zongmenModel={}
local _table_remove=table.remove

bdFlagType={
undefine=0,
normal=1,
build=2,
levelUp=3,
sectionBuildStart=4,
sectionBuildComplete=5,
}

BENEFIT_BUFF_EFFECT_TYPE=
{
eJingJieSpeed=1,
eShangPuAdd=2,
eMoneyAutoAdd=3,
eProfessionExp=4,
eDiscipleAttr=5,
eLianTiSpeed=6,
eLingShouJJSpeed=7,
}


BENEFIT_BUFF_ADDITION_TYPE_FUN={
[BENEFIT_BUFF_EFFECT_TYPE.eJingJieSpeed]={

getAdditionTypePramFun=function(type)
local typePram={}
typePram[1]=type or-1
return typePram
end,


checkAdditionTypeEqualsFun=function(buffPram,typePram)
local type=typePram[1]
if type and(type==-1 or buffPram[2]==0 or buffPram[2]==type)then

return buffPram[3]
end

return nil
end
},
[BENEFIT_BUFF_EFFECT_TYPE.eShangPuAdd]={
getAdditionTypePramFun=function(type)
local typePram={}
typePram[1]=type or-1
return typePram
end,


checkAdditionTypeEqualsFun=function(buffPram,typePram)
local type=typePram[1]
if type and(type==-1 or buffPram[2]==0 or buffPram[2]==type)then

return buffPram[3]
end

return nil
end
},
[BENEFIT_BUFF_EFFECT_TYPE.eMoneyAutoAdd]={
getAdditionTypePramFun=function(type1,type2)
if not type1 then
logErr("获取货币自增的增益建筑加成类型参数时 未传入货币类型，请前端检查相关代码")
return nil
end
local typePram={}
typePram[1]=type2 or-1
typePram[2]=type1
return typePram
end,


checkAdditionTypeEqualsFun=function(buffPram,typePram)
local type1=typePram[1]
local type2=typePram[2]
if type1 and(type1==-1 or not buffPram[4]or(buffPram[4]==0 or buffPram[4]==type1))then
if buffPram[2]==type2 then

return buffPram[3]
end
end

return nil
end
},
[BENEFIT_BUFF_EFFECT_TYPE.eProfessionExp]={
getAdditionTypePramFun=function(type1,type2)
if not type1 then
logErr("获取专业技能经验的增益建筑加成类型参数时 未传入专业技能类型，请前端检查相关代码")
return nil
end
local typePram={}
typePram[1]=type2 or-1
typePram[2]=type1
return typePram
end,


checkAdditionTypeEqualsFun=function(buffPram,typePram)
local type1=typePram[1]
local type2=typePram[2]
if type1 and(type1==-1 or not buffPram[4]or(buffPram[4]==0 or buffPram[4]==type1))then
if buffPram[2]==0 or buffPram[2]==type2 then

return buffPram[3]
end
end

return nil
end
},
[BENEFIT_BUFF_EFFECT_TYPE.eDiscipleAttr]={
getAdditionTypePramFun=function(type)
if not type then
logErr("获取弟子属性的增益建筑加成类型参数时 未传入属性类型，请前端检查相关代码")
return nil
end
local typePram={}
typePram[1]=type
return typePram
end,


checkAdditionTypeEqualsFun=function(buffPram,typePram)
local type=typePram[1]
if type and buffPram[2]==type then

return buffPram[3]
end

return nil
end
},
[BENEFIT_BUFF_EFFECT_TYPE.eLianTiSpeed]={

getAdditionTypePramFun=function(type)
local typePram={}
typePram[1]=type or-1
return typePram
end,


checkAdditionTypeEqualsFun=function(buffPram,typePram)
local type=typePram[1]
if type and(type==-1 or buffPram[2]==0 or buffPram[2]==type)then

return buffPram[3]
end

return nil
end
},
[BENEFIT_BUFF_EFFECT_TYPE.eLingShouJJSpeed]={

getAdditionTypePramFun=function(type)
local typePram={}
typePram[1]=type or-1
return typePram
end,


checkAdditionTypeEqualsFun=function(buffPram,typePram)
local type=typePram[1]
if type and(type==-1 or buffPram[2]==0 or buffPram[2]==type)then

return buffPram[3]
end

return nil
end
},
}

function zongmenModel:getBDFlagType(flag)
if flag==0 then
return bdFlagType.normal
elseif flag==1 then
return bdFlagType.build
elseif flag==2 then
return bdFlagType.levelUp
elseif flag>10 and flag<20 then
return bdFlagType.sectionBuildStart
elseif flag>20 and flag<30 then
return bdFlagType.sectionBuildComplete
end

return bdFlagType.undefine
end

function zongmenModel:onEnterState(...)
self.data={}
self.data.mountainData={}
self.data.mountainSkyData={}
self.currWarehouseLimit={}
self.entityIdToGUID={}
self.skyEntityIdToGUID={}
self.homelessRecord={}
self.homeRecord={}
self.areaUnlockRecord={}
self.buildingInMapData={}
self.skyBuildingInMapData={}
self.discipleWorkRoom={}
self.areaSearchRecord={}

self.activeBuild={}
self.activeBuildLookup={}
self.activeBuildReddot={}

self.activeRoad={}
self.activeRoadLookup={}
self.activeRoadReddot={}

self.nameHuds={}
self.qiyuHuds={}
self.freeManufactureBdList_lookup=nil
self.freeManufactureBdReddotCount=nil
self.buildLevelChange=nil

self.data.buildLimitMaxLvList={}

self:loadManufactureEventData()
self:loadRandomObjectPosition()
self:initSkyBDData()
end

function zongmenModel:onLeaveState(...)
self.data=nil
self.currWarehouseLimit=nil
self.entityIdToGUID=nil
self.skyEntityIdToGUID=nil
self.homelessRecord=nil
self.homeRecord=nil
self.areaUnlockRecord=nil
self.buildingInMapData=nil
self.skyBuildingInMapData=nil
self.discipleWorkRoom=nil
self.areaSearchRecord=nil
self.activeBuild={}
self.activeBuildLookup={}
self.activeBuildReddot={}
self.activeRoad={}
self.activeRoadLookup={}
self.activeRoadReddot={}
self.nameHuds={}
self.qiyuHuds={}
self.buildLevelChange=nil
self.freeManufactureBdList_lookup=nil
self.freeManufactureBdReddotCount=nil
end


function zongmenModel:getMountainId()
return self.data.currentMountain
end


function zongmenModel:setMountainId(id)
self.data.currentMountain=id
mainViewsControl.onChangeSceneMap(eSceneType.eZongmen,id)
xiaodaotongModel_update:onSwitchCurMountainId()
end

function zongmenModel:setZongmenDatas(datas)
local data=self.data
data.level=datas[1]
data.exp=datas[2]
data.extraStorage=datas[3]
data.buildedCount=datas[4]
data.buildingCountData={}
local sfcfg=cfg_monijysfconfig()
local cfgs=cfg_monijybuildconfig()
for k,v in pairs(cfgs)do
local td={}
for kk,vv in pairs(sfcfg)do
td[kk]={count=0,extraLimmit=0}
end
data.buildingCountData[k]=td
end
if datas[4]>0 then
for i,v in ipairs(datas[5])do
data.buildingCountData[v.param_1][v.param_2].count=v.param_3
end
end
if datas[6]>0 then
for i,v in ipairs(datas[7])do
data.buildingCountData[v.param_1][v.param_2].extraLimmit=v.param_3
end
end
data.storageDatas={}
if datas[8]>0 then
for i,v in ipairs(datas[9])do
data.storageDatas[v.unbuild_id]={un_build_id=v.unbuild_id,build_id=v.build_id,level=v.build_lv,build_appearance_id=v.build_appearance_id}
end
end
data.openMountains=datas[11]or{}
local animals=cfgHelper.get2(cfg_guildbasicconfig_get,1,"animals")

data.mouseData={datas[12],datas[13],animals[1],animals[2]}
end

function zongmenModel:getMouseCnt()
return self.data.mouseData[2]
end

function zongmenModel:setMouseCnt(cnt)
self.data.mouseData[2]=cnt
end

function zongmenModel:addMouseCnt()
self.data.mouseData[2]=self.data.mouseData[2]+1
end

function zongmenModel:getMouseLastTime()
return self.data.mouseData[1]
end

function zongmenModel:setMouseLastTime(time)
self.data.mouseData[1]=time
end

function zongmenModel:isMaxMouse()
local data=self.data.mouseData
return data[2]>=data[3]
end

function zongmenModel:getMouseLeastTime()
local data=self.data.mouseData
return data[4]-(timeHelper.getServerShortTime()-data[1])
end

function zongmenModel:getStorageMaxNum()
local cfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
return self.data.extraStorage+cfg.collect_build_cnt
end

function zongmenModel:setExtraStorage(collectCount)



if collectCount then
self.data.extraStorage=collectCount
end
end

function zongmenModel:setHideCount(type,id,add)
local tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,type)
local mdata=self:getMountainData(id)
local count=mdata.hideBDCData[tcfg.build_type]or 0
count=count+add
mdata.hideBDCData[tcfg.build_type]=count
end

function zongmenModel:getHideCount(type,id)
local tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,type)
local mdata=self:getMountainData(id)
local count=mdata.hideBDCData[tcfg.build_type]
return count or 0
end

function zongmenModel:getBuildingExtraLimmit(type,id)
local tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,type)
return self.data.buildingCountData[tcfg.build_type][id].extraLimmit or 0
end

function zongmenModel:getBuildingCount(type,id)
local tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,type)
return self.data.buildingCountData[tcfg.build_type][id].count
end

function zongmenModel:addBuildingCount(type,id)
local tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,type)
local data=self.data.buildingCountData[tcfg.build_type][id]
data.count=data.count+1
end

function zongmenModel:cutBuildingCount(type,id)
local tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,type)
local data=self.data.buildingCountData[tcfg.build_type][id]
data.count=data.count-1
end

function zongmenModel:getBuildingMaxNum(type,id)
local tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,type)
local level=self:getLevel()
if id==mapIdType.xianmeng then
local xmLv=xianmengModel:getXMLevel()
level=xmLv or-1
end
local count=0
if tcfg.guildlvl_limit then
for i,v in ipairs(tcfg.guildlvl_limit)do
if level>=v[1]and level<=v[2]then

count=count+(v.param[id]or 0)
break
end
end
end
if tcfg.task_add_buildcnt then
for k,v in pairs(tcfg.task_add_buildcnt)do
if taskModel:checkTaskFinish(k)then
count=count+(v[id]or 0)
end
end
end
count=count+self:getBuildingExtraLimmit(type,id)-self:getHideCount(type,id)
local curr=self:getBuildingCount(type,id)
if count<curr then
count=curr
end
return count
end


function zongmenModel:getMountainIdListByBdType(bdType)
local sfIdList={}
local tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdType)
if tcfg.build_sf then
sfIdList=table.deepCopy(tcfg.build_sf)
return sfIdList
else
logErr(FMT.fmt("找不到建筑类型为{0} 所对应的宗门等级建筑数量限制配置",bdType))
return nil
end
end

function zongmenModel:getBuildingsByWintypeList(typelist,mapType)
mapType=mapType or mapIdType.zhufeng
local allBuilingData=zongmenModel:getAllBuildingData(mapType)

local list={}
for index,bdData in pairs(allBuilingData)do
local win_type=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'win_type')
if table.containsValue(typelist,win_type)then
table.insert(list,bdData)
end
end

return list
end

function zongmenModel:getBuildingLevel(sfId,bdType)
local datas=zongmenModel:getBuildingDataByBdType(sfId,bdType)
if#datas>0 then
local level=datas[1].level
return level
end
return 0
end

function zongmenModel:getOpenMountains()
return self.data.openMountains
end

function zongmenModel:getLevel()
if self.data==nil then return end
return self.data.level
end

function zongmenModel:setLevel(level,exp)
self.data.level=level
self.data.exp=exp
end


function zongmenModel:getWorldLevel()
local zmLevel=self:getLevel()
local worldlevel=cfgHelper.get2(cfg_guildexpconfig_get,zmLevel,'worldlevel')
return worldlevel
end

function zongmenModel:getExp()
return self.data.exp
end

function zongmenModel:setExp(curr,add)
self.data.exp=curr
end

function zongmenModel:isMaxLv(lv)
local zonmenLv=lv or zongmenModel:getLevel()
local maxlv=zongmenModel:getZongMenLimitLv()
return zonmenLv>=maxlv
end

function zongmenModel:checkZongMenExchargeReddot()
local zonmenLv=zongmenModel:getLevel()
if zongmenModel:isMaxLv()then
local expreward=cfgHelper.get2(cfg_guildbasicconfig_get,1,'expreward')
local cost=expreward[1]
local has=tonumber(tostring(zongmenModel:getExp()))
return has>=10*cost
end
return false
end

function zongmenModel:checkZongMenLevelReddot()
local zonmenLv=zongmenModel:getLevel()
local nextConfig=cfgHelper.get1(cfg_guildexpconfig_get,zonmenLv+1)
if zongmenModel:isMaxLv()then return false end
if nextConfig then
local enoughExp=zongmenModel:checkLevelUp()
if enoughExp then
if nextConfig.sysid then
if systemModel.isOpen(nextConfig.sysid)then
return true
end
elseif nextConfig.condition then
local need_jingjie=nextConfig.condition[1][3]
local need_count=nextConfig.condition[1][1]
local count=UISettingModel:getDiziCountByJingjieLv(need_jingjie)
return count>=need_count
else
return true
end
end
end
return false
end


function zongmenModel:getCanLevelUpCountByAddExp(addExp)
if not addExp or addExp==0 then
return 0
end
local nowLevel=zongmenModel:getLevel()
local maxlv=zongmenModel:getZongMenLimitLv()
if nowLevel>=maxlv then

return 0
end

local nowExp=mathHelper.int64_to_number(zongmenModel:getExp())
local levelUpCount=0
local nextLevel=nowLevel+1
for i=nextLevel,maxlv do
local next_cfg=cfg_guildexpconfig_get(i)
local nextLevelNeedExp=next_cfg.exp-nowExp

if addExp>=nextLevelNeedExp then
addExp=addExp-nextLevelNeedExp
nowExp=0
levelUpCount=levelUpCount+1
else
break
end
end

return levelUpCount
end

function zongmenModel:getAdsSpeedupCount()
return self.data.ads_time or 0
end

function zongmenModel:setAdsSpeedupTimes(time)
self.data.ads_time=time
end

function zongmenModel:getBuildedCount()
return self.data.buildedCount
end

function zongmenModel:setMountainDatas(datas)
local mdata={}
local mapId=datas.sf_id
mdata.id=mapId
mdata.name=datas.sf_name
mdata.master=datas.sf_dizi_id
mdata.opentime=datas.opentime
mdata.begintime=datas.begintime
mdata.unlockCount=datas.unlockareacnt
mdata.task=datas.task_idx
mdata.taskFlag=datas.taskFlag
mdata.openUpDisciples=datas.opensfdiziList
mdata.areaDatas={}
if datas.open_area_list_len>0 then
for i,v in ipairs(datas.areaList)do

mdata.areaDatas[v.area_id]=v
if v.opentime>0 then
self.areaUnlockRecord[v.area_id]=true
else
self.areaSearchRecord[v.area_id]=true
end
end
end
mdata.buildingDatas={}
mdata.buildingIdDatas={}
mdata.buildingTypeDatas={}
if datas.open_build_list_len>0 then
for i,v in ipairs(datas.buildList)do


if reconnectState.waitResueGame or mapId==mapIdType.xianmeng then
local bdData=self:getBuildingData(v.un_build_id)
if bdData then
for kk,vv in pairs(v)do
bdData[kk]=vv
end
v=bdData
end
end
v.planStatus=v.plant_id>0 and planStatus.eStart or planStatus.eDefault
mdata.buildingDatas[v.un_build_id]=v
local build_id=v.build_id


if v.dizi_id then
v.dzIdStr=tostring(v.dizi_id)
end

if mdata.buildingIdDatas[build_id]==nil then mdata.buildingIdDatas[build_id]={}end
local buildingIdDatas=mdata.buildingIdDatas[build_id]
buildingIdDatas[#buildingIdDatas+1]=v

if v.caveGeZiLen>0 then
local caveGeziList=v.caveGeziList
for i=1,v.caveGeZiLen do
local caveGeziInfo=caveGeziList[i]
local dzIdStr=tostring(caveGeziInfo.dizi_id)
caveGeziInfo.dzIdStr=dzIdStr
if dzIdStr~='0'then
zongmenModel:setDiZiHome(caveGeziInfo.dizi_id,v.un_build_id)
end
end
end

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
local bdType=cfg.build_type
if mdata.buildingTypeDatas[bdType]==nil then mdata.buildingTypeDatas[bdType]={}end
local buildingTypeDatas=mdata.buildingTypeDatas[bdType]
buildingTypeDatas[#buildingTypeDatas+1]=v

self.buildingInMapData[v.un_build_id]=mdata.id
if v.plant_id>0 then
zongmenControl:setDiscipleState(v,DISCIPLE_STATE_TYPE.ePlantCreate)
end
zongmenModel:setDiscipleBuilding(v.dizi_id,v.un_build_id)


isometricMapSystem:setBenefitBuffBuilding(v)
end
end
mdata.repairDatas={}
mdata.hideBDCData={}
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,mdata.id)
local rplist=cfg.repair_build_list or{}
for k,v in pairs(rplist)do
for ii,vv in ipairs(v)do

local pcfg=cfgHelper.get1(cfg_monijyposidxconfig_get,vv)
mdata.repairDatas[vv]={state=repairStatus.eNotRepaired,x=pcfg.pos[1],y=pcfg.pos[2]}
end
local tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,k)
mdata.hideBDCData[tcfg.build_type]=#v
end
if datas.repair_build_len>0 then
for i,v in ipairs(datas.repairbuildList)do
if v.len>0 then
for ii,vv in ipairs(v.coodList)do

local sd=mdata.repairDatas[vv.param_1]or{}
sd.state=repairStatus.eUnderRepair
sd.guid=vv.param_2
mdata.repairDatas[vv.param_1]=sd
end
end
local tcfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
local count=mdata.hideBDCData[tcfg.build_type]or 0
count=count-v.len
mdata.hideBDCData[tcfg.build_type]=count
end
end
local roadDatas={}
if datas.road_len>0 then
for i,v in ipairs(datas.roadList)do
local key=FMT.fmt('{0}_{1}',v.param_1,v.param_2)
roadDatas[key]={x=v.param_1,y=v.param_2,style=v.param_4,type=v.param_3}
end
end
mdata.roadDatas=roadDatas
local sundriseData={}
if datas.randomItemLen>0 then
for i,v in ipairs(datas.randomList)do
sundriseData[v.rand_item_guid]=v
end
end
mdata.sundriseData=sundriseData
self.data.mountainData[mdata.id]=mdata


end

function zongmenModel:getMountainRoadDatas(mapId)
local mdata=self:getMountainData(mapId)
if mdata then
return mdata.roadDatas or{}
end
return{}
end

function zongmenModel:setQiYuBuildDatas(pushType,len,jzList)
if pushType==1 then
self.qiyuBuildList={}
for i=1,len do
self.qiyuBuildList[jzList[i].param_1]=jzList[i].param_2
end
elseif pushType==2 then
if not self.qiyuBuildList then
self.qiyuBuildList={}
end
for i=1,len do
self.qiyuBuildList[jzList[i].param_1]=jzList[i].param_2
end
end
end

function zongmenModel:getQiYuBuildState(bdId)
if not self.qiyuBuildList then
return 0
end
return self.qiyuBuildList[bdId]
end

function zongmenModel:addMountainRoadDatasByArea(mapId,areaId)
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,mapId)
local datas=cfg.unlock_road and cfg.unlock_road[areaId]or nil
if datas then
local mdata=self:getMountainData(mapId)
if mdata then
local roadDatas=mdata.roadDatas
for ii,vv in ipairs(datas)do
if vv[1]==vv[3]then
local add=vv[2]<vv[4]and 1 or-1
for i=vv[2],vv[4],add do
local x=vv[1]
local y=i
local key=FMT.fmt('{0}_{1}',x,y)
roadDatas[key]={x=x,y=y,style=1,type=vv[5]or 2}
end
elseif vv[2]==vv[4]then
local add=vv[1]<vv[3]and 1 or-1
for i=vv[1],vv[3],add do
local x=i
local y=vv[2]
local key=FMT.fmt('{0}_{1}',x,y)
roadDatas[key]={x=x,y=y,style=1,type=vv[5]or 2}
end
end
end
end
end
end

function zongmenModel:addMountainRoadDatas(mapId,arr)
local mdata=self:getMountainData(mapId)
if mdata then
local roadDatas=mdata.roadDatas
for i,v in ipairs(arr)do
local key=FMT.fmt('{0}_{1}',v.x,v.y)
roadDatas[key]={x=v.x,y=v.y,style=v.type,type=v.style}
end
end
end

function zongmenModel:isCoverRoad(mapId,x,y)
local mdata=self:getMountainData(mapId)
if mdata then
local roadDatas=mdata.roadDatas
local key=FMT.fmt('{0}_{1}',x,y)
return roadDatas[key]~=nil
end
return false
end

function zongmenModel:getRoadData(mapId,x,y)
local mdata=self:getMountainData(mapId)
if mdata then
local roadDatas=mdata.roadDatas
local key=FMT.fmt('{0}_{1}',x,y)
return roadDatas[key],key
end
end

function zongmenModel:removeMountainRoadDatas(mapId,arr)
local mdata=self:getMountainData(mapId)
if mdata then
local roadDatas=mdata.roadDatas
for i,v in ipairs(arr)do
v.x=v.param_1
v.y=v.param_2
end
local len=#arr
for i=2,len do
local v1=arr[i-1]
local v2=arr[i]
if v1.x==v2.x then
local x=v1.x
local check=v1.y<v2.y
local y1=check and v1.y or v2.y
local y2=check and v2.y or v1.y
for y=y1,y2 do
local key=FMT.fmt('{0}_{1}',x,y)
roadDatas[key]=nil
end
elseif v1.y==v2.y then
local y=v1.y
local check=v1.x<v2.x
local x1=check and v1.x or v2.x
local x2=check and v2.x or v1.x
for x=x1,x2 do
local key=FMT.fmt('{0}_{1}',x,y)
roadDatas[key]=nil
end
else
logErr('删除路径两端点不在一直线上')
end
end
end
end

function zongmenModel:getAllSundriseData(mapId)
local mdata=self:getMountainData(mapId)
if mdata then
return mdata.sundriseData or{}
end
return{}
end

function zongmenModel:getSundriseDataByPos(mapId,x,y,id)
if x==0 and y==0 then
logErr('禁用原点坐标')
return nil
end
local mdata=self:getMountainData(mapId)
if mdata then
if mdata.sundriseData then
for k,v in pairs(mdata.sundriseData)do
if v.rand_item_id==id and v.x==x and v.y==y then
return v
end
end
end
end
end

function zongmenModel:addSundriseData(mapId,data)
local mdata=self:getMountainData(mapId)
if mdata then
mdata.sundriseData[data.rand_item_guid]=data
end
end

function zongmenModel:removeSundriseData(mapId,guid)
local mdata=self:getMountainData(mapId)
if mdata then
mdata.sundriseData[guid]=nil
end
end

function zongmenModel:setDiscipleBuilding(dzId,ubdId)
local idstr=tostring(dzId)
if idstr~='0'then
self.discipleWorkRoom[idstr]=ubdId
end
end

function zongmenModel:getDiscipleBuildingByStr(dzGuidStr)
return self.discipleWorkRoom[dzGuidStr]
end

function zongmenModel:getDiscipleBuilding(dzId)
local idstr=tostring(dzId)
return self.discipleWorkRoom[idstr]
end

function zongmenModel:getRepairKey(id,x,y)
return string.format('%s_%s_%s',id,x,y)
end

function zongmenModel:isMountainUnlock(sfId)
local data=self.data.mountainData[sfId]
if not data then
return false
end

if data.opentime==0 and data.begintime==0 then
return false
end

return true
end

function zongmenModel:getMountainData(sfId)
return self.data.mountainData[sfId]
end

function zongmenModel:getAreaData(sfId,areaId)
local mdata=self:getMountainData(sfId)
return mdata and mdata.areaDatas[areaId]or nil
end

function zongmenModel:getUnlockAreaCount(sfId)
local mdata=self:getMountainData(sfId)
if mdata then
local count=0
for k,v in pairs(mdata.areaDatas)do
if v.opentime>0 then
count=count+1
end
end
return count>0 and count or 1
end
return 0
end

function zongmenModel:isAreaUnlock(areaId)






return self.areaUnlockRecord[areaId]==true
end

function zongmenModel:setAreaSearch(areaId)
self.areaSearchRecord[areaId]=true
end

function zongmenModel:getAreaSearchRecord()
return self.areaSearchRecord
end

function zongmenModel:isAreaUnlockInMap(mapId,areaId)
return _MapManager.IsAreaUnlock(mapId,areaId)
end

function zongmenModel:setAreaData(sfId,areaId,data)
local mdata=self:getMountainData(sfId)
if mdata then

mdata.areaDatas[areaId]=data
if data.opentime>0 then
self.areaUnlockRecord[areaId]=true
self.areaSearchRecord[areaId]=nil


zongmenModel:addMountainRoadDatasByArea(sfId,areaId)
end
end
end

function zongmenModel:isCompleteBuildQiYu(bdId)
local state=self:getQiYuBuildState(bdId)
return state==2
end


































function zongmenModel:getAllAreaData(sfId)
local mdata=self:getMountainData(sfId)
return mdata and mdata.areaDatas
end

function zongmenModel:getRepairStatus(sfId,key)
local mdata=self:getMountainData(sfId)
if mdata then
local sd=mdata.repairDatas[key]
return sd.state
end
end

function zongmenModel:getRepairStatusById(sfId,guid)
local mdata=self:getMountainData(sfId)
if mdata then
for k,v in pairs(mdata.repairDatas)do
if v.guid==guid then
return self:getRepairStatus(sfId,k)
end
end
end
end

function zongmenModel:setRepairStatus(sfId,id,status,key)
local mdata=self:getMountainData(sfId)
if mdata then
local sd=mdata.repairDatas[key]
if sd.state~=status and status==repairStatus.eUnderRepair then
self:setHideCount(id,sfId,-1)
end
sd.state=status
end
end

function zongmenModel:setRepairStatusById(sfId,id,status,guid)
local mdata=self:getMountainData(sfId)
if mdata then
for k,v in pairs(mdata.repairDatas)do
if v.guid==guid then
self:setRepairStatus(sfId,id,status,k)
end
end
end
end

function zongmenModel:setRepairStatusByPos(sfId,id,status,guid,x,y)
local mdata=self:getMountainData(sfId)
if mdata then
for k,v in pairs(mdata.repairDatas)do
if v.x==x and v.y==y then
v.guid=guid
self:setRepairStatus(sfId,id,status,k)
end
end
end
end

function zongmenModel:getAllBuildingDataBySF(sfId)
local mdata=self:getMountainData(sfId)
return mdata and mdata.buildingDatas
end

function zongmenModel:getAllBuildingData(sfId)
return zongmenModel:getAllBuildingDataBySF(sfId)or{}
end

function zongmenModel:getABuildingData(sfId)
local datas=self:getAllBuildingData(sfId)
local k,v=next(datas)
return v
end


function zongmenModel:getAllBuildingDataByBdId(sfId,bdId)
local mdata=self:getMountainData(sfId)
if mdata and mdata.buildingIdDatas then
return mdata.buildingIdDatas[bdId]
end
end



function zongmenModel:getBuildingDataByBdId(sfId,bdId)
return zongmenModel:getAllBuildingDataByBdId(sfId,bdId)or{}
end



function zongmenModel:getAllBuildingDataByBdType(sfId,bdType)
local mdata=self:getMountainData(sfId)
if mdata and mdata.buildingTypeDatas then
return mdata.buildingTypeDatas[bdType]
end
end




function zongmenModel:getBuildingDataByBdType(sfId,bdType)
return zongmenModel:getAllBuildingDataByBdType(sfId,bdType)or{}
end

function zongmenModel:setLevelDirty(bdId)
if self.buildLevelChange then
self.buildLevelChange[bdId]=true
end
end

function zongmenModel:checkBuildingWithCondition(sfId,condition)
local count=0
if condition then
local bdId=condition[1]
local num=condition[2]
local level=condition[3]





























local datas=zongmenModel:getAllBuildingDataByBdId(sfId,bdId)
if datas==nil then return false,0 end

for k,v in pairs(datas)do
if v.level>=level then


count=count+1
if count>=num then
return true,count
end

end
end
end
return false,count
end




function zongmenModel:getBuildNum(buildkey,exceptLv)
local buildid
local buildlv
if exceptLv==true then
buildid=buildkey
else
buildid=math.floor(buildkey/100)
buildlv=buildkey%100
end
local num=zongmenModel:getBuildNumEx(buildid,buildlv)
return num
end
function zongmenModel:getBuildNum2(buildkey,exceptLv)
local buildid
local buildlv
if exceptLv==true then
buildid=buildkey
else
local d=string.split(buildkey,'_')
buildid=tonumber(d[1])
buildlv=tonumber(d[2])
end
local num=zongmenModel:getBuildNumEx(buildid,buildlv)
return num
end


function zongmenModel:getBuildNumEx(buildid,needlv,sfId)
local num=0
sfId=sfId or zongmenModel:getMountainId()

local datas=zongmenModel:getAllBuildingDataByBdId(sfId,buildid)
if datas==nil then return 0 end
if needlv==nil then
return datas and#datas or 0
end
for k,v in pairs(datas)do
if v.level>=needlv then
num=num+1
end
end
return num
end

function zongmenModel:getBuildNum3(buildid,needlv)
local num=0
local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do
local bdDatas=zongmenModel:getAllBuildingDataByBdId(v.id,buildid)
if bdDatas then
if needlv==nil then
num=num+#bdDatas
else
for _,v2 in pairs(bdDatas)do
if v2.level>=needlv then
num=num+1
end
end
end
end
end
return num
end

function zongmenModel:hasBuildLevel(buildid,buildlv)
local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do
local bdDatas=zongmenModel:getAllBuildingDataByBdId(v.id,buildid)
if bdDatas then
for _,v2 in pairs(bdDatas)do
if v2.level>=buildlv then
return true
end
end
end
end
return false
end

function zongmenModel:getBuildingData(ubdId)
local sfId=self.buildingInMapData[ubdId]
local mdata=self:getMountainData(sfId)
return mdata and mdata.buildingDatas[ubdId]or nil
end

function zongmenModel:getBuildingLocationMapId(ubdId)
return self.buildingInMapData[ubdId]
end

function zongmenModel:setBuildingEntityId(sfId,ubdId,entityId)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.entityId=entityId
self:setEntityIdRecord(entityId,ubdId)
end
end

function zongmenModel:setEntityIdRecord(entityId,ubdId)
self.entityIdToGUID[entityId]=ubdId
end

function zongmenModel:getGUIDByEntityId(entityId)
return self.entityIdToGUID[entityId]
end

function zongmenModel:deleteBuildIdData(sfId,building,buId)

if self.data==nil or
self.data.mountainData==nil or
self.data.mountainData[sfId]==nil then

return
end

local build_id=buId or building.build_id
local un_build_id=building.un_build_id


if self.data.mountainData[sfId].buildingIdDatas and
self.data.mountainData[sfId].buildingIdDatas[build_id]then

local buildingIdDatas=self.data.mountainData[sfId].buildingIdDatas[build_id]
for i,v in ipairs(buildingIdDatas)do
if v.un_build_id==un_build_id then
_table_remove(buildingIdDatas,i)
break
end
end
end


local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
local bdType=cfg.build_type

if self.data.mountainData[sfId].buildingTypeDatas and
self.data.mountainData[sfId].buildingTypeDatas[bdType]then

local buildingTypeDatas=self.data.mountainData[sfId].buildingTypeDatas[bdType]
for i,v in ipairs(buildingTypeDatas)do
if v.un_build_id==un_build_id then
_table_remove(buildingTypeDatas,i)
break
end
end
end

xiaodaotongModel_update:setBuildDataDirty()
end

function zongmenModel:addBuildIdData(sfId,building,buId)

if self.data==nil or
self.data.mountainData==nil or
self.data.mountainData[sfId]==nil then

return
end

local build_id=buId or building.build_id
local un_build_id=building.un_build_id


if building.dizi_id then
building.dzIdStr=tostring(building.dizi_id)
end


if self.data.mountainData[sfId].buildingIdDatas then

if self.data.mountainData[sfId].buildingIdDatas[build_id]==nil then
self.data.mountainData[sfId].buildingIdDatas[build_id]={}
end
local buildingIdDatas=self.data.mountainData[sfId].buildingIdDatas[build_id]
for i,v in ipairs(buildingIdDatas)do
if v.un_build_id==un_build_id then
_table_remove(buildingIdDatas,i)
break
end
end
buildingIdDatas[#buildingIdDatas+1]=building
end


local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
local bdType=cfg.build_type
if self.data.mountainData[sfId].buildingTypeDatas then

if self.data.mountainData[sfId].buildingTypeDatas[bdType]==nil then
self.data.mountainData[sfId].buildingTypeDatas[bdType]={}
end
local buildingTypeDatas=self.data.mountainData[sfId].buildingTypeDatas[bdType]
for i,v in ipairs(buildingTypeDatas)do
if v.un_build_id==un_build_id then
_table_remove(buildingTypeDatas,i)
break
end
end
buildingTypeDatas[#buildingTypeDatas+1]=building
end

if building.caveGeZiLen>0 then
local caveGeziList=building.caveGeziList
for i=1,building.caveGeZiLen do
local caveGeziInfo=caveGeziList[i]
local dzIdStr=tostring(caveGeziInfo.dizi_id)
caveGeziInfo.dzIdStr=dzIdStr
if dzIdStr~='0'then
zongmenModel:setDiZiHome(caveGeziInfo.dizi_id,un_build_id)
end
end
end

xiaodaotongModel_update:setBuildDataDirty()
end


function zongmenModel:findBuildingByEntityId(entityId)







local guid=self:getGUIDByEntityId(entityId)
if guid then
return self:getBuildingData(guid)
end
return nil
end

function zongmenModel:findBuildingByManager(sfId,mDZId)
mDZId=tostring(mDZId)
local datas=zongmenModel:getAllBuildingData(sfId)
for i,v in pairs(datas)do
local dzId=tostring(v.dizi_id)
if dzId==mDZId then
return v
end
end
return nil
end

function zongmenModel:checkBuildHasManager(bdCfg,bdData)
if bdCfg.id==SLG_SYSTEM_TYPE.eBingGongFang then
return bingGongChangModel:hasDiZi()
else
local dzId=bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
return hasDZ
end
end

function zongmenModel:getConfigByEntityId(sfId,entityId)
local data=self:findBuildingByEntityId(entityId)
if data then
return cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
end
end

function zongmenModel:startMountainUnlock(sfId,time,len,arr)
local mdata=self:getMountainData(sfId)
if mdata then
mdata.begintime=time
mdata.openUpDisciples=arr
end
end

function zongmenModel:completeMountainUnlock(sfId,time)
local mdata=self:getMountainData(sfId)
if mdata then
mdata.opentime=time
end
end

function zongmenModel:startAreaUnlock(sfId,areaId,time,len,arr)
local area=self:getAreaData(sfId,areaId)
if area then
area.begintime=time
area.diziList=arr
end
end

function zongmenModel:completeAreaUnlock(sfId,areaId,time)
local area=self:getAreaData(sfId,areaId)
if area then
area.opentime=time
area.begintime=0
self.areaUnlockRecord[areaId]=true
self.areaSearchRecord[areaId]=nil
end
end

function zongmenModel:startBuild(sfId,ubdId,time,len,arr)
local building=zongmenModel:getBuildingData(ubdId)or{}
if building then
building.begintime=time
building.diziList=arr

end
self.data.mountainData[sfId].buildingDatas[ubdId]=building
zongmenModel:addBuildIdData(sfId,building)
self.buildingInMapData[ubdId]=sfId
end

function zongmenModel:completeBuild(sfId,ubdId,time)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.opentime=time
building.level=1
local ftype=zongmenModel:getBDFlagType(building.flag)
if ftype==bdFlagType.sectionBuildStart then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,building.build_id)
local flevel=building.flag-10
if flevel>=#cfg.repair_cost then
building.flag=0
else
building.flag=building.flag+10
end
else
building.flag=0
end
building.ncreateopentime=gameUtilityModel.getServerShortTime()
self:refreshSpecialBuilding(building.build_id)
zongmenModel:setLevelDirty(building.build_id)
end
end

function zongmenModel:checkBuildingLevelUpCondition(uplevel_condition)
for i,v in ipairs(uplevel_condition)do
if v.type==1 then
if not(zongmenModel:getLevel()>=v.param)then
return false
end
elseif v.type==2 then
if not taskModel:checkTaskFinish(v.param)then
return false
end
elseif v.type==3 then
local bdData
local bdDatas=zongmenModel:getBuildingDataByBdType(self.sfId,v.param[1])
local count=0
local level=v.param[3]
for _,bd in ipairs(bdDatas)do
if bd.level>=level then
count=count+1
else
bdData=bd
end
end
if not(count>=v.param[2])then
return false
end
elseif v.type==4 then
if not zheXianLingModel:checkFinish(v.param[1],v.param[2]or 0)then
return false
end
elseif v.type==5 then
if not(shiLianTaModel:getCurLayer()>v.param)then
return false
end
elseif v.type==6 then
if not systemModel.isOpen(v.param)then
return false
end
elseif v.type==7 then
if yandaotaiModel:getTechnologyListLevel(v.para[1])<v.para[2]then
return false
end
end
end
return true
end

function zongmenModel:startLevelUp(sfId,ubdId,time,len,arr)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.begintime=time
building.diziList=arr

end
end

function zongmenModel:completeLevelUp(sfId,ubdId,level)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.level=level

building.reducetime=0
local ftype=zongmenModel:getBDFlagType(building.flag)
if ftype==bdFlagType.sectionBuildStart then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,building.build_id)
local flevel=building.flag-10
if flevel>=#cfg.repair_cost then
building.flag=0
else
building.flag=building.flag+10
end
else
building.flag=0
end
self:refreshSpecialBuilding(building.build_id)
end
end

function zongmenModel:setMountSpeedupTime(sfId,time)
local mdata=self:getMountainData(sfId)
if mdata then
mdata.reducetimes=mdata.reducetimes+time
end
end

function zongmenModel:setAreaSpeedupTime(sfId,areaId,time)
local adata=self:getAreaData(sfId,areaId)
if adata then
adata.reducetimes=adata.reducetimes+time
end
end

function zongmenModel:setUpgradeSpeedupTime(sfId,ubdId,time)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.reducetime=building.reducetime+time
end
end

function zongmenModel:setProductSpeedupTime(sfId,ubdId,time)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.pcreatereducetimes=building.pcreatereducetimes+time
end
end

function zongmenModel:resetNaturalProduction(sfId,ubdId)
local building=zongmenModel:getBuildingData(ubdId)
if building then
local curTime=gameUtilityModel.getServerShortTime()
local curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,building.build_id,building.level)

if curLvCfg and curLvCfg.normal_produce and
curLvCfg.normal_produce.rewards and#curLvCfg.normal_produce.rewards==1 and
curLvCfg.normal_produce.maxrewards and#curLvCfg.normal_produce.maxrewards==1 then

local rewards=curLvCfg.normal_produce.rewards
local maxrewards=curLvCfg.normal_produce.maxrewards
local time_interval=curLvCfg.normal_produce[1]

local passtime=curTime-building.ncreateopentime
passtime=passtime+building.ncreatetotaltimes
local finishCnt=math.floor(passtime/time_interval)

if finishCnt>=math.ceil(maxrewards[1][2]/rewards[1][2])then
building.ncreatetotaltimes=0
else
building.ncreatetotaltimes=passtime-time_interval*finishCnt
end
else
building.ncreatetotaltimes=0
end
building.ncreateopentime=curTime
end
end

function zongmenModel:startPlanProduction(sfId,ubdId,plantId,dzId,addPercent,timePercent)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.plant_id=plantId
building.pcreatedizi_id=dzId
building.pcreateopentime=gameUtilityModel.getServerShortTime()
building.pcreatetotaltimes=0
building.pcreatereducetimes=0
building.hasExNum=0


zongmenModel:countManufacturePercent(building)
end
end

function zongmenModel:refreshPlanInfo(sfId,ubdId,planId,len,arr)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.plant_id=planId
building.pcreatedizi_id=building.dizi_id


building.effect_len=len
building.effectLst=arr
zongmenModel:countManufacturePercent(building)
end
end

function zongmenModel:endPlanProduction(sfId,ubdId)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.plant_id=0
building.pcreatedizi_id=0
building.pcreateopentime=0
building.pcreatetotaltimes=0
building.pcreatereducetimes=0
end
end

function zongmenModel:moveBuilding(sfId,ubdId,x,y,orientation)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.x=x
building.y=y
building.orientation=orientation
end
end

function zongmenModel:deleteBuilding(sfId,ubdId)
local mdata=self:getMountainData(sfId)
if mdata then
local data=mdata.buildingDatas[ubdId]
if data then
mdata.buildingDatas[ubdId]=nil
zongmenModel:deleteBuildIdData(sfId,data)
self:cutBuildingCount(data.build_id,sfId)
self:refreshSpecialBuilding(data.build_id)
end
end
end

function zongmenModel:stopBuilding(sfId,ubdId,plan,reason)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.pcreatestopreason=reason
end
end

function zongmenModel:restoreBuilding(sfId,ubdId,plan)
local building=zongmenModel:getBuildingData(ubdId)
if building then
building.pcreatestopreason=0
end
end

function zongmenModel:getAllstorageBuilding()
return self.data.storageDatas
end

function zongmenModel:storageBuilding(sfId,ubdId)
local mdata=self:getMountainData(sfId)
if mdata then
local building=mdata.buildingDatas[ubdId]
mdata.buildingDatas[ubdId]=nil
zongmenModel:deleteBuildIdData(sfId,building)
self.data.storageDatas[ubdId]=building

self:refreshSpecialBuilding(building.build_id)
zongmenModel:setLevelDirty(building.build_id)
end
end

function zongmenModel:getStorageBuilding(ubdId)
return self.data.storageDatas[ubdId]
end

function zongmenModel:deleteStorageBuilding(ubdId)
self.data.storageDatas[ubdId]=nil
end

function zongmenModel:findStorageDatasByID(bdId)
local datas={}
for i,v in pairs(self.data.storageDatas)do
if v.build_id==bdId then
table.insert(datas,v)
end
end
return datas
end

function zongmenModel:findStorageCountByID(bdId)
local count=0
for i,v in pairs(self.data.storageDatas)do
if v.build_id==bdId then
count=count+1
end
end
return count
end

function zongmenModel:placeBuilding(sfId,ubdId)
local mdata=self:getMountainData(sfId)
if mdata then
local building=self.data.storageDatas[ubdId]

self.data.storageDatas[ubdId]=nil
self:refreshSpecialBuilding(building.build_id)
end
end

function zongmenModel:setBuildingData(sfId,ubdId,data)
local mdata=self:getMountainData(sfId)
if mdata then

local md=mdata.buildingDatas[ubdId]
if md then
for k,v in pairs(data)do
md[k]=v
end


else
data.planStatus=planStatus.eDefault
mdata.buildingDatas[ubdId]=data
zongmenModel:addBuildIdData(sfId,data)

end
self.buildingInMapData[ubdId]=sfId
end
end

function zongmenModel:changeBuildingManager(sfId,ubdId,dzId)
local oldDzId
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData then
oldDzId=bdData.dizi_id
bdData.dizi_id=dzId
bdData.dzIdStr=tostring(dzId)

if sfId==1 then
self:refreshBuildingEffect(bdData)
end
end
return oldDzId
end


function zongmenModel:getRoomGridFlag(sfId,ubdId,gzId)
local bdData=self:getBuildingData(ubdId)
if bdData and bdData.caveGeziList then
for i,v in ipairs(bdData.caveGeziList)do
if v.gezi_id==gzId then
return v.flag
end
end
end
return-1
end

function zongmenModel:setRoomGridFlag(sfId,ubdId,gzId,flag)
local bdData=self:getBuildingData(ubdId)
if bdData and bdData.caveGeziList then
for i,v in ipairs(bdData.caveGeziList)do
if v.gezi_id==gzId then
v.flag=flag
break
end
end
end
end

function zongmenModel:getRoomGridDizi(sfId,ubdId,gzId)
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData and bdData.caveGeziList then
for i,v in ipairs(bdData.caveGeziList)do
if v.gezi_id==gzId then
return v.dizi_id
end
end
end
return int64.new(0)
end

function zongmenModel:setRoomGridDizi(sfId,ubdId,gzId,dzId,oldDzId,replace)
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData and bdData.caveGeziList then
for i,v in ipairs(bdData.caveGeziList)do
if v.gezi_id==gzId then
v.dizi_id=dzId
v.dzIdStr=tostring(dzId)
break
end
end
end
if not replace then
local oldDzIdStr=tostring(oldDzId)
if oldDzIdStr~='0'then
zongmenModel:setHomelessRecord(oldDzIdStr,true)
zongmenModel:setDiZiHome(oldDzId,nil)
end
end
local dzIdStr=tostring(dzId)
if dzIdStr~='0'then
zongmenModel:setHomelessRecord(dzIdStr,nil)
zongmenModel:setDiZiHome(dzId,ubdId)
end
end

function zongmenModel:checkRoomHaveDeadDz(bdData)
local slots=bdData.caveGeziList
if slots then
for i,v in ipairs(slots)do
local dzIdStr=v.dzIdStr
if dzIdStr==nil then v.dzIdStr=tostring(v.dizi_id)end
if dzIdStr~='0'then
local state=UIDiscipleModel:getDiscipleStateByStr(dzIdStr)
local check=state==DISCIPLE_STATE_TYPE.eChuiWei
if check then
return true
end
end
end
end
return false
end


function zongmenModel:isAnyBuilding(buildType)
local datas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,buildType)
for _,data in pairs(datas)do
local ftype=zongmenModel:getBDFlagType(data.flag)
if ftype==bdFlagType.build or ftype==bdFlagType.sectionBuildStart or ftype==bdFlagType.sectionBuildComplete then
return true
end
end
return false
end


function zongmenModel:checkBuildCanUse(bdData)
return bdData.level>=1 and bdData.flag==0
end

function zongmenModel:getRoomBuildDataByDzId(dzId)
local ubdId=zongmenModel:getDiZiHome(dzId)
if ubdId then
return zongmenModel:getBuildingData(ubdId)
end







































end

function zongmenModel:refreshRoomHud(ubdId,dzId,oldDzId)
local state=UIDiscipleModel:getDiscipleState(oldDzId)
local check=state==DISCIPLE_STATE_TYPE.eChuiWei
if check and tostring(dzId)=='0'then
hudControl:refreshBuildingStatusHUD(ubdId)
end
end



function zongmenModel:initActiveBuildData(len,array)
if array==nil then array={}end
self.activeBuild=array
self.activeBuildLookup={}
for i,v in ipairs(array)do
self.activeBuildLookup[v]=true
end
end

function zongmenModel:addActiveBuild(bdid)
if self.activeBuildLookup[bdid]then return end
self.activeBuildLookup[bdid]=true
self.activeBuild[#self.activeBuild+1]=bdid
self.activeBuildReddot[bdid]=true
reddotControl.onBuildActive()
end

function zongmenModel:isActiveBuild(bdid)
return self.activeBuildLookup[bdid]==true
end

function zongmenModel:getActiveBuild()
return self.activeBuild
end

function zongmenModel:hasAnyActiveBuildReddot()
return next(self.activeBuildReddot)~=nil
end

function zongmenModel:hasActiveBuildReddot(bdid)
return self.activeBuildReddot[bdid]==true
end

function zongmenModel:clearActiveBuildReddot(bdid)
self.activeBuildReddot[bdid]=nil
end

function zongmenModel:clearAllActiveBuildReddot()
local has=zongmenModel:hasAnyActiveBuildReddot()
if has then
self.activeBuildReddot={}
reddotControl.onBuildActive()
end
end


function zongmenModel:initActiveRoadData(len,array)
if array==nil then array={}end
self.activeRoad=array
self.activeRoadLookup={}
for i,v in ipairs(array)do
self.activeRoadLookup[v]=true
end
end

function zongmenModel:addActiveRoad(id)
if self.activeRoadLookup[id]then return end
self.activeRoadLookup[id]=true
self.activeRoad[#self.activeRoad+1]=id
self.activeRoadReddot[id]=true
reddotControl.onRoadActive()
end

function zongmenModel:isActiveRoad(id)
local activate_cost=cfgHelper.get2(cfg_roadstyleconfig_get,id,'activate_cost')
if activate_cost==nil then return true end
return self.activeRoadLookup[id]==true
end

function zongmenModel:hasAnyActiveRoadReddot()
return next(self.activeRoadReddot)~=nil
end

function zongmenModel:hasActiveRoadReddot(id)
return self.activeRoadReddot[id]==true
end

function zongmenModel:clearActiveRoadReddot()
self.activeRoadReddot={}
end

function zongmenModel:clearAllActiveRoadReddot()
local has=zongmenModel:hasAnyActiveRoadReddot()
if has then
self.activeRoadReddot={}
reddotControl.onRoadActive()
end
end


function zongmenModel:isBuildingUnlock(cfg)
local needSys=cfg.build_system
if needSys and not systemModel.isOpen(needSys)then
return false
end

local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,1)
local check=zongmenControl:checkCondition(levelCfg,false)
return check
end

function zongmenModel:hasProductionBuildReddot(id)
local sfId=zongmenModel:getMountainId()
local config=cfgHelper.get1(cfg_monijybuildconfig_get,id)
if config.mountain and not config.mountain[sfId]then
return false
end
local level=zongmenModel:getLevel()
local buildTab=config.buildTab
if buildTab~=BUILD_TAB_TYPE.eProduction or config.build_type==6 or level<config.show_level then
return false
end
if not zongmenModel:isBuildingUnlock(config)then
return false
end
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)
if not moneyModel.checkEnoughMoneyX(lcfg.uplevel_cost)then
return false
end
local curr=zongmenModel:getBuildingCount(id,sfId)
local max=zongmenModel:getBuildingMaxNum(id,sfId)
if max>=999 or curr>=max then
return false
end
return true
end

function zongmenModel:hasAllProductionBuildReddot()
local cfgs=cfg_monijybuildconfig()
for id,v in pairs(cfgs)do
if self:hasProductionBuildReddot(id)then
return true
end
end
return false
end

function zongmenModel:hasFunctionBuildReddot(id)
local sfId=zongmenModel:getMountainId()
local config=cfgHelper.get1(cfg_monijybuildconfig_get,id)
if config.mountain and not config.mountain[sfId]then
return false
end
local level=zongmenModel:getLevel()
local buildTab=config.buildTab
if buildTab~=BUILD_TAB_TYPE.eFunction or not config.showBuildRed or level<config.show_level then
return false
end
if not zongmenModel:isBuildingUnlock(config)then
return false
end
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)
if not moneyModel.checkEnoughMoneyX(lcfg.uplevel_cost)then
return false
end
local curr=zongmenModel:getBuildingCount(id,sfId)
if curr>=1 then
return false
end
return true
end

function zongmenModel:hasAllFunctionBuildReddot()
local cfgs=cfg_monijybuildconfig()
for id,v in pairs(cfgs)do
if self:hasFunctionBuildReddot(id)then
return true
end
end
return false
end


function zongmenModel:refreshBuildingEffect(bdData)
local config=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if config then












zongmenModel:countManufacturePercent(bdData)
else
logErr('找不到建筑配置:',bdData.build_id)
end
end

function zongmenModel:getAllBuildingDataByBdIdWithIgnoreGUID(sfId,bdId,ignore_ubdId)


local buildingDatas=zongmenModel:getBuildingDataByBdId(sfId,bdId)
if ignore_ubdId==nil then return buildingDatas end

local datas={}
for k,v in pairs(buildingDatas)do
if v.un_build_id~=ignore_ubdId then
table.insert(datas,v)
end
end
return datas
end

function zongmenModel:getBuildingDataByBdIdEx(sfId,bdId,ignore_ubdId,ignore_mar_states)





















local buildingDatas=zongmenModel:getBuildingDataByBdId(sfId,bdId)

if ignore_ubdId==nil and
(ignore_mar_states==nil or#ignore_mar_states==0)then
return buildingDatas
end

local list={}
for k,v in pairs(buildingDatas)do
if v.un_build_id~=ignore_ubdId then
local check=true
local state=UIDiscipleModel:getDiscipleStateByStr(v.dzIdStr)
for ii,vv in ipairs(ignore_mar_states)do
if vv==state then
check=false
break
end
end
if check then
table.insert(list,v)
end
end
end
return list
end


function zongmenModel:findBuildingDataByType(sfId,bdType)







local bdDatas=zongmenModel:getAllBuildingDataByBdType(sfId,bdType)
if bdDatas then return bdDatas[1]end
end

function zongmenModel:haveBuildByBuildType(bdType)
local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do

local bdDatas=zongmenModel:getAllBuildingDataByBdType(v.id,bdType)
if bdDatas then
for k,buildData in pairs(bdDatas)do
if buildData.flag==0 then


return true

end
end
end
end
return false
end

function zongmenModel:getAllBuildByBuildType(bdType)
local list={}

local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do


local bdDatas=zongmenModel:getAllBuildingDataByBdType(v.id,bdType)
if bdDatas then
for k,buildData in pairs(bdDatas)do
if buildData.flag==0 then





table.insert(list,buildData)
end
end
end
end



return list
end

function zongmenModel:findBuildingDataByID(sfId,bdId)







local list=zongmenModel:getAllBuildingDataByBdId(sfId,bdId)
if list then return list[1]end
end

function zongmenModel:findBuildingCountByID(sfId,bdId)








local list=zongmenModel:getAllBuildingDataByBdId(sfId,bdId)
return list and#list or 0
end


function zongmenModel:getBuildingAllPlant(bdId,level)
if self.buildingAllPlant==nil then
self.buildingAllPlant={}
end
if self.buildingAllPlant[bdId]==nil then
local allLevelCfg=cfg_monijybuilduplvlconfig_get(bdId)
local allLevelPlantCfg={}
for i,v in ipairs(allLevelCfg)do
table.insert(allLevelPlantCfg,v.produce_plans)
end
self.buildingAllPlant[bdId]=allLevelPlantCfg
end
local plants=self.buildingAllPlant[bdId]
level=level or#plants
return plants[level]
end


function zongmenModel:getBuildingPlantOpenLv(bdId)
if self.buildingPlantOpenLv==nil then
self.buildingPlantOpenLv={}
end
if self.buildingPlantOpenLv[bdId]==nil then
local allLevelCfg=cfg_monijybuilduplvlconfig_get(bdId)
local plant_len={}
for i,v in ipairs(allLevelCfg)do
table.insert(plant_len,v.produce_plans and#v.produce_plans or 0)
end
local plant_id_lv={}
for i,v in ipairs(plant_len)do
if v>0 and plant_id_lv[v]==nil then
plant_id_lv[v]=i
end
end
self.buildingPlantOpenLv[bdId]=plant_id_lv
end
return self.buildingPlantOpenLv[bdId]
end


function zongmenModel:getBuildingEffect(bdData,effect_type)
if bdData then
local build_id=bdData.build_id
local level=bdData.level
local key=string.format('%d_%d',build_id,level)

if self.buildingEffectCfg==nil or
self.buildingEffectCfg[key]==nil then

local bd_lv_cfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)

local lookup={}
if bd_lv_cfg and bd_lv_cfg.effects then
for i,cfg in ipairs(bd_lv_cfg.effects)do
lookup[cfg.type]=cfg.param
end
end
self.buildingEffectCfg=self.buildingEffectCfg or{}
self.buildingEffectCfg[key]=lookup
end
return self.buildingEffectCfg[key][effect_type]
end
end


function zongmenModel:getWarehouseAllLimitList()
local limit=self:getWarehouseAllLimitDict()
local datas={}
for k,v in pairs(limit)do
table.insert(datas,{k,v})
end
return datas
end


function zongmenModel:getWarehouseLimit(moneyType)
local limit=self:getWarehouseAllLimitDict()
return limit[moneyType]or-1
end


function zongmenModel:getWarehouseAllLimitDict()
return self.currWarehouseLimit
end

function zongmenModel:countWarehouseLimit()
local limit={}
local cfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
for k,v in pairs(cfg.store_init_conf)do
limit[k]=v
end
local bdDatas=self:getBuildingDataByBdId(self:getMountainId(),SLG_SYSTEM_TYPE.eCangKu)
for i,v in ipairs(bdDatas)do
local param=self:getBuildingEffect(v,buildingEffectType.eWareBuild)
if param then
for k,v in pairs(param)do
limit[k]=(limit[k]or 0)+v
end
end
end
self.currWarehouseLimit=limit
end

function zongmenModel:checkWarehouseFullByType(moneyType)
local max=self:getWarehouseLimit(moneyType)
if max>0 then
local curr=moneyModel.getMoney(moneyType)
if curr>=max then
return true
end
end
return false
end



function zongmenModel:getDiscipleEffect(dzId,effect_type,build_type)
local adds={[1]=0,[2]=0,[3]=0}
if dzId and tostring(dzId)~='0'then
build_type=build_type or 0
local configs=UIDiscipleModel:getDiscipleSpecialityConfig(dzId)
for _,cfg in ipairs(configs)do
if cfg.build_effects then
local args
for i,v in ipairs(cfg.build_effects)do
if v.type==effect_type then
args=v.param
end
end
if args then
local info=args[build_type]or args[0]
for i,v in ipairs(info)do
adds[v[1]]=adds[v[1]]+v[2]
end
end
end
end
local bd_tybe_cfg=cfg_monijybuildconfig_get(build_type)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
if skill_cfg.buildplant_effects then
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local effect=skill_cfg.buildplant_effects[level]
if effect then
adds[1]=adds[1]-effect[2]
adds[3]=adds[3]+effect[1]
end
end
end
end
return adds
end


function zongmenModel:getDiscipleRoomByData(netData)
local ubdId=zongmenModel:getDiZiHomeByStr(netData.discipleguidStr)
if ubdId then
local discipleguidStr=netData.discipleguidStr
local v=zongmenModel:getBuildingData(ubdId)
if v and v.build_id~=SLG_SYSTEM_TYPE.eDaoLv then
for i,w in ipairs(v.caveGeziList)do
if w.dzIdStr==nil then w.dzIdStr=tostring(w.dizi_id)end
if w.dzIdStr==discipleguidStr then
return v,w
end
end
else
return v
end
end
end


function zongmenModel:getDiscipleRoom(dzId)
local netData=UIDiscipleModel:getDiscipleData(dzId)
return zongmenModel:getDiscipleRoomByData(netData)


















































end

function zongmenModel:hasWorkroomByData(netData)
return self:getDiscipleBuildingByStr(netData.discipleguidStr)~=nil
end


function zongmenModel:getDiscipleWorkroomByData(netData)
local ubdId=self:getDiscipleBuildingByStr(netData.discipleguidStr)
if ubdId then
return self:getBuildingData(ubdId)
end
return nil
end


function zongmenModel:getDiscipleWorkroom(dzId)
local ubdId=self:getDiscipleBuilding(dzId)
if ubdId then
return self:getBuildingData(ubdId)
end
return nil
end

function zongmenModel:getDiscipleHome()

end

function zongmenModel:recordManufactureEvent(content,eventId,args,timeStamp)
local sfId=tonumber(tostring(args[1]))
local bdId=tonumber(tostring(args[2]))
local time=tonumber(tostring(timeStamp))
local bdData=self:getBuildingData(bdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local tdatas=self:getManufactureEventData(cfg.build_type)
if#tdatas>=15 then
_table_remove(tdatas,1)
end
local data={content=content,time=time,isNew=true}
table.insert(tdatas,data)
self:setManufactureEventData(cfg.build_type,tdatas)

self:saveManufactureEventData()
end

function zongmenModel:getManufactureEventData(btype)
return self.data.manufactureEventDatas[tostring(btype)]or{}
end

function zongmenModel:setManufactureEventData(btype,data)
self.data.manufactureEventDatas[tostring(btype)]=data
end

function zongmenModel:isHaveNewManufactureEvent(btype)
local data=self:getManufactureEventData(btype)
local len=#data
return len>0 and data[len].isNew or false
end

function zongmenModel:setManufactureEventRead(btype)
local data=self:getManufactureEventData(btype)
for i,v in ipairs(data)do
v.isNew=false
end
end

function zongmenModel:loadManufactureEventData()
local datas=userActorSetting.get('manufactureEventDatas',{})
self.data.manufactureEventDatas=datas
end

function zongmenModel:saveManufactureEventData()
userActorSetting.set('manufactureEventDatas',self.data.manufactureEventDatas)
userActorSetting.flush(true)
end



function zongmenModel:getManufactureRewardMoney(bdData,plant_id)
local curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)
local plants=self:getBuildingAllPlant(curLvCfg.build_id,curLvCfg.level)
local rewardNum=0
if plant_id and plant_id>0 then
local plantCfg=plants[plant_id]
local rewards=plantCfg.rewards[1]
local reap_percent=bdData.pcreateaddpercent/100+1
rewardNum=math.floor(rewards[2]*reap_percent)
end
return rewardNum
end

function zongmenModel:getNaturalRewardMoney(bdData,time)
local num=0
local curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)
local normalProduce=curLvCfg.normal_produce
if normalProduce then
local profitTime=normalProduce[1]
local reward=normalProduce.rewards[1]

local beginTime=time
if beginTime>0 then
local curTime=gameUtilityModel.getServerShortTime()
local dtime=curTime-beginTime+bdData.ncreatetotaltimes
local dtimeS=math.floor(dtime/profitTime)*profitTime
local profit=reward[2]/profitTime
local crwS=profit*dtimeS

local maxReward=normalProduce.maxrewards[1]
local crw=profit*dtime
local drw=maxReward[2]-crw
local dt=drw/profit
local isFull=dt<=0

if isFull then
num=maxReward[2]
else
num=math.floor(crwS)
end
end
end
return num
end

function zongmenModel:noBuildingTips(bdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
UIManager.error(FMT.fmt('尚未建造{0}',cfg.name))
end

function zongmenModel:haveBuildByBuildIdEx(bdId,isWarming)
local mountainCfg=cfg_monijysfconfig()
local len=0

for _,v in ipairs(mountainCfg)do







local bdDatas=zongmenModel:getAllBuildingDataByBdId(v.id,bdId)
len=len+(bdDatas and#bdDatas or 0)
if len>0 then
return true
end
end


if len<=0 then
if isWarming==true then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
local tips_str=FMT.fmt('尚未建造{0}',cfg.name)
UIManager.error(tips_str)
end
return false
end
return true
end

function zongmenModel:haveBuildByBuildId(bdId,justOpenUI,isList,isWarming,returnData)
local mountainCfg=cfg_monijysfconfig()
local bdList={}
for _,v in ipairs(mountainCfg)do


local bdDatas=zongmenModel:getAllBuildingDataByBdId(v.id,bdId)

if bdDatas then
for _,v1 in ipairs(bdDatas)do

table.insert(bdList,{sfId=v.id,data=v1})

end
end
end
local findData
local maxData
local findDataList={}
local errTips
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)

if#bdList>0 then
local maxLv=1
for i,v in ipairs(bdList)do
local data=v.data
if data.level>=maxLv then
maxLv=data.level
maxData={sfId=v.sfId,data=data}
end











local condition,tips=zongmenControl:isBuildingCanUse(data,isWarming==nil or isWarming)
if condition then
findData=v
findDataList[#findDataList+1]=v
else
errTips=tips
end
end
else
if isWarming==nil or isWarming==true then

local mountIdList=zongmenModel:getMountainIdListByBdType(bdId)
local mapId
local rdata
for i,id in ipairs(mountIdList)do
rdata=isometricMapSystem:getUnlockRepairDataByID(id,bdId)
if rdata then
mapId=id
break
end
end

if rdata then
local pass,tips=zongmenControl:checkBuildingPassRepairCondition(bdId)
if not pass then
UIManager.error(tips)
return
end

UIManager.error(FMT.fmt('请先修复{0}',cfg.name))
return
end
UIManager.error(FMT.fmt('尚未建造{0}',cfg.name))

local sortType=cfg.func_type
local jumpArgs={model=1,sortType=sortType,bdId=bdId}
isometricMapSystem:enterLayoutModel(jumpArgs)
end
return
end
local bdData
if findData then
bdData=findData
else
bdData=maxData
end
if isList then
local temp={}
for i,v in ipairs(findDataList)do
local check=isometricMapSystem:checkBuildState(bdData.sfId,bdData.data,justOpenUI)
if not check then
if returnData then
temp[#temp+1]=v.data
else
temp[#temp+1]=v.data.entityId
end
end
end
if not next(temp)and(isWarming==nil or isWarming==true)and errTips then
UIManager.error(errTips)
end

return temp
else
if bdData then
local check=isometricMapSystem:checkBuildState(bdData.sfId,bdData.data,justOpenUI)
if not check then
if returnData then
return bdData.data
else
return bdData.data.entityId
end
end
end
end
end


function zongmenModel:checkCurLevelNeedBreak()
local conditionStr=''
local config=self:getNextCondition()
local needBreak=false
local conditon
if config then
local need_jingjie=config.condition[1][3]
local need=config.condition[1][1]
local cur=UISettingModel:getDiziCountByJingjieLv(need_jingjie)
local curExp=tonumber(tostring(zongmenModel:getExp()))
local level=self:getLevel()
local next_cfg=cfg_guildexpconfig_get(level+1)
if next_cfg then
needBreak=curExp>=next_cfg.exp
if needBreak then
needBreak=needBreak and not zongmenModel:isMaxLv(level)
end
end
conditon={need_jingjie,cur,need}
end
return needBreak,conditon
end


function zongmenModel:checkLevelBreak()
local canBreak=false
local config=self:getNextCondition()
if config then
local need_jingjie=config.condition[1][3]
local need_count=config.condition[1][1]
local count=UISettingModel:getDiziCountByJingjieLv(need_jingjie)
canBreak=count>=need_count
end
return canBreak
end


function zongmenModel:checkLevelUp()
local level=self:getLevel()
local cfg=cfgHelper.get1(cfg_guildexpconfig_get,level+1)
if cfg then
if cfg.int64exp==nil then cfg.int64exp=int64.new(cfg.exp)end
return self:getExp()>=cfg.int64exp
end
end

function zongmenModel:isBreakLevel()
local level=self:getLevel()
local cfg=cfgHelper.get1(cfg_guildexpconfig_get,level+1)
if cfg then
return cfg.condition~=nil or cfg.sysid~=nil
end
end

function zongmenModel:getNextCondition()
local level=self:getLevel()
local all_cfg=cfg_guildexpconfig()
for i,v in ipairs(all_cfg)do
if v.condition then
if level+1==v.id then
return v
end
end
end
end

function zongmenModel:refreshSpecialBuilding(bdId)
if bdId==SLG_SYSTEM_TYPE.eCangKu then
self:countWarehouseLimit()
end
end








local function addValueToList(list,type1,type2,value)
if value==0 then
return
end
local plist=list[type1]or{}
local pv=plist[type2]or 0
plist[type2]=pv+value
list[type1]=plist
end

function zongmenModel:getMergeManufactureEffect(datas)
local list={}
local exAddPercent=0
for i,v in ipairs(datas)do
local isType6=v.type==6
local vData=v.data
for kk,vv in pairs(vData)do
if isType6 and kk==3 then
exAddPercent=exAddPercent+vv
else
list[kk]=(list[kk]or 0)+vv
end
end
end
list.exAddPercent=exAddPercent
return list
end

function zongmenModel:countPlanRewardDatas(bdData)
local list={}
local pEffectList=bdData.pEffectList
if pEffectList then
for i,v in ipairs(pEffectList)do
addValueToList(list,v.param_2,v.param_1,v.param_3)
end
end

local effectLst={}
if bdData.effectLst then
for i,v in ipairs(bdData.effectLst)do
effectLst[v.times]=v
end
end

local rewardList={}
if bdData.rewardList then
for i,v in ipairs(bdData.rewardList)do
if v.speRewardList then
local rw={}
for ii,vv in ipairs(v.speRewardList)do
rw[#rw+1]={vv.param_1,vv.param_2}
end
rewardList[v.times]=rw
end
end
end

local planDatas={}
local lcfg=cfg_monijybuilduplvlconfig_get(bdData.build_id)[bdData.level]
local pdata=lcfg.produce_plans[bdData.plant_id]
local stepNum=pdata.groups[1]
local stepTime=pdata[1]
local stepReward=pdata.rewards[1]


local baseTimeFactor=stepTime/100
local baseRewardFactor=stepReward[2]/100

for i=1,stepNum do
local data={
index=i,
effectLst={},
stepTime=stepTime,
stepReward={stepReward[1],stepReward[2]},
specialty=rewardList[i],
pcreatesubpercent=0,
pcreatetimepercent=0,
pcreateaddpercent=0,
}

local elist=effectLst[i]
local clist={}
for k,v in pairs(list)do
clist[k]=v
end

if elist then
for ii,v in ipairs(elist.pEffectList)do
addValueToList(clist,v.param_2,v.param_1,v.param_3)
end
end

local rlist={}
local cdatas={}
local exAddPercent=0
for k,v in pairs(clist)do
rlist[#rlist+1]={type=k,data=v}

local isType6=k==6
for kk,vv in pairs(v)do
if isType6 and kk==3 then
exAddPercent=exAddPercent+vv
else
cdatas[kk]=(cdatas[kk]or 0)+vv
end
end
end
data.effectLst=rlist

data.pcreatesubpercent=cdatas[1]or 0
data.pcreatetimepercent=cdatas[2]or 0
data.pcreateaddpercent=cdatas[3]or 0


data.stepTime=_MATH_FLOOR(stepTime+baseTimeFactor*data.pcreatetimepercent)
local opval=_MATH_FLOOR(stepReward[2]+baseRewardFactor*(data.pcreateaddpercent+exAddPercent))
data.stepReward[2]=opval

planDatas[i]=data
end

return planDatas
end


function zongmenModel:countManufacturePercent(bdData)
local pdatas=self:getMergeManufactureEffect(self:getManufactureEffect(bdData))
bdData.pcreatesubpercent=pdatas[1]or 0
bdData.pcreatetimepercent=pdatas[2]or 0
bdData.pcreateaddpercent=pdatas[3]or 0
end

function zongmenModel:countManufacturePercentByType(bdData,mtype)
local pdatas=self:getMergeManufactureEffect(self:getManufactureEffectInIdle(bdData,mtype))
return pdatas
end

function zongmenModel:getManufactureEffect(bdData)
if bdData.plant_id>0 then
return self:getManufactureEffectInPlan(bdData)
else
return self:getManufactureEffectInIdle(bdData)
end
end



function zongmenModel:getMergeManufactureEffectEx(datas,typeList)
local list={}
local exAddPercent=0
typeList=typeList or{}
for i,v in ipairs(datas)do
if table.containsValue(typeList,v.type)then
for kk,vv in pairs(v.data)do

if v.type==6 and kk==3 then
exAddPercent=exAddPercent+vv
else
local pv=list[kk]or 0
pv=pv+vv
list[kk]=pv
end
end
end
end
list.exAddPercent=exAddPercent
return list
end

function zongmenModel:getShopEffect(bdData)
local dzId=bdData.dizi_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local skill_id=cfg.pro_skill_id
local skill_cfg=cfgHelper.get1(cfg_discipleproskillconfig_get,skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local list={}
if skill_cfg.shangpu_effects then
local effect=skill_cfg.shangpu_effects[level]
addValueToList(list,2,1,effect)
end

local gbVal=gubaoModel:getGBSkil_MoneyUpRate(3,eMoneyType.mtLingShi)
addValueToList(list,4,1,gbVal)

local spVal=zongmenModel:countBuffManufactureEffect(bdData.build_id,8)
addValueToList(list,3,1,spVal)

local bsVal=zongmenBuildingSuitModel:countBuffManufactureEffect(bdData.build_id,8)
addValueToList(list,8,1,bsVal)

local rlist={}
for k,v in pairs(list)do
table.insert(rlist,{type=k,data=v})
end

return rlist
end

function zongmenModel:getMergeShopEffect(datas)
local list={}
for i,v in ipairs(datas)do
for kk,vv in pairs(v.data)do
local pv=list[kk]or 0
pv=pv+vv
list[kk]=pv
end
end
return list
end

function zongmenModel:getManufactureEffectInPlan(bdData)
local cddata=buildingCDControl:getCDData(buildingCDType.plan,bdData.un_build_id,true)
if cddata then
local planData=cddata.planDatas[cddata.currStep]
return planData.effectLst
end

local list={}
local datas=bdData.pEffectList
if datas then
for i,v in ipairs(datas)do
addValueToList(list,v.param_2,v.param_1,v.param_3)
end
end
local rlist={}
for k,v in pairs(list)do
table.insert(rlist,{type=k,data=v})
end
return rlist
end

function zongmenModel:countBuffManufactureEffect(bdType,checkType)
local count=0
local stateList=homeBuffModel.getEffectList()
for i,v in ipairs(stateList)do
local id=v[1]
if not zongmenBuildingSuitModel:isSuitBuff(id)then
local cfg=cfgHelper.get1(cfg_guildstateconfig_get,id)
local effects=cfg.effects
for ii,vv in ipairs(effects)do
local ecfg=cfgHelper.get1(cfg_guildstateeffectconfig_get,vv)
local etype=ecfg.effect_type
if etype==checkType then
for iii,vvv in ipairs(ecfg.param[1])do
if vvv==bdType then
count=count+ecfg.param[2]
break
end
end
end
end
end
end
return count
end


function zongmenModel:getManufactureEffectInIdle(bdData,funcType)
local list={}
local dzId=bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
local dzData=UIDiscipleModel:getDiscipleData(dzId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local bdType=cfg.build_type
if hasDZ then
local configs
if funcType then
configs=discipleSelectController.getSpeciallistByFunction(dzId,funcType)
else
configs=discipleSelectController.getSpeciallistByBuild(dzId,bdType)
end
if configs then
for i,v in ipairs(configs)do
if v.build_effects then
for ii,vv in ipairs(v.build_effects)do
local param=vv.param
local condition=vv.condition or{}
local isUnlock=dzSpecialityBuildEffectController:checkConditionFunc(dzData,condition)
if vv.type==1 then
local elist=param[0]
if elist and isUnlock then
for iii,vvv in ipairs(elist)do
addValueToList(list,1,vvv[1],vvv[2])
end
end
elist=param[bdType]
if elist and isUnlock then
for iii,vvv in ipairs(elist)do
addValueToList(list,1,vvv[1],vvv[2])
end
end
else
for iii,vvv in ipairs(param)do
addValueToList(list,1,vvv[1],vvv[2])
end
end
end
end
end
end
end

if hasDZ then
local skill_id=cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
if skill_cfg.buildplant_effects then
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local effect=skill_cfg.buildplant_effects[level]
addValueToList(list,2,3,effect[1])
addValueToList(list,2,1,effect[2])
end
end
end

local val=self:countBuffManufactureEffect(bdType,1)
addValueToList(list,3,3,val)

val=zongmenBuildingSuitModel:countBuffManufactureEffect(bdType,1)
addValueToList(list,8,3,val)

val=gubaoModel:getGBSkil_BuildProduceRate(bdType)
addValueToList(list,4,3,val)

local xcVal=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eZongMenBuildingRate)
if xcVal and xcVal[bdType]then
addValueToList(list,10,3,xcVal[bdType])
end

local effectType=9
local strId=tostring(bdType)
local effectList=yandaotaiModel:getAddrateDatasByEffectId(1)
if effectList and next(effectList)then
val=effectList[strId]
if val then
addValueToList(list,effectType,3,val)
end
end

local _type=11
val=DianFengLevelModel:getDFProduceUpPercent(bdType)
addValueToList(list,_type,3,val)

local blist=_MapManager.GetBenefitBuildingList(bdData.entityId)
if blist then

local slist={}
for i,v in ipairs(blist)do
local data=zongmenModel:findBuildingByEntityId(v)
local blcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,data.build_id,data.level)
local cv=slist[data.build_id]or 0
local nv=blcfg.effects[1].param[bdData.build_id]or 0
if nv>cv then
slist[data.build_id]=nv
end
end
local count=0
for k,v in pairs(slist)do
count=count+v
end
addValueToList(list,5,3,count)
end

if hasDZ then
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if UIDiscipleModel:isShuWuDisciple(dzData.id)then
local count=self:countShuWuManufactureEffect(bdData.build_id,dzData)
addValueToList(list,7,3,count)
else
local datas=UIDiscipleModel:getShuWuDZGlobalMEffectData()
local gval=datas[bdData.build_id]
if gval then
addValueToList(list,7,3,gval)
end
end
end


val=wanLingTaModel:getWanLingTaProduceUpPercent(bdType)
addValueToList(list,12,3,val)

local rlist={}
for k,v in pairs(list)do
table.insert(rlist,{type=k,data=v})
end

return rlist
end

function zongmenModel:countShuWuManufactureEffect(bdId,dzData)
local id=dzData.id
local count=0
local qjCfg=cfgHelper.get1(cfg_discipleqiaojiangconfig_get,dzData.qiaojianglv)
local bonus=qjCfg.bonus[id]
if bonus then
for i,v in ipairs(bonus)do
local bt=v[2]
if bt==0 or bt==bdId then
local ht=v[1]
if ht==2 then
count=count+v[3]
elseif ht==3 then
count=count+dzData.attrList[v[3]]*v[4]*0.01
end
end
end
end

local cfg=UIDiscipleModel:getShuWuDZConfig(id)
for i,v in ipairs(dzData.swList)do
if v>0 then
local skillId=cfg.skill[i]
local skillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,skillId,v)
local bonus=skillCfg.bonus
for ii,vv in ipairs(bonus)do
local bt=vv[2]
if bt==0 or bt==bdId then
local ht=vv[1]
if ht==2 then
count=count+vv[3]
elseif ht==3 then
count=count+dzData.attrList[vv[3]]*vv[4]*0.01
end
end
end
end
end

local datas=UIDiscipleModel:getShuWuDZGlobalMEffectData()
local val=datas[bdId]or 0
count=count+val

return count
end

function zongmenModel:getBuffBuildingBenefitList(bdData)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local bfDict={}
for i,v in ipairs(cfg.benefit_type)do
bfDict[v]=true
end
local list={}
local sfId=_MapManager.GetObjectMapID(bdData.entityId)
local buildingDatas=zongmenModel:getAllBuildingData(sfId)
for k,v in pairs(buildingDatas)do
if bfDict[v.build_id]then
if _MapManager.IsBuildingInBuffArea(bdData.entityId,v.entityId)then
list[v.un_build_id]=v
end
end
end
return list
end

function zongmenModel:getDiscipleWorkPosList()
local datas=self:getAllBuildingData(self:getMountainId())
local list={}
for k,v in pairs(datas)do
if tostring(v.dizi_id)~='0'then
local pos=_MapManager.ToVector3Int(v.x,v.y,0)
list[v.dizi_id]=pos
end
end
return list
end

function zongmenModel:getManufactureRewardList(bdData)
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)
local plantCfg=lcfg.produce_plans[bdData.plant_id]
local list={}
local reward=plantCfg.rewards[1]
list[1]={reward[1],reward[2]*(1+bdData.pcreateaddpercent/100)}
if bdData.spe_reward_len>0 then
local datas=bdData.speRewardList
for i,v in ipairs(datas)do
table.insert(list,{v.param_1,v.param_2,isNew=true})
end
end
return list
end


function zongmenModel:initFreeManufactureBuildingList()

self.freeManufactureBdList_lookup={}
local sfId=mapIdType.zhufeng
local datas=zongmenModel:getAllBuildingData(sfId)
for k,bdData in pairs(datas)do
if bdData.flag==buildingStateType.eNode and bdData.plant_id==0 then

local id=bdData.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
if cfg.win_type==sysWinType.eFangAn then

local ubdId=bdData.un_build_id
self.freeManufactureBdList_lookup[ubdId]={}
end
end
end
end


function zongmenModel:getFreeManufactureBuildingListLookup()
if not self.freeManufactureBdList_lookup then
zongmenModel:initFreeManufactureBuildingList()
end
return self.freeManufactureBdList_lookup
end


function zongmenModel:setFreeManufactureBuildingByUbdId(ubdId)
if not self.freeManufactureBdList_lookup then
zongmenModel:initFreeManufactureBuildingList()
end
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData then
if bdData.flag==buildingStateType.eNode and bdData.plant_id==0 then
local id=bdData.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
if cfg.win_type==sysWinType.eFangAn then
self.freeManufactureBdList_lookup[ubdId]={}
end
elseif self.freeManufactureBdList_lookup[ubdId]then

self.freeManufactureBdList_lookup[ubdId]=nil
end
end
end


function zongmenModel:checkFreeManufactureBuildingListHasUbdId(ubdId)
if not self.freeManufactureBdList_lookup then
zongmenModel:initFreeManufactureBuildingList()
end
if self.freeManufactureBdList_lookup[ubdId]then
return true
end
return false
end


function zongmenModel:checkFreeManufactureBuildingDzStateByUbdId(ubdId)
if self.freeManufactureBdList_lookup and self.freeManufactureBdList_lookup[ubdId]then
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData then
self.freeManufactureBdList_lookup[ubdId].dzCanStartPlan=tostring(bdData.dizi_id)~='0'and UIDiscipleModel:checkDZStateToDoSomething(bdData.dizi_id,eCheckDiscipleStateOpType.eProduce,false)
end
end
end


function zongmenModel:checkFreeManufactureBuildingReddot()
local freeBdList=zongmenModel:getFreeManufactureBuildingListLookup()
for ubdId,_ in pairs(freeBdList)do
local reddot=zongmenModel:checkFreeManufactureBuildingReddotByUbdId(ubdId)
if reddot then
return true
end
end

return false
end


function zongmenModel:getFreeManufactureBuildingReddotNum()
if self.freeManufactureBdReddotCount then
return self.freeManufactureBdReddotCount
end

local reddotCount=0
local freeBdList=zongmenModel:getFreeManufactureBuildingListLookup()
for ubdId,_ in pairs(freeBdList)do
local reddot=zongmenModel:checkFreeManufactureBuildingReddotByUbdId(ubdId)
if reddot then
reddotCount=reddotCount+1
end
end
self.freeManufactureBdReddotCount=reddotCount
return self.freeManufactureBdReddotCount
end


function zongmenModel:clearFreeManufactureBuildingReddotNum()
self.freeManufactureBdReddotCount=nil
end

function zongmenModel:checkFreeManufactureBuildingReddotByUbdId(ubdId)
if self.freeManufactureBdList_lookup[ubdId]then
local bdData=zongmenModel:getBuildingData(ubdId)
if not bdData then return end
local freeData=self.freeManufactureBdList_lookup[ubdId]
if freeData.dzCanStartPlan==nil then
zongmenModel:checkFreeManufactureBuildingDzStateByUbdId(ubdId)
end
if freeData.dzCanStartPlan then
if bdData then

local id=bdData.build_id


if self.freeManufactureBuildCost==nil or
self.freeManufactureBuildCost[id]==nil or
self.freeManufactureBuildCost[id][bdData.level]==nil then
local plans=cfg_monijybuilduplvlconfig_get(id)[bdData.level].produce_plans
local buildCosts={}
if plans then
local maxPlanIndex=#plans
local minPlanIndex=1
buildCosts=plans[maxPlanIndex].cost
local isOnlyLingShi=true
for i,v in ipairs(buildCosts)do
local moneyType=v[1]
if moneyType~=eMoneyType.mtLingShi then
isOnlyLingShi=false
break
end
end
if not isOnlyLingShi then

buildCosts=plans[minPlanIndex].cost
end
end
self.freeManufactureBuildCost=self.freeManufactureBuildCost or{}
self.freeManufactureBuildCost[id]=self.freeManufactureBuildCost[id]or{}
self.freeManufactureBuildCost[id][bdData.level]=buildCosts
end

local costs=self.freeManufactureBuildCost[id][bdData.level]
for i,v in ipairs(costs)do
local moneyType=v[1]
local moneyCount=v[2]
if not moneyModel.checkEnoughMoney(moneyType,moneyCount)then

return false
end
end
return true
end
end
end
return false
end


function zongmenModel:getMonsterLevel()
local lv=zongmenModel:getLevel()
return cfgHelper.get2(cfg_guildlvconfig_get,lv,'monlv')
end


function zongmenModel:getLevelReward(look)
local lv=zongmenModel:getLevel()
for i,v in ipairs(look)do
if lv>=v[1]and lv<=v[2]then
return v[3]
end
end
return nil
end



function zongmenModel:recordHomelessData()
local datas=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(datas)do
self:setHomelessRecord(k,true)
end
end

function zongmenModel:setHomelessRecord(dzId,flag)
self.homelessRecord[tostring(dzId)]=flag
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsg',zmMsgType.homeless,zongmenModel:hasHomeless())
end

function zongmenModel:isHomeless(dzId)
return self.homelessRecord[tostring(dzId)]==true
end

function zongmenModel:hasHomeless()
return next(self.homelessRecord)~=nil
end



function zongmenModel:getDiZiHomeByStr(guidStr)
return self.homeRecord[guidStr]
end

function zongmenModel:getDiZiHome(dzId)
return self.homeRecord[tostring(dzId)]
end

function zongmenModel:setDiZiHome(dzId,ubdId)
self.homeRecord[tostring(dzId)]=ubdId
end



function zongmenModel:setBenefitBuildingBuffList(buffEffectType,ubdId,data,dataIndex)
if not self.data.benefitBuildingBuffList then
self.data.benefitBuildingBuffList={}
end

if not self.data.benefitBuildingBuffList[buffEffectType]then
self.data.benefitBuildingBuffList[buffEffectType]={}
end

if not self.data.benefitBuildingBuffList_lookup then
self.data.benefitBuildingBuffList_lookup={}
end

if not self.data.benefitBuildingBuffList_lookup[ubdId]then
self.data.benefitBuildingBuffList_lookup[ubdId]={}
end

if self.data.benefitBuildingBuffList_lookup[ubdId][dataIndex]then
local index=self.data.benefitBuildingBuffList_lookup[ubdId][dataIndex].index
self.data.benefitBuildingBuffList[buffEffectType][index]=data
self.data.benefitBuildingBuffList_lookup[ubdId][dataIndex].data=self.data.benefitBuildingBuffList[buffEffectType][index]
else
local list=self.data.benefitBuildingBuffList[buffEffectType]


local index=zongmenModel:pushBenefitBuildingBuffRecyclePoolQueue()or#list+1
self.data.benefitBuildingBuffList[buffEffectType][index]=data
self.data.benefitBuildingBuffList_lookup[ubdId][dataIndex]={}
self.data.benefitBuildingBuffList_lookup[ubdId][dataIndex].data=self.data.benefitBuildingBuffList[buffEffectType][index]
self.data.benefitBuildingBuffList_lookup[ubdId][dataIndex].index=index
end


zongmenModel:resetBenefitBuildingBuffAddition(buffEffectType)
end


function zongmenModel:removeBenefitBuildingBuffListByUbdId(ubdId)
if self.data.benefitBuildingBuffList_lookup and self.data.benefitBuildingBuffList_lookup[ubdId]then
for i,v in ipairs(self.data.benefitBuildingBuffList_lookup[ubdId])do
local buffEffectType=v.data[1]
local index=v.index


self.data.benefitBuildingBuffList[buffEffectType][index]=-1

zongmenModel:addBenefitBuildingBuffRecyclePoolQueue(index)


zongmenModel:resetBenefitBuildingBuffAddition(buffEffectType)
end
self.data.benefitBuildingBuffList_lookup[ubdId]=nil
end
end


function zongmenModel:getBenefitBuildingBuffDataByUbdId(ubdId)
if not self.data.benefitBuildingBuffList_lookup then
return nil
end

return self.data.benefitBuildingBuffList_lookup[ubdId]
end


function zongmenModel:getBenefitBuildingBuffListByType(buffEffectType)
if not self.data.benefitBuildingBuffList then
return nil
end

return self.data.benefitBuildingBuffList[buffEffectType]
end




function zongmenModel:getBenefitBuildingBuffAddition(isRefresh,buffEffectType,...)
if not self.data.benefitBuildingBuffSumList then
self.data.benefitBuildingBuffSumList={}
end

if not self.data.benefitBuildingBuffSumList[buffEffectType]then
self.data.benefitBuildingBuffSumList[buffEffectType]={}
end


local typePram=BENEFIT_BUFF_ADDITION_TYPE_FUN[buffEffectType].getAdditionTypePramFun(...)
if not typePram then

return 0
end

local type1=typePram[1]
local type2=typePram[2]
if not isRefresh and self.data.benefitBuildingBuffSumList[buffEffectType][type1]then
if not type2 then
return self.data.benefitBuildingBuffSumList[buffEffectType][type1]
elseif self.data.benefitBuildingBuffSumList[buffEffectType][type1][type2]then
return self.data.benefitBuildingBuffSumList[buffEffectType][type1][type2]
end
end

local buffList=zongmenModel:getBenefitBuildingBuffListByType(buffEffectType)
local addition=0
if not buffList then
return addition
end

for i,v in ipairs(buffList)do
if v~=-1 then
local tmpAddition=BENEFIT_BUFF_ADDITION_TYPE_FUN[buffEffectType].checkAdditionTypeEqualsFun(v,typePram)or 0
addition=addition+tmpAddition
end
end

if not type2 then

self.data.benefitBuildingBuffSumList[buffEffectType][type1]=addition
return addition
else
if not self.data.benefitBuildingBuffSumList[buffEffectType][type1]then
self.data.benefitBuildingBuffSumList[buffEffectType][type1]={}
end

self.data.benefitBuildingBuffSumList[buffEffectType][type1][type2]=addition
return addition
end
end


function zongmenModel:resetBenefitBuildingBuffAddition(buffEffectType)
if not self.data.benefitBuildingBuffSumList then
self.data.benefitBuildingBuffSumList={}
end

self.data.benefitBuildingBuffSumList[buffEffectType]={}
end


function zongmenModel:getBenefitBuildingBuffAttrAddition_Lookup(isRefresh)
local buffEffectType=BENEFIT_BUFF_EFFECT_TYPE.eDiscipleAttr
if not self.data.benefitBuildingBuffSumList then
self.data.benefitBuildingBuffSumList={}
end

if not self.data.benefitBuildingBuffSumList[buffEffectType]then
self.data.benefitBuildingBuffSumList[buffEffectType]={}
end

if not isRefresh and next(self.data.benefitBuildingBuffSumList[buffEffectType])then
return self.data.benefitBuildingBuffSumList[buffEffectType]
end

local buffList=zongmenModel:getBenefitBuildingBuffListByType(buffEffectType)
local additionLookup={}
if not buffList then
return additionLookup
end

for i,v in ipairs(buffList)do
if v~=-1 then
local attrType=v[2]
local additionValue=v[3]

if additionLookup[attrType]then
additionLookup[attrType]=additionLookup[attrType]+additionValue
else
additionLookup[attrType]=additionValue
end
end
end

return additionLookup
end


function zongmenModel:addBenefitBuildingBuffRecyclePoolQueue(index)
if not self.data.benefitBuildingBuffList_recyclePool then
self.data.benefitBuildingBuffList_recyclePool=queue.New()
end

self.data.benefitBuildingBuffList_recyclePool:enqueue(index)
end


function zongmenModel:pushBenefitBuildingBuffRecyclePoolQueue()
if not self.data.benefitBuildingBuffList_recyclePool or self.data.benefitBuildingBuffList_recyclePool:isEmpty()then
return nil
end

local data=self.data.benefitBuildingBuffList_recyclePool:dequeue()
if self.data.benefitBuildingBuffList_recyclePool:isEmpty()then

self.data.benefitBuildingBuffList_recyclePool:clear()
end

return data
end



function zongmenModel:getBenefitBuildingBuffRecyclePoolQueueSize()
if not self.data.benefitBuildingBuffList_recyclePool then
return 0
end

return self.data.benefitBuildingBuffList_recyclePool:size()
end



function zongmenModel:setZongMenScoreGetRewardFlag(flag)
self.data.zongmenScoreFlag=flag
end


function zongmenModel:getZongMenScoreGetRewardFlag(index)
if self.data and self.data.zongmenScoreFlag then
local flag=bitHelper.check_pos(self.data.zongmenScoreFlag,index-1)
return flag
else
return false
end
end


function zongmenModel:getZongMenScoreGetRewardProgressPoint()
if self.data.zongmenScoreProgressPoint then
return self.data.zongmenScoreProgressPoint
end

zongmenModel:refreshZongMenScoreGetRewardProgressPoint()
return self.data.zongmenScoreProgressPoint
end


function zongmenModel:refreshZongMenScoreGetRewardProgressPoint()
self.data.zongmenScoreProgressPoint=0
local progressCfg=cfg_sectscoreconfig()
local progressRewardCount=#progressCfg
for i=1,progressRewardCount do
if zongmenModel:getZongMenScoreGetRewardFlag(i)then
if i>self.data.zongmenScoreProgressPoint then
self.data.zongmenScoreProgressPoint=i
end
else
break
end
end
end


function zongmenModel:checkZongMenScoreRewardReddot()
local gotRewardPoint=zongmenModel:getZongMenScoreGetRewardProgressPoint()
local progressCfg=cfg_sectscoreconfig()
local progressRewardCount=#progressCfg
if gotRewardPoint>=progressRewardCount then

return false
end

local zmScore=moneyModel.getMoney(eMoneyType.mtSectScore)
local nextPoint=gotRewardPoint+1
if progressCfg[nextPoint].score and zmScore>=progressCfg[nextPoint].score then
return true
end

return false
end

function zongmenModel:addNameHud(entityId,hudid)
if entityId==nil or hudid==nil then return end
self.nameHuds[entityId]=hudid
end

function zongmenModel:removeNameHud(entityId)
if entityId==nil then return end
self.nameHuds[entityId]=nil
end

function zongmenModel:hasNameHud(entityId)
if entityId==nil then return end
return self.nameHuds[entityId]~=nil
end

function zongmenModel:getNameHud(entityId)
if entityId==nil then return end
return self.nameHuds[entityId]
end

function zongmenModel:getAllNameHud()
return self.nameHuds
end

function zongmenModel:addQiYuHud(entityId,hudid)
if entityId==nil or hudid==nil then return end
self.qiyuHuds[entityId]=hudid
end

function zongmenModel:removeQiYuHud(entityId)
if entityId==nil then return end
self.qiyuHuds[entityId]=nil
end

function zongmenModel:hasQiYuHud(entityId)
if entityId==nil then return end
return self.qiyuHuds[entityId]~=nil
end

function zongmenModel:getQiYuHud(entityId)
if entityId==nil then return end
return self.qiyuHuds[entityId]
end

function zongmenModel:getAllQiYuHud()
return self.qiyuHuds
end



function zongmenModel:initSkyBDData()

local cfgs=cfg_monijysfconfig()
for i,v in ipairs(cfgs)do
if v.max_sky_bd_num then
self.data.mountainSkyData[v.id]=
{
buildingDatas={},
storageDatas={},
bdCount=0,
}
end
end
end

function zongmenModel:getSkyBuildingLocationMapId(ubdId)
return self.skyBuildingInMapData[ubdId]
end

function zongmenModel:setSkyBuildingDatas(sfId,len,arr,slen,sarr)
local skyDatas={}
local skyStorageDatas={}
local count=0
if len>0 then
for i,v in ipairs(arr)do
if reconnectState.waitResueGame then
local bdData=self:getSkyBuildingData(v.un_build_id)
if bdData then
for kk,vv in pairs(v)do
bdData[kk]=vv
end
v=bdData
end
end
v.orientation=v.dir
self.skyBuildingInMapData[v.un_build_id]=sfId
if v.flag==0 then
skyDatas[v.un_build_id]=v
count=count+1
else
skyStorageDatas[v.un_build_id]=v
end
v.sfId=sfId
end
end

local mountainSkyData={}
mountainSkyData.buildingDatas=skyDatas
mountainSkyData.storageDatas=skyStorageDatas
mountainSkyData.bdCount=count








self.data.mountainSkyData[sfId]=mountainSkyData
end

function zongmenModel:getSkyMountainData(mapId)
return self.data.mountainSkyData[mapId]
end

function zongmenModel:getSkyBuildingDatas(mapId)
local mdata=self:getSkyMountainData(mapId)
if mdata then
return mdata.buildingDatas
end
end

function zongmenModel:getSkyStorageDatas(mapId)
local mdata=self:getSkyMountainData(mapId)
if mdata then
return mdata.storageDatas
end
end

function zongmenModel:getAllSkyStorageDatas()
local list={}
for mapId,mdata in pairs(self.data.mountainSkyData)do
for ubdId,storageData in pairs(mdata.storageDatas)do
table.insert(list,storageData)
end
end
return list
end

function zongmenModel:deleteSkyStorageDatas(ubdId)
for mapId,mdata in pairs(self.data.mountainSkyData)do
if mdata.storageDatas[ubdId]then
mdata.storageDatas[ubdId]=nil
return
end
end
end

function zongmenModel:deleteSkyStorageDatasEx(mapId,ubdId)
local datas=self.data.mountainSkyData[mapId]
if datas and datas.storageDatas then
datas.storageDatas[ubdId]=nil
end
end

function zongmenModel:addSkyBuildingData(datas)
local mapId=datas[1]
local bdId=datas[2]
local x=datas[3]
local y=datas[4]
local dir=datas[5]
local ubdId=datas[6]

local data={}
data.un_build_id=ubdId
data.build_id=bdId
data.x=x
data.y=y
data.dir=dir
data.orientation=dir
data.level=1
data.flag=0
local mountainSkyData=self.data.mountainSkyData[mapId]
mountainSkyData.buildingDatas[ubdId]=data
mountainSkyData.bdCount=mountainSkyData.bdCount+1
self.skyBuildingInMapData[data.un_build_id]=mapId
end

function zongmenModel:moveSkyBuilding(sfId,ubdId,x,y,dir)
local data=self:getSkyBuildingData(ubdId)
data.x=x
data.y=y
data.dir=dir
data.orientation=dir
end

function zongmenModel:storageSkyBuilding(sfId,ubdId)
local mountainSkyData=self.data.mountainSkyData[sfId]
if mountainSkyData then
local data=mountainSkyData.buildingDatas[ubdId]
if data then
mountainSkyData.buildingDatas[ubdId]=nil
data.flag=1
mountainSkyData.storageDatas[ubdId]=data
mountainSkyData.bdCount=mountainSkyData.bdCount-1
return data
end
end
end

function zongmenModel:getSkyBuildingData(ubdId)
local mapId=zongmenModel:getSkyBuildingLocationMapId(ubdId)
local mountainSkyData=self.data.mountainSkyData[mapId]
if mountainSkyData then
local data=mountainSkyData.buildingDatas[ubdId]
return data
end
end

function zongmenModel:placeSkyBuilding(sfId,ubdId,x,y,dir)
local mountainSkyData=self.data.mountainSkyData[sfId]
if mountainSkyData then
local data=mountainSkyData.storageDatas[ubdId]
if data then
mountainSkyData.storageDatas[ubdId]=nil
data.x=x
data.y=y
data.dir=dir
data.orientation=dir
data.flag=0
mountainSkyData.buildingDatas[ubdId]=data
mountainSkyData.bdCount=mountainSkyData.bdCount+1
return data
end
end
end

function zongmenModel:getCurrentSkyBuildingCount(mapId)
local mountainSkyData=self.data.mountainSkyData[mapId]
if mountainSkyData then
return mountainSkyData.bdCount
end

return 0
end

function zongmenModel:setSkyBuildingEntityId(ubdId,entityId)
local data=self:getSkyBuildingData(ubdId)
if data then
data.entityId=entityId
self.skyEntityIdToGUID[entityId]=ubdId
end
end

function zongmenModel:findSkyBuildingByEntityId(entityId)
local ubdId=self.skyEntityIdToGUID[entityId]
local data=self:getSkyBuildingData(ubdId)
return data
end

function zongmenModel:setSkyBuildingClickEnable(mapId,enable)
if api_Available_SetTilemapObjectClickActive()then
local datas=self:getSkyBuildingDatas(mapId)
for k,v in pairs(datas)do
if v.entityId then
_MapManager.SetTilemapObjectClickActive(v.entityId,enable)
end
end
end
end

function zongmenModel:setSkyBuildingShow(mapId,bShow)








_MapManager.SetObjectDisplay(objectType.eSkyPlaceObject,bShow)
end

function zongmenModel:setSurfaceBuildingShow(mapId,bShow)








_MapManager.SetObjectDisplay(objectType.ePlaceObject,bShow)
end


function zongmenModel:getFortBuildingAllFightValue()
local sfId=mapIdType.fort
local fortfight=0
local mdata=self:getMountainData(sfId)
if mdata then
for i,datas in pairs(mdata.buildingIdDatas)do
for k,v in ipairs(datas)do
local lvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,v.build_id,v.level)
fortfight=fortfight+(lvCfg.fortfight or 0)
end
end
end
return fortfight
end


function zongmenModel:getFortFightValue()
local fortfight1=zongmenModel:getFortBuildingAllFightValue()
local fortfight2=XianYunGangModel:getMyAllBoatFight()
local fortfight3=yandaotaiModel:getFrotYanDaoTaiFightValue()
local fortfight4=yunjiayingModel:getFrotSoldierFightValue()

local yzAttrList=XianYunGangModel:getMyAllBoatEquipAttrList()

local fortfightrate=0
local attrTypes={
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
}
for i,attrId in pairs(attrTypes)do
fortfightrate=fortfightrate+(xianjieModel:getJZAttrLookup(attrId)or 0)
fortfightrate=fortfightrate+(tianshudazhenAttrsModel:getLookupAttrs(attrId)or 0)
fortfightrate=fortfightrate+(yzAttrList[attrId]or 0)
end
return math.floor(fortfight1+fortfight2+fortfight3+fortfight4*(1+fortfightrate/3))
end

function zongmenModel:getBuildLimitMaxLv(build_id,isNeedUpdate)
if build_id==nil then
logErr("获取建筑最高等级，传入的参数为空")
return 0
end

local totalLv=self.data.buildLimitMaxLvList[build_id]

if isNeedUpdate or totalLv==nil then
local allLvCfg=cfgHelper.get1(cfg_monijybuilduplvlconfig_get,build_id)
if build_id==SLG_SYSTEM_TYPE.eDuoRen then
local limitExtendSysId
for index,cfg in ipairs(allLvCfg)do
limitExtendSysId=cfgHelper.get3(cfg_monijyhomelvexlconfig_get,SLG_SYSTEM_TYPE.eDuoRen,cfg.level,'limitExtendSysId')
if limitExtendSysId~=nil then
if systemModel.isOpen(limitExtendSysId)then
totalLv=cfg.level
end
else
totalLv=cfg.level
end
end
else
totalLv=#allLvCfg
end
self.data.buildLimitMaxLvList[build_id]=totalLv
end

return totalLv
end

function zongmenModel:getZongMenLimitLv()
if self.zmMaxLv then
return self.zmMaxLv
end

local globalCfg=cfg_globalconfig_get(1)

self.zmMaxLv=globalCfg.maxlv

if globalCfg.maxlvGameVer then
local gvid=pfwindowslController:getGameVersion()
local limit=globalCfg.maxlvGameVer[gvid]
if limit then
self.zmMaxLv=limit
end
end

if globalCfg.maxlvPf then
local pfid=gameUtilityModel.getServerPlatform()
local limit=globalCfg.maxlvPf[pfid]
if limit then
self.zmMaxLv=limit
end
end

return self.zmMaxLv
end
