







UIFullJiuYuZhengFengController=gameState.addListener(fullScreenUI.create())

function UIFullJiuYuZhengFengController:onAppStart()
local args=
{
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eJiuYuZhengFeng,
}
self:initUI(args)
end

function UIFullJiuYuZhengFengController:showMainWindow(argstable)
local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIJYZF_RankWin'},
viewArgs={['UIJYZF_RankWin']=argstable or{}},
}
self:showUI(args)
return true
end