







def_class("UIXianGuanWuXuanMatch2Win",UIWindowBase)









function UIXianGuanWuXuanMatch2Win:bindComponents()

self.cdTx=UIText.get(self,0)
self.finalShift=UIObject.get(self,1)
self.inspectBtn=UIButton.get(self,2)
self.lastShift=UIObject.get(self,3)
self.matching_1=UIObject.get(self,4)
self.matching_2=UIObject.get(self,5)
self.rewardBtn=UIButton.get(self,6)
self.roundBg=UIObject.get(self,7)
self.roundTx=UIText.get(self,8)
self.shiftList=UIObject.get(self,9)

self.inspectBtn:setButtonClick(function()self:onInspectBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)
self.matching={
self.matching_1,
self.matching_2,
}



end


function UIXianGuanWuXuanMatch2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.finalShift);self.finalShift=nil;
_UIObject_release(self.inspectBtn);self.inspectBtn=nil;
_UIObject_release(self.lastShift);self.lastShift=nil;
_UIObject_release(self.matching_1);self.matching_1=nil;
_UIObject_release(self.matching_2);self.matching_2=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.roundBg);self.roundBg=nil;
_UIObject_release(self.roundTx);self.roundTx=nil;
_UIObject_release(self.shiftList);self.shiftList=nil;
self.matching=nil;
end















local _this=nil
local _playerCmp={
playerBG=0,
playerHead=1,
playerHeadIcon=2,
playerName=3,
serverName=4,
inspireNum=5,
inspired=6,
empty=7,
flag=8,
winner=9,
have=10,
}
local _lineCmp={
up_1=0,
up_2=1,
}
local _lookCmp={
button=0,
}
local _winnerCmp={
playerBG=0,
playerHead=1,
playerHeadIcon=2,
look=3,
empty=4,
playerName=5,
serverName=6,
have=7,
}
local _championCmp={
playerBG=0,
playerHead=1,
playerHeadIcon=2,
look=3,
empty=4,
nameBg=5,
playerName=6,
serverName=7,
}

local _shiftContentType={
eLast=1,
eFinal=2,
}

local _shiftTabList={
{
name="第1组",
contentType=_shiftContentType.eLast,
},
{
name="第2组",
contentType=_shiftContentType.eLast,
},
{
name="第3组",
contentType=_shiftContentType.eLast,
},
{
name="第4组",
contentType=_shiftContentType.eLast,
},
{
name="决赛",
contentType=_shiftContentType.eFinal,
},
}

local _lastPlayerScale=0.6
local _finalPlayerScale=0.75



function UIXianGuanWuXuanMatch2Win:onLoaded(...)
self:bindComponents()

_this=self

self.lastWb=self.lastShift:getWidgetBase()
self.finalWb=self.finalShift:getWidgetBase()

self:addProNotify(40,26,self.on_40_26)
self:addProNotify(40,29,self.on_40_29)
self:addProNotify(40,30,self.on_40_30)
self:addNotify(notifyConfig.onXianGuanJingXuanSegmentChange,self.onXianGuanJingXuanSegmentChange)
end


function UIXianGuanWuXuanMatch2Win:__delete()
_this=nil

self:unbindComponents()
end




function UIXianGuanWuXuanMatch2Win:onShow(argtable,afterOnloaded)
self.job=argtable.job


self.showShiftIdx=self:getShowTabDefaultIndex()

self:refreshAll()
end


function UIXianGuanWuXuanMatch2Win:onHide()

end




function UIXianGuanWuXuanMatch2Win:onInspectBtn()
local segment=xianguanController:getActivitySegment_WuXuan_Compatible()
if segment~=XianGuanWuXuanSegment.eReady then
return
end
local job=xianguanModel:getWuXuanPlayerJob()
if job==nil or job<=0 then
UIManager.info("未参选")
return
end
local declaration=xianguanModel:getWuXuanPlayerDeclaration()
local args={
parentWin=self,
job=job,
declaration=declaration,
}
self:showWindow("UIXianGuanWuXuanShareInspireWin",args)
end

function UIXianGuanWuXuanMatch2Win:onRewardBtn()

local segment=xianguanController:getActivitySegment_WuXuan_Compatible()
local reward=xianguanController:getWuXuanReddot_Compatible()
if reward then
xianguanController:send_40_26(segment)
end
end

function UIXianGuanWuXuanMatch2Win:onClickPlayer(matchData,matchSide,matchPlayerIndex)
local fieldName=FMT.fmt("actor{0}_idx",matchSide)
local playerIndex=matchData and matchData[fieldName]or 0
if playerIndex==0 and matchPlayerIndex then
playerIndex=matchPlayerIndex
end
if playerIndex>0 or matchPlayerIndex then
UIFullXJForceControl:showWuXuanTeamWin(self.job,playerIndex)
end
end

function UIXianGuanWuXuanMatch2Win:onClickInspire(matchData,matchSide,matchPlayerIndex)
local fieldName=FMT.fmt("actor{0}_idx",matchSide)
local playerIndex=matchData and matchData[fieldName]or 0
if playerIndex==0 and matchPlayerIndex then
playerIndex=matchPlayerIndex
end
if playerIndex>0 then
local args={
parentWin=self,
job=self.job,
playerIdx=playerIndex,
}
self:showWindow("UIXianGuanWuXuanInspireWin",args)
end
end

function UIXianGuanWuXuanMatch2Win:onClickLook(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
xianguanController:watchWuXuanBattle(self.job,round,roundIdx)
end

function UIXianGuanWuXuanMatch2Win:onClickWinnerPlayer(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local playerIndex=matchData and matchData.win_actor_idx or 0
if playerIndex>0 then
UIFullXJForceControl:showWuXuanTeamWin(self.job,playerIndex)
end
end

function UIXianGuanWuXuanMatch2Win:onClickWinnerLook(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
xianguanController:watchWuXuanBattle(self.job,round,roundIdx)
end

function UIXianGuanWuXuanMatch2Win:onClickChampionPlayer(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local playerIndex=matchData and matchData.win_actor_idx or 0
if playerIndex>0 then
UIFullXJForceControl:showWuXuanTeamWin(self.job,playerIndex)
end
end

function UIXianGuanWuXuanMatch2Win:onClickChampionLook(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
xianguanController:watchWuXuanBattle(self.job,round,roundIdx)
end


function UIXianGuanWuXuanMatch2Win:refreshAll()
self:refreshRewardBtn()
self:refreshInspireBtn()

self:refreshShiftTabList()

self:refreshShiftContent()

self:refreshRound()
end


function UIXianGuanWuXuanMatch2Win:refreshShiftTabList()
local len=#_shiftTabList

self.shiftList:setChildLayoutGroupCreateItems(len,function(index)
local item=_this.shiftList:getChildLayoutGroupGridItem(index-1)
local data=_shiftTabList[index]

local isSelect=_this.showShiftIdx==index
item:SetChildActive(0,isSelect)
item:SetChildText(1,data.name)

local isGray=false


if index==len then
isGray=not xianguanModel:isOpenPredict(self.job)
end
item:SetChildGray(-1,isGray)

item:SetBaseItemClickEvent(-1,function()
if index==len then

if not xianguanModel:isOpenPredict(self.job)then
UIManager.info("决赛暂无法预测开启")
return
end
end

local preItem=_this.shiftList:getChildLayoutGroupGridItem(_this.showShiftIdx-1)
preItem:SetChildActive(0,false)

_this.showShiftIdx=index
item:SetChildActive(0,true)

_this:refreshShiftContent()
end)
end)
end

function UIXianGuanWuXuanMatch2Win:refreshShiftContent()
local contentConfig=_shiftTabList[self.showShiftIdx]

local isShowLastShifht=contentConfig.contentType==_shiftContentType.eLast
local isShowFinalShift=contentConfig.contentType==_shiftContentType.eFinal

self.lastShift:setActive(isShowLastShifht)
self.finalShift:setActive(isShowFinalShift)

if isShowLastShifht then
self:refreshLastShift()
end

if isShowFinalShift then
self:refreshFinalShift()
end
end

function UIXianGuanWuXuanMatch2Win:refreshShiftInspireNum()
local contentConfig=_shiftTabList[self.showShiftIdx]

local isShowLastShifht=contentConfig.contentType==_shiftContentType.eLast
local isShowFinalShift=contentConfig.contentType==_shiftContentType.eFinal

if isShowLastShifht then
self:refreshLastShiftInspireNum()
end

if isShowFinalShift then
self:refreshFinalShiftInspireNum()
end
end


local _lastGroupLen=4
local _lastLineIndexs={0,1,2,3,4,5,6}
local _lastLookIndexs={7,8,9,10,11,12}
local _lastPlayerIndexs={13,14,15,16,17,18,19,20}
local _lastWinnerIndex=21
local _lastLineOffset={{5,4,1},{5,4,2},{5,4,3},{5,4,4},{4,2,1},{4,2,2},{3,1,1}}
function UIXianGuanWuXuanMatch2Win:refreshLastShift()

self:refreshLastShiftAllPlayer()
self:refreshLastShiftAllLine()
self:refreshLastShiftAllLook()
self:refreshLastShiftAllWinner()
end

function UIXianGuanWuXuanMatch2Win:refreshLastShiftAllPlayer()
for groupIndex=1,_lastGroupLen do
local matchIndex=(self.showShiftIdx-1)*_lastGroupLen+groupIndex
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,1,matchIndex)

for matchSide=1,2 do
local fieldName=FMT.fmt("actor{0}_idx",matchSide)
local playerIndex=matchData and matchData[fieldName]or 0
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,playerIndex)
local playerIdx=(groupIndex-1)*2+matchSide
local widget=self.lastWb:GetChildWidgetBase(_lastPlayerIndexs[playerIdx])
local inspectJob,inspectActor=xianguanModel:getWuXuanPlayerInspire()
local isInspiredTarget=inspectJob==self.job and inspectActor==playerIndex

widget:SetChildActive(_playerCmp.empty,data==nil)
widget:SetChildActive(_playerCmp.have,data~=nil)
if data then
local isSelf=playerModel:checkActorId(data.actor_id)
playerController:setHeadIcon(widget,_playerCmp.playerHead,{iconInfo=data.iconInfo,scale=_lastPlayerScale})
local nameStr=data.name
widget:SetChildText(_playerCmp.playerName,isSelf and FMT.cfmt2("#76D81E",nameStr)or nameStr)
local serverStr=loginModel:getServerName(data.server_id)
widget:SetChildText(_playerCmp.serverName,isSelf and FMT.cfmt2("#76D81E",serverStr)or serverStr)
widget:SetChildText(_playerCmp.inspireNum,data.inspired_num)
widget:SetChildActive(_playerCmp.inspired,isInspiredTarget)
widget:SetChildActive(_playerCmp.winner,matchData.win_actor_idx>0 and matchData.win_actor_idx==playerIndex)


widget:SetChildButtonClick(_playerCmp.playerBG,function()
self:onClickPlayer(matchData,matchSide)
end,true)
widget:SetChildButtonClick(_playerCmp.flag,function()
self:onClickInspire(matchData,matchSide)
end,true)
end
end
end
end


function UIXianGuanWuXuanMatch2Win:refreshLastShiftAllLine()
for idx,lineIdx in ipairs(_lastLineIndexs)do
local offset=_lastLineOffset[idx]
local sround=offset[1]
local offsetVal1=offset[2]
local offsetVal2=offset[3]

local index=Mathf.Pow(2,5)-Mathf.Pow(2,sround)+(self.showShiftIdx-1)*offsetVal1+offsetVal2
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local data=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local widget=self.lastWb:GetChildWidgetBase(lineIdx)
if data and data.win_actor_idx>0 then
widget:SetChildActive(_lineCmp.up_1,data.actor1_idx==data.win_actor_idx)
widget:SetChildActive(_lineCmp.up_2,data.actor2_idx==data.win_actor_idx)
else
widget:SetChildActive(_lineCmp.up_1,false)
widget:SetChildActive(_lineCmp.up_2,false)
end
end
end

function UIXianGuanWuXuanMatch2Win:refreshLastShiftAllLook()
for idx,lookIdx in ipairs(_lastLookIndexs)do
local offset=_lastLineOffset[idx]
local sround=offset[1]
local offsetVal1=offset[2]
local offsetVal2=offset[3]

local index=Mathf.Pow(2,5)-Mathf.Pow(2,sround)+(self.showShiftIdx-1)*offsetVal1+offsetVal2
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local data=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local widget=self.lastWb:GetChildWidgetBase(lookIdx)
widget:SetChildActive(_lookCmp.button,data~=nil and data.fight_log_id~="")

widget:SetChildButtonClick(_lookCmp.button,function()
self:onClickLook(index)
end,true)
end
end

function UIXianGuanWuXuanMatch2Win:refreshLastShiftAllWinner()
local index=self.showShiftIdx+24

local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local playerIndex=matchData and matchData.win_actor_idx or 0
local logId=matchData and matchData.fight_log_id or""
local haveWinner=playerIndex>0
local haveReport=logId~=""

local widget=self.lastWb:GetChildWidgetBase(_lastWinnerIndex)
widget:SetChildActive(_winnerCmp.look,haveReport)
widget:SetChildActive(_winnerCmp.empty,not haveWinner)
widget:SetChildActive(_winnerCmp.have,haveWinner)
if haveWinner then
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,playerIndex)
playerController:setHeadIcon(widget,_winnerCmp.playerHead,{iconInfo=data.iconInfo,scale=0.5})
widget:SetChildText(_winnerCmp.playerName,data.name)
widget:SetChildText(_winnerCmp.serverName,FMT.fmt("[{0}]",loginModel:getServerName(data.server_id)))

widget:SetChildButtonClick(_winnerCmp.playerBG,function()
self:onClickWinnerPlayer(index)
end,true)
widget:SetChildButtonClick(_winnerCmp.look,function()
self:onClickWinnerLook(index)
end,true)
end
end

function UIXianGuanWuXuanMatch2Win:refreshLastShiftInspireNum()
for groupIndex=1,_lastGroupLen do
local matchIndex=(self.showShiftIdx-1)*_lastGroupLen+groupIndex
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,1,matchIndex)

for matchSide=1,2 do
local fieldName=FMT.fmt("actor{0}_idx",matchSide)
local playerIndex=matchData and matchData[fieldName]or 0
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,playerIndex)
local playerIdx=(groupIndex-1)*2+matchSide
local widget=self.lastWb:GetChildWidgetBase(_lastPlayerIndexs[playerIdx])
local inspectJob,inspectActor=xianguanModel:getWuXuanPlayerInspire()
local isInspiredTarget=inspectJob==self.job and inspectActor==playerIndex

if data then
widget:SetChildText(_playerCmp.inspireNum,data.inspired_num)
widget:SetChildActive(_playerCmp.inspired,isInspiredTarget)
end
end
end
end



local _finalGroupLen=2
local _finalLineIndexs={0,1,2}
local _finalLookIndexs={3,4}
local _finalPlayerIndexs={5,6,7,8}
local _finalChampionIndex=9
local _finalLineLogicIndex={29,30,31}
local _finalLookLogicIndex={29,30}
local _finalChampionLogicIndex=31
function UIXianGuanWuXuanMatch2Win:refreshFinalShift()
self:refreshFinalShiftAllPlayer()
self:refreshFinalShiftAllLine()
self:refreshFinalShiftAllLook()
self:refreshFinalShiftChampion()
end

function UIXianGuanWuXuanMatch2Win:refreshFinalShiftAllPlayer()
for groupIndex=1,_finalGroupLen do
local matchIndex=groupIndex
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,4,matchIndex)

for matchSide=1,2 do
local fieldName=FMT.fmt("actor{0}_idx",matchSide)
local playerIndex=matchData and matchData[fieldName]or 0
local data,matchPlayerIndex=xianguanModel:getWuXuanFinalRegisterSingleData(self.job,playerIndex,groupIndex,matchSide)
local playerIdx=(groupIndex-1)*2+matchSide
local widget=self.finalWb:GetChildWidgetBase(_finalPlayerIndexs[playerIdx])
local inspectJob,inspectActor=xianguanModel:getWuXuanPlayerInspire()
local isInspiredTarget=inspectJob==self.job and inspectActor==playerIndex

widget:SetChildActive(_playerCmp.empty,data==nil)
widget:SetChildActive(_playerCmp.have,data~=nil)
if data then
local isSelf=playerModel:checkActorId(data.actor_id)
playerController:setHeadIcon(widget,_playerCmp.playerHead,{iconInfo=data.iconInfo,scale=_finalPlayerScale})
local nameStr=data.name
widget:SetChildText(_playerCmp.playerName,isSelf and FMT.cfmt2("#76D81E",nameStr)or nameStr)
local serverStr=loginModel:getServerName(data.server_id)
widget:SetChildText(_playerCmp.serverName,isSelf and FMT.cfmt2("#76D81E",serverStr)or serverStr)
widget:SetChildText(_playerCmp.inspireNum,data.inspired_num)
widget:SetChildActive(_playerCmp.inspired,isInspiredTarget)
widget:SetChildActive(_playerCmp.winner,matchData and matchData.win_actor_idx>0 and matchData.win_actor_idx==playerIndex)


widget:SetChildButtonClick(_playerCmp.playerBG,function()
self:onClickPlayer(matchData,matchSide,matchPlayerIndex)
end,true)
widget:SetChildButtonClick(_playerCmp.flag,function()
self:onClickInspire(matchData,matchSide,matchPlayerIndex)
end,true)
end
end
end
end

function UIXianGuanWuXuanMatch2Win:refreshFinalShiftAllLine()
for idx,lineIdx in ipairs(_finalLineIndexs)do
local index=_finalLineLogicIndex[idx]
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local data=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local widget=self.finalWb:GetChildWidgetBase(lineIdx)
if data and data.win_actor_idx>0 then
widget:SetChildActive(_lineCmp.up_1,data.actor1_idx==data.win_actor_idx)
widget:SetChildActive(_lineCmp.up_2,data.actor2_idx==data.win_actor_idx)
else
widget:SetChildActive(_lineCmp.up_1,false)
widget:SetChildActive(_lineCmp.up_2,false)
end
end
end

function UIXianGuanWuXuanMatch2Win:refreshFinalShiftAllLook()
for idx,lookIdx in ipairs(_finalLookIndexs)do
local index=_finalLookLogicIndex[idx]
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local data=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local widget=self.finalWb:GetChildWidgetBase(lookIdx)
widget:SetChildActive(_lookCmp.button,data~=nil and data.fight_log_id~="")

widget:SetChildButtonClick(_lookCmp.button,function()
self:onClickLook(index)
end,true)
end
end

function UIXianGuanWuXuanMatch2Win:refreshFinalShiftChampion()

local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(_finalChampionLogicIndex)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local playerIndex=matchData and matchData.win_actor_idx or 0
local logId=matchData and matchData.fight_log_id or""
local haveWinner=playerIndex>0

haveWinner=haveWinner
local haveLog=logId~=""
local widget=self.finalWb:GetChildWidgetBase(_finalChampionIndex)
widget:SetChildActive(_championCmp.look,haveLog)
widget:SetChildActive(_championCmp.empty,not haveWinner)
widget:SetChildActive(_championCmp.playerBG,haveWinner)
widget:SetChildActive(_championCmp.nameBg,haveWinner)
if haveWinner then
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,playerIndex)



playerController:setHeadIcon(widget,_championCmp.playerHead,{iconInfo=data.iconInfo,scale=0.5})
widget:SetChildText(_championCmp.playerName,data.name)
widget:SetChildText(_championCmp.serverName,FMT.fmt("[{0}]",loginModel:getServerName(data.server_id)))

widget:SetChildButtonClick(_championCmp.playerBG,function()
self:onClickChampionPlayer(_finalChampionLogicIndex)
end,true)
widget:SetChildButtonClick(_championCmp.look,function()
self:onClickChampionLook(_finalChampionLogicIndex)
end,true)
end
end

function UIXianGuanWuXuanMatch2Win:refreshFinalShiftInspireNum()
for groupIndex=1,_finalGroupLen do
local matchIndex=groupIndex
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,4,matchIndex)

for matchSide=1,2 do
local fieldName=FMT.fmt("actor{0}_idx",matchSide)
local playerIndex=matchData and matchData[fieldName]or 0
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,playerIndex)
local playerIdx=(groupIndex-1)*2+matchSide
local widget=self.finalWb:GetChildWidgetBase(_finalPlayerIndexs[playerIdx])
local inspectJob,inspectActor=xianguanModel:getWuXuanPlayerInspire()
local isInspiredTarget=inspectJob==self.job and inspectActor==playerIndex

if data then
widget:SetChildText(_playerCmp.inspireNum,data.inspired_num)
widget:SetChildActive(_playerCmp.inspired,isInspiredTarget)
end
end
end
end




function UIXianGuanWuXuanMatch2Win:refreshInspireBtn()
local segment=xianguanController:getActivitySegment_WuXuan_Compatible()
if segment==XianGuanWuXuanSegment.eReady then
local job=xianguanModel:getWuXuanPlayerJob()
if job and job>0 then
local registers=xianguanModel:getWuXuanRegisterJobData(job)
local match_conf=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"battle_conf")
local count=math.pow(2,#match_conf)
for i=1,count do
local registerData=registers[i]
if registerData then
if playerModel:checkActorId(registerData.actor_id)then
self.inspectBtn:setActive(true)
return
end
else
break
end
end
end
end
self.inspectBtn:setActive(false)
end

function UIXianGuanWuXuanMatch2Win:refreshRewardBtn()
local segment=xianguanModel:getWuXuanActivitySegment()
local reward=xianguanController:getWuXuanReddot_Compatible()
self.rewardBtn:setActive(reward)
end

function UIXianGuanWuXuanMatch2Win:refreshRound()
local activityData=xianguanModel:getWuXuanActivityData()
local segmentData=activityData.segmentData
local roundStr=""
local roundBgActive=false
local cdStr=""
if segmentData then
local segment=segmentData.status
local match_conf=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"battle_conf")
self.cdTime=nil
if segment==XianGuanWuXuanSegment.eReady or segment==XianGuanWuXuanSegment.eRegister then
self.cdTime=activityData.matchBTime
self.roundTx:setText(FMT.fmt("第1/{0}轮",#match_conf))
self.roundBg:setActive(true)
self.cdType=-1
elseif segment==XianGuanWuXuanSegment.eMatch then
local nowTime=timeHelper.getServerShortTime()
local round=nil
for i,v in ipairs(activityData.matchTime)do
if nowTime<v.endTime then
self.roundTx:setText(FMT.fmt("第{0}/{1}轮",i,#match_conf))
self.roundBg:setActive(true)
if nowTime>=v.beginTime then
self.cdTx:setText("进行中")
self.cdTime=v.endTime
self.cdType=-2
break


elseif nowTime<v.beginTime then
self.cdTime=v.beginTime
self.cdType=0
break
end
end
end
end
local logicRound=self:getLogicRound()
if logicRound>0 then
if logicRound==7 then
self.cdTime=nil
elseif logicRound==6 then
self.cdTime=nil
roundStr=FMT.fmt("第{0}/{1}轮",5,#match_conf)
roundBgActive=true
cdStr="已结束"
elseif logicRound==5 or logicRound==4 then
local nowTime=timeHelper.getServerShortTime()
local v=activityData.matchTime[logicRound]
self.roundTx:setText(FMT.fmt("第{0}/{1}轮",logicRound,#match_conf))
self.roundBg:setActive(true)
if nowTime>=v.beginTime then
self.cdTx:setText("进行中")
self.cdTime=v.endTime
self.cdType=-2
elseif nowTime<v.beginTime then
self.cdTime=v.beginTime
self.cdType=0
end
end
end

if self.cdTime then
if self:updateCDTick()then
self:showMatchingSpine(self.cdType==-2)
self:startCDTick()
else
self.cdTx:setText("")
self:stopCDTick()
self:showMatchingSpine(false)
end
return
end
end
self:showMatchingSpine(false)
self.roundTx:setText(roundStr)
self.roundBg:setActive(roundBgActive)
self.cdTx:setText(cdStr)
self:stopCDTick()
end

function UIXianGuanWuXuanMatch2Win:showMatchingSpine(show)
for i,v in ipairs(self.matching)do
v:setActive(show)
end
end

function UIXianGuanWuXuanMatch2Win:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
if not self:updateCDTick()then
self:refreshRound()
end
end)
end
end

function UIXianGuanWuXuanMatch2Win:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXianGuanWuXuanMatch2Win:updateCDTick()
local least=self.cdTime-timeHelper.getServerShortTime()
if least>0 then
if self.cdType~=-2 then
self.cdTx:setText(FMT.fmt("{0}后开启",timeHelper.format_time_stamp3(least)))
end
return true
end
return false
end

function UIXianGuanWuXuanMatch2Win.on_40_26()
_this:refreshRewardBtn()
end

function UIXianGuanWuXuanMatch2Win.on_40_29(len,list)
for i=1,len do
local data=list[i]
if data.xianguan_id==_this.job then


_this:refreshShiftContent()
end
end
end

function UIXianGuanWuXuanMatch2Win.on_40_30(xianguan_id)
if xianguan_id==_this.job then

_this:refreshShiftInspireNum()
end
end

function UIXianGuanWuXuanMatch2Win.onXianGuanJingXuanSegmentChange(campaignType)
if campaignType==XianGuanCampaignType.eWuXuan then
_this:refreshRewardBtn()
_this:refreshInspireBtn()
end
end

function UIXianGuanWuXuanMatch2Win:getShowTabDefaultIndex()
if xianguanModel:isOpenPredict(self.job)then
return 5
end

local job=xianguanModel:getWuXuanPlayerJob()
if self.job==job then

local roundData=xianguanModel:getWuXuanMatchRoundData(self.job,1)
if roundData then
local seat=nil
for index,matchData in pairs(roundData)do
if matchData.actor1_idx>0 then
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,matchData.actor1_idx)
if data and playerModel:checkActorId(data.actor_id)then
seat=index
break
end
end
if matchData.actor2_idx>0 then
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,matchData.actor2_idx)
if data and playerModel:checkActorId(data.actor_id)then
seat=index
break
end
end
end
if seat then
local index=Mathf.Floor(seat/4)+1
return index
end
end
end

return 1
end










function UIXianGuanWuXuanMatch2Win:getLogicRound()
local players=xianguanModel:getWuXuanRegisterJobData(self.job)
local playerLen=#players
if playerLen==0 then
return 0
end
if playerLen>4 then
return-1
end
if playerLen==1 then
return 6
end
local match_conf=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"battle_conf")
local curRoundIdx=xianguanModel:getCurRound_WuXuan()
if curRoundIdx==#match_conf then

return 5
end
if curRoundIdx==-1 then
return 7
end
return 4
end

