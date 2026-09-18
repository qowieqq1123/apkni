







def_class("tipsChildDaoBingMaterialsVoc",UICloneObject)





tipsChildDaoBingMaterialsVoc.abName="ui/windows/tips/child/tipschilddaobingmaterialsvoc.ab"

tipsChildDaoBingMaterialsVoc.assetName="tipsChildDaoBingMaterialsVoc"


function tipsChildDaoBingMaterialsVoc:bindComponents()

self.voc=UIText.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildDaoBingMaterialsVoc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.voc);self.voc=nil;
_UIObject_release(self.title);self.title=nil;
end








function tipsChildDaoBingMaterialsVoc:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingMaterialsVoc:__delete()
self:unbindComponents()
end

function tipsChildDaoBingMaterialsVoc:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx

local oitemid=data.itemid
local oitemCfg=itemsConfig.getConfig(oitemid)
local piece=oitemCfg.piece
local need=piece[2]
local itemid=piece[1]

local itemCfg=itemsConfig.getConfig(itemid)
local attach=data.attach
local type2=itemCfg.type2
local vocList=equipsHelper.getLimitVoc(type2)or{}
local vocDesc=''
local hasLimit=false
for i,v in ipairs(vocList)do
local vocationConfig=equipsConfig.getDiziVocationConfig(v)
local hide=vocationConfig.hide
if not hide then
local name=vocationConfig.name
local split=i~=1 and' 'or''
vocDesc=FMT.fmt('{0}{1}[\194\160{2}\194\160]',vocDesc,split,name)
hasLimit=true
end
end
if not hasLimit then
self:recycleSelf()
return
end
self.voc:setText(vocDesc)
end

function tipsChildDaoBingMaterialsVoc:onHide()

end


