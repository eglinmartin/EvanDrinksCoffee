if arg[2] == "debug" then
    require("lldebugger").start()
end

local Canvas = require("src/canvas")
local Controller = require("src/controller")
local Kitchen = require("src/kitchen")


function love.load()
    ScreenWidth, ScreenHeight = love.window.getDesktopDimensions()
    ScreenHeight = ScreenHeight * 0.8
    ScreenWidth = ScreenHeight
    ScreenScale = ScreenWidth/96

    SCREEN = Canvas(ScreenScale)
    CONTROLLER = Controller(SCREEN)
    KITCHEN = Kitchen(SCREEN)

    love.window.setTitle("Evan Drinks Coffee")
    love.window.setMode(ScreenWidth, ScreenHeight, {fullscreen=false, vsync=true, resizable=false, msaa=4})
end


function love.update()
    CONTROLLER:update()
    KITCHEN:update()
end


function love.draw()
    SCREEN:draw_static_sprite('main', {1, 1}, 48, 48, 0, 1, false, true)
    
    CONTROLLER:draw()
    KITCHEN:draw()

    SCREEN:draw({61, 0, 61}, ScreenScale)
end


function love.keypressed(key)
end


local love_errorhandler = love.errorhandler
function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
