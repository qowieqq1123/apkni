reportDisplayConfig={}

eReportDisplayType={
eFaBao=1,
eGongFa=2,
}

local _handles={
[eReportDisplayType.eFaBao]={
name="神通展示",
baseWin="UIReportDisplayFrameWin",
baseParams=function(eType,reportId,stageId,params)
return{
showType=eType,
reportId=reportId,
stageId=stageId,
}
end,
extraWin="UIReportDisplayFaBaoWin",
extraParams=function(eType,reportId,stageId,params)
return{
skillId=params.skillId,
}
end,
},
[eReportDisplayType.eGongFa]={
name="功法展示",
baseWin="UIReportDisplayFrameWin",
baseParams=function(eType,reportId,stageId,params)
return{
showType=eType,
reportId=reportId,
stageId=stageId,
}
end,
extraWin="UIReportDisplayGongFaWin",
extraParams=function(eType,reportId,stageId,params)
return{
gongfaId=params.gongfa,
}
end,
},
}

function reportDisplayConfig:getHandle(eType)
return _handles[eType]
end

function reportDisplayConfig:getHandleName(eType)
local handle=self:getHandle(eType)
return handle.name
end