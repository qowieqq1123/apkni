
eXMMouLueEffectType={
eZZSHAddCollectKeepRate=1,
eZZSHAddCollectRate=3,
eZZSHAddMonsterTeamNum=4,
eZZSHAddMonsterJiJieStage=5,
eZZSHRefreshResource=7,
eZZSHAddXuKongLingBuyNum=8,
eZZSHMinusPvPJingLiCost=10,
eZZSHAddPvPTeamNum=11,
eZZSHAddPvPProtectNum=12,
eZZSHAddPvPSupportNum=13,
}
local moulueData

function xianmengModel:clearData_moulue()
moulueData=nil
end

function xianmengModel:initData_moulue()
moulueData={}
moulueData.mou_table={}
moulueData.wu_table={}

end


function xianmengModel:setmoulueData(mou_len,mou_table,wu_len,wu_table)
if mou_len>0 then
moulueData.mou_table=mou_table
else
moulueData.mou_table={}
end
if wu_len>0 then
moulueData.wu_table=wu_table
else
moulueData.wu_table={}
end

end


function xianmengModel:UpdataSkillData(stduy_type,id,lv)

if stduy_type==1 then

if next(moulueData.mou_table)then
for k,v in ipairs(moulueData.mou_table)do
if v.param_1==id then
v.param_2=lv
return
end
end

moulueData.mou_table[#moulueData.mou_table+1]={['param_1']=id,['param_2']=lv}
else

moulueData.mou_table[#moulueData.mou_table+1]={['param_1']=id,['param_2']=lv}
end
elseif stduy_type==2 then

if next(moulueData.wu_table)then
for k,v in ipairs(moulueData.wu_table)do
if v.param_1==id then
v.param_2=lv
return
end
end

moulueData.wu_table[#moulueData.wu_table+1]={['param_1']=id,['param_2']=lv}
else

moulueData.wu_table[#moulueData.wu_table+1]={['param_1']=id,['param_2']=lv}

end
end

end



function xianmengModel:GetSkillLv(type,id)
if type==1 then
for k,v in ipairs(moulueData.mou_table)do
if id==v.param_1 then
return v.param_2
end
end
elseif type==2 then
for k,v in ipairs(moulueData.wu_table)do
if id==v.param_1 then
return v.param_2
end
end
end
return 0
end


function xianmengModel:GetSkilMaxLv(type,id)
local cfg=nil
if type==1 then
cfg=cfgHelper.get1(cfg_guildstrategyconfig_get,id)
elseif type==2 then
cfg=cfgHelper.get1(cfg_guildmilitaryconfig_get,id)
end
return cfg and#cfg or nil

end


function xianmengModel:GetSkill_Effect(effectid)

if effectid==eXMMouLueEffectType.eZZSHAddCollectKeepRate then
local study_effect=xianmengModel:GetcfgStudy_effect(1,4)
if study_effect then
return study_effect[1]and study_effect[1][2]or 0
end
return 0
elseif effectid==2 then







elseif effectid==eXMMouLueEffectType.eZZSHAddCollectRate then
local study_effect=xianmengModel:GetcfgStudy_effect(1,6)
if study_effect then
return study_effect[1]and study_effect[1][2]or 0
end
return 0
elseif effectid==eXMMouLueEffectType.eZZSHAddMonsterTeamNum then
local study_effect=xianmengModel:GetcfgStudy_effect(1,5)
if study_effect then
return study_effect[1]and study_effect[1][2]or 0
end
return 0
elseif effectid==eXMMouLueEffectType.eZZSHAddMonsterJiJieStage then
local study_effect=xianmengModel:GetcfgStudy_effect(1,3)
if study_effect then
return study_effect[1]and study_effect[1][2]or 0
end
return 0
elseif effectid==6 then







elseif effectid==eXMMouLueEffectType.eZZSHRefreshResource then

local skilllv=xianmengModel:GetSkillLv(1,1)
return skilllv
elseif effectid==eXMMouLueEffectType.eZZSHAddXuKongLingBuyNum then
local study_effect=xianmengModel:GetcfgStudy_effect(1,8)
if study_effect then
return study_effect[1]and study_effect[1][2]or 0
end
return 0
elseif effectid==eXMMouLueEffectType.eZZSHMinusPvPJingLiCost then
local study_effect=xianmengModel:GetcfgStudy_effect(2,3)
if study_effect then
return study_effect[1]and study_effect[1][2]or 0
end
return 0
elseif effectid==eXMMouLueEffectType.eZZSHAddPvPTeamNum then
local study_effect=xianmengModel:GetcfgStudy_effect(2,2)
if study_effect then
return study_effect[1]and study_effect[1][2]or 0
end
return 0
elseif effectid==eXMMouLueEffectType.eZZSHAddPvPProtectNum then

local study_effect=xianmengModel:GetcfgStudy_effect(2,1)
local resourcetb={}
if study_effect then
for k,v in ipairs(study_effect)do
resourcetb[#resourcetb+1]={v[1],v[2]}
end
end
return resourcetb
elseif effectid==eXMMouLueEffectType.eZZSHAddPvPSupportNum then

local study_effect=xianmengModel:GetcfgStudy_effect(2,8)
if study_effect then
return study_effect[1]and study_effect[1][2]or 0
end
return 0
end
end


function xianmengModel:GetcfgStudy_effect(type,skillid)
local skilllv=xianmengModel:GetSkillLv(type,skillid)
if skilllv>0 then
local cfg
if type==1 then
cfg=cfgHelper.get2(cfg_guildstrategyconfig_get,skillid,skilllv)
else
cfg=cfgHelper.get2(cfg_guildmilitaryconfig_get,skillid,skilllv)
end

local study_effect=cfg.study_effect
return study_effect
end
return nil
end
