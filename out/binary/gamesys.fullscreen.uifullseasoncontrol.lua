








UIFullSeasonControl=gameState.addListener(fullScreenUI.create())

function UIFullSeasonControl:onAppStart()
local menulist={}

local args=
{
menulist=menulist,
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eSeason,
}
self:initUI(args)
end

function UIFullSeasonControl:openSeasonWindow(handleType,stageIdx,subIndex1,subIndex2)
local winArgs={
handleType=handleType,
stageIdx=stageIdx,
funcIdx1=subIndex1,
funcIdx2=subIndex2,
}
local handle=seasonModel:getHandle(handleType)
if handle and handle:checkShowCondition()then
local winName=handle:getConfig("winName")
local args=
{
showBg=true,
showBlur=false,
showTopMask=true,
viewNames={winName},
viewArgs={[winName]=winArgs},
}
self:showUI(args)
return true
else
local seasonName=seasonModel:getHandleConfig(handleType,"name")
UIManager.error(FMT.fmt("{0}未开启",seasonName))
return false
end
end