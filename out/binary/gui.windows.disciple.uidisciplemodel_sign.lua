








local _signList={}

function UIDiscipleModel:setDiscipleSign(guid,signType,endTime)
local list=_signList[signType]
if list==nil then
list={}
_signList[signType]=list
end
local guidStr=tostring(guid)
list[guidStr]=endTime or-1
end

function UIDiscipleModel:clearDiscipleSign(guid,signType)
local list=_signList[signType]
if list then
local guidStr=tostring(guid)
list[guidStr]=nil
end
end

function UIDiscipleModel:clearDiscipleSignType(signType)
local list=_signList[signType]
if list then
table.clear(list)
end
end

function UIDiscipleModel:haveDiscipleSign(guid,signType)
local list=_signList[signType]
if list then
local guidStr=tostring(guid)
return list[guidStr]~=nil
end
return false
end

function UIDiscipleModel:getDiscipleSignEndTime(guid,signType)
local list=_signList[signType]
if list then
local guidStr=tostring(guid)
return list[guidStr]
end
end

function UIDiscipleModel:getDiscipleFinishSign()
local nowTime=timeHelper.getServerShortTime()
local finishs={}
for signType,list in pairs(_signList)do
for guidStr,endTime in pairs(list)do
if endTime>0 and nowTime>endTime then
table.insert(finishs,{guidStr,signType})
end
end
end
return finishs
end

function UIDiscipleModel:resetAllDiscipleSign()
table.clear(_signList)
end