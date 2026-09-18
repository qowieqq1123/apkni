







def_class("UIWDCQScheduleWin",UIWindowBase)









function UIWDCQScheduleWin:bindComponents()

self.backButton=UIButton.get(self,0)
self.groupList=UIObject.get(self,1)
self.matchView1=UIObject.get(self,2)
self.matchView2=UIObject.get(self,3)
self.phaseList=UIObject.get(self,4)
self.serverList=UIObject.get(self,5)

self.backButton:setButtonClick(function()self:onBackButton()end)



end


function UIWDCQScheduleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backButton);self.backButton=nil;
_UIObject_release(self.groupList);self.groupList=nil;
_UIObject_release(self.matchView1);self.matchView1=nil;
_UIObject_release(self.matchView2);self.matchView2=nil;
_UIObject_release(self.phaseList);self.phaseList=nil;
_UIObject_release(self.serverList);self.serverList=nil;
end















local _this=nil
local _showServerMax=9
local _groupCmp={
widget=-1,
select=0,
name=1,
}
local _phaseCmp={
widget=-1,
select=0,
name=1,
}
local _serverCmp={
widget=-1,
bgOther=0,
bgSelf=1,
name=2,
}
local _matchView1Cmp={
timeTx=0,
matchList=1,
}
local _matchView2Cmp={
lPlayer=0,
rPlayer=1,
matchImg=2,
watchBtn=3,
playbackBtn=4,
timeTx=5,
middle=6,
empty=7,
background=8,
}
local _matchItemCmp={
widget=-1,
orderTx=0,
timeTx=1,
sameServer=2,
lVictory=3,
rVictory=4,
lPlayer=5,
rPlayer=6,
bookRoot=7,
booked=8,
}
local _matchPlayerCmp={
widget=-1,
background=0,
playerImage=1,
playerModel=2,
empty=3,
nameBg=4,
name=5,
sameServer=6,
victory=7,
}
local _matchSpine={
[WDCQCGameStageEnum.eThird]=5554,
[WDCQCGameStageEnum.eChampion]=5555,
}
local _matchImages={
[WDCQCGameStageEnum.eThird]="image_wdcqsaicheng_wz4",
[WDCQCGameStageEnum.eChampion]="image_wdcqsaicheng_wz5",
}
local _playerBgImages={
[WDCQCGameStageEnum.eThird]="image_wdcqsaicheng_10",
[WDCQCGameStageEnum.eChampion]="image_wdcqsaicheng_12",
}
local _nameBgImages={
[WDCQCGameStageEnum.eThird]="image_wdcqsaicheng_9",
[WDCQCGameStageEnum.eChampion]="image_wdcqsaicheng_11",
}
local _abName="ui/windows/wendingcangqiong/wdcq_atlas_pak.ab"
local _nonePlayerName="暂无对手"



function UIWDCQScheduleWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(38,1,self.on_38_1)
self:addProNotify(38,8,self.on_38_8)
self:addNotify(notifyConfig.onRequestPhpServerNamesRecv,self.onRequestPhpServerNamesRecv)

self.viewWidget1=self.matchView1:getChildWidgetBase()
self.viewWidget2=self.matchView2:getChildWidgetBase()
self.viewWidget2:SetChildButtonClick(_matchView2Cmp.watchBtn,function(...)self:onWatchButton(...)end)
self.viewWidget2:SetChildButtonClick(_matchView2Cmp.playbackBtn,function(...)self:onPlaybackButton(...)end)

self.matchCfg=cfg_wendingcangqiongmatchconfig()
self:initGroupList()
end


function UIWDCQScheduleWin:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UIWDCQScheduleWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
local index=1
if argtable and argtable.group then
for i,v in ipairs(self.groupDatas)do
if v==argtable.group then
index=i
break
end
end
end
self:onClickGroup(index)
end


function UIWDCQScheduleWin:onHide()

end




function UIWDCQScheduleWin:onBackButton()
if self.closeFunc then
self.closeFunc()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIWDCQScheduleWin:onWatchButton()
wdcqLiveBroadcastRoomController:enterLiveRoom(self.selectGroup,self.selectPhase,1)
end

function UIWDCQScheduleWin:onPlaybackButton()
local group=self.selectGroup
local phase=self.selectPhase
local order=1
WDCQController:Req_FightReplay(group,phase,order,true,nil,function()
wdcqLiveBroadcastRoomController:enterLiveRoom(group,phase,order)
end)
end

function UIWDCQScheduleWin:onClickGroup(index)
if self.groupIdx~=index then
if self.groupIdx then
local item=self.groupList:getChildLayoutGroupGridItem(self.groupIdx-1)
item:SetChildActive(_groupCmp.select,false)
end
self.groupIdx=index
self.selectGroup=self.groupDatas[index]
if self.groupIdx then
local item=self.groupList:getChildLayoutGroupGridItem(self.groupIdx-1)
item:SetChildActive(_groupCmp.select,true)
end
self:refreshGroupView()
end
end

function UIWDCQScheduleWin:onClickPhase(index)
if self.selectPhase~=index then
if self.selectPhase then
local item=self.phaseList:getChildLayoutGroupGridItem(self.selectPhase-1)
item:SetChildActive(_phaseCmp.select,false)
end
self.selectPhase=index
if self.selectPhase then
local item=self.phaseList:getChildLayoutGroupGridItem(self.selectPhase-1)
item:SetChildActive(_phaseCmp.select,true)
end
self:refreshPhaseView()
end
end

function UIWDCQScheduleWin:onClickItem(index)
local nowTime=timeHelper.getServerShortTime()
if self.selectCfg.book==1 then
local data=self.viewData[index]
local delta=data.startTime-nowTime
if delta>0 then
local book=WDCQModel:getBookData(self.selectGroup,self.selectPhase,data.order)
local hasBook=mathHelper.getBitValue(book,0)
if not hasBook then
WDCQController:doBookWatch(self.selectGroup,self.selectPhase,data.order)
local item=self.viewWidget1:GetChildLayoutGroupGridItem(_matchView1Cmp.matchList,index-1)
item:SetChildActive(_matchItemCmp.booked,true)
else
local limit=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,"book_time")
if delta>limit then
WDCQModel:cancelBookData(self.selectGroup,self.selectPhase,data.order)
local item=self.viewWidget1:GetChildLayoutGroupGridItem(_matchView1Cmp.matchList,index-1)
item:SetChildActive(_matchItemCmp.booked,false)
else
UIManager.info("不可变更预约状态")
end
end
end
end
end

function UIWDCQScheduleWin:initGroupList()
self.groupDatas={}
for i,v in ipairs(self.matchCfg)do
local groupTemp=WDCQModel:getData_GroupTemp(i)
if groupTemp.hasData then
table.insert(self.groupDatas,i)
end
end

self.groupList:setChildLayoutGroupCreateItems(#self.groupDatas,function(index)
local item=self.groupList:getChildLayoutGroupGridItem(index-1)
local id=self.groupDatas[index]
local nameStr=cfgHelper.get3(cfg_wendingcangqiongconfig_get,1,"group_name_image",id)
item:SetChildActive(_groupCmp.select,index==self.groupIdx)
item:SetChildCSImageSprite(_groupCmp.name,_abName,nameStr)
item:SetChildButtonClick(_groupCmp.widget,function()
self:onClickGroup(index)
end)
end)
end

function UIWDCQScheduleWin:refreshGroupView()

self:refreshPhaseList()
self:refreshServerList()
if self.selectPhase then
local phaseCfg=self.matchCfg[self.selectGroup][self.selectPhase]
if self.selectPhase then
local item=self.phaseList:getChildLayoutGroupGridItem(self.selectPhase-1)
item:SetChildActive(_phaseCmp.select,false)
self.selectPhase=nil
end
self:onClickPhase(phaseCfg and self.selectPhase or 1)
else
local curPhase=WDCQController.getGroupStage(self.selectGroup)
local phaseCfg=self.matchCfg[self.selectGroup][curPhase]
self:onClickPhase(phaseCfg and curPhase or 1)
end
end

function UIWDCQScheduleWin:refreshPhaseList()
local phaseCfgs=self.matchCfg[self.selectGroup]
self.phaseList:setChildLayoutGroupCreateItems(#phaseCfgs,function(index)
local item=self.phaseList:getChildLayoutGroupGridItem(index-1)
local phaseCfg=phaseCfgs[index]
item:SetChildActive(_phaseCmp.select,index==self.selectPhase)
item:SetChildCSImageSprite(_phaseCmp.name,_abName,phaseCfg.name_image)
item:SetChildButtonClick(_phaseCmp.widget,function()
self:onClickPhase(index)
end)
end)
end

function UIWDCQScheduleWin:refreshServerList()
local cfg=self.matchCfg[self.selectGroup][1]
local crossLookup={}
for i,v in ipairs(cfg.time_conf)do
local matchInfo=WDCQController.getMacthInfo(self.selectGroup,1,i)
if matchInfo then
if mathHelper.validInt64(matchInfo.actor_id_1)then
local crossId=loginModel:getCrossSid(matchInfo.server_id_1)
if crossId then
crossLookup[crossId]=true
end
end
if mathHelper.validInt64(matchInfo.actor_id_2)then
local crossId=loginModel:getCrossSid(matchInfo.server_id_2)
if crossId then
crossLookup[crossId]=true
end
end
end
end
local list={}
local myCross=loginModel:getCrossSid(loginModel.server_id)
local haveSelf=false
for i,v in pairs(crossLookup)do
if i==myCross then
haveSelf=true
else
table.insert(list,i)
end
end
table.sort(list)
if haveSelf then
table.insert(list,1,myCross)
end

self.serverList:setChildLayoutGroupCreateItems(#list,function(index)
local item=self.serverList:getChildLayoutGroupGridItem(index-1)
local cross=list[index]
local selfCost=myCross==cross
local crossInfo=loginModel:getCrossServerInfo(cross)
local first,crossInfo=next(crossInfo)
item:SetChildActive(_serverCmp.bgOther,not selfCost)
item:SetChildActive(_serverCmp.bgSelf,selfCost)
item:SetChildText(_serverCmp.name,crossInfo and crossInfo.zone_name or"")
end)
self.winlua:ForceLayoutRect(self.serverList:getID())
end

function UIWDCQScheduleWin:refreshPhaseView()
if not self.selectGroup or not self.selectPhase then
return
end

self:updateMatchViewData()
self.matchView1:setActive(self.isMulti)
self.matchView2:setActive(not self.isMulti)
if self.isMulti then
self:refreshMatchView1()
else
self:refreshMatchView2()
end
end

function UIWDCQScheduleWin:updateMatchViewData()
local curPhase=WDCQController.getServerGroupStage(self.selectGroup)
self.selectCfg=self.matchCfg[self.selectGroup][self.selectPhase]
local matchCnt=#self.selectCfg.time_conf
self.isMulti=matchCnt>1
self.viewData={}
for order=1,matchCnt do
local matchInfo=WDCQController.getMacthInfo(self.selectGroup,self.selectPhase,order)
local roundCfg=WDCQController.getRoundCfg(self.selectGroup,self.selectPhase,order)
if matchInfo and(mathHelper.validInt64(matchInfo.actor_id_1)or mathHelper.validInt64(matchInfo.actor_id_2))then
table.insert(self.viewData,{
order=order,
info=matchInfo,
startTime=roundCfg.startTime,
endTime=roundCfg.endTime,
show=0
})
else
local show=0
if self.isMulti then
local perNum=math.pow(2,self.selectPhase-1)
for i=0,1 do
for j=1,perNum do
local index=(order-1)*perNum+j
local baseInfo=WDCQController.getMacthInfo(self.selectGroup,1,index)
if baseInfo and(mathHelper.validInt64(baseInfo.actor_id_1)or mathHelper.validInt64(baseInfo.actor_id_2))then
show=mathHelper.setbit(show,i)
break
end
end
end

else
local confCnt=#self.matchCfg[self.selectGroup][1].time_conf
if self.selectPhase==WDCQCGameStageEnum.eChampion then
for i=0,1 do
for j=1,confCnt/2 do
local index=i*confCnt/2+j
local baseInfo=WDCQController.getMacthInfo(self.selectGroup,1,index)
if baseInfo and(mathHelper.validInt64(baseInfo.actor_id_1)or mathHelper.validInt64(baseInfo.actor_id_2))then
show=mathHelper.setbit(show,i)
break
end
end
end
else
for i=0,1 do
local check=0
for j=1,confCnt/4 do
local index=i*confCnt/2+j
local baseInfo=WDCQController.getMacthInfo(self.selectGroup,1,index)
if baseInfo and(mathHelper.validInt64(baseInfo.actor_id_1)or mathHelper.validInt64(baseInfo.actor_id_2))then
check=check+1
break
end
end
for j=confCnt/4+1,confCnt/2 do
local index=i*confCnt/2+j
local baseInfo=WDCQController.getMacthInfo(self.selectGroup,1,index)
if baseInfo and(mathHelper.validInt64(baseInfo.actor_id_1)or mathHelper.validInt64(baseInfo.actor_id_2))then
check=check+1
break
end
end
if check==2 then
show=mathHelper.setbit(show,i)
end
end
end
end
if show>0 then
table.insert(self.viewData,{
order=order,
info=nil,
startTime=roundCfg.startTime,
endTime=roundCfg.endTime,
show=show
})
end
end
end

end

function UIWDCQScheduleWin:refreshMatchView1()
local widget=self.viewWidget1
local nowTime=timeHelper.getServerShortTime()
widget:SetChildLayoutGroupCreateItems(_matchView1Cmp.matchList,#self.viewData,function(index)
local item=widget:GetChildLayoutGroupGridItem(_matchView1Cmp.matchList,index-1)
local data=self.viewData[index]
local order=data.order
local matchInfo=data.info
local startTime=data.startTime
local endTime=data.endTime
local startStamp=timeHelper.convertLongStamp(startTime)
local show=data.show
local book=WDCQModel:getBookData(self.selectGroup,self.selectPhase,order)
local hasBook=mathHelper.getBitValue(book,0)
item:SetChildText(_matchItemCmp.orderTx,FMT.fmt("第{0}场",order))
item:SetChildText(_matchItemCmp.timeTx,timeHelper.getTwoFormatByStamp(startStamp))
item:SetChildActive(_matchItemCmp.booked,hasBook)
item:SetChildButtonClick(_matchItemCmp.widget,function()
self:onClickItem(index)
end)
if matchInfo then
item:SetChildActive(_matchItemCmp.bookRoot,nowTime<startTime and self.selectCfg.book==1)

if mathHelper.validInt64(matchInfo.win_actor_id)and(nowTime>=endTime or not mathHelper.validInt64(matchInfo.actor_id_1)or not mathHelper.validInt64(matchInfo.actor_id_2))then
item:SetChildActive(_matchItemCmp.lVictory,mathHelper.compareInt64(matchInfo.win_actor_id,matchInfo.actor_id_1))
item:SetChildActive(_matchItemCmp.rVictory,mathHelper.compareInt64(matchInfo.win_actor_id,matchInfo.actor_id_2))
else
item:SetChildActive(_matchItemCmp.lVictory,false)
item:SetChildActive(_matchItemCmp.rVictory,false)
end

for i=1,2 do
local cmp=i==1 and _matchItemCmp.lPlayer or _matchItemCmp.rPlayer
local actor_id=matchInfo[FMT.fmt("actor_id_{0}",i)]
local name=matchInfo[FMT.fmt("name_{0}",i)]
local isLose=mathHelper.validInt64(actor_id)and name==''
name=playerModel:getOtherActorName(name)
local server_id=matchInfo[FMT.fmt("server_id_{0}",i)]
if mathHelper.validInt64(actor_id)or isLose then
local serverName=loginModel:getServerNameEx(server_id,"")
local strName=FMT.fmt("{0}\n{1}",name,serverName)
if playerModel:checkActorId(actor_id)then
strName=FMT.cfmt3("549327",strName)
end
item:SetChildText(cmp,strName)
else
item:SetChildText(cmp,_nonePlayerName)
end
end

item:SetChildActive(_matchItemCmp.sameServer,loginModel:isMySameServerZoneByServerID(matchInfo.server_id_1)or loginModel:isMySameServerZoneByServerID(matchInfo.server_id_2))
else
item:SetChildActive(_matchItemCmp.sameServer,false)
item:SetChildActive(_matchItemCmp.lVictory,false)
item:SetChildActive(_matchItemCmp.rVictory,false)
item:SetChildActive(_matchItemCmp.bookRoot,nowTime<startTime and self.selectCfg.book==1)
local preCfg=self.matchCfg[self.selectGroup][self.selectPhase-1]
for i=1,2 do
local cmp=i==1 and _matchItemCmp.lPlayer or _matchItemCmp.rPlayer
if mathHelper.getBitValue(show,i-1)then
item:SetChildText(cmp,preCfg and FMT.fmt("{0}第{1}场胜者",preCfg.name,(order-1)*2+i)or _nonePlayerName)
else
item:SetChildText(cmp,_nonePlayerName)
end
end
end
end)

local first=self.viewData[1]
if first then
local date=timeHelper.dateServerStampData(timeHelper.convertLongStamp(first.startTime))
local timeStr=FMT.fmt("比赛日期：{0}月{1}日",date.month,date.day)
widget:SetChildText(_matchView1Cmp.timeTx,timeStr)
else
widget:SetChildText(_matchView1Cmp.timeTx,"")
end

if#self.viewData>0 and self.selectCfg.book==1 then
self:startCDTick()
else
self:startCDTick()
end
end

function UIWDCQScheduleWin:refreshMatchView2()
local widget=self.viewWidget2
local nowTime=timeHelper.getServerShortTime()
local data=self.viewData[1]
local haveData=data~=nil
widget:SetChildActive(_matchView2Cmp.middle,haveData)
widget:SetChildActive(_matchView2Cmp.lPlayer,haveData)
widget:SetChildActive(_matchView2Cmp.rPlayer,haveData)
widget:SetChildActive(_matchView2Cmp.empty,not haveData)
if haveData then
widget:SetChildUIModelShowTarget(_matchView2Cmp.background,_matchSpine[self.selectPhase],1,{},eAnimationID.stand,false,false,0)

local matchInfo=data.info


local timeStamp=timeHelper.convertLongStamp(data.startTime)
local date=timeHelper.dateServerStampData(timeStamp)
local timeStr=timeHelper.dateServerStamp('%H:%M',timeStamp)
timeStr=FMT.fmt("{0}月{1}日  {2}",date.month,date.day,timeStr)
widget:SetChildText(_matchView2Cmp.timeTx,timeStr)
widget:SetChildCSImageSprite(_matchView2Cmp.matchImg,_abName,_matchImages[self.selectPhase])

if matchInfo then
local havePlayer1=mathHelper.validInt64(matchInfo.actor_id_1)
local havePlayer2=mathHelper.validInt64(matchInfo.actor_id_2)
widget:SetChildActive(_matchView2Cmp.playbackBtn,havePlayer1 and havePlayer2 and nowTime>=data.endTime)
widget:SetChildActive(_matchView2Cmp.watchBtn,havePlayer1 and havePlayer2 and nowTime>=data.startTime and nowTime<data.endTime)

local showVictory=mathHelper.validInt64(matchInfo.win_actor_id)and(nowTime>=data.endTime or not havePlayer1 or not havePlayer2)
for i=1,2 do
local pWidget=widget:GetChildWidgetBase(i==1 and _matchView2Cmp.lPlayer or _matchView2Cmp.rPlayer)
local actor_id=matchInfo[FMT.fmt("actor_id_{0}",i)]
local name=matchInfo[FMT.fmt("name_{0}",i)]
local isLose=mathHelper.validInt64(actor_id)and name==''
name=playerModel:getOtherActorName(name)
local server_id=matchInfo[FMT.fmt("server_id_{0}",i)]
local iconInfo=matchInfo[FMT.fmt("iconInfo{0}",i)]
local havePlayer=mathHelper.validInt64(actor_id)
if havePlayer or isLose then
local serverName=loginModel:getServerNameEx(server_id,"")
local strName=FMT.fmt("{0}\n{1}",name,serverName)
if playerModel:checkActorId(actor_id)then
strName=FMT.cfmt3("549327",strName)
end
pWidget:SetChildText(_matchPlayerCmp.name,strName)
pWidget:SetChildActive(_matchPlayerCmp.playerImage,true)
pWidget:SetChildActive(_matchPlayerCmp.sameServer,loginModel:isMySameServerZoneByServerID(server_id))
playerController:setImage(pWidget,_matchPlayerCmp.playerModel,nil,iconInfo,false)
else
pWidget:SetChildText(_matchPlayerCmp.name,_nonePlayerName)
pWidget:SetChildActive(_matchPlayerCmp.sameServer,false)
end
pWidget:SetChildActive(_matchPlayerCmp.empty,false)
pWidget:SetChildActive(_matchPlayerCmp.playerImage,havePlayer)
pWidget:SetChildActive(_matchPlayerCmp.victory,showVictory and mathHelper.compareInt64(matchInfo.win_actor_id,actor_id))

pWidget:SetChildCSImageSprite(_matchPlayerCmp.nameBg,_abName,_nameBgImages[self.selectPhase])
end
else
local preCfg=self.matchCfg[self.selectGroup][WDCQCGameStageEnum.eSemi]
local tempStr=self.selectPhase==WDCQCGameStageEnum.eChampion and"胜者"or"败者"
for i=1,2 do
local pWidget=widget:GetChildWidgetBase(i==1 and _matchView2Cmp.lPlayer or _matchView2Cmp.rPlayer)
pWidget:SetChildActive(_matchPlayerCmp.empty,true)
pWidget:SetChildActive(_matchPlayerCmp.playerImage,false)
pWidget:SetChildActive(_matchPlayerCmp.sameServer,false)
pWidget:SetChildActive(_matchPlayerCmp.victory,false)
local nameStr=preCfg and FMT.fmt("{0}\n第{1}场{2}",preCfg.name,mathHelper.numberToChinese(i),tempStr)or _nonePlayerName
pWidget:SetChildText(_matchPlayerCmp.name,nameStr)

pWidget:SetChildCSImageSprite(_matchPlayerCmp.nameBg,_abName,_nameBgImages[self.selectPhase])
end

widget:SetChildActive(_matchView2Cmp.playbackBtn,false)
widget:SetChildActive(_matchView2Cmp.watchBtn,false)
end
end

if#self.viewData>0 and self.selectCfg.book==1 then
self:startCDTick()
else
self:startCDTick()
end
end

function UIWDCQScheduleWin:startCDTick()
if not self.cdTick then
self.cdTime=timeHelper.getServerShortTime()
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIWDCQScheduleWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
self.cdTime=nil
end
end

function UIWDCQScheduleWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
if self.isMulti then
for i,v in ipairs(self.viewData)do

if nowTime>=v.startTime and self.cdTime<v.startTime then
local item=self.viewWidget1:GetChildLayoutGroupGridItem(_matchView1Cmp.matchList,i-1)
item:SetChildActive(_matchItemCmp.bookRoot,false)
end











end
else
local v=self.viewData[1]
if v then

local matchInfo=v.info
if nowTime>=v.startTime and self.cdTime<v.startTime then
self.viewWidget2:SetChildActive(_matchView2Cmp.watchBtn,mathHelper.validInt64(matchInfo.actor_id_1)and mathHelper.validInt64(matchInfo.actor_id_2))
end

if nowTime>=v.endTime and self.cdTime<v.endTime then
self.viewWidget2:SetChildActive(_matchView2Cmp.playbackBtn,mathHelper.validInt64(matchInfo.actor_id_1)and mathHelper.validInt64(matchInfo.actor_id_2))
end






end
end
self.cdTime=nowTime
end

function UIWDCQScheduleWin.on_38_1()
_this:updateMatchViewData()
if _this.isMulti then
_this:refreshMatchView1()
else
_this:refreshMatchView2()
end
end

function UIWDCQScheduleWin.on_38_8(group,phase,order,matchInfo)
if _this.selectGroup==group and _this.selectPhase==phase then
for index,data in ipairs(_this.viewData)do
if data.order==order then
data.info=matchInfo
local showWin=mathHelper.validInt64(matchInfo.win_actor_id)
if _this.isMulti then
local item=_this.viewWidget1:GetChildLayoutGroupGridItem(_matchView1Cmp.matchList,index-1)
for i=1,2 do
local cmp=i==1 and _matchItemCmp.lVictory or _matchItemCmp.rVictory
local actor_id=matchInfo[FMT.fmt("actor_id_{0}",i)]
item:SetChildActive(cmp,showWin and mathHelper.compareInt64(matchInfo.win_actor_id,actor_id))
end
else
for i=1,2 do
local pWidget=_this.viewWidget2:GetChildWidgetBase(i==1 and _matchView2Cmp.lPlayer or _matchView2Cmp.rPlayer)
local actor_id=matchInfo[FMT.fmt("actor_id_{0}",i)]
pWidget:SetChildActive(_matchPlayerCmp.victory,showWin and mathHelper.compareInt64(matchInfo.win_actor_id,actor_id))
end
end
return
end
end
end
end

function UIWDCQScheduleWin.onRequestPhpServerNamesRecv(secFlag)
if secFlag then
_this:refreshServerList()

if _this.isMulti then
local widget=_this.viewWidget1
local itemsList=widget:GetChildLayoutGroupGridList(_matchView1Cmp.matchList)
for index=1,itemsList.Count do
local item=itemsList[index-1]
local data=_this.viewData[index]
local matchInfo=data.info
if matchInfo then
for i=1,2 do
local cmp=i==1 and _matchItemCmp.lPlayer or _matchItemCmp.rPlayer
local actor_id=matchInfo[FMT.fmt("actor_id_{0}",i)]
local name=matchInfo[FMT.fmt("name_{0}",i)]
local isLose=mathHelper.validInt64(actor_id)and name==''
name=playerModel:getOtherActorName(name)
local server_id=matchInfo[FMT.fmt("server_id_{0}",i)]
if mathHelper.validInt64(actor_id)or isLose then
local serverName=loginModel:getServerNameEx(server_id,"")
local strName=FMT.fmt("{0}\n{1}",name,serverName)
if playerModel:checkActorId(actor_id)then
strName=FMT.cfmt3("549327",strName)
end
item:SetChildText(cmp,strName)
else
item:SetChildText(cmp,_nonePlayerName)
end
end
end
end
else
local widget=_this.viewWidget2
local data=_this.viewData[1]
local haveData=data~=nil
if haveData then
local matchInfo=data.info
for i=1,2 do
local pWidget=widget:GetChildWidgetBase(i==1 and _matchView2Cmp.lPlayer or _matchView2Cmp.rPlayer)
local actor_id=matchInfo[FMT.fmt("actor_id_{0}",i)]
local name=matchInfo[FMT.fmt("name_{0}",i)]
local isLose=mathHelper.validInt64(actor_id)and name==''
name=playerModel:getOtherActorName(name)
local server_id=matchInfo[FMT.fmt("server_id_{0}",i)]
local havePlayer=mathHelper.validInt64(actor_id)
if havePlayer or isLose then
local serverName=loginModel:getServerNameEx(server_id,"")
local strName=FMT.fmt("{0}\n{1}",name,serverName)
if playerModel:checkActorId(actor_id)then
strName=FMT.cfmt3("549327",strName)
end
pWidget:SetChildText(_matchPlayerCmp.name,strName)
else
pWidget:SetChildText(_matchPlayerCmp.name,_nonePlayerName)
end
end
end
end
end
end