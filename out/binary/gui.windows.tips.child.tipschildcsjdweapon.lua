







def_class("tipsChildCSJDWeapon",UICloneObject)





tipsChildCSJDWeapon.abName="ui/windows/tips/child/tipschildcsjdweapon.ab"

tipsChildCSJDWeapon.assetName="tipsChildCSJDWeapon"


function tipsChildCSJDWeapon:bindComponents()

self.equip=UIObject.get(self,0)
self.fight=UIText.get(self,1)
self.Icon=UIImage.get(self,2)
self.name=UIText.get(self,3)
self.stage=UIText.get(self,4)
self.starList=UIObject.get(self,5)

end


function tipsChildCSJDWeapon:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.equip);self.equip=nil;
_UIObject_release(self.fight);self.fight=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.stage);self.stage=nil;
_UIObject_release(self.starList);self.starList=nil;
end





local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end



function tipsChildCSJDWeapon:onLoaded(...)
self:bindComponents()
end


function tipsChildCSJDWeapon:__delete()
self:unbindComponents()
end




function tipsChildCSJDWeapon:onShow(argtable,afterOnloaded)
local args=argtable.argtable
local id=args.itemid
local attach=args.attach
self.id=id
self.actId=attach.actId
self.subType=attach.subType
self.subId=attach.subId
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self:refreshView()
end


function tipsChildCSJDWeapon:onHide()

end



function tipsChildCSJDWeapon:refreshView()
local teamData=self.info:getTeam()
local weaponServer=self.config.treasure[self.id]
local weaponClient=self.config.treasureClient[self.id]
local nameStr=weaponClient[1]
local iconName=weaponClient[2]

local star=self.info:getCopyItemStar(self.id)
local isEquip=false
for i,v in ipairs(teamData)do
if v.weapon==self.id then
isEquip=true
break
end
end

self.name:setText(nameStr)
self.starList:setChildLayoutGroupCreateItems(star,function(index)
local item=self.starList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(0,true)
item:SetChildAnimationStringID(0,'daobing',false)
end)
self.Icon:setImageIcon(iconName,false)
self.fight:setText("")
self.stage:setText(_descFun("类型：","宝物"))
self.equip:setActive(isEquip)
end