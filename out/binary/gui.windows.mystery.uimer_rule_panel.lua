







def_class("UIMER_Rule_Panel",UIWindowBase)









function UIMER_Rule_Panel:bindComponents()

self.rulePanel=UIObject.get(self,0)



end


function UIMER_Rule_Panel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rulePanel);self.rulePanel=nil;
end


















local ruleList


function UIMER_Rule_Panel:onLoaded(...)
self:bindComponents()
end


function UIMER_Rule_Panel:__delete()
self:unbindComponents()
end




function UIMER_Rule_Panel:onShow(argtable,afterOnloaded)
if argtable then
ruleList=argtable.ruleList
end
self:showRulePanel()
end


function UIMER_Rule_Panel:onHide()

end

function UIMER_Rule_Panel:showRulePanel()
if ruleList then
self.rulePanel:setChildScrollViewCreateGrids(#ruleList,1)
local grids=self.rulePanel:getChildScrollViewItemWidgets()
for i,v in ipairs(ruleList)do
local item=grids[i-1]
if item then
local ruleCfg=cfgHelper.getSSlawRule(v)
local image=ruleCfg.image
local desc=ruleCfg.desc
item:SetChildText(1,desc)
item:SetChildCSImageIcon(2,image,false)
end
end
end
end



