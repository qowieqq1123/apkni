







def_class("tipsChildYunZhouInfo",UICloneObject)





tipsChildYunZhouInfo.abName="ui/windows/tips/child/tipschildyunzhouinfo.ab"

tipsChildYunZhouInfo.assetName="tipsChildYunZhouInfo"


function tipsChildYunZhouInfo:bindComponents()

self.bgstarGrid=UIObject.get(self,0)
self.Icon=UIImage.get(self,1)
self.name=UIText.get(self,2)
self.sign=UIObject.get(self,3)
self.starGrid=UIObject.get(self,4)
self.typename=UIText.get(self,5)

end


function tipsChildYunZhouInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgstarGrid);self.bgstarGrid=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.sign);self.sign=nil;
_UIObject_release(self.starGrid);self.starGrid=nil;
_UIObject_release(self.typename);self.typename=nil;
end







local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end


function tipsChildYunZhouInfo:onLoaded(...)
self:bindComponents()
end


function tipsChildYunZhouInfo:__delete()
self:unbindComponents()
end




function tipsChildYunZhouInfo:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemData=attach.itemData
local boatid=attach.yzId
local pos=attach.pos

local itemConfig=itemsConfig.getConfig(itemid)

self.Icon:setImageIcon(iconHelper.getIconName(itemid),false)


local item
if boatid and boatid>0 then
item=XianYunGangModel:getYunZhouComponentsPosData(boatid,pos)
else
item=bagModel.getItem(itemguid)
end
local otherData=itemData or(item~=nil and item.itemData or{})
local strengthLv=otherData.jinglianlv or 0
local strengthDesc=strengthLv>0 and string.format("+%d",strengthLv)or""
local posType=itemConfig.type1
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,itemConfig.color)

self.name:setText(string.format("[ %s ] %s %s",suitConfig.name,itemConfig.name,strengthDesc))

local isEquiped=false

self.sign:setActive(isEquiped)

local typename
if posType==1 then
typename="龙首"
elseif posType==2 then
typename="龙骨"
else
typename="阵炉"
end
local tname_str2=_descFun('类型：',typename)
self.typename:setText(tname_str2)


local starlv=itemConfig.stage
local starWidget=self.starGrid:getChildWidgetBase()
for i=1,6 do
starWidget:SetChildActive(i-1,i<=starlv)
end
local maxStar=yunZhouEquipsConfig.getEquipMaxStar(itemid)
starWidget=self.bgstarGrid:getChildWidgetBase()
for i=1,6 do
starWidget:SetChildActive(i-1,i<=maxStar)
end
end