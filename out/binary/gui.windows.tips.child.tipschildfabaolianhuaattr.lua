







def_class("tipsChildFabaoLianhuaAttr",UICloneObject)





tipsChildFabaoLianhuaAttr.abName="ui/windows/tips/child/tipschildfabaolianhuaattr.ab"

tipsChildFabaoLianhuaAttr.assetName="tipsChildFabaoLianhuaAttr"


function tipsChildFabaoLianhuaAttr:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)

end


function tipsChildFabaoLianhuaAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
end





function tipsChildFabaoLianhuaAttr:onLoaded()
self:bindComponents()
end

function tipsChildFabaoLianhuaAttr:__delete()
self:unbindComponents()
end

function tipsChildFabaoLianhuaAttr:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
local item=equipsHelper.getEquip(itemguid)
local isCfg=equipsHelper.isCfgEquip(itemguid)
local list=not isCfg and fabaoHelper.getLianhuaAttrsList(item)or
fabaoHelper.getLianhuaAttrsListByCfg(itemConfig)
if list==nil or#list==0 then
self:recycleSelf()
return
end
local leftNum,tNum
if not isCfg then
leftNum,tNum=fabaoHelper.getLianhuaLeftNum(itemguid)
else
tNum=fabaoHelper.getLianhuaMaxNumByCfg(itemid)
leftNum=tNum
end
self.title:setText(FMT.fmt('炼化属性（{0}/{1}）',tNum-leftNum,tNum))

local len=#list

self.creater:setChildLayoutGroupCreateItems(len)
local grids=self.creater:getChildLayoutGroupGridList()
for i=1,len do
local widget=grids[i-1]
local v=list[i]
local name,valstr=equipsHelper.getAttr(v[1],v[2])
local attrStr=FMT.fmt('{0}：{1}',name,valstr)
widget:SetChildText(0,attrStr)
widget:SetChildActive(1,false)
end
end
