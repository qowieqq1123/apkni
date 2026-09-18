






local _ronghe_select_save_key="ls_rh_only_xm"
local _ronghe_select_onlyXM=nil

local _jiulidian_save_1_key="jld_select_1"
local _jiulidian_save_2_key="jld_select_2"




local _jiulidian_save_1={}




local _jiulidian_save_2={}

function lingshouModel.getRongHeData(ls_guid,ls_list)
local result={}
local jjexp=0
local xuemai=0
local basic_exp=cfgHelper.get2(cfg_lingshoubasicconfig_get,1,"basic_xiuwei")
if ls_list~=nil and#ls_list>0 then
local lsData=lingshouModel:getLingShouData(ls_guid)
local jj_rate=cfgHelper.get2(cfg_lingshoubasicconfig_get,1,'jj_conversion_rate')
local xm_rate=cfgHelper.get2(cfg_lingshoubasicconfig_get,1,'xm_conversion_rate')
for i,v in ipairs(ls_list)do
if v.jj_lvl<=0 and v.jj_exp<=0 then
jjexp=jjexp+basic_exp
else
jjexp=jjexp+math.floor(lingshouModel.calculateAllJJexp(v.jj_lvl,v.jj_exp)*jj_rate/100)
end
if lsData.xuemai_type~=0 and v.xuemai_type==lsData.xuemai_type then
xuemai=xuemai+math.floor(v.xuemai_val*xm_rate/100)
end
end
end
result.jjexp=jjexp
result.xuemai=xuemai
return result
end

function lingshouModel:getOnlyXueMaiSelect()
return _ronghe_select_onlyXM
end

function lingshouModel:loadOnlyXueMaiSelect()
_ronghe_select_onlyXM=userActorSetting.get(_ronghe_select_save_key,false)
end

function lingshouModel:setOnlyXueMaiSelect(value)
_ronghe_select_onlyXM=value
userActorSetting.flushVal(_ronghe_select_save_key,_ronghe_select_onlyXM,false)
end

function lingshouModel:getJiuLiDianSelect1(ubdId)
local value=_jiulidian_save_1[tostring(ubdId)]
return value and int64.new(value)or nil
end

function lingshouModel:loadJiuLiDianSelect1()
_jiulidian_save_1=userActorSetting.get(_jiulidian_save_1_key,{})
end

function lingshouModel:setJiuLiDianSelect1(ubdId,lsGuid)
_jiulidian_save_1[tostring(ubdId)]=lsGuid and tostring(lsGuid)or nil
userActorSetting.set(_jiulidian_save_1_key,_jiulidian_save_1)
userActorSetting.flush()
end

function lingshouModel:getJiuLiDianSelect2(ubdId)
local value=_jiulidian_save_2[tostring(ubdId)]
return value and int64.new(value)or nil
end

function lingshouModel:loadJiuLiDianSelect2()
_jiulidian_save_2=userActorSetting.get(_jiulidian_save_2_key,{})
end

function lingshouModel:setJiuLiDianSelect2(ubdId,lsGuid)
_jiulidian_save_2[tostring(ubdId)]=lsGuid and tostring(lsGuid)or nil
userActorSetting.set(_jiulidian_save_2_key,_jiulidian_save_2)
userActorSetting.flush()
end