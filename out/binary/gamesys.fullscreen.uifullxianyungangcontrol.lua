
UIFullXianYunGangControl=gameState.addListener(fullScreenUI.create())

function UIFullXianYunGangControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eXianYunGang,
attachName={'entityId'},
skinType=fullScreenSkinType.eSkin22,
}
self:initUI(args)
end

function UIFullXianYunGangControl:showMainWindow(argstable)
local tabType=FULL_TAB_TYPE.eXianYunGang
local viewName='UIXianYunGangWin'
local args=
{
tabType=tabType,
showBg=true,
viewNames={viewName,"UITopMaskWin"},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end

