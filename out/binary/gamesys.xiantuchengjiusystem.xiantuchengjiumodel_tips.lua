local _tips={}
local _index=0
local _marks=nil
local _markKey="XianTuChengJiuMark"
function xiantuchengjiuModel:pushTaskTips(type,key1,key2,aimIdx)







table.insert(_tips,{type,key1,key2,aimIdx})
end

function xiantuchengjiuModel:popTaskTips()
return table.remove(_tips,1)





end

function xiantuchengjiuModel:haveTaskTips()


return#_tips>0
end

function xiantuchengjiuModel:cleanTaskTips()
_tips={}
_index=0
end

function xiantuchengjiuModel:loadMarkRepeated()
_marks=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianTuChengJiu,_markKey,{})
end

function xiantuchengjiuModel:saveMarkRepeated(type,key1,key2,aimIdx)
local config=xiantuchengjiuModel:getTaskConfig(type,key1,key2)
if config.mark then
local aimInfo=config.taskaims[aimIdx]
table.insert(_marks,{type=type,key1=key1,key2=key2,aimIdx=aimIdx,value=aimInfo[1]})

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianTuChengJiu,_markKey,_marks)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianTuChengJiu)
end
end

function xiantuchengjiuModel:isMarkRepeated(type,key1,key2,aimIdx)
local config=xiantuchengjiuModel:getTaskConfig(type,key1,key2)
if config.mark then
for i,v in ipairs(_marks)do
if v.type==type and v.key1==key1 and v.key2==key2 and v.aimIdx==aimIdx then
return true
end
end
end
return false
end