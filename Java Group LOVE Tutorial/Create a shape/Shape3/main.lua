function love.load()
    love.graphics.setColor(1,0,0,1)
    
    shape = {}
    shape.x = 200
    shape.y = 200
    shape.width = 50
    shape.height = 50
    shape.speed = 200
end

function love.update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    if shape.x + shape.width/2 > mouseX + 10 then
        shape.x = shape.x - shape.speed * dt
    elseif shape.x + shape.width/2 < mouseX - 10 then
        shape.x = shape.x + shape.speed * dt
    end
    if shape.y + shape.height/2 > mouseY + 10 then
        shape.y = shape.y - shape.speed * dt
    elseif shape.y + shape.height/2 < mouseY - 10 then
        shape.y = shape.y + shape.speed * dt
    end
    if (mouseX >= shape.x and mouseX <= shape.x + shape.width) and (mouseY >= shape.y and mouseY <= shape.y + shape.height) then
        love.graphics.setColor(0,1,0,1)
    else
        love.graphics.setColor(1,0,0,1)
    end
end

function love.draw()
    love.graphics.rectangle("fill", shape.x, shape.y, shape.width, shape.height)
end