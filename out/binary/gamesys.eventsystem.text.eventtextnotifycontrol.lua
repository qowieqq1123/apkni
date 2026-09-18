




eventTextNotifyControl=gameState.addListener({})

local _funcList={}
local _lookup={}
local _leaveState=true

function eventTextNotifyControl:onAppStart()

end

function eventTextNotifyControl:onEnterState()
_leaveState=false
end

function eventTextNotifyControl:onLeaveState()
_leaveState=true
end

function eventTextNotifyControl.register(mainType,subTypeList,func)
for i,subType in ipairs(subTypeList)do
eventTextNotifyControl.registerSingle(mainType,subType,func)
end
end

function eventTextNotifyControl.registerSingle(mainType,subType,func)
local lastVal=_lookup[func]
local val=mainType*10000+subType
if val==lastVal then return end
_lookup[func]=val
if _funcList[mainType]==nil then _funcList[mainType]={}end
if _funcList[mainType][subType]==nil then _funcList[mainType][subType]={}end
local list=_funcList[mainType][subType]
list[#list+1]=func
end

function eventTextNotifyControl.unregister(mainType,subTypeList,func)
if _lookup[func]==nil then return end
_lookup[func]=nil
if _funcList[mainType]==nil then _funcList[mainType]={}end

for _,subType in ipairs(subTypeList)do
if _funcList[mainType][subType]==nil then _funcList[mainType][subType]={}end
local list=_funcList[mainType][subType]
for i,v in ipairs(list)do
if v==func then
table.remove(list,i)
break
end
end
end
end


function eventTextNotifyControl.updateText(mainType,subType,eventid,txt,paramList,timeStamp)

if _leaveState==true then return end
if _funcList[mainType]==nil then return end
if _funcList[mainType][subType]==nil then return end
local list=_funcList[mainType][subType]
for _,func in ipairs(list)do
func(txt,eventid,paramList,timeStamp,mainType,subType)
end
end
