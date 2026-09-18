







def_class("UIDouFaTaiChallengeWin",UIWindowBase)









function UIDouFaTaiChallengeWin:bindComponents()

self.freeImage=UIObject.get(self,0)
self.flushBtn=UIButton.get(self,1)
self.skipRoot=UIObject.get(self,2)
self.freeCount=UIText.get(self,3)
self.flushText=UIText.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.competitor_1=UIObject.get(self,6)
self.competitor_2=UIObject.get(self,7)
self.competitor_3=UIObject.get(self,8)
self.selfFight=UIText.get(self,9)
self.selfWenDao=UIText.get(self,10)
self.skipToggle=UIToggleButton.get(self,11)
self.isSkipClose=UIButton.get(self,12)

self.flushBtn:setButtonClick(function()self:onFlushBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.isSkipClose:setButtonClick(function()self:onIsSkipClose()end)
self.competitor={
self.competitor_1,
self.competitor_2,
self.competitor_3,
}



end


function UIDouFaTaiChallengeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.freeImage);self.freeImage=nil;
_UIObject_release(self.flushBtn);self.flushBtn=nil;
_UIObject_release(self.skipRoot);self.skipRoot=nil;
_UIObject_release(self.freeCount);self.freeCount=nil;
_UIObject_release(self.flushText);self.flushText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.competitor_1);self.competitor_1=nil;
_UIObject_release(self.competitor_2);self.competitor_2=nil;
_UIObject_release(self.competitor_3);self.competitor_3=nil;
_UIObject_release(self.selfFight);self.selfFight=nil;
_UIObject_release(self.selfWenDao);self.selfWenDao=nil;
_UIObject_release(self.skipToggle);self.skipToggle=nil;
_UIObject_release(self.isSkipClose);self.isSkipClose=nil;
self.competitor=nil;
end

















local item_index=
{
back=0,
speak=1,
speaktxt=2,
kuang=3,
head=4,
name=5,
fight=6,
duanIcon=7,
duanweiVal=8,
challengebtn=9,
cost=10,
costicon=11,
costnum=12,
model=13,
challengeTxt=14,
}
local _init=false


function UIDouFaTaiChallengeWin:onLoaded(...)
self:bindComponents()
self.tween={}
self.skipToggle:setToggleChange(function(name,isOn,data)
if self.isOpenSkip then
self.isSkip=isOn
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eLunDaoDaHui,"isSkipDouFaTai",isOn)
end
end)
end


function UIDouFaTaiChallengeWin:__delete()
self:unbindComponents()
self:stopCdTimer()
self:killTween()
self.tween=nil
if UIFullDouFaTaiControl.fightStage and UIFullDouFaTaiControl.fightStage.stageID==821025 then
UIFullDouFaTaiControl.fightStage:close()
UIFullDouFaTaiControl.fightStage=nil
end



end




function UIDouFaTaiChallengeWin:onShow(argtable,afterOnloaded)
if not(UIFullDouFaTaiControl.fightStage and UIFullDouFaTaiControl.fightStage.stageID==821025)then
UIFullDouFaTaiControl.fightStage=fightStage:create(821025,nil)
end


local actorList=douFaTaiModel:getPiPeiActorList()
if not next(actorList)then
douFaTaiController:req_select_actor()
end

self.config=douFaTaiModel:getDouFaTaiBasicConfig()
self:refreshPlayerInfo()
self:refreshFreeCount()

local fight=douFaTaiModel:getSelfFight()
self.selfFight:setText(mathHelper.formatNumber3(fight))



local tzNum=douFaTaiModel:get_doufatai_tzNum()
local skipUnlock=cfgHelper.get(cfg_doufataibasicconfig_get,1,"fightPreSkipNum")

self.isOpenSkip=tzNum>=skipUnlock
self.isSkipClose:setActive(not self.isOpenSkip)

local isSkip=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLunDaoDaHui,"isSkipDouFaTai",false)
self.isSkip=isSkip
self.skipToggle:setToggle(isSkip)

end

function UIDouFaTaiChallengeWin:onIsSkipClose()
local tzNum=douFaTaiModel:get_doufatai_tzNum()
local skipUnlock=cfgHelper.get(cfg_doufataibasicconfig_get,1,"fightPreSkipNum")
UIManager.error(FMT.fmt("再进行{0}场战斗开启",skipUnlock-tzNum))
end

function UIDouFaTaiChallengeWin:onShowArgRecv()
douFaTaiModel:clearTempSpeak()
self:refreshPlayerInfo()
self:refreshFreeCount()
self:refreshCdTimer()
end


function UIDouFaTaiChallengeWin:onHide()
if UIFullDouFaTaiControl.fightStage and UIFullDouFaTaiControl.fightStage.stageID==821025 then
UIFullDouFaTaiControl.fightStage:close()
UIFullDouFaTaiControl.fightStage=nil
end
isometricMapSystem:leaveStoryMode()
end

function UIDouFaTaiChallengeWin:refreshPlayerInfo()
local actorList=douFaTaiModel:getPiPeiActorList()
if not next(actorList)then

return
end
local wendao=douFaTaiModel:get_doufatai_wendao()
self.selfWenDao:setText(wendao)

for i,v in ipairs(actorList)do
local head,kuang,name,wendao,iconInfo=douFaTaiModel:getDouFaTaiActorInfo(v)
local widget=self.competitor[i]:getChildWidgetBase()

local speakStr=self:getSpeakStr(v)
widget:SetChildText(item_index.speaktxt,speakStr)

widget:SetChildButtonClick(item_index.back,function(...)
self:onClickChallengeBtn(v,speakStr)
end)

if iconInfo then
playerController:setHeadIcon(widget,item_index.head,{scale=0.75,iconInfo=iconInfo})
else

iconInfo=playerModel:getActorIconInfoByCfg(head,kuang)
playerController:setHeadIcon(widget,item_index.head,{scale=0.75,iconInfo=iconInfo})
end



widget:SetChildText(item_index.name,name)

local fight=0
local actorIdNum=tonumber(tostring(v.actorId))







local iconName=douFaTaiModel:getWenDaoIconName()



widget:SetChildCSImageIcon(item_index.duanIcon,iconName,false)


widget:SetChildButtonClick(item_index.challengebtn,function(...)
self:onClickChallengeBtn(v,speakStr)
end)
local haveFree=douFaTaiModel:checkFreeCount()
widget:SetChildActive(item_index.cost,not haveFree)
if not haveFree then
local costList=self:getCurCostList()
local iconName=iconHelper.getIconName(costList[1])
widget:SetChildCSImageIcon(item_index.costicon,iconName,false)
widget:SetChildText(item_index.costnum,costList[2])
end

local robotType=v.robotType
if robotType==DOUFATAI_ROBOTTYPE.player then
if v.discipledata~=0 and v.discipleimage~=0 then
local imageInfo=UIDiscipleModel.calculationDiscipleImageBase(v)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
widget:SetChildUIModelShowTarget(item_index.model,modelParams.body,0.7,modelParams.componets,eAnimationID.stand)

end

local score=v.wendao or 0
widget:SetChildText(item_index.duanweiVal,score)
elseif robotType==DOUFATAI_ROBOTTYPE.oldRobot then
local config=DOUFATAI_ROBOTTYPE_FUNC[robotType].getConfig(actorIdNum)
local firstNpc=config.npclist[1]
local modelParams=fightPreSelectModel.getNPCOutSideModel(firstNpc)
widget:SetChildUIModelShowTarget(item_index.model,modelParams[1],0.7,modelParams[2],eAnimationID.stand)

local score=config.wendao or 0
widget:SetChildText(item_index.duanweiVal,score)
elseif robotType==DOUFATAI_ROBOTTYPE.robot then
local config=DOUFATAI_ROBOTTYPE_FUNC[robotType].getConfig(actorIdNum)
local gId=config.monTeamId[1]
local gcfg=cfgHelper.get1(cfg_monstergroup_get,gId)
local mId=gcfg.monList[math.random(1,#gcfg.monList)]
local mcfg=cfgHelper.get1(cfg_monsterconfig_get,mId)
widget:SetChildUIModelShowTarget(item_index.model,mcfg.modelid[1],0.7,mcfg.modelid[2],eAnimationID.stand)
local score=v.wendao or 0
widget:SetChildText(item_index.duanweiVal,score)
elseif robotType==DOUFATAI_ROBOTTYPE.clonePlayer or robotType==DOUFATAI_ROBOTTYPE.clonePlayer2 then
if v.discipledata~=0 and v.discipleimage~=0 then
local imageInfo=UIDiscipleModel.calculationDiscipleImageBase(v)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
widget:SetChildUIModelShowTarget(item_index.model,modelParams.body,0.7,modelParams.componets,eAnimationID.stand)
else
local config=DOUFATAI_ROBOTTYPE_FUNC[robotType].getConfig(actorIdNum)
local gId=config.monTeamId[1]
local gcfg=cfgHelper.get1(cfg_monstergroup_get,gId)
local monList={}
for i,v in ipairs(gcfg.monList)do
if v~=0 then
table.insert(monList,v)
end
end
local mId=monList[math.random(1,#monList)]
local mcfg=cfgHelper.get1(cfg_monsterconfig_get,mId)
widget:SetChildUIModelShowTarget(item_index.model,mcfg.modelid[1],0.7,mcfg.modelid[2],eAnimationID.stand)
end

local score=v.wendao or 0
widget:SetChildText(item_index.duanweiVal,score)
else
local score=v.wendao or 0
widget:SetChildText(item_index.duanweiVal,score)
end
fight=v.fight or 0
widget:SetChildText(item_index.fight,mathHelper.formatNumber3(fight))


end

local now=timeHelper.getServerShortTime()
local time=douFaTaiController:getLastSendSkipStamp()or 0

if self.skipTimer then
self:stopTimerByID(self.skipTimer)
self.skipTimer=nil
end

if now-time<=3 then

self.skipTimer=self:setTimer(1,4,function()
local now=timeHelper.getServerShortTime()
if now-time<4 then
for i,v in ipairs(actorList)do
local widget=self.competitor[i]:getChildWidgetBase()
widget:SetChildText(item_index.challengeTxt,FMT.fmt("挑战({0}秒)",4-now+time))
widget:SetChildGray(item_index.challengebtn,true)
end

else
for i,v in ipairs(actorList)do
local widget=self.competitor[i]:getChildWidgetBase()
widget:SetChildText(item_index.challengeTxt,"挑战")
widget:SetChildGray(item_index.challengebtn,false)
end
if self.skipTimer then
self:stopTimerByID(self.skipTimer)
self.skipTimer=nil
end
end
end)
for i,v in ipairs(actorList)do
local widget=self.competitor[i]:getChildWidgetBase()
widget:SetChildText(item_index.challengeTxt,FMT.fmt("挑战({0}秒)",4-now+time))
widget:SetChildGray(item_index.challengebtn,true)
end
else
for i,v in ipairs(actorList)do
local widget=self.competitor[i]:getChildWidgetBase()
widget:SetChildText(item_index.challengeTxt,"挑战")
widget:SetChildGray(item_index.challengebtn,false)
end
end
end

function UIDouFaTaiChallengeWin:getCurCostList()
local config=self.config
local cost=config.challenge_item[1]
local itemid=cost[1]
local needItem=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem>=needItem then
return cost
end

return cost
end

function UIDouFaTaiChallengeWin:refreshFreeCount()
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local totalFree=config.challenge_free
local data=douFaTaiModel:get_doufatai_data()
local useFree=data.freeCnt
local remain=totalFree-useFree
if remain>0 then
self.freeCount:setText(FMT.fmt('今日免费挑战：{0}次',remain))
self.freeImage:setActive(true)
else
self.freeCount:setText('')
self.freeImage:setActive(false)
end
end

function UIDouFaTaiChallengeWin:setRereshTime()
local curTime=timeHelper.getServerShortTime()
local serverLastCDTime=douFaTaiModel:getPiPeiCDTime()
if serverLastCDTime then
self.remainTime=serverLastCDTime-curTime
else
local refreshcd=self.config.match_cd
self.remainTime=refreshcd
end
end

function UIDouFaTaiChallengeWin:stopCdTimer()
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end

function UIDouFaTaiChallengeWin:refreshCdTimer()
local curTime=timeHelper.getServerShortTime()
local serverLastCDTime=douFaTaiModel:getPiPeiCDTime()
if serverLastCDTime then
self.remainTime=serverLastCDTime-curTime
end
if self.remainTime then
local flushStr=''
local btnGray=false
if self.remainTime>0 then
flushStr=FMT.fmt('刷新({0})',timeHelper.format_time_stamp4(self.remainTime-1))
else
flushStr='刷新'
end
btnGray=self.remainTime>0
self.flushText:setText(flushStr)
self.flushBtn:setButtonEnable(true,btnGray)

local endTime=curTime+self.remainTime
self.endTime=endTime
if self.remainTime>0 then
local func=function(...)
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
self.remainTime=dtTime
self.flushText:setText(FMT.fmt('刷新({0})',timeHelper.format_time_stamp4(dtTime)))
self.flushBtn:setButtonEnable(true,dtTime>0)
if dtTime<=0 then
self.flushText:setText('刷新')
self:stopCdTimer()
end
end
self.cdTimer=self:setTimer(1,self.remainTime+1,func)
end
end
end

function UIDouFaTaiChallengeWin:getSpeakStr(data)
local speakStr=data.sentence
local defaults=self.config.sentence
if speakStr==''then
local tempStr=douFaTaiModel:getPiPeiActoreSpeak(data.index)
if tempStr then
speakStr=tempStr
else
local rand=math.random(1,#defaults)
speakStr=defaults[rand]
end
end
douFaTaiModel:setPiPeiActorSpeak(data.index,speakStr)
return speakStr
end

function UIDouFaTaiChallengeWin:reqPrepareFight(actor,sentence)
if self.isSkip then
local time=douFaTaiController:skipFight(actor.actorId,actor.robotType)
if time>0 then
UIManager.error(FMT.fmt("{0}秒后可挑战",4-time))
end
return
end

douFaTaiModel:setCurLookType(DOUFATAI_LOOK_TYPE.eChallenge)
local actorIdNum=tonumber(tostring(actor.actorId))
if actor.robotType==DOUFATAI_ROBOTTYPE.player then
douFaTaiController:req_actor_defense_new(actor.actorId,actor.robotType,true,true)
elseif actor.robotType==DOUFATAI_ROBOTTYPE.oldRobot then
local monsterList=douFaTaiModel:getOldRobotMonstersList(actorIdNum)
local fight=actor.fight
douFaTaiController.prePareFight(actor.actorId,sentence,fight,nil,monsterList,actor.robotType)
elseif actor.robotType==DOUFATAI_ROBOTTYPE.robot or actor.robotType==DOUFATAI_ROBOTTYPE.clonePlayer2 then
local config=DOUFATAI_ROBOTTYPE_FUNC[actor.robotType].getConfig(actorIdNum)
local fight=actor.fight
if config then
local cfg=cfg_monstergroup_get(config.monTeamId[1])
local monsterList=cfg.monList
douFaTaiController.prePareFight(actor.actorId,sentence,fight,nil,monsterList,actor.robotType)
end
elseif actor.robotType==DOUFATAI_ROBOTTYPE.clonePlayer then

douFaTaiController:req_actor_defense_new(actor.actorId,actor.robotType,true,false,true)
end
end



function UIDouFaTaiChallengeWin:onClickChallengeBtn(actor,sentence)
local haveFree=douFaTaiModel:checkFreeCount()
if haveFree then
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local maxHonor=config.max_honor
local max=maxHonor[2]
local honor=douFaTaiModel:get_honorToday()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eDouFaTaiChallengeHonorMaxToday)
if honor>=max and not flag then

























local content='今日荣誉点已达获取上限，是否挑战？'
local okcallback=function(...)
self:reqPrepareFight(actor,sentence)
end
UIDialogManager.getConfirmDialog3(nil,content,okcallback,REPEAT_TYPE.eDouFaTaiChallengeHonorMaxToday)
else
self:reqPrepareFight(actor,sentence)
end
else
local config=self.config
local cost=config.challenge_item[1]
local itemid=cost[1]
local needItem=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem>=needItem then

local config=douFaTaiModel:getDouFaTaiBasicConfig()
local maxHonor=config.max_honor
local max=maxHonor[2]
local honor=douFaTaiModel:get_honorToday()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eDouFaTaiChallengeHonorMaxToday)
if honor>=max and not flag then

























local content='今日荣誉点已达获取上限，是否挑战？'
local okcallback=function(...)
self:reqPrepareFight(actor,sentence)
end
UIDialogManager.getConfirmDialog3(nil,content,okcallback,REPEAT_TYPE.eDouFaTaiChallengeHonorMaxToday)
else
self:reqPrepareFight(actor,sentence)
end

return
else
UIManager.info(FMT.fmt('{0}不足',itemsConfig.getItemName(itemid)))
gainControl:showGainWin(itemid)
end
end
end

function UIDouFaTaiChallengeWin:onFlushBtn()
if self.cdTimer then
local curTime=timeHelper.getServerShortTime()
local dtTime=self.endTime-curTime
if dtTime and dtTime>0 and dtTime<=self.config.match_cd then
UIManager.info(FMT.fmt('{0}后可刷新',timeHelper.format_time_stamp4(dtTime)))
end
return
end
for i=1,3 do
self.tween[i]=self.competitor[i]:setChildCanvasGroupDOFade(0,0.5,function(...)
self.tween[i]=self.competitor[i]:setChildCanvasGroupDOFade(1,0.5,function(...)
self:killTween()
end)
self.tween[i]:SetDelay(0.1)
end)
end
fightManager.setState(1)
douFaTaiController:req_select_actor()
end

function UIDouFaTaiChallengeWin:onCloseBtn()
UIFullDouFaTaiControl:showDouFaTaiWindow()
UIFullDouFaTaiControl:showActiveView('UIDouFaTaiWin')
end

function UIDouFaTaiChallengeWin:killTween()
for i=1,3 do
if self.tween[i]then
self.tween[i]:Kill(false)
self.tween[i]=nil
end
end
end
