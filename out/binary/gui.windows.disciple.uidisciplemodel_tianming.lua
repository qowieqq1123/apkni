







function UIDiscipleModel:checkOponTianMing(netData)
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
return tmlv>=0
end

function UIDiscipleModel:getTianMingLevel(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getTianMingLevelEx(netData)
end

function UIDiscipleModel:getTianMingLevelEx(netData)
return netData.tmlv or-1
end

function UIDiscipleModel.getTianMingLevelFloor(tmlv)
if tmlv>=0 then
return cfgHelper.get2(cfg_discipletianminglevelconfig_get,tmlv,'floor')
end
return nil
end

function UIDiscipleModel.getTianMingLevelFloorName(tmlv)
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
return cfgHelper.get2(cfg_discipletianmingfloorconfig_get,floor,'name')
end

function UIDiscipleModel.getTianMingFloorIcon(floor)
local iconName=cfgHelper.get2(cfg_discipletianmingfloorconfig_get,floor,'icon')
local abName=globalABLookup.diciplecolorframe
return abName,iconName
end

function UIDiscipleModel.getMaxTianMingLevel()
local cfg=cfg_discipletianminglevelconfig()
local finalIndex=#cfg
return cfg[finalIndex].id
end

function UIDiscipleModel.getMaxTianMingFloor()
local cfg=cfg_discipletianmingfloorconfig()
local finalIndex=#cfg
return cfg[finalIndex].id
end

function UIDiscipleModel.getTianMingLevelChong(tmlv)
local chong=0
if tmlv>0 then
chong=tmlv%3
if chong==0 then
chong=3
end
end
return chong
end

function UIDiscipleModel.getTianMingLevelChongEx(tmlv)
local chong=0
if tmlv>0 then
chong=tmlv%3
if chong==0 then
chong=3
end
elseif tmlv==0 then
chong=1
end
return chong
end

function UIDiscipleModel.getTianMingLevelDesc(tmlv,typo)
local chong=UIDiscipleModel.getTianMingLevelChong(tmlv)
local floorname=UIDiscipleModel.getTianMingLevelFloorName(tmlv)
if typo==1 then
if chong>0 then
return FMT.fmt('{0}天命({1}重)',floorname,chong)
else
return FMT.fmt('{0}天命',floorname)
end
elseif typo==2 then
if chong>0 then
return FMT.fmt('{0}天命【{1}重】',floorname,chong)
else
return FMT.fmt('{0}天命',floorname)
end
elseif typo==3 then
if chong>0 then

return FMT.fmt('{0}天命{1}重',floorname,mathHelper.numberToChinese(chong))
else
return FMT.fmt('{0}天命',floorname)
end
else
if chong>0 then
return FMT.fmt('{0}{1}重',floorname,chong)
else
return FMT.fmt('{0}',floorname)
end
end
end

function UIDiscipleModel.getTianMingDesc(tmcfg,jobid)
if tmcfg==nil then
return'解锁3项天命赐福'
else







local desclist=tmcfg.desc
local desc=desclist[jobid]
if desc then
return desc
else
return desclist[0]
end
end
end

function UIDiscipleModel.getTianMingNaneChange(tmcfg)
if tmcfg and tmcfg.lddzid then
local dzid=tmcfg.lddzid[1]
if dzid and UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)then
local tmID=tmcfg.lddzid[2]
tmcfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
end
end
if tmcfg then
return tmcfg.name
else
return''
end
end
function UIDiscipleModel.getTianMingDescExChange(tmcfg)
if tmcfg and tmcfg.lddzid then
local dzid=tmcfg.lddzid[1]
if dzid and UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)then
local tmID=tmcfg.lddzid[2]
tmcfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
end
end
if tmcfg then
return tmcfg.descEx
else
return''
end
end

function UIDiscipleModel.getTianMingSkillIconId(tmcfg,jobid,dzData)
if tmcfg==nil then
return 1
else
local list=tmcfg.skillicon
if dzData and dzData.id and dzData.disguise and tmcfg.skillicon2 then
if dzData.disguise>0 and dzData.id~=dzData.disguise then
list=tmcfg.skillicon2
end
end
local skillid=list[jobid]
if skillid then
return skillid
else
return list[0]
end
end
end

function UIDiscipleModel:getUpTianMingCost(netData)
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local dzID=UIDiscipleModel:getDiscipleIDEx(netData)
return UIDiscipleModel.getUpTianMingCostEx(dzID,tmlv)
end

function UIDiscipleModel.getUpTianMingCostEx(dzID,tmlv)
local yuanpo=cfgHelper.get2(cfg_discipleconfig_get,dzID,'yuanpo')
local tmcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,tmlv)
local cost={}

local itemID
local itemNum
if yuanpo~=nil then
itemID=yuanpo[1]
itemNum=tmcfg.yuanpo[2][dzID]
if itemNum==nil then
itemNum=tmcfg.yuanpo[2][0]
end
else
itemID=cfgHelper.getdef1(cfg_discipletianmingconfig,'itemid')
itemNum=tmcfg.yuanpo[1][dzID]
if itemNum==nil then
itemNum=tmcfg.yuanpo[1][0]
end
end
cost[1]={itemID,itemNum}

cost[2]=tmcfg.consume[1]

return cost
end

function UIDiscipleModel:getSpSkillLevel(tmlv)
local cfg=cfgHelper.get(cfg_discipletianminglevelconfig_get,tmlv)
local spSkillLv=cfg.level
return spSkillLv
end

function UIDiscipleModel.getMaxSpSkillLevel()
local cfg=cfg_discipletianminglevelconfig()
local finalIndex=#cfg
return cfg[finalIndex].level
end

function UIDiscipleModel:getNextSpSkillLevelAndNeedTmLv(tmlv)
local allCfg=cfg_discipletianminglevelconfig()
local finalIndex=#allCfg
local nowSpSkillLv=allCfg[tmlv].level
local nextSpSkillLv
local needTmLv
for i=tmlv+1,finalIndex do
local lvCfg=allCfg[i]
local spSkillLv=lvCfg.level
if spSkillLv>nowSpSkillLv then
nextSpSkillLv=spSkillLv
needTmLv=lvCfg.id
break
end
end

return nextSpSkillLv,needTmLv
end


function UIDiscipleModel:getUpTianMingCost2()
return cfgHelper.getdef1(cfg_discipletianmingconfig,'speitemid')
end


function UIDiscipleModel:getUpTianMingCost_normalItem()
return cfgHelper.getdef1(cfg_discipletianmingconfig,'itemid')
end

function UIDiscipleModel:getUpTianMingCostItem(guid,lookup)
lookup=lookup or{}
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local dzID=UIDiscipleModel:getDiscipleIDEx(netData)
if tmlv>0 then
local tmnum=netData.tmnum or 0
local isSPdz=UIDiscipleModel:isSPDiscipleEx(guid)
if tmnum>0 and not isSPdz then
local spe_itemid=UIDiscipleModel:getUpTianMingCost2()
lookup[spe_itemid]=lookup[spe_itemid]or 0
lookup[spe_itemid]=lookup[spe_itemid]+tmnum
end
for i=1,tmlv do
local cost=UIDiscipleModel.getUpTianMingCostEx(dzID,i-1)
local itemid=cost[1][1]
local itemnum=cost[1][2]
if tmnum>0 then
if tmnum>itemnum then
tmnum=tmnum-itemnum
itemnum=0
else
itemnum=itemnum-tmnum
tmnum=0
end
end
if itemnum>0 then
lookup[itemid]=lookup[itemid]or 0
lookup[itemid]=lookup[itemid]+itemnum
end
end
end
end
return lookup
end

function UIDiscipleModel:getFullTianMingCostItem(netData)
local num=0
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local dzID=UIDiscipleModel:getDiscipleIDEx(netData)
local next_tmcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,tmlv+1)
while next_tmcfg~=nil do
local cost=UIDiscipleModel.getUpTianMingCostEx(dzID,tmlv)
num=num+cost[1][2]
tmlv=tmlv+1
next_tmcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,tmlv+1)
end
return num
end

function UIDiscipleModel:checkTianMingFloorActive(tmlv,tmIndex)
local limit=cfgHelper.getdef2(cfg_discipletianmingconfig,'floor',tmIndex)
return tmlv>=limit,limit
end

function UIDiscipleModel:getTianMingByIndex(guid,tmIndex)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getTianMingByIndexEx(netData,tmIndex)
end

function UIDiscipleModel:getTianMingByIndexEx(netData,tmIndex)
if netData then
local tmList=netData.tmList
if tmList then
if tmIndex==nil then
return tmList
else
if tmIndex>6 then
tmIndex=tmIndex-1
elseif tmIndex==6 then
return nil
end
return tmList[tmIndex]
end
end
end
return nil
end

function UIDiscipleModel.getTianMingName(name)
return FMT.fmt('【{0}】',name)
end


function UIDiscipleModel:getTianMingJJRate(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getTianMingJJRateEx(netData)
end
function UIDiscipleModel:getTianMingJJRateEx(netData)
local rate=0
if netData then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
if tmlv>=0 then
rate=cfgHelper.get2(cfg_discipletianminglevelconfig_get,tmlv,'percent')
rate=rate/100.0
end
end
return rate
end



function UIDiscipleModel:checkTiamMingCiFuOpen(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:checkTiamMingCiFuOpenEx(netData)
end
function UIDiscipleModel:checkTiamMingCiFuOpenEx(netData)
return UIDiscipleModel:checkTiamMingCiFuPosOpenEx(netData,1)
end

function UIDiscipleModel:checkTiamMingCiFuPosOpen(guid,posIndex)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:checkTiamMingCiFuPosOpenEx(netData,posIndex)
end
function UIDiscipleModel:checkTiamMingCiFuPosOpenEx(netData,posIndex)
if netData then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
return UIDiscipleModel.checkTiamMingCiFuPosOpenX(tmlv,posIndex)
end
end

function UIDiscipleModel.checkTiamMingCiFuPosOpenX(tmlv,posIndex,isWarning)
local limit=cfgHelper.getdef2(cfg_discipletmcfconfig,'pos',posIndex)
local flag=false
if tmlv>=0 then
flag=tmlv>=limit
end
if not flag then
if isWarning==true then
local lock_str=FMT.fmt('{0}解锁',UIDiscipleModel.getTianMingLevelDesc(limit))
UIManager.error(lock_str)
end
end
return flag,limit
end

function UIDiscipleModel:getTianMingCiFuID(guid,posIndex)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getTianMingCiFuIDEx(netData,posIndex)
end

function UIDiscipleModel:getTianMingCiFuIDEx(netData,posIndex)
if netData then
if posIndex==nil then
return netData.tmcfList or{}
else
if netData.tmcfList then
return netData.tmcfList[posIndex]
end
end
end
end

function UIDiscipleModel.getTianMingCiFuSelectCfg(job,posIndex,dzId)
dzId=dzId or 0

local cfg=cfgHelper.get1(cfg_discipletmcfselectconfig_get,dzId)
if cfg then
return cfg[job][posIndex]['list']
else
dzId=0
return cfgHelper.get4(cfg_discipletmcfselectconfig_get,dzId,job,posIndex,'list')
end
end




eDZTianMingEffectType={



eSkillReplace=1,
}

function UIDiscipleModel:getTianMingEffectList(netData,jobid)
if netData==nil then return end

if jobid==nil then
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
jobid=imageInfo.job
end
local list={}
if UIDiscipleModel:checkOponTianMing(netData)then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local floor=cfgHelper.getdef1(cfg_discipletianmingconfig,'floor')
local tmList=UIDiscipleModel:getTianMingByIndexEx(netData)
for i,limit_tmlv in ipairs(floor)do
if tmlv>=limit_tmlv then
local tmID=tmList[i]
if tmID then
local effect=cfgHelper.get2(cfg_discipletianmingconfig_get,tmID,'effect')
if effect then
local temp=effect[jobid]
if temp==nil then
temp=effect[0]
end
for i2,v2 in ipairs(temp)do
list[#list+1]=v2
end
end
end
end
end
end
return list
end

function UIDiscipleModel:getTianMingEffectByType(netData,effType,jobid)
local all=UIDiscipleModel:getTianMingEffectList(netData,jobid)
local list={}
for i,v in ipairs(all)do
if effType==v[1]then
list[#list+1]=v
end
end
return list
end



function UIDiscipleModel:getDiscipleTianMingReddot(guid,checkSpe,isIgnoreNormalDz)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
if tmlv>=0 then
local next_tmcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,tmlv+1)
local isfull=next_tmcfg==nil
if not isfull then
local cost=UIDiscipleModel:getUpTianMingCost(netData)
local itemid=cost[1][1]
if isIgnoreNormalDz then

local normal_itemid=UIDiscipleModel:getUpTianMingCost_normalItem()
if normal_itemid and itemid==normal_itemid then

return false
end
end

local itemNum=cost[1][2]
local has_itemNum=bagModel.getItemCountById(itemid)
local moneyType=cost[2][1]
local moneyNum=cost[2][2]
local has_moneyNum=moneyModel.getMoney(moneyType)

local use_spe_itemNum=0
local isSPdz=UIDiscipleModel:isSPDiscipleEx(guid)
if checkSpe and not isSPdz then
local spe_itemid=UIDiscipleModel:getUpTianMingCost2()
local spe_itemNum=0

if has_itemNum<itemNum and itemid~=spe_itemid then
spe_itemNum=bagModel.getItemCountById(spe_itemid)
use_spe_itemNum=math.min(spe_itemNum,math.abs(has_itemNum-itemNum))
end
end
local num=has_itemNum+use_spe_itemNum
if num>=itemNum and has_moneyNum>=moneyNum then
return true
end
local poslist=cfgHelper.getdef1(cfg_discipletmcfconfig,'pos')
local allCiFuIDList=UIDiscipleModel:getTianMingCiFuIDEx(netData)
for i,limit_tmlv in ipairs(poslist)do
if tmlv>=limit_tmlv then
local cifuID=allCiFuIDList[i]
local has=cifuID~=nil and cifuID~=0
if not has then
return true
end
end
end
end
end
end
return false
end


function UIDiscipleModel:getDiscipleTianMingCiFuReddot(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local allCiFuIDList=UIDiscipleModel:getTianMingCiFuIDEx(netData)
local ciFuCount=3
for i=1,ciFuCount do
local cifuID=allCiFuIDList[i]
local isActive,limit_tmlv=UIDiscipleModel.checkTiamMingCiFuPosOpenX(tmlv,i)
local has=cifuID~=nil and cifuID~=0
if isActive then
if not has then

return true
end
end
end
end
return false
end