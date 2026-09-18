







def_class("UIYunJiaYing_extraAddWin",UIWindowBase)









function UIYunJiaYing_extraAddWin:bindComponents()

self.mask=UIButton.get(self,0)
self.scrollView=UIObject.get(self,1)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIYunJiaYing_extraAddWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end
















local _this




function UIYunJiaYing_extraAddWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIYunJiaYing_extraAddWin:__delete()
_this=nil
self:unbindComponents()
end




function UIYunJiaYing_extraAddWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIYunJiaYing_extraAddWin:onHide()

end

function UIYunJiaYing_extraAddWin:refresh()


local gainCfgList=self:getCanSelectGainCfgList()
self.scrollView:setChildScrollViewCreateGrids(#gainCfgList,1)
local grids=self.scrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local gainCfg=gainCfgList[i]
if gainCfg then
widget:SetChildActive(-1,true)

local name=gainCfg.title or"未知途径"
widget:SetChildText(0,name)


local desc=gainCfg.desc or""
widget:SetChildText(1,desc)


local gainType=gainCfg.type
widget:SetChildActive(2,gainType~=nil)
if gainType then
widget:SetChildButtonClick(2,function()
return self:onClickGotoBtn(gainType)
end,true)
end
else
widget:SetChildActive(-1,false)
end
end
end

function UIYunJiaYing_extraAddWin:getCanSelectGainCfgList()
local cfg=cfgHelper.get(cfg_yunjiayingbaseconfig_get,1)
local gainCfgList=cfg.extraGain or{}
local list={}
for i,v in ipairs(gainCfgList)do
local gainType=v.type
local isSellOut=false
if gainType==1 then

local moneyList=cfgHelper.getdef(cfg_yunjiayingconfig,'money')or{}
local moneyNum=yunjiayingModel:getMoneyNum()or 0
if not moneyList[moneyNum+1]then
isSellOut=true
end
elseif gainType==2 then

local rechargeList=cfgHelper.getdef(cfg_yunjiayingconfig,'recharge')or{}
local rechargeNum=yunjiayingModel:getRechargeNum()or 0
if not rechargeList[rechargeNum+1]then
isSellOut=true
end
end

if not isSellOut then
list[#list+1]=v
end
end
return list
end




function UIYunJiaYing_extraAddWin:onMask()
end



function UIYunJiaYing_extraAddWin:onClickGotoBtn(gainType)
if gainType==1 then

local moneyList=cfgHelper.getdef(cfg_yunjiayingconfig,'money')or{}
local moneyNum=yunjiayingModel:getMoneyNum()or 0
local price=moneyList[moneyNum+1]
if not price then
logErr(FMT.fmt("找不到货币购买类型第{0}次对应的消耗配置",moneyNum))
return
end
local priceMoneyType=price[1][1]
local priceMoneyCount=price[1][2]
local moneyName=moneyModel.getMoneyName(priceMoneyType)
local content=FMT.fmt("是否花费<color=#549327>{0}</color>{1}\n永久解锁1个训练计划栏",mathHelper.formatNumber(priceMoneyCount),moneyName)
local okCallback=function()
moneySystem:useMoney(priceMoneyType,priceMoneyCount,function()
yunjiayingController:reqBuyExtraTrainCountByMoney(1)
UIManager:closeWindow('UICommonPageWin')
end,WARNING_TYPE.eWarning)
end









local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=okCallback,
showclosebtn=true,
moneytypes={{priceMoneyType}},
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
elseif gainType==2 then

UIManager.error("暂无对应活动")
end
end

