local TestScene = {}

function TestScene:load()
  -- Camera transform state (Desktop Non-VR)
  self.camera = {
    x = 0,
    y = 1.7,
    z = 0
  }
  
  -- Cube transform parameters
  self.cube = {
    x = 0,
    y = 1.7,
    z = -3,
    size = 1.0,
    rotationX = 0,
    rotationY = 0
  }

  print("[TestScene] Loaded!")
end

function TestScene:update(dt)
  local time = lovr.timer.getTime()

  -- Rotate the cube continuously on X and Y axes
  self.cube.rotationX = time * 0.8
  self.cube.rotationY = time * 1.2
end

function TestScene:draw(pass)
  -- 1. Position the viewer camera (Eye Index 1 = Desktop view)
  pass:setViewPose(1, self.camera.x, self.camera.y, self.camera.z, 0, 0, 1, 0)

  -- 2. Render the Spinning Cube
  pass:push()
    -- Move to cube position
    pass:translate(self.cube.x, self.cube.y, self.cube.z)
    
    -- Apply rotations (angle in radians, axis_x, axis_y, axis_z)
    pass:rotate(self.cube.rotationY, 0, 1, 0)
    pass:rotate(self.cube.rotationX, 1, 0, 0)

    -- Set cube fill color (Light Blue)
    pass:setColor(0.3, 0.7, 1.0)
    pass:box('fill', 0, 0, 0, self.cube.size)

    -- Set outline wireframe color (White)
    pass:setColor(1, 1, 1)
    pass:box('line', 0, 0, 0, self.cube.size * 1.001)
  pass:pop()

  -- 3. Render 3D World Text
  pass:setColor(1, 1, 1)
  pass:text("LÖVR Desktop Scene Architecture", 0, 3.0, -3, 0.25)
  pass:text("Press [ESC] to Exit", 0, 0.5, -3, 0.15)
end

function TestScene:keypressed(key, scancode, repeating)
  print("[TestScene] Key pressed:", key)
end

function TestScene:unload()
  print("[TestScene] Unloaded!")
end

return TestScene