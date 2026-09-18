







def_class("ActSub_limitInvestorWin",UIWindowBase)









function ActSub_limitInvestorWin:bindComponents()

self.showImage=UIImage.get(self,0)
self.title=UIImage.get(self,1)
self.price=UIText.get(self,2)
self.time=UIText.get(self,3)
self.listScroller=UIObject.get(self,4)
self.lock=UIObject.get(self,5)
self.buyBtn=UIButton.get(self,6)
self.click=UIButton.get(self,7)
self.Image=UIObject.get(self,8)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.click:setButtonClick(function()self:onClick()end)



end


function ActSub_limitInvestorWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.showImage);self.showImage=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.price);self.price=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.Image);self.Image=nil;
end



















local _this=nil
local taskItemIndex={
select=0,
taskDesc=1,
baseRewards=2,
upRewards=3,
getRewardBtn=4,
rewardBtnText=5,
gotFlag=6,
unfinishFlag=7,
}


local PfSpriteCfg=
{
[pfwindowslController.priceTypeStr.CNY]={'image_zmdjtzui_2',{-112,6},{28.3,8}},
[pfwindowslController.priceTypeStr.USD]={'image_zmdjtzui_8',{-193.98,6},{93.5,8}},
[pfwindowslController.priceTypeStr.HKD]={'image_zmdjtzui_9',{-193.98,6},{93.5,8}},
[pfwindowslController.priceTypeStr.TWD]={'image_zmdjtzui_11',{-193.98,6},{93.5,8}},
}


function ActSub_limitInvestorWin:onLoaded(...)
self:bindComponents()

end


function ActSub_limitInvestorWin:__delete()
self:unbindComponents()
end




function ActSub_limitInvestorWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eXianShiInvest
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

self.allReward=self.config.reward
self.allEXReward=self.config.exreward

local showModel=self.config.showModel
if showModel[1]==1 then
self.showImage:setChildUIModelShowTarget(showModel[2],showModel[3]or 1,{},eAnimationID.stand,false,false,0)
if showModel[4]then
self.showImage:setChildUIModelShowTargetOffset(showModel[4],showModel[5])
end
else
self.showImage:setChildUIModelRemoveTarget()
self.showImage:setChildIcon(showModel[2],true)
end
self.title:setSprite(globalABLookup.limitinvestorgift,self.config.titleIcon,true)
self:refreshTime()
self:refresh(true)
end

function ActSub_limitInvestorWin:isGotReward(rewardIdx)
if not self.info then
return false
end
return self.info:isGotReward(rewardIdx)
end

function ActSub_limitInvestorWin:isGotExReward(rewardIdx)
if not self.info then
return false
end
return self.info:isGotExReward(rewardIdx)
end

function ActSub_limitInvestorWin:isOpenEx()
if not self.info then
return false
end
return self.info:isOpenEx()
end


function ActSub_limitInvestorWin:onHide()

end

function ActSub_limitInvestorWin:refresh(isInit)

self:refreshListTop()

self.autoJumpIndex=nil

self.firstUnfinishTaskIndex=nil


self:refreshTaskList()


if not self.autoJumpIndex then

self.autoJumpIndex=self.firstUnfinishTaskIndex or 0
end



local jumpIndex=self.autoJumpIndex-1
if jumpIndex<0 then
jumpIndex=0
end
if isInit then
self.listScroller:setChildScrollViewSelectItem(jumpIndex,false,false,false)
end
end

function ActSub_limitInvestorWin:refreshTime()
if self.info then
local leftTime=self.info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp15(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp15(leftTime)))
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
end


function ActSub_limitInvestorWin:refreshListTop()

self.isBuyChaozhi=self:isOpenEx()


self.lock:setActive(not self.isBuyChaozhi)

self.buyBtn:setActive(not self.isBuyChaozhi)
self.click:setActive(not self.isBuyChaozhi)

local rechargeId=self.config.rechargeid
local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,rechargeId)
local price=rechargeCfg.rmb
if price then
self.price:setText(price)
local PFMoneyType=pfwindowslController:getPFMoneyType()
local cfg=PfSpriteCfg[PFMoneyType]
if cfg then
self.price:setChildAnchoredPosition(Vector2.New(cfg[3][1],cfg[3][2]))
self.Image:setSprite(globalABLookup.zongmenlevelinvestor,cfg[1],true)
self.Image:setChildAnchoredPosition(Vector2.New(cfg[2][1],cfg[2][2]))
end
else
logErr(FMT.fmt("找不到充值id: {0}对应的rmb价格配置",rechargeId))
end
end


function ActSub_limitInvestorWin:refreshTaskList()
local count=#self.allReward
self.listScroller:setChildScrollViewCreateGrids(count,1)
local dayOut=self:getDayOut()
local grids=self.listScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshTaskItem(grids[i-1],i,dayOut)
end
end


function ActSub_limitInvestorWin:refreshTaskItem(item,index,dayOut)
if item==nil then
item=self.listScroller:getChildScrollViewItemWidget(index-1)
end
dayOut=dayOut or 0
local Reward=self.allReward[index]
local exReward=self.allEXReward[index]
if item and Reward then

local descStr=FMT.fmt("第{0}天",mathHelper.numberToChinese(index))
item:SetChildText(taskItemIndex.taskDesc,descStr)


local isFinish=dayOut>=index
item:SetChildActive(taskItemIndex.unfinishFlag,not isFinish)


local taskGotState=self:isGotReward(index)
local taskGotExState=self:isGotExReward(index)
item:SetChildActive(taskItemIndex.getRewardBtn,isFinish and((not taskGotState)or(not taskGotExState)))
local rewardBtnText=((not self.isBuyChaozhi)and taskGotState and not taskGotExState)and"继续领取"or"领取"
item:SetChildText(taskItemIndex.rewardBtnText,rewardBtnText)
item:SetChildButtonClick(taskItemIndex.getRewardBtn,function()
self:onClickGetRewardBtn(index,taskGotState,taskGotExState)
end)

local gotFlag=false
if self.isBuyChaozhi then
gotFlag=taskGotExState
end

item:SetChildActive(taskItemIndex.gotFlag,isFinish and gotFlag)
item:SetChildActive(0,isFinish and not gotFlag)
item:SetChildActive(8,not taskGotExState and not self.isBuyChaozhi)
item:SetChildActive(10,taskGotState)
item:SetChildActive(11,taskGotExState)





local baseRewards=Reward
item:SetChildLayoutGroupCreateItems(taskItemIndex.baseRewards,#baseRewards)
local grids=item:GetChildLayoutGroupGridList(taskItemIndex.baseRewards)
for i=1,#baseRewards do
local widget=grids[i-1]
local reward=baseRewards[i]
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


local isGot=taskGotState
local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)



widget:SetChildGray(-1,not isFinish)
end


local upRewards=exReward
item:SetChildLayoutGroupCreateItems(taskItemIndex.upRewards,#upRewards)
local grids=item:GetChildLayoutGroupGridList(taskItemIndex.upRewards)
for i=1,#upRewards do
local widget=grids[i-1]
local reward=upRewards[i]
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


local isLock=not self.isBuyChaozhi
local isGot=taskGotExState
local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)



widget:SetChildGray(-1,not isFinish)
end



if isFinish and not self.autoJumpIndex then

if not taskGotState then

self.autoJumpIndex=index-1
end
elseif not isFinish then

local nowIndex=index-1
if not self.firstUnfinishTaskIndex or nowIndex<self.firstUnfinishTaskIndex then

self.firstUnfinishTaskIndex=nowIndex
end
end
end

end
function ActSub_limitInvestorWin:getDayOut()
if not self.info then
return
end
local start_time=self.info.start_time
local longTime=timeHelper.getServerShortTime()
local et=longTime-start_time

local day=1
local isOpen=true
if et<0 then
day=1
isOpen=false
else
local cc=math.ceil(et/60)
cc=math.floor(cc/60)
cc=math.floor(cc/24)
local DD=cc
day=DD+1
end
return day
end
function ActSub_limitInvestorWin:getGotList()
local gotList={}
local count=#self.allReward
for i=1,count do
if not self:isGotReward(i)then
gotList[i]=true
end
end
return gotList
end




function ActSub_limitInvestorWin:onBuyBtn()
if not self.isBuyChaozhi then

local dayOut=self:getDayOut()
self:showWindow("ActSub_limitInvestorBuyWin",{dayOut=dayOut,act_id=self.actid,sub_act_id=self.subid})
end
end



function ActSub_limitInvestorWin:onClick()
if not self.isBuyChaozhi then

local dayOut=self:getDayOut()
self:showWindow("ActSub_limitInvestorBuyWin",{dayOut=dayOut,act_id=self.actid,sub_act_id=self.subid})
end
end


function ActSub_limitInvestorWin:onClickGetRewardBtn(taskId,taskGotState)
if taskGotState and not self.isBuyChaozhi then


local dayOut=self:getDayOut()
self:showWindow("ActSub_limitInvestorBuyWin",{dayOut=dayOut,act_id=self.actid,sub_act_id=self.subid})
return
end


activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({taskId}))
end

function ActSub_limitInvestorWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end