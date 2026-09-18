







def_class("UISelectLiBao_dialogWin",UIWindowBase)









function UISelectLiBao_dialogWin:bindComponents()

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
self.costLayoutEmpty=UIObject.get(self,13)
self.mask=UIButton.get(self,14)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UISelectLiBao_dialogWin:unbindComponents()
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
_UIObject_release(self.costLayoutEmpty);self.costLayoutEmpty=nil;
_UIObject_release(self.mask);self.mask=nil;
end

















local packTypeChinese={'日','周','月'}


function UISelectLiBao_dialogWin:onLoaded(...)
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickRewardItem,nil)
end


function UISelectLiBao_dialogWin:__delete()
self:unbindComponents()
end




function UISelectLiBao_dialogWin:onShow(argtable,afterOnloaded)
self.libaoId=argtable.libaoId
self.config=cfgHelper.get(cfg_customizedgiftconfig_get,self.libaoId)
self.title:setText(self.config.name)
self.rewards=argtable.rewards
self.rewardIndexList=argtable.rewardIndexList
local buyNum=rechargeModel:getSelectLiBaoBuyNumByLiBaoId(self.libaoId)
local limitType=self.config.reset_type
local isLimit=self.config.maxcount and self.config.maxcount>0
self.buyLimit:setActive(isLimit)
if isLimit then
self.buyLimit:setText(FMT.fmt('每{0}限购：{1}/{2}',packTypeChinese[limitType],buyNum,self.config.maxcount))
end

self.maxSelectCount=nil

self.selectCnt=1

local isRecharge=self.config.rechargeid~=nil
if not isRecharge then
local price=self.config.price
local moneyType=price[1]
local moneyCount=price[2]
self.cost={moneyType,moneyCount}
local name=''
if moneyType>0 then
name=itemsConfig.getItemName(moneyType)
end

local enough=moneyModel.checkEnoughMoney(moneyType,moneyCount)
if enough then
self.costCount:setText(moneyCount)
else
self.costCount:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}",moneyCount))
end
self.costIcon:setImageIcon(iconHelper.getIconName(moneyType),false)
self.costIcon:setActive(true)
self.costLayoutEmpty:setActive(true)


local canUseMoneyCount=moneyModel.getMoney(moneyType)
if moneyType==eMoneyType.mtLingYu then

canUseMoneyCount=canUseMoneyCount+moneyModel.getMoney(eMoneyType.mtXianYu)
end
self.maxSelectCount=math.floor(canUseMoneyCount/moneyCount)
if self.maxSelectCount<=0 then
self.maxSelectCount=1
end

if isLimit then
self.max=self.config.maxcount-buyNum
if self.maxSelectCount and self.max>self.maxSelectCount then
self.max=self.maxSelectCount
end
self.min=1
if self.max<=1 then
self.buyLimit:setActive(true)
self.selectCntSlider:setActive(false)
else
self.buyLimit:setActive(false)
self.selectCntSlider:setActive(true)

self.selectCnt=self.min

local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end
else
self.buyLimit:setActive(false)
self.selectCntSlider:setActive(false)
end
else

self.rechargeid=self.config.rechargeid
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,self.config.rechargeid)
local rmb=rechargecfg.rmb
if rmb then
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.costCount:setText(str)
end
self.buyLimit:setActive(true)
self.selectCntSlider:setActive(false)
self.costIcon:setActive(false)
self.costLayoutEmpty:setActive(false)
end


self:refreshItem()
end

function UISelectLiBao_dialogWin:refreshItem()
local rewards=self.rewards
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


function UISelectLiBao_dialogWin:onHide()

end





function UISelectLiBao_dialogWin:onSureBtn()
local rewardIndexList=self.rewardIndexList
local libaoId=self.libaoId
local isRecharge=self.config.rechargeid~=nil
if not isRecharge then
local moneyType=self.cost[1]
local moneyCount=self.cost[2]
if moneyType<=0 then
UIManager.error(FMT.fmt('没有找到货币类型{0}',moneyType))
return
end

self.selectCnt=self.selectCnt or 1

local selectCnt=self.selectCnt
local cb=function(...)

rechargeController:reqBuySelectLiBao(libaoId,selectCnt,rewardIndexList)
end

moneySystem:useMoney(moneyType,moneyCount*self.selectCnt,cb,WARNING_TYPE.eWarning)
else

local rechargeId=self.rechargeid
local params=FMT.fmt("{0}",libaoId)
for i,v in ipairs(rewardIndexList)do
params=FMT.fmt("{0}-{1}",params,v)
end
payControl.reqPay(rechargeId,1,params)
end
self:closeSelf()
end



function UISelectLiBao_dialogWin:onCancelBtn()
self:closeSelf()
end



function UISelectLiBao_dialogWin:onMaxCnt()
end



function UISelectLiBao_dialogWin:onSubBtn()
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UISelectLiBao_dialogWin:onAddBtn()
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



function UISelectLiBao_dialogWin:onMask()
self:closeSelf()
end

function UISelectLiBao_dialogWin:onLongPressBtn(id)
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

function UISelectLiBao_dialogWin:onSliderChange(value)
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
self.costCount:setText(self.need)
else
self.costCount:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}",self.need))
end
self:refreshItem()
end

function UISelectLiBao_dialogWin:onClickRewardItem(clickCount,index)
local rewards=self.rewards
local itemid=rewards[index+1][1]
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid})
end