







UIFullAirMiniGameControl=gameState.addListener(fullScreenUI.create())

function UIFullAirMiniGameControl:onAppStart()

local args=
{
fullType=FULL_TYPE.eAirMiniGame,
skinType=fullScreenSkinType.eSkin15,
}
self:initUI(args)
end

function UIFullAirMiniGameControl:onEnterState(isReconnect)
if isReconnect then
return
end
end

function UIFullAirMiniGameControl:onLeaveState(isReconnect)
if isReconnect then
return
end
end


function UIFullAirMiniGameControl:showShopWin(argstable)
self:showWindow("UIAirMiniGame_shopWin",argstable)
return true
end


function UIFullAirMiniGameControl:showBagWin(argstable)
self:showWindow("UIAirMiniGame_bagWin",argstable)
return true
end


function UIFullAirMiniGameControl:showPauseWin(argstable)
self:showWindow("UIAirMiniGame_pauseWin",argstable)
return true
end


function UIFullAirMiniGameControl:showLevelUpWin(argstable)
self:showWindow("UIAirMiniGame_levelUpWin",argstable)
return true
end


function UIFullAirMiniGameControl:showGetRewardWin(argstable)
self:showWindow("UIAirMiniGame_getRewardWin",argstable)
return true
end


function UIFullAirMiniGameControl:showSettlementWin(argstable)
self:showWindow("UIAirMiniGame_settlementWin",argstable)
return true
end


function UIFullAirMiniGameControl:showFinishAnimWin(argstable)
self:showWindow("UIAirMiniGame_finishAnimWin",argstable)
return true
end


function UIFullAirMiniGameControl:showReviveWin(argstable)
self:showWindow("UIAirMiniGame_reviveWin",argstable)
return true
end