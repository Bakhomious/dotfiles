local source_priority = {
  lsp = 4,
  path = 3,
  buffer = 2,
  snippets = 1,
}

return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
    },
    sources = {
      default = { "lsp", "path", "buffer", "snippets" },
    },
    fuzzy = {
      sorts = {
        function(a, b)
          local blink = require("blink.cmp.types")
          local kind_snippet = blink.CompletionItemKind.Snippet

          -- Helper to get the real priority
          local function get_priority(item)
            local prio = source_priority[item.source_id] or 0

            if item.source_id == "lsp" and item.kind == kind_snippet then
              return 0
            end

            return prio
          end

          local a_prio = get_priority(a)
          local b_prio = get_priority(b)

          if a_prio ~= b_prio then
            return a_prio > b_prio
          end
        end,
        "score",
        "sort_text",
        "kind",
        "label",
      },
    },
  },
}
