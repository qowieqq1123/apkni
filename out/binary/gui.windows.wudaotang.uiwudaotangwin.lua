







def_class("UIWuDaoTangWin",UIWindowBase)









function UIWuDaoTangWin:bindComponents()

self.scoreProgress=UIProgress.get(self,0)
self.disGrid=UIObject.get(self,1)
self.rewardBtn=UIButton.get(self,2)
self.levelTxt=UIText.get(self,3)
self.levelupPanel=UIObject.get(self,4)
self.pointIcon=UIObject.get(self,5)
self.progressTips=UIText.get(self,6)
self.planIcon=UIImage.get(self,7)
self.backEffect=UIObject.get(self,8)
self.costTimeText=UIText.get(self,9)
self.cloud=UIObject.get(self,10)
self.levelUpBtnText=UIText.get(self,11)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIWuDaoTangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scoreProgress);self.scoreProgress=nil;
_UIObject_release(self.disGrid);self.disGrid=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.levelTxt);self.levelTxt=nil;
_UIObject_release(self.levelupPanel);self.levelupPanel=nil;
_UIObject_release(self.pointIcon);self.pointIcon=nil;
_UIObject_release(self.progressTips);self.progressTips=nil;
_UIObject_release(self.planIcon);self.planIcon=nil;
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.costTimeText);self.costTimeText=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
end
















local _Ease=DG.Tweening.Ease
local wudaoState={
eNone=1,
eDoing=2,
eRewrad=3,
}
local wudaoDiscipleState={
eDoing=1,
eFight=2,
eDispatch=3,
eRewrad=4,
}
local myTimer=nil
local _this=nil
local maxMan=3
local orderList={2,1,3}
local orderListtwo={3,1,2}


function UIWuDaoTangWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)


local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.cloud:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)
end


function UIWuDaoTangWin:__delete()
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end

self.backEffect:setChildShowEffect(10003,false)
self:unbindComponents()
self:clearProgressAnim()
self.disWidget=nil
_this=nil
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function UIWuDaoTangWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if _this==nil then return end
if etype==buildingEvent.levelUpStart then
_this:refreshLevelView()
elseif etype==buildingEvent.levelUpComplete then
_this:refreshLevelView()
elseif etype==buildingEvent.speedUpComplete then
_this:refreshLevelView()
end
end


function UIWuDaoTangWin:onHide()

end

function UIWuDaoTangWin:clearMyTimer()
if myTimer then
self:stopTimerByID(myTimer)
myTimer=nil
end
end




function UIWuDaoTangWin:onShow(argtable,afterOnloaded)

self.entityID=argtable.entityID
self.sfId=mapIdType.zhufeng
self.bdData=zongmenModel:findBuildingByEntityId(self.entityID)

if self.disWidget==nil then
self.disWidget={}
local grid=self.disGrid:getChildCommonLayoutGroupWidgetList()
local disDatas=wudaotangModel:getDisDatas()
if disDatas and disDatas[2]and disDatas[2].idx==2 then
orderList={2,1,3}
end
if disDatas and disDatas[2]and disDatas[2].idx==3 then
orderList={2,3,1}
end
for i=1,maxMan do
local idx=orderList[i]
self.disWidget[i]=grid[idx-1]
end
end
self.curManNum=wudaotangModel:getManCount()
self.wdState=self:getwdSatet()
self.wdDiscipleStateList={}
self:refreshView()
self:refreshLevelView()
end

function UIWuDaoTangWin:getwdSatet()
if not wudaotangModel:hasPlan()then
return wudaoState.eNone
end
local buildLv=self.bdData.level
if wudaotangModel:checkHasReward(buildLv)then
return wudaoState.eRewrad
end
return wudaoState.eDoing
end

function UIWuDaoTangWin:getDiscipleState(index)
if self.wdState==wudaoState.eRewrad then
return wudaoDiscipleState.eRewrad
end
local data=wudaotangModel:getDisDataByIndex(index)
if data then
if UIDiscipleModel:checkDiscipleState2(data.guid,DISCIPLE_STATE_TYPE.edsDispatch)then
return wudaoDiscipleState.eDispatch
end
if UIDiscipleModel:checkDiscipleState2(data.guid,DISCIPLE_STATE_TYPE.eWuDaoRuMo)then
return wudaoDiscipleState.eFight
end



end
return wudaoDiscipleState.eDoing
end

function UIWuDaoTangWin:timerUpdate()
self.wdState=self:getwdSatet()

for i=1,self.curManNum do
local old=self.wdDiscipleStateList[i]
local cur=self:getDiscipleState(i)
self.wdDiscipleStateList[i]=cur
if old~=cur or cur==wudaoDiscipleState.fight then
local data=wudaotangModel:getDisDataByIndex(i)
self:refreshDiscipleItem(i,data)
end
end
self:flyPointCheck()
self:refreshCostTime()
end

function UIWuDaoTangWin:refreshView()

if self.disWidget then
self.disWidget={}
local grid=self.disGrid:getChildCommonLayoutGroupWidgetList()
local disDatas=wudaotangModel:getDisDatas()
if disDatas and disDatas[2]and disDatas[2].idx==2 then
orderList={2,1,3}
end
if disDatas and disDatas[2]and disDatas[2].idx==3 then
orderList={2,3,1}
end
for i=1,maxMan do
local idx=orderList[i]
self.disWidget[i]=grid[idx-1]
end
end

local hasPlan=self.wdState~=wudaoState.eNone

self:initProgress()
if hasPlan then
self:refreshProgress()
end

self:initDisciplesView()

self:clearMyTimer()

if self.wdState==wudaoState.eDoing then
self:freshProduceTimeProgress(true)
local func=function(...)
self:timerUpdate()
end
myTimer=self:setTimer(1,0,func)
self:timerUpdate()
end


local showEffect=hasPlan and self.wdState==wudaoState.eDoing
self.backEffect:setChildShowEffect(10071,showEffect)
end

function UIWuDaoTangWin:initProgress()
local showprogres=true
if self.wdState==wudaoState.eNone then
showprogres=false
end
self.scoreProgress:setActive(showprogres)
self.progressTips:setActive(not showprogres)

self.rewardBtn:setActive(showprogres)
if showprogres then
local iconname=wudaotangModel:getPlanIcon(wudaotangModel:getPlan())
self.planIcon:setImageIcon(iconname,true)
end
end

function UIWuDaoTangWin:refreshProgress(playAnim)
local buildLv=self.bdData.level
local cur,max=wudaotangModel:getCurPlanProgress(buildLv)
cur=math.floor(cur)
if cur>max then
cur=max
end
if playAnim then
self.scoreProgress:setProgress(cur,max)
else
self.scoreProgress:setProgressValue(cur,max)
end
local str=FMT.fmt('{0}/{1}',cur,max)
self.scoreProgress:setChildProgressText(str)
end

function UIWuDaoTangWin:refreshCostTime()
local isshow=false
if self.wdState==wudaoState.eDoing then
isshow=true
end
self.costTimeText:setActive(isshow)
if isshow then
local disDatas=wudaotangModel:getDisDatas()
local speed=0
for i,v in ipairs(disDatas)do
speed=speed+wudaotangModel:getDisciplePointSpeedEx(v.guid)
end
local time_str
if speed>0 then
local buildLv=self.bdData.level
local cur,max=wudaotangModel:getCurPlanProgress(buildLv)
local lerp=max-cur
if lerp<0 then lerp=0 end
local time=math.ceil(lerp/speed)
local passTime=wudaotangModel:getPassTime()
local delay=wudaotangModel:getTimerDelay()
local multi=math.floor(passTime/delay)
local npassTime=multi*delay
local offset=passTime-npassTime
time=time-offset
if time<0 then time=0 end
time_str=FMT.fmt('约{0}',timeHelper.format_time_stamp13(time))
else
time_str='暂停中'
end
self.costTimeText:setText(time_str)
end
end

function UIWuDaoTangWin:initDisciplesView()
local disDatas
local hasPlan=self.wdState~=wudaoState.eNone
if hasPlan then
disDatas=wudaotangModel:getDisDatas()
else
disDatas={}
end
local cnt=#disDatas
for i=1,maxMan do
local data=disDatas[i]
self.wdDiscipleStateList[i]=self:getDiscipleState(i)
local widget=self.disWidget[i]

widget:SetChildCSImageSprite(13,globalABLookup.hud_atlas,'icon_zhaomucs')


if false then

local widget=self.disWidget[i]
widget:SetChildActive(6,false)
widget:SetChildActive(3,false)
widget:SetChildActive(11,false)
widget:SetChildActive(12,false)
widget:SetChildActive(15,false)
else
self:refreshDiscipleItem(i,data)
end
end
end

function UIWuDaoTangWin:refreshDiscipleItem(index,data)
local widget=self.disWidget[index]
local state
local hasDis=data~=nil
local showDispatch=false
local showEffect=false
if hasDis then
state=self.wdDiscipleStateList[index]
showDispatch=state==wudaoDiscipleState.eDispatch
end

local showDis=hasDis and not showDispatch

widget:SetChildActive(6,showDis)
if showDis then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(6,sortLayer,sortOrder+2)

local isfight=state==wudaoDiscipleState.eFight
showEffect=isfight

widget:SetChildUIModelRemoveTarget(0)
local modelParams=self:getModelInfo(data.guid)

if state==wudaoDiscipleState.eDoing then
if deviceHelper.getAPILevel()>=3 and modelParams.componets[1]~=nil then
widget:SetChildUIModelShowTarget(0,modelParams.ChangeBody,modelParams.scale,nil,modelParams.anim,false,false)
widget:SetChildAddSkeletonSlot(0,"tou1","head",modelParams.componets[1])
else
widget:SetChildUIModelShowTarget(0,modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false)
end

else

widget:SetChildUIModelShowTarget(0,modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false)
end
widget:SetChildUIModelShowTargetOffset(0,0,-80)
local biaoqing=0
if state==wudaoDiscipleState.eDoing then
biaoqing=11
elseif state==wudaoDiscipleState.eFight then
biaoqing=2
elseif state==wudaoDiscipleState.eRewrad then
biaoqing=7
end
if deviceHelper.getAPILevel()>=3 and modelParams.componets[1]~=nil then

else

end

widget:SetChildActive(2,isfight)

widget:SetChildActive(1,state==wudaoDiscipleState.eDoing)

local isReward=state==wudaoDiscipleState.eRewrad
local showTalk=isReward or isfight
widget:SetChildActive(5,showTalk)
if showTalk then
local talkicon
if isReward then
talkicon='icon_sjgantanhao'
else
talkicon='icon_zhandou'
end
widget:SetChildCSImageSprite(9,globalABLookup.global,talkicon)
end

widget:SetChildButtonClickWithID(15,function(idx)
self:onChangeDiscipleClick(idx,data)
end,index)
end

widget:SetChildActive(12,hasDis)
widget:SetChildActive(13,hasDis)
if hasDis then
local name_str=UIDiscipleModel:getDiscipleName(data.guid)
widget:SetChildText(12,name_str)
end

widget:SetChildActive(3,not hasDis)

widget:SetChildActive(15,hasDis)

widget:SetChildActive(16,hasDis)

widget:SetChildActive(11,showDispatch)

widget:SetChildShowEffect(14,10074,showEffect)

widget:SetChildButtonClickWithID(4,function(idx)
self:onDiscipleClick(idx,hasDis,data)
end,index)

local isfight=state==wudaoDiscipleState.eFight
if isfight and hasDis then

widget:SetChildActive(15,false)

widget:SetChildActive(16,false)
end

if self.wdState==wudaoState.eRewrad then

widget:SetChildActive(3,false)

widget:SetChildActive(15,false)

widget:SetChildActive(16,false)
end
end


function UIWuDaoTangWin:getModelInfo(guid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(guid,false,1)

local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local bodyid=imageInfo.sex==SEX_TYPE.eMale and 50001 or 50002
modelParams.ChangeBody=cfgHelper.get2(cfg_disciplebodyimageconfig_get,bodyid,'out_side')

return modelParams
end

function UIWuDaoTangWin:freshProduceTimeProgress(init)
local delay=wudaotangModel:getTimerDelay()
local numRate
local lerp
if init then

local pass=wudaotangModel:getPassTime()
local cur=pass%delay
lerp=delay-cur
numRate=cur/delay
else
numRate=0
lerp=delay
end
self:clearProgressAnim()
for i=1,self.curManNum do
local widget=self.disWidget[i]
local state=self.wdDiscipleStateList[i]
local isshow=state==wudaoDiscipleState.eDoing
if isshow then
widget:SetChildIconFillAmount(10,numRate)
local func=function()
widget:SetChildIconFillAmount(10,0)
end
local tw=widget:SetChildImageDOFillAmount(10,1,lerp,func)
self.disWidgetProgressAnim[i]=tw
end
end
local func1=function()
self:nextProduce()
end
self:delayDo(lerp,func1)
end

function UIWuDaoTangWin:clearProgressAnim()
if self.disWidgetProgressAnim then
for k,v in pairs(self.disWidgetProgressAnim)do
if not v:IsComplete()then
v:OnComplete(nil)
v:Complete()
end
end
end
self.disWidgetProgressAnim={}
end

function UIWuDaoTangWin:nextProduce()
if self.wdState==wudaoState.eDoing then
self:freshProduceTimeProgress()
end
end

function UIWuDaoTangWin:flyPointCheck()
if(self.wdState==wudaoState.eDoing or self.wdState==wudaoState.eRewrad)and wudaotangModel:isProduce()then
self:flyPoint()
end
end

function UIWuDaoTangWin:flyPoint()
local e_pos=self.pointIcon:getChildPosition()
self.flying=true
local count=0
for i=1,self.curManNum do
local idx=i
local widget=self.disWidget[idx]
local state=self.wdDiscipleStateList[idx]
if state==wudaoDiscipleState.eDoing then
count=count+1
local b_pos=widget:GetChildPosition(7)
widget:SetChildPosition(8,b_pos)
widget:SetChildActive(8,true)
local func=nil
if count==1 then
func=function()
widget:SetChildActive(8,false)
self:flyPointEnd()
end
else
func=function()
widget:SetChildActive(8,false)
end
end
local tweener=widget:SetChildDOMove(8,e_pos,0.5,func)
tweener:SetEase(_Ease.Linear)
end
end
if count<=0 then
self:flyPointEnd()
end
end

function UIWuDaoTangWin:flyPointEnd()
self.flying=false
if self.wdState==wudaoState.eRewrad then
self:initDisciplesView()
self:clearMyTimer()
end
self:refreshProgress(true)
end

function UIWuDaoTangWin:checkFinish()

end

function UIWuDaoTangWin:onDiscipleClick(idx,hasDis,data)


if self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('升级中不能悟道')
return
end

if self.wdState==wudaoState.eNone then
local entityid=self.entityID
local winParams={
titleName='选择弟子',
extraWin='UIWuDaoTangSelectWin',
extraParams={entityID=entityid},
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)

elseif self.wdState==wudaoState.eDoing and not hasDis then
local diziindex=idx
if orderList[idx]then
diziindex=orderList[idx]
if orderList[idx]==1 then
diziindex=orderList[idx]+1
end
end
if data and data.idx then
diziindex=data.idx
end

local entityid=self.entityID
local winParams={
titleName='选择弟子',
extraWin='UIWuDaoTangChangeSelectWin',
extraParams={entityID=entityid,dizii_index=diziindex,dizii_data=data},
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)

elseif self.wdState==wudaoState.eRewrad then
wudaotangController:reqReward(0)
else
if idx>self.curManNum then
return
end
local state=self.wdDiscipleStateList[idx]
local data=wudaotangModel:getDisDataByIndex(idx)
if state==wudaoDiscipleState.eFight then
local fight_guid=data.guid
local func=function()
wudaotangController:doReqFight(fight_guid)
end
timeEventController.delayDo(0.2,func)
fullScreenUI.closeActiveUI()
end
end
end

function UIWuDaoTangWin:rec_plan(planid)
self.curManNum=wudaotangModel:getManCount()
self.wdState=self:getwdSatet()
self:refreshView()
end

function UIWuDaoTangWin:rec_planOver()
self.curManNum=wudaotangModel:getManCount()
self.wdState=self:getwdSatet()
self:refreshView()
end


function UIWuDaoTangWin:onLevelUp()
local hasPlan=self.wdState~=wudaoState.eNone
if hasPlan then
UIManager.error('悟道中不能升级')
return
end
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end

function UIWuDaoTangWin:onSpeedUp()
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end

function UIWuDaoTangWin:refreshLevelView()
local buildLv=self.bdData.level
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.levelTxt:setText(FMT.fmt('{0}级{1}',self.bdData.level,bdCfg.name))

local showUpgrad=false
self.nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,buildLv+1)
self.levelUpBtnText:setText(self.nextLvCfg~=nil and'升级'or'建筑信息')
if self.nextLvCfg then
if self.bdData.flag==buildingStateType.eUpgrading then
showUpgrad=true
end
end
self.levelupPanel:setActive(showUpgrad)
if showUpgrad then
self:refreshUpgradePanel()
else
self:stopTimerByName('levelUpTimer')
end
end

function UIWuDaoTangWin:refreshUpgradePanel()
self:stopTimerByName('levelUpTimer')
local widget=self.levelupPanel:getChildWidgetBase()
local hasTimer=false
local beginTime=self.bdData.begintime
if beginTime>0 then
local upgrade_need_time=self.nextLvCfg.uplevel_times
local delta_time=gameUtilityModel.getServerShortTime()-beginTime+self.bdData.reducetime
local ctime=upgrade_need_time-delta_time
if ctime>0 then
hasTimer=true
local endtime=os.time()+ctime
local tick=function()
local dtime=endtime-os.time()
if dtime>0 then
self:refreshLevelupTime(timeHelper.format_time_stamp4(dtime))
else
self:refreshUpgradePanel()
end
end
tick()
self.levelUpTimer=self:setTimer(1,0,tick)
self:refreshLevelupTime(timeHelper.format_time_stamp4(endtime-os.time()))
end
end

widget:SetChildActive(0,hasTimer)

local btn_str=hasTimer==true and'加速'or'完成升级'
widget:SetChildText(2,btn_str)
if hasTimer~=true then
self.levelUpBtnText:setText("完成升级")
end
end

function UIWuDaoTangWin:refreshLevelupTime(str)
local widget=self.levelupPanel:getChildWidgetBase()
widget:SetChildText(1,str)
end



function UIWuDaoTangWin:onQuestion()
local d={}
d.title='规则介绍'
d.mode=3
d.name='wudaotang_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIWuDaoTangWin:onRewardBtn()
UIManager:showWindow('UIWuDaoBoxRewardWin')
end


function UIWuDaoTangWin:onChangeDiscipleClick(idx,data)
if self.wdState==wudaoState.eDoing then
local entityid=self.entityID
local winParams={
titleName='更换弟子',
extraWin='UIWuDaoTangTieHuanSelectWin',
extraParams={entityID=entityid,dizii_index=data.idx,is_qihuan=true,dizii_data=data},
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end
end
