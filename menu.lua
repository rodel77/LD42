Menu = {
    bg_wrap = 0,
    selected = 1,
};

function Menu:draw()

    for x=-10,10 do
        for y=-1,8 do
            love.graphics.draw(images.menu_bg, x*48-self.bg_wrap, y*48+self.bg_wrap, 0, 6, 6);
        end
    end

    love.graphics.setFont(fonts.crates)
    black()
    -- love.graphics.print("Spatium", 256/2, 34, 0, 1, 1+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Spatium")/2, font_height.crates/2);
    -- love.graphics.print("Spatium", 256/2, 28, 0, 1, 1+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Spatium")/2, font_height.crates/2);
    -- love.graphics.print("Spatium", 256/2+2, 30, 0, 1, 1+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Spatium")/2, font_height.crates/2);
    -- love.graphics.print("Spatium", 256/2+2, 32, 0, 1, 1+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Spatium")/2, font_height.crates/2);
    -- love.graphics.print("Spatium", 256/2-2, 32, 0, 1, 1+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Spatium")/2, font_height.crates/2);
    outlineText("Spatium", 256/2, 40, 0, 2, 2+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Spatium")/2, font_height.crates/2, 0, 0, 2);
    outlineText("Spatium", 256/2, 42, 0, 2, 2+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Spatium")/2, font_height.crates/2, 0, 0, 2);
    love.graphics.setColor(unpack(edg64[(math.floor(love.timer.getTime()+1)-1)%#edg64+1]));
    love.graphics.print("Spatium", 256/2, 40, 0, 2, 2+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Spatium")/2, font_height.crates/2);
    love.graphics.setColor(unpack(edg64[(math.floor(love.timer.getTime())-1)%#edg64+1]));
    love.graphics.print("Spatium", 256/2, 42, 0, 2, 2+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Spatium")/2, font_height.crates/2);
    love.graphics.print("Spatium", 256/2, 42, 0, 2, 2+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Spatium")/2, font_height.crates/2);
    white();
    love.graphics.setFont(fonts.thicket)
    self:drawButton("Play", 100, 1);
    self:drawButton("Quit", 120, 2);
    self:drawButton("(Use arrow keys)", 160, 4);
    local volume = {
        {1, 1, 1},
        "Volume: ",
        {unpack(edgf64[32])},
    }
    local volumeol = {
        {unpack(edgf64[8])},
        "Volume: ",
        {unpack(edgf64[31])},
    }

    local com = "";

    for i=1,game_audio do
        com = com.."|";
    end
    volume[#volume+1] = com;
    volume[#volume+1] = {unpack(edgf64[7])};
    volumeol[#volumeol+1] = com;
    volumeol[#volumeol+1] = {unpack(edgf64[6])};
    com = "";
    
    for i=1,10-game_audio do
        com = com.."|";
    end
    volume[#volume+1] = com;
    volumeol[#volumeol+1] = com;


    -- self:drawButton("Volume: ||||||||||\n(Use arrow keys)", 140, 3);
    -- self:drawButton(volume, 140, 3);

    black();
    outlineText("Volume: ||||||||||", 256/2, 140, 0, 1, 1, fonts.thicket:getWidth("Volume: ||||||||||")/2, font_height.thicket/2, 0, 0, 1);
    outlineText("Volume: ||||||||||", 256/2, 141, 0, 1, 1, fonts.thicket:getWidth("Volume: ||||||||||")/2, font_height.thicket/2, 0, 0, 1);
    white();
    love.graphics.print(volumeol, 256/2, 141, 0, 1, 1, fonts.thicket:getWidth("Volume: ||||||||||")/2, font_height.thicket/2)
    love.graphics.print(volume, 256/2, 140, 0, 1, 1, fonts.thicket:getWidth("Volume: ||||||||||")/2, font_height.thicket/2)

    local legend = "Created in 48 hours\nfor ludum dare 42\n\nBy @therodel77";
    local y = 256 - font_height.thicket*4 - 2;
    outlineText(legend, 2, y-1, 0, 1, 1, 0, 0, 0, 0, 1);
    outlineText(legend, 2, y, 0, 1, 1, 0, 0, 0, 0, 1);
    love.graphics.setColor(unpack(edgf64[8]));
    love.graphics.print(legend, 2, y-1);
    white();
    love.graphics.print(legend, 2, y);
end

function Menu:drawButton(text, y, id)
    if self.selected==id then
        text = "> "..text.." <";
    end
    local maxwidth = 0;
    local wrapped  = nil;
    outlineText(text, 256/2, y, 0, 1, 1, fonts.thicket:getWidth(text)/2, font_height.thicket/2, 0, 0, 1)
    outlineText(text, 256/2, y+1, 0, 1, 1, fonts.thicket:getWidth(text)/2, font_height.thicket/2, 0, 0, 1)
    love.graphics.setColor(unpack(edgf64[8]));
    love.graphics.print(text, 256/2, y+1, 0, 1, 1, fonts.thicket:getWidth(text)/2, font_height.thicket/2);
    white()
    love.graphics.print(text, 256/2, y, 0, 1, 1, fonts.thicket:getWidth(text)/2, font_height.thicket/2);
end

function Menu:update(dt)
    self.bg_wrap = self.bg_wrap + 0.3;

    if self.bg_wrap>=48 then
        self.bg_wrap = 0;
    end
end

function Menu:start()
end

function Menu:keypressed(keys)
    if keys["down"] or keys["up"] then
        if self.selected==1 then
            self.selected=2;
        else
            self.selected = 1;
        end
        sounds.blip:stop();
        sounds.blip:play();
    end
    
    if keys["return"] then
        if self.selected==1 then
            Levels.bg_wrap = self.bg_wrap;
            state = Levels;
        else
            love.event.quit();
        end
        sounds.ok:stop();
        sounds.ok:play();
    end

    if keys["left"] then
        game_audio = math.max(0, game_audio-1);
        love.audio.setVolume(game_audio/10)
    end
    
    if keys["right"] then
        game_audio = math.min(10, game_audio+1);
        love.audio.setVolume(game_audio/10)
    end

    if keys["escape"] then
        love.event.quit();
    end
end

function Menu:mousepressed()
end

function Menu:mousereleased()
end