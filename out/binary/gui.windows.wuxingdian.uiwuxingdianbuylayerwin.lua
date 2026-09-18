







def_class("UIWuXingDianBuyLayerWin",UIWindowBase)









function UIWuXingDianBuyLayerWin:bindComponents()

self.root=UIObject.get(self,0)
self.cutBtn=UIButton.get(self,1)
self.addBtn=UIButton.get(self,2)
self.countSlider=UIObject.get(self,3)
self.buyBtn=UIButton.get(self,4)
self.des=UIText.get(self,5)
self.scrollView=UIObject.get(self,6)
self.layer=UIText.get(self,7)
self.maxDesc=UIText.get(self,8)
self.title=UIText.get(self,9)
self.needText=UIText.get(self,10)
self.bg=UIObject.get(self,11)
self.needIcon=UIObject.get(self,12)
self.moneyBtn=UIButton.get(self,13)
self.moneyIcon=UIImage.get(self,14)
self.money=UIText.get(self,15)
self.closeBtn=UIButton.get(self,16)
self.handle=UIObject.get(self,17)

self.cutBtn:setButtonClick(function()self:onCutBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIWuXingDianBuyLayerWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.cutBtn);self.cutBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.countSlider);self.countSlider=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.des);self.des=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.maxDesc);self.maxDesc=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.needText);self.needText=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.needIcon);self.needIcon=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.money);self.money=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.handle);self.handle=nil;
end


















function UIWuXingDianBuyLayerWin:onLoaded(...)
self:bindComponents()
end

function UIWuXingDianBuyLayerWin:__delete()
self:unbindComponents()
end

function UIWuXingDianBuyLayerWin:onShow(argtable,afterOnloaded)
self.wxdId=argtable.wxdId
self.index=argtable.index
local index=self.index or 0
self.minIndex=index+1
self.maxIndex=argtable.maxIndex
self.buyIndex=index+1
self:freshInfo()
end

function UIWuXingDianBuyLayerWin:onHide()

end





function UIWuXingDianBuyLayerWin:onCloseBtn()
self:closeSelf()
end

function UIWuXingDianBuyLayerWin:onCutBtn()
if self.buyIndex<=self.minIndex then return end
self.createCount=18
local index=self.buyIndex-1
if index<1 then index=1 end
self.winlua:SetChildSliderValue(self.countSlider:getID(),index)
self.createCount=1
end



function UIWuXingDianBuyLayerWin:onAddBtn()
if self.buyIndex>=self.maxIndex then return end
self.createCount=18
self.winlua:SetChildSliderValue(self.countSlider:getID(),self.buyIndex+1)
self.createCount=1
end



function UIWuXingDianBuyLayerWin:onBuyBtn()
local buyIndex=self.buyIndex
local moneyType=self.moneyType
local needValue=self.costnum

local cfgs=wuXingDianModel:getPrizeCfgs(self.wxdId)
local cfg=cfgs[self.buyIndex]
local layer=cfg.layer
local name=itemsModel.getName(moneyType)
local desc=FMT.fmt('是否花费<color=#ca631d>{0}{1}</color>购买至第<color=#ca631d>{2}</color>层？\n（购买的层数仅对该投资奖励生效，\n不影响圣殿实际通关层数）',needValue,name,layer)

local call=function()
local func=function()
socketManager:send_25_25(layer)
end
UIDialogManager.getConfirmDialog3(nil,desc,func,REPEAT_TYPE.eWXDBuyLayer)
end

moneySystem:useMoney(moneyType,needValue,call,WARNING_TYPE.eWarning)
end



function UIWuXingDianBuyLayerWin:onMoneyBtn()
gainControl:showGainWin(self.moneyType)
end

function UIWuXingDianBuyLayerWin:freshInfo()
local index=self.index
local minIndex=self.minIndex
local maxIndex=self.maxIndex
local curIndex=minIndex
local enable=maxIndex~=minIndex
if not enable then
minIndex=maxIndex-1
curIndex=maxIndex
end
self.winlua:SetChildImageRaycast(self.handle:getID(),enable)
self.winlua:SetChildSliderInit(self.countSlider:getID(),curIndex,minIndex,maxIndex,function(val)
if val~=self.buyIndex then
self.buyIndex=val
self:freshBuyInfo()
end
end)
self:freshBuyInfo()
end

function UIWuXingDianBuyLayerWin:freshBuyInfo()
local index=self.index
local minIndex=self.minIndex
local maxIndex=self.maxIndex
local wxdId=self.wxdId
local cfgs=wuXingDianModel:getPrizeCfgs(wxdId)
local cfg=cfgs[self.buyIndex]
local layer=cfg.layer
self.createCount=1

local isMax=self.buyIndex>=self.maxIndex

self.winlua:SetChildScrollViewStopGridCreate(self.scrollView:getID())

self.winlua:SetChildScrollViewCreateGrids(self.scrollView:getID(),0,0)

local datas,costnum=wuXingDianModel:getSDBuyPrize(self.index,self.buyIndex)
table.sort(datas,function(a,b)
local color_a=itemsConfig.getConfig(a[1]).color
local color_b=itemsConfig.getConfig(b[1]).color
return color_a*10000+a[1]/10000>color_b*10000+b[1]/10000
end)
self.costnum=costnum
local len=#datas
self.winlua:SetChildScrollViewDelayCreateGrids(self.scrollView:getID(),len,0,0.02,self.createCount,false,false,function(i,item)
local data=datas[i+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)

local moneyType=cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'money_id')
self.moneyType=moneyType
local have=moneyModel.getMoney(moneyType)
local str=have>=costnum and costnum or FMT.fmt('<color=red>{0}</color>',costnum)
self.needText:setText(str)

self.money:setText(mathHelper.formatNumber(have))

self.moneyIcon:setIcon(iconHelper.getIconName(moneyType),false)

self.needIcon:setIcon(iconHelper.getIconName(moneyType),false)

self.des:setText(FMT.fmt('圣殿层数购买至 <color=#ca631d>{0}</color> 层，可获得以下奖励\n',layer))

self.layer:setText(FMT.fmt('购买至 <color=#ca631d>{0}</color> 层',layer))

self.maxDesc:setActive(false)
end

