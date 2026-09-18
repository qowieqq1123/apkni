
local loaddatatable=nil
function taskModel:clearData_ExplorWinTask()
loaddatatable=nil
end

function taskModel:onEnterState_ExplorWinTask()
loaddatatable=nil
end

function taskModel:GetAllCanAccept()
local taskList=taskModel:getTaskList()
local list={}
for i,v in ipairs(taskList)do
local fit=false
local systemZM_ID=systemZongMenModel:getTaskBelong(v.taskid)
local systemZM_Info=systemZM_ID~=nil and systemZongMenModel:findInfoDataById(systemZM_ID)or nil
if systemZM_ID==nil or(systemZM_Info~=nil and systemZM_Info.relation_num~=systemZongMenRelationType.eDiDui)then
local taskstate=taskModel:getTaskState_transfromstate(v)
if taskstate==taskModel.taskAcceptState then
if taskModel:fitAcceptCondition(v.taskid)then
if taskModel:isXianJieTask(v.taskline)then
fit=true
local accept_npc=v.cfg.accept_npc
if accept_npc then
if taskModel:JudeNPCIsInCloud(accept_npc)then
fit=false
end
if taskModel:JudeNPCForceNotOpen(accept_npc)then
fit=false
end
end
end
end
end
end
if fit then
table_insert(list,v)
end
end
return list
end


function taskModel:GetAllChengjiu()
local taskList=taskModel:getTaskList()
local list={}
for i,v in ipairs(taskList)do
local fit=false

local systemZM_ID=systemZongMenModel:getTaskBelong(v.taskid)
local systemZM_Info=systemZM_ID~=nil and systemZongMenModel:findInfoDataById(systemZM_ID)or nil
if systemZM_ID==nil or(systemZM_Info~=nil and systemZM_Info.relation_num~=systemZongMenRelationType.eDiDui)then
local taskstate=taskModel:getTaskState_transfromstate(v)
if taskstate~=taskModel.taskAcceptState then
local cfg=taskModel:getTaskConfig(v.taskid)
if cfg.tasklineid>=5001 and cfg.tasklineid<=5200 then
fit=true
end
end
end

if fit then
table_insert(list,v)
end
end
local cjlist=cfgHelper.get2(cfg_taskbaseconfig_get,1,'task_chengjiu')
local xjcjlist=cjlist[1]
local finishlist={}
for k,v in ipairs(xjcjlist)do
if taskModel:checkTaskFinish(v)then
table_insert(finishlist,v)
end
end

return list,finishlist
end

function taskModel:GetChengjiuNum()
local list,finishilist=taskModel:GetAllChengjiu()
local num=#finishilist
local allnum=#list+#finishilist
return allnum,num
end


function taskModel:SetNewExplorationTask(taskid,taskline,taskstate)
local isxianjie=taskModel:isXianJieTask(taskline)
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.showInMenu==false or not isxianjie or not taskcfg.accept_npc then
return
end
local Explor_datatable=taskModel:Initloaddatatable()
local taskidstring=tostring(taskid)
if Explor_datatable[taskidstring]==false then
return
end

if taskstate==taskModel.taskAcceptState then
taskModel:SaveExplor_newtask(taskid,true)
end

end


function taskModel:ClearExplor_newtask()
local Explor_datatable=taskModel:Initloaddatatable()
local canaccept=taskModel:GetAllCanAccept()
if next(Explor_datatable)then
local fit=false
for k,v in ipairs(canaccept)do
local taskidstring=tostring(v.taskid)
if Explor_datatable[taskidstring]then
Explor_datatable[taskidstring]=false
fit=true
end
end
if fit then
userActorArraySetting.set(ACTOR_SETTING_TYPE.eTask,'Explor_newtask',Explor_datatable)
userActorArraySetting.flushDelay(ACTOR_SETTING_TYPE.eTask)
UIManager:invokeUIMethod('UIXianJieExplorationWin','refreshAllMenuItemSingleReddot',3)
end
end
end


function taskModel:SaveExplor_newtask(taskid,flag)
if taskid then
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.showInMenu==false then
return
end
end
local datatable=taskModel:Initloaddatatable()
local taskidstring=tostring(taskid)
datatable[taskidstring]=flag
userActorArraySetting.set(ACTOR_SETTING_TYPE.eTask,'Explor_newtask',datatable)
userActorArraySetting.flushDelay(ACTOR_SETTING_TYPE.eTask)
UIManager:invokeUIMethod('UIXianJieExplorationWin','refreshAllMenuItemSingleReddot',3)
end


function taskModel:loadExplor_newtask()
local datatable=userActorArraySetting.get(ACTOR_SETTING_TYPE.eTask,'Explor_newtask',false)
return datatable or{}
end


function taskModel:Explor_newtaskreddot()
local canaccept=taskModel:GetAllCanAccept()
local Explor_datatable=taskModel:Initloaddatatable()
for k,v in ipairs(canaccept)do
local taskidstring=tostring(v.taskid)
if Explor_datatable[taskidstring]then
return true
end
end
return false
end

function taskModel:Initloaddatatable()
if not loaddatatable then
loaddatatable=taskModel:loadExplor_newtask()
end
return loaddatatable
end

function taskModel:GetisExplor_newtask(taskid)
local datatable=taskModel:Initloaddatatable()

local taskidstring=tostring(taskid)
return datatable[taskidstring]
end

function taskModel:GetChengjiuReddot()
local list=taskModel:GetAllChengjiu()
for k,v in ipairs(list)do
local taskstate=taskModel:getTaskState_transfromstate(v)
if taskstate==taskModel.taskRewardState then
return true
end
end
return false
end

function taskModel:explorTaskAllreddot()
return taskModel:GetChengjiuReddot()or taskModel:Explor_newtaskreddot()
end
