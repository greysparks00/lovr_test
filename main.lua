local SceneManager = require("modules.scene_manager")

local scenes = SceneManager.new()
local currentScene

local function changeScene(name, ...)
    currentScene = scenes:change(name, ...)
end

function lovr.load()
    lovr.graphics.setBackgroundColor(0.08, 0.08, 0.1)

    scenes:setContext({
        changeScene = changeScene,

        getSceneName = function ()
            local _, name = scenes:getCurrent()
            return name
        end
    })

    scenes:register("test", require("scenes.test_scene"))
    changeScene("test")
end

function lovr.update(dt)
    if currentScene and currentScene.update then
        currentScene.update(dt, scenes.context)
    end
end

function lovr.draw(pass)
    if currentScene and currentScene.draw then
        currentScene.draw(pass, scenes.context)
    end
end

function lovr.keypressed(key, scancode, isrepeat)
    if currentScene and currentScene.keypressed then
        currentScene:keypressed(key, scancode, isrepeat, scenes.context)
    end
end