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
    self.coffee_machine = CoffeeMachine()
    self.plant1 = Plant()
    self.plant2 = Plant()
    self.window = Window()
end


function Kitchen:update()
end


function Kitchen:draw()
    self.screen:draw_static_sprite('coffee_machine', {self.coffee_machine.hover, self.coffee_machine.status}, 66, 72, 0, 1, true, false)
    self.screen:draw_static_sprite('plant1', {self.plant1.hover, 1}, 21, 69, 0, 1, true, false)
    self.screen:draw_static_sprite('plant2', {self.plant2.hover, 1}, 80, 72, 0, 1, true, false)
    self.screen:draw_static_sprite('window', {self.window.time_of_day, 1}, 41, 71, 0, 1, true, false)
end


function CoffeeMachine:init()
    self.status = Status.OFF
    self.hover = Status.OFF
end


function CoffeeMachine:update()
end


function Plant:init()
    self.hover = Status.OFF
end


function Plant:update()
end


function Window:init()
    self.time_of_day = TimeOfDay.DAWN
end


function Window:update()
end


return Kitchen
