







def_class("UIChildMoneyDetail",UICloneObject)





UIChildMoneyDetail.abName="ui/windows/main/child/uichildmoneydetail.ab"

UIChildMoneyDetail.assetName="UIChildMoneyDetail"


function UIChildMoneyDetail:bindComponents()

self.Text=UIText.get(self,0)
self.icon=UIImage.get(self,1)
self.progressBar=UIProgressBarAni.get(self,2)
self.progressText=UIText.get(self,3)

end


function UIChildMoneyDetail:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressText);self.progressText=nil;
end








function UIChildMoneyDetail:onLoaded(...)
self:bindComponents()
end

function UIChildMoneyDetail:__delete()
self:unbindComponents()
end

function UIChildMoneyDetail:onShow(argtable,afterOnloaded)
local moneyType=argtable
local val=moneyModel.getMoney(moneyType)
local iconname=iconHelper.getIconName(moneyType)
local moneyName=moneyModel.getMoneyName(moneyType)
local max=zongmenModel:getWarehouseLimit(moneyType)
if moneyType==eMoneyType.mtLingPai then
max=moneyModel.getMoneyMax(eMoneyType.mtLingPai)
end
local proText=val<max and val or'满库'

self.icon:setImageIcon(iconname,true)
self.Text:setText(moneyName)
self.progressBar:animateThreeParams(val,max,0)
self.progressText:setText(val)
end

function UIChildMoneyDetail:onHide()

end


