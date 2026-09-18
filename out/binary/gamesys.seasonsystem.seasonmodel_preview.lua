





function seasonModel:checkShowMoJieSeasonPreview()
local enterData=xianjieModel:getMoJieEnterData()

if enterData==nil then

return false
end


if not xianjieModel:checkJoin()then

return false
end

local nowTime=timeHelper.getServerShortTime()
local stime,etime=seasonModel:getSeasonPreviewTime_mojie(enterData)
if nowTime<stime or nowTime>etime then

return false
end

if nowTime>=enterData.eTime then

return false
end

if not seasonModel:isCanShowPreviewGuide()and nowTime>=stime then

return false
end

return true
end

function seasonModel:getSeasonPreviewTime_mojie(enterData)
enterData=enterData or xianjieModel:getMoJieEnterData()
if enterData==nil then
return 0,0
end

local seasonConfig=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)

local onedaysec=86400

local preview=seasonConfig.preview
local sOffset=preview[1]*onedaysec

local sTime=enterData.sTime-sOffset
local eTime=enterData.eTime

return sTime,eTime
end

function seasonModel:checkTriggerShowPreview()
if not initProControl.isDoneKF()then return end
seasonModel:clearTriggerShowPreview()


local sTime,eTime=seasonModel:getSeasonPreviewTime_mojie()
if sTime==0 then return end

local curTime=timeHelper.getServerShortTime()

if curTime<=sTime then

self.oneTriggerTimer_Preview=timeEventController.delayDo(sTime-curTime,function()
self.oneTriggerTimer_Preview=nil

notifySystem:postNotify(notifyConfig.onSeasonChange)
end)
end
end

function seasonModel:clearTriggerShowPreview()
if self.oneTriggerTimer_Preview then
self.oneTriggerTimer_Preview:cancel()
self.oneTriggerTimer_Preview=nil
end
end

function seasonModel.test_Check_Preview_Reddot()
local reddot_sMJYGTJYX=MojiePreviewExtendController.checkReddot()
local reddot_eMJYGExtend=MojiePreviewExtendController.checkAllBZZhengMoReddot()
local reddot_MzyhReward=MojiePreviewExtendController.checkMzyhRewardReddot()

logErr("魔界预告红点-sMJYGTJYX：",reddot_sMJYGTJYX)
logErr("魔界预告红点-seMJYGExtend：",reddot_eMJYGExtend)
logErr("魔界预告红点-MzyhReward：",reddot_MzyhReward)
end
