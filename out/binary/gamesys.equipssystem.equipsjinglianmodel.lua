














function equipsModel.onJinglianEquip(diziguid,equipType,level,exp,list)
local equip=equipsModel.getEquipByDizi(diziguid,equipType)
local itemguid=equip.itemguid
equipsModel.onJinglianEquipByEquip(equip,level,exp,list)
equipsModel.equips[tostring(itemguid)]=equip
equipsModel.onChangeAttrsOnJinglianEquip(diziguid,itemguid)
end

function equipsModel.onJinglianEquipByEquip(equip,level,exp,list)
if equip then
if equip.itemData==nil then
equip.itemData={}
equip.itemData.itemtype=ITEM_MAIN_TYPE.eEquip
equip.itemData.len=0
equip.itemData.suitid=0
equip.itemData.jinglianexp=0
equip.itemData.jinglianlv=0
end
local itemData=equip.itemData
itemData.jinglianlv=level
itemData.jinglianexp=exp


local randattrList=itemData.randattrList or{}
if list and#list>0 then
local temp={}
for i,v in ipairs(list)do
for ii,vv in ipairs(randattrList)do
if v.param_1==vv.param_1 then
table.remove(randattrList,ii)
break
end
end
temp[#temp+1]=v
end
itemData.randattrList=temp
end
itemData.len=#(itemData.randattrList or{})
equipsHelper.setEquipAttrsDirty(equip,true)
end
end







function equipsModel.getEquipJinglianLevelByDizi(diziguid,equipType)
local equip=equipsModel.getEquipByDizi(diziguid,equipType)
return equipsModel.getEquipJinglianLevel(equip)
end


function equipsModel.getEquipJinglianLevelByGUID(itemguid)
local equip=equipsHelper.getEquip(itemguid)
return equipsModel.getEquipJinglianLevel(equip)
end


function equipsModel.getEquipJinglianLevel(equip)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.jinglianlv,itemData.jinglianexp
end
end
return 0,0
end



function equipsModel:loadEqupJingLianDropDownIdx()
self.selectedDropDownIdx=userActorSetting.get('equipjinglianselected',{EQUIP_STAGE_MAX-1,0})
end

function equipsModel:saveEquipJingLianDropDownIdx()
userActorSetting.set('equipjinglianselected',self.selectedDropDownIdx)
userActorSetting.flush()
end

function equipsModel:changeEquipJingLianDropDownIdx(indexArgs)
self.selectedDropDownIdx=indexArgs

reddotControl.on_change_catch_type(CATCH_TYPE.eEquipJingLianFilterChanged)
end

function equipsModel:getEquipJingLianDropDownIdx(dropType)
local list=self.selectedDropDownIdx
if list then
if dropType==ITEM_FILTER_TYPE.eStage then
return list[1]
elseif dropType==ITEM_FILTER_TYPE.eColor then
return list[2]
end
end
return 0
end


function equipsModel:getCacheTempTable_Materials()
if not self.cache_temp_materials then
self.cache_temp_materials={}
end

table.clear(self.cache_temp_materials)
return self.cache_temp_materials
end