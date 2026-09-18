







UIFullJiuYouTaControl=gameState.addListener(fullScreenUI.create())



function UIFullJiuYouTaControl:onAppStart()
local args={
stage=true,
fullType=FULL_TYPE.eJiuYouTa,
}
self:initUI(args)
end


function UIFullJiuYouTaControl:showFullJiuYouTaWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eJiuYouTa
local args={
tabType=tabType,
showBg=false,
showFg=false,
viewNames={'UIJiuYouTaEnterWin'},
viewArgs={['UIJiuYouTaEnterWin']=argstable},
}
if argstable.subwin then
table.insert(args.viewNames,argstable.subwin)
args.viewArgs[argstable.subwin]=argstable
end
UIFullJiuYouTaControl.fightStage=argstable.fightStage
JiuYouTaModel:set_first_reddot()
self:showUI(args)
end

function UIFullJiuYouTaControl:showJiuYouTaWindow(winArgs,layer,afterOpenCB)

local lArgs=
{
[1]=layer or JiuYouTaModel:getCurLayer(),
}

winArgs=winArgs or lArgs
local mapId=nil
local curLayer=winArgs[1]or JiuYouTaModel:getCurLayer()

local monsterList=JiuYouTaModel.getLayerMonsterGroupList(curLayer)
local groupID
if monsterList then
mapId=cfgHelper.get2(cfg_monstergroup_get,monsterList[1],"mapId")
groupID=monsterList[1]
end

winArgs.groupId=groupID

isometricMapSystem:enterBattleMode()
local onLoadCallback=function()

fightManager.initCamera(Vector3.New(0,1,2.5),Vector3.New(0,1.85,0),Vector3.New(0,-2,5),Vector3.New(0,0,0),15)

UIManager:hideWindow("UITaskListWin")

UIFullJiuYouTaControl:showFullJiuYouTaWindow(winArgs)

if afterOpenCB then
afterOpenCB()
end
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")

end

local startCallback=function()
winArgs.selectStage=fightController:showSelectStage(nil,mapId,{},onLoadCallback,false)
end

if JiuYouTaModel.data.selectStage then
startCallback()
else
UIFullFightPrepareControl:showWindow("UIFightPrepareLoading",{
startCallback=startCallback
})
end
end

function UIFullJiuYouTaControl:showEnterWindow(layer,afterOpenCB)
local battleId=JiuYouTaModel:getPlayingBattle()
if battleId and fightController:isBattlePlaying(battleId)then
fightController:openBattle(battleId)
isometricMapSystem:enterBattleMode()
UIFullFightControl:showWindow("UIShiLianTaFightTop")
else
UIFullJiuYouTaControl:showJiuYouTaWindow(nil,layer,afterOpenCB)
end
end