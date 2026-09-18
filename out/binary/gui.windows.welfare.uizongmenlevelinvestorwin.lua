







def_class("UIZongmenLevelInvestorWin",UIWindowBase)









function UIZongmenLevelInvestorWin:bindComponents()

self.lock=UIObject.get(self,0)
self.buyBtn=UIButton.get(self,1)
self.price=UIText.get(self,2)
self.listScroller=UIObject.get(self,3)
self.click=UIButton.get(self,4)
self.Image=UIImage.get(self,5)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.click:setButtonClick(function()self:onClick()end)



end


function UIZongmenLevelInvestorWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.price);self.price=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
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
[pfwindowslController.priceTypeStr.CNY]={'image_zmdjtzui_2',{-128,5.8},{62,5.8}},
[pfwindowslController.priceTypeStr.USD]={'image_zmdjtzui_8',{-198,5.8},{126,5.8}},
[pfwindowslController.priceTypeStr.HKD]={'image_zmdjtzui_9',{-198,5.8},{126,5.8}},
[pfwindowslController.priceTypeStr.TWD]={'image_zmdjtzui_11',{-198,5.8},{126,5.8}},
[pfwindowslController.priceTypeStr.VND]={'image_zmdjtzui_8',{-90,5.8},{55,5.8}},
}



function UIZongmenLevelInvestorWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIZongmenLevelInvestorWin:__delete()
_this=nil
self:unbindComponents()
end




function UIZongmenLevelInvestorWin:onShow(argtable,afterOnloaded)
self.allTaskCfg=cfg_guildinvestconfig()
self.baseCfg=cfgHelper.get1(cfg_guildinvestbasicconfig_get,1)
self.zmLevel=zongmenModel:getLevel()

self:onShowArgRecv()
end


function UIZongmenLevelInvestorWin:onHide()

end


function UIZongmenLevelInvestorWin:onShowArgRecv()

self.autoJumpIndex=nil

self.firstUnfinishTaskIndex=nil

self:refresh()


if not self.autoJumpIndex then

self.autoJumpIndex=self.firstUnfinishTaskIndex or 0
end


local jumpIndex=self.autoJumpIndex-1
if jumpIndex<0 then
jumpIndex=0
end

self.listScroller:setChildScrollViewSelectItem(jumpIndex,false,false,false)
end

function UIZongmenLevelInvestorWin:refresh()

self:refreshListTop()


self:refreshTaskList()
end


function UIZongmenLevelInvestorWin:refreshListTop()

self.isBuyChaozhi=welfareModel:checkZongmenLevelInvestorBuy()


self.lock:setActive(not self.isBuyChaozhi)

self.buyBtn:setActive(not self.isBuyChaozhi)
self.click:setActive(not self.isBuyChaozhi)

local rechargeId=self.baseCfg.recharge_id
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


function UIZongmenLevelInvestorWin:refreshTaskList()
local count=#self.allTaskCfg
self.listScroller:setChildScrollViewCreateGrids(count,1)

local grids=self.listScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshTaskItem(grids[i-1],i)

end
end


function UIZongmenLevelInvestorWin:refreshTaskItem(item,index)
if item==nil then
item=self.listScroller:getChildScrollViewItemWidget(index-1)
end


local taskCfg=self.allTaskCfg[index]
if item and taskCfg then

local needCount=taskCfg.aimnum
local descStr=FMT.fmt("宗门等级达到<color=#ca631d>{0}级</color>",needCount)
item:SetChildText(taskItemIndex.taskDesc,descStr)


local isFinish=self.zmLevel>=needCount
item:SetChildActive(taskItemIndex.unfinishFlag,not isFinish)


local taskGotState=welfareModel:checkZongmenLevelInvestorTaskStateByTaskId(taskCfg.id)or 0
item:SetChildActive(taskItemIndex.getRewardBtn,isFinish and taskGotState~=2)
local rewardBtnText=taskGotState==0 and"领取"or"继续领取"
item:SetChildText(taskItemIndex.rewardBtnText,rewardBtnText)
item:SetChildButtonClick(taskItemIndex.getRewardBtn,function()
self:onClickGetRewardBtn(taskCfg.id,taskGotState)
end)


item:SetChildActive(taskItemIndex.gotFlag,isFinish and taskGotState==2)





local baseRewards=taskCfg.comm_rewards
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


local isGot=taskGotState~=0
local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


widget:SetChildActive(1,isGot)

end


local upRewards=taskCfg.recharge_rewards
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
local isGot=taskGotState==2
local isGrayMask=isGot or isLock
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


widget:SetChildActive(1,isGot)

end


if isFinish and not self.autoJumpIndex then

if taskGotState==0 then

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





function UIZongmenLevelInvestorWin:onBuyBtn()

UIFullWelfareController:showWindow("UIZongmenLevelInvestorBuyWin")
end


function UIZongmenLevelInvestorWin:onClickGetRewardBtn(taskId,taskGotState)
if taskGotState==1 and not self.isBuyChaozhi then


UIFullWelfareController:showWindow("UIZongmenLevelInvestorBuyWin")
return
end


welfareController:reqZongmenLevelInvestorGetReward(taskId)
end

function UIZongmenLevelInvestorWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UIZongmenLevelInvestorWin:onClick()

end
