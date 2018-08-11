local CScreen = require "libs/cscreen_min";
inspect = require "libs/inspect";

loadAssets = require "loader";

math.randomseed(os.time());

require "utils";
require "puzzle_generator";
require "level1";

function love.load()
    loadAssets();
    CScreen.init(256, 256, true);
    -- love.window.setMode(512, 512);
    -- CScreen.update(512, 512);
end

local keys = {};
function love.draw()
    CScreen.apply();
    Level1:draw();
    CScreen.cease()
end

function love.update(dt)
    mouseX, mouseY = CScreen.project(love.mouse.getPosition());
    Level1:update(dt);
end

function love.resize(width, height)
	CScreen.update(width, height)
end


function love.keypressed(keycode)
    keys[keycode] = true;

    if keys["escape"] then
        love.event.quit();
    end

    if keys["lalt"] and keys["return"] then
        love.window.setFullscreen(true);
    end

    if keys["lctrl"] and keys["f3"] then
        loadAssets();
    end

    Level1:keypressed(keys);
end

function love.keyreleased(keycode)
    keys[keycode] = nil;
end

function love.mousepressed()
    Level1:mousepressed();
end

function love.mousereleased()
    Level1:mousereleased();
end