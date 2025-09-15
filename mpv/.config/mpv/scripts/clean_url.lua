mp.register_event("start-file", function()
    local path = mp.get_property("path")
    if path and path:match("^https?://") then
        local cleaned = path:gsub("([?&])feature=shared", "")
        if cleaned ~= path then
            mp.set_property("path", cleaned)
        end
    end
end)
