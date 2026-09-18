









local subActivityInfo_longhudaodan={name='subActivityInfo_longhudaodan'}

function subActivityInfo_longhudaodan:onInit()
self:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
end

function subActivityInfo_longhudaodan:onStart()

end

function subActivityInfo_longhudaodan:onDelete()

end

function subActivityInfo_longhudaodan:checkReddot()
return activitiesHandle_longhudaodan:checkLianDanReddot(self.sub_act_id,self.sub_act_type,1)
or activitiesHandle_longhudaodan:checkLianDanReddot(self.sub_act_id,self.sub_act_type,2)
or activitiesHandle_longhudaodan:checkProgressRewardReddot(self.act_id,self.sub_act_type,self.sub_act_id)
end

function subActivityInfo_longhudaodan:onShowPrize(prizeType,temp,effectData)
if prizeType==ePrizeType.eLongHuDaoDan then

AudioManager.playAudio(604)
UIManager:showWindow("UILongHuDaoDanResultWin",{otherItemList=temp,effectData=effectData})
end
end

function subActivityInfo_longhudaodan:checkNewDay()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eLongHuMountain)
UIManager:invokeUIMethod("UISubAct_LongHuDaoDan_Win","refreshCost")
end

return subActivityInfo_longhudaodan