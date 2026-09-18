









local subActivityInfo_huiyingpintu={name='huiyingpintu'}

function subActivityInfo_huiyingpintu:onInit()




end

function subActivityInfo_huiyingpintu:onStart()

end

function subActivityInfo_huiyingpintu:onUpdate()

end

function subActivityInfo_huiyingpintu:onDelete()





end

function subActivityInfo_huiyingpintu:checkReddot()
local data=self.data
local reddot=false

if data then
reddot=activitiesHandle_huiyingpintu.checkdebrisreddot(self.act_id,SUB_ACTIVITY_TYPE.ePaintedPuzzle,self.sub_act_id)
or activitiesHandle_huiyingpintu.checkrewardreddot(self.act_id,SUB_ACTIVITY_TYPE.ePaintedPuzzle,self.sub_act_id)
or activitiesHandle_huiyingpintu.checkjindureddot(self.act_id,SUB_ACTIVITY_TYPE.ePaintedPuzzle,self.sub_act_id)
or activitiesHandle_huiyingpintu.checkpintuboxreddot(self.act_id,SUB_ACTIVITY_TYPE.ePaintedPuzzle,self.sub_act_id)
or activitiesHandle_huiyingpintu.checknextTureddot(self.act_id,SUB_ACTIVITY_TYPE.ePaintedPuzzle,self.sub_act_id)
end
return reddot
end


function subActivityInfo_huiyingpintu:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then









end
end
end


return subActivityInfo_huiyingpintu
