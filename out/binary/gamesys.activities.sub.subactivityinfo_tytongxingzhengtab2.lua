
local subActivityInfo_tytongxingzhengtab2={name='tytongxingzhengtab'}

function subActivityInfo_tytongxingzhengtab2:onInit()
self.data={}
self:listenNotify(notifyConfig.onSubActivityDontHandleReddotChange,function(actId,subType,subId)
local subActId=self:getSubActConfig("id")
local subActType=SUB_ACTIVITY_TYPE.ePassPortAct3

if self.act_id==actId and subActType==subType and subActId==subId then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end)
end

function subActivityInfo_tytongxingzhengtab2:onStart()
end

function subActivityInfo_tytongxingzhengtab2:onUpdate()
end

function subActivityInfo_tytongxingzhengtab2:onDelete()

end

function subActivityInfo_tytongxingzhengtab2:checkReddot()
local guid
local actId=self.act_id
local subType=SUB_ACTIVITY_TYPE.ePassPortAct3
local subId=self.sub_act_id
local passporttype=txzType.act
guid=UITYTongXingZhengModel:getGuidByActID(passporttype,actId,subType,subId)

if guid then
return UITYTongXingZhengController:checkReddot(guid)
end
return false
end

return subActivityInfo_tytongxingzhengtab2