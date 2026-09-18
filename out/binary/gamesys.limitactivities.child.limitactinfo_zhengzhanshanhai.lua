














local limitActInfo_zhengzhanshanhai={name='zhengzhanshanhai'}


function limitActInfo_zhengzhanshanhai:onInit()

end


function limitActInfo_zhengzhanshanhai:onStart()

self.lunList=zhengzhanshanhaiModel:getLunList(self.start_time_l,self.end_time_l)
self:initCurLunTime()
end

function limitActInfo_zhengzhanshanhai:initCurLunTime()
local time=nil
local lun=nil
local cur=gameUtilityModel.getServerLongTime()
local max=#self.lunList
for i,d in ipairs(self.lunList)do
local e_t=d[#d][2]
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
end

function limitActInfo_zhengzhanshanhai:getNextLunTime(cur)
cur=cur or gameUtilityModel.getServerLongTime()
if cur<self.curLunTime[1][1]then
return self.curLunTime
else
local max=#self.lunList
local idx=self.curLunIndex
if idx>=max then
local nextRaceData=zhengzhanshanhaiController:getNextRaceData()
local lunList=zhengzhanshanhaiModel:getLunList(nextRaceData[1],nextRaceData[2])
return lunList[1]
else
return self.lunList[idx+1]
end
end
end


function limitActInfo_zhengzhanshanhai:onUpdate()
if self:checkDoing()then
local cur=gameUtilityModel.getServerLongTime()
local e_t=self.curLunTime[#self.curLunTime][2]
if cur>e_t then





self:initCurLunTime()
else
local raceState=zhengzhanshanhaiModel:getLunState()
local raceState_old=self.raceState
self.raceState=raceState
if self.raceState~=raceState_old then
if raceState_old~=nil then
if raceState_old==eZZSH_State.ePVPStandby then
if self.raceState==eZZSH_State.ePVPFight then
if UIManager:isActive('UIXM_ZZSH_MapWin')then
local del={[eZZSHEntityType.ePvPLine]=true}
zhengzhanshanhaiModel:removeAllEntitys3(del)
UIManager:invokeUIMethod('UIXM_ZZSH_PvPMainWin','changeWinType')
end
end
elseif raceState_old==eZZSH_State.ePVPFight then

zhengzhanshanhaiModel:clearpvpOrder()
zhengzhanshanhaiModel:clearpvpTargetData()
if self.raceState==eZZSH_State.ePVPStandby then
if UIManager:isActive('UIXM_ZZSH_MapWin')then
local del={[eZZSHEntityType.ePvPTeam]=true}
zhengzhanshanhaiModel:removeAllEntitys3(del)
UIManager:invokeUIMethod('UIXM_ZZSH_PvPMainWin','changeWinType')
end
end
if UIManager:isActive('UIXM_ZZSH_MapWin')then
zhengzhanshanhaiModel:getPVPWarBalanceData()
end
elseif raceState_old==eZZSH_State.ePVEFight then


zhengzhanshanhaiController.finishSHZhanLing()
zhengzhanshanhaiController.finishSHWeekTask()
end
if self.raceState==eZZSH_State.ePVEFight then


zhengzhanshanhaiController.req_getZZSHZhanLingData()
zhengzhanshanhaiController:req_weekTaskInit()
zhengzhanshanhaiController.finishSHWeekTask()
end
else
if self.raceState==eZZSH_State.ePVEFight then



zhengzhanshanhaiController:req_weekTaskInit()
end
end
notifySystem:postNotify(notifyConfig.onZZSHRaceStateChange,raceState_old,self.raceState)
end
end
end
end


function limitActInfo_zhengzhanshanhai:onDelete()
self.lunList=nil
self.curLunTime=nil
self.curLunIndex=nil
self.raceState=nil
end


function limitActInfo_zhengzhanshanhai:checkReddot()
return false
end


function limitActInfo_zhengzhanshanhai:jump(extraParams)
if UIManager:findActiveWindow('UIFightPrepareLoading')then
return
end
extraParams=extraParams or{}
local showCloud=extraParams.showCloud
if showCloud==nil then
showCloud=true
end
if UIManager:isActive('UIXM_ZZSH_MapWin')then
showCloud=false
elseif not UIManager:findActiveWindow('UIXM_ZZSH_MapWin')then
showCloud=true
end
local cb=function()
local panelparams={}
panelparams.isFull=true
panelparams.extraParams=extraParams
UIFullCommonControl:showCommonWindow('UIXM_ZZSH_MapWin',panelparams,true,nil,true,fullScreenSkinType.eSkin15,true)
end
if showCloud then
local callback=function()
cb()
end
UIManager:showWindow("UIFightPrepareLoading",{para=1,startCallback=callback})
else
local win=nil
if UIManager:isActive('UIXM_ZZSH_MapWin')then
win=UIManager:findActiveWindow('UIXM_ZZSH_MapWin')
end
if win then
local panelparams={}
panelparams.isFull=true
panelparams.extraParams=extraParams
win:onShowArgRecv(panelparams)
else
cb()
end
end
end

function limitActInfo_zhengzhanshanhai:checkJump_time(isWarning)
if self:checkFinish()then
if isWarning then
UIManager.error('活动已结束')
end
return false
end
return true
end

function limitActInfo_zhengzhanshanhai:checkJump_data(isWarning)
if not zhengzhanshanhaiModel:checkInit()then
if isWarning then
UIManager.error('数据没有准备好')
end
return false
end
return true
end

function limitActInfo_zhengzhanshanhai:printLunTime()
zhengzhanshanhaiModel:testFun_printSeasonLunTime(self.lunList)
end

function limitActInfo_zhengzhanshanhai:getCurLunTime()
return self.curLunTime
end

function limitActInfo_zhengzhanshanhai:getCurLunIndex()
return self.curLunIndex
end

function limitActInfo_zhengzhanshanhai:getDayConditionStrFMT()
return'{0}天后可进入山海世界'
end

return limitActInfo_zhengzhanshanhai