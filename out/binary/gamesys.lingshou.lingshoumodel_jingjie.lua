








function lingshouModel:checkJJFull(guid)
local lsData=lingshouModel:getLingShouData(guid)
return lingshouModel.checkJJFullEx(lsData.jj_lvl,lsData.generation)
end

function lingshouModel.checkJJFullEx(jjlv,generation)

local jjcfg=cfgHelper.get1(cfg_lingshoujingjieconfig_get,jjlv)
if jjcfg.xiuwei==0 then
return true
end


local nextLv=jjlv+1
local nextLvCfg=cfgHelper.get2(cfg_lingshoujingjieconfig_get,nextLv)
if generation<nextLvCfg.generation then
return true
end

return false
end

function lingshouModel:checkJJNeedBroke(guid)
local lsData=lingshouModel:getLingShouData(guid)
local jjlv=lsData.jj_lvl
local jjexp=lsData.jj_exp
local jjcfg=cfgHelper.get1(cfg_lingshoujingjieconfig_get,jjlv)
local xiuwei=jjcfg.xiuwei
if xiuwei==0 then

return false,nil
end
if jjexp<xiuwei then
return false,nil
end
local tupo_cost=jjcfg.tupo_cost
if tupo_cost==nil then
return false,nil
end
return true,tupo_cost
end

function lingshouModel.checkJJUpNeedBroke(jjlv)
local jjcfg=cfgHelper.get1(cfg_lingshoujingjieconfig_get,jjlv)
if jjcfg.tupo_cost~=nil then
return true
end
return false
end

function lingshouModel:getJJName(guid,typo)
local lsData=lingshouModel:getLingShouData(guid)
return lingshouModel.getJJNameEx(lsData.jj_lvl,typo)
end

function lingshouModel.getJJFloor(jjlv)
local cfg=cfgHelper.get(cfg_lingshoujingjieconfig_get,jjlv)
return cfg.floor
end

function lingshouModel.getJJFloorNameEx(jjlv)
local floor=lingshouModel.getJJFloor(jjlv)
return lingshouModel:getJJFloorName(floor)
end

function lingshouModel:getJJFloorName(floor)
return cfg_lingshoubasicconfig_get(1).jingjiename[floor]
end

function lingshouModel.getJJNameEx(jjlv,typo)
return lingshouModel.getJJNameCommon(jjlv,typo)
end

function lingshouModel.getJJNameCommon(jjlv,typo)
typo=typo or 1
local p,pN=UIDiscipleModel.getJJSuffix(jjlv)
local fname=lingshouModel.getJJFloorNameEx(jjlv)
local jj_str=''
if typo==1 then
if p~=nil then
jj_str=FMT.fmt('{0}{1}（{2}）',fname,pN,jjlv)
else
jj_str=FMT.fmt('{0}（{1}）',fname,jjlv)
end
elseif typo==2 then
if p~=nil then
jj_str=FMT.fmt('{0}{1}阶',fname,p)
else
jj_str=fname
end
elseif typo==3 then
if p~=nil then
jj_str=FMT.fmt('{0}{1}',fname,pN)
else
jj_str=FMT.fmt('{0}',fname)
end
elseif typo==4 then
if p~=nil then
jj_str=FMT.fmt('{0}{1}({2}阶)',fname,pN,p)
else
jj_str=FMT.fmt('{0}',fname)
end
end
return jj_str
end

function lingshouModel.getJJNameX(jjlv)
local p,pN=UIDiscipleModel.getJJSuffix(jjlv)
return lingshouModel.getJJFloorNameEx(jjlv),p,pN
end
function lingshouModel.getJJAttrList(jjlv,race)
local list1=cfgHelper.get3(cfg_lingshoujingjieconfig_get,jjlv,'attrs',race)
return list1
end

function lingshouModel.getJJUpExp(jjlv)
local jjcfg=cfgHelper.get1(cfg_lingshoujingjieconfig_get,jjlv)
if jjcfg then
return jjcfg.xiuwei
end
return nil
end

function lingshouModel.getJJUpMaxExp(jjlv,jjexp)
local exp=0
local jjcfg=cfgHelper.get1(cfg_lingshoujingjieconfig_get,jjlv)
if jjcfg.xiuwei~=0 then
if jjcfg.tupo_cost==nil then
while jjcfg~=nil and jjcfg.xiuwei~=0 do
exp=exp+jjcfg.xiuwei
jjlv=jjlv+1
jjcfg=cfgHelper.get1(cfg_lingshoujingjieconfig_get,jjlv)
if jjcfg.tupo_cost~=nil then
exp=exp+jjcfg.xiuwei
break
end
end
else
exp=exp+jjcfg.xiuwei
end
end
if exp>0 then
exp=exp-jjexp
end
return exp
end

function lingshouModel:jjChangeAddExp(jjlv,jjexp,addexp)
local changelv=jjlv
local changeexp=jjexp+addexp
local upexp=lingshouModel.getJJUpExp(changelv)
local needbroke=lingshouModel.checkJJUpNeedBroke(changelv)
while upexp~=nil and upexp~=0 and changeexp>=upexp and not needbroke do
changeexp=changeexp-upexp
changelv=changelv+1
upexp=lingshouModel.getJJUpExp(changelv)
needbroke=lingshouModel.checkJJUpNeedBroke(changelv)
end
return changelv,changeexp
end

function lingshouModel:checkJJBrokeCondition(jjlv,generation,isWarning)
local isfull=lingshouModel.checkJJFullEx(jjlv,generation)
if isfull then
if isWarning then
UIManager.error('当前灵兽已满级')
end
return false
end

local nextLv=jjlv+1
local nextLvCfg=cfgHelper.get2(cfg_lingshoujingjieconfig_get,nextLv)

local sectlv=nextLvCfg and nextLvCfg.guild_lvl or nil

if sectlv~=nil then
local lv=zongmenModel:getLevel()

if lv<sectlv then
if isWarning then
UIManager.error(FMT.fmt('宗门等级需达到{0}级',sectlv))
end
return false
end
end

return true
end

function lingshouModel:checkJJEnoughBroke(jjlv,isWarning)
local jjcfg=cfgHelper.get1(cfg_lingshoujingjieconfig_get,jjlv)
if jjcfg.tupo_cost==nil then

logErr(FMT.fmt('境界{0}不能突破',jjlv))

return false
end
for i,v in ipairs(jjcfg.tupo_cost)do
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

function lingshouModel.calculateAllJJexp(jjlv,jjexp)
local subexp=jjexp or 0
if jjlv>0 then
for i=0,jjlv-1 do
subexp=subexp+cfgHelper.get2(cfg_lingshoujingjieconfig_get,i,'xiuwei')
end
end
return subexp
end


function lingshouModel:calculationJJMedicineGrow(lsGuid,baseGrow,itemid)
local lsData=lingshouModel:getLingShouData(lsGuid)
return lingshouModel:calculationJJMedicineGrowByData(lsData,baseGrow,itemid)
end

function lingshouModel:calculationJJMedicineGrowByData(lsData,baseGrow,itemid)









local value=lingshouModel.getLingShouPropertyValEx(lsData.guid,lingshouPropertyType.XIUWEI_GET_RATE,1,baseGrow)
value=math.floor(value)
return value
end


function lingshouModel:checkJJBrokeByHand(jjlv)
local floor=lingshouModel.getJJFloor(jjlv)
return floor>=1
end

function lingshouModel:getUseGoodStr(cond)
local str=''
local line=0
local jingjie=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLingshouLv,cond)
if jingjie then
local jj_name=lingshouModel.getJJFloorNameEx(jingjie[1])
str=str..FMT.fmt('{0}期灵兽才可以服用',jj_name)
line=line+1
end
local attr6=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLingShouAttr2,cond)
if attr6~=nil then

if line>0 then
str=str..'\n'
end
local c=#attr6
for i,v in ipairs(attr6)do
str=str..FMT.fmt('{0}（{1}~{2}）',UIDiscipleModel:getDiscipleBaseAttrName(v[1]),v[2][1],v[2][2])
if i<c then
str=str..'、'
else
str=str..'才可以服用'
end
end
end

return str
end

function lingshouModel:getLsZiZhiAddXiuLianExpRate(lsData)
local zizhi=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)
return lingshouModel:getLsZiZhiAddXiuLianExpRateEx(zizhi)
end

function lingshouModel:getLsZiZhiAddXiuLianExpRateEx(zizhi)
if zizhi<=0 then
return 0
end

local zizhiCfg=cfgHelper.get(cfg_lingshouzizhiconfig_get,zizhi)
if not zizhiCfg then
return 0
end

local addRatePercent=zizhiCfg.jingjie_xiulian_item
local addRate=addRatePercent/100
return addRate
end



function lingshouModel:setLingShouJJDirty()
self.lingShouJJListDirty=true
end

function lingshouModel:refreshLingShouJJData()
local allLsDatas=lingshouModel:getLingShouDatas()
if allLsDatas==nil then return end
if self.lingShouJJList==nil or self.lingShouJJListDirty~=false then
self.lingShouJJListDirty=false
local lingShouJJList={}
for k,lsData in pairs(allLsDatas)do
lingShouJJList[#lingShouJJList+1]={lsData.guid_str,lsData.jj_lvl}
end
table.sort(lingShouJJList,function(a,b)
return a[2]<b[2]
end)
self.lingShouJJList=lingShouJJList
end
end


function lingshouModel:getLingShouJJCount(jjlv)
lingshouModel:refreshLingShouJJData()
local startIndex=table.getBiggerValueStartIndex(self.lingShouJJList,jjlv,2)
if startIndex==nil then return 0 end
return#self.lingShouJJList-startIndex+1
end
