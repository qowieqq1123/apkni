







def_class("UIHongChenJieBigDecisionWin",UIWindowBase)









function UIHongChenJieBigDecisionWin:bindComponents()

self.back=UIObject.get(self,0)
self.closeMask=UIObject.get(self,1)
self.mask=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.BackModel=UIObject.get(self,4)
self.EventGroupImage=UIObject.get(self,5)
self.EventGroupImageMask=UIObject.get(self,6)
self.resultPanel=UIObject.get(self,7)
self.tipsText=UIText.get(self,8)
self.MysteryEventOptionsItem2=UIObject.get(self,9)
self.MysteryEventOptionsItem3=UIObject.get(self,10)
self.MysteryEventOptionsItem4=UIObject.get(self,11)
self.MysteryEventOptionsItem1=UIObject.get(self,12)
self.resultItemList=UIObject.get(self,13)
self.resultBg=UIButton.get(self,14)
self.resultTitle=UIText.get(self,15)
self.resultText=UIText.get(self,16)
self.resultItemRoot=UIObject.get(self,17)
self.optionPanel=UIObject.get(self,18)
self.closeClick=UIButton.get(self,19)
self.diziText=UIText.get(self,20)
self.tips=UIObject.get(self,21)
self.RoleListPanel=UIObject.get(self,22)
self.eventTitlle=UIText.get(self,23)
self.EventGroupText=UIText.get(self,24)

self.resultBg:setButtonClick(function()self:onResultBg()end)

self.closeClick:setButtonClick(function()self:onCloseClick()end)



end


function UIHongChenJieBigDecisionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.closeMask);self.closeMask=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.BackModel);self.BackModel=nil;
_UIObject_release(self.EventGroupImage);self.EventGroupImage=nil;
_UIObject_release(self.EventGroupImageMask);self.EventGroupImageMask=nil;
_UIObject_release(self.resultPanel);self.resultPanel=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.MysteryEventOptionsItem2);self.MysteryEventOptionsItem2=nil;
_UIObject_release(self.MysteryEventOptionsItem3);self.MysteryEventOptionsItem3=nil;
_UIObject_release(self.MysteryEventOptionsItem4);self.MysteryEventOptionsItem4=nil;
_UIObject_release(self.MysteryEventOptionsItem1);self.MysteryEventOptionsItem1=nil;
_UIObject_release(self.resultItemList);self.resultItemList=nil;
_UIObject_release(self.resultBg);self.resultBg=nil;
_UIObject_release(self.resultTitle);self.resultTitle=nil;
_UIObject_release(self.resultText);self.resultText=nil;
_UIObject_release(self.resultItemRoot);self.resultItemRoot=nil;
_UIObject_release(self.optionPanel);self.optionPanel=nil;
_UIObject_release(self.closeClick);self.closeClick=nil;
_UIObject_release(self.diziText);self.diziText=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.RoleListPanel);self.RoleListPanel=nil;
_UIObject_release(self.eventTitlle);self.eventTitlle=nil;
_UIObject_release(self.EventGroupText);self.EventGroupText=nil;
end
















local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local m_sendGuid=nil
local m_selectGuidIndex=nil

local enterTime=1.3
local changeTime=1.5
local textchangeTime=0.2

local CmpOptionItemIndex={
optionTxt=0,
select=1,
icon=2,
conditionText=3,
iconBg=4,
conditionImage=5,
bg1=6,
}

local isNotQiYu=false




function UIHongChenJieBigDecisionWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.onHongChenJieFreshEvent,function(...)self:onHongChenJieFreshEvent(...)end)
self:addNotify(notifyConfig.onHongChenJieAddNewEvent,function(...)self:onHongChenJieAddNewEvent(...)end)

isNotQiYu=false
self.isSelected=nil
self.optionTween={}

self.MysteryEventOption={
self.MysteryEventOptionsItem1,
self.MysteryEventOptionsItem2,
self.MysteryEventOptionsItem3,
self.MysteryEventOptionsItem4,
}


self.RoleListPanel:setChildScrollViewInit(-1,true,function(...)self:OnClickRoleItemCallback(...)end,nil)

local modelId=2042
self.root:setActive(false)
self.BackModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.common_window_enter,false,false,0,function()
timeEventController.delayDo(0.4,function()
if self and not self.isClose then
self.root:setActive(true)
self:playAnimation(1,enterTime)
end
end)
end)

self.back:setActive(false)

UIManager.setMoneyMsgShowState(false,true)
end


function UIHongChenJieBigDecisionWin:__delete()
self:unbindComponents()

if self.optionTween and next(self.optionTween)then
for i,v in pairs(self.optionTween)do
v:Kill()
end
end
self.isSelected=nil
m_sendGuid=nil
end

function UIHongChenJieBigDecisionWin:playAnimation(id,maskTime)
self.root:setAnimatorInteger('nState',id,true)
if maskTime and maskTime>0 then
self.mask:setActive(true)
self:delayDo(maskTime,function()
if self and(not self.isClose)then
self.mask:setActive(false)
end
end)
end
end




function UIHongChenJieBigDecisionWin:onShow(argtable,afterOnloaded)
self.id=argtable.id
self.eventInfo=argtable.eventInfo
self.isNotChoice=true

self.closeMask:setActive(false)
self.resultPanel:setActive(false)

self:refreshAll()
end


function UIHongChenJieBigDecisionWin:onHide()

end

function UIHongChenJieBigDecisionWin:refreshAll()

local eventCfg=self.eventInfo.eventCfg
self.eventTitlle:setText(eventCfg.title)
self.closeClick:setActive(not self.isNotChoice)
local isChoice=self.eventInfo.data.choice_idx>0
local idx=self.eventInfo.data.choice_idx
local result_idx=self.eventInfo.data.result_idx

if isChoice then

self:refreshEventText(eventCfg.result_text[idx][result_idx],self.curImage and 0.2)
self:refreshEventImage(eventCfg.result_image[idx][result_idx])
if self.isShowResult then
self:refreshResultPanel(self.attrStr,self.curImage and 0.2)
end
self.back:setActive(true)
else
self:refreshEventText(eventCfg.text,self.curImage and 0.2)
self:refreshEventImage(eventCfg.iamge)
self.back:setActive(false)
end

for index=1,#self.MysteryEventOption do
local item=self.MysteryEventOption[index]
local optionTxt=eventCfg.choice_text[index]
local isShowItem=optionTxt~=nil
local isSelect=false
if isChoice then
isSelect=idx==index
isShowItem=isShowItem and isSelect
end
item:setActive(isShowItem)
if isShowItem then
local itemWidght=item:getWidgetBase()
itemWidght:SetChildText(CmpOptionItemIndex.optionTxt,optionTxt)
itemWidght:SetChildActive(CmpOptionItemIndex.select,isSelect)
itemWidght:SetChildActive(CmpOptionItemIndex.icon,false)
itemWidght:SetChildActive(CmpOptionItemIndex.conditionText,false)
itemWidght:SetChildActive(CmpOptionItemIndex.iconBg,false)
itemWidght:SetChildActive(CmpOptionItemIndex.conditionImage,false)
itemWidght:SetChildActive(CmpOptionItemIndex.bg1,true)
itemWidght:SetChildButtonClick(CmpOptionItemIndex.bg1,function()self:OnClickEventItemCallback(index)end,true)
end
end
end

function UIHongChenJieBigDecisionWin:refreshEventText(txt,delay)
delay=delay or 0
if delay<=0 then
self.EventGroupText:setText(txt)
else
timeEventController.delayDo(delay,function()
if self and(not self.isClose)then
self.EventGroupText:setText(txt)
end
end)
end
end

function UIHongChenJieBigDecisionWin:refreshEventImage(imageId)
if self.curImage then
self:playAnimation(2,changeTime)
timeEventController.delayDo(changeTime,function()
if self and(not self.isClose)then
self.EventGroupImageMask:setChildIcon(FMT.fmt("image_shijian_{0}",imageId),true)
end
end)
else
self.EventGroupImageMask:setChildIcon(FMT.fmt("image_shijian_{0}",imageId),true)
end
self.EventGroupImage:setChildIcon(FMT.fmt("image_shijian_{0}",imageId),true)
self.curImage=imageId
end


function UIHongChenJieBigDecisionWin:refreshResultPanel(txt,delay)
delay=delay or 0
if delay<=0 then
self.EventGroupText:setText(txt)
else
timeEventController.delayDo(delay,function()
if self and(not self.isClose)then
self.resultPanel:setActive(true)
self.resultText:setActive(true)
self.closeMask:setActive(true)
self.resultText:setText(txt)
end
end)
end
end


function UIHongChenJieBigDecisionWin:onHongChenJieFreshEvent(id,eventInfo)
self.eventInfo=eventInfo
end

function UIHongChenJieBigDecisionWin:onHongChenJieAddNewEvent(id,eventInfo,prefabType,guid)
if eventInfo.eventType==HONGCHENJIE_EVENT_TYPE.Result then
self.resultEventInfo=eventInfo
self.attrStr=nil
self.isShowResult=false

if eventInfo.effectDataList~=nil and#eventInfo.effectDataList>0 then
for index,data in ipairs(eventInfo.effectDataList)do
local type=data[1]
local rVal=data[2]
local dotype=rVal>0 and'+'or'-'
local color=rVal>0 and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
local val=Mathf.Abs(data[2])
local typeName=HongChenJieDiscipleAttrNameList[type]
local valStr=FMT.fmt("{0}{1}",dotype,val)
local str=FMT.fmt("{0}{1}",typeName,valStr)
str=toColorString(color,str)

self.attrStr=self.attrStr and FMT.fmt("{0}\t\t{1}",self.attrStr,str)or str
end
self.isShowResult=true
end

if eventInfo.effectDescList~=nil and#eventInfo.effectDescList>0 then
for k,str in pairs(eventInfo.effectDescList)do
self.attrStr=self.attrStr and FMT.fmt("{0}\t{1}",self.attrStr,str)or str
end
self.isShowResult=true
end


self:refreshAll()
end
end





function UIHongChenJieBigDecisionWin:onCloseClick()
UIFullHongChenJieControl:closeWindow('UIHongChenJieBigDecisionWin')
end

function UIHongChenJieBigDecisionWin:OnClickEventItemCallback(index)
if self.isNotChoice then
self.isNotChoice=false
hongChenJieController:reqGameDisicionEventResult(self.id,self.eventInfo.eventId,index)
end
end
