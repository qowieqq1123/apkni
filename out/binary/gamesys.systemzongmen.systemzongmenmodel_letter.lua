






local _letters={}
local _local_save_key="systemZongMenRelationLetter"

function systemZongMenModel:loadRelationLetter()
_letters=userActorSetting.get(_local_save_key,{})
local invalids={}
for i,v in ipairs(_letters)do
if not timeHelper.isTodayShort(v.time)then
table.insert(invalids,i)
end
end
local correct=#invalids
if correct>0 then
for i=correct,1,-1 do
table.remove(_letters,invalids[i])
end
userActorSetting.set(_local_save_key,_letters)
userActorSetting.flush()
end
end

function systemZongMenModel:addALetter(serial,type)
local data={
serial=mathHelper.int64_to_string(serial),
time=timeHelper.getServerShortTime(),
type=type,
}
table.insert(_letters,data)
userActorSetting.set(_local_save_key,_letters)
userActorSetting.flush()
end

function systemZongMenModel:clearAllLetter()
_letters={}
userActorSetting.flushVal(_local_save_key,_letters)
end

function systemZongMenModel:getAllLetter()
return _letters
end

function systemZongMenModel:exsitALetter()
return#_letters>0
end