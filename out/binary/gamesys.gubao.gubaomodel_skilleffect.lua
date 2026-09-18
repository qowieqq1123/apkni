














local eGBSkillEffectType={
eJingJieAttr=1,
eLianTiAttr=2,
eGongFaSpeedRate=3,
eBuildProduceRate=4,
eDuJieRate=5,
eSchoolMaxCount=6,
eProskillExpRate=7,
eJingJieExpRate=8,
eLianTiExpRate=9,


eProskillToJJAttrRate=11,
eProskillToLTAttrRate=12,
eMoreShouYuanInNewDZ=13,
eStrangeForgetCostRate=14,
eWorldMoveSpeedRate=15,
eWorldTokenAddNum=16,
eRoomEmptyRate=17,
eMoneyUpRate=18,
eMoneyDownRate=19,
eMoneyAutoUpRate=20,
eYueKaJiKaLingYuUpRate=21,
eBaoLingShuFreeNum=22,
eShopChongZhiLingYuUpRate=23,
eGuangGaoNumAttr=24,
eSuoYaoTaFloorNumAttr=25,
eLiLianBossNumAttr=26,
eBlueDanYaoNumAttr=27,
ePurpleDanYaoNumAttr=28,
eOrangeAndUpDanYaoNumAttr=29,
eBlueFaBaoNumAttr=30,
ePurpleFaBaoNumAttr=31,
eOrangeAndUpFaBaoNumAttr=32,
eBlueFuBaoNumAttr=33,
ePurpleFuBaoNumAttr=34,
eOrangeAndUpFuBaoNumAttr=35,
eHouShanShiLianNumAttr=36,
eLingPaiCostNumAttr=37,
eDouFaTaiNumAttr=38,
eLoginDayNumAttr=39,
eWorldMonsterNumAttr=40,
eWorldMiJingNumAttr=41,
eDailyTaskNumAttr=42,
ePurpleAndUpXuanShangNumAttr=43,
eYYHYMoneyCardDailyRewardNumAttr=44,
eZGGDMoneyCardDailyRewardNumAttr=45,
eXXXMoneyCardDailyRewardNumAttr=53,
eLimitActTYSCNumAttr=54,
eLimitActTYCYNumAttr=55,
eLimitActXXXNumAttr=73,
eBlueGongFaNumAttr=75,
ePurpleGongFaNumAttr=76,
eOrangeGongFaNumAttr=77,
eRedGongFaNumAttr=78,
eLingTianProduceGreenNum=81,
eLingTianProduceBlueNum=82,
eLingTianProducePurpleNum=83,
eLingTianProduceOrangeNum=84,
eLingTianProduceRedNum=85,
eLinChangProduceGreenNum=86,
eLinChangProduceBlueNum=87,
eLinChangProducePurpleNum=88,
eLinChangProduceOrangeNum=89,
eLinChangProduceRedNum=90,
eKuangChangProduceGreenNum=91,
eKuangChangProduceBlueNum=92,
eKuangChangProducePurpleNum=93,
eKuangChangProduceOrangeNum=94,
eKuangChangProduceRedNum=95,
eLianQiGeProduceGreenNum=96,
eLianQiGeProduceBlueNum=97,
eLianQiGeProducePurpleNum=98,
eLianQiGeProduceOrangeNum=99,
eLianQiGeProduceRedNum=100,
eXMDGxdlNumAttr=101,
eFinishingNumAttr=102,
eXiuZhenJiaZuAddNum=103,
eFuLuTime=104,
eTianDaoDingAddDaoHuo=105,
eAddSatiety=106,
eAddGongFaExp=107,
eXiuZhenJiaZuAddMember=108,
eLianDanTime=109,
eLianDanProduce=110,
eLianDanDouble=111,
eJingJieExpRate2=112,
eLianTiExpRate2=113,
eYifanglingtianGainAttr=114,
eDaoLvDZAttr=115,
eAirGameAttr=116,
eXunBaoShiLianGuanQiaNum=117,
eXianXiuDzAddAllDzAttr=118,
eMoXiuDzAddAllDzAttr=119,
eXianMoDzDaoHang=120,
eXianMoDzDaoHangSpeed=121,
eJunZhenAttr=122,
eJuTianYiYield=123,
eTaiXuCangProtectVal=124,
eSmallWorldPeopleAddSpeed=125,
eSmallWorldXiangHuoAddSpeed=126,
eXianBaoAttr=127,
eXianJieFeiShengArr=128,






eXianXiuDZAddAttr=130,
eMoXiuDZAddAttr=131,
eMoJieAddJzAttr=132,
eMoJieAttackMoJiang=133,
eMoJieAttackMoJun=134,
eMoJieAttack=135,
eYLZMaxHurtNum=136,
eYXGSingleMaxCooperationCount=137,
eYLZMaxHurtPercent=138,
eYXGMaxCooperationTypeNum=139,
eSmallWorldXiuShiAddSpeed=140,
}

local counterChangeLookup={
[eGBSkillEffectType.eGuangGaoNumAttr]={gameCounterType.eGuangGaoNum},
[eGBSkillEffectType.eSuoYaoTaFloorNumAttr]={gameCounterType.eSuoYaoTaFloorNum},
[eGBSkillEffectType.eLiLianBossNumAttr]={gameCounterType.eLiLianBossNum},
[eGBSkillEffectType.eBlueDanYaoNumAttr]={gameCounterType.eBlueDanYaoNum},
[eGBSkillEffectType.ePurpleDanYaoNumAttr]={gameCounterType.ePurpleDanYaoNum},
[eGBSkillEffectType.eOrangeAndUpDanYaoNumAttr]={gameCounterType.eOrangeDanYaoNum,gameCounterType.eRedDanYaoNum},
[eGBSkillEffectType.eBlueFaBaoNumAttr]={gameCounterType.eBlueFaBaoNum},
[eGBSkillEffectType.ePurpleFaBaoNumAttr]={gameCounterType.ePurpleFaBaoNum},
[eGBSkillEffectType.eOrangeAndUpFaBaoNumAttr]={gameCounterType.eOrangeFaBaoNum,gameCounterType.eRedFaBaoNum},
[eGBSkillEffectType.eBlueFuBaoNumAttr]={gameCounterType.eBlueFuBaoNum},
[eGBSkillEffectType.ePurpleFuBaoNumAttr]={gameCounterType.ePurpleFuBaoNum},
[eGBSkillEffectType.eOrangeAndUpFuBaoNumAttr]={gameCounterType.eOrangeFuBaoNum,gameCounterType.eRedFuBaoNum},
[eGBSkillEffectType.eBlueGongFaNumAttr]={gameCounterType.eBlueGongFaNum},
[eGBSkillEffectType.ePurpleGongFaNumAttr]={gameCounterType.ePurpleGongFaNum},
[eGBSkillEffectType.eOrangeGongFaNumAttr]={gameCounterType.eOrangeGongFaNum},
[eGBSkillEffectType.eRedGongFaNumAttr]={gameCounterType.eRedGongFaNum},
[eGBSkillEffectType.eLoginDayNumAttr]={gameCounterType.eLoginDayNum},
[eGBSkillEffectType.eWorldMonsterNumAttr]={gameCounterType.eWorldMonsterNum},
[eGBSkillEffectType.eWorldMiJingNumAttr]={gameCounterType.eWorldMiJingNum},
[eGBSkillEffectType.eDailyTaskNumAttr]={gameCounterType.eDailyTaskNum},
[eGBSkillEffectType.ePurpleAndUpXuanShangNumAttr]={gameCounterType.ePurpleXuanShangNum,gameCounterType.eOrangeXuanShangNum,gameCounterType.eRedXuanShangNum},
[eGBSkillEffectType.eYYHYMoneyCardDailyRewardNumAttr]={gameCounterType.eYYHYMoneyCardDailyRewardNum},
[eGBSkillEffectType.eZGGDMoneyCardDailyRewardNumAttr]={gameCounterType.eZGGDMoneyCardDailyRewardNum},
[eGBSkillEffectType.eLimitActTYSCNumAttr]={gameCounterType.eLimitActTYSCNum},
[eGBSkillEffectType.eLimitActTYCYNumAttr]={gameCounterType.eLimitActTYCYNum},
[eGBSkillEffectType.eLingTianProduceGreenNum]={gameCounterType.eLingTianProduceGreenNum},
[eGBSkillEffectType.eLingTianProduceBlueNum]={gameCounterType.eLingTianProduceBlueNum},
[eGBSkillEffectType.eLingTianProducePurpleNum]={gameCounterType.eLingTianProducePurpleNum},
[eGBSkillEffectType.eLingTianProduceOrangeNum]={gameCounterType.eLingTianProduceOrangeNum},
[eGBSkillEffectType.eLingTianProduceRedNum]={gameCounterType.eLingTianProduceRedNum},
[eGBSkillEffectType.eLinChangProduceGreenNum]={gameCounterType.eLinChangProduceGreenNum},
[eGBSkillEffectType.eLinChangProduceBlueNum]={gameCounterType.eLinChangProduceBlueNum},
[eGBSkillEffectType.eLinChangProducePurpleNum]={gameCounterType.eLinChangProducePurpleNum},
[eGBSkillEffectType.eLinChangProduceOrangeNum]={gameCounterType.eLinChangProduceOrangeNum},
[eGBSkillEffectType.eLinChangProduceRedNum]={gameCounterType.eLinChangProduceRedNum},
[eGBSkillEffectType.eKuangChangProduceGreenNum]={gameCounterType.eKuangChangProduceGreenNum},
[eGBSkillEffectType.eKuangChangProduceBlueNum]={gameCounterType.eKuangChangProduceBlueNum},
[eGBSkillEffectType.eKuangChangProducePurpleNum]={gameCounterType.eKuangChangProducePurpleNum},
[eGBSkillEffectType.eKuangChangProduceOrangeNum]={gameCounterType.eKuangChangProduceOrangeNum},
[eGBSkillEffectType.eKuangChangProduceRedNum]={gameCounterType.eKuangChangProduceRedNum},
[eGBSkillEffectType.eLianQiGeProduceGreenNum]={gameCounterType.eLianQiGeProduceGreenNum},
[eGBSkillEffectType.eLianQiGeProduceBlueNum]={gameCounterType.eLianQiGeProduceBlueNum},
[eGBSkillEffectType.eLianQiGeProducePurpleNum]={gameCounterType.eLianQiGeProducePurpleNum},
[eGBSkillEffectType.eLianQiGeProduceOrangeNum]={gameCounterType.eLianQiGeProduceOrangeNum},
[eGBSkillEffectType.eLianQiGeProduceRedNum]={gameCounterType.eLianQiGeProduceRedNum},
[eGBSkillEffectType.eHouShanShiLianNumAttr]={gameCounterType.eHouShanShiLianNum},
[eGBSkillEffectType.eLingPaiCostNumAttr]={gameCounterType.eLingPaiCostNum},
[eGBSkillEffectType.eDouFaTaiNumAttr]={gameCounterType.eDouFaTaiNum},
[eGBSkillEffectType.eXMDGxdlNumAttr]={gameCounterType.eXianMengDiGongXDLNum},
[eGBSkillEffectType.eFinishingNumAttr]={gameCounterType.eFinishingNum},
[eGBSkillEffectType.eYifanglingtianGainAttr]={gameCounterType.eYifanglingtianGainNum},
[eGBSkillEffectType.eAirGameAttr]={gameCounterType.eAirGameNum},
[eGBSkillEffectType.eXunBaoShiLianGuanQiaNum]={gameCounterType.eXunBaoShiLianGuanQiaNum},
[eGBSkillEffectType.eXianXiuDzAddAllDzAttr]={gameCounterType.eXianXiuDZNum},
[eGBSkillEffectType.eMoXiuDzAddAllDzAttr]={gameCounterType.eMoXiuDzNum},
}

local counterChangeLookup2={}
for skillType,v in pairs(counterChangeLookup)do
for i,changeType in ipairs(v)do
if counterChangeLookup2[changeType]==nil then
counterChangeLookup2[changeType]={}
end
counterChangeLookup2[changeType][skillType]=true
end
end

local _effectlist=nil

function gubaoModel:checkCounterToChange(accutype)
if counterChangeLookup2[accutype]then
local check=false
for skillType,v in pairs(counterChangeLookup2[accutype])do
local all=gubaoModel:getSkillEffectList()
local temp=all[skillType]
if temp then
check=true
break
end
end
if check then

local discipleNetData=UIDiscipleModel:getAllDiscipleData()
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
UIDiscipleModel:setDiscipleAttrListDirty(netData,nil,false)
end
end
end
end
end

function gubaoModel:clearAllSkillEffect()
_effectlist=nil
end

function gubaoModel:initAllSkillEffectList()
_effectlist={}
local allgubao=gubaoModel:getGuGaoArray()
if allgubao~=nil then
local suitlookup1={}
local suitlookup2={}
local suitlookup3={}
for k,gbData in pairs(allgubao)do
local gbid=gbData.gubaoid
local skilllv=gubaoModel:getSkillLvEx(gbid,gbData.gubaostar,gbData.gubaojxlv,gbData.gubaoskilllv)
local skilldata=cfgHelper.get3(cfg_gubaoconfig_get,gbid,'skill',skilllv)
gubaoModel:addSkillEffectList(skilldata)

local feishengdata=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'fly_attr')
if feishengdata then
gubaoModel:addFeiShengEffectList(feishengdata)
end


local suitlist=gubaoLookup:getSuitList(gbid)
if suitlist~=nil and#suitlist>0 then
for i2,v2 in ipairs(suitlist)do

if gubaoModel:checkSuitActive1(v2)then
suitlookup1[v2]=true
end

if gubaoModel:checkSuitActive2(v2)then
suitlookup2[v2]=true
end

if gubaoModel:checkSuitActive3(v2)then
suitlookup3[v2]=true
end
end
end
end

for k,v in pairs(suitlookup1)do
if v==true then
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,k)
gubaoModel:addSkillEffectList(suitcfg.skill0)
end
end

for k,v in pairs(suitlookup2)do
if v==true then
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,k)
gubaoModel:addSkillEffectList(suitcfg.skill3)
end
end

for k,v in pairs(suitlookup3)do
if v==true then
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,k)
gubaoModel:addSkillEffectList(suitcfg.skill_1)
end
end
end
end

function gubaoModel:addSkillEffectList(skill)
if skill~=nil then
local skilldata=skill[3]
if skilldata~=nil and#skilldata>0 then
for i,v in ipairs(skilldata)do
local effectType=v[1]
if _effectlist[effectType]==nil then
_effectlist[effectType]={}
end
table.insert(_effectlist[effectType],v)
end
end
end
end
function gubaoModel:addFeiShengEffectList(skill)
if skill~=nil then
local skilldata=skill
if skilldata~=nil and#skilldata>0 then
for i,v in ipairs(skilldata)do
local effectType=v[1]
if _effectlist[effectType]==nil then
_effectlist[effectType]={}
end
table.insert(_effectlist[effectType],v)
end
end
end
end

function gubaoModel:getSkillEffectList()
if _effectlist==nil then
gubaoModel:initAllSkillEffectList()
end
return _effectlist
end


function gubaoModel:checkIsCounterSkillEffect(skillType)
return counterChangeLookup[skillType]~=nil
end

function gubaoModel.getCounterEffectLimit(effect)
return effect[2],effect[3],effect[4]or 0,effect[5]or 1
end

function gubaoModel:getGBCounterEffectProgress(effect,checkMax)
local skillType=effect[1]
local attrType,attrValue,numlimit,space=gubaoModel.getCounterEffectLimit(effect)
local changes=counterChangeLookup[skillType]
local num=0
if changes then
num=gameUtilityModel:getData_counterEx(changes)
num=math.floor(num/space)
if checkMax then
if numlimit>0 and num>numlimit then
num=numlimit
end
end
end
return num,numlimit
end

function gubaoModel:getSkillEffectAttrValue(effect)
local skillType=effect[1]
local v
if skillType==eGBSkillEffectType.eJingJieAttr or skillType==eGBSkillEffectType.eLianTiAttr
or(skillType>=30000 and skillType<=39999)or skillType==eGBSkillEffectType.eJunZhenAttr
or skillType==eGBSkillEffectType.eMoJieAddJzAttr then

v=helper.getAttributeNum(effect[2],effect[3],6)
elseif skillType==eGBSkillEffectType.eProskillExpRate or skillType==eGBSkillEffectType.eMoneyUpRate
or skillType==eGBSkillEffectType.eMoneyDownRate or skillType==eGBSkillEffectType.eMoneyAutoUpRate then
v=effect[3]
elseif gubaoModel:checkIsCounterSkillEffect(skillType)then
v=effect[4]
elseif skillType==eGBSkillEffectType.eDaoLvDZAttr then

v=helper.getAttributeNum(effect[2],effect[3],6)
elseif skillType==eGBSkillEffectType.eXianXiuDZAddAttr or skillType==eGBSkillEffectType.eMoXiuDZAddAttr then
v=effect[3]*100

elseif skillType==eGBSkillEffectType.eMoJieAttackMoJiang or skillType==eGBSkillEffectType.eMoJieAttackMoJun or
skillType==eGBSkillEffectType.eMoJieAttack then
local rid=effect[2]
local lv=effect[3]
local ruleCfg=cfgHelper.getSSlawRule(rid)
local descparm=ruleCfg.descparm
if descparm and descparm[lv]and next(descparm[lv])then
v=unpack(descparm[lv])
else
v=lv
logErr(FMT.fmt("古宝技能效果 使用法则id -->>{0} 等级 -->> {1} 法则配置 必须配置显示参数 descparm",rid,lv))
end
else
v=effect[#effect]
end
if skillType==eGBSkillEffectType.eLianDanProduce or skillType==eGBSkillEffectType.eLianDanDouble then

v=v/100
end

return v
end




function gubaoModel:getGBSkil_DaoLvAttr()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eDaoLvDZAttr]
local lookup={}
if temp then
for i,v in ipairs(temp)do
local attrType=v[2]
local attrValue=v[3]
lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrValue
end
end
return lookup
end



function gubaoModel:getGBSkil_JingJieAttr(jjlv)
if jjlv==nil then return{}end
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eJingJieAttr]
local lookup={}
if temp then
for i,v in ipairs(temp)do
local attrType=v[2]
local attrValue=v[3]
lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrValue
end
for k,v in pairs(lookup)do
lookup[k]=v*jjlv
end
end
return lookup
end



function gubaoModel:getGBSkil_LianTiAttr(ltlv)
if ltlv==nil then return{}end
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eLianTiAttr]
local lookup={}
if temp then
for i,v in ipairs(temp)do
local attrType=v[2]
local attrValue=v[3]
lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrValue
end
for k,v in pairs(lookup)do
lookup[k]=v*ltlv
end
end
return lookup
end



function gubaoModel:getGBSkil_GongFaSpeedRate(gfElement)
if gfElement==nil then return 0 end
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eGongFaSpeedRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
if v[2]==0 or v[2]==gfElement then
rate=rate+v[3]
end
end
end
return rate
end



function gubaoModel:getGBSkil_BuildProduceRate(buildid)
if buildid==nil then return 0 end
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eBuildProduceRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
if v[2]==0 or v[2]==buildid then
rate=rate+v[3]
end
end
end
return rate
end



function gubaoModel:getGBSkil_DuJieRate(jjlv)
if jjlv==nil then return 0 end
local floor=UIDiscipleModel:getJJFloor(jjlv)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eDuJieRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
if floor>=v[2]and floor<=v[3]then
rate=rate+v[4]
end
end
end
return rate
end


function gubaoModel:getGBSkil_SchoolMaxCount()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eSchoolMaxCount]
local rate=0
if temp then
for i,v in ipairs(temp)do
rate=rate+v[2]
end
end
return rate
end




function gubaoModel:getGBSkil_ProskillExpRate(proskillid,scrType)
if proskillid==nil then return 0 end
if scrType==nil then scrType=0 end
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eProskillExpRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
local _scrType=v[4]or 0
if v[2]==0 or v[2]==proskillid then
if _scrType==scrType or _scrType==0 then
rate=rate+v[3]
end
end
end
end
return rate
end


function gubaoModel:getGBSkil_JingJieExpRate()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eJingJieExpRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
rate=rate+v[2]
end
end
return rate
end


function gubaoModel:getGBSkil_LianTiExpRate()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eLianTiExpRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
rate=rate+v[2]
end
end
return rate
end















function gubaoModel:getGBSkil_ProskillToJJAttrRate(guid)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eProskillToJJAttrRate]
local rate=0
if temp and#temp>0 then
local lp={}
local netData=UIDiscipleModel:getDiscipleData(guid)
for k,proskillid in pairs(DISCIPLE_PROSKILL_TYPE)do
local lv=UIDiscipleModel:getDiscipleJobLevelEx(netData,proskillid)
if lv>0 then
lp[proskillid]=lv
end
end
for i,v in ipairs(temp)do
local lv=lp[v[2]]
if lv~=nil then
rate=rate+v[3]*lv
end
end
end
return rate
end


function gubaoModel:getGBSkil_ProskillToLTAttrRate(guid)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eProskillToLTAttrRate]
local rate=0
if temp and#temp>0 then
local lp={}
local netData=UIDiscipleModel:getDiscipleData(guid)
for k,proskillid in pairs(DISCIPLE_PROSKILL_TYPE)do
local lv=UIDiscipleModel:getDiscipleJobLevelEx(netData,proskillid)
if lv>0 then
lp[proskillid]=lv
end
end
for i,v in ipairs(temp)do
local lv=lp[v[2]]
if lv~=nil then
rate=rate+v[3]*lv
end
end
end
return rate
end


function gubaoModel:getGBSkil_MoreShouYuanInNewDZ()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eMoreShouYuanInNewDZ]
local num=0
if temp then
for i,v in ipairs(temp)do
num=num+v[2]
end
end
return num
end


function gubaoModel:getGBSkil_StrangeForgetCostRate()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eStrangeForgetCostRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
rate=rate+v[2]
end
end
return rate
end


function gubaoModel:getGBSkil_WorldMoveSpeedRate()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eWorldMoveSpeedRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
rate=rate+v[2]
end
end
return rate
end


function gubaoModel:getGBSkil_WorldTokenAddNum()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eWorldTokenAddNum]
local num=0
if temp then
for i,v in ipairs(temp)do
num=num+v[2]
end
end
return num
end


function gubaoModel:getGBSkil_RoomEmptyRate()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eRoomEmptyRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
rate=rate+v[2]
end
end
return rate
end




function gubaoModel:getGBSkil_MoneyUpRate(ctype,moneytype)
if ctype==nil then return 0 end
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eMoneyUpRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
if v[2]==moneytype and(v[4]==nil or v[4]==0 or v[4]==ctype)then
rate=rate+v[3]
end
end
end
return rate
end




function gubaoModel:getGBSkil_MoneyDownRate(ctype,moneytype)
if ctype==nil then return 0 end
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eMoneyDownRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
if v[2]==moneytype and(v[4]==nil or v[4]==0 or v[4]==ctype)then
rate=rate+v[3]
end
end
end
return rate
end




function gubaoModel:getGBSkil_MoneyAutoUpRate(ctype,moneytype)
if ctype==nil then return 0 end
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eMoneyAutoUpRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
if v[2]==moneytype and(v[4]==nil or v[4]==0 or v[4]==ctype)then
rate=rate+v[3]
end
end
end
return rate
end



function gubaoModel:getGBSkil_YueKaJiKaLingYuUpRate(typo)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eYueKaJiKaLingYuUpRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
if v[2]==0 or v[2]==typo then
rate=rate+v[3]
end
end
end
return rate
end


function gubaoModel:getGBSkil_BaoLingShuFreeNum()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eBaoLingShuFreeNum]
local num=0
if temp then
for i,v in ipairs(temp)do
num=num+v[2]
end
end
return num
end


function gubaoModel:getGBSkil_ShopChongZhiLingYuUpRate()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eShopChongZhiLingYuUpRate]
local rate=0
if temp then
for i,v in ipairs(temp)do
rate=rate+v[2]
end
end
return rate
end


function gubaoModel:getGBSkil_XiuZhenJiaZuAddNum()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eXiuZhenJiaZuAddNum]
local num=0
if temp then
for i,v in ipairs(temp)do
num=num+v[2]
end
end
return num
end


function gubaoModel:getGBSkil_FuLuTime()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eFuLuTime]
local rate=0
if temp then
for i,v in ipairs(temp)do
rate=rate+v[2]
end
end
return rate
end


function gubaoModel:getGBSkil_TianDaoDingAddDaoHuo()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eTianDaoDingAddDaoHuo]
local num=0
if temp then
for i,v in ipairs(temp)do
num=num+v[2]
end
end
return num
end


function gubaoModel:getGBSkil_AddSatiety()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eAddSatiety]
local num=0
if temp then
for i,v in ipairs(temp)do
num=num+v[2]
end
end
return num
end



function gubaoModel:getGBSkil_AddGongFaExp(ctype)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eAddGongFaExp]
local rate=0
if temp then
for i,v in ipairs(temp)do
if v[2]==0 or v[2]==ctype then
rate=rate+v[3]
end
end
end
return rate
end


function gubaoModel:getGBSkil_XiuZhenJiaZuAddMember()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eXiuZhenJiaZuAddMember]
local num=0
if temp then
for i,v in ipairs(temp)do
num=num+v[2]
end
end
return num
end


function gubaoModel:getGBSkil_LianDanTime()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eLianDanTime]
local rate=0
if temp then
for i,v in ipairs(temp)do
rate=rate+v[2]
end
end
return rate
end


function gubaoModel:getGBSkil_LianDanProduce()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eLianDanProduce]
local list={}
if temp then
for i,v in ipairs(temp)do
table.insert(list,v)
end
end
return list
end



function gubaoModel:getGBSkil_JingJieExpRate2(ctype)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eJingJieExpRate2]
local rate=0
if temp then
for i,v in ipairs(temp)do

if v[2]==ctype then
rate=rate+v[3]
end
end
end
return rate
end



function gubaoModel:getGBSkil_LianTiExpRate2(ctype)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eLianTiExpRate2]
local rate=0
if temp then
for i,v in ipairs(temp)do

if v[2]==ctype then
rate=rate+v[3]
end
end
end
return rate
end


function gubaoModel:getGBSkil_job_jj_attrRateLookup(jobid)
local all=gubaoModel:getSkillEffectList()
local lp={}
local typo=10000
local temp=all[typo]
gubaoModel:getGBSkil_job_jj_attrRateLookup_Ex(lp,temp)
typo=10000+jobid
temp=all[typo]
gubaoModel:getGBSkil_job_jj_attrRateLookup_Ex(lp,temp)
return lp
end
function gubaoModel:getGBSkil_job_jj_attrRateLookup_Ex(lp,list)
if list then
for i,v in ipairs(list)do
local attrType=v[2]
if lp[attrType]==nil then
lp[attrType]=v[3]/100
else
lp[attrType]=lp[attrType]+v[3]/100
end
end
end
end


function gubaoModel:getGBSkil_job_lt_attrRateLookup(jobid)
local all=gubaoModel:getSkillEffectList()
local lp={}
local typo=20000
local temp=all[typo]
gubaoModel:getGBSkil_job_lt_attrRateLookup_ex(lp,temp)
typo=20000+jobid
temp=all[typo]
gubaoModel:getGBSkil_job_lt_attrRateLookup_ex(lp,temp)
return lp
end
function gubaoModel:getGBSkil_job_lt_attrRateLookup_ex(lp,list)
if list then
for i,v in ipairs(list)do
local attrType=v[2]
if lp[attrType]==nil then
lp[attrType]=v[3]/100
else
lp[attrType]=lp[attrType]+v[3]/100
end
end
end
end


function gubaoModel:getGBSkil_job_attrLookup(jobid)
local all=gubaoModel:getSkillEffectList()
local typo=30000+jobid
local temp=all[typo]
local lp={}
if temp then
for i,v in ipairs(temp)do
local attrType=v[2]
if lp[attrType]==nil then
lp[attrType]=v[3]
else
lp[attrType]=lp[attrType]+v[3]
end
end
end
return lp
end


function gubaoModel:getGBSkil_allCounterEffectAttr()
local attrLookup={}
local all=gubaoModel:getSkillEffectList()
for skillType,changes in pairs(counterChangeLookup)do
local temp=all[skillType]
if temp then
local num=gameUtilityModel:getData_counterEx(changes)
if num>0 then
for i,effect in ipairs(temp)do
local attrType,attrValue,numlimit,space=gubaoModel.getCounterEffectLimit(effect)
local n=math.floor(num/space)
if numlimit>0 and n>numlimit then
n=numlimit
end
local attrValue=effect[3]*n
attrLookup[attrType]=attrLookup[attrType]or 0
attrLookup[attrType]=attrLookup[attrType]+attrValue
end
end
end
end
return attrLookup
end















function gubaoModel:getGBSkil_allCounterEffectAttr_print()
local attrLookup={}
local all=gubaoModel:getSkillEffectList()
for skillType,changes in pairs(counterChangeLookup)do

local temp=all[skillType]
if temp then
local num=gameUtilityModel:getData_counterEx(changes)
if num>0 then
local lp={}
for i,effect in ipairs(temp)do
local attrType,attrValue,numlimit,space=gubaoModel.getCounterEffectLimit(effect)
local n=math.floor(num/space)
if numlimit>0 and n>numlimit then
n=numlimit
end
local attrValue=effect[3]*n
lp[attrType]=lp[attrType]or 0
lp[attrType]=lp[attrType]+attrValue
end
attrLookup[skillType]=lp
end
end
end

end


function gubaoModel:getXianMo_DaoHangAttr(type)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eXianMoDzDaoHang]
local val=0
if temp then
for i,v in ipairs(temp)do
if type==v[2]then
val=val+v[3]
end
end
end
return val
end


function gubaoModel:getXianMo_DaoHangEXPSpeed(type)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eXianMoDzDaoHangSpeed]
local val=0
if temp then
for i,v in ipairs(temp)do
if type==v[2]then
val=val+v[3]
end
end
end
return val
end


function gubaoModel:getJunZhenAttrAttr()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eJunZhenAttr]
local lookup={}
if temp then
for i,v in ipairs(temp)do
local attrType=v[2]
local attrValue=v[3]
lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrValue
end
end

local sceneType=xianjieModel:getScenceType()
if sceneType and xianjienSceneType:isMoJie(sceneType)then

local mojietemp=all[eGBSkillEffectType.eMoJieAddJzAttr]
if mojietemp then
for i,v in ipairs(mojietemp)do
local attrType=v[2]
local attrValue=v[3]
lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrValue
end
end
end
return lookup
end


function gubaoModel:geteJuTianYiYield(type)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eJuTianYiYield]
local val=0
if temp then
for i,v in ipairs(temp)do
if type==v[2]then
val=val+v[3]
end
end
end
return val
end


function gubaoModel:getTaiXuCangProtectVal(type)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eTaiXuCangProtectVal]
local val=0
if temp then
for i,v in ipairs(temp)do
if type==v[2]then
val=val+v[3]
end
end
end
return val
end


function gubaoModel:geteSmallWorldPeopleAddSpeed()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eSmallWorldPeopleAddSpeed]
local val=0
if temp then
for i,v in ipairs(temp)do
val=val+v[2]
end
end
return val
end


function gubaoModel:getSmallWorldXiangHuoAddSpeed()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eSmallWorldXiangHuoAddSpeed]
local val=0
if temp then
for i,v in ipairs(temp)do
val=val+v[2]
end
end
return val
end


function gubaoModel:getXianBaoAttr(xbid)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eXianBaoAttr]
local val=0
if temp then
for i,v in ipairs(temp)do
if xbid==v[2]then
val=val+v[3]
end
end
end
return val
end


function gubaoModel:getXJFeiShengAttr()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eXianJieFeiShengArr]
local lookup={}
if temp then
for i,v in ipairs(temp)do
local attrType=v[2]
local attrValue=v[3]
lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrValue
end
end
return lookup
end


function gubaoModel:getXianXiuDZAddAttr()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eXianXiuDZAddAttr]
local lookup={}
if temp then
for i,v in ipairs(temp)do
local attrType=v[2]
local attrValue=v[3]
lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrValue
end
end
return lookup
end


function gubaoModel:getMoXiuDZAddAttr()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eMoXiuDZAddAttr]
local lookup={}
if temp then
for i,v in ipairs(temp)do
local attrType=v[2]
local attrValue=v[3]
lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrValue
end
end
return lookup
end


function gubaoModel:getYLZMaxHurtNumAddValue()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eYLZMaxHurtNum]
local addNum=0
if temp then
for i,v in ipairs(temp)do
addNum=addNum+v[2]
end
end
return addNum
end


function gubaoModel:getYXGSingleMaxCooperationCountAddNum()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eYXGSingleMaxCooperationCount]
local addNum=0
if temp then
for i,v in ipairs(temp)do
addNum=addNum+v[2]
end
end
return addNum
end


function gubaoModel:getYLZMaxHurtePercentAddValue()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eYLZMaxHurtPercent]
local addRate=0
if temp then
for i,v in ipairs(temp)do
addRate=addRate+v[2]
end
end
return addRate
end


function gubaoModel:getYXGMaxCooperationTypeAddNum(huZhuType)
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eYXGMaxCooperationTypeNum]
local addNum=0
if temp then
for i,v in ipairs(temp)do
local ctype=v[2]
if ctype==huZhuType then
addNum=addNum+v[3]
end
end
end
return addNum
end


function gubaoModel:geteSmallWorldXiuShiAddSpeed()
local all=gubaoModel:getSkillEffectList()
local temp=all[eGBSkillEffectType.eSmallWorldXiuShiAddSpeed]
local val=0
if temp then
for i,v in ipairs(temp)do
val=val+v[2]
end
end
return val
end


