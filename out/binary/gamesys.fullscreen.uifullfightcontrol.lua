




UIFullFightControl=gameState.addListener(fullScreenUI.create())

function UIFullFightControl:onAppStart()
local args=
{
menulist=nil,
fullType=FULL_TYPE.eFight,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end



function UIFullFightControl:showFightMain(battle)
local tabType=FULL_TAB_TYPE.eFightMain
local args={
tabType=tabType,
showBg=false,
viewNames={'UIFightMainTop'},
viewArgs={['UIFightMainTop']=battle},
}
self:showUI(args)
if battle.battleType then
local handle=fightBattleHandle:getHandle(battle.battleType)
if handle then
local mulitResultType=handle.mulitResultType or eFightMulitResultType.AndVictory
if handle.onFightTopHeadBattle then
local headArgs=handle.onFightTopHeadBattle(battle)
local player1=headArgs.player1 or{}
local player2=headArgs.player2 or{}
local showWinTimes=mulitResultType==eFightMulitResultType.ResultTimes
if headArgs.showWinTimes~=nil then
showWinTimes=headArgs.showWinTimes
end
local leftId=battle:getLeftActorId()
local rightId=battle:getRightActorId()
local winArgs={player1[1],player1[2],player2[1],player2[2],battle=battle,showWinTimes=showWinTimes}
winArgs.leftId=leftId
winArgs.rightId=rightId
winArgs.hideFlag=headArgs.hideFlag
self:showWindow('UIDouFaTaiPlayBackWin',winArgs)
elseif handle.onFightTopHeadBattleEx then
local winArgs=handle.onFightTopHeadBattleEx(battle)
self:showWindow(winArgs[1],winArgs[2])
end
else
error("请在fightBattleHandle添加类型")
end
end
end




function UIFullFightControl:hideFightMain(battle)

UIFullFightControl:closeWindow("UIFightMainTop")
local entitise=battle:getEntities()
for i,ent in pairs(entitise)do
ent:showHuD(false)
end
end


function UIFullFightControl:reshowFightMain(battle)
UIFullFightControl:showWindow("UIFightMainTop",battle)
local entitise=battle:getEntities()
for i,ent in pairs(entitise)do
if ent.guid>0 then
ent:showHuD(true)
end
end
end
