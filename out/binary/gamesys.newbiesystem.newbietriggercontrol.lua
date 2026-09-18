newbieTriggerControl={}

local _cfg={}
_cfg.benming={}


function newbieTriggerControl.initLuaFunc(luafuncName)
newbieTriggerControl.initBenming(luafuncName)
end



function newbieTriggerControl.initBenming(luafuncName)
if string.findStr(luafuncName,'benming+')then
local pattern='benming%+([%a_][%w_]*)%+(%d*)%+(%d*)'
local winname,itemid,num=string.match(luafuncName,pattern)
if winname==nil or itemid==nil or num==nil then return end
itemid=tonumber(itemid)
num=tonumber(num)
local benming=_cfg.benming
if benming[winname]==nil then benming[winname]={}end
benming[winname][itemid]={num,luafuncName}
end
end

function newbieTriggerControl.startBenmingNewbie(winname)
if _cfg.benming[winname]==nil then return false end
for itemid,val in pairs(_cfg.benming[winname])do
local luafuncName=val[2]
local num=val[1]
if itemsModel.getCount(itemid)>=num then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.luaFunc,luafuncName)
end
end
end

