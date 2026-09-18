






local _MODULENAME="worldPositionLibrary"




def_table(_MODULENAME)
worldPositionLibrary.name=_MODULENAME
worldPositionLibrary.emptyPos=Vector3.zero
worldPositionLibrary.saveKey="worldPositionLibrary"













worldPositionLibrary.data={}
worldPositionLibrary.sign=false
worldPositionLibrary.stack={}


worldPositionLibrary.eSelfIncreasingType={
eSystemZongMen=1,
}


local eFakeRange={
[eWorldUnitTpye.EXPERIENCE]={int64.new('-1'),int64.new('-10000')}
}


function worldPositionLibrary:onAppStart()
self.sub=int64.new('-1')
end


function worldPositionLibrary:onEnterState(isReconnect)
if not isReconnect then
self:loadData()
self.sign=false
end
end


function worldPositionLibrary:onLeaveState(isReconnect)

if not isReconnect then
self:cleanData()
self.sign=false
end
end


function worldPositionLibrary:onServerDataInitFinish()

end

function worldPositionLibrary:extract(ids,num,warning,offsets)
local count=num or 1
local offsets=offsets or{{0,0}}
local library={}
for i,v in ipairs(ids)do
local cfg=cfgHelper.get1(cfg_worldpositionlibraryconfig_get,v)
if cfg then
local world=cfg.world
for j,w in ipairs(cfg.position)do
local x=w[1]
local z=w[2]
local flip=w[3]

local check=true
for k,u in ipairs(offsets)do
local temp=self:checkAvailable(world,x+u[1],z+u[2])

if not temp then
check=false
end
end
if check then
table.insert(library,{
library=v,
world=cfg.world,
x=w[1],
z=w[2],
flip=w[3]==1,
})
end
end
end
end

local temp={}
for i=1,count do
if#library>0 then
local r=math.random(1,#library)
local data=table.remove(library,r)
for j=#library,1,-1 do
local t=library[j]
if data.world==t.world and data.x==t.x and data.z==t.z then
table.remove(library,j)
end
end
table.insert(temp,data)
else
if warning==nil or warning then
local idsStr=serializeHelper.serialize(ids)
loggerUtil.logErrFMT("抽取坐标库列表{0}抽取数量不足{1}",idsStr,count)

local statistics={}
for i,v in ipairs(ids)do
local idCfg=cfgHelper.get1(cfg_worldpositionlibraryconfig_get,v)
if idCfg then
for index,posData in ipairs(idCfg.position)do
local occupation=self:checkAvailableImp(idCfg.world,posData[1],posData[2])
if occupation then
statistics[occupation.unitType]=(statistics[occupation.unitType]or 0)+1
end
end
end
end
loggerUtil.warn(FMT.fmt("当前坐标库列表{0}总占用情况：{1}",idsStr,serializeHelper.serialize(statistics)))
end
return false,temp
end
end

return true,temp
end

function worldPositionLibrary:markData(world,x,z,flip,unitType,guid,sub)






if x<=0 or z<=0 then
loggerUtil.logErrFMT("无效记录点(必须大于0)：{0}， {1}",x,z)
return
end

local data,index=self:getData(guid,sub)
if data then
loggerUtil.logErrFMT("重复记录点：{0}， {1}",tostring(guid),sub or"nil")
return
end

data={
key=tostring(guid),
world=world,
x=x,
z=z,
flip=flip,
unitType=unitType,
sub=sub or 0,
}

local temp=self:checkAvailableImp(world,x,z)
if temp then


notifySystem:postNotify(notifyConfig.onWorldPositionReRandom,temp,data)
end

table.insert(self.data,data)

self.sign=true

end



function worldPositionLibrary:checkData(unitType,guidList)
local temp={}
for i,v in ipairs(self.data)do
if v.unitType==unitType then
local check=false
for j,w in ipairs(guidList)do
if v.key==tostring(w)then
check=true
break
end
end
if not check then
table.insert(temp,i)
end
end
end

table.sort(temp)
for i=#temp,1,-1 do
table.remove(self.data,temp[i])
end

self.sign=self.sign or(#temp>0)
end



function worldPositionLibrary:checkDataEx(unitType,guidExList)
local temp={}
for i,v in ipairs(self.data)do
if v.unitType==unitType then
local check=false
for j,w in ipairs(guidExList)do
if v.key==tostring(w[1])and v.sub==w[2]then
check=true
break
end
end
if not check then
table.insert(temp,i)
end
end
end

table.sort(temp)
for i=#temp,1,-1 do
table.remove(self.data,temp[i])
end

self.sign=self.sign or(#temp>0)
end

function worldPositionLibrary:eraseData(guid,sub)
local data,index=self:getData(guid,sub)
if index then
local temp=table.remove(self.data,index)



self.sign=true
end
end

function worldPositionLibrary:eraseDatas(guid)
local list={}
for i,v in ipairs(self.data)do
if v.key==tostring(guid)then
table.insert(list,i)
end
end
table.sort(list)
local count=#list
if count>0 then
for i=count,1,-1 do
table.remove(self.data,list[i])
end
self.sign=true
end
end

function worldPositionLibrary:cleanData()
self.data={}

end

function worldPositionLibrary:saveData()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWorldPosition,self.saveKey,self.data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWorldPosition)
self.sign=false
end

function worldPositionLibrary:loadData()
self.data=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWorldPosition,self.saveKey,{})
end

function worldPositionLibrary:checkAvailable(world,x,z)
return self:checkAvailableImp(world,x,z)==nil
end

function worldPositionLibrary:checkAvailableImp(world,x,z)
for i,v in pairs(self.data)do
if v.world==world and v.x==x and v.z==z then
return v
end
end
end

function worldPositionLibrary:containData(guid,sub)
return self:getData(guid,sub)~=nil
end

function worldPositionLibrary:getData(guid,sub)
for i,v in ipairs(self.data)do
if v.key==tostring(guid)and v.sub==(sub or 0)then

return v,i
end
end
end

function worldPositionLibrary:getDatas(guid)
local data={}
for i,v in ipairs(self.data)do
if v.key==tostring(guid)then
table.insert(data,{index=i,data=v})
end
end
return data
end

function worldPositionLibrary:printData()

end

function worldPositionLibrary:checkSave()
if initProControl.isDone()and self.sign then
self:saveData()
end
end






















function worldPositionLibrary:nextFakeGuid(eType)
local range=eFakeRange[eType]
if range then
local temp=range[1]
while(temp>=range[2])do
if not self:containData(temp)then
return temp
else
temp=temp+self.sub
end
end
end
end

function worldPositionLibrary:countLibraryValid(libs)
local count=0
for i,v in ipairs(libs)do
local cfg=cfgHelper.get1(cfg_worldpositionlibraryconfig_get,v)
if cfg then
for j,w in ipairs(cfg.position)do
if not self:checkAvailable(cfg.world,w[1],w[2])then
count=count+1
end
end
end
end
return count
end

function worldPositionLibrary:countWorldType(world,unitType)
local count=0
for i,v in ipairs(self.data)do
if v.world==world and v.unitType==unitType then
count=count+1
end
end
return count
end
