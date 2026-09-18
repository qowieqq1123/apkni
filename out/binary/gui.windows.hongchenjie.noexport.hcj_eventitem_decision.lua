







def_class("HCJ_EventItem_Decision",UICloneObject)





HCJ_EventItem_Decision.abName=""

HCJ_EventItem_Decision.assetName="HCJ_EventItem_Decision"


function HCJ_EventItem_Decision:bindComponents()

self.year=UIText.get(self,0)
self.kuangMask=UIObject.get(self,1)
self.EventId=UIText.get(self,2)
self.choiceBtn_1=UIButton.get(self,3)
self.choiceBtn_2=UIButton.get(self,4)
self.choiceBtn_3=UIButton.get(self,5)
self.kuang=UIObject.get(self,6)
self.leftZ=UIImage.get(self,7)
self.rightZ=UIImage.get(self,8)
self.bg=UIImage.get(self,9)
self.msg=UIText.get(self,10)
self.selectRusult=UIText.get(self,11)
self.buttonList=UIObject.get(self,12)
self.checktext=UIText.get(self,13)

self.choiceBtn_1:setButtonClick(function()self:onChoiceBtn_1()end)

self.choiceBtn_2:setButtonClick(function()self:onChoiceBtn_2()end)

self.choiceBtn_3:setButtonClick(function()self:onChoiceBtn_3()end)
self.choiceBtn={
self.choiceBtn_1,
self.choiceBtn_2,
self.choiceBtn_3,
}

end


function HCJ_EventItem_Decision:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.year);self.year=nil;
_UIObject_release(self.kuangMask);self.kuangMask=nil;
_UIObject_release(self.EventId);self.EventId=nil;
_UIObject_release(self.choiceBtn_1);self.choiceBtn_1=nil;
_UIObject_release(self.choiceBtn_2);self.choiceBtn_2=nil;
_UIObject_release(self.choiceBtn_3);self.choiceBtn_3=nil;
_UIObject_release(self.kuang);self.kuang=nil;
_UIObject_release(self.leftZ);self.leftZ=nil;
_UIObject_release(self.rightZ);self.rightZ=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.msg);self.msg=nil;
_UIObject_release(self.selectRusult);self.selectRusult=nil;
_UIObject_release(self.buttonList);self.buttonList=nil;
_UIObject_release(self.checktext);self.checktext=nil;
self.choiceBtn=nil;
end






local topOffset=10
local bottomOffset=5
local msgMinMax=60
local msgPadding=50
local msgWidth=614

local _ab='ui/windows/hongchenjie/hongchenjie_atlas_pak.ab'




function HCJ_EventItem_Decision:onLoaded(...)
self:bindComponents()
end


function HCJ_EventItem_Decision:__delete()
self:unbindComponents()
end




function HCJ_EventItem_Decision:onShow(argtable,afterOnloaded)
self.index=argtable.index
local eventInfo=argtable.eventInfo
local id=argtable.id

local jzResName,kuangResName=hongChenJieConfig.getDecisionJZAndKuangResName(eventInfo.eventType)

self.leftZ:setCSImageSprite(_ab,jzResName)
self.rightZ:setCSImageSprite(_ab,jzResName)
self.bg:setCSImageSprite(_ab,kuangResName)

local isEditor=deviceHelper.isRunNoneOrEditor()
self.EventId:setActive(isEditor)
if isEditor then
self.EventId:setText(eventInfo.eventId)
end


self.isShowYear=eventInfo.year~=nil
self.year:setActive(self.isShowYear)
if eventInfo.year then
local yearStr=FMT.fmt('第{0}年',eventInfo.year)
self.year:setText(yearStr)
end


local text=hongChenJieConfig.getEventTxt(id,eventInfo.eventCfg)
local tMsgStr=comHelper.getCheckLayoutStr(self.checktext:getGameObject(),msgWidth,text,nil,{'“'})
self.msg:setText(tMsgStr)

local resultIdx=eventInfo.data.result_idx
local choiceIdx=eventInfo.data.choice_idx
self.isShowResult=resultIdx>0
self.isShowButton=not self.isShowResult and eventInfo.eventType==HONGCHENJIE_EVENT_TYPE.SmallDisicion
self.buttonList:setActive(self.isShowButton)
self.selectRusult:setActive(self.isShowResult)
if self.isShowResult then
local optionTxt=eventInfo.eventCfg.choice_text[choiceIdx]
self.selectRusult:setText(optionTxt)
else
if self.isShowButton then
if eventInfo.eventCfg.choice_text then
local len=#eventInfo.eventCfg.choice_text

for bindex=1,#self.choiceBtn do
local item=self.choiceBtn[bindex]

local isShowBtn=bindex<=len
item:setActive(isShowBtn)
if isShowBtn then
local buttonItem=item:getWidgetBase()
local text=eventInfo.eventCfg.choice_text[bindex]
buttonItem:SetChildText(0,text)
buttonItem:SetChildButtonClick(-1,function()
hongChenJieController:reqGameDisicionEventResult(eventInfo.id,eventInfo.eventId,bindex)
end,true)
self.widget:ForceLayoutVertical(item:getID())
end
end

self.widget:ForceLayoutVertical(self.buttonList:getID())
else
logErr(FMT.fmt("缺少选项文本配置"))
end
end
end


self.widget:SetChildLayoutElementMinHeight(self.msg:getID(),msgMinMax)
self.widget:ForceLayoutVertical(self.msg:getID())
self:freshRect()

if eventInfo.isPlayAnim then

self.kuang:setChildIconFillAmount(0)
local rzpos=self.rightZ:getChildAnchoredPosition()
self.rightZ:setChildAnchoredPos(-646,rzpos.y)
local duration=1
self.kuang:setChildImageDOFillAmount(1,duration,nil)
self.rightZ:setChildDOAnchorPosX(16,duration,function()
local handle=hongChenJieModel:getGameHandle(eventInfo.id)
handle:setCanClickNextEventState(true)
end)
eventInfo.isPlayAnim=false
end
end


function HCJ_EventItem_Decision:onHide()

end

function HCJ_EventItem_Decision:freshRect()
self.widget:ForceLayoutVertical(-1)

local sizeY=self.widget:GetChildSizeDeltaY(self.msg:getID())
local yearHeight=self.isShowYear and 40 or 0
local buttonHeight=self.isShowButton and 45 or 0
local resultHeight=self.isShowResult and 40 or 0
local cSize=(self.isShowButton or self.isShowResult)and 5 or 0

sizeY=Mathf.Max(sizeY,msgMinMax)

local contentSize=sizeY+buttonHeight+resultHeight+cSize+msgPadding
self.kuangMask:setChildSizeDelta(672,contentSize)

local tSize=sizeY+topOffset+yearHeight+bottomOffset+buttonHeight+resultHeight+cSize+msgPadding

self.widget:SetChildSizeWithCurrentAnchors(-1,1,tSize)


end


