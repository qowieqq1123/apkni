







def_class("UISubAct_dabiaozengli_Win",UIWindowBase)









function UISubAct_dabiaozengli_Win:bindComponents()

self.topTipsText=UIText.get(self,0)
self.showRankBtn=UIButton.get(self,1)
self.rankFirstList=UIObject.get(self,2)
self.leftBtn=UIButton.get(self,3)
self.rightBtn=UIButton.get(self,4)
self.timeText=UIText.get(self,5)
self.bottomTipsText=UIText.get(self,6)
self.Content=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.time=UIText.get(self,9)
self.catpanel=UIObject.get(self,10)
self.catmodelone=UIObject.get(self,11)
self.catmodeltwo=UIObject.get(self,12)
self.catmodelthree=UIObject.get(self,13)
self.bgModel=UIObject.get(self,14)
self.dabiaonum=UIText.get(self,15)
self.catshopmodel=UIObject.get(self,16)
self.jumpbtns=UIButton.get(self,17)
self.biaoyu1=UIText.get(self,18)
self.biaoyu2=UIText.get(self,19)
self.reddotpanel=UIObject.get(self,20)
self.bxBtn=UIButton.get(self,21)
self.baoXiangReddot=UIImage.get(self,22)
self.moneyBg=UIButton.get(self,23)
self.moneyIcon=UIImage.get(self,24)
self.moneyNum=UIText.get(self,25)
self.moneyBg2=UIButton.get(self,26)
self.moneyIcon2=UIImage.get(self,27)
self.moneyNum2=UIText.get(self,28)

self.showRankBtn:setButtonClick(function()self:onShowRankBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.jumpbtns:setButtonClick(function()self:onJumpbtns()end)

self.bxBtn:setButtonClick(function()self:onBxBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.moneyBg2:setButtonClick(function()self:onMoneyBg2()end)



end


function UISubAct_dabiaozengli_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.topTipsText);self.topTipsText=nil;
_UIObject_release(self.showRankBtn);self.showRankBtn=nil;
_UIObject_release(self.rankFirstList);self.rankFirstList=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.bottomTipsText);self.bottomTipsText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.catpanel);self.catpanel=nil;
_UIObject_release(self.catmodelone);self.catmodelone=nil;
_UIObject_release(self.catmodeltwo);self.catmodeltwo=nil;
_UIObject_release(self.catmodelthree);self.catmodelthree=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.dabiaonum);self.dabiaonum=nil;
_UIObject_release(self.catshopmodel);self.catshopmodel=nil;
_UIObject_release(self.jumpbtns);self.jumpbtns=nil;
_UIObject_release(self.biaoyu1);self.biaoyu1=nil;
_UIObject_release(self.biaoyu2);self.biaoyu2=nil;
_UIObject_release(self.reddotpanel);self.reddotpanel=nil;
_UIObject_release(self.bxBtn);self.bxBtn=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.moneyBg2);self.moneyBg2=nil;
_UIObject_release(self.moneyIcon2);self.moneyIcon2=nil;
_UIObject_release(self.moneyNum2);self.moneyNum2=nil;
end
















local cmpItemIndex=
{
name=0,
item1=1,
buyLimit=6,
buyBtn=7,
freeBtn=8,
buyText=9,
resetFlag=10,
got=11,
selectBtn=12,
buyIcon=13,
}

local itemIndexList={1,2,3,4,5}

local itemCIndex=
{
item=0,
addRoot=1,
button=2,
change=3,
addRootimg=4,
}

local _this



function UISubAct_dabiaozengli_Win:onLoaded(...)
self:bindComponents()
_this=self
local on_new_day=function()
if self and not self.isClose and self.onRefresh then
self:onRefresh()
end
end
notifySystem:listenNotify(notifyConfig.onNewDay,on_new_day)


self._onMoneyChange=function(...)self:onMoneyChange(...)end

notifySystem:listenNotify(notifyConfig.on_money_changed,self._onMoneyChange)

end


function UISubAct_dabiaozengli_Win:__delete()
self:unbindComponents()
self.isOver=nil
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
end
notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)

UIManager:closeWindow("UILimitTimeGiftSelectWin")
_this=nil
end




function UISubAct_dabiaozengli_Win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.moneyType=eMoneyType.mtLingYu
self.isShowMoney=self.config.isShowMoney
self.fmTweenerList={}
if self.info then
local leftTime=self.info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("<color=#f1ce78>活动剩余时间：</color>{0}",timeHelper.format_time_stamp11(leftTime,true)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("<color=#f1ce78>活动剩余时间：</color>{0}",timeHelper.format_time_stamp11(leftTime,true)))
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end

end)
else
self.time:setText("活动已结束")
self.isOver=true
end

self.bgModel:setChildUIModelShowTarget(5220,1,{},eAnimationID.stand,false,false,0,nil)

local biaoyutxt=self.config.biaoyutxt
if biaoyutxt then
self.biaoyu1:setText(biaoyutxt[1]or"")
self.biaoyu2:setText(biaoyutxt[2]or"")
end
self:refreshdabiaoNum()
self:onRefresh()


local showList=self:sortReward(self.config.rewards)
if showList and#showList>0 then
local gridindex=0
for k,v in ipairs(showList)do
local giftData=activitiesHandle_dabiaozengli:getLiBaoData(self.actid,self.subid,v.listIndex)
local freebuyCount=giftData.freebuyCount or 0
if freebuyCount<=0 then
gridindex=k
break
end
end
if gridindex>0 then
self.rankFirstList:setChildScrollViewSelectItem(gridindex-1,false,false,false)
end
end
end


function UISubAct_dabiaozengli_Win:onHide()
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
end
end


function UISubAct_dabiaozengli_Win:refreshdabiaoNum()
local mydata=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
self.dabiaonum:setText(mydata.times or"0")
end


function UISubAct_dabiaozengli_Win:onRefresh()

self:refreshDailyReward()
self.showList=self:sortReward(self.config.rewards)
self.rankFirstList:setChildScrollViewCreateGrids(#self.showList,#self.showList)
self.rankFirstList:setChildScrollViewSelectItem(0,false,false,true)
local grids=self.rankFirstList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
self:refreshGiftItem(item,self.showList[i],self.showList[i].listIndex,i)
end
end

self:initMoneyItem()
self:initMoneyItem2()
end


function UISubAct_dabiaozengli_Win:sortReward(rewards)
local showList={}
for i,v in ipairs(rewards)do
local sortId=i
local item=v
item.listIndex=i
item.sortId=sortId
local giftData=activitiesHandle_dabiaozengli:getLiBaoData(self.actid,self.subid,i)

if giftData then
local freebuyCount=giftData.freebuyCount or 0
local buyCount=giftData.buyCount or 0
local buyLimit=item[5]
local isZeroReset=item[6]
local buyTime=giftData.buyTime

if isZeroReset==1 and buyTime~=nil then
if not timeHelper.isTodayStamp(timeHelper.convertLongStamp(buyTime))then
buyCount=0
freebuyCount=0
activitiesHandle_dabiaozengli:setLiBaoData(self.actid,self.subid,i,{buyCount=0,buyTime=nil})
end
end

local isSold=buyCount>=buyLimit
local isSold2=freebuyCount>0
if isSold and isSold2 then
item.sortId=sortId+10000
end
end
table.insert(showList,item)
end
table.sort(showList,function(a,b)
return a.sortId<b.sortId
end)
return showList
end


function UISubAct_dabiaozengli_Win:refreshGiftItemByIndex(listIndex,sortIndex)
local grid=self.rankFirstList:getChildScrollViewItemWidget(sortIndex-1)
if grid then
self:refreshGiftItem(grid,self.showList[sortIndex],listIndex,sortIndex)
end
end


function UISubAct_dabiaozengli_Win:refreshGiftItem(cmp,config,listIndex,sortIndex)
local mydata=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local freeitemList=config[2]
local itemList=config[3]
local isSelectFin=true

local giftData=activitiesHandle_dabiaozengli:getLiBaoData(self.actid,self.subid,listIndex)
local freebuyCount=giftData.freebuyCount or 0
local buyCount=giftData.buyCount or 0
local buyCostVal=config[4]
local buyLimit=config[5]
local isZeroReset=config[6]

local isSold=buyCount>=buyLimit
local isSoldfree=freebuyCount>0
local dabiaonume_cfg=self.config.dabiaonume or""
local yieldRate=self.config.yieldRate
if isSold and isSoldfree then
cmp:SetChildText(20,FMT.fmt("{0}次",config[1]))
cmp:SetChildText(0,"")
cmp:SetChildGray(1,true)
else
cmp:SetChildText(0,FMT.fmt("{0}次",config[1]))
cmp:SetChildText(20,"")
end


local timesNum=mydata.times or 0
local _str=FMT.fmt("累计{0}{1}次可解锁",dabiaonume_cfg,config[1])
local _isunlock=timesNum<config[1]
cmp:SetChildActive(13,_isunlock)
cmp:SetChildActive(21,not _isunlock)






if yieldRate and#yieldRate>0 then
if yieldRate[listIndex]then
cmp:SetChildActive(16,true)
cmp:SetChildText(17,yieldRate[listIndex]or"")
else
cmp:SetChildActive(16,false)
end
end


local rewards=freeitemList
local grids_up=cmp:GetChildCommonLayoutGroupWidgetList(3)
local rewardCount=#rewards
local gridIdxList=self:getGridIndexList(rewardCount)
local gridCount=grids_up.Count
for i=1,gridCount do
local widget
local gridIdx=gridIdxList[i]
if gridIdx<=grids_up.Count then
widget=grids_up[gridIdx-1]
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
local graynum=isSoldfree and 1 or 0
local itemConfig=itemsConfig.getConfig(itemid)
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false,showStageBg=true}
local item={itemid=itemid,itemcount=count==1 and 0 or count}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
if not itemConfig.stage then
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
widget:SetChildActive(-1,true)
widget:SetChildPropData(itemCIndex.item,prop)
widget:SetChildButtonClick(itemCIndex.button,function()
itemsComponentHelper.onItemClickEx(itemid,i)
end)

else
widget:SetChildActive(-1,false)
end
end

cmp:SetChildActive(5,isSoldfree)
cmp:SetChildActive(4,not isSoldfree)
cmp:SetChildButtonClick(4,function()
self:onBuyClick(listIndex,0,buyCostVal,freeitemList,freebuyCount,1,_isunlock,_str,nil)
end)



local grids_up2=cmp:GetChildCommonLayoutGroupWidgetList(7)
local grids_down2=cmp:GetChildCommonLayoutGroupWidgetList(8)
local rewardCount2=#itemList
cmp:SetChildActive(8,rewardCount2>2)
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
local itemKu=itemList[i]
if itemKu then
widget:SetChildActive(-1,true)

local num=#itemKu

local longPressFunc=function(...)
itemsComponentHelper.onItemClickEx(itemKu[1][1],i)
end
local graynum=isSold and 1 or 0
if num>1 then
local selectIndex=nil
if not self.isOver then
selectIndex=activitiesHandle_dabiaozengli:getLiBaoSelectData(self.actid,self.subid,listIndex,i)
end

if selectIndex then
local longPressFunc2=function(...)
itemsComponentHelper.onItemClickEx(itemKu[selectIndex][1],i)
end
widget:SetChildActive(itemCIndex.item,true)
widget:SetChildActive(itemCIndex.addRoot,false)
widget:SetChildActive(itemCIndex.change,true)
local itemConfig=itemsConfig.getConfig(itemKu[selectIndex][1])
local conf={showname=true,showcount=true,gray=graynum,showCountBG=itemKu[selectIndex][2]>1,itemcount=itemKu[selectIndex][2]==1 and"",nomalname=true,select=false,showStageBg=true}
local item={itemid=itemKu[selectIndex][1],itemcount=itemKu[selectIndex][2]==1 and 0 or itemKu[selectIndex][2]}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
if not itemConfig.stage then
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
widget:SetChildPropData(itemCIndex.item,prop)
widget:SetChildLongTouch(itemCIndex.button,i,0.5,longPressFunc2)
widget:SetChildButtonClick(itemCIndex.change,function()
if not isSold then
self:onAddClick(listIndex,sortIndex,itemList)
end
end)
else

isSelectFin=false
widget:SetChildActive(itemCIndex.item,false)
widget:SetChildActive(itemCIndex.addRoot,true)
widget:SetChildLongTouch(itemCIndex.button,i,0.5,nil)
widget:SetChildActive(itemCIndex.change,false)
widget:SetChildGray(itemCIndex.addRootimg,isSold)
end
widget:SetChildActive(itemCIndex.button,true)
widget:SetChildButtonClick(itemCIndex.button,function()
if not isSold then
self:onAddClick(listIndex,sortIndex,itemList)
end
end)
else

widget:SetChildActive(itemCIndex.change,false)
widget:SetChildActive(itemCIndex.item,true)
widget:SetChildActive(itemCIndex.addRoot,false)
widget:SetChildActive(itemCIndex.button,true)
local itemConfig=itemsConfig.getConfig(itemKu[1][1])
local conf={showname=false,showcount=true,gray=graynum,showCountBG=itemKu[1][2]>1,itemcount=itemKu[1][2]==1 and"",nomalname=true,select=false,showStageBg=true}
local item={itemid=itemKu[1][1],itemcount=itemKu[1][2]}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
if not itemConfig.stage then
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
widget:SetChildPropData(itemCIndex.item,prop)
widget:SetChildButtonClick(itemCIndex.button,function()
itemsComponentHelper.onItemClickEx(itemKu[1][1],i)
end)
widget:SetChildLongTouch(itemCIndex.button,i,0.5,longPressFunc)
end
else
widget:SetChildActive(-1,false)
end
end


local isActiveBuyBtn=false
local isActiveselectBtn=false
if isSelectFin then


isActiveselectBtn=false
isActiveBuyBtn=not isSold
if buyCostVal then
cmp:SetChildActive(11,true)
cmp:SetChildActive(18,false)
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,buyCostVal)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
cmp:SetChildText(11,str)
cmp:SetChildButtonClick(10,function()
self:onBuyClick(listIndex,-1,buyCostVal,itemList,buyCount,buyLimit,_isunlock,_str,nil)
end)
else
local buyCost=config[7][1]
if buyCost then
local haveMoney=moneyModel.getMoney(buyCost[1])
local costCnt=buyCost[2]
local colorStr=haveMoney>=costCnt and"F9F9F9"or"c82c2c"
local costStr=FMT.fmt("<color=#{0}>{1}</color>",colorStr,costCnt)
cmp:SetChildActive(11,false)
cmp:SetChildActive(18,true)
cmp:SetChildText(18,costStr)
cmp:SetChildIcon(19,iconHelper.getIconName(buyCost[1]),false)
cmp:SetChildButtonClick(10,function()
self:onBuyClick(listIndex,1,buyCostVal,itemList,buyCount,buyLimit,_isunlock,_str,buyCost)
end)
end
end
else
isActiveBuyBtn=false
isActiveselectBtn=not isSold
cmp:SetChildButtonClick(14,function()
self:onAddClick(listIndex,sortIndex,itemList)
end)
end
cmp:SetChildText(9,FMT.fmt("限购:{0}/{1}",buyCount,buyLimit))
cmp:SetChildActive(9,not isSold)
cmp:SetChildActive(10,isActiveBuyBtn)
cmp:SetChildActive(12,isSold)
cmp:SetChildActive(14,isActiveselectBtn)

end


function UISubAct_dabiaozengli_Win:onBuyClick(listIndex,buyCostType,buyCostVal,itemList,buyCount,buyLimit,_isunlock,_str,buyCost)
if self.isOver then
UIManager.error("活动已结束")
return
end
if _isunlock and _str then
UIManager.error(_str)
return
end
AudioManager.playBtnClick()


if buyCostType==0 then

local conf={}
for i,v in ipairs(itemList)do
local itemid=v[1]
local count=v[2]
table.insert(conf,{itemid=itemid,num=count})
end
local mydata=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local timesNum=mydata.times or 0
local _temp={}
for k,v in ipairs(self.showList)do
local giftData=activitiesHandle_dabiaozengli:getLiBaoData(self.actid,self.subid,v.listIndex)
local freebuyCount=giftData.freebuyCount or 0
local isSoldfree=freebuyCount>0
local isunlock=timesNum<v[1]
if not isSoldfree and not isunlock then
_temp[#_temp+1]={v.listIndex,1}
end
end
local info={2,_temp}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonStr)
self.showRewardFunc=function()
if next(conf)then

end
end
end

if buyCostType==1 then

if buyCost then
local isEnough=moneyModel.checkEnoughMoney(buyCost[1],buyCost[2])
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

local showItem={}
local indexList={}
for i,v in ipairs(itemList)do
local selectIndex=activitiesHandle_dabiaozengli:getLiBaoSelectData(self.actid,self.subid,listIndex,i)
if selectIndex then
indexList[i]=selectIndex
table.insert(showItem,v[selectIndex])
else
indexList[i]=1
table.insert(showItem,v[1])
end
end

local conf={}
for i,v in ipairs(showItem)do
local itemid=v[1]
local count=v[2]
table.insert(conf,{itemid=itemid,num=count})
end
local info={1,listIndex,1,indexList}
local cb=function(...)
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonStr)
end
moneySystem:useMoney(buyCost[1],buyCost[2],cb,WARNING_TYPE.eWarning)
end
end

if buyCostType==-1 then
if self.payTimer then
return
end
local showItem={}
local indexList={}
for i,v in ipairs(itemList)do
local selectIndex=activitiesHandle_dabiaozengli:getLiBaoSelectData(self.actid,self.subid,listIndex,i)
if selectIndex then
indexList[i]=selectIndex
table.insert(showItem,v[selectIndex])
else
indexList[i]=1
table.insert(showItem,v[1])
end
end

local conf={}
for i,v in ipairs(showItem)do
local itemid=v[1]
local count=v[2]
table.insert(conf,{itemid=itemid,num=count})
end
local info={listIndex,1}
for i,v in ipairs(indexList)do
table.insert(info,v)
end
local params=payControl.getActivityPayParams(self.actid,self.subType,self.subid,info)
payControl.reqPay(buyCostVal,1,params)
self.showRewardFunc=function()
if next(conf)then
showPrizeControl.showWindowNow(conf)
end
end
if not self.payTimer then
self.payTimer=self:setTimer(1,1,function()
self.payTimer=nil
end)
end
end
end

function UISubAct_dabiaozengli_Win:onblackClick(str)
UIManager.error(str)
end

function UISubAct_dabiaozengli_Win:onAddClick(listIndex,sortIndex,itemList)
AudioManager.playBtnClick()
UIManager:showWindow("UILimitTimeGiftSBZLSelectWin",{actid=self.actid,subid=self.subid,perentWin=self,rewardIndex=listIndex,sortIndex=sortIndex,itemList=itemList})
end


function UISubAct_dabiaozengli_Win:onJumpbtns()
local jumpParam=self.config.jumpParam
if jumpParam then
jumpManager:jump(jumpParam)
AudioManager.playBtnClick()
end
end




function UISubAct_dabiaozengli_Win:getGridIndexList(count)
if count==3 then
return{1,3,4,2}
else
return{1,2,3,4}
end
end

function UISubAct_dabiaozengli_Win:onShowRankBtn()
end
function UISubAct_dabiaozengli_Win:onLeftBtn()
end
function UISubAct_dabiaozengli_Win:onRightBtn()
end


function UISubAct_dabiaozengli_Win:refreshDailyReward()

local isGot=self.info:reqDaBiaoZengLi_checkDailyRewardsIsGot()

if isGot then

self.reddotpanel:setActive(false)
self.bgModel:setChildModelAnimationState(eAnimationID.stand2)
else
self.reddotpanel:setActive(true)
self:doPunchRotation(true)
end
end

function UISubAct_dabiaozengli_Win:onBxBtn()

local isGot=self.info:reqDaBiaoZengLi_checkDailyRewardsIsGot()
if isGot then

return
end

self.info:reqDaBiaoZengLi_getDailyRewards()
end


function UISubAct_dabiaozengli_Win:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.baoXiangReddot:setRotation(0,0,0)
local tweener=self.baoXiangReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.baoXiangReddot:setRotation(0,0,0)
end
end
end


function UISubAct_dabiaozengli_Win:onMoneyBg()
local itemId=eMoneyType.mtLingYu
gainControl:showCommonGainWin_item(itemId)
end
function UISubAct_dabiaozengli_Win:initMoneyItem()
local itemId=eMoneyType.mtLingYu
local iconname=iconHelper.getIconName(itemId)
self.moneyIcon:setIcon(iconname)
self:refreshMoney()
end
function UISubAct_dabiaozengli_Win:refreshMoney()
local itemId=eMoneyType.mtLingYu
local count=itemsModel.getCount(itemId)
self.moneyNum:setText(count)
end
function UISubAct_dabiaozengli_Win:onMoneyChange(moneyType,lastVal,val)
if moneyType==eMoneyType.mtLingYu then
self:refreshMoney()
end
if moneyType==eMoneyType.mtXianYu then
self:refreshMoney2()
end
end

function UISubAct_dabiaozengli_Win:onMoneyBg2()
local itemId=eMoneyType.mtXianYu
gainControl:showCommonGainWin_item(itemId)
end
function UISubAct_dabiaozengli_Win:initMoneyItem2()
local itemId=eMoneyType.mtXianYu
local iconname=iconHelper.getIconName(itemId)
self.moneyIcon2:setIcon(iconname)
self:refreshMoney2()
end
function UISubAct_dabiaozengli_Win:refreshMoney2()
local itemId=eMoneyType.mtXianYu
local count=itemsModel.getCount(itemId)
self.moneyNum2:setText(count)
end
