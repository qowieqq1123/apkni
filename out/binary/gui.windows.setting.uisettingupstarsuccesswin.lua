







def_class("UISettingUpStarSuccessWin",UIWindowBase)









function UISettingUpStarSuccessWin:bindComponents()

self.attr=UIObject.get(self,0)
self.attrItem_1=UIObject.get(self,1)
self.attrItem_2=UIObject.get(self,2)
self.attrItem_3=UIObject.get(self,3)
self.attrlvItem=UIObject.get(self,4)
self.effect=UIObject.get(self,5)
self.model=UIObject.get(self,6)
self.modelBg=UIObject.get(self,7)
self.newstar_1=UIObject.get(self,8)
self.newstar_2=UIObject.get(self,9)
self.newstar_3=UIObject.get(self,10)
self.newstar_4=UIObject.get(self,11)
self.newstar_5=UIObject.get(self,12)
self.oldstar_1=UIObject.get(self,13)
self.oldstar_2=UIObject.get(self,14)
self.oldstar_3=UIObject.get(self,15)
self.oldstar_4=UIObject.get(self,16)
self.oldstar_5=UIObject.get(self,17)
self.tips=UIText.get(self,18)
self.titleBack=UIObject.get(self,19)
self.attrItem={
self.attrItem_1,
self.attrItem_2,
self.attrItem_3,
}
self.newstar={
self.newstar_1,
self.newstar_2,
self.newstar_3,
self.newstar_4,
self.newstar_5,
}
self.oldstar={
self.oldstar_1,
self.oldstar_2,
self.oldstar_3,
self.oldstar_4,
self.oldstar_5,
}



end


function UISettingUpStarSuccessWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr);self.attr=nil;
_UIObject_release(self.attrItem_1);self.attrItem_1=nil;
_UIObject_release(self.attrItem_2);self.attrItem_2=nil;
_UIObject_release(self.attrItem_3);self.attrItem_3=nil;
_UIObject_release(self.attrlvItem);self.attrlvItem=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.newstar_1);self.newstar_1=nil;
_UIObject_release(self.newstar_2);self.newstar_2=nil;
_UIObject_release(self.newstar_3);self.newstar_3=nil;
_UIObject_release(self.newstar_4);self.newstar_4=nil;
_UIObject_release(self.newstar_5);self.newstar_5=nil;
_UIObject_release(self.oldstar_1);self.oldstar_1=nil;
_UIObject_release(self.oldstar_2);self.oldstar_2=nil;
_UIObject_release(self.oldstar_3);self.oldstar_3=nil;
_UIObject_release(self.oldstar_4);self.oldstar_4=nil;
_UIObject_release(self.oldstar_5);self.oldstar_5=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
self.attrItem=nil;
self.newstar=nil;
self.oldstar=nil;
end



















function UISettingUpStarSuccessWin:onLoaded(...)
self:bindComponents()
self.stamp=os.time()
self.closeTag=false
end


function UISettingUpStarSuccessWin:__delete()
self:unbindComponents()
end




function UISettingUpStarSuccessWin:onShow(argtable,afterOnloaded)
self:stopAllTimer()
self.settingType=argtable[1]
self.settingId=argtable[2]
local oldlv=argtable[3]
local newlv=argtable[4]

local settingcfg=UISettingConfig.getCfg(self.settingType,self.settingId)
local starNum=newlv
local maxStarNum=#settingcfg.star
local isMax=starNum==maxStarNum

self.effect:setChildShowEffect(10010,true)

AudioManager.playAudio(577)

local widget=self.attrlvItem:getWidgetBase()
widget:SetChildStarNumber(2,oldlv)
widget:SetChildStarNumber(4,newlv)

for i=1,5 do
if oldlv>=i then
self.oldstar[i]:setAnimationStringID('daobing',false)
end
end

for i=1,5 do
if newlv>=i then
self.newstar[i]:setAnimationStringID('daobing',false)
end
end

self.attrlvItem:setActive(false)

local attrList
local UpAttrList
local attr=settingcfg.attr
if attr then
attrList={}
UpAttrList={}
for i,v in ipairs(attr)do
table.insert(attrList,v)
table.insert(UpAttrList,v)
end
if oldlv>0 then
local star_attr=settingcfg.star_attr[oldlv]
attrList=table.concatTableXX(attrList,star_attr)
end
if newlv>0 then
local star_attr=settingcfg.star_attr[newlv]
UpAttrList=table.concatTableXX(UpAttrList,star_attr)
end
end
local jzattr=settingcfg.jzattr
if jzattr then
if not attrList then
attrList={}
end
if not UpAttrList then
UpAttrList={}
end
for i,v in ipairs(jzattr)do
table.insert(attrList,v)
table.insert(UpAttrList,v)
end
if oldlv>0 then
local star_jzattr=settingcfg.star_jzattr[oldlv]
attrList=table.concatTableXX(attrList,star_jzattr)
end
if newlv>0 then
local star_jzattr=settingcfg.star_jzattr[newlv]
UpAttrList=table.concatTableXX(UpAttrList,star_jzattr)
end
end

local len=#attrList
self.attrNum=len
for i,v in ipairs(self.attrItem)do
local widget=v:getWidgetBase()
v:setActive(i<=len)
if i<=len then
local attr=attrList[i]
local name,value=equipsHelper.getAttr(attr[1],attr[2])
local nameStr=FMT.fmt("{0}：{1}",name,value)

widget:SetChildText(1,nameStr)

local upName,addStr=equipsHelper.getAttr(UpAttrList[i][1],UpAttrList[i][2])
widget:SetChildText(3,addStr)
end
end
self.attr:setActive(false)

local modelId=settingcfg.modelId
self.winlua:SetChildUIModelEnableInitUISpinePara(self.model:getID(),false,true)
if self.dOFade and api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.model:getID(),true,true,false)
end
local pos=self.model:getChildAnchoredPosition()
local upstarmodelcfg=settingcfg.upstarmodelcfg or{}
local scale=upstarmodelcfg.scale or 1
local offset=upstarmodelcfg.offset or{0,0}
self.model:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand)
self.model:setChildAnchoredPos(pos.x+offset[1],pos.y+offset[2])

self.model:setActive(false)

self.titleBack:setScale(Vector3.zero)

self:doMyAnim()
end


function UISettingUpStarSuccessWin:onHide()

end




function UISettingUpStarSuccessWin:doMyAnim()
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

self.tips:setActive(false)
self:delayDo(delay,function()
self.tips:setActive(true)
self.closeTag=true
end)
end

function UISettingUpStarSuccessWin:onClose()
local stamp=os.time()
local left=stamp-self.stamp
if self.closeTag or left>=2 then
self:closeSelf()
end
end

