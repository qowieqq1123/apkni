







def_class("tipsChildFabaoTitle",UICloneObject)





tipsChildFabaoTitle.abName="ui/windows/tips/child/tipschildfabaotitle.ab"

tipsChildFabaoTitle.assetName="tipsChildFabaoTitle"


function tipsChildFabaoTitle:bindComponents()

self.desc=UIText.get(self,0)

end


function tipsChildFabaoTitle:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
end








function tipsChildFabaoTitle:onLoaded(...)
self:bindComponents()
end

function tipsChildFabaoTitle:__delete()
self:unbindComponents()
end

function tipsChildFabaoTitle:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
local name=itemConfig.name
local item=equipsHelper.getEquip(itemguid)
local shentongid=fabaoHelper.getShentongid(item)
local shentongConfig=fabaoConfig.getShentongConfig(shentongid)
local shentongName=shentongConfig.name
local isMainMaterials=attach.isMain or false
local desc=''
if itemsConfig.isEquip(itemid)then
desc=FMT.fmt('{0}被炼制为法宝时，可获得法宝神通【{1}】',name,shentongName)
else
if isMainMaterials then
desc=FMT.fmt('{0}作为主材料时，法宝属性预览')
else
desc=FMT.fmt('{0}作为辅助材料时，法宝属性预览')
end
end
self.desc:setText(desc)
end

function tipsChildFabaoTitle:onHide()

end


