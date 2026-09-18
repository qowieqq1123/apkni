
function xianjieController:onAppStart_halo()
notifySystem:listenNotify(notifyConfig.onXianJieEntityDataChange,self.onXianJieEntityDataChange)
end

function xianjieController:onEnterState_halo(isReconnet)
xianjieController:reset()
end

function xianjieController:onLeaveState_halo(isReconnet)
xianjieController:reset()
end

function xianjieController:onLeaveMap_halo(isReconnet)
xianjieController:reset()
end


XIANJIE_HALO_TYPE=
{
eTeQuanEditor=1,
}

local _halofunc=
{
[XIANJIE_HALO_TYPE.eTeQuanEditor]=
{
dataTypes={xjDataType.eZongMen},
cnd=
{
changes={eXjDataChangeType.eXmChange,eXjDataChangeType.ePosChange},
func=function(zmdata,in_zmdata,args)
local tqid=args.tqid
local xgid=args.xgid
return zmdata:getXMGuildid()==in_zmdata:getXMGuildid()
end,
}
}
}

for _,cfg in pairs(_halofunc)do
if cfg.cnd and cfg.cnd.changes then
local lookup={}
for _,v in ipairs(cfg.cnd.changes)do
lookup[v]=true
end
cfg.cnd.changelookup=lookup
end
end

function xianjieController.onXianJieEntityDataChange(args)
local changelookup={}
for i,v in ipairs(args)do
changelookup[v[2]]=true
end
local self=xianjieController

for entityId,v in pairs(self.entitylookup)do
for haloType,vv in pairs(v)do
local cfg=_halofunc[haloType]
if cfg.cnd then
for _,changeType in ipairs(cfg.cnd.changes)do
if changelookup[changeType]then
xianjieController:refreshEntityHalo(entityId,haloType)
break
end
end
end
end
end
end

function xianjieController:reset()
self.entitylookup={}
self.clookup={}
self.reflookup={}
end


function xianjieController:addEntityHalo(entityId,haloType,leftOffset,rightOffset,bottomOffset,topOffset,args,funcName)
self.entitylookup[entityId]=self.entitylookup[entityId]or{}
if self.entitylookup[entityId][haloType]then return false end

local info={}
info.haloType=haloType
info.entityId=entityId
info.leftOffset=leftOffset
info.rightOffset=rightOffset
info.topOffset=topOffset
info.bottomOffset=bottomOffset
info.funcName=funcName

info.args=args

self.entitylookup[entityId][haloType]=info

local xjdata=xianjieController:getXJClass(entityId)
if xjdata then
xjdata[funcName](xjdata,entityId,haloType,true,args)
end

xianjieController:refreshEntityHalo(entityId,haloType)

return true
end


function xianjieController:removeEntityHalo(entityId,haloType)
if self.entitylookup[entityId]==nil then return false end

local info=self.entitylookup[entityId][haloType]
if info==nil then return false end
self.entitylookup[entityId][haloType]=nil
self:removeEntityAllHaloReflookup(entityId,haloType)

local funcName=info.funcName
local list=self.clookup[entityId][haloType]
for _,entityId__ in ipairs(list)do
local xjdata=xianjieController:getXJClass(entityId__)
if xjdata then
xjdata[funcName](xjdata,entityId,haloType,false,info.args)
end
end

local xjdata=xianjieController:getXJClass(entityId)
if xjdata then
xjdata[funcName](xjdata,entityId,haloType,false,info.args)
end

return true
end


















function xianjieController:refreshEntityHalo(entityId,haloType)
if self.entitylookup[entityId]==nil then return false end
local info=self.entitylookup[entityId][haloType]
if info==nil then return false end
self:updateEntitysInHalo(info)


local lookup=self.clookup[entityId]

local oldlookup={}
local newlookup={}
for in_entityId,v in pairs(self.reflookup)do
if v[haloType]and v[haloType][entityId]then
v[haloType][entityId]=nil
oldlookup[in_entityId]=true
end
end

for haloType,list in pairs(lookup)do
for _,in_entityId in ipairs(list)do
newlookup[in_entityId]=true
self.reflookup[in_entityId]=self.reflookup[in_entityId]or{}
self.reflookup[in_entityId][haloType]=self.reflookup[in_entityId][haloType]or{}
self.reflookup[in_entityId][haloType][entityId]=true
end
end

local funcName=info.funcName
for entityId__,_ in pairs(oldlookup)do
if newlookup[entityId__]==nil then
local xjdata=xianjieController:getXJClass(entityId__)
if xjdata then
xjdata[funcName](xjdata,entityId,haloType,false,info.args)
end
end
end

for entityId__,_ in pairs(newlookup)do
if oldlookup[entityId__]==nil then
local xjdata=xianjieController:getXJClass(entityId__)
if xjdata then
xjdata[funcName](xjdata,entityId,haloType,true,info.args)
end
end
end

return true
end

function xianjieController:initEntitysInHalo(info)
local leftOffset=info.leftOffset
local rightOffset=info.rightOffset
local bottomOffset=info.bottomOffset
local topOffset=info.topOffset
local entityId=info.entityId
local haloType=info.haloType
local args=info.args
local xjdata=xianjieController:getXJClass(entityId)
local gridX=xjdata.gridX
local gridZ=xjdata.gridZ
local gridWidth=xjdata.gridWidth
local gridHeight=xjdata.gridHeight
local leftX=gridX-leftOffset
local rightX=gridX+rightOffset
local bottomZ=gridZ-bottomOffset
local topZ=gridZ+topOffset
local list={}
local lookup_={}
for i=leftX,topZ do
for j=bottomZ,rightZ do
local entitys=xianjieModel:getZmDataByPos(i,j)
if entitys then
for _,in_entityId in ipairs(entitys)do
if in_entityId~=entityId and not lookup_[entityId]and self:checkCDN(entityId,in_entityId,haloType,args)then
lookup_[entityId]=true
_insert(list,in_entityId)
self:addEntityHaloReflookup(entityId,in_entityId,haloType)
end
end
end
end
end
self.clookup[entityId]=self.clookup[entityId]or{}
self.clookup[entityId][haloType]=list
end

function xianjieController:updateEntitysInHalo(info)
local leftOffset=info.leftOffset
local rightOffset=info.rightOffset
local bottomOffset=info.bottomOffset
local topOffset=info.topOffset
local entityId=info.entityId
local haloType=info.haloType
local args=info.args
local xjdata=xianjieController:getXJClass(entityId)
local gridX=xjdata.gridX
local gridZ=xjdata.gridZ
local gridWidth=xjdata.gridWidth
local gridHeight=xjdata.gridHeight
local leftX=gridX-leftOffset
local rightX=gridX+rightOffset
local bottomZ=gridZ-bottomOffset
local topZ=gridZ+topOffset
local list={}
local lookup_={}
for i=leftX,rightX do
for j=bottomZ,topZ do
local entitys=xianjieModel:getZmDataByPos(i,j)
if entitys then
for _,in_entityId in ipairs(entitys)do
if in_entityId~=entityId and not lookup_[in_entityId]and self:checkCDN(entityId,in_entityId,haloType,args)then
lookup_[in_entityId]=true
_insert(list,in_entityId)
end
end
end
end
end
self.clookup[entityId]=self.clookup[entityId]or{}
self.clookup[entityId][haloType]=list
end


function xianjieController:addEntityHaloReflookup(entityId,in_entityId,haloType)
self.reflookup[in_entityId]=self.reflookup[in_entityId]or{}
self.reflookup[in_entityId][haloType]=self.reflookup[in_entityId][haloType]or{}
self.reflookup[in_entityId][haloType][entityId]=true
end


function xianjieController:removeEntityAllHaloReflookup(entityId,haloType)
for _,v in pairs(self.reflookup)do
local lookup=v[haloType]
if lookup then
lookup[entityId]=nil
end
end
end

function xianjieController:checkCDN(entityId,in_entityId,haloType,args)
local xjdata=xianjieController:getXJClass(entityId)
local in_xjdata=xianjieController:getXJClass(in_entityId)
local func=_halofunc[haloType]
local dataTypes=func.dataTypes
if dataTypes then
local dataType=xjdata:getDataType()
local flag=false
for _,v in ipairs(dataTypes)do
if dataType==v then
flag=true
break
end
end
if not flag then return false end
end

local cnd=func.cnd
if cnd then
return cnd.func(xjdata,in_xjdata,args)
end
return true
end


function xianjieController:getHaloEntitys(entityId)
return self.clookup[entityId]
end


function xianjieController:getHaloEntitysByHaloType(entityId,haloType)
return self.clookup[entityId]and self.clookup[entityId][haloType]or nil
end


function xianjieController:getAllHaloEntitysByEntity(entityId)
return self.reflookup[entityId]
end


function xianjieController:getSelfHaloEntitys(entityId,haloType)
return self.reflookup[entityId]and self.reflookup[entityId][haloType]or nil
end


function xianjieController:isInHalo(entityId,haloType)
local reflookup=xianjieController:getSelfHaloEntitys(entityId,haloType)
return next(reflookup)~=nil
end


function xianjieController:getHaloEntityArgs(entityId,haloType)
return self.entitylookup[entityId]and
self.entitylookup[entityId][haloType]and
self.entitylookup[entityId][haloType].args or nil
end


function xianjieController:addEntityAllHalo(xjdata)
xianguanController:handleTeQuanByAddEntity(xjdata)
end

function xianjieController:refreshEntityAllHalo(xjdata)
xianguanController:handleTeQuanByRemoveEntity(xjdata)
xianguanController:handleTeQuanByAddEntity(xjdata)
end

function xianjieController:removeEntityAllHalo(xjdata)
local entityId=xjdata:getID()
if self.entitylookup[entityId]==nil then return end
for haloType,_ in pairs(self.entitylookup[entityId])do
xianjieController:removeEntityHalo(entityId,haloType)
end
end