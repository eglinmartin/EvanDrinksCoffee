if arg[2] == "debug" then
    require("lldebugger").start()
end


local Canvas = require("src/canvas")
local Controller = require("src/controller")
local Kitchen = require("src/kitchen")


Direction = {
    LEFT = -1,
    RIGHT = 1
}


function love.load()
    ScreenWidth, ScreenHeight = love.window.getDesktopDimensions()
    ScreenHeight = ScreenHeight * 0.8
    ScreenWidth = ScreenHeight
    ScreenScale = ScreenWidth/96

    SCREEN = Canvas(ScreenScale)
    KITCHEN = Kitchen(SCREEN)
    CONTROLLER = Controller(SCREEN)

    love.window.setTitle("Evan Drinks Coffee")
    love.window.setMode(ScreenWidth, ScreenHeight, {fullscreen=false, vsync=true, resizable=false, msaa=4})
end


function love.update()
    CONTROLLER:update()
    KITCHEN:update()
end


function love.draw()
    love.graphics.clear(61/255, 0/255, 61/255)

    SCREEN:draw_static_sprite('main', {1, 1}, 48, 48, 0, 1, false, true)
    
    KITCHEN:draw()
    CONTROLLER:draw()

    SCREEN:draw(ScreenScale)

    CONTROLLER:draw_vectors()

end


local love_errorhandler = love.errorhandler
function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
