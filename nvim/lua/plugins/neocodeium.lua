-- lua/plugins/neocodeium.lua
return {
  "monkoose/neocodeium",

  -- This dependency is still CRITICAL to prevent load-order bugs
  dependencies = { "saghen/blink.cmp" },

  event = "VeryLazy",

  config = function()
    local neocodeium = require("neocodeium")
    local blink = require("blink-cmp")

    -- 1. Configure neocodeium for MANUAL mode
    neocodeium.setup({
      manual = true, -- This is the key setting you wanted!

      -- This is still good practice. It tells neocodeium to hide
      -- if you happen to have its suggestion open and then
      -- press Ctrl+Space to open the blink menu.

      -- ##### ĐÂY LÀ FILTER ĐÃ ĐƯỢC GỘP LẠI #####
      filter = function(bufnr)
        local is_blink_visible = blink.is_visible()
        local is_env_file = vim.endswith(vim.api.nvim_buf_get_name(bufnr), ".env")

        -- Chỉ hiển thị gợi ý khi:
        -- 1. Menu của blink.cmp KHÔNG hiển thị
        -- VÀ
        -- 2. File KHÔNG phải là file .env
        return not is_blink_visible and not is_env_file
      end,
    })

    -- 2. This autocmd is also good practice
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        neocodeium.clear()
      end,
    })

    -- 3. Your New, Correct Keymaps

    -- THIS IS YOUR NEW "MANUAL CALL" BUTTON
    -- It will get a completion OR cycle to the next one.
    vim.keymap.set("i", "<A-n>", function()
      neocodeium.cycle_or_complete()
    end, { desc = "Neocodeium - Cycle / Get Completion" })

    -- This keymap is just for accepting.
    vim.keymap.set("i", "<A-f>", neocodeium.accept, { desc = "Neocodeium - Accept" })

    -- This keymap is just for cycling backwards.
    vim.keymap.set("i", "<A-N>", function()
      neocodeium.cycle(-1)
    end, { desc = "Neocodeium - Cycle Back" })
  end,
}
