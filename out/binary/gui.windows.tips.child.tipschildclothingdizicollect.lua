







def_class("tipsChildClothingDiziCollect",UICloneObject)





tipsChildClothingDiziCollect.abName="ui/windows/tips/child/tipschildclothingdizicollect.ab"

tipsChildClothingDiziCollect.assetName="tipsChildClothingDiziCollect"


function tipsChildClothingDiziCollect:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.voc=UIText.get(self,2)

end


function tipsChildClothingDiziCollect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.voc);self.voc=nil;
end









function tipsChildClothingDiziCollect:onLoaded(...)
self:bindComponents()
end


function tipsChildClothingDiziCollect:__delete()
self:unbindComponents()
end




function tipsChildClothingDiziCollect:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach_starlv=attach.starlv



local collectLv=ClothingModel:getClothingCollectStarLvById(itemid)or 0

local starlv=0
if itemguid then
starlv=collectLv
end
if itemguid and not ClothingHelper.getEquip(itemguid)then
self:recycleSelf()
return
end
local itemConfig=itemsConfig.getConfig(itemid)
local type2=itemConfig.type2
local cfg=cfgHelper.get(cfg_discipledresstypeconfig_get,type2)
if(not cfg)or(not cfg.disciple)then
self:recycleSelf()
return
end
local diziName=cfgHelper.get2(cfg_discipleconfig_get,cfg.disciple,"name")

local attr=cfg.attrex

if attr and attr[0]then
local name,str=equipsHelper.getAttr(attr[0][1][1],attr[0][1][2],nil,1)
self.voc:setText(FMT.fmt("{0} {1}+<color=#efb150>{2}</color>(获得后生效)",diziName,name,str))
else
self:recycleSelf()
return
end
end


function tipsChildClothingDiziCollect:onHide()

end


