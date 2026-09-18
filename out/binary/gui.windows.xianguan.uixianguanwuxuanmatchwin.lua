







def_class("UIXianGuanWuXuanMatchWin",UIWindowBase)









function UIXianGuanWuXuanMatchWin:bindComponents()

self.cdTx=UIText.get(self,0)
self.champion_31=UIObject.get(self,1)
self.content=UIObject.get(self,2)
self.inspectBtn=UIButton.get(self,3)
self.line_1=UIObject.get(self,4)
self.line_10=UIObject.get(self,5)
self.line_11=UIObject.get(self,6)
self.line_12=UIObject.get(self,7)
self.line_13=UIObject.get(self,8)
self.line_14=UIObject.get(self,9)
self.line_15=UIObject.get(self,10)
self.line_16=UIObject.get(self,11)
self.line_17=UIObject.get(self,12)
self.line_18=UIObject.get(self,13)
self.line_19=UIObject.get(self,14)
self.line_2=UIObject.get(self,15)
self.line_20=UIObject.get(self,16)
self.line_21=UIObject.get(self,17)
self.line_22=UIObject.get(self,18)
self.line_23=UIObject.get(self,19)
self.line_24=UIObject.get(self,20)
self.line_25=UIObject.get(self,21)
self.line_26=UIObject.get(self,22)
self.line_27=UIObject.get(self,23)
self.line_28=UIObject.get(self,24)
self.line_29=UIObject.get(self,25)
self.line_3=UIObject.get(self,26)
self.line_30=UIObject.get(self,27)
self.line_31=UIObject.get(self,28)
self.line_4=UIObject.get(self,29)
self.line_5=UIObject.get(self,30)
self.line_6=UIObject.get(self,31)
self.line_7=UIObject.get(self,32)
self.line_8=UIObject.get(self,33)
self.line_9=UIObject.get(self,34)
self.look_1=UIObject.get(self,35)
self.look_10=UIObject.get(self,36)
self.look_11=UIObject.get(self,37)
self.look_12=UIObject.get(self,38)
self.look_13=UIObject.get(self,39)
self.look_14=UIObject.get(self,40)
self.look_15=UIObject.get(self,41)
self.look_16=UIObject.get(self,42)
self.look_17=UIObject.get(self,43)
self.look_18=UIObject.get(self,44)
self.look_19=UIObject.get(self,45)
self.look_2=UIObject.get(self,46)
self.look_20=UIObject.get(self,47)
self.look_21=UIObject.get(self,48)
self.look_22=UIObject.get(self,49)
self.look_23=UIObject.get(self,50)
self.look_24=UIObject.get(self,51)
self.look_29=UIObject.get(self,52)
self.look_3=UIObject.get(self,53)
self.look_30=UIObject.get(self,54)
self.look_4=UIObject.get(self,55)
self.look_5=UIObject.get(self,56)
self.look_6=UIObject.get(self,57)
self.look_7=UIObject.get(self,58)
self.look_8=UIObject.get(self,59)
self.look_9=UIObject.get(self,60)
self.matching_1=UIObject.get(self,61)
self.matching_2=UIObject.get(self,62)
self.player_1=UIObject.get(self,63)
self.player_10=UIObject.get(self,64)
self.player_11=UIObject.get(self,65)
self.player_12=UIObject.get(self,66)
self.player_13=UIObject.get(self,67)
self.player_14=UIObject.get(self,68)
self.player_15=UIObject.get(self,69)
self.player_16=UIObject.get(self,70)
self.player_17=UIObject.get(self,71)
self.player_18=UIObject.get(self,72)
self.player_19=UIObject.get(self,73)
self.player_2=UIObject.get(self,74)
self.player_20=UIObject.get(self,75)
self.player_21=UIObject.get(self,76)
self.player_22=UIObject.get(self,77)
self.player_23=UIObject.get(self,78)
self.player_24=UIObject.get(self,79)
self.player_25=UIObject.get(self,80)
self.player_26=UIObject.get(self,81)
self.player_27=UIObject.get(self,82)
self.player_28=UIObject.get(self,83)
self.player_29=UIObject.get(self,84)
self.player_3=UIObject.get(self,85)
self.player_30=UIObject.get(self,86)
self.player_31=UIObject.get(self,87)
self.player_32=UIObject.get(self,88)
self.player_4=UIObject.get(self,89)
self.player_5=UIObject.get(self,90)
self.player_6=UIObject.get(self,91)
self.player_7=UIObject.get(self,92)
self.player_8=UIObject.get(self,93)
self.player_9=UIObject.get(self,94)
self.rewardBtn=UIButton.get(self,95)
self.roundBg=UIObject.get(self,96)
self.roundTx=UIText.get(self,97)
self.scrollView=UIObject.get(self,98)
self.tweenMask=UIObject.get(self,99)
self.winner_25=UIObject.get(self,100)
self.winner_26=UIObject.get(self,101)
self.winner_27=UIObject.get(self,102)
self.winner_28=UIObject.get(self,103)

self.inspectBtn:setButtonClick(function()self:onInspectBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)
self.champion={
[31]=self.champion_31,
}
self.line={
self.line_1,
self.line_2,
self.line_3,
self.line_4,
self.line_5,
self.line_6,
self.line_7,
self.line_8,
self.line_9,
self.line_10,
self.line_11,
self.line_12,
self.line_13,
self.line_14,
self.line_15,
self.line_16,
self.line_17,
self.line_18,
self.line_19,
self.line_20,
self.line_21,
self.line_22,
self.line_23,
self.line_24,
self.line_25,
self.line_26,
self.line_27,
self.line_28,
self.line_29,
self.line_30,
self.line_31,
}
self.look={
[1]=self.look_1,
[2]=self.look_2,
[3]=self.look_3,
[4]=self.look_4,
[5]=self.look_5,
[6]=self.look_6,
[7]=self.look_7,
[8]=self.look_8,
[9]=self.look_9,
[10]=self.look_10,
[11]=self.look_11,
[12]=self.look_12,
[13]=self.look_13,
[14]=self.look_14,
[15]=self.look_15,
[16]=self.look_16,
[17]=self.look_17,
[18]=self.look_18,
[19]=self.look_19,
[20]=self.look_20,
[21]=self.look_21,
[22]=self.look_22,
[23]=self.look_23,
[24]=self.look_24,
[29]=self.look_29,
[30]=self.look_30,
}
self.matching={
self.matching_1,
self.matching_2,
}
self.player={
self.player_1,
self.player_2,
self.player_3,
self.player_4,
self.player_5,
self.player_6,
self.player_7,
self.player_8,
self.player_9,
self.player_10,
self.player_11,
self.player_12,
self.player_13,
self.player_14,
self.player_15,
self.player_16,
self.player_17,
self.player_18,
self.player_19,
self.player_20,
self.player_21,
self.player_22,
self.player_23,
self.player_24,
self.player_25,
self.player_26,
self.player_27,
self.player_28,
self.player_29,
self.player_30,
self.player_31,
self.player_32,
}
self.winner={
[25]=self.winner_25,
[26]=self.winner_26,
[27]=self.winner_27,
[28]=self.winner_28,
}



end


function UIXianGuanWuXuanMatchWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.champion_31);self.champion_31=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.inspectBtn);self.inspectBtn=nil;
_UIObject_release(self.line_1);self.line_1=nil;
_UIObject_release(self.line_10);self.line_10=nil;
_UIObject_release(self.line_11);self.line_11=nil;
_UIObject_release(self.line_12);self.line_12=nil;
_UIObject_release(self.line_13);self.line_13=nil;
_UIObject_release(self.line_14);self.line_14=nil;
_UIObject_release(self.line_15);self.line_15=nil;
_UIObject_release(self.line_16);self.line_16=nil;
_UIObject_release(self.line_17);self.line_17=nil;
_UIObject_release(self.line_18);self.line_18=nil;
_UIObject_release(self.line_19);self.line_19=nil;
_UIObject_release(self.line_2);self.line_2=nil;
_UIObject_release(self.line_20);self.line_20=nil;
_UIObject_release(self.line_21);self.line_21=nil;
_UIObject_release(self.line_22);self.line_22=nil;
_UIObject_release(self.line_23);self.line_23=nil;
_UIObject_release(self.line_24);self.line_24=nil;
_UIObject_release(self.line_25);self.line_25=nil;
_UIObject_release(self.line_26);self.line_26=nil;
_UIObject_release(self.line_27);self.line_27=nil;
_UIObject_release(self.line_28);self.line_28=nil;
_UIObject_release(self.line_29);self.line_29=nil;
_UIObject_release(self.line_3);self.line_3=nil;
_UIObject_release(self.line_30);self.line_30=nil;
_UIObject_release(self.line_31);self.line_31=nil;
_UIObject_release(self.line_4);self.line_4=nil;
_UIObject_release(self.line_5);self.line_5=nil;
_UIObject_release(self.line_6);self.line_6=nil;
_UIObject_release(self.line_7);self.line_7=nil;
_UIObject_release(self.line_8);self.line_8=nil;
_UIObject_release(self.line_9);self.line_9=nil;
_UIObject_release(self.look_1);self.look_1=nil;
_UIObject_release(self.look_10);self.look_10=nil;
_UIObject_release(self.look_11);self.look_11=nil;
_UIObject_release(self.look_12);self.look_12=nil;
_UIObject_release(self.look_13);self.look_13=nil;
_UIObject_release(self.look_14);self.look_14=nil;
_UIObject_release(self.look_15);self.look_15=nil;
_UIObject_release(self.look_16);self.look_16=nil;
_UIObject_release(self.look_17);self.look_17=nil;
_UIObject_release(self.look_18);self.look_18=nil;
_UIObject_release(self.look_19);self.look_19=nil;
_UIObject_release(self.look_2);self.look_2=nil;
_UIObject_release(self.look_20);self.look_20=nil;
_UIObject_release(self.look_21);self.look_21=nil;
_UIObject_release(self.look_22);self.look_22=nil;
_UIObject_release(self.look_23);self.look_23=nil;
_UIObject_release(self.look_24);self.look_24=nil;
_UIObject_release(self.look_29);self.look_29=nil;
_UIObject_release(self.look_3);self.look_3=nil;
_UIObject_release(self.look_30);self.look_30=nil;
_UIObject_release(self.look_4);self.look_4=nil;
_UIObject_release(self.look_5);self.look_5=nil;
_UIObject_release(self.look_6);self.look_6=nil;
_UIObject_release(self.look_7);self.look_7=nil;
_UIObject_release(self.look_8);self.look_8=nil;
_UIObject_release(self.look_9);self.look_9=nil;
_UIObject_release(self.matching_1);self.matching_1=nil;
_UIObject_release(self.matching_2);self.matching_2=nil;
_UIObject_release(self.player_1);self.player_1=nil;
_UIObject_release(self.player_10);self.player_10=nil;
_UIObject_release(self.player_11);self.player_11=nil;
_UIObject_release(self.player_12);self.player_12=nil;
_UIObject_release(self.player_13);self.player_13=nil;
_UIObject_release(self.player_14);self.player_14=nil;
_UIObject_release(self.player_15);self.player_15=nil;
_UIObject_release(self.player_16);self.player_16=nil;
_UIObject_release(self.player_17);self.player_17=nil;
_UIObject_release(self.player_18);self.player_18=nil;
_UIObject_release(self.player_19);self.player_19=nil;
_UIObject_release(self.player_2);self.player_2=nil;
_UIObject_release(self.player_20);self.player_20=nil;
_UIObject_release(self.player_21);self.player_21=nil;
_UIObject_release(self.player_22);self.player_22=nil;
_UIObject_release(self.player_23);self.player_23=nil;
_UIObject_release(self.player_24);self.player_24=nil;
_UIObject_release(self.player_25);self.player_25=nil;
_UIObject_release(self.player_26);self.player_26=nil;
_UIObject_release(self.player_27);self.player_27=nil;
_UIObject_release(self.player_28);self.player_28=nil;
_UIObject_release(self.player_29);self.player_29=nil;
_UIObject_release(self.player_3);self.player_3=nil;
_UIObject_release(self.player_30);self.player_30=nil;
_UIObject_release(self.player_31);self.player_31=nil;
_UIObject_release(self.player_32);self.player_32=nil;
_UIObject_release(self.player_4);self.player_4=nil;
_UIObject_release(self.player_5);self.player_5=nil;
_UIObject_release(self.player_6);self.player_6=nil;
_UIObject_release(self.player_7);self.player_7=nil;
_UIObject_release(self.player_8);self.player_8=nil;
_UIObject_release(self.player_9);self.player_9=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.roundBg);self.roundBg=nil;
_UIObject_release(self.roundTx);self.roundTx=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.tweenMask);self.tweenMask=nil;
_UIObject_release(self.winner_25);self.winner_25=nil;
_UIObject_release(self.winner_26);self.winner_26=nil;
_UIObject_release(self.winner_27);self.winner_27=nil;
_UIObject_release(self.winner_28);self.winner_28=nil;
self.champion=nil;
self.line=nil;
self.look=nil;
self.matching=nil;
self.player=nil;
self.winner=nil;
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



function UIXianGuanWuXuanMatchWin:onLoaded(...)
self:bindComponents()
_this=self
self:addProNotify(40,26,self.on_40_26)
self:addProNotify(40,29,self.on_40_29)
self:addProNotify(40,30,self.on_40_30)
self:addNotify(notifyConfig.onXianGuanJingXuanSegmentChange,self.onXianGuanJingXuanSegmentChange)
self.oScale=self.content:getScale()
self:initAllPlayer()
self:initAllLook()
self:initAllWinner()
self:initChampion()
end


function UIXianGuanWuXuanMatchWin:__delete()
self:unbindComponents()
_this=nil

self:killLookAtCenter()
end




function UIXianGuanWuXuanMatchWin:onShow(argtable,afterOnloaded)
self.job=argtable.job
self:refreshView()
self:lookAtCenter()
end


function UIXianGuanWuXuanMatchWin:onHide()

end




function UIXianGuanWuXuanMatchWin:onInspectBtn()
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

function UIXianGuanWuXuanMatchWin:onRewardBtn()

local segment=xianguanController:getActivitySegment_WuXuan_Compatible()
local reward=xianguanController:getWuXuanReddot_Compatible()
if reward then
xianguanController:send_40_26(segment)
end
end

function UIXianGuanWuXuanMatchWin:onClickPlayer(index)
local matchIndex=math.ceil(index/2)
local matchSide=2-(index%2)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,1,matchIndex)
local fieldName=FMT.fmt("actor{0}_idx",matchSide)
local playerIndex=matchData and matchData[fieldName]or 0
if playerIndex>0 then
UIFullXJForceControl:showWuXuanTeamWin(self.job,playerIndex)
end
end

function UIXianGuanWuXuanMatchWin:onClickInspire(index)





local matchIndex=math.ceil(index/2)
local matchSide=2-(index%2)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,1,matchIndex)
local fieldName=FMT.fmt("actor{0}_idx",matchSide)
local playerIndex=matchData and matchData[fieldName]or 0
if playerIndex>0 then
local args={
parentWin=self,
job=self.job,
playerIdx=playerIndex,
}
self:showWindow("UIXianGuanWuXuanInspireWin",args)
end
end

function UIXianGuanWuXuanMatchWin:onClickLook(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
xianguanController:watchWuXuanBattle(self.job,round,roundIdx)
end

function UIXianGuanWuXuanMatchWin:onClickWinnerPlayer(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local playerIndex=matchData and matchData.win_actor_idx or 0
if playerIndex>0 then
UIFullXJForceControl:showWuXuanTeamWin(self.job,playerIndex)
end
end

function UIXianGuanWuXuanMatchWin:onClickWinnerLook(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
xianguanController:watchWuXuanBattle(self.job,round,roundIdx)
end

function UIXianGuanWuXuanMatchWin:onClickChampionPlayer(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local playerIndex=matchData and matchData.win_actor_idx or 0
if playerIndex>0 then
UIFullXJForceControl:showWuXuanTeamWin(self.job,playerIndex)
end
end

function UIXianGuanWuXuanMatchWin:onClickChampionLook(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
xianguanController:watchWuXuanBattle(self.job,round,roundIdx)
end

function UIXianGuanWuXuanMatchWin:refreshView()
self:refreshRewardBtn()
self:refreshInspireBtn()
self:refreshAllPlayer()
self:refreshAllLine()
self:refreshAllLook()
self:refreshAllWinner()
self:refreshAllChampion()
self:refreshRound()
end

function UIXianGuanWuXuanMatchWin:refreshAllPlayer()
for i,v in ipairs(self.player)do
self:refreshPlayer(i)
end
end

function UIXianGuanWuXuanMatchWin:refreshAllPlayerInspiredNum()
for i,v in ipairs(self.player)do
self:refreshPlayerInspiredNum(i)
end
end

function UIXianGuanWuXuanMatchWin:initAllPlayer()
for i,v in ipairs(self.player)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_playerCmp.playerBG,function()
self:onClickPlayer(i)
end)
widget:SetChildButtonClick(_playerCmp.flag,function()
self:onClickInspire(i)
end)
end
end

function UIXianGuanWuXuanMatchWin:refreshPlayer(index)
local matchIndex=math.ceil(index/2)
local matchSide=2-(index%2)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,1,matchIndex)
local fieldName=FMT.fmt("actor{0}_idx",matchSide)
local playerIndex=matchData and matchData[fieldName]or 0
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,playerIndex)
local widget=self.player[index]:getChildWidgetBase()
local inspectJob,inspectActor=xianguanModel:getWuXuanPlayerInspire()
local isInspiredTarget=inspectJob==self.job and inspectActor==playerIndex

widget:SetChildActive(_playerCmp.empty,data==nil)
widget:SetChildActive(_playerCmp.have,data~=nil)
if data then
local isSelf=playerModel:checkActorId(data.actor_id)
playerController:setHeadIcon(widget,_playerCmp.playerHead,{iconInfo=data.iconInfo,scale=0.425})
local nameStr=data.name
widget:SetChildText(_playerCmp.playerName,isSelf and FMT.cfmt2("#76D81E",nameStr)or nameStr)
local serverStr=loginModel:getServerName(data.server_id)
widget:SetChildText(_playerCmp.serverName,isSelf and FMT.cfmt2("#76D81E",serverStr)or serverStr)
widget:SetChildText(_playerCmp.inspireNum,data.inspired_num)
widget:SetChildActive(_playerCmp.inspired,isInspiredTarget)
widget:SetChildActive(_playerCmp.winner,matchData.win_actor_idx>0 and matchData.win_actor_idx==playerIndex)
end
end

function UIXianGuanWuXuanMatchWin:refreshPlayerInspiredNum(index)
local matchIndex=math.ceil(index/2)
local matchSide=2-(index%2)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,1,matchIndex)
local fieldName=FMT.fmt("actor{0}_idx",matchSide)
local playerIndex=matchData and matchData[fieldName]or 0
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,playerIndex)
if data then
local widget=self.player[index]:getChildWidgetBase()
widget:SetChildText(_playerCmp.inspireNum,data.inspired_num)
end
end

function UIXianGuanWuXuanMatchWin:refreshAllLine()
for i,v in ipairs(self.line)do
self:refreshLine(i)
end
end

function UIXianGuanWuXuanMatchWin:refreshLine(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local data=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local widget=self.line[index]:getChildWidgetBase()
if data and data.win_actor_idx>0 then
widget:SetChildActive(_lineCmp.up_1,data.actor1_idx==data.win_actor_idx)
widget:SetChildActive(_lineCmp.up_2,data.actor2_idx==data.win_actor_idx)
else
widget:SetChildActive(_lineCmp.up_1,false)
widget:SetChildActive(_lineCmp.up_2,false)
end
end

function UIXianGuanWuXuanMatchWin:refreshAllLook()
for i,v in pairs(self.look)do
self:refreshLook(i)
end
end

function UIXianGuanWuXuanMatchWin:initAllLook()
for i,v in pairs(self.look)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_lookCmp.button,function()
self:onClickLook(i)
end)
end
end

function UIXianGuanWuXuanMatchWin:refreshLook(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local data=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local widget=self.look[index]:getChildWidgetBase()
widget:SetChildActive(_lookCmp.button,data~=nil and data.fight_log_id~="")
end

function UIXianGuanWuXuanMatchWin:refreshAllWinner()
for i,v in pairs(self.winner)do
self:refreshWinner(i)
end
end

function UIXianGuanWuXuanMatchWin:initAllWinner()
for i,v in pairs(self.winner)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_winnerCmp.playerBG,function()
self:onClickWinnerPlayer(i)
end)
widget:SetChildButtonClick(_winnerCmp.look,function()
self:onClickWinnerLook(i)
end)
end
end

function UIXianGuanWuXuanMatchWin:refreshWinner(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local playerIndex=matchData and matchData.win_actor_idx or 0
local logId=matchData and matchData.fight_log_id or""
local haveWinner=playerIndex>0
local haveReport=logId~=""

local widget=self.winner[index]:getChildWidgetBase()
widget:SetChildActive(_winnerCmp.look,haveReport)
widget:SetChildActive(_winnerCmp.empty,not haveWinner)
widget:SetChildActive(_winnerCmp.have,haveWinner)
if haveWinner then
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,playerIndex)
playerController:setHeadIcon(widget,_winnerCmp.playerHead,{iconInfo=data.iconInfo,scale=0.5})
widget:SetChildText(_winnerCmp.playerName,data.name)
widget:SetChildText(_winnerCmp.serverName,FMT.fmt("[{0}]",loginModel:getServerName(data.server_id)))
end
end

function UIXianGuanWuXuanMatchWin:initChampion()
for i,v in pairs(self.champion)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_championCmp.playerBG,function()
self:onClickChampionPlayer(i)
end)
widget:SetChildButtonClick(_championCmp.look,function()
self:onClickChampionLook(i)
end)
end
end

function UIXianGuanWuXuanMatchWin:refreshAllChampion()
for i,v in pairs(self.champion)do
self:refreshChampion(i)
end
end

function UIXianGuanWuXuanMatchWin:refreshChampion(index)
local round,roundIdx=xianguanModel:convertWuXuanBattleIdx2RoundIdx(index)
local matchData=xianguanModel:getWuXuanMatchSingleData(self.job,round,roundIdx)
local playerIndex=matchData and matchData.win_actor_idx or 0
local logId=matchData and matchData.fight_log_id or""
local haveWinner=playerIndex>0
local haveLog=logId~=""
local widget=self.champion[index]:getChildWidgetBase()
widget:SetChildActive(_championCmp.look,haveLog)
widget:SetChildActive(_championCmp.empty,not haveWinner)
widget:SetChildActive(_championCmp.playerBG,haveWinner)
widget:SetChildActive(_championCmp.nameBg,haveWinner)
if haveWinner then
local data=xianguanModel:getWuXuanRegisterSingleData(self.job,playerIndex)
playerController:setHeadIcon(widget,_championCmp.playerHead,{iconInfo=data.iconInfo,scale=0.5})
widget:SetChildText(_championCmp.playerName,data.name)
widget:SetChildText(_championCmp.serverName,FMT.fmt("[{0}]",loginModel:getServerName(data.server_id)))
end
end

function UIXianGuanWuXuanMatchWin:refreshRoundMatch(round)
local battle_conf=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"battle_conf")
local count=#battle_conf
local battleNum=math.pow(2,count-round)
for index=1,battleNum do
local matchIdx=xianguanModel:convertWuXuanRoundIdx2BattleIdx(round,index)
if self.look[matchIdx]then
self:refreshLook(matchIdx)
end
if self.winner[matchIdx]then
self:refreshWinner(matchIdx)
end
if self.champion[matchIdx]then
self:refreshChampion(matchIdx)
end
if self.line[matchIdx]then
self:refreshLine(matchIdx)
end
end









if round==1 then
self:refreshAllPlayer()
end
end

function UIXianGuanWuXuanMatchWin:refreshInspireBtn()
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

function UIXianGuanWuXuanMatchWin:refreshRewardBtn()
local segment=xianguanModel:getWuXuanActivitySegment()
local reward=xianguanController:getWuXuanReddot_Compatible()
self.rewardBtn:setActive(reward)
end

function UIXianGuanWuXuanMatchWin:refreshRound()
local activityData=xianguanModel:getWuXuanActivityData()
local segmentData=activityData.segmentData
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
self.roundTx:setText("")
self.roundBg:setActive(false)
self.cdTx:setText("")
self:stopCDTick()
end

function UIXianGuanWuXuanMatchWin:showMatchingSpine(show)
for i,v in ipairs(self.matching)do
v:setActive(show)
end
end

function UIXianGuanWuXuanMatchWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
if not self:updateCDTick()then
self:refreshRound()
end
end)
end
end

function UIXianGuanWuXuanMatchWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXianGuanWuXuanMatchWin:updateCDTick()
local least=self.cdTime-timeHelper.getServerShortTime()
if least>0 then
if self.cdType~=-2 then
self.cdTx:setText(FMT.fmt("{0}后开启",timeHelper.format_time_stamp3(least)))
end
return true
end
return false
end

function UIXianGuanWuXuanMatchWin:killLookAtCenter()
if self.lookAtTween then
self.lookAtTween:Kill()
self.lookAtTween=nil
end
end

function UIXianGuanWuXuanMatchWin:doLookAtCenter(x,y)
self.tweenMask:setActive(true)
self.content:setChildAnchoredPos(0,0)
self.lookAtTween=self.content:setChildDOAnchorPos(Vector2.New(x,y),0.2,function()
self.tweenMask:setActive(false)
end)
self.lookAtTween:SetDelay(0.5)
end

function UIXianGuanWuXuanMatchWin:lookAtCenter()
self:killLookAtCenter()
self.tweenMask:setActive(false)

self.content:setScale(self.oScale)
local segment=xianguanModel:getWuXuanActivitySegment()
if segment==XianGuanWuXuanSegment.eFinish then
self.content:setChildAnchoredPos(0,0)
return
elseif segment==XianGuanWuXuanSegment.eMatch then
local activity=xianguanModel:getWuXuanActivityData()
local matchCnt=#activity.matchTime
local nowTime=timeHelper.getServerShortTime()
if nowTime>=activity.matchTime[matchCnt-1].beginTime then
self.content:setChildAnchoredPos(0,0)
return
end
end
local contentWidth=self.content:getChildSizeDeltaX()
local contentHeight=self.content:getChildSizeDeltaY()
local contentScale=self.content:getScale()
local viewWidth=self.scrollView:getChildSizeDeltaX()
local viewHeight=self.scrollView:getChildSizeDeltaY()
local width=contentWidth*contentScale.x/2-viewWidth/2
local height=contentHeight*contentScale.y/2-viewHeight/2
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
local side=math.ceil(seat/4)
local _w=side<=2 and 1 or-1
local _h=side%2==1 and-1 or 1

self:doLookAtCenter(_w*width,_h*height)
return
end
end
end

self:doLookAtCenter(width,-height)
end

function UIXianGuanWuXuanMatchWin.on_40_26()
_this:refreshRewardBtn()
end

function UIXianGuanWuXuanMatchWin.on_40_29(len,list)
for i=1,len do
local data=list[i]
if data.xianguan_id==_this.job then
_this:refreshRoundMatch(data.group_type)
end
end
end

function UIXianGuanWuXuanMatchWin.on_40_30(xianguan_id)
if xianguan_id==_this.job then
_this:refreshAllPlayerInspiredNum()
end
end

function UIXianGuanWuXuanMatchWin.onXianGuanJingXuanSegmentChange(campaignType)
if campaignType==XianGuanCampaignType.eWuXuan then
_this:refreshRewardBtn()
_this:refreshInspireBtn()
end
end

function UIXianGuanWuXuanMatchWin:onTweenMask()
self:killLookAtCenter()
self.tweenMask:setActive(false)
end