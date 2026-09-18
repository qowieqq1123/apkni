






local _MODULENAME="YuLingZhaiController"

gameState.addListener(def_table(_MODULENAME))
YuLingZhaiController.name=_MODULENAME
YuLingZhaiController.data={}

function YuLingZhaiController:onAppStart()

YuLingZhaiModel:onAppStart()








socketManager:register_receiver(6,131,self.recv_6_131)
socketManager:register_receiver(6,132,self.recv_6_132)
socketManager:register_receiver(6,133,self.recv_6_133)
socketManager:register_receiver(6,134,self.recv_6_134)

socketManager:register_receiver(6,135,self.recv_6_135)

notifySystem:listenNotify(notifyConfig.on_money_init,self.onInitMoney)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)



end


function YuLingZhaiController:onEnterState(isReconnect)
YuLingZhaiModel:onEnterState()
end


function YuLingZhaiController:onProtocolReq()
YuLingZhaiModel:onProtocolReq()
end


function YuLingZhaiController:onLeaveState(isReconnect)
YuLingZhaiModel:onLeaveState(isReconnect)

self.data={}
end


function YuLingZhaiController:onLostConnection()

end


function YuLingZhaiController:onReConnection(isInitPro)

end












function YuLingZhaiController.recv_6_131(args)
local recover_type,start_time,accelerate_time,len,soldier,produce_rate,capacity_improve,build_lv=unpack(args)

YuLingZhaiModel.initFlag=true

YuLingZhaiModel:setHealType(recover_type)
YuLingZhaiModel:setHealData(soldier)
YuLingZhaiModel:setHealStartTime(start_time)
YuLingZhaiModel:setServerAccTime(accelerate_time)

YuLingZhaiModel:setSpeedAddPercent(produce_rate)
YuLingZhaiModel:setMaxAddPercent(capacity_improve)

YuLingZhaiModel:setBuildingLv(build_lv)

if start_time>0 then
YuLingZhaiController:start_result_timer()
else
YuLingZhaiModel:setHealType(0)
YuLingZhaiController:check_free_heal()
end

UIManager:invokeUIMethod("UIYuLingZhaiWin","refreshRecv")
YuLingZhaiController:refreshYLZHUD()
end

function YuLingZhaiController.req_6_132(recover_type,len,soldier)
if recover_type==2 then
YuLingZhaiController.req_6_132_2_stamp=timeHelper.getServerShortTime()
end
socketManager:send_6_132(recover_type,len,soldier)
end

function YuLingZhaiController.recv_6_132(args)
local recover_type,len,soldier,start_time,produce_rate,capacity_improve,build_lv,quit_cd=unpack(args)
YuLingZhaiModel:setServerAccTime(0)
YuLingZhaiModel:setSpeedAddPercent(produce_rate)
YuLingZhaiModel:setMaxAddPercent(capacity_improve)

YuLingZhaiModel:setBuildingLv(build_lv)

YuLingZhaiController.quit_cd_sec=quit_cd

if recover_type==3 then
if len==0 then
YuLingZhaiController.recv_6_133(len,soldier)
else
YuLingZhaiModel:setHealData(soldier)
YuLingZhaiModel:setHealStartTime(start_time)
if start_time>0 then
YuLingZhaiController:start_result_timer()
end
end
else
if recover_type==2 then
YuLingZhaiController.req_6_132_2_stamp=nil
end
YuLingZhaiModel:setHealType(recover_type)
YuLingZhaiModel:setHealData(soldier)
YuLingZhaiModel:setHealStartTime(start_time)
if start_time>0 and len>0 then
YuLingZhaiController:start_result_timer()
else
YuLingZhaiModel:setHealType(0)
end
end

UIManager:invokeUIMethod("UIYuLingZhaiWin","refreshRecv")
YuLingZhaiController:refreshYLZHUD()

end

function YuLingZhaiController.req_6_133(is_quit)
is_quit=is_quit or 0
if is_quit==1 and YuLingZhaiController.quit_cd_sec then
local now=timeHelper.getServerShortTime()
if now-YuLingZhaiController.quit_cd_sec<60 then
UIManager.error(FMT.fmt(" 正在治疗中，请{0}秒后重试",60-(now-YuLingZhaiController.quit_cd_sec)))
return
end
end
socketManager:send_6_133(is_quit)
end

function YuLingZhaiController.recv_6_133(recover_len,soldier)
YuLingZhaiModel:setHealStartTime(0)
YuLingZhaiModel:setHealType(0)
YuLingZhaiModel:setHealData()
YuLingZhaiController:check_free_heal()

UIManager:invokeUIMethod("UIYuLingZhaiWin","refreshRecv")
YuLingZhaiController:refreshYLZHUD()
end

function YuLingZhaiController.recv_6_134(recover_len,soldier)
YuLingZhaiController:check_free_heal()
UIManager:invokeUIMethod("UIYuLingZhaiWin","refreshRecv")
YuLingZhaiController:refreshYLZHUD()
end

function YuLingZhaiController.recv_6_135(accelerate_time)
YuLingZhaiModel:setServerAccTime(accelerate_time)
YuLingZhaiController:start_result_timer()
UIManager:invokeUIMethod("UIYuLingZhaiWin","refreshRecv")
end




function YuLingZhaiController:start_result_timer()
local startStamp=YuLingZhaiModel:getHealStartTime()
local useTime=YuLingZhaiModel:getLeftTime(true)
local endStamp=startStamp+useTime
local now=timeHelper.getServerShortTime()

local left=endStamp-now



self:stopUpdate()

if left>0 then
YuLingZhaiController:startUpdate(left)
else
YuLingZhaiController.req_6_133()
end

end

function YuLingZhaiController:onNormalUpdate(delay)
local curRealTime=Time.realtimeSinceStartup
if(not self.endResultTime)or(curRealTime>=self.endResultTime)then
self:stopUpdate()
YuLingZhaiController.req_6_133()
end
end


function YuLingZhaiController:startUpdate(left)
self.endResultTime=Time.realtimeSinceStartup+left
timeEventController.addNormalTimerHandler(1,self.name,self)
end


function YuLingZhaiController:stopUpdate()
timeEventController.removeNormalTimerHandler(1,self.name)
end



function YuLingZhaiController:check_free_heal()
local hurtList=xianjieModel:getSoldierHurtList(xjSoldierHurtType.eSeriousInjury,true)

if next(hurtList)then
local sendList={}
local lv=YuLingZhaiModel:getBuildingLv()
local limit=cfgHelper.get(cfg_yulingzhaiconfig_get,lv,"recover_max")
local num=0
local sortList={}
for id,v in pairs(hurtList)do
if v>0 then
table.insert(sortList,{id,v})
end
end
table.sort(sortList,function(a,b)return a[1]>b[1]end)
for i,v in ipairs(sortList)do
if num+v[2]>=limit then
table.insert(sendList,{v[1],limit-num})
num=limit
break
else
table.insert(sendList,{v[1],v[2]})
num=num+v[2]
end

end
YuLingZhaiController.req_6_132(YLZ_HEAL_TYPE.eFree,#sendList,sendList)
end
end

function YuLingZhaiController.onMoneyChanged(moneyType,oldVal,newVal)
if YuLingZhaiModel:isMoneyHurtType(moneyType)then

if newVal>oldVal and YuLingZhaiModel:getBuildingData(mapIdType.fort)then
if YuLingZhaiController.req_6_132_2_stamp then
local now=timeHelper.getServerShortTime()
if now-YuLingZhaiController.req_6_132_2_stamp<5 then
return
end
end
local healType=YuLingZhaiModel:getHealType()
if healType==0 then
YuLingZhaiController:check_free_heal()
end
end
end
end

function YuLingZhaiController.onInitMoney()
if YuLingZhaiModel.initFlag and YuLingZhaiModel:getHealType()==0 then
YuLingZhaiController:check_free_heal()
YuLingZhaiModel.initFlag=nil
end
end

function YuLingZhaiController:setItemAccTime(accTime)
YuLingZhaiModel:addServerAccTime(accTime)
end

function YuLingZhaiController:onItemAccTimeEnd()
YuLingZhaiController:start_result_timer()
UIManager:invokeUIMethod("UIYuLingZhaiWin","refreshRecv")
end


function YuLingZhaiController:refreshYLZHUD()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYuLingZhai)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end
