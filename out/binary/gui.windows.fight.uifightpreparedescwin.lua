







def_class("UIFightPrepareDescWin",UIWindowBase)









function UIFightPrepareDescWin:bindComponents()

self.descGrid=UIObject.get(self,0)
self.tipsObj=UIObject.get(self,1)
self.tipsTxt=UIText.get(self,2)



end


function UIFightPrepareDescWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descGrid);self.descGrid=nil;
_UIObject_release(self.tipsObj);self.tipsObj=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
end

















function UIFightPrepareDescWin:onLoaded(...)
self:bindComponents()
end


function UIFightPrepareDescWin:__delete()
self:unbindComponents()
end


function UIFightPrepareDescWin:onHide()

end




function UIFightPrepareDescWin:onShow(argtable,afterOnloaded)
local desclist=argtable.desclist
local tips_str=argtable.tips_str
local num=#desclist
self.descGrid:setChildLayoutGroupCreateItems(num)
local grids=self.descGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
item:SetChildText(0,desclist[i])
end
local showTips=tips_str~=nil
self.tipsObj:setActive(showTips)
if showTips then
self.tipsTxt:setText(tips_str)
end
end