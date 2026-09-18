
local subActivityInfo_dailylibao={name='dailylibao'}
local _freshFunc=
{
[1]=function(data)
UIManager:callWindowFunc('UISubAct_previewWin','freshReddot')
end,
}
function subActivityInfo_dailylibao:onInit()
local actCfg=cfgHelper.get1(cfg_dailylibaoactconfig_get,self.sub_act_id)
self.customType=actCfg.customtype
self.resetTime=actCfg.reset

if self.resetTime==0 then
self._on_new_day=function(...)
self:on_new_day(...)
end
notifySystem:listenNotify(notifyConfig.onNewDay,self._on_new_day)
elseif self.resetTime==5 then
self._on_new5_day=function(...)
self:on_new5_day(...)
end
notifySystem:listenNotify(notifyConfig.onNewDay5am,self._on_new5_day)
else
loggerUtil.logErrFMT('每日礼包展示活动尚未支持{0}点重置刷新数据',self.resetTime)
end
end

function subActivityInfo_dailylibao:onStart()

end

function subActivityInfo_dailylibao:onDelete()
if self.resetTime==0 then
notifySystem:removelistener(notifyConfig.onNewDay,self._on_new_day)
elseif self.resetTime==5 then
notifySystem:removelistener(notifyConfig.onNewDay5am,self._on_new5_day)
end
self.customType=nil
self.resetTime=nil
end

function subActivityInfo_dailylibao:checkReddot()
return not self:isPrize()
end

function subActivityInfo_dailylibao:isPrize()
local flag=self.data
return flag==1
end

function subActivityInfo_dailylibao:on_new_day()
local actCfg=cfgHelper.get1(cfg_dailylibaoactconfig_get,self.sub_act_id)
local rwLimit=actCfg.rwLimit==1
local isPrize=self:isPrize()
if not isPrize or rwLimit then return end

self.data=0

local customType=self.customType
if _freshFunc[customType]then
_freshFunc[customType](self.data)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eDailyLiBao)
end

function subActivityInfo_dailylibao:on_new5_day()
local actCfg=cfgHelper.get1(cfg_dailylibaoactconfig_get,self.sub_act_id)
local rwLimit=actCfg.rwLimit==1
local isPrize=self:isPrize()
if not isPrize or rwLimit then return end

self.data=0

local customType=self.customType
if _freshFunc[customType]then
_freshFunc[customType](self.data)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eDailyLiBao)
end

function subActivityInfo_dailylibao:isCustomType(customtype)
return customtype==self.customType
end

function subActivityInfo_dailylibao:reqPrize()
local uit={1}
local jsonStr=jsonHelper.encode(uit)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jsonStr)
end

return subActivityInfo_dailylibao