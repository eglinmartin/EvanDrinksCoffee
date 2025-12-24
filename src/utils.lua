local utils = {}


function utils.vibrate(strength)
    local dx = (love.math.random() * 2 - 1) * strength
    local dy = (love.math.random() * 2 - 1) * strength
    return dx, dy
end


function utils.vibrate_smooth(strength, speed)
    local time = love.timer.getTime()
    local dx = math.sin(time * speed) * strength
    local dy = math.cos(time * speed * 1.3) * strength
    return dx, dy
end

return utils
