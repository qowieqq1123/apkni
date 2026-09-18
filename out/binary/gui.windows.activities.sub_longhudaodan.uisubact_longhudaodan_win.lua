







def_class("UISubAct_LongHuDaoDan_Win",UIWindowBase)









function UISubAct_LongHuDaoDan_Win:bindComponents()

self.bg=UIObject.get(self,0)
self.overeffect=UIObject.get(self,1)
self.WarringPanel=UIObject.get(self,2)
self.Page4=UIObject.get(self,3)
self.Page2=UIObject.get(self,4)
self.konhuoEff=UIObject.get(self,5)
self.Page1=UIObject.get(self,6)
self.beginRoot=UIObject.get(self,7)
self.jifenProgressBar=UIProgressBarAni.get(self,8)
self.ewKonhuoEff=UIObject.get(self,9)
self.SpineObject2=UIObject.get(self,10)
self.outfire=UIObject.get(self,11)
self.fire3=UIObject.get(self,12)
self.SpineObject=UIObject.get(self,13)
self.fire2=UIObject.get(self,14)
self.fire4=UIObject.get(self,15)
self.fire1=UIObject.get(self,16)
self.dzModels=UIObject.get(self,17)
self.warringText=UIImage.get(self,18)
self.P4LianDanZhi=UIText.get(self,19)
self.HuoHouKongZhiButton=UIButton.get(self,20)
self.fireSlider=UISlider.get(self,21)
self.TimeProgressBar=UIProgressBarAni.get(self,22)
self.PreviewButton=UIButton.get(self,23)
self.progressRoot=UIObject.get(self,24)
self.icon=UIImage.get(self,25)
self.P2LianDanZhi=UIText.get(self,26)
self.jifenEffect=UIObject.get(self,27)
self.MissFlag=UIObject.get(self,28)
self.BadFlag=UIObject.get(self,29)
self.GoodFlag=UIObject.get(self,30)
self.BigFlag=UIObject.get(self,31)
self.progressEff=UIObject.get(self,32)
self.ruleBtn=UIButton.get(self,33)
self.rewardGetted=UIObject.get(self,34)
self.UIBattleVictoryItem=UIBaseItem.get(self,35)
self.progressTxt=UIText.get(self,36)
self.progressReddot=UIObject.get(self,37)
self.LongReddot=UIObject.get(self,38)
self.HuReddot=UIObject.get(self,39)
self.LongButton=UIButton.get(self,40)
self.LongScrollView=UIObject.get(self,41)
self.HuButton=UIButton.get(self,42)
self.HuScrollView=UIObject.get(self,43)
self.GoodArea=UIObject.get(self,44)
self.BestArea=UIObject.get(self,45)
self.jfSpriteAni=UIObject.get(self,46)
self.jfSpriteAni2=UIObject.get(self,47)
self.fireHandle=UIObject.get(self,48)

self.HuoHouKongZhiButton:setButtonClick(function()self:onHuoHouKongZhiButton()end)

self.PreviewButton:setButtonClick(function()self:onPreviewButton()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.LongButton:setButtonClick(function()self:onLongButton()end)

self.HuButton:setButtonClick(function()self:onHuButton()end)


self.spriteAnim_liandanjifen=0
self.spriteAnim_liandanjifenMask=1

end


function UISubAct_LongHuDaoDan_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.overeffect);self.overeffect=nil;
_UIObject_release(self.WarringPanel);self.WarringPanel=nil;
_UIObject_release(self.Page4);self.Page4=nil;
_UIObject_release(self.Page2);self.Page2=nil;
_UIObject_release(self.konhuoEff);self.konhuoEff=nil;
_UIObject_release(self.Page1);self.Page1=nil;
_UIObject_release(self.beginRoot);self.beginRoot=nil;
_UIObject_release(self.jifenProgressBar);self.jifenProgressBar=nil;
_UIObject_release(self.ewKonhuoEff);self.ewKonhuoEff=nil;
_UIObject_release(self.SpineObject2);self.SpineObject2=nil;
_UIObject_release(self.outfire);self.outfire=nil;
_UIObject_release(self.fire3);self.fire3=nil;
_UIObject_release(self.SpineObject);self.SpineObject=nil;
_UIObject_release(self.fire2);self.fire2=nil;
_UIObject_release(self.fire4);self.fire4=nil;
_UIObject_release(self.fire1);self.fire1=nil;
_UIObject_release(self.dzModels);self.dzModels=nil;
_UIObject_release(self.warringText);self.warringText=nil;
_UIObject_release(self.P4LianDanZhi);self.P4LianDanZhi=nil;
_UIObject_release(self.HuoHouKongZhiButton);self.HuoHouKongZhiButton=nil;
_UIObject_release(self.fireSlider);self.fireSlider=nil;
_UIObject_release(self.TimeProgressBar);self.TimeProgressBar=nil;
_UIObject_release(self.PreviewButton);self.PreviewButton=nil;
_UIObject_release(self.progressRoot);self.progressRoot=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.P2LianDanZhi);self.P2LianDanZhi=nil;
_UIObject_release(self.jifenEffect);self.jifenEffect=nil;
_UIObject_release(self.MissFlag);self.MissFlag=nil;
_UIObject_release(self.BadFlag);self.BadFlag=nil;
_UIObject_release(self.GoodFlag);self.GoodFlag=nil;
_UIObject_release(self.BigFlag);self.BigFlag=nil;
_UIObject_release(self.progressEff);self.progressEff=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.rewardGetted);self.rewardGetted=nil;
_UIObject_release(self.UIBattleVictoryItem);self.UIBattleVictoryItem=nil;
_UIObject_release(self.progressTxt);self.progressTxt=nil;
_UIObject_release(self.progressReddot);self.progressReddot=nil;
_UIObject_release(self.LongReddot);self.LongReddot=nil;
_UIObject_release(self.HuReddot);self.HuReddot=nil;
_UIObject_release(self.LongButton);self.LongButton=nil;
_UIObject_release(self.LongScrollView);self.LongScrollView=nil;
_UIObject_release(self.HuButton);self.HuButton=nil;
_UIObject_release(self.HuScrollView);self.HuScrollView=nil;
_UIObject_release(self.GoodArea);self.GoodArea=nil;
_UIObject_release(self.BestArea);self.BestArea=nil;
_UIObject_release(self.jfSpriteAni);self.jfSpriteAni=nil;
_UIObject_release(self.jfSpriteAni2);self.jfSpriteAni2=nil;
_UIObject_release(self.fireHandle);self.fireHandle=nil;
end


















local _this

local ePanelType=
{
idle=0,
begin=1,
controlFire=2,
balance=3,
}

local panelState=
{
[ePanelType.idle]={true,false,false},
[ePanelType.begin]={false,false,true},
[ePanelType.controlFire]={false,true,false},
[ePanelType.balance]={false,false,true},
}

local openPanelFuncName=
{
[ePanelType.idle]="showIdlePanel",
[ePanelType.begin]="showBeginPanel",
[ePanelType.controlFire]="showControlFirePanel",
[ePanelType.balance]="showBalancePanel",
}

local fireHeight=371
local warringTime=2


function UISubAct_LongHuDaoDan_Win:onLoaded(...)
self:bindComponents()

self.multiBT={}


self.LongButton:setButtonClick(function()self:onLongButton()end,nil,0)
self.HuButton:setButtonClick(function()self:onHuButton()end,nil,0)
self.HuoHouKongZhiButton:setButtonClick(function()self:onHuoHouKongZhiButton()end,nil,0)

self.PageType={self.Page1,self.Page2,self.Page4}
self.bg:setChildUIModelShowTarget(5330,1,{},eAnimationID.stand)
self.SpineObject:setChildUIModelShowTarget(5331,1,{},eAnimationID.stand)
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

self.aiDiscipleList={}
local top5List=UIDiscipleModel:getFightTop5DiscipleGuidList()
for i,v in pairs(top5List)do
local dzguid=v.discipleguid
table.insert(self.aiDiscipleList,dzguid)
end
self.aiBodyList={5320,5317,5324,5314,5321}
self.currDZList={}
self.dzIndex=math.random(1,#self.aiDiscipleList)
self.bodyIndex=math.random(1,#self.aiBodyList)
self.visitorNum=0

self._onMoneyChange=function(...)self:onMoneyChange(...)end
self._onItemChange=function(...)self:onItemChange(...)end
notifySystem:listenNotify(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:listenNotify(notifyConfig.on_item_changed,self._onItemChange)
end


function UISubAct_LongHuDaoDan_Win:__delete()
self:unbindComponents()
if self.aiTimer then
self:stopTimerByID(self.aiTimer)
end
if self.showMoney then
self.showMoney=nil
self:closeWindow('UITopMoneyWin4')
end
self:clearAI()
_this=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self._onItemChange)
end


function UISubAct_LongHuDaoDan_Win:onMoneyChange(moneyType,lastVal,val)
if not self.config or not self.config.moneytypes then return end
local costs=self.config.costs
for i,list in ipairs(costs)do
for k,v in ipairs(list)do
if v[1]==moneyType then
self:refreshCost()
break
end
end
end
end

function UISubAct_LongHuDaoDan_Win:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
if not self.config or not self.config.moneytypes then return end
local costs=self.config.costs
for i,list in ipairs(costs)do
for k,v in ipairs(list)do
if v[1]==itemid then
self:refreshCost()
break
end
end
end
end




function UISubAct_LongHuDaoDan_Win:onShow(argtable,afterOnloaded)
_this=self
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eLongHuMountain
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.end_time=self.info.end_time
self.isSendKonHuo=false

self:initConfig()

self:refreshCost()
self:refreshProgressReward()
self:refreshLDZProgressBar(0,true)
if self:checkBegin()then
local timeStamp=gameUtilityModel.getServerShortTime()
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local beginTime=data.excuteList[data.excute_len].param_2
local excute=self.config.excute[data.excute_id][data.excute_len]
local maxtime=excute and excute[2]-1 or 0
if excute and beginTime>0 and timeStamp-beginTime<maxtime then
self:refreshPanel(ePanelType.begin)
else
self.beginRoot:setActive(true)
self:refreshPanel(ePanelType.balance)
local value=self:getLianDanZhi(data)
self:refreshLDZProgressBar(value)
end
else
self:refreshPanel(ePanelType.idle)
end

local moneytypes=self.config.moneytypes
self.showMoney=moneytypes~=nil
if self.showMoney then
self:showWindow('UITopMoneyWin4',{moneys=moneytypes,offsetX=175,offsetY=-40})
else
self:closeWindow('UITopMoneyWin4')
end

self:initAI()
end

function UISubAct_LongHuDaoDan_Win:checkBegin()
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
if not data or data.excute_len==0 then
return false
end
local beginTime=data.excuteList[data.excute_len].param_2
if beginTime and beginTime>0 then
return true
end
end

function UISubAct_LongHuDaoDan_Win:refreshProgressReward()
local actid=self.actid
local subType=self.subType
local subid=self.subid
local data=activitiesModel:getSubActInfoData(actid,subType,subid)
local cost=self.config.progress_reward[2][1]
local itemId=cost[1]
local itemCount=cost[2]or 0
local itemConfig=itemsConfig.getConfig(itemId)
local isRed=activitiesHandle_longhudaodan:checkProgressRewardReddot(actid,subType,subid)

local cur=data.progress or 0
local need=self.config.progress_reward[1]
local str=data.has_recv==1 and'已领取'or FMT.fmt('{0}%',math.floor(1000*math.min(cur,need)/need)/10)
self.progressTxt:setText(str)
self.rewardGetted:setActive(data.has_recv==1)
self.progressReddot:setActive(isRed)
self.progressEff:setChildShowEffect(0,false)
if cur>=need then
self.progressEff:setChildShowEffect(10573,true)
end
local countStr=itemCount>1 and mathHelper.formatNumber(itemCount)or''
local iconName=iconHelper.getIconName(itemConfig.icon)
local conf=
{
itemid=itemId,
iconName=iconName,
color=itemConfig.color,
itemcount=countStr,
showCountBG=itemCount>1,
}
local prop=itemsComponentHelper.getCommonSpecialFillData(conf)
self.UIBattleVictoryItem:setChildPropData(prop)
self.UIBattleVictoryItem:setBaseItemClickEvent(function(...)
if isRed then
activitiesHandle_longhudaodan.sendGetProgressReward(actid,subid)
else
tipsManager.showTips({itemid=itemId})
end
end)
end

function UISubAct_LongHuDaoDan_Win:refreshCost()
local costs=self.config.costs[1]
local count=#costs
self.LongScrollView:setChildScrollViewCreateGrids(count,count)
if count<3 then
self.winlua:SetChildSizeDelta(self.LongScrollView:getID(),count*102+20,107)
end
local grids=self.LongScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local index=i+1
local item=grids[i]
local cost=costs[index]
local itemId=cost[1]
local itemConfig=itemsConfig.getConfig(itemId)

local iconName=iconHelper.getIconName(itemConfig.icon)
local conf=
{
iconName=iconName,
color=itemConfig.color,
}
local prop=itemsComponentHelper.getCommonSpecialFillData(conf)
item:SetChildPropData(0,prop)
item:SetChildText(1,itemConfig.name)

item:SetChildText(2,self:getCountStr(itemId,cost[2]))
item:SetBaseItemClickEvent(0,function()
tipsManager.showTips({itemid=itemId})
end)
end

local costs=self.config.costs[2]
local count=#costs
self.HuScrollView:setChildScrollViewCreateGrids(count,count)
if count<3 then
self.winlua:SetChildSizeDelta(self.HuScrollView:getID(),count*102+20,107)
end
local grids=self.HuScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local index=i+1
local item=grids[i]
local cost=costs[index]
local itemId=cost[1]
local itemConfig=itemsConfig.getConfig(itemId)

local iconName=iconHelper.getIconName(itemConfig.icon)
local conf=
{
iconName=iconName,
color=itemConfig.color,
}
local prop=itemsComponentHelper.getCommonSpecialFillData(conf)
item:SetChildPropData(0,prop)
item:SetChildText(1,itemConfig.name)

item:SetChildText(2,self:getCountStr(itemId,cost[2]))
item:SetBaseItemClickEvent(0,function()
tipsManager.showTips({itemid=itemId})
end)
end

local isLongReddot=activitiesHandle_longhudaodan:checkLianDanReddot(self.subid,self.subType,1)
self.LongReddot:setActive(isLongReddot)

local isHuReddot=activitiesHandle_longhudaodan:checkLianDanReddot(self.subid,self.subType,2)
self.HuReddot:setActive(isHuReddot)
end

function UISubAct_LongHuDaoDan_Win:getCountStr(itemId,count)
local have=itemsModel.getCount(itemId)
local haveStr=mathHelper.formatNumber(have,true)
local countStr=mathHelper.formatNumber(count,true)
local isHave=have>=count
if itemsConfig.isMaterials(itemId)then
return isHave and FMT.fmt("{0}/{1}",haveStr,countStr)
or FMT.fmt("<color=red>{0}/{1}</color>",haveStr,countStr)
else
return isHave and countStr
or FMT.fmt("<color=red>{0}</color>",countStr)
end
end

function UISubAct_LongHuDaoDan_Win:getLianDanZhi(data)
local value=0
local excuteList=data.excuteList
if excuteList then
for i,v in ipairs(excuteList)do
value=value+v.param_1
end
end
return value
end

function UISubAct_LongHuDaoDan_Win:refreshLDZProgressBar(value,isReset)
if isReset then
self.jifenProgressBar:animateTwoParams(0,100)
self.jifenProgressBar:setLocalPosX(10000)
self.jfSpriteAni2:setLocalPosY(-52)
self.jfSpriteAni2:setLocalPosX(10000)
self.jfSpriteAni2:setChildDOScale(0,0,nil)
return
end
local isChange=self.ldzValue~=value
self.ldzValue=value
self.jifenProgressBar:setLocalPosX(84.1)
self.jifenProgressBar:animateTwoParams(value,self.config.jindutiao)

if isChange then
self.jfSpriteAni2:setLocalPosX(10000)
self:setTimer(0.2,1,function()
self.jfSpriteAni2:setChildAnchoredPosition(Vector3(0,-52+(value/self.config.jindutiao*(52+50)),0))
end)


local scaleList={{0.1,0},{0.15,0.35},{0.7,0.5},{0.95,0.25},{1,0}}
for i,v in ipairs(scaleList)do
if value/self.config.jindutiao<=v[1]then
self.jfSpriteAni2:setChildDOScale(v[2],0.2,nil)
break
end
end

end


self.P2LianDanZhi:setText(value)
end


function UISubAct_LongHuDaoDan_Win:onHide()
if self.showMoney then
self.showMoney=nil
self:closeWindow('UITopMoneyWin4')
end
end

function UISubAct_LongHuDaoDan_Win:initConfig()
self.freeTimes=self.config.free
end

function UISubAct_LongHuDaoDan_Win:resetData()
if self.liandanTimer then
self:stopTimerByID(self.liandanTimer)
self.liandanTimer=nil
end
self.isPause=nil
self.initLianDan=nil
self.initFire=nil

end

function UISubAct_LongHuDaoDan_Win:refreshPanel(panelType)
self.panelType=panelType or ePanelType.idle
local openFunc=openPanelFuncName[self.panelType]
self[openFunc](self)
end

function UISubAct_LongHuDaoDan_Win:refreshPage()
for i,v in ipairs(self.PageType)do
v:setActive(panelState[self.panelType][i])
end
end

function UISubAct_LongHuDaoDan_Win:showIdlePanel()
self.outfire:setScale(Vector3.zero)
for i,v in ipairs(self.fireEffect)do
v:setScale(Vector3.zero)
v:setChildPosition(Vector3.New(80.391,-170.83,0))
end
self:refreshPage()
self:checkFinishTime(true)
self.beginRoot:setActive(false)
end

function UISubAct_LongHuDaoDan_Win:updateState()
self.isSendKonHuo=false
self:refreshPanel(ePanelType.begin)
end

function UISubAct_LongHuDaoDan_Win:showBeginPanel()
self:refreshPage()
local actid=self.actid
local subType=self.subType
local subid=self.subid
local data=activitiesModel:getSubActInfoData(actid,subType,subid)
local beginTime=data.excuteList[data.excute_len].param_2
self.beginTime=beginTime

self.isPause=nil
self.beginRoot:setActive(true)

local timeStamp=gameUtilityModel.getServerShortTime()
local excute=self.config.excute[data.excute_id][data.excute_len]
local maxtime=excute and excute[2]-1 or 0
if not self.initLianDan then
self.outfire:setScale(Vector3.one)
self:resetData()
self.initLianDan=true

if beginTime==0 then
logErr("炼丹开始时间戳为0")
return
end
self:showWarringPanel(ePanelType.controlFire)
self:setTimer(warringTime,1,function()
self:refreshPanel(ePanelType.controlFire)
end)
else
if beginTime>0 and timeStamp-beginTime<maxtime then
self:showWarringPanel(ePanelType.controlFire)
self:setTimer(warringTime,1,function()
self.konhuoEff:setChildShowEffect(0,false)
self.ewKonhuoEff:setChildShowEffect(0,false)
self:refreshPanel(ePanelType.controlFire)
end)
else
self:setTimer(warringTime,1,function()
activitiesHandle_longhudaodan.sendEndLianDan(self.actid,self.subid)
self:resetData()
self:refreshLDZProgressBar(0,true)
self:refreshPanel(ePanelType.idle)
self.Start=false
end)
end
end

local value=self:getLianDanZhi(data)
self:refreshLDZProgressBar(value)
end


function UISubAct_LongHuDaoDan_Win:showControlFirePanel()
self.Page2:setChildCanvasGroupAlpha(0)
self:refreshPage()
self.Page2:setChildCanvasGroupDOFade(1,0.5,nil)

local actid=self.actid
local subType=self.subType
local subid=self.subid
local data=activitiesModel:getSubActInfoData(actid,subType,subid)
local fireArea=self.config.eventAreas[data.excute_len]
local bestArea=fireArea[1]
local goodArea=fireArea[2]
local rate=fireArea[3]or 1

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

local time
local maxtime=self.config.excute[data.excute_id][data.excute_len][2]
local beginTime=data.excuteList[data.excute_len].param_2

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
self.fireTweener=self.fireHandle:setChildDOAnchorPos(Vector3.New(0,fireHeight),3/rate)

self.fireTweener:SetEase(_Ease.Linear)
self.fireTweener:SetLoops(-1,_LoopType.Yoyo)
self:switchFireEffect(0)

self.frieUpdate=self:setTimer(0.02,0,function()
local handlePos=self.fireHandle:getChildAnchoredPosition()
local selectCnt=handlePos.y/self.fireHeight
self:switchFireEffect(selectCnt)
end)
local timeStamp=gameUtilityModel.getServerShortTime()
maxtime=self.beginTime+maxtime-timeStamp-1
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
self:showOverEffect(1)
self:refreshPanel(ePanelType.balance)
end
end
end)
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local value=self:getLianDanZhi(data)
self:refreshLDZProgressBar(value)
end

function UISubAct_LongHuDaoDan_Win:showBalancePanel()
self:refreshPage()
local actid=self.actid
local subType=self.subType
local subid=self.subid
local data=activitiesModel:getSubActInfoData(actid,subType,subid)
self:setTimer(warringTime,1,function()
activitiesHandle_longhudaodan.sendEndLianDan(self.actid,self.subid)
self:resetData()
self:refreshLDZProgressBar(0,true)
self:refreshPanel(ePanelType.idle)
self.Start=false
end)
end

function UISubAct_LongHuDaoDan_Win:switchFireEffect(selectCnt)
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

function UISubAct_LongHuDaoDan_Win:getFire(selectCnt)
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

function UISubAct_LongHuDaoDan_Win:showOverEffect(lv)
local effect={10180,10181,10182}
if effect[lv]then
self.overeffect:setChildShowEffect(effect[lv],true)
else
self.overeffect:setChildShowEffect(0,false)
end
end

local imageAb="ui/windows/activities/sub_liandandahui/liandandahui_atlas_pak.ab"
function UISubAct_LongHuDaoDan_Win:showWarringPanel(panelType)
local actid=self.actid
local subType=self.subType
local subid=self.subid
local data=activitiesModel:getSubActInfoData(actid,subType,subid)

local fireArea=self.config.eventAreas[data.excute_len]
local effType=fireArea[4]
if effType==1 then
self.warringText:setCSImageSprite(imageAb,"title_kongzhihuohou_1")
self.WarringPanel:setLocalPosY(600)
self.WarringPanel:setChildCanvasGroupAlpha(1)
self.WarringPanel:setChildDOLocalMoveY(200,0.5,nil)
local fadetweener=self.WarringPanel:setChildCanvasGroupDOFade(0,0.5)
fadetweener:SetDelay(1.25)
elseif effType==2 then
self.konhuoEff:setChildShowEffect(10563,true)
self.ewKonhuoEff:setChildShowEffect(10580,true)
elseif effType==3 then
self.konhuoEff:setChildShowEffect(10564,true)
self.ewKonhuoEff:setChildShowEffect(10580,true)
elseif effType==4 then
self.konhuoEff:setChildShowEffect(10562,true)
self.ewKonhuoEff:setChildShowEffect(10580,true)
end
end


function UISubAct_LongHuDaoDan_Win:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_LongHuDaoDan_Win:checkOver()
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
if not data then
UIManager.error("活动已结束")
self:resetData()
self:refreshPanel(ePanelType.idle)
return true
end
return false
end

function UISubAct_LongHuDaoDan_Win:checkFinishTime(refreshBtn)
local nowTime=gameUtilityModel.getServerShortTime()
local endTime=self.end_time
local banTime=self.config.finishTime
local check=false
if endTime then
if nowTime+banTime>=endTime then
check=true
if refreshBtn then
self.LongButton:setButtonEnable(true,true)
self.HuButton:setButtonEnable(true,true)
end
else
if refreshBtn then
self.LongButton:setButtonEnable(true,false)
self.HuButton:setButtonEnable(true,false)
end
end
else
check=true
if refreshBtn then
self.LongButton:setButtonEnable(true,true)
self.HuButton:setButtonEnable(true,true)
end
end
return check
end

function UISubAct_LongHuDaoDan_Win:onMask()
UIManager.error("正在炼丹中，暂无法退出")
end




function UISubAct_LongHuDaoDan_Win:onPreviewButton()
UIManager:showWindow("UILongHuDaoDanPreviewWin",{actid=self.actid,act2id=self.subid})
end


function UISubAct_LongHuDaoDan_Win:onLongButton()
local costs=self.config.costs[1]
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

if activitiesHandle_longhudaodan:checkLianDanReddot(self.subid,self.subType,1,true)then
activitiesHandle_longhudaodan.sendBeginLianDan(self.actid,self.subid,1)

AudioManager.playAudio(597)
self:resetData()


AudioManager.playBtnClick()
end
end


function UISubAct_LongHuDaoDan_Win:onHuButton()
local costs=self.config.costs[2]
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

if activitiesHandle_longhudaodan:checkLianDanReddot(self.subid,self.subType,2,true)then
activitiesHandle_longhudaodan.sendBeginLianDan(self.actid,self.subid,2)

AudioManager.playAudio(597)
self:resetData()


AudioManager.playBtnClick()
end
end


function UISubAct_LongHuDaoDan_Win:onHuoHouKongZhiButton()
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
self.isSendKonHuo=true
activitiesHandle_longhudaodan.sendControlFireGame(self.actid,self.subid,lv)

AudioManager.playAudio(597)
self.clickTimer=self:setTimer(warringTime,1,function()
self.clickTimer=nil
if self.isSendKonHuo then
self:refreshPanel(ePanelType.balance)
end
end)
end
self.bestRange=nil
self.goodRange=nil
end


function UISubAct_LongHuDaoDan_Win:onRuleBtn()
local langId=self.config.ruleLangId or''
local d={}
d.title='规则说明'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end

function UISubAct_LongHuDaoDan_Win:initAI()
if self.aiTimer then
self:stopTimerByID(self.aiTimer)
end
local func=function()
_this:addAVisitor()
end
func()
self.aiTimer=self:setTimer(12,0,func)
end

function UISubAct_LongHuDaoDan_Win:addAVisitor()
if self.visitorNum<10 then
self:createVisitor()
end
end

function UISubAct_LongHuDaoDan_Win:getADisciple()
local count=0
local stand=math.random(0,1)
if stand==1 then
local len=#self.aiDiscipleList
while(count<5)do
local dz=self.aiDiscipleList[self.dzIndex]
if not self.currDZList[dz]then
return dz,1
end
self.dzIndex=self.dzIndex+1
if self.dzIndex>len then
self.dzIndex=1
end
count=count+1
end
else
local len=#self.aiBodyList
while(count<5)do
local bodyId=self.aiBodyList[self.bodyIndex]
if not self.currDZList[bodyId]then
return bodyId,0
end
self.bodyIndex=self.bodyIndex+1
if self.bodyIndex>len then
self.bodyIndex=1
end
count=count+1
end
end
return nil
end

function UISubAct_LongHuDaoDan_Win:createVisitor()
local dzId,type=self:getADisciple()
if not dzId then
return
end
if type==1 then
self.currDZList[tostring(dzId)]=true
else
self.currDZList[dzId]=true
end
self.visitorNum=self.visitorNum+1
local tran=self.dzModels:getCommonComponent('Transform')
local standPos=math.random(0,1)
local pos=standPos==1 and Vector3.New(700,-235,0)or Vector3.New(-840,-285,0)
local initData={
speakHUDID=1,
speakTime=3,
speakHUDParent=1,
offset={0,0},
speakRate=0.5,
speakCD=4,
standPos=standPos,
targetPos1=standPos==1 and{500,-150}or{-500,-150},
targetPos2=standPos==1 and{250,-120}or{-250,-120},
targetPos3=standPos==1 and{-250,-120}or{250,-120},
targetPos4=standPos==1 and{-500,-150}or{500,-150},
endPos=standPos==1 and{-840,-285}or{700,-235},
}

local otherData={
scale=0.7,
}
if type==1 then
uiAIManager:createUIDisciple('UISubAct_LongHuDaoDan_Win','bt_ui_lhdd',dzId,tran,pos,initData,otherData,function(bt)

end)
else
uiAIManager:createUIObject('UISubAct_LongHuDaoDan_Win','bt_ui_lhdd',INSTANCE_TYPE.eUIDisciple,dzId,
tran,pos,initData,otherData,function(bt)

end)
end
end

function UISubAct_LongHuDaoDan_Win:getSpeakText(bt,tkey)
local strGroup=cfgHelper.get(cfg_longhudaodantextconfig_get,1,"textGroup")
local str=strGroup[math.random(1,#strGroup)]
bt:setSharedVar(tkey,str)
end

function UISubAct_LongHuDaoDan_Win:dzLeave(bt)
local dzId=bt:getSharedVar('dzId')
local bodyId=bt:getSharedVar('bodyId')
uiAIManager:removeUIInstance(bt)
if dzId then
self.currDZList[dzId]=nil
else
self.currDZList[bodyId]=nil
end
self.visitorNum=self.visitorNum-1
end

function UISubAct_LongHuDaoDan_Win:clearAI()
uiAIManager:clearUIWinData('UISubAct_LongHuDaoDan_Win')
end