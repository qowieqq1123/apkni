







def_class("tipsChildBenMingFabaoInfo",UICloneObject)





tipsChildBenMingFabaoInfo.abName="ui/windows/tips/child/tipschildbenmingfabaoinfo.ab"

tipsChildBenMingFabaoInfo.assetName="tipsChildBenMingFabaoInfo"


function tipsChildBenMingFabaoInfo:bindComponents()

self.name=UIText.get(self,0)

end


function tipsChildBenMingFabaoInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
end








function tipsChildBenMingFabaoInfo:onLoaded(...)
self:bindComponents()
end

function tipsChildBenMingFabaoInfo:__delete()
self:unbindComponents()
end

function tipsChildBenMingFabaoInfo:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local diziguid=attach.diziguid
self.diziguid=diziguid
self.itemid=itemid
self.formType=data.formType
local itemConfig=itemsConfig.getConfig(itemid)
self.itemguid=itemguid

local selfItem=fabaoBagModel:getItem(itemguid)or fabaoModel.getFabao(itemguid)
local isSelf=selfItem~=nil
if not isSelf then
self.name:setText('<size=22>无法查探法宝主人信息</size>')
return
end

local hasOwner,dzguid=benMingFaBaoHelper.hasOwner(itemguid)
if hasOwner then
local dzInfo=UIDiscipleModel:getMyDiscipleData(dzguid)
if dzInfo then
local dzname=UIDiscipleModel:getDiscipleName(dzguid)
self.name:setText(FMT.fmt('<color=#efb150>法宝主人：{0}</color>',dzname))
else
self.name:setText('该法宝尚无主人')
end
else
self.name:setText('该法宝尚无主人')
end
end

function tipsChildBenMingFabaoInfo:onHide()

end


