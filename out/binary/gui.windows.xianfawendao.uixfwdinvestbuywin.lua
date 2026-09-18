







def_class("UIXFWDInvestBuyWin",UIWindowBase)









function UIXFWDInvestBuyWin:bindComponents()

self.bgmodel=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.rwScrollViewA=UIObject.get(self,2)
self.rwScrollViewB=UIObject.get(self,3)
self.cancelBtn=UIButton.get(self,4)
self.payBtn=UIButton.get(self,5)
self.titleBg_1=UIObject.get(self,6)
self.titleBg_2=UIObject.get(self,7)
self.tips=UIText.get(self,8)
self.payBtnText=UIText.get(self,9)
self.jihuoText=UIText.get(self,10)
self.finalText=UIText.get(self,11)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.payBtn:setButtonClick(function()self:onPayBtn()end)
self.titleBg={
self.titleBg_1,
self.titleBg_2,
}



end


function UIXFWDInvestBuyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rwScrollViewA);self.rwScrollViewA=nil;
_UIObject_release(self.rwScrollViewB);self.rwScrollViewB=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.payBtn);self.payBtn=nil;
_UIObject_release(self.titleBg_1);self.titleBg_1=nil;
_UIObject_release(self.titleBg_2);self.titleBg_2=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.payBtnText);self.payBtnText=nil;
_UIObject_release(self.jihuoText);self.jihuoText=nil;
_UIObject_release(self.finalText);self.finalText=nil;
self.titleBg=nil;
end


















local titleType=
{
[2]={ab='ui/windows/activities/sub_act_tianmolu/act_tianmolu_atlas_pak.ab',name='image_tianmolu_14',color='#702988'}
}

function UIXFWDInvestBuyWin:onLoaded(...)
self:bindComponents()

self.rwScrollViewA:setChildScrollViewInit(0.5,true,nil,nil)
self.rwScrollViewB:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXFWDInvestBuyWin:__delete()
self:unbindComponents()
self.payCall=nil
end




function UIXFWDInvestBuyWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
if argtable.bgmodel then
self.bgmodel:setChildUIModelShowTarget(argtable.bgmodel,1,{},eAnimationID.stand,false,false,0.6)
else
self.bgmodel:setChildUIModelShowTarget(4005,1,{},eAnimationID.stand,false,false,0.6)
end
if argtable.bgmodelOffset then
self.bgmodel:setChildUIModelShowTargetOffset(argtable.bgmodelOffset[1],argtable.bgmodelOffset[2])
end
if argtable.titleType and titleType[argtable.titleType]then
for i,titleBg in ipairs(self.titleBg)do
titleBg:setCSImageSprite(titleType[argtable.titleType].ab,titleType[argtable.titleType].name)
end
self.winlua:SetChildColor(self.jihuoText:getID(),Color.StrToColor(titleType[argtable.titleType].color))
self.winlua:SetChildColor(self.finalText:getID(),Color.StrToColor(titleType[argtable.titleType].color))
self.winlua:SetChildColor(self.tips:getID(),Color.StrToColor(titleType[argtable.titleType].color))
end
end
local jhText=argtable.jihuoText or'激活'
self.jihuoText:setText(FMT.fmt("{0}可获得",jhText))
self.rechargeId=argtable.rechargeId
if self.rechargeId then
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,self.rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.payBtnText:setText(FMT.fmt('{0}购买',str))
else
if argtable.confirmText then
self.payBtnText:setText(argtable.confirmText)
end
end

self.title:setText(argtable.title)

local activeRewards=argtable.activeRewards
local totalRewards=argtable.totalRewards

self.payCall=argtable.payCall

local len=#activeRewards
self.rwScrollViewA:setChildScrollViewCreateGrids(len,0)
local grids=self.rwScrollViewA:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=activeRewards[i]
widgetHelper.setNormalRewardItem(item,0,data)
end

self.tips:setText(len>0 and''or FMT.fmt('暂未{0}奖励',jhText))

len=#totalRewards
self.rwScrollViewB:setChildScrollViewCreateGrids(len,0)
grids=self.rwScrollViewB:getChildScrollViewItemWidgets()
count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=totalRewards[i]
widgetHelper.setNormalRewardItem(item,0,data)
end
end


function UIXFWDInvestBuyWin:onHide()

end




function UIXFWDInvestBuyWin:onCancelBtn()
self:onCloseClick()
end

function UIXFWDInvestBuyWin:onPayBtn()
if self.payCall then
self.payCall()
else
payControl.reqPay(self.rechargeId)
end

self:onCloseClick()
end

function UIXFWDInvestBuyWin:onCloseClick()
self:closeSelf()
end