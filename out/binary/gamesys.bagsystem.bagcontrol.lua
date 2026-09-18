




bagControl=gameState.addListener({})








local _register_list={}




function bagControl:onAppStart()
bagModel:onAppStart()
end

function bagControl:onEnterState()
bagModel:onEnterState()
bagNewHelper.reset()
end

function bagControl:onLeaveState()
bagModel:onLeaveState()
bagNewHelper.reset()
end

function bagControl:onPlayerCreate()

end


local getModel=function(itemid)
local bagType=itemsConfig.getBagType(itemid)
local model=_register_list[bagType]
if model==nil then
loggerUtil.logErrFMT('没有找到类型为{0}的背包类型',bagType)
end
return model
end

local invokeFuncByItemid=function(itemid,func_name,...)
local model=getModel(itemid)
if model==nil then return end
if model[func_name]then
local args={...}
return model[func_name](model,unpack(args))
else
loggerUtil.logErrFMT('道具id{0}没有找到{1}方法',itemid,func_name)
end
end

local invokeFuncByBagType=function(bagType,func_name,...)
local model=_register_list[bagType]
if model==nil then return end
if model[func_name]then
local args={...}
return model[func_name](model,unpack(args))
else
loggerUtil.logErrFMT('背包类型{0}没有找到{1}方法',bagType,func_name)
end
end


local invokeBagsModelFunc=function(func_name,...)
for _,bagType in pairs(BAG_TYPE)do
local args={...}
invokeFuncByBagType(bagType,func_name,unpack(args))
end
end



function bagControl.register(model)
local bagType=model.bagType

if _register_list[bagType]then return end
_register_list[bagType]=model
end


function bagControl.getBagModel(itemid)
return getModel(itemid)
end


function bagControl.invokeFuncByItemId(item_id,func_name,...)
local args={...}
return invokeFuncByItemid(item_id,func_name,unpack(args))
end


function bagControl.invokeFuncByBagType(bagType,func_name,...)
local args={...}
return invokeFuncByBagType(bagType,func_name,unpack(args))
end


function bagControl.invokeAllModelsFunc(func_name,...)
local args={...}
return invokeBagsModelFunc(func_name,unpack(args))
end




function bagControl.getBagItemsByFilter(bagType,filter,sort,useCache)
return bagControl.invokeFuncByBagType(bagType,'getBagItemsByFilter',filter,sort,useCache)
end


function bagControl.getShowBagItemsByFilter(showBagType,filter,sort,useCache)
local temp
if useCache then
table.clear(bagModel.group_cache_temp)
temp=bagModel.group_cache_temp
else
temp={}
end
for i,v in ipairs(BAG_TYPE_IN_SHOW_BAG_TYPE[showBagType])do
temp=table.concatTableX(temp,bagControl.getBagItems(v))
end
local flag=false
if filter then
for _,v in pairs(filter)do
flag=true
break
end
end
if not flag then
return temp
end

temp=itemsFilterHelper.filterItems(temp,filter,useCache)
if#temp>1 and sort~=false then
if sort then
sort(temp)
end
end
return temp
end


function bagControl.hasBagItems(bagType,filter)
return bagControl.invokeFuncByBagType(bagType,'hasBagItems',filter)
end


function bagControl.getBagItemsCnt(bagType,filter)
return bagControl.invokeFuncByBagType(bagType,'getBagItemsCnt',filter)
end


function bagControl.getBagItems(bagType)
return bagControl.invokeFuncByBagType(bagType,'getBagItems')
end


function bagControl.freshBagWindowOnAdd(item)
bagControl.freshBagWindowFunc('addItem',item)
end


function bagControl.freshBagWindowOnDelete(itemguid)
bagControl.freshBagWindowFunc('clearItem',itemguid)
end


function bagControl.freshBagWindowOnChange(item)
bagControl.freshBagWindowFunc('freshItem',item)
end


function bagControl.freshBagWindowOnSortBag(bagType)
bagControl.freshBagWindowFunc('onSortBag',bagType)
end


function bagControl.freshBagWindow()
bagControl.freshBagWindowFunc('freshInfo')
end

function bagControl.initBagWindow()
bagControl.freshBagWindowFunc('init')
end

function bagControl.freshBagWindowFunc(funcname,args)
UIManager:callWindowFunc('UIBagWin',funcname,args)
end



function bagControl.checkShowFullEquipBagTips(desc,callback)
local isFull=false

desc=desc or'无法继续挑战'

local maxNum=cfgHelper.get2(cfg_globalconfig_get,1,"equipBagFullNum")

local items=bagControl.getBagItems(BAG_TYPE.eEquipBag)
local len=#items

if len>=maxNum then
local content=FMT.fmt("祖师的装备数量已<color=#eb1010>超过{0}</color>\n{1}\n是否前往库房<color=#549327>熔炼装备</color>",maxNum,desc)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
allowclickBG=true,
showclosebtn=true,
okcallback=function()
jumpManager:jump({id=JUMP_TYPE.eBag,args={bagType=BAG_TYPE.eEquipBag}},callback)
end,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()


isFull=true
end

return isFull
end
