systemIconControl=gameState.addListener({})

function systemIconControl:onAppStart(...)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
systemIconModel.initUnlockCfg()
end

function systemIconControl:onEnterState(...)
systemIconModel.init()
end

function systemIconControl:onLeaveState(...)
systemIconModel.init()
end

function systemIconControl:onSystemInit()
local cfgs=cfg_systemiconlockconfig()
for _,v in pairs(cfgs)do
local cnd=v.cnd
local iconType=v.id
if cnd then
for _,sysid in ipairs(cnd)do
if systemModel.isOpen(sysid)then
systemIconModel.setUnlock(iconType)
break
end
end
else
systemIconModel.setUnlock(iconType)
end
end
end

function systemIconControl.isCanUnLock(id)
if systemIconModel.isUnlock(id)then return false end
local cfg=cfg_systemiconlockconfig_get(id)
if cfg then
local cnd=cfg.cnd
if cnd then
for _,sysid in ipairs(cnd)do
if systemModel.isOpen(sysid)then
return true,sysid
end
end
end
end
return false
end

function systemIconControl.on_system_open(sysid)
local array={}
local cfg=systemIconModel.getConfigBySysid(sysid)
if cfg then
for i,v in ipairs(cfg)do
if systemIconControl.isCanUnLock(v)then
systemIconModel.setUnlock(v)
array[#array+1]=v
end
end
end
if#array>0 then
notifySystem:postNotify(notifyConfig.iconUnlock,array)
end
end