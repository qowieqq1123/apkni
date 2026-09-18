




def_class("fightBattle",{})

local stopEffect=CS.GameInterface.StopEffect


local roundDefaultTime=10





function fightBattle:__init(fightStrList,id,onComplete,onClose,useReportMapId)
fightActionMrg:init()



self.fightIndex=1
if type(fightStrList)=="table"then
self.fightType=eFightType.eMulti
self.fightReportStrList=fightStrList
self.fightReportStr=self.fightReportStrList[self.fightIndex]
else
self.fightType=eFightType.eSingle
self.fightReportStrList={fightStrList}
self.fightReportStr=fightStrList
end

self.id=id

self.onCompleteCall=onComplete
self.onCloseCall=onClose
self.useReportMapId=useReportMapId

self.leftWinTimes=0
self.rightWinTimes=0
self.isBeginNextBattle=nil
self.isRestart=nil
self.repeatPlayRound=false
self.hideStartWin=false
self.entHideHud=false
self.enterDelayTimeDaZhen=0
self.roundDefaultTime=roundDefaultTime
self.isJzTrans=nil
if id~=0 then
self.preSelectEntity=fightModel:getPreSelectEntity()
fightModel:setPreSelectEntity(nil)
end

self.isLog=id==0

fightManager.preLoadEffect({10334},{},nil)

self.statisticsEntInfo={}
self.statisticsEntSkillDemage={}
self.statisticsEntSkillHeal={}
self.statisticsEntSkillShield={}
self.statisticBuffInfo={}
self.statisticEntSkillBuff={}


self.rcHPList={}

self:init()
end

function fightBattle:init()
self.fightInfo=fightModel:getJsonReport(self.fightReportStr)
self.stageInfo=self.fightInfo[fightReportTag.stage]

self.openTime=0
self.accLimit=2



if self.isLog then
self:initNormal()
else
local jzBattle=self:initJunZhen()
if jzBattle then
self.fightMode=fightPlayModeType.eJunZhen
else
self:initNormal()
end
end
end


function fightBattle:initNormal(jzAfterAttr,jzEnter)


local stageCfg
if not jzEnter then
stageCfg=fightModel:getStage(self.stageInfo[stageInfoTag.mapID])
if stageCfg==nil then
stageCfg=fightModel:getStage(fightStage.defStageID)
end
self.stageCfg=stageCfg
else
stageCfg=self.stageCfg
end
self.stage=stageCfg.assetbundle
self.stageBgm=stageCfg.bgMusic
self.witnessInfo=stageCfg.witness

local customData=self.stageInfo[stageInfoTag.customInfo]
self:initStageCustomInfo(customData)


if customData~=nil then
self.isPlotMode=true
self.accMulti=0
else
self.accMulti=userActorSetting.get("AccMulti",0)
end

self.fightMode=fightPlayModeType.eNormal
self.buffWaitTime=0

self.result=self.fightInfo[fightReportTag.result]
self.exchangeResult=false


local leftEntities=self.fightInfo[fightReportTag.attack]
local rightEntities=self.fightInfo[fightReportTag.defend]


local leftActorId=self.stageInfo[stageInfoTag.leftActorId]
if leftActorId then
self.leftActorId=type(leftActorId)=="string"and int64.new(leftActorId)or leftActorId
end
local rightActorId=self.stageInfo[stageInfoTag.rightActorId]
if rightActorId then
self.rightActorId=type(rightActorId)=="string"and int64.new(rightActorId)or rightActorId
end

self.fightSceneTypo=fightSceneTypo.enter
if self.preSelectEntity==nil then
self.fightSceneTypo=fightSceneTypo.fight
end
self.leftPosType=self.stageInfo[stageInfoTag.leftTypo]
self.rightPosType=self.stageInfo[stageInfoTag.rightTypo]

self.leftZhenFaId=self.stageInfo[stageInfoTag.leftZhenFaId]
self.rightZhenFaId=self.stageInfo[stageInfoTag.rightZhenFaId]


self.maxRound=self.stageInfo[stageInfoTag.maxRound]or cfgHelper.get3(cfg_globalconfig_get,1,'fightcycnum',0)

local yuanjun=self.fightInfo[fightReportTag.yuanjun]

self.leftTeamShieldVal=yuanjun[3]~=nil and yuanjun[3][1]or 0
self.rightTeamShieldVal=yuanjun[4]~=nil and yuanjun[4][1]or 0
self.leftTeamShieldMax=yuanjun[3]~=nil and yuanjun[3][2]or 0
self.rightTeamShieldMax=yuanjun[4]~=nil and yuanjun[4][2]or 0
self.leftTeamShieldLv=yuanjun[3]~=nil and yuanjun[3][3]or 1
self.rightTeamShieldLv=yuanjun[4]~=nil and yuanjun[4][3]or 1
self.enterDelayTimeDaZhen=0

self.jzAfterAttr=jzAfterAttr

self:initEntity(self.leftPosType,leftEntities,self.rightPosType,rightEntities,self.leftEnterBt,self.rightEnterBt)

self.openTime=gameUtilityModel.getPassTime()

self.buffInfo={}
self.effectHandleList={}
self.roundData=self.fightInfo[fightReportTag.round]

self.leftTotalYuanJun=yuanjun[1]
self.leftCurUseYuanJun=0
self.rightTotalYuanJun=yuanjun[2]
self.rightCurUseYuanJun=0

self.roundIndex=0
self.totalRound=#self.roundData
self.roundObj=fightRound(self)
self.isPlotMode=nil

if self.updateTimer~=nil then
self.updateTimer:cancel()
end
self.updateTimer=nil

self.isShowWindow=false
self.isDelayOver=false
self.isOver=false

self.isSkipMode=false



self.witnessBehaviorList={}

self.newEntInfo={}


self.statisticsEntInfo[self.fightIndex]={}
self.statisticsEntSkillDemage[self.fightIndex]={}
self.statisticsEntSkillHeal[self.fightIndex]={}
self.statisticsEntSkillShield[self.fightIndex]={}
self.statisticBuffInfo[self.fightIndex]={}
self.statisticEntSkillBuff[self.fightIndex]={}

self.changeEntDataList={}

self.addBuffIndex=0


self:initSceneEffect()

self:genStatistics()
end


function fightBattle:getStageCfg()
return self.stageCfg
end

function fightBattle:getLeftActorId()
return self.leftActorId
end

function fightBattle:getRightActorId()
return self.rightActorId
end

function fightBattle:playNextBattle(skip)
self:saveStatistics(self.fightIndex)
self.fightIndex=self.fightIndex+1
local fightReportStr=self.fightReportStrList[self.fightIndex]
self:setAccMulti(0,false)
if fightReportStr then
self.fightReportStr=fightReportStr
local showStage=self.isShowStage
local delayTime=0.5
local enterAni=true
local result=self.fightInfo[fightReportTag.result]
if showStage and self.isShowWindow then
if not self.isOver then
fightManager.setCameraActive(true,fightCameraMode.fight)
for i,ent in pairs(self.entities)do
if i>=1 and i<=5 then
if skip and not self.playmoveAni and result~=fightResultType.Victory then
ent:fadeToColor(Color.clear,0.2)
else
if self.rightEntType and self.rightEntType==0 then
ent:runBehavior("nextFightEntityMove")
else
ent:runBehavior("nextFightEntityMovePVE")
end
end
elseif i>=6 and i<=10 then
if skip and not self.playmoveAni and result~=fightResultType.Victory then
ent:fadeToColor(Color.clear,0.2)
else
if ent:getType()==fightEntityType.diZi then
ent:runBehavior("nextFightEntityMoveR")
else
ent:fadeToColor(Color.clear,0.2)
end
end
elseif i>=51 and i<=52 then
ent:remove()
end
end
local loadingTime=1

timeEventController.delayDo(1,function()
self:removeAllEntity()
end,false)
timeEventController.delayDo(2,function()
if not self.isOver then
self:init()
fightManager.setState(fightSceneTypo.fight)
UIFullFightControl:showFightMain(self)
UIManager:closeWindow("UIFightSkillInfo")
delayTime=self:showStage(enterAni,false)+loadingTime
self:startTimer(delayTime+self.enterDelayTime+self.enterDelayTimeDaZhen)
self.isBeginNextBattle=nil
end
end,false)
else
self:removeAllEntity()
return false
end
else

self:removeAllEntity()
self:init()
self:enterBack()
self.isBeginNextBattle=nil
end

return true
end
end

function fightBattle:onSkipAll()
for i,v in ipairs(self.fightReportStrList)do
self:onComplete(true)
end
end

function fightBattle:restart()

self:saveStatistics(self.fightIndex)
self.fightIndex=self.fightIndex+1
local fightReportStr=self.fightReportStrList[self.fightIndex]
self:setAccMulti(0,false)
if fightReportStr then
local delayTime=0.5
self.fightReportStr=fightReportStr
fightManager.setCameraActive(true,fightCameraMode.fight)
self:removeAllEntity()
self:init()
self.isRestart=true

self:stopTransJZSceneTimer()

if self.fightMode==fightPlayModeType.eJunZhen then
self:showStageBase()
end

fightManager.setState(fightSceneTypo.fight)
UIFullFightControl:showFightMain(self)
UIManager:callWindowFunc("UIFightMainTop","restart")
UIManager:closeWindow("UIFightSkillInfo")
delayTime=self:showStage(true,false)

self.isOver=false
if self.updateTimer~=nil then
self.updateTimer:cancel()
self.updateTimer=nil
end
self:startTimer(delayTime+self.enterDelayTime+self.enterDelayTimeDaZhen)
self.isBeginNextBattle=nil
end
end


function fightBattle:getfightIndex()
return self.fightIndex or 1
end

function fightBattle:getfightMaxTimes()
return#self.fightReportStrList
end

function fightBattle:getfightLeftWinTimes()
return self.leftWinTimes or 0
end

function fightBattle:getfightRightWinTimes()
return self.rightWinTimes or 0
end

function fightBattle:setSendExtraArgs(sendExtraArgs)

self.sendExtraArgs=sendExtraArgs
end

function fightBattle:getSendExtraArgs()
return self.sendExtraArgs
end


function fightBattle:initStageCustomInfo(data)
if data==nil then

self.leftPosOffset=Vector3.zero
self.rightPosOffset=Vector3.zero
self.showFightStartFlag=true
self.leftEnterBt=nil
self.rightEnterBt=nil
self.enterDelayTime=0
else
local leftOffset=data[stageCustomInfoTag.leftPosOffset]
if leftOffset~=nil then
self.leftPosOffset=Vector3.New(leftOffset[1],leftOffset[2],leftOffset[3])
else
self.leftPosOffset=Vector3.zero
end

local rightOffset=data[stageCustomInfoTag.rightPosOffset]
if rightOffset~=nil then
self.rightPosOffset=Vector3.New(rightOffset[1],rightOffset[2],rightOffset[3])
else
self.rightPosOffset=Vector3.zero
end
local showEffect=data[stageCustomInfoTag.showStartEffect]
if(showEffect==nil or showEffect)then
self.showFightStartFlag=true
else
self.showFightStartFlag=false
end

local leftEnterBT=data[stageCustomInfoTag.leftEnterBT]
if leftEnterBT and leftEnterBT~=""then
self.leftEnterBt=leftEnterBT
else
self.leftEnterBt=nil
end
local rightEnterBT=data[stageCustomInfoTag.rightEnterBT]

if rightEnterBT and rightEnterBT~=""then
self.rightEnterBt=rightEnterBT
else
self.rightEnterBt=nil
end
self.enterDelayTime=data[stageCustomInfoTag.enterBTTime]or 0

end

end


function fightBattle:start(showStage,enterAni,resetCamera,continue)
local delayTime=0.5
self.isShowStage=showStage
local story=self.stageCfg.storytreeid
local plotBoard=self.stageCfg.plotboardid
local isexid=SiFangPingYaoModel:getplotBoardChange()
if isexid and isexid~=0 then
plotBoard=isexid
end
SiFangPingYaoModel:setywbattle(false)
if(not story)and(not plotBoard)then
self.isSkipStory=true
end
if continue then
self.isSkipStory=true
end
if self.isSkipStory or not showStage then
if showStage then
self:showStageBase()
if not self.repeatPlayRound then
UIFullFightControl:showFightMain(self)
end
delayTime=self:showStage(enterAni,resetCamera)
end
if self.repeatPlayRound then
delayTime=0
end

self:insertWitnessBehavior(eFightWitnessEventType.enter)

if showStage then
self:startTimer(delayTime+self.enterDelayTime+self.enterDelayTimeDaZhen)
else
self:enterBack()
end
else
if plotBoard then
self:showStageBase()
if not self.repeatPlayRound then
UIFullFightControl:showFightMain(self)
end
delayTime=self:showStage(enterAni,resetCamera)
local call=function()
self:showAllEntityHUD()
if showStage then
self:startTimer(delayTime+self.enterDelayTime+self.enterDelayTimeDaZhen)
else
self:enterBack()
end
self:insertWitnessBehavior(eFightWitnessEventType.enter)
end

local args={groupid=plotBoard,callback=call,isFullOpen=false}
gameplotController:showPlotBoard(args)
else
self:hideAllEntity()
local cb=function()
local loadingTime=1
UIManager:showWindow("UIFightPrepareLoading",{para=loadingTime})
timeEventController.delayDo(0.5,function()
fightManager.loadStage(self.stage)
fightManager.resetCameraEx(self.stageCfg)
fightManager.initCameraEffect(self.stageCfg)
fightManager.playSceneEffect(self.stageCfg)
fightManager.setState(fightSceneTypo.fight)
UIFullFightControl:showFightMain(self)
delayTime=self:showStage(enterAni)+loadingTime
self:startTimer(delayTime+self.enterDelayTime+self.enterDelayTimeDaZhen)
self:insertWitnessBehavior(eFightWitnessEventType.enter)
end)
end
worldStoryController:showStoryTree(story,cb,true)
end
end
self.isSkipStory=true
end



function fightBattle:showStageBase()


self:hideAllEntity()
fightManager.loadStage(self.stage,function()
fightManager.resetCameraEx(self.stageCfg)
fightManager.initCameraEffect(self.stageCfg)
fightManager.playSceneEffect(self.stageCfg)
fightManager.setState(fightSceneTypo.fight)

notifySystem:postNotify(notifyConfig.onBattleStageLoad,self.id)
buildlightController:setBLState(false)
end)


end


function fightBattle:showStage(enterAni,resetCamera)
local delayTime=1
self.isShowWindow=true
if resetCamera==nil then
resetCamera=true
end
if self.exchangeHp then
if self.rightActorId and tostring(tonumber(tostring(self.rightActorId)))==tostring(tonumber(tostring(playerModel:getActorID())))then
self.teamHpType=fightEntityHPType.right
self.exchangeResult=true
end
end

if self.fightMode==fightPlayModeType.eJunZhen then
self:showAllJZEntity()
else
self:showAllEntity(enterAni,self.enterDelayTime)
end


fightManager.setSelectMask({})

if self.fightSceneTypo==fightSceneTypo.enter then
delayTime=2
end

if self.leftZhenFaId~=nil then
self.leftZhenFa=self.setZhenFaEffect(self.leftZhenFaId,true)
end

if self.rightZhenFaId~=nil then
self.rightZhenFa=self.setZhenFaEffect(self.rightZhenFaId,false)
end
if resetCamera then
if self:hasAssistant()then
fightManager.setCameraActive(true,fightCameraMode.assistFight)
else
fightManager.setCameraActive(true,fightCameraMode.fight)
end
end

if self.stageBgm and self.stageBgm~=0 and self.stageBgm~=self.playingStageBgmId then
self.beforeBgm=AudioManager.getCurrentBgm()or self.beforeBgm
AudioManager.setGroupMute(SOUND_GROUP_TYPE.scene3d,false)
sceneAudioModel:setAudioShieldState(true)
self.stageBgmHandleId=AudioManager.playBgMusic(self.stageBgm)
if self.stageBgmHandleId and self.stageBgmHandleId~=-1 then
self.playingStageBgmId=self.stageBgm
end
end

if enterAni then
delayTime=delayTime+2
end

self:setAccMulti(self.accMulti,false)

self:exitBack()

if xianjieModel:isInitScene()then
xianjieController:activeXianJieHud(false)
end

return delayTime
end


function fightBattle:startTimer(delayTime)
if self.updateTimer==nil and not self.isOver then
local updateFunc=function()
local deltaTime=Time.deltaTime
if not self.isShowWindow then
deltaTime=deltaTime*(self.accMulti+1)
end
self:update(deltaTime)
end

self.updateTimer=timer.new()
self.updateTimer:start(0,updateFunc)



local delayStart=function()

self.delayStartTimer=nil
self:setAccMulti(self.accMulti,false)
self:onStart()

if self.fightMode==fightPlayModeType.eJunZhen then
self:playJunZhenNextRound()
else
self:playNextRound()
end
end

local showStartEffect=function()
if self.isShowWindow and not self.hideStartWin then
local times
if self.fightType==eFightType.eMulti then
times=self.fightIndex
end
UIManager:showWindow("UIFightEffect",{para=10067,fightTimes=times})
end
self.delayStartTimer=timer.new()
self.delayStartTimer:start(2,delayStart,1)
end






if self.showFightStartFlag and not self.repeatPlayRound then
delayTime=delayTime-2
if delayTime>0 then
if self.delayStartTimer==nil then
self.delayStartTimer=timer.new()
self.delayStartTimer:start(delayTime,showStartEffect,1)
end
else
showStartEffect()
end
else
self.delayStartTimer=timer.new()
self.delayStartTimer:start(delayTime,delayStart,1)
end
end
end

function fightBattle:onPause()
if not self.isOver then
if self.updateTimer~=nil then
self.updateTimer:pause()
end
end
end

function fightBattle:onContinue()
if not self.isOver then
if self.updateTimer~=nil then
self.updateTimer:continue()
else
self:startTimer(0)
end
end
end

function fightBattle:enterBack()
local remainRound=self.totalRound-self.roundIndex

if remainRound<=0 then
remainRound=1
end
self:onPause()
if self.backTimer==nil then
self.backTimer=timer.new()
local overFunc=function()
if not self.isOver and not self.isShowWindow then
self:skipProcess()
self.backTimer:cancel()
self.backTimer=nil
end
end
self.backTimer:start(self.roundDefaultTime*remainRound,overFunc)
end
end


function fightBattle:exitBack()
if self.backTimer~=nil then
self.backTimer:cancel()
self.backTimer=nil
self:onContinue()
end

end

function fightBattle:hideStage(clearStage,isOpenCurBattle)
fightManager.stageFadeToColor(0,Color.New(1,1,1,1))
fightManager.resetDotLight(0)
clearStage=clearStage==nil and true or clearStage
self.isShowWindow=false
self:hideAllEntity()
UIFullFightControl:hideFightMain(self)
if clearStage then
fightManager.clearStage()
end


notifySystem:postNotify(notifyConfig.onBattleStageClose,self.id)

fightManager.setCameraActive(false,fightCameraMode.fight)

if not fightModel:getBattleAccBan()then
Time.timeScale=1
end

if self.leftZhenFa then
stopEffect(self.leftZhenFa)
self.leftZhenFa=nil
end

if self.rightZhenFa then
stopEffect(self.rightZhenFa)
self.rightZhenFa=nil
end

if not isOpenCurBattle then

if self.beforeBgm then
AudioManager.playBgMusic(self.beforeBgm)
self.stageBgmHandleId=nil
self.playingStageBgmId=nil
elseif self.stageBgm and self.stageBgm~=0 then
AudioManager.stopBGMusic()
end
AudioManager.setGroupMute(SOUND_GROUP_TYPE.scene3d,true)
sceneAudioModel:setAudioShieldState(false)
end
end


function fightBattle:resumeMusic()
if self.beforeBgm then
AudioManager.playBgMusic(self.beforeBgm)
self.stageBgmHandleId=nil
self.playingStageBgmId=nil
elseif self.stageBgm and self.stageBgm~=0 then
AudioManager.stopBGMusic()
end
end

function fightBattle:closeMainUI(clearStage)
UIFullFightControl:closeUI(clearStage)
end


function fightBattle:close(closeMain)
if not self.isShowWindow then
return
end

if self:isTransJZSceneTimerPlaying()then
return
end

if buildlightModel:isChangeOpenBL_fightBattle()then
buildlightController:setBLState(true)
end

if closeMain==nil then
closeMain=true
end
if self.isShowWindow then
self:hideStage()

if closeMain then
self:closeMainUI()
end
end
if self.onCloseCall~=nil then
self.onCloseCall(self.id)
notifySystem:postNotify(notifyConfig.onBattlePlayClose)
end
if self.isOver or self.fightMode==fightPlayModeType.eJunZhen then
fightModel:removeBattle(self.id)
if self.entities then
for i,ent in pairs(self.entities)do
ent:remove()
end
end

self.entities=nil
self.fightReportStr=nil
self.fightReportStrList=nil

fightManager.releaseDynamicAtlas()
else
self:enterBack()
end

self:onCloseJunZhen()


self.isPlotMode=nil
self.isBeginNextBattle=nil
if deviceHelper.getAPILevel()>=14 then
fightManager.clearPreLoad()
end
end

function fightBattle:stopAllEffect()
if self.effectHandleList~=nil and next(self.effectHandleList)then
for i,v in pairs(self.effectHandleList)do
stopEffect(v)
end
end
end

function fightBattle:getPosInfoByTypo(typo,id)

local posInfo=fightModel:getPosInfoByTypo(typo,id)
local offsetPos={}
offsetPos.id=posInfo.id
offsetPos.left=posInfo.left

if posInfo.left then
offsetPos.pos=posInfo.pos+self.leftPosOffset
offsetPos.rowPos=posInfo.rowPos+self.leftPosOffset
else
offsetPos.pos=posInfo.pos+self.rightPosOffset
offsetPos.rowPos=posInfo.rowPos+self.rightPosOffset
end

return offsetPos
end




function fightBattle:initEntity(leftPosTypo,leftEntities,rightPosTypo,rightEntities,leftEnterBt,rightEnterBt)
local preSelectEntity=self.preSelectEntity or{}
self.entities={}
self.witnessEntities={}

local jzAfterAttr=self.jzAfterAttr or{}

for i,v in ipairs(leftEntities)do
local id=i
if v[fightEntityTag.typo]>=0 then
local ent=preSelectEntity[id]
if ent~=nil then
ent:init(self,leftPosTypo,id,fightModel:getEntityInfo(v,jzAfterAttr[id]),true)
else
ent=fightEntity(self,leftPosTypo,id,fightModel:getEntityInfo(v,jzAfterAttr[id]),true)
end
preSelectEntity[id]=nil
self.entities[i]=ent

ent:setEnterBehavior(leftEnterBt)


if v[fightEntityTag.assistant]then
id=id+stagePosWeight.assist
ent=preSelectEntity[id]
if ent~=nil then
ent:init(self,leftPosTypo,id,fightModel:getAssistantInfo(v[fightEntityTag.assistant]),nil,fightAssistantType.eLingShou)
else
ent=fightEntity(self,leftPosTypo,id,fightModel:getAssistantInfo(v[fightEntityTag.assistant]),nil,fightAssistantType.eLingShou)
end
preSelectEntity[id]=nil
self.entities[id]=ent

ent:setEnterBehavior(leftEnterBt)

end
end
end
self.rightEntType=nil
for i,v in ipairs(rightEntities)do
local id=i+5
if v[fightEntityTag.typo]>=0 then
local ent=preSelectEntity[id]
if ent~=nil then
ent:init(self,rightPosTypo,id,fightModel:getEntityInfo(v,jzAfterAttr[id]),true)
else
ent=fightEntity(self,rightPosTypo,id,fightModel:getEntityInfo(v,jzAfterAttr[id]),true)
end
preSelectEntity[id]=nil
self.entities[id]=ent
ent:setEnterBehavior(rightEnterBt)





if v[fightEntityTag.assistant]then
id=id+stagePosWeight.assist
ent=preSelectEntity[id]
if ent~=nil then
ent:init(self,rightPosTypo,id,fightModel:getAssistantInfo(v[fightEntityTag.assistant]),nil,fightAssistantType.eLingShou)
else
ent=fightEntity(self,rightPosTypo,id,fightModel:getAssistantInfo(v[fightEntityTag.assistant]),nil,fightAssistantType.eLingShou)
end
preSelectEntity[id]=nil
self.entities[id]=ent

ent:setEnterBehavior(rightEnterBt)
end

if not self.rightEntType then
self.rightEntType=v[fightEntityTag.typo]
end
end
end

if self.witnessInfo~=nil then
for i,v in ipairs(self.witnessInfo)do
local idList=v[1]
local entList={}
for _,id in ipairs(idList)do
local ent=preSelectEntity[id]
if ent~=nil then
ent:init(self,rightPosTypo,id,fightModel:createMonsterInfo(v[2],1,1))
else
ent=fightEntity(self,rightPosTypo,id,fightModel:createMonsterInfo(v[2],1,1))
end
preSelectEntity[id]=nil
ent.isNPC=true
self.entities[id]=ent
entList[id]=ent
ent:enableHUD(false)

end
local loopBh=cfgHelper.get(cfg_fightwitnessconfig_get,v[3],"loopBh")
local loopMinTime,loopMaxTime=nil,nil
if loopBh then
loopMinTime=loopBh[2]
loopMaxTime=loopBh[3]
end
self.witnessEntities[i]={entList=entList,eventId=v[3],loopMinTime=loopMinTime,loopMaxTime=loopMaxTime}



end
end



if self.leftTeamShieldVal>0 and self.leftTeamShieldMax>0 then
local id=51
local ent=preSelectEntity[id]
local sheildId=fightModel:getSheildId(self.leftTeamShieldLv)
if ent~=nil then
ent:init(self,leftPosTypo,id,fightModel:createShieldInfo(sheildId,self.leftTeamShieldVal,self.leftTeamShieldMax,self.leftTeamShieldLv),true)
else
ent=fightShield(self,leftPosTypo,id,fightModel:createShieldInfo(sheildId,self.leftTeamShieldVal,self.leftTeamShieldMax,self.leftTeamShieldLv),true)
end
ent.isNPC=true
self.entities[id]=ent
preSelectEntity[id]=nil
self.enterDelayTimeDaZhen=4.5
end


if self.rightTeamShieldVal>0 and self.rightTeamShieldMax>0 then
local id=52
local ent=preSelectEntity[id]
local sheildId=fightModel:getSheildId(self.rightTeamShieldLv)
if ent~=nil then
ent:init(self,leftPosTypo,id,fightModel:createShieldInfo(sheildId,self.rightTeamShieldVal,self.rightTeamShieldMax,self.rightTeamShieldLv),true)
else
ent=fightShield(self,leftPosTypo,id,fightModel:createShieldInfo(sheildId,self.rightTeamShieldVal,self.rightTeamShieldMax,self.rightTeamShieldLv),true)
end
ent.isNPC=true
self.entities[id]=ent
preSelectEntity[id]=nil
self.enterDelayTimeDaZhen=4.5
end

if self.preSelectEntity~=nil then
for i,v in pairs(self.preSelectEntity)do
v:remove()
end
self.preSelectEntity=nil
end
end

function fightBattle:getPosInfo(id)

end

function fightBattle:getEntities()
return self.entities
end

function fightBattle:getEntity(id)
return id and self.entities[id]
end

function fightBattle:isEntitySameTeam(id1,id2)
return(id1>=1 and id1<=5 and id2>=1 and id2<=5)or(id1>=6 and id1<=10 and id2>=6 and id2<=10)
end

function fightBattle:hasAssistant()
for id=stagePosWeight.assist+1,stagePosWeight.assist+10 do
if self.entities[id]then
return true
end
end
end


function fightBattle:addEntity(id,data,isFade,outEffectOpen)
local ent=self.entities[id]
if ent~=nil then
ent:remove()
end
local posType=self.leftPosType
if not fightModel:isLeft(id)then
posType=self.rightPosType
end
ent=fightEntity(self,posType,id,data,outEffectOpen)
if ent==nil then
logErr("fightBattle:addEntity xx",id)
else

end
self.entities[id]=ent
ent:show(isFade)
ent:showHuD(self.showHud)
return ent
end

function fightBattle:removeEntity(id)
local ent=self.entities[id]
if ent~=nil then
ent:remove()
end
self.entities[id]=nil
end

function fightBattle.setZhenFaEffect(zfId,isLeft)
local effectCfg=cfgHelper.get1(cfg_zhenfaconfig_get,zfId)
if effectCfg and effectCfg.effect then
local effectId=effectCfg.effect[1]
local effectOffect=effectCfg.effect[2]or{0,0,0}
local pos=Vector3.New(effectOffect[1],effectOffect[2],effectOffect[3])
local centerPos=fightModel:getcenterPos(isLeft)
pos=centerPos+pos
return fightManager.playEffect(effectId,pos,isLeft)
end
end



function fightBattle:showAllEntity(enterAni,delayShow)
for i,ent in pairs(self.entities)do
if ent:getAttribute(entityAttr.hp)>0 or fightModel:isAssist(i)then
ent:show()
if enterAni then
if i>=1 and i<=5 then
ent:runBehavior("fight_enter",{},function()
ent:showHuD(not self.entHideHud)
end)
elseif i>=6 and i<=10 then
ent:runBehavior("fight_right_enter",{},function()
ent:showHuD(not self.entHideHud)
end)
else
ent:showHuD(not self.entHideHud)
end
else
if delayShow>0 then
ent:showHuD(false)
else
ent:showHuD(not self.entHideHud)
end
end
else
ent:showHuD(false)
end
end
end

function fightBattle:showAllEntityHUD()
for i,ent in pairs(self.entities)do
if ent:getAttribute(entityAttr.hp)>0 or fightModel:isAssist(i)then
ent:showHuD(not self.entHideHud)
end
end
end


function fightBattle:hideAllEntity()
self.guidMap={}
if self.entities then
for i,ent in pairs(self.entities)do
ent:hide()
end
end

self:initSceneEffect()
end

function fightBattle:removeAllEntity()
self.guidMap={}
if self.entities then
for i,ent in pairs(self.entities)do
ent:remove()
end
end
self.entities={}

self:initSceneEffect()
end

function fightBattle:getTotalRound()
return self.totalRound
end

function fightBattle:getRoundIndexInfo()
return self.roundIndex,self.maxRound
end

function fightBattle:getBuffClientID()
self.addBuffIndex=self.addBuffIndex+1
return self.addBuffIndex

end

function fightBattle:onAddBuff(info)

self.buffInfo[info.guid]=info
end

function fightBattle:onRemoveBuff(info)
self.buffInfo[info.guid]=nil
end

function fightBattle:updateBuff()

self.buffWaitTime=0
for _,ent in pairs(self.entities)do
local t=ent:updateBuffRound(buffCheckType.roundEnd)
if t>self.buffWaitTime then
self.buffWaitTime=t
end
end
end

function fightBattle:logUpdateBuff(logFun)

self.buffWaitTime=0
for _,ent in pairs(self.entities)do
ent:logUpdateBuffRound(buffCheckType.roundEnd,logFun)
end
end

function fightBattle:getBuffInfo(guid)
return self.buffInfo[guid]
end

function fightBattle:onYuanJunChange(id)
if fightModel:isLeft(id)then
self.leftCurUseYuanJun=self.leftCurUseYuanJun+1
else
self.rightCurUseYuanJun=self.rightCurUseYuanJun+1
end

UIManager:invokeUIMethod("UIFightMainTop","flushYuanJunInfo")
end

function fightBattle:getYuanJunInfo()
return self.leftCurUseYuanJun,self.leftTotalYuanJun,self.rightCurUseYuanJun,self.rightTotalYuanJun
end

function fightBattle:getLeftTeamShield()
return self.leftTeamSheildVal
end

function fightBattle:getRightTeamShield()
return self.rightTeamShieldVal
end


function fightBattle:updateLeftTeamShield(val,nowVal)
self.leftTeamShieldVal=nowVal
local isDead=false
local ent=self:getEntity(51)
if ent then
isDead=ent:onRecvDamage(val,nowVal)
end









return isDead
end

function fightBattle:updateRightTeamShield(val,nowVal)
self.rightTeamShieldVal=nowVal
local isDead=false
local ent=self:getEntity(52)
if ent then
isDead=ent:onRecvDamage(val,nowVal)
end










return isDead
end



function fightBattle:getLeftTeamShieldMax()
return self.leftTeamShieldMax
end

function fightBattle:getRightTeamShieldMax()
return self.rightTeamShieldMax
end





function fightBattle:isPlaying()
return self.updateTimer~=nil or self.delayStartTimer~=nil or self:isTransJZSceneTimerPlaying()
end



function fightBattle:onStart()

end


function fightBattle:skipProcess()
if not self.isOver and self.delayStartTimer==nil and not self:isTransJZSceneTimerPlaying()then
if self.delayStartTimer~=nil then
self.delayStartTimer:cancel()
self.delayStartTimer=nil
end

self.isSkipMode=true
for i,ent in pairs(self.entities)do
ent:enterSkipMode()
end

if self.roundObj~=nil then
self.roundObj:stop()
end

if self.jzRoundObj~=nil then
self.jzRoundObj:stop()
end

for i,ent in pairs(self.entities)do
ent:leaveSkipMode()
end

if self.fightMode==fightPlayModeType.eJunZhen then
self:onCompleteJunZhenBattle(true)
else
self:onComplete(true)
end

end
end

function fightBattle:setBattlePause(isPause)
self.isPause=isPause
end

function fightBattle:isBattlePause()
return self.isPause
end

function fightBattle:update(deltaTime)
if self:isBattlePause()then
return
end
if self.delayPlayRound then
self.delayPlayRound=self.delayPlayRound+deltaTime
if self.roundIndex==0 and self.delayPlayRound>10*self.accMulti then
self.loadRoundCB()
else
self.loadRoundCB()
end
return
end

if self.buffWaitTime>0 then
self.buffWaitTime=self.buffWaitTime-deltaTime
else

if self.roundObj~=nil then
self.roundObj:update(deltaTime)
end

if self.jzRoundObj~=nil then
self.jzRoundObj:update(deltaTime)
end

if self.entities then
for i,v in pairs(self.entities)do
v:update(deltaTime)
end
end

self:updateWitnessBehavior(deltaTime)
end
end

function fightBattle:setAccLimit(accLimit)
self.accLimit=accLimit
if self.accMulti>self.accLimit then
self:setAccMulti(self.accLimit)
end
end


function fightBattle:addAccMulti()
local multi=self.accMulti
multi=multi+1
if multi>self.accLimit then
multi=0
end

self:setAccMulti(multi)
return multi
end

function fightBattle:getAccMulti()
return self.accMulti
end

function fightBattle:setAccMulti(multi,save)


if multi<=0 then multi=0 end

if fightModel:getBattleAccBan()then
return
end

self.accMulti=multi
if self.isShowWindow then
Time.timeScale=(self.accMulti+1)
end
if save==nil and not self.isPlotMode then
save=true
end
if save then
userActorSetting.flushVal("AccMulti",self.accMulti)
end
end

function fightBattle:isInBeginNextBattle()
return self.isBeginNextBattle
end


function fightBattle:onComplete(skip,skipAll)
self.isBeginNextBattle=true
loggerUtil.log(FMT.fmt("fightBattle:onComplete1 {0}",self.id))

UIManager:callWindowFunc("UIFightMainTop","hideDemagePanel")
UIManager:callWindowFunc("UIFightMainTop","hideHealPanel")


self:setAccMulti(0,false)
if self.isShowWindow then
UIManager:invokeUIMethod("UIFightMainTop","flushState")
end

local onEnd=function()
if self.entities then
for i,ent in pairs(self.entities)do
ent:onComplete()
end
end
if skipAll then
if self.isCalcTotalStatistics then
if self.fightIndex==#self.fightReportStrList then
self:saveStatistics(self.fightIndex)
self:endBattle()
else
local isShowWindow=self.isShowWindow
self:saveStatistics(self.fightIndex)
for i=self.fightIndex+1,#self.fightReportStrList do
self:removeAllEntity()
self.fightIndex=i
self.fightReportStr=self.fightReportStrList[self.fightIndex]
self:init()
self:saveStatistics(i)
end
self.isBeginNextBattle=nil
self.isSkipMode=true
self.isShowWindow=isShowWindow
self:endBattle()
end
else
if self.entities then
self:saveStatistics(self.fightIndex)
end
self:endBattle()
end

else
local isNextBattle=self:playNextBattle(skip)
if not isNextBattle then
self:endBattle()
end
end
end
local delayTime=0.01
local result=self.fightInfo[fightReportTag.result]


local dizitemp={}
local dizihp={}
for i,ent in pairs(self.entities)do
local diziInfo=ent.baseInfo
if diziInfo.typo==fightEntityType.diZi then
if diziInfo.diziId and diziInfo.cvId then
dizitemp[#dizitemp+1]={diziId=diziInfo.diziId,cvId=diziInfo.cvId,jobid=diziInfo.image.job,disguise=diziInfo.disguise}
end
local hp=ent:getAttribute(entityAttr.hp)
if hp>0 then
dizihp[#dizihp+1]=hp
end

end
if i>=1 and i<=10 then
self.rcHPList[i]=(self.rcHPList[i]or 0)+self:getStatisticsTimes(self.fightIndex,FIGHT_STATISTICS_TYPE.hit,i)
end
end
local playdizi=roleAudioController:getSinglePlayDizi()

if self.isShowWindow then
if result==fightResultType.Victory then
roleAudioController:fightingRoleSpeak(dizitemp,roleAudioNodeType.Fight_ShengLi,playdizi)
elseif result==fightResultType.Lose then

roleAudioController:fightingRoleSpeak(dizitemp,roleAudioNodeType.Fight_ShiBai,playdizi)

end
end

local showBiaoQing=true

if result==fightResultType.Victory then
self.leftWinTimes=self.leftWinTimes+1
if self.exchangeResult then
result=fightResultType.Lose
self:insertWitnessBehavior(eFightWitnessEventType.fail,{kill=true})
else
self:insertWitnessBehavior(eFightWitnessEventType.victory,{kill=true})
end
elseif result==fightResultType.Lose then
self.rightWinTimes=self.rightWinTimes+1
if self.exchangeResult then
result=fightResultType.Victory
self:insertWitnessBehavior(eFightWitnessEventType.victory,{kill=true})
else
self:insertWitnessBehavior(eFightWitnessEventType.fail,{kill=true})
end

end

if self.debug==nil then
self:stopAllEffect()
end

if self.isShowWindow then
UIManager:invokeUIMethod("UIDouFaTaiPlayBackWin","refreshWinTimes",self.leftWinTimes,self.rightWinTimes)
UIManager:invokeUIMethod("UIWDCQPlayBackWin","refreshWinTimes",self.fightIndex,result)
end

if not skip then
if result==fightResultType.Victory then
for i,ent in pairs(self.entities)do
if ent:isLeft()and ent.isNPC==nil then
local bt1,bt2=ent:getSuccessBehavior()
if showBiaoQing then
showBiaoQing=false
ent:onFightSuccess(bt1)
else
ent:onFightSuccess(bt2)
end
end
end
if fightController.curBattle and fightController.curBattle.id==self.id then
if self.isShowWindow then
UIManager:showWindow("UIFightEffect",{para=10063})

AudioManager.playAudio(623)
end
end

self.isDelayOver=true
delayTime=3
elseif result==fightResultType.Lose then
self.isDelayOver=true
local haveFail=false
if self.stageCfg.witness then
for i,v in ipairs(self.stageCfg.witness)do
local fail=cfgHelper.get(cfg_fightwitnessconfig_get,v[3],"fail")
if fail then
haveFail=true
break
end
end
end
if haveFail then
delayTime=3
end
end

if self.onCompleteBattleDelay then
delayTime=self.onCompleteBattleDelay(self)or delayTime
end
end

local delayOnComplte=timer.New()
delayOnComplte:start(delayTime,onEnd,1)
end

function fightBattle:endBattle()

if not self.isOver then
if self.stageBgmHandleId then

local fadeTime=1

AudioManager.fadeoutBGMusic(fadeTime)
self.stageBgmHandleId=nil
self.playingStageBgmId=nil
end
loggerUtil.log(FMT.fmt("fightBattle:onComplete2 {0}",self.id))
if self.onCompleteCall~=nil then
self.onCompleteCall(self.id,self.isShowWindow,self.stageCfg,false)
end

if self.weakGuide then
weakGuideController:killGuide(self.weakGuide)
end
end

self.isOver=true

if not self.isShowWindow then
fightModel:removeBattle(self.id)
end

if self.updateTimer~=nil then
self.updateTimer:cancel()
self.updateTimer=nil
end

if self.roundObj~=nil then
self.roundObj:stop()
end

UIManager:closeWindow('UIChatEmotWin')

UIManager:closeWindow('UIDouFaTaiPlayBackWin')

self:initSceneEffect()


end

function fightBattle:onLeaveState(isReconnet)
self:setAccMulti(0,false)

self.isOver=true

if isReconnet then
if self.onCompleteCall~=nil then
self.onCompleteCall(self.id,self.isShowWindow,self.stageCfg,isReconnet)
end
end

if self.entities then
for i,ent in pairs(self.entities)do
ent:onComplete()
end
end

self:initSceneEffect()

if not self.isShowWindow then
fightModel:removeBattle(self.id)
end

if self.updateTimer~=nil then
self.updateTimer:cancel()
self.updateTimer=nil
end

if self.roundObj~=nil then
self.roundObj:stop()
end

end


function fightBattle:playRound(data)
if self.updateTimer==nil then
self:onStart()
local updateFunc=function()
local deltaTime=Time.deltaTime
if not self.isShowWindow then
deltaTime=deltaTime*(self.accMulti+1)
end
self:update(deltaTime)
end

self.updateTimer=timer.new()
self.updateTimer:start(0,updateFunc)
end

if data~=nil then
if self.isShowWindow then
UIManager:invokeUIMethod('UIFightMainTop','flushRoundInfo')
end
self.roundObj:play(1,data)
else
self:onComplete()
end
end


function fightBattle:playNextRound()
self.delayPlayRound=0
self.loadRoundCB=function()
if self.delayPlayRound then
self.delayPlayRound=nil
local oldRound=self.roundIndex
self.roundIndex=self.roundIndex+1
if self.repeatPlayRound and self.roundIndex>#self.roundData then
self.roundIndex=1
end
local data=self.roundData[self.roundIndex]
if not self.repeatPlayRound and data then
notifySystem:postNotify(notifyConfig.onBattleRoundChange,self.id,oldRound,self.roundIndex)
end

if data~=nil then
if self.isShowWindow then
UIManager:invokeUIMethod('UIFightMainTop','flushRoundInfo')
end
self:updateBuff()
self.roundObj:play(self.roundIndex,data)
else
self:onComplete(false)
end
end
end
self:preLoadNextRoundEffect(self.loadRoundCB)
end

function fightBattle:preLoadNextRoundEffect(loadCB)
local effectList={}
local soundList={}
for i=self.roundIndex+1,self.roundIndex+3 do
local data=self.roundData[i]
if data then
for i,roundStageData in ipairs(data)do
local ii=1
local roundStageDataLen=#roundStageData
while(ii<=roundStageDataLen)
do
local actionData=roundStageData[ii]
local typo=actionData[fightCommonTag.typo]

if typo==fightActionType.CAST_SKILL then
local id=actionData[fightSkillTag.id]
local cfg=cfg_skillconfig_get(id)
if cfg.behavior then
local rawData=cfgHelper.get1(cfg_fightbehaviorconfig_get,cfg.behavior)

if not rawData then
loggerUtil.debugErrFMT("找不到行为树配置 id:{0}",id)
end

if rawData then
if rawData.effectList then
for _,v in ipairs(rawData.effectList)do
table.insert(effectList,v)
end
end
if rawData.soundList then
for _,v in ipairs(rawData.soundList)do
table.insert(soundList,v)
end
end
end
end
end
ii=ii+1
end
end
end
end
if next(effectList)or next(soundList)then
fightManager.preLoadEffect(effectList or{},soundList or{},loadCB)
else
loadCB()
end
end

function fightBattle:printEntityBuff()
for i,ent in pairs(self.entities)do
ent:printBuff()
end
end









function fightBattle:getStatistics()
local stastics={}
stastics.left={}
stastics.right={}
if self.entities then
for i,v in pairs(self.entities)do
if v.id>=1 and v.id<=10 then
if v:isLeft()then
stastics.left[#stastics.left+1]=v
else
stastics.right[#stastics.right+1]=v
end
end
end
end
return stastics
end

function fightBattle:genStatistics()
for i,roundData in ipairs(self.roundData)do
self.roundObj:playStatistics(i,roundData)
end
self.roundObj:stop()
end


function fightBattle:addNewMonEnt(id)
if not self.newEntInfo[id]then
self.newEntInfo[id]=1
else
self.newEntInfo[id]=self.newEntInfo[id]+1
end
end

function fightBattle:getNewMonEnt(id)
return self.newEntInfo[id]
end

function fightBattle:isNewMonEnt(id)
if self.newEntInfo[id]~=nil then
return true
end
return false
end

function fightBattle:getNewMonEntList()
return self.newEntInfo
end


function fightBattle:setChangeEntData(id,data)
self.changeEntDataList[id]=data
end

function fightBattle:getChangeEntData(id)
return self.changeEntDataList[id]
end

function fightBattle:getChangeEntDataList()
return self.changeEntDataList
end




function fightBattle:calculateFightData()
local res={left={},right={},leftFinalHpPercent=1,rightFinalHpPercent=1}
local statistics=self:getStatistics()
for k,v in pairs(statistics)do
if(k=='left'or k=='right')then
local final_hp_percent=1
local originalEntities
local addCount
local entityCount=0
if k=='left'then
originalEntities=self.fightInfo[fightReportTag.attack]or{}
addCount=self.leftTotalYuanJun
elseif k=='right'then
originalEntities=self.fightInfo[fightReportTag.defend]or{}
addCount=self.rightTotalYuanJun
end
for _,info in ipairs(originalEntities)do
if info[fightEntityTag.typo]>=0 then
entityCount=entityCount+1
end
end
entityCount=entityCount+addCount
for i,entity in ipairs(v)do
if(not entity.isNPC)then
local d={}
d.enityType=entity:getType()
d.image=entity:getImageInfo()
d.name=entity.name
d.monsterID=entity:getMonsterID()
local guid=entity:getAttribute(entityAttr.id)
local guid_str=type(guid)=="string"and guid or string.format('%.0f',guid)
d.dis_guid=int64.new(guid_str)
d.totalAttack=self:getStatisticsSkillAllDemage(self.fightIndex,entity.id)
d.totalDefend=entity.totalDefend
d.totalCue=self:getStatisticsSkillAllHeal(self.fightIndex,entity.id)
d.totalTreated=self:getStatisticsSkillAllShield(self.fightIndex,entity.id)
d.id=entity.id
local entId=entity.id
local dataAddId=self:getNewMonEnt(entId)
if dataAddId and dataAddId>0 then
d.weight=(dataAddId+1)*10000+entId
else
d.weight=entId
end
table.insert(res[k],d)
if entity.finalHpPercentList then
for _,percent in ipairs(entity.finalHpPercentList)do
final_hp_percent=final_hp_percent-(1/entityCount)+percent/entityCount
end
end


if dataAddId and dataAddId>0 then
for i=1,dataAddId do
local changeIdx=dataAddId*10000+entId
local data=self:getChangeEntData(changeIdx)
if data then
local c_d={}
c_d.enityType=entity:getTypeEx(data)
c_d.image=entity:getImageInfoEx(data)
d.name=entity.name
c_d.monsterID=entity:getMonsterIDEx(data)
local guid=entity:getAttributeEx(data,entityAttr.id)
local guid_str=type(guid)=="string"and guid or string.format('%.0f',guid)
c_d.dis_guid=int64.new(guid_str)
c_d.totalAttack=data.totalAttack
c_d.totalDefend=data.totalDefend
c_d.totalCue=data.totalCue
c_d.totalTreated=data.totalTreated
c_d.id=changeIdx
c_d.weight=changeIdx
table.insert(res[k],c_d)
end
end
end
end
end
if k=='left'then
res.leftFinalHpPercent=final_hp_percent
elseif k=='right'then
res.rightFinalHpPercent=final_hp_percent
end
end
end

return res
end

function fightBattle:saveStatistics(index)
self.stasticsList=self.stasticsList or{}
self.stasticsListFinal=self.stasticsListFinal or{}
local statistics=self:calculateFightData()
local idx,max=self:getRoundIndexInfo()
local round=self:getTotalRound()
local maxRound=max
self.stasticsList[index]={statistics=statistics,round=round,maxRound=maxRound}

for i,v in pairs(self.entities)do
if v:isLeft()and v.isNPC==nil then
local d={}
local guid=v:getAttribute(entityAttr.id)
local guid_str=type(guid)=="string"and guid or string.format('%.0f',guid)
d.guid_str=guid_str
d.dis_guid=int64.new(guid_str)
d.image=v:getImageInfo()
d.max_hp=v:getAttribute(entityAttr.max_hp)
d.hp=v.finalHpPercentList and v.finalHpPercentList[1]*d.max_hp or d.max_hp
self.stasticsListFinal[guid_str]=d
end
end
end

function fightBattle:getStatisticsList()
return self.stasticsList
end

function fightBattle:getStasticsListFinal()
return self.stasticsListFinal
end

function fightBattle:getLog()
local logReport={}

local fightProcess={}
local logFun=function(str)
fightProcess[#fightProcess+1]=str
end

logFun('战斗开始')
for i,roundData in ipairs(self.roundData)do
self:logUpdateBuff(logFun)
self.roundObj:logPlay(i,roundData,logFun)
end
logFun('战斗结束')
logReport['战斗过程']=fightProcess

local statistics={}
local entityInfo={}
statistics['实体数据']=entityInfo
local totalAtt=0
local totalDef=0
local totalCue=0
local totalTreated=0
for i,ent in pairs(self.entities)do
local info=ent:getFightInfo()
entityInfo[tostring(ent.id)]=info
totalAtt=totalAtt+info.attack
totalDef=totalDef+info.defend
totalCue=totalCue+info.cue
totalTreated=totalTreated+info.treated
end
local totalInfo={}
totalInfo['伤害输出']=totalAtt
totalInfo['承受伤害']=totalDef
totalInfo['总治疗']=totalCue
totalInfo['总被治疗']=totalTreated
statistics['数据汇总']=totalInfo
logReport['统计']=statistics

local logjz=self:getJunZhenLog()
if logjz then
logReport['军阵信息']=logjz
end

logReport['格式化战报']=self.fightInfo
logReport['原始战报']=self.fightReportStr

return logReport
end








function fightBattle:insertWitnessBehavior(witnessEventType,args,index)
if next(self.witnessEntities)then
args=args or{}
local eventId=nil
local cfgEvent=nil
local behaviourName=nil
for i,v in pairs(self.witnessEntities)do
if index==nil or index==i then
eventId=v.eventId
cfgEvent=cfgHelper.get(cfg_fightwitnessconfig_get,eventId)
if cfgEvent[witnessEventType]then
if not v.witnessBehaviorList then
v.witnessBehaviorList={}
end
behaviourName=cfgEvent[witnessEventType][1]

if witnessEventType==eFightWitnessEventType.diziDead then
if not v.diziDeadTimes then
v.diziDeadTimes=0
end
if(not cfgEvent[witnessEventType][3])or(v.diziDeadTimes<cfgEvent[witnessEventType][3])then
v.diziDeadTimes=v.diziDeadTimes+1
if cfgEvent[witnessEventType][2]==2 and not args.left then
behaviourName=nil
end
if cfgEvent[witnessEventType][2]==3 and args.left then
behaviourName=nil
end
else
behaviourName=nil
end
elseif witnessEventType==eFightWitnessEventType.useFaBao then
if not v.useFaBaoTimes then
v.useFaBaoTimes=0
end
if(not cfgEvent[witnessEventType][3])or(v.useFaBaoTimes<cfgEvent[witnessEventType][3])then
v.useFaBaoTimes=v.useFaBaoTimes+1
if cfgEvent[witnessEventType][2]==2 and not args.left then
behaviourName=nil
end
if cfgEvent[witnessEventType][2]==3 and args.left then
behaviourName=nil
end
else
behaviourName=nil
end
end

if behaviourName then
if args.immediately then
table.insert(v.witnessBehaviorList,1,behaviourName)
elseif args.kill then
local freeEntList={}
local entList={}
if v.entList and next(v.entList)then
for _,ent in pairs(v.entList)do
if not ent.isRunBehavior then
table.insert(freeEntList,ent)
end
table.insert(entList,ent)
end
if not next(freeEntList)then
entList[1]:stopBehavior()
end
end
table.insert(v.witnessBehaviorList,1,behaviourName)
else
table.insert(v.witnessBehaviorList,behaviourName)
end
end
end
end
end

end
end

function fightBattle:updateWitnessBehavior(deltaTime)
local witnessEntities=nil
local firstBH=nil
local freeEntList={}
local ent=nil
for i,v in pairs(self.witnessEntities)do
if v.loopMinTime then
if(not v.loopDeltaTime)or v.loopDeltaTime>=v.loopTime then
v.loopDeltaTime=0
if v.loopMaxTime then
v.loopTime=math.random(v.loopMinTime*1000,v.loopMaxTime*1000)/1000
else
v.loopTime=v.loopMinTime
end
if not self.isDelayOver then
self:insertWitnessBehavior(eFightWitnessEventType.loop,nil,i)
end

end
v.loopDeltaTime=v.loopDeltaTime+deltaTime
end

if v.witnessBehaviorList then
if next(v.witnessBehaviorList)then
witnessEntities=v
if witnessEntities then
freeEntList={}
for _,ent in pairs(witnessEntities.entList)do
if not ent.isRunBehavior then
table.insert(freeEntList,ent)
end
end
if next(freeEntList)then
ent=freeEntList[math.random(1,#freeEntList)]
firstBH=v.witnessBehaviorList[1]
if firstBH and ent then
ent:runBehavior(firstBH,{})
table.remove(v.witnessBehaviorList,1)
end
end
end
end
end
end





end

function fightBattle:testReport(reportName)
local filename=''
if deviceHelper.isRunEditor()then
filename=FMT.fmt('fightReport/{0}.json',reportName)
else
filename=FMT.fmt('{0}.json',reportName)
end
local clientReport=jsonHelper.readFile(filename)
if clientReport~=nil then
return clientReport["原始战报"]
end
end
