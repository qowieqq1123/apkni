







def_class("UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin:bindComponents()

self.attr=UIObject.get(self,0)
self.attrItem_1=UIObject.get(self,1)
self.attrItem_2=UIObject.get(self,2)
self.attrItem_3=UIObject.get(self,3)
self.attrlvItem=UIObject.get(self,4)
self.desc=UIText.get(self,5)
self.effect=UIObject.get(self,6)
self.modelEffect=UIObject.get(self,7)
self.modelImage=UIImage.get(self,8)
self.newstar_1=UIObject.get(self,9)
self.newstar_2=UIObject.get(self,10)
self.newstar_3=UIObject.get(self,11)
self.newstar_4=UIObject.get(self,12)
self.newstar_5=UIObject.get(self,13)
self.oldstar_1=UIObject.get(self,14)
self.oldstar_2=UIObject.get(self,15)
self.oldstar_3=UIObject.get(self,16)
self.oldstar_4=UIObject.get(self,17)
self.oldstar_5=UIObject.get(self,18)
self.skill=UIObject.get(self,19)
self.skillIcon=UIImage.get(self,20)
self.tips=UIText.get(self,21)
self.titleBack=UIObject.get(self,22)
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


function UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr);self.attr=nil;
_UIObject_release(self.attrItem_1);self.attrItem_1=nil;
_UIObject_release(self.attrItem_2);self.attrItem_2=nil;
_UIObject_release(self.attrItem_3);self.attrItem_3=nil;
_UIObject_release(self.attrlvItem);self.attrlvItem=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.modelEffect);self.modelEffect=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
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
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
self.attrItem=nil;
self.newstar=nil;
self.oldstar=nil;
end















local _this=nil



function UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin:onLoaded(...)
self:bindComponents()
_this=self
self.stamp=os.time()
self.closeTag=false
end


function UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.oldID=argtable.oldID
self.newID=argtable.newID
self.parentWin=argtable.parentWin
self.callback=argtable.callback
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self:refreshView()
end


function UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin:onHide()

end



function UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin:doMyAnim()
local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)



local item=self.modelEffect:getWidgetBase()
local pos=item:GetChildLocalPosition(-1)
item:SetChildLocalPosX(-1,pos.x+200)
item:SetChildActive(-1,true)
self:delayDo(delay,function()
item:SetChildDOLocalMoveX(-1,pos.x,0.5)
end)

local item=self.modelImage:getWidgetBase()
local pos=item:GetChildLocalPosition(-1)
item:SetChildLocalPosX(-1,pos.x+200)
item:SetChildActive(-1,true)
self:delayDo(delay,function()
item:SetChildCanvasGroupAlpha(-1,1)
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

function UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin:onClose()
local stamp=os.time()
local left=stamp-self.stamp
if self.closeTag or left>=2 then
self:doCloseWin()
end
end

function UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin:doCloseWin()
if self.callback then
self.callback()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
UIManager:closeWindow(self.__name)
end
end

function UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin:refreshView()
self:stopAllTimer()

local oldServer=self.config.treasure[self.oldID]
local oldClient=self.config.treasureClient[self.oldID]
local newServer=self.config.treasure[self.newID]
local newClient=self.config.treasureClient[self.newID]

local oldStar=self.info:getCopyItemStar(self.oldID)
local newStar=self.info:getCopyItemStar(self.newID)

local widget=self.attrlvItem:getWidgetBase()
widget:SetChildStarNumber(2,oldStar)
widget:SetChildStarNumber(4,newStar)
for i=1,5 do
if oldStar>=i then
self.oldstar[i]:setAnimationStringID('daobing',false)
end
end
for i=1,5 do
if newStar>=i then
self.newstar[i]:setAnimationStringID('daobing',false)
end
end
self.attrlvItem:setActive(false)

local oldAttrs=oldServer[1]
local newAttrs=newServer[1]
local oldAttrLookup=attrListHelper.tramsformToLookup(oldAttrs)
local deltaAttrs={}
for i,v in ipairs(newAttrs)do
local attrType=v[1]
local nAttrValue=v[2]
local oAttrValue=oldAttrLookup[attrType]or 0
if nAttrValue>oAttrValue then
table.insert(deltaAttrs,v)
end
end
local len=#deltaAttrs
self.attrNum=len
for i,v in ipairs(self.attrItem)do
local widget=v:getWidgetBase()
v:setActive(i<=len)
if i<=len then
local attrData=deltaAttrs[i]
local attrType=attrData[1]
local oldVal=oldAttrLookup[attrType]or 0
local newVal=attrData[2]
local attrName=helper.getAttributeName(attrType)
local oldStr=helper.getAttributeStrEx(attrType,oldVal,2)
local newStr=helper.getAttributeStrEx(attrType,newVal,2)
widget:SetChildText(1,FMT.fmt('{0}：{1}',attrName,oldStr))
widget:SetChildText(3,newStr)
end
end
self.attr:setActive(false)

local skillId=newServer[2]
local skillLv=newServer[3]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local desc=skillModel:getSkillDesc(skillId,skillLv)
self.skillIcon:setChildIcon(iconHelper.getSkillIcon(skillCfg.icon),false)
self.desc:setText(desc)
self.skill:setChildCanvasGroupAlpha(0)

local effectId=newClient[4]
self.modelEffect:setChildShowEffect(effectId,true)
self.modelEffect:setActive(false)

local imageName=newClient[3]
self.modelImage:setImageIcon(imageName,true)
self.modelImage:setChildCanvasGroupAlpha(0)

self.titleBack:setScale(Vector3.zero)

self:doMyAnim()
end