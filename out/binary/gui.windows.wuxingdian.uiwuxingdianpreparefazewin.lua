







def_class("UIWuXingDianPrepareFaZeWin",UIWindowBase)









function UIWuXingDianPrepareFaZeWin:bindComponents()

self.faZeList=UIObject.get(self,0)



end


function UIWuXingDianPrepareFaZeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.faZeList);self.faZeList=nil;
end


















function UIWuXingDianPrepareFaZeWin:onLoaded(...)
self:bindComponents()
end

function UIWuXingDianPrepareFaZeWin:__delete()
self:unbindComponents()
end

function UIWuXingDianPrepareFaZeWin:onShow(argtable,afterOnloaded)
local wxdId=argtable.wxdId
local layer=argtable.layer
local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
local faze_list2=layerCfg.faze_list2
local len=#faze_list2
self.faZeList:setChildScrollViewCreateGrids(len,0)
self.grids=self.faZeList:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local fazeid=faze_list2[i]
local fzRuleCfg=cfgHelper.getSSlawRule(fazeid)
local fzlv=1
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local desc=not hasParam and fzRuleCfg.desc or
string.format(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
item:SetChildIcon(1,fzRuleCfg.image,false)
item:SetChildText(0,desc)
end
end

function UIWuXingDianPrepareFaZeWin:onHide()

end



