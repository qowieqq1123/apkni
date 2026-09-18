







def_class("UIShopSettingWin",UIWindowBase)









function UIShopSettingWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.applyBtn=UIButton.get(self,1)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)



end


function UIShopSettingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
end
















local _format=string.format




function UIShopSettingWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIShopSettingWin:__delete()
local consumeRateDatas=UIShopModel:getConsumeRateDatas()
for k,v in pairs(self.changeRecord)do
if v~=consumeRateDatas[k]then
UIShopControl:reqSetConsumeRate(k,v)
end
end

self:unbindComponents()
end




function UIShopSettingWin:onShow(argtable,afterOnloaded)
self.changeRecord={}
local consumeRateDatas=UIShopModel:getConsumeRateDatas()
local limit=zongmenModel:getWarehouseAllLimitList()
self.scrollview:setChildScrollViewCreateGrids(#limit,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local key=limit[i][1]
local value=limit[i][2]
local cfg=moneyModel.getMoneyConfig(key)
local have=moneyModel.getMoney(key)
item:SetChildIcon(0,iconHelper.getIconName(key),true)
item:SetChildText(1,cfg.name)
if have>value then
item:SetChildText(2,_format('<color=red>%s/%s</color>',have,value))
else
item:SetChildText(2,_format('%s / %s',have,value))
end
local dval=consumeRateDatas[key]
item:SetChildSliderInit(3,dval,0,100,function(val)
item:SetChildText(4,_format('%s%%',val))
self.changeRecord[key]=val
end)
end
end


function UIShopSettingWin:onHide()

end



function UIShopSettingWin:onApplyBtn()






self:onCloseClick()
end

function UIShopSettingWin:onCloseClick()
self:closeSelf()
end