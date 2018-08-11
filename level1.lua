Level1 = {
    bg_wrap = 0,
    map = {
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0},
    },
    currentColor = 1,
    pieces = {},
    grab = 0,
    hover = 0,
}

function Level1:draw()
    for x=0,8 do
        for y=-1,7 do
            love.graphics.draw(images.carnival_bg, x*32-self.bg_wrap, y*32+self.bg_wrap, 0, 4, 4);
            -- love.graphics.rectangle("line", i*16, j*16, 16, 16)
        end
    end

    love.graphics.setLineWidth(2)

    -- print(mouseX, mouseY)
    self.hover = 0;
    for i,piece in ipairs(self.pieces) do
        love.graphics.push();
        love.graphics.translate(20, 50+(i-1)*20)
        -- love.graphics.rotate(math.rad(math.cos(love.timer.getTime())*45));
        local matrix = piece[2];
        for j,row in ipairs(matrix) do
            for k,col in ipairs(row) do
                if col~=0 then
                    black();
                    if collide((k-1)*5+20, (j-1)*5+50+(i-1)*20, 5, 5, mouseX, mouseY) then
                        self.hover = i;
                    end
                    love.graphics.rectangle("line", (k-1)*5, (j-1)*5, 5, 5)
                end
            end
        end
        for j,row in ipairs(matrix) do
            for k,col in ipairs(row) do
                if col~=0 then
                    love.graphics.setColor(unpack(edg64[(piece[1]-1)%#edg64+1]));
                    love.graphics.rectangle("fill", (k-1)*5, (j-1)*5, 5, 5)
                end
            end
        end
        love.graphics.pop();
    end
    white()

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

    if self.grab>0 then
        love.graphics.setColor(unpack(edg64[(self.grab-1)%#edg64+1]));
        for j,row in ipairs(self.pieces[self.grab][2]) do
            for k,col in ipairs(row) do
                if col~=0 then
                    love.graphics.draw(images.block, math.floor((mouseX+(k-1)*32)/32)*32, math.floor((mouseY+(j-1)*32)/32)*32, 0, 2, 2);
                end
            end
        end
        white()
    end

end

function Level1:update(dt)
    self.bg_wrap = self.bg_wrap + 0.3;

    if self.bg_wrap>=16 then
        self.bg_wrap = 0;
    end
end

function Level1:start()
    while true do
        print("Start!")
        if isSpace(self.map) then
            local row, col = randomXY(self.map);
            local meta = {
                hirow = row,
                lorow = row,
                hicol = col,
                locol = col,
            };
            setIfEmpty(self.map, row, col, self.currentColor, 2, meta);
            self.pieces[#self.pieces+1] = {self.currentColor, submatrix(self.map, meta.lorow, meta.locol, meta.hirow, meta.hicol, self.currentColor)};
    
            self.currentColor = self.currentColor + 1;
        else
            self.map = {
                {0, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0, 0},
            }
            return;
        end
    end
end

function Level1:keypressed(keys)
    if keys["space"] then
        self:start();
    end

    if keys["r"] then
        self.pieces = {};
        self.map = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0},
        }
    end
    -- markAdjacent(self.map, 3, 3, 1)
end

function Level1:mousepressed()
    if self.hover>0 then
        self.grab = self.hover;
    end
end

function Level1:mousereleased()
    if self.grab>0 then
        add(self.map, self.pieces[self.grab][2], math.floor(mouseY/32)*32/32-1, math.floor(mouseX/32)*32/32-1);
        table.remove(self.pieces, self.grab);
        self.grab = 0;
    end
end