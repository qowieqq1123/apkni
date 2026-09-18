







def_class("UIXingYuMainWin",UIWindowBase)









function UIXingYuMainWin:bindComponents()

self.rightArrow=UIButton.get(self,0)
self.leftArrow=UIButton.get(self,1)
self.rewardBtn=UIButton.get(self,2)
self.recordBtn=UIButton.get(self,3)
self.teamBtn=UIButton.get(self,4)
self.timebg=UIObject.get(self,5)
self.timeTxt=UIText.get(self,6)
self.titleTxt=UIText.get(self,7)
self.root=UIObject.get(self,8)
self.titleTimeTxt=UIText.get(self,9)
self.effectgrid=UIGameobjectClone.new(self,10)
self.stateItem_1=UIObject.get(self,11)
self.stateItem_2=UIObject.get(self,12)
self.stateItem_3=UIObject.get(self,13)
self.maskBtn=UIButton.get(self,14)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.teamBtn:setButtonClick(function()self:onTeamBtn()end)

self.maskBtn:setButtonClick(function()self:onMaskBtn()end)
self.stateItem={
self.stateItem_1,
self.stateItem_2,
self.stateItem_3,
}



end


function UIXingYuMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.teamBtn);self.teamBtn=nil;
_UIObject_release(self.timebg);self.timebg=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleTimeTxt);self.titleTimeTxt=nil;
self.effectgrid:deleteSelf();self.effectgrid=nil;
_UIObject_release(self.stateItem_1);self.stateItem_1=nil;
_UIObject_release(self.stateItem_2);self.stateItem_2=nil;
_UIObject_release(self.stateItem_3);self.stateItem_3=nil;
_UIObject_release(self.maskBtn);self.maskBtn=nil;
self.stateItem=nil;
end















local stateItemCmp={
name=0,
ing=1,
endFlag=2,
click=3,
}



function UIXingYuMainWin:onLoaded(...)
self:bindComponents()
self.trigerFlagList={}
for i,v in ipairs(self.stateItem)do
local widget=v:getWidgetBase()
widget:SetChildButtonClick(stateItemCmp.click,function()
self:onClickState(i)
end)
end
end


function UIXingYuMainWin:__delete()
local xyId=self.teamXingYuList[self.selectIndex]
XingYuController.req_35_109(xyId)
self.trigerFlagList=nil
self:unbindComponents()
self:stopTimer()
if UIFullXingYuController.fightStage then
UIFullXingYuController.fightStage:close()
UIFullXingYuController.fightStage=nil
end
end




function UIXingYuMainWin:onShow(argtable,afterOnloaded)

local xyId=argtable and argtable.xyId or nil
local popWin=argtable and argtable.popWin or nil
if popWin then
self:showWindow(popWin.winName,popWin.winArgs)
end
if XingYuController.replayFlag then
XingYuController.req_35_107(xyId)
elseif afterOnloaded then
loadingControl.closeCloud()
end

self.teamXingYuList=XingYuController.getHasTeamXingYuList()
if not next(self.teamXingYuList)then
logErr("UIXingYuMainWin teamXingYuList 空表")
return
end

self.maxIndex=#self.teamXingYuList
local listIndex
if xyId then
for i,v in ipairs(self.teamXingYuList)do
if xyId==v then
listIndex=i
break
end
end
end
self.selectIndex=listIndex or 1

self:startTimer(function()
self:update()
end)

self:refreshView()
if afterOnloaded then
self:refreshRoot()
end
end


function UIXingYuMainWin:onHide()

end

function UIXingYuMainWin:onShowArgRecv(argtable)

self:onShow(argtable)
end

function UIXingYuMainWin:update()
local xyId=self.teamXingYuList[self.selectIndex]
local state,endTime=XingYuController.getXingYuState(xyId)

if self.lastState~=state then
self:stateChange(state)




self.lastState=state
end
self:refreshRoundTime(xyId,state)
self:refreshTitle(state,endTime)
local lerp=XingYuController.getNextTSRewardLerpTime()
if lerp==0 then

self:GetReward()
end
if state==XingYuState.eTanSuo and lerp then
self.timebg:setActive(true)
local str=FMT.fmt("<color=#f1ce78>{0}后</color>\n获得探索奖励",timeHelper.format_time_stamp3(lerp))
self.timeTxt:setText(str)
else
self.timebg:setActive(false)
end
end

function UIXingYuMainWin:refreshView()
self.rightArrow:setActive(self.selectIndex>1)
self.leftArrow:setActive(self.selectIndex<self.maxIndex)


self:refreshStateItem()
self:update()
end

function UIXingYuMainWin:refreshTitle(state,endTime)
local str=""
local curTime=timeHelper.getServerShortTime()
local lerp=0
if state==XingYuState.eDataErr or
state==XingYuState.eNone then
lerp=-1
elseif state==XingYuState.eTanSuo then
str="探索期结束："
lerp=endTime-curTime
elseif state==XingYuState.eHunZhan then
str="混战期结束："
lerp=endTime-curTime
elseif state==XingYuState.eZhenDuo then
str="争夺期结束："
lerp=endTime-curTime
elseif state==XingYuState.eFinish then
str="星域消失："
lerp=endTime-curTime
end
if lerp<0 then
lerp=0
end
local timeStr=timeHelper.format_time_stamp3(lerp)





self.titleTxt:setText(str)
self.titleTimeTxt:setText(timeStr)
end

function UIXingYuMainWin:refreshRoundTime(xyId,state)

if not self.trigerFlagList[xyId]then
self.trigerFlagList[xyId]={}
end


if state==XingYuState.eHunZhan then
local nextHzRound=XingYuController.getHZNextRoundEx(xyId)

if nextHzRound then
local curTime=timeHelper.getServerShortTime()
local nextStartTime=XingYuController.getHZRoundFightTime(nextHzRound)
local keyStr=string.format("hz_%d",nextHzRound)
if nextStartTime<=curTime and curTime<=nextStartTime+2 and not self.trigerFlagList[xyId][keyStr]then
self.trigerFlagList[xyId][keyStr]=true

UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","checkOpenCloud",nextHzRound)
UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","reqAllRivalInfo")








end
end
elseif state==XingYuState.eZhenDuo then
local nextzdzRound=XingYuController.getZDZNextRoundEx(xyId)

if nextzdzRound then
local curTime=timeHelper.getServerShortTime()
local nextStartTime=XingYuController.getZDRoundFightTime(nextzdzRound)
local keyStr=string.format("zdz_%d",nextzdzRound)

if nextStartTime<=curTime and curTime<=nextStartTime+2 and not self.trigerFlagList[xyId][keyStr]then
self.trigerFlagList[xyId][keyStr]=true

UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","checkOpenCloud",nextzdzRound)
UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","reqAllRivalInfo")
end
end
end

end


function UIXingYuMainWin:refreshRoot()
local xyId=self.teamXingYuList[self.selectIndex]
local state,endTime=XingYuController.getXingYuState(xyId)
self.timebg:setActive(state==XingYuState.eTanSuo and XingYuController.getNextTSRewardLerpTime()~=nil)
if state==XingYuState.eTanSuo then
self:showWindow("UIXingYuTanSuoWin",{xyId=xyId})

elseif state==XingYuState.eHunZhan or
state==XingYuState.eZhenDuo or
state==XingYuState.eFinish then
self:showWindow("UIXingYu_HZ_ZDWin",{xyId=xyId})

else
return
end
end

function UIXingYuMainWin:refreshStateItem()
local xyId=self.teamXingYuList[self.selectIndex]
local state,endTime=XingYuController.getXingYuState(xyId)
for i,v in ipairs(self.stateItem)do
local widget=v:getWidgetBase()
widget:SetChildActive(stateItemCmp.ing,state==i)
widget:SetChildActive(stateItemCmp.endFlag,state>i)
end

end

function UIXingYuMainWin:stateChange(state)

self:refreshStateItem()
if self.lastState==XingYuState.eTanSuo and state==XingYuState.eHunZhan then


local xyId=self.teamXingYuList[self.selectIndex]





local func=function(argstableEx)
fightManager.setState(2)
fightManager.setCameraActive(true,fightCameraMode.fight)
UIFullXingYuController.fightStage=argstableEx.fightStage


loadingControl.closeCloud()
end
local startCallback=function()
fightManager.setCameraActive(false,fightCameraMode.fight)
self:closeWindow("UIXingYuTanSuoWin")
self:showWindow("UIXingYu_HZ_ZDWin",{xyId=xyId})
self:refreshView()
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local stage=xyCfg.stage
fightStage:create(stage,func,{})
end
loadingControl.openCloud(startCallback)

elseif self.lastState==XingYuState.eHunZhan and state==XingYuState.eZhenDuo then
loadingControl.openCloud(function()
UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","setOpenCloudFlag",true)
UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","reqAllRivalInfo")
end,nil,true)

elseif self.lastState==XingYuState.eHunZhan and state==XingYuState.eFinish then
loadingControl.openCloud(function()
XingYuController.req_35_100()
UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","setOpenCloudFlag",true)
UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","reqAllRivalInfo")
end,nil,true)
elseif self.lastState==XingYuState.eZhenDuo and state==XingYuState.eFinish then



local xyId=self.teamXingYuList[self.selectIndex]
local zdzSumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)


if zdzSumRound and zdzSumRound~=0 then
UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","checkOpenCloud",zdzSumRound)
end
UIManager:invokeUIMethod("UIXingYu_HZ_ZDWin","reqAllRivalInfo")
end

end


function UIXingYuMainWin:stopTimer()
if self._timer then
self:stopTimerByID(self._timer)
self._timer=nil
end
end

function UIXingYuMainWin:startTimer(func)
self:stopTimer()
self._timer=self:setTimer(1,0,func)
end




function UIXingYuMainWin:GetReward(teamIndex)

local list=UIManager:invokeUIMethod("UIXingYuTanSuoWin","getEffectCfgList",teamIndex)
local num=list and#list or 0
if num<=0 then

self.effectgrid:recycleAll()
return
end







































if teamIndex then



list[1].epos=self.rewardBtn:getChildPosition()
local args=list[1]
self.effectgrid:createObject("xyeffectItem",self.effectgrid:getID(),nil,args,true)
else

local configList={}
for i=1,num do
local teamp={}
teamp.name="xyeffectItem"
teamp.parentIdx=self.effectgrid:getID()
list[i].epos=self.rewardBtn:getChildPosition()
teamp.args=list[i]
table.insert(configList,teamp)
end

self.effectgrid:createObjectList(configList)
end
end

function UIXingYuMainWin:playRewardBtnAnim(luaid)
if self.scaleTween then
self.scaleTween:Kill()
end
if luaid then
if not self.effectItemIdList then
self.effectItemIdList={}
end
table.insert(self.effectItemIdList,luaid)
end





self.scaleTween=self.rewardBtn:setChildDOScale(1.2,0.3,function()
if self and self.isClose then return end
if self.effectItemIdList then
for i,_luaid in ipairs(self.effectItemIdList)do
self.effectgrid:deleteItemByLuaid(_luaid)
end
self.effectItemIdList={}
end
end)
self.scaleTween:SetEase(_Ease.Linear)
self.scaleTween:SetLoops(2,_LoopType.Yoyo)
end

function UIXingYuMainWin:openFullMaskClick(clickFunc)
self.MaskClickFunc=clickFunc
self.maskBtn:setActive(true)
end










function UIXingYuMainWin:onRightArrow()
if self.selectIndex>1 then

local oldxyId=self.teamXingYuList[self.selectIndex]
XingYuController.req_35_109(oldxyId)
self.selectIndex=self.selectIndex-1
local newxyId=self.teamXingYuList[self.selectIndex]

XingYuController.req_35_102(newxyId)

end
end



function UIXingYuMainWin:onLeftArrow()
if self.selectIndex<self.maxIndex then
local oldxyId=self.teamXingYuList[self.selectIndex]
XingYuController.req_35_109(oldxyId)
self.selectIndex=self.selectIndex+1
local newxyId=self.teamXingYuList[self.selectIndex]

XingYuController.req_35_102(newxyId)

end
end



function UIXingYuMainWin:onRewardBtn()
local xyId=self.teamXingYuList[self.selectIndex]
XingYuController.req_35_103(xyId)
end



function UIXingYuMainWin:onRecordBtn()
local xyId=self.teamXingYuList[self.selectIndex]
XingYuController.req_35_104(xyId)
end



function UIXingYuMainWin:onTeamBtn()
local xyId=self.teamXingYuList[self.selectIndex]
XingYuController.req_35_105(xyId)
end



function UIXingYuMainWin:onMaskBtn()
self.maskBtn:setActive(false)
if self.MaskClickFunc then
self.MaskClickFunc()
self.MaskClickFunc=nil
end
end

function UIXingYuMainWin:onClickState(state)

if state==XingYuState.eHunZhan then
local curTime=timeHelper.getServerShortTime()
local tansuoEndTime=XingYuController.getTanSuoEndTime()
if curTime<tansuoEndTime then
local lerp=tansuoEndTime-curTime
local timeStr=timeHelper.format_time_stamp3(lerp)
UIManager.info(FMT.fmt("<color=#ca631d>{0}</color>后开启混战",timeStr))
end
elseif state==XingYuState.eZhenDuo then
local curTime=timeHelper.getServerShortTime()
local hunzhanEndTime=XingYuController.getHunZhanEndTime()
if curTime<hunzhanEndTime then
local lerp=hunzhanEndTime-curTime
local timeStr=timeHelper.format_time_stamp3(lerp)
UIManager.info(FMT.fmt("<color=#ca631d>{0}</color>后开启争夺战",timeStr))
end
end
end















