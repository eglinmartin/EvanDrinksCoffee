local Class = require("src/libraries/class")
local Player = require("src/player")
local utils = require("src/utils")

local Controller = Class{}
local StatusBar = Class{}


function Controller:init(screen)
    self.screen = screen
    self.player = Player(screen)
    self.time = 0

    self.fatigue_bar = StatusBar(screen, 73, 35, self.player.fatigue)
    self.heart_rate_bar = StatusBar(screen, 86, 35, self.player.heart_rate)
end


function Controller:update()
    self.fatigue_bar:update()
    self.heart_rate_bar:update()
end


function Controller:draw()
    self.heart_rate_bar:draw()

    -- Draw time
    local hours = string.format("%02d", ((love.timer.getTime() + 360) / 60) % 60)
    local minutes = string.format("%02d", love.timer.getTime() % 60)
    self.screen:draw_static_sprite('numbers', {hours:sub(1, 1) + 1, 1}, 21.5, 41, 0, 1, false, false)
    self.screen:draw_static_sprite('numbers', {hours:sub(2, 2) + 1, 1}, 26.5, 41, 0, 1, false, false)
    self.screen:draw_static_sprite('numbers', {12, 1}, 31.5, 41, 0, 1, false, false)
    self.screen:draw_static_sprite('numbers', {minutes:sub(1, 1) + 1, 1}, 33.5, 41, 0, 1, false, false)
    self.screen:draw_static_sprite('numbers', {minutes:sub(2, 2) + 1, 1}, 38.5, 41, 0, 1, false, false)

    -- Draw fatigue bar
    self.fatigue_bar:draw()
end


function Controller:draw_vectors()
    local scale = self.screen.scale
    
    -- Draw fatigue bar
    love.graphics.setColor(92/255, 139/255, 168/255, 1)
    love.graphics.rectangle("fill", (70 + self.fatigue_bar.dx) * scale, (27 + self.fatigue_bar.dy) * scale, 3 * scale, 14 * scale)

    -- Draw heart rate bar
    love.graphics.setColor(148/255, 44/255, 75/255, 1)
    love.graphics.rectangle("fill", (83 + self.heart_rate_bar.dx) * scale, (27 + self.fatigue_bar.dy) * scale, 3 * scale, 14 * scale)
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


return Controller
