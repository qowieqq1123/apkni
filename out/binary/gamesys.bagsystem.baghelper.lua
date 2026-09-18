




bagHelper={}






function bagHelper.getItemName(itemguid)
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
if itemsConfig.isFabao(itemid)then
return fabaoHelper.getFabaoName(item)
end
return itemsConfig.getConfig(itemid).name
end

function bagHelper.checkAnyBagFull(checkBags)
local bagTypes=bagHelper.isAnyBagFull(true)
if bagTypes then

local bagType=nil
for i,v in ipairs(bagTypes)do

if bagType==nil then bagType=v end
end
local desc='宗门库房空间不足，请先整理'
if bagType==BAG_TYPE.eEquipBag then
desc='库房装备已满'
end
bagHelper.bagFullDialogue=UIDialogManager.getConfirmDialog(bagHelper.bagFullDialogue,'提示',desc)
bagHelper.bagFullDialogue.okcallback=function()jumpManager:jump({id=801,args={bagType=bagType}})end
bagHelper.bagFullDialogue:show()
return true
end
return false
end

function bagHelper.checkBagFull(bagType)
if bagHelper.isBagFull(bagType)then
local desc='宗门库房空间不足，请先整理'
if bagType==BAG_TYPE.eEquipBag then
desc='宗门库房装备空间不足，请先整理'
end
bagHelper.bagFullDialogue=UIDialogManager.getConfirmDialog(bagHelper.bagFullDialogue,'提示',desc,"前往")
bagHelper.bagFullDialogue.okcallback=function()jumpManager:jump({id=801,args={bagType=bagType}})end
bagHelper.bagFullDialogue:show()
return true
end
return false
end


function bagHelper.showTipsWhenEquipBagFull(floatingTips)
local desc='宗门库房装备空间不足，请先整理'
if floatingTips then
UIManager.info("库房装备空间已满，部分信件暂时无法领取")
else
bagHelper.bagFullDialogue=UIDialogManager.getConfirmDialog(bagHelper.bagFullDialogue,'提示',desc,"前往")
bagHelper.bagFullDialogue.okcallback=function()jumpManager:jump({id=801,args={bagType=BAG_TYPE.eEquipBag}})end
bagHelper.bagFullDialogue:show()
end
end

function bagHelper.isAnyBagFull(isAll)
local temp=nil
for i,v in ipairs(BAG_TYPE_LIST)do
if bagHelper.isBagFull(v)then
if isAll then
if temp==nil then temp={}end
temp[#temp+1]=v
else
return{v}
end
end
end
return temp
end

function bagHelper.isBagFull(bagType)
local num=bagControl.invokeFuncByBagType(bagType,'getBagNum')
return num>=bagConfig.getBagMaxNum(bagType)
end

function bagHelper.isLock(item)
if item==nil then return false end
return mathHelper.getBitValue(item.itemflag or 0,1)
end

function bagHelper.isBinding(item)
if item==nil then return false end
return mathHelper.getBitValue(item.itemflag or 0,0)
end

function bagHelper.setItemListInLocalFile(itemidlist,store)
for i,itemid in ipairs(itemidlist)do
bagHelper.setItemInLocalFile(itemid,false)
end
if store~=false then
bagHelper.flushLocalFile()
end
end

function bagHelper.setItemInLocalFile(itemid,store)
local ckey=ACTOR_SETTING_TYPE.eGetItem
local key=FMT.fmt('hasItem_{0}',itemid)
local hasItem=userActorArraySetting.get(ckey,key,false)
if hasItem then return end
userActorArraySetting.set(ckey,key,true)
if store~=false then
bagHelper.flushLocalFile()
end
end

function bagHelper.hasItemInLocalFile(itemid)
local ckey=ACTOR_SETTING_TYPE.eGetItem
local key=FMT.fmt('hasItem_{0}',itemid)
return userActorArraySetting.get(ckey,key,false)
end

function bagHelper.flushLocalFile()
local ckey=ACTOR_SETTING_TYPE.eGetItem
userActorArraySetting.flush(ckey)
end


function bagHelper.setItemListInLocalXMFile(typelist,store)
for type3,v in ipairs(typelist)do
bagHelper.setItemInLocalXMFile(type3,false)
end
if store~=false then
bagHelper.flushLocalFile()
end
end
function bagHelper.setItemInLocalXMFile(type3,store)
local ckey=ACTOR_SETTING_TYPE.eGetXMEquip
local key=FMT.fmt('XianMoEquip_get_{0}',type3)
local hasItem=userActorArraySetting.get(ckey,key,false)
if hasItem then return end
userActorArraySetting.set(ckey,key,true)
if store~=false then
bagHelper.flushLocalXMFile()
end
end

function bagHelper.hasItemInLocalXMFile(type3)
local ckey=ACTOR_SETTING_TYPE.eGetXMEquip
local key=FMT.fmt('XianMoEquip_get_{0}',type3)
return userActorArraySetting.get(ckey,key,false)
end
function bagHelper.flushLocalXMFile()
local ckey=ACTOR_SETTING_TYPE.eGetXMEquip
userActorArraySetting.flush(ckey)
end


function bagHelper.setItemInLocalYZZQFile(store)
local ckey=ACTOR_SETTING_TYPE.eGetyzEquip
local key='yunzhouEquip_get'
local hasItem=userActorArraySetting.get(ckey,key,false)
if hasItem then return end
userActorArraySetting.set(ckey,key,true)
if store~=false then
bagHelper.flushLocalYZZQFile()
end
end
function bagHelper.hasItemInLocalYZZQFile()
local ckey=ACTOR_SETTING_TYPE.eGetyzEquip
local key='yunzhouEquip_get'
return userActorArraySetting.get(ckey,key,false)
end
function bagHelper.flushLocalYZZQFile()
local ckey=ACTOR_SETTING_TYPE.eGetyzEquip
userActorArraySetting.flush(ckey)
end