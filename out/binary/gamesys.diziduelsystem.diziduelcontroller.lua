






local _MODULENAME="DiZiDuelController"

gameState.addListener(def_table(_MODULENAME))
DiZiDuelController.name=_MODULENAME
DiZiDuelController.data={}

DiZiqiecuotype=
{
liaotian=1,
xianyou=2,
xmdadain=3,
xmddother=4,
xmgfb=5,
wanlingbei=6,
hundunbei=7,
wujibei=8,
suoyaota=9,
lthuifang=10,
}


function DiZiDuelController:onAppStart()

DiZiDuelModel:onAppStart()

socketManager:register_receiver(254,71,self.recv_254_71)
socketManager:register_receiver(254,72,self.recv_254_72)
socketManager:register_receiver(254,73,self.recv_254_73)
socketManager:register_receiver(254,74,self.recv_254_74)
socketManager:register_receiver(254,75,self.recv_254_75)

end


function DiZiDuelController:onEnterState(isReconnect)
DiZiDuelModel:onEnterState()
end


function DiZiDuelController:onProtocolReq()

end


function DiZiDuelController:onLeaveState(isReconnect)
DiZiDuelModel:onLeaveState(isReconnect)

self.data={}
end


function DiZiDuelController:onLostConnection()

end


function DiZiDuelController:onReConnection(isInitPro)

end


function DiZiDuelController.send_254_71()
socketManager:send_254_71()
end


function DiZiDuelController.send_254_72(severid,actorid)
socketManager:send_254_72(severid,actorid)
end
function DiZiDuelController.send_254_73()
socketManager:send_254_73()
end


function DiZiDuelController.send_254_74(allow)
socketManager:send_254_74(allow)
end


function DiZiDuelController.send_254_75()
socketManager:send_254_75()
end


function DiZiDuelController.send_254_76(type,param,channellen,channellist,actorlen,actorlist)
socketManager:send_254_76(type,param,channellen,channellist,actorlen,actorlist)
end



function DiZiDuelController.recv_254_71(args1,args2,args3)
DiZiDuelModel:initData(args1,args2,args3)
end


function DiZiDuelController.recv_254_72(args1,args2,args3)
DiZiDuelModel:fenxiangData(args1,args2,args3)
end


function DiZiDuelController.recv_254_73(args1)
DiZiDuelModel:resultData(args1[1],args1[2],args1[3],args1[4],args1[5],args1[6],args1[7],args1[8])
DiZiDuelModel:onCompleteBattle()
end


function DiZiDuelController.recv_254_74(allow)
DiZiDuelModel:Frightsetting(allow)
end


function DiZiDuelController.recv_254_75(id)
DiZiDuelModel:newbieindex(id)
end


function DiZiDuelController.recv_254_76(args)

end


function DiZiDuelController.prePareFight(actor_id,sentence,monsterFight,teamList,monstersList,robotType,severId)
sentence='我辈修士，何惧一战'
local lookType=4

local list={}
if teamList then
for i,v in pairs(teamList)do
if v.base then
local netData=v.base
netData.equipLookup=v.equipLookup
if v.equipLookup[EQUIP_TYPE.eWeapon]then
netData.discipleweapon=v.equipLookup[EQUIP_TYPE.eWeapon].itemid
end
list[i]={guid=v.base.discipleguid,typo=fightEntityType.diZi,netData=netData,data=v}
end
end

end
local cancelCallBack=function()
UIManager:closeWindow('UIQieCuoFightExtraWin')

local cbtype=DiZiDuelModel:getCallBackType()
if cbtype then
local cbfun=DiZiDuelModel:getCallBackFun(cbtype,actor_id,severId)
if cbfun then
cbfun()
end
DiZiDuelModel:setCallBackType(false)
end
end
if lookType==DOUFATAI_LOOK_TYPE.eBeatBack or lookType==DOUFATAI_LOOK_TYPE.eChallenge then

local winArgs=
{
enterTxt="切磋",
skipDiscipleStateCheck=true,
statePriorityCheck=false,
skipDiscipleInjuryCheck=true,
monsterFight=monsterFight,
cancelCallBack=cancelCallBack,

skipShouYuanCheck=true,
otherArgs={actor_id,sentence,monsterFight,teamList,monstersList,robotType},
}


if robotType==DOUFATAI_ROBOTTYPE.player or robotType==DOUFATAI_ROBOTTYPE.clonePlayer then
winArgs.monsterListEx=list
else
winArgs.monsterList=monstersList
end


if lookType~=DOUFATAI_LOOK_TYPE.eChallenge then
local selfTeamList={}
local doufataiData=douFaTaiModel:get_doufatai_data()
local defenseList=doufataiData.defenseList
for i,v in ipairs(defenseList)do
selfTeamList[i]=v.unitId
end
winArgs.teamList=selfTeamList
end

local enterCallBack=function(guidList,zfId)
UIManager:closeWindow('UIQieCuoFightExtraWin')
if lookType==DOUFATAI_LOOK_TYPE.eBeatBack then
fightLaunchController:sendFight(eBattleLaunch.doufatai,guidList,818001,zfId,{2,robotType,actor_id})
else

local severid=severId
local actorID
if type(actor_id)=="number"then
actorID=int64.new(FMT.fmt("{0}",actor_id))
else
actorID=actor_id
end
fightLaunchController:sendFight(eBattleLaunch.qiecuo,guidList,818001,zfId,{severid,actorID})
end
end
winArgs.enterCallBack=enterCallBack

UIFullDouFaTaiControl:closeUI(false)

fightController.showPrepareWin(fightPreSelectModel.fightType.doufatai,winArgs,function(...)
UIManager:showWindow('UIQieCuoFightExtraWin',{lookType,actor_id,sentence,actor_id})
end)

elseif lookType==DOUFATAI_LOOK_TYPE.eLunDaoTeam then
UIFullLunDaoDaHuiControl:showLookRivalWin(actor_id,teamList)
else

UIFullDouFaTaiControl:showWindow('UIDouFaTaiLookRivalWin',{lookType=lookType,actor_id=actor_id,sentence=sentence,teamList=teamList})
end
end


function DiZiDuelController:req_actor_defense_new(actor_id,robotType,openWin,checkNew,mustNew,severId)
local sendId=nil
if type(actor_id)=="number"then
sendId=int64.new(FMT.fmt("{0}",actor_id))
else
sendId=actor_id
end
local callback
if openWin then
callback=function(teamDzList,args)

local sentence=args and args.sentence or'一起切磋'
local monsterFight=0

for i,v in pairs(teamDzList)do
if v.base then
monsterFight=monsterFight+tonumber(tostring(v.base.fightvalue))
end
end
DiZiDuelController.prePareFight(sendId,sentence,monsterFight,teamDzList,nil,robotType,severId)
end
end
if severId~=playerModel:getActorServerID()then
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eDouFaTaiDef2,sendId,{dftRobotType=robotType,serverid=severId},callback,checkNew,mustNew)
else
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eDouFaTaiDef2,sendId,{dftRobotType=robotType},callback,checkNew,mustNew)
end
end



function DiZiDuelController:testfight()
DiZiDuelController:req_actor_defense_new(81604378626,4,true,true,false,76)
end


function DiZiDuelController:reqDiZiQieCuo(actorid,severid,qctype)

DiZiDuelController:req_actor_defense_new(actorid,4,true,true,false,severid)
end



function DiZiDuelController:checkDouFaTaiTeamlist(actor_id,_severid,actorData)
local sendId=nil
if type(actor_id)=="number"then
sendId=int64.new(FMT.fmt("{0}",actor_id))
else
sendId=actor_id
end
local callback=function(teamDzList,args)
if not teamDzList or not next(teamDzList)then
UIManager.error('对方未设置斗法台切磋阵容，切磋失败！')
else
local otherseverid=actorData.serverid or playerModel:getActorServerID()
DiZiDuelController:reqDiZiQieCuo(actor_id,otherseverid)
end
end
if _severid then
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eDouFaTaiDef1,sendId,{dftRobotType=4,serverid=_severid},callback,false,true)
else
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eDouFaTaiDef1,sendId,{dftRobotType=4},callback,false,true)
end
end

