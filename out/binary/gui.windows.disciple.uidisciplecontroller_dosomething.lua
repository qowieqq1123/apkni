












function UIDiscipleController.doTriggerSomething(typeid,args)
if typeid==dzTriggerDoSomething.ePrivateMoney then
local costType=args[1]
local costNum=args[2]
if args[1]~=eMoneyType.mtLingShi then
return false
else
local costLimit=cfgHelper.getdef1(cfg_diziprivatemoneyconfig,'costLimit')
if costNum>costLimit then
return false
end
end
end

local times
if typeid==dzTriggerDoSomething.ePrivateMoney then
times=onlineDataSetting:getData(onlineDataKeyType.ePrivateMoneyTimes)
elseif typeid==dzTriggerDoSomething.eChuiWei then
times=onlineDataSetting:getData(onlineDataKeyType.eDiscipleChuiWei)
end
if times==nil then
return false
end

local cfg=cfgHelper.get2(cfg_diziprivatemoneyconfig_get,typeid,times+1)
if cfg==nil then return end

local condition=cfg.condition
if condition~=nil then
for i,cond in ipairs(condition)do
if cond[1]==1 then

if not taskModel:checkTaskFinish(cond[2])then
return false
end
end
end
end

local dialogueids=cfg.dialogue
local func=function()
if typeid==dzTriggerDoSomething.eChuiWei then
gameplotController:showPlotBoard({groupid=dialogueids[2],showGoBtn=true,goBtnStr='前往救治',callback=function()
UIFullDiscipleMainControl:showWindowInfo({dis_guid=args[1]})
local weakguideids=cfg.weakguideids
for i,v in ipairs(weakguideids)do
weakGuideController:beginGuide(v)
end
end})
end
UIDiscipleController:req_privateMoney(typeid)
end
gameplotController:showPlotBoard({groupid=dialogueids[1],rewards=cfg.rewards,callback=func})
return true
end




function UIDiscipleController:req_privateMoney(typeid)
socketManager:send_254_36(typeid)
end




function UIDiscipleController.do_protocol_254_35(len,list)
if len>0 then
local typeFlag={}
for i,v in ipairs(list)do
local typeid=v.param_1
local times=v.param_2
if not typeFlag[typeid]then
typeFlag[typeid]=true
end


if typeid==dzTriggerDoSomething.ePrivateMoney then


local old=onlineDataSetting:getData(onlineDataKeyType.ePrivateMoneyTimes)
onlineDataSetting:setData(onlineDataKeyType.ePrivateMoneyTimes,times)

if old~=nil then

else

end
elseif typeid==dzTriggerDoSomething.eChuiWei then
local old=onlineDataSetting:getData(onlineDataKeyType.eDiscipleChuiWei)
onlineDataSetting:setData(onlineDataKeyType.eDiscipleChuiWei,times)
if old~=nil then
UIDiscipleController:setTriggerChuiweiDisciple(0)
UIManager:invokeUIMethod('UITaskListWin','refreshDzChuiweiTaskView')
end
end
end
for i,v in pairs(dzTriggerDoSomething)do
if not typeFlag[v]then
UIDiscipleController.setZeroData(v)
end
end
else
for i,v in pairs(dzTriggerDoSomething)do
UIDiscipleController.setZeroData(v)
end
end
end

function UIDiscipleController.setZeroData(typeid)
if typeid==dzTriggerDoSomething.ePrivateMoney then
onlineDataSetting:setData(onlineDataKeyType.ePrivateMoneyTimes,0)
elseif typeid==dzTriggerDoSomething.eChuiWei then
onlineDataSetting:setData(onlineDataKeyType.eDiscipleChuiWei,0)
end
end



function UIDiscipleController:loadTriggerChuiweiDisciple()
self.triggerChuiWeiDzId=userActorSetting.get('triggerchuiweidisciple','0')
end

function UIDiscipleController:setTriggerChuiweiDisciple(dzId)
self.triggerChuiWeiDzId=tostring(dzId)
userActorSetting.set('triggerchuiweidisciple',tostring(dzId))
userActorSetting.flush()
end

function UIDiscipleController:getTriggerChuiweiDisciple()
return self.triggerChuiWeiDzId
end