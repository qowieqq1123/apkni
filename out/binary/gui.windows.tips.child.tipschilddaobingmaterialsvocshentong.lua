







def_class("tipsChildDaoBingMaterialsVocShentong",UICloneObject)





tipsChildDaoBingMaterialsVocShentong.abName="ui/windows/tips/child/tipschilddaobingmaterialsvocshentong.ab"

tipsChildDaoBingMaterialsVocShentong.assetName="tipsChildDaoBingMaterialsVocShentong"


function tipsChildDaoBingMaterialsVocShentong:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)

end


function tipsChildDaoBingMaterialsVocShentong:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
end








function tipsChildDaoBingMaterialsVocShentong:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingMaterialsVocShentong:__delete()
self:unbindComponents()
end

function tipsChildDaoBingMaterialsVocShentong:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local attach=data.attach

local oitemid=data.itemid
local oitemCfg=itemsConfig.getConfig(oitemid)
local piece=oitemCfg.piece
local need=piece[2]
local itemid=piece[1]

local itemCfg=itemsConfig.getConfig(itemid)

local useSkillids,allSkillids=daobingHelper.getVocShentong(itemid)
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

function tipsChildDaoBingMaterialsVocShentong:onHide()

end


