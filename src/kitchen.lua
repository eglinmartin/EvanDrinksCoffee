local Class = require("src/libraries/class")

local Clock = Class {}
local CoffeeMachine = Class{}
local Kitchen = Class{}
local Plant = Class{}
local Window = Class{}


Status = {
    OFF = 1,
    ON = 2
}


TimeOfDay = {
    DAY = 1,
    DUSK = 2,
    NIGHT = 3,
    DAWN = 4
}


function Kitchen:init(screen)
    self.screen = screen
    self.coffee_machine = CoffeeMachine(screen)
    self.plant1 = Plant(screen, 21, 69, 20, 36)
    self.plant2 = Plant(screen, 80, 72, 12, 16)
    self.window = Window()
end


function Kitchen:update()
    self.coffee_machine:update()
    self.plant1:update()
    self.plant2:update()
end


function Kitchen:draw()
    self.screen:draw_static_sprite('coffee_machine', {self.coffee_machine.hover, self.coffee_machine.status}, self.coffee_machine.x, self.coffee_machine.y, 0, 1, false, false)
    self.screen:draw_static_sprite('plant1', {self.plant1.hover, 1}, self.plant1.x, self.plant1.y, 0, 1, false, false)
    self.screen:draw_static_sprite('plant2', {self.plant2.hover, 1}, self.plant2.x, self.plant2.y, 0, 1, false, false)
    self.screen:draw_static_sprite('window', {self.window.time_of_day, 1}, 41, 71, 0, 1, false, false)
end


function CoffeeMachine:init(screen)
    self.screen = screen
    self.status = Status.OFF
    self.hover = Status.OFF
    self.x = 65
    self.y = 72
end


function CoffeeMachine:update()
    local mx, my = love.mouse.getPosition()

    scale = self.screen.scale
    if mx >= (self.x - 10) * scale and mx <= (self.x + 10) * scale and my >= (self.y - 8) * scale and my <= (self.y + 8) * scale then
        self.hover = Status.ON
    else
        self.hover = Status.OFF
    end
end


function Plant:init(screen, x, y, w, h)
    self.screen = screen
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.hover = Status.OFF
end


function Plant:update()
    local mx, my = love.mouse.getPosition()

    scale = self.screen.scale
    if mx >= (self.x - (self.w) / 2) * scale and mx <= (self.x + (self.w) / 2) * scale and my >= (self.y - (self.h) / 2) * scale and my <= (self.y + (self.h) / 2) * scale then
        self.hover = Status.ON
    else
        self.hover = Status.OFF
    end
end


function Window:init()
    self.time_of_day = TimeOfDay.DAWN
end


function Window:update()
end


return Kitchen
