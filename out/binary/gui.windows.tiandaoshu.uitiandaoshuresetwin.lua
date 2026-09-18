







def_class("UITianDaoShuResetWin",UIWindowBase)









function UITianDaoShuResetWin:bindComponents()

self.Root=UIObject.get(self,0)
self.desc=UIText.get(self,1)
self.rewardRoot=UIObject.get(self,2)
self.rewardList=UIObject.get(self,3)
self.resetBtn=UIButton.get(self,4)
self.consumeNum=UIText.get(self,5)
self.consumeIcon=UIObject.get(self,6)
self.counttip=UIText.get(self,7)
self.closeBtn=UIButton.get(self,8)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UITianDaoShuResetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.consumeNum);self.consumeNum=nil;
_UIObject_release(self.consumeIcon);self.consumeIcon=nil;
_UIObject_release(self.counttip);self.counttip=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end
















local _this




function UITianDaoShuResetWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onTiandaoshuReset,self.onTiandaoshuReset)
end


function UITianDaoShuResetWin:__delete()
self:unbindComponents()
end




function UITianDaoShuResetWin:onShow(argtable,afterOnloaded)
self.voc=argtable.voc


local recordNum=gameUtilityModel:getData_counter(gameCounterType.eTianDaoShuResetNum)

local resetData=tiandaoshuConfig:getBaseConfig('reset')
local resetReturnDesc=tiandaoshuConfig:getBaseConfig('resetReturnDesc')
local resetMaxNum=#(resetData[1]or{})
local moneyDiscount=resetData[2]
local moneyDiscountList=resetData[3]
local exchangeList=resetData[4]
local itemDiscount=100
local vocName=cfgHelper.get2(cfg_disciplevocationconfig_get,self.voc,'name')


local descStr=FMT.fmt(resetReturnDesc,toColorString(FONT_COLOR.eOrangeColor,vocName))
descStr=string.replaceSpace(descStr)

local returnItemDataList=tiandaoshuModel:caculateReturnItemDataList(self.voc,itemDiscount,moneyDiscount,moneyDiscountList,exchangeList)

self.desc:setText(descStr)

self.rewardList:setChildLayoutGroupCreateItems(#returnItemDataList,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)

local data=returnItemDataList[index]
local rewardConf={showname=false,nomalname=false,showcount=data.itemcount>1,showCountBG=data.itemcount>1}
local propData=itemsComponentHelper.getCommonFillData(data,rewardConf)

item:SetChildPropData(-1,propData)

item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
end)

self.counttip:setText(FMT.fmt('本月可重置天道树次数({0} / {1})',recordNum,resetMaxNum))

local resetConsumeList=resetData[1][recordNum+1]
local isShowResetBtn=resetConsumeList~=nil
self.resetBtn:setButtonEnable(true,not isShowResetBtn)
self.consumeNum:setActive(isShowResetBtn)
if isShowResetBtn then
local consumeMoneyId=resetConsumeList[1][1]
local consumeCount=resetConsumeList[1][2]
local moneyIconName=iconHelper.getIconName(consumeMoneyId)
local hasNum=itemsModel.getCount(consumeMoneyId)
local color=hasNum>=consumeCount and FONT_COLOR.eNomalBlackColor or FONT_COLOR.eRedColor
self.consumeNum:setText(toColorString(color,consumeCount))
self.consumeIcon:setChildIcon(moneyIconName,false)
end

self:freshMoney()
end


function UITianDaoShuResetWin:onHide()

end

function UITianDaoShuResetWin:onTiandaoshuReset()
_this:closeSelf()
end

function UITianDaoShuResetWin:freshMoney()
self:showWindow('UITopMoneyWin',{{eMoneyType.mtLingYu,0},{eMoneyType.mtXianYu,0}})
end





function UITianDaoShuResetWin:onResetBtn()
local recordNum=gameUtilityModel:getData_counter(gameCounterType.eTianDaoShuResetNum)
local resetData=tiandaoshuConfig:getBaseConfig('reset')
local resetMaxNum=#(resetData[1]or{})
local vocName=cfgHelper.get2(cfg_disciplevocationconfig_get,self.voc,'name')

local resetConsumeList=resetData[1][recordNum+1]
if resetConsumeList~=nil then
local consumeMoneyId=resetConsumeList[1][1]
local consumeCount=resetConsumeList[1][2]


local content=FMT.fmt('是否重置 {0} 天道树',toColorString(FONT_COLOR.eOrangeColor,vocName))
content=string.replaceSpace(content)
local func=function()
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
tiandaoshuController.send_6_65(self.voc)
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end

moneySystem:useMoney(consumeMoneyId,consumeCount,func,WARNING_TYPE.eWarning,nil)
else
local stemp=timeHelper.getNextMonthDateDisStamp2(1,5,1,0)
local time=timeHelper.format_time_stamp12(stemp)
UIManager.info(FMT.fmt('本月重置次数已用完，{0}后可以再次重置',time))
end
end



function UITianDaoShuResetWin:onCloseBtn()
self:closeSelf()
end

