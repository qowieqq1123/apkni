







UIFullFightPrepareControl=gameState.addListener(fullScreenUI.create())

local _prepareTypeWin={
[1]='UIFightPrepareWin',
[2]='UIFightPrepareTwoWin',
}

function UIFullFightPrepareControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eFightPrepare,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullFightPrepareControl:onLoadFinish()

end

function UIFullFightPrepareControl:showPrepareWindow(winArgs,afterLoading)
winArgs.isFullOpen=true
local prepareType=winArgs.prepareType or 1
local prepareWinName=_prepareTypeWin[prepareType]

local mapId=nil
if winArgs.mapId then
mapId=winArgs.mapId
else
if winArgs.groupId then
mapId=cfgHelper.get2(cfg_monstergroup_get,winArgs.groupId,"mapId")
end
local fightType=winArgs.fightType
if fightType==eFightPreSelectType.doufatai or fightType==eFightPreSelectType.lundaodahui or fightType==eFightPreSelectType.doufataidefense then
mapId=818001
end
winArgs.mapId=mapId or 0
end

local startCallback=function()
winArgs.selectStage=fightController:showSelectStage(nil,mapId,nil,function()
local args=
{
showBg=false,

viewNames={prepareWinName},
viewArgs={[prepareWinName]=winArgs},
}

self:showUI(args)

if afterLoading then
afterLoading()
end

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end)
end

UIFullFightPrepareControl:showWindow("UIFightPrepareLoading",{
startCallback=startCallback
})
end


function UIFullFightPrepareControl:showPrepareWindowEx(winArgs,afterLoading)
winArgs.isFullOpen=true
local prepareType=winArgs.prepareType or 1
local prepareWinName=_prepareTypeWin[prepareType]

local mapId=nil
if winArgs.mapId then
mapId=winArgs.mapId
else
if winArgs.groupId then
mapId=cfgHelper.get2(cfg_monstergroup_get,winArgs.groupId,"mapId")
end
local fightType=winArgs.fightType
if fightType==eFightPreSelectType.doufatai or fightType==eFightPreSelectType.lundaodahui or fightType==eFightPreSelectType.doufataidefense then
mapId=818001
end
winArgs.mapId=mapId or 0
end

local startCallback=function()
winArgs.selectStage=fightController:showSelectStage(nil,mapId,nil,function()
local args=
{
showBg=false,

viewNames={prepareWinName,},
viewArgs={[prepareWinName]=winArgs},
}

self:showUI(args)

if afterLoading then
afterLoading()
end

loadingControl.closeCloud()
end)
end
loadingControl.openCloud(startCallback)
end

function UIFullFightPrepareControl:showPrepareWindowWithoutStage(winArgs,stage)
winArgs.isFullOpen=true
winArgs.selectStage=stage
local prepareType=winArgs.prepareType or 1
local prepareWinName=_prepareTypeWin[prepareType]
local args=
{
showBg=false,
viewNames={prepareWinName,},
viewArgs={[prepareWinName]=winArgs},
}
self:showUI(args)
end

function UIFullFightPrepareControl:showAdverseSquadWindow(winArgs,afterLoading)
winArgs.isFullOpen=true
local mapId=nil
if winArgs.groupId then
mapId=cfgHelper.get2(cfg_monstergroup_get,winArgs.groupId,"mapId")
end
local fightType=winArgs.fightType
if fightType==fightPreSelectModel.fightType.doufatai then
mapId=818001
end

local startCallback=function()
winArgs.selectStage=fightController:showSelectStage(nil,mapId,nil,function()
local args=
{
showBg=false,

viewNames={'UIFightAdverseSquadWin'},
viewArgs={['UIFightAdverseSquadWin']=winArgs},
}
self:showUI(args)

if afterLoading then
afterLoading()
end

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end)
end

UIFullFightPrepareControl:showWindow("UIFightPrepareLoading",{
startCallback=startCallback
})
end

function UIFullFightPrepareControl:showShiLianTaWindow(winArgs)
winArgs.isFullOpen=true
local args=
{
showBg=false,
viewNames={'UIShiLianTaEnterWin','UIShiLianTaEffectWin'},
viewArgs={['UIShiLianTaEnterWin']=winArgs},
}
self:showUI(args)
end

function UIFullFightPrepareControl:setTopMask(active)
UIManager:invokeUIMethod("UIFightPrepareWin","setTopMask",active)
UIManager:invokeUIMethod("UIFightPrepareTwoWin","setTopMask",active)
end


function UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx(winArgs,afterLoading)
winArgs=winArgs or{}
winArgs.enterTxt="云舟布阵"

winArgs.isFullOpen=true

local mapId=nil
if winArgs.mapId then
mapId=winArgs.mapId
else
if winArgs.groupId then
mapId=cfgHelper.get2(cfg_monstergroup_get,winArgs.groupId,"mapId")
end

end

local startCallback=function()




local args=
{
showBg=false,
showTopMask=true,
viewNames={'UIXianJie_YunZhouPrepareWin'},
viewArgs={['UIXianJie_YunZhouPrepareWin']=winArgs},
}
self:showUI(args)
if afterLoading then
afterLoading()
end
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end

UIFullFightPrepareControl:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end
