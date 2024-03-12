function love.load()
    love.graphics.setColor(1,0,0,1)
    
    shape = {}
    shape.x = 200
    shape.y = 200
    shape.width = 50
    shape.height = 50
end

function love.draw()
    love.graphics.rectangle("fill", shape.x, shape.y, shape.width, shape.height)
end