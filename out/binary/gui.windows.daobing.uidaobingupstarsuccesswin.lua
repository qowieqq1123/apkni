







def_class("UIDaoBingUpStarSuccessWin",UIWindowBase)









function UIDaoBingUpStarSuccessWin:bindComponents()

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
self.oldstar_5=UIObject.get(self,14)
self.oldstar_4=UIObject.get(self,15)
self.oldstar_3=UIObject.get(self,16)
self.oldstar_2=UIObject.get(self,17)
self.oldstar_1=UIObject.get(self,18)
self.newstar_4=UIObject.get(self,19)
self.newstar_5=UIObject.get(self,20)
self.newstar_1=UIObject.get(self,21)
self.newstar_2=UIObject.get(self,22)
self.newstar_3=UIObject.get(self,23)
self.attrItem={
self.attrItem_1,
self.attrItem_2,
self.attrItem_3,
}
self.oldstar={
self.oldstar_1,
self.oldstar_2,
self.oldstar_3,
self.oldstar_4,
self.oldstar_5,
}
self.newstar={
self.newstar_1,
self.newstar_2,
self.newstar_3,
self.newstar_4,
self.newstar_5,
}



end


function UIDaoBingUpStarSuccessWin:unbindComponents()
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
_UIObject_release(self.oldstar_5);self.oldstar_5=nil;
_UIObject_release(self.oldstar_4);self.oldstar_4=nil;
_UIObject_release(self.oldstar_3);self.oldstar_3=nil;
_UIObject_release(self.oldstar_2);self.oldstar_2=nil;
_UIObject_release(self.oldstar_1);self.oldstar_1=nil;
_UIObject_release(self.newstar_4);self.newstar_4=nil;
_UIObject_release(self.newstar_5);self.newstar_5=nil;
_UIObject_release(self.newstar_1);self.newstar_1=nil;
_UIObject_release(self.newstar_2);self.newstar_2=nil;
_UIObject_release(self.newstar_3);self.newstar_3=nil;
self.attrItem=nil;
self.oldstar=nil;
self.newstar=nil;
end


















function UIDaoBingUpStarSuccessWin:onLoaded(...)
self:bindComponents()
self.stamp=os.time()
self.closeTag=false
end

function UIDaoBingUpStarSuccessWin:__delete()
self:unbindComponents()
end

function UIDaoBingUpStarSuccessWin:onShow(argtable,afterOnloaded)
self:stopAllTimer()
local itemguid=argtable[1]
local oldlv=argtable[2]
local newlv=argtable[3]
local equip=daobingHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local isMax=newlv>=daobingConfig.getStarMaxLv(itemid)

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

local jllv=daobingModel:getJilianLv(itemguid)
local oldAttrLookup=daobingHelper.getEquipBaseAttrsLookupByItemid(itemid,oldlv,jllv)
local newAttrLookup=daobingHelper.getEquipBaseAttrsLookupByItemid(itemid,newlv,jllv)

local baseAttrList=daobingHelper.getBaseAttrsList(itemCfg)or{}

local widget=self.attrItemup:getWidgetBase()
local oldMaxlv=daobingConfig.getjinglianLimitLvByStar(oldlv)
local newMaxlv=daobingConfig.getjinglianLimitLvByStar(newlv)
widget:SetChildText(1,FMT.fmt('精炼上限：{0}',oldMaxlv))
widget:SetChildText(3,newMaxlv)
self.attrItemup:setActive(false)


local len=#baseAttrList
self.attrNum=len
for i,v in ipairs(self.attrItem)do
local widget=v:getWidgetBase()
v:setActive(i<=len)
if i<=len then
local newattr=baseAttrList[i]
local attrtype=newattr[1]
local oldval=oldAttrLookup[attrtype]or 0
local newval=newAttrLookup[attrtype]or 0
local name,oldStr=equipsHelper.getAttr(attrtype,oldval)
local name,newStr=equipsHelper.getAttr(attrtype,newval)
widget:SetChildText(1,FMT.fmt('{0}：{1}',name,oldStr))
widget:SetChildText(3,newStr)
end
end
self.attr:setActive(false)

local skillids=daobingHelper.getWeaponShentong(itemid)
local skillid=skillids[1]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillid)
local starlv=newlv
local skilllv=daobingConfig.getWeaponShentongLvByStar(starlv)

local desc=skillModel:getSkillDesc(skillid,skilllv)

self.skillIcon:setChildIcon(iconHelper.getSkillIcon(skillCfg.icon),false)
self.desc:setText(desc)

self.skill:setChildCanvasGroupAlpha(0)

local modelParams=itemsConfig.getConfig(itemid).model
local effectInfo=isMax and modelParams[2]or modelParams[1]
self.model:setChildShowEffect(effectInfo[1],true)

self.model:setActive(false)

self.titleBack:setScale(Vector3.zero)

self:doMyAnim()
end

function UIDaoBingUpStarSuccessWin:onHide()

end



function UIDaoBingUpStarSuccessWin:doMyAnim()
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

local item=self.attrItemup:getWidgetBase()
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

function UIDaoBingUpStarSuccessWin:onClose()
local stamp=os.time()
local left=stamp-self.stamp
if self.closeTag or left>=2 then
self:closeSelf()
end
end
