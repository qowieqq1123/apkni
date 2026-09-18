








function wanBaoXunBaoDuiModel:getDressEquipList()
local dressEquipList={}
for k,v in pairs(self.employeeLookUp)do
if v.equip_num>0 then
for kk,vv in pairs(v.equipList)do
dressEquipList[vv]=1
end
end
end
return dressEquipList
end



function wanBaoXunBaoDuiModel:collecteMaomaoEquipedData()
self.catEquipedData={}
self.catEquipDataLookUp={}
for catguid,catdata in pairs(self.employeeLookUp)do
if catdata.equip_num>0 then
for eindex,equipItemData in pairs(catdata.equipList)do
equipItemData.equiped=catguid
table.insert(self.catEquipedData,equipItemData)
self.catEquipDataLookUp[tostring(equipItemData.itemguid)]=equipItemData
end
end
end
end




function wanBaoXunBaoDuiModel:getMaomaoEquipedData()
return self.catEquipedData or{}
end




function wanBaoXunBaoDuiModel:getMaomaoEquipedLookup()
return self.catEquipDataLookUp or{}
end





function wanBaoXunBaoDuiModel:getEquipDataByGuid(guid)
local equipdata=wanBaoXunBaoDuiController:getMaomaoEquipDataByGuid(guid)
if not next(equipdata)then
equipdata=self.catEquipDataLookUp[tostring(guid)]
else
equipdata=equipdata[1]
end
return equipdata
end




function wanBaoXunBaoDuiModel:getEmployeeExpItemdata()
local constDef=self:getConstDef()
local up_exp_item_list=constDef.up_exp_item_list
local filter={
[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,up_exp_item_list},
}
local itemdatalist=bagControl.getBagItemsByFilter(ITEM_MAIN_TYPE.eItem,filter)
return itemdatalist
end





function wanBaoXunBaoDuiModel:checkEmployeeMaxLv(employeeguid)
local employeedata=self.employeeLookUp[tostring(employeeguid)]
if employeedata then
return employeedata.lv<wanBaoXunBaoDuiModel:getMaxUpLevel()
end
return false
end







function wanBaoXunBaoDuiModel:getJLItemdata(guid,compareType,color)

local filter={
[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eMaoMao}},
[ITEM_FILTER_TYPE.eColor]={compareType,{color}},
[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,{guid}},
}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eMaoMaoBag,filter)
return items
end





function wanBaoXunBaoDuiModel:statisticsEquipAttr(itemData)
local itemConfig=itemsConfig.getConfig(itemData.itemid)
local static=itemConfig.static
local attrType=static[1]
local staticAttrVal=static[2]
local jl_lv=itemData.itemData.jl_lv
local jl_exp=itemData.itemData.jl_exp
local addAttrVal=0
if jl_lv>0 then
local upPropList=cfgHelper.get2(cfg_catequipjlconfig_get,attrType,'upProp')
addAttrVal=upPropList[jl_lv]
end
local finalAttrVal=staticAttrVal+addAttrVal
return finalAttrVal,attrType
end






function wanBaoXunBaoDuiModel:getAddAttrVal(itemData,addlv)
local itemConfig=itemsConfig.getConfig(itemData.itemid)
local static=itemConfig.static
local attrType=static[1]
local staticAttrVal=static[2]
local jl_lv=itemData.itemData.jl_lv
local jl_exp=itemData.itemData.jl_exp
local addAttrVal=0
local upPropList=cfgHelper.get2(cfg_catequipjlconfig_get,attrType,'upProp')
addAttrVal=upPropList[jl_lv]or 0
local addLvAttrVal=upPropList[jl_lv+addlv]or 0
return addLvAttrVal-addAttrVal
end





function wanBaoXunBaoDuiModel:getEquipMaxJlLevel(guid)
local equipData=wanBaoXunBaoDuiModel:getEquipDataByGuid(guid)
local equipConfig=itemsConfig.getConfig(equipData.itemid)
local equipMakeConfig=cfgHelper.get1(cfg_catequipmakeconfig_get,equipConfig.color)
return equipMakeConfig.maxJLLv
end





function wanBaoXunBaoDuiModel.getJinglianValueToMaxLevelOnItem(item)
local jinglianlv=item.itemData and item.itemData.jl_lv
local jinglianexp=item.itemData and item.itemData.jl_exp
local itemid=item.itemid
local itemguid=item.itemguid
local levelExpList=cfg_catequipjlxhconfig()
local maxLv=wanBaoXunBaoDuiModel:getEquipMaxJlLevel(itemguid)
local realLv=Mathf.Min(jinglianlv+1,maxLv)
local curMaxExp=levelExpList[realLv].needExp
local needExp=curMaxExp-jinglianexp
if jinglianlv+2<=maxLv then
for index=jinglianlv+2,maxLv do
needExp=needExp+levelExpList[index].needExp
end
end
return needExp
end






function wanBaoXunBaoDuiModel.getJinglianValue(itemguid,num)
local equipData=wanBaoXunBaoDuiModel:getEquipDataByGuid(itemguid)
local equipConfig=itemsConfig.getConfig(equipData.itemid)
local maxlv=wanBaoXunBaoDuiModel:getEquipMaxJlLevel(itemguid)
local totalExp=0

if itemsConfig.isMaoMao(equipData.itemid)then
local jinglianlv=equipData.itemData and equipData.itemData.jl_lv or 0
local jinglianexp=equipData.itemData and equipData.itemData.jl_exp or 0

local calExp=0
if jinglianlv>0 then
calExp=cfgHelper.get2(cfg_catequipjlxhconfig_get,jinglianlv,'totalExp')
end
totalExp=calExp+jinglianexp+equipConfig.jlExp
end

if itemsConfig.isMaterials(equipData.itemid)then
totalExp=(equipConfig.jlExp or 0)*num
end

return totalExp
end








function wanBaoXunBaoDuiModel.getAddJinglianLv(itemid,jinglianlv,jinglianexp,addItemExp)
local levelExpList=cfg_catequipjlxhconfig()
local addLv,leftExp,overExp=0,0,0
local equipConfig=itemsConfig.getConfig(itemid)
local maxJlLv=cfgHelper.get2(cfg_catequipmakeconfig_get,equipConfig.color,'maxJLLv')
while(addItemExp>0)do
if levelExpList[jinglianlv+addLv+1]then
local exp=levelExpList[jinglianlv+addLv+1].needExp-(addLv==0 and jinglianexp or 0)
if addItemExp>=exp then
addLv=addLv+1
end

if addItemExp>exp then
addItemExp=addItemExp-exp
if jinglianlv+addLv>=maxJlLv then
if addItemExp>0 then
overExp=addItemExp
end
break
end
else
break
end
else
overExp=addItemExp
break
end
end
leftExp=addItemExp
return addLv,leftExp,overExp
end




function wanBaoXunBaoDuiModel:getCatEquips()
local equipList={}
local cats=wanBaoXunBaoDuiModel:getEmployeeList()
for k,catinfo in ipairs(cats)do
local catEquipList=catinfo.equipList or{}
if#catEquipList>0 then
equipList=table.concatTable(equipList,catEquipList)
end
end
return equipList
end





function wanBaoXunBaoDuiModel:checkHasCatEquip(guid)
local cats=wanBaoXunBaoDuiModel:getEmployeeList()
for k,catinfo in ipairs(cats)do
local catEquipList=catinfo.equipList or{}
if#catEquipList>0 then
local equipData=catEquipList[1]
if mathHelper.compareInt64(guid,equipData.itemguid)then
return true,catinfo.guid
end
end
end
return false
end




function wanBaoXunBaoDuiModel:getSelectEquipDressState()
return self.selectEquipDressState or false
end




function wanBaoXunBaoDuiModel:setSelectEquipDressState(state)
self.selectEquipDressState=state
end
