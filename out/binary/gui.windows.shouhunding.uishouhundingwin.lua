







def_class("UIShouHunDingWin",UIWindowBase)









function UIShouHunDingWin:bindComponents()

self.background=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.costName=UIText.get(self,2)
self.effect=UIObject.get(self,3)
self.gainBtn=UIButton.get(self,4)
self.helpBtn=UIButton.get(self,5)
self.previewBtn=UIButton.get(self,6)
self.progressBar=UIProgress.get(self,7)
self.refineBtn=UIButton.get(self,8)
self.refineReddot=UIObject.get(self,9)
self.root=UIObject.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gainBtn:setButtonClick(function()self:onGainBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.previewBtn:setButtonClick(function()self:onPreviewBtn()end)

self.refineBtn:setButtonClick(function()self:onRefineBtn()end)



end


function UIShouHunDingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costName);self.costName=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.gainBtn);self.gainBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.previewBtn);self.previewBtn=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.refineBtn);self.refineBtn=nil;
_UIObject_release(self.refineReddot);self.refineReddot=nil;
_UIObject_release(self.root);self.root=nil;
end















local _this=nil
local _effect=20670



function UIShouHunDingWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onShowPrize,self.onShowPrize)

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.background:getID(),true,true,true)
end
self.background:setChildUIModelShowTarget(5782,1,{},eAnimationID.stand)
end


function UIShouHunDingWin:__delete()
self:unbindComponents()
_this=nil
end




function UIShouHunDingWin:onShow(argtable,afterOnloaded)
self:initView()
self:refreshView()
end


function UIShouHunDingWin:onHide()

end




function UIShouHunDingWin:onCloseBtn()
UIFullXJForceControl:closeWindow(self.__name)
end


function UIShouHunDingWin:onGainBtn()
local itemId=shouhundingModel:getDataType()
gainControl:showGainWin(itemId)
end


function UIShouHunDingWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='shouhunding_help_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UIShouHunDingWin:onPreviewBtn()
UIFullXJForceControl:showWindow("UIShouHunDingPreviewWin")
end


function UIShouHunDingWin:onRefineBtn()
local cur=shouhundingModel:getDataValue()
local max=shouhundingModel:getDataMax()
if cur>=max then

shouhundingController:send_37_121()








else
local itemId=shouhundingModel:getDataType()
local itemName=itemsConfig.getItemName(itemId)
UIManager.error(string.format("%s不足，无法炼制",itemName))
end
end

function UIShouHunDingWin:initView()
local itemId=shouhundingModel:getDataType()
local itemName=itemsConfig.getItemName(itemId)
self.costName:setText(string.format("%s：",itemName))
end

function UIShouHunDingWin:refreshView(anim)
local cur=shouhundingModel:getDataValue()
local max=shouhundingModel:getDataMax()
local value=math.min(cur,max)
local str=string.format("%d/%d",cur,max)
if anim then
self.progressBar:setProgress(value,max)
else
self.progressBar:setProgressValue(value,max)
end
self.progressBar:setChildProgressText(str)
self.refineBtn:setChildGraphicGray(cur<max)
self.refineReddot:setActive(cur>=max)
end

function UIShouHunDingWin.on_money_changed(mType)
if shouhundingModel:isDataType(mType)then
_this:refreshView(true)
end
end

function UIShouHunDingWin.onShowPrize(prizeType,prizeList,effectData)
if prizeType==ePrizeType.eShouHunDing then
local duration=cfgHelper.get2(cfg_effectconfig_get,_effect,"lifetime")
duration=duration/1000
_this.effect:setChildShowEffect(_effect,true)
_this.root:setActive(false)
_this:delayDo(duration,function()
if#prizeList>0 then
showPrizeControl.showWindow(prizeList,function()_this.root:setActive(true)end)
else
_this.root:setActive(true)
end
end)
end
end