







def_class("UIStorageUnlockWin",UIWindowBase)









function UIStorageUnlockWin:bindComponents()

self.desc=UIText.get(self,0)
self.cost=UIBaseItem.get(self,1)
self.btnUnlock=UIButton.get(self,2)

self.btnUnlock:setButtonClick(function()self:onBtnUnlock()end)



end


function UIStorageUnlockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.btnUnlock);self.btnUnlock=nil;
end



















function UIStorageUnlockWin:onLoaded(...)
self:bindComponents()
end


function UIStorageUnlockWin:__delete()
self:unbindComponents()
end




function UIStorageUnlockWin:onShow(argtable,afterOnloaded)
local cfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
local costItem=cfg.item_collect_build_cnt[1]
local itemCfg=itemsConfig.getConfig(costItem[1])
self.desc:setText(string.format('使用%s获得无限收纳空间',itemCfg.name))


local itemId=costItem[1]
local need=costItem[2]








widgetHelper.setNormalRewardItem(self.winlua,self.cost:getID(),{itemId,need,checkAmount=true})
self.costItem=itemId
end


function UIStorageUnlockWin:onHide()

end



function UIStorageUnlockWin:onBtnUnlock()
local itemCount=bagModel.getItemCountById(self.costItem)
if itemCount>0 then
zongmenControl:reqBuyStorageNum(1)
self:onCloseClick()
else
UIManager.error('道具不足')
gainControl:showGainWin(self.costItem)
end
end

function UIStorageUnlockWin:onCloseClick()
self:closeSelf()
end