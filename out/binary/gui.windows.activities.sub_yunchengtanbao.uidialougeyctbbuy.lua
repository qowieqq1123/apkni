







def_class("UIDialougeYCTBbuy",UIWindowBase)









function UIDialougeYCTBbuy:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.handleImg=UIObject.get(self,1)
self.subBtn=UIButton.get(self,2)
self.addBtn=UIButton.get(self,3)
self.selectCntText=UIText.get(self,4)
self.titleText=UIText.get(self,5)
self.sliderRoot=UIObject.get(self,6)
self.selectCntSlider=UIObject.get(self,7)
self.lyitem=UIObject.get(self,8)
self.lynum=UIText.get(self,9)
self.lybtn=UIButton.get(self,10)
self.lycosttxt=UIText.get(self,11)
self.lytitle=UIText.get(self,12)
self.lysynum=UIText.get(self,13)
self.layout1=UIObject.get(self,14)
self.layout2=UIObject.get(self,15)
self.zgbtn=UIButton.get(self,16)
self.zgtxt=UIText.get(self,17)
self.zgtitle=UIText.get(self,18)
self.zgsynum=UIText.get(self,19)
self.cosicon=UIImage.get(self,20)
self.fullzg=UIObject.get(self,21)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.lybtn:setButtonClick(function()self:onLybtn()end)

self.zgbtn:setButtonClick(function()self:onZgbtn()end)



end


function UIDialougeYCTBbuy:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.lyitem);self.lyitem=nil;
_UIObject_release(self.lynum);self.lynum=nil;
_UIObject_release(self.lybtn);self.lybtn=nil;
_UIObject_release(self.lycosttxt);self.lycosttxt=nil;
_UIObject_release(self.lytitle);self.lytitle=nil;
_UIObject_release(self.lysynum);self.lysynum=nil;
_UIObject_release(self.layout1);self.layout1=nil;
_UIObject_release(self.layout2);self.layout2=nil;
_UIObject_release(self.zgbtn);self.zgbtn=nil;
_UIObject_release(self.zgtxt);self.zgtxt=nil;
_UIObject_release(self.zgtitle);self.zgtitle=nil;
_UIObject_release(self.zgsynum);self.zgsynum=nil;
_UIObject_release(self.cosicon);self.cosicon=nil;
_UIObject_release(self.fullzg);self.fullzg=nil;
end

















local _this


function UIDialougeYCTBbuy:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDialougeYCTBbuy:__delete()
self:unbindComponents()
self:closeWindow('UITopMoneyWin2')

self.selectCnt=nil
self.max=nil
_this=nil
end




function UIDialougeYCTBbuy:onShow(argtable,afterOnloaded)
if argtable then
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid
self.parentwin=argtable.parentwin

self.titleText:setText("获取途径")

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.actHandle=get_activitiesHandle2(self.subType)























local buy_dice_times=_this.config.buy_dice_times
local costid=buy_dice_times[1][2][1]
local iconName=iconHelper.getIconName(costid)
self.winlua:SetChildIcon(self.cosicon:getID(),iconName,false)


local buy_get_items=_this.config.buy_get_items
local itemID=buy_get_items[1]
self.itemIDnum=buy_get_items[2]
if itemID then
local widget=self.lyitem:getWidgetBase()
local itemid=itemID
local countStr=''
local showCountBG=false
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end

local moneytypes={{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}}
if moneytypes then

self:showWindow("UITopMoneyWin2",{moneys={{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}},offsetX=90,offsetY=-25})
else
self:closeWindow('UITopMoneyWin2')
end


self:refreshInfo()


self:refreshZhigou()
end
end


function UIDialougeYCTBbuy:refreshInfo()



_this.canbuy=false
local limitNum=_this.config.buy_times_limit
local lynum,zgnum=self.actHandle:getBuyNum(_this.actID,_this.subType,_this.subid)

local buy_dice_times=_this.config.buy_dice_times
local costid=buy_dice_times[1][2][1]

local num2=moneyModel.getMoney(eMoneyType.mtXianYu)
local num3=moneyModel.getMoney(costid)
local num=num2+num3

local systr=""
if limitNum>0 then
local _num=limitNum-lynum
if _num<=0 then
_num=0
end
systr=FMT.fmt("剩余购买次数：{0}",_num)
end
_this.lysynum:setText(systr)


if limitNum==0 then
local costItemNum=0
local buynum=0

local idx=0
local isfull=false
for k,v in ipairs(buy_dice_times)do
if isfull then
break
end
for i=idx+1,v[1]do
if lynum<i then
local cost=v[2][2]
if costItemNum<=num then
costItemNum=costItemNum+cost
buynum=buynum+1
else
isfull=true
break
end
end
end
idx=v[1]
end

if costItemNum<num and buynum<99 then
local cost=buy_dice_times[#buy_dice_times][2][2]
for i=1,99 do
if costItemNum<=num or buynum<=99 then
costItemNum=costItemNum+cost
buynum=buynum+1
end
end
end
if buynum==0 then
_this.min=1
_this.max=1
_this.selectCnt=_this.min
local func=function(...)
_this:onSliderChange(...)
end
_this.winlua:SetChildImageRaycast(_this.handleImg:getID(),_this.max>_this.min)
_this.winlua:SetChildSliderInit(_this.selectCntSlider:getID(),_this.selectCnt,_this.min,_this.max,func)
_this.winlua:SetChildSliderValue(_this.selectCntSlider:getID(),_this.selectCnt)
else
_this.canbuy=true
_this.min=1
_this.max=99
if buynum<99 then
_this.max=buynum
end
_this.selectCnt=_this.min
local func=function(...)
_this:onSliderChange(...)
end
_this.winlua:SetChildImageRaycast(_this.handleImg:getID(),_this.max>_this.min)
_this.winlua:SetChildSliderInit(_this.selectCntSlider:getID(),_this.selectCnt,_this.min,_this.max,func)
_this.winlua:SetChildSliderValue(_this.selectCntSlider:getID(),_this.selectCnt)
end
else
local canbuy=limitNum-lynum
if canbuy>0 then
local costItemNum=0
local buynum=0

local idx=0
local isfull=false
for k,v in ipairs(buy_dice_times)do
if isfull then
break
end
for i=idx+1,v[1]do
if lynum<i then
local cost=v[2][2]
if costItemNum<=num then
costItemNum=costItemNum+cost
if costItemNum<=num then
buynum=buynum+1
end
else
isfull=true
break
end
end
end
idx=v[1]
end

if costItemNum<num and buynum<canbuy then
local cost=buy_dice_times[#buy_dice_times][2][2]
for i=1,canbuy do
if costItemNum<=num and buynum<=canbuy then
costItemNum=costItemNum+cost
buynum=buynum+1
end
end
end
_this.min=1
_this.max=canbuy
if buynum<canbuy then
_this.max=buynum
if buynum>99 then
_this.max=99
end
end
if _this.max>99 then
_this.max=99
end

if buynum==0 then
_this.max=1
end
if buynum>0 then
_this.canbuy=true
end
_this.selectCnt=_this.min
local func=function(...)
_this:onSliderChange(...)
end

_this.winlua:SetChildImageRaycast(_this.handleImg:getID(),_this.max>_this.min)
_this.winlua:SetChildSliderInit(_this.selectCntSlider:getID(),_this.selectCnt,_this.min,_this.max,func)
_this.winlua:SetChildSliderValue(_this.selectCntSlider:getID(),_this.selectCnt)
else
_this.canbuy=true
_this.min=1
_this.max=1
_this.selectCnt=_this.min
local func=function(...)
_this:onSliderChange(...)
end
_this.winlua:SetChildImageRaycast(_this.handleImg:getID(),_this.max>_this.min)
_this.winlua:SetChildSliderInit(_this.selectCntSlider:getID(),_this.selectCnt,_this.min,_this.max,func)
_this.winlua:SetChildSliderValue(_this.selectCntSlider:getID(),_this.selectCnt)
end
end
end


function UIDialougeYCTBbuy:onSliderChange(value)
_this.selectCnt=value
local num=_this.selectCnt



_this.selectCntText:setText(num)


_this:ChangeNum(value)
end


function UIDialougeYCTBbuy:ChangeNum(value)


local lynum,zgnum=self.actHandle:getBuyNum(_this.actID,_this.subType,_this.subid)
local buy_dice_times=_this.config.buy_dice_times

local costItemNum=0
local buynum=0

local idx=0
local isfull=false
for k,v in ipairs(buy_dice_times)do
if isfull then
break
end
for i=idx+1,v[1]do
if lynum<i then
local cost=v[2][2]
if buynum<value then
costItemNum=costItemNum+cost
buynum=buynum+1
else
isfull=true
break
end
end
end
idx=v[1]
end

if buynum<value then
local cost=buy_dice_times[#buy_dice_times][2][2]
for i=1,value do
if buynum<=value then
costItemNum=costItemNum+cost
buynum=buynum+1
end
end
end

local costid=buy_dice_times[1][2][1]
local num=moneyModel.getMoney(costid)


_this._moneyType=costid
_this._moneyNum=costItemNum


local costNum=costItemNum
local str=FMT.fmt('{0}',costNum)
if num<costItemNum then
str=FMT.fmt('<color=#c82c2c>{0}</color>',costNum)
end
_this.lycosttxt:setText(str)


local itemNum=buynum*_this.itemIDnum
local itemstr=FMT.fmt('{0}',itemNum)
_this.lynum:setText(itemstr)
end


function UIDialougeYCTBbuy:refreshZhigou()
local cfg=_this.config.recharge_dice_times
_this.zgcanbuy=false
_this.rechargeid=cfg[1]
local rewards=cfg[2]
local limitnum=cfg[3]
local lynum,zgnum=self.actHandle:getBuyNum(_this.actID,_this.subType,_this.subid)

if limitnum>0 and zgnum<=limitnum then
_this.zgcanbuy=true
end
if limitnum==0 then
_this.zgcanbuy=true
_this.zgsynum:setText("")
end
if limitnum>0 then
local _num=limitnum-zgnum
if _num<=0 then
_num=0
end
local systr=FMT.fmt("剩余购买次数：{0}",_num)
_this.zgsynum:setText(systr)
end

if limitnum>0 and zgnum>=limitnum then
_this.fullzg:setActive(true)
_this.zgbtn:setActive(false)
else
_this.fullzg:setActive(false)
_this.zgbtn:setActive(true)
end


local grids_up2=_this.winlua:GetChildCommonLayoutGroupWidgetList(_this.layout1:getID())
local grids_down2=_this.winlua:GetChildCommonLayoutGroupWidgetList(_this.layout2:getID())
local rewardCount2=#rewards
_this.winlua:SetChildActive(_this.layout2:getID(),rewardCount2>2)
local gridIdxList2=self:getGridIndexList(rewardCount2)
local gridCount2=grids_up2.Count+grids_down2.Count
for i=1,gridCount2 do
local widget
local gridIdx=gridIdxList2[i]
if gridIdx<=grids_up2.Count then
widget=grids_up2[gridIdx-1]
else
widget=grids_down2[gridIdx-grids_up2.Count-1]
end
local reward=rewards[i]
if reward then
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
else
widget:SetChildActive(-1,false)
end
end


local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,_this.rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local zhigoustr=str or'nil'
_this.zgtxt:setText(zhigoustr)


end
function UIDialougeYCTBbuy:getGridIndexList(count)
if count==3 then
return{1,3,4,2}
else
return{1,2,3,4}
end
end


function UIDialougeYCTBbuy:onHide()

end


function UIDialougeYCTBbuy:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


function UIDialougeYCTBbuy:onAddBtn()
if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


function UIDialougeYCTBbuy:onCloseBtn()
self:closeSelf()
end

function UIDialougeYCTBbuy:onBGClick()
self:onCloseBtn()
end


function UIDialougeYCTBbuy:onLybtn()
local limitNum=_this.config.buy_times_limit
local lynum,zgnum=self.actHandle:getBuyNum(_this.actID,_this.subType,_this.subid)
if limitNum>0 and lynum>=limitNum then
UIManager.error("可购买次数已达上限")
return
end

local buyCost={_this._moneyType,_this._moneyNum}
local isEnough=moneyModel.checkEnoughMoney(buyCost[1],buyCost[2])

if not isEnough then
if not isEnough and buyCost[1]==eMoneyType.mtLingYu then

local hasLingYuCount=moneyModel.getMoney(buyCost[1])
local needXianYuCount=buyCost[2]-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end
if not isEnough then
local MoneyName=moneyModel.getMoneyName(buyCost[1])
UIManager.error(FMT.fmt("{0}不足",MoneyName))
gainControl:showGainWin(buyCost[1])
return
end
local cb=function(...)
if _this==nil then return end
_this.actHandle.sendBuy(_this.selectCnt,_this.actID,_this.subType,_this.subid)
end
moneySystem:useMoney(buyCost[1],buyCost[2],cb,WARNING_TYPE.eWarning)

else
self.actHandle.sendBuy(_this.selectCnt,_this.actID,_this.subType,_this.subid)
end
end


function UIDialougeYCTBbuy:onZgbtn()
local cfg=_this.config.recharge_dice_times
local limitnum=cfg[3]
local lynum,zgnum=self.actHandle:getBuyNum(_this.actID,_this.subType,_this.subid)
if limitnum>0 and zgnum>=limitnum then
UIManager.error("可购买次数已达上限")
end

if _this.zgcanbuy then

local params=payControl.getActivityPayParams(_this.actID,_this.subType,_this.subid)
payControl.reqPay(_this.rechargeid,1,params)
end
end
