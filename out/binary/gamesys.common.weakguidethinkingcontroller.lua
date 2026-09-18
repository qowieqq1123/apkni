







local _MODULENAME="weakGuideThinkingController"
gameState.addListener(def_table(_MODULENAME))
weakGuideThinkingController.name=_MODULENAME


local thinkingFuncLookup={

[1]=function(params)
local sfId=params[1]
local id=params[2]
local count=zongmenModel:getBuildingCount(id,sfId)
local max=zongmenModel:getBuildingMaxNum(id,sfId)
if count>=max then
return true
end
return false
end,

[2]=function(params)
local equipType=params[1]
local all=UIDiscipleModel:getAllDiscipleData()
local flag=true
for k,v in pairs(all)do
local netData=v.netData.net
local equip=equipsHelper.getEquipByDizi(netData.discipleguid,equipType)
if equip~=nil then
flag=true
break
end
end
return flag
end,

[3]=function(params)
local jjlv1=params[1]
local jjlv2=params[2]
local all=UIDiscipleModel:getAllDiscipleData()
local flag=false
for k,v in pairs(all)do
local netData=v.netData.net
local jjlv=UIDiscipleModel:getDiscipleJJLevelEx(netData)
if jjlv>=jjlv1 and jjlv<=jjlv2 then
flag=true
break
end
end
return flag
end,

[4]=function(params)
local equipType=params[1]
local num=params[2]
local all=UIDiscipleModel:getAllDiscipleData()
local c=0
for k,v in pairs(all)do
local netData=v.netData.net
local equip=equipsHelper.getEquipByDizi(netData.discipleguid,equipType)
if equip~=nil then
if equipType==EQUIP_TYPE.eFabao then
if fabaoHelper.isCanShowJilian(equip.itemguid)then
c=c+1
end
else
if equipsHelper.isCanShowJinglian(equip.itemguid)then
c=c+1
end
end
end
end
return c>=num
end,

[5]=function(params)
local state=UICatShopControl:getCatShopState()
return state==2
end,

[6]=function(params)
local buildType=params[1]
return zongmenModel:isAnyBuilding(buildType)
end,

[7]=function(params)
local cur=params[1]
local screenType=mainControl:getSceneType()
return screenType==cur
end,


[8]=function(params)
local state=params[1]
if state==1 then
local level=zongmenModel:getLevel()
local next_cfg=cfg_guildexpconfig_get(level+1)
if next_cfg and next_cfg.condition==nil and next_cfg.sysid==nil then
local curExp=tonumber(tostring(zongmenModel:getExp()))
return curExp<next_cfg.exp
end
elseif state==2 then
local level=zongmenModel:getLevel()
local next_cfg=cfg_guildexpconfig_get(level+1)
if next_cfg and next_cfg.condition==nil and next_cfg.sysid==nil then
local curExp=tonumber(tostring(zongmenModel:getExp()))
return curExp>=next_cfg.exp
end
elseif state==3 then
local level=zongmenModel:getLevel()
local next_cfg=cfg_guildexpconfig_get(level+1)
if next_cfg then
if next_cfg.sysid then
if systemModel.isOpen(next_cfg.sysid)then
return true
end
elseif next_cfg.condition then
local curExp=tonumber(tostring(zongmenModel:getExp()))
return curExp<next_cfg.exp
end
end
elseif state==4 then
local level=zongmenModel:getLevel()
local next_cfg=cfg_guildexpconfig_get(level+1)
if next_cfg then
if next_cfg.sysid then
if systemModel.isOpen(next_cfg.sysid)then
return true
end
elseif next_cfg.condition then
local curExp=tonumber(tostring(zongmenModel:getExp()))
return curExp>=next_cfg.exp
end
end
end
return false
end,


[9]=function(params)
local buildType=params[1]
local state=params[2]
local temp=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,buildType)
if temp~=nil and#temp>0 then
for i,data in ipairs(temp)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isLinkRoad=true
if cfg.is_connect_road==1 and not data.isLinkRoad then
isLinkRoad=false
end
if isLinkRoad and data.flag==0 then
local hasDZ=zongmenModel:checkBuildHasManager(cfg,data)
if state==1 then
if not hasDZ then
return true
end
else
if hasDZ then

local cd=buildingCDControl:checkCD(cfg,data)
if state==2 then
if cd==nil then
return true
end
elseif state==3 then
if cd~=nil and cd>0 then
return true
end
elseif state==4 then
if cd~=nil and cd<=0 then
return true
end
end
end
end
end
end
end
return false
end,
[10]=function(params,guideID)
local fightlen=params[1]
local equipType=params[2]
local maxjllv=params[3]
local fightIndex
local discipleList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,nil,nil)
for i=1,fightlen do
local netData=discipleList[i].netData
local dzguid=netData.net.discipleguid
local equip=equipsModel.getEquipByDizi(dzguid,equipType)
if equip then
local jllv=equipsModel.getEquipJinglianLevel(equip)
if maxjllv>jllv then
fightIndex=i
break
end
end
end
if fightIndex==nil then return false end
local replacename=params[4]
if replacename then
local jumpParam=cfgHelper.get3(cfg_weakguideconfig_get,guideID,'uiParams',2)
if jumpParam then
local jumpParamX=table.deepCopy(jumpParam)
if not table.replaceKey(jumpParamX.args,replacename,fightIndex)then
jumpParamX.args[replacename]=fightIndex
end
return true,jumpParamX
end
end
return false
end,

[11]=function(params,guideID)
if not xianmengModel:hasXM()then return false end
local actorid=playerModel:getActorID()
local typo=params[1]
local checkJoin=zhengzhanshanhaiModel:checkJoin()
if typo==1 then
return not checkJoin and
(xianmengModel.checkActorPost(actorid,GUILD_POST_TYPE.gpElder)or
xianmengModel.checkActorPost(actorid,GUILD_POST_TYPE.gpCivilian))
elseif typo==2 then
return checkJoin and
(xianmengModel.checkActorPost(actorid,GUILD_POST_TYPE.gpElder)or
xianmengModel.checkActorPost(actorid,GUILD_POST_TYPE.gpCivilian))
elseif typo==3 then
return xianmengModel.checkActorPost(actorid,GUILD_POST_TYPE.gpAllyLeader)or
xianmengModel.checkActorPost(actorid,GUILD_POST_TYPE.gpViceLeader)
end
return false
end,


[12]=function(params,guideID)
if not mainControl:isInScene(eSceneType.eXianJie)then return false end
local cloudid=params[1]
local islock=xianjieModel:isCloudLockbyid(cloudid)
return islock
end,

[13]=function(params,guideID)
local dfid=params[1]
local isUnLock=UIDanYaoModel:isUnLock(dfid)
return isUnLock
end,
}

function weakGuideThinkingController:onAppStart()
end
function weakGuideThinkingController:onEnterState()
end
function weakGuideThinkingController:onLeaveState()
end
function weakGuideThinkingController:onPlayerCreate(...)
end
function weakGuideThinkingController:onProtocolReq()
end
function weakGuideThinkingController:onLostConnection()
end


function weakGuideThinkingController:doThinkingLine(lineID)
local linecfg=cfgHelper.get1(cfg_weakguidethinkinglineconfig_get,lineID)
if linecfg then
local line=linecfg.line
local f=nil
local jumpParam
for i,v in ipairs(line)do
local typo=v[1]
local params=v[2]
if typo==nil then
f=v
break
else
local func=thinkingFuncLookup[typo]
if func then
local ret,param=func(params,v[3])
if ret then
f=v
jumpParam=param
break
end
else



end
end
end
if f then
local guideID=f[3]




weakGuideController:beginGuide(guideID,nil,nil,jumpParam)
end
else



end
end
