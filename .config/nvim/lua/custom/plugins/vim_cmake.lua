return {
    "cdelledonne/vim-cmake",
    config = function()
        vim.g.cmake_link_compile_commands = 1
        vim.g.cmake_default_config = "Build"
        vim.keymap.set("n", "<leader>cg", vim.cmd.CMakeGenerate)
        vim.keymap.set("n", "<leader>cb", vim.cmd.CMakeBuild)
    end,
    -- event = { "BufRead *.cpp", "BufNew *.cpp" },
}
