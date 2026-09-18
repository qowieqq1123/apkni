







def_class("UISubAct_shizhuanchoujian_prizeWin",UIWindowBase)









function UISubAct_shizhuanchoujian_prizeWin:bindComponents()

self.btnClickMask=UIObject.get(self,0)
self.creater=UIGameobjectClone.new(self,1)
self.drawBtnMany=UIButton.get(self,2)
self.drawBtnManyText=UIText.get(self,3)
self.drawBtnOne=UIButton.get(self,4)
self.drawBtnPanel=UIObject.get(self,5)
self.drawManyMoneyImg=UIImage.get(self,6)
self.drawManyMoneyTxt=UIText.get(self,7)
self.drawManyReddot=UIObject.get(self,8)
self.drawOneFreeText=UIText.get(self,9)
self.drawOneMoneyImg=UIImage.get(self,10)
self.drawOneMoneyTxt=UIText.get(self,11)
self.drawOneReddot=UIObject.get(self,12)
self.effect=UIObject.get(self,13)
self.nextTx=UIText.get(self,14)
self.rwScrollView=UIObject.get(self,15)
self.tips=UILinkImageText.get(self,16)
self.tipsText=UIText.get(self,17)

self.drawBtnMany:setButtonClick(function()self:onDrawBtnMany()end)

self.drawBtnOne:setButtonClick(function()self:onDrawBtnOne()end)



end


function UISubAct_shizhuanchoujian_prizeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClickMask);self.btnClickMask=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.drawBtnMany);self.drawBtnMany=nil;
_UIObject_release(self.drawBtnManyText);self.drawBtnManyText=nil;
_UIObject_release(self.drawBtnOne);self.drawBtnOne=nil;
_UIObject_release(self.drawBtnPanel);self.drawBtnPanel=nil;
_UIObject_release(self.drawManyMoneyImg);self.drawManyMoneyImg=nil;
_UIObject_release(self.drawManyMoneyTxt);self.drawManyMoneyTxt=nil;
_UIObject_release(self.drawManyReddot);self.drawManyReddot=nil;
_UIObject_release(self.drawOneFreeText);self.drawOneFreeText=nil;
_UIObject_release(self.drawOneMoneyImg);self.drawOneMoneyImg=nil;
_UIObject_release(self.drawOneMoneyTxt);self.drawOneMoneyTxt=nil;
_UIObject_release(self.drawOneReddot);self.drawOneReddot=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.nextTx);self.nextTx=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end
















local _this
local colorEffectList={
[eQualityColor.eOrange]={10468,10469},
[eQualityColor.eRed]={10164,10165},
}




function UISubAct_shizhuanchoujian_prizeWin:onLoaded(...)
_this=self
self:bindComponents()
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)

UIManager.setMoneyMsgShowState(false,true)
end


function UISubAct_shizhuanchoujian_prizeWin:__delete()
self:clearTimer()
self.rwScrollView:setChildScrollViewStopGridCreate()

self:unbindComponents()


UIManager.setMoneyMsgShowState(true,true)
_this=nil
end


















function UISubAct_shizhuanchoujian_prizeWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.openTimer=self:delayDo(0.5,function()
if _this==nil then return end
self.btnClickMask:setActive(false)
end)

local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'

self.networking=false

self.tips:setText(tipsStr)
self.tipsText:setText(closeTips)
self.effect:setChildShowEffect(10014,true)

AudioManager.playAudio(407)

self.rewards=argtable.list
self.showDrawBtn=not argtable.isHideDrawBtn
local len=#self.rewards







self.rwScrollView:setChildScrollViewStopGridCreate()
self.rwScrollView:setChildScrollViewCreateGrids(0,0)
self.rwScrollView:setChildScrollViewDelayCreateGrids(len,math.min(len,5),0.15,1,false,false,function(index,item)
local rwdata=self.rewards[index+1]
local rewardId=rwdata.itemid
local rewardNum=rwdata.num
local rewardGuid=rwdata.itemguid
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local colorEffect=argtable.effect[rewardId]or false
local isDaoBing=itemsConfig.isDaoBing(rewardId)
local showStage=not isDaoBing
local conf={itemid=rewardId,itemcount=countStr,itemguid=rewardGuid,showCountBG=showCountBG,showname=true,showStage=showStage,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=equipsHelper.getSuitIcon(rwdata)
item:SetChildPropData(0,prop)

item:SetBaseItemClickEvent(0,function(...)itemsComponentHelper.onItemClickEx(...)end)


if index<10 then
item:SetChildShowEffect(2,10078,true)
end








end)

self:refreshBtn()
self:baodinum()
end


function UISubAct_shizhuanchoujian_prizeWin:onHide()
self:clearTimer()
end

function UISubAct_shizhuanchoujian_prizeWin:refreshBtn()
self.drawBtnPanel:setActive(self.showDrawBtn)
if self.showDrawBtn then
local costCfg=self.config.cost_items
local itemId=costCfg[1]
local needCnt=costCfg[2]
local iconName=iconHelper.getIconName(itemId)
local hasItemCount=itemsModel.getCount(itemId)
local maxFreeNum=self.config.free_times or 0
local mydata=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
local useFreeNum=mydata.use_free_times or 0
local remainingDrawCount=maxFreeNum-useFreeNum
if remainingDrawCount>0 then
self.drawOneMoneyTxt:setActive(false)
self.drawOneFreeText:setActive(true)
self.drawOneFreeText:setText(FMT.fmt("免费次数：{0}",remainingDrawCount))
self.drawOneReddot:setActive(true)
else
self.drawOneMoneyTxt:setActive(true)
self.drawOneFreeText:setActive(false)
self.drawOneMoneyImg:setImageIcon(iconName)
local isEnough=hasItemCount>=needCnt
if isEnough then
self.drawOneMoneyTxt:setText(FMT.fmt("{0}/{1}",hasItemCount,needCnt))
else
self.drawOneMoneyTxt:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",hasItemCount,needCnt))
end
self.drawOneReddot:setActive(isEnough)
end

self.drawManyMoneyImg:setImageIcon(iconName)
local manyDrawCount=10
self.drawBtnManyText:setText(FMT.fmt("购物{0}次",manyDrawCount))
local isEnough=hasItemCount>=(needCnt*manyDrawCount)
if isEnough then
self.drawManyMoneyTxt:setText(FMT.fmt("{0}/{1}",hasItemCount,needCnt*manyDrawCount))
else
self.drawManyMoneyTxt:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",hasItemCount,needCnt*manyDrawCount))
end
self.drawManyReddot:setActive(isEnough)
end

end

function UISubAct_shizhuanchoujian_prizeWin:showSpecialEffect()
local specialItemList_lookup=self.config.reset_items[self.selectBoxIndex]or{}
for i,rwdata in ipairs(self.rewards)do
local rewardId=rwdata.itemid
local rewardNum=rwdata.num
local rewardGuid=rwdata.itemguid
local color=itemsConfig.getItemColor(rewardId)
if color>=eQualityColor.eOrange and specialItemList_lookup[rewardId]then
local item=self.rwScrollView:getChildScrollViewItemWidget(i-1)

local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local colorEffect=true
local isDaoBing=itemsConfig.isDaoBing(rewardId)
local showStage=not isDaoBing
local conf={itemid=rewardId,itemcount=countStr,itemguid=rewardGuid,showCountBG=showCountBG,showname=true,showStage=showStage,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=equipsHelper.getSuitIcon(rwdata)
local effect=colorEffectList[color]
item:SetChildShowEffect(2,effect[1],true)
local func=function()
item:SetChildPropData(0,prop)
item:SetChildShowEffect(3,effect[2],true)
end
self:delayDo(0.5,func)
end
end
end




function UISubAct_shizhuanchoujian_prizeWin:onDrawBtnOne()
_this:clearTimer()
self.btnClickMask:setActive(true)
UIManager:invokeUIMethod("UISubAct_shizhuanchoujianWin","onBtn_one")
self:onClickBg()
end



function UISubAct_shizhuanchoujian_prizeWin:onDrawBtnMany()
_this:clearTimer()
self.btnClickMask:setActive(true)
UIManager:invokeUIMethod("UISubAct_shizhuanchoujianWin","onBtn_two")
self:onClickBg()
end

function UISubAct_shizhuanchoujian_prizeWin:onClickBg()
_this:clearTimer()
self.btnClickMask:setActive(true)
if self.callback then
self.callback()
end

self:closeSelf()
end

function UISubAct_shizhuanchoujian_prizeWin:clearTimer()
if self.openTimer then
self:stopTimerByID(self.openTimer)
self.openTimer=nil
end
end


function UISubAct_shizhuanchoujian_prizeWin:baodinum()
local data=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
if data==nil then return end
local history_num=data.history_use_times or 0
local max=cfg_lotteryact3config_get(self.subId).guarantee_times or 50
local num=history_num
if max<=history_num then
num=math.fmod(history_num,max)
end
local nextnum=max-num
local colorStr=FONT_COLOR_VAL[FONT_COLOR.eOrangeColor]
_this.nextTx:setText(FMT.fmt("再购物 <color=#8f5127>{0}</color> 次，必得 <color={1}>极品仙衣</color>",nextnum,colorStr))
end
