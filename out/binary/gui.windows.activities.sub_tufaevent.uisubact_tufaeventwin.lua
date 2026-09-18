







def_class("UISubAct_tufaEventWin",UIWindowBase)









function UISubAct_tufaEventWin:bindComponents()

self.timeText=UIText.get(self,0)
self.title=UIImage.get(self,1)
self.infoText=UIText.get(self,2)
self.rewardList=UIObject.get(self,3)
self.infoBg=UIObject.get(self,4)
self.showModel=UIObject.get(self,5)
self.modelClick=UIButton.get(self,6)
self.bgModel=UIObject.get(self,7)

self.modelClick:setButtonClick(function()self:onModelClick()end)



end


function UISubAct_tufaEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.infoText);self.infoText=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.infoBg);self.infoBg=nil;
_UIObject_release(self.showModel);self.showModel=nil;
_UIObject_release(self.modelClick);self.modelClick=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local _this
local clickModelCd=1.5




function UISubAct_tufaEventWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_tufaEventWin:__delete()
self:clearTimer()
self:clearDelayClickTimer()
self.isClickModel=nil
self:unbindComponents()
_this=nil
end




function UISubAct_tufaEventWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self.itemList=self.config.showRewards
self.isClickModel=nil


self:refreshBgModel()

self:refresh()
end


function UISubAct_tufaEventWin:onHide()
self:clearTimer()
self:clearDelayClickTimer()
end

function UISubAct_tufaEventWin:refresh()

local abName="ui/windows/activities/sub_tufaevent/tufaeventact_atlas_pak.ab"
local iconname=self.config.titleImage
if iconname then
self.title:setSprite(abName,iconname)
self.title:setActive(true)
else
self.title:setActive(false)
end


if self.config.infoDesc then
self.infoText:setText(self.config.infoDesc)
self.infoText:setActive(true)
self.infoBg:setActive(true)
else
self.infoText:setActive(false)
self.infoBg:setActive(false)
end


local grids=self.rewardList:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local reward=self.itemList[i]
if reward then
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end


self.clickAnimIdList={}
local showModelPram=self.config.showModelPram
if showModelPram then
self.showModel:setActive(true)
local modelId=showModelPram.modelId
if modelId then
local offset=showModelPram.offset or{0,0}
local size=showModelPram.size or 1
local animId=showModelPram.animId or eAnimationID.stand
local isFlip=showModelPram.isFlip and showModelPram.isFlip==1 or false
self.showModel:setChildUIModelShowTarget(modelId,size,{},animId,false,false,0.5)
self.showModel:setChildUIModelShowTargetOffset(offset[1],offset[2])
self.showModel:setChildUIModelShowFlipX(isFlip)
else
logErr(FMT.fmt("活动id: {0}, 活动类型: {1}, 子活动id: {2}配置了展示模型参数 但找不到对应的模型id 请检查配置是否正确",self.activityId,self.subType,self.subId))
end

local clickModelPram=self.config.clickModelPram
if not clickModelPram then

self.modelClick:setActive(false)
else
self.modelClick:setActive(true)

local width=clickModelPram.width or 100
local height=clickModelPram.height or 100
self.modelClick:setChildSizeDelta(width,height)

local offset=clickModelPram.offset or{0,0}
self.modelClick:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))

self.clickAnimIdList=clickModelPram.animIdList
end
else
self.showModel:setActive(false)
end


self:setRemainingTimeTimer()
end


function UISubAct_tufaEventWin:refreshBgModel()
local bgModelId=self.config.bgModelId
if bgModelId then
local animId=eAnimationID.stand
self.bgModel:setChildUIModelShowTarget(bgModelId,1,{},animId,false,false,0)
self.bgModel:setActive(true)
else
self.bgModel:setActive(false)
self.bgModel:setChildUIModelRemoveTarget()
end
end


function UISubAct_tufaEventWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("<color=#f1ce78>活动剩余时间：</color>{0}",timeHelper.format_time_stamp11(lerp,true)))

else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()

end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_tufaEventWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_tufaEventWin:clearDelayClickTimer()
if self.delayClickTimer then
self:stopTimerByID(self.delayClickTimer)
end
end


function UISubAct_tufaEventWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end


function UISubAct_tufaEventWin:onModelClick()
if not self.clickAnimIdList or not next(self.clickAnimIdList)then

logErr(FMT.fmt("活动id: {0}, 活动类型: {1}, 子活动id: {2}配置了展示模型点击参数 但找不到对应的点击动作id 请检查配置是否正确",self.activityId,self.subType,self.subId))
return
end


local clickAnimIdCount=#self.clickAnimIdList
local animId
if clickAnimIdCount>1 then
local randomIndex=math.random(1,clickAnimIdCount)
animId=self.clickAnimIdList[randomIndex]
else
animId=self.clickAnimIdList[1]
end

if not self.isClickModel then

self.showModel:setChildModelAnimationState(animId)
self:clearDelayClickTimer()
self.isClickModel=true
self.delayClickTimer=self:delayDo(clickModelCd,function()
_this.isClickModel=false
end)
end
end

