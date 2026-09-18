









local subActivityInfo_tehuilibao={name='tehuilibao'}

function subActivityInfo_tehuilibao:onInit()

end

function subActivityInfo_tehuilibao:onStart()

end

function subActivityInfo_tehuilibao:onDelete()

end

function subActivityInfo_tehuilibao:checkReddot()
return activitiesHandle_tehuilibao.canGetBaoXiang(self.act_id,self.sub_act_id)
end

function subActivityInfo_tehuilibao:checkNewDay()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eTeHuiLiBao)
end


return subActivityInfo_tehuilibao