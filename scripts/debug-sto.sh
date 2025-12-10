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
  fzf \
    --no-sort \
    --tac \
    --prompt="err/warn> " \
    --header="Filtering: only error & warn. Type to search." \
    --preview '
        jq "." <<< {} \
        | bat --color=always --language=json --wrap=auto
    ' \
    --preview-window=right:60%,wrap |
  jq
