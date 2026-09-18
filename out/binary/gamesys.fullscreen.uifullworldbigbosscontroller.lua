







UIFullWorldBigBossController=gameState.addListener(fullScreenUI.create())

function UIFullWorldBigBossController:onAppStart()
local args=
{
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eWorldBigBoss,
}
self:initUI(args)
end

function UIFullWorldBigBossController:showRankWindow(argstable)
local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIWorldBigBossActivityRankWin'},
viewArgs={['UIWorldBigBossActivityRankWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullWorldBigBossController:showChallengeWin()
local cPos=worldController:getCameraPosition()
local minZoom=worldController:getCameraZoomRange_Normal()[1]
local unitKey="8_0_0"
local callback=function()
local argstable={
close=function()
worldController:lookAtUnit(unitKey,cPos.y,false)
worldController:resetRightView()
end
}
worldController:changeRightView("UIWorldBigBossActivityChallengeWIn",argstable)
end
worldController:lookAtUnit(unitKey,minZoom,false,callback)


end