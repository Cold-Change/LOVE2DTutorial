wf = require 'windfield'

function love.load()
    world = wf.newWorld(0, 0, true)
    world:setGravity(0, 800)

    square = world:newRectangleCollider(250, 250, 25, 25)
    square:setFixedRotation(true)

    ground = world:newRectangleCollider(0, 550, 800, 50)
    wall_left = world:newRectangleCollider(0, 0, 50, 600)
    wall_right = world:newRectangleCollider(750, 0, 50, 600)
    ground:setType('static')
    wall_left:setType('static')
    wall_right:setType('static')

    spawned_objects = {}

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    world:update(dt)

    local vx,vy = square:getLinearVelocity()

    if love.keyboard.isDown("right") then
        square:setLinearVelocity(200, vy)
    elseif love.keyboard.isDown("left") then
        square:setLinearVelocity(-200, vy)
    end

    if love.keyboard.keysPressed["up"] then
        square:applyLinearImpulse(0, -400)
    end

    if love.keyboard.keysPressed["e"] then
        local x,y = love.mouse.getPosition()
        world:newRectangleCollider(x, y, 25, 25)
    end

    if love.keyboard.isDown("r") then
        square:setPosition(250,250)
        square:setLinearVelocity(0, 0)
    end

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.draw()
    world:draw()
end
