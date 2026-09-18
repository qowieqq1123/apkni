







def_class("tipsChildDaoBingZhuanShuShentong",UICloneObject)





tipsChildDaoBingZhuanShuShentong.abName="ui/windows/tips/child/tipschilddaobingzhuanshushentong.ab"

tipsChildDaoBingZhuanShuShentong.assetName="tipsChildDaoBingZhuanShuShentong"


function tipsChildDaoBingZhuanShuShentong:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)

end


function tipsChildDaoBingZhuanShuShentong:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
end








function tipsChildDaoBingZhuanShuShentong:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingZhuanShuShentong:__delete()
self:unbindComponents()
end

function tipsChildDaoBingZhuanShuShentong:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach_starlv=attach.starlv
local itemConfig=itemsConfig.getConfig(itemid)

local isEquip=daobingModel:isEquipedOnAnyDizi(itemguid)
local equip=equipsHelper.getEquip(itemguid)
local useSkillids,allSkillids=daobingHelper.getZhuanShuShentong(itemid,itemguid)
local len=#allSkillids
if len==0 then
self:recycleSelf()
return
end
local isUse=function(skillid)
for i,v in ipairs(useSkillids)do
if v==skillid then return true end
end
return false
end
self.creater:setChildLayoutGroupCreateItems(len)
local grids=self.creater:getChildLayoutGroupGridList()
local skilllv=daobingHelper.getZhuanShuShentongLv(equip)
if self.attach_starlv then
skilllv=daobingConfig.getZhuanShuShentongLvByStar(self.attach_starlv)
end
for i=1,len do
local item=grids[i-1]
local skillid=allSkillids[i]
local desc=skillModel:getSkillDesc(skillid,skilllv)
desc=isUse(skillid)and desc or FMT.cfmt2('#8e8c87',desc)
item:SetChildText(0,desc)
end
end

function tipsChildDaoBingZhuanShuShentong:onHide()

end


