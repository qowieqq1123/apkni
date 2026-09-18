








UIFullShangHangEnterController=gameState.addListener(fullScreenUI.create())

function UIFullShangHangEnterController:onAppStart()


local args=
{
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eShangHangEnter,
}
self:initUI(args)
end

function UIFullShangHangEnterController:showShangHangEnterWindow(argstable)
if not argstable then argstable={}end

local args=
{
tabType=FULL_TAB_TYPE.eShangHangEnter,
showBg=true,
viewNames={'UIShangHangWin'},
viewArgs={['UIShangHangWin']=argstable,},
}
self:showUI(args)
return true
end
