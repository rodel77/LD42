function markAdjacent(table, row, col, deep)
    -- local newtable = shallowcopy(table);

    local ads = 0;

    while ads<2 do
        if halfr() then
            setIfEmpty(table, row-1, col, table[row][col], deep);
            ads = ads + 1;
        end
        if halfr() then
            setIfEmpty(table, row+1, col, table[row][col], deep);
            ads = ads + 1;
        end
        if halfr() then
            setIfEmpty(table, row, col-1, table[row][col], deep);
            ads = ads + 1;
        end
        if halfr() then
            setIfEmpty(table, row, col+1, table[row][col], deep);
            ads = ads + 1;
        end
    end

end

function randomXY(table)
    while true do
        local rowid = math.random(#table);
        local row   = table[rowid];

        local colid = math.random(#row);

        if table[rowid][colid]==0 then
            print(rowid, colid)
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

function setIfEmpty(table, row, col, number, deep)
    if row<1 or #table<row then
        return;
    end

    if col<1 or #table[row]<col then
        return;
    end

    if table[row][col]==0 then
        table[row][col] = number;
    end

    deep = deep -1;

    if deep>0 then
        markAdjacent(table, row, col, deep)
    end
    return true;
end