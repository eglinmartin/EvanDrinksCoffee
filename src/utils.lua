local utils = {}


function utils.vibrate(strength)
    local t = love.timer.getTime()
    local dx = math.sin(t * 60) * strength
    local dy = math.sin(t * 60) * strength
    return dx, dy
end


return utils
