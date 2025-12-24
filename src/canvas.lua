local anim8 = require("src/libraries/anim8")
local Class = require("src/libraries/class")

local Canvas = Class{}
local Sprite = Class{}


function Sprite:init(animation, sprite_sheet_image, x, y, w, h, rotation, scale, depth, shadow, background)
    self.animation = animation
    self.sprite_sheet_image = sprite_sheet_image
    self.x = x
    self.y = y
    self.width = w
    self.height = h
    self.rotation = rotation
    self.scale = scale
    self.depth = depth
    self.shadow = shadow
    self.background = background
end


function Canvas:init()
    -- Create empty sprite lists
    self.sprites_foreground = {}
    self.sprites_shadow = {}

    -- Load all PNGs
    self.sprite_sheets = self:load_sprites()

    -- Parse sprite sheets
    self:parse_sprite_sheet(self.sprite_sheets.coffee_machine, 20, 16)
    self:parse_sprite_sheet(self.sprite_sheets.main, 96, 96)
    self:parse_sprite_sheet(self.sprite_sheets.plant1, 20, 36)
    self:parse_sprite_sheet(self.sprite_sheets.plant2, 12, 16)
    self:parse_sprite_sheet(self.sprite_sheets.window, 12, 20)
end


function Canvas:load_sprites()
    local sprite_sheets = {}
    local path = 'assets/sprites'
    local items = love.filesystem.getDirectoryItems(path)

    -- Iterate through image files
    for _, item in ipairs(items) do
        local fullPath = path .. "/" .. item
        local key = item:match("^(.*)%.png$")

        -- Load image and store in a structured table
        sprite_sheets[key] = {
            image = love.graphics.newImage(fullPath),
            grid = nil
        }
    end
    
    return sprite_sheets
end


function Canvas:parse_sprite_sheet(sheet, frame_width, frame_height)
    sheet.frame_width = frame_width
    sheet.frame_height = frame_height
    sheet.grid = anim8.newGrid(frame_width, frame_height, sheet.image:getWidth(), sheet.image:getHeight(), 0, 0, 1)
end


function Canvas:draw_static_sprite(sprite_name, sprite_coords, x, y, rotation, scale, shadow, background)
    local sheet = self.sprite_sheets[sprite_name]

    -- Create 1-frame animated sprite
    local animation = anim8.newAnimation(sheet.grid(sprite_coords[1], sprite_coords[2]), 1)
    local sprite = Sprite(animation, sheet.image, x, y, sheet.frame_width, sheet.frame_height, math.rad(rotation), scale, shadow, background)
    sprite.sprite_sheet_image:setFilter("nearest", "nearest")

    -- Insert into layers
    table.insert(self.sprites_foreground, sprite)

    -- Insert into shadow layers
    if shadow then
        table.insert(self.sprites_shadow, sprite)
    end
end


function Canvas:draw(rgb, screen_scale)
    -- Draw background colour
    love.graphics.clear(rgb[1]/255, rgb[2]/255, rgb[3]/255)

    -- Create shader for shadow rendering as block colour
    local shadowShader = love.graphics.newShader[[
        vec4 effect(vec4 color, Image tex, vec2 tc, vec2 pc) {
            float a = Texel(tex, tc).a;
            return vec4(color.rgb, a);
        }
    ]]
    
    -- Draw shadow layer
    love.graphics.setShader(shadowShader)
    love.graphics.setColor(92/255, 129/255, 163/255, 1)
    for _, sprite in ipairs(self.sprites_shadow) do
        sprite.animation:draw(
            sprite.sprite_sheet_image,
            (sprite.x + 1) * screen_scale,
            (sprite.y + 1) * screen_scale,
            sprite.rotation,
            sprite.scale * screen_scale,
            sprite.scale * screen_scale,
            sprite.width/2,
            sprite.height/2
        )
    end

    -- Draw foreground layer
    love.graphics.setShader()
    love.graphics.setColor(1, 1, 1, 1)
    for _, sprite in ipairs(self.sprites_foreground) do
        sprite.animation:draw(
            sprite.sprite_sheet_image,
            sprite.x * screen_scale,
            sprite.y * screen_scale,
            sprite.rotation,
            sprite.scale * screen_scale,
            sprite.scale * screen_scale,
            sprite.width/2,
            sprite.height/2
        )
    end

    -- Reset sprite lists
    self.sprites_foreground = {}
    self.sprites_shadow = {}
end


return Canvas
