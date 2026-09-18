







def_class("UIXM_XMDG_MiLingBuyProgressWin",UIWindowBase)









function UIXM_XMDG_MiLingBuyProgressWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.confirmBtn=UIButton.get(self,1)
self.costIcon=UIObject.get(self,2)
self.costNum=UIText.get(self,3)
self.curScore=UIText.get(self,4)
self.gearContent=UIObject.get(self,5)
self.handleImg=UIObject.get(self,6)
self.maxCnt=UIButton.get(self,7)
self.rewardContent=UIObject.get(self,8)
self.root=UIObject.get(self,9)
self.selectCntSlider=UIObject.get(self,10)
self.selectCntText=UIText.get(self,11)
self.subBtn=UIButton.get(self,12)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)



end


function UIXM_XMDG_MiLingBuyProgressWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.curScore);self.curScore=nil;
_UIObject_release(self.gearContent);self.gearContent=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
end


















local _this=nil

function UIXM_XMDG_MiLingBuyProgressWin:onLoaded(...)
self:bindComponents()
_this=self
self._onSliderChange=function(...)
self:onSliderChange(...)
end
self.gearRewardList={}
end


function UIXM_XMDG_MiLingBuyProgressWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXM_XMDG_MiLingBuyProgressWin:onShow(argtable,afterOnloaded)
local baseCfg=cfgHelper.get1(cfg_xmdgtongxingzhengbaseconfig_get,1)
local cost=baseCfg.buyItems[1]
self.costMoney=cost[1]
self.costNumUnit=cost[2]
self.costIcon:setChildIcon(iconHelper.getIconName(self.costMoney),true)
local passInvestList=xianmengdigongModel:getPassInvestList()
local curXDL=xianmengdigongModel:getPassXDL()
self.gearList={}
for i,v in ipairs(passInvestList)do
if curXDL<v.id then
table.insert(self.gearList,v)
end
end
self.maxNum=#self.gearList
if self.maxNum<=0 then
logErr("[ERR] 没有可购买挡位")
self:closeSelf()
return
end
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.3)
end)
end
self.selectGearIdx=1
self.curScore:setText(curXDL)
self:refreshGearList()
self:showWindow('UITopMoneyWin2',{{eMoneyType.mtXianYu},{eMoneyType.mtLingYu}})
end


function UIXM_XMDG_MiLingBuyProgressWin:refreshGearList()
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectGearIdx,1,self.maxNum,self._onSliderChange)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectGearIdx)
end


function UIXM_XMDG_MiLingBuyProgressWin:refreshGearRewardList()
local cfg=self.gearList[self.selectGearIdx]
if not self.gearRewardList[self.selectGearIdx]then
self.gearRewardList[self.selectGearIdx]=xianmengdigongModel:getPassBuyProgressRewardList(cfg.id)
end
local rewardList=self.gearRewardList[self.selectGearIdx]
self.rewardContent:setChildLayoutGroupCreateItems(#rewardList,function(index)
local widget=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local reward=rewardList[index]
local itemid,itemnum=unpack(reward)
local countStr=itemnum>1 and mathHelper.formatNumber(itemnum)or''
local conf={itemid=itemid,itemcount=countStr,showCountBG=itemnum>1,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
widget:SetChildPropData(-1,prop)
end)
if#rewardList>8 then
self.rewardContent:setChildPivot(Vector2(0,1))
self.rewardContent:setChildAnchoredPos(0,0)
else
self.rewardContent:setChildPivot(Vector2(0.5,1))
end
end

function UIXM_XMDG_MiLingBuyProgressWin:onSliderChange(index)
self.selectGearIdx=index
local cfg=self.gearList[index]
self.selectCntText:setText(string.format("%d档",cfg.id))
self:refreshCostNum()
self:refreshGearRewardList()
end

function UIXM_XMDG_MiLingBuyProgressWin:refreshCostNum()
local curXDL=xianmengdigongModel:getPassXDL()
local cfg=self.gearList[self.selectGearIdx]
local buyXDL=cfg.id-curXDL
local need=buyXDL*self.costNumUnit
local has=itemsModel.getCount(self.costMoney)
self.costNum:setText(string.format("<color=%s>%d</color>",has>=need and"#F7F7F7"or"#C82C2C",need))

end

function UIXM_XMDG_MiLingBuyProgressWin:onMaxCnt()
self.selectGearIdx=self.numMax
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectGearIdx)
end

function UIXM_XMDG_MiLingBuyProgressWin:onSubBtn()
if self.selectGearIdx<=1 then return end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectGearIdx-1)
end

function UIXM_XMDG_MiLingBuyProgressWin:onAddBtn()
if self.selectGearIdx>=self.maxNum then return end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectGearIdx+1)
end

function UIXM_XMDG_MiLingBuyProgressWin:onConfirmBtn()
local cfg=self.gearList[self.selectGearIdx]
local curXDL=xianmengdigongModel:getPassXDL()
local moneyType=self.costMoney
local buyXDL=cfg.id-curXDL
local need=buyXDL*self.costNumUnit
local moneyname=moneyModel.getMoneyName(moneyType)
local func1=function()
local func=function()
xianmengdigongController:reqPassBuyProgress(cfg.id)
end
moneySystem:useMoney(moneyType,need,func,WARNING_TYPE.eWarning)
end
local costIcon=iconHelper.getIconName(moneyType)
local str=FMT.fmt('是否花费quad-icon={0}-quad<color=#C82C2C>{1}</color>{2}直接解锁\n<color=#C82C2C>{3}</color>档次奖励？',costIcon,need,moneyname,cfg.id)
local show_data={
type='UIDialouge',
title='提示',
okcallback=func1,
content=str,
oktext='确定',
canceltext='取消',

}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

end