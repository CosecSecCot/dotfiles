return {
    "barrett-ruth/live-server.nvim",
    build = "yarn global add live-server",
    -- config = true,
    config = function()
        require("live-server").setup {
            args = {},
        }
    end,
}
