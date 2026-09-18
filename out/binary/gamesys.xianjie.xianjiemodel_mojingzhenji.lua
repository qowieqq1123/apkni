local _destroyedBuilds={}







local _changellBuilds={}











local _rankBuilds={}







local _benYuanZhenJiDatas={}







local _benYuanZhenJiNetDatas={}







local _lastReqBYZJListTime

function xianjieModel:refreshBenYuanZhenJiDatas(season_id,chapter_idx)
if _changellBuilds[season_id]and _changellBuilds[season_id][chapter_idx]then
xianjieModel:onEnterMap_mojingzhenji()
end
end

function xianjieModel:setMoJingZhenJiDestroyed(season_id,chapter_idx,build_id)
if not _destroyedBuilds[season_id]then
_destroyedBuilds[season_id]={}
end
if not _destroyedBuilds[season_id][chapter_idx]then
_destroyedBuilds[season_id][chapter_idx]={}
end
_destroyedBuilds[season_id][chapter_idx][build_id]=true
end

function xianjieModel:checkMoJingZhenJiDestroyed(season_id,chapter_idx,build_id)
if not _destroyedBuilds[season_id]then
return false
end
if not _destroyedBuilds[season_id][chapter_idx]then
return false
end
return _destroyedBuilds[season_id][chapter_idx][build_id]==true
end

function xianjieModel:setMoJingZhenJiRankData(season_id,chapter_idx,build_id,data)
if not _rankBuilds[season_id]then
_rankBuilds[season_id]={}
end
if not _rankBuilds[season_id][chapter_idx]then
_rankBuilds[season_id][chapter_idx]={}
end
_rankBuilds[season_id][chapter_idx][build_id]=data
end

function xianjieModel:getMoJingZhenJiRankData(season_id,chapter_idx,build_id)
if not _rankBuilds[season_id]then
return false
end
if not _rankBuilds[season_id][chapter_idx]then
return false
end
return _rankBuilds[season_id][chapter_idx][build_id]
end

function xianjieModel:setMoJingZhenJiChangellData(season_id,chapter_idx,build_id,data)
if not _changellBuilds[season_id]then
_changellBuilds[season_id]={}
end
if not _changellBuilds[season_id][chapter_idx]then
_changellBuilds[season_id][chapter_idx]={}
end
_changellBuilds[season_id][chapter_idx][build_id]=data
end

function xianjieModel:getMoJingZhenJiChangellData(season_id,chapter_idx,build_id)
if not _changellBuilds[season_id]then
return false
end
if not _changellBuilds[season_id][chapter_idx]then
return false
end
return _changellBuilds[season_id][chapter_idx][build_id]
end

function xianjieModel:createBenYuanZhenJiData(season_id,chapter_idx,build_id)
if not _benYuanZhenJiDatas[season_id]then
_benYuanZhenJiDatas[season_id]={}
end
if not _benYuanZhenJiDatas[season_id][chapter_idx]then
_benYuanZhenJiDatas[season_id][chapter_idx]={}
end
if not _benYuanZhenJiDatas[season_id][chapter_idx][build_id]then
local args={
season_id=season_id,
chapter_idx=chapter_idx,
entityId=build_id,
entityId_str=tostring(build_id),
}
_benYuanZhenJiDatas[season_id][chapter_idx][build_id]=xianjieController:createXJClass(xjDataType.eMoJingZhenJi_Origin,args)
return true
else
if _benYuanZhenJiDatas[season_id][chapter_idx][build_id].refreshEntity then
_benYuanZhenJiDatas[season_id][chapter_idx][build_id]:refreshEntity()
end
end
end

function xianjieModel:getBenYuanZhenJiDataByBuildId(season_id,chapter_idx,build_id)
if not _benYuanZhenJiDatas[season_id]then
return nil
end
if not _benYuanZhenJiDatas[season_id][chapter_idx]then
return nil
end

return _benYuanZhenJiDatas[season_id][chapter_idx][build_id]
end

function xianjieModel:findBenYuanZhenJiDataByBuildId(build_id)
for season_id,temp1 in pairs(_benYuanZhenJiDatas)do
for chapter_idx,temp2 in pairs(temp1)do
if temp2[build_id]then
return temp2[build_id]
end
end
end
end

function xianjieModel:clearBenYuanZhenJiDatas(season_id,chapter_idx)
if not _benYuanZhenJiDatas[season_id]then
return
end
if not _benYuanZhenJiDatas[season_id][chapter_idx]then
return
end

for _,entityObj in pairs(_benYuanZhenJiDatas[season_id][chapter_idx])do
xianjieController:removeXJClass(entityObj)
end
end

function xianjieModel:getBenYuanZhenJiDataList()
return _benYuanZhenJiDatas
end

function xianjieModel:setBenYuanZhenJiNetData(season_id,chapter_idx,build_id,args)
if not _benYuanZhenJiNetDatas[season_id]then
_benYuanZhenJiNetDatas[season_id]={}
end
if not _benYuanZhenJiNetDatas[season_id][chapter_idx]then
_benYuanZhenJiNetDatas[season_id][chapter_idx]={}
end
local datas=_benYuanZhenJiNetDatas[season_id][chapter_idx][build_id]or{}
datas.season_id=season_id
datas.chapter_idx=chapter_idx
datas.entityId=build_id
datas.myRank=args[4]
datas.len=args[5]
datas.rankList=args[6]
_benYuanZhenJiNetDatas[season_id][chapter_idx][build_id]=datas
end


function xianjieModel:setBenYuanZhenJiUseMoJing(season_id,chapter_idx,build_id,useMoJing)
if not _benYuanZhenJiNetDatas[season_id]then
_benYuanZhenJiNetDatas[season_id]={}
end
if not _benYuanZhenJiNetDatas[season_id][chapter_idx]then
_benYuanZhenJiNetDatas[season_id][chapter_idx]={}
end
if _benYuanZhenJiNetDatas[season_id][chapter_idx][build_id]~=nil then
_benYuanZhenJiNetDatas[season_id][chapter_idx][build_id].useMoJing=useMoJing
end
end

function xianjieModel:setBenYuanZhenJiNetList(season_id,chapter_idx,len,byzjList)
_lastReqBYZJListTime=gameUtilityModel.getServerShortTime()
if not _benYuanZhenJiNetDatas[season_id]then
_benYuanZhenJiNetDatas[season_id]={}
end
if not _benYuanZhenJiNetDatas[season_id][chapter_idx]then
_benYuanZhenJiNetDatas[season_id][chapter_idx]={}
end
for i=1,len do
local byzjData=byzjList[i]
local build_id=byzjData.buildingId
local datas=_benYuanZhenJiNetDatas[season_id][chapter_idx][build_id]or{}
local useMoJing=tonumber(tostring(byzjData.useMoJing))
local myMoJingNum=tonumber(tostring(byzjData.myMoJingNum))
datas.season_id=season_id
datas.chapter_idx=chapter_idx
datas.entityId=build_id
datas.ptzjDieNum=byzjData.ptzjDieNum
datas.countdownTime=byzjData.attackTime
datas.hpVal=byzjData.hpVal
datas.myRank=byzjData.myRank
datas.myMoJingNum=myMoJingNum
datas.useMoJing=useMoJing
datas.moqiDelTime=byzjData.moqiDelTime
datas.bufflistlen=byzjData.len
datas.buffList={}
for i=1,byzjData.len do
local v=byzjData.buffList[i]
table.insert(datas.buffList,{buffid=v.param_1,endsec=v.param_2})
end
_benYuanZhenJiNetDatas[season_id][chapter_idx][build_id]=datas
end
end

function xianjieModel:setMoJingZhenJiUpdateNetList(season_id,chapter_idx,ptzjDieNum,len,byzjList)
if not _benYuanZhenJiNetDatas[season_id]then
_benYuanZhenJiNetDatas[season_id]={}
end
if not _benYuanZhenJiNetDatas[season_id][chapter_idx]then
_benYuanZhenJiNetDatas[season_id][chapter_idx]={}
end
for i=1,len do
local byzjData=byzjList[i]
local build_id=byzjData.cb_type
local datas=_benYuanZhenJiNetDatas[season_id][chapter_idx][build_id]or{}
datas.season_id=season_id
datas.chapter_idx=chapter_idx
datas.entityId=byzjData.cb_type
datas.ptzjDieNum=ptzjDieNum
datas.countdownTime=byzjData.attackTime
datas.moqiDelTime=byzjData.moqiDelTime
_benYuanZhenJiNetDatas[season_id][chapter_idx][build_id]=datas
end
end

function xianjieModel:setMoJingZhenJiUpdateNetBuff(season_id,chapter_idx,build_id,bufflistlen,buffList)
if not _benYuanZhenJiNetDatas[season_id]then
_benYuanZhenJiNetDatas[season_id]={}
end
if not _benYuanZhenJiNetDatas[season_id][chapter_idx]then
_benYuanZhenJiNetDatas[season_id][chapter_idx]={}
end
local datas=_benYuanZhenJiNetDatas[season_id][chapter_idx][build_id]or{}

datas.bufflistlen=bufflistlen
datas.buffList={}
for i=1,bufflistlen do
local v=buffList[i]
table.insert(datas.buffList,{buffid=v.param_1,endsec=v.param_2})
end

_benYuanZhenJiNetDatas[season_id][chapter_idx][build_id]=datas
end

function xianjieModel:getLastReqBYZJListTime()
return _lastReqBYZJListTime
end

function xianjieModel:getIsInitBenYuanZhenJiNetData(season_id,chapter_idx)
if not _benYuanZhenJiNetDatas[season_id]then
return false
end
if not _benYuanZhenJiNetDatas[season_id][chapter_idx]then
return false
end
return true
end

function xianjieModel:getBenYuanZhenJiNetData(season_id,chapter_idx,build_id)
if not _benYuanZhenJiNetDatas[season_id]then
return nil
end
if not _benYuanZhenJiNetDatas[season_id][chapter_idx]then
return nil
end

return _benYuanZhenJiNetDatas[season_id][chapter_idx][build_id]
end

function xianjieModel:checkClientBdIsBenYuanZhenJiByGuid(guid)
local guidNum=mathHelper.int64_to_number(guid)
local buildIdList={
[xjClientBuildType.flcbZhenJi1]=true,
[xjClientBuildType.flcbZhenJi2]=true,
[xjClientBuildType.flcbZhenJi3]=true,
[xjClientBuildType.flcbZhenJi4]=true,
}
if buildIdList[guidNum]then
return true
end
return false
end

function xianjieModel:checkClientBdIsBenYuanZhenJiByBuildId(build_id)
local buildIdList={
[xjClientBuildType.flcbZhenJi1]=true,
[xjClientBuildType.flcbZhenJi2]=true,
[xjClientBuildType.flcbZhenJi3]=true,
[xjClientBuildType.flcbZhenJi4]=true,
}
if buildIdList[build_id]then
return true
end
return false
end

function xianjieModel:clearData_mojingzhenji()
for season_id,temp1 in pairs(_benYuanZhenJiDatas)do
for chapter_idx,temp2 in pairs(temp1)do
for build_id,entityObj in pairs(temp2)do
xianjieController:removeXJClass(entityObj)
end
end
end
table.clear(_destroyedBuilds)
table.clear(_changellBuilds)
table.clear(_rankBuilds)
table.clear(_benYuanZhenJiDatas)
table.clear(_benYuanZhenJiNetDatas)
_lastReqBYZJListTime=nil
end

function xianjieModel:initData_mojingzhenji()

end

function xianjieModel:onEnterMap_mojingzhenji()
for season_id,temp1 in pairs(_benYuanZhenJiDatas)do
for chapter_idx,temp2 in pairs(temp1)do
if seasonController:checkSeasonStageBegined(season_id,chapter_idx)then
for build_id,entityObj in pairs(temp2)do
if entityObj and entityObj.createEntity then
entityObj:createEntity(true)
end
end
end
end
end
end

function xianjieModel:onExitMap_mojingzhenji()
for season_id,temp1 in pairs(_benYuanZhenJiDatas)do
for chapter_idx,temp2 in pairs(temp1)do
for build_id,entityObj in pairs(temp2)do
if entityObj and entityObj.removeEntity then
entityObj:removeEntity()
end
end
end
end
end


function xianjieModel:clearData_puTongZhenJi()
local lp=self.allPuTongZhenJiDatas
if lp then
for infoguid_str,puTongZhenJiData in pairs(lp)do
xianjieController:removeXJClass(puTongZhenJiData)
end
self.allPuTongZhenJiDatas=nil
end
end

function xianjieModel:initAllPuTongZhenJiDatas()
xianjieModel:clearData_puTongZhenJi()
self.allPuTongZhenJiDatas={}
end

function xianjieModel:refreshPuTongZhenJiData(v,isInit)











local infoguid_str=tostring(v.infoguid)
local infoid_str=tostring(v.infoid)
if isInit then
if infoid_str~='0'then
v.infoguid_str=infoguid_str
local puTongZhenJiData=xianjieController:createXJClass(xjDataType.eMoJingZhenJi_Normal,v)
self.allPuTongZhenJiDatas[infoguid_str]=puTongZhenJiData
xianjieModel:setGuid2EntityType(v.infoguid,v.entitytype,v.sceneidx)
else



end
else
if infoid_str~='0'then
local puTongZhenJiData_=self.allPuTongZhenJiDatas[infoguid_str]
if puTongZhenJiData_==nil then
v.infoguid_str=infoguid_str
local puTongZhenJiData=xianjieController:createXJClass(xjDataType.eMoJingZhenJi_Normal,v)
self.allPuTongZhenJiDatas[infoguid_str]=puTongZhenJiData
xianjieModel:setGuid2EntityType(v.infoguid,v.entitytype,v.sceneidx)
puTongZhenJiData:createEntity(true)
notifySystem:postNotify(notifyConfig.onXianJieWuXingZhenJiChange,CHANGE_TYPE.eAdd,puTongZhenJiData.infoguid)
else
puTongZhenJiData_:refreshData(v)
puTongZhenJiData_:refreshEntity()
notifySystem:postNotify(notifyConfig.onXianJieWuXingZhenJiChange,CHANGE_TYPE.eChanged,puTongZhenJiData_.infoguid)
end
else
local puTongZhenJiData=self.allPuTongZhenJiDatas[infoguid_str]
if puTongZhenJiData~=nil then
local infoguid=puTongZhenJiData.infoguid
local sceneidx=puTongZhenJiData.sceneidx
puTongZhenJiData:removeEntity(true)
xianjieController:removeXJClass(puTongZhenJiData)
self.allPuTongZhenJiDatas[infoguid_str]=nil
xianjieModel:setGuid2EntityType(v.infoguid,nil,sceneidx)

notifySystem:postNotify(notifyConfig.onXianJieWuXingZhenJiChange,CHANGE_TYPE.eDelete,infoguid)

UIManager:invokeUIMethod("UIXianJie_puTongZhenJiInfoWin","refreshWuXingZhenJi",nil,infoguid_str)
else



end
end
end
end

function xianjieModel:getAllPuTongZhenJiData()
return self.allPuTongZhenJiDatas
end

function xianjieModel:getPuTongZhenJiData(infoguid)
if self.allPuTongZhenJiDatas then
local infoguid_str=tostring(infoguid)
return self.allPuTongZhenJiDatas[infoguid_str]
end
end

function xianjieModel:getPuTongZhenJiDataEx(infoguid_str)
if self.allPuTongZhenJiDatas then
return self.allPuTongZhenJiDatas[infoguid_str]
end
end

function xianjieModel:createAllPuTongZhenJiEnities(needRefreshAOI)
local lp=self.allPuTongZhenJiDatas
if lp then
for infoguid_str,puTongZhenJiData in pairs(lp)do
puTongZhenJiData:createEntity(needRefreshAOI)
end
end
end

function xianjieModel:removeAllPuTongZhenJiEnities()
local lp=self.allPuTongZhenJiDatas
if lp then
for infoguid_str,puTongZhenJiData in pairs(lp)do
if puTongZhenJiData and puTongZhenJiData.removeEntity then
puTongZhenJiData:removeEntity()
end
end
end
end
