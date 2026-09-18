







local _LuaHelper=CS.LuaHelper

activitiesHandle_huiyingpintu=new_activitiesHandle('activitiesHandle_huiyingpintu',activitiesHandle)









local showRewards
local battleRecv
local qiyudata
local _Count=24




function activitiesHandle_huiyingpintu:onEnterState()

notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function activitiesHandle_huiyingpintu:onLeaveState()
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
end

function activitiesHandle_huiyingpintu:get_showRewards()
return showRewards
end


function activitiesHandle_huiyingpintu.recv_249_118(...)














local args={...}
args=args[1]
local subType=SUB_ACTIVITY_TYPE.ePaintedPuzzle
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.puzzle_id=args[3]
data.debris_progress=args[4]
data.use_times=args[5]
data.taskList={}
if args[6]and args[6]>0 then
for k,v in ipairs(args[7])do
data.taskList[v.task_id]=v
end
end
data.has_recv_idx=args[8]
data.debrisList={}
if args[9]and args[9]>0 then
data.debrisList=args[10]
end
data.recv_puzzle_id=args[11]or 0
data.chooseid=0

data.recvList={}
if args[12]>0 then
data.recvList=args[13]
end

activitiesModel:setSubActInfoData(actID,subType,subID,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_huiyingpintu.recv_249_119(...)



local args={...}
local subType=SUB_ACTIVITY_TYPE.ePaintedPuzzle
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.has_recv_idx=args[3]
activitiesModel:setSubActInfoData(actID,subType,subID,data)

UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshProgress')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_huiyingpintu.recv_249_120(...)




local args={...}
local subType=SUB_ACTIVITY_TYPE.ePaintedPuzzle
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

local task_id=args[3]
local new_task_idx=args[4]
if task_id and new_task_idx then
if data.taskList and data.taskList[task_id]then
data.taskList[task_id].task_idx=new_task_idx
data.taskList[task_id].task_progress=0
data.use_times=data.use_times+1
end
end
activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod('UISubAct_HYPTTaskWin','playeffec')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshTask')
UIManager:invokeUIMethod('UISubAct_HYPTTaskWin','refreshdata',{actID,subType,subID,task_id})
end


function activitiesHandle_huiyingpintu.recv_249_122(...)





local args={...}
local subType=SUB_ACTIVITY_TYPE.ePaintedPuzzle
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

local newaddlist={}
local debrisindexArry={}
if args[3]and args[3]>0 then

if args[4]then
local oldtasklist=data.taskList
for k,v in ipairs(args[4])do
debrisindexArry[#debrisindexArry+1]=v

if oldtasklist[v.task_id]then
data.taskList[v.task_id]=v
else
data.taskList[#data.taskList+1]=v
end
end
end
end
activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)




if#debrisindexArry>0 then
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshGridSinglebyUnlock',debrisindexArry)
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshTask')
end
end


function activitiesHandle_huiyingpintu.recv_249_123(...)



local args={...}
local subType=SUB_ACTIVITY_TYPE.ePaintedPuzzle
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.puzzle_id=args[3]
if args[3]then
data.debrisList={}
data.recvList={}
data.taskList={}
end
activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','cleanAllAnimationTween')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','reseatDebrisTypeData')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','initDebris')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','PinTuRewards')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshDebris')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshGridReddot')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshTask')
end


function activitiesHandle_huiyingpintu.recv_249_124(...)



local args={...}
local subType=SUB_ACTIVITY_TYPE.ePaintedPuzzle
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.recv_puzzle_id=args[3]
activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','checkOpenNewPinTu')
end


function activitiesHandle_huiyingpintu.recv_249_125(...)




local args={...}
local subType=SUB_ACTIVITY_TYPE.ePaintedPuzzle
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

if args[3]and args[3]>0 then
if args[4]then
local taskList=data.taskList


for k,v in ipairs(args[4])do
data.recvList[#data.recvList+1]=v.param_2
end


local newtaskList={}
for k,v in ipairs(taskList)do
table.insert(newtaskList,{v,0})
end
for k,v in ipairs(newtaskList)do
for i,j in ipairs(args[4])do
if k==j.param_1 then
v[2]=1
end
end
end


local taskListNew={}
local debrisindex={}
for k,v in ipairs(newtaskList)do
if v[2]==0 then
taskListNew[#taskListNew+1]=v[1]
else
debrisindex[#debrisindex+1]=v[1].debris_idx
data.debrisList[#data.debrisList+1]=v[1].debris_idx
data.debris_progress=data.debris_progress+1
end
end
data.taskList=taskListNew



activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)


if#debrisindex>0 then
for k,v in ipairs(debrisindex)do
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshGridSinglebyReward',v)
end
end
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshTask')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshProgress')










if data.specialPrize then
local list=data.specialPrize or{}
local conf={}
for i,v in ipairs(list)do
table.insert(conf,{itemid=v.itemid,num=v.num})
end
showPrizeControl.showWindow(conf,function()
local debrisList=data.debrisList
if#debrisList>=_Count then
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','setpintumap')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','checkOpenNewPinTu')
end
end)
end

end
end
end


function activitiesHandle_huiyingpintu.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.ePaintedPuzzle then



if effectData and prizelist then
local subType=SUB_ACTIVITY_TYPE.ePaintedPuzzle
local actID=effectData.actid
local subID=effectData.act2id
local task_len=effectData.task_len
local taskList_arry=effectData.taskList

local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end
data.specialPrize={}
data.specialPrize=prizelist
if task_len and task_len>0 and taskList_arry then
local taskList=data.taskList


for k,v in ipairs(taskList_arry)do
data.recvList[#data.recvList+1]=v.param_2
end


local newtaskList={}
for k,v in ipairs(taskList)do
table.insert(newtaskList,{v,0})
end
for k,v in ipairs(newtaskList)do
for i,j in ipairs(taskList_arry)do
if k==j.param_1 then
v[2]=1
end
end
end


local taskListNew={}
local debrisindex={}
for k,v in ipairs(newtaskList)do
if v[2]==0 then
taskListNew[#taskListNew+1]=v[1]
else
debrisindex[#debrisindex+1]=v[1].debris_idx
data.debrisList[#data.debrisList+1]=v[1].debris_idx
data.debris_progress=data.debris_progress+1
end
end
data.taskList=taskListNew



activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)


if#debrisindex>0 then
for k,v in ipairs(debrisindex)do
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshGridSinglebyReward',v)
end
end
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshTask')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','refreshProgress')










if data.specialPrize then
local list=data.specialPrize or{}
local conf={}
for i,v in ipairs(list)do
table.insert(conf,{itemid=v.itemid,num=v.num})
end
showPrizeControl.showWindow(conf,function()
local debrisList=data.debrisList
if#debrisList>=_Count then
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','checkOpenNewPinTu')
UIManager:invokeUIMethod('UISubAct_HuiYingPinTuWin','setpintumap')
end
end)
end
end


end
end
end


function activitiesHandle_huiyingpintu.checkdebrisreddot(actID,subType,subid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local isreddot=false
if mydata then
local debrisList=mydata.debrisList
if#debrisList<_Count then
local max_task_len=cfg_paintedpuzzleactivityconfig_get(subid).max_task_len or 3
local taskList=mydata.taskList
if#taskList<max_task_len then
isreddot=true
end
if(#debrisList+#taskList)==_Count then
isreddot=false
end
end
end

return isreddot
end


function activitiesHandle_huiyingpintu.checkrewardreddot(actID,subType,subid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local isreddot=false
if mydata then
local taskList=mydata.taskList
if taskList and#taskList>0 then
for k,v in ipairs(taskList)do
local task_pools=cfg_paintedpuzzleactivityconfig_get(subid).task_pools
local task_idx=v.task_idx
local jindu=task_pools[task_idx][1][2]
if v.task_progress>=jindu then
isreddot=true
break
end
end
end
end

return isreddot
end


function activitiesHandle_huiyingpintu.checkjindureddot(actID,subType,subid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local progress_rewards=cfg_paintedpuzzleactivityconfig_get(subid).debris_progress_rewards
local has_recv_idx=mydata.has_recv_idx
local debris_progress=mydata.debris_progress
local idx=0
for k,v in ipairs(progress_rewards)do
if debris_progress>=v[1]then
idx=k
end
end

if has_recv_idx<idx then
return true
else
return false
end
end


function activitiesHandle_huiyingpintu.checkpintuboxreddot(actID,subType,subid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local puzzle_id=mydata.puzzle_id
local debrisList=mydata.debrisList
local recv_puzzle_id=mydata.recv_puzzle_id
local isfinish=#debrisList>=_Count
local isreward=puzzle_id==recv_puzzle_id

if isfinish and not isreward then
return true
else
return false
end
end


function activitiesHandle_huiyingpintu.checknextTureddot(actID,subType,subid)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subid)
local debrisList=mydata.debrisList
local puzzle_id=mydata.puzzle_id
local recv_puzzle_id=mydata.recv_puzzle_id
local recvList=mydata.recvList
local cfg_puzzle=cfg_paintedpuzzleactivityconfig_get(subid).puzzle
local isfinish=#debrisList>=_Count
local isreddt=false
if isfinish and#recvList>=24 then
if#cfg_puzzle~=puzzle_id then
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
local startday=sub_actInfo:getOpenDayIndex()
local nextday=cfg_puzzle[puzzle_id+1][1]
if startday>=nextday then
if puzzle_id==recv_puzzle_id then
isreddt=true
end
end
end
end

return isreddt
end
