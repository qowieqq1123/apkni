







def_class("tipsChildDaoBingMaterialsZhuanShuShentong",UICloneObject)





tipsChildDaoBingMaterialsZhuanShuShentong.abName="ui/windows/tips/child/tipschilddaobingmaterialszhuanshushentong.ab"

tipsChildDaoBingMaterialsZhuanShuShentong.assetName="tipsChildDaoBingMaterialsZhuanShuShentong"


function tipsChildDaoBingMaterialsZhuanShuShentong:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)

end


function tipsChildDaoBingMaterialsZhuanShuShentong:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
end








function tipsChildDaoBingMaterialsZhuanShuShentong:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingMaterialsZhuanShuShentong:__delete()
self:unbindComponents()
end

function tipsChildDaoBingMaterialsZhuanShuShentong:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local attach=data.attach


local oitemid=data.itemid
local oitemCfg=itemsConfig.getConfig(oitemid)
local piece=oitemCfg.piece
local need=piece[2]
local itemid=piece[1]


local itemCfg=itemsConfig.getConfig(itemid)


local useSkillids,allSkillids=daobingHelper.getZhuanShuShentong(itemid)
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
for i=1,len do
local item=grids[i-1]
local skillid=allSkillids[i]
local desc=skillModel:getSkillDesc(skillid,1)
desc=isUse(skillid)and desc or FMT.cfmt2('#8e8c87',desc)
item:SetChildText(0,desc)
end
end

function tipsChildDaoBingMaterialsZhuanShuShentong:onHide()

end


