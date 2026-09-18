







def_class("YYHYBuyDialogWin",UIWindowBase)









function YYHYBuyDialogWin:bindComponents()

self.title=UIText.get(self,0)
self.scrollerView=UIObject.get(self,1)
self.sureBtn=UIButton.get(self,2)
self.cancelBtn=UIButton.get(self,3)
self.buyLimit=UIText.get(self,4)
self.selectCntSlider=UIObject.get(self,5)
self.costCount=UIText.get(self,6)
self.costIcon=UIImage.get(self,7)
self.handleImg=UIObject.get(self,8)
self.maxCnt=UIButton.get(self,9)
self.subBtn=UIButton.get(self,10)
self.addBtn=UIButton.get(self,11)
self.selectCntText=UIText.get(self,12)
self.text1=UIText.get(self,13)
self.dialougeText=UILinkImageText.get(self,14)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)



end


function YYHYBuyDialogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.buyLimit);self.buyLimit=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.costCount);self.costCount=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.text1);self.text1=nil;
_UIObject_release(self.dialougeText);self.dialougeText=nil;
end

















local packTypeChinese={'日','周','月'}
local _this


function YYHYBuyDialogWin:onLoaded(...)
self:bindComponents()
_this=self
local _onClickRewardItem=function(...)

end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickRewardItem,nil)
end


function YYHYBuyDialogWin:__delete()
self:unbindComponents()
end




function YYHYBuyDialogWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
self.config=argtable
self.title:setText(argtable.name)
self.rewards=argtable.rewards
local buyNum

local cfg=cfg_yiyuhuiyoubaseconfig_get(1).buy_enter_cnt
local tz_num=YiYuHuiYouModel:getEnter_cnt()
local tz_buynum=YiYuHuiYouModel:getBuy_enter_cnt()or 0
local tz_peizi_num=#cfg


self.buyLimit:setActive(true)
self.buyLimit:setText(FMT.fmt('（剩余购买次数：{0}）',tz_peizi_num-tz_buynum))
self.costCount:setText(FMT.fmt("购买"))
self.selectCntSlider:setActive(false)

self.cost={}
if(tz_peizi_num-tz_buynum)>0 then
_this.cost=cfg[tz_buynum+1]
end

if#self.cost>0 then
local enough=moneyModel.checkEnoughMoney(self.cost[1],self.cost[2])
if enough then

self.dialougeText:setText(FMT.fmt("是否确认花费quad-icon={0}-quad<color=#549327FF>{1}</color>购买挑战次数",moneyModel.getIconNameEx(_this.cost[1]),_this.cost[2]))
else
self.dialougeText:setText(FMT.fmt("是否确认花费quad-icon={0}-quad<color=#FF0000FF>{1}</color>购买挑战次数",moneyModel.getIconNameEx(_this.cost[1]),_this.cost[2]))
end

else
self.text1:setText(FMT.fmt("今日购买次数已耗尽"))
end

self.selectCnt=1

























































end

function YYHYBuyDialogWin:refreshItem()
local rewards=rechargeModel:getXianGouLiBaoRewards(self.rewards)
self.scrollerView:setChildScrollViewCreateGrids(#rewards,#rewards)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count*self.selectCnt,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
end
end
end


function YYHYBuyDialogWin:onHide()

end




function YYHYBuyDialogWin:onMaxCnt()
end



function YYHYBuyDialogWin:onSubBtn()
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function YYHYBuyDialogWin:onAddBtn()
if self.max<=1 then
return
end

if self.min==self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function YYHYBuyDialogWin:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function YYHYBuyDialogWin:onSliderChange(value)

self.selectCnt=value
self.selectCntText:setText(self.selectCnt)
local moneyCount=self.cost[2]
self.need=self.selectCnt*moneyCount
local name=''
if self.cost[1]>0 then
name=itemsConfig.getItemName(self.cost[1])
end
local enough=moneyModel.checkEnoughMoney(self.cost[1],self.need)
if enough then
self.costCount:setText(FMT.fmt("{0}{1}",self.need,name))
else
self.costCount:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}{1}",self.need,name))
end
self:refreshItem()
end



function YYHYBuyDialogWin:onSureBtn()
local configId=self.config.id
if _this.cost then
local moneyType=_this.cost[1]
local moneyCount=_this.cost[2]
if moneyType<=0 then
UIManager.error(FMT.fmt('没有找到货币类型{0}',moneyType))
return
end

self.selectCnt=self.selectCnt or 1

local selectCnt=self.selectCnt
local cb=function(...)

YiYuHuiYouController.send_248_52()
end

moneySystem:useMoney(moneyType,moneyCount*self.selectCnt,cb,WARNING_TYPE.eWarning)
else





UIManager.error("今日购买次数已耗尽")
end
self:closeSelf()
end

function YYHYBuyDialogWin:onCancelBtn()
self:closeSelf()
end

function YYHYBuyDialogWin:onClickRewardItem(clickCount,index)
local cfgs=self.config.rewards
local rewards=rechargeModel:getXianGouLiBaoRewards(cfgs)
local itemid=rewards[index+1][1]
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid})
end
