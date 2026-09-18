






UIFullYunJiaYingControl=gameState.addListener(fullScreenUI.create())

function UIFullYunJiaYingControl:onAppStart()
local args=
{
skinType=fullScreenSkinType.eSkin24,
fullType=FULL_TYPE.eYunJiaYing,
attachName={'entityId'}
}
self:initUI(args)
end

function UIFullYunJiaYingControl:showYunJiaYingWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eYunJiaYing
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIYunJiaYingWin'},
viewArgs={['UIYunJiaYingWin']=argstable},
}
self:showUI(args)
return true
end
