return function()
    love.graphics.setDefaultFilter("nearest", "nearest");

    images = {
        carnival_bg = love.graphics.newImage("assets/carnival.png"),
        frame       = love.graphics.newImage("assets/frame.png"),
        block       = love.graphics.newImage("assets/block.png"),
    };

    quads = {
        frame = {
            love.graphics.newQuad(0,  0, 16, 16, 48, 48),
            love.graphics.newQuad(16, 0, 16, 16, 48, 48),
            love.graphics.newQuad(32, 0, 16, 16, 48, 48),
            love.graphics.newQuad(0,  16, 16, 16, 48, 48),
            love.graphics.newQuad(16, 16, 16, 16, 48, 48),
            love.graphics.newQuad(32, 16, 16, 16, 48, 48),
            love.graphics.newQuad(0,  32, 32, 16, 48, 48),
            love.graphics.newQuad(16, 32, 32, 16, 48, 48),
            love.graphics.newQuad(32, 32, 32, 16, 48, 48),
        }
    }

    edg64 = {
        -- "ff0040","131313","1b1b1b","272727","3d3d3d","5d5d5d","858585","b4b4b4","ffffff","c7cfdd","92a1b9","657392","424c6e","2a2f4e","1a1932","0e071b","1c121c","391f21","5d2c28","8a4836","bf6f4a","e69c69","f6ca9f","f9e6cf","edab50","e07438","c64524","8e251d","ff5000","ed7614","ffa214","ffc825","ffeb57","d3fc7e","99e65f","5ac54f","33984b","1e6f50","134c4c","0c2e44","00396d","0069aa","0098dc","00cdf9","0cf1ff","94fdff","fdd2ed","f389f5","db3ffd","7a09fa","3003d9","0c0293","03193f","3b1443","622461","93388f","ca52c9","c85086","f68187","f5555d","ea323c","c42430","891e2b","571c27",
        "571c27",
        "1e6f50",
        "ed7614",
        "00396d",
        "891e2b",
        "33984b",
        "ffa214",
        "0069aa",
        "c42430",
        "5ac54f",
        "ffc825",
        "0098dc",
        "ea323c",
        "99e65f",
        "ffeb57",
        "00cdf9",
    }
    
    -- print(#edg64)

    -- for i=1,200 do
    --     print(i, edg64[(i-1)%#edg64+1])
    -- end


    for i,v in ipairs(edg64) do
        edg64[i] = hex2rgb(v);
    end

end