






local _MODULENAME="YingXianGeModel"


def_table(_MODULENAME)
YingXianGeModel.name=_MODULENAME
YingXianGeModel.data={}

function YingXianGeModel:onAppStart()

end


function YingXianGeModel:onEnterState(isReconnect)

end


function YingXianGeModel:onProtocolReq()

end


function YingXianGeModel:onLeaveState(isReconnect)

self.data={}
end


function YingXianGeModel:refreshZhiYuanData(actorid,data)
if not self.data.yzmyData then
self.data.yzmyData={}
self.data.yzmyLookup={}
end
local actorid1_str=tostring(actorid)
local actorid2_str=tostring(data.actor_id)
local guid_str=tostring(data.guid)
if not self.data.yzmyData[actorid1_str]then
self.data.yzmyData[actorid1_str]={}
end
self.data.yzmyData[actorid1_str][actorid2_str]=data
self.data.yzmyLookup[guid_str]=data
end

function YingXianGeModel:delZhiYuanData(params,sceneidx)
local actorid=params[1]
local ret=params[2]
local yzmyData,yzmyLookup=YingXianGeModel:getYZMyData(sceneidx)
local selfActorId=playerModel:getActorID()
local actorid1_str=tostring(actorid)
local actorid2_str=tostring(selfActorId)
if ret==0 then
if yzmyData~=nil and yzmyData[actorid1_str]and yzmyData[actorid1_str][actorid2_str]then
local guid_str=tostring(yzmyData[actorid1_str][actorid2_str].guid)
yzmyLookup[guid_str]=nil
yzmyData[actorid1_str][actorid2_str]=nil
end

UIManager:invokeUIMethod("UIYingXianGeMYYJWin","refresh")
else
if yzmyData~=nil and yzmyData[actorid2_str]and yzmyData[actorid2_str][actorid1_str]then
local guid_str=tostring(yzmyData[actorid2_str][actorid1_str].guid)
yzmyLookup[guid_str]=nil
yzmyData[actorid2_str][actorid1_str]=nil
end

UIManager:invokeUIMethod("UIYingXianGeWDYJWin","refresh")
end

end


function YingXianGeModel:setYZMYData(actorid,assistlistlen,assistlist,sceneType)
local yzmyData={}
local lookup={}

if sceneType==xjYuanZhuGroupType.eXianJie then
self.data.yzmyData=yzmyData
self.data.yzmyLookup=lookup
elseif sceneType==xjYuanZhuGroupType.eMoJie then
self.data.yzmyData_mj=yzmyData
self.data.yzmyLookup_mj=lookup
elseif sceneType==xjYuanZhuGroupType.eMoGong then
self.data.yzmyData_mg=yzmyData
self.data.yzmyLookup_mg=lookup
end

local actorid1_str=tostring(actorid)
yzmyData[actorid1_str]={}
if assistlistlen>0 then
for i,v in ipairs(assistlist)do
local actorid2_str=tostring(v.actor_id)
local guid_str=tostring(v.guid)
yzmyData[actorid1_str][actorid2_str]=v
lookup[guid_str]=v
end







end
end

function YingXianGeModel:getYZMyData(sceneidx)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local isMoJie=xianjienSceneIndexType:isMoJie(sceneidx)
local isMoGong=xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)

if isMoJie then
if not self.data.yzmyData_mj then
self.data.yzmyData_mj={}
end

if not self.data.yzmyLookup_mj then
self.data.yzmyLookup_mj={}
end

return self.data.yzmyData_mj,self.data.yzmyLookup_mj
elseif isMoGong then
if not self.data.yzmyData_mg then
self.data.yzmyData_mg={}
end

if not self.data.yzmyLookup_mg then
self.data.yzmyLookup_mg={}
end

return self.data.yzmyData_mg,self.data.yzmyLookup_mg
else
if not self.data.yzmyData then
self.data.yzmyData={}
end

if not self.data.yzmyLookup then
self.data.yzmyLookup={}
end

return self.data.yzmyData,self.data.yzmyLookup
end
end

function YingXianGeModel:getCurSceneYZMyData()
local sceneidx=xianjieModel:getSceneIndex()
return self:getYZMyData(sceneidx)
end

function YingXianGeModel:getWithMyYZTotal()
return YingXianGeModel:getMyYZTotal()+YingXianGeModel:getYZMyTotal()
end

function YingXianGeModel:getMyYZTotal()
local total=0
local selfActorID=playerModel:getActorID()
local selfActorIDStr=tostring(selfActorID)
for index,sceneidx in pairs(xjYuanZhuGroupType)do
local list=YingXianGeModel:getYZMyData(sceneidx)
for tActorStr,tlist in pairs(list)do
for sActorStr,data in pairs(tlist)do
if sActorStr==selfActorIDStr then
total=total+1
end
end
end
end
return total
end

function YingXianGeModel:getYZMyTotal()
local total=0
local selfActorID=playerModel:getActorID()
local selfActorIDStr=tostring(selfActorID)
for index,sceneidx in pairs(xjYuanZhuGroupType)do
local list=YingXianGeModel:getYZMyData(sceneidx)







local tlist=list[selfActorIDStr]
if tlist then
total=total+table.nums(tlist)
end
end
return total
end


function YingXianGeModel:setXJChuZhenInfo(boatid,lp)
if not self.data.boatData then
self.data.boatData={}
self.data.boatDataLookup={}
end
local teamData=lp:getMarchTeamData()
if teamData and teamData.marchtype and teamData.marchtype==xjServerMarchType.eYuanZhu then
local actorid_str=tostring(teamData.taractorid)
self.data.boatData[boatid]=actorid_str
self.data.boatDataLookup[actorid_str]=true
end
end


function YingXianGeModel:removeXJChuZhenInfo(boatid)
if not self.data.boatData then
return
end
if self.data.boatData[boatid]then
local actorid_str=self.data.boatData[boatid]
self.data.boatDataLookup[actorid_str]=nil
self.data.boatData[boatid]=nil
end
end


function YingXianGeModel:getHasYZXJ(actorid)
if not self.data.boatData then
return false
end
local actorid_str=tostring(actorid)
return self.data.boatDataLookup[actorid_str]==true
end


function YingXianGeModel:getYZMYList(actorid,sceneidx)
local yzmyData=self:getYZMyData(sceneidx)
local actorid1_str=tostring(actorid)
if not yzmyData or not yzmyData[actorid1_str]then
return{}
end
local list1={}
local list2={}
local selfActorId=playerModel:getActorID()
local actorid2_str=tostring(selfActorId)
for i,v in pairs(yzmyData[actorid1_str])do
if v then
local actorid_str=tostring(v.actor_id)
if actorid_str==actorid2_str then
table.insert(list1,v)
else
table.insert(list2,v)
end
end
end
return table.concatTable(list1,list2)
end

function YingXianGeModel:getYZMYItem(actorid,zy_actorid,sceneidx)
local yzmyData=self:getYZMyData(sceneidx)
local actorid1_str=tostring(actorid)
if not yzmyData or not yzmyData[actorid1_str]then
return nil
end
local actorid2_str=tostring(zy_actorid)
return yzmyData[actorid1_str][actorid2_str]
end

function YingXianGeModel:getYZMYItemByGuid(guid,sceneidx)
local yzmyData,yzmyLookup=self:getYZMyData(sceneidx)
if not yzmyLookup then
return nil
end
local guid_str=tostring(guid)
return yzmyLookup[guid_str]
end

function YingXianGeModel:getYZMYTotleXB(actorid,sceneidx)
local yzmyData=self:getYZMyData(sceneidx)
local actorid1_str=tostring(actorid)
local max=YingXianGeModel:getAssistData(actorid)
if not yzmyData or not yzmyData[actorid1_str]then
return 0,max
end

local cur=0
for i,v in pairs(yzmyData[actorid1_str])do
if v then
cur=cur+1
end
end

return cur,max
end

function YingXianGeModel:getIncreaseAddition()
local bdData=YingXianGeController:getBuildingData()
local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')


if bdData then
local level=bdData.level
local cfg=cfgHelper.get1(cfg_yingxiangeconfig_get,level)
local cooperationNum=baseCfg[6][2]+cfg.ex_cooperation_num
local finalCooperationNum=self:getSingleMaxCooperationCountEx(cooperationNum)

local ylzHuZhuType=7
local ylzHuZhuNum=cfg.cooperation_conf[ylzHuZhuType]or 0
local finalYLZCooperationNum=self:getMaxCooperationTypeNumEx(ylzHuZhuType,ylzHuZhuNum)

return cfg.ex_reduce_time+baseCfg[6][1],finalCooperationNum,cfg.yxg_assist_num,finalYLZCooperationNum
end
return 0,0,0,0
end


function YingXianGeModel:getAssistData(actorId)
local level=0
local isSelfPlayer=playerModel:checkActorId(actorId)
if isSelfPlayer or actorId==nil then
level=YingXianGeController:getBuildingLevel()
else
local actorData=xianmengModel:getXMMemberData(actorId)
level=actorData and actorData.yxg_lv or 0
end
if level==0 then
return 0
end
local cfg=cfgHelper.get1(cfg_yingxiangeconfig_get,level)

return cfg.yxg_assist_num
end


function YingXianGeModel:getReduceTimesData(actorId)
local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')

local level=0
local cooperationNum
local isSelfPlayer=playerModel:checkActorId(actorId)
if isSelfPlayer or actorId==nil then
level=YingXianGeController:getBuildingLevel()
else
local actorData=xianmengModel:getXMMemberData(actorId)
level=actorData and actorData.yxg_lv or 0
end
if level==0 then
cooperationNum=self:getSingleMaxCooperationCountEx(baseCfg[6][2])
return baseCfg[6][1],cooperationNum,baseCfg[6][3],baseCfg[6][4]
end

if not self.data.reduceTimesData then
self.data.reduceTimesData={}

local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eYingXianGe)
for i=1,bdCfg.max_lvl do
local lvCfg=cfgHelper.get1(cfg_yingxiangeconfig_get,i)
self.data.reduceTimesData[i]={baseCfg[6][1]+lvCfg.ex_reduce_time,baseCfg[6][2]+lvCfg.ex_cooperation_num}
end
end
cooperationNum=self:getSingleMaxCooperationCountEx(self.data.reduceTimesData[level][2])
return self.data.reduceTimesData[level][1],cooperationNum,baseCfg[6][3],baseCfg[6][4]
end

function YingXianGeModel:checkOpen()
return YingXianGeController:getBuildingLevel()>0
end

function YingXianGeModel:checkReddot()
if not YingXianGeModel:checkOpen()then
return false
end
return true
end

function YingXianGeModel:checkYuanZhuPlayer(actorid,sceneidx)
if not xianmengModel:hasXM()then
return false
end

sceneidx=sceneidx or xianjieModel:getSceneIndex()

local yzmyData=self:getYZMyData(sceneidx)

local selfActorId=playerModel:getActorID()
return yzmyData and YingXianGeModel:getYZMYItem(actorid,selfActorId,sceneidx)~=nil
end


function YingXianGeModel:getSelfSingleMaxCooperationCount()
local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local num=baseCfg[6][2]


local bdData=YingXianGeController:getBuildingData()
if bdData then
local level=bdData.level
local cfg=cfgHelper.get1(cfg_yingxiangeconfig_get,level)
num=cfg.ex_cooperation_num+num
end

local finalNum=self:getSingleMaxCooperationCountEx(num)
return finalNum
end

function YingXianGeModel:getSingleMaxCooperationCountEx(num)

local addNum_gubao=gubaoModel:getYXGSingleMaxCooperationCountAddNum()
local finalNum=num+addNum_gubao
return finalNum
end


function YingXianGeModel:getMaxCooperationTypeNum(huZhuType)
local bdData=YingXianGeController:getBuildingData()
local huZhuNum=0


if bdData then
local level=bdData.level
local cfg=cfgHelper.get1(cfg_yingxiangeconfig_get,level)
huZhuNum=cfg and cfg.cooperation_conf[huZhuType]or 0
end

local finalNum=self:getMaxCooperationTypeNumEx(huZhuType,huZhuNum)
return finalNum
end


function YingXianGeModel:getMaxCooperationTypeNumEx(huZhuType,num)

local addNum_gubao=gubaoModel:getYXGMaxCooperationTypeAddNum(huZhuType)
local finalNum=num+addNum_gubao
return finalNum
end