





function lingshouModel:onEnterState_xuemai(isReconnect)

end

function lingshouModel:onProtocolReq_xuemai()

end

function lingshouModel:onLeaveState_xuemai(isReconnect)

end







function lingshouModel:getLingShouConfig(lsID,...)
return cfgHelper.get(cfg_lingshouconfig_get,lsID,...)
end





function lingshouModel:getConfig_XueMai(xmID,...)
return cfgHelper.get(cfg_lingshouxuemaiconfig_get,xmID,...)
end






function lingshouModel:getLevelConfig_XueMai(xmID,level,...)
if level==nil then
local cfg=cfgHelper.get(cfg_lingshouxuemailevelconfig_get,xmID)
if cfg==nil then
logErr("血脉等级配置获取失败",xmID,level)
end
return cfg
end
return cfgHelper.get(cfg_lingshouxuemailevelconfig_get,xmID,level,...)
end






function lingshouModel:getLevelConfig2_XueMai(lsID,level,...)
local lingshouCfg=self:getLingShouConfig(lsID)
local xuemai=lingshouCfg.xuemai[1]

return lingshouModel:getLevelConfig_XueMai(xuemai,level,...)
end






function lingshouModel:getLevelConfig3_XueMai(lsGuid,level,...)
local lsID=self:getLingShouIDByLSGuid(lsGuid)
local lingshouCfg=self:getLingShouConfig(lsID)
local xuemai=lingshouCfg.xuemai[1]

return lingshouModel:getLevelConfig_XueMai(xuemai,level,...)
end

function lingshouModel:getLevelConfig3Ex_XueMai(lsData,level,...)
local lingshouCfg=lsData.cfg
local xuemai=lingshouCfg.xuemai[1]

return lingshouModel:getLevelConfig_XueMai(xuemai,level,...)
end









function lingshouModel:switchLevelToStageName_XueMai(level,needColor)
local xuemaiStageNameList=cfgHelper.get(cfg_lingshoubasicconfig_get,1,'xuemaiStageNameList')
local xuemaiSubStageNumList=cfgHelper.get(cfg_lingshoubasicconfig_get,1,'xuemaiSubStageNumList')

local stage=level

local stageNameIndex=1

local tempLevel=stage
for index=1,#xuemaiSubStageNumList do
tempLevel=tempLevel-1
if tempLevel>=xuemaiSubStageNumList[index]then
stageNameIndex=index+1
tempLevel=tempLevel-(xuemaiSubStageNumList[index]-1)
else
break
end
end

local name
if tempLevel>0 then
name=FMT.fmt("{0}品+{1}",xuemaiStageNameList[stageNameIndex],tempLevel)
else
name=FMT.fmt("{0}品",xuemaiStageNameList[stageNameIndex])
end

if needColor then
local color=FONT_COLOR_VAL[stageNameIndex]
name=toColorStringX(color,name)
end

return name
end





function lingshouModel:switchLevelToStageAndIdx_XueMai(level)
local xuemaiSubStageNumList=cfgHelper.get(cfg_lingshoubasicconfig_get,1,'xuemaiSubStageNumList')

local stage=level
local stageNameIndex=1

local tempLevel=stage
for index=1,#xuemaiSubStageNumList do
tempLevel=tempLevel-1
if tempLevel>=xuemaiSubStageNumList[index]then
stageNameIndex=index+1
tempLevel=tempLevel-(xuemaiSubStageNumList[index]-1)
else
break
end
end

return stageNameIndex,tempLevel
end








function lingshouModel:getLingShouIDByLSGuid(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
return lsData.id
end




function lingshouModel:getLevel_XueMai(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
return lsData.xuemai_val
end






function lingshouModel:getStageName_XueMai(lsGuid,needColor)
local level=self:getLevel_XueMai(lsGuid)
return self:switchLevelToStageName_XueMai(level,needColor)
end




function lingshouModel:getStageIconName(idx)
return string.format("image_lingshou_xuemai_%d",8+idx)
end

function lingshouModel:getPointIconNameByStage(level)
return string.format("icon_lingshou_xuemai_%d",level+1)
end








function lingshouModel:checkIsMaxlevelAndPoint_XueMai(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
local level=lsData.xuemai_val
local point=lsData.xuemai_dianshu

local levelCfgs=self:getLevelConfig3_XueMai(lsGuid)
local lastLevelCfg=levelCfgs[#levelCfgs]

return level>=lastLevelCfg.level and point>=#(lastLevelCfg.pointList)
end




function lingshouModel:checkIsMaxLevel_XueMai(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
local level=lsData.xuemai_val

local levelCfgs=self:getLevelConfig3_XueMai(lsGuid)

return level>=#levelCfgs
end






function lingshouModel:checkIsNeedUpLevel_XueMai(lsGuid,level,point)
local thisLevelConfig=self:getLevelConfig3_XueMai(lsGuid,level)
if thisLevelConfig==nil then return false end
return thisLevelConfig.optionalUpLevelCost[point]~=nil
end





function lingshouModel:checkCanUpLevel_XueMai(lsGuid,level)
local lsData=self:getLingShouData2(lsGuid)

level=level or lsData.xuemai_val

local levelConfig=self:getLevelConfig2_XueMai(lsData.id,level)
local isPassJingJie=lsData.jj_lvl>=levelConfig.limitJingJie
if not isPassJingJie then
local jjName=lingshouModel.getJJNameCommon(levelConfig.limitJingJie,2)
local tips=FMT.fmt("境界需达到{0}({1})",jjName,levelConfig.limitJingJie)
return false,tips
end



return true
end



function lingshouModel:getUpXueMaiSpeCostLsList(lsGuid,speType,checkDress)
local lsList={}
local slsGuidStr=tostring(lsGuid)
local slsData=lingshouModel:getLingShouData2(lsGuid)
local lslookup=lingshouModel:getLingShouDatas()
if speType==-1 then
local limitLSIDList=lingshouModel:getLingShouConfig(slsData.id,'xuemai_cost_ls',slsData.xuemai_val)
if limitLSIDList then
for lsGuidStr,lsData in pairs(lslookup)do
local isNoSameLS=lsGuidStr~=slsGuidStr
local isLimitLs=limitLSIDList[lsData.id]~=nil
local dzGuid=lingshouModel:getDiziguidByLsGuid(lsData.guid)
local isCheckPassDress=true
if dzGuid~=nil then
isCheckPassDress=checkDress
end

if isNoSameLS and isLimitLs and isCheckPassDress then
lsList[#lsList+1]=lsData
end
end
end
return lsList
elseif speType==-2 then
local color=slsData.cfg.color
local generation=slsData.cfg.generation
local race=slsData.cfg.race

for lsGuidStr,lsData in pairs(lslookup)do
local isNoSameLS=lsGuidStr~=slsGuidStr
local isSameColor=lsData.cfg.color==color
local isSameRace=lsData.cfg.race==race
local isSameGeneration=lsData.cfg.generation==generation
local dzGuid=lingshouModel:getDiziguidByLsGuid(lsData.guid)
local isCheckPassDress=true
if dzGuid~=nil then
isCheckPassDress=checkDress
end

if isNoSameLS and isSameColor and isSameRace and isSameGeneration and isCheckPassDress then
lsList[#lsList+1]=lsData
end
end
return lsList
end
return lsList
end




local _readQuickUpLevelFlag="LingShou_XueMai_QuickUpLevelFlag"


function lingshouModel:readQuickUpLevelFlag()
self.quickUpLevelFlag=userActorSetting.get(_readQuickUpLevelFlag,false)
end



function lingshouModel:writeQuickUpLevelFalg(flag)
self.quickUpLevelFlag=flag

userActorSetting.set(_readQuickUpLevelFlag,flag)
userActorSetting.flush()
end



function lingshouModel:getQuickUpLevelFlag()
if self.quickUpLevelFlag==nil then
self:readQuickUpLevelFlag()
end

return self.quickUpLevelFlag
end


function lingshouModel:checkCostEnoughUXueMaiLevel(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
local fixedUpLevelCost=lingshouModel:getLevelConfig2_XueMai(lsData.id,lsData.xuemai_val,'fixedUpLevelCost',lsData.xuemai_dianshu)
local optionalUpLevelCost=lingshouModel:getLevelConfig2_XueMai(lsData.id,lsData.xuemai_val,'optionalUpLevelCost',lsData.xuemai_dianshu)or defaultT

local costT=table.concatTable(fixedUpLevelCost,optionalUpLevelCost)

for index,cost in ipairs(costT)do
local itemId=cost[1]
local needCount=cost[2]
if itemId>0 then
if not itemsModel.checkItemEnough(itemId,needCount)then
return false,cost
end
else
local speType=itemId
local lsDataList=lingshouModel:getUpXueMaiSpeCostLsList(lsGuid,speType,true)or defaultT
if needCount>#lsDataList then
return false,cost
end
end
end
return true
end

function lingshouModel:getLingShouXueMaiReddot(lsGuid)
local isMaxLevel=lingshouModel:checkIsMaxlevelAndPoint_XueMai(lsGuid)
if isMaxLevel then return false end

local isPass=lingshouModel:checkCanUpLevel_XueMai(lsGuid)
if not isPass then return false end

local isCostEnough,cost=lingshouModel:checkCostEnoughUXueMaiLevel(lsGuid)
if not isCostEnough then
return false
end
return true
end

function lingshouModel:getLingShouXueMaiReddot_Top5()
local lsFightTop5List=lingshouModel:getFightTop5EquipLingShouGuidList()
for index,data in ipairs(lsFightTop5List)do
local lsGuid=data.lsGuid
if lingshouModel:getLingShouXueMaiReddot(lsGuid)then
return true
end
end

return false
end


function lingshouModel:findLingShouXueMaiLv(lv)
local lingshoulist=lingshouModel:getLingShouDatas()
local num=0
for lsGuidStr,lsData in pairs(lingshoulist)do
local xuemaiLv=tonumber(lsData.xuemai_val)
local lv2=tonumber(lv)
if lv2 then
if xuemaiLv>=lv2 then
num=num+1
end
end

end
return num
end