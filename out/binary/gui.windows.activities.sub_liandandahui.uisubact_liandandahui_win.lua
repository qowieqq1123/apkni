







def_class("UISubAct_LianDanDaHui_Win",UIWindowBase)









function UISubAct_LianDanDaHui_Win:bindComponents()

self.bg=UIObject.get(self,0)
self.overeffect=UIObject.get(self,1)
self.WarringPanel=UIObject.get(self,2)
self.Page4=UIObject.get(self,3)
self.Page3=UIObject.get(self,4)
self.Page2=UIObject.get(self,5)
self.talkObj3=UIObject.get(self,6)
self.Page1=UIObject.get(self,7)
self.beginProgressBar=UIProgressBarAni.get(self,8)
self.beginRoot=UIObject.get(self,9)
self.talkObj4=UIObject.get(self,10)
self.fire3=UIObject.get(self,11)
self.SpineObject=UIObject.get(self,12)
self.fire2=UIObject.get(self,13)
self.fire1=UIObject.get(self,14)
self.jifenProgressBar=UIProgressBarAni.get(self,15)
self.SpineObject2=UIObject.get(self,16)
self.fire4=UIObject.get(self,17)
self.outfire=UIObject.get(self,18)
self.jifenEffect=UIObject.get(self,19)
self.icon=UIImage.get(self,20)
self.P2LianDanZhi=UIText.get(self,21)
self.TenTimesButton=UIButton.get(self,22)
self.talkObj1=UIObject.get(self,23)
self.talkObj2=UIObject.get(self,24)
self.helpButton=UIButton.get(self,25)
self.OneTimesButton=UIButton.get(self,26)
self.PreviewButton=UIButton.get(self,27)
self.TimeProgressBar=UIProgressBarAni.get(self,28)
self.HuoHouKongZhiButton=UIButton.get(self,29)
self.fireSlider=UISlider.get(self,30)
self.TimeProgressBar3=UIProgressBarAni.get(self,31)
self.P3LianDanZhi=UIText.get(self,32)
self.sudanButton=UIButton.get(self,33)
self.P4LianDanZhi=UIText.get(self,34)
self.warringText=UIImage.get(self,35)
self.cost2=UILinkImageText.get(self,36)
self.cost1=UILinkImageText.get(self,37)
self.GoodFlag=UIObject.get(self,38)
self.BadFlag=UIObject.get(self,39)
self.MissFlag=UIObject.get(self,40)
self.BigFlag=UIObject.get(self,41)
self.fireLine=UIObject.get(self,42)
self.sudanLine=UIObject.get(self,43)
self.circleCenterBad=UIObject.get(self,44)
self.circleCenterGood=UIObject.get(self,45)
self.circleCenterBest=UIObject.get(self,46)
self.circleCenterGood2=UIObject.get(self,47)
self.circleCenterTarget=UIObject.get(self,48)
self.time=UIText.get(self,49)
self.haveMoney=UILinkImageText.get(self,50)
self.btnAdd=UIButton.get(self,51)
self.jfSpriteAni=UIObject.get(self,52)
self.jfSpriteAni2=UIObject.get(self,53)
self.fireHandle=UIObject.get(self,54)
self.BestArea=UIObject.get(self,55)
self.GoodArea=UIObject.get(self,56)

self.TenTimesButton:setButtonClick(function()self:onTenTimesButton()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.OneTimesButton:setButtonClick(function()self:onOneTimesButton()end)

self.PreviewButton:setButtonClick(function()self:onPreviewButton()end)

self.HuoHouKongZhiButton:setButtonClick(function()self:onHuoHouKongZhiButton()end)

self.sudanButton:setButtonClick(function()self:onSudanButton()end)

self.btnAdd:setButtonClick(function()self:onBtnAdd()end)


self.spriteAnim_liandanjifen=0
self.spriteAnim_liandanjifenMask=1

end


function UISubAct_LianDanDaHui_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.overeffect);self.overeffect=nil;
_UIObject_release(self.WarringPanel);self.WarringPanel=nil;
_UIObject_release(self.Page4);self.Page4=nil;
_UIObject_release(self.Page3);self.Page3=nil;
_UIObject_release(self.Page2);self.Page2=nil;
_UIObject_release(self.talkObj3);self.talkObj3=nil;
_UIObject_release(self.Page1);self.Page1=nil;
_UIObject_release(self.beginProgressBar);self.beginProgressBar=nil;
_UIObject_release(self.beginRoot);self.beginRoot=nil;
_UIObject_release(self.talkObj4);self.talkObj4=nil;
_UIObject_release(self.fire3);self.fire3=nil;
_UIObject_release(self.SpineObject);self.SpineObject=nil;
_UIObject_release(self.fire2);self.fire2=nil;
_UIObject_release(self.fire1);self.fire1=nil;
_UIObject_release(self.jifenProgressBar);self.jifenProgressBar=nil;
_UIObject_release(self.SpineObject2);self.SpineObject2=nil;
_UIObject_release(self.fire4);self.fire4=nil;
_UIObject_release(self.outfire);self.outfire=nil;
_UIObject_release(self.jifenEffect);self.jifenEffect=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.P2LianDanZhi);self.P2LianDanZhi=nil;
_UIObject_release(self.TenTimesButton);self.TenTimesButton=nil;
_UIObject_release(self.talkObj1);self.talkObj1=nil;
_UIObject_release(self.talkObj2);self.talkObj2=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.OneTimesButton);self.OneTimesButton=nil;
_UIObject_release(self.PreviewButton);self.PreviewButton=nil;
_UIObject_release(self.TimeProgressBar);self.TimeProgressBar=nil;
_UIObject_release(self.HuoHouKongZhiButton);self.HuoHouKongZhiButton=nil;
_UIObject_release(self.fireSlider);self.fireSlider=nil;
_UIObject_release(self.TimeProgressBar3);self.TimeProgressBar3=nil;
_UIObject_release(self.P3LianDanZhi);self.P3LianDanZhi=nil;
_UIObject_release(self.sudanButton);self.sudanButton=nil;
_UIObject_release(self.P4LianDanZhi);self.P4LianDanZhi=nil;
_UIObject_release(self.warringText);self.warringText=nil;
_UIObject_release(self.cost2);self.cost2=nil;
_UIObject_release(self.cost1);self.cost1=nil;
_UIObject_release(self.GoodFlag);self.GoodFlag=nil;
_UIObject_release(self.BadFlag);self.BadFlag=nil;
_UIObject_release(self.MissFlag);self.MissFlag=nil;
_UIObject_release(self.BigFlag);self.BigFlag=nil;
_UIObject_release(self.fireLine);self.fireLine=nil;
_UIObject_release(self.sudanLine);self.sudanLine=nil;
_UIObject_release(self.circleCenterBad);self.circleCenterBad=nil;
_UIObject_release(self.circleCenterGood);self.circleCenterGood=nil;
_UIObject_release(self.circleCenterBest);self.circleCenterBest=nil;
_UIObject_release(self.circleCenterGood2);self.circleCenterGood2=nil;
_UIObject_release(self.circleCenterTarget);self.circleCenterTarget=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.haveMoney);self.haveMoney=nil;
_UIObject_release(self.btnAdd);self.btnAdd=nil;
_UIObject_release(self.jfSpriteAni);self.jfSpriteAni=nil;
_UIObject_release(self.jfSpriteAni2);self.jfSpriteAni2=nil;
_UIObject_release(self.fireHandle);self.fireHandle=nil;
_UIObject_release(self.BestArea);self.BestArea=nil;
_UIObject_release(self.GoodArea);self.GoodArea=nil;
end



















local ePanelType=
{
idle=0,
begin=1,
controlFire=2,
suDan=3,
}

local panelState=
{
[ePanelType.idle]={true,false,false,false},
[ePanelType.begin]={false,false,false,true},
[ePanelType.controlFire]={false,true,false,false},
[ePanelType.suDan]={false,false,true,false},
}

local openPanelFuncName=
{
[ePanelType.idle]="showIdlePanel",
[ePanelType.begin]="showBeginPanel",
[ePanelType.controlFire]="showControlFirePanel",
[ePanelType.suDan]="showSuDanPanel",
}

local eventName=
{
[ePanelType.controlFire]="title_kongzhihuohou_1",
[ePanelType.suDan]="title_sudanzengxiao_1",
}

local fireHeight=371
local warringTime=2


function UISubAct_LianDanDaHui_Win:onLoaded(...)
self:bindComponents()


self.OneTimesButton:setButtonClick(function()self:onOneTimesButton()end,nil,0)
self.HuoHouKongZhiButton:setButtonClick(function()self:onHuoHouKongZhiButton()end,nil,0)
self.sudanButton:setButtonClick(function()self:onSudanButton()end,nil,0)

self.PageType={self.Page1,self.Page2,self.Page3,self.Page4}
self.talkObj={self.talkObj1,self.talkObj2,self.talkObj3,self.talkObj4}
local func=function()
if self and not self.isClose then
self:refreshMoney()
end
end
self.bg:setChildUIModelShowTarget(4019,1,{},eAnimationID.stand)
self.SpineObject:setChildUIModelShowTarget(4020,1,{},eAnimationID.stand)
self.fireEffect=
{
self.fire1,self.fire2,self.fire3,self.fire4
}
self.fire1:setChildShowEffect(10166,true)
self.fire2:setChildShowEffect(10167,true)
self.fire3:setChildShowEffect(10168,true)
self.fire4:setChildShowEffect(10169,true)
self.winlua:SetChildSpriteAnimationPrefabIndex(self.jfSpriteAni:getID(),0,true)
self.winlua:SetChildSpriteAnimationPrefabIndex(self.jfSpriteAni2:getID(),1,true)


for i,v in ipairs(self.fireEffect)do
v:setScale(Vector3.zero)
v:setChildPosition(Vector3.New(80.391,-170.83,0))
end
self.outfire:setChildShowEffect(10170,true)
self.outfire:setScale(Vector3.zero)
notifySystem:listenNotify(notifyConfig.on_money_changed,func)
self.beginProgressBar:setFinishAction(function(...)self:onProgressBarFinishAction(...)end)
end


function UISubAct_LianDanDaHui_Win:__delete()
if self.talkTimer then
self:stopTimerByID(self.talkTimer)
end
self:unbindComponents()
end




function UISubAct_LianDanDaHui_Win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eLianDanDaHui
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.end_time=self.info.end_time

self:initConfig()

self:setRemainingTimeTimer()
self:refreshCost()
self:refreshMoney()
self:refreshLDZProgressBar(0,true)
if self:checkBegin()then
self:refreshPanel(ePanelType.begin)
else
self:refreshPanel(ePanelType.idle)
end
end

function UISubAct_LianDanDaHui_Win:checkBegin()
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
if not data then
return false
end


if data.beginTime and data.beginTime>0 then
return true
end
end

function UISubAct_LianDanDaHui_Win:refreshCost()

local cost=self.config.consume
local iconname=iconHelper.getIconName(cost[1][1])
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,32)

if not self.info then
return
end
local freeCount=self.info:getFreeCount()
if self.freeTimes-freeCount>0 then
self.cost1:setText(FMT.fmt("免费次数：{0}",self.freeTimes-freeCount))
else
self.cost1:setText(FMT.fmt("{0}{1}",iconStr,cost[1][2]))
if pfwindowslController:checkIsGameVersion_yuenan()then
self.cost1:setText(FMT.fmt("{0} {1}",iconStr,cost[1][2]))
end
end

end

function UISubAct_LianDanDaHui_Win:refreshMoney()
local cost=self.config.sub_money
local iconname=iconHelper.getIconName(cost)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,48)
local have=itemsModel.getCount(cost)
self.haveMoney:setText(FMT.fmt("<color=#f1ce78></color> {0}  {1}",iconStr,have))
if pfwindowslController:checkIsGameVersion_yuenan()then
self.haveMoney:setText(FMT.fmt("<color=#f1ce78></color> {0}  {1}",iconStr,have))
end
end

function UISubAct_LianDanDaHui_Win:getLianDanZhi(data)
local value=0
local event1Val=data.event1List
local event2Val=data.event2List
if event1Val then
for i,v in ipairs(event1Val)do
value=value+v
end
end
if event2Val then
for i,v in ipairs(event2Val)do
value=value+v
end
end
return value
end

function UISubAct_LianDanDaHui_Win:refreshLDZProgressBar(value,isReset)
if isReset then
self.jifenProgressBar:animateTwoParams(0,100)
self.jifenProgressBar:setLocalPosX(10000)
self.jfSpriteAni2:setLocalPosY(-63)
self.jfSpriteAni2:setLocalPosX(10000)
return
end
local isChange=self.ldzValue~=value
self.ldzValue=value
self.jifenProgressBar:setLocalPosX(84.1)
self.jifenProgressBar:animateTwoParams(value,self.config.jindutiao)
if isChange then
self.jfSpriteAni2:setLocalPosX(10000)
self:setTimer(0.2,1,function()
self.jfSpriteAni2:setChildAnchoredPosition(Vector3(0,-63+(value/self.config.jindutiao*(53+63)),0))
end)


local scaleList={{0,0.5},{0.2,0.7},{0.7,0.5},{0.9,0},{1,0}}
for i,v in ipairs(scaleList)do
if value/self.config.jindutiao<=v[1]then
self.jfSpriteAni2:setChildDOScale(v[2],0.2,nil)
break
end
end

end

self.P2LianDanZhi:setText(value)
end


function UISubAct_LianDanDaHui_Win:onHide()

end

function UISubAct_LianDanDaHui_Win:initConfig()
self.liandanDuration=self.config.duration

self.freeTimes=self.config.free
self.suDanTimes=self.config.event2[5]
end

function UISubAct_LianDanDaHui_Win:resetData()
if self.liandanTimer then
self:stopTimerByID(self.liandanTimer)
self.liandanTimer=nil
end
self.isPause=nil
self.initLianDan=nil
self.initFire=nil
self.suDanCount=0
end

function UISubAct_LianDanDaHui_Win:refreshPanel(panelType)
self.panelType=panelType or ePanelType.idle
local openFunc=openPanelFuncName[self.panelType]
self[openFunc](self)
end

function UISubAct_LianDanDaHui_Win:refreshPage()

for i,v in ipairs(self.PageType)do
v:setActive(panelState[self.panelType][i])
end
end

function UISubAct_LianDanDaHui_Win:showIdlePanel()
self.SpineObject:setChildModelAnimationState(eAnimationID.stand,1,nil)
self.outfire:setScale(Vector3.zero)
for i,v in ipairs(self.fireEffect)do
v:setScale(Vector3.zero)
v:setChildPosition(Vector3.New(80.391,-170.83,0))
end
self:refreshPage()
self:checkFinishTime(true)
self.beginRoot:setActive(false)
self.beginProgressBar:setProgressValue(0,100)
self.beginProgressBar:setChildAnchoredPosition(Vector3.New(10000,-342,0))
if self.talkTimer then
self:stopTimerByID(self.talkTimer)
end
local func=function()
self:showTalk(1)
self:setTimer(1,1,function()
self:showTalk(2)
end)
end
func()
self.talkTimer=self:setTimer(6,0,func)
end

function UISubAct_LianDanDaHui_Win:showTalk(index)
local talkObj=self.talkObj[index]
local strGroup=cfgHelper.get(cfg_liandandahuitextconfig_get,1,"textGroup")
local str=strGroup[math.random(1,#strGroup)]
local widget=talkObj:getWidgetBase()
local key=index==2 and"right"or"left"
if str[key]then
widget:SetChildText(0,str[key])
talkObj:setChildCanvasGroupAlpha(1)
self:setTimer(2,1,function()
talkObj:setChildCanvasGroupAlpha(0)
end)
end
end

local getTalkId=
{
[ePanelType.controlFire]={2,3,4},
[ePanelType.suDan]={5,6,7},
}

function UISubAct_LianDanDaHui_Win:showTalk2(mType,lv)
if self.talkTimer2 then
self:stopTimerByID(self.talkTimer2)
end
local id=getTalkId[mType][lv]
local strGroup=cfgHelper.get(cfg_liandandahuitextconfig_get,id,"textGroup")
local str=strGroup[math.random(1,#strGroup)]

local cb=function(index)
local talkObj=self.talkObj[index+2]
local widget=talkObj:getWidgetBase()
local key=index==2 and"right"or"left"
if str[key]then
widget:SetChildText(0,str[key])
talkObj:setChildCanvasGroupAlpha(1)
self:setTimer(2,1,function()
talkObj:setChildCanvasGroupAlpha(0)
end)
end
end
if str.left and not str.right then
cb(1)
elseif str.right and not str.left then
cb(2)
elseif str.right and str.left then
cb(1)
self:setTimer(1,1,function()
cb(2)
end)
end
end

function UISubAct_LianDanDaHui_Win:updateState()
if not self.Start then
self:refreshPanel(ePanelType.begin)
self.Start=true
else
if self.suDanCount~=nil and self.suDanCount>=1 and self.suDanCount<self.suDanTimes then
self.suDanCount=self.suDanCount+1
self:refreshPanel(ePanelType.suDan)
else
self:refreshPanel(ePanelType.begin)
end
end
end

function UISubAct_LianDanDaHui_Win:showBeginPanel()
self:refreshPage()
local actid=self.actid
local subType=self.subType
local subid=self.subid
local data=activitiesModel:getSubActInfoData(actid,subType,subid)

self.isPause=nil
self.beginProgressBar:setChildAnchoredPosition(Vector3.New(87,-342,0))
self.beginRoot:setActive(true)
if not self.initLianDan then
self.outfire:setScale(Vector3.one)
self.SpineObject:setChildModelAnimationState(eAnimationID.juanzhou_idle2,1,nil)
self:resetData()
self.initLianDan=true
local beginTime=data.beginTime
self.beginTime=beginTime
local event1time=data.event1Time
local event2time=data.event2Time
self.event1time=event1time
self.event2time=event2time

self.fireLine:setChildAnchoredPosition(Vector3.New((event1time-beginTime)/self.liandanDuration*354,1,0))
self.sudanLine:setChildAnchoredPosition(Vector3.New((event2time-beginTime)/self.liandanDuration*354,1,0))
if beginTime==0 then
logErr("炼丹开始时间戳为0")
return
end
local timeStamp=gameUtilityModel.getServerShortTime()
if timeStamp-beginTime>=self.liandanDuration then
activitiesHandle_liandandahui.sendEndLianDan(self.actid,self.subid)
self:resetData()
self:refreshLDZProgressBar(0,true)
self:refreshPanel(ePanelType.idle)
self.Start=false
return
end

self.timeState=0
self.beginProgressBar:animateFiveParams(0,(event1time-beginTime)*10000,self.liandanDuration*10000,event1time-beginTime)
else
if self.timeState==0 then
self.beginProgressBar:animateThreeParams(self.event2time-self.beginTime,self.liandanDuration,self.event2time-self.event1time)
self.timeState=1
elseif self.timeState==1 then
self.beginProgressBar:animateThreeParams(self.liandanDuration,self.liandanDuration,self.liandanDuration-(self.event2time-self.beginTime))
self.timeState=2
for i,v in ipairs(self.fireEffect)do
v:setLocalPos(-3,-9,0)
end
end

end

local value=self:getLianDanZhi(data)

self:refreshLDZProgressBar(value)

end

function UISubAct_LianDanDaHui_Win:onProgressBarFinishAction(value,value1)
if self.timeState==0 then
if not self.initFire then
self.initFire=true
end
self:showWarringPanel(ePanelType.controlFire)
self:setTimer(warringTime,1,function()
self:refreshPanel(ePanelType.controlFire)
end)
elseif self.timeState==1 then
self:showWarringPanel(ePanelType.suDan)
self:setTimer(warringTime,1,function()
self:refreshPanel(ePanelType.suDan)
end)
self.suDanCount=1

if self.suDanTimes-1>0 then
for i=2,self.suDanTimes-1 do
table.insert(self.suDanStartTime,self.suDanStartTime[i-1]+1)
end
end
elseif self.timeState==2 then
activitiesHandle_liandandahui.sendEndLianDan(self.actid,self.subid)
self:resetData()
self:refreshLDZProgressBar(0,true)
self:refreshPanel(ePanelType.idle)
self.Start=false
self.timeState=0
end
end

function UISubAct_LianDanDaHui_Win:showControlFirePanel()
self.Page2:setChildCanvasGroupAlpha(0)
self:refreshPage()
self.Page2:setChildCanvasGroupDOFade(1,0.5,nil)
local fireArea=self.config.event1Area
local bestArea=fireArea[1]
local goodArea=fireArea[2]

local inNewBie=newbieControl.isCurrentNewbie(500155)

local centerPoint=math.random(goodArea*100,100-goodArea*100)/100

if inNewBie then
centerPoint=1-goodArea
else
centerPoint=math.random(goodArea*100,100-goodArea*100)/100
end

self.goodRange={centerPoint-goodArea/2,centerPoint+goodArea/2}
self.bestRange={centerPoint-bestArea/2,centerPoint+bestArea/2}

self.GoodArea:setChildAnchoredPosition(Vector3.New(0,self.goodRange[1]*fireHeight))
self.BestArea:setChildAnchoredPosition(Vector3.New(0,self.bestRange[1]*fireHeight))

local size=self.GoodArea:getCommonComponent('RectTransform').sizeDelta
self.GoodArea:setChildSizeDelta(size.x,self.goodRange[2]*fireHeight-self.goodRange[1]*fireHeight)
self.BestArea:setChildSizeDelta(size.x,self.bestRange[2]*fireHeight-self.bestRange[1]*fireHeight)

self.fireHeight=fireHeight
if self.fireTweener then
self.fireTweener:Kill()
end

if self.frieUpdate then
self:stopTimerByID(self.frieUpdate)
end

local maxtime=self.config.event1[3]


if inNewBie then
local y=(self.bestRange[1]+self.bestRange[2])/2*self.fireHeight
self.fireHandle:setChildAnchoredPosition(Vector3.New(0,0))
self.fireTweener=self.fireHandle:setChildDOAnchorPos(Vector3.New(0,y),2.5,function()
local selectCnt=y/self.fireHeight
self:switchFireEffect(selectCnt)
end)


maxtime=9999
else
self.fireHandle:setChildAnchoredPosition(Vector3.New(0,0))
self.fireTweener=self.fireHandle:setChildDOAnchorPos(Vector3.New(0,fireHeight),3)

self.fireTweener:SetEase(_Ease.Linear)
self.fireTweener:SetLoops(-1,_LoopType.Yoyo)
self:switchFireEffect(0)

self.frieUpdate=self:setTimer(0.02,0,function()
local handlePos=self.fireHandle:getChildAnchoredPosition()
local selectCnt=handlePos.y/self.fireHeight
self:switchFireEffect(selectCnt)
end)
end




local time=maxtime

self.TimeProgressBar:animateThreeParams(time,maxtime,0)
self.TimeProgressBar:animateFourParams(0,time,maxtime,true)
if self.fireTimeTimer then
self:stopTimerByID(self.fireTimeTimer)
end
self.fireTimeTimer=self:setTimer(1,maxtime,function()
time=time-1

if time<=0 then
self.TimeProgressBar:animateThreeParams(0,maxtime,0)
if self.fireTweener then
self.fireTweener:Kill()
end
if self.frieUpdate then
self:stopTimerByID(self.frieUpdate)
end
self:stopTimerByID(self.fireTimeTimer)
if not self:checkOver()then
local handlePos=self.fireHandle:getChildAnchoredPosition()
local selectCnt=handlePos.y/self.fireHeight
if self.bestRange and self.goodRange then
local lv=1
if selectCnt>=self.bestRange[1]and selectCnt<=self.bestRange[2]then
lv=3
elseif selectCnt>=self.goodRange[1]and selectCnt<=self.goodRange[2]then
lv=2
end

activitiesHandle_liandandahui.sendControlFireGame(self.actid,self.subid,lv)
self.bestRange=nil
self.goodRange=nil
self:showTalk2(ePanelType.controlFire,lv)
else
activitiesHandle_liandandahui.sendControlFireGame(self.actid,self.subid,1)
self:showTalk2(ePanelType.controlFire,1)
end

self:refreshPanel(ePanelType.begin)
end
end
end)
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local value=self:getLianDanZhi(data)

self:refreshLDZProgressBar(value)
end

function UISubAct_LianDanDaHui_Win:showSuDanPanel()
self.Page3:setChildCanvasGroupAlpha(0)
self:refreshPage()
self.Page3:setChildCanvasGroupDOFade(1,0.5,nil)

for i,v in ipairs(self.fireEffect)do

v:setLocalPosX(-10000)
end

local goodScale=0.42
local bestScale=0.4
local goodScale2=0.23
local badScale=0.16

local timeArea=self.config.event2Area

if self.sudanTweener then
self.sudanTweener:Kill()
end
self.suDanScale={1,goodScale,bestScale,goodScale2,badScale}
local maxtime=self.config.event2[3]
self.isToMax=true

AudioManager.playAudio(557)

local inNewBie=newbieControl.isCurrentNewbie(500155)
if inNewBie then
self.circleCenterTarget:setScale(Vector3.New(1,1,1))
local scale=(self.suDanScale[3]+self.suDanScale[4])/2

self.sudanTweener=self.circleCenterTarget:setChildDOScale(scale,math.random(timeArea[1]*10,timeArea[2]*10)/10,nil)
maxtime=9999
else
self.circleCenterTarget:setScale(Vector3.New(0.18,0.18,0.18))
self.sudanTweener=self.circleCenterTarget:setChildDOScale(1,math.random(timeArea[1]*10,timeArea[2]*10)/10,nil)
self.sudanTweener:SetEase(_Ease.Linear)
self.sudanTweener:SetLoops(-1,_LoopType.Yoyo)
self.sudanTweener:OnStepComplete(function()
self.isToMax=not self.isToMax
local audioId
if self.isToMax then
audioId=557
else
audioId=558
end

AudioManager.playAudio(audioId)
end)
end



if self.sudanTimeTimer then
self:stopTimerByID(self.sudanTimeTimer)
end

local time=maxtime


self.TimeProgressBar3:animateThreeParams(time,maxtime,0)
self.TimeProgressBar3:animateFourParams(0,time,maxtime,true)
self.sudanTimeTimer=self:setTimer(1,maxtime,function()
time=time-1

if time<=0 then
self.TimeProgressBar3:animateThreeParams(0,maxtime,0)
self:stopTimerByID(self.sudanTimeTimer)
if not self:checkOver()then
if self.sudanTweener then
self.sudanTweener:Kill()
end
local lv=1
if self.suDanScale then
local scale=self.winlua:GetChildScale(self.circleCenterTarget:getID())
scale=scale.x
if scale<=self.suDanScale[1]and scale>self.suDanScale[2]then
lv=1
elseif scale<=self.suDanScale[2]and scale>self.suDanScale[3]then
lv=2
elseif scale<=self.suDanScale[3]and scale>self.suDanScale[4]then
lv=3
elseif scale<=self.suDanScale[4]and scale>self.suDanScale[5]then
lv=2
elseif scale<=self.suDanScale[5]and scale>0 then
lv=1
end
activitiesHandle_liandandahui.sendSuDanGame(self.actid,self.subid,lv)
else
activitiesHandle_liandandahui.sendSuDanGame(self.actid,self.subid,1)
end
self:showTalk2(ePanelType.suDan,lv)
if not(self.suDanCount>=1 and self.suDanCount<self.suDanTimes)then
self:refreshPanel(ePanelType.begin)
end
end
end
end)
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local value=self:getLianDanZhi(data)

self:refreshLDZProgressBar(value)
end

function UISubAct_LianDanDaHui_Win:switchFireEffect(selectCnt)
local index=self:getFire(selectCnt)
if self.selectFireIndex~=index then
if self.selectFireIndex~=nil and self.selectFireIndex>index then
if self.selectFireIndex then

self.fireEffect[self.selectFireIndex]:setChildDOScale(0,0.15,nil)

self.fireEffect[self.selectFireIndex]:setChildDOLocalMove(Vector3(80.391,-170.83,0),0.15,nil)

end
self.fireEffect[index]:setChildDOScale(1,0.15,nil)
self.fireEffect[index]:setChildDOLocalMove(Vector3(-3,-9,0),0.15,nil)
else
self.fireEffect[index]:setChildDOScale(1,0.15,nil)
self.fireEffect[index]:setChildDOLocalMove(Vector3(-3,-9,0),0.15,nil)
end

end

self.selectFireIndex=index
end

function UISubAct_LianDanDaHui_Win:getFire(selectCnt)
if selectCnt<0.25 then
return 1
elseif selectCnt>=0.25 and selectCnt<0.5 then
return 2
elseif selectCnt>=0.5 and selectCnt<0.75 then
return 3
else
return 4
end
end

function UISubAct_LianDanDaHui_Win:showOverEffect(lv)
local effect={10180,10181,10182}
if effect[lv]then
self.overeffect:setChildShowEffect(effect[lv],true)
else
self.overeffect:setChildShowEffect(0,false)
end
end

local imageAb="ui/windows/activities/sub_liandandahui/liandandahui_atlas_pak.ab"
function UISubAct_LianDanDaHui_Win:showWarringPanel(panelType)

self.WarringPanel:setLocalPosY(600)
self.warringText:setCSImageSprite(imageAb,eventName[panelType])
self.WarringPanel:setChildCanvasGroupAlpha(1)

self.WarringPanel:setChildDOLocalMoveY(200,0.5,nil)


local fadetweener=self.WarringPanel:setChildCanvasGroupDOFade(0,0.5)
fadetweener:SetDelay(1.25)
end


function UISubAct_LianDanDaHui_Win:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.end_time and self.end_time-nowTime or 0
if lerp>0 then

self.time:setText(FMT.fmt("<color=#f1ce78>活动时间：</color>{0}后结束",timeHelper.format_time_stamp11(lerp,true)))
self.isOver=false
else
self.time:setText("活动已结束")

UIManager.error("活动已结束")
self:clearTimer()
self.isOver=true
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_LianDanDaHui_Win:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_LianDanDaHui_Win:checkOver()
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
if not data then
UIManager.error("活动已结束")
self:resetData()
self:refreshPanel(ePanelType.idle)
return true
end
return false
end

function UISubAct_LianDanDaHui_Win:checkFinishTime(refreshBtn)
local nowTime=gameUtilityModel.getServerShortTime()
local endTime=self.end_time
local banTime=self.config.finishTime
local check=false
if endTime then
if nowTime+banTime>=endTime then
check=true
if refreshBtn then
self.OneTimesButton:setButtonEnable(true,true)
self.TenTimesButton:setButtonEnable(true,true)
end
else
if refreshBtn then
self.OneTimesButton:setButtonEnable(true,false)
self.TenTimesButton:setButtonEnable(true,false)
end
end
else
check=true
if refreshBtn then
self.OneTimesButton:setButtonEnable(true,true)
self.TenTimesButton:setButtonEnable(true,true)
end
end
return check
end

function UISubAct_LianDanDaHui_Win:onMask()
UIManager.error("正在炼丹中，暂无法退出")
end




function UISubAct_LianDanDaHui_Win:onPreviewButton()
UIManager:showWindow("UILianDanPreviewWin",{actid=self.actid,act2id=self.subid})
end


function UISubAct_LianDanDaHui_Win:onOneTimesButton()
local cost=self.config.consume

local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
if self.isOver or not data then
UIManager.error("活动已结束")

AudioManager.playBtnClick()
return
end

if self:checkFinishTime()then
UIManager.error("活动即将结束，暂无法进行炼丹")

AudioManager.playBtnClick()
return
end


local freeCount=self.info:getFreeCount()
if self.freeTimes-freeCount>0 then
activitiesHandle_liandandahui.sendBeginLianDan(self.actid,self.subid,1)

AudioManager.playAudio(597)
self:resetData()
else





local cb=function()
activitiesHandle_liandandahui.sendBeginLianDan(self.actid,self.subid,1)

AudioManager.playAudio(597)
self:resetData()
end
if itemsConfig.isMoney(cost[1][1])then
moneySystem:useMoney(cost[1][1],cost[1][2],cb,WARNING_TYPE.eWarning)

AudioManager.playBtnClick()
else
local count=itemsModel.getCount(cost[1][1])
if count>=cost[1][2]then
cb()
else
gainControl:showGainWin(cost[1][1])

AudioManager.playBtnClick()
end
end
end
end


function UISubAct_LianDanDaHui_Win:onTenTimesButton()
local cost=self.config.consume
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local count=itemsModel.getCount(cost[1][1])
if count<cost[1][2]then
gainControl:showGainWin(cost[1][1])
return
end
local callback=function(times)
if self.isOver or not data then
UIManager.error("活动已结束")
return
end

if self:checkFinishTime()then
UIManager.error("活动即将结束，暂无法进行炼丹")
return
end

local cb=function()
activitiesHandle_liandandahui.sendBeginLianDan(self.actid,self.subid,times)

AudioManager.playAudio(597)
self:resetData()
end
if itemsConfig.isMoney(cost[1][1])then
moneySystem:useMoney(cost[1][1],cost[1][2]*times,cb,WARNING_TYPE.eWarning)
else
local count=itemsModel.getCount(cost[1][1])
if count>=cost[1][2]*times then
cb()
else
gainControl:showGainWin(cost[1][1])
end
end
end

self:showWindow("UIfastLianDanDialouge",{config=self.config,callback=callback})
end


function UISubAct_LianDanDaHui_Win:onHuoHouKongZhiButton()
if self.fireTimeTimer then
self:stopTimerByID(self.fireTimeTimer)
end
if self.frieUpdate then
self:stopTimerByID(self.frieUpdate)
end
if self.fireTweener then
self.fireTweener:Kill()
end

if self.clickTimer then

AudioManager.playBtnClick()
return
end

local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
if not data then
UIManager.error("活动已结束")
self:resetData()
self:refreshPanel(ePanelType.idle)

AudioManager.playBtnClick()
return
end

local handlePos=self.fireHandle:getChildAnchoredPosition()
local selectCnt=handlePos.y/self.fireHeight

if self.bestRange and self.goodRange then
local lv=1
if selectCnt>=self.bestRange[1]and selectCnt<=self.bestRange[2]then
lv=3
elseif selectCnt>=self.goodRange[1]and selectCnt<=self.goodRange[2]then
lv=2
end

activitiesHandle_liandandahui.sendControlFireGame(self.actid,self.subid,lv)

AudioManager.playAudio(597)
self.clickTimer=self:setTimer(1,1,function()
self.clickTimer=nil
end)
self:showTalk2(ePanelType.controlFire,lv)
end
self.bestRange=nil
self.goodRange=nil
end


function UISubAct_LianDanDaHui_Win:onSudanButton()
if self.clickTimer then

AudioManager.playBtnClick()
return
end
if self.cantSuDan then

AudioManager.playBtnClick()
return
end
if self.sudanTweener then
self.sudanTweener:Kill()
end

if self.sudanTimeTimer then
self:stopTimerByID(self.sudanTimeTimer)
end

local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
if not data then
UIManager.error("活动已结束")
self:resetData()
self:refreshPanel(ePanelType.idle)

AudioManager.playBtnClick()
return
end

local lv=1
if self.suDanScale then
local scale=self.winlua:GetChildScale(self.circleCenterTarget:getID())
scale=scale.x
if scale<=self.suDanScale[1]and scale>self.suDanScale[2]then
lv=1
elseif scale<=self.suDanScale[2]and scale>self.suDanScale[3]then
lv=2
elseif scale<=self.suDanScale[3]and scale>self.suDanScale[4]then
lv=3
elseif scale<=self.suDanScale[4]and scale>self.suDanScale[5]then
lv=2
elseif scale<=self.suDanScale[5]and scale>0 then
lv=1
end
end

self:showTalk2(ePanelType.suDan,lv)
activitiesHandle_liandandahui.sendSuDanGame(self.actid,self.subid,lv)

AudioManager.playAudio(597)
self.clickTimer=self:setTimer(1,1,function()
self.clickTimer=nil
end)
end

function UISubAct_LianDanDaHui_Win:onHelpButton()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_lianandahui_help_%s'})
end

function UISubAct_LianDanDaHui_Win:onBtnAdd()
local moneyType=self.config.sub_money
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end
