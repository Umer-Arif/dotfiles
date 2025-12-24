local start_time = nil

local function ensure_videos_dir()
    local home = os.getenv("HOME")
    local dir = home .. "/Videos"
    os.execute("mkdir -p " .. dir)
    return dir
end

mp.add_key_binding("R", "clipper", function()
    local pos = mp.get_property_number("time-pos")
    local path = mp.get_property("path")

    if not pos or not path then
        mp.osd_message("Error: Can't read position or file path.")
        return
    end

    if not start_time then
        start_time = pos
        mp.osd_message("Clip start: " .. string.format("%.2f", pos) .. "s")
    else
        local end_time = pos

        if end_time <= start_time then
            mp.osd_message("Error: End time must be after start time!")
            start_time = nil
            return
        end

        local home = os.getenv("HOME")
        local videos_dir = ensure_videos_dir()
        local output = videos_dir .. "/clip-" .. os.time() .. ".mkv"

        local cmd = {
            "ffmpeg", "-y",
            "-i", path,
            "-ss", tostring(start_time),
            "-to", tostring(end_time),
            "-c", "copy",
            output
        }

        mp.osd_message("Saving clip...")
        mp.command_native_async({ name = "run", args = cmd }, function()
            mp.osd_message("Saved clip: " .. output)
        end)

        start_time = nil
    end
end)
