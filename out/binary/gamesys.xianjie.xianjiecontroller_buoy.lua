







xjBuoyType={
eZongmen=1,
eXJFMBoss=2,
eXJBiaoJi=3,
eXianMeng=4,
}

xjBuoyConfig={
[xjBuoyType.eZongmen]={'xjBuoy_zongmen',INSTANCE_TYPE.eXianJieCommonBuoy,1},
[xjBuoyType.eXJFMBoss]={'xjBuoy_XJFMBoss',INSTANCE_TYPE.eXianJieCommonBuoy,1},
[xjBuoyType.eXJBiaoJi]={'xjBuoy_biaoji',INSTANCE_TYPE.eXianJieCommonBuoy,50},
[xjBuoyType.eXianMeng]={'xjBuoy_XianMeng',INSTANCE_TYPE.eXianJieCommonBuoy,1},
}

local buoyLookup={}
local buoyLookup_update={}
local buoyParent
local myXMBuoy

function xianjieController:setBuoyParent(parent)
buoyParent=parent
end

function xianjieController:getBuoyParent()
return buoyParent
end

function xianjieController:getUIScaleFactor()
return UIManager.defaultCanvas_trans.localScale
end

function xianjieController:initBuoy()





xianjieController:addBuoy(xjBuoyType.eZongmen,{})
xianjieModel:initMyXianMengBuoy()
xianjieController:initAllBiaoJiBuoy()
end

function xianjieController:getBuoy(mID)
if mID==nil then return end
return buoyLookup[mID]
end

function xianjieController:addBuoy(buoyType,data)
if not xianjieModel:isInitScene()then



return
end
local obj=new_xjBuoy(buoyType,data)
local mID=obj.m_ID
assert(buoyLookup[mID]==nil)
buoyLookup[mID]=obj
if obj.onUpdate then
buoyLookup_update[mID]=obj
end
notifySystem:postNotify(notifyConfig.onXianJieBuoyAdd,mID)
return mID
end

function xianjieController:removeBuoy(mID)
if mID==nil then return end
local obj=xianjieController:getBuoy(mID)
if obj then
release_xjBuoy(obj)
buoyLookup[mID]=nil
buoyLookup_update[mID]=nil
end
end

function xianjieController:clearAllBuoy()
xianjieController:clearAllBiaoJiBuoy()
xianjieModel:clearMyXianMengBuoy()
if buoyLookup~=nil and next(buoyLookup)~=nil then
for mID,obj in pairs(buoyLookup)do
release_xjBuoy(obj)
end
buoyLookup={}
buoyLookup_update={}



clear_xjBuoyLookup()
end
end

function xianjieController:refreshAllBuoy(anim)
if buoyLookup~=nil then
for mID,obj in pairs(buoyLookup)do
obj:refreshPos(anim)
end
end
end

function xianjieController:refreshBuoy(mID,anim)
local obj=xianjieController:getBuoy(mID)
if obj then
obj:refreshPos(anim)
end
end

function xianjieController:refreshBuoy2(obj,anim)
obj:refreshPos(anim)
end

function xianjieController:updataAllBuoy()
if buoyLookup_update~=nil then
for mID,obj in pairs(buoyLookup_update)do
obj:onUpdate()
end
end
end

function xianjieController:invokeBuoyFunc(mID,funcName,...)
if mID==nil then return end
local obj=xianjieController:getBuoy(mID)
if obj then
local f=obj[funcName]
if f~=nil then
return f(obj,...)
end
end
end


function xianjieController:testBuoy(offset)
if buoyLookup then
for mID,obj in pairs(buoyLookup)do
if obj.setSceneOffset then
obj:setSceneOffset(offset)
end
end
end
end
