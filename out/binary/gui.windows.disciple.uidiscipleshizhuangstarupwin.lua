







def_class("UIDiscipleShiZhuangStarUpWin",UIWindowBase)









function UIDiscipleShiZhuangStarUpWin:bindComponents()

self.attr=UIObject.get(self,0)
self.attrItem_1=UIObject.get(self,1)
self.attrItem_2=UIObject.get(self,2)
self.attrItem_3=UIObject.get(self,3)
self.attrItem_4=UIObject.get(self,4)
self.attrItem_5=UIObject.get(self,5)
self.attrlvItem=UIObject.get(self,6)
self.cattrItem=UIObject.get(self,7)
self.effect=UIObject.get(self,8)
self.model=UIObject.get(self,9)
self.modelBg=UIObject.get(self,10)
self.name=UIText.get(self,11)
self.newstar_1=UIObject.get(self,12)
self.newstar_2=UIObject.get(self,13)
self.newstar_3=UIObject.get(self,14)
self.newstar_4=UIObject.get(self,15)
self.newstar_5=UIObject.get(self,16)
self.oldstar_1=UIObject.get(self,17)
self.oldstar_2=UIObject.get(self,18)
self.oldstar_3=UIObject.get(self,19)
self.oldstar_4=UIObject.get(self,20)
self.oldstar_5=UIObject.get(self,21)
self.tips=UIText.get(self,22)
self.titleBack=UIObject.get(self,23)
self.attrItem={
self.attrItem_1,
self.attrItem_2,
self.attrItem_3,
self.attrItem_4,
self.attrItem_5,
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


function UIDiscipleShiZhuangStarUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr);self.attr=nil;
_UIObject_release(self.attrItem_1);self.attrItem_1=nil;
_UIObject_release(self.attrItem_2);self.attrItem_2=nil;
_UIObject_release(self.attrItem_3);self.attrItem_3=nil;
_UIObject_release(self.attrItem_4);self.attrItem_4=nil;
_UIObject_release(self.attrItem_5);self.attrItem_5=nil;
_UIObject_release(self.attrlvItem);self.attrlvItem=nil;
_UIObject_release(self.cattrItem);self.cattrItem=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.name);self.name=nil;
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



















function UIDiscipleShiZhuangStarUpWin:onLoaded(...)
self:bindComponents()
self.stamp=os.time()
self.closeTag=false
end


function UIDiscipleShiZhuangStarUpWin:__delete()
self:unbindComponents()
end




function UIDiscipleShiZhuangStarUpWin:onShow(argtable,afterOnloaded)
self:stopAllTimer()
local itemguid=argtable[1]
local oldlv=argtable[2]
local newlv=argtable[3]
local oldCollectLv=argtable[4]

local equip=ClothingHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local isMax=newlv>=ClothingConfig.getStarMaxLv(itemid)

local diziguid=ClothingModel:getDiziguidByItemguid(itemguid)

if itemCfg.item then
self.name:setText("羽化成功")
end

self.effect:setChildShowEffect(10010,true)

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

local oldAttrLookup,diziAttr=ClothingHelper.getEquipBaseAttrsLookupByItemid(itemid,oldlv)
local newAttrLookup,newdiziAttr=ClothingHelper.getEquipBaseAttrsLookupByItemid(itemid,newlv)

local baseAttrList=ClothingHelper.getBaseAttrsList(itemCfg)or{}

local baseDiziAttrList=ClothingHelper.getDiziAttrsList(itemCfg)or{}
local baseAttrListlen=#baseAttrList
local len=baseAttrListlen+#baseDiziAttrList
self.attrNum=len
for i,v in ipairs(self.attrItem)do
local widget=v:getWidgetBase()
v:setActive(i<=len)
if i<=baseAttrListlen then
local newattr=baseAttrList[i]
local attrtype=newattr[1]
local oldval=oldAttrLookup[attrtype]or 0
local newval=newAttrLookup[attrtype]or 0
local name,oldStr=equipsHelper.getAttr(attrtype,oldval)
local name,newStr=equipsHelper.getAttr(attrtype,newval)
widget:SetChildText(1,FMT.fmt('{0}：{1}',name,oldStr))
widget:SetChildText(3,newStr)
else
local newattr=baseDiziAttrList[i-baseAttrListlen]
local attrtype=newattr[1]
local oldval=diziAttr[attrtype]or 0
local newval=newdiziAttr[attrtype]or 0
local name,oldStr=equipsHelper.getDiziAttr(attrtype,oldval)
local name,newStr=equipsHelper.getDiziAttr(attrtype,newval)
widget:SetChildText(1,FMT.fmt('{0}：{1}',name,oldStr))
widget:SetChildText(3,newStr)
end
end
self.attr:setActive(false)


local modelParams=nil
local diziguid=ClothingModel:getDiziguidByItemguid(itemguid)
if diziguid then
local imageInfo=table.deepCopy(UIDiscipleModel:getDiscipleImageInfo(diziguid))
imageInfo.clothingId=itemid
imageInfo.clothingStar=newlv
local modelInfo=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,nil,{clothingStar=newlv})
modelParams={model=modelInfo.body,component=modelInfo.componets}
else
modelParams=ClothingConfig.getModelArgs(itemid,newlv,diziguid)
end


self.model:setChildUIModelShowTarget(modelParams.model,1.5,modelParams.component,eAnimationID.stand,false,false,0)


local collectLv=ClothingModel:getClothingCollectStarLv(itemCfg.type2)
if collectLv then
local attr=ClothingHelper.getCollectAttrs(itemid,collectLv)
local upName,addStr=equipsHelper.getAttr(attr[1][1],attr[1][2],nil,1)
local widget=self.cattrItem:getWidgetBase()
if oldCollectLv<collectLv then
local oldAttr=ClothingHelper.getCollectAttrs(itemid,oldCollectLv)
local oldupName,oldStr=equipsHelper.getAttr(oldAttr[1][1],oldAttr[1][2],nil,1)
widget:SetChildText(1,FMT.fmt('{0}：{1}',upName,oldStr))
widget:SetChildText(3,addStr)
widget:SetChildActive(2,true)
else
widget:SetChildText(1,FMT.fmt('{0}：{1}',upName,addStr))
widget:SetChildText(3,'')
widget:SetChildActive(2,false)
end



end

self.titleBack:setScale(Vector3.zero)

self:doMyAnim()
end


function UIDiscipleShiZhuangStarUpWin:onHide()

end

function UIDiscipleShiZhuangStarUpWin:doMyAnim()
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






















delay=delay+0.2


self.tips:setActive(false)
self:delayDo(delay,function()
self.tips:setActive(true)
self.closeTag=true
end)
end

function UIDiscipleShiZhuangStarUpWin:onClose()
local stamp=os.time()
local left=stamp-self.stamp
if self.closeTag or left>=2 then
self:closeSelf()
end
end



