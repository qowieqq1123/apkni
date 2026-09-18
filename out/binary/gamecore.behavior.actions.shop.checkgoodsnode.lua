







checkGoodsNode=simple_class(baseNode)

local function _haveGoods(list)
for i,v in ipairs(list)do
if v>0 then
return true
end
end
return false
end

function checkGoodsNode:update(interval)
local data=self.data
if data and data.inId then
local ubdId=self:getSharedVar(data.inId)
if ubdId then
local shopData=UIShopModel:getShopData(ubdId)
if shopData then
local goods=shopData.sellItemList
if goods and _haveGoods(goods)then
return nodeState.success
end
end
end
end
return nodeState.failure
end


function checkGoodsNode:skip()
return self:update()
end