







def_class("tipsChildXMKCItemSlider",UICloneObject)





tipsChildXMKCItemSlider.abName="ui/windows/tips/child/tipschildxmkcitemslider.ab"

tipsChildXMKCItemSlider.assetName="tipsChildXMKCItemSlider"


function tipsChildXMKCItemSlider:bindComponents()

self.desc=UIText.get(self,0)
self.tipsChildXMKCItemSlider=UIObject.get(self,1)
self.selectCntSlider=UIObject.get(self,2)
self.handleImg=UIObject.get(self,3)
self.handleImgCenter=UIObject.get(self,4)
self.selectCntText=UIText.get(self,5)
self.subBtn=UIButton.get(self,6)
self.addBtn=UIButton.get(self,7)
self.maxBtn=UIButton.get(self,8)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.maxBtn:setButtonClick(function()self:onMaxBtn()end)

end


function tipsChildXMKCItemSlider:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.tipsChildXMKCItemSlider);self.tipsChildXMKCItemSlider=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.handleImgCenter);self.handleImgCenter=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.maxBtn);self.maxBtn=nil;
end









function tipsChildXMKCItemSlider:onLoaded(...)
self:bindComponents()
local longPressFunc=function(...)
self:onLongPressBtn(...)
end
self.widget:SetChildLongPress(self.subBtn:getID(),1,longPressFunc,nil)
self.widget:SetChildLongPress(self.addBtn:getID(),2,longPressFunc,nil)
end


function tipsChildXMKCItemSlider:__delete()
self:unbindComponents()
end




function tipsChildXMKCItemSlider:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local attach=data.attach
local formType=data.formType
self.attach=attach
local cfg=cfg_guildconversionconfig_get(itemid)
if cfg then
local maxCnt=cfg.distribution_week_max or 9999
local curCnt=xianmengModel:getkfZHFPData_FPCnt(itemid)
local leftCnt=maxCnt-curCnt

if leftCnt<=0 then
self.widget:SetChildImageRaycast(self.handleImg:getID(),false)
self.widget:SetChildImageRaycast(self.handleImgCenter:getID(),false)
self.widget:SetChildImageRaycast(self.subBtn:getID(),false)
self.widget:SetChildImageRaycast(self.maxBtn:getID(),false)
self.widget:SetChildSliderInit(self.selectCntSlider:getID(),1,0,1,function(value)
self.attach.selectCnt=0
self.selectCntText:setText(0)
self.desc:setText("放入:0/0")
end)
return
end
self.maxSelectCnt=leftCnt

if leftCnt>moneyModel.getMoney(itemid)then
self.maxSelectCnt=moneyModel.getMoney(itemid)
end
else
self.tipsChildXMKCItemSlider:setActive(false)
return
end
self.widget:SetChildImageRaycast(self.handleImg:getID(),true)
self.widget:SetChildImageRaycast(self.handleImgCenter:getID(),true)
self.widget:SetChildImageRaycast(self.subBtn:getID(),true)
self.widget:SetChildImageRaycast(self.maxBtn:getID(),true)
self.attach.selectCnt=attach.cutCnt

local maxCnt=self.maxSelectCnt
local minCount=0
local curSeclet=self.attach.selectCnt

if curSeclet<minCount then
curSeclet=minCount
self.attach.selectCnt=minCount
end
if curSeclet>maxCnt then
curSeclet=maxCnt
self.attach.selectCnt=maxCnt
end





self.widget:SetChildSliderInit(self.selectCntSlider:getID(),curSeclet,minCount,maxCnt,function(value)
self.attach.selectCnt=value
self.selectCntText:setText(value)
self.desc:setText(FMT.fmt("放入:{0}/{1}",value,maxCnt))
end)
end

function tipsChildXMKCItemSlider:onLongPressBtn(id)
if not self.attach.selectCnt or not self.maxSelectCnt then
return
end
if id==1 then
if self.attach.selectCnt<=0 then
return
end
self.attach.selectCnt=self.attach.selectCnt-1
else
if self.attach.selectCnt>=self.maxSelectCnt then
return
end
self.attach.selectCnt=self.attach.selectCnt+1
end
self.widget:SetChildSliderValue(self.selectCntSlider:getID(),self.attach.selectCnt)
end

function tipsChildXMKCItemSlider:onMaxBtn()
self.attach.selectCnt=self.maxSelectCnt
self.widget:SetChildSliderValue(self.selectCntSlider:getID(),self.attach.selectCnt)
end


function tipsChildXMKCItemSlider:onHide()

end

function tipsChildXMKCItemSlider:onSubBtn()

end

function tipsChildXMKCItemSlider:onAddBtn()

end


