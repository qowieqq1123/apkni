






local _MODULENAME="xianYouRuYunModel"


def_table(_MODULENAME)
xianYouRuYunModel.name=_MODULENAME
xianYouRuYunModel.data={}

function xianYouRuYunModel:onAppStart()

end


function xianYouRuYunModel:onEnterState(isReconnect)

end


function xianYouRuYunModel:onProtocolReq()
self:initSuggestLineUpDatas()
end


function xianYouRuYunModel:onLeaveState(isReconnect)

self.data={}
self.taskList={}
self.suggestList={}
end




function xianYouRuYunModel:initTaskProgressDatas(len,list)
if len>0 then
for k,v in ipairs(list)do
local id=v.taskid
if not self.data[id]then self.data[id]={}end
self.data[id].taskRecv=v.taskrecv
self.data[id].taskProgress=v.taskprogress
end
end
end

function xianYouRuYunModel:setTaskDatas(cfg)
local taskId=cfg.id
local type=cfg.tasktype
local params=cfg.params

if not self.data[taskId]then
self.data[taskId]={}
self.data[taskId].taskProgress=0
self.data[taskId].taskRecv=0
end

if type==2 then
local color=params[1]
local num=UIDiscipleModel:getDiscipleColorCountAndList(color)
self.data[taskId].taskProgress=num
elseif type==3 then
local level=params[1]
local num=UIDiscipleModel:getDiscipleJJCountList(level)
self.data[taskId].taskProgress=num
elseif type==4 then
local level=params[1]
local num=UIDiscipleModel:getDiscipleLTCountList(level)
self.data[taskId].taskProgress=num
elseif type==306 then
local num=0
local len=#params

for i=1,len do
local diziId=params[i]
local count=UIDiscipleModel:getSameIdDiscipleCount(diziId)
if count>=1 then num=num+1 end
end

self.data[taskId].taskProgress=num
elseif type==307 then
local num=0
local len=#params

for i=1,len do
local param=params[i]
local d=string.split(param,'_')
local diziId=tonumber(d[1])
local tmLv=tonumber(d[2])
local count,list=UIDiscipleModel:getSameIdDiscipleCountAndList(diziId)

if count>=1 then
local guidinfo=list[1]
local netData=UIDiscipleModel:getDiscipleDataByStr(guidinfo.discipleguidStr)
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(netData)
if dzNowTmLv>=tmLv then num=num+1 end
end
end
self.data[taskId].taskProgress=num
elseif type==308 then
local param=params[1]
local d=string.split(param,'_')
local color=tonumber(d[1])
local jobid=tonumber(d[2])
local num,list=UIDiscipleModel:getDiscipleJobAndColorCount(jobid,color)

self.data[taskId].taskProgress=num
end
end

function xianYouRuYunModel:checkTaskIsOpen(v)
local zmLevel=zongmenModel:getLevel()
local openDays=timeHelper.getServerOpenDay()
local openTime=timeHelper.getServerOpenLongTime()

local check=true
self:setTaskDatas(v)


if v.conditions then
for i,cod in ipairs(v.conditions)do
local type=cod[1]
if type==1 then
local minTime=timeHelper.getDateStamp(cod[2])
local maxTime=timeHelper.getDateStamp(cod[3])
if openTime<minTime or openTime>maxTime then check=false end
elseif type==2 then
if openDays<cod[2]then check=false end
elseif type==3 then
if zmLevel<cod[2]then check=false end
end
end
end


local limitId=v.limitId or nil
if limitId and self.data[limitId]then
if self.data[limitId].taskRecv==0 then
check=false
end
end


local nextId=v.nextId or nil
if nextId then
if self.data[v.id].taskRecv==1 then
check=false
end
end

if check then
local time=v.time
if time then
local min=time[1]
local max=time[2]
local isSuggest=true and time[3]==1 or false

if openDays>=min and openDays<max then
table.insert(self.taskList,v)


if isSuggest then
for i,id in ipairs(v.params)do
if not self.suggestList[id]then self.suggestList[id]={}end

if self.data[v.id].taskRecv==0 then
self.suggestList[id].isNow=true
else
self.suggestList[id].isNow=false
end
self.suggestList[id].list=v.params
self.suggestList[id].jump=v.checkJump
end
end
elseif openDays>=min and openDays>=max then
local taskId=v.id
local cur=self:getTaskProgress(taskId)
local aim=v.num
local isRecv=xianYouRuYunModel:getTaskIsRecv(taskId)


if cur<aim or not isRecv then
table.insert(self.taskList,v)

end


if isSuggest then
for i,id in ipairs(v.params)do
if not self.suggestList[id]then
self.suggestList[id]={}

self.suggestList[id].isNow=false
self.suggestList[id].list=v.params
self.suggestList[id].jump=v.checkJump
end
end
end
end
else
table.insert(self.taskList,v)
self:setTaskDatas(v)
end
end
end


function xianYouRuYunModel:initSuggestLineUpDatas()
self.taskList={}
self.suggestList={}
local config=cfg_xianyouruyunconfig()

for k,v in pairs(config)do
xianYouRuYunModel:checkTaskIsOpen(v)
end




end

function xianYouRuYunModel:refreshNewTask(id)
local config=cfg_xianyouruyunconfig()

if config[id]and config[id].nextId then
local nextId=config[id].nextId
if config[nextId]then
xianYouRuYunModel:checkTaskIsOpen(config[nextId])
end
end
end

function xianYouRuYunModel:getTaskData()
return self.taskList
end

function xianYouRuYunModel:getSuggestDataById(id)
if self.suggestList[id]then
return self.suggestList[id]
end
end

function xianYouRuYunModel:setTaskIsRecv(id)
if not self.data[id]then
self.data[id]={}
end

self.data[id].taskRecv=1
end

function xianYouRuYunModel:getTaskIsRecv(id)
if self.data[id]then
return true and self.data[id].taskRecv==1 or false
else
return false
end
end

function xianYouRuYunModel:getTaskProgress(id)
local cfg=cfgHelper.get1(cfg_xianyouruyunconfig_get,id)
xianYouRuYunModel:setTaskDatas(cfg)

if self.data[id]then
return self.data[id].taskProgress
else
return 0
end
end

function xianYouRuYunModel:getIsReddot()
if self.taskList then
for k,v in ipairs(self.taskList)do
local taskId=v.id
local aimNum=v.num
local curNum=xianYouRuYunModel:getTaskProgress(taskId)
if curNum>=aimNum and self.data[taskId].taskRecv~=1 then return true end
end
end
return false
end

function xianYouRuYunModel:getCanRecvTaskLists()
local list={}
for k,v in ipairs(self.taskList)do
local aimNum=v.num
local curNum=xianYouRuYunModel:getTaskProgress(v.id)

if curNum>=aimNum and not xianYouRuYunModel:getTaskIsRecv(v.id)then
table.insert(list,v.id)
end
end
return list
end