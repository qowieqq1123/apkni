




UIFullTaiXuCangControl=gameState.addListener(fullScreenUI.create())

function UIFullTaiXuCangControl:onAppStart()

local args=
{
fullType=FULL_TYPE.eTaiXuCang,
skinType=fullScreenSkinType.eSkin24,
}
self:initUI(args)
end


function UIFullTaiXuCangControl:showMainWindow(argstable)
argstable=argstable or{}
local state=TaiXuCangModel:getNum()>0
local bdData
if argstable and argstable.entityId then
bdData=zongmenModel:findBuildingByEntityId(argstable.entityId)
else
bdData=TaiXuCangModel:getBuildingData()
end
if state and bdData and zongmenModel:getBDFlagType(bdData.flag)==bdFlagType.normal then
TaiXuCangController:send_6_142()
return
end

local tabType=FULL_TAB_TYPE.eTaiXuCang
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UITaiXuCangWin'},
viewArgs={['UITaiXuCangWin']=argstable},
}


self:showUI(args)
return true
end