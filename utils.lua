function white()
    love.graphics.setColor(1, 1, 1);
end

function red()
    love.graphics.setColor(1, 0, 0);
end

function halfr()
    return math.random(100)<50;
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