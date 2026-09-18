







def_class("tipsChildDaoBingWeaponShentong",UICloneObject)





tipsChildDaoBingWeaponShentong.abName="ui/windows/tips/child/tipschilddaobingweaponshentong.ab"

tipsChildDaoBingWeaponShentong.assetName="tipsChildDaoBingWeaponShentong"


function tipsChildDaoBingWeaponShentong:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)

end


function tipsChildDaoBingWeaponShentong:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
end








function tipsChildDaoBingWeaponShentong:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingWeaponShentong:__delete()
self:unbindComponents()
end

function tipsChildDaoBingWeaponShentong:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach_starlv=attach.starlv
self.attach_jllv=attach.jllv
local itemConfig=itemsConfig.getConfig(itemid)

local equip=itemguid and equipsHelper.getEquip(itemguid)or nil
local lv=daobingHelper.getWeaponShentongLv(equip)
if self.attach_starlv then
lv=daobingConfig.getWeaponShentongLvByStar(self.attach_starlv)
end
local skillids=daobingHelper.getWeaponShentong(itemid)
local len=#skillids
self.creater:setChildLayoutGroupCreateItems(len)
local grids=self.creater:getChildLayoutGroupGridList()
for i=1,len do
local item=grids[i-1]
local skillid=skillids[i]
local skilllv=lv
local cfg=fabaoConfig.getShentongConfig(skillid)
local name=cfg.name
local nameTitle=FMT.fmt('<color=#fd8950>【{0}{1}级】</color>',name,skilllv)
local desc=skillModel:getSkillDesc(skillid,skilllv)
local descEx=skillModel:getSkillDescEx(skillid,skilllv)or{}
desc=FMT.fmt('{0}{1}',nameTitle,desc)
for i,v in ipairs(descEx)do
local str=FMT.fmt('<color=#ffff99>{0}</color>',v)
desc=FMT.fmt('{0}\n{1}',desc,str)
end
item:SetChildText(0,desc)
end
end

function tipsChildDaoBingWeaponShentong:onHide()

end


