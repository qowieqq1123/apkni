







monsterModel={}

function monsterModel:getMonsterGroupFight(group,fazelist)
local gcfg=cfgHelper.get1(cfg_monstergroup_get,group)
local attrs={}
for _,monsterID in ipairs(gcfg.monList)do
local temp=monsterModel:getMonsterAttrs(monsterID,gcfg.level,gcfg.levelUp)
for m,n in pairs(temp)do
if attrs[m]==nil then
attrs[m]=n
else
attrs[m]=attrs[m]+n
end
end
end
return cfgHelper.getFight(attrs)
end

function monsterModel:getMonsterAttrs(monsterID,level,levelUp)
local mcfg=cfgHelper.get1(cfg_monsterconfig_get,monsterID)
local attrs=table.deepCopy(mcfg.attrs)
if levelUp then
local levelUpPro=mcfg.levelUpPro
if levelUpPro and level~=mcfg.level then
for _,v in ipairs(levelUpPro)do
if level<=v[1]then
for m,n in pairs(v[2])do
attrs[m]=n
end
break
end
end
end
end
return attrs
end