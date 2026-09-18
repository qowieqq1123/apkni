

















local _outgoers={}




local _librarys={}









local _funcData=nil

function systemZongMenModel:convertOutgoerUnitKey(guid)
return worldModel:convertUnitKey({eWorldUnitTpye.SYSTEMZM_OUTGOER,tostring(guid)})
end

function systemZongMenModel:initOutgoerLibrary()
_librarys={}
local config=cfg_syssectoutgoerposlibconfig()
for world,wCfg in pairs(config)do
local list={}
for block,bCfg in pairs(wCfg)do
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
local libs=bCfg.poslist
for index,lib in ipairs(libs)do
table.insert(list,lib)
end
end
end
_librarys[world]=list
end
end

function systemZongMenModel:addOutgoerLibrary(world,block)
local config=cfgHelper.get2(cfg_syssectoutgoerposlibconfig_get,world,block)
local list=_librarys[world]
if list then
for index,lib in ipairs(config.poslist)do
table.insert(list,lib)
end
end
end

function systemZongMenModel:getOutgoerLibrary(world)
return _librarys[world]or{}
end

function systemZongMenModel:setOutgoerDatas(infoData)
local serverDatas=infoData.ylList or{}
for i,v in ipairs(serverDatas)do
local guidStr=tostring(v.discipleguid)
v.serial=infoData.serial
v.world=infoData.worldId
v.guid=infoData.guid
self:handleOutgoerPosition(v)
_outgoers[guidStr]=v
end
end

function systemZongMenModel:setOutgoerDatasEx(xtzmYlInfo)
local serial=xtzmYlInfo.serial
local infoData=self:getInfoData(serial)
if infoData then
infoData.yl_num=xtzmYlInfo.yl_num
infoData.ylList=xtzmYlInfo.ylList
self:setOutgoerDatas(infoData)
end
end

function systemZongMenModel:handleOutgoerPosition(data)
local serial_num=mathHelper.int64_to_string(data.guid)
local guid_num=mathHelper.int64_to_string(data.discipleguid)
local posData=worldPositionLibrary:getData(serial_num,guid_num)
if posData then
data.flip=posData.flip
local position,block=worldPositionConfig:getPosition(posData.world,{posData.x,posData.z})
data.position=position
data.block=block
if position~=Vector3.zero then
return
else
loggerUtil.logErrFMT("本地存在错误系统宗门外出弟子旧坐标数据:{0},({1},{2}),{3}",data.world,posData.x,posData.z,tostring(data.serial))
worldPositionLibrary:eraseData(serial_num,guid_num)
end
end

local library=self:getOutgoerLibrary(data.world)
local check=false
local temp=nil
if#library>0 then
check,temp=worldPositionLibrary:extract(library)
end
if check then
posData=temp[1]
local x=posData.x
local z=posData.z
local flip=posData.flip
local position,block=worldPositionConfig:getPosition(posData.world,{posData.x,posData.z})
data.position=position
data.block=block
data.flip=flip
worldPositionLibrary:markData(data.world,x,z,flip,eWorldUnitTpye.SYSTEMZM_OUTGOER,serial_num,guid_num)
else
loggerUtil.logErrFMT("系统宗门坐标随机库抽取失败,GUID:{0}",tostring(data.serial))
data.position=Vector3.zero
data.block=nil
data.flip=false
end
end

function systemZongMenModel:getAllOutgoerData()
return _outgoers
end

function systemZongMenModel:clearOutgoerData()
_outgoers={}
end

function systemZongMenModel:getOutgoerData(guid)
local guidStr=tostring(guid)
return self:getOutgoerDataImp(guidStr)
end

function systemZongMenModel:getOutgoerDataImp(guidStr)
return _outgoers[guidStr]
end

function systemZongMenModel:deleteOutgoerData(guid)
local data=self:getOutgoerData(guid)
if data then
local infoData=self:getInfoData(data.serial)
for i=infoData.yl_num,1,-1 do
local serverData=infoData.ylList[i]
if mathHelper.compareInt64(guid,serverData.discipleguid)then
table.remove(infoData.ylList,i)
end
end
_outgoers[tostring(guid)]=nil
worldPositionLibrary:eraseData(data.guid,mathHelper.int64_to_string(guid))
end
end

function systemZongMenModel:findOutgoerDataBySerial(serial)
local list={}
for guidStr,outgoer in pairs(_outgoers)do
if mathHelper.compareInt64(outgoer.serial,serial)then
table.insert(list,guidStr)
end
end
return list
end

function systemZongMenModel:deleteOutgoerDataBySerial(serial)
local list=self:findOutgoerDataBySerial(serial)
for index,guidStr in ipairs(list)do
local data=_outgoers[guidStr]
_outgoers[guidStr]=nil
worldPositionLibrary:eraseData(data.guid,guidStr)
end
return list
end

function systemZongMenModel:setOutgoerFuncData(serverData)
_funcData={
serial=serverData[1],
guid=serverData[2],
gift_num=serverData[3],
incite_num=serverData[4],
arrest_num=serverData[5],
loyalty=serverData[6],
likeList=serverData[8]or{},
}
end

function systemZongMenModel:getOutgoerFuncData()
return _funcData
end

function systemZongMenModel:clearOutgoerFuncData()
_funcData=nil
end

function systemZongMenModel:isSameOutgoerFuncData(serial,guid)
if _funcData then
return mathHelper.compareInt64(_funcData.serial,serial)and mathHelper.compareInt64(_funcData.guid,guid)
end
return false
end

