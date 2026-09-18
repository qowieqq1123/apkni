







def_class("tipsChildDaoBingMaterialsWeaponShentong",UICloneObject)





tipsChildDaoBingMaterialsWeaponShentong.abName="ui/windows/tips/child/tipschilddaobingmaterialsweaponshentong.ab"

tipsChildDaoBingMaterialsWeaponShentong.assetName="tipsChildDaoBingMaterialsWeaponShentong"


function tipsChildDaoBingMaterialsWeaponShentong:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)

end


function tipsChildDaoBingMaterialsWeaponShentong:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
end








function tipsChildDaoBingMaterialsWeaponShentong:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingMaterialsWeaponShentong:__delete()
self:unbindComponents()
end

function tipsChildDaoBingMaterialsWeaponShentong:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemguid=data.itemguid
local attach=data.attach


local oitemid=data.itemid
local oitemCfg=itemsConfig.getConfig(oitemid)
local piece=oitemCfg.piece
local need=piece[2]
local itemid=piece[1]


local itemCfg=itemsConfig.getConfig(itemid)

local lv=daobingHelper.getWeaponShentongLv()
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

function tipsChildDaoBingMaterialsWeaponShentong:onHide()

end


