







def_class("tipsChildDaoBingVocShentong",UICloneObject)





tipsChildDaoBingVocShentong.abName="ui/windows/tips/child/tipschilddaobingvocshentong.ab"

tipsChildDaoBingVocShentong.assetName="tipsChildDaoBingVocShentong"


function tipsChildDaoBingVocShentong:bindComponents()

self.title=UIText.get(self,0)
self.creater=UIObject.get(self,1)
self.line=UIObject.get(self,2)

end


function tipsChildDaoBingVocShentong:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.line);self.line=nil;
end








function tipsChildDaoBingVocShentong:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingVocShentong:__delete()
self:unbindComponents()
end

function tipsChildDaoBingVocShentong:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach_starlv=attach.starlv
local itemConfig=itemsConfig.getConfig(itemid)

local isEquip=false
if itemguid then
isEquip=daobingModel:isEquipedOnAnyDizi(itemguid)
end
local voc
if isEquip then
local diziguid=daobingModel:getDiziguidByItemguid(itemguid)
voc=UIDiscipleModel:getDiscipleJob(diziguid)
end
local useSkillids,allSkillids=daobingHelper.getVocShentong(itemid,voc)
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
local skilllv=daobingHelper.getVocShentongLv(equip)
if self.attach_starlv then
skilllv=daobingConfig.getVocShentongLvByStar(self.attach_starlv)
end
for i=1,len do
local item=grids[i-1]
local skillid=allSkillids[i]
local desc=skillModel:getSkillDesc(skillid,skilllv)
desc=isUse(skillid)and desc or FMT.cfmt2('#8e8c87',desc)
item:SetChildText(0,desc)
end
end

function tipsChildDaoBingVocShentong:onHide()

end


