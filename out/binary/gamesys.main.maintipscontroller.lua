







local _index=0
local getIndex=function()
_index=_index+1
return _index
end

mainTipsType={
eLimitAct_TYSC=getIndex(),
eLimitAct_SJSL=getIndex(),
eLimitAct_WDCQ=getIndex(),
eLimitAct_XJFM=getIndex(),
eLimitAct_LTYW=getIndex(),
eLimitAct_MGZD=getIndex(),
eLimitAct_LDDH=getIndex()
}

local _MODULENAME="mainTipsController"
gameState.addListener(def_table(_MODULENAME))
mainTipsController.name=_MODULENAME


local checkLookup={

[mainTipsType.eLimitAct_TYSC]={
win='UILimitActTipsWin',
check=function()
local actID=LIMIT_ACT_TYPE.eTianYuanShouChao
if limitActivitiesModel:checkDoingPreview(actID)then
return true,{actID=actID}
end
return false,nil
end,
onlineOnce=true,
},

[mainTipsType.eLimitAct_SJSL]={
win='UILimitActTipsWin',
check=function()
local actID=LIMIT_ACT_TYPE.eShiJieShouLing
if limitActivitiesModel:checkDoingPreview(actID)and worldLeaderModel.init then
local curr=worldLeaderModel:getChallengeTimes()
local buy=worldLeaderModel:getBuyTimes()
local free=cfgHelper.get2(cfg_worldbossconfig_get,1,"free")
if curr>=buy+free then
return false,nil
else
return true,{actID=actID}
end
end
return false,nil
end,
onlineOnce=true,
},

[mainTipsType.eLimitAct_WDCQ]={
win='UILimitActTipsWin',
check=function()
if not WDCQController.checkSysReddot()then
return false,nil
end
local actID=LIMIT_ACT_TYPE.eWenDingCangQiong
local name="赛前调整"
local gotoExtraParams=nil
local selfActorId=playerModel:getActorID()
local gameInfo=WDCQController.getActorGameInfo and WDCQController.getActorGameInfo(selfActorId)
if gameInfo and WDCQController.getMacthStage then
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(gameInfo.groupId,gameInfo.stageId,gameInfo.idx)

if macthStage==WDCQCMatchStageEnum.ePreTheGame and preStage==WDCQCPreGameStageEnum.eAdjustTeam then
local adjustTeamIndex=WDCQController.getAdjustTeamIndex and WDCQController.getAdjustTeamIndex(adjustStage)
local hasPreset=false
if adjustTeamIndex and WDCQController.checkTeamDZ then
hasPreset=WDCQController.checkTeamDZ(selfActorId,adjustTeamIndex)
end
if not hasPreset then
name="预设队伍"
gotoExtraParams={showPreWin=true}
else
local posEnum=gameInfo.posEnum
local isMyTurn=false
if posEnum and WDCQController.checkAdjustTeamPos then
isMyTurn=WDCQController.checkAdjustTeamPos(adjustStage,posEnum)
end
if isMyTurn then
name="赛前调整"
gotoExtraParams={showPreWin=true}
end
end
end
end

return true,{actID=actID,name=name,gotoExtraParams=gotoExtraParams}
end,
onlineOnce=true,
},

[mainTipsType.eLimitAct_XJFM]={
win='UILimitActTipsWin',
check=function()
local actID=LIMIT_ACT_TYPE.eXianJieFuMo
if XianJieFuMoModel.init and XianJieFuMoController:getReddot()then
return true,{actID=actID}
end
return false,nil
end,
onlineOnce=true,
},

[mainTipsType.eLimitAct_LDDH]={
win='UILimitActTipsWin',
check=function()


local actID=LIMIT_ACT_TYPE.eLunDaoDaHui
if lundaodahuiModel:checkLunDaoDaHuiEntry()then


local titleName,gotoSub,result=lundaodahuiController:tryGetTaoTaiMatchTips()
if not result then
return false,nil
end

local args={
actID=actID,
tipsText=titleName,
gotoText="前往查看",
gotoExtraParams={
page=2,
subPage=gotoSub
}
}
return true,args
end
return false,nil
end,
onlineOnce=true,
},

[mainTipsType.eLimitAct_LTYW]={
win='UILimitActTipsWin',
check=function()
local actID=LIMIT_ACT_TYPE.eLeiTaiYanWu
if limitActivitiesModel:checkDoingPreview(actID)then
return true,{actID=actID}
end
return false,nil
end,
onlineOnce=true,
},

[mainTipsType.eLimitAct_MGZD]={
win='UILimitActTipsWin',
check=function()
local actID=LIMIT_ACT_TYPE.eMoGongZhengDuo
if limitActivitiesModel:checkDoingPreview(actID)then
return true,{actID=actID}
end
return false,nil
end,
onlineOnce=true,
},
}

function mainTipsController:onAppStart()

end

function mainTipsController:onEnterState(isReconnet)
if not isReconnet then
local list={}
for i,v in ipairs(checkLookup)do
v.typo=i

v.mark=false

table.insert(list,v)
end
self.checklist=list
end
end

function mainTipsController:onLeaveState(isReconnet)
if not isReconnet then
self.checklist=nil
end
end

function mainTipsController:onPlayerCreate(...)

end

function mainTipsController:onProtocolReq(isReconnet)

end

function mainTipsController:onLostConnection()

end

function mainTipsController:openMain()
timeEventController.delayDo(2,function()
mainTipsController:triggerNext()
end)
end

function mainTipsController:closeMain()
if self.activeObj~=nil then
local win=self.activeObj.win
UIManager:closeWindow(win)
self.activeObj=nil
end
end

function mainTipsController:triggerNext()
if not UIManager:isActive('UIMain')then
return
end
if self.activeObj~=nil then
return
end
if#self.checklist<=0 then
return
end
local dels={}
for i,v in ipairs(self.checklist)do
local flag=mainTipsController:onTrigger(v.typo)
if flag then
break
else
table.insert(dels,i)
end
end
if#dels>0 then
for i=#dels,1,-1 do
table.remove(self.checklist,dels[i])
end
end
end

function mainTipsController:onTrigger(typo)
local d=checkLookup[typo]
if d and d.mark==false then
local flag,params=d.check()
if flag then
params.typo=typo
UIManager:showWindow(d.win,params)
self.activeObj=d
return true
end
end
return false
end

function mainTipsController:onCloseWin(typo)
self.activeObj=nil
local d=checkLookup[typo]
if d then
d.mark=true
local f
for i,v in ipairs(self.checklist)do
if v.typo==typo then
f=i
break
end
end
if f then
table.remove(self.checklist,f)
end
end


timeEventController.delayDo(0.1,function()
mainTipsController:triggerNext()
end)
end

function mainTipsController:onActive(typo)
if self.activeObj~=nil then
return
end
local d=checkLookup[typo]
if d then
d.mark=false
local f
for i,v in ipairs(self.checklist)do
if v.typo==typo then
f=i
break
end
end
if not f then
table.insert(self.checklist,d)
end

mainTipsController:triggerNext()
end
end