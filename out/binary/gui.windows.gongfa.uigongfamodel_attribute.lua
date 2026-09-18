







function UIGongFaModel:getDiscipleAllStudyGF(dis_guid)
local list={}
local temp=UIDiscipleModel:getDiscipleAllGFData(dis_guid)
if#temp>0 then
for i,v in ipairs(temp)do
local gfID=v.param_1
local studylv=UIGongFaModel:getStudyLevel(gfID)
if studylv>0 then
table.insert(list,{gfID,studylv})
end
end
end
return list
end

function UIGongFaModel:calculationGFAttrLookup(dis_guid)
local attrlookup={}

UIGongFaModel:calculationGFStudyAttrLookup(dis_guid,attrlookup)















return attrlookup
end

function UIGongFaModel:calculationGFStudyAttrLookup(dis_guid,lookup)
local list=UIGongFaModel:getDiscipleAllStudyGF(dis_guid)
if#list>0 then
for i,v in ipairs(list)do
local gfID=v[1]
local studylv=v[2]
local attrs=UIGongFaModel:getGFStudyAttr(gfID,studylv)
for i,v in ipairs(attrs)do
lookup[v[1]]=lookup[v[1]]or 0
lookup[v[1]]=lookup[v[1]]+v[2]
end
end
end
end


function UIGongFaModel:getGFStudySkillList(gfID,studylv)
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local study=cfg.study
local attrs=study[studylv][2]
return attrs
end

function UIGongFaModel:getGFStudyAttr(gfID,studylv)
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local study=cfg.study
local attrs=study[studylv][3]
return attrs
end

function UIGongFaModel:getGFStudySkillLvPlus(gfID,studylv)
local cfg=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID)
local study=cfg.study
local list=study[studylv][4]
return list
end