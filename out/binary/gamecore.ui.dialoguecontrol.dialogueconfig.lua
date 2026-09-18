





dialogueConfig={}




dialogueGroupType=
{
eDefault=0,
}


dialoguePriorityType=
{

eDefault=1000,
}







local _dialogNameConf=
{
['UIEmergenciesSettlement']={

},
}

function dialogueConfig:isContains(name)
if name then
return _dialogNameConf[name]
end
return false
end

function dialogueConfig.getConfig(name)
if name then
return _dialogNameConf[name]
end
end

function dialogueConfig.getGroup(name)
if name then
local conf=_dialogNameConf[name]
if conf then
return conf.group or dialogueGroupType.eDefault
end
end
end

function dialogueConfig.checkCnd(name)
if name then
local conf=_dialogNameConf[name]
if conf then
return conf.cnd and conf.cnd()or conf.cnd==nil
end
end
end