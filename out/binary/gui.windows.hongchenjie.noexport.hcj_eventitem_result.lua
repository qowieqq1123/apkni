







def_class("HCJ_EventItem_Result",UICloneObject)





HCJ_EventItem_Result.abName=""

HCJ_EventItem_Result.assetName="HCJ_EventItem_Result"


function HCJ_EventItem_Result:bindComponents()

self.mask=UIObject.get(self,0)
self.leftZ=UIImage.get(self,1)
self.rightZ=UIImage.get(self,2)
self.kuang=UIObject.get(self,3)
self.attrChangeInfo=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.checktext=UIText.get(self,6)
self.bg=UIImage.get(self,7)
self.msg=UIText.get(self,8)
self.exMsg=UIText.get(self,9)

end


function HCJ_EventItem_Result:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.leftZ);self.leftZ=nil;
_UIObject_release(self.rightZ);self.rightZ=nil;
_UIObject_release(self.kuang);self.kuang=nil;
_UIObject_release(self.attrChangeInfo);self.attrChangeInfo=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.checktext);self.checktext=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.msg);self.msg=nil;
_UIObject_release(self.exMsg);self.exMsg=nil;
end





local topOffset=10
local bottomOffset=5
local msgPadding=40
local msgMinMax=60
local msgWidth=614

local _ab='ui/windows/hongchenjie/hongchenjie_atlas_pak.ab'




function HCJ_EventItem_Result:onLoaded(...)
self:bindComponents()

end


function HCJ_EventItem_Result:__delete()
self:unbindComponents()
end




function HCJ_EventItem_Result:onShow(argtable,afterOnloaded)
self.index=argtable.index
local eventInfo=argtable.eventInfo
local isPlayAnim=argtable.isPlayAnim

local eventType=HONGCHENJIE_EVENT_TYPE.SmallDisicion
if eventInfo.eventCfg.iamge~=nil then

eventType=HONGCHENJIE_EVENT_TYPE.BigDisicion
end

local jzResName,kuangResName=hongChenJieConfig.getDecisionJZAndKuangResName(eventType)

self.leftZ:setCSImageSprite(_ab,jzResName)
self.rightZ:setCSImageSprite(_ab,jzResName)
self.bg:setCSImageSprite(_ab,kuangResName)


local resultIdx=eventInfo.data.result_idx
local choiceIdx=eventInfo.data.choice_idx
local resultList=eventInfo.eventCfg.result_text[choiceIdx]or{}

local result=resultList[resultIdx]
if result then
local tMsgStr=comHelper.getCheckLayoutStr(self.checktext:getGameObject(),msgWidth,result,nil,{'“'})
self.msg:setText(tMsgStr)
else
logErr(FMT.fmt("事件 {0} 选项 {1} 结果索引 {2} 未配置",eventInfo.id,choiceIdx,resultIdx))
end

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


function HCJ_EventItem_Result:onHide()

end

function HCJ_EventItem_Result:freshRect()
self.widget:ForceLayoutVertical(-1)

local sizeY=self.widget:GetChildSizeDeltaY(self.msg:getID())
local eSize=self.isShowEffectList and 44 or 0
local sSize=self.isShowExMsg and 5 or 0
local exMsgSize=self.isShowExMsg and 40 or 0

sizeY=Mathf.Max(sizeY,msgMinMax)

local contentSize=sizeY+eSize+msgPadding+exMsgSize
self.mask:setChildSizeDelta(672,contentSize)

local rootSize=sizeY+msgPadding+sSize+exMsgSize
self.root:setChildSizeDelta(672,rootSize)

local tSize=sizeY+topOffset+eSize+bottomOffset+msgPadding+exMsgSize


self.widget:SetChildSizeWithCurrentAnchors(-1,1,tSize)

end



