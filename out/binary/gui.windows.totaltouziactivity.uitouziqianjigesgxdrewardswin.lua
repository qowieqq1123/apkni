







def_class("UITouZiQianJiGeSGXDRewardsWin",UIWindowBase)









function UITouZiQianJiGeSGXDRewardsWin:bindComponents()

self.model=UIObject.get(self,0)
self.listScroller=UIObject.get(self,1)
self.buyBtn=UIButton.get(self,2)
self.mjBtn=UIButton.get(self,3)
self.helpbtn=UIButton.get(self,4)
self.lock=UIObject.get(self,5)
self.click=UIButton.get(self,6)
self.time=UIText.get(self,7)
self.icon=UIObject.get(self,8)
self.tipBg=UIObject.get(self,9)
self.txtTalk=UIText.get(self,10)
self.bgModel=UIObject.get(self,11)
self.CnyImage=UIObject.get(self,12)
self.HWImage=UIObject.get(self,13)
self.NumberText=UIText.get(self,14)
self.HwSprite=UIImage.get(self,15)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.mjBtn:setButtonClick(function()self:onMjBtn()end)

self.helpbtn:setButtonClick(function()self:onHelpbtn()end)

self.click:setButtonClick(function()self:onClick()end)


self.sprite_button_qjgjnxx_1=0
self.sprite_button_qjgjnxx_2=1
self.sprite_button_qjgjnxx_3=2

end


function UITouZiQianJiGeSGXDRewardsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.mjBtn);self.mjBtn=nil;
_UIObject_release(self.helpbtn);self.helpbtn=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.tipBg);self.tipBg=nil;
_UIObject_release(self.txtTalk);self.txtTalk=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.CnyImage);self.CnyImage=nil;
_UIObject_release(self.HWImage);self.HWImage=nil;
_UIObject_release(self.NumberText);self.NumberText=nil;
_UIObject_release(self.HwSprite);self.HwSprite=nil;
end



















local taskItemIndex={
taskDesc=0,
baseRewards=1,
upRewards=2,
gotFlag=3,
suo=4,
baseGot=5,
upGot=6,
notRecvFlag=7,
recvBtn=8,
recvBtntxt=9,
taskDesc2=10,
reddot=11,
}


local commonItemIndex={
itemSmall=0,
gotFlag=1,
lock=2,
get=3,
}


local PfSpriteCfg=
{
[pfwindowslController.priceTypeStr.USD]='image_jiesuowenzi10',
[pfwindowslController.priceTypeStr.HKD]='image_jiesuowenzi9',
[pfwindowslController.priceTypeStr.TWD]='image_jiesuowenzi11',
}


function UITouZiQianJiGeSGXDRewardsWin:onLoaded(...)
self:bindComponents()
self.bgModel:setChildUIModelShowTarget(5541,1,{},eAnimationID.stand)

self.icon:setChildUIModelShowTarget(1113037,0.8,{},eAnimationID.stand)
self.icon:setChildUIModelShowFlipX(true)
self.winid:SetChildScale(self.tipBg:getID(),Vector3(1,1,1))
self.txtTalk:setText("尘世沧桑，千机万象")
end


function UITouZiQianJiGeSGXDRewardsWin:__delete()
self:unbindComponents()
if self.daoqiTimer then
self:stopTimerByID(self.daoqiTimer)
self.daoqiTimer=nil
end
if self.tipsTimer then
self:stopTimerByID(self.tipsTimer)
self.tipsTimer=nil
end

end




function UITouZiQianJiGeSGXDRewardsWin:onShow(argtable,afterOnloaded)
self.config=cfg_mijingtanxiantouziconfig()
self:refresh(true)
end


function UITouZiQianJiGeSGXDRewardsWin:onHide()

end

function UITouZiQianJiGeSGXDRewardsWin:refresh(isInit)

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

function UITouZiQianJiGeSGXDRewardsWin:refreshListTop()

self.isBuyChaozhi=mysteryWeekActivityModel:getXDTouZiJhFlag()==1


self.lock:setActive(not self.isBuyChaozhi)
self.isGuoFu=pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_yuenan()
if not self.isBuyChaozhi then
self.CnyImage:setActive(self.isGuoFu)
self.HWImage:setActive(not self.isGuoFu)
if not self.isGuoFu then
local baseCfg=cfgHelper.get(cfg_mijingtanxiantouzibaseconfig_get,1)
local jihuo=baseCfg.jihuo
self.jihuo=jihuo
if jihuo[1]==1 then

local rechargeId=jihuo[2]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
self.NumberText:setText(rechargecfg.rmb)
local PFMoneyType=pfwindowslController:getPFMoneyType()
local spriteName=PfSpriteCfg[PFMoneyType]
self.HwSprite:setSprite(globalABLookup.totaltouzi_atlas,spriteName,true)
end
end
end

self.buyBtn:setActive(false)
self.click:setActive(not self.isBuyChaozhi)
self:startDaoQiTimer()
end

function UITouZiQianJiGeSGXDRewardsWin:startDaoQiTimer()
local endTime=mysteryWeekActivityModel:getXDTouZiMhTimeout()
local time=timeHelper.getServerShortTime()
if not self.daoqiTimer then
local left=endTime-time
if left<=0 then
self.time:setText("上级密函已到期")
else

self.time:setText(FMT.fmt("本期剩余时间:{0}",timeHelper.format_time_stamp3(left)))
end

self.daoqiTimer=self:setTimer(30,0,function()
local time=timeHelper.getServerShortTime()
local left=endTime-time
if left<=0 then
if self.daoqiTimer then
self:stopTimerByID(self.daoqiTimer)
self.daoqiTimer=nil
end
self.time:setText("上级密函已到期")
else

self.time:setText(FMT.fmt("本期剩余时间:{0}",timeHelper.format_time_stamp3(left)))
end
end)
end
end

function UITouZiQianJiGeSGXDRewardsWin:isGotReward(index)
local rewardLast=mysteryWeekActivityModel:getXDTouZiFreeLayerLast()or 0
return index<=rewardLast
end

function UITouZiQianJiGeSGXDRewardsWin:isGotExReward(index)
local rewardLast=mysteryWeekActivityModel:getXDTouZiFeeLayerLast()or 0
return index<=rewardLast
end


function UITouZiQianJiGeSGXDRewardsWin:refreshTaskList()
local count=#self.config
local xdTouZiData=mysteryWeekActivityModel:getXDTouZiData()
local layerClear=xdTouZiData.passLayer
self.listScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.listScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshTaskItem(grids[i-1],i,layerClear)
end
end


function UITouZiQianJiGeSGXDRewardsWin:refreshTaskItem(item,index,layerClear)
layerClear=layerClear or 0
local layerConfig=self.config[index]
local Reward=layerConfig.freeItems
local exReward=layerConfig.feeItems
if item and Reward then

local descStr=FMT.fmt("{0}层",index)
item:SetChildText(taskItemIndex.taskDesc,descStr)


local isFinish=layerClear>=index
local descStr2=FMT.fmt("(<color=#{0}>{1}/{2}</color>)",isFinish and"298a1c"or"e03333",layerClear,index)
item:SetChildText(taskItemIndex.taskDesc2,descStr2)


local taskGotState=self:isGotReward(index)
local taskGotExState=self:isGotExReward(index)

local gotFlag=false
if self.isBuyChaozhi then
gotFlag=taskGotExState
end

item:SetChildActive(taskItemIndex.baseGot,false)

item:SetChildActive(taskItemIndex.upGot,false)
if isFinish then
item:SetChildActive(taskItemIndex.notRecvFlag,false)
if taskGotState and taskGotExState then
item:SetChildActive(taskItemIndex.recvBtn,false)
item:SetChildActive(taskItemIndex.gotFlag,true)
else
item:SetChildActive(taskItemIndex.recvBtn,true)
item:SetChildActive(taskItemIndex.gotFlag,false)
item:SetChildText(taskItemIndex.recvBtntxt,(taskGotState and not self.isBuyChaozhi)and"继续领取"or"领取")
item:SetChildActive(taskItemIndex.reddot,not(taskGotState and not self.isBuyChaozhi))
item:SetChildButtonClick(taskItemIndex.recvBtn,function()
self:onClickGetRewardBtn(index,taskGotState,taskGotExState)
end)
end
else
item:SetChildActive(taskItemIndex.notRecvFlag,true)
item:SetChildActive(taskItemIndex.recvBtn,false)
item:SetChildActive(taskItemIndex.gotFlag,false)
end





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

local conf={gray=isFinish and 0 or 0,itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


local isGot=taskGotState
local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(commonItemIndex.itemSmall,prop)
widget:SetBaseItemClickEvent(commonItemIndex.itemSmall,function(...)





self:onClickRewardItem(...)
end)
widget:SetChildActive(commonItemIndex.lock,false)

widget:SetChildActive(commonItemIndex.get,false)
widget:SetChildActive(commonItemIndex.gotFlag,isGot)
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

local conf={gray=isFinish and 0 or 0,itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


local isLock=not self.isBuyChaozhi
local isGot=taskGotExState
local isGrayMask=isGot or isLock
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(commonItemIndex.itemSmall,prop)
widget:SetBaseItemClickEvent(commonItemIndex.itemSmall,function(...)





self:onClickRewardItem(...)
end)

widget:SetChildActive(commonItemIndex.lock,isLock)




widget:SetChildActive(commonItemIndex.get,false)
widget:SetChildActive(commonItemIndex.gotFlag,isGot)
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




function UITouZiQianJiGeSGXDRewardsWin:onClick()
self:onBuyBtn()
end

function UITouZiQianJiGeSGXDRewardsWin:onBuyBtn()
local jhFlag=mysteryWeekActivityModel:getXDTouZiJhFlag()
if jhFlag~=1 then
self:showWindow("UIQianJiGeSGXDBuyWin")
end
end

function UITouZiQianJiGeSGXDRewardsWin:onMjBtn()
if not mysteryWeekActivityController:openFightWeekEnterWin()then
UIManager.error("本周上古险地进入次数已用完")
end
end


function UITouZiQianJiGeSGXDRewardsWin:onClickGetRewardBtn(taskId,taskGotState)
if taskGotState and not self.isBuyChaozhi then


self:showWindow("UIQianJiGeSGXDBuyWin")
return
end
local last=mysteryWeekActivityModel:getXDTouZiFreeLayerLast()

AudioManager.playAudio(503)
if taskId>last+1 then
mysteryWeekActivityController.send_4_73(0)
else
mysteryWeekActivityController.send_4_73(taskId)
end
end

function UITouZiQianJiGeSGXDRewardsWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UITouZiQianJiGeSGXDRewardsWin:onHelpbtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='qjg_xdtz_help_%s'})
end
