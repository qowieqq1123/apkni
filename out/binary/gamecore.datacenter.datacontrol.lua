dataControl=gameState.addListener({})

local _change_lookup={}

function dataControl:onAppStart()

end

function dataControl:onEnterState()
self.dirty_lookup={}
self.lookupDATA={}
self.listDATA={}
self.cal_list={}
self.isInit=false
end

function dataControl:onLeaveState()
self.dirty_lookup={}
self.lookupDATA={}
self.listDATA={}
self.cal_list={}
self.isInit=false
dataControl:stopTimer()
end

function dataControl:onProtocolReq()
dataControl:initalize()
end


local _GUID=0
local _index=function()
_GUID=_GUID+1
return _GUID
end

DATA_TYPE={
dzColorCount=_index(),
dzJobInfo=_index(),
dzIdInfo=_index(),
dzEquipCount=_index(),
dzSrcInfo=_index(),
dzGfCount=_index(),
dzFBCount=_index(),
dzEquipCount2=_index(),
}



SUB_DATA_TYPE={

eDZGD_1=1,
eDZGD_2=2,

eDZSrc_1=1,
eDZSrc_2=2,

eDZFaBao_Color=1,

eDZEquipJingLianLv=1,
}









local _type=0
local _type=function()
_type=_type+1
return _type
end



DATA_CHANGE_TYPE={
eAddDZ=_type(),
eRemoveDZ=_type(),
eDZImageChange=_type(),
eDZEquipChange=_type(),
eDZJJChange=_type(),
eDZGFChange=_type(),
eDZFaBaoChange=_type(),
eDZEquipJllvChange=_type(),
}

local _dataCfg={
[DATA_TYPE.dzColorCount]={
dirty_list={DATA_CHANGE_TYPE.eAddDZ,DATA_CHANGE_TYPE.eRemoveDZ,DATA_CHANGE_TYPE.eDZImageChange},
get=function()
return dataControl:getDiscipleImageParamList('color')
end
},
[DATA_TYPE.dzJobInfo]={
dirty_list={DATA_CHANGE_TYPE.eAddDZ,DATA_CHANGE_TYPE.eRemoveDZ},
get=function()
return dataControl:getDiscipleImageParamListInfo('job')
end
},
[DATA_TYPE.dzIdInfo]={
dirty_list={DATA_CHANGE_TYPE.eAddDZ,DATA_CHANGE_TYPE.eRemoveDZ},
get=function()
return dataControl:getDiscipleDataParamListInfo('id')
end
},
[DATA_TYPE.dzEquipCount]={
dirty_list={DATA_CHANGE_TYPE.eRemoveDZ,
DATA_CHANGE_TYPE.eDZEquipChange},
get=function()
return dataControl:getDiscipleEquipCount()
end
},
[DATA_TYPE.dzSrcInfo]={
dirty_list={DATA_CHANGE_TYPE.eAddDZ,DATA_CHANGE_TYPE.eRemoveDZ},
get=function()
return dataControl:getDiscipleSrcCount()
end
},
[DATA_TYPE.dzGfCount]={
dirty_list={DATA_CHANGE_TYPE.eAddDZ,DATA_CHANGE_TYPE.eRemoveDZ,
DATA_CHANGE_TYPE.eDZGFChange},
get=function()
return dataControl:getDiscipleGFCount()
end
},
[DATA_TYPE.dzFBCount]={
dirty_list={DATA_CHANGE_TYPE.eRemoveDZ,
DATA_CHANGE_TYPE.eDZFaBaoChange},
get=function()
return dataControl:getDiscipleBaBaoCount()
end
},
[DATA_TYPE.dzEquipCount2]={
dirty_list={DATA_CHANGE_TYPE.eRemoveDZ,DATA_CHANGE_TYPE.eDZEquipChange,
DATA_CHANGE_TYPE.eDZEquipJllvChange},
get=function()
return dataControl:getDiscipleEquipJingCount()
end
},
}

for k,v in pairs(_dataCfg)do
for _,vv in ipairs(v.dirty_list)do
if _change_lookup[vv]==nil then _change_lookup[vv]={}end
local change_lookup=_change_lookup[vv]
change_lookup[#change_lookup+1]=k
end
end

function dataControl.onDiscipleCreate()
dataControl:onReceiveChangeType(DATA_CHANGE_TYPE.eAddDZ)
end

function dataControl.onDiscipleRemove()
dataControl:onReceiveChangeType(DATA_CHANGE_TYPE.eRemoveDZ)
end

function dataControl.onDiscipleImageChange()
dataControl:onReceiveChangeType(DATA_CHANGE_TYPE.eDZImageChange)
end

function dataControl.onEquipChange()
dataControl:onReceiveChangeType(DATA_CHANGE_TYPE.eDZEquipChange)
end

function dataControl.onDiscipleJJChange()
dataControl:onReceiveChangeType(DATA_CHANGE_TYPE.eDZJJChange)
end

function dataControl.onDiscipleGFChange()
dataControl:onReceiveChangeType(DATA_CHANGE_TYPE.eDZGFChange)
end

function dataControl.onFaBaoChange()
dataControl:onReceiveChangeType(DATA_CHANGE_TYPE.eDZFaBaoChange)
end

function dataControl.onDZEquipJilvChange()
dataControl:onReceiveChangeType(DATA_CHANGE_TYPE.eDZEquipJllvChange)
end

function dataControl:initalize()
self.isInit=true
self.cal_list={}
for k,_ in pairs(_dataCfg)do
self.cal_list[#self.cal_list+1]=k
end
dataControl:startTimer()
end

function dataControl:onReceiveChangeType(changeType)
local change_list=_change_lookup[changeType]
if change_list==nil then return end
for _,dataType in pairs(change_list)do
local cfg=_dataCfg[dataType]
cfg.dirty=true
self.cal_list[#self.cal_list+1]=dataType
end

if#self.cal_list>0 then
dataControl:startTimer()
end
end

function dataControl:calValue(dataType)
local cfg=_dataCfg[dataType]
if cfg.dirty~=false then
cfg.dirty=false
self.lookupDATA[dataType],self.listDATA[dataType]=cfg.get()
end
end

function dataControl:getValue(dataType,subType,...)
if not initProControl.isDone()then return end
dataControl:calValue(dataType)
subType=subType or-1
return table.getKeyValue(self.lookupDATA,dataType,subType,...)
end

function dataControl:getList(dataType,subType,...)
if not initProControl.isDone()then return end
dataControl:calValue(dataType)
subType=subType or-1
return table.getKeyValue(self.listDATA,dataType,subType,...)
end



function dataControl:getBiggerListCount(list,target)
local startIndex=table.getBiggerNumberStartIndex(list,target)
if startIndex==nil then return 0 end
return#list-startIndex+1
end


local _tickUpdate=function()
dataControl:update()
end

function dataControl:update()
local len=#self.cal_list
if len==0 then return end
local dataType=_remove(self.cal_list,1)
self:calValue(dataType)
if len==1 then
self:stopTimer()
end
end

function dataControl:startTimer()
if self.isInit and self.tickTimer==nil then
self.tickTimer=FrameTimer.New(_tickUpdate,0,-1)
self.tickTimer:Start()
end
end

function dataControl:stopTimer()
if self.tickTimer then
self.tickTimer:Stop()
self.tickTimer=nil
end
end

function dataControl:getDiscipleImageParamListInfo(paramName)
local lookup={}
local discipleNetData=UIDiscipleModel:getDiscipleList()
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
local value=imageInfo[paramName]
if value then
dataControl:addDZNetDataEx(lookup,nil,value,netData)
end
end
end
return lookup
end

function dataControl:getDiscipleImageParamList(paramName)
local lookup={}
local discipleNetData=UIDiscipleModel:getDiscipleList()
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
local value=imageInfo[paramName]
if value then
dataControl:addCount(lookup,nil,value)
end
end
end
return lookup
end

function dataControl:getDiscipleDataParamListInfo(paramName)
local lookup={}
local discipleNetData=UIDiscipleModel:getDiscipleList()
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local value=netData[paramName]
if value then
dataControl:addDZNetDataEx(lookup,nil,value,netData)
end
end
end
return lookup
end

function dataControl:getDiscipleEquipCount()
local lookup={}
local discipleNetData=UIDiscipleModel:getDiscipleList()
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
for _,equipType in pairs(EQUIP_TYPE)do
local equip=equipsModel.getEquipByDizi(netData.discipleguid,equipType)
if equip then
local itemid=equip.itemid
dataControl:addCount(lookup,nil,itemid)
end
end
end
end
return lookup
end

function dataControl:getDiscipleEquipJingCount()
local lookup={}
local list={}
local equips=equipsModel.getAllEquip()
for _,equip in pairs(equips)do
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
dataControl:addList(list,SUB_DATA_TYPE.eDZEquipJingLianLv,jinglianlv)
end
if list[SUB_DATA_TYPE.eDZEquipJingLianLv]then
table.sort(list[SUB_DATA_TYPE.eDZEquipJingLianLv],function(a,b)
return a<b
end)
end
return lookup,list
end

function dataControl:getDiscipleBaBaoCount()
local lookup={}
local discipleNetData=UIDiscipleModel:getDiscipleList()
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local equip=equipsHelper.getEquipByDizi(netData.discipleguid,EQUIP_TYPE.eFabao)
if equip then
local itemid=equip.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
dataControl:addCount(lookup,SUB_DATA_TYPE.eDZFaBao_Color,color)
end
end
end
return lookup
end

function dataControl:getDiscipleSrcCount()
local lookup={}
local discipleNetData=UIDiscipleModel:getDiscipleList()
if discipleNetData then
for _,v in pairs(discipleNetData)do
local netData=v.netData.net
local value=netData.srctype or discipleSrcType.eNone
dataControl:addDZNetDataEx(lookup,SUB_DATA_TYPE.eDZSrc_1,value,netData)
if discipleSrcType:isPlot(value)then
dataControl:addDZNetData(lookup,SUB_DATA_TYPE.eDZSrc_2,netData)
end
end
end
return lookup
end

function dataControl:getDiscipleGFCount()
local lookup={}
local list={}
local discipleNetData=UIDiscipleModel:getDiscipleList()
if discipleNetData then
for _,v in pairs(discipleNetData)do
local netData=v.netData.net
local gongfaidList=netData.gongfaidList
local cnt=0
local has={}
for _,gfID in ipairs(gongfaidList)do
if not has[gfID]then
has[gfID]=true
dataControl:addCount(lookup,SUB_DATA_TYPE.eDZGD_1,gfID)
end
if gfID>0 then
cnt=cnt+1
end
end
dataControl:addCount(lookup,SUB_DATA_TYPE.eDZGD_2,cnt)
dataControl:addList(list,SUB_DATA_TYPE.eDZGD_2,cnt)
end
if list[SUB_DATA_TYPE.eDZGD_2]then
table.sort(list[SUB_DATA_TYPE.eDZGD_2],function(a,b)
return a<b
end)
end
end
return lookup,list
end

function dataControl:addDZNetData(lookup,subType,netData)
subType=subType or-1
if lookup[subType]==nil then lookup[subType]={}end
_insert(lookup[subType],{discipleguidStr=netData.discipleguidStr,
discipleguid=netData.discipleguid})
end

function dataControl:addDZNetDataEx(lookup,subType,key,netData)
subType=subType or-1
if lookup[subType]==nil then lookup[subType]={}end
if lookup[subType][key]==nil then lookup[subType][key]={}end
_insert(lookup[subType][key],{discipleguidStr=netData.discipleguidStr,
discipleguid=netData.discipleguid})
end

function dataControl:addCount(lookup,subType,key)
subType=subType or-1
if lookup[subType]==nil then lookup[subType]={}end
local old=lookup[subType][key]or 0
lookup[subType][key]=old+1
end

function dataControl:addList(list,subType,value)
subType=subType or-1
if list[subType]==nil then list[subType]={}end
local T=list[subType]
T[#T+1]=value
end
