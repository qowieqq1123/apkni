def_class('fightHaloListAction',fightBaseAction)

function fightHaloListAction:__init()
self.typo=fightActionType.HALO_LIST
end

function fightHaloListAction:getTypo()
return self.typo
end



function fightHaloListAction:init(_round,_rawData,_srcID,_dstID)
self.round=_round
self.battle=_round:getBattle()
self.dstID=_rawData[2]
self.haloList=_rawData[3]
end


function fightHaloListAction:exe(immediately)
local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
for _,data in ipairs(self.haloList)do
self:addHalo(ent,data[1],data[2])
end
end

self.isComplete=true
end

function fightHaloListAction:logExe(logContent)
local ent=self.battle:getEntity(self.dstID)
if ent~=nil then
if#self.haloList>0 then
for _,data in ipairs(self.haloList)do
self:addHaloLog(logContent,ent,data[1],data[2])
end
else
logContent(FMT.fmt("{0}光环已清除",ent:logName()))
end
end
self.isComplete=true
end

function fightHaloListAction:update(deltaTime)

return self.isComplete
end


function fightHaloListAction:onDespwan()
fightActionMrg:recycleAction(self)
end


function fightHaloListAction:addHalo(ent,id,level)
local haloCfg=cfgHelper.get1(cfg_haloconfig_get,id)
if haloCfg~=nil then

end
end


function fightHaloListAction:addHaloLog(logContent,ent,id,level)
local haloCfg=cfgHelper.get1(cfg_haloconfig_get,id)
if haloCfg~=nil then
logContent(FMT.fmt("{0}添加光环[{1}]级[{2}][{3}]",ent:logName(),level,haloCfg.desc,id))
else
logContent(FMT.fmt("{0}添加光环[{1}]找不到配置",ent:logName(),id))
end
end