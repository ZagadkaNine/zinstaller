local W = {}

local function execute(command)
    handle = io.popen(command .. " 2>&1")
    output = handle:read("*a")
    handle:close()
    return output
end

local function split(output)
    lines = {}
    for s in output:gmatch("[^\r\n]+") do
        table.insert(lines, s)
    end
    return lines
end

local function runNotify(command)
    vim.notify(" " .. execute(command), "info", { title = "make sync" })
end

local function runSplit(command)
    vim.cmd('botright split new')
    vim.cmd('setlocal buftype=nofile')
    vim.api.nvim_win_set_height(0, 10)
    local buf_handle = vim.api.nvim_win_get_buf(0)
    vim.api.nvim_buf_set_option(buf_handle, 'modifiable', true)
    vim.api.nvim_buf_set_lines(buf_handle, 0, 0, true, split(execute(command)))
end

function W.sync()
    runNotify("make sync")
end

function W.run()
    runSplit("make execute")
end

return W


