






local _MODULENAME="tianMoJieModel"


def_table(_MODULENAME)
tianMoJieModel.name=_MODULENAME









local _data={}
local _clientRecordTime=nil
local _recordKey="TianMoJieRecordTime"







local _animData=nil
local _enterAnim=nil
local _animKey="TianMoJieAnimationInfo"
local _lastShare=nil
local _shareKey="TianMoJieLastShareTime"

local _visitorLocate=nil


function tianMoJieModel:onAppStart()

end


function tianMoJieModel:onEnterState(isReconnect)
_animData=userActorSetting.get(_animKey,nil)
if _animData==nil then
_animData={
stage=0,
monsters={},
done=false,
finish=false
}
end

_lastShare=userActorSetting.get(_shareKey,nil)
end


function tianMoJieModel:onProtocolReq()

end


function tianMoJieModel:onLeaveState(isReconnect)

self:resetData()
self:resetMonsterData()
self:resetMonsterAssists()
self:resetPlayerAssists()
self:popFightData()
self:clearVisitorLocate()
end


function tianMoJieModel:resetData()
table.clear(_data)
_animData=nil
_enterAnim=nil
_clientRecordTime=nil
end

function tianMoJieModel:setData(score,flag,daily,sec)
local init=_data.init
local _score=_data.flag

_data.score=score
_data.flag=flag
_data.daily=daily
_data.sec=sec
_data.init=true

self:updateStage()
if init then
if _score~=score then
notifySystem:postNotify(notifyConfig.onTianMoJiejifenChange,_score,score)
end
else
notifySystem:postNotify(notifyConfig.onTianMoJieInit)
end
end

function tianMoJieModel:isInit()
return _data.init
end

function tianMoJieModel:getScore()
return _data.score or-1
end

function tianMoJieModel:getFlag()
return _data.flag or 0
end

function tianMoJieModel:getDaily()
return _data.daily or 0
end

function tianMoJieModel:getSec()
return _data.sec or 0
end

function tianMoJieModel.setSec(sec)
_data.sec=sec
end

function tianMoJieModel:addDaily()
_data.daily=_data.daily+1
end

function tianMoJieModel:clearDaily()
_data.daily=0
end

function tianMoJieModel:setFlag(stage)
_data.flag=stage
end

function tianMoJieModel:calculateStage(score)
local stage=0
if score>=0 then
local stageCfg=cfg_tianmojiestageconfig()
for i,v in ipairs(stageCfg)do
if score<v.score then
return i
end
end
return#stageCfg+1
else
return stage
end
end

function tianMoJieModel:getStage()
return _data.stage or 0
end

function tianMoJieModel:addScore(score)
if self:isOpen()then
_data.score=_data.score+score
self:updateStage()
end
end

function tianMoJieModel:updateStage()
local oStage=_data.stage
_data.stage=self:calculateStage(_data.score)


if oStage~=nil then
oStage=oStage or 0
if _data.stage<=0 then
self:recordAnimData(_data.stage)
notifySystem:postNotify(notifyConfig.onTianMoJieStageChange,oStage,_data.stage)
elseif oStage~=_data.stage then
self:recordAnimData(oStage)
notifySystem:postNotify(notifyConfig.onTianMoJieStageChange,oStage,_data.stage)
end
if oStage<=0 and _data.stage>0 then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.TianMoJieOpen)
end
end












end

function tianMoJieModel:isFinish()
local stage=self:getStage()
local stageCfg=cfg_tianmojiestageconfig()
return stage>#stageCfg
end

function tianMoJieModel:isOpen()
local score=self:getScore()
return score>=0
end

function tianMoJieModel:recordAnimData(oStage)
local actorId=playerModel:getActorID()
local datas=tianMoJieModel:getMonstersByActor(actorId)
local list={}
for i,v in pairs(datas)do
table.insert(list,v.id)
end
_animData.stage=oStage
_animData.monsters=list
_animData.done=false
_animData.finish=false

userActorSetting.set(_animKey,_animData)
userActorSetting.flush()

_enterAnim=oStage<=0
end

function tianMoJieModel:doneAnimData()
_animData.done=true
userActorSetting.set(_animKey,_animData)
userActorSetting.flush()
end

function tianMoJieModel:finishAnimData()
_animData.finish=true
userActorSetting.set(_animKey,_animData)
userActorSetting.flush()
end

function tianMoJieModel:getAnimData()
return _animData
end

function tianMoJieModel:getEnterAnim()
return _enterAnim
end

function tianMoJieModel:clearEnterAnim()
_enterAnim=nil
end

function tianMoJieModel:getRecordTime()
if _clientRecordTime==nil then
_clientRecordTime=userActorSetting.get(_recordKey,0)
end
return _clientRecordTime
end

function tianMoJieModel:saveRecordTime()
_clientRecordTime=timeHelper.getServerShortTime()
userActorSetting.flushVal(_recordKey,_clientRecordTime,0)
end

function tianMoJieModel:checkNewHelp()
local client=self:getRecordTime()
local server=self:getSec()
return server>client
end

function tianMoJieModel:isNewHelp(time)
local client=self:getRecordTime()
return time>client
end

function tianMoJieModel:getShareInterval()
if _lastShare then
local interval=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"shareInterval")
local nowTime=timeHelper.getServerShortTime()
return _lastShare+interval-nowTime
end
return 0
end

function tianMoJieModel:recordShareTime()
_lastShare=timeHelper.getServerShortTime()
userActorSetting.flushVal(_shareKey,_lastShare)
end

function tianMoJieModel:setVisitorLocate(actorId)
_visitorLocate=actorId
end

function tianMoJieModel:checkVisitorLocate(actorId)
if _visitorLocate then
return mathHelper.compareInt64(actorId,_visitorLocate)
end
return false
end

function tianMoJieModel:clearVisitorLocate()
_visitorLocate=nil
end