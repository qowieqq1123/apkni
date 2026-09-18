







function lingshouModel:getQianLiReturn(guid)
local list=nil
local lsData=lingshouModel:getLingShouData(guid)
if lsData.qianliItemList~=nil and#lsData.qianliItemList>0 then
list={}
for i,v in ipairs(lsData.qianliItemList)do
table.insert(list,{v.param_1,v.param_2})
end
end
return list
end

function lingshouModel:getQianLiReturnEx(guidlist)
local list={}
local lookup={}
for i,guid in ipairs(guidlist)do
local lsData=lingshouModel:getLingShouData(guid)
if lsData.qianliItemList~=nil and#lsData.qianliItemList>0 then
for i2,v in ipairs(lsData.qianliItemList)do
if lookup[v.param_1]==nil then
lookup[v.param_1]=v.param_2
else
lookup[v.param_1]=lookup[v.param_1]+v.param_2
end
end
end
end
for k,v in pairs(lookup)do
table.insert(list,{k,v})
end
return list
end

function lingshouModel.checkQLEnoughUp(qianli,isWarning)
local qlcfg=cfgHelper.get(cfg_lingshouqianliconfig_get,qianli+1)
for i,v in ipairs(qlcfg.cost)do
local itemid=v[1]
local itemnum=v[2]
local hasnum
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if hasnum<itemnum then
if isWarning then
UIManager.error('材料不足')
gainControl:showGainWin(itemid)
end
return false
end
end
return true
end

function lingshouModel.checkQianLiFull(qianli)
local cfg=cfg_lingshouqianliconfig()
return cfg[qianli]~=nil and cfg[qianli+1]==nil
end

function lingshouModel.getQianLiFloor(qianli)
return math.ceil(qianli/10)
end

function lingshouModel:getQianLiDesc(guid)
local lsData=lingshouModel:getLingShouData(guid)
local qianli=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)
return lingshouModel.getQianLiDescEx(qianli)
end

function lingshouModel.getQianLiDescEx(qianli)
return qianli
end

function lingshouModel.getQianLiDescEx2(qianli)
local floor=lingshouModel.getQianLiFloor(qianli)
local fname=cfgHelper.get2(cfg_lingshouqianlifloorconfig_get,floor,'name')
local str=FMT.fmt('{0}（{1}）',qianli,fname)
return str
end

function lingshouModel.getQianLiEffectDesc(v)
local temp=FMT.fmt('{0}+{1}%',helper.getAttributeName(v[2]),v[3])
local str
if v[1]==1 then
str='灵兽'
else
str='主人'
end
str=FMT.fmt('{0}{1}',str,temp)
return str
end

function lingshouModel.getQianLiToJJAttrRate(qianli)
return cfgHelper.get2(cfg_lingshouqianliconfig_get,qianli,'percent')
end



function lingshouModel.getQianLiDanUseMaxNum(lsData,ql_itemid)
if lsData and ql_itemid and lsData.generation then
local config=cfgHelper.get1(cfg_lingshoubasicconfig_get,1)
local color_ql_max=config.color_ql_max
local generation_ql_max=config.generation_ql_max
local fyCfg=cfgHelper.get1(cfg_lingshouconfig_get,lsData.id)
local num=0
if generation_ql_max[lsData.generation]and generation_ql_max[lsData.generation][ql_itemid]then
num=generation_ql_max[lsData.generation][ql_itemid]
end
if color_ql_max[fyCfg.color]and color_ql_max[fyCfg.color][ql_itemid]then
num=num+color_ql_max[fyCfg.color][ql_itemid]
end
return num
else
return 0
end
end