







def_class("UISubAct_YXJMrewardWin",UIWindowBase)









function UISubAct_YXJMrewardWin:bindComponents()

self.rewardList=UIObject.get(self,0)
self.black=UIButton.get(self,1)
self.centerPanel=UIObject.get(self,2)
self.bgModel=UIObject.get(self,3)

self.black:setButtonClick(function()self:onBlack()end)



end


function UISubAct_YXJMrewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.black);self.black=nil;
_UIObject_release(self.centerPanel);self.centerPanel=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local _this



function UISubAct_YXJMrewardWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_YXJMrewardWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_YXJMrewardWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
if not self.sub_actInfo then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.startday=self.sub_actInfo.start_day_idx
self.start_time=self.sub_actInfo.start_time
self.end_time=self.sub_actInfo.end_time
self.subcfg=cfg_lanternriddlesconfig_get(self.subid)

self.centerPanel:setChildCanvasGroupAlpha(0)
local idx=self.sub_actInfo:getOpenDayIndex()
local cfg_questions=self.subcfg.questions
local reward={}
if idx and idx>0 and cfg_questions[idx]then
reward=cfg_questions[idx][2]
end
if reward and next(reward)then
local len=#reward
local widget=self.rewardList:getWidgetBase()
for i=1,len do
local rewardItem=widget:GetChildWidgetBase(i-1)
local rewards=reward[i]
local itemid=rewards[1]
local itemnum=rewards[2]
local graynum=0
local itemcount=mathHelper.formatNumber7(itemnum,nil,2)
local conf={itemid=itemid,itemcount=itemcount,showCountBG=true,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(1,prop)
rewardItem:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
self.bgModel:setChildUIModelShowTarget(6096,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(0.2,function()
if _this==nil then return end
self.centerPanel:setChildCanvasGroupDOFade(1,0.3,nil)
end)
end)


end


function UISubAct_YXJMrewardWin:onHide()

end

function UISubAct_YXJMrewardWin:onBlack()
self:closeSelf()
end


function UISubAct_YXJMrewardWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end
