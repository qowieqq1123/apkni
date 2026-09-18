







def_class("UIMoJieRankSelectWin",UIWindowBase)









function UIMoJieRankSelectWin:bindComponents()

self.GridRoot=UIObject.get(self,0)
self.leftJianTou=UIButton.get(self,1)
self.rightJianTou=UIButton.get(self,2)
self.Scroll_View=UIObject.get(self,3)

self.leftJianTou:setButtonClick(function()self:onLeftJianTou()end)

self.rightJianTou:setButtonClick(function()self:onRightJianTou()end)



end


function UIMoJieRankSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.GridRoot);self.GridRoot=nil;
_UIObject_release(self.leftJianTou);self.leftJianTou=nil;
_UIObject_release(self.rightJianTou);self.rightJianTou=nil;
_UIObject_release(self.Scroll_View);self.Scroll_View=nil;
end



















local _this=nil
local abName="ui/windows/mojierank/mojierank_atlas_pak.ab"
function UIMoJieRankSelectWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIMoJieRankSelectWin:__delete()
self:unbindComponents()
end




function UIMoJieRankSelectWin:onShow(argtable,afterOnloaded)
local NowShowRank=xianjieController:GetShowRank()

local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]-1
self:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,sortOrder=sortOrder})
local cfg=NowShowRank
self.gridLen=#NowShowRank
if self.gridLen<4 then
self.leftJianTou:setActive(false)
self.rightJianTou:setActive(false)
end
self.GridRoot:setChildLayoutGroupCreateItems(#cfg,function(id)
local item=self.GridRoot:getChildLayoutGroupGridItem(id-1)
local config=cfg[id]
local index=id
item:SetChildButtonClick(0,function(...)
NowShowRank[id].openfunction()
UIManager:closeWindow("UIMoJieRankSelectWin")
end)

item:SetChildCSImageSprite(0,abName,NowShowRank[id].uinamebig)







local check=false
item:SetChildActive(3,check)
item:SetChildGraphicGray(0,check)
end)
end


function UIMoJieRankSelectWin:onHide()

end


function UIMoJieRankSelectWin:onClosebtn()
UIManager:closeWindow("UIMoJieRankSelectWin")
end



