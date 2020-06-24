text = "this is some text for evaluation and language detection"

Benchee.run(
  %{
    "Async_stream" => fn -> Text.Language.detect(text) end,
    "Flow 10" => fn -> Text.Language.detect2(text, max_demand: 10) end,
    "Flow 20" => fn -> Text.Language.detect2(text, max_demand: 20) end,
    "Flow 30" => fn -> Text.Language.detect2(text, max_demand: 30) end,
    "Flow 40" => fn -> Text.Language.detect2(text, max_demand: 40) end,
    "Flow 50" => fn -> Text.Language.detect2(text, max_demand: 50) end
  }
)