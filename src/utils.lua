local utils = {}


function utils.vibrate(strength)
    local dx = (love.math.random() * 2 - 1) * strength
    local dy = (love.math.random() * 2 - 1) * strength
    return dx, dy
end


return utils
