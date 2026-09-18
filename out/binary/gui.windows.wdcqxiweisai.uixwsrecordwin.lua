







def_class("UIXWSRecordWin",UIWindowBase)









function UIXWSRecordWin:bindComponents()

self.infoScrollView=UILoopListView.new(self,0)
self.empty=UIObject.get(self,1)

self.infoScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXWSRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
self.infoScrollView:deleteSelf();self.infoScrollView=nil;
_UIObject_release(self.empty);self.empty=nil;
end


















local itemCmp={
winFlag=0,
failFlag=1,
contect=2,
huifang=3,
}

function UIXWSRecordWin:onLoaded(...)
self:bindComponents()
end


function UIXWSRecordWin:__delete()
self:unbindComponents()
end




function UIXWSRecordWin:onShow(argtable,afterOnloaded)
if argtable and argtable.showRecordWin then
loadingControl.closeCloud()
end

local logList=XiWeiSaiModel:getData_logList()
if logList then
self.empty:setActive(false)
self.infoScrollView:setActive(true)
self.infoScrollView:initData("item",logList)
else
self.empty:setActive(true)
self.infoScrollView:setActive(false)
end
end


function UIXWSRecordWin:onHide()

end
















function UIXWSRecordWin:onFreshAction(index,widget,data)
local loginfo=data
local sec=loginfo.log_type==1
widget:SetChildActive(itemCmp.winFlag,sec)
widget:SetChildActive(itemCmp.failFlag,not sec)
local func=function()
self:replayFight(loginfo)
end
widget:SetChildButtonClick(itemCmp.huifang,func,true)
local actor_name=loginfo.actor_name
local sName=loginModel:getServerName(loginfo.server_id)
local fmtStr
if sec then
fmtStr="向<color=#7d3b17>【{0}】{1}</color>发起挑战，力胜强敌，席位升至第<color=#7d3b17>{2}</color>位"
widget:SetChildText(itemCmp.contect,FMT.fmt(fmtStr,sName,actor_name,loginfo.new_pos))
else
if loginfo.log_type==2 then
if loginfo.new_pos~=0 then
fmtStr="被<color=#7d3b17>【{0}】{1}</color>挑战，不慎落败，席位降至第<color=#7d3b17>{2}</color>位"
widget:SetChildText(itemCmp.contect,FMT.fmt(fmtStr,sName,actor_name,loginfo.new_pos))
else
fmtStr="被<color=#7d3b17>【{0}】{1}</color>挑战，不慎落败，暂无占据席位"
widget:SetChildText(itemCmp.contect,FMT.fmt(fmtStr,sName,actor_name))
end
elseif loginfo.log_type==3 then
fmtStr="向<color=#7d3b17>【{0}】{1}</color>发起挑战，憾负敌手，席位不变"
widget:SetChildText(itemCmp.contect,FMT.fmt(fmtStr,sName,actor_name))
end

end

end

function UIXWSRecordWin:onStartAction()

end

function UIXWSRecordWin:replayFight(loginfo)
local showBattle=true
local fightLogList=loginfo.FightLogList
local args={eReplayType=eRePlayerType.xiweisailog}
local myserver=FMT.fmt('[{0}]',loginModel:getMyServerName())

local name=loginfo.actor_name
local info=loginfo.iconInfo
local server=loginModel:getServerName(loginfo.server_id)
server=FMT.fmt('[{0}]',server)
args.showBattle=showBattle
if showBattle then
args.player1={playerModel:getActorName(),playerModel:getActorIconInfo()}
args.player2={name,info}
else
args.player1={playerModel:getActorID(),playerModel:getActorName(),playerModel:getActorIconInfo(),myserver}
args.player2={loginfo.actorid,name,info,server}
end

if loginfo.log_type==2 then
local player=args.player1
args.player1=args.player2
args.player2=player
end

args.fightCloseCallBack=function(battle)
loadingControl.openCloud(function()
UIFullWenDingCangQiongControl:showHaiXuanWin({showRecordWin=true})
if battle then
fightController:closeBattle(battle)
end
end)
end

fightModel:setSendExtraArgs(eBattleType.wdcqxiweisai,args)
fightController:send_log_list(fightLogList,args,true,true,bigCrossActType.eWDCQ)
end




function UIXWSRecordWin:onCloseClick()
self:closeSelf()
end
