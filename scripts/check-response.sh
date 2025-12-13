ssh d3labsdev "docker logs sto-core 2>&1" | jq -R '
    fromjson?
    | select(type=="object")
    | select(.level == "error" or .level == "warn")
    | {
        level,
        timestamp,
        timestamp_gmt7:
            (if (.timestamp|type) == "number"
             then ((.timestamp / 1000) + 25200 | strftime("%Y-%m-%d %H:%M:%S"))
             else "N/A"
             end),
        message,
        context,
        pid
    }
' -c |
  jq -s 'sort_by(.timestamp // 0) | .[]' -c |
  jq -s '
    map(
      select(
        (.message | type) == "object" and 
        .message.responseTime != null
      ) 
      | .message.responseTime 
      | if type == "string" then tonumber else . end
    ) 
    | sort 
    | if length > 0 then {
        count: length,
        p50: .[((length - 1) * 0.5) | floor],
        p90: .[((length - 1) * 0.9) | floor],
        p95: .[((length - 1) * 0.95) | floor],
        p99: .[((length - 1) * 0.99) | floor],
        min: .[0],
        max: .[-1],
        avg: (add / length | . * 100 | round / 100)
      } else {
        error: "No response times found"
      } end
  '
