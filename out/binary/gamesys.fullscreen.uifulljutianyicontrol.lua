
UIFullJuTianYiControl=gameState.addListener(fullScreenUI.create())

function UIFullJuTianYiControl:onAppStart()
local menulist=
{

{tabType=FULL_TAB_TYPE.eJuTianYi_Produce,callback=function(...)self:showProductionWindow(...)end},
}
local args=
{

fullType=FULL_TYPE.eJuTianYi,
attachName={'entityId'},
skinType=fullScreenSkinType.eSkin24,
}
self:initUI(args)
end

function UIFullJuTianYiControl:showJuTianYiProduceWindow(argstable)
local viewName='UIXianJie_JuTianYiWin'
local args=
{
tabType=FULL_TAB_TYPE.eJuTianYi_Produce,
showBg=true,

viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end