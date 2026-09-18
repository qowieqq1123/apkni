







def_class("UIRuiShouLinMenWin",UIWindowBase)









function UIRuiShouLinMenWin:bindComponents()

self.background=UIButton.get(self,0)
self.boxRoot=UIObject.get(self,1)
self.segment_3=UIText.get(self,2)
self.segment_2=UIText.get(self,3)
self.feedBtn=UIButton.get(self,4)
self.segment_1=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.content=UIObject.get(self,7)
self.progress1=UIProgress.get(self,8)
self.tipsRoot=UIObject.get(self,9)
self.uiModel=UIObject.get(self,10)
self.progress2=UIProgress.get(self,11)
self.buffList=UIObject.get(self,12)
self.nameTx=UIText.get(self,13)
self.box_6=UIButton.get(self,14)
self.box_1=UIButton.get(self,15)
self.box_2=UIButton.get(self,16)
self.box_3=UIButton.get(self,17)
self.box_4=UIButton.get(self,18)
self.box_5=UIButton.get(self,19)
self.onAddBtn=UIButton.get(self,20)
self.btnpanel=UIObject.get(self,21)
self.uipanel=UIObject.get(self,22)

self.background:setButtonClick(function()self:onBackground()end)

self.feedBtn:setButtonClick(function()self:onFeedBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.box_6:setButtonClick(function()self:onBox_6()end)

self.box_1:setButtonClick(function()self:onBox_1()end)

self.box_2:setButtonClick(function()self:onBox_2()end)

self.box_3:setButtonClick(function()self:onBox_3()end)

self.box_4:setButtonClick(function()self:onBox_4()end)

self.box_5:setButtonClick(function()self:onBox_5()end)

self.onAddBtn:setButtonClick(function()self:onOnAddBtn()end)
self.segment={
self.segment_1,
self.segment_2,
self.segment_3,
}
self.box={
self.box_1,
self.box_2,
self.box_3,
self.box_4,
self.box_5,
self.box_6,
}



end


function UIRuiShouLinMenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.boxRoot);self.boxRoot=nil;
_UIObject_release(self.segment_3);self.segment_3=nil;
_UIObject_release(self.segment_2);self.segment_2=nil;
_UIObject_release(self.feedBtn);self.feedBtn=nil;
_UIObject_release(self.segment_1);self.segment_1=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.progress1);self.progress1=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.uiModel);self.uiModel=nil;
_UIObject_release(self.progress2);self.progress2=nil;
_UIObject_release(self.buffList);self.buffList=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.box_6);self.box_6=nil;
_UIObject_release(self.box_1);self.box_1=nil;
_UIObject_release(self.box_2);self.box_2=nil;
_UIObject_release(self.box_3);self.box_3=nil;
_UIObject_release(self.box_4);self.box_4=nil;
_UIObject_release(self.box_5);self.box_5=nil;
_UIObject_release(self.onAddBtn);self.onAddBtn=nil;
_UIObject_release(self.btnpanel);self.btnpanel=nil;
_UIObject_release(self.uipanel);self.uipanel=nil;
self.segment=nil;
self.box=nil;
end



















function UIRuiShouLinMenWin:onLoaded(...)
self:bindComponents()
self._tryAddProgress=function(value)
self:tryAddProgress(value)
end
self._cancelTryProgress=function()
self:cancelTryProgress()
end
self.boxes={}
self.uipanel:setChildCanvasGroupAlpha(0)
self.content:setChildUIModelShowTarget(5258,1,nil,5,false,false,0,function()
self.progress1:setActive(true)
self.closeBtn:setActive(true)
self.tipsRoot:setActive(true)
self.feedBtn:setActive(true)
self.boxRoot:setActive(true)
self:delayDo(0.3,function()
self.uipanel:setChildCanvasGroupDOFade(1,0.5,nil)
end)
for i,v in ipairs(self.segment)do
v:setActive(true)
end
end)
end


function UIRuiShouLinMenWin:__delete()
self:unbindComponents()
end




function UIRuiShouLinMenWin:onShow(argtable,afterOnloaded)
local curEventId=emergenciesModel:getCurrentEventId()
self.eventId=curEventId
if self.eventId<=0 then

self.eventId=emergenciesModel:getOldEventIdByType(emergenciesType.eRuiShouLinMen)or self.eventId
else
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,self.eventId)
if cfg.event_type~=emergenciesType.eRuiShouLinMen then
self.eventId=emergenciesModel:getOldEventIdByType(emergenciesType.eRuiShouLinMen)
end
end
if self.eventId<=0 then

UIFullRuiShouLinMenControl:closeUI(true)
end
self.eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,self.eventId)
local stageCfg=self.eventCfg.event_conf.stage
local curFeed,maxFeed

self.isNowEvent=self.eventId>0 and self.eventId==curEventId
if self.isNowEvent then
curFeed,maxFeed=emergenciesModel:getFeedRS()
else
maxFeed=stageCfg[#stageCfg][1]
curFeed=maxFeed
end
local isFull=curFeed>=maxFeed
local sundriesModel=self.eventCfg.event_conf.ruishou
sundriesModel=isFull and sundriesModel[2]or sundriesModel[1]
local sundriesCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,sundriesModel)

for i,v in ipairs(self.segment)do
local index=#stageCfg-i+1
local segmentCfg=stageCfg[index]
if segmentCfg then
local segmentModel=segmentCfg[2]
local segmentModelCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,segmentModel)
v:setText(FMT.fmt("{0}%",math.ceil(segmentCfg[1]/maxFeed*100)))
else
v:setText("")
end
if curFeed>=segmentCfg[1]then
self.box[i+3]:setActive(true)
else
self.box[i]:setActive(true)
end
end
local index=emergenciesModel:findFeedSegment(stageCfg)
local sScale=emergenciesModel:getRSLMModelScale(index)
local scale=isFull and 0.42 or(0.35*sScale)
local ox=isFull and-16 or 0
local oy=isFull and-27 or 0
local animation=isFull and eAnimationID.stand or eAnimationID.enter
self.uiModel:setChildUIModelShowTarget(sundriesCfg.model[1],scale,sundriesCfg.model[2]or{},animation,false,false,0)
self.uiModel:setChildUIModelShowTargetOffset(ox,oy)
self.uiModel:setChildUIModelShowFlipX(true)

if self.eventCfg.succ_guild_buffs then
local buff=self.eventCfg.succ_guild_buffs[1][1]
local buffCfg=cfgHelper.get1(cfg_guildstateconfig_get,buff)
self.buffList:setChildLayoutGroupCreateItems(#buffCfg.effects,function(index)
local buffItem=self.buffList:getChildLayoutGroupGridItem(index-1)
local desc=homeBuffModel:getBuffDesc(buffCfg.effects[index])
local color=isFull and Color.StrToColor('#7d3b17')or Color.StrToColor('#65615F')
buffItem:SetChildText(-1,desc)
buffItem:SetTextColor(-1,color)
end)
end



self.progress2:setProgressValue(math.floor(curFeed/maxFeed*10000),10000)
self.progress1:setProgressValue(math.floor(curFeed/maxFeed*10000),10000)
local progressStr=curFeed<maxFeed and FMT.fmt("{0}/{1}",curFeed,maxFeed)or"已喂饱"
self.progress1:setChildProgressText(progressStr)

if curFeed>=maxFeed then
self.btnpanel:setActive(false)
end
end


function UIRuiShouLinMenWin:onHide()

end




function UIRuiShouLinMenWin:onBackground()
self:onCloseBtn()
end


function UIRuiShouLinMenWin:onCloseBtn()
emergenciesModel:showRSLMBoxesEffect(self.eventId)

UIFullRuiShouLinMenControl:closeUI(true)
end


function UIRuiShouLinMenWin:onFeedBtn()
if not self.isNowEvent then
UIManager.info("瑞兽已喂饱")
return
end
local curFeed,maxFeed=emergenciesModel:getFeedRS()
local isFull=curFeed>=maxFeed
if isFull then
UIManager.info("瑞兽已喂饱")
return
end
local param={
event=self.eventId,
variation=emergenciesModel:getFeedLeast(),
change=self._tryAddProgress,
close=self._cancelTryProgress,
}
self:showWindow("UIRuiShouLinMenSelectWin",param)


self:changeBtn()
end

function UIRuiShouLinMenWin:changeBtn()
self.feedBtn:setActive(false)
self.onAddBtn:setActive(true)
end

function UIRuiShouLinMenWin:onOnAddBtn()
if not self.isNowEvent then
UIManager.info("瑞兽已喂饱")
return
end
local curFeed,maxFeed=emergenciesModel:getFeedRS()
local isFull=curFeed>=maxFeed
if isFull then
UIManager.info("瑞兽已喂饱")
return
end
UIManager:invokeUIMethod('UIRuiShouLinMenSelectWin','onFeedBtn')
end

function UIRuiShouLinMenWin:tryAddProgress(value)

if value>0 then
local curFeed,maxFeed=emergenciesModel:getFeedRS()
local target=math.min(curFeed+value,maxFeed)
self.progress1:setChildProgressText(FMT.fmt("{0}<color=#76D81E>(+{1})</color>/{2}",curFeed,target-curFeed,maxFeed))
self.progress2:setProgress(math.floor(target/maxFeed*10000),10000)
else
self:cancelTryProgress()
end
end

function UIRuiShouLinMenWin:cancelTryProgress()
local curFeed,maxFeed=emergenciesModel:getFeedRS()
self.progress2:setProgressValue(math.floor(curFeed/maxFeed*10000),10000)
self.progress1:setChildProgressText(FMT.fmt("{0}/{1}",curFeed,maxFeed))
end

function UIRuiShouLinMenWin:refreshView()
local curFeed,maxFeed=emergenciesModel:getFeedRS()
local isFull=curFeed>=maxFeed


self.progress2:setProgressValue(math.floor(curFeed/maxFeed*10000),10000)
self.progress1:setProgressValue(math.floor(curFeed/maxFeed*10000),10000)
local progressStr=curFeed<maxFeed and FMT.fmt("{0}/{1}",curFeed,maxFeed)or"已满"
self.progress1:setChildProgressText(progressStr)

local buffItems=self.buffList:getChildLayoutGroupGridList()
for i=1,buffItems.Count do
local buffItem=buffItems[i-1]
local color=isFull and Color.StrToColor('#7D3B17')or Color.StrToColor('#827F78')
buffItem:SetTextColor(-1,color)
end

if isFull then
local sundriesModel=self.eventCfg.event_conf.ruishou[2]
local sundriesCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,sundriesModel)
self.uiModel:setChildUIModelShowTarget(sundriesCfg.model[1],0.42,sundriesCfg.model[2]or{},eAnimationID.stand,false,false,0)
self.uiModel:setChildUIModelShowTargetOffset(-16,-27)
end
end

function UIRuiShouLinMenWin:onClickSegment(index)
local stageCfg=self.eventCfg.event_conf.stage[index]
local sundriesId=stageCfg[2]
local sundriesCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,sundriesId)
local rewardId=sundriesCfg.rewards_conf.rewardid
local level=zongmenModel:getLevel()
local rewardList=itemsAwardConfig:getAwardInConfigByLevel(rewardId,level)

local args=
{
title='奖励',
desc1='开启宝箱有机会获得以下奖励',
rewardTitle='',
commitName='确定',
showCancel=false,
rewards=rewardList.showItems,
}
self:showWindow('UIDialougeRewardWin',args)
end

function UIRuiShouLinMenWin:onBox_1()
self:onClickSegment(3)
end

function UIRuiShouLinMenWin:onBox_2()
self:onClickSegment(2)
end

function UIRuiShouLinMenWin:onBox_3()
self:onClickSegment(1)
end

function UIRuiShouLinMenWin:onBox_4()
self:onClickSegment(3)
end

function UIRuiShouLinMenWin:onBox_5()
self:onClickSegment(2)
end

function UIRuiShouLinMenWin:onBox_6()
self:onClickSegment(1)
end