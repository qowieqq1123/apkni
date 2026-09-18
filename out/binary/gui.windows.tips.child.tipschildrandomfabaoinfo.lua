







def_class("tipsChildRandomFabaoInfo",UICloneObject)





tipsChildRandomFabaoInfo.abName="ui/windows/tips/child/tipschildrandomfabaoinfo.ab"

tipsChildRandomFabaoInfo.assetName="tipsChildRandomFabaoInfo"


function tipsChildRandomFabaoInfo:bindComponents()

self.name=UIText.get(self,0)
self.typename=UIText.get(self,1)
self.stage=UIText.get(self,2)
self.Icon=UIImage.get(self,3)

end


function tipsChildRandomFabaoInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.typename);self.typename=nil;
_UIObject_release(self.stage);self.stage=nil;
_UIObject_release(self.Icon);self.Icon=nil;
end







local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end

function tipsChildRandomFabaoInfo:onLoaded(...)
self:bindComponents()
end

function tipsChildRandomFabaoInfo:__delete()
self:unbindComponents()
end

function tipsChildRandomFabaoInfo:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx

local formType=data.formType
local itemid=data.itemid
local attach=data.attach
self.formType=formType
self.diziguid=attach.diziguid

local itemConfig=itemsConfig.getConfig(itemid)

local name=itemConfig.name or'随机法宝'


local typetxt=_descFun('类型：','法宝')


local stage=itemConfig.stage or 0
local needjingjielv=fabaoHelper.getDressJingjielv(itemid)
local jingjieName=UIDiscipleModel:getJJNameX(needjingjielv)
local jingjielv=self.diziguid and UIDiscipleModel:getDiscipleJJLevel(self.diziguid)or 0
jingjieName=FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,jingjieName)
local stageStr=FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,'境界：'),jingjieName)


local iconname=iconHelper.getItemIconName(itemConfig.icon)

self.name:setText(name)
self.typename:setText(typetxt)
self.stage:setText(stageStr)
self.Icon:setImageIcon(iconname,false)
end

function tipsChildRandomFabaoInfo:onHide()

end


