









local subActivityInfo_xishizhenbao={name='xishizhenbao'}

function subActivityInfo_xishizhenbao:onInit()

end

function subActivityInfo_xishizhenbao:onStart()

end

function subActivityInfo_xishizhenbao:onDelete()

end

function subActivityInfo_xishizhenbao:checkReddot()


if self.data then
if self:checkFree()then
return true
elseif self:checkBuyReddot()then
return true
end
end
return false
end

function subActivityInfo_xishizhenbao:checkBuyReddot()
if self.data then
if self:checkCanBuy()then
local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
local isEnterOnceData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eActEnterOnce,keyStr,nil)
if isEnterOnceData and timeHelper.getServerShortTime()>isEnterOnceData[1]then
isEnterOnceData=nil
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eActEnterOnce,keyStr,nil)
end
return not isEnterOnceData
end
end
return false
end

function subActivityInfo_xishizhenbao:refreshBuyReddot()
if self.data then
if self:checkCanBuy()then
local subType=SUB_ACTIVITY_TYPE.eXiShiZhenBao
local isEnterOnceData={self.end_time,1}
local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActEnterOnce,keyStr,isEnterOnceData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActEnterOnce)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end
end

function subActivityInfo_xishizhenbao:checkCanBuy()
if self.data then
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local type=config.check_type[1]
local itemid=config.check_type[2]
local have=false
local itemNum=bagModel.getItemCountById(itemid)
if type==1 then
local gbid=gubaoLookup:good2GuBao(itemid)
have=gubaoModel:checkActive(gbid)or(itemNum>0)
else
have=daobingModel:hasDaoBingRecord(itemid)or(itemNum>0)
end
if have then

return false,1
end
local buy_flag=self.data.buy_flag
if buy_flag~=0 then

return false,2
end
local task_conf=config.task_conf
if task_conf and task_conf[1]then
local need_num=task_conf[1][2]
if self.data.task_num<need_num then

return false,3
end
end
return true
end
return false,-1
end

function subActivityInfo_xishizhenbao:checkFree()
if self.data and self.data.free_flag then
return self.data.free_flag==0
end
return false
end

return subActivityInfo_xishizhenbao