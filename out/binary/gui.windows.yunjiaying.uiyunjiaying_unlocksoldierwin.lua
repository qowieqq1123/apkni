







def_class("UIYunJiaYing_unlockSoldierWin",UIWindowBase)









function UIYunJiaYing_unlockSoldierWin:bindComponents()

self.mask=UIButton.get(self,0)
self.titleIcon=UIImage.get(self,1)
self.soldierModel=UIObject.get(self,2)
self.bgModel=UIObject.get(self,3)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIYunJiaYing_unlockSoldierWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.titleIcon);self.titleIcon=nil;
_UIObject_release(self.soldierModel);self.soldierModel=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end



















function UIYunJiaYing_unlockSoldierWin:onLoaded(...)
self:bindComponents()
end


function UIYunJiaYing_unlockSoldierWin:__delete()
self:unbindComponents()
end




function UIYunJiaYing_unlockSoldierWin:onShow(argtable,afterOnloaded)
self.bgModel:setChildUIModelShowTarget(6238,1,nil,eAnimationID.enter)
local unlockSoldierIdx=argtable.soldierIdx
local soldierCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,unlockSoldierIdx)
local iconName=soldierCfg.nameIcon4
local iconAb="ui/windows/yunjiaying/yunjiaying_unlock_atlas_pak.ab"
self.titleIcon:setSprite(iconAb,iconName)


local jzCfg=cfgHelper.get(cfg_jzconfig_get,unlockSoldierIdx)
local abName=jzCfg.uiModel
local percent=0.8
local maxShowNum=30
self.winlua:SetChildTroop(self.soldierModel:getID(),abName,maxShowNum,percent,function()
return
end)
end


function UIYunJiaYing_unlockSoldierWin:onHide()

end





function UIYunJiaYing_unlockSoldierWin:onMask()
self:closeSelf()
end

