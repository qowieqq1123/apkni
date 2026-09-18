







def_class("tipsChildFabaoCiZuiAttr",UICloneObject)





tipsChildFabaoCiZuiAttr.abName="ui/windows/tips/child/tipschildfabaocizuiattr.ab"

tipsChildFabaoCiZuiAttr.assetName="tipsChildFabaoCiZuiAttr"


function tipsChildFabaoCiZuiAttr:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)

end


function tipsChildFabaoCiZuiAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
end








function tipsChildFabaoCiZuiAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildFabaoCiZuiAttr:__delete()
self:unbindComponents()
end

function tipsChildFabaoCiZuiAttr:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
local item=equipsHelper.getEquip(itemguid)
local isCfg=equipsHelper.isCfgEquip(itemguid)
local stage=itemConfig.stage or 0
local maxlimitNum=fabaoConfig.getLianhuaConfig(stage).limit
local commonConfig=fabaoConfig.getCommonConfig()
local lianhualen=not isCfg and item.itemData and item.itemData.lianhualen or 0
local lianhuanum=not isCfg and item.itemData and item.itemData.lianhuanum or 0
local czActiveLookup=commonConfig.czactiveex
local czlist=not isCfg and fabaoHelper.getCiZhuiList(item)or itemConfig.cz
local jilianlv=not isCfg and item.itemData and item.itemData.jilianlv or 0
local maxlv=not isCfg and fabaoHelper.getJilianMaxLv(itemguid)or
fabaoHelper.getJilianMaxLvByCfg(itemid)
local len=#czlist
self.creater:setChildLayoutGroupCreateItems(len)
local grids=self.creater:getChildLayoutGroupGridList()
local activeNum=0
for i=1,len do
local widget=grids[i-1]
local needjllv=czActiveLookup[i]or 0
local alreadyJl=jilianlv>=needjllv
local active=alreadyJl and len>=i
local czid=czlist[i]
local hasczid=czid~=nil
local has=hasczid and needjllv<=maxlv or false

widget:SetChildActive(-1,has)
if has then
local ciZhuiConfig=fabaoConfig.getCiZhuiConfig(czid)
local color=ciZhuiConfig.color
local name=ciZhuiConfig.name
if active then
activeNum=activeNum+1
widget:SetChildText(0,FMT.cfmt1(color,'【{0}】{1}',name,ciZhuiConfig.desc))
else
widget:SetChildText(0,FMT.cfmt1(FONT_COLOR.eGrayColor,'【{0}】{1} (精炼+{2}激活)',name,ciZhuiConfig.desc,needjllv))
end
end
end

self.title:setText(FMT.fmt('词缀属性（{0}/{1}）',activeNum,len))
self.line:setActive(not self:isLastItem())
end

function tipsChildFabaoCiZuiAttr:onHide()

end



function tipsChildFabaoCiZuiAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end