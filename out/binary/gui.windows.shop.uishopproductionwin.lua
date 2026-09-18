







def_class("UIShopProductionWin",UIWindowBase)









function UIShopProductionWin:bindComponents()

self.btnBag=UIButton.get(self,0)
self.btnSelect=UIObject.get(self,1)
self.btnSelectReddot=UIObject.get(self,2)
self.btnText=UIText.get(self,3)
self.cancelProduceBtn=UIButton.get(self,4)
self.costItem1=UIBaseItem.get(self,5)
self.costItem2=UIBaseItem.get(self,6)
self.countBtn=UIButton.get(self,7)
self.diziInfo=UIObject.get(self,8)
self.dzName=UIText.get(self,9)
self.helpBtn=UIButton.get(self,10)
self.infoText=UIText.get(self,11)
self.jobLevel=UIText.get(self,12)
self.leftArrow=UIButton.get(self,13)
self.leftArrowImg=UIObject.get(self,14)
self.name=UIText.get(self,15)
self.order_1=UIObject.get(self,16)
self.order_2=UIObject.get(self,17)
self.order_3=UIObject.get(self,18)
self.orderText_1=UIText.get(self,19)
self.orderText_2=UIText.get(self,20)
self.orderText_3=UIText.get(self,21)
self.productionItem1=UIBaseItem.get(self,22)
self.productionItem2=UIBaseItem.get(self,23)
self.productionItem3=UIBaseItem.get(self,24)
self.qiantai=UIObject.get(self,25)
self.queueItem1=UIObject.get(self,26)
self.queueItem2=UIObject.get(self,27)
self.queueItem3=UIObject.get(self,28)
self.quickBtn=UIButton.get(self,29)
self.rightArrow=UIButton.get(self,30)
self.rightArrowImg=UIObject.get(self,31)
self.root=UIObject.get(self,32)
self.sbg=UIImage.get(self,33)
self.scrollView=UIObject.get(self,34)
self.selectBtn=UIButton.get(self,35)
self.startBtn=UIButton.get(self,36)
self.state=UIToggleButton.get(self,37)
self.timeicon=UIObject.get(self,38)
self.timeRoot=UIObject.get(self,39)
self.timeTxt=UIText.get(self,40)
self.title=UIText.get(self,41)
self.txtSelect=UIText.get(self,42)
self.waichu=UIObject.get(self,43)

self.btnBag:setButtonClick(function()self:onBtnBag()end)

self.cancelProduceBtn:setButtonClick(function()self:onCancelProduceBtn()end)

self.countBtn:setButtonClick(function()self:onCountBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)
self.order={
self.order_1,
self.order_2,
self.order_3,
}
self.orderText={
self.orderText_1,
self.orderText_2,
self.orderText_3,
}



end


function UIShopProductionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnBag);self.btnBag=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnSelectReddot);self.btnSelectReddot=nil;
_UIObject_release(self.btnText);self.btnText=nil;
_UIObject_release(self.cancelProduceBtn);self.cancelProduceBtn=nil;
_UIObject_release(self.costItem1);self.costItem1=nil;
_UIObject_release(self.costItem2);self.costItem2=nil;
_UIObject_release(self.countBtn);self.countBtn=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.infoText);self.infoText=nil;
_UIObject_release(self.jobLevel);self.jobLevel=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.order_1);self.order_1=nil;
_UIObject_release(self.order_2);self.order_2=nil;
_UIObject_release(self.order_3);self.order_3=nil;
_UIObject_release(self.orderText_1);self.orderText_1=nil;
_UIObject_release(self.orderText_2);self.orderText_2=nil;
_UIObject_release(self.orderText_3);self.orderText_3=nil;
_UIObject_release(self.productionItem1);self.productionItem1=nil;
_UIObject_release(self.productionItem2);self.productionItem2=nil;
_UIObject_release(self.productionItem3);self.productionItem3=nil;
_UIObject_release(self.qiantai);self.qiantai=nil;
_UIObject_release(self.queueItem1);self.queueItem1=nil;
_UIObject_release(self.queueItem2);self.queueItem2=nil;
_UIObject_release(self.queueItem3);self.queueItem3=nil;
_UIObject_release(self.quickBtn);self.quickBtn=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sbg);self.sbg=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.state);self.state=nil;
_UIObject_release(self.timeicon);self.timeicon=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.txtSelect);self.txtSelect=nil;
_UIObject_release(self.waichu);self.waichu=nil;
self.order=nil;
self.orderText=nil;
end


















local _format=string.format

local _this

local queueItemIndex={
queueItem=0,
bg=1,
productionItem=2,
time=3,
title=4,
nullBg=5,
nullTxt=6,
reddot=7,
model=8,
barRoot=9,
bar=10,
barValue=11,
}

local widgetState={
eNull=0,
eCreate=1,
}

function UIShopProductionWin:onLoaded(...)
self:bindComponents()
self.productionItemList={self.productionItem1,self.productionItem2,self.productionItem3}
self.costItemList={self.costItem1,self.costItem2}
self.queueItemList={self.queueItem1,self.queueItem2,self.queueItem3}
self.queuewidgetList={}
for i,v in ipairs(self.productionItemList)do
v:setBaseItemClickEvent(function(...)
self:productionItemCilck(i,...)
end)
v:setBaseItemLongTouchEvent(function(...)
self:productionItemLongTouch(...)
end)

end
for i,v in ipairs(self.costItemList)do
v:setBaseItemClickEvent(function(...)
self:costItemCilck(...)
end)
end
for i,v in ipairs(self.queueItemList)do
local widget=v:getChildWidgetBase()
self.queuewidgetList[#self.queuewidgetList+1]=widget
widget:SetBaseItemClickEvent(queueItemIndex.productionItem,function(...)
self:queueItemCilck(i,...)
end)
widget:SetChildUIModelShowTarget(queueItemIndex.model,5296,1,nil,2184)
widget:SetChildActive(queueItemIndex.bg,false)
widget:SetChildActive(queueItemIndex.nullBg,false)
end

self.shope_bg_ab='ui/windows/shop/sharedtextures/{0}.ab'

_this=self

self.state:setToggleChange(function(name,isOn,data)
if isOn then
self:onState()
end
end)
self.scrollView:setChildScrollViewInit(0.5,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)

self.enterPosL={-450,-300}
self.leftPos={-350,-235}
self.rightPos={-110,-235}
self.jumpPos={-435,-300}

self.waichu:setActive(false)
self.btnSelect:setActive(false)
self.selectIndex=1
self.widgetState={}
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end

function UIShopProductionWin:onState()
UIManager.error("onState")

end

function UIShopProductionWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.bdData.dizi_id,config=data})
end


function UIShopProductionWin:__delete()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
self:clear()
self:unbindComponents()
_this=nil
end




function UIShopProductionWin:onShow(argtable,afterOnloaded)
self.isHide=false
self:refresh(argtable)
self:refreshCancelProduceBtn()
end

function UIShopProductionWin:onShowArgRecv(argtable)
self.isHide=false
self:refresh(argtable)
end


function UIShopProductionWin:onHide()
self.isHide=true
self:clear()
end
function UIShopProductionWin:refresh(argtable)


local bdData=argtable
self.bdData=bdData
self.sfId=zongmenModel:getMountainId()
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
self.title:setText(cfg.name)

local scfg=cfgHelper.get1(cfg_shangpuconfig_get,bdData.build_id)
local bfname=scfg.bg_image
local abName=FMT.fmt(self.shope_bg_ab,bfname)
self.sbg:setSprite(abName,bfname)

self.config=cfg
self.bdType=self.config.id
UIShopControl:setTitle(cfg.name)

if not self.isInitAI then
self.isInitAI=true
self:initAI(self.bdData.dizi_id)
end

self:initOrdelList()
self:refreshLeftPanel()
self:refreshRightPanel()

self:showBuffState()





self:checkAndShowArrowBtn()
end

function UIShopProductionWin:refreshRightPanel()
self:refreshProductionItemList()
self:refreshCostItemList()
self:setSelectItemName()
self:setSelectItemCostTime()
self:refreshBtnState()
self:refreshCancelProduceBtn()
end

function UIShopProductionWin:refreshProductionItemList()
local bdData=self.bdData
local id=bdData.build_id
local level=bdData.level
local productionItemList=UIShopModel:getProductionItemList(id,level)

for i,v in ipairs(self.productionItemList)do
local itemid=productionItemList[i][1]
if itemid then
v:setActive(true)
local conf={
showname=false,
showStageBg=false,
showCountBG=true,
itemcount="",
stage="",
select=i==self.selectIndex,
gray=productionItemList[i][2]and 0 or 3,
}
local item_data={itemid=itemid,itemcount=0}
local prop=itemsComponentHelper.getCommonFillData(item_data,conf)

local itemNum=itemsModel.getCount(itemid)
local countStr=string.format('库存:%s',itemNum)
local level=0
if productionItemList[i][2]and productionItemList[i][2].level then
level=productionItemList[i][2].level
end

if level and level>0 then
local zmLevel=zongmenModel:getLevel()
if zmLevel>=level then
prop[PropIndex(DataPropKey.eWidgetText,4)]=countStr
else
prop[PropIndex(DataPropKey.eWidgetActive,8)]=true
end
else
prop[PropIndex(DataPropKey.eWidgetText,4)]=countStr
end

v:setChildPropData(prop)

local count=self.orderList[itemid]or 0
local itemObj=self.order[i]
local itemText=self.orderText[i]
if count>0 then
itemText:setText(string.format('<color=#E9AC3B>订单</color>:%s',count))
end
itemObj:setActive(count>0)
else
v:setActive(false)
end
end
end

function UIShopProductionWin:refreshCostItemList()
local bdData=self.bdData
local id=bdData.build_id
local level=bdData.level
local costItemListAll=UIShopModel:getCostItemList(id,level)
local costItemList=costItemListAll[self.selectIndex]
for i,v in ipairs(self.costItemList)do
local itemCfg=costItemList[i]
if itemCfg then
v:setActive(true)
local itemid=itemCfg[1]
local needCount=itemCfg[2]
local hasCount=itemsModel.getCount(itemid)
local itemfmtStr=hasCount<needCount and"<color=#C82C2C>{0}/{1}</color>"or"{0}/{1}"
local moneyfmtStr=hasCount<needCount and"<color=#C82C2C>{0}</color>"or"{0}"
local fmtStr=itemsConfig.isMoney(itemid)and moneyfmtStr or itemfmtStr
local conf={
showname=false,
showStageBg=true,
showCountBG=true,
itemcount=FMT.fmt(fmtStr,mathHelper.formatNumber(itemsConfig.isMoney(itemid)and needCount or hasCount),mathHelper.formatNumber(needCount))
}
local item_data={itemid=itemid,itemcount=0}
local prop=itemsComponentHelper.getCommonFillData(item_data,conf)

v:setChildPropData(prop)
else
v:setActive(false)
end
end
end

function UIShopProductionWin:setSelectItemName()
local bdData=self.bdData
local id=bdData.build_id
local level=bdData.level
local productionItemList=UIShopModel:getProductionItemList(id,level)
local itemid=productionItemList[self.selectIndex][1]
local name=itemsConfig.getTipsColorName(itemid)
self.name:setText(name)
end

function UIShopProductionWin:setSelectItemCostTime()
local bdData=self.bdData
local id=bdData.build_id
local level=bdData.level
local productionItemTimeList=UIShopModel:getProductionItemTimeList(id,level)
local time=productionItemTimeList[self.selectIndex]
self.timeTxt:setText(timeHelper.format_time_stamp3(time,false))
end

function UIShopProductionWin:initAI(dzId)

self.winlua:SetChildCanvasEx(self.qiantai:getID(),'',1001)
self.winlua:SetChildSimulateDepth(self.qiantai:getID(),-300,1100,0.5,0,0)

dzId=tostring(dzId)
if dzId=='0'then
return
end

local state=UIDiscipleModel:getDiscipleState(dzId)
local waichu=state==DISCIPLE_STATE_TYPE.edsDispatch
self.waichu:setActive(waichu)
if waichu then
return
end

self.hasManager=true

if state==DISCIPLE_STATE_TYPE.eChuiWei then
self.hasManager=false
end

self:createDZ(self.bdData.dizi_id,self.rightPos,function(bt)
self.currDZ=bt
self:changeDzState()
self.currDZ:setSharedVar('UIstateId',1)
self:setDZDepth(bt)
end)
end

function UIShopProductionWin:setDZDepth(bt)
local dzWidget=bt:getSharedVar('dzWidget')
local dzIndex=bt:getSharedVar('dzIndex')
dzWidget:SetChildSimulateDepth(dzIndex,-300,1100,0.5,0.001,0.001)
dzWidget:SetChildSimulateDepthActiveUpdate(dzIndex,true)
end

function UIShopProductionWin:createDZ(dzId,pos,callback)
local cfg=cfgHelper.get1(cfg_selleraiconfig_get,1)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=1,
leftPos=self.leftPos,
rightPos=self.rightPos,
enterPos=self.enterPosL,
jumpPos=self.jumpPos,
minSpeakCD=cfg.ui_s_speak_cd[1],
maxSpeakCD=cfg.ui_s_speak_cd[2],
minWaitCD=cfg.ui_c_speak_cd[1],
maxWaitCD=cfg.ui_c_speak_cd[1],
isFinish=0,
animId=10,


}
self.speakRate=cfg.ui_c_speak_rate
self.finishTxt=cfg.ui_c_speak_finish
local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local dzstr=tostring(dzId)

local otherData={
order=1001,
cwCallback=function(bt,ov,cv)
self.hasManager=not cv

end,
}
uiAIManager:createUIDisciple('UIShopProductionWin','bt_ui_shop_production',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end

function UIShopProductionWin:refreshLeftPanel()
self.btnSelect:setActive(true)
local dzId=self.bdData.dizi_id
if tostring(dzId)~='0'then
































self.txtSelect:setText('更替')
local shake=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSelectReddot:setActive(shake)
if shake then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.btnSelect:getID())
else
self.winlua:SetChildDOTweenAnimation_DOPause(self.btnSelect:getID())
self.btnSelect:setRotation(0,0,0)
end
else




self.txtSelect:setText('安排')
local reddot=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSelectReddot:setActive(reddot)
self.winlua:SetChildDOTweenAnimation_DOPause(self.btnSelect:getID())
self.btnSelect:setRotation(0,0,0)
end

self:refreshQueueItemList()
end

function UIShopProductionWin:refreshQueueItemList()
local queue,count=self:getQueue()
for i,v in ipairs(self.queuewidgetList)do
local widget=v
local isNull=queue[i]==nil
widget:SetChildActive(queueItemIndex.productionItem,false)
widget:SetChildActive(queueItemIndex.title,false)
widget:SetChildActive(queueItemIndex.time,false)
widget:SetChildActive(queueItemIndex.nullTxt,false)
widget:SetChildActive(queueItemIndex.reddot,false)
widget:SetChildActive(queueItemIndex.barRoot,false)
local _func=function()
widget:SetChildActive(queueItemIndex.productionItem,not isNull)
widget:SetChildActive(queueItemIndex.title,not isNull)
widget:SetChildActive(queueItemIndex.time,not isNull)
widget:SetChildActive(queueItemIndex.nullTxt,isNull)
widget:SetChildActive(queueItemIndex.barRoot,not isNull)
if not isNull then
widget:SetChildActive(queueItemIndex.barRoot,queue[i].canStart)
widget:SetChildText(queueItemIndex.title,FMT.fmt("队列{0}",mathHelper.numberToChinese(i)))
local finish_times=queue[i].finish_times
local conf={
showbg=true,
showname=false,
showStageBg=false,
showCountBG=false,
itemcount="",
stage=""
}
local item_data={itemid=queue[i].itemid,itemcount=0}
local prop=itemsComponentHelper.getCommonFillData(item_data,conf)

widget:SetChildPropData(queueItemIndex.productionItem,prop)
local curTime=timeHelper.getServerShortTime()
local showTime=finish_times-curTime
widget:SetChildActive(queueItemIndex.reddot,showTime<=0)
widget:SetChildText(queueItemIndex.time,showTime<=0 and"已完成"or(queue[i].canStart and timeHelper.format_time_stamp3(showTime,false)or"等待中"))
if showTime<=0 then
widget:SetChildUIProgressbar(queueItemIndex.bar,queue[i].needTime,queue[i].needTime,false)
else
widget:SetChildUIProgressbar(queueItemIndex.bar,queue[i].canStart and queue[i].needTime-showTime or 0,queue[i].needTime,false)
end

end
end

local lastState=self.widgetState[i]or widgetState.eNull
local animId
if isNull then
animId=lastState==widgetState.eNull and eAnimationID.shop_null or eAnimationID.shop_create_to_null
else
animId=lastState==widgetState.eNull and eAnimationID.shop_null_to_create or eAnimationID.shop_create
end
self.widgetState[i]=isNull and widgetState.eNull or widgetState.eCreate

widget:SetChildModelAnimationState(queueItemIndex.model,animId,1)


if animId==eAnimationID.shop_null or animId==eAnimationID.shop_create then
_func()
else
self:setTimer(0.35,1,_func)
end
end
self:refreshBtn()

local func=function()
local queue,count,allfinish=self:getQueue()
for i,v in ipairs(self.queuewidgetList)do
local isNull=queue[i]==nil
local widget=v
if not isNull then
widget:SetChildActive(queueItemIndex.barRoot,queue[i].canStart)
local finish_times=queue[i].finish_times
local curTime=timeHelper.getServerShortTime()
local showTime=finish_times-curTime
if showTime>0 then
widget:SetChildText(queueItemIndex.time,queue[i].canStart and timeHelper.format_time_stamp3(showTime,false)or"等待中")
widget:SetChildUIProgressbar(queueItemIndex.bar,queue[i].canStart and queue[i].needTime-showTime or 0,queue[i].needTime,false)

else
widget:SetChildText(queueItemIndex.time,"已完成")
widget:SetChildActive(queueItemIndex.reddot,true)
widget:SetChildUIProgressbar(queueItemIndex.bar,queue[i].needTime,queue[i].needTime,false)
reddotControl.on_change_catch_type(CATCH_TYPE.eShopCreate)



end
end
end
if count<=0 or allfinish then
self:stopHandleTimer()
return
end
end
self:startHandleTimer(func)
end

function UIShopProductionWin:refreshBtn()
local queue,count=self:getQueue()
local grayFlag=count>=3
self.startBtn:setGray(grayFlag)
end

function UIShopProductionWin:startHandleTimer(func)
if not self.HandleTimer then
self.HandleTimer=self:setTimer(1,0,func)
self:changeDzState()
end
end

function UIShopProductionWin:stopHandleTimer()
if self.HandleTimer then
self:stopTimerByID(self.HandleTimer)
self.HandleTimer=nil
self:changeDzState()
end
end

function UIShopProductionWin:getQueue()
local bdData=self.bdData
local bdId=bdData.build_id
local ubdId=bdData.un_build_id
local level=bdData.level
local createList=UIShopModel:getCreateList(ubdId)

local temp={}
local productionItemList=UIShopModel:getProductionItemList(bdId,level)
local productionItemTimeList=UIShopModel:getProductionItemTimeList(bdId,level)
local allfinish=true
local hasStart=false
local finish_times
local curTime=timeHelper.getServerShortTime()
for i,v in ipairs(createList)do
finish_times=v.param_2+productionItemTimeList[v.param_1]

local canStart=false
if not hasStart then
hasStart=(finish_times-curTime)>0
canStart=(finish_times-curTime)>0
end
temp[i]={
idx=v.param_1,
itemid=productionItemList[v.param_1][1],


finish_times=finish_times,
canStart=canStart,
needTime=productionItemTimeList[v.param_1]
}
if allfinish then
allfinish=(finish_times-curTime)<=0
end
end
return temp,#temp,allfinish
end

function UIShopProductionWin:EnQueue()

end

function UIShopProductionWin:setStateButton(bActive)
self.state:setToggle(bActive)
end

function UIShopProductionWin:showBuffState()
if not self.bdData or tostring(self.bdData.dizi_id)=='0'then
self.state:setActive(false)
return
end

local edatas=zongmenModel:getShopEffect(self.bdData)
self.state:setActive(false)
end

function UIShopProductionWin:checkAndShowArrowBtn()

local bdDatas=zongmenModel:getAllBuildingData(self.sfId)
local list={}
for k,v in pairs(bdDatas)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg.build_type==24 and v.isLinkRoad then
table.insert(list,v)
end
end
local len=#list
local showArrow=len>1
self.otherBDData=list
self.leftArrow:setActive(showArrow)
self.rightArrow:setActive(showArrow)
if showArrow and not self.showArrowAnim then
self.showArrowAnim=true
local tween1=self.leftArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween1:SetEase(_Ease.InOutSine)
tween1:SetLoops(-1,_LoopType.Yoyo)
local tween2=self.rightArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween2:SetEase(_Ease.InOutSine)
tween2:SetLoops(-1,_LoopType.Yoyo)
end
end

function UIShopProductionWin:toNextWin(arrow)
local ubdId=self.bdData.un_build_id
local index
for i,v in ipairs(self.otherBDData)do
if v.un_build_id==ubdId then
index=i
break
end
end

if not index then
return
end

index=index+arrow
local len=#self.otherBDData
if index>len then
index=index-len
elseif index<1 then
index=index+len
end

self.leftArrow:setActive(false)
self.rightArrow:setActive(false)

local bdData=self.otherBDData[index]
self:clear()
self.hasManager=false

UIShopControl:showShopProductionWindow(bdData)
end

function UIShopProductionWin:clear()
roleAudioController:stopRoleSpeak()

uiAIManager:clearUIWinData('UIShopProductionWin')

self.isInitAI=false
self.currDZ=nil
self.selectIndex=1
self:stopHandleTimer()
end




function UIShopProductionWin:onLeftArrow()
self:toNextWin(-1)
end


function UIShopProductionWin:onRightArrow()
self:toNextWin(1)
end


function UIShopProductionWin:onCountBtn()
end


function UIShopProductionWin:onSelectBtn()
if self.bdData.flag~=0 then
UIManager.error('商铺升级中无法转型')
return
end
if UIShopControl:checkCreating(self.bdData)then
UIManager.error('当前商铺正在生产，不可转型')
return
end
local sdata=UIShopModel:getShopData(self.bdData.un_build_id)
if not sdata.is_in_event then
UIManager:showWindow('UIShopSelectWin',{self.bdData})
else
UIManager.error('当前商铺存在事件，不可转型')
end
end


function UIShopProductionWin:onBtnBag()
UIManager:showWindow("UIShopHuoCangWin")
end

function UIShopProductionWin:onHelpBtn()
local d={}
d.title='商铺生产规则'
d.mode=3
d.name='shopProduction_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIShopProductionWin:onStartBtn()
if not self.bdData or tostring(self.bdData.dizi_id)=='0'then
UIManager.error("没安排弟子无法生产")
return
end
if UIDiscipleModel:checkDiscipleState2(self.bdData.dizi_id,DISCIPLE_STATE_TYPE.eChuiWei)then
UIManager.error("弟子垂危无法生产")
return
end

local queue,count=self:getQueue()
if count<3 then
local bdData=self.bdData
local id=bdData.build_id
local level=bdData.level
local costItemListAll=UIShopModel:getCostItemList(id,level)
local costItemList=costItemListAll[self.selectIndex]
for k,v in pairs(costItemList)do
local itemid=v[1]
local needCount=v[2]
local hasCount=itemsModel.getCount(itemid)
if needCount>hasCount then
gainControl:showGainWin(itemid)
UIManager.error("材料不足")
return
end
end
UIShopControl.Req_9_15(self.bdData.un_build_id,self.selectIndex)

else
UIManager.error("队列已满")
end
end

function UIShopProductionWin:productionItemCilck(index,itemId)
local bdData=self.bdData
local id=bdData.build_id
local level=bdData.level
local productionItemList=UIShopModel:getProductionItemList(id,level)
local realItem=productionItemList[index][2]
if not realItem then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local name=cfg.name
UIManager.info(FMT.fmt("{0}需达到{1}级",name,productionItemList[index][3]))
return
end
if self.selectIndex==index then
return
end

local level=productionItemList[index][2].level or 0
if level and level>0 then
local zmLevel=zongmenModel:getLevel()
if zmLevel<level then
UIManager.error(string.format('宗门等级%s级解锁',level))
return
end
end

local prop={}
prop[PropIndex(DataPropKey.eWidgetActive,1)]=false
self.productionItemList[self.selectIndex]:setChildPropData(prop)
self.selectIndex=index
prop[PropIndex(DataPropKey.eWidgetActive,1)]=true
self.productionItemList[self.selectIndex]:setChildPropData(prop)
self:setSelectItemName()
self:setSelectItemCostTime()
self:refreshCostItemList()
end

function UIShopProductionWin:refreshBtnState()
local queue,count,allfinish=self:getQueue()
self.quickBtn:setActive(not allfinish)
end

function UIShopProductionWin:productionItemLongTouch(itemid,index,itemguid,attach)



tipsManager.showTips({itemid=itemid,itemguid=index,move=TIPS_MOVE_POS.eLeft})
end

function UIShopProductionWin:costItemCilck(itemid,index,itemguid,attach)








tipsManager.showTips({itemid=itemid,itemguid=index,move=TIPS_MOVE_POS.eLeft})
end

function UIShopProductionWin:queueItemCilck(index,itemid,indexEx,itemguid,attach)
local queue=self:getQueue()
if not queue[index]then
return
end
local finish_times=queue[index].finish_times
local curTime=timeHelper.getServerShortTime()
if finish_times>curTime then


tipsManager.showTips({itemid=itemid,itemguid=index,move=TIPS_MOVE_POS.eCenter})
return
end
local bdData=self.bdData
local ubdId=bdData.un_build_id
UIShopControl.Req_9_16(0)
end

function UIShopProductionWin:onClickClose()

AudioManager.playBtnClick()
fullScreenUI.closeActiveUI()
end

function UIShopProductionWin:onQuickBtn()
local cnt=0
local needTime=0
local config=cfg_shangpubasicconfig_get(1)
local itemId=next(config.accelerate_conf)
local itemName=itemsModel.getName(itemId)
local time=config.accelerate_conf[itemId][1]
local queue,count,allfinish=self:getQueue()

local haveNum=itemsModel.getCount(itemId)
if haveNum<=0 then UIManager.info(string.format('祖师，您现在没有%s哦',itemName))return end

if count>0 and queue then
for k,v in ipairs(queue)do
local finish_times=v.finish_times
local curTime=timeHelper.getServerShortTime()
local showTime=finish_times-curTime
if showTime>0 then
if v.canStart==false then showTime=v.needTime end
needTime=needTime+showTime
end
end
end

cnt=math.ceil(needTime/time)
if haveNum<cnt then cnt=haveNum end
local iconStr=iconHelper.getIconName(itemId)
local colorNum=itemsConfig.getItemColor(itemId)
local color=FONT_COLOR_VAL[colorNum]
local costStr=FMT.fmt("剩余：quad-icon={1}-quad<color=#549327>{0}</color>",haveNum,iconStr)
local contentStr=string.format('是否消耗%s张<color=%s>[%s]</color>，完成当前所有生产队列商品？\n\n%s',cnt,color,itemName,costStr)

local callBack=function()
socketManager:send_9_18(self.bdData.un_build_id,itemId,cnt)
end

local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=callBack,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end

function UIShopProductionWin:startWork(bt)


end

function UIShopProductionWin:getDZSpeakRate(bt,key)
local rate=self.speakRate
bt:setSharedVar(key,rate)
end

function UIShopProductionWin:getDZrandomPos(bt,key)
if not self.lastPosIndex then
self.lastPosIndex=1
end
local temp={{2,3},{1,3},{1,2}}
local indexList=temp[self.lastPosIndex]
local newIndex=indexList[math.random(2)]
local randomPosList={self.rightPos,self.leftPos,{-250,-235}}
self.lastPosIndex=newIndex
local randomPos=randomPosList[newIndex]
bt:setSharedVar(key,randomPos)
end

function UIShopProductionWin:getSpeakText(bt,tkey,stype)
local bdData=self.bdData
local id=bdData.build_id
local level=bdData.level
local cfg=cfgHelper.get2(cfg_shangpulevelconfig_get,id,level)
local shopData=UIShopModel:getShopData(bdData.un_build_id)
local data=cfg.item_create_conf[shopData.create_item_idx]

self.speakArgs={id,data.shop_item.name}

local id=self.speakArgs[1]
local name=self.speakArgs[2]
local cfg=cfgHelper.get1(cfg_shangpuconfig_get,id)
local speakList=cfg[string.format('ui_speak%d',stype)]
local txt=speakList[math.random(#speakList)]
local rstr=FMT.fmt(txt,name)
bt:setSharedVar(tkey,rstr)
end

function UIShopProductionWin:changeDzState()
if self.currDZ and self.bdData then
local state=UIShopControl:checkCreating(self.bdData)and 1 or 0
self.currDZ:setSharedVar("createState",state)

self.currDZ:broke()
self.currDZ:reset()
self.currDZ:tick(0)
end
end

function UIShopProductionWin:getFinishSpeakText(bt,tkey)
local rstr=self.finishTxt
bt:setSharedVar(tkey,rstr)
end


function UIShopProductionWin:refreshAnim()
for i,v in ipairs(self.queuewidgetList)do
if self.widgetState[i]==widgetState.eCreate then
local widget=v
widget:SetChildActive(queueItemIndex.productionItem,false)
widget:SetChildActive(queueItemIndex.title,false)
widget:SetChildActive(queueItemIndex.time,false)
widget:SetChildActive(queueItemIndex.reddot,false)
widget:SetChildActive(queueItemIndex.barRoot,false)
widget:SetChildModelAnimationState(queueItemIndex.model,eAnimationID.shop_create_to_null,1)
self.widgetState[i]=widgetState.eNull
local _func=function()
widget:SetChildActive(queueItemIndex.nullTxt,true)
end
self:setTimer(0.35,1,_func)
end
end
end


function UIShopProductionWin:delayRefresh()
self:setTimer(0.35,1,function()
self:refreshCancelProduceBtn()
self:refreshQueueItemList()
end)
end

function UIShopProductionWin:onClickSelect()

if UIShopControl:checkCreating(self.bdData)then
UIManager.error('当前商铺正在生产，不能更换弟子')
return
end
if tostring(self.bdData.dizi_id)~='0'then
if self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
end
if self.bdData.plant_id>0 then
UIManager.error('建筑执行生产中, 不能更换弟子')
return
end
else
if self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能安排弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能安排弟子')
return
end
end
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eManager,dzSelectEffectType.eShangPu)
end

function UIShopProductionWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if _this.bdData.un_build_id~=bdId then
return
end
if etype==buildingEvent.replaceDisciple then
_this:refreshLeftPanel()
_this:refreshDzModel(arg1)
end
end

function UIShopProductionWin:refreshDzModel(arg1)
local dzId=arg1

uiAIManager:clearUIWinData('UIShopProductionWin')
self.currDZ=nil
if tostring(dzId)~='0'and not self.isHide then
self:createDZ(dzId,self.rightPos,function(bt)
self.currDZ=bt
self:changeDzState()
self.currDZ:setSharedVar('UIstateId',1)
self:setDZDepth(bt)
end)
end
end

function UIShopProductionWin:refreshCancelProduceBtn()
local flag=false
local queue,count=self:getQueue()
local curTime=timeHelper.getServerShortTime()

if count>0 then
for k,v in ipairs(queue)do
local finish_times=v.finish_times
local showTime=finish_times-curTime
if showTime>0 then flag=true end
end
end

self.cancelProduceBtn:setActive(flag)
end

function UIShopProductionWin:onCancelProduceBtn()
local show_data={
type='UIDialouge',
title='提示',
content='是否取消当前商铺所有正在生产的商品？\n取消则会退还全部生产材料',
oktext='确定',
canceltext='取消',
okcallback=function()
local bdData=self.bdData
local ubdId=bdData.un_build_id
UIShopControl.Req_9_17(ubdId)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIShopProductionWin:initOrdelList()
self.orderList={}
local list=xianzhanModel:getKeShangList()or{}

for k,v in pairs(list)do
local npcId=v.npcid
local ksCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,npcId)
local orderNeedList=ksCfg.sgddList

for k,value in ipairs(orderNeedList)do
local itemid=value[1]
local num=value[2]

local val=self.orderList[itemid]or 0
self.orderList[itemid]=val+num
end
end


end