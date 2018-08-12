function white()
    love.graphics.setColor(1, 1, 1);
end

function red()
    love.graphics.setColor(1, 0, 0);
end

function black(alpha)
    love.graphics.setColor(0.07, 0.07, 0.07, alpha or 1);
end

function halfr()
    return math.random(100)<50;
end

function map(n, start1, stop1, start2, stop2)
    return (n - start1) / (stop1 - start1) * (stop2 - start2) + start2;
end

local msgAnimation = 0;
local msgHiding = false;
function screenMessage(text)
    local msAnimation = math.min(msgAnimation, 1);
    if msgHiding then
        msAnimation = msAnimation + 1;
    end
    r, g, b, a = love.graphics.getColor();
    love.graphics.setColor(unpack(edgf64[7]));
    love.graphics.rectangle("fill", -10*msAnimation, 128-10, msAnimation*276, 20);
    love.graphics.setColor(unpack(edgf64[8]));
    love.graphics.rectangle("fill", -10, 128-10, msAnimation*276, 18);
    black();
    love.graphics.rectangle("line", -10, 128-10, msAnimation*276, 20);
    love.graphics.print(text, msAnimation*(256/2), 256/2, 0, 1, 1, fonts.thicket:getWidth(text)/2, font_height.thicket/2);
    love.graphics.setColor(r, g, b, a);
    msgAnimation = msgAnimation + 0.03;

    if msgAnimation>2 then
        if not msgHiding then
            msgHiding = true;
            msgAnimation = 0;
        else
            -- msgHiding = false;
            -- msgAnimation = 0;
        end
    end
end

function submatrix(table, lorow, locol, hirow, hicol, id)
    -- local rows = hirow-lorow+1;
    -- local cols = hicol-locol+1;
    local newtable = {};

    for row=lorow,hirow do
        local trow = {}
        for col=locol,hicol do
            -- if table[row][col]==id then
                trow[#trow+1] = table[row][col];
            -- end
            -- row-lorow, col-locol
        end

        newtable[#newtable+1] = trow;
    end

    for i,r in ipairs(newtable) do
        for j,c in ipairs(r) do
            if c~=id then
                newtable[i][j] = 0;
            end
        end
    end

    return newtable;
end

function percent(x)
    return 100 * math.random() < x;
end

function collide(ox, oy, w, h, x, y)
    return x >= ox and x <= ox+w and y >= oy and y <= oy+h;
end

function add(table, subtable, row, col)
    -- table[row][col] = 1;
    for i,r in ipairs(subtable) do
        for v,c in ipairs(r) do
            if table[row+i-1][col+v-1]==0 then
                table[row+i-1][col+v-1] = c;
            end
        end
    end
end

function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

-- https://gist.github.com/jasonbradley/4357406
function hex2rgb(hex)
    hex = hex:gsub("#","");
    return {tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255};
end

function outlineText(text, x, y, r, sx, sy, ox, oy, kx, ky, off)
    red, green, blue, alpha = love.graphics.getColor();
    black();
    love.graphics.print(text, x+off, y, r, sx, sy, ox, oy, kx, ky);
    love.graphics.print(text, x-off, y, r, sx, sy, ox, oy, kx, ky);
    love.graphics.print(text, x, y+off, r, sx, sy, ox, oy, kx, ky);
    love.graphics.print(text, x, y-off, r, sx, sy, ox, oy, kx, ky);
    love.graphics.setColor(red, green, blue, alpha);
end

function outlineTextf(text, x, y, maxwidth, align, r, sx, sy, ox, oy, kx, ky, off)
    red, green, blue, alpha = love.graphics.getColor();
    black();
    love.graphics.printf(text, x+off, y, maxwidth, align, r, sx, sy, ox, oy, kx, ky);
    love.graphics.printf(text, x-off, y, maxwidth, align, r, sx, sy, ox, oy, kx, ky);
    love.graphics.printf(text, x, y+off, maxwidth, align, r, sx, sy, ox, oy, kx, ky);
    love.graphics.printf(text, x, y-off, maxwidth, align, r, sx, sy, ox, oy, kx, ky);
    love.graphics.setColor(red, green, blue, alpha);
end

function matrixRange(s)
    local table = {};
    for i=1,s do
        local row = {};
        for j=1,s do
            row[#row+1] = 0;
        end
        table[#table+1] = row;
    end
    return table;
end

function darken(color)
    local copy = shallowcopy(color);
    for i,v in ipairs(copy) do
        copy[i] = v * 0.7;
    end
    return copy;
end