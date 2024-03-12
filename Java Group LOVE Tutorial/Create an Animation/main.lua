wf = require 'windfield'
anim8 = require 'anim8'

function love.load()
    world = wf.newWorld(0, 0, true)
    world:setGravity(0, 800)

    ground = world:newRectangleCollider(0, 550, 800, 50)
    wall_left = world:newRectangleCollider(0, 0, 50, 600)
    wall_right = world:newRectangleCollider(750, 0, 50, 600)
    ground:setType('static')
    wall_left:setType('static')
    wall_right:setType('static')

    spawned_objects = {}

    love.keyboard.keysPressed = {}

    player = {}
    player.image = love.graphics.newImage('adventurer.png')
    local grid = anim8.newGrid(50, 37, player.image:getWidth(), player.image:getHeight())
    player.animation = {}
    player.animation.runR = anim8.newAnimation(grid('2-7',2), 0.1)
    player.animation.runL = anim8.newAnimation(grid('2-7',2), 0.1):flipH()
    player.animation.idle = anim8.newAnimation(grid('1-4',1), 0.2)  
    player.animation.jumpR = anim8.newAnimation(grid('1-7',5), 0.1)
    player.animation.jumpL = anim8.newAnimation(grid('1-7',5), 0.1):flipH()
    player.flippedH = false
    player.collider = world:newRectangleCollider(250, 250, 25, 50)
    player.collider:setFixedRotation(true)
    player.collider:setFriction(0.8)
end

function love.update(dt)
    world:update(dt)
    for k,v in pairs(player.animation) do
        v:update(dt)
    end

    local vx,vy = player.collider:getLinearVelocity()

    if love.keyboard.isDown("right") then
        player.collider:setLinearVelocity(200, vy)
    elseif love.keyboard.isDown("left") then
        player.collider:setLinearVelocity(-200, vy)
    end

    if love.keyboard.keysPressed["up"] then
        player.collider:applyLinearImpulse(0, -800)
    end

    if love.keyboard.keysPressed["e"] then
        local x,y = love.mouse.getPosition()
        world:newRectangleCollider(x, y, 25, 25)
    end

    if love.keyboard.isDown("r") then
        player.collider:setPosition(250,250)
        player.collider:setLinearVelocity(0, 0)
    end

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.draw()
    love.graphics.clear(.7, .7, 1, 1)
    love.graphics.setColor(1, 1, 1, 1)

    -- world:draw()

    local playerX,playerY = player.collider:getX() - 54, player.collider:getY() - 48
    if love.keyboard.isDown("right") then
        player.animation.runR:draw(player.image, playerX, playerY, nil, 2, 2)
    elseif love.keyboard.isDown("left") then
        player.animation.runL:draw(player.image, playerX, playerY, nil, 2, 2)
    else
        player.animation.idle:draw(player.image, playerX, playerY, nil, 2, 2)
    end
    
    love.graphics.setColor(0.4, 0.8, 0.4, 1)
    love.graphics.rectangle("fill", 0, 550, 800, 50)
    love.graphics.setColor(0.4, 0.4, 0.8, 1)
    love.graphics.rectangle("fill", 0, 0, 50, 600)
    love.graphics.rectangle("fill", 750, 0, 50, 600)
end
