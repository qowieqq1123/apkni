









local subActivityInfo_tanxianduitanbao={name='tanxianduitanbao'}

function subActivityInfo_tanxianduitanbao:onInit()


end

function subActivityInfo_tanxianduitanbao:checkReddot()
return activitiesHandle_tanxianduitanbao.checkreddot(self.act_id,self.sub_act_id)
end

return subActivityInfo_tanxianduitanbao