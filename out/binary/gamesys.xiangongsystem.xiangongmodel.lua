






local _MODULENAME="XianGongModel"


def_table(_MODULENAME)
XianGongModel.name=_MODULENAME

function XianGongModel:onAppStart()

end


function XianGongModel:onEnterState(isReconnect)
self.shopAllItemList={}
self.shopItemList={}
self.taskIdList={}
self.taskLookup={}
self.sortFlag=false
self.stageVal=0
self.stageIdx=0
end


function XianGongModel:onProtocolReq()

end


function XianGongModel:onLeaveState(isReconnect)

self.shopAllItemList=nil
self.shopItemList=nil
self.taskIdList=nil
self.taskLookup=nil
self.sortFlag=nil
self.stageVal=nil
self.stageIdx=nil
end

function XianGongModel:initShopItemList()
self.shopItemList={}
self.shopAllItemList=funcShopModel:get_sort_list(eFuncShopType.eXianJieBaoKu)
for i,v in ipairs(self.shopAllItemList or{})do
local cfg=v.cfg
local baoKu=cfg.baoKu
if not self.shopItemList[baoKu]then
self.shopItemList[baoKu]={}
end
table.insert(self.shopItemList[baoKu],cfg)
end
end

function XianGongModel:getShopBaoKuItemList(baoKu)
return self.shopItemList[baoKu]or{}
end

function XianGongModel:initTaskList(data)
self.taskIdList={}
self.taskLookup={}
for i,v in ipairs(data or{})do
local id=v.param_1
local aim_idx=v.param_2
local task_progress=v.param_3
table.insert(self.taskIdList,{taskId=id})
self.taskLookup[id]={aim_idx=aim_idx,task_progress=mathHelper.int64_to_number(task_progress)}
end
self.sortFlag=true
end

function XianGongModel:getSortTaskList()
if self.taskIdList and#self.taskIdList>1 and self.sortFlag then
for i,v in ipairs(self.taskIdList)do
local taskData=XianGongModel:getTaskDataLookup(v.taskId)
local sort=XianGongModel:getTaskSort(v.taskId,taskData.aim_idx,taskData.task_progress)
v.sortVal=sort
end
table.sort(self.taskIdList,function(a,b)
return a.sortVal<b.sortVal
end)
self.sortFlag=false
end
return self.taskIdList
end

function XianGongModel:getTaskSort(id,aim_idx,progress)
local taskCfg=cfgHelper.get1(cfg_xiangongtaskconfig_get,id)
if not taskCfg then
logErr("not find taskCfg, id:",id)
return 0
end
local order=taskCfg.order

if aim_idx>=#taskCfg.taskaims then
return order*1000000
else
local cur_aim_idx=aim_idx+1
local taskaim=taskCfg.taskaims[cur_aim_idx]
local aim_progress=taskaim[1]
if progress>=aim_progress then
return order
else
return order*1000
end
end
end

function XianGongModel:updateTask(id,progress)
if self.taskLookup[id]then
self.taskLookup[id].task_progress=mathHelper.int64_to_number(progress)
self.sortFlag=true
end
end

function XianGongModel:receiveUpdateTask(list)
for i,v in ipairs(list or{})do
local id=v.param_1
local new_aim_idx=v.param_2
if self.taskLookup[id]then
local taskCfg=cfgHelper.get1(cfg_xiangongtaskconfig_get,id)
local old_aim_idx=self.taskLookup[id].aim_idx
for aim_idx=old_aim_idx+1,new_aim_idx do
local taskaim=taskCfg.taskaims[aim_idx]
local taskStageVal=taskaim[3]
self.stageVal=self.stageVal+taskStageVal
end
self.taskLookup[id].aim_idx=new_aim_idx
self.sortFlag=true
end
end
end

function XianGongModel:getTaskDataLookup(id)
return self.taskLookup[id]
end


function XianGongModel:setStageVal(val)
self.stageVal=val
end

function XianGongModel:setStageIdx(idx)
self.stageIdx=idx
end

function XianGongModel:getStageVal()
return self.stageVal
end

function XianGongModel:getMaxStageVal()
local cfg=cfgHelper.get1(cfg_xiangongbaseconfig_get,1)
local stageCfg=cfg.stage
return stageCfg[#stageCfg][1]
end

function XianGongModel:getStageIdx()
return self.stageIdx
end

function XianGongModel:checkXianGongBangYuReddot()

local stageVal=XianGongModel:getStageVal()
local stageIdx=XianGongModel:getStageIdx()
local cfg=cfgHelper.get1(cfg_xiangongbaseconfig_get,1)
local stageCfg=cfg.stage
for i,v in ipairs(stageCfg)do
local target=v[1]
if i>stageIdx and target<=stageVal then
return true
end
end

for taskId,taskData in pairs(self.taskLookup)do
local taskCfg=cfgHelper.get1(cfg_xiangongtaskconfig_get,taskId)
local aim_idx=taskData.aim_idx
local taskProgress=taskData.task_progress
local cur_aim_idx=aim_idx>=#taskCfg.taskaims and aim_idx or(aim_idx+1)
local taskaim=taskCfg.taskaims[cur_aim_idx]
local taskMaxProgress=taskaim[1]
local taskReceiveFlag=aim_idx>=#taskCfg.taskaims
if not taskReceiveFlag and taskProgress>=taskMaxProgress then
return true
end
end
return false
end