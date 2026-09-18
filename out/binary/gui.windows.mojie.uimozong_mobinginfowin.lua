







def_class("UIMoZong_moBingInfoWin",UIWindowBase)









function UIMoZong_moBingInfoWin:bindComponents()

self.mask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.Content=UIObject.get(self,2)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIMoZong_moBingInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.Content);self.Content=nil;
end



















function UIMoZong_moBingInfoWin:onLoaded(...)
self:bindComponents()
end


function UIMoZong_moBingInfoWin:__delete()
self:unbindComponents()
end




function UIMoZong_moBingInfoWin:onShow(argtable,afterOnloaded)
local soldierList=argtable.soldierList or{}
local maxLookup=argtable.maxLookup
self.Content:setChildLayoutGroupCreateItems(#soldierList,function(index)
local item=self.Content:getChildLayoutGroupGridItem(index-1)
local data=soldierList[index]
local jzLv=data.param_1
local num=data.param_2
local cfg=cfgHelper.get(cfg_jzconfig_get,jzLv)
local name=cfg.name
item:SetChildText(0,name)
local max=maxLookup[jzLv]
item:SetChildUIProgressbar(1,num,max,false)
item:SetChildText(2,FMT.fmt("{0}/{1}",num,max))
end)
end


function UIMoZong_moBingInfoWin:onHide()

end





function UIMoZong_moBingInfoWin:onMask()
self:closeSelf()
end

