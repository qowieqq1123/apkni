






local _MODULENAME="ClothingModel"


def_table(_MODULENAME)
ClothingModel.name=_MODULENAME
ClothingModel.data={}

function ClothingModel:onAppStart()

end


function ClothingModel:onEnterState(isReconnect)
ClothingModel:init()
end


function ClothingModel:onLeaveState(isReconnect)

self.data={}
end


function ClothingModel:init()
self.equips={}
self.equipsLookup={}
self.diziLookup={}
self.equipsSwitchIdxLookup={}
self.data.collectClotingData={}
self:initAttrsData()
end

function ClothingModel:initEquip(diziArray)
self.equips={}
self.equipsLookup={}
self.equipsSwitchIdxLookup={}
for i,v in ipairs(diziArray)do
self:addNewDizi(v,true)
end
end

function ClothingModel:deleDizi(diziguid)
self:deleteEquip(diziguid)
end

function ClothingModel:addNewDizi(dizidata,notCalcCollect)
if self.equips==nil then self.equips={}end
if self.equipsLookup==nil then self.equipsLookup={}end
local diziguid=dizidata.discipleguid
local array=dizidata.dressList or{}
for i,v in ipairs(array)do
self:addEquip(diziguid,v)
end

if dizidata.switchList and next(dizidata.switchList)then
for switchidx,data in ipairs(dizidata.switchList)do
if data.dressList and next(data.dressList)then
local switchEquipList=data.dressList
for i,v in ipairs(switchEquipList)do
self:addEquip(diziguid,v,nil,switchidx)
end
end
end
end

if not notCalcCollect then
if self.data.collectClotingData then
for type2,newStar in pairs(self.data.collectClotingData)do
ClothingModel:onChangeDiziCollectStarOnStarUp(diziguid,type2,newStar)
end
end
end
end

function ClothingModel:addEquip(diziguid,item,showFightTips,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
local litem=self.equipsLookup[diziguidStr]and self.equipsLookup[diziguidStr][switchidx]or nil
if litem and tostring(litem.itemguid)==tostring(item.itemguid)then return end
local itemguid=item.itemguid

if not self.equipsLookup[diziguidStr]then
self.equipsLookup[diziguidStr]={}
end
self.equipsLookup[diziguidStr][switchidx]=item
self.equips[tostring(item.itemguid)]=item
if switchidx~=0 then
self.equipsSwitchIdxLookup[tostring(itemguid)]=switchidx
end

self.diziLookup[tostring(item.itemguid)]={guid=diziguid,switchidx=switchidx}

if switchidx==0 then
self:onChangeAttrsOnEquip(diziguid,itemguid,showFightTips)
end
end


function ClothingModel:deleteEquip(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
local item=self.equipsLookup[diziguidStr]and self.equipsLookup[diziguidStr][switchidx]or nil
if item==nil then return end
self.equipsLookup[diziguidStr][switchidx]=nil
local itemguid=item.itemguid
self.equips[tostring(itemguid)]=nil
self.diziLookup[tostring(itemguid)]=nil
self.equipsSwitchIdxLookup[tostring(itemguid)]=nil
if switchidx==0 then
self:onChangeAttrsOnEquip(diziguid,itemguid)
end
return EQUIP_TYPE.eShiZhuang
end

function ClothingModel:switchEquip(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if not self.equipsLookup[diziguidStr]then
self.equipsLookup[diziguidStr]={}
end
local useSwitchIdx=0
local originalEquip=self.equipsLookup[diziguidStr][useSwitchIdx]
local switchEquip=self.equipsLookup[diziguidStr][switchidx]
self.equipsLookup[diziguidStr][useSwitchIdx]=switchEquip
self.equipsLookup[diziguidStr][switchidx]=originalEquip

if originalEquip and next(originalEquip)then
self.diziLookup[tostring(originalEquip.itemguid)]={guid=diziguid,switchidx=switchidx}
self.equipsSwitchIdxLookup[tostring(originalEquip.itemguid)]=switchidx
self:onChangeAttrsOnEquip(diziguid,originalEquip.itemguid)
end
if switchEquip and next(switchEquip)then
self.diziLookup[tostring(switchEquip.itemguid)]={guid=diziguid,switchidx=useSwitchIdx}
self.equipsSwitchIdxLookup[tostring(switchEquip.itemguid)]=nil
self:onChangeAttrsOnEquip(diziguid,switchEquip.itemguid)
end
end

function ClothingModel:hideDress(diziguid,hidedress)
local netData=UIDiscipleModel:getDiscipleData(diziguid)
if netData==nil then return end
netData.hidedress=hidedress
UIDiscipleModel.calculationDiscipleImageBase(netData)
UIDiscipleModel:setDiscipleImageDirty(netData)
end

function ClothingModel:addBagItem(equip)
local itemid=equip.itemid

end

function ClothingModel:onDressEquip(diziguid,itemguid)
local item=bagModel.getItem(itemguid)
if item==nil then
loggerUtil.logErrFMT('背包不存在此装备',tostring(itemguid))
return
end
self:addEquip(diziguid,item,true)
end

function ClothingModel:onTakeOffEquip(diziguid)
self:deleteEquip(diziguid)
end

function ClothingModel:changeBagItem(itemid,itemguid)

end

function ClothingModel:getEquip(itemguid)
return self.equips[tostring(itemguid)]
end

function ClothingModel:getEquipByDizi(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if self.equipsLookup[diziguidStr]==nil then return end
if self.equipsLookup[diziguidStr][switchidx]==nil then return end
return self.equipsLookup[diziguidStr][switchidx]
end

function ClothingModel:getAnyDiziEquip()
if self.equipsLookup==nil then return end
return self.equipsLookup
end

function ClothingModel:getEquipSwitchIdx(itemguid)
return self.equipsSwitchIdxLookup[tostring(itemguid)]
end

function ClothingModel:getDiziguidByItemguid(itemguid)
local data=self.diziLookup[tostring(itemguid)]
return data and data.guid or nil
end

function ClothingModel:getEquipByFilter(filter,useCache)
return itemsFilterHelper.filterLookItems(self.equips,filter,useCache)
end

function ClothingModel:isEquipedOnAnyDizi(itemguid)
return self:getEquip(itemguid)~=nil
end

function ClothingModel:getAllEquip(ignoreguid)
local temp={}
for i,v in pairs(self.equips)do
if ignoreguid==nil or tostring(ignoreguid)~=tostring(v.itemguid)then
temp[#temp+1]=v
end
end
return temp
end

function ClothingModel:getAllVocEquip(ignoreguid,voc)
local temp={}
for i,v in pairs(self.equips)do
if ignoreguid==nil or tostring(ignoreguid)~=tostring(v.itemguid)then
if voc==itemsConfig.getConfig(v.itemid).type1 then
temp[#temp+1]=v
end
end
end
return temp
end

function ClothingModel:getAllType2Equip(ignoreguid,type2)
local temp={}
for i,v in pairs(self.equips)do
if ignoreguid==nil or tostring(ignoreguid)~=tostring(v.itemguid)then
if type2==itemsConfig.getConfig(v.itemid).type2 then
temp[#temp+1]=v
end
end
end
return temp
end

function ClothingModel:getStarLvByEquip(equip)
local itemData=equip.itemData
if itemData then
return itemData.star or 0
end
return 0
end

function ClothingModel:getStarLv(itemguid)
local equip=equipsHelper.getEquip(itemguid)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.star or 0
end
end
return 0
end

function ClothingModel:getStarByDizi(dzguid)
local equip=self:getEquipByDizi(dzguid)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.star or 0
end
end
return 0
end

function ClothingModel:onEquipStar(itemguid,star)
local item=equipsHelper.getEquip(itemguid)
if item and item.itemData then
local itemData=item.itemData
itemData.star=star

ClothingModel:updateCollectStar(item.itemid,star)
end
end

function ClothingModel:onEquipStarByDizi(diziguid,star)
local item=self:getEquipByDizi(diziguid)
if item and item.itemData then
local itemData=item.itemData
itemData.star=star
self:onChangeAttrsOnEquip(diziguid,item.itemguid,true)
ClothingModel:updateCollectStar(item.itemid,star)
end
end

function ClothingModel:updateCollectStar(itemid,star)
local type2=itemsConfig.getConfig(itemid).type2
local collect=ClothingModel:getClothingCollectStarLv(type2)or 0
if star>=collect then
self.data.collectClotingData[type2]=star
ClothingModel:onChangeCollectStarOnStarUp(type2,star)
end
end

function ClothingModel:isEquipedOnDizi(diziguid,itemguid)
local item=self:getEquipByDizi(diziguid)
if item and tostring(item.itemguid)==tostring(itemguid)then
return true
end
return false
end



function ClothingModel:initClotingData(len,list)
local t={}
if len>0 then
for i,v in ipairs(list)do
t[v.param_1]=v.param_2
ClothingModel:onChangeCollectStarOnStarUp(v.param_1,v.param_2)
end
end
self.data.collectClotingData=t
end

function ClothingModel:getClothingCollectStarLv(type2)
return self.data.collectClotingData[type2]or 0
end

function ClothingModel:getClothingCollectStarLvById(itemid)
local cfg=itemsConfig.getConfig(itemid)
return self.data.collectClotingData[cfg.type2]or 0
end

function ClothingModel:getClothingCollectData()
return self.data and self.data.collectClotingData or nil
end

function ClothingModel:getAllEquipByItemid(itemid)
local temp={}
for i,v in pairs(self.equips)do
if v.itemid==itemid then
temp[#temp+1]=v
end
end
return temp
end