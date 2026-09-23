-- ============================================================================
-- SCENE MANAGER
-- ============================================================================
local SceneManager = {
    current = nil
}

--- Switch to a new scene table/object
-- @param newScene table: The scene module to switch to
-- @param ... any: Optional arguments passed into newScene:load(...)
function SceneManager:switch(newScene, ...)
    if self.current and self.current.unload then
        self.current:unload()
    end
    
    self.current = newScene
    
    if self.current and self.current.load then
        self.current:load(...)
    end
end

_G.SceneManager = SceneManager

-- ============================================================================
-- LOVR SYSTEM CALLBACKS
-- ============================================================================

function lovr.load()
    -- default dark background color
    lovr.graphics.setBackgroundColor(0.08, 0.08, 0.1)

    local TestScene = require("scenes.test_scene")
    SceneManager:switch(TestScene)
end

function lovr.update(dt)
    if SceneManager.current and SceneManager.current.update then
        SceneManager.current:update(dt)
    end
end

function lovr.draw(pass)
    if SceneManager.current and SceneManager.current.draw then
        SceneManager.current:draw(pass)
    end

    return pass
end

function lovr.keypressed(key, scancode, repeating)
    -- global quit hotkey
    if key == "escape" then
        lovr.event.quit()
    end

    if SceneManager.current and SceneManager.current.keypressed then
        SceneManager.current:keypressed(key, scancode, repeating)
    end
end

function lovr.keyreleased(key, scancode)
    if SceneManager.current and SceneManager.current.keyreleased then
        SceneManager.current:keyreleased(key, scancode)
    end
end

function lovr.mousepressed(x, y, button)
    if SceneManager.current and SceneManager.current.mousepressed then
        SceneManager.current:mousepressed(x, y, button)
    end
end

function lovr.mousereleased(x, y, button)
    if SceneManager.current and SceneManager.current.mousereleased then
        SceneManager.current:mousereleased(x, y, button)
    end
end

function lovr.mousemoved(x, y, dx, dy)
    if SceneManager.current and SceneManager.current.mousemoved then
        SceneManager.current:mousemoved(x, y, dx, dy)
    end
end

function lovr.resize(width, height)
    if SceneManager.current and SceneManager.current.resize then
        SceneManager.current:resize(width, height)
    end
end