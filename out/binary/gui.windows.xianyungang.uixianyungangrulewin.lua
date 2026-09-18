







def_class("UIXianYunGangRuleWin",UIWindowBase)









function UIXianYunGangRuleWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.descRoot=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.title=UIText.get(self,3)



end


function UIXianYunGangRuleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.descRoot);self.descRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIXianYunGangRuleWin:onLoaded(...)
self:bindComponents()
end


function UIXianYunGangRuleWin:__delete()
self:unbindComponents()
local cb=self.closeCB
if cb then
cb()
end
end


function UIXianYunGangRuleWin:onHide()

end




function UIXianYunGangRuleWin:onShow(argtable,afterOnloaded)

local showBlack=argtable.showBlack
if showBlack==nil then showBlack=false end
self.blackBG:setActive(showBlack)

self.closeCB=argtable.closeCB
self.title:setText(argtable.title or'兵力上限详情')
self.desclist=argtable.datas
self:refreshDesc()


local moveSortOrder=argtable.moveSortOrder
if moveSortOrder then
local pos=self:getChildCanvas(-1)
self:setChildCanvas(-1,pos[1],pos[2]+moveSortOrder)
end

self.root:setChildCanvasGroupAlpha(0)
local tween=self.root:setChildCanvasGroupDOFade(1,0.5)
tween:SetDelay(0.25)
end

function UIXianYunGangRuleWin:refreshDesc()
if self.desclist==nil then return end
local c=#self.desclist
if c<=0 then return end
self.descRoot:setChildLayoutGroupCreateItems(c)
local gridlist=self.descRoot:getChildLayoutGroupGridList()
for i=1,c do
local item=gridlist[i-1]
item:SetChildText(0,self.desclist[i].desc)
item:SetChildText(1,self.desclist[i].value)
end
end