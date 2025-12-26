local Class = require("src/libraries/class")

local Player = Class{}


Facing = {
    RIGHT = 1,
    LEFT = 2
}


function Player:init(screen)
    self.screen = screen

    self.x = 41
    self.y = 81
    self.alive = true
    self.facing = Facing.RIGHT

    self.fatigue = 50
    self.heart_rate = 90
end


function Player:update()
    self.fatigue = self.fatigue + 0.1

    if love.keyboard.isDown("left", "a") then
        CONTROLLER.player:move(Direction.LEFT)
        self.facing = Facing.LEFT
    end
    if love.keyboard.isDown("right", "d") then
        CONTROLLER.player:move(Direction.RIGHT)
        self.facing = Facing.RIGHT
    end
end


function Player:draw()
    self.screen:draw_static_sprite('player', {self.facing, 1}, self.x, self.y, 0, 1, false, false)
end


function Player:move(direction)
    self.x = self.x + direction * 0.5
end


return Player
