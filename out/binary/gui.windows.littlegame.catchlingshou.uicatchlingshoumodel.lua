







local _MODULENAME="UICatchLingShouModel"


def_table(_MODULENAME)
UICatchLingShouModel.name=_MODULENAME
UICatchLingShouModel.data={}


function UICatchLingShouModel:onEnterState()
self:init_data()
end


function UICatchLingShouModel:onLeaveState()

self:init_data()
end


function UICatchLingShouModel:init_data()
self.lookup={}
self.lookup_id={}
end

function UICatchLingShouModel:setGameInfo(data)
if data==nil then return end

data.bzlsItemLookup={}
if data.len2>0 then
for index,gainJson in ipairs(data.gainList)do
local gainData=jsonHelper.decode_josn(gainJson,defaultT)
data.bzlsItemLookup[gainData[1]]=gainData
end
end

local dataEx=jsonHelper.decode_josn(data.jsonStr,defaultT)
data.sysId=dataEx[1]
data.qyEventGuid_str=dataEx[2]


local gameGuid=data.gameGuid
self.lookup[tostring(gameGuid)]=data
self.lookup_id[data.qyEventGuid_str]=data
end

function UICatchLingShouModel:getGameDataById(qyEventGuid_str)
return self.lookup_id[qyEventGuid_str]
end


function UICatchLingShouModel:getGameData(gameGuidStr)
return self.lookup and self.lookup[gameGuidStr]
end


function UICatchLingShouModel:getGameInfoData(gameGuidStr,key)
return self.lookup and self.lookup[gameGuidStr][key]
end

function UICatchLingShouModel:getFindUseItem(gameGuidStr)

local findCount=UICatchLingShouModel:getGameInfoData(gameGuidStr,'len3')
local gameID=UICatchLingShouModel:getGameInfoData(gameGuidStr,'gameConfId')

local useItems=cfgHelper.get(cfg_buzhuolingshouconfig_get,gameID,'useItems')

return useItems[findCount+1]or useItems[#useItems]
end

function UICatchLingShouModel:isEndGame(gameGuidStr)
local endFlag=self:getGameInfoData(gameGuidStr,'endFlag')
return endFlag==1
end