







function UIDiscipleModel:checkSystemReddot()
if not UIDiscipleController:checkInit()then return false end

if UIDiscipleModel:checkAllDiscipleJJReddot()then
return true
end













return false
end



function UIDiscipleModel:checkAllDiscipleJJReddot(asynch,asynchData)
if not UIDiscipleController:checkInit()then return false end

local alldisciple=UIDiscipleModel:getAllDiscipleData()
if alldisciple then
local cnt=5
for k,v in pairs(alldisciple)do
if not asynch or cnt>0 and not asynchData[k]then
cnt=cnt-1
if asynch then
asynchData[k]=true
end
local netData=v.netData.net
local chuiwei=UIDiscipleModel:checkDiscipleState2(netData.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)

if not chuiwei and UIDiscipleModel:checkJJReddot(netData.discipleguid)then
return true
end
elseif asynch then
if cnt<=0 then
return-1,asynchData
end
end
end
end
return false
end




function UIDiscipleModel:checkAllDiscipleXianMoReddot(asynch,asynchData)
if not UIDiscipleController:checkInit()then return false end

local alldisciple=UIDiscipleModel:getAllDiscipleData()
if alldisciple then
local cnt=5
for k,v in pairs(alldisciple)do
if not asynch or cnt>0 and not asynchData[k]then
cnt=cnt-1
if asynch then
asynchData[k]=true
end
local netData=v.netData.net
local discipleguid=netData.discipleguid
local chuiwei=UIDiscipleModel:checkDiscipleState2(discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)

if not chuiwei then
if UIDiscipleModel:checkDiscipleIsTop5(discipleguid)then
if UIDiscipleModel:checkDiscipleXianMoTransferReddot(discipleguid)then
return true
end
if UIDiscipleModel:checkDiscipleXianMoXinFaReddot(discipleguid)then
return true
end
end
end
elseif asynch then
if cnt<=0 then
return-1,asynchData
end
end
end
end
return false
end




function UIDiscipleModel:checkAllDiscipleWXGReddot(asynch,asynchData)
if asynch then
if not asynchData.checkWXGReddot then
asynchData.checkWXGReddot=true
local ret=WenXinGuanModel:isHaveReddot()

if ret then
return true
else
return-1,asynchData
end
end

if not asynchData.checkWXGYuLanReddot then
asynchData.checkWXGYuLanReddot=true
local ret=WenXinGuanModel:alldzXMYuLanReddot()

if ret then
return true
else
return-1,asynchData
end
end
else
if WenXinGuanModel:isHaveReddot()then return true end
if WenXinGuanModel:alldzXMYuLanReddot()then return true end
end

return false
end


















function UIDiscipleModel:checkDiscipleInofReddot2(guid)
local chuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)




if not chuiwei then
if UIDiscipleModel:checkJJReddot(guid)then
return true
end
if UIDiscipleModel:isShuWuDiscipleEx(guid)then
if UIDiscipleController:checkShuWuDZReddot(guid)then
return true
end
else
if UIDiscipleModel:checkLTReddot(guid)then
return true
end
end
if UIDiscipleModel:checkDZQiZhenSystemReddot(guid)then
return true
end
if UIDiscipleModel:checkDiscipleXianMoTransferReddot(guid)then
return true
end
if UIDiscipleModel:checkDiscipleXianMoXinFaReddot(guid)then
return true
end
end
return false
end


function UIDiscipleModel:checkDiscipleEquipReddot(diziguid)
local equipTypeList=EQUIP_TYPE
for _,equipType in pairs(equipTypeList)do
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if equipType~=EQUIP_TYPE.eFuBao then
local ret=equipsReddotHelper.getBetterReddotByDZ(diziguid,equipType)
if ret then
return true
end
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local reddot=false
if itemsConfig.isFabao(itemid)then
if fabaoConfig.isBenMingFabao(itemid)then
reddot=benMingFaBaoHelper.canlxUp(itemguid)
end
if not reddot then
reddot=fabaoHelper.checkFabaoIsCanJiLian(itemguid)
end
elseif itemsConfig.isEquip(itemid)then
reddot=equipsHelper.checkEquipIsCanJingLian(itemguid)
elseif itemsConfig.isDaoBing(itemid)then
reddot=daobingHelper.checkDaoBingReddot(itemguid)
elseif itemsConfig.isVocEquip(itemid)then
reddot=vocEquipController:checkVocEquipZhuanHuanReddot_diziid(diziguid)
end

if reddot then
return true
end
end
end


local reddot=UIFuLuFangModel:checkDiscipleNeedEquipFubao(diziguid)
if reddot then
return true
end

local lsGuid=UIDiscipleModel:getDZLingShou(diziguid)
if lsGuid and lingshouModel:checkLingShouReddot(lsGuid)then
return true
end
end
return false
end


function UIDiscipleModel:checkDiscipleSkillReddot(diziguid)

if zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eCangJingGe)then

local netData=UIDiscipleModel:getDiscipleData(diziguid)
local usingGFList=UIDiscipleModel:getDiscipleUsingGFList(netData)
for idx=1,2 do
local gfID=usingGFList[idx]
local hasGF=gfID>0
local reddot=UIDiscipleModel:checkDiscipleGFSlotCanSetup(netData,idx)
if not reddot and hasGF then
reddot=UIDiscipleModel:checkDiscipleGFSlotCanUp(netData,idx)
end

if reddot then
return true
end
end
end


local equipType=EQUIP_TYPE.eFabao
local reddot=equipsReddotHelper.getBetterFabaoReddotByDZ(diziguid)
if reddot then

return true
end
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if equip then

local itemid=equip.itemid
local itemguid=equip.itemguid
local reddot=false
if fabaoConfig.isBenMingFabao(itemid)then
reddot=benMingFaBaoHelper.canlxUp(itemguid)
end
if not reddot then
reddot=fabaoHelper.checkFabaoIsCanJiLian(itemguid)
end

if reddot then
return true
end
end

return false
end


function UIDiscipleModel:checkDiscipleBengMingFaBaoReddot(diziguid)
local equipType=EQUIP_TYPE.eFabao
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if not equip then

return false
end

local itemid=equip.itemid
local itemguid=equip.itemguid
if fabaoConfig.isBenMingFabao(itemid)then
return benMingFaBaoHelper.canlxUp(itemguid)
end

return false
end


function UIDiscipleModel:checkDiscipleLingGenReddot(diziguid)
return UIDiscipleModel:checkDiscipleStrengthenLingGenReddot(diziguid)or
UIDiscipleModel:checkDiscipleVaryLingGenReddot(diziguid)or
UIDiscipleModel:checkDiscipleCanEquipHoardReddot(diziguid)
end


function UIDiscipleModel:checkDiscipleSelectReddot(diziguid)

if UIDiscipleModel:checkDiscipleIsTop5(diziguid)then

if UIDiscipleModel:getDiscipleTianMingReddot(diziguid)or
UIDiscipleModel:getDiscipleTianMingCiFuReddot(diziguid)or
UIDiscipleModel:getDiscipleDaoYanReddot(diziguid)or
UIDiscipleModel:checkDiscipleInofReddot2(diziguid)or
UIDiscipleModel:checkDiscipleSkillReddot(diziguid)or
UIDiscipleModel:checkDiscipleEquipReddot(diziguid)or
UIDiscipleModel:checkDiscipleLingGenReddot(diziguid)then
return true
end
else

local netData=UIDiscipleModel:getDiscipleData(diziguid)
if netData then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
if tmlv>=0 then
local cost=UIDiscipleModel:getUpTianMingCost(netData)
local itemid=cost[1][1]

local normal_itemid=UIDiscipleModel:getUpTianMingCost_normalItem()
if normal_itemid and itemid==normal_itemid then

return false
else
if UIDiscipleModel:getDiscipleTianMingReddot(diziguid,nil,true)or
UIDiscipleModel:getDiscipleDaoYanReddot(diziguid)or
UIDiscipleModel:getDiscipleTianMingCiFuReddot(diziguid)then
return true
end
end
end
end
end


return false
end