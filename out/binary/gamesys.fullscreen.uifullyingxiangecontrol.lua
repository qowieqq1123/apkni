
UIFullYingXianGeControl=gameState.addListener(fullScreenUI.create())

function UIFullYingXianGeControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eYingXianGe,
attachName={'entityId'},
skinType=fullScreenSkinType.eSkin24,
}
self:initUI(args)
end

function UIFullYingXianGeControl:showYingXianGeWindow(argstable)
local tabType=FULL_TAB_TYPE.eYingXianGe
local viewName='UIYingXianGeWin'
local args=
{
tabType=tabType,
showBg=true,
viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end

