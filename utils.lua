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