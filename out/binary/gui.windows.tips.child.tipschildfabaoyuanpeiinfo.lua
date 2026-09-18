







def_class("tipsChildFaBaoYuanPeiInfo",UICloneObject)





tipsChildFaBaoYuanPeiInfo.abName="ui/windows/tips/child/tipschildfabaoyuanpeiinfo.ab"

tipsChildFaBaoYuanPeiInfo.assetName="tipsChildFaBaoYuanPeiInfo"


function tipsChildFaBaoYuanPeiInfo:bindComponents()

self.name=UIText.get(self,0)
self.typename=UIText.get(self,1)
self.Icon=UIImage.get(self,2)
self.level=UIText.get(self,3)

end


function tipsChildFaBaoYuanPeiInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.typename);self.typename=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.level);self.level=nil;
end







local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end

function tipsChildFaBaoYuanPeiInfo:onLoaded(...)
self:bindComponents()
end

function tipsChildFaBaoYuanPeiInfo:__delete()
self:unbindComponents()
end

function tipsChildFaBaoYuanPeiInfo:onShow(args,afterOnloaded)
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
local itemCfg=itemsConfig.getConfig(itemid)
self.itemguid=itemguid
local level=itemCfg.level
local iconname=iconHelper.getItemIconName(itemCfg.icon)

local typetxt=_descFun('类型：','法宝原胚')
local leveltxt=_descFun('使用等级：',FMT.fmt('宗门{0}级',level))

self.name:setText(itemCfg.name)
self.typename:setText(typetxt)
self.level:setText(leveltxt)
self.Icon:setChildIcon(iconname,true)
end

function tipsChildFaBaoYuanPeiInfo:onHide()

end


