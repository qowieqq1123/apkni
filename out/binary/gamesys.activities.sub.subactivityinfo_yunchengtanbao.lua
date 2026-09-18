









local subActivityInfo_yunchengtanbao={name='yunchengtanbao'}

function subActivityInfo_yunchengtanbao:onInit()


end

function subActivityInfo_yunchengtanbao:onStart()

end

function subActivityInfo_yunchengtanbao:onUpdate()

end

function subActivityInfo_yunchengtanbao:onDelete()





end

function subActivityInfo_yunchengtanbao:checkReddot()
local data=self.data
if data then
return activitiesHandle_yunchengtanbao:isSaiZiNum(self.act_id,SUB_ACTIVITY_TYPE.eCloudCityTreasure,self.sub_act_id)
end
return false
end


function subActivityInfo_yunchengtanbao:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then
local mydata=activitiesModel:getSubActInfoData(self.act_id,SUB_ACTIVITY_TYPE.eCloudCityTreasure,self.sub_act_id)
mydata.free_times=0
activitiesModel:setSubActInfoData(self.act_id,SUB_ACTIVITY_TYPE.eCloudCityTreasure,self.sub_act_id,mydata)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eCloudCityTreasure)
end
end
end


function subActivityInfo_yunchengtanbao:isInAuto()
return self.data.autoMode
end
function subActivityInfo_yunchengtanbao:setAutoMode(flag)
self.data.autoMode=flag
end

function subActivityInfo_yunchengtanbao:setAutoStart(flag)
self.data.autoFlag=flag
end
function subActivityInfo_yunchengtanbao:isAutoStart()
return self.data.autoFlag
end

function subActivityInfo_yunchengtanbao:isfrightAuto()
if self and self:checkDoing()then
if self.data then
return self.data.frightautoFlag
else
return nil
end
end
end
function subActivityInfo_yunchengtanbao:setAutofright(flag)
self.data.frightautoFlag=flag
end


function subActivityInfo_yunchengtanbao:isSaiZiNum()
local havenum=false
local mydata=activitiesModel:getSubActInfoData(self.act_id,self.sub_act_type,self.sub_act_id)
local free_times=mydata.free_times
local cfg_free_times=cfg_cloudcitytreasureactconfig_get(self.sub_act_id).free_times

if cfg_free_times>free_times then
havenum=true
elseif cfg_free_times<=free_times then
local costid=cfg_cloudcitytreasureactconfig_get(self.sub_act_id).costs[1]
local num=bagControl.invokeFuncByItemId(costid,'getItemCountByItemID',costid)
if num and num>0 then
havenum=true
else
havenum=false
end
end
return havenum
end


return subActivityInfo_yunchengtanbao
