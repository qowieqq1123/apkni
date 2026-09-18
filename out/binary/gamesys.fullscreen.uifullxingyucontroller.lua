







UIFullXingYuController=gameState.addListener(fullScreenUI.create())

function UIFullXingYuController:onAppStart()
local args=
{
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eXingYu,
}
self:initUI(args)
end

function UIFullXingYuController:showMainWindow(argstable)
local xyId=argstable.xyId
local state,endTime=XingYuController.getXingYuState(xyId)
if state==XingYuState.eTanSuo then
local startCallback=function()
local args=
{
showBg=false,
showTopMask=false,
viewNames={'UIXingYuMainWin'},
viewArgs={['UIXingYuMainWin']=argstable or{}},
}
self:showUI(args)
end
loadingControl.openCloud(startCallback)
elseif state==XingYuState.eHunZhan or
state==XingYuState.eZhenDuo or
state==XingYuState.eFinish then

local func=function(argstableEx)
fightManager.setState(2)
fightManager.setCameraActive(true,fightCameraMode.fight)
UIFullXingYuController.fightStage=argstableEx.fightStage
local args=
{
showBg=false,
showTopMask=false,
viewNames={'UIXingYuMainWin'},
viewArgs={['UIXingYuMainWin']=argstableEx or{}},
}
self:showUI(args)

end
local startCallback=function()
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local stage=xyCfg.stage
fightStage:create(stage,func,argstable)
end
fightManager.setCameraActive(false,fightCameraMode.fight)
loadingControl.openCloud(startCallback)
else
logErr("UIFullXingYuController 打开主界面 状态不对",state)
end
end

function UIFullXingYuController:closeWin()
if fullScreenUI.checkFull(UIFullXingYuController)then
UIFullXingYuController:closeUI()
end
UIManager:closeWindow("UIXYInfoListWIn")
end
