







FeiShengTaiModel={}




function FeiShengTaiModel.getFeiShengTaiLimitJJLv()
local cfg=cfgHelper.get1(cfg_feishengtaiconfig_get,1)
return cfg.autodj
end

function FeiShengTaiModel.getFeiShengTaiSpecialityList()
local cfg=cfgHelper.get1(cfg_feishengtaiconfig_get,1)
return cfg.djspeciality
end

function FeiShengTaiModel.getBuildingModel()
local cfg=cfgHelper.get1(cfg_feishengtaiconfig_get,1)
return cfg.buildmodel
end






function FeiShengTaiModel.getModelInfo(modelId)
local result={}
result.body=modelId
result.componets={}
local headOffset=cfgHelper.get2(cfg_dbbodyconfig_get,result.body,'headOffset')
if headOffset then
result.offset={headOffset[1],headOffset[2]}
end
result.scale=0.7
result.anim=0
return result
end


function FeiShengTaiModel.getSuccessRate(floor)
floor=floor or 0
local floorCfg=cfgHelper.getdef1(cfg_disciplejingjieconfig,'floor')
return floorCfg and floorCfg[floor][3]or 0
end

function FeiShengTaiModel.getFeiShengTaiBuildingAddRate(buildingLevel)
buildingLevel=buildingLevel or 1
local cfg=cfgHelper.get1(cfg_feishengtaiconfig_get,1)
return cfg.lveffects[buildingLevel]
end


function FeiShengTaiModel.getFailTimesAddRate(floor)
floor=floor or 0
local floorCfg=cfgHelper.getdef1(cfg_disciplejingjieconfig,'floor')
return floorCfg and floorCfg[floor][4]or 0
end


function FeiShengTaiModel.getLightningTimesConfig(successRate)
if successRate<=0 then
return 0
end
local cfg=cfgHelper.get1(cfg_feishengtaiconfig_get,1)
for i,v in ipairs(cfg.lightningtimes)do
if successRate>=v[1]and successRate<=v[2]then
return v[3]
end
end
return cfg.lightningtimes[#cfg.lightningtimes][3]
end


function FeiShengTaiModel.getTuPoDanUseCountLimit(floor)
floor=floor or 0
local floorCfg=cfgHelper.getdef1(cfg_disciplejingjieconfig,'floor')
return floorCfg and floorCfg[floor][6]or 0
end


function FeiShengTaiModel.getHuDaoFuRetainJJFloor(stage)
local cfg=cfgHelper.get2(cfg_feishengtaiconfig_get,1,'retainitem')
if cfg then
return cfg[stage]
end

return nil
end





function FeiShengTaiModel:init_data()
self.data={}
end

function FeiShengTaiModel:getBuilding()
local mountainId=zongmenModel:getMountainId()
local buildingList=zongmenModel:getBuildingDataByBdType(mountainId,SLG_SYSTEM_TYPE.eFeiShengTai)
local len=#buildingList
if len>0 then
for _,v in ipairs(buildingList)do
return v
end
end
end

function FeiShengTaiModel:getBuildingLevel()
local building=self:getBuilding()
return building and building.level or 1
end

function FeiShengTaiModel:getMyFeiShengSpecialitySuccessRate(guid)
local SuccessRate=0
local configs=UIDiscipleModel:getDiscipleSpecialityConfig(guid)
if#configs>0 then
local addRateCfg=FeiShengTaiModel.getFeiShengTaiSpecialityList()
for i,cfg in ipairs(configs)do
for _,v in ipairs(addRateCfg)do
if v[1]==cfg.specialitytype and v[2]==cfg.id then
SuccessRate=SuccessRate
end
end
end
end
return SuccessRate
end

function FeiShengTaiModel:setMaxRate(rate)
rate=rate>100 and 100 or rate
return rate
end


function FeiShengTaiModel:getDiscipleBrokeSuccessRate(guid)

local netData=UIDiscipleModel:getDiscipleData(guid)

local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local floor=UIDiscipleModel:getJJFloor(jjlv)

local buildingAddRate=0
if self:isBuildingRepaired()then
local buildingLevel=self:getBuildingLevel()
buildingAddRate=self.getFeiShengTaiBuildingAddRate(buildingLevel)
end

local failAddRate=UIDiscipleModel:getDuJieFailRate(guid)

local speRate=dzSpecialityGrowEffectController:getJJBrokeRate(netData)

local jjRateList=UIDiscipleModel:getDuJieDanRate(guid)

local floorcfg=cfgHelper.getdef1(cfg_disciplejingjieconfig,'floor')
local offsetRate=floorcfg[floor][8]
local baseRate=self.getSuccessRate(floor)+jjRateList[1]+offsetRate

local dujiedanRate=jjRateList[2]

local eventRate=jjRateList[3]

local jindiRate=jjRateList[4]or 0

local gubaoRate=gubaoModel:getGBSkil_DuJieRate(jjlv)

local buffRate=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eDujieSuccessPrecentChanged)or 0

local buffs=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eDiziDuJieFloorChanged)or{}
for idx,buffId in ipairs(buffs)do
local buffCfg=cfgHelper.get1(cfg_guildstateeffectconfig_get,buffId)
local tf=-1
for f,r in pairs(buffCfg.param)do
if floor>=f then
tf=math.max(tf,f)
end
end
if tf>=0 then
buffRate=buffRate+buffCfg.param[tf]
end
end

local dujieup=FeiShengTaiModel:GetDuJieUP()

local rate=baseRate+dujiedanRate+failAddRate+buildingAddRate+speRate+eventRate+jindiRate+gubaoRate+buffRate+dujieup
rate=self:setMaxRate(rate)

if rate<0 then
rate=0
end
return rate,{baseRate,dujiedanRate,failAddRate,speRate,eventRate,jindiRate,gubaoRate,buildingAddRate,buffRate,dujieup},offsetRate
end

function FeiShengTaiModel:DiscipleBrokeSuccessRateStr(guid)
local strList={"基础概率：{0}%","丹药加成：{0}%","失败加成：{0}%","特质加成：{0}%","事件加成：{0}%","禁地悟道：{0}%","古宝加成：{0}%","建筑加成：{0}%","宗门状态：{0}%","飞升台加成：{0}%"}
local rate,ratelist,offsetRate=FeiShengTaiModel:getDiscipleBrokeSuccessRate(guid)
local str=''
local index=1
for i,s in ipairs(strList)do
local rate=ratelist[i]
if rate~=nil and rate~=0 then
if i==1 then
str=FMT.fmt(s,rate)





else
if index==1 then
str=FMT.fmt(s,rate)
else
str=FMT.fmt('{0}\n{1}',str,FMT.fmt(s,rate))
end

end
index=index+1
end
end



return str
end



function FeiShengTaiModel:setLightningDisciple(guid)
self.data.lightningDisciple=guid
end

function FeiShengTaiModel:getLightningDisciple()
return self.data.lightningDisciple
end



function FeiShengTaiModel:setLightningResult(result)
self.data.lightningResult=result
end

function FeiShengTaiModel:getLightningResult()
return self.data.lightningResult
end


function FeiShengTaiModel:getLightningTimes(successRate)
local lightningtimes=self:getLightningResult()and 9 or self.getLightningTimesConfig(successRate)
return lightningtimes,(1+lightningtimes)*lightningtimes/2
end


function FeiShengTaiModel:calculateLightningDamage(lightningNum)
local successRateBrokeBefore=FeiShengTaiModel:getSuccessRateBrokeBefore()
if not self.data.damgeCof then
local totalTimes,p=self:getLightningTimes(successRateBrokeBefore)
self.data.damgeCof=p
end
local curBlood=self:getLightningDiscipleBlood()
local totalTimes=self:getLightningTotalTimes()
local attachDamage=0
if lightningNum==9 and not self:getLightningResult()then
attachDamage=curBlood*(math.random(5,8)/100)+curBlood
end
return(totalTimes-lightningNum+1)*curBlood/self.data.damgeCof+attachDamage
end


function FeiShengTaiModel:setSuccessRateBrokeBefore(successRate)
self.data.successRateBrokeBefore=successRate
end


function FeiShengTaiModel:getSuccessRateBrokeBefore()
return self.data.successRateBrokeBefore or 0
end


function FeiShengTaiModel:initLightningDiscipleBlood(guid)
self.data.lightningBlood=UIDiscipleModel:getDiscipleAttrByType(guid,eAttributeType.eHP)
self.data.lightningMaxBlood=self.data.lightningBlood
end


function FeiShengTaiModel:setLightningDiscipleBlood(damage)
self.data.lightningBlood=self.data.lightningBlood-damage
end

function FeiShengTaiModel:getLightningDiscipleMaxBlood()
return self.data.lightningMaxBlood
end

function FeiShengTaiModel:getLightningDiscipleBlood()
return self.data.lightningBlood
end


function FeiShengTaiModel:initLightningTimes()
local successRateBrokeBefore=self:getSuccessRateBrokeBefore()
local totalTimes,p=self:getLightningTimes(successRateBrokeBefore)
self.data.lightningTotalTimes=totalTimes
self.data.lightningTimes=0
self.data.damgeCof=p
end


function FeiShengTaiModel:addLightningTimes()
if self.data.lightningTimes<self.data.lightningTotalTimes then
self.data.lightningTimes=self.data.lightningTimes+1
end
end


function FeiShengTaiModel:getCurLightningTimes()
return self.data.lightningTimes
end


function FeiShengTaiModel:getLightningTotalTimes()
return self.data.lightningTotalTimes
end



function FeiShengTaiModel:canFeiSheng(guid)
return UIDiscipleModel:checkJJNeedNonAutoBroke(guid)
end


function FeiShengTaiModel:haveLightningDisciple()
if self.data.lightningDisciple~=nil then
local bt=discipleStateManager:getActiveBehaviorTree(self.data.lightningDisciple)
if bt then
local val=bt:getSharedVar(behaviorConfig.stateIdKey)
if val~=eBtState.duJie then
self.data.lightningDisciple=nil
end
end
end
return self.data.lightningDisciple~=nil
end

function FeiShengTaiModel:isFeiShengSpeciality(specialityType,id)
local specialityList=FeiShengTaiModel.getFeiShengTaiSpecialityList()
for _,v in ipairs(specialityList)do
if specialityType==v[1]and id==v[2]then
return true
end
end
return false
end


function FeiShengTaiModel:isBuildingRepaired()

local sfId=zongmenModel:getMountainId()
local data=zongmenModel:findBuildingDataByType(sfId,SLG_SYSTEM_TYPE.eFeiShengTai)
if data then


local status=zongmenModel:getRepairStatusById(sfId,data.un_build_id)
return status==repairStatus.eRepaired
end
return false
end

function FeiShengTaiModel:getSelectHuDaoFuItemId()
if self.data.selectHuDaoFuItemId then
return self.data.selectHuDaoFuItemId
end

return nil
end

function FeiShengTaiModel:setSelectHuDaoFuItemId(itemId)
self.data.selectHuDaoFuItemId=itemId
end


function FeiShengTaiModel:checkBagHasHuDaoFuByFloor(floor)
local bagHuDaoFuList=itemsLookup:getItemsByBag(item_funtion_type.huDaoFu)
if bagHuDaoFuList and next(bagHuDaoFuList)then

for k,v in pairs(bagHuDaoFuList)do
local stage=v.stage or 0
local needFloorList=FeiShengTaiModel.getHuDaoFuRetainJJFloor(stage)
if needFloorList and needFloorList[floor]==1 then

return true
end
end
end

return false
end

function FeiShengTaiModel:setAlphaIdId(AlphaId)
self.AlphaId=AlphaId
end

function FeiShengTaiModel:setId(bt,stId)
self.treeId=bt
self.stId=stId
end

function FeiShengTaiModel:getId()
return self.treeId,self.stId,self.AlphaId
end

function FeiShengTaiModel:setEffectId(effectId)
self.effectId=effectId
end

function FeiShengTaiModel:getEffectId()
return self.effectId
end

function FeiShengTaiModel:setChangeData(effectType,temp,effectData)
self.effectType=effectType
self.effectData=temp
end

function FeiShengTaiModel:getChangeData()
return self.effectType,self.effectData
end

function FeiShengTaiModel:saveDzOldData(guid)
local attrsShow={1,3,2,4}
local attrlist=UIDiscipleModel:getDiscipleMultipleAttrListByType(guid,attrsShow,true)

if not self.oldData then self.oldData={}end
self.oldData.guid=guid
self.oldData.attrlist=attrlist
end

function FeiShengTaiModel:getDzOldData()
return self.oldData
end
