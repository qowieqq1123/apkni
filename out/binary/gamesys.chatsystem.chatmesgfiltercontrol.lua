chatMesgFilterControl=gameState.addListener({})

local _filterStr='filterMsgType'
local _array=nil

local _filterMsgHandle=
{
[CHAT_MSG_TYPE.eFairyLandAttack]=function(mesg)





local ret=false
for server_id,_ in string.gmatch(mesg,'#serverid=(%d*)')do
server_id=tonumber(server_id)
local servername,get=loginModel:getServerName(server_id)
if get==false then
ret=true
break
else
mesg=string.gsub(mesg,FMT.fmt('#serverid={0}',server_id),servername)
end
end

local params
if ret then
params={}
params.refreshType=CHAT_MESG_REFRESH_TYPE.eRefreshServerName
params.funcType=CHAT_MESG_NOTIFY_TYPE.eFilterMesg
params.refreshArgs={CHAT_MSG_TYPE.eFairyLandAttack,mesg}
end

return mesg,params
end,
[CHAT_MSG_TYPE.eLeiTaiYanWu]=function(mesg)
local finalStr=mesg

finalStr=string.gsub(mesg,"#ltywScene=(%d*)",function(sceneIdxStr)
local sceneIdx=tonumber(sceneIdxStr)

local xyName=xianjieController:getCrossServerNamebySCidx(sceneIdx)
return xyName
end)


finalStr=string.gsub(finalStr,"#ltywLeiTaiId=(%-?%d*)",function(arenaIdStr)
local arenaId=tonumber(arenaIdStr)
local arenaCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local arenaName=arenaCfg and arenaCfg.name or"未知擂台"
return arenaName
end)

return finalStr
end,
[CHAT_MSG_TYPE.eFirstAscension]=function(mesg)
local finalStr=mesg

finalStr=string.gsub(mesg,"#serverid=(%d*)",function(serverIdStr)
local serverId=tonumber(serverIdStr)
local servername,get=loginModel:getServerName(serverId)
return servername
end)

return finalStr
end,
[CHAT_MSG_TYPE.eMoGongZhengDuo]=function(mesg)
local finalStr=mesg

finalStr=string.gsub(mesg,"#mgzdServerId=(%d*)",function(sceneIdxStr)
local servername,get=loginModel:getServerName(sceneIdxStr)
return servername
end)

return finalStr
end,
[CHAT_MSG_TYPE.eGuanKouYaoSai]=function(mesg)
local finalStr=mesg

finalStr=string.gsub(mesg,"#xianyuSceneIdx=(%d*)",function(sceneIdxStr)
local sceneIdx=tonumber(sceneIdxStr)

local xyName=xianjieController:getCrossServerNamebySCidx(sceneIdx)
return xyName
end)


finalStr=string.gsub(finalStr,"#gateId=(%d*)",function(gateIdStr)
local gateId=tonumber(gateIdStr)
local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,gateId)


local nameStr
if gateCfg then
local gateName=gateCfg.name
local gateXYSceneIndex=gateCfg.area
local xyName=xianjieController:getCrossServerNamebySCidx(gateXYSceneIndex)
nameStr=FMT.fmt("{0}-{1}",xyName,gateName)
else
nameStr="未知关口"
end
return nameStr
end)

return finalStr
end,
[CHAT_MSG_TYPE.eMoJieZhengFeng]=function(mesg)
local finalStr=mesg
local zoneId=tonumber(mesg)
local xyName=loginModel:getZoneName(zoneId)

local clientMsg=cfgHelper.get1(cfg_lang_get,'season_mojiezhengfeng_first')

finalStr=string.gsub(clientMsg,"【XYMC】",xyName or"")
return finalStr
end,
}


function chatMesgFilterControl:onAppStart()

end

function chatMesgFilterControl:onEnterState()
chatMesgFilterControl.load()
end

function chatMesgFilterControl:onLeaveState()
_array=nil
end





local _filterfunc=
{
[CHAT_MSG_TYPE.eZhengZhanShanHai]=function(msg)
return zhengzhanshanhaiModel:checkJoin()
end
}





function chatMesgFilterControl.load()
_array=userActorSetting.get(_filterStr,{})
end

function chatMesgFilterControl.flush()
userActorSetting.flushVal(_filterStr,_array)
end

function chatMesgFilterControl.setAllValues(array)
_array=array
userActorSetting.flushVal(_filterStr,array)
end

function chatMesgFilterControl.setValueByType(typo,val)
if _array==nil then _array={}end
if typo>1 then
for i=1,typo-1 do
if _array[i]==nil then
_array[i]=true
end
end
end
_array[typo]=val or false
end

function chatMesgFilterControl.getValueByType(typo)
if _array==nil then return true end
local ret=_array[typo]
if ret==nil then return true end
return ret or false
end

function chatMesgFilterControl.getCfg(typo)
return cfg_msgtypeconfig_get(typo)
end

function chatMesgFilterControl.getHourPosByMsgType(key)
local cfg=cfg_msgtypeconfig_get(key)
if cfg and cfg.hource then
if cfg.hource==1 then
return math.pow(2,CHAT_SYSYTEM_POS.eTopHourse)
else
return math.pow(2,CHAT_SYSYTEM_POS.eMidHourse)
end
end
return 0
end

function chatMesgFilterControl.check(typo,mesg)
if typo==nil then
loggerUtil.logErrFMT('没有传递消息筛选类型')
return
end

local ret=chatMesgFilterControl.getValueByType(typo)
if ret==false then




return false
end

local func=_filterfunc[typo]
if func then
if not func(mesg)then




return false
end
end
return true
end


function chatMesgFilterControl.handleMesg(filterType,mesg)
if _filterMsgHandle[filterType]then
return _filterMsgHandle[filterType](mesg)
end
return mesg
end
