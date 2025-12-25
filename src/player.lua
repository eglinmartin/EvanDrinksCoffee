local Class = require("src/libraries/class")

local Player = Class{}


function Player:init(screen)
    self.screen = screen

    self.x = 0
    self.y = 0
    self.alive = true

    self.fatigue = 70
    self.heart_rate = 90
end


function Player:update()
    self.fatigue = self.fatigue + 0.1
end


function Player:draw()
end


return Player
