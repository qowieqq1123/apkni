






local _MODULENAME="vocEquipModel"


def_table(_MODULENAME)
vocEquipModel.name=_MODULENAME
vocEquipModel.data={}

function vocEquipModel:onAppStart()

end


function vocEquipModel:onEnterState(isReconnect)
vocEquipModel:init()
end


function vocEquipModel:onProtocolReq()

end


function vocEquipModel:onLeaveState(isReconnect)

self.data={}
end


function vocEquipModel:init()
self.equips={}
self.equipsLookup={}
self.equipsCountLookup={}
self.diziLookup={}
self.gongMingGbLookup={}
self.equipsSwitchIdxLookup={}
self:initAttrsData()
end

function vocEquipModel:initEquip(diziArray)
self.equips={}
self.equipsLookup={}
self.equipsCountLookup={}
self.equipsSwitchIdxLookup={}
for i,v in ipairs(diziArray)do
self:addNewDizi(v,true)
end
end

function vocEquipModel:deleDizi(diziguid)
self:deleteEquip(diziguid)
end

function vocEquipModel:addNewDizi(dizidata)
if self.equips==nil then self.equips={}end
if self.equipsLookup==nil then self.equipsLookup={}end
local diziguid=dizidata.discipleguid
local array=dizidata.vocequipList or{}
for i,v in ipairs(array)do
self:addEquip(diziguid,v)
end

if dizidata.switchList and next(dizidata.switchList)then
for switchidx,data in ipairs(dizidata.switchList)do
if data.vocequipList and next(data.vocequipList)then
local switchEquipList=data.vocequipList
for i,v in ipairs(switchEquipList)do
self:addEquip(diziguid,v,nil,switchidx)
end
end
end
end
end

function vocEquipModel:addEquip(diziguid,item,showFightTips,switchidx)
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
if not self.equipsCountLookup[itemid]then
self.equipsCountLookup[itemid]=0
end
self.equipsCountLookup[itemid]=self.equipsCountLookup[itemid]+1

if switchidx==0 then
self:onChangeAttrsOnEquip(diziguid,itemguid,showFightTips)
end
end


function vocEquipModel:deleteEquip(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
local item=self.equipsLookup[diziguidStr]and self.equipsLookup[diziguidStr][switchidx]or nil
if item==nil then return end
self.equipsLookup[diziguidStr][switchidx]=nil
local itemguid=item.itemguid
local itemid=item.itemid
self.equips[tostring(itemguid)]=nil
self.diziLookup[tostring(itemguid)]=nil
self.equipsSwitchIdxLookup[tostring(itemguid)]=nil
if self.equipsCountLookup[itemid]then
self.equipsCountLookup[itemid]=self.equipsCountLookup[itemid]-1
end
if switchidx==0 then
self:onChangeAttrsOnEquip(diziguid,itemguid)
end
return EQUIP_TYPE.eVocEquip
end

function vocEquipModel:switchEquip(diziguid,switchidx)
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

function vocEquipModel:onDressEquip(diziguid,itemguid)
local item=bagModel.getItem(itemguid)
if item==nil then
loggerUtil.logErrFMT('背包不存在此装备',tostring(itemguid))
return
end
self:addEquip(diziguid,item,true)
end

function vocEquipModel:onTakeOffEquip(diziguid)
self:deleteEquip(diziguid)
end

function vocEquipModel:getEquip(itemguid)
return self.equips[tostring(itemguid)]
end

function vocEquipModel:getEquipByDizi(diziguid,switchidx)
if not diziguid then
return nil
end
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if self.equipsLookup[diziguidStr]==nil then return end
if self.equipsLookup[diziguidStr][switchidx]==nil then return end
return self.equipsLookup[diziguidStr][switchidx]
end

function vocEquipModel:getAnyDiziEquip()
if self.equipsLookup==nil then return end
return self.equipsLookup
end

function vocEquipModel:getEquipSwitchIdx(itemguid)
return self.equipsSwitchIdxLookup[tostring(itemguid)]
end

function vocEquipModel:getDiziguidByItemguid(itemguid)
local data=self.diziLookup[tostring(itemguid)]
return data and data.guid or nil
end

function vocEquipModel:getEquipByFilter(filter,useCache)
return itemsFilterHelper.filterLookItems(self.equips,filter,useCache)
end

function vocEquipModel:isEquipedOnAnyDizi(itemguid)
return self:getEquip(itemguid)~=nil
end

function vocEquipModel:getAllEquip(ignoreguid)
local temp={}
for i,v in pairs(self.equips)do
if ignoreguid==nil or tostring(ignoreguid)~=tostring(v.itemguid)then
temp[#temp+1]=v
end
end
return temp
end

function vocEquipModel:getAllVocEquip(ignoreguid,voc)
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

function vocEquipModel:isEquipedOnDizi(diziguid,itemguid)
local item=self:getEquipByDizi(diziguid)
if item and tostring(item.itemguid)==tostring(itemguid)then
return true
end
return false
end

function vocEquipModel:getAllEquipByItemid(itemid)
local temp={}
for i,v in pairs(self.equips)do
if v.itemid==itemid then
temp[#temp+1]=v
end
end
return temp
end


function vocEquipModel:getEquipsCountByItemid(itemid)
return self.equipsCountLookup[itemid]or 0
end


function vocEquipModel.onStrengthenEquip(diziguid,level,exp)
local equip=vocEquipModel:getEquipByDizi(diziguid)
local itemguid=equip.itemguid
vocEquipModel.onStrengthenEquipByEquip(equip,level,exp)
vocEquipModel.equips[tostring(itemguid)]=equip

vocEquipModel:onChangeAttrsOnEquip(diziguid,itemguid)
end

function vocEquipModel.onStrengthenEquipByEquip(equip,level,exp)
if equip then
if equip.itemData==nil then
equip.itemData={}
equip.itemData.itemtype=ITEM_MAIN_TYPE.eVocEquip
equip.itemData.enhancelv=0
equip.itemData.enhanceexp=0
end
local itemData=equip.itemData
itemData.enhancelv=level
itemData.enhanceexp=exp
vocEquipHelper.setEquipAttrsDirty(equip,true)
end
end


function vocEquipModel.getVocEquipStrengthenLevelByDizi(diziguid)
local equip=vocEquipModel:getEquipByDizi(diziguid)
if equip then
return vocEquipModel.getVocEquipStrengthenLevel(equip)
end
end


function vocEquipModel.getVocEquipStrengthenLevelByGUID(itemguid)
local equip=equipsHelper.getEquip(itemguid)
return vocEquipModel.getVocEquipStrengthenLevel(equip)
end

function vocEquipModel.getVocEquipStrengthenLevel(equip)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.enhancelv,itemData.enhanceexp
end
end
return 0,0
end


function vocEquipModel:getVocEquipGongMingLv(itemid)
local gongMingLv=0
local gongMingGbList=vocEquipHelper.getVocEquipGongMingGBIdList(itemid)
if gongMingGbList and next(gongMingGbList)then
local gmGbCount=#gongMingGbList
local activeCount=0
local starCount_3=0
local starCount_5=0
local jueXingCount=0

for _,gbid in ipairs(gongMingGbList)do
local isActive=gubaoModel:checkActive(gbid)
if isActive then
activeCount=activeCount+1
local gbData=gubaoModel:getDataByID(gbid)
local starlv=gbData and gbData.gubaostar or 0
if starlv>=3 then
starCount_3=starCount_3+1
end

if starlv>=5 then
starCount_5=starCount_5+1
end

local isJueXing=isActive and gubaoModel:checkAwake(gbid)or false
if isJueXing then
jueXingCount=jueXingCount+1
end
end
end

if jueXingCount>=gmGbCount then

gongMingLv=4
elseif starCount_5>=gmGbCount then

gongMingLv=3
elseif starCount_3>=gmGbCount then

gongMingLv=2
elseif activeCount>=gmGbCount then

gongMingLv=1
end
end
return gongMingLv,gongMingGbList
end

function vocEquipModel:setGongMingGbLookupWithVocEquipItemGuid(gbId,itemguid)
if not self.gongMingGbLookup then
self.gongMingGbLookup={}
end

if not self.gongMingGbLookup[gbId]then
self.gongMingGbLookup[gbId]={}
end
local itemguid_str=tostring(itemguid)
self.gongMingGbLookup[gbId][itemguid_str]=true
end

function vocEquipModel:getGongMingGbLookupByGbId(gbId)
if not self.gongMingGbLookup then
return
end
return self.gongMingGbLookup[gbId]
end

function vocEquipModel:clearGongMingGbLookupWithVocEquipItemGuid(gbId,itemguid)
if not self.gongMingGbLookup or not self.gongMingGbLookup[gbId]then
return
end
local itemguid_str=tostring(itemguid)
self.gongMingGbLookup[gbId][itemguid_str]=nil
end

function vocEquipModel:getPieceToItem(piece)
local mergeCfg=cfg_lianqigeconfig()
for i,v in pairs(mergeCfg)do
if v.itemid==piece then
return v.cost[1][1]
end
end
end



function vocEquipModel.onChangeEquipByEquip(equip,itemid,itemguid)
if equip and equip.itemData then
if equip.itemData.itemtype==ITEM_MAIN_TYPE.eVocEquip then
local olditemid=equip.itemid
equip.itemid=itemid
equipsModel.ChangeVoeEquipByID(itemguid,olditemid,itemid)
end
vocEquipHelper.setEquipAttrsDirty(equip,true)
end
end

function vocEquipModel:setSwitch_cnt(voc_switch_cnt)
self.data.voc_switch_cnt=voc_switch_cnt
end
function vocEquipModel:getSwitch_cnt()
return self.data.voc_switch_cnt or 0
end
