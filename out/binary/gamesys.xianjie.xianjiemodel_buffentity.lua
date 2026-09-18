
local _tempTable={}
local _lookupEntity={}
local _cacheList={}
local _len=10
local _tickTimer

function xianjieModel:onUpdate_buffEntity()
local len=_len
if#_cacheList>0 and len>0 then
len=len-1
local v=_remove(_cacheList,1)
local entData=xianjieController:getXJClass(v)
if entData then
xianjieModel:handleBuffList_OnUpdate(entData)
xianjieModel:updateEntityBuff(entData)
end
else
local stamp=timeHelper.getServerShortTime()
if self.nextStamp and self.nextStamp>stamp then return end
self.nextStamp=stamp+1

for i,v in pairs(_lookupEntity)do
_cacheList[#_cacheList+1]=i
end
end
end

function xianjieModel:onEnterMap_buffEntity()
xianjieModel:onReset_buffEntity()
xianjieModel:startTick()
end

function xianjieModel:onLeaveMap_buffEntity()
xianjieModel:onReset_buffEntity()
end

function xianjieModel:onLeaveState_buffEntity()
xianjieModel:onReset_buffEntity()
end

function xianjieModel:onReset_buffEntity()
_tempTable={}
_lookupEntity={}
_cacheList={}
xianjieModel:stopTick()
end

function xianjieModel:startTick()
if _tickTimer==nil then
_tickTimer=timer.new()
_tickTimer:start(0.1,function()
xianjieModel:onUpdate_buffEntity()
end)
end
end

function xianjieModel:stopTick()
if _tickTimer then
_tickTimer:cancel()
_tickTimer=nil
end
end

local _effectHandle=
{
[xjDataType.eZongMen]=
{
[xjBuffEffectType.eFangHuZhao]=
{
func=function(...)
xianjieModel:refreshEntityFangHuZhaoBuff(...)
end,
},
[xjBuffEffectType.eAttrJiaCheng]=
{
ignore=true,
},
[xjBuffEffectType.eDisableFangHuZhao]={
func=function(...)
xianjieModel:refreshEntityDisableFangHuZhaoBuff(...)
xianjieModel:refreshEntityDisableInvisibleBuff(...)
end,
},
[xjBuffEffectType.eKillMonsterRewardUp]={
func=function(...)

end,
},
[xjBuffEffectType.eAddYunZhouBingLimit]=
{
ignore=true,
},
[xjBuffEffectType.eBanMoveZongMen]=
{
ignore=true,
func=function(...)
xianjieModel:refreshEntityBanMoveZongMenBuff(...)
end,
},
[xjBuffEffectType.eAttrAttackLeader]={
ignore=true,
},
[xjBuffEffectType.eAttrAttackXianXu]={
ignore=true,
},
[xjBuffEffectType.eZongMenInvisible]=
{
func=function(...)
xianjieModel:refreshEntityInvisibleBuff(...)
end,
},
[xjBuffEffectType.eCanNotTanChaAndFangZhu]={
ignore=true,
},
[xjBuffEffectType.eBanFangZhuZongMen]={
ignore=true,
},
[xjBuffEffectType.eBanJinGuZongMen]={
ignore=true,
},
[xjBuffEffectType.eLongweiShenDunBuff]=
{
func=function(...)
xianjieModel:refreshEntityTianShuShenDunBuff(...)
end,
},
[xjBuffEffectType.eZaieBuQinBuff]=
{
func=function(...)
xianjieModel:refreshEntityTianShuShenDunBuff(...)
end,
},
[xjBuffEffectType.eFangshouJunZhenAttr]=
{
ignore=true,
},
[xjBuffEffectType.eYunZhouAttrJiaChengNotJiJie]={
ignore=true,
},
[xjBuffEffectType.eYunZhouAttrJiaChengMoJun]={
ignore=true,
},
[xjBuffEffectType.eMoJieShiLiSkillLight]=
{
ignore=true,
},
[xjBuffEffectType.eCantLeaveSafeArea]=
{
ignore=true,
},
[xjBuffEffectType.eMJSLSkillPengLaiAdd]=
{
func=function(...)

xianjieModel:refreshEntitySkillPengLaiAddBuff(...)
end,
},
[xjBuffEffectType.eMJSLSkillAddIcon]=
{
func=function(...)

xianjieModel:refreshEntitySkillAddIcon(...)
end,
},
[xjBuffEffectType.eMJSLSkillJiuYuanAdd]=
{
func=function(...)


end,
},
[xjBuffEffectType.eFaZeAdd]=
{
ignore=true,
},



[xjBuffEffectType.eMingYueMoJun]=
{
ignore=true,
},
[xjBuffEffectType.eMoJieZhenYan_Big]=
{
ignore=true,
},

}
}
for type=xjBuffEffectType.eEntityAttrTypeHead+1,xjBuffEffectType.eEntityAttrTypeHead+xjServerEnityType.eEnumMax do
_effectHandle[xjDataType.eZongMen][type]={ignore=true}
end


local _buffListUse={
[xjDataType.eZongMen]=true,
}
local _buffShowType={
eSpine=1,
}
local _buffHandle={
[_buffShowType.eSpine]=function(entData,buffid,showParam,flBuffInfo)
local ent_key=entData:getEntityKey()
if ent_key then
local nowTime=timeHelper.getServerShortTime()
if flBuffInfo and(flBuffInfo.endsec<=0 or nowTime<flBuffInfo.endsec)then

xianjieController:invokeEntityFunc(ent_key,"showSpineBuffEffect",buffid,showParam)
else

xianjieController:invokeEntityFunc(ent_key,"hideBuffEffect",buffid)
end
end
end,
}


function xianjieModel:initBuffData(entData)
local entityType=entData.dataType
if _effectHandle[entityType]==nil then return end

if entData.buffInfo==nil then
entData.buffInfo={}
else
table.clear(entData.buffInfo)
end

if entData.buffList_lookup==nil then
entData.buffList_lookup={}
else
table.clear(entData.buffList_lookup)
end

local buffInfo=entData.buffInfo
local buffList_lookup=entData.buffList_lookup

local oldlist=entData.buffList
if oldlist==nil then return end
local stamp=timeHelper.getServerShortTime()
local entId=entData:getID()

for i,v in ipairs(oldlist)do
local buffid=v.buffid
local endsec=v.endsec
local always=endsec==0
local counting=endsec>stamp
local alive=always or counting
if alive then

buffList_lookup[buffid]=v

if _lookupEntity[entId]==nil and counting then _lookupEntity[entId]=true end

local effects=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffid,'effects')
for _,effect in ipairs(effects)do
local effecttype=effect[1]
buffInfo[effecttype]=endsec
end
end
end
end


function xianjieModel:handleBuffList_OnCreate(entData)
local entityType=entData.dataType
if not _buffListUse[entityType]then return end
local buffList=entData.buffList or{}

for i,v in ipairs(buffList)do
self:handleBuffItem(entData,v.buffid,v)
end
end


function xianjieModel:refreshEntityBuff(entData,newData)
local entityType=entData.dataType
if _effectHandle[entityType]==nil then return end

local oldlist=entData.buffList or{}
entData.buffList=newData.buffList
entData.bufflistlen=newData.bufflistlen
local entId=entData:getID()
_lookupEntity[entId]=nil

local temp={}
local oldlookup={}
for i,v in ipairs(oldlist)do
oldlookup[v.buffid]=v.endsec
end

local newlist=newData.buffList or{}
local dataHandle=_effectHandle[entityType]
local stamp=timeHelper.getServerShortTime()

for i,v in ipairs(newlist)do
local buffid=v.buffid
local endsec=v.endsec
local always=endsec==0
local counting=endsec>stamp
local alive=always or counting

temp[buffid]=true
if _lookupEntity[entId]==nil and counting then _lookupEntity[entId]=true end


local oldEndsec=oldlookup[buffid]
local oldAlive=oldEndsec~=nil
local aliveChanged=oldAlive~=alive
local changeType=oldEndsec~=endsec and CHANGE_TYPE.eChanged or nil
if aliveChanged then
if oldAlive then
changeType=CHANGE_TYPE.eDelete
else
changeType=CHANGE_TYPE.eAdd
end
end
xianjieModel:handleEntityEffect(entData,buffid,endsec,dataHandle,stamp,changeType)
end

for i,v in ipairs(oldlist)do
local buffid=v.buffid
if not temp[buffid]then
xianjieModel:handleEntityEffect(entData,buffid,0,dataHandle,stamp,CHANGE_TYPE.eDelete)
end
end
end

function xianjieModel:handleEntityEffect(entData,buffid,endsec,dataHandle,stamp,changeType)
if changeType==nil then return end
local buffInfo=entData.buffInfo
local alive=endsec==0 or endsec>stamp
local effects=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffid,'effects')
for _,effect in ipairs(effects)do
local effecttype=effect[1]

if alive then
buffInfo[effecttype]=endsec
else
buffInfo[effecttype]=nil
end

local handle=dataHandle[effecttype]
if handle then
if not xianjieModel:isBuffShieldedInScene(effecttype)then
if not handle.ignore and handle.func then
handle.func(entData,alive and endsec or 0,changeType)
end
end
else
loggerUtil.debugErrFMT('暂未支持添加效果类型：{0},buffid：{1}',effecttype,buffid)
end
end

end

function xianjieModel:handleBuffList_OnRefresh(entData,newData)
local entityType=entData.dataType
if not _buffListUse[entityType]then return end
local oldlist=entData.buffList or{}
local newlist=newData.buffList or{}

local oldlookup={}
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(oldlist)do
if v.endsec==0 or v.endsec>nowTime then
oldlookup[v.buffid]=true
end
end
local newLookup={}
for i,v in ipairs(newlist)do
if v.endsec==0 or v.endsec>nowTime then
newLookup[v.buffid]=true
if not oldlookup[v.buffid]then
self:handleBuffItem(entData,v.buffid,v)
end
end
end

for i,v in ipairs(oldlist)do
if not newLookup[v.buffid]then

self:handleBuffItem(entData,v.buffid,nil)
end
end
end

function xianjieModel:updateEntityBuff(entData)
local entityType=entData.dataType
if _effectHandle[entityType]==nil then return end
if entData.buffInfo==nil then return end
if next(entData.buffInfo)==nil then return end

local stamp=timeHelper.getServerShortTime()
local buffInfo=entData.buffInfo
local dataHandle=_effectHandle[entityType]
local buffList=entData.buffList

if buffList then
for i=#buffList,1,-1 do
local buff=buffList[i]
local buffid=buff.buffid
local endsec=buff.endsec
if endsec~=0 and endsec<=stamp then
_remove(buffList,i)
end
end
end

local alive=nil
for effecttype,endsec in pairs(buffInfo)do
local handle=dataHandle[effecttype]
if endsec~=0 and endsec<=stamp then
_tempTable[#_tempTable+1]=effecttype
else
alive=true
end
end

if#_tempTable>0 then
for _,effecttype in ipairs(_tempTable)do
buffInfo[effecttype]=nil
local handle=dataHandle[effecttype]
if handle and handle.func then
handle.func(entData,0,CHANGE_TYPE.eDelete)
end
end
table.clear(_tempTable)

local entId=entData:getID()
_lookupEntity[entId]=alive
end
end

function xianjieModel:handleBuffList_OnUpdate(entData)
local entityType=entData.dataType
if not _buffListUse[entityType]then return end
local buffList=entData.buffList or{}

for i,v in ipairs(buffList)do
if v.endsec>0 then
self:handleBuffItem(entData,v.buffid,v)
end
end
end

function xianjieModel:handleBuffItem(entData,buffid,flBuffInfo)
local buffCfg=cfgHelper.get1(cfg_fairylandbuffconfig_get,buffid)

if buffCfg.buffShow then
local showType=buffCfg.buffShow[1]
local showParam=buffCfg.buffShow[2]
local showHandle=_buffHandle[showType]
if showHandle then

showHandle(entData,buffid,showParam,flBuffInfo)
end
end
end


function xianjieModel:createEntityBuff(entData)
local entityType=entData.dataType
if _effectHandle[entityType]==nil then return end

local buffInfo=entData.buffInfo
if buffInfo==nil then return end

local dataHandle=_effectHandle[entityType]
local stamp=timeHelper.getServerShortTime()
local entId=entData:getID()
_lookupEntity[entId]=nil

local remove={}
for effecttype,endsec in pairs(buffInfo)do

if _lookupEntity[entId]==nil and endsec>stamp then
_lookupEntity[entId]=true
end

local alive=endsec>stamp or endsec==0
if alive then
if not xianjieModel:isBuffShieldedInScene(effecttype)then
local handle=dataHandle[effecttype]
if handle then
if not handle.ignore and handle.func then
handle.func(entData,endsec,CHANGE_TYPE.eInit)
end
else
loggerUtil.debugErrFMT('暂未支持添加效果类型：{0}',effecttype)
end
end
else
remove[#remove+1]=effecttype
end
end

for _,effecttype in ipairs(remove)do
local handle=dataHandle[effecttype]
if handle then
if not handle.ignore and handle.func then
handle.func(entData,0,CHANGE_TYPE.eDelete)
end
else
loggerUtil.debugErrFMT('暂未支持添加效果类型：{0}',effecttype)
end
end
end



function xianjieModel:refreshEntityFangHuZhaoBuff(entData,endsec,changeType)
xianjieController:onAddZongmenTianShuDaZhen(entData,endsec,changeType)
end


function xianjieModel:refreshEntityDisableFangHuZhaoBuff(entData,endsec,changeType)
xianjieController:onAddZongmenDisableTianShuDaZhen(entData,endsec,changeType)
end


function xianjieModel:refreshEntityTianShuShenDunBuff(entData,endsec,changeType)
xianjieController:onAddZongmenTianShuShenDun(entData,endsec,changeType)
end


function xianjieModel:refreshEntityZaieBuQinBuff(entData,endsec,changeType)
xianjieController:onAddZongmenZaieBuQin(entData,endsec,changeType)
end

function xianjieModel:refreshEntityBanMoveZongMenBuff(entData,endsec,changeType)
xianjieController:onAddBanMoveZongMenBuff(entData,endsec,changeType)
end



function xianjieModel:refreshEntityInvisibleBuff(entData,changeType)
xianjieController:onRefreshZongmenInvisibleEffect(entData,changeType)
end

function xianjieModel:refreshEntityDisableInvisibleBuff(entData,endsec,changeType)
xianjieController:onAddZongmenDisableInvisibleEffect(entData,endsec,changeType)
end


function xianjieModel:refreshEntitySkillPengLaiAddBuff(entData,changeType)
xianjieController:onRefreshSkillPengLaiAddEffect(entData,changeType)
end

function xianjieModel:refreshEntitySkillAddIcon(entData,changeType)
xianjieController:onRefreshSkillAddIcon(entData,changeType)
end

function xianjieModel:refreshEntitySkillJiuYuanAddBuff(entData,changeType)
xianjieController:onRefreshSkillJiuYuanAddEffect(entData,changeType)
end
