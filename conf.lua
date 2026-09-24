lovr.conf = function(t)
    -- Identity & Metadata
    t.identity = "lovr_game"             -- Name of the save directory for filesystem writes
    t.version = "0.17.0"                 -- Target LÖVR version for compatibility checks

    -- Window & Desktop Settings
    t.window = {
        width = 1280,                    -- Desktop window width
        height = 720,                    -- Desktop window height
        title = "LÖVR Application",      -- Desktop window title
        icon = nil,                      -- Path to a PNG file to use as the window icon
        fullscreen = false,              -- Enable/disable fullscreen mode
        resizable = true,                -- Allow the user to resize the window
        vsync = true                     -- Sync framerate with screen refresh rate
    }

    -- Engine Modules (Toggle True/False)
    t.modules = {
        audio = true,                    -- Enables 3D audio spatialization and playback
        data = true,                     -- Enables low-level binary data block manipulation
        event = true,                    -- Enables the event loop (quitting, inputs, etc.)
        filesystem = true,               -- Enables reading/writing project assets
        graphics = true,                 -- Enables 3D rendering pipeline
        headset = false,                 -- [DISABLED] Disables VR headset and OpenXR tracking
        math = true,                     -- Enables fast vectors, matrices, and curves
        physics = true,                  -- Enables 3D rigid-body physics and collisions
        system = true,                   -- Enables OS communication, keyboard, and mouse
        thread = true,                   -- Enables background Lua worker threads
        timer = true                     -- Enables delta time tracking and FPS calculation
    }
end