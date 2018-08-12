local CScreen = require "libs/cscreen_min";
inspect = require "libs/inspect";

loadAssets = require "loader";

math.randomseed(os.time());

require "utils";
require "puzzle_generator";
require "menu";
require "levelCustom";
require "levels";

state = Menu;

function love.load()
    loadAssets();
    CScreen.init(256, 256, true);
end

keys_pressing = {};
function love.draw()
    CScreen.apply();
    state:draw();
    CScreen.cease()
end

function love.update(dt)
    mouseX, mouseY = CScreen.project(love.mouse.getPosition());
    state:update(dt);

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
    keys_pressing[keycode] = true;

    if keys_pressing["lalt"] and keys_pressing["return"] then
        love.window.setFullscreen(not love.window.getFullscreen());
        return;
    end

    if keys_pressing["lctrl"] and keys_pressing["f3"] then
        loadAssets();
        return;
    end

    state:keypressed(keys_pressing);
end

function love.keyreleased(keycode)
    keys_pressing[keycode] = nil;
end

function love.mousepressed()
    state:mousepressed();
end

function love.mousereleased()
    state:mousereleased();
end

function love.wheelmoved(x, y)
    if state.wheelmoved then
        state:wheelmoved(x, y);
    end
end