







def_class("UIXiaoZhuShou_XianWuLou_SetupWin",UIWindowBase)









function UIXiaoZhuShou_XianWuLou_SetupWin:bindComponents()

self.item1Obj=UIButton.get(self,0)
self.item2Obj=UIButton.get(self,1)
self.root=UIObject.get(self,2)

self.item1Obj:setButtonClick(function()self:onItem1Obj()end)

self.item2Obj:setButtonClick(function()self:onItem2Obj()end)



end


function UIXiaoZhuShou_XianWuLou_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.item1Obj);self.item1Obj=nil;
_UIObject_release(self.item2Obj);self.item2Obj=nil;
_UIObject_release(self.root);self.root=nil;
end

















function UIXiaoZhuShou_XianWuLou_SetupWin:onLoaded(...)
self:bindComponents()
self.itemWidget1=self.item1Obj:getWidgetBase()
self.itemWidget2=self.item2Obj:getWidgetBase()
end


function UIXiaoZhuShou_XianWuLou_SetupWin:__delete()
self:unbindComponents()
end


function UIXiaoZhuShou_XianWuLou_SetupWin:onHide()

end




function UIXiaoZhuShou_XianWuLou_SetupWin:onShow(argtable,afterOnloaded)
self.orderID=XIAOZHUSHU_ENUM.xzs_XianWuLou
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local typo=setupData[xzsDataKey.xwlAutoSubmitType]or 2
local selects={}
selects[1]=bitHelper.check_pos(typo,0)
selects[2]=bitHelper.check_pos(typo,1)
self.selects=selects
self:updateView()
end

function UIXiaoZhuShou_XianWuLou_SetupWin:updateView()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)

local tjGoods=xianmengModel:getTJGoods()
local itemid
if tjGoods then
local goodid=tjGoods[1]
local goodcfg=cfgHelper.get1(cfg_xianwuloutijiaowupinconfig_get,goodid)
itemid=goodcfg.item[1]
else
itemid=eMoneyType.mtTieKuang
end
local flag=self.selects[1]
self.itemWidget1:SetChildCSImageIcon(0,iconHelper.getIconName(itemid),true)
self.itemWidget1:SetChildText(1,'非灵玉材料')
self.itemWidget1:SetChildActive(2,flag)

local moneyType=eMoneyType.mtLingYu
flag=self.selects[2]
self.itemWidget2:SetChildCSImageIcon(0,iconHelper.getIconName(moneyType),true)
self.itemWidget2:SetChildText(1,itemsConfig.getItemName(moneyType))
self.itemWidget2:SetChildActive(2,flag)
end

function UIXiaoZhuShou_XianWuLou_SetupWin:onItem1Obj()
self:refreshSelect()
end

function UIXiaoZhuShou_XianWuLou_SetupWin:onItem2Obj()
self:refreshSelect()
end

function UIXiaoZhuShou_XianWuLou_SetupWin:refreshSelect()

local flag=not self.selects[1]
self.selects[1]=flag
self.itemWidget1:SetChildActive(2,flag)

flag=not flag
self.selects[2]=flag
self.itemWidget2:SetChildActive(2,flag)

self:refreshSetup()
end

function UIXiaoZhuShou_XianWuLou_SetupWin:refreshSetup()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local typo=0
if self.selects[1]then
typo=bitHelper.set_1(typo,0)
else
typo=bitHelper.set_0(typo,0)
end
if self.selects[2]then
typo=bitHelper.set_1(typo,1)
else
typo=bitHelper.set_0(typo,1)
end
setupData[xzsDataKey.xwlAutoSubmitType]=typo
end