local SceneManager = {}
SceneManager.__index = SceneManager

local callbacks = {
    load = true,
    enter = true,
    leave = true,
    update = true,
    draw = true,
    keypressed = true,
}

local function validateScene(name, scene) 
    if type(name) ~= "string" or name == "" then
        error("[SCENE MANAGER] Scene name must be a non-empty string", 3)
    end

    if type(scene) ~= "table" then
        error("Scene must be a table")
    end

    for callback in pairs(callbacks) do
        local value = scene[callback]
        
        if value ~= nil and type(value) ~= "function" then
            error("[SCENE MANAGER] Scene callback '" .. callback .. "' must be a function", 3)
        end
    end

    if type(scene.draw) ~= "function" then
        error("[SCENE MANAGER] Scene 'draw' callback must be a function", 3)
    end
end

function SceneManager.new()
    return setmetatable({

        scenes = {},
        loaded = {},
        current = nil,
        currentName = nil,
        context = nil,

    }, SceneManager)
end

function SceneManager:register(name, scene)
    validateScene(name, scene)

    if self.scenes[name] then
        error("[SCENE MANAGER] Scene '" .. name .. "' is already registered", 2)
    end

    self.scenes[name] = scene
    return scene
end

function SceneManager:setContext(context)
    if type(context) ~= "table" then
        error("[SCENE MANAGER] Context must be a table", 2)
    end

    self.context = context
end

function SceneManager:change(name, ...)
    local nextScene = self.scenes[name]
    if not nextScene then
        error("[SCENE MANAGER] Cannot change to unknown scene " .. name, 2)
    end

    local previousScene = self.current
    local previousName = self.currentName

    if previousScene and previousScene.leave then
        previousScene.leave(self.context, name)
    end

    if not self.loaded[name] then
        if nextScene.load then
        nextScene.load(self.context)
        end
        self.loaded[name] = true
    end

    self.current = nextScene
    self.currentName = name

    if nextScene.enter then
        nextScene.enter(self.context, previousName, ...)
    end

    return nextScene
end

function SceneManager:getCurrent()
    return self.current, self.currentName
end

return SceneManager