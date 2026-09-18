







def_class("UIXM_ZZSH_endTipsWin",UIWindowBase)









function UIXM_ZZSH_endTipsWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.tipsText=UIText.get(self,2)
self.infoScrollView=UIObject.get(self,3)
self.oneKeyBtn=UIButton.get(self,4)
self.finishFlag=UIObject.get(self,5)
self.clearTimeText=UIText.get(self,6)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.oneKeyBtn:setButtonClick(function()self:onOneKeyBtn()end)



end


function UIXM_ZZSH_endTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.infoScrollView);self.infoScrollView=nil;
_UIObject_release(self.oneKeyBtn);self.oneKeyBtn=nil;
_UIObject_release(self.finishFlag);self.finishFlag=nil;
_UIObject_release(self.clearTimeText);self.clearTimeText=nil;
end
















local infoCfgList={
{
index=1,
iconAb="ui/windows/xianmeng/act_zhengzhanshanhai/zzshseason_atlas_pak.ab",
iconName="image_shanhaipaihang_2",
name="山海宝匣",
reddotType=2,
reddotCheckFunc=function()
local num=zhengzhanshanhaiModel:isBXReddot()
local isReddot=num>0
return isReddot,num
end,
clickFunc=function()
UIManager:showWindow('UIXM_ZZSH_TreasureBoxWin')
end,
},
{
index=2,
iconAb="ui/windows/xianmeng/act_zhengzhanshanhai/zzshseason_atlas_pak.ab",
iconName="image_shanhaipaihang_3",
name="山海日志",
reddotType=3,
reddotCheckFunc=function()
local isReddot=zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()
local num=isReddot and 1 or 0
return isReddot,num
end,
clickFunc=function()
zhengzhanshanhaiController:OpenZhengZhanShanHaiFightLog()
end,
}
}

local infoItemCmpIndex={
icon=0,
desc=1,
reddotType1=2,
reddotType2=3,
reddotType3=4,
reddotNum=5,
name=6,
}




function UIXM_ZZSH_endTipsWin:onLoaded(...)
self:bindComponents()
self._onShowPrize=function(...)
self:onShowPrize(...)
end
self:addNotify(notifyConfig.onShowPrize,self._onShowPrize)
end


function UIXM_ZZSH_endTipsWin:__delete()
self:clearTimer()
self:unbindComponents()
end




function UIXM_ZZSH_endTipsWin:onShow(argtable,afterOnloaded)
self:refresh(true)
end


function UIXM_ZZSH_endTipsWin:onHide()
self:clearTimer()
end

function UIXM_ZZSH_endTipsWin:refresh(isInit)
local infoCount=0
if isInit then

self.infoList={}
for _,cfg in ipairs(infoCfgList)do
local reddotFunc=cfg.reddotCheckFunc
local isReddot,num=reddotFunc()
if isReddot then
self.infoList[#self.infoList+1]={cfg=cfg,reddotNum=num}
infoCount=infoCount+1
end
end
self.infoScrollView:setChildScrollViewCreateGrids(infoCount,1)
self:refreshInfoScrollView()
else
infoCount=#self.infoList
self:refreshInfoScrollView_resetReddot()
end


local isAllFinish=true
if infoCount>0 then
for i,v in ipairs(self.infoList)do
if v.reddotNum and v.reddotNum>0 then
isAllFinish=false
break
end
end
end

self.finishFlag:setActive(isAllFinish)
self.oneKeyBtn:setActive(not isAllFinish)


self:setRemainingTimeTimer()
end


function UIXM_ZZSH_endTipsWin:refreshInfoScrollView()
local grids=self.infoScrollView:getChildScrollViewItemWidgets()
local descTextList=zhengzhanshanhaiController:getZZSHCfg("endTipsText")
if not descTextList then

descTextList=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,1,"endTipsText")
end
for i=1,grids.Count do
local widget=grids[i-1]
local infoData=self.infoList[i]
if infoData then
widget:SetChildActive(-1,true)
local cfg=infoData.cfg

local iconAb=cfg.iconAb
local iconName=cfg.iconName
widget:SetChildCSImageSprite(infoItemCmpIndex.icon,iconAb,iconName)


local reddotType=cfg.reddotType
widget:SetChildActive(infoItemCmpIndex.reddotType1,reddotType==1)
widget:SetChildActive(infoItemCmpIndex.reddotType2,reddotType==2)
widget:SetChildActive(infoItemCmpIndex.reddotType3,reddotType==3)
if reddotType==2 then
local reddotNum=infoData.reddotNum
widget:SetChildText(infoItemCmpIndex.reddotNum,reddotNum)
end


local name=cfg.name
widget:SetChildText(infoItemCmpIndex.name,name)


local index=cfg.index
local desc=descTextList[index]
widget:SetChildText(infoItemCmpIndex.desc,desc)


local clickFunc=cfg.clickFunc
widget:SetChildButtonClick(infoItemCmpIndex.icon,clickFunc)
end
end
end


function UIXM_ZZSH_endTipsWin:refreshInfoScrollView_resetReddot()
local grids=self.infoScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local infoData=self.infoList[i]
if infoData then
widget:SetChildActive(-1,true)
local cfg=infoData.cfg

local reddotFunc=cfg.reddotCheckFunc
local isReddot,num=reddotFunc()
infoData.reddotNum=num
if isReddot then
local reddotType=cfg.reddotType
widget:SetChildActive(infoItemCmpIndex.reddotType1,reddotType==1)
widget:SetChildActive(infoItemCmpIndex.reddotType2,reddotType==2)
widget:SetChildActive(infoItemCmpIndex.reddotType3,reddotType==3)
if reddotType==2 then
local reddotNum=infoData.reddotNum
widget:SetChildText(infoItemCmpIndex.reddotNum,reddotNum)
end
else
widget:SetChildActive(infoItemCmpIndex.reddotType1,false)
widget:SetChildActive(infoItemCmpIndex.reddotType2,false)
widget:SetChildActive(infoItemCmpIndex.reddotType3,false)
end
end
end
end

function UIXM_ZZSH_endTipsWin:refreshClearTime()
local start_time,end_time,settle_time,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
local nowTime=timeHelper.getServerLongTime()
local deltaTime=settleEndTime-nowTime
local timeStr=timeHelper.format_time_stamp11(deltaTime,true)


local cfgStr
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then
cfgStr="        本次山海赛季将于{0}后结束，日志奖励即将被清空，需及时处理哦！"
else
cfgStr="        本次山海赛季将于{0}后结束，山海宝匣魂钥即将回收、日志奖励即将被清空，\n需及时处理哦！"
end

local tipsStr=FMT.fmt(cfgStr,timeStr)
self.tipsText:setText(tipsStr)


local clearTimeStr=string.format("奖励清空剩余时间：<color=#C82C2C>%s</color>",timeStr)
self.clearTimeText:setText(clearTimeStr)

if deltaTime<=0 then
self:clearTimer()
end
end


function UIXM_ZZSH_endTipsWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshClearTime()
end

self.timer=self:setTimer(1,0,func)

self:refreshClearTime()
end


function UIXM_ZZSH_endTipsWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIXM_ZZSH_endTipsWin:onShowPrize(prizeType,temp,effectData,temp2)
if prizeType==ePrizeType.eZZSHOneKeyGetReward then
for i,v in ipairs(temp)do
showPrizeControl.insertCommon(self.commonList,self.commonLookup,v.itemguid,v.itemid,v.num,true)
end
local cd=1
self:clearShowPrizeTimer()
self.showPrizeTimer=self:setTimer(1,cd,function()
local rewardlist=self.commonList
showPrizeControl.showWindow(rewardlist)
self.commonList={}
self.commonLookup={}
end)
end
end

function UIXM_ZZSH_endTipsWin:clearShowPrizeTimer()
if self.showPrizeTimer then
self:stopTimerByID(self.showPrizeTimer)
self.showPrizeTimer=nil
end
end




function UIXM_ZZSH_endTipsWin:onClickMask()
return self:onCloseBtn()
end



function UIXM_ZZSH_endTipsWin:onCloseBtn()
self:closeSelf()
end



function UIXM_ZZSH_endTipsWin:onOneKeyBtn()
self.commonList={}
self.commonLookup={}
local temp
local getBoxListFunc=function(config)
local list={}
for k,v in ipairs(config)do
if v.recv<v.cfg.max then
local consume=v.cfg.consume[1]
local boxCount=moneyModel.getMoney(consume[1])or 0
local box_cost=consume[2]
local canOpenBoxCount=v.cfg.max-v.recv

if canOpenBoxCount<0 then canOpenBoxCount=0 end
local isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false

if canOpenBoxCount>0 and not isEnoughOpen and boxCount>=box_cost then
canOpenBoxCount=math.floor(boxCount/box_cost)
isEnoughOpen=boxCount>=box_cost*canOpenBoxCount or false
end

if isEnoughOpen then
temp={v.idx,canOpenBoxCount}
table.insert(list,temp)
end
end
end
return list
end


local config_initial=zhengzhanshanhaiModel:getTreasureBoxData_initial()
local boxList_initial=config_initial and getBoxListFunc(config_initial)or nil


local config_season=zhengzhanshanhaiModel:getTreasureBoxData_season()
local boxList_season=config_season and getBoxListFunc(config_season)or nil


local guid_tb=zhengzhanshanhaiModel:Find_allLogReward()


local prizeType=ePrizeType.eZZSHOneKeyGetReward
if boxList_initial and next(boxList_initial)then

zhengzhanshanhaiController:reqOpenBaoXia(#boxList_initial,boxList_initial,true,false,prizeType)
end
if boxList_season and next(boxList_season)then

zhengzhanshanhaiController:reqOpenBaoXia(#boxList_season,boxList_season,true,true,prizeType)
end
if next(guid_tb)then

zhengzhanshanhaiController:Send_reward_req(#guid_tb,guid_tb,prizeType)
end
end

