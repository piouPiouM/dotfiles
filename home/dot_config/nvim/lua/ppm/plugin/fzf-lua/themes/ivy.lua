--- ┌──────────────────────────────────────────────────┐
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │ ┌──────────────────────┐┌──────────────────────┐ │
--- │ │        Prompt        ││                      │ │
--- │ │──────────────────────││       Preview        │ │
--- │ │       Results        ││       Preview        │ │
--- │ │       Results        ││       Preview        │ │
--- │ │       Results        ││       Preview        │ │
--- │ │                      ││                      │ │
--- │ └──────────────────────┘└──────────────────────┘ │
--- └──────────────────────────────────────────────────┘
return function(opts)
  return {
    fzf_opts = {
      ["--layout"] = "reverse",
      ["--no-separator"] = "",
      ["--pointer"] = "󰅂",
      ["--marker"] = " ",
    },
    winopts = {
      row = 1,
      col = 0,
      width = 1,
      height = 0.4,
      title_pos = "left",
      border = { "", "─", "", "", "", "", "", "" },
      preview = {
        layout = "horizontal",
        title_pos = "right",
        border = function(_, m)
          if m.type == "fzf" then
            return "single"
          else
            assert(m.type == "nvim" and m.name == "prev" and type(m.layout) == "string")
            local b = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
            if m.layout == "down" then
              b[1] = "├" --top right
              b[3] = "┤" -- top left
            elseif m.layout == "up" then
              b[7] = "├" -- bottom left
              b[6] = "" -- remove bottom
              b[5] = "┤" -- bottom right
            elseif m.layout == "left" then
              b[3] = "┬" -- top right
              b[5] = "┴" -- bottom right
              b[6] = "" -- remove bottom
            else -- right
              b[1] = "┬" -- top left
              b[7] = "┴" -- bottom left
              b[6] = "" -- remove bottom
            end
            return b
          end
        end,
      }
    },
  }
end
