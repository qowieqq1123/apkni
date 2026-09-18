







def_class("UISubAct_ChiSeJinDi_EnterWin2",UIWindowBase)









function UISubAct_ChiSeJinDi_EnterWin2:bindComponents()

self.background=UIObject.get(self,0)
self.costIcon=UIImage.get(self,1)
self.costNum=UIText.get(self,2)
self.costRoot=UIObject.get(self,3)
self.dailyBtn=UIButton.get(self,4)
self.dailyImg1=UIObject.get(self,5)
self.dailyImg2=UIObject.get(self,6)
self.dailyReddot=UIObject.get(self,7)
self.dailyScore=UIText.get(self,8)
self.dzModel_1=UIObject.get(self,9)
self.dzModel_2=UIObject.get(self,10)
self.dzModel_3=UIObject.get(self,11)
self.dzModel_4=UIObject.get(self,12)
self.enterContinue=UIText.get(self,13)
self.enterCost=UIText.get(self,14)
self.enterEffect=UIObject.get(self,15)
self.enterModel=UIButton.get(self,16)
self.freeTx=UIText.get(self,17)
self.helpBtn=UIButton.get(self,18)
self.jumpBtn=UIButton.get(self,19)
self.jumpReddot=UIObject.get(self,20)
self.levelHelp=UIButton.get(self,21)
self.levelIcon=UIImage.get(self,22)
self.nextLevel=UIText.get(self,23)
self.rankBtn=UIButton.get(self,24)
self.rewardList=UIObject.get(self,25)
self.root=UIObject.get(self,26)
self.scoreTx=UIText.get(self,27)
self.targetBtn=UIButton.get(self,28)
self.targetReddot=UIObject.get(self,29)
self.timeBg=UIObject.get(self,30)
self.timeTx=UIText.get(self,31)

self.dailyBtn:setButtonClick(function()self:onDailyBtn()end)

self.enterModel:setButtonClick(function()self:onEnterModel()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.levelHelp:setButtonClick(function()self:onLevelHelp()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.targetBtn:setButtonClick(function()self:onTargetBtn()end)
self.dzModel={
self.dzModel_1,
self.dzModel_2,
self.dzModel_3,
self.dzModel_4,
}



end


function UISubAct_ChiSeJinDi_EnterWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.dailyBtn);self.dailyBtn=nil;
_UIObject_release(self.dailyImg1);self.dailyImg1=nil;
_UIObject_release(self.dailyImg2);self.dailyImg2=nil;
_UIObject_release(self.dailyReddot);self.dailyReddot=nil;
_UIObject_release(self.dailyScore);self.dailyScore=nil;
_UIObject_release(self.dzModel_1);self.dzModel_1=nil;
_UIObject_release(self.dzModel_2);self.dzModel_2=nil;
_UIObject_release(self.dzModel_3);self.dzModel_3=nil;
_UIObject_release(self.dzModel_4);self.dzModel_4=nil;
_UIObject_release(self.enterContinue);self.enterContinue=nil;
_UIObject_release(self.enterCost);self.enterCost=nil;
_UIObject_release(self.enterEffect);self.enterEffect=nil;
_UIObject_release(self.enterModel);self.enterModel=nil;
_UIObject_release(self.freeTx);self.freeTx=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.jumpReddot);self.jumpReddot=nil;
_UIObject_release(self.levelHelp);self.levelHelp=nil;
_UIObject_release(self.levelIcon);self.levelIcon=nil;
_UIObject_release(self.nextLevel);self.nextLevel=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scoreTx);self.scoreTx=nil;
_UIObject_release(self.targetBtn);self.targetBtn=nil;
_UIObject_release(self.targetReddot);self.targetReddot=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
self.dzModel=nil;
end















local _this=nil
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"
local _enterEffect=20435



function UISubAct_ChiSeJinDi_EnterWin2:onLoaded(...)
self:bindComponents()
_this=self

socketManager:addNotify(249,231,self.on_249_231)
socketManager:addNotify(249,233,self.on_249_233)
socketManager:addNotify(249,234,self.on_249_234)
socketManager:addNotify(249,235,self.on_249_235)
socketManager:addNotify(249,236,self.on_249_236)
socketManager:addNotify(249,240,self.on_249_240)
self:addNotify(notifyConfig.onSubActivityDontHandleReddotChange,self.onSubActivityDontHandleReddotChange)
end


function UISubAct_ChiSeJinDi_EnterWin2:__delete()
self:unbindComponents()
_this=nil

socketManager:removeNotify(249,231,self.on_249_231)
socketManager:removeNotify(249,233,self.on_249_233)
socketManager:removeNotify(249,234,self.on_249_234)
socketManager:removeNotify(249,235,self.on_249_235)
socketManager:removeNotify(249,236,self.on_249_236)
socketManager:removeNotify(249,240,self.on_249_240)

self:closeWindow("UITopMoneyWin6")
self:stopBT()
self:stopCDTick()
if self.enterTweener and self.enterTweener:IsActive()then
self.enterTweener:Kill()
end
if self.enterBatch and self.enterBatch:IsActive()then
self.enterBatch:Kill()
end

if self:stopEnterTick()then
if initProControl.isDone()then
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
call_activitiesHandle_func("activitiesHandle_chisejindi","reqRefreshActivityData",self.actId,self.subId)
else
UIManager:closeWindow("UIFightPrepareLoading")
end
end
end




function UISubAct_ChiSeJinDi_EnterWin2:onShow(argtable,afterOnloaded)
if argtable then
local same=self.actId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
if not same then
self.argtable=argtable
self.actId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self:initView()
end

self:refreshView()
self:showView()
self:extraParamsHandle(argtable.extraParams)

end
end


function UISubAct_ChiSeJinDi_EnterWin2:onHide()
self:hideWindow("UITopMoneyWin6")
end




function UISubAct_ChiSeJinDi_EnterWin2:onEnterModel()
if self.info:checkInResultRankTime()then
UIManager.error("禁地封闭中，0点后方可进入")
return
end

local data=self.info:getData()
if data.continue>0 then

self:enterCopy()
return
end

local costIdx=data.copyTimes+1
local consume=self.config.consume
local costCfg=costIdx>=#consume and consume[#consume]or consume[costIdx]
local checkEnterCopy=function()
self:checkEnterCost(costCfg,nil,function()
self:enterCopy()
end)
end
local checkCost=function()
if#costCfg<=0 or dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eChiSeJinDiCostEnterCopy)then
checkEnterCopy()
else
local costStr=nil
for i,v in ipairs(costCfg)do
local itemid=v[1]
local itemnum=v[2]
local havenum=itemsModel.getCount(itemid)
local color=havenum>=itemnum and"#08b400"or"#e50000"
local tempStr=FMT.fmt("quad-icon={0}-quad<color={2}>{1}</color>",iconHelper.getIconName(itemid),itemnum,color)
costStr=costStr and FMT.fmt("{0}、{1}",costStr,tempStr)or tempStr
end
local content=FMT.fmt("本次进入需要消耗{0}，是否确定？",costStr)
local dialog=UIDialogManager.getConfirmDialog(nil,'提示',content)
dialog.type="UIDialougeWithIcon"
dialog.choosetext="今日不再提示"
dialog.choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eChiSeJinDiCostEnterCopy,flag)
end
dialog.okcallback=checkEnterCopy
dialog.moneytypes=self.moneyList
dialog:show()
end
end
local data=self.info:getData()
local dailyScore=data.dailyScore
local todayScore=self.config.today
if dailyScore>=todayScore then
local content=FMT.fmt("每日{0}已达上限（仍可获得段位积分）是否确认进入？",self.config.dailyName)
UIDialogManager.getConfirmDialog3(nil,content,checkCost,REPEAT_TYPE.eChiSeJinDiFullDailyScore)
else
checkCost()
end
end


function UISubAct_ChiSeJinDi_EnterWin2:onTargetBtn()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
}
self:showWindow("UISubAct_ChiSeJinDi_AchievementWin",args)
end


function UISubAct_ChiSeJinDi_EnterWin2:onRankBtn()
if self.info:checkInResultRankTime()then
UIManager.error("结算期间无法查看")
return
end
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
}
self:showWindow("UISubAct_ChiSeJinDi_RankWin",args)
call_activitiesHandle_func("activitiesHandle_chisejindi","reqRankData",self.actId,self.subId)
end


function UISubAct_ChiSeJinDi_EnterWin2:onHelpBtn()
local args={
ruleGroupID=self.argtable.help,
}
self:showWindow("UIRuleTipsImage2Win",args)
end


function UISubAct_ChiSeJinDi_EnterWin2:onDailyBtn()
local data=self.info:getData()
if data.dailyFlag==1 then
UIManager.error("今日已领取")
return
end
local pass=data.copyTimes>1 or(data.copyTimes==1 and data.continue==0)
if not pass then
UIManager.info("需要重走一次西游")
return
end

call_activitiesHandle_func("activitiesHandle_chisejindi","reqGetDailyReward",self.actId,self.subId)
end


function UISubAct_ChiSeJinDi_EnterWin2:onJumpBtn()
local passportParam=self.config.passportParam
local actId=self.actId
local subType=passportParam[1]
local subId=passportParam[2]
if activitiesModel:isDontHandleSubType(subType)then
activitiesController:jump_DontHandle(actId,subType,subId)
else
activitiesController:jump(actId,subType,subId)
end
end

function UISubAct_ChiSeJinDi_EnterWin2:isHideJumpBtn()
local passportParam=self.config.passportParam
local passporttype=txzType.act
local actId=self.actId
local subType=passportParam[1]
local subId=passportParam[2]
local guid=UITYTongXingZhengModel:getGuidByActID(passporttype,actId,subType,subId)
local txzId=UITYTongXingZhengModel:getTXZId(guid)

if not guid or not txzId then
local str=string.format("活动id：%s-%s-%s 拿取guid或通行证id有误，请联系前端排查！！！",actId,subType,subId)
logErr(str)
end

if UITYTongXingZhengModel:isReceiveFullIncludeCharge(guid,txzId)then
local config=cfgHelper.get2(cfg_passportconfig_get,txzId,'drop_id')
if not config then
return false
end
end
return true
end

function UISubAct_ChiSeJinDi_EnterWin2:refreshJumpReddot()
local passportParam=self.config.passportParam
local actId=self.actId
local subType=passportParam[1]
local subId=passportParam[2]
local reddot=false
if activitiesModel:isDontHandleSubType(subType)then
reddot=activitiesModel:getReddot_DontHandle(actId,subType,subId)
else
reddot=activitiesModel:checkSubActReddot(actId,subType,subId)
end
self.jumpReddot:setActive(reddot)

local flag=self:isHideJumpBtn()
self.jumpBtn:setActive(flag)
if not flag then
UIManager:invokeUIMethod("UITYTXZRewardsWin","onCloseBtn")
end
end


function UISubAct_ChiSeJinDi_EnterWin2:onLevelHelp()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_RankRuleWin",args)
end

function UISubAct_ChiSeJinDi_EnterWin2:enterCopy()
AudioManager.playAudio(661)
local sequence=Lua.SequenceProxy.New()
local batch=Lua.SequenceProxy.New()
local effecCfg=cfgHelper.get1(cfg_effectconfig_get,_enterEffect)
local duration=effecCfg.lifetime/1000
UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)
self.root:setActive(false)
self:hideWindow("UITopMoneyWin6")
local tweener1=self.background:setChildDOScale(1.3,duration)
local tweener2=self.background:setChildDOAnchorPosY(-100,duration)
self.enterEffect:setChildShowEffect(_enterEffect,true)
batch:AppendInterval(duration-1)
batch:AppendCallback(function()

if UIManager:isActive("UIFightPrepareLoading")then
call_activitiesHandle_func("activitiesHandle_chisejindi","reqEnterCopy",self.actId,self.subId)
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
call_activitiesHandle_func("activitiesHandle_chisejindi","reqEnterCopy",self.actId,self.subId)
end
})
end
self:startEnterTick()
end)
sequence:Join(batch)
sequence:Join(tweener1)
sequence:Join(tweener2)
sequence:AppendCallback(function()
self.root:setActive(true)
UIManager:invokeUIMethod(self.parentWin,'activeRoot',true)
self:showWindow("UITopMoneyWin6")
self.background:setScale(Vector3.one)
self.background:setChildAnchoredPosition(Vector2.zero)
end)
self.enterTweener=sequence
self.enterBatch=batch
end


function UISubAct_ChiSeJinDi_EnterWin2:initView()

self:startCDTick()

local moneyLookup={}
for i,v in ipairs(self.config.consume)do
for j,w in ipairs(v)do
moneyLookup[w[1]]=true
end
end
self.moneyList={}
for i,v in pairsBySortKey(moneyLookup)do
table.insert(self.moneyList,{i})
end

self:startBT()

self.background:setChildUIModelShowTarget(self.argtable.bgSpine,1,defaultT,eAnimationID.stand)
end

function UISubAct_ChiSeJinDi_EnterWin2:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_ChiSeJinDi_EnterWin2:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_ChiSeJinDi_EnterWin2:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.actId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time,true)))
end

function UISubAct_ChiSeJinDi_EnterWin2:startEnterTick()
if not self.enterTick then
self.enterTick=self:setTimer(5,1,function()
if UIManager:isActive("UIFightPrepareLoading")then
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
UIManager.error("进入失败")
call_activitiesHandle_func("activitiesHandle_chisejindi","reqRefreshActivityData",self.actId,self.subId)
end
self:stopEnterTick()
end)
end
end

function UISubAct_ChiSeJinDi_EnterWin2:stopEnterTick()
if self.enterTick then
self:stopTimerByID(self.enterTick)
self.enterTick=nil
return true
end
return false
end


function UISubAct_ChiSeJinDi_EnterWin2:refreshView()
self:refreshJumpReddot()
self:refreshDailyBtn()
self:refreshDailyScore()
self:refreshCopyCost()
self:refreshRankScore()
self:refreshRankReward()
self:refreshTargetReddot()
end


function UISubAct_ChiSeJinDi_EnterWin2:showView()
if self.moneyList and#self.moneyList>0 then
self:showWindow("UITopMoneyWin6",{moneys=self.moneyList,offsetX=-358,offsetY=-24})
else
self:hideWindow("UITopMoneyWin6")
end
end

function UISubAct_ChiSeJinDi_EnterWin2:openCopy()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
parentWin=self,
preview=self.argtable.preview,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyMainWin2",args)
self:stopEnterTick()
end


function UISubAct_ChiSeJinDi_EnterWin2:extraParamsHandle(extraParams)
if extraParams then

if extraParams.autoContinue then
local data=self.info:getData()
local copyData=self.info:getCopy()

if copyData and data.continue>0 then
if not self.info:checkInResultRankTime()then
self:openCopy()
return
end
else

local resultData=self.info:getResult()
if resultData then
if UIManager:isActive("UIFightPrepareLoading")then
self:openCopy()
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
self:openCopy()
end
})
end
return
end
end

if UIManager:isActive("UIFightPrepareLoading")then
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
end
end
end


function UISubAct_ChiSeJinDi_EnterWin2:refreshDailyBtn()
local data=self.info:getData()
local getted=data.dailyFlag==1
local pass=data.copyTimes>1 or(data.copyTimes==1 and data.continue==0)
local reddot=getted or pass


self.dailyImg1:setActive(not getted)
self.dailyImg2:setActive(getted)

self.dailyReddot:setActive(reddot)
end


function UISubAct_ChiSeJinDi_EnterWin2:refreshDailyScore()
local data=self.info:getData()
self.dailyScore:setText(FMT.fmt("{0}/{1}",data.dailyScore,self.config.today))
end


function UISubAct_ChiSeJinDi_EnterWin2:refreshCopyCost()
local data=self.info:getData()
local continue=data.continue

if continue>0 then
self.enterContinue:setActive(true)
self.enterCost:setActive(false)
return
end

self.enterContinue:setActive(false)
self.enterCost:setActive(true)
local costIdx=data.copyTimes+1
local consume=self.config.consume
local costCfg=costIdx>=#consume and consume[#consume]or consume[costIdx]
local haveCost=#costCfg>0
self.freeTx:setActive(not haveCost)
self.costRoot:setActive(haveCost)
if haveCost then
local costData=costCfg[1]
self.costIcon:setImageIcon(iconHelper.getIconName(costData[1]),false)
self.costNum:setText(FMT.fmt("{0})",mathHelper.formatNumber(costData[2])))
end
end


function UISubAct_ChiSeJinDi_EnterWin2:refreshRankScore()
local data=self.info:getData()

self.scoreTx:setText(FMT.fmt("积分: {0}",data.stageScore))

local nextStr=data.stageNext>0 and FMT.fmt("（还差{0}分升段）",data.stageNext)or""
self.nextLevel:setText(nextStr)

self.levelIcon:setSprite(_abName,self.config.scoreClient[data.stage][2])
end


function UISubAct_ChiSeJinDi_EnterWin2:refreshRankReward()
local data=self.info:getData()
local stageCnt=#self.config.score
local top=data.stageFlag==stageCnt
local rewards=top and self.config.score[data.stageFlag][2]or self.config.score[data.stageFlag+1][2]
local count=#rewards
local getted=top
local reddot=data.stage>data.stageFlag

self.rewardList:setChildLayoutGroupCreateItems(count,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewards[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local showCountBG=rewardNum>1
local countStr=showCountBG and mathHelper.formatNumber(rewardNum)or""
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
rewardItem:SetChildActive(1,reddot)
rewardItem:SetChildActive(2,getted)
end)
end

function UISubAct_ChiSeJinDi_EnterWin2:onClickRewardItem(itemid,index,itemguid,attach)
local data=self.info:getData()
if data.stageFlag<data.stage then
call_activitiesHandle_func("activitiesHandle_chisejindi","reqGetStageReward",self.actId,self.subId,data.stageFlag+1)
else
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end
end


function UISubAct_ChiSeJinDi_EnterWin2:startBT()
self:stopBT()

local discipleCount=UIDiscipleModel:checkDiscipleCount()
if discipleCount>0 then
local btArgs={
widget=self.winlua,
winName=self.__name,
}
for i,v in ipairs(self.dzModel)do
btArgs[FMT.fmt("model{0}",i)]=v:getID()
end
self.bt=behaviorManager:addBehaviorTree("bt_ui_csjd_enter_disciple",nil,true,btArgs,true)
end
end


function UISubAct_ChiSeJinDi_EnterWin2:randomBTDisciple(bt,index)
local modelCmp=bt:getSharedVar(FMT.fmt("model{0}",index))
local discipleCount=UIDiscipleModel:checkDiscipleCount()
local discipleList=UIDiscipleModel:getAllDiscipleData()
local randomNum=math.random(1,discipleCount)
local modelParams=nil
for i,v in pairs(discipleList)do
randomNum=randomNum-1
if randomNum<=0 then
local netData=v.netData.net
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(netData.discipleguid)
break
end
end
self.winlua:SetChildUIModelShowTarget(modelCmp,modelParams.body,0.8,modelParams.componets,eAnimationID.stand,false,false,0,nil)
end


function UISubAct_ChiSeJinDi_EnterWin2:stopBT()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end

function UISubAct_ChiSeJinDi_EnterWin2:randamJumpPos(bt,index)
local rx=math.random(-2,2)
local ry=math.random(-2,2)
local pos={17+rx*50,80+ry*50}
local key=FMT.fmt("jumpPos{0}",index)
bt:setSharedVar(key,pos)
end

function UISubAct_ChiSeJinDi_EnterWin2:refreshTargetReddot()
local reddot=self.info:hasTargetFlag0()
self.targetReddot:setActive(reddot)
end

function UISubAct_ChiSeJinDi_EnterWin2:checkEnterCost(costList,sIndex,callback)
sIndex=sIndex or 1
for i=sIndex,#costList do
local cost=costList[i]
local itemId=cost[1]
local needNum=cost[2]
if itemsConfig.isMoney(itemId)then
local check=moneySystem:useMoney(itemId,needNum,function()
self:checkEnterCost(costList,i+1,callback)
end,WARNING_TYPE.eWarning)
return
else
local haveNum=itemsModel.getCount(itemId)
if needNum>haveNum then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
return
end
end
end
callback()
end


function UISubAct_ChiSeJinDi_EnterWin2.on_249_231(args)
local actId=args[1]
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local subId=args[2]
if _this.info:compare(actId,subType,subId)then
_this:refreshView()
end
end


function UISubAct_ChiSeJinDi_EnterWin2.on_249_233(actId,subId,stageIdx)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshRankReward()
end
end


function UISubAct_ChiSeJinDi_EnterWin2.on_249_234(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshDailyBtn()
end
end


function UISubAct_ChiSeJinDi_EnterWin2.on_249_235(actId,subId,targetIdx)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshTargetReddot()
end
end


function UISubAct_ChiSeJinDi_EnterWin2.on_249_236(args)
local actId=args[1]
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
local subId=args[2]
local round=args[4]
if _this.info:compare(actId,subType,subId)then
_this:openCopy()
if round==1 then
_this:refreshCopyCost()
end
end
end


function UISubAct_ChiSeJinDi_EnterWin2.on_249_240(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshView()
end
end

function UISubAct_ChiSeJinDi_EnterWin2.onSubActivityDontHandleReddotChange(actId,subType,subId)
local passportParam=_this.config.passportParam
if _this.actId==actId and subType==passportParam[1]and subId==passportParam[2]then
_this:refreshJumpReddot()
end
end