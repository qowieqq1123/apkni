







def_class("UISubAct_shizhuangzhigouWin",UIWindowBase)









function UISubAct_shizhuangzhigouWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.btnBuy=UIButton.get(self,1)
self.btnDetail=UIButton.get(self,2)
self.btnLeft=UIButton.get(self,3)
self.btnRight=UIButton.get(self,4)
self.dzListPanel=UIObject.get(self,5)
self.dzListScrollView=UIObject.get(self,6)
self.dzmodel=UIObject.get(self,7)
self.effectTxt=UIImage.get(self,8)
self.freeGift=UIButton.get(self,9)
self.layout=UIObject.get(self,10)
self.leftTime=UIText.get(self,11)
self.limitBuy=UIText.get(self,12)
self.price=UIImage.get(self,13)
self.priceTxt=UIText.get(self,14)
self.rewardList=UIObject.get(self,15)
self.sellOut=UIObject.get(self,16)

self.btnBuy:setButtonClick(function()self:onBtnBuy()end)

self.btnDetail:setButtonClick(function()self:onBtnDetail()end)

self.btnLeft:setButtonClick(function()self:onBtnLeft()end)

self.btnRight:setButtonClick(function()self:onBtnRight()end)

self.freeGift:setButtonClick(function()self:onFreeGift()end)



end


function UISubAct_shizhuangzhigouWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.btnBuy);self.btnBuy=nil;
_UIObject_release(self.btnDetail);self.btnDetail=nil;
_UIObject_release(self.btnLeft);self.btnLeft=nil;
_UIObject_release(self.btnRight);self.btnRight=nil;
_UIObject_release(self.dzListPanel);self.dzListPanel=nil;
_UIObject_release(self.dzListScrollView);self.dzListScrollView=nil;
_UIObject_release(self.dzmodel);self.dzmodel=nil;
_UIObject_release(self.effectTxt);self.effectTxt=nil;
_UIObject_release(self.freeGift);self.freeGift=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.leftTime);self.leftTime=nil;
_UIObject_release(self.limitBuy);self.limitBuy=nil;
_UIObject_release(self.price);self.price=nil;
_UIObject_release(self.priceTxt);self.priceTxt=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.sellOut);self.sellOut=nil;
end


















local dzItemIndex={
btnClick=0,
select=1,
headIcon=2,
}

function UISubAct_shizhuangzhigouWin:onLoaded(...)
self:bindComponents()
self.scrollViewMaxSize=845
self.widget:SetChildScrollViewAutoSizeOption(self.dzListScrollView:getID(),true,self.scrollViewMaxSize)
end


function UISubAct_shizhuangzhigouWin:__delete()
self:unbindComponents()
self.isOver=nil
end


function UISubAct_shizhuangzhigouWin:onHide()
self.dzListScrollView:setActive(false)
end




function UISubAct_shizhuangzhigouWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.ebuyact9
self.subid=argtable.sub_act_id

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

if afterOnloaded and not self.showSuitConf then
self.showSuitConf={}
for pageIndex,v in ipairs(self.config.suit_conf)do
if self.info:checkShowPage(pageIndex)then
v.pageIndex=pageIndex
table.insert(self.showSuitConf,v)
end
end
if not next(self.showSuitConf)then
logErr("UISubAct_shizhuangzhigouWin 时装已经全部激活和满星 不应该存在这个页签")
return
end
end


self.selectIdx=1

if self.info then
local left=self.info:getEndLeftTime()
if left>0 then
self.leftTime:setText(FMT.fmt("本期剩余时间:{0}",self.format_time_stamp2(left)))
else
self.leftTime:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local left=info:getEndLeftTime()
if left>0 then
self.leftTime:setText(FMT.fmt("本期剩余时间:{0}",self.format_time_stamp2(left)))
else
self.leftTime:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end
else
self.leftTime:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end

end)
else
self.leftTime:setText("活动已结束")
self.isOver=true
end

self:refreshDiscipleHeadList()
self:refreshSelectPanel()
self:refreshModel()
end


function UISubAct_shizhuangzhigouWin:refreshDiscipleHeadList()
self.dzListScrollView:setActive(true)
local count=#self.showSuitConf
self.dzListScrollView:setChildScrollViewCreateGrids(count,count)
local grids=self.dzListScrollView:getChildScrollViewItemWidgets()
for i=1,count do
local itemIndex=i
local widget=grids[itemIndex-1]
local cfg=self.showSuitConf[itemIndex]

local headIconName=cfg.head
if headIconName then

local abName="ui/windows/tianming/newtianming_headicon_atlas_pak.ab"
widget:SetChildCSImageSprite(dzItemIndex.headIcon,abName,headIconName)
widget:SetChildActive(dzItemIndex.headIcon,true)
else
widget:SetChildActive(dzItemIndex.headIcon,false)
end

widget:SetChildButtonClick(dzItemIndex.btnClick,function()
self:selectPage(itemIndex)
end)

widget:SetChildActive(dzItemIndex.select,self.selectIdx==itemIndex)

end
end

function UISubAct_shizhuangzhigouWin:selectPage(idx)
if self.selectIdx==idx then
return
end
local widget=self.dzListScrollView:getChildScrollViewItemWidget(self.selectIdx-1)
widget:SetChildActive(dzItemIndex.select,false)
self.selectIdx=idx
widget=self.dzListScrollView:getChildScrollViewItemWidget(idx-1)
widget:SetChildActive(dzItemIndex.select,true)
self:refreshSelectPanel()
self:refreshModel()
end

function UISubAct_shizhuangzhigouWin:refreshSelectPanel()
local suit_conf=self.showSuitConf[self.selectIdx]
local pageIndex=suit_conf.pageIndex

local buyCnt=self.info.data.list[pageIndex]
local buy_conf=self.config.recharge_conf[pageIndex]
local limitCnt=#buy_conf
local checkItems=self.config.checkItems
if checkItems and checkItems[pageIndex]then
local clothItemid,upStarItemid=unpack(checkItems[pageIndex])
local isActive,isFullStar=ClothingHelper.checkClothAcitveAndFullStar(clothItemid,upStarItemid)
if buyCnt==0 and isActive then
buyCnt=1
end
if isFullStar then
buyCnt=limitCnt
end
end
local conf_idx=buyCnt+1
if conf_idx>limitCnt then
conf_idx=limitCnt
end

local butCnt_conf=buy_conf[conf_idx]

local rechargeId=butCnt_conf[1]
local isLimit=self.config.limit

local czCfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
self.limitBuy:setActive(false)

local abName="ui/windows/activities/sub_shizhuangzhigou/shizhuangzhigou_atlas_pak.ab"
if isLimit~=0 and buyCnt>=limitCnt then
self.priceTxt:setActive(false)
self.sellOut:setActive(true)
else
local str=pfwindowslController:showDesc_ByMoneyType(czCfg)
self.priceTxt:setText(str)
self.priceTxt:setActive(true)
self.sellOut:setActive(false)
end
self.effectTxt:setSprite(abName,suit_conf.effectText[conf_idx])

local gift_cnt=self.info.data.gift_cnt or 0
self.freeGift:setActive(gift_cnt<=0)

local rewardList=butCnt_conf[2]or{}
self.rewardList:setChildLayoutGroupCreateItems(#rewardList)
local grids=self.rewardList:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
item:SetChildActive(-1,true)
local itemCfg=rewardList[i]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local colorEffect=false
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name='',colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

local num=#self.showSuitConf
self.btnLeft:setActive(self.selectIdx>1)
self.btnRight:setActive(self.selectIdx<num)
end

function UISubAct_shizhuangzhigouWin:refreshModel()
local suit_conf=self.showSuitConf[self.selectIdx]
local model=suit_conf.model
local scale=suit_conf.scale
local model_stand=suit_conf.model_stand
local scale_stand=suit_conf.scale_stand
local offset_stand=suit_conf.offset_stand
self.dzmodel:setChildUIModelShowTarget(model,scale,{},eAnimationID.stand,false,true)
self.bgModel:setChildUIModelShowTarget(model_stand,scale_stand,{},eAnimationID.stand,false,true)
self.bgModel:setChildUIModelShowTargetOffset(offset_stand[1],offset_stand[2])
end


function UISubAct_shizhuangzhigouWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end

tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true,})
end

function UISubAct_shizhuangzhigouWin:onBtnBuy()
if self.isOver then
return UIManager.error("活动已结束")
end
if self.payTimer then
return
end
local data=activitiesModel:getSubActInfoData(self.actid,SUB_ACTIVITY_TYPE.ebuyact9,self.subid)
if data then
local suit_conf=self.showSuitConf[self.selectIdx]
local pageIndex=suit_conf.pageIndex
local buyCnt=self.info.data.list[pageIndex]
local buy_conf=self.config.recharge_conf[pageIndex]
local limitCnt=#buy_conf
local checkItems=self.config.checkItems
if checkItems and checkItems[pageIndex]then
local clothItemid,upStarItemid=unpack(checkItems[pageIndex])
local isActive,isFullStar=ClothingHelper.checkClothAcitveAndFullStar(clothItemid,upStarItemid)
if buyCnt==0 and isActive then
buyCnt=1
end
if isFullStar then
buyCnt=limitCnt
end
end
local isLimit=self.config.limit
if isLimit~=0 and buyCnt>=limitCnt then
return UIManager.error("已售罄")
end
local conf_idx=buyCnt+1
if conf_idx>limitCnt then
conf_idx=limitCnt
end
local butCnt_conf=buy_conf[conf_idx]
local rechargeId=butCnt_conf[1]
local showItem=butCnt_conf[2]

local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)




























local args={
rewards=showItem,
name="时装购买",
comfirmText=str,
showBuyLimit=false,
leftNum=0,
maxcount=1,
callback=function(num)
call_activitiesHandle_func('activitiesHandle_shizhuangzhigou','reqBuy',self.actid,self.subid,pageIndex,conf_idx)
end
}
UIManager:showWindow("UICommonBuyDialogWin",args)

end
end

function UISubAct_shizhuangzhigouWin:onBtnDetail()
local suit_conf=self.showSuitConf[self.selectIdx]
local itemId=suit_conf.tipsItemId
if not itemId then
return
end
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end

function UISubAct_shizhuangzhigouWin:onBtnLeft()
if self.selectIdx<=1 then
return
end
self:selectPage(self.selectIdx-1)
end

function UISubAct_shizhuangzhigouWin:onBtnRight()
local num=#self.showSuitConf
if self.selectIdx>=num then
return
end
self:selectPage(self.selectIdx+1)
end

function UISubAct_shizhuangzhigouWin:onFreeGift()
local data=activitiesModel:getSubActInfoData(self.actid,SUB_ACTIVITY_TYPE.ebuyact9,self.subid)
if data then
call_activitiesHandle_func('activitiesHandle_shizhuangzhigou','reqFreeGift',self.actid,self.subid)
end
end

local _format=string.format
local _floor=math.floor
function UISubAct_shizhuangzhigouWin.format_time_stamp2(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>0 then
return _format('%s天%s时',DD,HH)
else
if HH>0 then
return _format('%s时%s分',HH,mm)
else
if mm>0 then
return _format('%s分%s秒',mm,SS)
else
return _format('%s秒',SS)
end
end
end
end
