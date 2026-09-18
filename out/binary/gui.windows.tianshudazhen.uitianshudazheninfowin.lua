







def_class("UITianShuDaZhenInfoWin",UIWindowBase)









function UITianShuDaZhenInfoWin:bindComponents()

self.attrCreator=UIObject.get(self,0)
self.previewCreator=UIObject.get(self,1)



end


function UITianShuDaZhenInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrCreator);self.attrCreator=nil;
_UIObject_release(self.previewCreator);self.previewCreator=nil;
end



















function UITianShuDaZhenInfoWin:onLoaded(...)
self:bindComponents()
self.bdData=tianshudazhenModel:getBuildData()
end


function UITianShuDaZhenInfoWin:__delete()
self:unbindComponents()
end




function UITianShuDaZhenInfoWin:onShow(argtable,afterOnloaded)
self:refreshInfo()
end


function UITianShuDaZhenInfoWin:onHide()

end




function UITianShuDaZhenInfoWin:refreshInfo()
self.level=self.bdData.level
local alltsdzCfgs=cfg_tianshudazhenconfig()
local attrslist={}

local max=tianshudazhenAttrsModel:getHDTop()
local baseValue=tianshudazhenModel:getMaxHDZValue()
attrslist[#attrslist+1]={name='防护值上限',maxStr=max,add=max-baseValue,addStr=max-baseValue,oper=''}

local level=self.level
for i,v in ipairs(alltsdzCfgs[level].attr)do
local attrid=v[1]
local value=v[2]
local max=tianshudazhenAttrsModel:getLookupAttrs(attrid)
local add=max-value
local name,maxstr=equipsHelper.getAttr(attrid,max)
local name,addStr=equipsHelper.getAttr(attrid,add)
attrslist[#attrslist+1]={name=name,maxStr=maxstr,add=add,addStr=add>0 and addStr or'',oper='+'}
end
local len=#attrslist

self.winlua:SetChildLayoutGroupCreateItems(self.attrCreator:getID(),len,function(index)
local widget=self.winlua:GetChildLayoutGroupGridItem(self.attrCreator:getID(),index-1)
local attr=attrslist[index]
local maxStr=attr.maxStr
local add=attr.add
local addStr=attr.addStr
local name=attr.name
local oper=attr.oper
local desc=add>0 and FMT.fmt('{0}：<color=#aae252>{1}{2}</color>({3})',name,oper,maxStr,addStr)or
FMT.fmt('{0}：<color=#aae252>{1}{2}</color>',name,oper,maxStr)
widget:SetChildText(0,desc)
end)


local len=#alltsdzCfgs
self.winlua:SetChildLayoutGroupCreateItems(self.previewCreator:getID(),len,function(index)
local widget=self.winlua:GetChildLayoutGroupGridItem(self.previewCreator:getID(),index-1)
local cfg=alltsdzCfgs[index]
local isSelect=self.level==cfg.id
local attr=cfg.attr

widget:SetChildText(0,isSelect and FMT.fmt('<color=#efb150>{0}</color>',cfg.id)or cfg.id)
widget:SetChildText(1,isSelect and FMT.fmt('<color=#efb150>{0}</color>',cfg.shield)or cfg.shield)
for i=1,3 do
local attr=attr[i]
if attr then
local name,val=equipsHelper.getAttr(attr[1],attr[2])
widget:SetChildText(i+1,isSelect and FMT.fmt('<color=#efb150>{0}</color>',val)or val)
else
widget:SetChildText(i+1,'')
end
end
end)
end

