






local _MODULENAME="JuTianYiController"

gameState.addListener(def_table(_MODULENAME))
JuTianYiController.name=_MODULENAME
JuTianYiController.data={}

function JuTianYiController:onAppStart()

JuTianYiModel:onAppStart()


socketManager:register_receiver(6,151,JuTianYiController.recv_6_151)
socketManager:register_receiver(6,152,JuTianYiController.recv_6_152)
socketManager:register_receiver(6,153,JuTianYiController.recv_6_153)
socketManager:register_receiver(6,154,JuTianYiController.recv_6_154)
socketManager:register_receiver(6,155,JuTianYiController.recv_6_155)
socketManager:register_receiver(6,156,JuTianYiController.recv_6_156)
socketManager:register_receiver(6,157,JuTianYiController.recv_6_157)

end


function JuTianYiController:onEnterState(isReconnect)
JuTianYiModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
timeEventController.addSlowTimerHandler('JuTianYiController',self)
end


function JuTianYiController:onProtocolReq()
JuTianYiModel:onProtocolReq()
end


function JuTianYiController:onLeaveState(isReconnect)
JuTianYiModel:onLeaveState(isReconnect)

self.data={}
self.bdData=nil
notifySystem:removelistener(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
timeEventController.removeSlowTimerHandler('JuTianYiController')
end


function JuTianYiController:onLostConnection()

end


function JuTianYiController:onReConnection(isInitPro)

end





function JuTianYiController.reqChangeRate(init_a,init_b)
socketManager:send_6_153(init_a,init_b)
end



function JuTianYiController.reqUseGnosis(use_gnosis_num)
socketManager:send_6_157(use_gnosis_num)
end







function JuTianYiController.recv_6_151(sec,init_a,init_b,repair_sec,accelerate_sec)
JuTianYiModel:setMoQiRate(init_a)
JuTianYiModel:setProduceTimeStamp(sec)
JuTianYiModel:setItemAccelerateTime(accelerate_sec)
end



function JuTianYiController.recv_6_152(sec)
JuTianYiModel:setProduceTimeStamp(sec)
end





function JuTianYiController.recv_6_153(init_a,init_b,sec)
JuTianYiModel:setMoQiRate(init_a)
JuTianYiModel:setProduceTimeStamp(sec)
end



function JuTianYiController.recv_6_154(accelerate_sec)
local old=JuTianYiModel:getItemAccelerateTime()
local oldXianQi=moneyModel.getMoney(eMoneyType.mtXianQi)
local oldMoQi=moneyModel.getMoney(eMoneyType.mtMoQi)
JuTianYiModel:setItemAccelerateTime(accelerate_sec)
if old then
local passTime=accelerate_sec-old
if passTime<=0 then
return
end
local defCfg=cfgHelper.getdef(cfg_jutianyiconfig)
local level=JuTianYiController:getBuildingLevel()
if not level then
return
end
local init_produce=cfgHelper.get2(cfg_jutianyiconfig_get,level,'init_produce')
local xianIncrRate,moIncrRate=JuTianYiModel:getLastRate()
local times=mathHelper.floor(passTime/defCfg.interval)*defCfg.coefficient_a
local xianRate=10-JuTianYiModel:getMoQiRate()
local moRate=JuTianYiModel:getMoQiRate()
local xianAdd=mathHelper.floor(init_produce*(xianIncrRate/100))*times*(xianRate/10)
xianAdd=mathHelper.floor(xianAdd)
local moAdd=mathHelper.floor(init_produce*(moIncrRate/100))*times*(moRate/10)
moAdd=mathHelper.floor(moAdd)
UIManager.info(string.format("已获得魔气x%d，仙气x%d，可前往太虚仓查看",moAdd,xianAdd))
if xianAdd>0 then
local curMoney=oldXianQi+xianAdd
notifySystem:postNotify(notifyConfig.on_money_changed,eMoneyType.mtXianQi,oldXianQi,curMoney)
end
if moAdd>0 then
local curMoney=oldMoQi+moAdd
notifySystem:postNotify(notifyConfig.on_money_changed,eMoneyType.mtMoQi,oldMoQi,curMoney)
end
end
end




function JuTianYiController.recv_6_155(gnosis_sec,gnosis_cnt)
JuTianYiModel:setGnosisData(gnosis_sec,gnosis_cnt)

local bdData=JuTianYiController:getBuildingData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
UIManager:invokeUIMethod("UIXianJie_JuTianYiWin","on_gnosis_callback")
end




function JuTianYiController.recv_6_156(gnosis_sec,gnosis_cnt)
JuTianYiModel:setGnosisData(gnosis_sec,gnosis_cnt)

local bdData=JuTianYiController:getBuildingData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
UIManager:invokeUIMethod("UIXianJie_JuTianYiWin","on_gnosis_callback")
end




function JuTianYiController.recv_6_157(gnosis_sec,gnosis_cnt)
JuTianYiModel:setGnosisData(gnosis_sec,gnosis_cnt)

local bdData=JuTianYiController:getBuildingData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
UIManager:invokeUIMethod("UIXianJie_JuTianYiWin","on_gnosis_callback")
end


function JuTianYiController:getBuildingData()
if not self.bdData then
self.bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eJuTianYi)
end
return self.bdData
end

function JuTianYiController:getBuildingLevel()
local data=self:getBuildingData()
if data then
return data.level
end
end

function JuTianYiController.onShowDiscipleChanged(effectType,temp,effectData)
if effectType==ePrizeType.eJuTianYiGnosis then
local data=temp[4]or{}
local dzStrId,datas=next(data)
if datas then
local expdata=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local addexp=0
for i,v in ipairs(datas)do
local jobtype,oldlv,lv,oldexp,exp=unpack(v)
if jobtype==DISCIPLE_PROSKILL_TYPE.eZhenFa then
if lv==oldlv then
addexp=addexp+exp-oldexp
else
for ii=oldlv,lv-1 do
addexp=addexp+expdata[oldlv]
end
addexp=addexp-oldexp+exp
end
end
end
local disciplename=UIDiscipleModel:getDiscipleName(int64.new(dzStrId))
timeEventController.delayDo(0.2,function()
UIManager.info(string.format("%s阵法经验+%d",disciplename,addexp))
end)
end
end
end

function JuTianYiController:onSlowUpdate()

local bdData=JuTianYiController:getBuildingData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
JuTianYiModel:postMoneyChange()
end