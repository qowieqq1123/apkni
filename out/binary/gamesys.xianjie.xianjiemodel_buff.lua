
function xianjieModel:clearBuff()
self.buffDataList={}
self.buffDataLookup={}
self.buffEffectLookup={}
self.buffGroupMaxTime=nil
self.buffGroupList={}
self.buffConflictList={}
self.buffConflictMaxLokup={}
self.buffInit=nil
xianjieModel:stopBuffTimer(true)
end


function xianjieModel:initBuff(len,bufflist)
xianjieModel:initGroupCfg()
local oldLookup=nil
if self.buffInit then
oldLookup=table.deepCopy(self.buffDataLookup)
else
oldLookup={}
end
self.buffDataList=bufflist or{}

if len>0 then
local buffDataLookup={}
local buffEffectLookup={}
for _,v in ipairs(bufflist)do
buffDataLookup[v.buffid]=v

local buffCfg=cfg_fairylandbuffconfig_get(v.buffid)
if buffCfg.conflict then
local type=math.floor(buffCfg.conflict/100)
if self.buffConflictList[type]==nil then self.buffConflictList[type]={}end
local list=self.buffConflictList[type]
list[#list+1]=buffCfg.id
end
for _,effect in ipairs(buffCfg.effects)do
local effType=effect[1]
if buffEffectLookup[effType]==nil then buffEffectLookup[effType]={}end
buffEffectLookup[effType][v.buffid]=true
end
end
self.buffDataLookup=buffDataLookup
self.buffEffectLookup=buffEffectLookup
else
self.buffDataLookup={}
self.buffEffectLookup={}
end

local temp={}
if len>0 then
for _,v in ipairs(bufflist)do
temp[v.buffid]=true
local flag=xianjieModel:getIsConflictMaxBuffId(v.buffid)
if flag then
if not oldLookup[v.buffid]then
xianjieModel:addBuffEffect(v.buffid,1,not self.buffInit)
elseif v.endsec~=oldLookup[v.buffid].endsec then
xianjieModel:refreshBuffEffect(v.buffid)
end
end
end
end

for _,v in pairs(oldLookup)do
local flag=xianjieModel:getIsConflictMaxBuffId(v.buffid)
if not temp[v.buffid]or not flag then
xianjieModel:removeBuffEffect(v.buffid)
end
end

if not self.buffInit then
xianjieModel:initBuffs()
end
self.buffInit=true
xianjieModel:startBuffTimer()
end

function xianjieModel:addBuff(buffid,times)
times=times or 1
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
local duration=buffCfg.duration
local isForever=duration<=0
local maxLeft=xianjieModel:getBuffMaxLeftTime(buffid)
if maxLeft and maxLeft<=0 then return end
local add=duration*times
maxLeft=maxLeft and math.min(maxLeft,add)or add
local stamp=timeHelper.getServerShortTime()

if self.buffDataLookup[buffid]then
local old=self.buffDataLookup[buffid].endsec
if old<stamp then old=stamp end
local new=old+maxLeft
if isForever then
self.buffDataLookup[buffid].endsec=0
else
self.buffDataLookup[buffid].endsec=new
end
else
local data={}
data.buffid=buffid
local new=stamp+maxLeft
data.endsec=isForever and 0 or new

self.buffDataLookup[buffid]=data
local list=self.buffDataList
list[#list+1]=data
for _,effect in ipairs(buffCfg.effects)do
local effType=effect[1]
if self.buffEffectLookup[effType]==nil then self.buffEffectLookup[effType]={}end
self.buffEffectLookup[effType][buffid]=true
end
end
if buffCfg.conflict then
local type=math.floor(buffCfg.conflict/100)
if self.buffConflictList[type]==nil then self.buffConflictList[type]={}end
local list=self.buffConflictList[type]
list[#list+1]=buffCfg.id
end

local flag=xianjieModel:getIsConflictMaxBuffId(buffid)
if flag then
xianjieModel:addBuffEffect(buffid)
xianjieModel:startBuffTimer()
end
end

function xianjieModel:removeBuff(buffid)
self.buffDataLookup[buffid]=nil
for i,v in ipairs(self.buffDataList)do
if v.buffid==buffid then
table.remove(self.buffDataList,i)
break
end
end
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
if buffCfg.conflict then
local type=math.floor(buffCfg.conflict/100)
for i,v in ipairs(self.buffConflictList[type])do
if v==buffid then
table.remove(self.buffConflictList[type],i)
if self.buffConflictMaxLokup[type]==buffid then
self.buffConflictMaxLokup[type]=nil
end
break
end
end
end
for _,effect in ipairs(buffCfg.effects)do
local effType=effect[1]
if self.buffEffectLookup[effType]~=nil then
self.buffEffectLookup[effType][buffid]=nil
end
end
xianjieModel:removeBuffEffect(buffid)
xianjieModel:stopBuffTimer()
end

function xianjieModel:initGroupCfg()
if self.buffGroupMaxTime==nil then
self.buffGroupMaxTime={}
self.buffGroupList={}
local cfgs=cfg_fairylandbuffconfig()
for _,v in ipairs(cfgs)do
if v.group then
local group=v.group
if self.buffGroupList[group]==nil then self.buffGroupList[group]={}end
local list=self.buffGroupList[group]
list[#list+1]=v.id
if v.max then
self.buffGroupMaxTime[group]=v.max
end
end
end
end
end

function xianjieModel:getIsConflictMaxBuffId(buffid)
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
local conflict=buffCfg.conflict
if conflict==nil then return true end

local type=math.floor(conflict/100)
local list=self.buffConflictList[type]
if list==nil then return true end

if self.buffConflictMaxLokup[type]then
return self.buffConflictMaxLokup[type]
end

local maxConflict=conflict
local maxBuffId=buffid
for i,v in ipairs(list)do
local buffCfg=cfg_fairylandbuffconfig_get(v)
if buffCfg.conflict>maxConflict then
maxConflict=buffCfg.conflict
maxBuffId=v
end
end
self.buffConflictMaxLokup[type]=maxBuffId
return maxBuffId==buffid
end

function xianjieModel:getGroupLeftTime(group)
if group==nil then return end
local list=self.buffGroupList[group]
if list==nil then return end
local left=0
for i,v in ipairs(list)do
left=left+xianjieModel:getBuffLeftTime(v)
end
return left
end

function xianjieModel:getBuffMaxLeftTime(buffid)
xianjieModel:initGroupCfg()
local cfg=cfg_fairylandbuffconfig_get(buffid)
if cfg.group then
local maxTime=self.buffGroupMaxTime[cfg.group]
if maxTime then
local left=xianjieModel:getGroupLeftTime(cfg.group)
return math.max(0,maxTime-left)
end
end
if cfg.max then
return math.max(0,cfg.max-xianjieModel:getBuffLeftTime(buffid))
end
end

function xianjieModel:onUpdateBuff()
local stamp=timeHelper.getServerShortTime()
local len=#self.buffDataList
if len==0 then return end
for i=len,1,-1 do
local info=self.buffDataList[i]
local left=info.endsec-stamp
if left<=0 and info.endsec>0 then
self.buffDataLookup[info.buffid]=nil
table.remove(self.buffDataList,i)
xianjieModel:removeBuffEffect(info.buffid)
local buffCfg=cfg_fairylandbuffconfig_get(info.buffid)
for _,effect in ipairs(buffCfg.effects)do
local effType=effect[1]
if self.buffEffectLookup[effType]~=nil then
self.buffEffectLookup[effType][info.buffid]=nil
end
end
end
end
xianjieModel:stopBuffTimer()
end

function xianjieModel:startBuffTimer()
if self.buffTimer then return end
if#self.buffDataList==0 then return end
self.buffTimer=timer.new()
local tick=function()
xianjieModel:onUpdateBuff()
end
self.buffTimer:start(1,tick)
end

function xianjieModel:stopBuffTimer(force)
if self.buffTimer==nil then return end
if not force and#self.buffDataList>0 then return end
self.buffTimer:cancel()
self.buffTimer=nil
end

function xianjieModel:getBuffEndStamp(buffid)
if self.buffDataLookup[buffid]then
return self.buffDataLookup[buffid].endsec
end
end


function xianjieModel:getBuffLeftTime(buffid)
if self.buffDataLookup[buffid]then
local endsec=self.buffDataLookup[buffid].endsec
local left=endsec-timeHelper.getServerShortTime()
return math.max(0,left)
end
return 0
end

function xianjieModel:isCanActiveBuff(buffid)
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
local consume=buffCfg.consume
for i,v in ipairs(consume)do
if not itemsModel.checkItemEnough(v[1],v[2])then return false end
end
return true
end

function xianjieModel:isCanShowBuffList()
for _,v in ipairs(self.buffDataList or{})do
local buffid=v.buffid
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
if buffCfg.show then
return true
end
end
local homeBuffList=homeBuffModel.getAllList()
for i,v in ipairs(homeBuffList)do
local guildstateconfig=cfg_guildstateconfig_get(v[1])
if guildstateconfig.isSystemShow==2 then
return true
end
end
return false
end

function xianjieModel:getBuffList()
return self.buffDataList or{}
end

function xianjieModel:getBuffIDsByBuffType(effType)
if self.buffEffectLookup then
local lp=self.buffEffectLookup[effType]
if lp~=nil then
local flag=next(lp)~=nil
if flag==true then
return true,lp
end
end
end
return false,nil
end

function xianjieModel:isBuffShieldedInScene(buffid)
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
if buffCfg and buffCfg.shield_scene then
local curSceneIdx=xianjieModel:getSceneIndex()or 0
return buffCfg.shield_scene[curSceneIdx]==1
end
return false
end


local _baseUpMassSoldierNumBuff=10500
function xianjieModel:getUpMassMaxSoldierNumEffectId(targetEntityType)
return _baseUpMassSoldierNumBuff+targetEntityType
end

function xianjieModel:isActiveBuff(buffID)
if self.buffDataLookup==nil then return false end
local data=self.buffDataLookup[buffID]
if data==nil then return end
if data.endsec==0 then
return true
else
local nowTime=timeHelper.getServerShortTime()
return data.endsec>nowTime
end
end

function xianjieModel:getAvtiveEffectListByEffectID(effectID)
local activeEffectList={}
for index,buffData in ipairs(self.buffDataList)do
local buffID=buffData.buffid
if self:isActiveBuff(buffID)then
local effects=cfgHelper.get(cfg_fairylandbuffconfig_get,buffID,'effects')
if next(effects)then
for index,effectData in ipairs(effects)do
if effectData[1]==effectID then
activeEffectList[#activeEffectList+1]=effectData
end
end
end
end
end
return activeEffectList
end