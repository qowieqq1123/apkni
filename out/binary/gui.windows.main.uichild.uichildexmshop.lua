UIChildeXMShop=simple_class(UIChildObject)

local iconname='button_zjmxianmengshangdian'

local _this

function UIChildeXMShop:onLoaded()
_this=self

end

function UIChildeXMShop:onShow(isInit)
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()
local data=zongmenModel:findBuildingDataByID(mapIdType.xianmeng,SLG_SYSTEM_TYPE.eXianMengShanDian)
if data then
isometricMapSystem:openBuildingWin(data)
end
end,true)
end

function UIChildeXMShop:release()

_this=nil
end