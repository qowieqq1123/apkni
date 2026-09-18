





equipsModel={}
equipsModel.equips={}
equipsModel.equipsLookup={}
equipsModel.diziLookup={}
equipsModel.equipstakeoffLookup={}
equipsModel.equipsItemidLookup={}
equipsModel.equipsSwitchIdxLookup={}
function equipsModel.init()
equipsModel.equips={}
equipsModel.equipsLookup={}
equipsModel.diziLookup={}
equipsModel.equipstakeoffLookup={}
equipsModel.equipsItemidLookup={}
equipsModel.equipsSwitchIdxLookup={}
equipsModel.initAttrsData()
end





function equipsModel.initEquips(diziArray)
equipsModel.equips={}
equipsModel.equipsLookup={}
equipsModel.diziLookup={}
equipsModel.equipsSwitchIdxLookup={}
for i,v in ipairs(diziArray)do
equipsModel.addNewDizi(v,true)
end
end

function equipsModel.addNewDizi(dizidata,isInit)
local diziguid=dizidata.discipleguid
local equipList=dizidata.fightEquipList or{}
for i,v in ipairs(equipList)do
equipsModel.addEquip(diziguid,v,isInit)
end
if dizidata.switchList and next(dizidata.switchList)then
for switchidx,data in ipairs(dizidata.switchList)do
if data.fightEquipList and next(data.fightEquipList)then
local switchEquipList=data.fightEquipList
for i,v in ipairs(switchEquipList)do
equipsModel.addEquip(diziguid,v,isInit,switchidx)
end
end
end
end
end

function equipsModel.deleDiziEquip(diziguid,isTakeOff)
local equipTypes={}
for _,equipType in pairs(EQUIP_SUIT_TYPES)do
equipTypes[#equipTypes+1]=equipType
equipsModel.deleteEquip(diziguid,equipType)
if not isTakeOff then
local switchidx=1
equipsModel.deleteEquip(diziguid,equipType,switchidx)
end
end
return equipTypes
end


function equipsModel.onDressEquip(diziguid,itemguid)
return equipsModel.addEquipByBag(diziguid,itemguid)
end

function equipsModel.onTakeoffEquip(diziguid,equipType)
equipsModel.deleteEquip(diziguid,equipType)
end

function equipsModel.onDianHua(diziguid,reveal_times)

end





function equipsModel.addEquip(diziguid,equip,isInit,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if equipsModel.equipsLookup[diziguidStr]==nil then equipsModel.equipsLookup[diziguidStr]={}end
if equipsModel.equipsLookup[diziguidStr][switchidx]==nil then equipsModel.equipsLookup[diziguidStr][switchidx]={}end
local equipsLookup=equipsModel.equipsLookup[diziguidStr][switchidx]
local itemid=equip.itemid
local itemconfig=itemsConfig.getConfig(itemid)
local equipType=equipsConfig.getEquipType(itemid)
local lequip=equipsLookup[equipType]
if lequip and tostring(lequip.itemguid)==tostring(equip.itemguid)then
return equipType
end
if equipsModel.equipsItemidLookup[itemid]==nil then equipsModel.equipsItemidLookup[itemid]={}end
local equipsItemidLookup=equipsModel.equipsItemidLookup[itemid]
equipsItemidLookup[tostring(equip.itemguid)]=true
equipsLookup[equipType]=equip
equipsModel.equips[tostring(equip.itemguid)]=equip
if switchidx~=0 then
equipsModel.equipsSwitchIdxLookup[tostring(equip.itemguid)]=switchidx
end

equipsModel.diziLookup[tostring(equip.itemguid)]={guid=diziguid,switchidx=switchidx}
if switchidx==0 then
equipsModel.onChangeAttrsOnJinglianEquip(diziguid,equip.itemguid,isInit)
dzSpecialityEffectManager.onEquipChange(diziguid,equipType)
end
dataControl.onEquipChange()
if UIDiscipleModel:isMyActorDZ(diziguid)then
notifySystem:postNotify(notifyConfig.onEquipChange,1,diziguid,equipType)
end
return equipType
end


function equipsModel.addEquipByBag(diziguid,itemguid)
local bagEquip=bagModel.getItem(itemguid)
if bagEquip==nil then
loggerUtil.logErrFMT('背包没有找到装备guid：{0}',tostring(itemguid))
return
end
local equip=table.deepCopy(bagEquip)
return equipsModel.addEquip(diziguid,equip)
end


function equipsModel.deleteEquip(diziguid,equipType,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
equipsModel.equipstakeoffLookup[diziguidStr]=true
if equipsModel.equipsLookup[diziguidStr]==nil then return end
if equipsModel.equipsLookup[diziguidStr][switchidx]==nil then return end
local equipsLookup=equipsModel.equipsLookup[diziguidStr][switchidx]
local equip=equipsLookup[equipType]
if equip==nil then return end
local itemguid=equip.itemguid
local itemid=equip.itemid

if equipsModel.equipsItemidLookup[itemid]then
local equipsItemidLookup=equipsModel.equipsItemidLookup[itemid]
equipsItemidLookup[tostring(itemguid)]=nil
end
equipsLookup[equipType]=nil
equipsModel.equips[tostring(itemguid)]=nil
equipsModel.diziLookup[tostring(itemguid)]=nil
equipsModel.equipstakeoffLookup[tostring(itemguid)]=true

equipsModel.equipsSwitchIdxLookup[tostring(equip.itemguid)]=nil
if switchidx==0 then
equipsModel.onChangeAttrsOnJinglianEquip(diziguid,itemguid)
dzSpecialityEffectManager.onEquipChange(diziguid,equipType)
end
dataControl.onEquipChange()
notifySystem:postNotify(notifyConfig.onEquipChange,2,diziguid,equipType)
end


function equipsModel.switchEquip(diziguid,switchidx)
local diziguidStr=tostring(diziguid)
if equipsModel.equipsLookup[diziguidStr]==nil then equipsModel.equipsLookup[diziguidStr]={}end
local useSwitchIdx=0
local originalEquipsLookup=equipsModel.equipsLookup[diziguidStr][useSwitchIdx]
local switchEquipsLookup=equipsModel.equipsLookup[diziguidStr][switchidx]
equipsModel.equipsLookup[diziguidStr][useSwitchIdx]=switchEquipsLookup
equipsModel.equipsLookup[diziguidStr][switchidx]=originalEquipsLookup

for _,equipType in pairs(EQUIP_SUIT_TYPES)do
local switchEquip=switchEquipsLookup and switchEquipsLookup[equipType]or nil
local originalEquip=originalEquipsLookup and originalEquipsLookup[equipType]or nil
if originalEquip and next(originalEquip)then
equipsModel.diziLookup[tostring(originalEquip.itemguid)]={guid=diziguid,switchidx=switchidx}
equipsModel.equipsSwitchIdxLookup[tostring(originalEquip.itemguid)]=switchidx
equipsModel.onChangeAttrsOnJinglianEquip(diziguid,originalEquip.itemguid)
end
if switchEquip and next(switchEquip)then
equipsModel.diziLookup[tostring(switchEquip.itemguid)]={guid=diziguid,switchidx=useSwitchIdx}
equipsModel.equipsSwitchIdxLookup[tostring(switchEquip.itemguid)]=nil
equipsModel.onChangeAttrsOnJinglianEquip(diziguid,switchEquip.itemguid)
end
dzSpecialityEffectManager.onEquipChange(diziguid,equipType)

dataControl.onEquipChange()

if UIDiscipleModel:isMyActorDZ(diziguid)then
notifySystem:postNotify(notifyConfig.onEquipChange,3,diziguid,equipType)
end
end
end


function equipsModel:getTakeOffEquiplist()
return equipsModel.equipstakeoffLookup
end
function equipsModel:setTakeOffEquiplist(itemguid)
equipsModel.equipstakeoffLookup[tostring(itemguid)]=true
end
function equipsModel:clearTakeOffEquiplist()
equipsModel.equipstakeoffLookup={}
end


function equipsModel.getEquipGuidLookup(itemid)
return equipsModel.equipsItemidLookup[itemid]
end

function equipsModel.getAllEquipByItemID(itemid)
local itemDict={}
local equipsItemidLookup=equipsModel.equipsItemidLookup[itemid]or{}
for guidStr,_ in pairs(equipsItemidLookup)do
local equip=equipsModel.getEquip(guidStr)
itemDict[#itemDict+1]=equip
end
return itemDict
end

function equipsModel.ChangeVoeEquipByID(itemguid,olditemid,itemid)
if equipsModel.equipsItemidLookup[olditemid]then
local equipsItemidLookup=equipsModel.equipsItemidLookup[olditemid]
equipsItemidLookup[tostring(itemguid)]=nil
end
if equipsModel.equipsItemidLookup[itemid]==nil then equipsModel.equipsItemidLookup[itemid]={}end
local equipsItemidLookup2=equipsModel.equipsItemidLookup[itemid]
equipsItemidLookup2[tostring(itemguid)]=true
end






function equipsModel.getEquip(itemguid)
return equipsModel.equips[tostring(itemguid)]
end


function equipsModel.getAllEquipsByDizi(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if equipsModel.equipsLookup[diziguidStr]==nil then return end
if equipsModel.equipsLookup[diziguidStr][switchidx]==nil then return end
return equipsModel.equipsLookup[diziguidStr][switchidx]
end


function equipsModel.getEquipByDizi(diziguid,equipType,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if equipsModel.equipsLookup[diziguidStr]==nil then return end
if equipsModel.equipsLookup[diziguidStr][switchidx]==nil then return end
local equip=equipsModel.equipsLookup[diziguidStr][switchidx][equipType]
return equip
end

function equipsModel.checkEquipByItemID(diziguid,itemid)
if not itemsConfig.isEquip(itemid)then
return
end
local itemconfig=itemsConfig.getConfig(itemid)
if itemconfig==nil then return end
local equipType=equipsConfig.getEquipType(itemid)
local equip=equipsModel.getEquipByDizi(diziguid,equipType)
if equip==nil then return end
return itemid==equip.itemid
end


function equipsModel.getEquipSuit(diziguid,suitid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if equipsModel.equipsLookup[diziguidStr]==nil then equipsModel.equipsLookup[diziguidStr]={}end
if equipsModel.equipsLookup[diziguidStr][switchidx]==nil then equipsModel.equipsLookup[diziguidStr][switchidx]={}end
local equipsLookup=equipsModel.equipsLookup[diziguidStr][switchidx]
local temp={}
for equipType,equip in pairs(equipsLookup)do
local itemData=equip.itemData or{}
if itemData.suitid==suitid then
temp[#temp+1]=equip.itemguid
end
end
return temp
end

function equipsModel.getAllEquipSuit(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if equipsModel.equipsLookup[diziguidStr]==nil then equipsModel.equipsLookup[diziguidStr]={}end
if equipsModel.equipsLookup[diziguidStr][switchidx]==nil then equipsModel.equipsLookup[diziguidStr][switchidx]={}end
local equipsLookup=equipsModel.equipsLookup[diziguidStr][switchidx]
local temp={}
local lookup={}
for equipType,equip in pairs(equipsLookup)do
local itemData=equip.itemData or{}
local suitid=itemData.suitid or 0
if suitid>0 then
local num=lookup[suitid]or 0
lookup[suitid]=num+1
end
end
for suitid,num in pairs(lookup)do
temp[#temp+1]={suitid,num}
end
return temp
end


function equipsModel.getEquipByFilter(filter,useCache)
return itemsFilterHelper.filterLookItems(equipsModel.equips,filter,useCache)
end


function equipsModel.getDiziguidByItemguid(itemguid)
if itemguid==nil then return end
local data=equipsModel.diziLookup[tostring(itemguid)]
return data and data.guid or nil
end

function equipsModel.getAllEquip()
return equipsModel.equips
end






function equipsModel.isEquipedOnAnyDizi(itemguid)






return equipsModel.getEquip(itemguid)~=nil
end

function equipsModel.isHasAnyEquiped(diziguid)
for i=EQUIP_TYPE.eWeapon,EQUIP_TYPE.eDaoBing do
if equipsModel.getEquipByDizi(diziguid,i)then
return true
end
end
return false
end


function equipsModel.isEquipedOnDizi(diziguid,itemguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if equipsModel.equipsLookup[diziguidStr]==nil then return end
if equipsModel.equipsLookup[diziguidStr][switchidx]==nil then return end
local lookup=equipsModel.equipsLookup[diziguidStr][switchidx]
for equipType,equip in pairs(lookup)do
if tostring(equip.itemguid)==tostring(itemguid)then
return true
end
end
return false
end


function equipsModel.getAllEquipToBagEmot()
local temp={}
for switchidx,switchList in pairs(equipsModel.equipsLookup)do
for k,lookup in pairs(switchList)do
for equipType,equip in pairs(lookup)do
temp[#temp+1]=equip
end
end
end
return temp
end

function equipsModel.setAllEquipedAttrsDirty(dzguid)
if dzguid==nil then return end
local equipsLookup=equipsModel.getAllEquipsByDizi(dzguid)
if equipsLookup==nil then return end
for _,equip in pairs(equipsLookup)do
equipsHelper.setEquipAttrsDirty(equip,true)
end
end

function equipsModel.getEquipSwitchIdx(itemguid)
return equipsModel.equipsSwitchIdxLookup[tostring(itemguid)]
end

local _bagMutipleJinglianEquipGuidList=defaultT
function equipsModel.setBagMutipleJingLianEquipGuidList(list)
_bagMutipleJinglianEquipGuidList=table.weakCopy(list)
end

function equipsModel.getBagMutipleJingLianEquipGuidList()
return _bagMutipleJinglianEquipGuidList
end