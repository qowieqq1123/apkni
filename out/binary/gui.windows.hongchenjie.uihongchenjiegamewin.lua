







def_class("UIHongChenJieGameWin",UIWindowBase)









function UIHongChenJieGameWin:bindComponents()

self.attrChangeEffectList=UIObject.get(self,0)
self.closeStateBack=UIObject.get(self,1)
self.endBtn=UIButton.get(self,2)
self.eventContent=UIObject.get(self,3)
self.eventList=UILoopListView.new(self,4)
self.infoItem_1=UIObject.get(self,5)
self.infoItem_2=UIObject.get(self,6)
self.infoItem_3=UIObject.get(self,7)
self.infoItem_4=UIObject.get(self,8)
self.infoItem_5=UIObject.get(self,9)
self.infoItem_6=UIObject.get(self,10)
self.infoList=UIObject.get(self,11)
self.leftPart=UIObject.get(self,12)
self.nextBtn=UIButton.get(self,13)
self.nextTipImg=UIImage.get(self,14)
self.polygonAttrPanel=UIObject.get(self,15)
self.rightPart=UIObject.get(self,16)
self.Root=UIObject.get(self,17)
self.stateBack=UIObject.get(self,18)
self.stateSpine=UIObject.get(self,19)
self.uiRoot=UIObject.get(self,20)

self.endBtn:setButtonClick(function()self:onEndBtn()end)

self.eventList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.nextBtn:setButtonClick(function()self:onNextBtn()end)
self.infoItem={
self.infoItem_1,
self.infoItem_2,
self.infoItem_3,
self.infoItem_4,
self.infoItem_5,
self.infoItem_6,
}



end


function UIHongChenJieGameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrChangeEffectList);self.attrChangeEffectList=nil;
_UIObject_release(self.closeStateBack);self.closeStateBack=nil;
_UIObject_release(self.endBtn);self.endBtn=nil;
_UIObject_release(self.eventContent);self.eventContent=nil;
self.eventList:deleteSelf();self.eventList=nil;
_UIObject_release(self.infoItem_1);self.infoItem_1=nil;
_UIObject_release(self.infoItem_2);self.infoItem_2=nil;
_UIObject_release(self.infoItem_3);self.infoItem_3=nil;
_UIObject_release(self.infoItem_4);self.infoItem_4=nil;
_UIObject_release(self.infoItem_5);self.infoItem_5=nil;
_UIObject_release(self.infoItem_6);self.infoItem_6=nil;
_UIObject_release(self.infoList);self.infoList=nil;
_UIObject_release(self.leftPart);self.leftPart=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.nextTipImg);self.nextTipImg=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.rightPart);self.rightPart=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.stateBack);self.stateBack=nil;
_UIObject_release(self.stateSpine);self.stateSpine=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.infoItem=nil;
end
















local _this
local eventViewPortSizeY=575

local transPolygonIndex={
HongChenJieDiscipleAttrTypeEnum.JiYuan,
HongChenJieDiscipleAttrTypeEnum.MeiLi,
HongChenJieDiscipleAttrTypeEnum.QianLi,
HongChenJieDiscipleAttrTypeEnum.CongHui,
HongChenJieDiscipleAttrTypeEnum.GenGu,
HongChenJieDiscipleAttrTypeEnum.ZiZhi,
}




function UIHongChenJieGameWin:onLoaded(...)
self:bindComponents()
_this=self
self.loopListView=self.winlua:GetChildUILoopListView(self.eventList:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.eventList:getID())

self:addNotify(notifyConfig.onHongChenJieAddNewEvent,function(...)self:onHongChenJieAddNewEvent(...)end)
self:addNotify(notifyConfig.onHongChenJieFreshEvent,function(...)self:onHongChenJieFreshEvent(...)end)
self:addNotify(notifyConfig.onHongChenJieGameHPLess,function(...)self:onHongChenJieGameHPLess(...)end)
self:addNotify(notifyConfig.onHongChenJieGameOver,function(...)self:onHongChenJieGameOver(...)end)

self.loopListView:SetAction(function(...)
self:onFreshListView(...)
end,function(...)
self:onStartView(...)
end)

local dragBeginCallBack=function()
_this.isDraging=true
end

local dragEndCallBack=function()
_this.isDraging=false
end

self.winlua:SetChildUIDragEvent(self.eventList:getID(),1,dragBeginCallBack,dragEndCallBack,nil)

self.mesgWin={}
self.msgIDLookup={}
self.eventInfoList={}


self.fmTweener={}

self.isCanNext=true

self.dotweens={}

UIManager.setMoneyMsgShowState(false,true)
end


function UIHongChenJieGameWin:__delete()
self:clearAllFMTweener()

self:clearAllAttrTweener()

self:unbindComponents()

_this=nil

UIManager.setMoneyMsgShowState(true,true)
end




function UIHongChenJieGameWin:onShow(argtable,afterOnloaded)


self.id=argtable.id
self.data=hongChenJieModel:getGameHandle(self.id)
self.identityId=argtable.identityId

self.data:setCanClickNextEventState(true)

self.stateBack:setActive(false)

self:freshLeftPart()
self:firstFreshEventList()
self:freshBtn()
end


function UIHongChenJieGameWin:onHide()
self.eventList:setActive(false)
self:clearAllFMTweener()
end

function UIHongChenJieGameWin:onShowArgRecv(argtable)
self.eventList:setActive(true)
self:onShow(argtable)
end

function UIHongChenJieGameWin:freshBtn()
local isShowEnd=self.data:checkGameEnd()
self.endBtn:setActive(isShowEnd)
self.nextBtn:setActive(not isShowEnd)

local isDecision=self.data:checkEndEventIsDecisionEvent()
local icon=isDecision and'image_hongchenjie_wz9'or'image_hongchenjie_wz2'
self.nextTipImg:setCSImageSprite(globalABLookup.hongchenjie,icon)
end

function UIHongChenJieGameWin:freshLeftPart()



self:freshPolygon()

self:freshInfoList()
end

function UIHongChenJieGameWin:freshPolygon()
local max_single_dimension=hongChenJieConfig.getBaseInfo(self.id,'max_single_dimension')
local max_single_value=max_single_dimension
local attrList={}

local wiget=self.polygonAttrPanel:getWidgetBase()
for index=1,6 do
local val=self.data:getSingleInfo(index)
local name=HongChenJieDiscipleAttrNameList[index]
local str=FMT.fmt("{0}\n{1}",name,toColorStringX('#aae252',val))
wiget:SetChildText(index-1,str)
max_single_value=max_single_value>val and max_single_value or val
local transformIndex=transPolygonIndex[index]
attrList[transformIndex]=val
end

for index=1,6 do
attrList[index]=attrList[index]/max_single_value
end

wiget:SetChildUIPolygonImage(6,attrList,0)



end

function UIHongChenJieGameWin:freshPolygon2()
local max_single_dimension=hongChenJieConfig.getBaseInfo(self.id,'max_single_dimension')
local max_single_value=max_single_dimension
local attrList={}

local wiget=self.polygonAttrPanel:getWidgetBase()
for index=1,6 do
local val=self.data:getSingleInfo(index)
max_single_value=max_single_value>val and max_single_value or val
local transformIndex=transPolygonIndex[index]
attrList[transformIndex]=val
end

for index=1,6 do
attrList[index]=attrList[index]/max_single_value
end

wiget:SetChildUIPolygonImage(6,attrList,0)
end

function UIHongChenJieGameWin:freshInfoList()

local item1=self.infoItem_1:getWidgetBase()
item1:SetChildText(0,'境界:')
local jjLevel=self.data:getJingJie()
local jjStr=self.data:getJingJieName(jjLevel)
item1:SetChildText(1,jjStr)

local item2=self.infoItem_2:getWidgetBase()
item2:SetChildText(0,'种族:')
local raceStr=self.data:getRaceName()
item2:SetChildText(1,raceStr)

local item3=self.infoItem_3:getWidgetBase()
item3:SetChildText(0,'性别:')
local sexStr=self.data:getSex()
item3:SetChildText(1,sexStr)

local item4=self.infoItem_4:getWidgetBase()
item4:SetChildText(0,'仙缘:')
local xyValue=self.data:getSingleInfo(HongChenJieDiscipleAttrTypeEnum.XianYuan)
item4:SetChildText(1,xyValue)

local item5=self.infoItem_5:getWidgetBase()
item5:SetChildText(0,'寿元:')
local xyValue=self.data:getSingleInfo(HongChenJieDiscipleAttrTypeEnum.ShouYuan)
item5:SetChildText(1,xyValue)


local item6=self.infoItem_6:getWidgetBase()
item6:SetChildText(0,'姓名:')
local name=self.data:getIdentityName()
item6:SetChildText(1,name)
end

function UIHongChenJieGameWin:firstFreshEventList()

self:recycleItems()

self.events=table.deepCopy(self.data:getEventInfoList())
local eventPrefabNameList=self.data:getEventPrefabNameList()

local eventLen=#self.events
local eventGuidList=self.data:getEventGuidList()
local idlist={}
for index=1,eventLen do
table.insert(idlist,index)
end
self.loopListView:InitDataList(eventLen,eventPrefabNameList,idlist,eventGuidList,nil)

self:freshEventListRect()

self:freshBtn()

if self.data:getReconnectJCState()then
local eventInfo=self.events[#self.events]
if eventInfo.eventType==HONGCHENJIE_EVENT_TYPE.BigDisicion then
UIFullHongChenJieControl:showWindow('UIHongChenJieBigDecisionWin',{id=self.id,eventInfo=eventInfo})
end
self.data:setReconnectJCState(false)
end
end

function UIHongChenJieGameWin:freshEventListRect()
self.winlua:ForceLayoutRect(self.eventList:getID())
self.loopListViewCmp:ResetListView()
self.loopListView:JumpNewestIndex()
end

function UIHongChenJieGameWin:recycleItems()
for _,luaObject in pairs(self.mesgWin or{})do
UICloneObject.release(luaObject)
end
self.events={}
self.mesgWin={}
self.eventLookup={}
end

function UIHongChenJieGameWin:createLuaObject(index,widget)
local eventInfo=self.events[index]
local compName=HONGCHENJIE_COM_TYPE_NAME[eventInfo.eventPrefabType]
local luaObject=UICloneObject.get(compName)
local msgID=eventInfo.eventGuid
self.msgIDLookup[msgID]=true
self.mesgWin[index]=luaObject
luaObject:setWidget(widget)
luaObject:onLoaded()
return luaObject
end


function UIHongChenJieGameWin:onStartView()

end

function UIHongChenJieGameWin:onFreshListView(index,widget)
index=index+1
local eventInfo=self.events[index]
local luaObject=self.mesgWin[index]



if luaObject then
UICloneObject.release(luaObject)
end

luaObject=self:createLuaObject(index,widget)

local func=function()
luaObject:onShow({eventInfo=eventInfo,index=index,id=_this.id})
end
xpcall(func,function(err)
logErr("UIHongChenJieGameWin onFreshAction err",err,eventInfo.eventPrefabType)
end)
end


function UIHongChenJieGameWin:onRectChange()

end



function UIHongChenJieGameWin:onHongChenJieAddNewEvent(id,eventInfo,prefabType,guid)
if id~=self.id then return end

self.data:setCanClickNextEventState(false)


table.insert(self.events,eventInfo)
local prefabName=HONGCHENJIE_COM_TYPE_NAME[prefabType]

self.loopListView:AddItem(prefabName,#self.events,guid,nil,true)



self:freshLeftPart()


self:freshBtn()


if eventInfo.effectDataList and#eventInfo.effectDataList>0 then
self:playShowAttrChangePart(eventInfo.effectDataList)
end
end

function UIHongChenJieGameWin:onHongChenJieFreshEvent(id,eventInfo)
if id~=self.id then return end

local index=#self.mesgWin
local luaObject=self.mesgWin[index]
self.events[index]=eventInfo
local func=function()
luaObject:onShow({eventInfo=eventInfo,index=index})
end
xpcall(func,function(err)
logErr("UIHongChenJieGameWin onFreshAction err",err,id,eventInfo.eventPrefabType)
end)
self:freshEventListRect()
end

function UIHongChenJieGameWin:onHongChenJieGameHPLess()
self.stateBack:setActive(true)
self.closeStateBack:setActive(false)
self.stateSpine:setChildUIModelShowTarget(5427,1,{},eAnimationID.enter)
self:delayDo(2.66,function()
self.closeStateBack:setActive(true)
end)
end

function UIHongChenJieGameWin:onHongChenJieGameOver()
self.stateBack:setActive(true)
self.closeStateBack:setActive(false)
self.stateSpine:setChildUIModelShowTarget(5428,1,{},eAnimationID.enter)
self:delayDo(2.66,function()
self.closeStateBack:setActive(true)
end)
end


function UIHongChenJieGameWin:playAttrChangeAnimation(index,oldVal,newVal)
local wiget=self.polygonAttrPanel:getWidgetBase()

self:clearFMTweener(index)
local tempVal=oldVal

local duration=(newVal-oldVal>20)and(newVal-oldVal)/40 or 0.2
self.fmTweener[index]=_DOTweenProxy.DoValueTo(function()
return tempVal
end,function(val)
tempVal=Mathf.Floor(val)
local name=HongChenJieDiscipleAttrNameList[index]
local str=FMT.fmt("{0}\n{1}",name,toColorStringX('#aae252',tempVal))
wiget:SetChildText(index-1,str)
end,newVal,duration)



self:freshPolygon2()
end

function UIHongChenJieGameWin:clearFMTweener(index)
if self.fmTweener[index]then
self.fmTweener[index]:Kill()
self.fmTweener[index]=nil
end
end

function UIHongChenJieGameWin:clearAllFMTweener()
for index,v in pairs(self.fmTweener)do
self.fmTweener[index]:Kill()
self.fmTweener[index]=nil
end
end

function UIHongChenJieGameWin:clearAllAttrTweener()
for index,v in pairs(self.dotweens)do
self.dotweens[index]:Kill()
self.dotweens[index]=nil
end
end

function UIHongChenJieGameWin:playShowAttrChangePart(effectDataList)
local _this=self

self:clearAllAttrTweener()

self.attrChangeEffectList:setChildCanvasGroupAlpha(1)

local len=#effectDataList
local itemList={}
self.attrChangeEffectList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.attrChangeEffectList:getChildLayoutGroupGridItem(index-1)
local info=effectDataList[index]

local isShowItem=info~=nil
item:SetChildActive(-1,isShowItem)
if isShowItem then

local type=info[1]
local val=info[2]

local replaceChar=HongChenJieDiscipleAttrNameToArtWordName[type]
local effectInfo=replaceChar

local posY

local showEffectId
if val>0 then
showEffectId=20251
effectInfo=FMT.fmt("{0}{1}",effectInfo,'+')

posY=50
else
showEffectId=20252

posY=-50
end

item:SetChildAnchoredPos(2,0,posY)
effectInfo=FMT.fmt("{0}{1}",effectInfo,val)


item:SetChildCanvasGroupAlpha(1,0)
item:SetChildText(1,effectInfo)

itemList[#itemList+1]={item,showEffectId}
end
end)

if self.attrTimerId then
self:stopTimerByID(self.attrTimerId)
self.attrTimerId=nil
end

local showInterVal=0.25
local index=1
self.attrTimerId=self:setTimer(showInterVal,len,function()
local item=itemList[index][1]
local showEffectId=itemList[index][2]
item:SetChildShowEffect(0,showEffectId,true)

if self.dotweens[index]then
self.dotweens[index]:Complete()
self.dotweens[index]:Kill()
self.dotweens[index]=nil
end
item:SetChildCanvasGroupDOFade(1,1,0.8,function()
item:SetChildCanvasGroupDOFade(1,0,0.4,nil)
end)
item:SetChildScale(1,Vector3(0.8,0.8,1))
self.dotweens[index]=item:SetChildDOPunchScale(1,Vector3.New(1,1,0),0.2,1)
self.dotweens[index]:SetEase(_Ease.OutElastic)
index=index+1
end)








end





function UIHongChenJieGameWin:onNextBtn()
local isCanReqNext,stateId=self.data:checkCanReqNextEvent()
if(not self.isDraging)then
if isCanReqNext then
hongChenJieController:reqGameEventNext(self.id)
else
if self.data:checkEndEventIsDecisionEvent()then
UIManager.info('请进行选项抉择')
end
end
end
end

function UIHongChenJieGameWin:onEndBtn()
UIFullHongChenJieControl:showWindow("UIHongChenJieSummaryWin",{data=self.data})
end

function UIHongChenJieGameWin:onCloseStateBack()
self.stateBack:setActive(false)
end
