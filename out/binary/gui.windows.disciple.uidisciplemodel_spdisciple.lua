








local checkEmptyDataKeyName={
["fightEquipList"]=true,
["livingEquipList"]=true,
["gongfaidList"]=true,
["fabaoList"]=true,
["daobingList"]=true,
["dressList"]=true,
["vocequipList"]=true,
["tmList"]=true,
["randtmList"]=true,
["tmcfList"]=true,
["hoardList"]=true,
["randHoardList"]=true,
}

local isSwitching
local lastSwitchTimeStamp

function UIDiscipleModel:initSpDiscipleData()
isSwitching=nil
lastSwitchTimeStamp=0
end

function UIDiscipleModel:clearSpDiscipleData()
isSwitching=nil
lastSwitchTimeStamp=nil
end


function UIDiscipleModel:isSPDisciple(dzId)
local data=cfgHelper.get1(cfg_discipleconfig_get,dzId)
if data and data.switch then
return true
end
return false
end

function UIDiscipleModel:isSPDiscipleEx(guid)
local dzId=UIDiscipleModel:getDiscipleID(guid)
if dzId then
return UIDiscipleModel:isSPDisciple(dzId)
end
return false
end

function UIDiscipleModel:getSPDiscipleSwitchIdxWithSameJobId(guid,jobId)
local switchIdx=0
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local nowJobId=UIDiscipleModel:getDiscipleJob(guid)
if nowJobId==jobId then
return switchIdx
else
if netData.switchlistlen then
for idx=1,netData.switchlistlen do
local dataJobId=UIDiscipleModel:getDiscipleJob(guid,idx)
if dataJobId==jobId then
switchIdx=idx
return switchIdx
end
end
end
end
end
return switchIdx
end


function UIDiscipleModel:switchSPDiscipleData(guid,switchidx)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData==nil then return false end


if netData.switchlistlen then
local switchDataList=netData.switchList
local switchData=switchDataList[switchidx]
if switchData then
local tempData={}
for key,v in pairs(switchData)do
tempData[key]=netData[key]
netData[key]=v
end


for key,_ in pairs(checkEmptyDataKeyName)do
if switchData[key]==nil then
tempData[key]=netData[key]
netData[key]=nil
end
end
switchDataList[switchidx]=tempData



netData.notfix_attrList=table.deepCopy(netData.attrList)
for i,v in ipairs(netData.attrList)do
if netData.attrList[i]<=0 then
netData.attrList[i]=1
end
end

local gongfaListlookup={}
if netData.gongfaList~=nil then
for i,v in ipairs(netData.gongfaList)do
gongfaListlookup[v.param_1]=v
end
end
netData.gongfaListlookup=gongfaListlookup
local gongfaUsinglookup={}
for i,v in ipairs(netData.gongfaidList)do
if v>0 then
gongfaUsinglookup[v]=i
end
end
netData.gongfaUsinglookup=gongfaUsinglookup


return true
end
end


return false
end

function UIDiscipleModel:takeOffSwitchSPDiscipleEquip(discipleguid,switchidx,listidx,pos)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

if netData.switchlistlen then
local switchDataList=netData.switchList
local switchData=switchDataList[switchidx]
if switchData then
if listidx==1 then

equipsModel.deleteEquip(discipleguid,pos,switchidx)
elseif listidx==2 then

UIFuLuFangModel:changeFuBaoData(discipleguid,pos,nil,switchidx)
elseif listidx==3 then

fabaoModel.deleteFabao(discipleguid,switchidx)
elseif listidx==4 then

daobingModel:deleteEquip(discipleguid,switchidx)
elseif listidx==5 then

lingshouModel:deleteDzLingShou(discipleguid,switchidx)
elseif listidx==6 then

ClothingModel:deleteEquip(discipleguid,switchidx)
elseif listidx==7 then

vocEquipModel:deleteEquip(discipleguid,switchidx)
end
end
end
end

function UIDiscipleModel:checkIsSwitchingSPDisciple()
return isSwitching or false
end

function UIDiscipleModel:setIsSwitchingSPDisciple(flag)
isSwitching=flag
end

function UIDiscipleModel:setSPDiscipleLastSwitchTimeStamp()
local nowTime=timeHelper.getServerShortTime()
lastSwitchTimeStamp=nowTime
end

function UIDiscipleModel:getSPDiscipleLastSwitchTimeStamp()
return lastSwitchTimeStamp or 0
end


function UIDiscipleModel:checkIsCanSwitch(discipleguid,isWarring)


































if lundaodahuiModel:isInTeam(discipleguid)and lundaodahuiModel:isPlayerInMatchMatchType()then
local isInMatch,matchType,fightId=lundaodahuiModel:checkPlayerInMatchMatchTypeAndGetParams()
if isInMatch then

if matchType~=eLDMatchType.xuanBa then

local isLose=lundaodahuiModel:isPlayerLose(fightId)
if not isLose and lundaodahuiModel:checkMatchTimeBefore15Min()~=nil then

if isWarring then
UIManager.error("弟子处于论道且锁定期间，不可切换")
end
return false
end
end
end
end

return true
end