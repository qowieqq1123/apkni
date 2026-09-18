







local sendDataLookup={

[otherPlayerInfoType.ePlayerInfo1]=function(typo,send_args)


return{typo,0},sendMessageServerType.eKuafu
end,

[otherPlayerInfoType.ePlayerInfo2]=function(typo,send_args)


return{typo,0}
end,

[otherPlayerInfoType.eDouFaTaiDef1]=function(typo,send_args)


return{typo,send_args.dftRobotType or DOUFATAI_ROBOTTYPE.player}
end,

[otherPlayerInfoType.eDouFaTaiDef2]=function(typo,send_args)


return{typo,send_args.dftRobotType or DOUFATAI_ROBOTTYPE.player}
end,

[otherPlayerInfoType.eLunDaoDaHuiFight]=function(typo,send_args)


return{typo,0}
end,

[otherPlayerInfoType.eXianFaWenDao1]=function(typo,send_args)


return{typo,0},sendMessageServerType.eKuafu
end,

[otherPlayerInfoType.eXianFaWenDao2]=function(typo,send_args)


return{typo,0},sendMessageServerType.eKuafu
end,

[otherPlayerInfoType.eZongMenDaBiDef1]=function(typo,send_args)





local sendServerType=activitiesModel:getSendMessageSeverType(send_args.actID)
return{typo,send_args.actID,send_args.subType,send_args.subid},sendServerType
end,

[otherPlayerInfoType.eZongMenDaBiDef2]=function(typo,send_args)





local sendServerType=activitiesModel:getSendMessageSeverType(send_args.actID)
return{typo,send_args.actID,send_args.subType,send_args.subid},sendServerType
end,

[otherPlayerInfoType.eDZInfoList]=function(typo,send_args)




return{typo,#send_args.guidList,send_args.guidList}
end,

[otherPlayerInfoType.eJiuCengYaoLouDef2]=function(typo,send_args)

local sendServerType=activitiesModel:getSendMessageSeverType(send_args.actID)
return{typo,send_args.actID,send_args.subType,send_args.subid,send_args.floor,send_args.idx},sendServerType
end,


[otherPlayerInfoType.eShiLianTa2]=function(typo,send_args)

return{typo,send_args.layer,send_args.recordType}
end,

[otherPlayerInfoType.eLingXuWenJianDef1]=function(typo,send_args)



return{typo,send_args.lxwjteamtype},sendMessageServerType.eKuafu
end,

[otherPlayerInfoType.eLingXuWenJianDef2]=function(typo,send_args)



return{typo,send_args.lxwjteamtype},sendMessageServerType.eKuafu
end,

[otherPlayerInfoType.eSDShouTong]=function(typo,send_args)

return{typo,send_args.wxdId,send_args.id}
end,

[otherPlayerInfoType.eZhengZhanShanHaiPvP]=function(typo,send_args)

return{typo,send_args.idx},sendMessageServerType.eKuafu
end,

[otherPlayerInfoType.eWenDingCangQiong]=function(typo,send_args)

return{typo,send_args.group,send_args.stage,send_args.idx},sendMessageServerType.eKuafu
end,

[otherPlayerInfoType.eXianJieInfo]=function(typo,send_args)
return{typo,0},sendMessageServerType.eKuafu
end,

[otherPlayerInfoType.eXianJieSearchLog]=function(typo,send_args)
return{typo,send_args.guid,send_args.stationguid},sendMessageServerType.eKuafu
end,

[otherPlayerInfoType.eXingYu]=function(typo,send_args)

return{typo,send_args.xyId,send_args.teamIndex},sendMessageServerType.eKuafu
end,

[otherPlayerInfoType.eTeamChangeInfo1]=function(typo,send_args)


if send_args.isXianJie then
return{typo,0},sendMessageServerType.eXJKuafu
else
return{typo,0},sendMessageServerType.eKuafu
end
end,

[otherPlayerInfoType.eTeamChangeInfo2]=function(typo,send_args)


return{typo,0}
end,
}

local recDataLookup={

[otherPlayerInfoType.ePlayerInfo1]=function(otherData,send_args)


return otherData
end,

[otherPlayerInfoType.ePlayerInfo2]=function(otherData,send_args)


return otherData
end,

[otherPlayerInfoType.eDouFaTaiDef1]=function(otherData,send_args)


local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local sentence=otherData.sentence
local teams,otherArgs=otherPlayerModel:setActorDefTeams(otherPlayerInfoType.eDouFaTaiDef1,actorid,discipleList,{sentence=sentence})
return teams,otherArgs
end,

[otherPlayerInfoType.eDouFaTaiDef2]=function(otherData,send_args)


local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local sentence=otherData.sentence
local teams,otherArgs=otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eDouFaTaiDef2,actorid,discipleList,{sentence=sentence},true)
return teams,otherArgs
end,

[otherPlayerInfoType.eXianFaWenDao1]=function(otherData,send_args)
local actorid=otherData.actorid
local discipleList=otherData.discipleList
local teams=otherPlayerModel:setActorDefTeams(otherPlayerInfoType.eXianFaWenDao1,actorid,discipleList)
return teams
end,

[otherPlayerInfoType.eXianFaWenDao2]=function(otherData,send_args)
local actorid=otherData.actorid
local discipleList=otherData.discipleList
local teams=otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eXianFaWenDao2,actorid,discipleList)
return teams
end,

[otherPlayerInfoType.eLunDaoDaHuiFight]=function(otherData,send_args)


local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local teams,otherArgs=otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eLunDaoDaHuiFight,actorid,discipleList)
return teams
end,

[otherPlayerInfoType.eZongMenDaBiDef1]=function(otherData,send_args)


local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local teams=otherPlayerModel:setActorDefTeams(otherPlayerInfoType.eZongMenDaBiDef1,actorid,discipleList)
return teams
end,

[otherPlayerInfoType.eZongMenDaBiDef2]=function(otherData,send_args)


local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local teams=otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eZongMenDaBiDef2,actorid,discipleList)
return teams
end,

[otherPlayerInfoType.eDZInfoList]=function(otherData,send_args)


otherData.send_args=send_args
return otherData
end,

[otherPlayerInfoType.eDZInfoList]=function(otherData,send_args)


otherData.send_args=send_args
return otherData
end,

[otherPlayerInfoType.eJiuCengYaoLouDef2]=function(otherData,send_args)

otherData.send_args=send_args
local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local dzDatas={}
if discipleList then
for i,v in ipairs(discipleList)do
if v.flag>0 then
local dzData=otherPlayerModel.detailDisciple_to_discipleStruct3(v)
local dzData_=otherPlayerModel:addDZData(actorid,dzData,false,false)
table.insert(dzDatas,dzData_)
end
end
end
return dzDatas
end,

[otherPlayerInfoType.eShiLianTa2]=function(otherData,send_args)

local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local teams=otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eShiLianTa2,actorid,discipleList)
return teams
end,

[otherPlayerInfoType.eLingXuWenJianDef1]=function(otherData,send_args)




local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local lxwjteamtype=otherData.lxwjteamtype
local teamwinrate=otherData.teamwinrate
local otherArgs={actorid=actorid,lxwjteamtype=lxwjteamtype,teamwinrate=teamwinrate}
local teams=otherPlayerModel:setActorDefTeams(otherPlayerInfoType.eLingXuWenJianDef1,actorid,discipleList)
return teams,otherArgs
end,

[otherPlayerInfoType.eLingXuWenJianDef2]=function(otherData,send_args)



local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local lxwjteamtype=otherData.lxwjteamtype
local otherArgs={actorid=actorid,lxwjteamtype=lxwjteamtype}
local teams=otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eLingXuWenJianDef2,actorid,discipleList)
return teams,otherArgs
end,

[otherPlayerInfoType.eSDShouTong]=function(otherData,send_args)
local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local teams,otherArgs=otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eSDShouTong,actorid,discipleList)
return teams,otherArgs
end,

[otherPlayerInfoType.eZhengZhanShanHaiPvP]=function(otherData,send_args)
local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
local otherArgs={idx=otherData.idx}
local teams=otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eZhengZhanShanHaiPvP,actorid,discipleList)
return teams,otherArgs
end,

[otherPlayerInfoType.eWenDingCangQiong]=function(otherData,send_args)

local actorid=otherData.actorid
local serverid=otherData.serverid
local idList=otherData.idList
local discipleList=otherData.discipleList
local team_id_list_len=otherData.team_id_list_len
local team_data_list_len=otherData.team_data_list_len
local temp={}
if team_id_list_len<=0 or team_data_list_len<=0 then
return
end
for i,v in ipairs(idList)do
if mathHelper.compareInt64(v,Int64_0)then
temp[i]={flag=0}
else
for ii,vv in ipairs(discipleList)do
if mathHelper.compareInt64(v,vv.discipleguid)then
temp[i]=vv
break
end
end
if not temp[i]then
temp[i]={flag=0}
end
end
end
local teams,otherArgs=otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eWenDingCangQiong,actorid,temp)
return teams
end,

[otherPlayerInfoType.eXianJieInfo]=function(otherData,send_args)


local actorid=otherData.actorid
otherData.send_args=send_args
local teams,otherArgs=otherPlayerModel:setActorXianJieInfo(otherPlayerInfoType.eXianJieInfo,actorid,0,otherData)
return teams
end,

[otherPlayerInfoType.eXianJieSearchLog]=function(otherData,send_args)


local actorid=otherData.actorid
otherData.send_args=send_args
local teams,otherArgs=otherPlayerModel:setActorXianJieInfo(otherPlayerInfoType.eXianJieSearchLog,actorid,send_args.stationguid,otherData)
return teams
end,


[otherPlayerInfoType.eXingYu]=function(otherData,send_args)

local actorid=otherData.actorid
local serverid=otherData.serverid
local discipleList=otherData.discipleList
otherData.send_args=send_args
local teams,otherArgs=otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eXingYu,actorid,discipleList,otherData)
return teams,otherArgs
end,


[otherPlayerInfoType.eTeamChangeInfo1]=function(otherData,send_args)


return otherData
end,

[otherPlayerInfoType.eTeamChangeInfo2]=function(otherData,send_args)


return otherData
end,
}

local actorReqLockTime=2
local callbackLookup

function otherPlayerController:onAppStart_common()
socketManager:register_receiver(254,60,otherPlayerController.do_protocol_254_60)
end

function otherPlayerController:onEnterState_common()
callbackLookup={}
end

function otherPlayerController:onLeaveState_common()
callbackLookup=nil
end





function otherPlayerController:reqCommonInfo(actorid,typo,args,callback,new)
local actorid_str=tostring(actorid)
local cb_data
if not new then
if callbackLookup[typo]then
cb_data=callbackLookup[typo][actorid_str]
end
if cb_data then
local curTime=Time.realtimeSinceStartup
if(curTime-cb_data.time)<actorReqLockTime then
return
end
end
end

args=args or{}
local serverid=args.serverid
local send_handle=sendDataLookup[typo]
if send_handle==nil then
return
end
local data,sendServerType=send_handle(typo,args)
sendServerType=sendServerType or sendMessageServerType.eNone
local serverid
if sendServerType==sendMessageServerType.eNone and not args.isXianJie then
if args.serverid~=nil and args.serverid>0 then
local serverid_self=playerModel:getActorServerID()
if serverid_self~=args.serverid then
serverid=args.serverid
end
end
else
serverid=args.serverid
if serverid==nil then
logErr(FMT.fmt('类型{0}必须传serverid',typo))
return
end
end
if args.stilsid then

serverid=args.serverid
end
if serverid==nil then
socketManager:send_254_60(actorid,data)
else
if args.isXianJie then
socketManager:send_254_107(serverid,actorid,data)
elseif args.actType then
socketManager:send_254_108(args.actType,serverid,actorid,data)
elseif args.isZZSHSeason then
socketManager:send_254_123(serverid,actorid,data)
else
socketManager:send_254_61(serverid,actorid,data)
end

end
if callbackLookup[typo]==nil then
callbackLookup[typo]={}
end
callbackLookup[typo][actorid_str]={callback=callback,time=Time.realtimeSinceStartup,serverid=serverid,args=args}
end


function otherPlayerController.do_protocol_254_60(serverid,actorid,otherData)




if otherData==nil then
return
end
local actorid_str=tostring(actorid)
local typo=otherData.teamtype
local cb_data
if callbackLookup[typo]then
cb_data=callbackLookup[typo][actorid_str]
callbackLookup[typo][actorid_str]=nil
end
if cb_data==nil then
return
end


otherData.serverid=serverid




otherData.actorid=actorid
if otherData.discipleList~=nil then
for _,v in ipairs(otherData.discipleList)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(v.dzAttrList)
end
end
local send_args=cb_data.args
local rec_handle=recDataLookup[typo]
local args,other
if rec_handle then
args,other=rec_handle(otherData,send_args)
else
args=otherData
end

if cb_data.callback then
cb_data.callback(args,other)
end
end
