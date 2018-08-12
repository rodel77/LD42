LevelCustom = {
    bg_wrap = 0,
    map = {},
    solved = {},
    currentColor = 1,
    pieces = {},
    oldPieces = {},
    grab = 0,
    hover = 0,
    canplace = false,
    piecesY = 0,
    finished = false,
    back_hover = false,
    transition = 128,
    specs = {
        size = 4,
        tile_size = 32,
        deep = 2,
    },
}

function LevelCustom:reset()
    self.currentColor = 1;
    self.pieces = {};
    self.oldPieces = {};
    self.grab = 0;
    self.hover = 0;
    self.canplace = false;
    self.piecesY = 0;
    self.finished = false;
    self.back_hover = false;
    self.transition = 128;
end

local shakeEnabled = true;

function LevelCustom:draw()
    love.graphics.push();

    -- love.graphics.scale(1.5);
    if sounds.place:isPlaying() and shakeEnabled then
        love.graphics.translate(math.random(-1, 1), math.random(-1, 1));
    end

    -- love.graphics.scale(map(self.shake, 0, 1, 1, 2));
    -- self.shake = math.min(1, self.shake+0.005);
    
    for x=-10,10 do
        for y=-1,8 do
            love.graphics.draw(images.carnival_bg, x*48-self.bg_wrap, y*48+self.bg_wrap, 0, 6, 6);
        end
    end

    love.graphics.setLineWidth(2)

    -- print(mouseX, mouseY)
    self.hover = 0;
    for i,piece in ipairs(self.pieces) do
        love.graphics.push();
        local matrix = piece[2];

        love.graphics.translate(20, 50+(i-1)*(30)+self.piecesY)
        -- love.graphics.rotate(math.rad(math.cos(love.timer.getTime())*45));
        for j,row in ipairs(matrix) do
            for k,col in ipairs(row) do
                if col~=0 then
                    black();
                    if collide((k-1)*5+20, (j-1)*5+50+(i-1)*(30)+self.piecesY, 5, 5, mouseX, mouseY) then
                        self.hover = i;
                    end
                    love.graphics.rectangle("line", (k-1)*5, (j-1)*5, 5, 5)
                end
            end
        end
        for j,row in ipairs(matrix) do
            for k,col in ipairs(row) do
                if col~=0 then
                    love.graphics.setColor(unpack(darken(edg64[(piece[1]-1)%#edg64+1])));
                    love.graphics.rectangle("fill", (k-1)*5, (j-1)*5, 5, 5)
                    love.graphics.setColor(unpack(edg64[(piece[1]-1)%#edg64+1]));
                    love.graphics.rectangle("fill", (k-1)*5+1, (j-1)*5, 4, 4)
                end
            end
        end
        love.graphics.pop();
    end
    
    love.graphics.setColor(.3, .3, .3)
    love.graphics.rectangle("fill", 66, 66, self.specs.size*self.specs.tile_size, self.specs.size*self.specs.tile_size);
    white()

    local solveState = false;

    if keys_pressing["lshift"] then
        solveState = true;
    end
    -- print(inspect(self.solved))

    for y=1,self.specs.size do
        local row = self.map[y];
        if solveState then
            row = self.solved[y];
        end

        for x=1,self.specs.size do
            local colour = self.map[y][x];
            if solveState then
                colour = self.solved[y][x];
            end

            if colour>0 then
                love.graphics.setColor(unpack(darken(edg64[(colour-1)%#edg64+1])));
            else
                love.graphics.setColor(unpack(edgf64[6]));
            end

            love.graphics.rectangle("fill", 64+(x-1)*self.specs.tile_size, 64+(y-1)*self.specs.tile_size, self.specs.tile_size, self.specs.tile_size);
            
            if colour>0 then
                love.graphics.setColor(unpack(edg64[(colour-1)%#edg64+1]));
            else
                white();
            end
            -- love.graphics.draw(images.block, 64+(x-1)*16, 64+(y-1)*16, 0, 1, 1);
            love.graphics.rectangle("fill", 64+(x-1)*self.specs.tile_size+1, 64+(y-1)*self.specs.tile_size, self.specs.tile_size-1, self.specs.tile_size-1);
            white();
        end
    end
    
    if self.grab>0 then
        -- love.graphics.setColor(unpack(edg64[(self.grab-1)%#edg64+1]));
        self.canplace = true;
        for j,row in ipairs(self.pieces[self.grab][2]) do
            for k,col in ipairs(row) do
                if col~=0 then
                    local x = math.floor((mouseX+(k-1)*self.specs.tile_size)/self.specs.tile_size)*self.specs.tile_size;
                    local y = math.floor((mouseY+(j-1)*self.specs.tile_size)/self.specs.tile_size)*self.specs.tile_size;
                    if x>=64 and y>=64 and x<64+self.specs.size*self.specs.tile_size and y<64+self.specs.size*self.specs.tile_size then
                        if self.map[(y-64)/self.specs.tile_size+1][(x-64)/self.specs.tile_size+1]~=0 then
                            self.canplace = false;
                        end
                    else
                        self.canplace = false;
                    end
                end
            end
        end

        for j,row in ipairs(self.pieces[self.grab][2]) do
            for k,col in ipairs(row) do
                if col~=0 then
                    -- print(math.floor((mouseX+(k-1)*self.specs.tile_size)/self.specs.tile_size), math.floor((mouseY+(j-1)*self.specs.tile_size)/self.specs.tile_size))
                    local x = math.floor((mouseX+(k-1)*self.specs.tile_size)/self.specs.tile_size)*self.specs.tile_size;
                    local y = math.floor((mouseY+(j-1)*self.specs.tile_size)/self.specs.tile_size)*self.specs.tile_size;
                    if x>=64 and y>=64 and x<64+self.specs.size*self.specs.tile_size and y<64+self.specs.size*self.specs.tile_size then
                        if self.map[(y-64)/self.specs.tile_size+1][(x-64)/self.specs.tile_size+1]~=0 then
                            love.graphics.setColor(unpack(edgf64[62]));
                        else
                            love.graphics.setColor(unpack(darken(edg64[(self.pieces[self.grab][1]-1)%#edg64+1])));
                        end
                    else
                        love.graphics.setColor(unpack(edgf64[62]));
                    end
                    love.graphics.rectangle("fill", x, y, self.specs.tile_size, self.specs.tile_size);
                    if x>=64 and y>=64 and x<64+self.specs.size*self.specs.tile_size and y<64+self.specs.size*self.specs.tile_size then
                        if self.map[(y-64)/self.specs.tile_size+1][(x-64)/self.specs.tile_size+1]~=0 then
                            love.graphics.setColor(unpack(edgf64[61]));
                        else
                            love.graphics.setColor(unpack(edg64[(self.pieces[self.grab][1]-1)%#edg64+1]));
                        end
                    else
                        love.graphics.setColor(unpack(edgf64[61]));
                    end
                    love.graphics.rectangle("fill", x+1, y, self.specs.tile_size-1, self.specs.tile_size-1);
                    -- love.graphics.draw(images.block, math.floor((mouseX+(k-1)*16)/16)*16, math.floor((mouseY+(j-1)*16)/16)*16, 0, 1, 1);
                end
            end
        end
        white()
    end
    -- love.graphics.rectangle("fill", 64, 64, self.specs.size*self.specs.tile_size, self.specs.size*self.specs.tile_size)
    local help = "Solved state: \"shift\"\nNew Game: \"r\"\nLevel Selection: \"esc\"\n(You can scroll the pieces)";
    outlineText(help, 64, 2, 0, 1, 1, 0, 0, 0, 0, 1)
    outlineText(help, 64, 3, 0, 1, 1, 0, 0, 0, 0, 1)
    -- outlineText("Restart: \"r\"", 64, 4+font_height.thicket, 0, 1, 1, 0, 0, 0, 0, 1)
    -- outlineText("Restart: \"r\"", 64, 5+font_height.thicket, 0, 1, 1, 0, 0, 0, 0, 1)
    -- outlineText("(You can scroll the pieces)", 64, 6+font_height.thicket*2, 0, 1, 1, 0, 0, 0, 0, 1)
    -- outlineText("(You can scroll the pieces)", 64, 7+font_height.thicket*2, 0, 1, 1, 0, 0, 0, 0, 1)
    love.graphics.setColor(unpack(edgf64[8]));
    love.graphics.print(help, 64, 3)
    -- love.graphics.print("Restart: \"r\"", 64, 5+font_height.thicket)
    -- love.graphics.print("(You can scroll the pieces)", 64, 7+font_height.thicket*2)
    white();
    love.graphics.print(help, 64, 2)
    -- love.graphics.print("Restart: \"r\"", 64, 4+font_height.thicket)
    -- love.graphics.print("(You can scroll the pieces)", 64, 6+font_height.thicket*2)

    
    if self.finished then
        black();
        love.graphics.rectangle("line", 128-fonts.thicket:getWidth("Back")/2-20, 220-font_height.thicket/2-5, fonts.thicket:getWidth("Back")+40, font_height.thicket/2+15+2);
        love.graphics.setColor(unpack(edgf64[37]));
        love.graphics.rectangle("fill", 128-fonts.thicket:getWidth("Back")/2-20, 220-font_height.thicket/2-5, fonts.thicket:getWidth("Back")+40, font_height.thicket/2+15+2);
        love.graphics.setColor(unpack(edgf64[36]));
        love.graphics.rectangle("fill", 128-fonts.thicket:getWidth("Back")/2-20, 220-font_height.thicket/2-5, fonts.thicket:getWidth("Back")+40, font_height.thicket/2+15);
    
        outlineText("Back", 128, 220, 0, 1, 1, fonts.thicket:getWidth("Back")/2, font_height.thicket/2, 0, 0, 1);
        outlineText("Back", 128, 221, 0, 1, 1, fonts.thicket:getWidth("Back")/2, font_height.thicket/2, 0, 0, 1);
        love.graphics.setColor(unpack(edgf64[8]));
        love.graphics.print("Back", 128, 221, 0, 1, 1, fonts.thicket:getWidth("Back")/2, font_height.thicket/2);
        white();
        love.graphics.print("Back", 128, 220, 0, 1, 1, fonts.thicket:getWidth("Back")/2, font_height.thicket/2);
        
        self.back_hover = collide(128-fonts.thicket:getWidth("Back")/2-20, 220-font_height.thicket/2-5, fonts.thicket:getWidth("Back")+40, font_height.thicket/2+15+2, mouseX, mouseY);
        
    end
    
    love.graphics.pop();
    
    
    black();
    love.graphics.rectangle("fill", 0, 0, 256, self.transition);
    love.graphics.rectangle("fill", 0, 256, 256, -self.transition);
    white();

    -- screenMessage("test");
end

function LevelCustom:update(dt)
    self.bg_wrap = self.bg_wrap + 0.3;

    if self.bg_wrap>=48 then
        self.bg_wrap = 0;
    end

    if self.transition>0 then
        self.transition = self.transition - 1;
    end
end

function LevelCustom:start()
    self.map = matrixRange(self.specs.size);

    while true do
        if isSpace(self.map) then
            local row, col = randomXY(self.map);
            local meta = {
                hirow = row,
                lorow = row,
                hicol = col,
                locol = col,
            };
            setIfEmpty(self.map, row, col, self.currentColor, self.specs.deep, meta);
            self.pieces[#self.pieces+1] = {self.currentColor, submatrix(self.map, meta.lorow, meta.locol, meta.hirow, meta.hicol, self.currentColor)};
    
            self.currentColor = self.currentColor + 1;
        else
            self.oldPieces = shallowcopy(self.pieces);
            self.solved = self.map;
            self.map = matrixRange(self.specs.size);
            return;
        end
    end
end

function LevelCustom:keypressed(keys)
    -- if keys["space"] then
    --     self:start();
    -- end

    if keys["r"] then
        self.pieces = {};
        self.map = matrixRange(self.specs.size);
        self:start();
        sounds.remove:stop();
        sounds.remove:play();
    end

    if keys["s"] then
        shakeEnabled = not shakeEnabled;
    end

    if keys["escape"] then
        self:reset();
        state = Levels;
    end
    -- markAdjacent(self.map, 3, 3, 1)
end

function LevelCustom:mousepressed()
    if self.hover>0 then
        self.grab = self.hover;
        sounds.pick:stop();
        sounds.pick:play();
    elseif self.back_hover then
        self:reset();
        state = Levels;
        sounds.ok:stop();
        sounds.ok:play();
    else
        local y = (math.floor(mouseY/self.specs.tile_size)*self.specs.tile_size-64)/self.specs.tile_size+1;
        local x = (math.floor(mouseX/self.specs.tile_size)*self.specs.tile_size-64)/self.specs.tile_size+1;
        if x>0 and y>0 and y<=#self.map and x<=#self.map[y] and self.map[y][x]~=0 then
            for i,piece in ipairs(self.oldPieces) do
                if piece[1]==self.map[y][x] then
                    self.pieces[#self.pieces+1] = piece;
                    break;
                end
            end

            deleteColor(self.map, self.map[y][x]);
            sounds.remove:stop();
            sounds.remove:play();
        end
    end
end

function LevelCustom:mousereleased()
    if self.grab>0 then
        if not self.canplace then
            sounds.no:play();
            self.grab = 0;
            return;
        end

        sounds.place:stop();
        sounds.place:play();

        add(self.map, self.pieces[self.grab][2], (math.floor(mouseY/self.specs.tile_size)*self.specs.tile_size-64)/self.specs.tile_size+1, (math.floor(mouseX/self.specs.tile_size)*self.specs.tile_size-64)/self.specs.tile_size+1);
        table.remove(self.pieces, self.grab);
        self.grab = 0;

        if not isSpace(self.map) then
            sounds.finish:play()
            self.finished = true;
        end
    end
end

function LevelCustom:wheelmoved(x, y)
    self.piecesY = self.piecesY + y*5;
end