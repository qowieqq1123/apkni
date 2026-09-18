

















local limitActInfo_lingxuwenjian={name='lingxuwenjian'}


function limitActInfo_lingxuwenjian:onInit()

end


function limitActInfo_lingxuwenjian:onStart()

self.lunList=lingxuwenjianModel:getLunList(self.start_time_l)
self:initCurLunTime()
end

function limitActInfo_lingxuwenjian:initCurLunTime()
local time=nil
local lun=nil
local cur=gameUtilityModel.getServerLongTime()
local max=#self.lunList
for i,d in ipairs(self.lunList)do
local e_t=d[#d]
if cur<e_t then
time=d
lun=i
break
end
end
if time==nil then
time=self.lunList[max]
lun=max
end
self.curLunTime=time
self.curLunIndex=lun
self.raceState=nil
self.fightState=nil


local zhenyanWin_lun=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingXuWenJian,'zhenyanWin_lun',nil)
if not zhenyanWin_lun or zhenyanWin_lun~=self.curLunIndex then
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLingXuWenJian,'zhenyanWin_lun',self.curLunIndex)

local temp={}
for i=1,6 do
temp[i]={}
for j=1,8 do
temp[i][j]=0
end
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLingXuWenJian,'zhenyanWin_Changedata',temp)


local temp2={}
for i=1,6 do
temp2[i]=0
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLingXuWenJian,'BattleWin_Changedata',temp2)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLingXuWenJian)
end

end

function limitActInfo_lingxuwenjian:getNextLunTime(cur)
cur=cur or gameUtilityModel.getServerLongTime()
if cur<self.curLunTime[1]then
return self.curLunTime
else
local max=#self.lunList
local idx=self.curLunIndex
if idx>=max then
local nextRaceData=lingxuwenjianController:getNextRaceData()
local lunList=lingxuwenjianModel:getLunList(nextRaceData[1])
return lunList[1]
else
return self.lunList[idx+1]
end
end
end


function limitActInfo_lingxuwenjian:onUpdate()
if self:checkDoing()then
local cur=gameUtilityModel.getServerLongTime()
local e_t=self.curLunTime[#self.curLunTime]
if cur>e_t then



lingxuwenjianModel:setEnemyData(nil)
lingxuwenjianModel:setEnterBattle(nil)

self:initCurLunTime()
else
local raceState=lingxuwenjianModel:getLunState()
local raceState_old=self.raceState
self.raceState=raceState
if self.raceState~=raceState_old then
self:refreshEnterEx("onUIEnterBigLimitActivityBottomText")

if self.raceState==eLXWJ_State.eFight or raceState_old==eLXWJ_State.eFight then
UIManager:invokeUIMethod('UILimitActStorageWin','refreshCondShow',LIMIT_ACT_TYPE.eLingXuWenJian)
UIManager:invokeUIMethod('UILimitActStorageWin','refreshTipsShow',LIMIT_ACT_TYPE.eLingXuWenJian)
end
if raceState_old~=nil then
if self.raceState==eLXWJ_State.eFight then



lingxuwenjianModel:setScoreNotesList(nil)

lingxuwenjianModel:clearAttackTimes()
UIManager:invokeUIMethod('UIXM_LXWJ_BattleWin','refreshAttackNum')
UIManager:invokeUIMethod('UIXM_LXWJ_zhenyanWin','refreshAttackNum')
elseif self.raceState==eLXWJ_State.eFinish then


end
end
end

local kfDay=limitActivitiesModel.getDayConditionCfg(self.actcfg)
if kfDay~=nil then

local openday=timeHelper.getServerOpenDay()
if openday>=kfDay then
if self.raceState==eLXWJ_State.eFight then
local fightState,left_=lingxuwenjianModel:getFightState()
local fightState_old=self.fightState
self.fightState=fightState
if self.fightState==eLXWJ_Fight_State.eWJIdle then
if left_==lingxuwenjianModel.wjFightTime then
local desc=cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'wjNotice',1)
lingxuwenjianController:sendChatNotice(desc)
end
elseif self.fightState==eLXWJ_Fight_State.eWJ1 then
if left_==lingxuwenjianModel.wjFightTime then
local desc=cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'wjNotice',2)
lingxuwenjianController:sendChatNotice(desc)
end
elseif self.fightState==eLXWJ_Fight_State.eWJ2 then
if left_==lingxuwenjianModel.wjFightTime then
local desc=cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'wjNotice',3)
lingxuwenjianController:sendChatNotice(desc)
end
end
end
end
end
end
end
end

function limitActInfo_lingxuwenjian:getUIEnterBigLimitActivityBottomText()
local raceState=lingxuwenjianModel:getLunState()

if raceState==eLXWJ_State.eStandby then
return'备战阶段'
elseif raceState==eLXWJ_State.eFight then
return'决战阶段'
elseif raceState==eLXWJ_State.eFinish then
return'结算阶段'
end
end


function limitActInfo_lingxuwenjian:onDelete()
self.lunList=nil
self.curLunTime=nil
self.curLunIndex=nil
self.raceState=nil
self.fightState=nil
end


function limitActInfo_lingxuwenjian:checkReddot()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eLingXuWenJian)
if actInfo then
if not actInfo:checkDoing()and actInfo:checkOpen()then
local has_xm=xianmengModel:hasXM()
local isBM=lingxuwenjianModel:isBaoMing()
return has_xm and not isBM
end
end
return false
end


function limitActInfo_lingxuwenjian:jump(extraParams)
extraParams=extraParams or{}
local win=UIManager:findActiveWindow('UIXM_LXWJ_Enter_win')
if win then

else
local panelparams={}
panelparams.isFull=true
panelparams.extraParams=extraParams
UIFullCommonControl:showCommonWindow('UIXM_LXWJ_Enter_win',panelparams,true,nil,true,fullScreenSkinType.eSkin15,true)
end
end

function limitActInfo_lingxuwenjian:checkJump_time(isWarning)
if self:checkFinish()then
if isWarning then
UIManager.error('活动已结束')
end
return false
end
return true
end

function limitActInfo_lingxuwenjian:checkJump_data(isWarning)
if not lingxuwenjianModel:checkInit()then
if isWarning then
UIManager.error('数据没有准备好')
end
return false
end
return true
end


function limitActInfo_lingxuwenjian:getCurLunTime()
return self.curLunTime
end

function limitActInfo_lingxuwenjian:getCurLunIndex()
return self.curLunIndex
end

return limitActInfo_lingxuwenjian
