Levels = {
    bg_wrap = 0,
    selected = 1,
    currentSize = 1;
    customSizes = {
        {2, 64},
        {4, 32},
        {8, 16},
        {16, 8},
        {32, 4},
        {64, 2},
        {128, 1},
    },
    currentDeep = 2,
    customDeeps = {
        1,
        2,
        3,
        4,
        5,
    }
};

function Levels:draw()

    for x=-10,10 do
        for y=-1,8 do
            love.graphics.draw(images.menu_bg, x*48-self.bg_wrap, y*48+self.bg_wrap, 0, 6, 6);
        end
    end

    love.graphics.setFont(fonts.crates)
    black()
    outlineText("Levels", 256/2, 30, 0, 1, 1+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Levels")/2, font_height.crates/2, 0, 0, 2);
    outlineText("Levels", 256/2, 32, 0, 1, 1+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Levels")/2, font_height.crates/2, 0, 0, 2);
    love.graphics.setColor(unpack(edg64[(math.floor(love.timer.getTime()+1)-1)%#edg64+1]));
    love.graphics.print("Levels", 256/2, 30, 0, 1, 1+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Levels")/2, font_height.crates/2);
    love.graphics.setColor(unpack(edg64[(math.floor(love.timer.getTime())-1)%#edg64+1]));
    love.graphics.print("Levels", 256/2, 32, 0, 1, 1+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Levels")/2, font_height.crates/2);
    love.graphics.print("Levels", 256/2, 32, 0, 1, 1+map(math.sin(love.timer.getTime()), -1, 1, 0, .5), fonts.crates:getWidth("Levels")/2, font_height.crates/2);
    white();
    love.graphics.setFont(fonts.thicket)
    local y = 80;
    self:drawButton("Presets:", y, -1); y = y + 20;
    self:drawButton("Level 1", y, 1); y = y + 20;
    self:drawButton("Level 2", y, 2); y = y + 20;
    self:drawButton("Level 3", y, 3); y = y + 20;
    self:drawButton("Customized:", y, -1); y = y + 20;
    local warn = "";

    if self.customSizes[self.currentSize][1]==128 then
        warn = " (Bad Performance)";
    end

    self:drawButton("Size: "..self.customSizes[self.currentSize][1].."x"..self.customSizes[self.currentSize][1]..warn, y, 4); y = y + 20;
    self:drawButton("Piece Deep: "..self.customDeeps[self.currentDeep], y, 5); y = y + 20;
    self:drawButton("Start customized", y, 6); y = y + 20;
end

function Levels:drawButton(text, y, id)
    if self.selected==id then
        text = "> "..text.." <";
    end
    local maxwidth = 0;
    local wrapped  = nil;
    outlineText(text, 256/2, y, 0, 1, 1, fonts.thicket:getWidth(text)/2, font_height.thicket/2, 0, 0, 1)
    outlineText(text, 256/2, y+1, 0, 1, 1, fonts.thicket:getWidth(text)/2, font_height.thicket/2, 0, 0, 1)
    if id==-1 then
        love.graphics.setColor(unpack(edgf64[7]));
    else
        love.graphics.setColor(unpack(edgf64[8]));
    end
    love.graphics.print(text, 256/2, y+1, 0, 1, 1, fonts.thicket:getWidth(text)/2, font_height.thicket/2);
    if id==-1 then
        love.graphics.setColor(unpack(edgf64[8]));
    else
        white()
    end
    love.graphics.print(text, 256/2, y, 0, 1, 1, fonts.thicket:getWidth(text)/2, font_height.thicket/2);
end

function Levels:update(dt)
    self.bg_wrap = self.bg_wrap + 0.3;

    if self.bg_wrap>=48 then
        self.bg_wrap = 0;
    end
end

function Levels:start()
end

local presets = {
    {
        size = 4,
        tile_size = 32,
        deep = 2,
    },
    {
        size = 8,
        tile_size = 16,
        deep = 2,
    },
    {
        size = 16,
        tile_size = 8,
        deep = 2,
    },
}

function Levels:keypressed(keys)

    if keys["up"] then
        self.selected = self.selected - 1;

        if self.selected<1 then
            self.selected=6;
        end
        sounds.blip:stop();
        sounds.blip:play();
    end

    if keys["down"] then
        self.selected = self.selected + 1;

        if self.selected==7 then
            self.selected=1;
        end
        sounds.blip:stop();
        sounds.blip:play();
    end
    
    if keys["left"] then
        if self.selected==4 then
            self.currentSize = self.currentSize - 1;

            if self.currentSize==0 then
                self.currentSize = #self.customSizes;
            end
            sounds.bip:stop();
            sounds.bip:play();
        end

        if self.selected==5 then
            self.currentDeep = self.currentDeep - 1;

            if self.currentDeep==0 then
                self.currentDeep = #self.customDeeps;
            end
            sounds.bip:stop();
            sounds.bip:play();
        end
    end

    if keys["right"] then
        if self.selected==4 then
            self.currentSize = self.currentSize + 1;

            if self.currentSize==#self.customSizes+1 then
                self.currentSize = 1;
            end
            sounds.bip:stop();
            sounds.bip:play();
        end

        if self.selected==5 then
            self.currentDeep = self.currentDeep + 1;

            if self.currentDeep==#self.customDeeps+1 then
                self.currentDeep = 1;
            end
            sounds.bip:stop();
            sounds.bip:play();
        end
    end

    if keys["return"] then
        if self.selected>=1 and self.selected<=3 then
            LevelCustom.specs = shallowcopy(presets[self.selected]);
            LevelCustom:start();
            state = LevelCustom;
            sounds.ok:stop();
            sounds.ok:play();
        end

        if self.selected==6 then
            LevelCustom.specs.size = self.customSizes[self.currentSize][1];
            LevelCustom.specs.tile_size = self.customSizes[self.currentSize][2];
            LevelCustom.specs.deep = self.customDeeps[self.currentDeep];
            LevelCustom:start();
            state = LevelCustom;
            sounds.ok:stop();
            sounds.ok:play();
        end

    end

    if keys["escape"] then
        Menu.bg_wrap = self.bg_wrap;
        state = Menu;
    end
end

function Levels:mousepressed()
end

function Levels:mousereleased()
end