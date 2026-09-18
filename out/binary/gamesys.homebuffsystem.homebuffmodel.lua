




homeBuffModel={}

local _stableVal=0
local _effectList={}
local _effectIdLookup={}
local _effectParams={}

local _allLookup={}
local _allList={}

local _timer=nil
local _freshFlag=false
function homeBuffModel.init()
_stableVal=0
_effectList={}
_allList={}
_allLookup={}
_effectIdLookup={}
_effectParams={}
_freshFlag=false
end

function homeBuffModel.startTimer()
homeBuffModel.stopTimer()
_timer=timer.new()
_timer:start(1,function()
homeBuffModel.update()
end)
end

function homeBuffModel.stopTimer()
if _timer then
_timer:cancel()
end
_timer=nil
end

function homeBuffModel.update()
local len=#_allList
if len>0 then
local stamp=timeHelper.getServerShortTime()
for i=len,1,-1 do
local info=_allList[i]
if info then
local endStamp=info[2]
if endStamp and endStamp>0 and endStamp<=stamp then
homeBuffModel.removeState(info[3])
_freshFlag=true
end
end
end
end
if _freshFlag then
_freshFlag=false
homeBuffControl.sort(_allList)
homeBuffControl.sort(_effectList)
userActorSetting.flush()
homeBuffControl.freshWindow()
end
end




function homeBuffModel.initStateList(list)
_allList={}
_effectList={}
_allLookup={}
_effectIdLookup={}
_effectParams={}
for i,v in ipairs(list or{})do
homeBuffModel.addState(v.param_3,v.param_1,v.param_2,false,v.param_4)
end
homeBuffControl.sort(_effectList)
homeBuffControl.sort(_allList)
homeBuffControl.freshWindow()
end

function homeBuffModel.addState(guid,id,endStamp,flag,src)
local config=cfg_guildstateconfig_get(id)
if config==nil then
loggerUtil.logErrFMT("服务器下发了无配置的宗门状态：{0}",id)
return
end
local stamp=timeHelper.getServerShortTime()
if endStamp>0 and stamp>=endStamp then
loggerUtil.logWarnFMT('服务器发送了已失效的状态:{0}',id)
return
end
if _allLookup[guid]==nil then
homeBuffModel.onAdd(guid,id,endStamp,src)
if flag then
homeBuffModel.addJianWenMesg(id)
end
else
for i,v in ipairs(_allList)do
if v[3]==guid then

v[2]=endStamp
break
end
end
end
if flag then
homeBuffControl.sort(_allList)
homeBuffControl.sort(_effectList)
homeBuffControl.freshWindow(id)
end
end

function homeBuffModel.onAdd(guid,id,endStamp,src)
_allLookup[guid]=true
_allList[#_allList+1]={id,endStamp,guid,src}
homeBuffModel.freshEffectList()
if not homeBuffModel.isReadBuff(guid)then

end
end

function homeBuffModel.freshEffectList()
local temp={}
local sortTag={}
for i,v in ipairs(_allList)do
local id=v[1]
temp[#temp+1]=v
local level=cfg_guildstateconfig_get(id).level
sortTag[id]=level*1000-i
end
table.sort(temp,function(a,b)
return sortTag[a[1]]>sortTag[b[1]]
end)

_effectList={}
_effectParams={}
_effectIdLookup={}
for i,v in ipairs(temp)do
local id=v[1]
local hasHigher=homeBuffModel.hasHigherLevelBuff(id)
if not hasHigher then
_effectList[#_effectList+1]=v
homeBuffConfig.handleBuff(id,_effectParams,true)
_effectIdLookup[id]=true
end
end
end

function homeBuffModel.removeStateById(id,guid)

homeBuffModel.removeState(guid)
homeBuffControl.sort(_allList)
homeBuffControl.sort(_effectList)
end

function homeBuffModel.removeState(guid)
if guid==nil or _allLookup[guid]==nil then return end
local id
for i,v in ipairs(_allList)do
if v[3]==guid then
id=v[1]
table.remove(_allList,i)
break
end
end

if id then
homeBuffModel.freshEffectList()
userActorSetting.flush()
else
loggerUtil.logWarnFMT('buff guid:{0}已删除：',guid)
end
end

function homeBuffModel.getBuffInfo(guid)
for i,v in ipairs(_allList)do
if v[3]==guid then
return v,i
end
end
end

function homeBuffModel.getBuffInfoByIdSrc(id,src)
for i,v in ipairs(_allList)do
if v[1]==id and v[4]==src then
return v,i
end
end
end

function homeBuffModel.setStableVal(val)
_stableVal=val

UIManager:callWindowFunc('UIHomeBuffWin','refreshStableVal')
end

function homeBuffModel.readAllBuff()
local actorid=playerModel:getActorID()
for _,v in ipairs(_allList)do
homeBuffModel.readBuff(v[3],v[1])
end
userActorSetting.flush()
end


function homeBuffModel.readBuff(guid,id)
local key=FMT.fmt('bf_{0}',guid)
if homeBuffModel.isReadBuff(guid)then return end




userActorSetting.set(key,1)
end

function homeBuffModel.isReadBuff(guid)
local key=FMT.fmt('bf_{0}',guid)
return userActorSetting.get(key,0)==1
end

function homeBuffModel.isHasNewBuff()
if not playerModel:checkInit()then return false end
for i,v in ipairs(_allList)do
if not homeBuffModel.isReadBuff(v[3])then
return true,v
end
end
return false
end


function homeBuffModel.isHasEffectBuff(id)
return _effectIdLookup[id]==true
end


function homeBuffModel.hasLowerLevelBuff(id)
local cfg=cfg_guildstateconfig_get(id)
local sametype=cfg.sametype
local curlv=cfg.level
if sametype and sametype==0 then
return false
end
if curlv>1 then
for i=1,curlv-1 do
local cfgids=cfg_lookupguildstateconfig_get(sametype)[i]or{}
for _,v in ipairs(cfgids)do
if homeBuffModel.isHasEffectBuff(v)then return true end
end
end
end
return false
end


function homeBuffModel.hasHigherLevelBuff(id)
local cfg=cfg_guildstateconfig_get(id)
local sametype=cfg.sametype
local curlv=cfg.level
local cfgs=cfg_lookupguildstateconfig_get(sametype)
if sametype and sametype==0 then
return false
end
if cfgs==nil then return false end
for level,cfgids in pairs(cfgs)do
for _,v in ipairs(cfgids)do
if level>curlv and homeBuffModel.isHasEffectBuff(v)then return true end
end
end
return false
end






function homeBuffModel.getBuffAddValue(effectType)
return _effectParams[effectType]
end

function homeBuffModel.getStableValue()
return _stableVal
end

function homeBuffModel.getEffectList()
return _effectList
end

function homeBuffModel.getAllList()
return _allList
end

function homeBuffModel:getBuffDesc(buffId)
local cfg=cfg_guildstateeffectconfig_get(buffId)
return cfg.desc
end

function homeBuffModel:getBuffDuration(duration)

local rate=1+gubaoModel:getGBSkil_FuLuTime()/100
duration=math.floor(duration*rate)
return duration
end

function homeBuffModel:getBuffDescByStateId(id)
local bcfg=cfgHelper.get1(cfg_guildstateconfig_get,id)
local desc=''
for i,v in ipairs(bcfg.effects)do
local ds=homeBuffModel:getBuffDesc(v)
desc=FMT.fmt('{0}\n{1}',desc,ds)
end
desc=string.gsub(desc,'\n','',1)
return desc
end

function homeBuffModel.getStableScaleData()
local stableList=cfgHelper.getglobal1('zmstableval')
local scaleList
for i,v in ipairs(stableList)do
if _stableVal>=v[1]and _stableVal<=v[2]then
scaleList=v
break
end
end
if scaleList==nil then
scaleList=stableList[#stableList]
end
return scaleList
end
function homeBuffModel.addJianWenMesg(id)
local cfg=cfgHelper.get1(cfg_guildstateconfig_get,id)
if cfg.show_jianwen==false then
return
end
local get_type=cfg.get_type
if get_type==1 then



end

local stableVal=homeBuffModel.getStableValue()
chatGGControl.onHomeBuffAdd(id,stableVal)
end
