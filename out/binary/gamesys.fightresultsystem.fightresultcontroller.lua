






local _MODULENAME="fightResultController"




gameState.addListener(def_table(_MODULENAME))
fightResultController.name=_MODULENAME


fightResultController.data={}

local _callback=nil
local _story=nil
local _this=fightResultController








local _disciple_result={
{
eType=eDiscipleChangeType.eGongFaLvUp,
winName="UIDiscipleGongFaResultWin",
},
}


function fightResultController:onAppStart()

fightResultModel:onAppStart()









end


function fightResultController:onEnterState()
fightResultModel:onEnterState()

notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
end


function fightResultController:onServerDataInitFinish()
fightResultModel:onServerDataInitFinish()
end


function fightResultController:onLeaveState(isReconnet)
if not isReconnet then
fightResultModel:onLeaveState()
end

self.data={}

notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:removelistener(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
end


function fightResultController:onLostConnection()

end

















function fightResultController.onShowPrize(prizeType,prizelist,effectData)
if fightResultModel:checkPrizeContain(prizeType)then

if prizeType==ePrizeType.eZMMonster then


for i=1,effectData.itemLen do
zongmenModel:removeSundriseData(effectData.sf_id,effectData.rand_item_guids[i])
sundriseCreateControl:removeData(effectData.rand_item_guids[i])
local data=isometricMapSystem:getSundriesDataByServerGuid(effectData.rand_item_guids[i])
if data then
if data.type~=sundriseType.eStillEnemy and data.type~=sundriseType.eMovementEnemy then

return
end
end
end
if effectData.auto_clear==1 then
return
end
elseif prizeType==ePrizeType.eMonsterInvade then
if effectData.auto_clear==1 then
return
end
end
fightResultModel:pushReward(prizeType,prizelist)
end
end

function fightResultController.onShowDiscipleChanged(prizeType,data)
if fightResultModel:checkPrizeContain(prizeType)then

fightResultModel:pushAttribute(prizeType,data)
end
end

function fightResultController:showResult(handle,battleId,battleType,btnsInfo,extraWinArgs,fightData,logPackage,param)

extraWinArgs.battleType=battleType
extraWinArgs.battleId=battleId
local winArgs={
callback=function()
fightResultController:afterShowResult()
end,
extraWin=handle.extraWin,
extraParams=extraWinArgs,
btnsInfo=btnsInfo,
fightData=fightData,
logPackage=logPackage,
param=param,
argtableEx=handle.argtableEx
}











local winName=handle.baseWin
UIFullFightControl:showWindow(winName,winArgs)
end

function fightResultController:reShowResult()
local record=fightResultModel:getRecord()
if record~=nil then
fightResultController:showResult(record.handle,record.battleId,record.battleType,record.btnsInfo,record.extraWinArgs,record.fightData,record.logPackage,record.param)


end
end

function fightResultController:showDiscipleChange(winName,datas,list,next)

local args={
datas=datas,
callback=function()
fightResultController:doDiscipleChange(list,next)
end,
}
UIManager:showWindow(winName,args)

end





function fightResultController:startResult(args)
local resultType,battleType,result,battleId,logPackage,callback,param,showWindow,stageCfg=
args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9]
loggerUtil.log(FMT.fmt("startResult {0}",battleId))
local isStory=false
if showWindow then
local story=stageCfg and stageCfg.afterstorytreeid
isStory=story~=nil
if isStory then
_callback=function()
local cb=function()
local loadingTime=1
UIManager:showWindow("UIFightPrepareLoading",{para=loadingTime})
timeEventController.delayDo(0.5,function()
if callback then callback()end
end)
end
worldStoryController:showStoryTree(story,cb,true)
end
else
_callback=callback
end
end
if resultType then
local handle=fightResultController:getResultHandle(resultType,result)
if handle then
local fightData
if battleId then
fightData=fightResultModel:calculateFightData(battleId)
end
local btnsInfo=handle.btnsInfo and
handle:btnsInfo(battleId,param)or nil
local extraWinArgs=handle.extraWinArgs and
handle:extraWinArgs(battleId,logPackage.prizeList,param,fightData)or{}

extraWinArgs.resultType=resultType

local mustShow=handle.checkShowSpeFunc~=nil and handle.checkShowSpeFunc(handle,battleId,battleType,btnsInfo,extraWinArgs,fightData,logPackage,param,showWindow)

if showWindow then
fightResultModel:makeRecord(handle,battleId,btnsInfo,extraWinArgs,logPackage,battleType,fightData,param)

fightResultController:showResult(handle,battleId,battleType,btnsInfo,extraWinArgs,fightData,logPackage,param)
end
if showWindow and isStory and battleId then
local battle=fightModel:getBattle(battleId)
battle:hideAllEntity()
end
return
end
end
fightResultModel:makeRecord(nil,nil,nil,nil,logPackage,battleType,nil,nil)
fightResultController:afterShowResult()
end


function fightResultController:endResult(battleId)
if _callback then _callback(battleId)end
end


function fightResultController:getResultHandle(resultType,result)
local resultHandle=fightResultConfig:getResultConfig(resultType)
if resultHandle then
local resultParam=resultHandle[result]
if not resultParam and result==fightResultType.Tie then
resultParam=resultHandle[fightResultType.Lose]
end
if resultParam then
return resultParam
end
end
logErr(FMT.fmt("没有类型{0}，结果{1}的结算处理",resultType,result))
end


function fightResultController:afterShowResult()
local record=fightResultModel:getRecord()

local logPackage=record.logPackage
local attrList=logPackage.attrList
local battleId=record.battleId
fightResultModel:clearRecord()
self:doDiscipleChange(attrList,1,battleId)
end

function fightResultController:doDiscipleChange(list,index,battleId)
local result=_disciple_result[index]
if result then
if list and next(list)then
local datas=list[result.eType]
self:showDiscipleChange(result.winName,datas,list,index+1)
return
end
end
self:afterShowDiscipleChange(battleId)
end


function fightResultController:afterShowDiscipleChange(battleId)
self:endResult(battleId)
end

function fightResultController:getMultiResult(multiResultType,resultList)
local result=fightResultType.Victory
local winCount=0
local loseCount=0
local tieCount=0
for i,result in ipairs(resultList)do
if result==fightResultType.Victory then
winCount=winCount+1
elseif result==fightResultType.Lose then
loseCount=loseCount+1
elseif result==fightResultType.Tie then
tieCount=tieCount+1
end
end

if multiResultType==eFightMulitResultType.ResultTimes then
if winCount==loseCount then
result=fightResultType.Tie
elseif winCount>loseCount then
result=fightResultType.Victory
else
result=fightResultType.Lose
end
else
if loseCount>=1 then
result=fightResultType.Lose
else
if winCount==0 and tieCount>0 then
result=fightResultType.Tie
end
end
end
return result
end
