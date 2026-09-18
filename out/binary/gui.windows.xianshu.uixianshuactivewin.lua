







def_class("UIXianShuActiveWin",UIWindowBase)









function UIXianShuActiveWin:bindComponents()

self.panelA=UIObject.get(self,0)
self.panelB=UIObject.get(self,1)
self.buyBtnA=UIButton.get(self,2)
self.buyBtnB=UIButton.get(self,3)
self.buyBtnAText=UIText.get(self,4)
self.buyBtnBText=UIText.get(self,5)

self.buyBtnA:setButtonClick(function()self:onBuyBtnA()end)

self.buyBtnB:setButtonClick(function()self:onBuyBtnB()end)



end


function UIXianShuActiveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.panelA);self.panelA=nil;
_UIObject_release(self.panelB);self.panelB=nil;
_UIObject_release(self.buyBtnA);self.buyBtnA=nil;
_UIObject_release(self.buyBtnB);self.buyBtnB=nil;
_UIObject_release(self.buyBtnAText);self.buyBtnAText=nil;
_UIObject_release(self.buyBtnBText);self.buyBtnBText=nil;
end
















local _this




function UIXianShuActiveWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianShuActiveWin:__delete()
self:stopCreate(self.panelA)
self:stopCreate(self.panelB)

self:unbindComponents()
_this=nil
end




function UIXianShuActiveWin:onShow(argtable,afterOnloaded)
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
self.config=cfg
self.rechargeCfg=cfg.recharge_rw

self.rechargeState=0
local rId=UIXianShuControl:getRechargeId()
if rId==self.rechargeCfg[1][1]then
self.rechargeState=1
end

self.rweards=UIXianShuControl:getRewardDataInRange(nil,nil,true)
if self.rechargeState==0 then
self:setPanelA()
self:setPanelB()
else
self.panelA:setActive(false)
self.panelB:setChildAnchoredPosition(Vector2.New(0,0))
self:setPanelB()
end
end


function UIXianShuActiveWin:onHide()

end

function UIXianShuActiveWin:stopCreate(panel)
local widget=panel:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
end

function UIXianShuActiveWin:setRewardList(widget)
local len=#self.rweards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=self.rweards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)
end

function UIXianShuActiveWin:setPanelA()
local widget=self.panelA:getChildWidgetBase()
self:setRewardList(widget)

local buyCfg=self.rechargeCfg[1]

local buyId=buyCfg[1]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,buyId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.buyBtnAText:setText(str)
end

function UIXianShuActiveWin:setPanelB()
local widget=self.panelB:getChildWidgetBase()


local rewards=self.rechargeCfg[3][2]
local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,2,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)

local buyCfg
if self.rechargeState==0 then
buyCfg=self.rechargeCfg[2]
else
buyCfg=self.rechargeCfg[3]
end




local model=self.config.model
local scale=isometricMapSystem:getModelScale(model,true)
widget:SetChildUIModelShowTarget(1,model,scale,nil,eAnimationID.stand)

local buyId=buyCfg[1]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,buyId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.buyBtnBText:setText(str)
end

function UIXianShuActiveWin:showDialog(content,callback,ok,cancel)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext=ok or'确定',
canceltext=cancel or'取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end



function UIXianShuActiveWin:onBuyBtnA()
local isShowReconfirm,contentStr=UIXianShuControl:checkReconfirmBuyTime()
local buyFunc=function()
if not _this then return end
payControl.reqPay(self.rechargeCfg[1][1])
self:onCloseClick()
end
if isShowReconfirm then
self:showDialog(contentStr,buyFunc)
else
buyFunc()
end
end

function UIXianShuActiveWin:onBuyBtnB()
if self.rechargeState==0 then

local buyFunc=function()
if not _this then return end
payControl.reqPay(self.rechargeCfg[2][1])
self:onCloseClick()
end


local isShowReconfirm,contentStr=UIXianShuControl:checkReconfirmBuyTime()
if isShowReconfirm then
self:showDialog(contentStr,buyFunc)
else
buyFunc()
end
else

payControl.reqPay(self.rechargeCfg[3][1])
self:onCloseClick()
end
end

function UIXianShuActiveWin:onCloseClick()
self:closeSelf()
end