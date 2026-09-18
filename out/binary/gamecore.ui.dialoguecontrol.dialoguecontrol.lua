




dialogueControl=gameState.addListener({})

local _data={}

function dialogueControl:onAppStart()

end

function dialogueControl:onEnterState()
_data={}
_data.tickTimerList={}
_data.checkTagList={}
_data.tickList={}
_data.queueList={}
_data.isCreatePlayer=false
_data.isHold=false
end

function dialogueControl:onLeaveState()
local tickTimerList=_data.tickTimerList
for group,tickTimer in pairs(tickTimerList)do
if tickTimer then
tickTimer:cancel()
end
end
_data={}
_data.tickTimerList={}
_data.checkTagList={}
_data.tickList={}
_data.queueList={}
_data.isCreatePlayer=false
_data.isHold=false
end

function dialogueControl:onPlayerCreate()
_data.isCreatePlayer=true
end

function dialogueControl.clearAllWin()
_data.tickTimerList={}
_data.checkTagList={}
_data.tickList={}
_data.queueList={}
end


function dialogueControl.startTimer(group)
group=group or 0
local tickTimer=_data.tickTimerList[group]
if dialogueControl.count(group)>0 then
if not tickTimer then
_data.tickTimerList[group]=timer.new()
local tick=_data.tickList[group]
if tick==nil then
_data.tickList[group]=function()
dialogueControl.dequeue(group)
end
tick=_data.tickList[group]
end
_data.tickTimerList[group]:start(1,tick)
end
else
dialogueControl:stopTimer(group)
end
end

function dialogueControl:stopTimer(group)
group=group or 0
local tickTimer=_data.tickTimerList[group]
if tickTimer then
_data.tickTimerList[group]:cancel()
end
_data.tickTimerList[group]=nil
end

function dialogueControl.dequeue(group)
if not _data.isCreatePlayer then
return
end
group=group or 0
local count=dialogueControl.count(group)
if count>0 then
if dialogueControl.canContinue(group)then
local val=dialogueControl.outQueue(group,true)
if val then
local name=val[1]
dialogueControl.setCheckTag(group,name,true)
UIManager:showWindowEx(name,val[2])
end
end
if dialogueControl.count(group)<=0 then
dialogueControl:stopTimer(group)
end
else
dialogueControl:stopTimer(group)
end
end

function dialogueControl.enqueue(name,argstable)
local val={name,argstable}
local conf=dialogueConfig.getConfig(name)
if conf then
local group=conf.group or 0
dialogueControl.enterQueue(val,conf)
dialogueControl.startTimer(group)
end
end

function dialogueControl.show(name,argstable)
local group=dialogueConfig.getGroup(name)
if group then
if _data.isCreatePlayer and dialogueControl.canContinue(group)and dialogueControl.outQueue(group,false)==nil and dialogueConfig.checkCnd(name)then
dialogueControl.setCheckTag(group,name,true)
else
dialogueControl.enqueue(name,argstable)
return false
end
end
return true
end

function dialogueControl.delete(name)
local group=dialogueConfig.getGroup(name)
if group then
dialogueControl.setCheckTag(group,name,nil)
end
end



function dialogueControl.setHold(isHold)
_data.isHold=isHold
end

function dialogueControl.canContinue(group)
if fullScreenUI.isActiveFull()then
return false
end
if _data.isHold then
return false
end
local checkTab=_data.checkTagList[group]
if checkTab then
for k,v in pairs(checkTab)do
if checkTab[k]then
return false
end
end
end
return true
end

function dialogueControl.setCheckTag(group,name,flag)
if group==nil then
return
end
local checkTab=_data.checkTagList[group]
if checkTab==nil then
_data.checkTagList[group]={}
end
_data.checkTagList[group][name]=flag
end

function dialogueControl.newQueue(group)
if _data.queueList[group]==nil then
_data.queueList[group]={}
end
return _data.queueList[group]
end

function dialogueControl.enterQueue(info,config)
local group=config.group or dialogueGroupType.eDefault
local groupQueue=dialogueControl.newQueue(group)
config.priority=config.priority or dialoguePriorityType.eDefault
if#groupQueue>50 then
logErr("列表长度中已超过50个")
return
end
groupQueue[#groupQueue+1]={v=info,cof=config}
end

function dialogueControl.sort(group)
local groupQueue=dialogueControl.newQueue(group)
if#groupQueue<=0 then
return
end
table.sort(groupQueue,function(a,b)
local cof=a.cof
local nextcof=b.cof
local cnd=cof.cnd and cof.cnd()or cof.cnd==nil
local nextcnd=nextcof.cnd and nextcof.cnd()or nextcof.cnd==nil
local t1=cnd and 1 or 2
local t2=nextcnd and 1 or 2
if t1~=t2 then
return t1<t2
else
return cof.priority<nextcof.priority
end
end)
end

function dialogueControl.outQueue(group,remove)
local groupQueue=dialogueControl.newQueue(group)
if#groupQueue>0 then
dialogueControl.sort(group)
local val=groupQueue[1]
local cnd=val.cof.cnd
if cnd==nil or cnd and cnd()then
if remove~=false then
table.remove(groupQueue,1)
end
return val.v
end
end
end

function dialogueControl.count(group)
local groupQueue=dialogueControl.newQueue(group)
return#groupQueue
end

