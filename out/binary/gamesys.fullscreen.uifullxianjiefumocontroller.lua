







UIFullXianJieFuMoController=gameState.addListener(fullScreenUI.create())

function UIFullXianJieFuMoController:onAppStart()
local args=
{
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eXianJIeFuMo,
}
self:initUI(args)
end

function UIFullXianJieFuMoController:showMainWindow(argstable)
local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIXianJIeFuMoMainWin'},
viewArgs={['UIXianJIeFuMoMainWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullXianJieFuMoController:showChallengeWin()
local data=XianJieFuMoController:getBossData()
local winParams={}
winParams.lookAtPos=data:getWorldPos()
xianjieController:openWin('UIXJFMChallengeWIn',winParams)
end