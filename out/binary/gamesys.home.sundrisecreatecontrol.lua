
sundriseCreateControl=gameState.addListener({})

function sundriseCreateControl:onEnterState(isReconnect)
if isReconnect then
return
end

self:init()

notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function sundriseCreateControl:onLeaveState(isReconnect)
if isReconnect then
return
end
self.specialRandom=nil
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
end

function sundriseCreateControl:onEnterHome()

end

function sundriseCreateControl:onLeaveHome()
for k,v in pairs(self.handle_data)do
v.entityId=nil
end
self:resetPosListRecord()
end

function sundriseCreateControl.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eZMMonster then
local isRewardBox
for i=1,effectData.itemLen do
zongmenModel:removeSundriseData(effectData.sf_id,effectData.rand_item_guids[i])
sundriseCreateControl:removeData(effectData.rand_item_guids[i])
local data=isometricMapSystem:getSundriesDataByServerGuid(effectData.rand_item_guids[i])
if data then
if data.type==sundriseType.eRewardBox then
isRewardBox=true
end
local rewards={}
if effectData.itemLen==1 then
for i,v in ipairs(prizelist)do
rewards[i]={v.itemid,v.num,v.itemguid}
end
else
local rewards_conf=cfgHelper.get2(cfg_monijyrandomitemconfig_get,data.id,'rewards_conf')
local items=cfgHelper.get2(cfg_awardconfig_get,rewards_conf.rewardid,'showItems')
if not items then
items=cfgHelper.get2(cfg_awardconfig_get,rewards_conf.rewardid,'staticItems')
end
for i,v in ipairs(items)do
rewards[i]={v[1],v[2]}
end
end
if data.type==sundriseType.eStillSundrise or data.type==sundriseType.eRewardBox then
isometricMapSystem:showStillSundriesRewardHud(data.mapId,0,0,rewards,nil,data.serverGuid)
end
isometricMapSystem:receiveSundries(data.mapId,data.serverGuid)
end
end
if isRewardBox then
msgWinControl:addMsgWin(msgWinType.eCommonShowPrize,{list=prizelist})
end
end
end

function sundriseCreateControl:init()
self.save_data=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSundrise,'SUNDRISE_CREATE_DATA',{})
local map_data={}
for k,v in pairs(self.save_data)do
local mapId=v.mapId
local md=map_data[mapId]or{}
local areaId=v.areaId
local ad=md[areaId]or{count=0}
ad[areaId]=v
ad.count=ad.count+1
md[areaId]=ad
map_data[mapId]=md
end
self.map_data=map_data

local handle_data={}
for k,v in pairs(self.save_data)do
handle_data[k]={data=v}
end
self.handle_data=handle_data

self:resetPosListRecord()
end

function sundriseCreateControl:saveData()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSundrise,'SUNDRISE_CREATE_DATA',self.save_data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSundrise)
end

function sundriseCreateControl:clearSaveData()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSundrise,'SUNDRISE_CREATE_DATA',{})
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSundrise)
end

function sundriseCreateControl:getSundriesSaveData(guid)
return self.save_data[tostring(guid)]
end


function sundriseCreateControl:setSundriesSaveData(guid,data)
self.save_data[tostring(guid)]=data
end

function sundriseCreateControl:getSundriesHandleData(guid)
return self.handle_data[tostring(guid)]
end


function sundriseCreateControl:getSundriesPosType(guid)
local data=sundriseCreateControl:getSundriesHandleData(guid)
if data then
local serverData=data.serverData
if serverData then
return sundriseCreateControl:getSundriesHandlePosType(serverData,data)
end
end
end

function sundriseCreateControl:getSundriesHandlePosType(serverData,hData)
if serverData.x==0 and serverData.y==0 then
return sundrisePosType.eServer
end
local spe=self:getSpecialRandom(serverData.rand_item_guid)
if spe==nil then
local areaId,rpos=self:getConfigCreatePos(hData.data.mapId,serverData.rand_item_id)
if areaId then
return sundrisePosType.eConfig
else
return sundrisePosType.eRandom
end
else
return sundrisePosType.eSpe
end
end

function sundriseCreateControl:setSundriesHandleData(guid,data)
self.handle_data[tostring(guid)]=data
end

function sundriseCreateControl:setSundriesSavePos(guid,areaId,newPos)
local data=sundriseCreateControl:getSundriesSaveData(guid)
if data then
data.pos=newPos
data.areaId=areaId
end
end

function sundriseCreateControl:setSundriesHandleDataPos(guid,areaId,newPos)
local data=sundriseCreateControl:getSundriesHandleData(guid)
if data then
data.data.pos=newPos
data.data.areaId=areaId
end
end

function sundriseCreateControl:refreshSundriesPos(guid)
local handle=sundriseCreateControl:getSundriesHandleData(guid)
if handle then
local pos=handle.data.pos
if handle.entityId then
_MapManager.SetPosition(handle.entityId,_MapManager.ToVector3Int(pos[1],pos[2],0))
local sundries=isometricMapSystem:getSundries(handle.entityId)
if sundries then
sundries.x=pos[1]
sundries.y=pos[2]
local rect=_MapManager.GetObjectRectInMap(handle.entityId)
if rect then
sundries.rx=rect[1]+rect[3]-1
sundries.ry=rect[2]+rect[4]-1
end
if sundries.hudId then
hudControl:refreshHUDPosition(sundries.hudId)
end
end
end
end
end

function sundriseCreateControl:refreshSundriesListPos(entList)
for i,guid in ipairs(entList)do
self:refreshSundriesPos(guid)
end
end

function sundriseCreateControl:removeData(guid)
self:setSundriesSaveData(guid)
self:setSundriesHandleData(guid)
end

function sundriseCreateControl:getAreaSundriseCount(mapId,areaId)
local md=self.map_data[mapId]
if md then
local ad=md[areaId]
if ad then
return ad.count
end
end
return 0
end

function sundriseCreateControl:isAreaNotFull(mapId,areaId)
if not zongmenModel:isAreaUnlock(areaId)then
return false
end
local limit=cfgHelper.get2(cfg_monijysfconfig_get,mapId,'rand_item_area_limit')
local lcount=limit[areaId]or-1
if lcount<0 then
return true
end
local ncount=self:getAreaSundriseCount(mapId,areaId)
return ncount<lcount
end

function sundriseCreateControl:resetPosListRecord()
self.areaPosListRecord={}
self.areaPosListRecordSP={}
end

function sundriseCreateControl:getAPosition(posList,mapId,areaId,removeUsed,cfg)
local mdata=posList[mapId]
if not mdata then
mdata={}
posList[mapId]=mdata
end
local areaData=mdata[areaId]
if not areaData then
areaData={}
mdata[areaId]=areaData
end
local plist=areaData[cfg]
if not plist then
local list=_MapManager.GetMapAreaPosByConfig(mapId,areaId,cfg)
plist={}
for i=1,list.Count do
plist[i]=list[i-1]
end
areaData[areaId]=plist
end
local len=#plist
if len<=0 then
return nil
end
local rv=math.random(1,len)
local pos=plist[rv]
if removeUsed then
table.remove(plist,rv)
end
return pos
end

function sundriseCreateControl:getPlaceConfig(id)
local rtype=cfgHelper.get2(cfg_monijyrandomitemconfig_get,id,'type')
if rtype==2 or rtype==4 then
return 11
end
return 10
end

function sundriseCreateControl:getRandomAreaList(mapId)
local mapCfg=cfgHelper.get1(cfg_monijysfconfig_get,mapId)
local list={}
for i,v in ipairs(mapCfg.area_list)do
list[i]=v
end
local len=#list
for i=1,len do
local p=math.random(1,len)
local v=list[p]
list[p]=list[i]
list[i]=v
end
return list
end

function sundriseCreateControl:getAPosCanPlace(mapId,id)
local pcfg=id and self:getPlaceConfig(id)or 10
local areaId,rpos
local areaList=self:getRandomAreaList(mapId)
for i,v in ipairs(areaList)do
local pos=self:getAPosition(self.areaPosListRecord,mapId,v,true,pcfg)
if pos then
areaId=v
rpos=pos
break
end
end
if not areaId then
for i,v in ipairs(areaList)do
local pos=self:getAPosition(self.areaPosListRecordSP,mapId,v,false,12)
if pos then
areaId=v
rpos=pos
break
end
end
end
if not areaId then
local fixedData=cfgHelper.get2(cfg_monijysfconfig_get,mapId,'fixed_create_pos')
if fixedData then
areaId=fixedData[1]
rpos=_MapManager.ToVector3Int(fixedData[2][1],fixedData[2][2],0)
else
logErr('随机物极端情况刷新点未配置')
end
end
return areaId,rpos
end

function sundriseCreateControl:getConfigCreatePos(mapId,id)
local cpos=cfgHelper.get2(cfg_monijyrandomitemconfig_get,id,'createPos')
if cpos then
local pos=_MapManager.ToVector3Int(cpos[1],cpos[2],0)
local areaId=_MapManager.GetAreaID(mapId,pos)
return areaId,pos
end
end

function sundriseCreateControl:createASundries(mapId,rdata)
local hdata=self:getSundriesHandleData(rdata.rand_item_guid)

if hdata and hdata.entityId then
return
end
local edata=isometricMapSystem:findNoServerData(mapId,rdata.x,rdata.y,rdata.rand_item_id)

if not hdata then
local sdata={}
if edata then
sdata.mapId=edata.mapId
sdata.areaId=edata.areaId
sdata.pos={edata.x,edata.y}
else
if rdata.x~=0 or rdata.y~=0 then
local pos=_MapManager.ToVector3Int(rdata.x,rdata.y,0)
local areaId=_MapManager.GetAreaID(mapId,pos)
sdata.mapId=mapId
sdata.areaId=areaId
sdata.pos={rdata.x,rdata.y}
else
local spe=self:getSpecialRandom(rdata.rand_item_guid)
local areaId,rpos
if spe==nil then

areaId,rpos=self:getConfigCreatePos(mapId,rdata.rand_item_id)
if not areaId then
areaId,rpos=self:getAPosCanPlace(mapId,rdata.rand_item_id)
end
else
areaId,rpos=spe(mapId,rdata.rand_item_id,rdata.rand_item_guid)
self:clearSpecialRandom(rdata.rand_item_guid)
end
sdata.mapId=mapId
sdata.areaId=areaId
local posList=_MapManager.Vector3IntToArray(rpos)
sdata.pos={posList[1],posList[2]}

end
end
self:setSundriesSaveData(rdata.rand_item_guid,sdata)
hdata={data=sdata}
self:setSundriesHandleData(rdata.rand_item_guid,hdata)
else
local pos=hdata.data.pos

if pos then

if sundriseCreateControl:getSundriesHandlePosType(rdata,hdata)==sundrisePosType.eRandom then
local bdDatas=zongmenModel:getAllBuildingData(mapId)
for k,v in pairs(bdDatas)do
local x,y,orientation=v.x,v.y,v.orientation
local cfg=cfgHelper.get(cfg_monijybuildconfig_get,v.build_id)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local cx=bx
local cy=by
local flip=orientation==1
if flip then
cx=by
cy=bx
end
local ex=x+cx-1
local ey=y+cy-1
if isometricMapSystem:checkOverlap(x,y,ex,ey,pos[1],pos[2],pos[1],pos[2])then
local areaId,rpos=self:getAPosCanPlace(mapId,rdata.rand_item_id)
local posList=_MapManager.Vector3IntToArray(rpos)
hdata.data.pos={posList[1],posList[2]}
hdata.data.areaId=areaId

break
end
end
end
end
end

if not edata then
local sdata=hdata.data
local pos=_MapManager.ToVector3Int(sdata.pos[1],sdata.pos[2],0)
local cdata={
id=rdata.rand_item_id,
flip=rdata.flip==1,
pos=pos,
complete=rdata.battle==1,
areaId=sdata.areaId,
unlock=true,
level=rdata.level,
mapId=mapId,
end_times=rdata.end_times,
serverGuid=rdata.rand_item_guid,
auto_clear=rdata.auto_clear,
}
edata=isometricMapSystem:createSundries(cdata)
else
edata.serverGuid=rdata.rand_item_guid
isometricMapSystem:setSundriesDataByServerGuid(rdata.rand_item_guid,edata)
if not edata.unlock then
isometricMapSystem:unlockSundries(edata,rdata)
end
end

hdata.serverData=rdata

if edata then
hdata.entityId=edata.guid
else
logErr('创建随机物失败！',rdata.rand_item_id)
end
end

function sundriseCreateControl:isCanCreate(data)
if data.buildid>0 then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.buildid)
if cfg.build_type==3002 then
return false
end
end
return true
end


function sundriseCreateControl:createSundriesByDatas(mapId,datas,clear)
if not isometricMapSystem.isAreaInit then
return
end
for k,v in pairs(datas)do
if self:isCanCreate(v)then
self:createASundries(mapId,v)
end
end

self:resetPosListRecord()

if clear then
self:clearVoidData(mapId)
end

self:saveData()
end

function sundriseCreateControl:findDataAndCreate(mapId,x,y,id)
local data=zongmenModel:getSundriseDataByPos(mapId,x,y,id)
if data then
self:createASundries(mapId,data)
end
end

function sundriseCreateControl:clearVoidData(mapId)
for k,v in pairs(self.save_data)do
if v.mapId==mapId then
local hdata=self:getSundriesHandleData(k)
if not hdata or not hdata.serverData then

self.save_data[k]=nil
end
end
end
end

function sundriseCreateControl:markSpecialRandom(guids,func)
if self.specialRandom==nil then
self.specialRandom={}
end
for i,v in ipairs(guids)do
local key=tostring(v)
self.specialRandom[key]=func
end
end

function sundriseCreateControl:getSpecialRandom(guid)
if self.specialRandom==nil then
return nil
end
local key=tostring(guid)
return self.specialRandom[key]
end

function sundriseCreateControl:clearSpecialRandom(guid)
if self.specialRandom~=nil then
local key=tostring(guid)
self.specialRandom[key]=nil
end
end
