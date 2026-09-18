






local _MODULENAME="xianjiexianbangModel"


def_table(_MODULENAME)
xianjiexianbangModel.name=_MODULENAME
xianjiexianbangModel.data={}

function xianjiexianbangModel:onAppStart()

end


function xianjiexianbangModel:onEnterState(isReconnect)
self.data.taskList={}
end


function xianjiexianbangModel:onProtocolReq()

end


function xianjiexianbangModel:onLeaveState(isReconnect)

self.data={}
end



function xianjiexianbangModel:initdata(agr1,agr2,agr3,agr4,agr5)
self.data.xbLevel=agr1
self.data.finishNum=agr2
self.data.refreshTime=agr3
self.data.taskList={}
if agr4>0 and agr5 then
self.data.taskList=agr5
end
end


function xianjiexianbangModel:setXBrwFlag(agr1,agr2,agr3,agr4)
if agr1>0 and agr2 then
if self.data.taskList and#self.data.taskList>0 then
local temp={}
for k,olddata in ipairs(self.data.taskList)do
local ishave=true
for i,newtaskid in ipairs(agr2)do
if olddata.taskId==newtaskid then
ishave=false
end
end
if ishave then
temp[#temp+1]=olddata
end
end
self.data.taskList=temp
end
end


self.data.finishNum=agr3
self.data.xbLevel=agr4
end


function xianjiexianbangModel:freshOldTaskDataXB(agr1,agr2,agr3)
if self.data.taskList and#self.data.taskList>0 then
local temp=
{
taskId=agr1,
failFlag=agr2,
finishFlag=agr3
}

for k,v in ipairs(self.data.taskList)do
if v.taskId and v.taskId==agr1 then
self.data.taskList[k]=temp
break
end
end
end

end








function xianjiexianbangModel:freshXBNewTaskData(agr1,agr2,agr3)
local needrefreshFlag=false
if self.data.refreshTime and self.data.refreshTime~=0 then
needrefreshFlag=self.data.refreshTime~=agr1
end

self.data.refreshTime=agr1
if agr2>0 and agr3 then
if self.data.taskList then
if needrefreshFlag then
local newtable={}
for k,v in ipairs(self.data.taskList)do
if tostring(v.actorId)=='0'then
table.insert(newtable,v)
end
end
self.data.taskList=newtable
end
for k,v in ipairs(agr3)do








table.insert(self.data.taskList,v)
end
end
end
end

function xianjiexianbangModel:setXBtaskDoingflag(taskId,runFlag)
if self.data.taskList then
for k,v in ipairs(self.data.taskList)do
if v.taskId==taskId then
self.data.taskList[k].runFlag=runFlag
end
end
end
end


function xianjiexianbangModel:getXBTaskData()
return self.data.taskList
end

function xianjiexianbangModel:getXBLevel()
return self.data.xbLevel or 1
end

function xianjiexianbangModel:getXBfinishNum()
return self.data.finishNum or 0
end

function xianjiexianbangModel:getXBrefreshTime()
return self.data.refreshTime or 0
end


function xianjiexianbangModel:getXBTaskDatabyId(taskId)
if self.data.taskList then
for k,v in ipairs(self.data.taskList)do
if v.taskId==taskId then
return v
end
end
end
return false
end


function xianjiexianbangModel:getXBTaskDataOfTC()
local list={}
if self.data.taskList then
for k,v in ipairs(self.data.taskList)do
if v.finishFlag==0 then
table.insert(list,v)
end
end
end
return list
end


function xianjiexianbangModel:XBXDThavetasksReddot()
local isreddot=false
if self.data.taskList then
for k,v in ipairs(self.data.taskList)do
if v.finishFlag==1 then
isreddot=true
break
else
if v.runFlag and v.runFlag~=1 then
isreddot=true
break
end
end
end
end
return isreddot
end

function xianjiexianbangModel:XBhavetasksReddot()
local isreddot=false
local flag=0
if self.data.taskList then
for k,v in ipairs(self.data.taskList)do
if v.finishFlag==1 then
isreddot=true
flag=1
break
else
if v.runFlag and v.runFlag~=1 then
isreddot=true
flag=2
end
end
end
end
local reddotflag=xianguanModel:getSelecttask()
if reddotflag then
isreddot=true
flag=2
end

return isreddot,flag
end

function xianjiexianbangModel:refreshYJYHUD()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eXianBang)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end


function xianjiexianbangModel:getHaveTaskNum()
local num=0
if self.data.taskList then
for k,v in ipairs(self.data.taskList)do
if v.finishFlag==0 then
num=num+1
end
end
end
return num
end

function xianjiexianbangModel:freshwindata()
UIManager:invokeUIMethod("UIXianJieMainWin","refreshXianbangBtn")
end


function xianjiexianbangModel:changetimes(time)
local odian=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())-time
local num=math.abs(odian)


end


function xianjiexianbangModel:getTaskRewardReddot()
if self.data.taskList then
for k,v in ipairs(self.data.taskList)do
if v.finishFlag==1 then
return true
end
end
end
return false
end
