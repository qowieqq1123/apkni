







function UIDiscipleModel:getDiscipleLTLevel(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.liantilv
end


function UIDiscipleModel:setDiscipelLTDirty()
self.discipleLTListDirty=true
end

function UIDiscipleModel:initDiscipleLTCountData()
local alldisciple=UIDiscipleModel:getAllDiscipleDataX()
if alldisciple==nil then return end
if self.discipleLTList==nil or self.discipleLTListDirty~=false then
self.discipleLTListDirty=false
local discipleLTList={}
for k,v in pairs(alldisciple)do
local netData=v.netData.net
discipleLTList[#discipleLTList+1]={netData.discipleguidStr,netData.liantilv}
end
table.sort(discipleLTList,function(a,b)
return a[2]<b[2]
end)
self.discipleLTList=discipleLTList
end
end

function UIDiscipleModel:getDiscipleBiggerLTCountIndex(ltlv)
UIDiscipleModel:initDiscipleLTCountData()
return table.getBiggerValueStartIndex(self.discipleLTList,ltlv,2)
end

function UIDiscipleModel:getDiscipleLTCount(ltlv)
local startIndex=UIDiscipleModel:getDiscipleBiggerLTCountIndex(ltlv)
if startIndex==nil then return 0 end
return#self.discipleLTList-startIndex+1
end


function UIDiscipleModel:getDiscipleLTCountList(ltlv)
local c=0
local list={}
local alldisciple=UIDiscipleModel:getAllDiscipleData()
if alldisciple then
for k,v in pairs(alldisciple)do
local netData=v.netData.net
if netData.liantilv>=ltlv then
c=c+1
table.insert(list,netData)
end
end
end
return c,list




end

function UIDiscipleModel:canDiscipleLTAutoUp(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:canDiscipleLTAutoUpX(netData)
end

function UIDiscipleModel:canDiscipleLTAutoUpX(netData)
local liantilv=netData.liantilv
local cfg=cfgHelper.get1(cfg_disciplelianticonfig_get,liantilv)
local curltexp=netData.liantiexp
local nxltexp=cfg.exp

if nxltexp~=0 then
if curltexp>=nxltexp then
local consume=cfg.consume
if consume==nil then
return true
end
end
end
return false
end

function UIDiscipleModel.checkLTFull(ltlv)
local cfg=cfgHelper.get1(cfg_disciplelianticonfig_get,ltlv)
return cfg.exp==0
end
function UIDiscipleModel.checkLTFullEx(cfg)
return cfg.exp==0
end

function UIDiscipleModel:checkDiscipleLTNeedBroke(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local liantilv=netData.liantilv
local cfg=cfgHelper.get1(cfg_disciplelianticonfig_get,liantilv)
local curltexp=netData.liantiexp
local nxltexp=cfg.exp

if nxltexp~=0 then
if curltexp>=nxltexp then
local consume=cfg.consume
if consume~=nil then
return true
end
end
end
return false
end

function UIDiscipleModel:canDiscipleLTBroke(guid)
if UIDiscipleModel:checkDiscipleLTNeedBroke(guid)then
local netData=UIDiscipleModel:getDiscipleData(guid)
local liantilv=netData.liantilv
local cfg=cfgHelper.get1(cfg_disciplelianticonfig_get,liantilv)
local jingjie=cfg.jingjie
local curJJ=UIDiscipleModel:getDiscipleJJLevel(guid)
if curJJ<jingjie then
return false,1
end

local costlist=UIDiscipleModel:getDiscipleLTBrokeCost(guid,liantilv)
local fix=true
local needItemid
local needCount
if#costlist>0 then
for i,v in ipairs(costlist)do
local itemID=v[1]
local needNum=v[2]
local hasNum=bagModel.getItemCountById(itemID)
if hasNum<needNum then
fix=false
needItemid=itemID
needCount=needNum
break
end
end
end
return fix,2,needItemid,needCount
end
return false,0
end

function UIDiscipleModel:getDiscipleLTBrokeMissingItem(guid,checkHC)
local netData=UIDiscipleModel:getDiscipleData(guid)
local liantilv=netData.liantilv
local costlist=UIDiscipleModel:getDiscipleLTBrokeCost(guid,liantilv)
local list={}
for i,v in ipairs(costlist)do
local itemID=v[1]
local needNum=v[2]
local hasNum=bagModel.getItemCountById(itemID)
if hasNum<needNum then
if checkHC then
local hcId=heChengLianHuaModel:getItemIdToHCConfigId(itemID)
local hcCfg=cfgHelper.get1(cfg_lianqigeconfig_get,hcId)
local max=heChengLianHuaModel:getMaxLianHuaCount_quick(hcCfg)
if max>=1 then
table.insert(list,v)
end
else
table.insert(list,v)
end
end
end
return list
end

function UIDiscipleModel:getDiscipleLTBrokeCost(guid,liantilv)
local consume=cfgHelper.get2(cfg_disciplelianticonfig_get,liantilv,'consume')
local costlist={}
local speciallist=UIDiscipleModel:getDiscipleSpeciality(guid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)or{}
local snum=#speciallist
local gnum=0
if snum>0 then
gnum=consume[2][snum]
end
for i,v in ipairs(speciallist)do
local goodid=consume[1][v.param_1]or 0
if goodid>0 then
table_insert(costlist,{goodid,gnum})
end
end
return costlist
end

function UIDiscipleModel:checkLTBrokeCondition(guid,warning,warnType)
local can,flag,itemid,needCount=UIDiscipleModel:canDiscipleLTBroke(guid)
if not can then
if warning==true then
if flag==1 then

local netData=UIDiscipleModel:getDiscipleData(guid)
local liantilv=netData.liantilv
local jingjie=cfgHelper.get2(cfg_disciplelianticonfig_get,liantilv,'jingjie')
local jjname=UIDiscipleModel:getJJName(jingjie)
local cond_str=FMT.fmt('境界需达到{0}期',jjname)
if warnType==1 then
local pos=Vector2.New(-208,23)
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,pos=pos})
else
UIManager.error(cond_str)
end
elseif flag==2 then
local nlist=UIDiscipleModel:getDiscipleLTBrokeMissingItem(guid,true)
if#nlist>=2 then
UIManager:showWindow('UIPiLiangHeChengJCWin',{list=nlist})
else
UIManager.error('突破材料不足')
gainControl:showGainWin(itemid,needCount,{needCount=needCount})
end
end
end
return false
end
return true
end

function UIDiscipleModel:checkLTOpen(guid,isWarning)
local liantiopen=cfgHelper.getglobal1('liantiopen')
for i,v in ipairs(liantiopen)do
if i==1 then
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local floor=UIDiscipleModel:getJJFloor(jjlv)
if floor<v then
local floorname=UIDiscipleModel:getJJFloorName(v)
if isWarning==true then
UIManager.error(FMT.fmt('{0}期开启炼体',floorname))
end
return false,FMT.fmt('{0}期开启',floorname)
end
end
end
return true
end

function UIDiscipleModel:checkLTReddot(guid)
if not UIDiscipleModel:checkDiscipleIsTop5(guid)then
return false
end

return UIDiscipleModel:checkLTBrokeCondition(guid,false)
end

function UIDiscipleModel:getLTNameX(ltlv)
local p,pN=UIDiscipleModel.getJJSuffix(ltlv)
return UIDiscipleModel:getLTName(ltlv),p,pN
end

function UIDiscipleModel:getLTNameXX(ltlv)
return UIDiscipleModel.getLTNameCommon(ltlv,1)
end

function UIDiscipleModel:getLTNameEx(ltlv)
return UIDiscipleModel.getLTNameCommon(ltlv,2)
end

function UIDiscipleModel:getLTName3(ltlv)
return UIDiscipleModel.getLTNameCommon(ltlv,3)
end

function UIDiscipleModel:getLTName4(ltlv)
return UIDiscipleModel.getLTNameCommon(ltlv,4)
end

function UIDiscipleModel.getLTNameCommon(ltlv,typo)
typo=typo or 1
local n,p,pN=UIDiscipleModel:getLTNameX(ltlv)
local jj_str=''
if typo==1 then
if p~=nil then
jj_str=FMT.fmt('{0}{1}（{2}）',n,pN,ltlv)
else
jj_str=FMT.fmt('{0}（{1}）',n,ltlv)
end
elseif typo==2 then
if p~=nil then
jj_str=FMT.fmt('{0}{1}层',n,p)
else
jj_str=n
end
elseif typo==3 then
if p~=nil then
jj_str=FMT.fmt('{0}{1}',n,pN)
else
jj_str=FMT.fmt('{0}',n)
end
elseif typo==4 then
if p~=nil then
jj_str=FMT.fmt('{0}{1}({2}层)',n,pN,p)
else
jj_str=FMT.fmt('{0}',n)
end
end
return jj_str
end

function UIDiscipleModel:getLTGrade(ltlv)
local grade=cfgHelper.get2(cfg_disciplelianticonfig_get,ltlv,'grade')
return grade
end

function UIDiscipleModel:getLTName(ltlv)
local grade=cfgHelper.get2(cfg_disciplelianticonfig_get,ltlv,'grade')
return cfgHelper.getglobal2('liantiname',grade)
end

function UIDiscipleModel:useLTGoodBack(guid,itemid,showType,num)
local itemcfg=itemsHelper:get_item_config(itemid)
local funcparam=itemcfg.funcparam
showType=showType or 1
num=num or 1
local isBroke=guid~=nil and UIDiscipleModel:checkDiscipleLTNeedBroke(guid)
if funcparam.exp and not isBroke then
local exp=funcparam.exp
if guid~=nil then
exp=UIDiscipleModel:calculationLTMedicineGrow(guid,exp,itemid)
end
exp=exp*num
local str=FMT.fmt('+{0}经验',exp)
commonTipsHelper.addThrowOutAndSliderTips(showType,str)
end
if funcparam.attr6 then
for i,v in ipairs(funcparam.attr6)do
local exp=v[2]*num
local str=FMT.fmt('+{0}{1}',exp,UIDiscipleModel:getDiscipleBaseAttrName(v[1]))
commonTipsHelper.addThrowOutAndSliderTips(1,str)
end
end
end

function UIDiscipleModel:calculationLTGrow(guid,baseGrow,addrate)
addrate=addrate or 0
local ex_grow=UIDiscipleModel:getLTGrowRate(guid)
local grow=baseGrow*(1+ex_grow+addrate)
return math.floor(grow)
end


function UIDiscipleModel:calculationLTMedicineGrow(guid,baseGrow,itemid)
local addrate=0

if itemsLookup:checkItemFuncType(itemid,item_funtion_type.lt_jingyandan)then

addrate=addrate+gubaoModel:getGBSkil_LianTiExpRate2(2)/100

local buildingBuffRate=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eLianTiSpeed,2)
buildingBuffRate=buildingBuffRate/100

local swEffecData=UIDiscipleModel:getShuWuDZGlobalDYEffectData()
local rate=(swEffecData[3]or 0)/100
addrate=addrate+buildingBuffRate+rate
end
local value=UIDiscipleModel:calculationLTGrow(guid,baseGrow,addrate)
value=math.floor(value)
return value
end


function UIDiscipleModel:getLTGrowRate(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getLTGrowRateByData(netData)
end

function UIDiscipleModel:getLTGrowRateByData(netData)
local rate=0

local ex_grow=UIDiscipleModel:getDiscipleBaseAttrExListXXByData(netData,DISCIPLE_BASE_ATTR_TYPE.eGenGu,1)
ex_grow=ex_grow/100
rate=rate+ex_grow

local spe_grow=dzSpecialityGrowEffectController:getLianTiUpSpeedRate(netData)
spe_grow=spe_grow/100
rate=rate+spe_grow

local gb_grow=gubaoModel:getGBSkil_LianTiExpRate()+gubaoModel:getGBSkil_LianTiExpRate2(0)
gb_grow=gb_grow/100
rate=rate+gb_grow

local fb_rate=UIFuLuFangModel:getFuBaoEffectByData(netData,FUBAO_EFFECT_TYPE.eLianTiSpeed)
fb_rate=fb_rate/100
rate=rate+fb_rate

local buffRate=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eDiziLiantiXiaolvChanged)or 0
buffRate=buffRate/100
rate=rate+buffRate

local xcVal=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eDiziLianTiRate)
xcVal=xcVal/100
rate=rate+xcVal

return rate,{ex_grow,spe_grow,gb_grow,fb_rate,buffRate,xcVal}
end


























function UIDiscipleModel:findClosestLianTiDZ(liantilv)
local all=UIDiscipleModel:getAllDiscipleData()
local guid=nil
local ltlv=-1
local ltexp=-1
local fight=-1
for k,v in pairs(all)do
local netData=v.netData.net
if liantilv==nil or netData.liantilv<liantilv then
local guid_=netData.discipleguid
local chuiwei=UIDiscipleModel:checkDiscipleState2(guid_,DISCIPLE_STATE_TYPE.eChuiWei)
if not chuiwei then
if netData.liantilv>ltlv then
ltlv=netData.liantilv
ltexp=netData.liantiexp
fight=UIDiscipleModel:getDiscipleFightValueEx(netData)
guid=guid_
elseif netData.liantilv==ltlv then
if liantilv~=nil then
if netData.liantiexp>ltexp then
ltexp=netData.liantiexp
guid=guid_
end
else
local fight_=UIDiscipleModel:getDiscipleFightValueEx(netData)
if fight_>fight then
fight=fight_
guid=guid_
end
end
end
end
end
end
return guid
end