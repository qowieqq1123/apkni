







gameplotModel={}

eGameplotStoryType={
eBoard=1,
eComic=2,
eVideo=3,
eBoard2=4,
eAction=5,
eBoard3=6,
eComic2=7,
}

eCheckNoviciateFinishType={
eWorldBlockOpen=1,
eTaskFinish=2,
eZongMenLevel=3,
}

local _checkNoviciateFinish={
[eCheckNoviciateFinishType.eWorldBlockOpen]=function(param)
return not worldBlockModel:checkBlockState(param[1],param[2],eWorldBlockState.OPEN)
end,
[eCheckNoviciateFinishType.eTaskFinish]=function(param)
return not taskModel:checkTaskFinish(param)
end,
[eCheckNoviciateFinishType.eZongMenLevel]=function(param)
return zongmenModel:getLevel()<param
end,
}

local _save1={}

function gameplotModel:clearData()
_save1={}
end

function gameplotModel:isFinish()
return not gameplotModel:inNovicePlot()
end

function gameplotModel:inNovicePlot()
local data=cfgHelper.get2(cfg_noviciateconfig_get,"checkNoviciateFinish",'value')
local type=data[1]
local param=data[2]
return _checkNoviciateFinish[type](param)


end

function gameplotModel:replaceName(str,name,otherName)
str=string.gsub(str,'%[ZM%]',UISettingModel:getZMName())
str=string.gsub(str,'%[WJ%]',playerModel:getActorName()or'')
str=string.gsub(str,'%[Name%]',name or'')
str=string.gsub(str,'%[otherName%]',otherName or'')
return str
end

function gameplotModel:pushDiscipleChange(guid,oldData,newData)
_save1[tostring(guid)]={oldData,newData}
end

function gameplotModel:popDiscipleChange(id)
for i,v in pairs(_save1)do
if v[1].id==id then
return v
end
end
end

function gameplotModel:getAllDiscipleChange()
return _save1
end

function gameplotModel:clearDiscipleChange()
_save1={}
end