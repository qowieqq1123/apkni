systemIconModel={}





local _data={}
_data.unlock={}
local _iconListCfg={}
local _sysListCfg={}
local _initCfg=false

function systemIconModel.init()
_data={}
_data.unlock={}
end

function systemIconModel.initUnlockCfg()
_sysListCfg={}
_iconListCfg={}
local cfgs=cfg_systemiconlockconfig()
for k,v in pairs(cfgs)do
local cfg=v
if cfg then
local id=cfg.id
local cnd=cfg.cnd

_sysListCfg[id]={}
local sysList=_sysListCfg[id]
local sysLookup={}

if cnd then
for _,sysid in ipairs(cnd)do
if _iconListCfg[sysid]==nil then _iconListCfg[sysid]={}end
local iconList=_iconListCfg[sysid]
iconList[#iconList+1]=id

if sysLookup[sysid]==nil then
sysLookup[sysid]=true
sysList[#sysList+1]=sysid
end
end
end
end
end
_initCfg=true
end

function systemIconModel.setUnlock(id)
_data.unlock[id]=true
end

function systemIconModel.setUnlockFlag(id,flag)
_data.unlock[id]=flag
end

function systemIconModel.isUnlock(id)
return _data.unlock[id]or false
end

function systemIconModel.getUnlockSys(id)
if not _initCfg then
systemIconModel.initUnlockCfg()
end
return _sysListCfg[id]
end

function systemIconModel.getConfigBySysid(sysid)
return _iconListCfg[sysid]
end

function systemIconModel.getConfig()
return _iconListCfg
end