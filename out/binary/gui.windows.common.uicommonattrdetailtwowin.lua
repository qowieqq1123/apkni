







def_class("UICommonAttrDetailTwoWin",UIWindowBase)









function UICommonAttrDetailTwoWin:bindComponents()

self.attrCreater=UIObject.get(self,0)
self.contentRoot=UIObject.get(self,1)



end


function UICommonAttrDetailTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrCreater);self.attrCreater=nil;
_UIObject_release(self.contentRoot);self.contentRoot=nil;
end



















function UICommonAttrDetailTwoWin:onLoaded(...)
self:bindComponents()
end


function UICommonAttrDetailTwoWin:__delete()
self:unbindComponents()
end




function UICommonAttrDetailTwoWin:onShow(argtable,afterOnloaded)
self.attrLookup=argtable.attrLookup
self.attrlist=argtable.attrlist

self:RefreshAttrList(true)

self.contentRoot:setChildCanvasGroupAlpha(0)
local func=function()
self.contentRoot:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.1,func)
end


function UICommonAttrDetailTwoWin:onHide()

end

function UICommonAttrDetailTwoWin:RefreshAttrList(isInit)

if self.attrlist==nil then
local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
self.attrlist=UIDiscipleModel.getAttrListByType(self.attrLookup,attrsBase)
end
local c=#self.attrlist
if isInit then
self.attrCreater:setChildLayoutGroupCreateItems(c)
end
local gridlist=self.attrCreater:getChildLayoutGroupGridList()
for i=1,c do
local item=gridlist[i-1]
local attr=self.attrlist[i]
local attr_v=attr[2]
if attr_v<0 then
attr_v=0
end
item:SetChildText(0,cfgHelper.get2(cfg_attributesconfig_get,attr[1],'attrname'))
item:SetChildText(1,helper.getAttributeStrEx(attr[1],attr_v))
end
end




