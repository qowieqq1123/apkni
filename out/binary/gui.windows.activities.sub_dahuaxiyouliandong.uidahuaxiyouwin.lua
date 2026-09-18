







def_class("UIDaHuaXiYouWin",UIWindowBase)









function UIDaHuaXiYouWin:bindComponents()

self.bgmodel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.UIDaHuaXiYouItem=UIObject.get(self,2)
self.expPB=UIObject.get(self,3)
self.wanfajieshao=UIButton.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.exp=UIText.get(self,6)
self.yilingqu=UIObject.get(self,8)
self.reddot=UIObject.get(self,9)
self.juqingBtn=UIObject.get(self,10)
self.leftBtn=UIButton.get(self,11)
self.rightBtn=UIButton.get(self,12)
self.switchBtn=UIButton.get(self,13)
self.tiaozhanBtn=UIObject.get(self,14)
self.ScreenTitleText=UIText.get(self,15)
self.lockmodel=UIObject.get(self,16)
self.icon=UIObject.get(self,17)
self.rewardContent=UIObject.get(self,18)
self.timeTx=UIText.get(self,19)
self.progressSpine=UIObject.get(self,20)
self.BG2=UIObject.get(self,21)
self.posGridList=UIObject.get(self,22)

self.wanfajieshao:setButtonClick(function()self:onWanfajieshao()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.switchBtn:setButtonClick(function()self:onSwitchBtn()end)



end


function UIDaHuaXiYouWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.UIDaHuaXiYouItem);self.UIDaHuaXiYouItem=nil;
_UIObject_release(self.expPB);self.expPB=nil;
_UIObject_release(self.wanfajieshao);self.wanfajieshao=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.exp);self.exp=nil;
_UIObject_release(self.yilingqu);self.yilingqu=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.juqingBtn);self.juqingBtn=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.switchBtn);self.switchBtn=nil;
_UIObject_release(self.tiaozhanBtn);self.tiaozhanBtn=nil;
_UIObject_release(self.ScreenTitleText);self.ScreenTitleText=nil;
_UIObject_release(self.lockmodel);self.lockmodel=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.progressSpine);self.progressSpine=nil;
_UIObject_release(self.BG2);self.BG2=nil;
_UIObject_release(self.posGridList);self.posGridList=nil;
end



















local this

local ScreenWidgetCmp=
{
tiaozhanTipsImage=0,
reddot=1,
juqingTipsImage=2,
CompletedImage=3,
unlockCDNText=4,
reddotLeft=5,
reddotRight=6,
}

local rewardCmp=
{
effectCmp=9,
reddot=11,
receive=12,
effectCmp1=13,
}


local eventType=
{
pushMaps=1,
answerquestions=2,
Adventure=3,
None=4,
}

local reddotIndex=
{
screenReddot=1,
leftReddot=2,
rightReddot=3,
}

local speakCd={2,4}
local showSpeakTime=3

local eventHandle={
[eventType.pushMaps]=
{
enter=function(window)
window:enterCopy()
end
},
[eventType.answerquestions]=
{
enter=function(window)
window:openDaTi()
end
},
[eventType.Adventure]=
{
enter=function(window)
window:openQiyu()
end
},
[eventType.None]=
{
enter=function(window)
window:checkCorrect()
end
},
}

local progressSpineId=6211
local lockSprineId=6212

local stringF=string.format


function UIDaHuaXiYouWin:onLoaded(...)
self:bindComponents()
this=self
self.speakRefreshTimerList={}
self.speakShowTimerList={}
end


function UIDaHuaXiYouWin:__delete()
self:unbindComponents()
this=nil
end




function UIDaHuaXiYouWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.custom=(self.sub_actcfg and self.sub_actcfg.custonPanelConfig)or{}


local img2=self.custom.image2
if img2 and img2[1]and img2[2]then
self.tiaozhanBtn:setSprite(img2[1],img2[2],false)
end

self.spectatorBtList={}
self.canSpeakPosIndexLookup={}
self.speakRandomList={}


self.ScreenWidget=self.UIDaHuaXiYouItem:getWidgetBase()

local curWhichAct=self.myData.progress
self.isCompleted=self.info:isAllCompleted()

local CurScreenIsOpen=false
if not self.selectWhichAct then

self.selectWhichAct=curWhichAct
if not self.isCompleted then
CurScreenIsOpen=self.info:checkCurScreenIsOpen(curWhichAct+1)
end
if CurScreenIsOpen then
self.selectWhichAct=curWhichAct+1
end
if self.selectWhichAct>#self.sub_actcfg.eventList then
self.selectWhichAct=#self.sub_actcfg.eventList
end
end
local AnimationID=CurScreenIsOpen and eAnimationID.idle or eAnimationID.stand2

local buid=self.sub_actcfg.BgId
self.bgmodel:setChildUIModelShowTarget(buid,1,nil,AnimationID,false,false,0,function()
end)

self.progressSpine:setChildUIModelShowTarget(progressSpineId,1,nil,eAnimationID.idle,false,false,0,function()
end)

self:refreshScreen()


if self.actTimer==nil then
local func=function()
self:refreshActTimer()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end

self.speakLib=self.sub_actcfg.spectatorSpeakStr
self.spectatorCount=self.sub_actcfg.spectatorCount
self.maxSpeakCount=self.sub_actcfg.maxSpeakCount

self:refreshSpectator()

end

function UIDaHuaXiYouWin:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(time))
self.timeTx:setText(time_str)
end






function UIDaHuaXiYouWin:onHide()
self:clearSpeakRefreshTimer()
self:clearSpeakShowTimer()
end



function UIDaHuaXiYouWin:PlotSelectChange()
self.selectWhichAct=self.myData.selectWhichAct
self:refreshScreen()
end


function UIDaHuaXiYouWin:refreshScreen()

self.leftBtn:setActive(self.selectWhichAct~=1)
self.rightBtn:setActive(self.selectWhichAct~=#self.sub_actcfg.eventList)

local playFlag=self.myData.playFlag
local today=self.info:getStart2NowDay()

local screenAllCompleted=self.info:checkScreenAllCompleted(self.selectWhichAct)

local CurScreenIsOpen=self.info:checkCurScreenIsOpen(self.selectWhichAct)

local isCompleted=self.selectWhichAct<=self.myData.progress

local title=self.sub_actcfg.titleList[self.selectWhichAct]

local iconNumber=self.sub_actcfg.iconList[self.selectWhichAct]
local PlotCompleted=mathHelper.getBitValue(playFlag,self.selectWhichAct-1)

self.ScreenWidget:SetChildActive(ScreenWidgetCmp.unlockCDNText,not CurScreenIsOpen)
local str=""
if not CurScreenIsOpen then
local Condition=self.sub_actcfg.openCDN[self.selectWhichAct]
str=stringF("<color=#F84C33>活动第%s天开启</color>",Condition)
if Condition==today+1 then
str="<color=#F84C33>明日开启</color>"
else
local title=self.sub_actcfg.titleList[self.selectWhichAct-1]
str=stringF("<color=#F84C33>完成【%s】后开启</color>",title)
end
self.lockmodel:setActive(true)

self.lockmodel:setChildUIModelShowTarget(lockSprineId,1,nil,eAnimationID.idle,false,false,0,function()

end)
else
self.lockmodel:setActive(false)
end
local AnimationID=CurScreenIsOpen and eAnimationID.idle or eAnimationID.stand2
self.bgmodel:setChildModelAnimationState(AnimationID)

self.ScreenWidget:SetChildText(ScreenWidgetCmp.unlockCDNText,str)

self.ScreenWidget:SetChildActive(ScreenWidgetCmp.CompletedImage,screenAllCompleted)

self.ScreenWidget:SetChildActive(ScreenWidgetCmp.juqingTipsImage,CurScreenIsOpen and not screenAllCompleted)

self.ScreenWidget:SetChildActive(ScreenWidgetCmp.tiaozhanTipsImage,isCompleted and not screenAllCompleted)

self.ScreenTitleText:setText(title)
self.icon:setChildIcon(stringF("image_shijian_%s",iconNumber),false)

self:UIProgress()

local reddotflag=self.info:checkCurScreenReddot(self.sub_actcfg,self.myData,self.selectWhichAct)
local leftReddotFlag=self.info:checkLeftScreenReddot(self.sub_actcfg,self.myData,self.selectWhichAct)
local rightReddotFlag=self.info:checkRightScreenReddot(self.sub_actcfg,self.myData,self.selectWhichAct)

self:doPunchRotation(self.ScreenWidget,reddotIndex.screenReddot,ScreenWidgetCmp.reddot,reddotflag)
self.ScreenWidget:SetChildActive(ScreenWidgetCmp.reddotLeft,leftReddotFlag)
self.ScreenWidget:SetChildActive(ScreenWidgetCmp.reddotRight,rightReddotFlag)


self:refreshRewardPanel()
end




function UIDaHuaXiYouWin:onButtonClick(delta)
if self.clickCD then
return
end

self.clickCD=true

self.selectWhichAct=self.selectWhichAct+delta
self.selectWhichAct=math.max(1,math.min(self.selectWhichAct,#self.sub_actcfg.eventList))

self:refreshScreen()

self:delayDo(0.2,function()
self.clickCD=false
end)
end


function UIDaHuaXiYouWin:onLeftBtn()
self:onButtonClick(-1)
end


function UIDaHuaXiYouWin:onRightBtn()
self:onButtonClick(1)
end




function UIDaHuaXiYouWin:onSwitchBtn()
local tempArgtable={actID=self.actID,subType=self.subType,subid=self.subid,selectWhichAct=self.selectWhichAct}
self:showWindow("UIFangYingTingPlotSelectWin",tempArgtable)
end


function UIDaHuaXiYouWin:onCloseBtn()
self:closeSelf()
end




function UIDaHuaXiYouWin:onIcon()

end


function UIDaHuaXiYouWin:chaHuaClick()

local screenAllCompleted=self.info:checkScreenAllCompleted(self.selectWhichAct)
local playFlag=self.myData.playFlag
local PlotCompleted=mathHelper.getBitValue(playFlag,self.selectWhichAct-1)
if not screenAllCompleted then
local CurScreenIsOpen=self.info:checkCurScreenIsOpen(self.selectWhichAct)
if CurScreenIsOpen then
if not PlotCompleted then
self:onPlayImage()
else
self:onJuqingBtn()
end
end
else
UIManager.info("此剧幕已完成")
end
end


function UIDaHuaXiYouWin:onPlayImage()
local playFlag=self.myData.playFlag
local PlotCompleted=mathHelper.getBitValue(playFlag,self.selectWhichAct-1)
if not PlotCompleted then
local args={isFullOpen=false,}
local PlotID=self.sub_actcfg.PlotList[self.selectWhichAct]
local PlotCompletedCD=function()
if this then
this:req_RecordPlotFlag()
end
end
worldStoryController:showStoryTree(PlotID,PlotCompletedCD,nil,nil,args)
end
end


function UIDaHuaXiYouWin:req_RecordPlotFlag()
local PlotCompleted=mathHelper.getBitValue(self.myData.playFlag,self.selectWhichAct-1)
if not PlotCompleted then
local playFlag=mathHelper.setbit(self.myData.playFlag,self.selectWhichAct-1)
call_activitiesHandle_func("activitiesHandle_fangyingting","reqProtocol_PlotFlag",self.actID,self.subType,self.subid,playFlag)
end
end


function UIDaHuaXiYouWin:onPlayImageProtocol()
local playFlag=self.myData.playFlag
local PlotCompleted=mathHelper.getBitValue(playFlag,self.selectWhichAct-1)
local curEventCfg=self.sub_actcfg.eventList[self.selectWhichAct]
local eventType=curEventCfg[1]
if PlotCompleted then
if eventType==eFangYingTingEventType.None then
return
end
if eventType~=eFangYingTingEventType.AnswerQuestion then

call_activitiesHandle_func("activitiesHandle_fangyingting","reqProtocol_EventStart",self.actID,self.subType,self.subid)
else

self:onJuqingBtn()
end
end
end


function UIDaHuaXiYouWin:onEventProtocol()
self:onJuqingBtn()
self:refreshScreen()
end



function UIDaHuaXiYouWin:onJuqingBtn()
self.myData.selectWhichAct=self.selectWhichAct
local curEventCfg=self.sub_actcfg.eventList[self.selectWhichAct]
local screenAllCompleted=self.info:checkScreenAllCompleted(self.selectWhichAct)

if not screenAllCompleted then
local playFlag=self.myData.playFlag
local PlotCompleted=mathHelper.getBitValue(playFlag,self.selectWhichAct-1)
local CurScreenIsOpen=self.info:checkCurScreenIsOpen(self.selectWhichAct)
if CurScreenIsOpen then
if not PlotCompleted then
self:onPlayImage()
else
local newHandle=eventHandle[curEventCfg[1]]
if newHandle then
newHandle.enter(self);
end
end
end
else

self.isCompleted=self.info:isAllCompleted()

local curWhichAct=self.myData.progress
local CurScreenIsOpen=false
if not self.isCompleted then
if not self.isCompleted then
CurScreenIsOpen=self.info:checkCurScreenIsOpen(curWhichAct+1)
if CurScreenIsOpen then
self.selectWhichAct=curWhichAct+1
self.myData.selectWhichAct=self.selectWhichAct
end
end
end
end
end


function UIDaHuaXiYouWin:onWanfajieshao()






local args={
ruleGroupID=self.sub_actcfg.screenHelp,
}
self:showWindow("UIRuleTipsImage2Win",args)
end



function UIDaHuaXiYouWin:enterCopy()
AudioManager.playAudio(661)
local isCompleted=self.selectWhichAct<=self.myData.progress
local tuituIndexStr=self.myData.tuituIndexStr
if#tuituIndexStr==0 and(not isCompleted)then

call_activitiesHandle_func("activitiesHandle_fangyingting","reqProtocol_EventStart",self.actID,self.subType,self.subid)
return
end


local PushMapId,PlotState=self.info:checkPushMapId(self.sub_actcfg,self.selectWhichAct)
self.myData.selectPushMapId=PushMapId
self.myData.selectPlotState=PlotState
local tempArgtable={actID=self.actID,subType=self.subType,subid=self.subid,selectPushMapId=self.myData.selectPushMapId,selectPlotState=self.myData.selectPlotState}

if UIManager:isActive("UIFightPrepareLoading")then
self:showWindow('UIDaHuaXiYouWin_CopyMainWin',tempArgtable)
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
self:showWindow('UIDaHuaXiYouWin_CopyMainWin',tempArgtable)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
})
end

end


function UIDaHuaXiYouWin:openDaTi()
local tempArgtable={actID=self.actID,subType=self.subType,subid=self.subid}
if UIManager:isActive("UIFightPrepareLoading")then
self:showWindow('UIDaHuaXiYouWin_DaTi',tempArgtable)
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
self:showWindow('UIDaHuaXiYouWin_DaTi',tempArgtable)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
})
end
end


function UIDaHuaXiYouWin:openQiyu()

if tonumber(tostring(self.myData.qiyuId))==0 then

call_activitiesHandle_func("activitiesHandle_fangyingting","reqProtocol_EventStart",self.actID,self.subType,self.subid)
else
local func=function()

end
MysteryEventSystem:showEventByGuid(SYSTEM_DEFINE.eCloudCityTreasure,self.myData.qiyuId,{},true,func)
end
end



function UIDaHuaXiYouWin:checkCorrect()

local PlotCompleted=mathHelper.getBitValue(self.myData.playFlag,self.selectWhichAct-1)
local isCompleted=self.selectWhichAct<=self.myData.progress
if PlotCompleted and(not isCompleted)then

call_activitiesHandle_func("activitiesHandle_fangyingting","reqProtocol_Correct",self.actID,self.subType,self.subid)
end
end


function UIDaHuaXiYouWin:UIProgress()
local curExp=0
local curWhichAct=self.myData.progress
for i,v in ipairs(self.sub_actcfg.eventList)do
if curWhichAct>=i then
curExp=curExp+v[3]
end
end
local needExp=self.sub_actcfg.gressMax
self.exp:setText(FMT.fmt('放映进度：{0}%',curExp/needExp*100))
self.expPB:setChildUIProgressbar(curExp,needExp,false)
end



function UIDaHuaXiYouWin:refreshRewardPanel()
local rewardList=self.sub_actcfg.rewards

self.isReceive=self.info:checkProgressIsReceive()
self.rewardContent:setChildLayoutGroupCreateItems(#rewardList,function(index)
local item=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local itemId,itemNum=unpack(rewardList[index])
local countStr=mathHelper.formatNumber(itemNum)
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true,colorEffect=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
if self.isReceive then
call_activitiesHandle_func("activitiesHandle_fangyingting","reqProtocol_ClaimReward",self.actID,self.subType,self.subid)
else
itemsComponentHelper.onItemClick(...)
end
end)
item:SetChildPropData(-1,prop)
local effectId="xianshu_light"
item:SetChildActive(rewardCmp.effectCmp1,self.isReceive)
item:SetChildAnimationStringID(rewardCmp.effectCmp1,effectId,self.isReceive)
item:SetChildActive(rewardCmp.reddot,self.isReceive)

item:SetChildActive(rewardCmp.receive,self.myData.rewardFlag==1)
end)
end


function UIDaHuaXiYouWin:doPunchRotation(Widget,reddotIndex,componentIndex,flag)
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
Widget:SetChildActive(componentIndex,flag)
if flag then
Widget:SetChildRotation(componentIndex,0,0,0)
local tweener=Widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
else
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
end
end
end



function UIDaHuaXiYouWin:refreshSpectator()
self:clearSpeakRefreshTimer()
self:clearSpeakShowTimer()
local posGrids=self.posGridList:getChildCommonLayoutGroupWidgetList()

for i=1,posGrids.Count do
local posWidget=posGrids[i-1]
if i<=self.spectatorCount then
posWidget:SetChildActive(-1,true)
posWidget:SetChildActive(1,false)


local randomCd=math.random(speakCd[1],speakCd[2])
self.speakRefreshTimerList[i]=self:delayDo(randomCd,function()
if not this then return end
return this:applySpectatorSpeakContent(i)
end)
else
posWidget:SetChildActive(-1,false)
end
end
end

function UIDaHuaXiYouWin:clearSpeakRefreshTimer()
if self.speakRefreshTimerList and next(self.speakRefreshTimerList)then
for i,timer in pairs(self.speakRefreshTimerList)do
self:stopTimerByID(timer)
self.speakRefreshTimerList[i]=nil
end
end
end

function UIDaHuaXiYouWin:clearSpeakShowTimer()
if self.speakShowTimerList and next(self.speakShowTimerList)then
for i,timer in pairs(self.speakShowTimerList)do
self:stopTimerByID(timer)
self.speakShowTimerList[i]=nil
end
end
end

function UIDaHuaXiYouWin:applySpectatorSpeakContent(index)
if not self.canSpeakPosIndexLookup or not next(self.canSpeakPosIndexLookup)then

local indexList={}
for i=1,self.spectatorCount do
indexList[#indexList+1]=i
end

for i=1,self.maxSpeakCount do
local rand=math.random(1,#indexList)
local randIndex=indexList[rand]
table.remove(indexList,rand)
self.canSpeakPosIndexLookup[randIndex]=true
end

end

local widget=self.posGridList:getChildCommonLayoutGroupWidgetItem(index-1)
local refreshFunc=function(isShowCallBack)
if not this then return end
widget:SetChildActive(1,false)
if isShowCallBack then
this.canSpeakPosIndexLookup[index]=nil
end
local randomCd=math.random(speakCd[1],speakCd[2])
this.speakRefreshTimerList[index]=this:delayDo(randomCd,function()
if not this then return end
return this:applySpectatorSpeakContent(index)
end)
end

if self.canSpeakPosIndexLookup[index]then
local speakStr=self:getSpectatorSpeakContent()
widget:SetChildText(0,speakStr)
widget:SetChildActive(1,true)
self.speakShowTimerList[index]=self:delayDo(showSpeakTime,function()
return refreshFunc(true)
end)
else
return refreshFunc()
end
end

function UIDaHuaXiYouWin:releaseSpectatorSpeakContent(index)
self.canSpeakPosIndexLookup[index]=nil
end

function UIDaHuaXiYouWin:getSpectatorSpeakContent()
if not self.speakRandomList or not next(self.speakRandomList)then

for i,str in ipairs(self.speakLib)do
self.speakRandomList[#self.speakRandomList+1]=i
end
end

local rand=math.random(1,#self.speakRandomList)
local randIndex=self.speakRandomList[rand]
table.remove(self.speakRandomList,rand)
local contentStr=self.speakLib[randIndex]
return contentStr
end



