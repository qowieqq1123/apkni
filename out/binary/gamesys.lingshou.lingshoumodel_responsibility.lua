

local _removeLingShouResponsbilityStateFunc={
[eLingShouStateType.petEquip]=function(lsGuid)

local dzGuid=lingshouModel:getDiziguidByLsGuid(lsGuid)
local dzName=UIDiscipleModel:getDiscipleName(dzGuid)
local content=FMT.fmt("此灵兽已被{0}携带，\n是否前往放下",dzName)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
allowclickBG=true,
showclosebtn=true,
okcallback=function(...)

jumpManager:jump({id=JUMP_TYPE.eDiscipleMain,args={tabType=FULL_TAB_TYPE.eDiscipleEquip,discipleguid=dzGuid,subArgs={equipPage=2}}})
end,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end,
[eLingShouStateType.petBorn]=function(lsGuid)
local content="此灵兽正在繁育中"
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
allowclickBG=true,
showclosebtn=true,




}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end,
[eLingShouStateType.petBuild]=function(lsGuid,callback)
feedingSystem:checkAndRemoveLingShou_notSL(lsGuid,callback)
end,
[eLingShouStateType.petBuildMix]=function(lsGuid,callback)
feedingSystem:checkAndRemoveLingShou_notSL(lsGuid,callback)
end,
}


function lingshouModel:removeLingShouResponsbility(lsGuid,callback)
local state=lingshouModel:getHighestStateType(lsGuid)
if state==eLingShouStateType.petFree then
if callback then
callback()
end
return true
end

local removeStateFunc=_removeLingShouResponsbilityStateFunc[state]
if removeStateFunc==nil then
logErr("缺少移除灵兽职责处理",state)
return false
end
removeStateFunc(lsGuid,callback)
return false
end