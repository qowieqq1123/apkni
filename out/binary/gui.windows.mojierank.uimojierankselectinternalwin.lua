







def_class("UIMoJieRankSelectInternalWin",UIWindowBase)









function UIMoJieRankSelectInternalWin:bindComponents()

self.closebtn=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.selectList=UIObject.get(self,2)

self.closebtn:setButtonClick(function()self:onClosebtn()end)



end


function UIMoJieRankSelectInternalWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectList);self.selectList=nil;
end


















local abname='ui/windows/mojierank/mojierank_atlas_pak.ab'

function UIMoJieRankSelectInternalWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieRankSelectInternalWin:__delete()
self:unbindComponents()
end




function UIMoJieRankSelectInternalWin:onShow(argtable,afterOnloaded)
local rankType=argtable.rankType
self:refresh(rankType)
end


function UIMoJieRankSelectInternalWin:onHide()

end





function UIMoJieRankSelectInternalWin:onClosebtn()
end

function UIMoJieRankSelectInternalWin:refresh(rankType)
local NowShowRank=xianjieController:GetShowRank()
for k,v in ipairs(NowShowRank)do
if k==rankType then
table.remove(NowShowRank,k)
end
end
local cnt=#NowShowRank

self.selectList:setChildLayoutGroupCreateItems(cnt)
local grids=self.selectList:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]


item:SetChildCSImageSprite(-1,abname,NowShowRank[i].uiname)
item:SetChildButtonClick(3,function()


xianjieController.ShowRank[rankType].closefunction()
NowShowRank[i].openfunction()

end)

end
end