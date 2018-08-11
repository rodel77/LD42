local CScreen = require "libs/cscreen_min";
inspect = require "libs/inspect";

loadAssets = require "loader";

math.randomseed(os.time());

require "utils";
require "puzzle_generator";
require "menu";
require "level1";
require "level2";

local state = Menu;

function love.load()
    loadAssets();
    CScreen.init(256, 256, true);
    -- love.window.setMode(512, 512);
    -- CScreen.update(512, 512);
end

local keys = {};
function love.draw()
    CScreen.apply();
    Menu:draw();
    -- CScreen.cease()
end

function love.update(dt)
    mouseX, mouseY = CScreen.project(love.mouse.getPosition());
    Menu:update(dt);

    -- For some reason "setLooping" caused some problems
    -- I never seen that... but I has to happend in a jam!
    if not sounds.music_carnival:isPlaying() then
        sounds.music_carnival:play();
    end
end

function love.resize(width, height)
	CScreen.update(width, height)
end

game_audio = 5;
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

    if keys["left"] then
        game_audio = math.max(0, game_audio-1);
        love.audio.setVolume(game_audio/10)
    end
    
    if keys["right"] then
        game_audio = math.min(10, game_audio+1);
        love.audio.setVolume(game_audio/10)
    end


    Menu:keypressed(keys);
end

function love.keyreleased(keycode)
    keys[keycode] = nil;
end

function love.mousepressed()
    Menu:mousepressed();
end

function love.mousereleased()
    Menu:mousereleased();
end