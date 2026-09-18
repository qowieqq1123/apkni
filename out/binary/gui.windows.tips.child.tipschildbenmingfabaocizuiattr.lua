







def_class("tipsChildBenMingFabaoCiZuiAttr",UICloneObject)





tipsChildBenMingFabaoCiZuiAttr.abName="ui/windows/tips/child/tipschildbenmingfabaocizuiattr.ab"

tipsChildBenMingFabaoCiZuiAttr.assetName="tipsChildBenMingFabaoCiZuiAttr"


function tipsChildBenMingFabaoCiZuiAttr:bindComponents()

self.Icon=UIImage.get(self,0)
self.desc=UIText.get(self,1)
self.line=UIObject.get(self,2)

end


function tipsChildBenMingFabaoCiZuiAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.line);self.line=nil;
end








function tipsChildBenMingFabaoCiZuiAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildBenMingFabaoCiZuiAttr:__delete()
self:unbindComponents()
end

function tipsChildBenMingFabaoCiZuiAttr:onShow(args,afterOnloaded)
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
local fabao=fabaoHelper.getFabao(itemguid)

local mainid=fabaoHelper.getMainId(fabao)
local czid=benMingFaBaoHelper.getCiZhui(mainid)
local czCfg=cfg_disciplefabaoczconfig_get(czid)
local czname=czCfg.name
local desc=czCfg.descEx or czCfg.desc

self.Icon:setIcon(iconHelper.getSkillIcon(czCfg.icon),false)
self.desc:setText(FMT.fmt('<color=#efb150>【{0}】</color>{1}',czname,desc))
end

function tipsChildBenMingFabaoCiZuiAttr:onHide()

end


