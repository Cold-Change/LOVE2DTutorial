function love.load()
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)

    objects = {}
  
    objects.ground = {}
    objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2)
    objects.ground.shape = love.physics.newRectangleShape(650, 50)
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
    objects.ground.fixture:setFriction(1)
  
    objects.square = {}
    objects.square.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
    objects.square.shape = love.physics.newRectangleShape(0, 0, 25, 25)
    objects.square.fixture = love.physics.newFixture(objects.square.body, objects.square.shape, 3)
    objects.square.fixture:setRestitution(0.2)
    objects.square.fixture:setFriction(1)
    objects.square.body:setFixedRotation(true)


    objects.block1 = {}
    objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
    objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
    objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5)
    objects.block1.fixture:setFriction(.5)

    objects.block2 = {}
    objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
    objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
    objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)
    objects.block2.fixture:setFriction(.5)

    spawned_rectangle_objects = {}

    love.graphics.setBackgroundColor(.5, .5, .5)
    love.window.setMode(650, 650)

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    world:update(dt)

    local vx, vy = objects.square.body:getLinearVelocity()

    if love.keyboard.isDown("right") then
      objects.square.body:setLinearVelocity(200, vy)
    elseif love.keyboard.isDown("left") then
      objects.square.body:setLinearVelocity(-200, vy)
    end

    if love.keyboard.keysPressed["up"] then
        objects.square.body:applyForce(0, -8000)
    end

    if love.keyboard.isDown("r") then
        objects.square.body:setPosition(650/2, 650/2)
        objects.square.body:setLinearVelocity(0, 0)
    end

    if love.keyboard.keysPressed["e"] then
        local x,y = love.mouse.getPosition()
        createRectangleObject(x,y,30,30,{1,.8,.8,1})
    end

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function createRectangleObject(x,y,width,height,color)
    local new_object = {}
    new_object.body = love.physics.newBody(world, x, y, "dynamic")
    new_object.shape = love.physics.newRectangleShape(0, 0, width, height)
    new_object.fixture = love.physics.newFixture(new_object.body, new_object.shape, 3)
    new_object.fixture:setFriction(.5)
    new_object.color = color or {1,1,1,1}
    table.insert(spawned_rectangle_objects, new_object)
end

function love.draw()
    love.graphics.setColor(0.8, 0.6, 0)
    love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))

    love.graphics.setColor(0.8, 0.8, 1)
    love.graphics.polygon("fill", objects.square.body:getWorldPoints(objects.square.shape:getPoints()))
  
    love.graphics.setColor(0.20, 0.20, 0.20)
    love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
    love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))

    if #spawned_rectangle_objects > 0 then
        for i,v in ipairs(spawned_rectangle_objects) do
            love.graphics.setColor(v.color[1], v.color[2], v.color[3], v.color[4])
            love.graphics.polygon("fill", v.body:getWorldPoints(v.shape:getPoints()))
        end
    end
end