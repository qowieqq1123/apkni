







def_class("UIWDCQLiveBroadcastRoomShopWin",UIWindowBase)









function UIWDCQLiveBroadcastRoomShopWin:bindComponents()

self.cdTx=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.giftBtn=UIButton.get(self,2)
self.giftCostIcon=UIImage.get(self,3)
self.giftCostNum=UIText.get(self,4)
self.giftDropdown=UIDropdown.get(self,5)
self.giftList=UIObject.get(self,6)
self.giftTips=UIText.get(self,7)
self.giftView=UIObject.get(self,8)
self.goodsList=UIObject.get(self,9)
self.goodsView=UIObject.get(self,10)
self.helpBtn=UIButton.get(self,11)
self.hotProgressBar=UIProgress.get(self,12)
self.merchatModel=UIObject.get(self,13)
self.merchatModel2=UIObject.get(self,14)
self.poolTx=UIText.get(self,15)
self.rewardBtn=UIButton.get(self,16)
self.rewardList=UIObject.get(self,17)
self.rewardReddot=UIObject.get(self,18)
self.tabActive_1=UIObject.get(self,19)
self.tabActive_2=UIObject.get(self,20)
self.tabBtn_1=UIButton.get(self,21)
self.tabBtn_2=UIButton.get(self,22)
self.tabList=UIObject.get(self,23)
self.tabReddot_1=UIObject.get(self,24)
self.tabReddot_2=UIObject.get(self,25)
self.tips=UIText.get(self,26)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.giftBtn:setButtonClick(function()self:onGiftBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.tabBtn_1:setButtonClick(function()self:onTabBtn_1()end)

self.tabBtn_2:setButtonClick(function()self:onTabBtn_2()end)
self.tabActive={
self.tabActive_1,
self.tabActive_2,
}
self.tabBtn={
self.tabBtn_1,
self.tabBtn_2,
}
self.tabReddot={
self.tabReddot_1,
self.tabReddot_2,
}



end


function UIWDCQLiveBroadcastRoomShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.giftBtn);self.giftBtn=nil;
_UIObject_release(self.giftCostIcon);self.giftCostIcon=nil;
_UIObject_release(self.giftCostNum);self.giftCostNum=nil;
_UIObject_release(self.giftDropdown);self.giftDropdown=nil;
_UIObject_release(self.giftList);self.giftList=nil;
_UIObject_release(self.giftTips);self.giftTips=nil;
_UIObject_release(self.giftView);self.giftView=nil;
_UIObject_release(self.goodsList);self.goodsList=nil;
_UIObject_release(self.goodsView);self.goodsView=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.hotProgressBar);self.hotProgressBar=nil;
_UIObject_release(self.merchatModel);self.merchatModel=nil;
_UIObject_release(self.merchatModel2);self.merchatModel2=nil;
_UIObject_release(self.poolTx);self.poolTx=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.tabActive_1);self.tabActive_1=nil;
_UIObject_release(self.tabActive_2);self.tabActive_2=nil;
_UIObject_release(self.tabBtn_1);self.tabBtn_1=nil;
_UIObject_release(self.tabBtn_2);self.tabBtn_2=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.tabReddot_1);self.tabReddot_1=nil;
_UIObject_release(self.tabReddot_2);self.tabReddot_2=nil;
_UIObject_release(self.tips);self.tips=nil;
self.tabActive=nil;
self.tabBtn=nil;
self.tabReddot=nil;
end















local _this=nil
local _giftCmp={
widget=-1,
hotNum=0,
costNum=1,
costIcon=2,
select=3,
item=4,
limit=5,
limitTx=6,
empty=7,
}
local _goodsListCmp={
0,1,2,
}
local _goodsItemCmp={
widget=-1,
item=0,
name=1,
costIcon=2,
costNum=3,
numTx=4,
empty=5,
}
local _tabHandle={
[1]={
show=function(win)
win.tabActive_1:setActive(true)
win.goodsView:setScale(Vector3.one)
end,
hide=function(win)
win.tabActive_1:setActive(false)
win.goodsView:setScale(Vector3.zero)
end,
},
[2]={
show=function(win)
win.tabActive_2:setActive(true)
win.giftView:setScale(Vector3.one)
end,
hide=function(win)
win.tabActive_2:setActive(false)
win.giftView:setScale(Vector3.zero)
end,
},
}
local _goodsSortLine=10000
local _optionStr="{0}个"
local _progressHeight=96



function UIWDCQLiveBroadcastRoomShopWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(38,22,self.on_38_22)
self:addProNotify(38,23,self.on_38_23)
self:addProNotify(38,32,self.on_38_32)
self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomPoolNumChange,self.onWDCQLiveBroadcastRoomPoolNumChange)
self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomHotChange,self.onWDCQLiveBroadcastRoomHotChange)
self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomTotalHotChange,self.onWDCQLiveBroadcastRoomTotalHotChange)

self:initView()

self:showWindow('UITopMoneyWin4',{moneys={{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}},offsetX=40,offsetY=-30})
end


function UIWDCQLiveBroadcastRoomShopWin:__delete()
self:unbindComponents()
_this=nil

self:stopModelAI()
end




function UIWDCQLiveBroadcastRoomShopWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.group=argtable.group
self.phase=argtable.phase
self.order=argtable.order
self.matchCfg=cfgHelper.get2(cfg_wendingcangqiongmatchconfig_get,self.group,self.phase)

local roomData=wdcqLiveBroadcastRoomModel:getRoomData()
if not roomData or roomData.group~=self.group or roomData.phase~=self.phase then
self:onCloseBtn()
return
end


if not self.matchCfg.xiaofan_conf then
self:onCloseBtn()
return
end
local roomClose=WDCQController.getGameEndTime()
local roomOpen=WDCQController.getGameStartTime()
local nowTime=timeHelper.getServerShortTime()
self.offTime=roomClose
for i,v in ipairs(self.matchCfg.xiaofan_conf)do
local sTime=roomOpen+86400*v[1]+3600*v[2]+60*v[3]+v[4]
local eTime=sTime+v[5]
if sTime<=nowTime and nowTime<eTime then
self.offTime=eTime
end
end

local showHot=self.phase==WDCQCGameStageEnum.eChampion
if showHot then
self:refreshHotProgress()
end
self.hotProgressBar:setActive(showHot)
self.tabList:setActive(showHot)
self:refreshTabReddot()
self:startCDTick()
for i,v in pairs(_tabHandle)do
v.hide(self)
end
self:onTabBtn(1)

self:refreshPoolNum()
if wdcqLiveBroadcastRoomModel:haveShopData(self.phase)then
self:initGoodsView()
self:initGiftView()
end
end


function UIWDCQLiveBroadcastRoomShopWin:onHide()

end




function UIWDCQLiveBroadcastRoomShopWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
UIManager:closeWindow(self.__name)
end
end


function UIWDCQLiveBroadcastRoomShopWin:onGiftBtn()
if self.selectGiftIdx and self.selectGiftNum then
local giftID=self.giftIDs[self.selectGiftIdx]
local giftNum=self.giftNumOptions[self.selectGiftNum+1]
local giftCfg=cfgHelper.get1(cfg_wendingcangqiongreduitemconfig_get,giftID)
local buyed=wdcqLiveBroadcastRoomModel:getGiftBuyed(self.phase,giftID)
if giftCfg.limitNum and buyed+giftNum>giftCfg.limitNum then
UIManager.error(FMT.fmt("剩余限购数量不足{0}",giftNum))
return
end

local costItem=giftCfg.price[1]
local costNum=giftCfg.price[2]*giftNum
moneySystem:useMoney(costItem,costNum,function()
if _this==nil then
UIManager.info("商人已离开")
return
end
wdcqLiveBroadcastRoomController:send_38_23(giftID,giftNum)
end,WARNING_TYPE.eWarning)
end
end


function UIWDCQLiveBroadcastRoomShopWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='wendingcangqiongzhibojian_shop_%d'
d.showBlack=true
self:showWindow('UIRuleWin',d)
end


function UIWDCQLiveBroadcastRoomShopWin:onTabBtn_1()
self:onTabBtn(1)
end


function UIWDCQLiveBroadcastRoomShopWin:onTabBtn_2()
self:onTabBtn(2)
end

function UIWDCQLiveBroadcastRoomShopWin:onRewardBtn()
local args={
perantWin=self,
}
self:showWindow("UIWDCQLiveBroadcastRoomHotRewardWin",args)
end

function UIWDCQLiveBroadcastRoomShopWin:onGiftNumSelect(index)
self.selectGiftNum=index

self:refreshGiftCost()
end

function UIWDCQLiveBroadcastRoomShopWin:onTabBtn(index)
if self.tabIdx~=index then
if self.tabIdx then
_tabHandle[self.tabIdx].hide(self)
end
self.tabIdx=index
if self.tabIdx then
_tabHandle[self.tabIdx].show(self)
end
end
end

function UIWDCQLiveBroadcastRoomShopWin:refreshTabReddot()
local showHot=self.phase==WDCQCGameStageEnum.eChampion
if showHot then

self:refreshTabReddot2()
end
end

function UIWDCQLiveBroadcastRoomShopWin:refreshTabReddot2()
local reddot=wdcqLiveBroadcastRoomModel:getTotalHotReddot()
self.tabReddot_2:setActive(reddot)
end

function UIWDCQLiveBroadcastRoomShopWin:initView()
local baseCfg=cfgHelper.get1(cfg_wendingcangqiongzhibobasicconfig_get,1)
self.merchatSpeakCnt=#baseCfg.merchantSpeak
self.merchatSpeakLib={}
for i=1,self.merchatSpeakCnt do
table.insert(self.merchatSpeakLib,i)
end

self.giftDropdown:setChangeAction(function(...)self:onGiftNumSelect(...)end)
self.giftNumOptions=baseCfg.giftNumOption
local _optionList={}
for i,v in ipairs(self.giftNumOptions)do
table.insert(_optionList,FMT.fmt(_optionStr,v))
end
self.giftDropdown:setOption(_optionList)

self.progressMax=baseCfg.gfjcCondition
local str=FMT.fmt("热度值每累计{0}，擂台内的玩家获得1次抽取次数",self.progressMax)
self.tips:setText(str)



self.merchatModel:setChildUIModelShowTarget(1113045,1.1,{},eAnimationID.stand,false,false,0)
self.merchatModel:setChildUIModelShowFlipX(true)
self.merchatModel2:setChildUIModelShowTarget(1113046,1.1,{},eAnimationID.stand,false,false,0)
self.merchatModel2:setChildUIModelShowFlipX(true)
self:startModelAI()
end

function UIWDCQLiveBroadcastRoomShopWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIWDCQLiveBroadcastRoomShopWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIWDCQLiveBroadcastRoomShopWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
if nowTime>self.offTime then
self:onCloseBtn()
else
local delta=self.offTime-nowTime
self.cdTx:setText(FMT.fmt("离开倒计时：{0}",timeHelper.format_time_stamp3(delta)))
end
end

function UIWDCQLiveBroadcastRoomShopWin:startModelAI()
self:stopModelAI()

local args={
widget=self.winlua,
component=self.merchatModel:getID(),
speak="",
}
self.merchatBT=behaviorManager:addBehaviorTree("bt_ui_wdcqzbj_shop",nil,true,args)
end

function UIWDCQLiveBroadcastRoomShopWin:stopModelAI()
if self.merchatBT then
behaviorManager:removeBehaviorTree(self.merchatBT)
self.merchatBT=nil
end
end

function UIWDCQLiveBroadcastRoomShopWin:randomModelSpeak(bt)
local r=math.random(1,#self.merchatSpeakLib)
local index=table.remove(self.merchatSpeakLib,r)
local speakStr=cfgHelper.get2(cfg_wendingcangqiongzhibobasicconfig_get,1,"merchantSpeak")
bt:setSharedVar("speak",speakStr[index])

if#self.merchatSpeakLib<=0 then
for i=1,self.merchatSpeakCnt do
table.insert(self.merchatSpeakLib,i)
end
end
end

function UIWDCQLiveBroadcastRoomShopWin:refreshPoolNum()
local num=wdcqLiveBroadcastRoomModel:getPoolNum()
self.poolTx:setText(FMT.fmt("灵玉奖池: <color=#CA631D>{0}</color>",num))
end

function UIWDCQLiveBroadcastRoomShopWin:refreshHotProgress()
local hot=wdcqLiveBroadcastRoomModel:getRoomHot()or 0
local progressValue=hot%self.progressMax
self.hotProgressBar:setProgressValue(math.floor(progressValue/self.progressMax*10000),10000)
self.hotProgressBar:setChildProgressText(FMT.fmt("<color=#AAE252>{0}</color>/{1}",progressValue,self.progressMax))
end

function UIWDCQLiveBroadcastRoomShopWin:initGiftView()
if self.giftIDs==nil then
local config=cfg_wendingcangqiongreduitemconfig()
self.giftIDs={}
for i,v in pairs(config)do


table.insert(self.giftIDs,v.id)

end
end

self.selectGiftIdx=1
self.selectGiftNum=self.selectGiftNum or 0
local datas=wdcqLiveBroadcastRoomModel:getGiftData(self.phase)
self.giftList:setChildLayoutGroupCreateItems(#self.giftIDs,function(index)
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
local giftID=self.giftIDs[index]
local giftCfg=cfgHelper.get1(cfg_wendingcangqiongreduitemconfig_get,giftID)
local showCountBG=giftCfg.itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(giftCfg.itemNum)or""
local conf={itemid=giftCfg.item,itemcount=countStr,showCountBG=countStr,showname=true,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_giftCmp.item,prop)
item:SetBaseItemClickEvent(_giftCmp.item,itemsComponentHelper.onItemClickEx)
item:SetChildText(_giftCmp.hotNum,giftCfg.redu)
item:SetChildCSImageIcon(_giftCmp.costIcon,iconHelper.getIconName(giftCfg.price[1]),false)
item:SetChildText(_giftCmp.costNum,giftCfg.price[2])
item:SetChildActive(_giftCmp.select,self.selectGiftIdx==index)
item:SetChildButtonClick(_giftCmp.widget,function()
self:onClickGift(index)
end)
item:SetChildActive(_giftCmp.limit,giftCfg.limitNum~=nil)
if giftCfg.limitNum then
local buyed=datas[giftID]or 0
item:SetChildText(_giftCmp.limitTx,FMT.fmt("本期限购: {0}/{1}",buyed,giftCfg.limitNum))
item:SetChildActive(_giftCmp.empty,buyed>=giftCfg.limitNum)
end
end)
self.giftDropdown:setValue(self.selectGiftNum)
self:refreshNextReward()
self:refreshGiftCost()
end

function UIWDCQLiveBroadcastRoomShopWin:refreshNextReward()
local tHot=wdcqLiveBroadcastRoomModel:getTotalHot()
self.giftTips:setActive(tHot.nextGoal~=nil)
if tHot.nextGoal then
local rewards=cfgHelper.get3(cfg_wendingcangqiongzhibobasicconfig_get,1,"rdGoalReward",tHot.nextGoal)
self.giftTips:setText(tHot.nextGoal-tHot.num)
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local itemData=rewards[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
end
self.rewardReddot:setActive(tHot.flag<tHot.currGoal)
end

function UIWDCQLiveBroadcastRoomShopWin:onClickGift(index)
if self.selectGiftIdx~=index then
if self.selectGiftIdx then
local item=self.giftList:getChildLayoutGroupGridItem(self.selectGiftIdx-1)
item:SetChildActive(_giftCmp.select,false)
end
self.selectGiftIdx=index
if self.selectGiftIdx then
local item=self.giftList:getChildLayoutGroupGridItem(self.selectGiftIdx-1)
item:SetChildActive(_giftCmp.select,true)
end
self:refreshGiftCost()
end
end

function UIWDCQLiveBroadcastRoomShopWin:initGoodsView()
if self.sortGoods==nil then
self.sortGoods={}
else
table.clear(self.sortGoods)
end






local datas=wdcqLiveBroadcastRoomModel:getShopData(self.phase)
for i,v in pairs(datas)do
local config=cfgHelper.get1(cfg_wendingcangqiongshopconfig_get,i)
local buyed=v
local sortWeight=(buyed>=config.limitNum and _goodsSortLine or 0)+i
table.insert(self.sortGoods,{
config=config,
buyed=buyed,
sortWeight=sortWeight
})
end
table.sort(self.sortGoods,self.sortGoodsFunc)
local cnt=#_goodsListCmp
local count=math.ceil(#self.sortGoods/cnt)
self.goodsList:setChildLayoutGroupCreateItems(count,function(idx)
local item=self.goodsList:getChildLayoutGroupGridItem(idx-1)
for i,v in ipairs(_goodsListCmp)do
local index=(idx-1)*cnt+i
local item=item:GetChildWidgetBase(v)
local sortGoods=self.sortGoods[index]
item:SetChildActive(_goodsItemCmp.widget,sortGoods~=nil)
if sortGoods then
local buyed=sortGoods.buyed
local config=sortGoods.config
local showCountBG=config.itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(config.itemNum)or""
local conf={itemid=config.itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_goodsItemCmp.item,prop)
item:SetBaseItemClickEvent(_goodsItemCmp.item,itemsComponentHelper.onItemClickEx)
item:SetChildText(_goodsItemCmp.name,itemsConfig.getItemName(config.itemId))
item:SetChildCSImageIcon(_goodsItemCmp.costIcon,iconHelper.getIconName(config.money[1]),false)
item:SetChildText(_goodsItemCmp.costNum,mathHelper.formatNumber(config.money[2]))
local buyStr=FMT.fmt("限购：{0}/{1}",buyed,config.limitNum)
item:SetChildText(_goodsItemCmp.numTx,buyStr)
item:SetChildActive(_goodsItemCmp.empty,buyed>=config.limitNum)
item:SetChildButtonClick(_goodsItemCmp.widget,function()
self:onClickGoods(index)
end)
end
end
end)
end

function UIWDCQLiveBroadcastRoomShopWin.sortGoodsFunc(a,b)
return a.sortWeight<b.sortWeight
end

function UIWDCQLiveBroadcastRoomShopWin:onClickGoods(index)
local sortGoods=self.sortGoods[index]
local buyed=sortGoods.buyed
local config=sortGoods.config
if buyed>=config.limitNum then
UIManager.info("已售罄")
return
end


local least=config.limitNum-buyed
local costId=config.money[1]
local haveNum=itemsModel.getCount(costId)
local costIcon=iconHelper.getIconName(costId)


















if least>1 then
local refresh=function(num)
local haveNum=itemsModel.getCount(costId)
local costNum=config.money[2]*num
local numStr=haveNum>=costNum and FMT.cfmt2("#ca631d",costNum)or FMT.cfmt1(FONT_COLOR.eRedColor,costNum)
local contentStr=FMT.fmt("是否确认花费quad-icon={0}-quad{1}购买",costIcon,numStr)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=least,
tips=nil,
oktext='购买',
canceltext='取消',
okcallback=function(num)
if _this==nil then
UIManager.info("商人已离开")
return
end
local costNum=config.money[2]*num
moneySystem:useMoney(costId,costNum,function()
if _this==nil then
UIManager.info("商人已离开")
return
end
wdcqLiveBroadcastRoomController:send_38_22(config.id,num)
end,WARNING_TYPE.eWarning)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
local costNum=config.money[2]
local numStr=haveNum>=costNum and FMT.cfmt2("#ca631d",costNum)or FMT.cfmt1(FONT_COLOR.eRedColor,costNum)
local contentStr=FMT.fmt("是否确认花费quad-icon={0}-quad{1}购买",costIcon,numStr)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='购买',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
if _this==nil then
UIManager.info("商人已离开")
return
end
moneySystem:useMoney(costId,costNum,function()
if _this==nil then
UIManager.info("商人已离开")
return
end
wdcqLiveBroadcastRoomController:send_38_22(config.id,1)
end,WARNING_TYPE.eWarning)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
end

function UIWDCQLiveBroadcastRoomShopWin:updateGoodsNum(buyId,buyNum)
for i,v in ipairs(self.sortGoods)do
if v.config.id==buyId then
local oldNum=v.buyed
v.buyed=buyNum
if oldNum<v.config.limitNum and v.buyed>=v.config.limitNum then
break
else
local cnt=#_goodsListCmp
local itemIdx=math.floor((i-1)/cnt)
local subIdx=i-itemIdx*cnt
local goodsItem=self.goodsList:getChildLayoutGroupGridItem(itemIdx)
local item=goodsItem:GetChildWidgetBase(_goodsListCmp[subIdx])
local buyStr=v.buyed<v.config.limitNum and FMT.fmt("限购：{0}/{1}",v.buyed,v.config.limitNum)or""
item:SetChildText(_goodsItemCmp.numTx,buyStr)
return
end
end
end
self:initGoodsView()
end

function UIWDCQLiveBroadcastRoomShopWin:updateGiftNum(buyId,buyNum)
local giftCfg=cfgHelper.get1(cfg_wendingcangqiongreduitemconfig_get,buyId)
if giftCfg.limitNum then
local itemIdx=table.findValue(self.giftIDs,buyId)
local buyed=wdcqLiveBroadcastRoomModel:getGiftBuyed(self.phase,buyId)or 0
local item=self.giftList:getChildLayoutGroupGridItem(itemIdx-1)
item:SetChildText(_giftCmp.limitTx,FMT.fmt("本期限购: {0}/{1}",buyed,giftCfg.limitNum))
item:SetChildActive(_giftCmp.empty,buyed>=giftCfg.limitNum)
end
end

function UIWDCQLiveBroadcastRoomShopWin:refreshGiftCost()
local giftId=self.giftIDs[self.selectGiftIdx]
local giftNum=self.giftNumOptions[self.selectGiftNum+1]
local costCfg=cfgHelper.get2(cfg_wendingcangqiongreduitemconfig_get,giftId,"price")
local costId=costCfg[1]
local costNum=costCfg[2]*giftNum
self.giftCostIcon:setImageIcon(iconHelper.getIconName(costId),false)
self.giftCostNum:setText(FMT.fmt("-{0}",mathHelper.formatNumber(costNum)))
end

function UIWDCQLiveBroadcastRoomShopWin.on_38_22(group,phase,order,buyId,buyNum)
if _this.group==group and _this.phase==phase and _this.sortGoods then
_this:updateGoodsNum(buyId,buyNum)
end
end

function UIWDCQLiveBroadcastRoomShopWin.on_38_23(group,phase,order,buyId,buyNum)
if _this.group==group and _this.phase==phase and _this.sortGoods then
_this:updateGiftNum(buyId,buyNum)
end
end

function UIWDCQLiveBroadcastRoomShopWin.on_38_32(group,phase,order)
if _this.group==group and _this.phase==phase then
_this:initGoodsView()
end
end

function UIWDCQLiveBroadcastRoomShopWin.onWDCQLiveBroadcastRoomPoolNumChange()
_this:refreshPoolNum()
end

function UIWDCQLiveBroadcastRoomShopWin.onWDCQLiveBroadcastRoomHotChange(group,phase,order)
if _this.group==group and _this.phase==phase and _this.order==order then
_this:refreshHotProgress()
end
end

function UIWDCQLiveBroadcastRoomShopWin.onWDCQLiveBroadcastRoomTotalHotChange()
_this:refreshNextReward()
_this:refreshTabReddot2()
end