







def_class("UIHuanJingJinDiWin",UIWindowBase)









function UIHuanJingJinDiWin:bindComponents()

self.root=UIObject.get(self,0)
self.tipsBack=UIButton.get(self,1)
self.progressRoot=UIProgressBarAni.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.bottomRoot=UIObject.get(self,4)
self.effect=UIObject.get(self,5)
self.smoke=UIObject.get(self,6)
self.dzModel=UIObject.get(self,7)
self.topList=UIObject.get(self,8)
self.helpTips=UIObject.get(self,9)
self.eventTips=UIObject.get(self,10)
self.banStart=UIObject.get(self,11)
self.startBtn=UIButton.get(self,12)
self.waitRoot=UIObject.get(self,13)
self.itemDescRoot=UIImage.get(self,14)
self.infoRoot=UIObject.get(self,15)
self.openTips=UIText.get(self,16)
self.descTx=UIText.get(self,17)
self.dzEffect=UIObject.get(self,18)
self.helpResetTime=UIText.get(self,19)
self.eventDesc=UIText.get(self,20)
self.eventIcon=UIImage.get(self,21)
self.eventName=UIText.get(self,22)
self.selectHead=UIObject.get(self,23)
self.selectName=UIText.get(self,24)
self.progressIconBg=UIImage.get(self,25)
self.progressIcon=UIObject.get(self,26)
self.itemDesc_2=UIText.get(self,27)
self.itemDesc_1=UIText.get(self,28)
self.fastBtn=UIButton.get(self,29)
self.waitTime=UIText.get(self,30)
self.helpBtn=UIButton.get(self,31)
self.cost_3=UIObject.get(self,32)
self.cost_2=UIObject.get(self,33)
self.cost_1=UIObject.get(self,34)
self.selectDz=UIButton.get(self,35)
self.emptyBtn=UIButton.get(self,36)
self.event_3=UIButton.get(self,37)
self.event_2=UIButton.get(self,38)
self.event_1=UIButton.get(self,39)
self.timesTx=UIText.get(self,40)

self.tipsBack:setButtonClick(function()self:onTipsBack()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)

self.fastBtn:setButtonClick(function()self:onFastBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.selectDz:setButtonClick(function()self:onSelectDz()end)

self.emptyBtn:setButtonClick(function()self:onEmptyBtn()end)

self.event_3:setButtonClick(function()self:onEvent_3()end)

self.event_2:setButtonClick(function()self:onEvent_2()end)

self.event_1:setButtonClick(function()self:onEvent_1()end)
self.itemDesc={
self.itemDesc_1,
self.itemDesc_2,
}
self.cost={
self.cost_1,
self.cost_2,
self.cost_3,
}
self.event={
self.event_1,
self.event_2,
self.event_3,
}



end


function UIHuanJingJinDiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsBack);self.tipsBack=nil;
_UIObject_release(self.progressRoot);self.progressRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.smoke);self.smoke=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.topList);self.topList=nil;
_UIObject_release(self.helpTips);self.helpTips=nil;
_UIObject_release(self.eventTips);self.eventTips=nil;
_UIObject_release(self.banStart);self.banStart=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.waitRoot);self.waitRoot=nil;
_UIObject_release(self.itemDescRoot);self.itemDescRoot=nil;
_UIObject_release(self.infoRoot);self.infoRoot=nil;
_UIObject_release(self.openTips);self.openTips=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.dzEffect);self.dzEffect=nil;
_UIObject_release(self.helpResetTime);self.helpResetTime=nil;
_UIObject_release(self.eventDesc);self.eventDesc=nil;
_UIObject_release(self.eventIcon);self.eventIcon=nil;
_UIObject_release(self.eventName);self.eventName=nil;
_UIObject_release(self.selectHead);self.selectHead=nil;
_UIObject_release(self.selectName);self.selectName=nil;
_UIObject_release(self.progressIconBg);self.progressIconBg=nil;
_UIObject_release(self.progressIcon);self.progressIcon=nil;
_UIObject_release(self.itemDesc_2);self.itemDesc_2=nil;
_UIObject_release(self.itemDesc_1);self.itemDesc_1=nil;
_UIObject_release(self.fastBtn);self.fastBtn=nil;
_UIObject_release(self.waitTime);self.waitTime=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.cost_3);self.cost_3=nil;
_UIObject_release(self.cost_2);self.cost_2=nil;
_UIObject_release(self.cost_1);self.cost_1=nil;
_UIObject_release(self.selectDz);self.selectDz=nil;
_UIObject_release(self.emptyBtn);self.emptyBtn=nil;
_UIObject_release(self.event_3);self.event_3=nil;
_UIObject_release(self.event_2);self.event_2=nil;
_UIObject_release(self.event_1);self.event_1=nil;
_UIObject_release(self.timesTx);self.timesTx=nil;
self.itemDesc=nil;
self.cost=nil;
self.event=nil;
end















local _this=nil
local aiOtherData={
scale=0.9,
noRescueClick=true,
}
local eventTipsX={
{97},{35,153},{22,97,172}
}
local maxSpeed=25
local clickSpeed=10
local radius=550
local correctTime=5
local waitAnim=2088
local startAnim=2089
local maxDeltaX=150
local itemCnt=4
local speed=700
local scaleRange={0,1}
local xRange={-830,970}
local posRange={Vector2.New(-830,-35),Vector2.New(70,-35),Vector2.New(970,-35)}



function UIHuanJingJinDiWin:onLoaded(...)
self:bindComponents()
_this=self

self.abName='ui/windows/huanjing/huanjing_atlas_pak.ab'

local _beginDragTopList=function(index,pos)
self:beginDragTopList(pos)
end
local _onDragTopList=function(index,pos)
self:onDragTopList(pos)
end
local _endDragTopList=function(index,pos)
self:endDragTopList(pos)
end
self.winlua:SetChildUIDragEvent(self.topList:getID(),0,_beginDragTopList,_endDragTopList,_onDragTopList)

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)

self.cds={}
end


function UIHuanJingJinDiWin:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
self:stopTopListCorrect()
self:stopCDTick()
self:stopRuleCDTick()
if self.resultBt then
behaviorManager:removeBehaviorTree(self.resultBt)
end
end




function UIHuanJingJinDiWin:onShow(argtable,afterOnloaded)
self:changeDz(self.selectDzGuid)
self:initItemList2()

UIHuanJingControl:checkShowNeedSelectTeZhiDialouge()
end


function UIHuanJingJinDiWin:onHide()

end



function UIHuanJingJinDiWin:onCloseBtn()
UIHuanJingControl:closeUI(true,true)
end


function UIHuanJingJinDiWin:onTipsBack()
if self.tipsType then
if self.tipsType==1 then
self:closeTipsRule()
elseif self.tipsType==2 then
self:closeTipsEvent()
end
end
end


function UIHuanJingJinDiWin:onStartBtn()
local cOpen=UIHuanJingControl:isJinDiOpen(self.config.id)
if cOpen then
local cost=UIHuanJingControl:getCost(self.config.id)
if cost then
for i,v in ipairs(cost)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(v[1])))
gainControl:showGainWin(v[1])
return
end
end
end
if self.selectDzGuid then

local callback=function()
UIHuanJingControl:send_25_12(self.config.id,{self.selectDzGuid})
end
UIHuanJingControl:checkDialog(self.config.id,self.selectDzGuid,callback)
else
UIManager.info("请先选择派遣弟子")
end
else
local tips=UIHuanJingControl:getJinDiOpenTips(self.config.id,"后开启")
UIManager.error(tips)
end
end


function UIHuanJingJinDiWin:onFastBtn()

end


function UIHuanJingJinDiWin:onHelpBtn()
self:showTipsRule()
end


function UIHuanJingJinDiWin:onEvent_3()
self:showTipsEvent(3)
end


function UIHuanJingJinDiWin:onEvent_2()
self:showTipsEvent(2)
end


function UIHuanJingJinDiWin:onEvent_1()
self:showTipsEvent(1)
end


function UIHuanJingJinDiWin:onEmptyBtn()
UIHuanJingControl:showJinDiSelectWindow(self.config.id,self.selectDzGuid)
end


function UIHuanJingJinDiWin:onSelectDz()
UIHuanJingControl:showJinDiSelectWindow(self.config.id,self.selectDzGuid)
end

function UIHuanJingJinDiWin.on_money_changed(moneyType,lastVal,val)
if _this.listenItem==nil then return end
local index=table.findValue(_this.listenItem,moneyType)
if index then
local costCfg=UIHuanJingControl:getCost(_this.config.id)
local cCfg=costCfg[index]
local costWidget=_this.cost[index]:getChildWidgetBase()
local str=val>=cCfg[2]and mathHelper.formatBIGNumbereEx(cCfg[2])or FMT.cfmt(FONT_COLOR.eRedColor,"{0}",mathHelper.formatBIGNumbereEx(cCfg[2]))
str=FMT.fmt("{0}：{1}",itemsConfig.getItemName(moneyType),str)
costWidget:SetChildText(1,str)
end
end

function UIHuanJingJinDiWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this.listenItem==nil then return end
local index=table.findValue(_this.listenItem,itemid)
if index then
local costCfg=UIHuanJingControl:getCost(_this.config.id)
local cCfg=costCfg[index]
local costWidget=_this.cost[index]:getChildWidgetBase()
local str=newcount>=cCfg[2]and mathHelper.formatBIGNumbereEx(cCfg[2])or FMT.cfmt(FONT_COLOR.eRedColor,"{0}",mathHelper.formatBIGNumbereEx(cCfg[2]))
str=FMT.fmt("{0}：{1}",itemsConfig.getItemName(itemid),str)
costWidget:SetChildText(1,str)
end
end

function UIHuanJingJinDiWin:changeDz(dzId)
if dzId==nil then
local dzData=UIDiscipleModel:getDiscipleByFightIndex(1)
dzId=dzData.discipleguid
end
if self.showDz~=dzId then
self.showDz=dzId
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId,false,1)
self.dzModel:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false,0)
self.dzModel:setChildUIModelShowFlipX(true)
end


end

function UIHuanJingJinDiWin:showTipsRule()
self.tipsType=1
self.tipsBack:setActive(true)
self.helpTips:setActive(true)
self:onRuleCDTick()
self:startRuleCDTick()
end

function UIHuanJingJinDiWin:startRuleCDTick()
if not self.ruleCD then
self.ruleCD=self:setTimer(1,0,function()
self:onRuleCDTick()
end)
end
end

function UIHuanJingJinDiWin:stopRuleCDTick()
if self.ruleCD then
self:stopTimerByID(self.ruleCD)
self.ruleCD=nil
end
end

function UIHuanJingJinDiWin:onRuleCDTick()
local delta=timeHelper.getNextMonthDateDisStamp(1,0,0,0)
local str=timeHelper.formatSimpleTime(delta)
str=FMT.fmt("距离下一次重置消耗还需：{0}",str)
self.helpResetTime:setText(str)
end

function UIHuanJingJinDiWin:showTipsEvent(index)
local tipsData=self.config.jyTips[index]
if tipsData.tzlist~=nil and#tipsData.tzlist>0 then
local agrs={
id=self.config.id,
name=tipsData.name,
desc=FMT.fmt(tipsData.desc,self.config.times),
list=tipsData.tzlist,
note=tipsData.note
}
UIManager:showWindow("UIHuanJingJinDiTeZiTipsWin",agrs)
else
self.tipsType=2
self.tipsBack:setActive(true)
self.eventTips:setActive(true)

local count=#self.config.jyTips
local xs=eventTipsX[count]
local x=xs[index]
self.eventTips:setChildAnchoredPos(x,-300)
self.eventIcon:setImageIcon(tipsData.icon,false)
self.eventName:setText(tipsData.name)
self.eventDesc:setText(tipsData.desc)
self.winlua:ForceLayoutRect(self.eventTips:getID())
end
end

function UIHuanJingJinDiWin:closeTipsRule()
self.tipsType=nil
self:stopRuleCDTick()
self.helpTips:setActive(false)
self.tipsBack:setActive(false)
end

function UIHuanJingJinDiWin:closeTipsEvent()
self.tipsType=nil
self.eventTips:setActive(false)
self.tipsBack:setActive(false)
end

function UIHuanJingJinDiWin:selectItem(id,noClear)

if noClear~=nil then
if not noClear then
self.selectDzGuid=nil
end
elseif self.config==nil or id~=self.config.id then
self.selectDzGuid=nil
end
self:changeDz(self.selectDzGuid)
if noClear then
self.bottomRoot:setActive(true)
self.bottomRoot:setChildCanvasGroupAlpha(1)
else
self.bottomRoot:setChildCanvasGroupAlpha(0)
self.bottomRoot:setActive(true)
self.bottomRoot:setChildCanvasGroupDOFade(1,0.5)
end
self.config=cfgHelper.get1(cfg_backmountainareaconfig_get,id)
self.descTx:setText(self.config.descStr)

local totalCount=UIHuanJingControl:getJDTotalCount(id)
local times=self.config.times or 0
self.timesTx:setActive(times>0)
if times>0 then
local timesStr=toColorString2(FONT_COLOR.eGreenColor,FMT.fmt("{0}",math.max(1,times-totalCount)))
self.timesTx:setText(FMT.fmt("{0}次历练后必出特质",timesStr))
end

local count=UIHuanJingControl:getJDCount(id)

for i,v in ipairs(self.itemDesc)do
local col=FMT.fmt("descTx{0}",i)
v:setText(self.config[col])
end
local hasCD=false
local isOpen=UIHuanJingControl:isJinDiOpen(id)
if isOpen then
self.openTips:setActive(false)
local endTime=self.cds[id]

self.waitRoot:setActive(endTime~=nil)
self.infoRoot:setActive(endTime==nil)
self.startBtn:setActive(true)
if endTime then
local nowTime=timeHelper.getServerShortTime()
local str=FMT.fmt("预计还需：{0}",timeHelper.format_time_stamp11(endTime-nowTime,true))
self.waitTime:setText(str)
self.winlua:SetChildButtonEnable(self.startBtn:getID(),false,true)
self.banStart:setActive(true)
if endTime>nowTime then
hasCD=true
end
else
self.winlua:SetChildButtonEnable(self.startBtn:getID(),true,false)
self.banStart:setActive(false)

local costCfg=UIHuanJingControl:getCost(id)
self.listenItem={}
for i,v in ipairs(self.cost)do
local cCfg=costCfg[i]
if cCfg then
local costWidget=v:getChildWidgetBase()
local itemId=cCfg[1]
local itemNum=cCfg[2]
costWidget:SetChildActive(-1,true)
costWidget:SetChildCSImageIcon(0,iconHelper.getIconName(itemId),false)
local have=itemsModel.getCount(itemId)
local str
if pfwindowslController:checkIsGameVersion_yuenan()then
str=have>=itemNum and mathHelper.formatNumberCeil4(itemNum,1)or FMT.cfmt(FONT_COLOR.eRedColor,"{0}",mathHelper.formatNumberCeil4(itemNum,1))
else
str=have>=itemNum and mathHelper.formatBIGNumbereEx(itemNum)or FMT.cfmt(FONT_COLOR.eRedColor,"{0}",mathHelper.formatBIGNumbereEx(itemNum))
end
str=FMT.fmt("{0}：{1}",itemsConfig.getItemName(itemId),str)
costWidget:SetChildText(1,str)
table.insert(self.listenItem,itemId)
elseif i==#costCfg+1 then
local costWidget=v:getChildWidgetBase()
costWidget:SetChildActive(-1,true)
costWidget:SetChildCSImageSprite(0,globalABLookup.global,"icon_tyshijian")
costWidget:SetChildText(1,FMT.fmt("冷却：{0}",timeHelper.format_time_stamp11(self.config.sec,true)))
else
v:setActive(false)
end
end

for i,v in ipairs(self.event)do
local eCfg=self.config.jyTips[i]
if eCfg then
v:setActive(true)
self.winlua:SetChildCSImageIcon(v:getID(),eCfg.icon,false)
else
v:setActive(false)
end
end

self.emptyBtn:setActive(self.selectDzGuid==nil)
self.selectDz:setActive(self.selectDzGuid~=nil)
end
else
self.startBtn:setActive(false)
self.openTips:setActive(true)
self.infoRoot:setActive(false)
self.waitRoot:setActive(false)

self.openTips:setText(UIHuanJingControl:getJinDiOpenTips(id,"后可发现此禁地"))
end

local item=self.topList:getChildLayoutGroupGridItem(self.midIdx-1)
item:SetChildActive(4,true)
item:SetChildActive(7,isOpen and totalCount+1==times and not hasCD)
local isOpen=UIHuanJingControl:isJinDiOpen(id)
if isOpen then
item:SetChildModelAnimationState(0,waitAnim)
end
end

function UIHuanJingJinDiWin:refreshSelectDz(id,disciple,force)
if force or self.config.id==id then
self.selectDzGuid=disciple
if disciple then
self:changeDz(disciple)
self.selectDz:setActive(true)




comHelper.setChildModelHeadIconBG(self.winlua,self.selectDz:getID(),disciple)
comHelper.setChildModelRawImage(self.winlua,disciple,self.selectHead:getID(),0,eHeadCenterType.eHead)
else
local first=UIDiscipleModel:getDiscipleByFightIndex(1)
self:changeDz(first.discipleguid)
self.selectDz:setActive(false)
end
end
end

function UIHuanJingJinDiWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(0.5,0,function()
self:onCDTick()
end)
end
end

function UIHuanJingJinDiWin:onCDTick()
local nowTime=timeHelper.getServerShortTime()
local over={}
for i,v in pairs(self.cds)do
if nowTime>=v then
self.cds[i]=nil

for j,w in pairs(self.dragData)do
if w==i then
local item=self.topList:getChildLayoutGroupGridItem(j-1)
item:SetChildActive(3,false)

end
end

if self.config and i==self.config.id then
self:selectItem(i)
end
end
end

if self.cds[self.config.id]then
local endTime=self.cds[self.config.id]
if nowTime<=endTime then
local str=FMT.fmt("预计还需：{0}",timeHelper.format_time_stamp11(endTime-nowTime,true))
self.waitTime:setText(str)
end
end

if next(self.cds)==nil then
self:stopCDTick()
end
end

function UIHuanJingJinDiWin:stopCDTick()

if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIHuanJingJinDiWin:refreshListItem(index,id,init)
local item=self.topList:getChildLayoutGroupGridItem(index-1)
item.gameObject.name=FMT.fmt("{0}-{1}",index,id)
local cfg=cfgHelper.get1(cfg_backmountainareaconfig_get,id)
local isOpen=UIHuanJingControl:isJinDiOpen(id)
if init~=false then
if webGLHelper:isRunWebGL()then
item:SetChildCSImageSprite(6,self.abName,cfg.image)
item:SetChildGraphicGray(6,not isOpen)
else
item:SetChildUIModelShowTarget(0,cfg.model,1,{},waitAnim,true,false,0,function()
if self.config and id==self.config.id then
item:SetChildModelAnimationState(0,waitAnim,1)
end
end)
end
item:SetChildButtonClick(-1,function()

self:onClickItem2(index)
end)
else
if self.config and id==self.config.id then
item:SetChildModelAnimationState(0,waitAnim,1)
else
item:SetChildModelAnimationStop(0,waitAnim,0)
end
end

item:SetChildText(1,cfg.name)
item:SetChildActive(2,not isOpen)


if api_Available_SetChildUIModelGray()then
item:SetChildUIModelGray(0,not isOpen)
else
local colorV=isOpen and 1 or 0.3
item:SetChildUIModelShowColor(0,Color.New(colorV,colorV,colorV,1))
end





local totalCount=UIHuanJingControl:getJDTotalCount(id)
local times=cfg.times or 0
local flag=totalCount+1==times
if isOpen then
local startTime=UIHuanJingControl:getJDTime(id)
local nowTime=timeHelper.getServerShortTime()
local endTime=startTime+cfg.sec
local cding=nowTime<endTime
item:SetChildActive(3,cding)
if cding then
self.cds[id]=endTime
self:startCDTick()
end
else
item:SetChildActive(3,false)
end
end









function UIHuanJingJinDiWin:hideOtherItem()
local itemList=self.topList:getChildLayoutGroupGridList()
for i=1,itemList.Count do
local item=itemList[i-1]
if i~=self.midIdx then
item:SetChildActive(-1,false)
else

AudioManager.playAudio(565)
item:SetChildModelAnimationState(0,startAnim,1)
item:SetChildDOAnchorPosY(0,-270,2)
item:SetChildShowEffect(5,10246,true)
item:SetChildActive(4,false)
item:SetChildActive(7,false)

end
end

end

function UIHuanJingJinDiWin:resetHideItem()
local itemList=self.topList:getChildLayoutGroupGridList()
for i=1,itemList.Count do
local item=itemList[i-1]
if i~=self.midIdx then
item:SetChildActive(-1,true)
else
item:SetChildModelAnimationState(0,waitAnim,1)
item:SetChildAnchoredPos(0,0,-180)

end
end

end

function UIHuanJingJinDiWin:startResutlAI(id,dzId)
if id==self.config.id then
local args={
dzWidget=self.winlua,
dzIndex=self.dzModel:getID(),
wait=self.config.wait_sec,
result=UIDiscipleModel:checkDiscipleState2(dzId,DISCIPLE_STATE_TYPE.eChuiWei)and 1 or 0,
effectIdx=self.effect:getID(),
dzEffect=self.dzEffect:getID(),
smokeIdx=self.smoke:getID(),
}
self.resultBt=behaviorManager:addBehaviorTree("bt_ui_huanjingjindi",nil,true,args,true)
self.bottomRoot:setActive(false)

self:refreshSelectDz(id,dzId,true)
else
UIHuanJingJinDiWin:closeWindow("UIHuanJingJinDiResultWin")
self:endResutlAI()
end
end

function UIHuanJingJinDiWin:endResutlAI()
self:resetHideItem()
self.dzModel:setChildAnchoredPos(-400,-320)
self:changeDz(self.selectDzGuid)
self.resultBt=nil
local items=self.topList:getChildLayoutGroupGridList()
for i=1,items.Count do
self:refreshListItem(i,self.dragData[i],false)
end
self:selectItem(self.config.id)
end

function UIHuanJingJinDiWin:startProgress(time)
self.progressRoot:setActive(true)
comHelper.setChildModelRawImage(self.winlua,self.selectDzGuid,self.progressIcon:getID(),0,eHeadCenterType.eHead)
self.progressRoot:animateFiveParams(0,100,100,time)
local item=self.topList:getChildLayoutGroupGridItem(self.midIdx-1)
item:SetChildShowEffect(5,10247,true)
end

function UIHuanJingJinDiWin:endProgress()
self.progressRoot:setActive(false)
local item=self.topList:getChildLayoutGroupGridItem(self.midIdx-1)
item:SetChildShowEffect(5,-1,false)
end

function UIHuanJingJinDiWin:initItemList2()
local cfg=cfg_backmountainareaconfig()
self.idList={}
for i,v in pairs(cfg)do
if v.id then
table.insert(self.idList,v.id)
end
end
table.sort(self.idList)
self.dragData={}
self.angle={}
self.leftIdx=1
self.midIdx=itemCnt/2

self.rightIdx=itemCnt
self.topList:setChildLayoutGroupCreateItems(itemCnt,function(index)
local dataIdx=(index-self.midIdx)%#self.idList+1
self.dragData[index]=dataIdx
self:refreshListItem(index,dataIdx)
local deltaAngle=180/itemCnt
self.angle[index]=index*deltaAngle
local rad=math.rad(index*deltaAngle)
local pos=Vector2.New(70-radius*math.cos(rad),-35)
local item=self.topList:getChildLayoutGroupGridItem(index-1)
item:SetChildAnchoredPosition(-1,pos)
item:SetChildScale(-1,Vector3.one*math.sin(rad))
end)
self:selectItem(self.dragData[self.midIdx])
end

function UIHuanJingJinDiWin:limitListIndex(index,max)
local temp=index%max
return temp==0 and max or temp
end

function UIHuanJingJinDiWin:beginDragTopList(pos)
if self.dragCorrect then return end

self.dragPos=pos
self:closeSelectItem()
end

function UIHuanJingJinDiWin:onDragTopList(pos)
if self.dragPos==nil then return end

local delta=pos-self.dragPos
self:onDragTopListDelta(delta)

self.dragPos=pos
end

function UIHuanJingJinDiWin:onDragTopListAngle(delta)
delta=math.floor(delta*100+0.5)/100
local items=self.topList:getChildLayoutGroupGridList()
for i=1,items.Count do
local item=items[i-1]
local angle=self.angle[i]
angle=angle+delta
angle=math.floor(angle*100+0.5)/100

if angle<=0 then
angle=angle+180
self.dragData[i]=self:limitListIndex(self.dragData[self.rightIdx]+1,#self.idList)
self:refreshListItem(i,self.dragData[i])
self.leftIdx=self:limitListIndex(self.leftIdx+1,itemCnt)
self.midIdx=self:limitListIndex(self.midIdx+1,itemCnt)

self.rightIdx=self:limitListIndex(self.rightIdx+1,itemCnt)
item:SetAsLastSibling(-1)
elseif angle>180 then
angle=angle-180
self.dragData[i]=self:limitListIndex(self.dragData[self.leftIdx]-1,#self.idList)
self:refreshListItem(i,self.dragData[i])
self.leftIdx=self:limitListIndex(self.leftIdx-1,itemCnt)
self.midIdx=self:limitListIndex(self.midIdx-1,itemCnt)

self.rightIdx=self:limitListIndex(self.rightIdx-1,itemCnt)
item:SetAsLastSibling(-1)
end
self.angle[i]=angle

local rad=math.rad(angle)
local pos=Vector2.New(70-radius*math.cos(rad),-35)
item:SetChildAnchoredPosition(-1,pos)
item:SetChildScale(-1,Vector3.one*math.sin(rad))
end
end

function UIHuanJingJinDiWin:onDragTopListDelta(delta)
local deltaX=Mathf.Clamp(delta.x,-maxDeltaX,maxDeltaX)


local deltaT=deltaX/clickSpeed
self:onDragTopListAngle(deltaT)
end

function UIHuanJingJinDiWin:endDragTopList(pos)
if self.dragPos==nil then return end
self.dragPos=nil

local a1=self.angle[self.midIdx]
local ns=self:limitListIndex(self.midIdx+1,itemCnt)
local a2=self.angle[ns]
local d1=math.abs(a1-90)
local d2=math.abs(a2-90)
local idx=d1<d2 and self.midIdx or ns
if self.angle[idx]~=90 then
self:dragToItem(idx)
else
self:selectItem(self.dragData[idx])
end
end

function UIHuanJingJinDiWin:stopTopListCorrect()
if self.dragCorrect then
self:stopTimerByID(self.dragCorrect)
self.dragCorrect=nil
end
end

function UIHuanJingJinDiWin:closeSelectItem()
local item=self.topList:getChildLayoutGroupGridItem(self.midIdx-1)
item:SetChildModelAnimationStop(0,waitAnim)
item:SetChildActive(4,false)
item:SetChildActive(7,false)

self.bottomRoot:setActive(false)

end


function UIHuanJingJinDiWin:dragToItem(selectIdx)


















self.dragCorrect=self:setTimer(0.02,0,function()
local nAngle=self.angle[selectIdx]
local delta=nAngle-90
local deltaV=math.abs(delta)
local sign=Mathf.Sign(delta)
local deltaEx=math.min(deltaV/2,maxSpeed)
if deltaV<=1 then
self:onDragTopListAngle(deltaV*-sign)
self:selectItem(self.dragData[selectIdx])
self:stopTopListCorrect()
elseif sign<0 then
self:onDragTopListAngle(deltaEx)
elseif sign>0 then
self:onDragTopListAngle(-deltaEx)
end

end)
end

function UIHuanJingJinDiWin:onClickItem2(index)
if self.dragCorrect or self.dragPos then return end

self:dragToItem(index)
self:closeSelectItem()
end

function UIHuanJingJinDiWin:refreshView()

local items=self.topList:getChildLayoutGroupGridList()
for i=1,items.Count do
self:refreshListItem(i,self.dragData[i],false)
end
self:selectItem(self.dragData[self.midIdx],true)
end
