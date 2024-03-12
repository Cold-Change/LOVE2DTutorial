Shape = {}

function Shape:init(x,y,width,height,speed,color1,color2)
    local self = setmetatable({}, Shape)
    self.x = x or 0
    self.y = y or 0
    self.width = width or 10
    self.height = height or 10
    self.speed = speed or 100
    self.color1 = color1 or {1,1,1,1}
    self.color2 = color2 or {1,1,1,1}
    function self:update(dt)
        local mouseX, mouseY = love.mouse.getPosition()
        if self.x + self.width/2 > mouseX + self.width/4 then
            self.x = self.x - self.speed * dt
        elseif self.x + self.width/2 < mouseX - self.width/4 then
            self.x = self.x + self.speed * dt
        end
        if self.y + self.height/2 > mouseY + self.height/4 then
            self.y = self.y - self.speed * dt
        elseif self.y + self.height/2 < mouseY - self.height/4 then
            self.y = self.y + self.speed * dt
        end
    end
    function self:draw()
        local mouseX, mouseY = love.mouse.getPosition()
        if (mouseX >= self.x and mouseX <= self.x + self.width) and (mouseY >= self.y and mouseY <= self.y + self.height) then
            love.graphics.setColor(color1[1],color1[2],color1[3],color1[4])
        else
            love.graphics.setColor(color2[1],color2[2],color2[3],color2[4])
        end
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end
    return self
end

function Shape:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    if Shape.x + Shape.width/2 > mouseX + 10 then
        Shape.x = Shape.x - Shape.speed * dt
    elseif Shape.x + Shape.width/2 < mouseX - 10 then
        Shape.x = Shape.x + Shape.speed * dt
    end
    if Shape.y + Shape.height/2 > mouseY + 10 then
        Shape.y = Shape.y - Shape.speed * dt
    elseif Shape.y + Shape.height/2 < mouseY - 10 then
        Shape.y = Shape.y + Shape.speed * dt
    end
    if (mouseX >= Shape.x and mouseX <= Shape.x + Shape.width) and (mouseY >= Shape.y and mouseY <= Shape.y + Shape.height) then
        love.graphics.setColor(0,1,0,1)
    else
        love.graphics.setColor(1,0,0,1)
    end
end

return Shape