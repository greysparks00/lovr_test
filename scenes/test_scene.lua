local TestScene = {
    angle = 0
}

function TestScene.enter(context)
    TestScene.angle = 0

    print("entered the test scene")
end

function TestScene.leave(context, nextSceneName)
    print("we leaving this scene for " .. nextSceneName)
end

function TestScene.update(dt)
    print(dt)
    TestScene.angle = TestScene.angle + dt
end

function TestScene.draw(pass)
    pass:setColor(.25, 0.7, 1.0)
    pass:cube(0, 1.5, -2.5, .6, TestScene.angle, 0, 1, 0)

    pass:setColor(1, 1, 1)
    pass:text("Test Scene", 0, 2.15, -2.5, 0.35)
end

function TestScene.keypressed(key, scancode, isrepeat, context)
    if key == "r" and not isrepeat then
        context.changeScene("test")
    end
end

return TestScene