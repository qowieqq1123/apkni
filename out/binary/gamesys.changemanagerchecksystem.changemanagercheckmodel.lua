






local _MODULENAME="changeManagerCheckModel"


def_table(_MODULENAME)
changeManagerCheckModel.name=_MODULENAME
changeManagerCheckModel.data={}

function changeManagerCheckModel:onAppStart()

end


function changeManagerCheckModel:onEnterState(isReconnect)

end


function changeManagerCheckModel:onLeaveState(isReconnect)


end

function changeManagerCheckModel:onProtocolReq()

end






























































































































































function changeManagerCheckModel:getCheckOffset(netData,masklist,proskill_sort_offset)
local spelist=UIDiscipleModel:getDiscipleSpecialityConfigByData(netData)
local build_effects=discipleSelectController.calculateSpeciallist(spelist,masklist)
local offset=0
for i,v in ipairs(build_effects)do
if proskill_sort_offset[v.typo]~=nil then
local offset_=proskill_sort_offset[v.typo][v.id]
if offset_~=nil then
offset=offset+offset_
end
end
end
return offset
end

function changeManagerCheckModel:getBuildingReddot(un_build_id)
local bdData=zongmenModel:getBuildingData(un_build_id)
return self:getBuildingReddotEx(bdData)
end

function changeManagerCheckModel:getBuildingReddotEx(bdData)
local cfg=cfgHelper.get1(cfg_buildingchangemanagerreddotconfig_get,bdData.build_id)
if cfg then
local proskill=cfg.proskill
local masklist=discipleSelectController.getBuildSpecialityLookup(bdData.build_id)
masklist=masklist and masklist.spelist or{}
local proskill_sort_offset=cfgHelper.get2(cfg_disciplespecialityconfig_get,1,'proskill_sort_offset')
local levelLine=-1000
local offsetLine=-1000
if tostring(bdData.dizi_id)~='0'then
levelLine=UIDiscipleModel:getDiscipleJobLevel(bdData.dizi_id,proskill)
local netData=UIDiscipleModel:getDiscipleData(bdData.dizi_id)
offsetLine=changeManagerCheckModel:getCheckOffset(netData,masklist,proskill_sort_offset)
end
local disciples=UIDiscipleModel:getAllDiscipleData()
for guidStr,discipleData in pairs(disciples)do
local netData=discipleData.netData.net
local discipleguid=netData.discipleguid
local level=UIDiscipleModel:getDiscipleJobLevelEx(netData,proskill)
local offset=changeManagerCheckModel:getCheckOffset(netData,masklist,proskill_sort_offset)
if level>levelLine and(level+offset)>(levelLine+offsetLine)and UIDiscipleModel:checkDiscipleState2(discipleguid,DISCIPLE_STATE_TYPE.eFree)and not zongmenModel:isHomeless(discipleguid)then
local check1=zongmenModel:findBuildingByManager(mapIdType.zhufeng,discipleguid)
local check2=zongmenModel:findBuildingByManager(mapIdType.lingshoudao,discipleguid)
if check1==nil and check2==nil then
return true
end
end
end
end
return false





end





















































































































































































































































































