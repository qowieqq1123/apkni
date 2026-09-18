







def_class("UIQianJiGeSGXDWin",UIWindowBase)









function UIQianJiGeSGXDWin:bindComponents()

self.animRoot=UIObject.get(self,0)
self.icon=UIObject.get(self,1)
self.cloud=UIObject.get(self,2)
self.title=UIText.get(self,3)
self.tipBg=UIObject.get(self,4)
self.txtTalk=UIText.get(self,5)
self.lock=UIObject.get(self,6)
self.click=UIButton.get(self,7)
self.model=UIObject.get(self,8)
self.listScroller=UIObject.get(self,9)
self.buyBtn=UIButton.get(self,10)
self.mjBtn=UIButton.get(self,11)
self.helpbtn=UIButton.get(self,12)
self.time=UIText.get(self,13)

self.click:setButtonClick(function()self:onClick()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.mjBtn:setButtonClick(function()self:onMjBtn()end)

self.helpbtn:setButtonClick(function()self:onHelpbtn()end)


self.sprite_button_qjgjnxx_1=0
self.sprite_button_qjgjnxx_2=1
self.sprite_button_qjgjnxx_3=2

end


function UIQianJiGeSGXDWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.tipBg);self.tipBg=nil;
_UIObject_release(self.txtTalk);self.txtTalk=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.mjBtn);self.mjBtn=nil;
_UIObject_release(self.helpbtn);self.helpbtn=nil;
_UIObject_release(self.time);self.time=nil;
end



















local taskItemIndex={
taskDesc=0,
baseRewards=1,
upRewards=2,
baseGot=5,
upGot=6,
}


function UIQianJiGeSGXDWin:onLoaded(...)
self:bindComponents()

self.model:setChildUIModelShowTarget(4077,1,{},eAnimationID.stand,false,false,0,nil)

self:showLeftPanel()

local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.cloud:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)
end


function UIQianJiGeSGXDWin:__delete()
self:unbindComponents()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
if self.tipsTimer then
self:stopTimerByID(self.tipsTimer)
self.tipsTimer=nil
end
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end
end




function UIQianJiGeSGXDWin:onShow(argtable,afterOnloaded)
local cfg=cfg_mijingtanxiantouziconfig()
self.config=cfg
self:refresh(true)


end


function UIQianJiGeSGXDWin:onHide()

end

function UIQianJiGeSGXDWin:refresh(isInit)

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

function UIQianJiGeSGXDWin:refreshListTop()

self.isBuyChaozhi=mysteryWeekActivityModel:getXDTouZiJhFlag()==1


self.lock:setActive(not self.isBuyChaozhi)

self.buyBtn:setActive(not self.isBuyChaozhi)
self.click:setActive(not self.isBuyChaozhi)



local endTime=mysteryWeekActivityModel:getXDTouZiMhTimeout()
local time=timeHelper.getServerShortTime()
if not self.timer then
local left=endTime-time

if left<=0 then
self.time:setText("上级密函已到期")
else
self.time:setText(FMT.fmt("上级密函将在<color=#fd8950>{0}</color>到期(<color=#fd8950>{1}</color>后）",timeHelper.dateServerStamp('%m月%d日',endTime),timeHelper.format_time_stamp7(left)))
end

self.timer=self:setTimer(30,0,function()
local time=timeHelper.getServerShortTime()
local left=endTime-time
if left<=0 then
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
self.time:setText("上级密函已到期")
else
self.time:setText(FMT.fmt("上级密函将在<color=#fd8950>{0}</color>到期(<color=#fd8950>{1}</color>后）",timeHelper.dateServerStamp('%m月%d日',endTime),timeHelper.format_time_stamp7(left)))
end

end)
end



end

function UIQianJiGeSGXDWin:isGotReward(index)
local rewardLast=mysteryWeekActivityModel:getXDTouZiFreeLayerLast()or 0
return index<=rewardLast
end

function UIQianJiGeSGXDWin:isGotExReward(index)
local rewardLast=mysteryWeekActivityModel:getXDTouZiFeeLayerLast()or 0
return index<=rewardLast
end

function UIQianJiGeSGXDWin:showLeftPanel()
local baseConfig=cfg_qianjigebaseconfig_get(1)
if baseConfig.model then
self.icon:setChildUIModelShowTarget(baseConfig.model[1],baseConfig.model[3]or 1,baseConfig.model[2],eAnimationID.stand)
self.icon:setChildUIModelShowFlipX(baseConfig.model[4]==1)
end
local mihantips=cfgHelper.get(cfg_mijingtanxiantouzibaseconfig_get,1,"mihantips")

if not self.tipsTimer then
local func=function()
self.txtTalk:setText(mihantips[math.random(1,#mihantips)])
self.txtTalk:setActive(true)
self.tipBg:setChildCanvasGroupAlpha(1)

self:setTimer(5,1,function()
self.txtTalk:setActive(false)
self.tipBg:setChildCanvasGroupAlpha(0)
end)
end
func()
self.tipsTimer=self:setTimer(8,0,func)
end

end


function UIQianJiGeSGXDWin:refreshTaskList()
local count=#self.config
local xdTouZiData=mysteryWeekActivityModel:getXDTouZiData()
local layerClear=xdTouZiData.passLayer
self.listScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.listScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshTaskItem(grids[i-1],i,layerClear)
end
end


function UIQianJiGeSGXDWin:refreshTaskItem(item,index,layerClear)
layerClear=layerClear or 0
local layerConfig=self.config[index]
local Reward=layerConfig.freeItems
local exReward=layerConfig.feeItems
if item and Reward then

local descStr=FMT.fmt("{0}层",index)
item:SetChildText(taskItemIndex.taskDesc,descStr)


local isFinish=layerClear>=index



local taskGotState=self:isGotReward(index)
local taskGotExState=self:isGotExReward(index)






local gotFlag=false
if self.isBuyChaozhi then
gotFlag=taskGotExState
end

item:SetChildActive(taskItemIndex.baseGot,isFinish and taskGotState)

item:SetChildActive(taskItemIndex.upGot,isFinish and taskGotExState)






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
if isFinish and not isGot then
self:onClickGetRewardBtn(index,taskGotState,taskGotExState)
else
self:onClickRewardItem(...)
end
end)





widget:SetChildActive(3,isFinish and not isGot)
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
if isFinish and not isGot then
self:onClickGetRewardBtn(index,taskGotState,taskGotExState)
else
self:onClickRewardItem(...)
end
end)

widget:SetChildActive(2,isLock)



widget:SetChildActive(3,not isLock and isFinish and not isGot)
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




function UIQianJiGeSGXDWin:onClick()
self:onBuyBtn()
end

function UIQianJiGeSGXDWin:onBuyBtn()
local jhFlag=mysteryWeekActivityModel:getXDTouZiJhFlag()
if jhFlag~=1 then
self:showWindow("UIQianJiGeSGXDBuyWin")
end
end

function UIQianJiGeSGXDWin:onMjBtn()
local fb=mysteryWeekActivityModel:getNextMystery()
if fb then
mysteryWeekActivityController:openWeekEnterWin(fb.id)
else
UIManager.error("世界暂无险地")
end
end


function UIQianJiGeSGXDWin:onClickGetRewardBtn(taskId,taskGotState)
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

function UIQianJiGeSGXDWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UIQianJiGeSGXDWin:onHelpbtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='qjg_xdtz_help_%s'})
end