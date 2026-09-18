







def_class("HCJ_EventItem_Base",UICloneObject)





HCJ_EventItem_Base.abName=""

HCJ_EventItem_Base.assetName="HCJ_EventItem_Base"


function HCJ_EventItem_Base:bindComponents()

self.mask=UIObject.get(self,0)
self.leftZ=UIObject.get(self,1)
self.rightZ=UIObject.get(self,2)
self.bg=UIObject.get(self,3)
self.msg=UIText.get(self,4)
self.exMsg=UIText.get(self,5)
self.year=UIText.get(self,6)
self.root=UIObject.get(self,7)
self.EventId=UIText.get(self,8)
self.kuang=UIObject.get(self,9)
self.attrChangeInfo=UIObject.get(self,10)
self.checktext=UIText.get(self,11)

end


function HCJ_EventItem_Base:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.leftZ);self.leftZ=nil;
_UIObject_release(self.rightZ);self.rightZ=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.msg);self.msg=nil;
_UIObject_release(self.exMsg);self.exMsg=nil;
_UIObject_release(self.year);self.year=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.EventId);self.EventId=nil;
_UIObject_release(self.kuang);self.kuang=nil;
_UIObject_release(self.attrChangeInfo);self.attrChangeInfo=nil;
_UIObject_release(self.checktext);self.checktext=nil;
end





local topOffset=10
local bottomOffset=5
local msgMinMax=50
local msgPadding=40
local msgWidth=614



function HCJ_EventItem_Base:onLoaded(...)
self:bindComponents()
end


function HCJ_EventItem_Base:__delete()
self:unbindComponents()
end




function HCJ_EventItem_Base:onShow(argtable,afterOnloaded)
self.index=argtable.index
local eventInfo=argtable.eventInfo
local id=argtable.id

local isEditor=deviceHelper.isRunNoneOrEditor()
self.EventId:setActive(isEditor)
if isEditor then
self.EventId:setText(eventInfo.eventId)
end


self.isShowYear=eventInfo.year~=nil
self.year:setActive(self.isShowYear)
if self.isShowYear then
local yearStr=FMT.fmt('第{0}年',eventInfo.year)
self.year:setText(yearStr)
end


local text=hongChenJieConfig.getEventTxt(id,eventInfo.eventCfg)
local tMsgStr=comHelper.getCheckLayoutStr(self.checktext:getGameObject(),msgWidth,text,nil,{'“'})
self.msg:setText(tMsgStr)

local effectDataList=eventInfo.effectDataList
self.isShowEffectList=effectDataList~=nil and#effectDataList>0
self.attrChangeInfo:setActive(self.isShowEffectList)
if self.isShowEffectList then
local len=#eventInfo.effectDataList
self.attrChangeInfo:setChildLayoutGroupCreateItems(len,function(index)
local item=self.attrChangeInfo:getChildLayoutGroupGridItem(index-1)
local data=effectDataList[index]

local isShow=data~=nil
item:SetChildActive(-1,isShow)
if isShow then
local type=data[1]
local val=data[2]

local bgIconName=hongChenJieConfig.getEventAttrChangeBgIconName(type,val)
item:SetChildCSImageSprite(-1,globalABLookup.hongchenjie,bgIconName)

local attrName=HongChenJieDiscipleAttrNameList[type]
local single=""
if val>0 then
single='+'
end
local info=FMT.fmt("{0}{1}{2}",attrName,single,val)
item:SetChildText(0,info)
end
end)
end

self.isShowExMsg=eventInfo.effectStr~=nil and eventInfo.effectStr~=""
self.exMsg:setActive(self.isShowExMsg)
if self.isShowExMsg then
self.exMsg:setText(eventInfo.effectStr)
end


self.widget:SetChildLayoutElementMinHeight(self.msg:getID(),msgMinMax)
self.widget:ForceLayoutVertical(self.msg:getID())
self:freshRect()

if eventInfo.isPlayAnim then

self.mask:setChildIconFillAmount(0)
local rzpos=self.rightZ:getChildAnchoredPosition()
self.rightZ:setChildAnchoredPos(-646,rzpos.y)

local duration=1
self.mask:setChildImageDOFillAmount(1,duration,nil)
self.rightZ:setChildDOAnchorPosX(16,duration,function()
local handle=hongChenJieModel:getGameHandle(eventInfo.id)
handle:setCanClickNextEventState(true)
end)

eventInfo.isPlayAnim=false
end
end


function HCJ_EventItem_Base:onHide()

end

function HCJ_EventItem_Base:freshRect()
self.widget:ForceLayoutVertical(-1)
local msgSize=self.widget:GetChildSizeDeltaY(self.msg:getID())
local eSize=self.isShowEffectList and 44 or 0
local yearHeight=self.isShowYear and 40 or 0
local sSize=self.isShowExMsg and 5 or 0
local exMsgSize=self.isShowExMsg and 40 or 0

msgSize=Mathf.Max(msgSize,msgMinMax)

local contentSize=msgSize+eSize+msgPadding+exMsgSize
self.mask:setChildSizeDelta(672,contentSize)

local rootSize=msgSize+msgPadding+sSize+exMsgSize
self.root:setChildSizeDelta(672,rootSize)

local tSize=msgSize+eSize+topOffset+yearHeight+bottomOffset+msgPadding+sSize+exMsgSize

self.widget:SetChildSizeWithCurrentAnchors(-1,1,tSize)
end


