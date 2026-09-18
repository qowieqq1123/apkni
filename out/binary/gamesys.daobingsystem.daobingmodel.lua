






local _MODULENAME="daobingModel"


def_table(_MODULENAME)
daobingModel.name=_MODULENAME
daobingModel.data={}


function daobingModel:onAppStart()

end


function daobingModel:onEnterState(isReconnect)
daobingModel:init()
end


function daobingModel:onLeaveState(isReconnect)
daobingModel:init()
end

function daobingModel:init()
self.equips={}
self.equipsLookup={}
self.diziLookup={}
self.equipsSwitchIdxLookup={}
self:initAttrsData()
end


function daobingModel:initEquip(diziArray)
self.equips={}
self.equipsLookup={}
self.equipsSwitchIdxLookup={}
for i,v in ipairs(diziArray)do
self:addNewDizi(v,true)
end
end

function daobingModel:deleDizi(diziguid)
self:deleteEquip(diziguid)
end

function daobingModel:addNewDizi(dizidata,isInit)
if self.equips==nil then self.equips={}end
if self.equipsLookup==nil then self.equipsLookup={}end
local diziguid=dizidata.discipleguid
local array=dizidata.daobingList or{}
for i,v in ipairs(array)do
self:addEquip(diziguid,v,isInit)
end

if dizidata.switchList and next(dizidata.switchList)then
for switchidx,data in ipairs(dizidata.switchList)do
if data.daobingList and next(data.daobingList)then
local switchEquipList=data.daobingList
for i,v in ipairs(switchEquipList)do
self:addEquip(diziguid,v,nil,switchidx)
end
end
end
end
end

function daobingModel:addEquip(diziguid,item,isInit,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
local litem=self.equipsLookup[diziguidStr]and self.equipsLookup[diziguidStr][switchidx]or nil
if litem and tostring(litem.itemguid)==tostring(item.itemguid)then return end
local itemguid=item.itemguid
local itemid=item.itemid
if not self.equipsLookup[diziguidStr]then
self.equipsLookup[diziguidStr]={}
end
self.equipsLookup[diziguidStr][switchidx]=item
self.equips[tostring(item.itemguid)]=item
if switchidx~=0 then
self.equipsSwitchIdxLookup[tostring(itemguid)]=switchidx
end

self.diziLookup[tostring(item.itemguid)]={guid=diziguid,switchidx=switchidx}
daobingModel:addDaoBingRecord(itemid)
if switchidx==0 then
self:onChangeAttrsOnEquip(diziguid,itemguid,not isInit)
end
pushGiftTwoManager:onDaoBingChange(isInit)
pushGiftThreeManager:onDaoBingChange(isInit)
end


function daobingModel:deleteEquip(diziguid,switchidx)
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
return EQUIP_TYPE.eDaoBing
end

function daobingModel:switchEquip(diziguid,switchidx)
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





function daobingModel:getEquip(itemguid)
return self.equips[tostring(itemguid)]
end

function daobingModel:getEquipByDizi(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if self.equipsLookup[diziguidStr]==nil then return end
if self.equipsLookup[diziguidStr][switchidx]==nil then return end
return self.equipsLookup[diziguidStr][switchidx]
end

function daobingModel:getEquipSwitchIdx(itemguid)
return self.equipsSwitchIdxLookup[tostring(itemguid)]
end

function daobingModel:getEquipByFilter(filter,useCache)
return itemsFilterHelper.filterLookItems(self.equips,filter,useCache)
end

function daobingModel:getDiziguidByItemguid(itemguid)
local data=self.diziLookup[tostring(itemguid)]
return data and data.guid or nil
end


function daobingModel:getJilianLv(itemguid)
local equip=equipsHelper.getEquip(itemguid)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.jinglianlv or 0
end
end
return 0
end

function daobingModel:getJilianLvByDizi(diziguid)
local equip=self:getEquipByDizi(diziguid)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.jinglianlv or 0
end
end
return 0
end

function daobingModel:getStarLvByEquip(equip)
local itemData=equip.itemData
if itemData then
return itemData.star or 0
end
return 0
end

function daobingModel:getStarLv(itemguid)
local equip=equipsHelper.getEquip(itemguid)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.star or 0
end
end
return 0
end

function daobingModel:getStarByDizi(dzguid)
local equip=self:getEquipByDizi(dzguid)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.star or 0
end
end
return 0
end





function daobingModel:onDressEquip(diziguid,itemguid)
local item=bagModel.getItem(itemguid)
if item==nil then
loggerUtil.logErrFMT('背包不存在此装备',tostring(itemguid))
return
end
self:addEquip(diziguid,item)
end

function daobingModel:onTakeOffEquip(diziguid)
self:deleteEquip(diziguid)
end

function daobingModel:onJilian(itemguid,level)
local equip=equipsHelper.getEquip(itemguid)
if equip and equip.itemData then
local itemData=equip.itemData
itemData.jinglianlv=level
end
end

function daobingModel:onJilianByDizi(diziguid,level)
local item=self:getEquipByDizi(diziguid)
if item and item.itemData then
local itemData=item.itemData
itemData.jinglianlv=level
self:onChangeAttrsOnEquip(diziguid,item.itemguid,true)
end
end

function daobingModel:onEquipStar(itemguid,star)
local item=equipsHelper.getEquip(itemguid)
if item and item.itemData then
local itemData=item.itemData
itemData.star=star
end
end

function daobingModel:onEquipStarByDizi(diziguid,star)
local item=self:getEquipByDizi(diziguid)
if item and item.itemData then
local itemData=item.itemData
itemData.star=star
self:onChangeAttrsOnEquip(diziguid,item.itemguid,true)
end
end



function daobingModel:isEquipedOnDizi(diziguid,itemguid)
local item=self:getEquipByDizi(diziguid)
if item and tostring(item.itemguid)==tostring(itemguid)then
return true
end
return false
end
function daobingModel:isEquipedOnDiziEx(diziguid,itemid)
local item=self:getEquipByDizi(diziguid)
if item and itemid==item.itemid then
return true
end
return false
end

function daobingModel:isEquipedOnAnyDizi(itemguid)
return self:getEquip(itemguid)~=nil
end

function daobingModel:getAllEquip(ignoreguid)
local temp={}
for i,v in pairs(self.equips)do
if ignoreguid==nil or tostring(ignoreguid)~=tostring(v.itemguid)then
temp[#temp+1]=v
end
end
return temp
end

function daobingModel:hasDaoBingRecord(itemid)
if self.record==nil then return false end
return self.record[itemid]==true
end

function daobingModel:addBagItem(equip,init)
local itemid=equip.itemid
daobingModel:addDaoBingRecord(itemid)
if itemsConfig.isDaoBingMaterials(itemid)then
reddotControl.onDaoBingCombine()
end
end

function daobingModel:changeBagItem(itemid,itemguid)
if itemsConfig.isDaoBingMaterials(itemid)then
reddotControl.onDaoBingCombine()
end
end

function daobingModel:addDaoBingRecord(itemid)
if daobingModel:hasDaoBingRecord(itemid)then return end

if self.record==nil then self.record={}end
self.record[itemid]=true
daobingModel:storeRecord()
UIManager:callWindowFunc('UIDaoBingCollectWin','freshInfo')
end

function daobingModel.onInitDaoBingRecord(length,tab)
local self=daobingModel
self.record={}
if length>0 then
local record=self.record
for i,v in ipairs(tab)do
record[v]=true
end
end
end


function daobingModel:storeRecord()
if self.delayFlushTimer==nil then
self.delayFlushTimer=FrameTimer.New(daobingModel.storeServer,1,0)
self.delayFlushTimer:Start()
end
end

function daobingModel.storeServer()
local self=daobingModel
self.delayFlushTimer=nil
if self.record==nil then return end
local temp={}
for itemid,_ in pairs(self.record)do
temp[#temp+1]=itemid
end
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.HAVE_DAO_BING,#temp,temp)
end