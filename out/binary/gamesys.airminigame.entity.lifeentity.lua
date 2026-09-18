lifeEntity=simple_class(baseEntity)

local _remove=table.remove

function lifeEntity:initialize(args)
lifeEntity._base.initialize(self,args)


self.allbuffLookup={}
self.buffLookup={}
self.buffTypeLookup={}
self.buffGroups={}
self.buffConverGroups={}
self.buffDelayList={}
self.buffSameConver={}
self.buffCheckList={}
self.chixuDamage={}
self.curAttrs={}

self.buffEntity={}
self.reflectStamp=nil
self.roleCommonCfg=cfg_airroleconfig_get(1)
self.commonCfg=cfg_aircommonconfig_get(1)
self.reflectCD=self.commonCfg.reflectCD
self.buffStatus={}
self.hpChangeAttrsLookup={}
self.convertAttrsLookup={}
self.addDamageAttrsLookup_P={}
self.attrTopLimit={}
self.buffCaster={}
self.addWeaponAttrsLookup={}
self.addSummonAttrsLookup={}

self.summonLookup={}
self.summonHandleLookup={}
self.chixuSkill={}

self:setIdle(true)
end

function lifeEntity:onDelete()
if self==nil or self:isDeleteSelf()then return end

if self.summonLookup then
for _,v in pairs(self.summonLookup)do
for _,ent in pairs(v)do
ent:deleteEntity()
end
end
end
self.summonLookup=nil

if self.buffCaster then
local temp={}
for _,caster in pairs(self.buffCaster)do
if airSkillSystem:isReplaceEntity(caster)then
temp[#temp+1]=caster
end
end

for _,caster in ipairs(temp)do
caster:deleteEntity()
end
end
self.buffCaster=nil

lifeEntity._base.onDelete(self)

self.allbuffLookup=nil
self.buffLookup=nil
self.buffTypeLookup=nil
self.buffGroups=nil
self.buffConverGroups=nil
self.buffDelayList=nil
self.buffCheckList=nil
self.buffSameConver=nil

self.isIdleStatus=nil
self.chixuDamage=nil
self.buffEntity=nil
self.reflectStamp=nil
self.buffStatus=nil
self.hpChangeAttrsLookup=nil
self.convertAttrsLookup=nil
self.addDamageAttrsLookup_P=nil
self.attrTopLimit=nil
self.addWeaponAttrsLookup=nil
self.addSummonAttrsLookup=nil

self.summonLookup=nil
self.summonHandleLookup=nil
self.chixuSkill=nil
end

function lifeEntity:onUpdate()
lifeEntity._base.onUpdate(self)
self:checkBuffFinish()
self:checkDelayOpenBuff()
end

function lifeEntity:onFastUpdate()
lifeEntity._base.onFastUpdate(self)
end

function lifeEntity:deleteEntity()
if self:isDeleteSelf()then return end
airSkillSystem:removeChixuDamageEntity(self)
lifeEntity._base.deleteEntity(self)
end


function lifeEntity:getAttrs()
return self.curAttrs
end

function lifeEntity:clampTopAttr(attributeCfg,value)
if attributeCfg.limitTopAttr then
local top=self:getAttrValue(attributeCfg.limitTopAttr)
value=math.min(top,value)
end
return value
end

function lifeEntity:clampAttr(attributeType,value)
local cfg=cfg_airattributesconfig_get(attributeType)
if cfg.limitTop then
local newTop=self.attrTopLimit[attributeType]or cfg.limitTop
local top=math.max(newTop,cfg.limitTop)
value=math.min(value,top)
end
if cfg.limitBottom then
value=math.max(value,cfg.limitBottom)
end
return value
end

function lifeEntity:getClampAttrTop(attributeType)
local cfg=cfg_airattributesconfig_get(attributeType)
if cfg.limitTop then
local newTop=self.attrTopLimit[attributeType]or cfg.limitTop
local top=math.max(newTop,cfg.limitTop)
return top
end
return nil
end



function lifeEntity:addBuff(buffid,level,delayType,time,caster,levelClear)
if self:isDeleteSelf()then return end

if caster and
self.entityType==eAirEntityType.TYPE_ROLE and
caster.handle~=self.handle and
not levelClear then
loggerUtil.logErrFMT('角色每一波结束保存的buff释放对象一定是角色')
return-1,0
end

if delayType and not self:checkDelayBuff(delayType,time)then
self:addDelayBuff(buffid,level,delayType,time,caster,levelClear)
return-1,1
end

local buffCfg=cfg_airbuffconfig_get(buffid)
local coverType=buffCfg.coverType
local buffType=buffCfg.buffType
if coverType==1 then
local has=airBuffSystem:hasBestBuff(self,self.buffTypeLookup,self.buffLookup,buffid,level)
if has then return-1,2 end

local list=self.buffTypeLookup[buffType]
if list and#list>0 then
for i=#list,1,-1 do
self:removeBuff(list[i])
end
end
elseif coverType==2 then
if self:hasSameTypeBuff(buffType)then return-1,3 end
elseif coverType==3 then
local ret,buffguid=self:hasSameBuff(buffid)
if ret then
self:removeBuff(buffguid)
end
elseif coverType==0 then
local coverGroup=buffCfg.coverGroup
if coverGroup and coverGroup>0 then
return self:converGroupBuff(buffid,level,coverGroup,caster,levelClear)
else
return self:converSameBuff(buffid,level,caster,levelClear)
end
end
return self:addRealBuff(buffid,level,caster,levelClear)
end

function lifeEntity:removeBuff(buffguid)
local buffInfo=self.allbuffLookup[buffguid]
if buffInfo==nil then return end
self.allbuffLookup[buffguid]=nil

local buffid=buffInfo.buffid

self:removeRealBuff(buffguid)


self:removeConverGroupBuffByGUID(buffguid)


self:removeSameBuffByGUID(buffguid,buffid)


local buffCfg=cfg_airbuffconfig_get(buffid)
local groupId=buffCfg.groupId
if groupId then
local groups=self.buffGroups[groupId]
if groups and#groups>0 then
for i=#groups,1,-1 do
local buffguid_=groups[i]
self:removeRealBuff(buffguid_)
self:removeConverGroupBuffByGUID(buffguid_)
end
end
self.buffGroups[groupId]=nil
end


self:effectAllBestConverGroupBuff()

self:effectAllConverSameBuff()
end

function lifeEntity:addDelayBuff(buffid,level,delayType,time,caster,levelClear)
if caster and caster.handle~=self.handle then
loggerUtil.debugErrFMT('暂未支持持续buff回溯对象延迟触发')
caster=nil
end
local casterSelf=caster and caster.handle~=self.handle or false
self.buffDelayList[#self.buffDelayList+1]={
buffid=buffid,
level=level,
delayType=delayType,
delayTime=time,
levelClear=levelClear,
caster=caster,
casterSelf=casterSelf
}
end

function lifeEntity:addRealBuff(buffid,level,caster,levelClear)
local GUID=airBuffSystem:getBuffGUID()
local buffInfo={buffguid=GUID,buffid=buffid,level=level}
self:addBuffStartInfo(buffInfo,caster,levelClear)
self.allbuffLookup[GUID]=buffInfo
return self:addRealBuffInfo(buffInfo)
end

function lifeEntity:addRealBuffInfo(buffInfo)
local buffid=buffInfo.buffid
local level=buffInfo.level
local GUID=buffInfo.buffguid
local buffCfg=cfg_airbuffconfig_get(buffid)
self:addGroupBuff(GUID,buffCfg.groupId)
self:addBuffType(GUID,buffCfg.buffType)
self.buffLookup[GUID]=buffInfo
if buffCfg.duration>0 then
self.buffCheckList[#self.buffCheckList+1]=buffInfo
end

airBuffSystem:addBuffEffect(self,buffInfo)



if buffCfg.addEffectID then
local effectArgs=buffCfg.addEffectID
local effectId=effectArgs[1]
local offset=effectArgs[2]or{0,0,0}
local attach=effectArgs[3]==1
self:playEffect(effectId,Vector3.New(offset[1],offset[2],offset[3]),attach)
end
return GUID
end

function lifeEntity:removeRealBuff(buffguid)
if buffguid==nil then return end
if self.buffLookup[buffguid]==nil then return end
local buffInfo=self.buffLookup[buffguid]
self.buffLookup[buffguid]=nil

local buffid=buffInfo.buffid
local buffguid=buffInfo.buffguid
local buffCfg=cfg_airbuffconfig_get(buffid)

self:removeBuffType(buffguid,buffCfg.buffType)

self:removeCheckBuffList(buffguid)

local caster=self:getBuffCaster(buffInfo,true)
if caster and airSkillSystem:isReplaceEntity(caster)then
caster:deleteEntity()
self.buffCaster[buffguid]=nil
end

airBuffSystem:removeBuffEffect(self,buffInfo)


return buffInfo
end

function lifeEntity:removeRealBuffByBuffId(buffid)
if buffid==nil then return end
local dele={}
for buffid_,v in pairs(self.buffLookup)do
if buffid_==buffid then
dele[#dele+1]=v
end
end
for i=#dele,1,-1 do
self:removeRealBuff(dele[i].buffguid)
end
end

function lifeEntity:getBuffInfo(buffguid)
return self.allbuffLookup[buffguid]
end


function lifeEntity:getUsedBuffInfo(buffguid)
return self.buffLookup[buffguid]
end

function lifeEntity:useBuffList(buffguids)
if buffguids==nil then return end
for buffguid,_ in pairs(buffguids)do
self:useBuffInfo(buffguid)
end
end

function lifeEntity:useBuffInfo(buffguid)
if buffguid==nil then return end
local buffInfo=self:getBuffInfo(buffguid)
if buffInfo then
local buffid=buffInfo.buffid
local buffCfg=cfg_airbuffconfig_get(buffid)
local interval=buffCfg.interval
if interval>0 then
local durationType=buffCfg.durationType
if durationType==1 then
buffInfo.useTime=airController:getRealServerTime_short()
elseif durationType==2 then
buffInfo.useTime=airLevelSystem:getCurLevelIdx()
end
end

local times=buffCfg.times
if times then
buffInfo.times=(buffInfo.times or 0)+1
end







end
end

function lifeEntity:addGroupBuff(buffguid,groupId)
if groupId==nil then return end
if self.buffGroups[groupId]==nil then self.buffGroups[groupId]={}end
local list=self.buffGroups[groupId]
for _,v in ipairs(list)do
if buffguid==v then
return
end
end
list[#list+1]=buffguid
end

function lifeEntity:addBuffType(buffguid,buffType)
if self.buffTypeLookup[buffType]==nil then self.buffTypeLookup[buffType]={}end
local list=self.buffTypeLookup[buffType]
for _,v in ipairs(list)do
if buffguid==v then
return
end
end
list[#list+1]=buffguid
end


function lifeEntity:converSameBuff(buffid,level,caster)
if self.buffSameConver[buffid]==nil then self.buffSameConver[buffid]={}end

local buffCfg=cfg_airbuffconfig_get(buffid)
local list=self.buffSameConver[buffid]


local GUID=airBuffSystem:getBuffGUID()
local buffInfo={buffguid=GUID,buffid=buffid,level=level}
self:addBuffStartInfo(buffInfo,caster)
list[#list+1]=buffInfo
self.allbuffLookup[GUID]=buffInfo

local layer=self:getSameBuffLayer(buffid)
if layer<=buffCfg.effectOverlay then
self:addRealBuffInfo(buffInfo)
end
return GUID
end


function lifeEntity:effectAllConverSameBuff()
local groups={}
for buffid,_ in pairs(self.buffSameConver)do
groups[#groups+1]=buffid
end

if#groups>0 then
for i=#groups,1,-1 do
self:effectConverSameBuff(groups[i])
end
end
end

function lifeEntity:effectConverSameBuff(buffid)
if self.buffSameConver[buffid]==nil then return end
local buffCfg=cfg_airbuffconfig_get(buffid)

local layer=self:getSameBuffLayer(buffid)
local effectOverlay=buffCfg.effectOverlay
if effectOverlay>=layer then
local list=self.buffSameConver[buffid]
for i,v in ipairs(list)do
if not self.buffLookup[v.buffguid]then
layer=layer+1
self:addRealBuffInfo(v)
if effectOverlay<layer then
break
end
end
end
end
end

function lifeEntity:removeSameBuffByGUID(buffguid,buffid)
if buffguid==nil or buffid==nil then return end
local list=self.buffSameConver[buffid]
for i=#list,1,-1 do
local buffInfo=list[i]
if buffInfo.buffguid==buffguid then
_remove(list,i)
break
end
end
end

function lifeEntity:getConverGroupBuffOverlay(buffid,coverGroup)
if self.buffConverGroups[coverGroup]==nil then return 0 end
local layer=0
for _,v in ipairs(self.buffConverGroups[coverGroup])do
if buffid==v.buffid then
layer=layer+1
end
end
return layer
end

function lifeEntity:converGroupBuff(buffid,level,coverGroup,caster)
if self.buffConverGroups[coverGroup]==nil then self.buffConverGroups[coverGroup]={}end

local buffCfg=cfg_airbuffconfig_get(buffid)
local list=self.buffConverGroups[coverGroup]


local GUID=airBuffSystem:getBuffGUID()
local buffInfo={buffguid=GUID,buffid=buffid,level=level}
self:addBuffStartInfo(buffInfo,caster)
list[#list+1]=buffInfo
self.allbuffLookup[GUID]=buffInfo


self:effectBestConverGroupBuff(coverGroup)

return GUID
end

function lifeEntity:removeConverGroupBuff(groupId)
if groupId==nil or groupId<=0 then return end

for coverGroup,list in pairs(self.buffConverGroups)do
for i=#list,1,-1 do
local buffInfo=list[i]
local buffid_=buffInfo.buffid
local groupId_=cfg_airbuffconfig_get(buffid_).groupId
if groupId_==groupId then
_remove(list,i)
end
end
end
end

function lifeEntity:removeConverGroupBuffByGUID(buffguid)
if buffguid==nil then return end

for _,list in pairs(self.buffConverGroups)do
for i=#list,1,-1 do
local buffInfo=list[i]
if buffInfo.buffguid==buffguid then
_remove(list,i)
end
end
end
end


function lifeEntity:effectAllBestConverGroupBuff()
local groups={}
for coverGroup,_ in pairs(self.buffConverGroups)do
groups[#groups+1]=coverGroup
end

if#groups>0 then
for i=#groups,1,-1 do
self:effectBestConverGroupBuff(groups[i])
end
end
end


function lifeEntity:effectBestConverGroupBuff(coverGroup)
local list=self.buffConverGroups[coverGroup]
if#list==0 then return end


local enableList={}
local buffType
for _,v in ipairs(list)do
if self.buffLookup[v.buffguid]then
enableList[#enableList+1]=v.buffguid
end







end

if#enableList>0 then
for i=#enableList,1,-1 do
self:removeRealBuff(enableList[i])
end
end


local lookup=airBuffSystem:addBuffEffectList(self,list)
local bestEffect
local useBuffid
local buffType
for buffid_,effects in pairs(lookup)do
local buffCfg_=cfg_airbuffconfig_get(buffid_)
if bestEffect==nil then
bestEffect=effects
useBuffid=buffid_
else
local canCompare=buffType==buffCfg_.buffType and
airBuffSystem:compareBuffEffect(self,buffType,bestEffect,effects)
if canCompare then
local isBest=airBuffSystem:isBestBuffEffect(self,useBuffid,bestEffect,buffid_,effects,buffCfg_.helpType==1)
if not isBest then
bestEffect=effects
useBuffid=buffid_
end
else
loggerUtil.debugErrFMT('不同类的效果不能放入同一组buff')
end
end
end


for _,v in ipairs(list)do
if v.buffid==useBuffid and not self:isOverrideLayer(useBuffid)then
self:addRealBuffInfo(v)
end
end
end

function lifeEntity:removeBuffType(buffguid,buffType)
if self.buffTypeLookup[buffType]==nil then return end
local list=self.buffTypeLookup[buffType]
for i=#list,1,-1 do
if list[i]==buffguid then
_remove(list,i)
return
end
end
end

function lifeEntity:isOverrideLayer(buffid)
local effectOverlay=cfgHelper.get2(cfg_airbuffconfig_get,buffid,'effectOverlay')
local layer=self:getSameBuffLayer(buffid)
return layer>effectOverlay
end

function lifeEntity:getSameBuffLayer(buffid)
local layer=0
for _,buffInfo in pairs(self.buffLookup)do
if buffInfo.buffid==buffid then
layer=layer+1
end
end
return layer
end

function lifeEntity:hasSameTypeBuff(buffType)
if self.buffTypeLookup[buffType]==nil then return false end
return#self.buffTypeLookup[buffType]>0
end

function lifeEntity:calculationBuffEffectList(buffType,...)
local list=self.buffTypeLookup[buffType]
if list==nil or#list==0 then return{}end
local effectlist={}
for _,buffguid in ipairs(self.buffTypeLookup[buffType])do
local buffInfo=self.buffLookup[buffguid]
if self:checkCanUseBuff(buffInfo)then
local buffid=buffInfo.buffid
local level=buffInfo.level
local buffCfg=cfg_airbuffconfig_get(buffid)
local effect_=airBuffSystem:getBuffEffects(buffCfg,level)
effectlist=airBuffSystem:calculationBuffEffectList(self,buffType,effectlist,buffInfo.buffguid,effect_,...)
end
end
return effectlist
end

function lifeEntity:checkCanUseBuff(buffInfo)
if buffInfo==nil then return false end
local buffid=buffInfo.buffid
local buffCfg=cfg_airbuffconfig_get(buffid)

local interval=buffCfg.interval
local times=buffCfg.times
if times then
local useCnt=buffInfo.times or 0
if useCnt>=times then return false end
end

if interval>0 and buffInfo.useTime then
local durationType=buffCfg.durationType
if durationType==1 then
return airController:getRealServerTime_short()-buffInfo.useTime>=interval
elseif durationType==2 then
return airLevelSystem:getCurLevelIdx()-buffInfo.useTime>=interval
end
end
return true
end

function lifeEntity:hasSameBuff(buffid)
for _,buffInfo in ipairs(self.buffLookup)do
if buffInfo.buffid==buffid then return true,buffInfo.buffguid end
end
return false
end


function lifeEntity:isMaxConverGroup(buffCfg)
local buffType=buffCfg.buffType
if not self:hasSameTypeBuff(buffType)then return true end
end

function lifeEntity:checkDelayOpenBuff()
local len=#self.buffDelayList
if len>0 then
for i=len,1,-1 do
local delayInfo=self.buffDelayList[i]
if self:checkDelayBuff(delayInfo.delayType,delayInfo.delayTime)then
_remove(self.buffDelayList,i)
local caster=delayInfo.casterSelf and self or nil
self:addBuff(delayInfo.buffid,delayInfo.level,nil,nil,caster,delayInfo.levelClear)
end
end
end
end

function lifeEntity:checkDelayBuff(delayType,time)
if delayType==1 then
return time==0 or airController:getRealServerTime_short()>=time
elseif delayType==2 then
return time==0 or airLevelSystem:getCurLevelIdx()>=time
end
return false
end

function lifeEntity:checkBuffFinish()
local len=#self.buffCheckList
if len==0 then return end
local sceneIdx=airLevelSystem:getCurLevelIdx()
local curStamp=airController:getRealServerTime_short()
for i=len,1,-1 do
local buffInfo=self.buffCheckList[i]
local buffid=buffInfo.buffid
local buffguid=buffInfo.buffguid
local buffCfg=cfg_airbuffconfig_get(buffid)
local duration=buffCfg.duration
local stamp=buffInfo.stamp
local index=buffInfo.index
if stamp then
if stamp+duration<=curStamp then
self:removeBuff(buffguid)

end
elseif index then
if index+duration<=sceneIdx then
self:removeBuff(buffguid)

end
end
end
end

function lifeEntity:removeCheckBuffList(buffguid)
local len=#self.buffCheckList
if len==0 then return end
for i=len,1,-1 do
if self.buffCheckList[i].buffguid==buffguid then
_remove(self.buffCheckList,i)
return
end
end
end

function lifeEntity:addBuffStartInfo(buffInfo,caster,levelClear)
local buffid=buffInfo.buffid
local buffCfg=cfg_airbuffconfig_get(buffid)
if buffCfg.durationType==1 then
buffInfo.stamp=airController:getRealServerTime_short()

elseif buffCfg.durationType==2 then
buffInfo.index=airLevelSystem:getCurLevelIdx()

end
buffInfo.levelClear=levelClear

if caster then
local buffguid=buffInfo.buffguid
if caster.handle==self.handle then
buffInfo.casterSelf=true
else
self.buffCaster[buffInfo.buffguid]=caster
end
local handle=caster.handle
if self.buffEntity[handle]==nil then self.buffEntity[handle]={}end
local buffEntityTable=self.buffEntity[handle]
for i,v in ipairs(buffEntityTable)do
if v==buffguid then return end
end
buffEntityTable[#buffEntityTable+1]=buffguid
self:addPostDelete()
end
end

function lifeEntity:getBuffCaster(buffInfo,ignoreSelf)
if buffInfo.casterSelf then
if ignoreSelf then return end
return self
end
return self.buffCaster[buffInfo.buffguid]
end

function lifeEntity:copyBuffCaster(buffInfo,caster)
if buffInfo.casterSelf then return end
local replaceEntity=airEntitySystem:createReplaceEntity(caster,self)
self.buffCaster[buffInfo.buffguid]=replaceEntity
end


function lifeEntity:isWuDi()
return self:hasBuffStatus(eBuffStatus.eWuDi)
end

function lifeEntity:isXuanYun()
return self:hasBuffStatus(eBuffStatus.eXuanYun)
end

function lifeEntity:onWuDi(flag)

end

function lifeEntity:onXuanYun(flag)

end

function lifeEntity:hasBuffStatus(buffStatus)
return self.buffStatus[buffStatus]==true
end

function lifeEntity:setBuffStatus(buffStatus,flag)
local old=self.buffStatus[buffStatus]or false
if old==flag then return end
self.buffStatus[buffStatus]=flag
if buffStatus==eBuffStatus.eXuanYun then
self:onXuanYun(flag)
elseif buffStatus==eBuffStatus.eWuDi then
self:onWuDi(flag)
end
airHUDSystem:setStatus(self.handle,buffStatus,flag)
end

function lifeEntity:onRemoveEntity(handle)
lifeEntity._base.onRemoveEntity(self,handle)
if self.buffEntity and self.buffEntity[handle]then
local entity=airEntitySystem:getEntity(handle)
if entity==nil then
self.buffEntity[handle]=nil
loggerUtil.debugErrFMT('实体已经没了！')
return
end
local buffguidList=self.buffEntity[handle]
local len=#buffguidList
if len>0 then
for i=len,1,-1 do
local buffInfo=self:getBuffInfo(buffguidList[i])
if buffInfo then
self:copyBuffCaster(buffInfo,entity)
else
_remove(buffguidList,i)
end
end
end
if len<=0 then
self.buffEntity[handle]=nil
end
end

self:removeSummon(handle)
end


function lifeEntity:onBuffAddAttr(attrid,value)
if value~=0 then
self:addAttrValue(attrid,value)
end
end

function lifeEntity:onBuffRemoveAttr(buffType,attrid,value)
if value~=0 then
self:addAttrValue(attrid,-value)
end
end


function lifeEntity:getAttr_P(attrid)
return 0
end


function lifeEntity:getExtraAttrValue(attrid)
local addValue=0
addValue=addValue+(self.hpChangeAttrsLookup[attrid]or 0)
addValue=addValue+(self.convertAttrsLookup[attrid]or 0)
addValue=addValue+(self.addDamageAttrsLookup_P[attrid]or 0)
addValue=addValue+(self.addWeaponAttrsLookup[attrid]or 0)
return addValue
end


function lifeEntity:getStoreAllBuff()
local list={}
for buffguid,v in pairs(self.allbuffLookup)do
if not v.levelClear then
local t={}
list[#list+1]=t
t[#t+1]=v.buffguid
t[#t+1]=v.buffid
t[#t+1]=v.stamp or-1
t[#t+1]=v.index or-1
t[#t+1]=v.useTime or-1
t[#t+1]=v.times or-1
end
end
return list
end

function lifeEntity:getStoreBuffLookup()
local list={}
for buffguid,v in pairs(self.buffLookup)do
if not v.levelClear then
list[#list+1]=buffguid
end
end
return list
end

function lifeEntity:getStoreDelayList()
local list={}
for _,v in ipairs(self.buffDelayList)do
if not v.levelClear then
local t={}
list[#list+1]=t
t[#t+1]=v.buffid
t[#t+1]=v.delayType
t[#t+1]=v.delayTime
end
end
return list
end

function lifeEntity:getStoreSameConver()
local lookup={}
for k,v in pairs(self.buffSameConver)do
lookup[k]={}
local t=lookup[k]
for _,vv in ipairs(v)do
if not vv.levelClear then
t[#t+1]=vv.buffguid
end
end
end
return lookup
end

function lifeEntity:getStoreConverGroups()
local lookup={}
for k,v in pairs(self.buffConverGroups)do
lookup[k]={}
local t=lookup[k]
for _,vv in ipairs(v)do
if not vv.levelClear then
t[#t+1]=vv
end
end
end
return lookup
end

function lifeEntity:getStoreChiXuDamages()
local list={}
for _,v in ipairs(self.chixuDamage)do
if not v.levelClear and v.casterSelf then
local t={}
list[#list+1]=v.buffguid
end
end
return list
end

function lifeEntity:convertServerAllBuff(data)
local allbuffLookup={}
if data then
for _,v in ipairs(data)do
local buffguid=v[1]
local buffid=v[2]
local stamp=v[3]
local index=v[4]
local useTime=v[5]
local times=v[6]
local t={}
t.buffguid=buffguid
t.buffid=buffid
t.stamp=stamp~=-1 and stamp or nil
t.index=index~=-1 and index or nil
t.useTime=useTime~=-1 and useTime or nil
t.times=times~=-1 and times or nil
t.level=1
allbuffLookup[buffguid]=t
end
end
return allbuffLookup
end

function lifeEntity:clearCurrentBuffLookup()
local lookup={}
for buffguid,v in pairs(self.buffLookup)do
if not v.levelClear then
lookup[buffguid]=v
end
end
return lookup
end

function lifeEntity:clearCurrentDelayList()
local list={}
for _,v in ipairs(self.buffDelayList)do
if not v.levelClear then
list[#list+1]={
buffid=v.buffid,
level=v.level,
delayType=v.delayType,
delayTime=v.delayTime,
}
end
end
return list
end

function lifeEntity:clearCurrentSameConver()
local lookup={}
for k,v in pairs(self.buffSameConver)do
lookup[k]={}
local t=lookup[k]
for _,vv in ipairs(v)do
if not vv.levelClear then
t[#t+1]=vv
end
end
end
return lookup
end

function lifeEntity:clearCurrentChiXuDamages()
local list={}
for _,v in ipairs(self.chixuDamage)do
if not v.levelClear then
list[#list+1]=v
end
end
return list
end



function lifeEntity:addChiXuDamage(buffInfo)
for i,v in ipairs(self.chixuDamage)do
if v.buffguid==buffInfo.buffguid then return end
end
self.chixuDamage[#self.chixuDamage+1]=buffInfo
airSkillSystem:addChixuDamageEntity(self)
end

function lifeEntity:removeChiXuDamage(buffInfo)
for i,v in ipairs(self.chixuDamage)do
if v.buffguid==buffInfo.buffguid then
_remove(self.chixuDamage,i)
break
end
end
if next(self.chixuDamage)==nil then
airSkillSystem:removeChixuDamageEntity(self)
end
end


function lifeEntity:updateChiXuDamage()
if self.chixuDamage and#self.chixuDamage>0 then
local damage=0
local damage_HP=0
for i=#self.chixuDamage,1,-1 do
local buffInfo=self.chixuDamage[i]
if self:checkCanUseBuff(buffInfo)then
local buffCfg=cfg_airbuffconfig_get(buffInfo.buffid)
local effect=airBuffSystem:getBuffEffects(buffCfg,buffInfo.level)
local damage_,damage_HP_,delete=self:calculationChiXuDamage(effect,buffInfo)
if delete then
_remove(self.chixuDamage,i)
else
damage=damage+damage_
damage_HP=damage_HP+damage_HP_
self:useBuffInfo(buffInfo.buffguid)
end
end
end
local ret=false
if damage>0 then
ret=self:onChiXuDamage(damage)
end

if damage_HP>0 and not self:isDeleteSelf()then
self:onChiXuReduceHP(damage_HP,ret)
end
end
end

function lifeEntity:calculationChiXuDamage(effect,buffInfo)
local attackType=effect[1]
local damage=effect[2]or 0
local addDamage_HP=effect[3]or 0

local addDamage_attack_P=effect[4]or 0
local delete=false
if addDamage_attack_P~=0 then
local caster=self:getBuffCaster(buffInfo)
if caster==nil or caster:isDeleteSelf()then



delete=true
else
local damage_caster=airSkillSystem:getDamageValue(attackType,caster)*addDamage_attack_P/10000
damage=damage+math.ceil(damage_caster)
end
end

if damage<=0 and addDamage_HP<=0 then return 0,0,true end

local finalDamage=damage>0 and damage or 0
return finalDamage,addDamage_HP,delete
end

function lifeEntity:getSkillDamage_P(skillCfg)
local hurtType=skillCfg.hurtType2
if hurtType==eSkillHurtType2.eRange then
return self:getAttrValue(aiAttributeType.eRangeDamage)
elseif hurtType==eSkillHurtType2.ePenetration then
return self:getAttrValue(aiAttributeType.ePenetrationDamage)
end
return 0
end

function lifeEntity:initHpChangeBuff()
local HP=self:getAttrValue(aiAttributeType.eHP,nil,true)
local maxHP=self:getAttrValue(aiAttributeType.eMaxHP,nil,true)
self.hpChangeAttrsLookup={}
self.hpChangeAttrsLookup=airBuffSystem:getHpLimitAttr(self,HP,maxHP)
end

function lifeEntity:initConvertAttr()
self.convertAttrsLookup={}
self.convertAttrsLookup=airBuffSystem:getAllConvertAttrToAttrBuff(self)
end

function lifeEntity:initDamageAttr()
local attrid=aiAttributeType.eAddDamage
self.addDamageAttrsLookup_P[attrid]=0
self.addDamageAttrsLookup_P[attrid]=airBuffSystem:getConvertAttrToDamageBuff(self)
end

function lifeEntity:setAttrTopLimit(attrid,value)
self.attrTopLimit[attrid]=value
end

function lifeEntity:initWeaponHoldAttr()
self.addWeaponAttrsLookup={}
self.addWeaponAttrsLookup=airBuffSystem:getHoldWeaponChangeAttrsBuffAttrs(self)
end

function lifeEntity:initSummonChangeAttr()
self.addSummonAttrsLookup={}
self.addSummonAttrsLookup=airBuffSystem:getOwnerSummonChangeAttrs(self)
end

function lifeEntity:getSummonAddAttr(ent,attrid)
local summonType=airConfig.getSummonType(ent.entityType)
if self.addSummonAttrsLookup[summonType]==nil then return 0 end
return self.addSummonAttrsLookup[summonType][attrid]or 0
end

function lifeEntity:initChiXuSkill()
self.chixuSkill={}
self.chixuSkill=airBuffSystem:getChiXuSkill(self)
end

function lifeEntity:isIdle()
return self.isIdleStatus==true
end

function lifeEntity:setIdle(flag)
if self.isIdleStatus==flag then return end
self.isIdleStatus=flag
airBuffSystem:onEntityIdle(self,flag)
end



function lifeEntity:verifyDamage(entity,skillCfg,damage,damage_P,deductHP_P)
local teamType=entity.teamType
local entityType=entity.entityType
local damage_,damage_P_,deductHP_P_,ignoreDamageLimit=airBuffSystem:getSpecialTargetAddDamage(teamType,entityType)
airSkillSystem:debugSkillDamage('buff增加特定怪物伤害值（buff类型5）：',damage_)
airSkillSystem:debugSkillDamage('buff增加特定怪物伤害万分比（buff类型5）：',damage_P_)
airSkillSystem:debugSkillDamage('buff增加特定怪物直接扣减生命万分比（buff类型5）：',deductHP_P_)
local addSkillValue,addSkillValue_P=airBuffSystem:getSkillAddDamage(self,skillCfg)
airSkillSystem:debugSkillDamage('buff增加技能伤害值（buff类型14）：',addSkillValue)
airSkillSystem:debugSkillDamage('buff增加技能伤害万分比（buff类型14）：',addSkillValue_P)
local addValue_skill_P=self:getSkillDamage_P(skillCfg)
airSkillSystem:debugSkillDamage('buff增加属性伤害提升万分比（buff类型1）：',addValue_skill_P)
damage=damage+damage_+addSkillValue
damage_P=damage_P+damage_P_+addSkillValue_P+addValue_skill_P
deductHP_P=deductHP_P+deductHP_P_
return damage,damage_P,deductHP_P,ignoreDamageLimit
end

function lifeEntity:canIgnoreDamageLimit(entity)
local teamType=entity.teamType
local entityType=entity.entityType
local damage_,damage_P_,deductHP_P_,ignoreDamageLimit=airBuffSystem:getSpecialTargetAddDamage(teamType,entityType)
return ignoreDamageLimit
end

function lifeEntity:printBuff()

end


function lifeEntity:getArmor()
local attributeType=aiAttributeType.eArmor
local armor=self:getAttrValue(attributeType)
local armor_P=self:getAttrValue(aiAttributeType.eArmorReductionDamage)
armor=math.floor(armor*(1+math.abs(armor_P)/10000))
armor=self:clampAttr(attributeType,armor)
local verify=cfgHelper.get2(cfg_airattributesconfig_get,attributeType,'verify')
return armor/(armor+verify)
end

function lifeEntity:isCanTakeDamage()

end

function lifeEntity:onAttack(entity)

end

function lifeEntity:onDamage(damage,isCirtical,caster,ignoreDamageLimit,damageType)
return false
end

function lifeEntity:onChiXuDamage(damage,caster)
if damage>0 then

end
self:onDamage(damage,false,caster,false,eDamageType.eChiXuDamage)
end

function lifeEntity:onChiXuReduceHP(HP_P,forceDamage)
if HP_P>0 then

end
self:onReduceHP(HP_P,forceDamage,eDamageType.eChiXuDamage)
end


function lifeEntity:onReduceHP(HP_P,forceDamage,damageType)
return false
end

function lifeEntity:onDead(ignoreRevive)

end


function lifeEntity:onDodge(entity)

end

function lifeEntity:onRestoreHP(add)

end

function lifeEntity:onStealHP(add)

end

function lifeEntity:onReflect(value)

end

function lifeEntity:onRestoreSelf(add)

end

function lifeEntity:onRestoreHPByDrop(addValue,addValue_P)

end

function lifeEntity:onMissSkillAction(entity,skillid,actionid,isPenetrate)

end

function lifeEntity:isCanReflect()
if self.reflectStamp==nil then return true end
local useStamp=self.reflectStamp+self:getPauseTime()
return Time.realtimeSinceStartup-useStamp>=self.reflectCD
end


function lifeEntity:reflectDamage(damage)
self.reflectStamp=Time.realtimeSinceStartup-self:getPauseTime()
airBuffSystem:reflectDamage(self)
end


function lifeEntity:onWuDiOnDamage()

end


function lifeEntity:onRevive(next)
local max=self:getMaxHP()
next=next or max

self:setHP(max)
if self.entityType==eAirEntityType.TYPE_ROLE then

local buffId=cfgHelper.get(cfg_aircommonconfig_get,1,"reviveBuffId")
local level=1
airBuffSystem:addBuff(self,buffId,level,self)
self:showWuDiBehaiour()
end

airHUDSystem:onRevive(self.handle,max)

local effectId=2136
local scale=Vector3.New(2,2,2)
self:playEffectWithOrder(effectId,Vector3.zero,scale,false,true)
end



function lifeEntity:addSummon(ent)
local summonType=airConfig.getSummonType(ent.entityType)
if self.summonLookup[summonType]==nil then self.summonLookup[summonType]={}end
local summonLookup=self.summonLookup[summonType]
summonLookup[ent.handle]=ent
self.summonHandleLookup[ent.handle]=true
self:addPostDelete()
end

function lifeEntity:removeSummon(handle)
if self.summonHandleLookup[handle]==nil then return end
self.summonHandleLookup[handle]=nil
local ent=airEntitySystem:getEntity(handle)
local summonType=airConfig.getSummonType(ent.entityType)
if self.summonLookup[summonType]==nil then return end
local summonLookup=self.summonLookup[summonType]
summonLookup[handle]=nil
end

