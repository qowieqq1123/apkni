







def_class("UIXianBaoUpStarSuccessWin",UIWindowBase)









function UIXianBaoUpStarSuccessWin:bindComponents()

self.attrlvItem=UIObject.get(self,0)
self.attrItem_3=UIObject.get(self,1)
self.attrItem_2=UIObject.get(self,2)
self.attrItem_1=UIObject.get(self,3)
self.attrItemup=UIObject.get(self,4)
self.desc=UIText.get(self,5)
self.skillIcon=UIImage.get(self,6)
self.tips=UIText.get(self,7)
self.effect=UIObject.get(self,8)
self.skill=UIObject.get(self,9)
self.modelBg=UIObject.get(self,10)
self.model=UIObject.get(self,11)
self.attr=UIObject.get(self,12)
self.titleBack=UIObject.get(self,13)
self.desc2=UIText.get(self,14)
self.titledesc=UIText.get(self,15)
self.uptitle=UIObject.get(self,16)
self.attrItem={
self.attrItem_1,
self.attrItem_2,
self.attrItem_3,
}



end


function UIXianBaoUpStarSuccessWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrlvItem);self.attrlvItem=nil;
_UIObject_release(self.attrItem_3);self.attrItem_3=nil;
_UIObject_release(self.attrItem_2);self.attrItem_2=nil;
_UIObject_release(self.attrItem_1);self.attrItem_1=nil;
_UIObject_release(self.attrItemup);self.attrItemup=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.attr);self.attr=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.titledesc);self.titledesc=nil;
_UIObject_release(self.uptitle);self.uptitle=nil;
self.attrItem=nil;
end


















function UIXianBaoUpStarSuccessWin:onLoaded(...)
self:bindComponents()
self.stamp=os.time()
self.closeTag=false
end

function UIXianBaoUpStarSuccessWin:__delete()
self:unbindComponents()
end

function UIXianBaoUpStarSuccessWin:onShow(argtable,afterOnloaded)
self:stopAllTimer()
local xbid=argtable[1]
local oldlv=argtable[2]
local newlv=argtable[3]
local xbCfg=xianbaoConfig.getXBCfg(xbid)
local isMax=xianbaoModel:checkIsMaxStar(xbid)

self.effect:setChildShowEffect(10010,true)

AudioManager.playAudio(577)

local widget=self.attrlvItem:getWidgetBase()
local fisrstFlag=oldlv==0
widget:SetChildLayoutGroupCreateItems(2,fisrstFlag and 1 or oldlv,function(idx)
local starItem=widget:GetChildLayoutGroupGridItem(2,idx-1)
starItem:SetChildActive(0,not fisrstFlag)
end)

widget:SetChildActive(3,true)
widget:SetChildLayoutGroupCreateItems(4,newlv,function(idx)
local starItem=widget:GetChildLayoutGroupGridItem(4,idx-1)
starItem:SetChildActive(0,true)
end)

self.attrlvItem:setActive(false)

self.attrItemup:setActive(false)

local oldstarXbCfg=xianbaoConfig.getXBStarCfg(xbid,oldlv)
local newstarXbCfg=xianbaoConfig.getXBStarCfg(xbid,newlv)
local oldattrs=oldstarXbCfg.attrs
local newattrs=newstarXbCfg.attrs
local len=#oldattrs
self.attrNum=len
for i,v in ipairs(self.attrItem)do
local widget=v:getWidgetBase()
v:setActive(i<=len)
if i<=len then
local oldattr=oldattrs[i]
local newattr=newattrs[i]
local attrtype=oldattr[1]
local oldval=oldattr[2]or 0
local newval=newattr[2]or 0
local name,oldStr=equipsHelper.getAttr(attrtype,oldval)
local name,newStr=equipsHelper.getAttr(attrtype,newval)
widget:SetChildText(1,FMT.fmt('{0}：{1}',name,oldStr))
widget:SetChildText(3,newStr)
end
end
self.attr:setActive(false)

local desc=oldstarXbCfg.upStarEffectDec

self.skillIcon:setChildIcon(xbCfg.upStarIcon,false)
self.titledesc:setText(desc[1])
self.desc:setText(desc[2])
if desc[3]then
self.uptitle:setActive(true)
self.desc2:setText(desc[3])
else
self.uptitle:setActive(false)
end


self.skill:setChildCanvasGroupAlpha(0)

local modelParams=xbCfg.model
local effectInfo=isMax and modelParams[2]or modelParams[1]
self.model:setChildShowEffect(effectInfo[1],true)

self.model:setActive(false)

self.titleBack:setScale(Vector3.zero)

self:doMyAnim()
end

function UIXianBaoUpStarSuccessWin:onHide()

end



function UIXianBaoUpStarSuccessWin:doMyAnim()
local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)



local item=self.model:getWidgetBase()
local pos=item:GetChildLocalPosition(-1)
item:SetChildLocalPosX(-1,pos.x+200)
item:SetChildActive(-1,true)
self:delayDo(delay,function()
item:SetChildDOLocalMoveX(-1,pos.x,0.5)
end)
delay=delay+0.5


self.attr:setActive(true)

local item=self.attrlvItem:getWidgetBase()
local pos=item:GetChildLocalPosition(-1)
item:SetChildLocalPosY(-1,pos.y-200)
self:delayDo(delay,function()
item:SetChildActive(-1,true)
item:SetChildDOLocalMoveY(-1,pos.y,0.2)
end)
delay=delay+0.1










for i=1,self.attrNum do
local item=self.attrItem[i]:getWidgetBase()
item:SetChildActive(-1,false)
local pos=item:GetChildLocalPosition(-1)
item:SetChildLocalPosY(-1,pos.y-200)
self:delayDo(delay,function()
item:SetChildActive(-1,true)
item:SetChildDOLocalMoveY(-1,pos.y,0.2)
end)
delay=delay+0.1
end

delay=delay+0.2


local item=self.skill:getWidgetBase()
local pos=item:GetChildLocalPosition(-1)
self:delayDo(delay,function()
item:SetChildCanvasGroupDOFade(-1,1,2,nil)
end)
delay=delay+0.1

self.tips:setActive(false)
self:delayDo(delay,function()
self.tips:setActive(true)
self.closeTag=true
end)
end

function UIXianBaoUpStarSuccessWin:onClose()
local stamp=os.time()
local left=stamp-self.stamp
if self.closeTag or left>=2 then
self:closeSelf()
end
end
