function daobingHelper.getDzUseSkills(dzguid)
local equip=daobingModel:getEquipByDizi(dzguid)
if equip==nil then return end
local shentong={}
local itemid=equip.itemid
local itemguid=equip.itemguid
local voc=UIDiscipleModel:getDiscipleJob(dzguid)
local useSkillids=daobingHelper.getWeaponShentong(itemid)
local lv=daobingHelper.getWeaponShentongLv(equip)
for i,skllid in ipairs(useSkillids or{})do
shentong[#shentong+1]={skllid,lv}
end

local useSkillids=daobingHelper.getVocShentong(itemid,voc)
local lv=daobingHelper.getVocShentongLv(equip)
for i,skllid in ipairs(useSkillids or{})do
shentong[#shentong+1]={skllid,lv}
end

local useSkillids=daobingHelper.getZhuanShuShentong(itemid,itemguid)
local lv=daobingHelper.getZhuanShuShentongLv(equip)
for i,skllid in ipairs(useSkillids or{})do
shentong[#shentong+1]={skllid,lv}
end
return shentong
end


function daobingHelper.getWeaponShentong(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local shentong=itemCfg.shentong[1]
return daobingHelper.getUseSkills(shentong)
end

function daobingHelper.getWeaponShentongLv(equip)
local star=0
if equip and equip.itemData then
star=equip.itemData.star or 0
end
return daobingConfig.getWeaponShentongLvByStar(star)
end

function daobingHelper.getVocShentong(itemid,voc)
local itemCfg=itemsConfig.getConfig(itemid)
local shentong=itemCfg.shentong[2]
local useSkillids=daobingHelper.getUseSkills(shentong,voc)
local allSkillids=daobingHelper.getUseSkills(shentong)
return useSkillids,allSkillids
end

function daobingHelper.getVocShentongLv(equip)
local star=0
if equip and equip.itemData then
star=equip.itemData.star or 0
end
return daobingConfig.getVocShentongLvByStar(star)
end

function daobingHelper.getZhuanShuShentong(itemid,itemguid)
local dzguid=itemguid and daobingModel:getDiziguidByItemguid(itemguid)or nil
local itemCfg=itemsConfig.getConfig(itemid)
local shentong=itemCfg.shentong[3]
local dzid
if dzguid then
local netData=UIDiscipleModel:getDiscipleData(dzguid)
dzid=netData.id
end
local useSkillids=daobingHelper.getUseSkills(shentong,dzid)
local allSkillids=daobingHelper.getUseSkills(shentong)
return useSkillids,allSkillids
end

function daobingHelper.getZhuanShuShentongLv(equip)
local star=0
if equip and equip.itemData then
star=equip.itemData.star or 0
end
return daobingConfig.getZhuanShuShentongLvByStar(star)
end

function daobingHelper.getUseSkills(shentong,args)
local useSkillids={}
for i,v in ipairs(shentong or{})do
local check=false
if v[2]==nil or args==nil then
check=true
else
for i,vv in ipairs(v[2])do
if tostring(vv)==tostring(args)then
check=true
break
end
end
end
if check then
useSkillids[#useSkillids+1]=v[1]
end
end
return useSkillids
end

function daobingHelper.convertTable(tab)
local t={}
local list={}
for k,v in pairs(tab)do
t[#t+1]={k,v}
end
table.sort(t,function(a,b)
return a[1]<b[1]
end)
for _,v in ipairs(t)do
list=table.concatTableX(list,v[2])
end
return list
end
