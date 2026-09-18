






local _MODULENAME="DiZiDuelModel"


def_table(_MODULENAME)
DiZiDuelModel.name=_MODULENAME
DiZiDuelModel.data={}

function DiZiDuelModel:onAppStart()

end


function DiZiDuelModel:onEnterState(isReconnect)

end


function DiZiDuelModel:onLeaveState(isReconnect)

self.data={}
end



function DiZiDuelModel:initData(args1,args2,args3)
self.data.allow=args1
self.data.sec=args2
self.data.dueltimes=args3 or 0
if not self.data.OtherIconInfo then
self.data.OtherIconInfo={}
end
































end


function DiZiDuelModel:fenxiangData(args1,args2,args3)
self.data.findserverid=args1
self.data.findactorid=args2
self.data.findret=args3

end


function DiZiDuelModel:resultData(args1,args2,args3,args4,args5,args6,args7,args8)
self.data.serverid=args1
self.data.actorid=args2
self.data.actorname=args3
self.data.actoriconinfo=args4
self.data.result=args5
self.data.fightlogid=args6
self.data.selfFright=args7
self.data.otherFright=args8
end


function DiZiDuelModel:Frightsetting(allow)
self.data.allow=allow
end


function DiZiDuelModel:newbieindex(id)
self.data.newbieindex=id
end


function DiZiDuelModel:getallow()
return self.data.allow
end


function DiZiDuelModel:getAllData()

return self.data or{}
end


function DiZiDuelModel:setOtherIconInfo(actorid,iconinfo)
if not self.data.OtherIconInfo then
self.data.OtherIconInfo={}
end
if actorid and iconinfo then
self.data.OtherIconInfo[actorid]={}
self.data.OtherIconInfo[actorid]=iconinfo
end
end
function DiZiDuelModel:getOtherIconInfo(actorid)
if actorid and self.data.OtherIconInfo[actorid]then
return self.data.OtherIconInfo[actorid]
else
return false
end
end



function DiZiDuelModel:onCompleteBattle()
local otherserverid=self.data.serverid
local otheractorid=self.data.actorid
local otheractorname=self.data.actorname
local otheractoriconinfo=self.data.actoriconinfo
local fightlogid=self.data.fightlogid

local key=mathHelper.int64_to_string(otheractorid)
self:setOtherIconInfo(key,otheractoriconinfo)

local serverid=playerModel:getActorServerID()
local actorname=playerModel:getActorName()
local result=self.data.result
local selfFright=self.data.selfFright
local otherFright=self.data.otherFright


local otherserverName=loginModel:getServerName(otherserverid)
local strOtherServerName=FMT.fmt('[{0}]',otherserverName)


local strDesc=""
if result==1 then

strDesc=cfgHelper.getlang('dizi_qiecuo_result_lose')
elseif result==2 then

strDesc=cfgHelper.getlang('dizi_qiecuo_result_win')
elseif result==3 then

strDesc=cfgHelper.getlang('dizi_qiecuo_result_win')
end


local strName=FMT.fmt('{3}<a;{0};4;1;14,{1},{2};/>',otheractorname,tostring(otheractorid),tostring(otherserverid),strOtherServerName)



local strFightlogidlink=FMT.fmt('<a;战报;1;1;15,{0},{1},{2},{3},{4},{5},{6};/>',fightlogid,tostring(otherserverid),tostring(otheractorid),otheractorname,tostring(result),tostring(selfFright),tostring(otherFright))
local strFightlogid=FMT.fmt('[{0}]',strFightlogidlink)


local Allstr=FMT.fmt('{0}{1}{2}',strName,strDesc,strFightlogid)
chatControl.addJianWenMesg(CHAT_MSG_TYPE.eQieCuo,Allstr,nil)
end


function DiZiDuelModel:onCompleteBattletestttt()
local strDesc=cfgHelper.getlang('dizi_qiecuo_result_lose')
local str2="[<a;战报;1;1;15,20271106/week_55076_215355398_3_29,76,1131701605498956,依依,2,12398721,12493101;/>]"
local str=FMT.fmt('[76服]<a;切磋弟子名字;1;1;14,{0},{1};/>{2}{3}',tostring(int64.new("1135000140382284")),tostring(76),strDesc,str2)
chatControl.addJianWenMesg(CHAT_MSG_TYPE.eQieCuo,str,nil)
end



function DiZiDuelModel:setbattlelog(log)

end

function DiZiDuelModel:getbattlelog()
local log=userActorSetting.get('DiZiDuelModel_log',false)

return'DiZiDuelModel_log'
end


function DiZiDuelModel:adddueltimes()
if not self.data.dueltimes then
self.data.dueltimes=0
end
self.data.dueltimes=self.data.dueltimes+1
end
function DiZiDuelModel:adddqiecnum()

end

function DiZiDuelModel:resetDueltimes()
if self.data.sec then
local longtime=timeHelper.convertLongStamp(self.data.sec)
if not timeHelper.isTodayStamp(longtime)then
self.data.dueltimes=0
end
end
end


function DiZiDuelModel:isDefTeams(isteam)
self.data.isteam=isteam
end
function DiZiDuelModel:getisDefTeams()
return self.data.isteam
end


function DiZiDuelModel:resetDueltimesDayFive()









end


function DiZiDuelModel:setCallBackType(cbtype)
self.data.cbtype=cbtype
end
function DiZiDuelModel:getCallBackType()
return self.data.cbtype
end

function DiZiDuelModel:getCallBackFun(cbtype,actor_id,othersever_id)
local funa
if cbtype==DiZiqiecuotype.liaotian then
funa=function()
UIManager:showWindow('UIChatWin')
local attach=nil
if othersever_id~=playerModel:getActorServerID()then
attach={serverid=othersever_id}
end
otherPlayerController:openOtherPlayerInfoWin(actor_id,nil,nil,attach)
end

elseif cbtype==DiZiqiecuotype.xianyou then
funa=function()
local jumpId=JUMP_TYPE.eFriend
if jumpId==JUMP_TYPE.eFriend then

local tabType=FULL_TAB_TYPE.eFriendList
local fulltabconfig=fullScreenModel.getFullTabConfig(tabType)
local ret,checkArgs=fullScreenModel.checkCND(fulltabconfig.cnd)
if ret==false then
else
jumpManager:jump({id=jumpId,args={tab=2},},function()
local attach=nil
if othersever_id~=playerModel:getActorServerID()then
attach={serverid=othersever_id}
end
otherPlayerController:openOtherPlayerInfoWin(actor_id,nil,nil,attach)
end)
end
end
end

elseif cbtype==DiZiqiecuotype.xmdadain then
funa=function()
UIFullXianMengPalaceControl:showWindowPalaceInfo()
local attach=nil
if othersever_id~=playerModel:getActorServerID()then
attach={serverid=othersever_id}
end
otherPlayerController:openOtherPlayerInfoWin(actor_id,nil,nil,attach)
end

elseif cbtype==DiZiqiecuotype.xmddother then
funa=function()
UIFullXianMengPalaceControl:showWindowXMListInfo()
local attach=nil
if othersever_id~=playerModel:getActorServerID()then
attach={serverid=othersever_id}
end
otherPlayerController:openOtherPlayerInfoWin(actor_id,nil,nil,attach)
end

elseif cbtype==DiZiqiecuotype.xmgfb then
funa=function()
UIFullXMGongXunBangControl:showWindowRank()
local attach=nil
if othersever_id~=playerModel:getActorServerID()then
attach={serverid=othersever_id}
end
otherPlayerController:openOtherPlayerInfoWin(actor_id,nil,nil,attach)
end

elseif cbtype==DiZiqiecuotype.wanlingbei then
funa=function()
UIFullZaoHuaTianBeiControl:showMainWindowEx()
UIFullZaoHuaTianBeiControl:openWanLingBei()
local attach=nil
if othersever_id~=playerModel:getActorServerID()then
attach={serverid=othersever_id}
end
otherPlayerController:openOtherPlayerInfoWin(actor_id,nil,nil,attach)
end

elseif cbtype==DiZiqiecuotype.hundunbei then
funa=function()
UIFullZaoHuaTianBeiControl:showMainWindowEx()
UIFullZaoHuaTianBeiControl:openHunDunBei()
local attach=nil
if othersever_id~=playerModel:getActorServerID()then
attach={serverid=othersever_id}
end
otherPlayerController:openOtherPlayerInfoWin(actor_id,nil,nil,attach)
end

elseif cbtype==DiZiqiecuotype.wujibei then
funa=function()
UIFullZaoHuaTianBeiControl:showMainWindowEx()
UIFullZaoHuaTianBeiControl:openWuJiBei()
local attach=nil
if othersever_id~=playerModel:getActorServerID()then
attach={serverid=othersever_id}
end
otherPlayerController:openOtherPlayerInfoWin(actor_id,nil,nil,attach)
end

elseif cbtype==DiZiqiecuotype.suoyaota then
funa=function()
jumpManager:jump({id=JUMP_TYPE.eShiLianTa})






end
elseif cbtype==DiZiqiecuotype.lthuifang then
funa=function()
UIManager:showWindow('UIChatWin')
end
end

return funa
end
