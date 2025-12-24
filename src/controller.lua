local Class = require("src/libraries/class")
local utils = require("src/utils")

local Controller = Class{}
local Player = Class{}
local StatusBar = Class{}


function Controller:init(screen)
    self.screen = screen
    self.player = Player(screen)

    self.fatigue_bar = StatusBar(screen, 73, 35, self.player.fatigue)
    self.blood_pressure_bar = StatusBar(screen, 86, 35, self.player.blood_pressure)
end


function Controller:update()
    self.fatigue_bar:update()
    self.blood_pressure_bar:update()
end


function Controller:draw()
    self.fatigue_bar:draw()
    self.blood_pressure_bar:draw()
end


function StatusBar:init(screen, x, y, measure)
    self.screen = screen
    self.measure = measure

    self.x = x
    self.y = y
    self.dx = 0
    self.dy = 0
end


function StatusBar:update()
    if self.measure >= 90 then
        self.dx, self.dy = utils.vibrate(0.5)
    end
end


function StatusBar:draw()
    local frame = {1, 1}
    if self.measure >= 90 then
        frame = {2, 1}
    end
    self.screen:draw_static_sprite('bar', frame, self.x + self.dx, self.y + self.dy, 0, 1, false, false)
end


function Player:init(screen)
    self.screen = screen

    self.x = 0
    self.y = 0
    self.alive = true

    self.fatigue = 70
    self.blood_pressure = 20
end


function Player:update()
end


function Player:draw()
end


return Controller
