







def_class("tipsChildItemNumSelect",UICloneObject)





tipsChildItemNumSelect.abName="ui/windows/tips/child/tipschilditemnumselect.ab"

tipsChildItemNumSelect.assetName="tipsChildItemNumSelect"


function tipsChildItemNumSelect:bindComponents()

self.addBtn=UIButton.get(self,0)
self.handleImg=UIObject.get(self,1)
self.maxCnt=UIButton.get(self,2)
self.moneyIcon=UIImage.get(self,3)
self.moneyText=UIText.get(self,4)
self.num=UIText.get(self,5)
self.selectCntText=UIText.get(self,6)
self.slider=UIObject.get(self,7)
self.sliderPanel=UIObject.get(self,8)
self.subBtn=UIButton.get(self,9)
self.tips=UIObject.get(self,10)
self.tips2=UIObject.get(self,11)
self.tipsText=UIText.get(self,12)
self.tipsText2=UIText.get(self,13)
self.tipsTitleText2=UIText.get(self,14)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

end


function tipsChildItemNumSelect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyText);self.moneyText=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.slider);self.slider=nil;
_UIObject_release(self.sliderPanel);self.sliderPanel=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tips2);self.tips2=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.tipsText2);self.tipsText2=nil;
_UIObject_release(self.tipsTitleText2);self.tipsTitleText2=nil;
end








function tipsChildItemNumSelect:onLoaded(...)
self:bindComponents()
end

function tipsChildItemNumSelect:__delete()
self:unbindComponents()
end

function tipsChildItemNumSelect:onShow(argtable,afterOnloaded)
local attach=argtable.argtable.attach
self.attach=attach
local isClose=attach.closeSelectNum
if isClose then
self:onSelect(1)
self:recycleSelf()
return
end
local args=attach.selectNumCmpArgs
self.numFormat=args.numFormat or'放入：<color=#f1ce78>{0}/{1}</color>'
self.moneyData=args.moneyData
self.tipStr=args.tips
self.tipTotleStr2=args.tipsTitle2
self.tipStr2=args.tips2
self.onSelectValue=args.onSelectValue
local min=args.min or 0
local max=args.max or 1
local cur=args.val or 1
local lock=args.lock
self.min=min
self.max=max
self.val=cur
self.lock=lock
self.widget:SetChildImageRaycast(self.handleImg:getID(),not lock)
self.widget:SetChildSliderInit(self.slider:getID(),self.val,self.min,self.max,function(val)
self.val=val
self:onSelect(self.val)
self:freshInfo()
end)
self:freshInfo()
self:onSelect(self.val)
end

function tipsChildItemNumSelect:onHide()

end



function tipsChildItemNumSelect:freshInfo()
self.num:setText(FMT.fmt(self.numFormat,self.val,self.max))
self.selectCntText:setText(self.val)


local isShowMoney=self.moneyData~=nil
self.moneyText:setActive(isShowMoney)
if isShowMoney then
local moneyType=self.moneyData.moneyType
local moneyCount=self.val>0 and self.moneyData.cost*self.val or self.moneyData.cost

self.moneyIcon:setChildIcon(iconHelper.getIconName(moneyType),false)
local moneyCountStr=moneyCount
if self.moneyData.isCheck then

if not moneyModel.checkEnoughMoney(moneyType,moneyCount)then
moneyCountStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}",moneyCount)
end
end

self.moneyText:setText(moneyCountStr)
end


local isShowTips=self.tipStr~=nil
self.tips:setActive(isShowTips)
if isShowTips then
self.tipsText:setText(self.tipStr)
end


local isShowTips2=self.tipStr2~=nil
self.tips2:setActive(isShowTips2)
if isShowTips2 then
self.tipsTitleText2:setText(self.tipTitleStr2 or"兑换详情")
self.tipsText2:setText(self.tipStr2)
end


local isShowSliderPanel=true
if self.max<=1 and not self.attach.selectNumCmpArgs.mustShow then
isShowSliderPanel=false
end
self.sliderPanel:setActive(isShowSliderPanel)
end

function tipsChildItemNumSelect:onSubBtn()
if self.lock or self.val<=self.min then return end
self.val=self.val-1
self:freshInfo()
self.widget:SetChildSliderValue(self.slider:getID(),self.val)
self:onSelect(self.val)

end

function tipsChildItemNumSelect:onAddBtn()
if self.lock or self.val>=self.max then return end
self.val=self.val+1
self.widget:SetChildSliderValue(self.slider:getID(),self.val)
self:onSelect(self.val)
self:freshInfo()
end

function tipsChildItemNumSelect:onMaxCnt()
if self.lock or self.val>=self.max then return end
self.val=self.max
self.widget:SetChildSliderValue(self.slider:getID(),self.val)
self:onSelect(self.val)
self:freshInfo()
end

function tipsChildItemNumSelect:onSelect(num)
tipsManager.setTipsAttachTableArgs(self.attach,{'selectNumCmpArgs','selectNum'},num)
if self.onSelectValue then
self.onSelectValue(num)
end
end
