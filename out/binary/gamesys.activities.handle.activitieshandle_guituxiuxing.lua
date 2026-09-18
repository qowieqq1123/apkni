







activitiesHandle_guituxiuxing=new_activitiesHandle('activitiesHandle_guituxiuxing',activitiesHandle)

function activitiesHandle_guituxiuxing:onInit()

end

function activitiesHandle_guituxiuxing:onDelete()

end

function activitiesHandle_guituxiuxing.recv_249_127(arg)
local actId=arg[1]
local subId=arg[2]
local taskLen=arg[3]
local taskList=arg[4]
local libaoLen=arg[5]
local libaoList=arg[6]
local maxGotJF=arg[7]
local nowJF=arg[8]

local subType=SUB_ACTIVITY_TYPE.eGuiTuXiuXing

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data then
return
end
data.taskList={}
if taskLen>0 then
for i,v in ipairs(taskList)do
local day=v.day
if not data.taskList[day]then
data.taskList[day]={}
end

local taskId=v.taskId
local finishNum=mathHelper.int64_to_number(v.finishNum)
v.finishNum=finishNum
data.taskList[day][taskId]=v
end
end

data.libaoList={}
if libaoLen>0 then
for i,v in ipairs(libaoList)do
local day=v.day
if not data.libaoList[day]then
data.libaoList[day]={}
end

local libaoId=v.lbId
data.libaoList[day][libaoId]=v
end
end

data.maxGotJF=maxGotJF
data.nowJF=nowJF

activitiesModel:setSubActInfoData(actId,subType,subId,data)


local win=UIManager:findActiveWindow('UISubAct_GuiTuXiuXingWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_guituxiuxing.recv_249_128(actId,subId,len,taskList,nowJF)
local subType=SUB_ACTIVITY_TYPE.eGuiTuXiuXing

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data or not data.taskList then

return
end
if len>0 then
for i,v in ipairs(taskList)do
local day=v.day
if not data.taskList[day]then
data.taskList[day]={}
end

local taskId=v.taskId
local finishNum=mathHelper.int64_to_number(v.finishNum)
v.finishNum=finishNum
data.taskList[day][taskId]=v
end
end
data.nowJF=nowJF

activitiesModel:setSubActInfoData(actId,subType,subId,data)


local win=UIManager:findActiveWindow('UISubAct_GuiTuXiuXingWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_guituxiuxing.recv_249_129(actId,subId,len,libaoList)
local subType=SUB_ACTIVITY_TYPE.eGuiTuXiuXing

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data then
return
end

if len>0 then
for i,v in ipairs(libaoList)do
local day=v.day
if not data.libaoList[day]then
data.libaoList[day]={}
end

local libaoId=v.lbId
data.libaoList[day][libaoId]=v
end
end

activitiesModel:setSubActInfoData(actId,subType,subId,data)


local win=UIManager:findActiveWindow('UISubAct_GuiTuXiuXingWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_guituxiuxing.recv_249_149(actId,subId,maxGotJF)

local subType=SUB_ACTIVITY_TYPE.eGuiTuXiuXing

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data then
return
end

data.maxGotJF=maxGotJF
activitiesModel:setSubActInfoData(actId,subType,subId,data)


local win=UIManager:findActiveWindow('UISubAct_GuiTuXiuXingWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end