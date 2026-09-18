









local subActivityInfo_liandandahui={name='subActivityInfo_liandandahui'}

function subActivityInfo_liandandahui:onInit()
self:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
end

function subActivityInfo_liandandahui:onStart()

end

function subActivityInfo_liandandahui:onDelete()

end

function subActivityInfo_liandandahui:checkReddot()
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
return config.free-self:getFreeCount()>0
end

function subActivityInfo_liandandahui:onShowPrize(prizeType,temp,effectData)
if prizeType==ePrizeType.eLianDanDaHui then

AudioManager.playAudio(604)
UIManager:showWindow("UILianDanResultWin",{otherItemList=temp,effectData=effectData})
end
end

function subActivityInfo_liandandahui:checkNewDay()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eLianDanDaHui)
UIManager:invokeUIMethod("UISubAct_LianDanDaHui_Win","refreshCost")
end

function subActivityInfo_liandandahui:getFreeCount()
if self.data.freeSec and not timeHelper.isTodayStamp(timeHelper.convertLongStamp(self.data.freeSec))then
self.data.freeSec=0
self.data.free=0
end
return self.data.free or 0
end

function subActivityInfo_liandandahui:getFreeSec()
return self.data.freeSec
end


return subActivityInfo_liandandahui