function markAdjacent(table, row, col, deep, meta)
    local ads = 0;
    local chance = 60;

    while ads<2 do
        if percent(chance) then
            if setIfEmpty(table, row-1, col, table[row][col], deep, meta) then
                ads = ads + 1;
            end
        end
        if percent(chance) then
            if setIfEmpty(table, row+1, col, table[row][col], deep, meta) then
                ads = ads + 1;
            end
        end
        if percent(chance) then
            if setIfEmpty(table, row, col-1, table[row][col], deep, meta) then
                ads = ads + 1;
            end
        end
        if percent(chance) then
            if setIfEmpty(table, row, col+1, table[row][col], deep, meta) then
                ads = ads + 1;
            end
        end
        ads = ads + 0.4;
    end

end

function randomXY(table)
    while true do
        local rowid = math.random(#table);
        local row   = table[rowid];

        local colid = math.random(#row);

        if table[rowid][colid]==0 then
            return rowid, colid;
        end
    end

    return -1, -1;
end

function isSpace(table)
    for i=1,#table do
        for j=1,#table[i] do
            if table[i][j]==0 then
                return true;
            end
        end
    end

    return false;
end

function setIfEmpty(table, row, col, number, deep, meta)
    if row<1 or #table<row then
        return false;
    end

    if col<1 or #table[row]<col then
        return false;
    end

    if table[row][col]~=0 then
        return false;
    end

    table[row][col] = number;

    if row>meta.hirow then
        meta.hirow = row;
    end

    if row<meta.lorow then
        meta.lorow = row;
    end

    if col>meta.hicol then
        meta.hicol = col;
    end

    if col<meta.locol then
        meta.locol = col;
    end

    deep = deep -1;

    if deep>0 then
        markAdjacent(table, row, col, deep, meta)
    end
    return true;
end