
local subActivityInfo_tytongxingzhengtab={name='tytongxingzhengtab'}

function subActivityInfo_tytongxingzhengtab:onInit()
self.data={}
self:listenNotify(notifyConfig.onSubActivityDontHandleReddotChange,function(actId,subType,subId)
local subActId=self:getSubActConfig("id")
local subActType=SUB_ACTIVITY_TYPE.ePassPortAct1

if self.act_id==actId and subActType==subType and subActId==subId then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end)
end

function subActivityInfo_tytongxingzhengtab:onStart()
end

function subActivityInfo_tytongxingzhengtab:onUpdate()
end

function subActivityInfo_tytongxingzhengtab:onDelete()

end

function subActivityInfo_tytongxingzhengtab:checkReddot()
local guid
local actId=self.act_id
local subType=SUB_ACTIVITY_TYPE.ePassPortAct1
local subId=self.sub_act_id
local passporttype=txzType.act
guid=UITYTongXingZhengModel:getGuidByActID(passporttype,actId,subType,subId)

if guid then
return UITYTongXingZhengController:checkReddot(guid)
end
return false
end

return subActivityInfo_tytongxingzhengtab