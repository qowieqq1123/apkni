initProConfig={}

INIT_PRO_STATE=
{
eUnStart=0,
eDoing=1,
eDone=2,
}

local _ignoreSid=
{
[255]=true,
}

local _ignoreProtocol=
{
[254]={
24,30,37,47
},
[0]={
2
}
}

local _ignoreCfg={}
for sid,v in pairs(_ignoreProtocol)do
for _,pid in ipairs(v)do
if _ignoreCfg[sid]==nil then _ignoreCfg[sid]={}end
_ignoreCfg[sid][pid]=true
end
end

function initProConfig.ignore(sid,pid)
if _ignoreSid[sid]==true then return true end
if _ignoreCfg[sid]==nil then return false end
return _ignoreCfg[sid][pid]==true
end