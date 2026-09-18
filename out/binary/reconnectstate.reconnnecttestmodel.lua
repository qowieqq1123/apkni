reconnnectTestModel=gameState.addListener({})

local _loadStr=''
local _lookup={}

function reconnnectTestModel:onEnterState()
reconnnectTestModel.load()
end

function reconnnectTestModel.load()
_loadStr=userGlobalSetting.get('reconnectTestProtocol','')
reconnnectTestModel.freshLookup()
end

function reconnnectTestModel.clear()
_loadStr=''
_lookup={}
userGlobalSetting.set('reconnectTestProtocol','')
userGlobalSetting.flush()
end

function reconnnectTestModel.onfresh(str)
_loadStr=str
userGlobalSetting.set('reconnectTestProtocol',str)
reconnnectTestModel.freshLookup()
end

function reconnnectTestModel.freshLookup()
local str=_loadStr
_lookup={}
if str and str~=''then
local array=string.split(str,',')or{}
for _,v in ipairs(array)do
local info=string.split(v,'_')
if#info==2 then
local sid=tonumber(info[1])
local pid=tonumber(info[2])
if _lookup[sid]==nil then _lookup[sid]={}end
_lookup[sid][pid]=true
end
end
end
end

function reconnnectTestModel.isTestProtocol(sid,pid)
if _lookup[sid]==nil then return false end
return _lookup[sid][pid]==true
end