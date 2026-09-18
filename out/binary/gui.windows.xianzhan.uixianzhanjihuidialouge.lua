







def_class("UIXianZhanJiHuiDialouge",UIWindowBase)









function UIXianZhanJiHuiDialouge:bindComponents()

self.backModel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.eventImage=UIImage.get(self,2)
self.bg=UIButton.get(self,3)
self.closeClick=UIButton.get(self,4)
self.resultDesc=UIText.get(self,5)
self.okButton=UIButton.get(self,6)
self.right=UIObject.get(self,7)
self.extraText=UIText.get(self,8)

self.bg:setButtonClick(function()self:onBg()end)

self.closeClick:setButtonClick(function()self:onCloseClick()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIXianZhanJiHuiDialouge:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backModel);self.backModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.eventImage);self.eventImage=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.closeClick);self.closeClick=nil;
_UIObject_release(self.resultDesc);self.resultDesc=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.extraText);self.extraText=nil;
end
















local _this




function UIXianZhanJiHuiDialouge:onLoaded(...)
_this=self
self:bindComponents()

local modelId=2042
self.root:setActive(false)
self.backModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.common_window_enter,false,false,0,function()
timeEventController.delayDo(0.4,function()
if self and not self.isClose then
self.root:setActive(true)
self:playAnimation(1)
self.finishInit=true
end
end)
end)
end


function UIXianZhanJiHuiDialouge:__delete()
_this=nil
self:unbindComponents()
end




function UIXianZhanJiHuiDialouge:onShow(argtable,afterOnloaded)

local imageName="image_shijian_jishi"
self:freshEventImage(imageName)

local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)
local descStr=baseCfg.startJiHuiText or""
local needXyValue=baseCfg.jsUse or 0
local ksMaxCount=baseCfg.ksMax or 0
self.resultDesc:setText(FMT.fmt(descStr,needXyValue,ksMaxCount))
self.extraText:setText(FMT.fmt("消耗<color=#549327>{0}点</color>客商信誉",needXyValue))
end


function UIXianZhanJiHuiDialouge:onHide()

end

function UIXianZhanJiHuiDialouge:freshEventImage(imageName)
self.winlua:SetChildCanvasGroupAlpha(self.eventImage:getID(),0)
self.winlua:SetChildCanvasGroupDOFade(self.eventImage:getID(),1,2,nil)

local abName="ui/windows/xianzhan/sharedtextures/image_shijian_jishi.ab"
self.eventImage:setCSImageSprite(abName,imageName)
end

function UIXianZhanJiHuiDialouge:playAnimation(id)
self.root:setAnimatorInteger('nState',id,true)
end




function UIXianZhanJiHuiDialouge:onCloseClick()
if not self.finishInit then

return
end
self:closeSelf()
end



function UIXianZhanJiHuiDialouge:onOkButton()
if not self.finishInit then

return
end


local nowXyValue=moneyModel.getMoney(eMoneyType.mtXianZhanXinYuZhi)
local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)
local needXyValue=baseCfg.jsUse or 0
if nowXyValue<needXyValue then
local itemName=itemsModel.getName(eMoneyType.mtXianZhanXinYuZhi)
UIManager.error(FMT.fmt('{0}不足',itemName))
gainControl:showGainWin(eMoneyType.mtXianZhanXinYuZhi)
return
end


xianzhanController:req_start_keshang_jishi()


self:onCloseClick()
end

function UIXianZhanJiHuiDialouge:onBg()
self:onCloseClick()
end

