







def_class("UIFabaoTuPoSuccessWin",UIWindowBase)









function UIFabaoTuPoSuccessWin:bindComponents()

self.titleBack=UIObject.get(self,0)
self.attr=UIObject.get(self,1)
self.title=UIText.get(self,2)
self.desc=UIText.get(self,3)
self.effect=UIObject.get(self,4)
self.attrlvItem=UIObject.get(self,5)
self.attrItem_1=UIObject.get(self,6)
self.attrItem_2=UIObject.get(self,7)
self.attrItem_3=UIObject.get(self,8)
self.attrItem={
self.attrItem_1,
self.attrItem_2,
self.attrItem_3,
}



end


function UIFabaoTuPoSuccessWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.attr);self.attr=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.attrlvItem);self.attrlvItem=nil;
_UIObject_release(self.attrItem_1);self.attrItem_1=nil;
_UIObject_release(self.attrItem_2);self.attrItem_2=nil;
_UIObject_release(self.attrItem_3);self.attrItem_3=nil;
self.attrItem=nil;
end


















function UIFabaoTuPoSuccessWin:onLoaded(...)
self:bindComponents()
self.attritemlist={
self.attrlvItem,
self.attrItem_1,
self.attrItem_2,
self.attrItem_3,
}
end

function UIFabaoTuPoSuccessWin:__delete()
self:unbindComponents()
end

function UIFabaoTuPoSuccessWin:onShow(argtable,afterOnloaded)
self:stopAllTimer()
local itemguid=argtable[1]
local oldlv=argtable[2]
local newlv=argtable[3]
local equip=fabaoHelper.getFabao(itemguid)

self.effect:setChildShowEffect(10010,true)

local widget1=self.attrlvItem:getWidgetBase()
local mainid=fabaoHelper.getReallyMainId(equip)
local oldAttrs=benMingFaBaoHelper.getLxAttr(mainid,oldlv)or{}
local newAttrs=benMingFaBaoHelper.getLxAttr(mainid,newlv)or{}
widget1:SetChildText(1,FMT.fmt('灵性{0}级',oldlv))
widget1:SetChildText(3,FMT.fmt('灵性{0}级',newlv))

local len=#newAttrs
self.attrNum=len
for i,v in ipairs(self.attrItem)do
local widget=v:getWidgetBase()
v:setActive(i<=len)
if i<=len then
local newattr=newAttrs[i]
local oldAttr=oldAttrs[i]or{}
local name,oldStr=equipsHelper.getAttr(newattr[1],oldAttr[2]or 0)
local name,newStr=equipsHelper.getAttr(newattr[1],newattr[2])
widget:SetChildText(1,FMT.fmt('{0}：{1}',name,oldStr))
widget:SetChildText(3,newStr)
end
end
self.attr:setActive(false)

local effectlist,effectlookup=fabaoConfig.getLxEffectList()
local effectInfo=effectlookup[newlv]
if effectInfo then
self.showEffect=true
local effectType=effectInfo[1]
local name,desc=benMingFaBaoHelper.getDesc(equip,newlv,effectType)
self.desc:setText(desc)
else
self.showEffect=false
end
self.title:setActive(false)

self.titleBack:setScale(Vector3.zero)

self:doMyAnim()
end

function UIFabaoTuPoSuccessWin:onHide()

end




function UIFabaoTuPoSuccessWin:doMyAnim()
local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)
delay=delay+0.15

self.attr:setActive(true)
for i=1,self.attrNum do
local item=self.attritemlist[i]:getWidgetBase()
item:SetChildActive(-1,false)
local pos=item:GetChildLocalPosition(-1)
item:SetChildLocalPosY(-1,pos.y-200)
self:delayDo(delay,function()
item:SetChildActive(-1,true)
item:SetChildDOLocalMoveY(-1,pos.y,0.2)
end)
delay=delay+0.1
end

if self.showEffect then
self.title:setActive(true)
local pos=self.title:getChildLocalPosition()
self.winlua:SetChildLocalPosY(self.title:getID(),pos.y-200)
self:delayDo(delay,function()
self.winlua:SetChildDOLocalMoveY(self.title:getID(),pos.y,0.2)
end)
end
end
