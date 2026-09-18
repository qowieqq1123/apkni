






local _MODULENAME="zhenfaController"





gameState.addListener(def_table(_MODULENAME))




zhenfaController.name=_MODULENAME


zhenfaController.data={}

local _this=zhenfaController


function zhenfaController:onAppStart()

zhenfaModel:onAppStart()








socketManager:register_receiver(3,201,self.recv_3_201)
socketManager:register_receiver(3,202,self.recv_3_202)
socketManager:register_receiver(3,203,self.recv_3_203)


notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:listenNotify(notifyConfig.onDiscipleSpecialityChange,self.onDiscipleSpecialityChange)
notifySystem:listenNotify(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
end


function zhenfaController:onEnterState()
zhenfaModel:onEnterState()
end


function zhenfaController:onServerDataInitFinish()
zhenfaModel:onServerDataInitFinish()
end


function zhenfaController:onLeaveState()
zhenfaModel:onLeaveState()

self.data={}
end


function zhenfaController:onLostConnection()
if isometricMapSystem:IsInHome()then
timeEventController.removeNormalTimerHandler(2,'zhenfaController')
end
end

function zhenfaController:onReConnection()
if isometricMapSystem:IsInHome()then
timeEventController.addNormalTimerHandler(2,'zhenfaController',_this)
end
end

function zhenfaController:onNormalUpdate(delay)
local nowTime=timeHelper.getServerShortTime()
local datas=zhenfaModel:getAllStudying()
for i,v in pairs(datas)do
if v.running then
local least=zhenfaModel.calculateLeastTime(v)
if least<0 then
zhenfaModel:stopStudying(v.ubdId)
self:send_3_203(v.sfId,v.ubdId)
end
end
end
end

function zhenfaController.on_home_event(etype)
if etype==homeEvent.eEnterHome then





timeEventController.addNormalTimerHandler(2,'zhenfaController',_this)
elseif etype==homeEvent.eLeaveHome then
timeEventController.removeNormalTimerHandler(2,'zhenfaController')
end
end

function zhenfaController.onDiscipleStateChange(guid,stateType,old,cur)
if stateType==DISCIPLE_STATE_TYPE.edsDispatch then
local bdData=zongmenModel:getDiscipleWorkroom(guid)
if bdData and bdData.build_id==SLG_SYSTEM_TYPE.eTianGongGe then
local sfId=zongmenModel.buildingInMapData[bdData.build_id]
UIManager:invokeUIMethod("UIZhenFaStudyWin","refreshDzState",sfId,bdData.un_build_id)
if zhenfaModel:isStartStudying(bdData.un_build_id)then
if old==true and cur==false then
zhenfaModel:resumeStudying(bdData.un_build_id)
UIManager:invokeUIMethod("UIZhenFaStudyWin","refreshStudying",sfId,bdData.un_build_id)
elseif old==false and cur==true then
zhenfaModel:stopStudying(bdData.un_build_id)
UIManager:invokeUIMethod("UIZhenFaStudyWin","refreshStudying",sfId,bdData.un_build_id)
end
end
end
end
end

function zhenfaController.onDiscipleSpecialityChange(dzguid,specialitytype,specialityid,updatetype)
local bdData=zongmenModel:getDiscipleWorkroom(dzguid)
if bdData and bdData.build_id==SLG_SYSTEM_TYPE.eTianGongGe then
local sfId=zongmenModel.buildingInMapData[bdData.build_id]
local ubdId=bdData.un_build_id
UIManager:invokeUIMethod("UIZhenFaStudyWin","refreshDzState",sfId,ubdId)
if zhenfaModel:isStartStudying(bdData.un_build_id)then
zhenfaModel:refreshStudyingDuration_Building(bdData.un_build_id)
UIManager:invokeUIMethod("UIZhenFaStudyWin","refreshStudying",sfId,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)
end
end
end

function zhenfaController.onDiscipleJobChange(dzguid,jobtype,oldlv,newlv,oldexp,exp)
if jobtype==DISCIPLE_PROSKILL_TYPE.eZhenFa and newlv~=oldlv then
local bdData=zongmenModel:getDiscipleWorkroom(dzguid)
if bdData and bdData.build_id==SLG_SYSTEM_TYPE.eTianGongGe then
local sfId=zongmenModel.buildingInMapData[bdData.build_id]
local ubdId=bdData.un_build_id
UIManager:invokeUIMethod("UIZhenFaStudyWin","refreshDzState",sfId,ubdId)
if zhenfaModel:isStartStudying(bdData.un_build_id)then
zhenfaModel:refreshStudyingDuration_Building(bdData.un_build_id)
UIManager:invokeUIMethod("UIZhenFaStudyWin","refreshStudying",sfId,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)
end
end
end
end

function zhenfaController.on_item_list_changed(args)
for i,v in ipairs(args)do
local itemid=v[3]
local list=zhenfaModel:getZhenFaByActiveCost(itemid)
if list and#list>0 then
local sfId=zongmenModel:getMountainId()
if sfId then
local bdDatas=zongmenModel:getBuildingDataByBdId(sfId,SLG_SYSTEM_TYPE.eTianGongGe)
for i,v in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end
end
end
end



function zhenfaController:send_3_201()
socketManager:send_3_201()
end




function zhenfaController:send_3_202(sfId,ubdId,zfId)
socketManager:send_3_202(sfId,ubdId,zfId)
end



function zhenfaController:send_3_203(sfId,ubdId)
socketManager:send_3_203(sfId,ubdId)
end






function zhenfaController.recv_3_201(bdLen,bdList,zfLen,zfList)

if zfLen>0 then
for i,v in ipairs(zfList)do
zhenfaModel:setZhenFaData(v.param_1,v.param_2)
end
end
if bdLen>0 then
for i,v in ipairs(bdList)do
zhenfaModel:setStudyingData(v.buildguid,v.sfid,v.zhenfaid,v.timeList,v.acceleratetime)
end
end
zhenfaModel:initZhenFaAtiveCost()
zhenfaModel.isInit=true

local sfId=zongmenModel:getMountainId()
if sfId then
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,SLG_SYSTEM_TYPE.eTianGongGe)
for i,v in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end
end





function zhenfaController.recv_3_202(sfId,ubdId,zfId,res)
local zfCfg=cfgHelper.get1(cfg_zhenfaconfig_get,zfId)
if res==0 then
local currLv=zhenfaModel:getZhenFaData(zfId)
local lvCfg=zfCfg.level[currLv]
if lvCfg[2]>0 then
zhenfaModel:startStudying(ubdId,sfId,zfId)
UIManager.info("研究开始")
reddotControl.on_zhenfa_studying_changed(zfId,ubdId,1)
else
UIManager.info(FMT.fmt("{0}激活成功",zfCfg.name))
zhenfaModel:setZhenFaData(zfId,currLv+1)
UIManager:invokeUIMethod("UIZhenFaLevelUpWin","refreshItem",sfId,ubdId,zfId,true)
reddotControl.on_zhenfa_studying_changed(zfId,ubdId,2)
end

UIManager:invokeUIMethod("UIZhenFaStudyWin","refreshStudying",sfId,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)
elseif res==1 then
UIManager.error("消耗不足")
elseif res==2 then
UIManager.error("天工阁等级不足")
elseif res==3 then
UIManager.error("在其他建筑升级中")
elseif res==4 then
UIManager.error(FMT.fmt("阵法{0}已满级",zfCfg.name))
elseif res==5 then
UIManager.error("弟子在忙")
end
end




function zhenfaController.recv_3_203(sfId,ubdId,res)
if res==0 then
local studying=zhenfaModel:getStudyingData(ubdId)
local zfId=studying.zfId
local currLv=zhenfaModel:getZhenFaData(zfId)
zhenfaModel:clearStudyingData(ubdId)
zhenfaModel:setZhenFaData(zfId,currLv+1)

UIManager:invokeUIMethod("UIZhenFaStudyWin","refreshStudying",sfId,ubdId)
UIManager:invokeUIMethod("UIZhenFaLevelUpWin","refreshItem",sfId,ubdId,zfId,false)
hudControl:refreshBuildingStatusHUD(ubdId)
reddotControl.on_zhenfa_studying_changed(zfId,ubdId,2)
elseif res==1 then
UIManager.error("时间不足")
elseif res==2 then
UIManager.error("无正在升级的阵法")
end
end

















