






local _MODULENAME="XianjieXuanShangController"

gameState.addListener(def_table(_MODULENAME))

XianjieXuanShangController.name=_MODULENAME
XianjieXuanShangController.data={}

XJXSzmtype=
{
normalzm=1,
juqingzm=2,
}


function XianjieXuanShangController:onAppStart()
XianjieXuanShangModel:onAppStart()

socketManager:register_receiver(7,55,self.recv_7_55)
socketManager:register_receiver(7,56,self.recv_7_56)
socketManager:register_receiver(7,57,self.recv_7_57)
socketManager:register_receiver(7,58,self.recv_7_58)
socketManager:register_receiver(7,59,self.recv_7_59)
socketManager:register_receiver(7,60,self.recv_7_60)
socketManager:register_receiver(7,61,self.recv_7_61)

end


function XianjieXuanShangController:onEnterState(isReconnect)
XianjieXuanShangModel:onEnterState()
end


function XianjieXuanShangController:onProtocolReq()
XianjieXuanShangModel:onProtocolReq()
end


function XianjieXuanShangController:onLeaveState(isReconnect)
XianjieXuanShangModel:onLeaveState(isReconnect)

self.data={}
end


function XianjieXuanShangController:onLostConnection()

end


function XianjieXuanShangController:onReConnection(isInitPro)

end


function XianjieXuanShangController:send_7_55()
socketManager:send_7_55()
end

function XianjieXuanShangController:send_7_56(taskId,zmGuid,taskIndex)
socketManager:send_7_56(taskId,zmGuid,taskIndex)
end

function XianjieXuanShangController:send_7_57(taskId)
socketManager:send_7_57(taskId)
end

function XianjieXuanShangController:send_7_58(assistant)
socketManager:send_7_58(assistant or 0)
end

function XianjieXuanShangController:send_7_59(len,list)
socketManager:send_7_59(len,list)
end

function XianjieXuanShangController:send_7_60(taskId)
socketManager:send_7_60(taskId)
end



function XianjieXuanShangController.recv_7_55(data)

XianjieXuanShangModel:getXJTaskData(data[1],data[2],data[3],data[4],data[5],data[6])
end

function XianjieXuanShangController.recv_7_56(datas)
XianjieXuanShangModel:getXJTaskDataAccess(datas[1],datas[2],datas[3],datas[4],datas[5],datas[6],datas[7])
local idxlist={}
if datas[6]then
idxlist[#idxlist+1]=datas[6]
end
if#idxlist>0 then
UIManager.info("任务已接取")
UIManager:invokeUIMethod("UIXianjieXuanShangWin","refreshinfo",idxlist)
UIManager:invokeUIMethod("UIXianjieXuanShangWin","freshSYnum")
end
XianjieXuanShangController:refreshXuanShangHUD()
end

function XianjieXuanShangController.recv_7_57(data1,data2)
local idxlist={}
if data1 and data2 then
local taskdata=XianjieXuanShangModel:getTaskDataSinglebyTaskid(data1)
if taskdata and taskdata.taskIndex then
idxlist[#idxlist+1]=taskdata.taskIndex
end
end
XianjieXuanShangModel:getXJTaskDataFinish(data1,data2)
if#idxlist>0 then
UIManager.info("任务已完成")
UIManager:invokeUIMethod("UIXianjieXuanShangWin","refreshinfo",idxlist)
end
XianjieXuanShangController:refreshXuanShangHUD()
end

function XianjieXuanShangController.recv_7_58(data1,data2,assistant)
local idxlist={}
if data1>0 and data2 then
for k,v in ipairs(data2)do
local taskdata=XianjieXuanShangModel:getTaskDataSinglebyTaskid(v)
if taskdata and taskdata.taskIndex then
idxlist[#idxlist+1]=taskdata.taskIndex
end
end
end
XianjieXuanShangModel:getXJTaskDataReward(data1,data2)
if#idxlist>0 then
UIManager:invokeUIMethod("UIXianjieXuanShangWin","refreshinfo",idxlist)
end
XianjieXuanShangController:refreshXuanShangHUD()
if assistant==1 then
XianjieXuanShangController:againDispatch()
end
end

function XianjieXuanShangController.recv_7_59(data1,data2,data3,data4)
local idxlist={}
if data1>0 and data2 then
for k,v in ipairs(data2)do
if v.taskIndex then
idxlist[#idxlist+1]=v.taskIndex
end
end
end
XianjieXuanShangModel:getXJTaskDataChangeTask(data1,data2,data3,data4)
if#idxlist>0 then
UIManager.info("任务已接取")
UIManager:invokeUIMethod("UIXianjieXuanShangWin","refreshinfo",idxlist)
UIManager:invokeUIMethod("UIXianjieXuanShangWin","freshSYnum")
end
XianjieXuanShangController:refreshXuanShangHUD()
end

function XianjieXuanShangController.recv_7_60(data1,data2,data3)
local idxlist={}
if data1 then
local taskdata=XianjieXuanShangModel:getTaskDataSinglebyTaskid(data1)
if taskdata and taskdata.taskIndex then
idxlist[#idxlist+1]=taskdata.taskIndex
end
end
XianjieXuanShangModel:getXJTaskDataAbandon(data1,data2,data3)
if#idxlist>0 then

UIManager.info("任务已取消")
UIManager:invokeUIMethod("UIXianjieXuanShangWin","refreshinfo",idxlist)
end
UIManager:invokeUIMethod("UIXianjieXuanShangWin","freshSYnum")
XianjieXuanShangController:refreshXuanShangHUD()
end

function XianjieXuanShangController.recv_7_61(data1,data2,data3)
XianjieXuanShangModel:getXJZongMenTeZhi(data1,data2,data3)
end


function XianjieXuanShangController:closeXJXSwin(flag)
if flag==1 then
UIManager:closeWindow("UIXianjieXSselectWin")
elseif flag==2 then
UIManager:closeWindow("UIXianjieXSselectWin")
else
UIManager:closeWindow("UIXianjieXSzongmenWin")
UIManager:closeWindow("UIXianjieXSselectWin")
end
end

function XianjieXuanShangController:changeXJXSsystm()
local check=systemModel.isOpen(SYSTEM_DEFINE.eXianJieXuanShangTai)
if check then
return true
end
return false
end

function XianjieXuanShangController:getTaskTypeDoing()
local tasktype={}

local data=XianjieXuanShangModel:getTaskAllData()
for k,v in pairs(data)do
if v and v.rwFlag==0 and v.taskId then
local taskType=cfg_xianjiexuanshangtaskconfig_get(v.taskId).taskType
tasktype[taskType]=true
end
end
return tasktype
end

function XianjieXuanShangController:getTaskidDoing()
local taskid={}
local data=XianjieXuanShangModel:getTaskAllData()
for k,v in pairs(data)do
if v and v.rwFlag==0 and v.taskId then
taskid[v.taskId]=true
end
end
return taskid
end

function XianjieXuanShangController:getTaskZongMenDoing()
local taskzm={}
local data=XianjieXuanShangModel:getTaskAllData()
for k,v in pairs(data)do
if v and v.zmGuid and v.rwFlag==0 then
taskzm[v.zmGuid]=true
end
end
return taskzm
end


function XianjieXuanShangController:getAllWorldZMdata(oldzmGuid)
local cfg=cfg_worldconfig()
local worlds={}
for i,v in ipairs(cfg)do
if worldBlockModel:getWorldStateCount(v.id,eWorldBlockState.OPEN)>0 then
table.insert(worlds,v.id)
end
end
table.sort(worlds)
local alllist={}
local temp1={}
local temp2={}
local zmDoing=XianjieXuanShangController:getTaskZongMenDoing()
for index,worldId in ipairs(worlds)do
local zmList=systemZongMenModel:findInfoDataByWorld(worldId)
for i,v in ipairs(zmList)do
if v.flag~=systemZongMenFightFlagType.eExpel then
if oldzmGuid and oldzmGuid==v.serial then
local zmCfg=cfgHelper.get1(cfg_syssectconfig_get,v.id)
if zmCfg.type==XJXSzmtype.juqingzm then
table.insert(temp1,v)
elseif zmCfg.type==XJXSzmtype.normalzm then
table.insert(temp2,v)
end
else
if not zmDoing[v.serial]then
local zmCfg=cfgHelper.get1(cfg_syssectconfig_get,v.id)
if zmCfg.type==XJXSzmtype.juqingzm then
table.insert(temp1,v)
elseif zmCfg.type==XJXSzmtype.normalzm then
table.insert(temp2,v)
end
end
end
end
end
end
if#temp1>0 then
for k,v in ipairs(temp1)do
table.insert(alllist,v)
end
end
if#temp2>0 then
for k,v in ipairs(temp2)do
table.insert(alllist,v)
end
end

return alllist
end


function XianjieXuanShangController:checkFreeOrTaskReddot()
local xjxstFreeNum=cfg_zongmenxuanshangtaskbaseconfig_get(1).xjxstFreeNum or 0
return(XianjieXuanShangModel:getfreeNumUse()<xjxstFreeNum)and XianjieXuanShangModel:cangetTask()
end

function XianjieXuanShangController:refreshXuanShangHUD()
if not isometricMapSystem:IsInHome()then
return
end
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXuanShangTai)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end


function XianjieXuanShangController:againDispatch()
local tasklists=XianjieXuanShangModel:getTaskAllData()
local taskidlist={}
for i=1,3 do
local taskdata=tasklists[i]
if taskdata then
local nowstamp=timeHelper.getServerShortTime()
if nowstamp>=taskdata.endTime and taskdata.rwFlag==1 then
taskidlist[#taskidlist+1]=taskdata.taskId
end
end
end

if#taskidlist>0 then
for k,v in ipairs(taskidlist)do
if XianjieXuanShangModel:checkDoneToday(v)then

return
end
end
end
if#taskidlist>0 then
local new_taskidlist={}
local allnum=#taskidlist
local nowfree=XianjieXuanShangModel:getfreeNumUse()
local cfg=cfg_zongmenxuanshangtaskbaseconfig_get(1)
local maxfree=cfg.xjxstFreeNum
local cannum=maxfree-nowfree

if allnum<=cannum then
for k,v in ipairs(taskidlist)do
new_taskidlist[#new_taskidlist+1]=v
end
if#new_taskidlist>0 then
XianjieXuanShangController:send_7_59(#new_taskidlist,new_taskidlist)
end
end
end
end



function XianjieXuanShangController:checkOrderPT(conds,defaultVersionId,pfid)
local cond={}
local cfg=conds[defaultVersionId]or conds[1]
if cfg then
if cfg[-1]then
cond=cfg[-1]
else
if pfid and cfg[pfid]then
cond=cfg[pfid]
end
end
end
return cond
end