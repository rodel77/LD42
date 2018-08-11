Level1 = {
    bg_wrap = 0,
    map = {
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0},
    },
    currentColor = 1,
}

function Level1:draw()
    for x=0,8 do
        for y=-1,7 do
            love.graphics.draw(images.carnival_bg, x*32-self.bg_wrap, y*32+self.bg_wrap, 0, 4, 4);
            -- love.graphics.rectangle("line", i*16, j*16, 16, 16)
        end
    end

    for y=1,4 do
        local row = self.map[y];

        for x=1,4 do
            if self.map[y][x]>0 then
                -- red();
                love.graphics.setColor(unpack(edg64[(self.map[y][x]-1)%#edg64+1]));
            end

            love.graphics.draw(images.block, 64+(x-1)*32, 64+(y-1)*32, 0, 2, 2);
            -- love.graphics.rectangle("fill", 64+(x-1)*32, 64+(y-1)*32, 32, 32);
            white();
        end
    end

end

function Level1:update(dt)
    self.bg_wrap = self.bg_wrap + 0.3;

    if self.bg_wrap>=16 then
        self.bg_wrap = 0;
    end
end

function Level1:keypressed(keys)
    if keys["space"] then
        if isSpace(self.map) then
            local row, col = randomXY(self.map);
            setIfEmpty(self.map, row, col, self.currentColor, 2);
            self.currentColor = self.currentColor + 1;
        else
            print("full!")
        end
    end

    if keys["r"] then
        self.map = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0},
        }
    end
    -- markAdjacent(self.map, 3, 3, 1)
end