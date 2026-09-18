







def_class("UISubAct_ZhongLiXieXinWin",UIWindowBase)









function UISubAct_ZhongLiXieXinWin:bindComponents()

self.mbg=UIObject.get(self,0)
self.progressText=UIText.get(self,1)
self.rankBtn=UIButton.get(self,2)
self.recordBtn=UIButton.get(self,3)
self.recordReddot=UIObject.get(self,4)
self.rewardDesc=UIObject.get(self,5)
self.rewardList=UIObject.get(self,6)
self.rewardPanel=UIObject.get(self,7)
self.rewardReddot=UIObject.get(self,8)
self.root=UIObject.get(self,9)
self.ruleBtn=UIButton.get(self,10)
self.startBtn=UIButton.get(self,11)
self.startReddot=UIObject.get(self,12)
self.timeTxt=UIText.get(self,13)
self.topDesc=UIText.get(self,14)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)



end


function UISubAct_ZhongLiXieXinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.recordReddot);self.recordReddot=nil;
_UIObject_release(self.rewardDesc);self.rewardDesc=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.startReddot);self.startReddot=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.topDesc);self.topDesc=nil;
end
















local _this




function UISubAct_ZhongLiXieXinWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_ZhongLiXieXinWin:__delete()
self:unbindComponents()
self:endAllReddotPunchRotation()
_this=nil
end




function UISubAct_ZhongLiXieXinWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
if not self.sub_actInfo then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.startday=self.sub_actInfo.start_day_idx
self.start_time=self.sub_actInfo.start_time
self.end_time=self.sub_actInfo.end_time

self.topDesc:setText(cfgHelper.getlang("zlxx_top_desc"))

self:refreshActivityTime()
self:refreshAll()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6221,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end


function UISubAct_ZhongLiXieXinWin:onHide()

end

function UISubAct_ZhongLiXieXinWin:refreshAll()
self:refreshInfo()
self:refreshReward()
self:refreshProgress()
self:refreshRecordReddot()
end

function UISubAct_ZhongLiXieXinWin:refreshRecordReddot()
local isRed=self.sub_actInfo:checkRecordReddot()
self.recordReddot:setActive(isRed)
self.recordReddotIndex=self:doPunchRotation(self.widget,self.recordReddot:getID(),self.recordReddotIndex,isRed)
end

function UISubAct_ZhongLiXieXinWin:refreshInfo()
local curDay=self.sub_actInfo:getCurDay()
self.recordBtn:setActive(curDay>1)
end

function UISubAct_ZhongLiXieXinWin:refreshReward()
local curDay=self.sub_actInfo:getCurDay()
local ques=self.sub_actcfg.ques_list[curDay]
self.rewardPanel:setActive(ques~=nil)
self.rewardDesc:setActive(ques~=nil)
self.startBtn:setActive(ques~=nil)
if ques~=nil then
local rewards=ques[2]

local isGet=self.sub_actInfo:getIsDailyGet()
local canGet=self.sub_actInfo:checkRewardReddot()
self.rewardReddot:setActive(canGet)
self.rewardReddotIndex=self:doPunchRotation(self.widget,self.rewardReddot:getID(),self.rewardReddotIndex,canGet)

local bindItem=function(index)
local widget=self.rewardList:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local count=data[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=data[2]
end
local grayNum=isGet and 1 or 0
local prop=itemsComponentHelper.getCommonFillDataSmall({itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,gray=grayNum})
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
if canGet then
_this.sub_actInfo:reqGetReward()
else
itemsComponentHelper.onItemClick(...)
end
end)

widget:SetChildActive(1,canGet)
widget:SetChildActive(2,isGet)
end
self.rewardList:setChildLayoutGroupCreateItems(#rewards,bindItem)
else
self.rewardReddot:setActive(false)
self.rewardReddotIndex=self:doPunchRotation(self.widget,self.rewardReddot:getID(),self.rewardReddotIndex,false)
end
end

function UISubAct_ZhongLiXieXinWin:refreshProgress(isRecv)
local curDay=self.sub_actInfo:getCurDay()
local ques=self.sub_actcfg.ques_list[curDay]
if not ques then
self.startReddot:setActive(false)
self.startReddotIndex=self:doPunchRotation(self.widget,self.startReddot:getID(),self.startReddotIndex,false)
return
end
local cur,max=self.sub_actInfo:getCurProgress()

local colorStr=cur>=max and"#549327"or"#c82c2c"
self.progressText:setText(FMT.fmt("已答 <color={0}>{1}</color>/{2}题",colorStr,cur,max))

local quesReddot=self.sub_actInfo:checkQuesReddot()
self.startReddot:setActive(quesReddot)
self.startReddotIndex=self:doPunchRotation(self.widget,self.startReddot:getID(),self.startReddotIndex,quesReddot)

if isRecv and cur>=max then
self:refreshReward()
end
end


function UISubAct_ZhongLiXieXinWin:refreshActivityTime()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.end_time and self.end_time-nowTime or 0
if lerp>0 then

self.timeTxt:setText(FMT.fmt("<color=#f1ce78>结束倒计时：</color>{0}",timeHelper.format_time_stamp3(lerp,true)))
else
self.timeTxt:setText("活动已结束")
UIManager.error("活动已结束")
self.isOver=true
self:clearTimer()
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UISubAct_ZhongLiXieXinWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end






function UISubAct_ZhongLiXieXinWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UISubAct_ZhongLiXieXinWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end




function UISubAct_ZhongLiXieXinWin:onRankBtn()
local args={}
args.act_id=self.actID
args.sub_act_type=self.subType
args.sub_act_id=self.subid
self:showWindow("UISubAct_ZhongLiXieXinRankWin",args)
end



function UISubAct_ZhongLiXieXinWin:onRecordBtn()
local curDay=self.sub_actInfo:getCurDay()
local args={}
args.act_id=self.actID
args.sub_act_type=self.subType
args.sub_act_id=self.subid
args.day=curDay-1
self:showWindow("UISubAct_ZhongLiXieXinDaTiTipsWin",args)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSubZLXXRecordReddot,true)
self:refreshRecordReddot()

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
end



function UISubAct_ZhongLiXieXinWin:onStartBtn()
local curDay=self.sub_actInfo:getCurDay()
local args={}
args.act_id=self.actID
args.sub_act_type=self.subType
args.sub_act_id=self.subid
args.day=curDay
self:showWindow("UISubAct_ZhongLiXieXinDaTiTipsWin",args)
end



function UISubAct_ZhongLiXieXinWin:onRuleBtn()
local d={}
d.title='规则'
d.mode=3
d.name='ZhongLiXieXin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end
