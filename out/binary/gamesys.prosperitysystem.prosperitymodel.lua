






local _MODULENAME="prosperityModel"


def_table(_MODULENAME)
prosperityModel.name=_MODULENAME
prosperityModel.data={}

function prosperityModel:onAppStart()

end


function prosperityModel:onEnterState(isReconnect)
self.totalFrValue=0
self.isInit=false
end


function prosperityModel:onProtocolReq()

end


function prosperityModel:onLeaveState(isReconnect)

self.data={}
self.isInit=false
end


local FRD_BaseLV_BuildingFunc=function(build_data)
local buildID=build_data.build_id
local huildLv=build_data.level

local abundance_value=cfgHelper.get3(cfg_monijybuilduplvlconfig_get,buildID,huildLv,'abundance_value')
return abundance_value or 0
end

local FRD_Sp_BuildingInitFunc={
[FRD_SP_BuildingFunc_Index.ProduceRate]=function(build_data,args)

local abundance_value=FRD_BaseLV_BuildingFunc(build_data)

local edatas=zongmenModel:getManufactureEffect(build_data)
local tdatas={}
if build_data.plant_id==0 then

tdatas=zongmenModel:getMergeManufactureEffectEx(edatas,{1,2,4,7})
else

tdatas=zongmenModel:getMergeManufactureEffectEx(edatas,{1,2,4,5,7,8})
end
local val=(tdatas[3]or 0)*0.01


return abundance_value*val
end,
[FRD_SP_BuildingFunc_Index.DiscipleProfressionalSkill]=function(build_data,args)




local discipleID=build_data.dizi_id
local jobType=args[2]


local abundance_value=FRD_BaseLV_BuildingFunc(build_data)

if discipleID and tonumber(tostring(discipleID))>0 then
local jobLevel=eSpecialAttrFunc[jobType].getValue(discipleID)
local value=abundance_value*(jobLevel/100)
return value
end
return 0
end,
[FRD_SP_BuildingFunc_Index.GongFa]=function(build_data,args)
local totalValue=0

local percent=args[2]or 0
if args[2]==nil then
logErr("丹方公式 缺少配置")
end

local allGFList=UIGongFaModel:getAcitveGFList()

local gfTotalValue=0
for gfID,gfData in pairs(allGFList or{})do
gfTotalValue=gfTotalValue+gfData.studylv
end

totalValue=totalValue+gfTotalValue*percent*0.01

return totalValue
end,
[FRD_SP_BuildingFunc_Index.exploreSKill]=function(build_data,args)




local totalValue=0

local cfgid=args[2]
local dfCfg=cfgHelper.get2(cfg_guildabundanceidconfig_get,cfgid,'list_conf')
local tsSkillAllData=QianJiGeModel:get_skill_unlock_data()
for tsSkillID,tsSkillState in pairs(tsSkillAllData or{})do
if tsSkillState and dfCfg[tsSkillID]then
totalValue=totalValue+dfCfg[tsSkillID]
end
end
return totalValue
end,
[FRD_SP_BuildingFunc_Index.ZongMenRule]=function(build_data,args)




local totalValue=0
local cfgid=args[2]
local defaultVal=args[3]
local flCfg=cfgHelper.get2(cfg_guildabundanceidconfig_get,cfgid,'list_conf')

local cfgs=cfg_guildorderconfig()
for i,cfg in pairs(cfgs)do
local orderID=cfg.id
local isActive=guildOrderModel:checkOrderActive(orderID)
if isActive then
if flCfg[orderID]then
totalValue=totalValue+flCfg[orderID]
else
totalValue=totalValue+defaultVal
end
end
end
return totalValue
end,
[FRD_SP_BuildingFunc_Index.ZhengYan]=function(build_data,args)




local totalValue=0
local cfgid=args[2]
local defaultVal=args[3]
local zyCfg=cfgHelper.get2(cfg_guildabundanceidconfig_get,cfgid,'list_conf')



local zyAllCfg=cfg_worldblocktransportconfig()
for worldID,worldData in pairs(zyAllCfg)do
if worldBlockModel:getWorldStateCount(worldID,eWorldBlockState.OPEN)>0 then
for blockID,bloackData in pairs(worldData)do
if worldBlockModel:checkBlockState(worldID,blockID,eWorldBlockState.OPEN)then
if chuanSongZhenModel:getFlagBit(worldID,blockID)then
if zyCfg[worldID]and zyCfg[worldID][blockID]then
totalValue=totalValue+zyCfg[worldID][blockID]
else
totalValue=totalValue+defaultVal
end
end
end
end
end
end
return totalValue
end,
[FRD_SP_BuildingFunc_Index.ChannelNum]=function(build_data,args)




local singChannelValue=args[2]


local abundance_value=FRD_BaseLV_BuildingFunc(build_data)

local channelNum=wanBaoXunBaoDuiModel:getUnlockChannelNum()

local value=abundance_value*(singChannelValue*channelNum/100)



return value
end,
[FRD_SP_BuildingFunc_Index.XianZhanRoomNum]=function(build_data,args)




local singRoomValue=args[2]


local abundance_value=FRD_BaseLV_BuildingFunc(build_data)

local xzRoomCnt=xianzhanModel:getRoomCount()

local value=abundance_value*(singRoomValue*xzRoomCnt/100)

return value
end,
[FRD_SP_BuildingFunc_Index.YinXianTaiJiaZu]=function(build_data,args)




local totalValue=0
local cfgid=args[2]
local jzCfg=cfgHelper.get2(cfg_guildabundanceidconfig_get,cfgid,'list_conf')


local abundance_value=FRD_BaseLV_BuildingFunc(build_data)

local jzDatas=worldXiuZhenJiaZuModel:getAllSelfFamilyData()

for k,jzData in pairs(jzDatas)do
local index=worldXiuZhenJiaZuModel:getFamilyScaleData(jzData.guid)

totalValue=totalValue+jzCfg[index]
end

local value=abundance_value*totalValue*0.01

return value
end,
[FRD_SP_BuildingFunc_Index.XuanShangTaiLevel]=function(build_data,args)




local ratioValue=args[2]
local level=UIXuanShangControl:getXuanShangLevel()
return level*ratioValue*0.01
end
}




function prosperityModel:initData()



self.buildingFRDDataList={}
self.buildingFormulaLookup={}
self.formulaBuildingLookup={}
self.buildingTotalFrValue=0
self.buildingFrUpdateDelayFlag=false
self.buildingManageDiscipleList={}


self.areaTotalFrValue=0
self.areaFRDDataList={}
self.areaFrUpdateDelayFlag=false


self.discipleTotalFrValue=0


self.danfangTotalFrValue=0



self:initBuildingFrdData()


self:initAreaFRDData()


self:updateDiscipleFRDValue(false)


self:updateDanFangFRDValue(false)

self.isInit=true
xiaodaotongModel:refreshTipsList(true)
UIManager:invokeUIMethod('UIFuncStorageWin','refreshFastManagerBtn')

end


function prosperityModel:initBuildingFrdData()
self.buildingFRDDataList={}
self.buildingFormulaLookup={}
self.formulaBuildingLookup={}
self.buildingTotalFrValue=0
self.buildingFrUpdateDelayFlag=false
self.buildingManageDiscipleList={}

local allData=zongmenModel:getAllBuildingData(mapIdType.zhufeng)

for unBuildID,buildData in pairs(allData)do

local buildID=buildData.build_id
local buildLevel=buildData.level
local baseFrd=cfgHelper.get3(cfg_monijybuilduplvlconfig_get,buildID,buildLevel,'abundance_value')

if baseFrd~=nil then
self:constructBuildingFRDData(buildData)

if not mathHelper.compareInt64(buildData.dizi,0)then
local sguid=tostring(buildData.dizi)
self.buildingManageDiscipleList[sguid]=buildData.un_build_id
end
end
end
self:caculateBuildingTotalValue()
end

function prosperityModel:constructBuildingFRDData(build_data)
if build_data.flag==0 then

local unBuildID=build_data.un_build_id
local buildID=build_data.build_id

local huildFRData={
unBuildID=unBuildID,
buildID=buildID,
totalFR=0,
lvFR=0,
spTotalFR=0,
spFRList={},
}
self.buildingFRDDataList[unBuildID]=huildFRData



local temp={}
huildFRData.testInfo=temp
temp.bdName=cfgHelper.get2(cfg_monijybuildconfig_get,buildID,'name')
temp.bdLevel=build_data.level
if not mathHelper.compareInt64(build_data.dizi_id,0)then
temp.dzName=UIDiscipleModel:getDiscipleName(build_data.dizi_id)
end

self:caculateBuildingFRDData(build_data)
end
end

function prosperityModel:caculateBuildingFRDData(build_data)

local unBuildID=build_data.un_build_id
local buildID=build_data.build_id

local huildFRData=self.buildingFRDDataList[unBuildID]

self.buildingFormulaLookup[unBuildID]={}

if huildFRData~=nil then

self:caculateBuildingBaseFrData(huildFRData,build_data)

local bdFrConfig=cfgHelper.get1(cfg_guildabundanceconfig_get,buildID)
if bdFrConfig and bdFrConfig.param_list~=nil then
self:caculateBuildingSpFrData(huildFRData,build_data,bdFrConfig.param_list)
end

self:caculateBuildFrDataTotalValue(huildFRData)
end
end

function prosperityModel:caculateBuildingBaseFrData(huild_FR_Data,build_data)
local unBuildID=build_data.un_build_id
local buildID=build_data.build_id

local frFormula=FRD_SP_BuildingFunc_Index.LevelBase

huild_FR_Data.lvFR=FRD_BaseLV_BuildingFunc(build_data)
self.buildingFormulaLookup[unBuildID][frFormula]={frFormula,{}}

if self.formulaBuildingLookup[frFormula]==nil then
self.formulaBuildingLookup[frFormula]={}
end
local buildType=cfgHelper.get2(cfg_monijybuildconfig_get,buildID,'build_type')
self.formulaBuildingLookup[frFormula][buildType]=true
end

function prosperityModel:caculateBuildingSpFrData(huild_FR_Data,build_data,fr_formula_list)
if fr_formula_list~=nil and build_data~=nil then

local unBuildID=build_data.un_build_id
local buildID=build_data.build_id

for index,frFormula in pairs(fr_formula_list)do
local formulaType=frFormula[1]

local spFunc=FRD_Sp_BuildingInitFunc[formulaType]
local frValue=spFunc(build_data,frFormula)

huild_FR_Data.spFRList[formulaType]=frValue

self.buildingFormulaLookup[unBuildID][formulaType]=frFormula

if self.formulaBuildingLookup[formulaType]==nil then
self.formulaBuildingLookup[formulaType]={}
end
local buildType=cfgHelper.get2(cfg_monijybuildconfig_get,buildID,'build_type')
self.formulaBuildingLookup[formulaType][buildType]=true
end
end
end

function prosperityModel:caculateBuildFrDataTotalValue(fr_Build_data)
local totalValue=0
totalValue=totalValue+fr_Build_data.lvFR

local spTotalValue=0
for formulaType,frValue in pairs(fr_Build_data.spFRList)do
spTotalValue=spTotalValue+frValue
end
fr_Build_data.spTotalFR=spTotalValue

totalValue=totalValue+spTotalValue
fr_Build_data.totalFR=totalValue
end

function prosperityModel:updateBuildFrData(build_data,formulaType,show_dialouge)
local unBuildID=build_data.un_build_id
local buildID=build_data.build_id

show_dialouge=true

local updateSp=function(huildFRData,frFormula)
local formulaType=frFormula[1]

local spFunc=FRD_Sp_BuildingInitFunc[formulaType]
local frValue=spFunc(build_data,frFormula)

huildFRData.spFRList[formulaType]=frValue
end

if self.buildingFormulaLookup[unBuildID]then
local huildFRData=self.buildingFRDDataList[unBuildID]
if formulaType then
if self.buildingFormulaLookup[unBuildID][formulaType]then
local frFormula=self.buildingFormulaLookup[unBuildID][formulaType]
if formulaType>FRD_SP_BuildingFunc_Index.LevelBase then
updateSp(huildFRData,frFormula)
else
huildFRData.lvFR=FRD_BaseLV_BuildingFunc(build_data)
end
end
else
for type,frFormula in pairs(self.buildingFormulaLookup[unBuildID])do
if type>FRD_SP_BuildingFunc_Index.LevelBase then
updateSp(huildFRData,frFormula)
else
huildFRData.lvFR=FRD_BaseLV_BuildingFunc(build_data)
end
end
end
self.buildingFrUpdateDelayFlag=true
self:caculateBuildFrDataTotalValue(huildFRData)

self:showFrdValueChangeDialouge(show_dialouge)
else

local oldTotalValue=self.totalFrValue
self:constructBuildingFRDData(build_data)
self.buildingFrUpdateDelayFlag=true
local totalValue=self:getTotalFRValue()
fightUpRemindController.onFrdFightChanged(oldTotalValue,totalValue)
end

notifySystem:postNotify(notifyConfig.onProsperityChange)
taskController.fanrongduValueChange()
end

function prosperityModel:updateAllBuildFrDataByFormulaType(formulaType)

local bdTypeList=prosperityModel:getFormulaBuildingTypeList(formulaType)
for bdType,_ in pairs(bdTypeList or{})do
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,bdType)
for index,bdData in pairs(bdDatas)do
prosperityModel:updateBuildFrData(bdData,formulaType)
self.buildingFrUpdateDelayFlag=true
end
end


notifySystem:postNotify(notifyConfig.onProsperityChange)
self:showFrdValueChangeDialouge(true)
taskController.fanrongduValueChange()
end

function prosperityModel:caculateBuildingTotalValue()
local tempV=0
for k,buildingFrData in pairs(self.buildingFRDDataList)do
tempV=tempV+buildingFrData.totalFR
end
self.buildingTotalFrValue=tempV
end

function prosperityModel:getBuildingProsperityValueByGuid(build_guid)
return self.buildingFRDDataList[build_guid]
end


function prosperityModel:initAreaFRDData()
local allAreaCfg=cfg_monijyareaconfig()
for k,areaCfg in pairs(allAreaCfg)do
self:constructAreaFRDData(areaCfg.id,areaCfg)
end
self:caculateAreaTotalFRValue()
end

function prosperityModel:constructAreaFRDData(area_id,area_cfg)

local areaFRData={
areaID=area_id,
frValue=0
}
self.areaFRDDataList[area_id]=areaFRData
local isUnlockArea=zongmenModel:isAreaUnlock(area_id)

if area_cfg and area_cfg.abundance_value and isUnlockArea then
areaFRData.frValue=area_cfg.abundance_value
end
end

function prosperityModel:caculateAreaTotalFRValue()
local tempV=0
for k,areaFrData in pairs(self.areaFRDDataList)do
if areaFrData.frValue then
tempV=tempV+areaFrData.frValue
else
logWarn("区域{0}未配置繁荣度",areaFrData.areaID)
end
end
self.areaTotalFrValue=tempV
end

function prosperityModel:updateAreaFRValue(area_id,show_dialouge)
local areaFRData=self.areaFRDDataList[area_id]

local abundance_value=cfgHelper.get2(cfg_monijyareaconfig_get,area_id,'abundance_value')
areaFRData.frValue=abundance_value
self.areaFrUpdateDelayFlag=true


self.buildingFrUpdateDelayFlag=true
self:showFrdValueChangeDialouge(show_dialouge)
notifySystem:postNotify(notifyConfig.onProsperityChange)
taskController.fanrongduValueChange()
end


function prosperityModel:updateDiscipleFRDValue(show_dialouge)
local dzCnt=UIDiscipleModel:checkDiscipleCount()
local dzRate=cfgHelper.getdef(cfg_guildabundanceconfig,'dzratio')
local totalValue=dzCnt*dzRate*0.01
self.discipleTotalFrValue=totalValue

self.buildingFrUpdateDelayFlag=true
self:showFrdValueChangeDialouge(show_dialouge)
notifySystem:postNotify(notifyConfig.onProsperityChange)
taskController.fanrongduValueChange()
end

function prosperityModel:getDiscipleFRDTotalValue()
return self.discipleTotalFrValue
end


function prosperityModel:updateDanFangFRDValue(show_dialouge)
local totalValue=0

local dfCfg=cfgHelper.getdef1(cfg_guildabundanceconfig,'abundance_df_conf')
local dfDefault=cfgHelper.getdef1(cfg_guildabundanceconfig,'df_default_val')
local dfAllData=UIDanYaoModel:getTotalActiveDanfangList()

for dfIndex,dfID in pairs(dfAllData)do
if dfCfg[dfID]~=nil then
totalValue=totalValue+dfCfg[dfID]
else
totalValue=totalValue+dfDefault
end
end

self.danfangTotalFrValue=totalValue
self.buildingFrUpdateDelayFlag=true
self:showFrdValueChangeDialouge(show_dialouge)
notifySystem:postNotify(notifyConfig.onProsperityChange)
taskController.fanrongduValueChange()
end

function prosperityModel:getDanFangFRDTotalValue()
return self.danfangTotalFrValue
end


function prosperityModel:checkUpdateBuildforDiscipleGuid(dizi_guid)
local sDiziGuid=tostring(dizi_guid)
local buildList={}

for sguid,unBuildID in pairs(self.buildingManageDiscipleList)do
if sguid==sDiziGuid then
table.insert(buildList,unBuildID)
end
end
return#buildList>0,buildList
end

function prosperityModel:updateBuildingFrdByList(building_list,show_dialouge)
for k,unBuildID in ipairs(building_list)do
local bdData=zongmenModel:getBuildingData(unBuildID)
self:caculateBuildingFRDData(bdData)
end

self.buildingFrUpdateDelayFlag=true
self:showFrdValueChangeDialouge(show_dialouge)
notifySystem:postNotify(notifyConfig.onProsperityChange)
taskController.fanrongduValueChange()
end


function prosperityModel:getTotalFRValue()
if not self.isInit then return 0 end

if self.buildingFrUpdateDelayFlag then
self.buildingFrUpdateDelayFlag=false
self:caculateBuildingTotalValue()
end

if self.areaFrUpdateDelayFlag then
self.areaFrUpdateDelayFlag=false
self:caculateAreaTotalFRValue()
end

local totalValue=self.buildingTotalFrValue+self.areaTotalFrValue+self.discipleTotalFrValue+self.danfangTotalFrValue

totalValue=Mathf.Floor(totalValue+0.00001)


self.totalFrValue=totalValue

return totalValue
end


function prosperityModel:getBuildingFRDDataList()
local list={}

for unBuildID,frdData in pairs(self.buildingFRDDataList)do
if frdData.totalFR>0 then
table.insert(list,frdData)
end
end

table.sort(list,function(a,b)
return a.totalFR>b.totalFR
end)

return list
end


function prosperityModel:getBuildingProsperityByWinTypeList(type_list,isExclude)
local list={}

for unBuildID,frdData in pairs(self.buildingFRDDataList)do
local win_type=cfgHelper.get2(cfg_monijybuildconfig_get,frdData.buildID,'win_type')
local isFind=table.containsValue(type_list,win_type)
if isExclude then
isFind=not isFind
end
if isFind then
table.insert(list,frdData)
end
end

table.sort(list,function(a,b)
return a.totalFR>b.totalFR
end)

return list
end


function prosperityModel:getBuildingProsperityByTypeList(type_list,isExclude)
local list={}

for unBuildID,frdData in pairs(self.buildingFRDDataList)do
local build_type=cfgHelper.get2(cfg_monijybuildconfig_get,frdData.buildID,'build_type')
local isFind=table.containsValue(type_list,build_type)
if isExclude then
isFind=not isFind
end
if isFind then
table.insert(list,frdData)
end
end

table.sort(list,function(a,b)
return a.totalFR>b.totalFR
end)

return list
end



function prosperityModel:getFormulaBuildingTypeList(formulaType)
return self.formulaBuildingLookup[formulaType]
end

function prosperityModel:getJJFloorIconName(floor)
return FMT.fmt('image_zmdzjja_{0}',floor)
end

function prosperityModel:getLTFloorIconName(floor)
return FMT.fmt('image_zmdzlta_{0}',floor)
end

function prosperityModel:getJJSuffixIconName(index)
return FMT.fmt('image_zmdzjjb_{0}',index)
end

function prosperityModel:getLTSuffixIconName(index)
return FMT.fmt('image_zmdzltb_{0}',index)
end

function prosperityModel:getTotalLevel()
local allLVCfg=cfg_guildabundancelvconfig()
return#allLVCfg
end

function prosperityModel:getCurLevel()
local curTotalFrd=prosperityModel:getTotalFRValue()
local allLVCfg=cfg_guildabundancelvconfig()
local lv=0
for k,cfg in ipairs(allLVCfg)do
if curTotalFrd>=cfg.exp then
lv=cfg.id
end
end
return lv
end

function prosperityModel:showFrdValueChangeDialouge(show_dialouge)
if show_dialouge and systemModel.isOpen(SYSTEM_DEFINE.eProsperity)then
local oldTotalValue=self.totalFrValue
local totalValue=self:getTotalFRValue()
fightUpRemindController.onFrdFightChanged(oldTotalValue,totalValue)
end
end



function prosperityModel:setLevelRewardIdx(idx)
self.data.levelRewardIdx=idx

end

function prosperityModel:getProsperityLevel()
return self.data.levelRewardIdx or 0
end

function prosperityModel:checkLevelTaskReceiveState(level)
local curLevel=prosperityModel:getProsperityLevel()
local isReceived=self.data.levelRewardIdx>=level
local isCanReceive=curLevel>=level
return isCanReceive,isReceived
end



function prosperityModel:getZongMenJingJieMaxInfo()
local sortFunc=function(a,b)
if a.jingjielv==b.jingjielv then
return a.fightvalue>b.fightvalue
else
return a.jingjielv>b.jingjielv
end
end
local temp=UIDiscipleModel:getSortList(nil,sortFunc)
local dzData=temp[1]

local p,pN,pIndex=UIDiscipleModel.getJJSuffix(dzData.jingjielv)

return dzData,pIndex
end


function prosperityModel:getZongMenLianTiMaxInfo()

local sortFunc=function(a,b)
if a.liantilv==b.liantilv then
return a.fightvalue>b.fightvalue
else
return a.liantilv>b.liantilv
end
end
local temp=UIDiscipleModel:getSortList(nil,sortFunc)
local dzData=temp[1]


local p,pN,pIndex=UIDiscipleModel.getJJSuffix(dzData.liantilv)
pIndex=pIndex or 0

return dzData,pIndex
end


function prosperityModel:getZongMenJingJieCntInfo()
local zmLevel=zongmenModel:getLevel()
local zmMaxJJF=nil

local jjLvAllCfg=cfg_disciplejingjieconfig()
for k,cfg in pairs(jjLvAllCfg)do
if cfg.sectlv~=nil then
if zmLevel>=cfg.sectlv then
zmMaxJJF=cfg.floor
else
zmMaxJJF=cfg.floor
break
end
end
end

local selectFunc=function(netData)
local floor=UIDiscipleModel:getJJFloor(netData.jingjielv)
return floor>=zmMaxJJF
end
local sortFunc=function(a,b)
return a.jingjielv>a.jingjielv
end
local temp=UIDiscipleModel:getSortList(selectFunc,sortFunc)or{}

while#temp==0 and zmMaxJJF>0 do
zmMaxJJF=zmMaxJJF-1
temp=UIDiscipleModel:getSortList(selectFunc,sortFunc)or{}
end

local jjName=UIDiscipleModel:getJJFloorName(zmMaxJJF)


return jjName,#temp
end


function prosperityModel:getProductionRecentDataList()
local buildingRecentInfoList={}

local buildingDatas1=zongmenModel:getBuildingsByWintypeList({sysWinType.eFangAn})
for index,bdData in pairs(buildingDatas1)do


local edatas=zongmenModel:getManufactureEffect(bdData)
local tdatas=zongmenModel:getMergeManufactureEffectEx(edatas,{1,2,4,7})
local productionValue=tdatas[3]or 0

local buildNum=zongmenModel:getBuildingCount(bdData.build_id,mapIdType.zhufeng)

if buildingRecentInfoList[bdData.build_id]==nil then
buildingRecentInfoList[bdData.build_id]={
buildID=bdData.build_id,
rate=0,
productionItemId=0,
productionValue=0,
hasProductionPlane=false,
name=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'name'),
icon=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'icon'),
type=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'build_type'),
buildNum=buildNum,
}
end

local infoData=buildingRecentInfoList[bdData.build_id]
infoData.rate=infoData.rate+100+productionValue



local maxMPV=0
local produce_plans=cfgHelper.get3(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level,'produce_plans')
if produce_plans then
local shiftTime=produce_plans[1][1]
local rewardItemID=produce_plans[1].rewards[1][1]
local rewardNum=produce_plans[1].rewards[1][2]

maxMPV=Mathf.Floor(rewardNum/shiftTime+0.000001)
local pValue=Mathf.Floor(1140*maxMPV*((100+productionValue)*0.01)+0.000001)
infoData.productionValue=infoData.productionValue+pValue

infoData.productionItemId=rewardItemID
infoData.hasProductionPlane=true
end


infoData.rate=Mathf.Floor(infoData.rate)
end

local buildingDatas2=zongmenModel:getBuildingsByWintypeList({sysWinType.eShangPu})

local shangPuBuildID=9999999

if buildingDatas2 and#buildingDatas2>0 then

local buildNum=zongmenModel:getBuildingCount(SLG_SYSTEM_TYPE.eXianJiuTang,mapIdType.zhufeng)

if buildingRecentInfoList[shangPuBuildID]==nil then
buildingRecentInfoList[shangPuBuildID]={
buildID=shangPuBuildID,
rate=0,
productionItemId=eMoneyType.mtLingShi,
productionValue=0,
hasProductionPlane=false,
name='商铺',
icon='540004_3x3',
type=SLG_SYSTEM_TYPE.eXianJiuTang,
buildNum=buildNum,
}
end


local infoData=buildingRecentInfoList[shangPuBuildID]

for index,bdData in pairs(buildingDatas2)do
local productionValue=0

if not mathHelper.compareInt64(bdData.dizi_id or 0,0)then
local jobLevel=UIDiscipleModel:getDiscipleJobLevel(bdData.dizi_id,DISCIPLE_PROSKILL_TYPE.eShangDao)
productionValue=jobLevel
end


local val=gubaoModel:getGBSkil_MoneyUpRate(3,eMoneyType.mtLingShi)

infoData.rate=infoData.rate+100+productionValue+val
end
infoData.rate=Mathf.Floor(infoData.rate)
end

local temp={}

for k,v in pairs(buildingRecentInfoList)do
table.insert(temp,v)
end

table.sort(temp,function(a,b)
return a.buildID<b.buildID
end)

return temp
end



function prosperityModel:isCanUpLevel()
local clientLevel=prosperityModel:getCurLevel()
local serverLevel=prosperityModel:getProsperityLevel()
return clientLevel>serverLevel
end


function prosperityModel:getSelfAdaptionExp()
local totalFrVal=self:getTotalFRValue()
local clientLevel=self:getCurLevel()
local serverLevel=self:getProsperityLevel()
local totalLv=prosperityModel:getTotalLevel()
serverLevel=Mathf.Min(totalLv,serverLevel+1)

local subExp
local mainExp

if clientLevel>=serverLevel then

local exp=cfgHelper.get2(cfg_guildabundancelvconfig_get,serverLevel,'exp')
mainExp=cfgHelper.get2(cfg_guildabundancelvconfig_get,serverLevel,'abundance_value')
subExp=totalFrVal-exp
else


local exp=cfgHelper.get2(cfg_guildabundancelvconfig_get,clientLevel,'exp')
subExp=totalFrVal-exp

mainExp=0

for index=clientLevel+1,serverLevel do
mainExp=mainExp+cfgHelper.get2(cfg_guildabundancelvconfig_get,index,'abundance_value')
end
end



return subExp,mainExp
end



function prosperityModel:printBuildingFrData()

end

function prosperityModel:printBuildingFrDatByType(type)
local list={}
local totalValue=0
for k,v in pairs(self.buildingFRDDataList)do
if v.buildID==type then
table.insert(list,v)
totalValue=totalValue+v.totalFR
end
end


end

function prosperityModel:printBuildingDatassssss()
local list={}
for k,v in pairs(self.buildingFRDDataList)do
list[v.buildID]=list[v.buildID]or 0

list[v.buildID]=list[v.buildID]+v.totalFR
end



for buildID,v in pairs(list)do
local gmStr=FMT.fmt('@printAbundance 2 {0}',buildID)
gmControl.reqCommand(gmStr)
end
end

function prosperityModel:printTotalFRValue()

end

function prosperityModel:printTotalFrRValuePart()




end

function prosperityModel:printAreaFrRValue()
local list={}
for k,v in pairs(self.areaFRDDataList)do
list[v.areaID]=list[v.areaID]or 0

list[v.areaID]=list[v.areaID]+v.frValue
end


end

function prosperityModel:testJump1()
jumpManager:jump({id=JUMP_TYPE.eProsperityMain,args={}})
end

function prosperityModel:testJump2()
jumpManager:jump({id=JUMP_TYPE.eProsperityDetailsInfo,args={index=2}})
end









