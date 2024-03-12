Shape = require "Shape"

function love.load()
    -- shape = Shape:init(200,200,50,50,200,{0,1,0,1},{1,0,0,1})
    shapes = {
        Shape:init(250,250,50,50,300,{.9,.9,1,1},{1,1,1,1}),
        Shape:init(250,250,45,45,315,{.75,.75,1,1},{1,1,1,1}),
        Shape:init(250,250,40,40,330,{.6,.6,1,1},{1,1,1,1}),
        Shape:init(250,250,35,35,350,{.45,.45,1,1},{1,1,1,1}),
        Shape:init(250,250,30,30,370,{.3,.3,1,1},{1,1,1,1}),
        Shape:init(250,250,25,25,385,{.15,.15,1,1},{1,1,1,1}),
        Shape:init(250,250,20,20,400,{0,0,1,1},{1,1,1,1}),
    }
end

function love.update(dt)
    -- shape:update(dt)
    for i,v in ipairs(shapes) do
        v:update(dt)
    end
end

function love.draw()
    -- shape:draw()
    for i,v in ipairs(shapes) do
        v:draw()
    end
end