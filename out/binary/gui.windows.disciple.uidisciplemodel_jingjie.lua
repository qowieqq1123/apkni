







function UIDiscipleModel:getDiscipleJJLevelByStr(guidStr)
local netData=UIDiscipleModel:getDiscipleDataByStr(guidStr)
return UIDiscipleModel:getDiscipleJJLevelEx(netData)
end

function UIDiscipleModel:getDiscipleJJLevel(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleJJLevelEx(netData)
end

function UIDiscipleModel:getDiscipleJJLevelEx(netData)
return netData.jingjielv
end

function UIDiscipleModel:getDiscipleJJPoint(jingjielv,jingjieexp)
local point=0
local jjcfg=cfg_disciplejingjieconfig_get(jingjielv)
local upexp=jjcfg.exp
local curexp=jingjieexp
if jjcfg.average then
local average=jjcfg.average
local piece=upexp/average
if curexp>upexp then
curexp=upexp
end
point=math.floor(curexp/piece)
if point>=average then point=average-1 end
upexp=piece
curexp=curexp-point*piece
end
return point,curexp,upexp
end

function UIDiscipleModel:getDiscipleJJLevelAndPointByData(netData)
local jingjielv=netData.jingjielv
local point=0
local jjcfg=cfg_disciplejingjieconfig_get(jingjielv)
if jjcfg.average then
local average=jjcfg.average
local upexp_=jjcfg.exp
local piece=upexp_/average
local curexp_=UIDiscipleModel:calculationJJExpByData(netData)
if curexp_>upexp_ then
curexp_=upexp_
end
point=math.floor(curexp_/piece)
if point>=average then point=average-1 end
end
return jingjielv,point
end

function UIDiscipleModel:getDiscipleJJLevelAndPoint(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleJJLevelAndPointByData(netData)
end

function UIDiscipleModel:getDiscipleJJLevelAndPoint2ByData(netData)
local jingjielv=netData.jingjielv
local point=0
local upexp
local curexp
local jjcfg=cfg_disciplejingjieconfig_get(jingjielv)
if jjcfg.average then
local average=jjcfg.average
local upexp_=jjcfg.exp
local piece=upexp_/average
local curexp_=UIDiscipleModel:calculationJJExpByData(netData)
if curexp_>upexp_ then
curexp_=upexp_
end
point=math.floor(curexp_/piece)
if point>=average then point=average-1 end
upexp=piece
curexp=curexp_-point*piece
else
upexp=jjcfg.exp
curexp=UIDiscipleModel:calculationJJExpByData(netData)
end
return jingjielv,point,curexp,upexp
end

function UIDiscipleModel:getDiscipleJJLevelAndPoint2(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleJJLevelAndPoint2ByData(netData)
end

function UIDiscipleModel:getDiscipleJJSatiety(guid)
local netData=self:getDiscipleData(guid)
return tonumber(tostring(netData.jingjiesatiety))
end

function UIDiscipleModel:setDiscipelJJDirty()
self.discipleJJListDirty=true
end

function UIDiscipleModel:refreshDiscipelJJData()
local alldisciple=UIDiscipleModel:getAllDiscipleDataX()
if alldisciple==nil then return end
if self.discipleJJList==nil or self.discipleJJListDirty~=false then
self.discipleJJListDirty=false
local discipleJJList={}
for k,v in pairs(alldisciple)do
local netData=v.netData.net
discipleJJList[#discipleJJList+1]={netData.discipleguidStr,netData.jingjielv}
end
table.sort(discipleJJList,function(a,b)
return a[2]<b[2]
end)
self.discipleJJList=discipleJJList
end
end


function UIDiscipleModel:getDiscipleJJCount(jjlv)
UIDiscipleModel:refreshDiscipelJJData()
local startIndex=table.getBiggerValueStartIndex(self.discipleJJList,jjlv,2)
if startIndex==nil then return 0 end
return#self.discipleJJList-startIndex+1
end


function UIDiscipleModel:getDiscipleJJCountList(jjlv)
local c=0
local list={}
local alldisciple=UIDiscipleModel:getAllDiscipleData()
if alldisciple then
for k,v in pairs(alldisciple)do
local netData=v.netData.net
if netData.jingjielv>=jjlv then
c=c+1
table.insert(list,netData)
end
end
end
return c,list
end


function UIDiscipleModel:calculationJJExpByData(netData,frameSpace)
local jjlv=netData.jingjielv

local nxjjexp=UIDiscipleModel:getJJExp(jjlv)
if nxjjexp==0 or netData.jingjieexp>=nxjjexp then return netData.jingjieexp end

local lerp
if not worldController:checkNoticiateBlockOpen()then

lerp=0
netData.checktm=gameUtilityModel.getServerShortTime()
else
lerp=gameUtilityModel.getServerShortTime()-netData.checktm
end
if lerp<=0 then return netData.jingjieexp end


local frameCount=Time.frameCount
frameSpace=frameSpace or 1
if netData.jjCacheExp==nil or
netData.jjCacheExpFrame==nil or
(netData.jjCacheExpFrame+frameSpace)<frameCount then

netData.jjCacheExpFrame=frameCount

local grow=UIDiscipleModel:calculationJJSecondGrowByData(netData)
local exp=math.floor(netData.jingjieexp+lerp*grow)
if exp>=nxjjexp then exp=nxjjexp end
netData.jjCacheExp=exp
end

return netData.jjCacheExp
end

function UIDiscipleModel:calculationJJExp(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:calculationJJExpByData(netData)
end

function UIDiscipleModel:calculationJJLerpTime(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local lerp=gameUtilityModel.getServerShortTime()-netData.checktm
return lerp
end

function UIDiscipleModel:calculationJJSecondGrowByData(netData)
local baseGrow=cfg_globalconfig_get(1).jingjieincr
local grow=UIDiscipleModel:calculationJJSecondGrowExByData(netData,baseGrow)
return grow
end

function UIDiscipleModel:calculationJJSecondGrow(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:calculationJJSecondGrowByData(netData)
end

function UIDiscipleModel:calculationJJSecondGrowExByData(netData,baseGrow)
local ex_grow=UIDiscipleModel:getJJAutoGrowRateByData(netData)
local absorb=fabaoModel.getAbsorbExpRateByStr(netData.discipleguidStr)
local grow=baseGrow*(1+ex_grow)*(1-absorb)
return grow
end

function UIDiscipleModel:calculationJJSecondGrowEx(guid,baseGrow)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:calculationJJSecondGrowExByData(netData,baseGrow)
end

function UIDiscipleModel:calculationJJGrowByData(netData,baseGrow,addrate)
addrate=addrate or 0
local ex_grow=UIDiscipleModel:getJJGrowRateByData(netData)
local absorb=fabaoModel.getAbsorbExpRateByStr(netData.discipleguidStr)
local grow=baseGrow*(1+ex_grow+addrate)*(1-absorb)
return grow
end

function UIDiscipleModel:calculationJJGrow(guid,baseGrow,addrate)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:calculationJJGrowByData(netData,baseGrow,addrate)
end


function UIDiscipleModel:calculationJJMedicineGrowByData(netData,baseGrow,itemid)
local addrate=0

if itemsLookup:checkItemFuncType(itemid,item_funtion_type.jj_xiuweidan)then

addrate=addrate+gubaoModel:getGBSkil_JingJieExpRate2(2)/100

addrate=addrate+dzSpecialityGrowEffectController:getJJMedicineRate(netData)

local buildingBuffRate=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eJingJieSpeed,2)
buildingBuffRate=buildingBuffRate/100
addrate=addrate+buildingBuffRate

local swEffecData=UIDiscipleModel:getShuWuDZGlobalDYEffectData()
local swRate=(swEffecData[1]or 0)/100
addrate=addrate+swRate


local buffRate=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eDanXiangSiYi)or 0
addrate=addrate+buffRate/100
end
local value=UIDiscipleModel:calculationJJGrowByData(netData,baseGrow,addrate)
value=math.floor(value)
return value
end


function UIDiscipleModel:calculationJJMedicineGrow(guid,baseGrow,itemid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:calculationJJMedicineGrowByData(netData,baseGrow,itemid)
end

function UIDiscipleModel:getJJGrowRateByData(netData)
local rate=0

local ex_grow=UIDiscipleModel:getDiscipleBaseAttrExListXXByData(netData,DISCIPLE_BASE_ATTR_TYPE.eZiZhi,1)
ex_grow=ex_grow/100
rate=rate+ex_grow

local spe_grow=dzSpecialityGrowEffectController:getJJXiuWeiUpSpeedRateByData(netData)
spe_grow=spe_grow/100
rate=rate+spe_grow

local gb_grow=gubaoModel:getGBSkil_JingJieExpRate()+gubaoModel:getGBSkil_JingJieExpRate2(0)
gb_grow=gb_grow/100
rate=rate+gb_grow

local fb_rate=UIFuLuFangModel:getFuBaoEffectByData(netData,FUBAO_EFFECT_TYPE.eXiuWeiSpeed)
fb_rate=fb_rate/100
rate=rate+fb_rate

local roomRate=zongmenModel:getDzRoomEffect_jjRate_ex_Data(netData)
rate=rate+roomRate

local postRate=UISectPalaceModel:getDiscipleXiuWeiReteByData(netData)
postRate=postRate/100
rate=rate+postRate

local buffRate=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eDiziXiulianXiaolvChanged)or 0
buffRate=buffRate/100
rate=rate+buffRate


local xcRate=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eDiziJingJieRate)
xcRate=xcRate/100
rate=rate+xcRate

return rate,{ex_grow,spe_grow,gb_grow,fb_rate,roomRate,postRate,buffRate,xcRate}
end


function UIDiscipleModel:getJJGrowRate(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getJJGrowRateByData(netData)
end


function UIDiscipleModel:getJJAutoGrowRateByData(netData)
local rate,rlist=UIDiscipleModel:getJJGrowRateByData(netData)

local buffRate=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eGetXiuweiXiaolvChanged)or 0
buffRate=buffRate/100
rate=rate+buffRate

rlist[#rlist+1]=buffRate


local buildingBuffRate=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eJingJieSpeed,1)
buildingBuffRate=buildingBuffRate/100
rate=rate+buildingBuffRate
rlist[#rlist+1]=buildingBuffRate


local xianmengActRate=xianmengModel:getAcTJJRateTeQuan()
xianmengActRate=xianmengActRate/100
rate=rate+xianmengActRate
rlist[#rlist+1]=xianmengActRate


local gb_grow=gubaoModel:getGBSkil_JingJieExpRate2(1)
gb_grow=gb_grow/100
rate=rate+gb_grow
rlist[#rlist+1]=gb_grow

return rate,rlist
end


function UIDiscipleModel:getJJAutoGrowRate(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getJJAutoGrowRateByData(netData)
end

function UIDiscipleModel:calculationJJTimeGrow(guid,time)
local netData=UIDiscipleModel:getDiscipleData(guid)
local grow=UIDiscipleModel:calculationJJSecondGrowByData(netData)
return math.floor(grow*time)
end

function UIDiscipleModel:getDuJieFailRate(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local floor=UIDiscipleModel:getJJFloor(jjlv)
local failTimes=UIDiscipleModel:getDuJieFailNum(guid)
local failAddRate=FeiShengTaiModel.getFailTimesAddRate(floor)*failTimes*(1+dzSpecialityGrowEffectController:getDuJieFailDuJieRateLookup(netData)/100)
return failAddRate
end

function UIDiscipleModel:isDiscipleJJLevelWillChange(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData)
end

function UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData,frameSpace)
local jjlv=netData.jingjielv
local nxjjexp=cfg_disciplejingjieconfig_get(jjlv).exp
if nxjjexp<=0 then return false end
local curjjexp=UIDiscipleModel:calculationJJExpByData(netData,frameSpace)
return curjjexp>=nxjjexp
end


function UIDiscipleModel:checkNextJJNeedBroke(jjlv)
local ncfg=cfg_disciplejingjieconfig_get(jjlv+1)
if ncfg then
local floor=cfg_disciplejingjieconfig_get(jjlv).floor
return floor~=ncfg.floor
end
return false
end


function UIDiscipleModel:checkJJAutoBrokeConditon(jjlv)
local autotp=cfgHelper.get2(cfg_feishengtaiconfig_get,1,'autodj')
return jjlv<=autotp
end

function UIDiscipleModel:checkJJBrokeByHand(jjlv)
local floor=UIDiscipleModel:getJJFloor(jjlv)
return floor>=1
end

local spNeedSystemTips=
{
[SYSTEM_DEFINE.eJiuChongTianJieComplete]="完成九重天劫渡劫飞升后可突破至{0}期"
}
local spNeedSystemJump=
{
[SYSTEM_DEFINE.eJiuChongTianJieComplete]=function()
jumpManager:jump({id=JUMP_TYPE.eJiuChongTianJie})
end,
}
function UIDiscipleModel:checkJJBrokeNeedSystem(jjlv,warning,jump)
local needsys=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'needsys')
if needsys~=nil and not systemModel.isOpen(needsys)then
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(needsys,true)
local typo=errArgs[1]
if typo==SYSTEM_OPEN_TYPE.eServerPlatform then
if warning then
UIManager.error("暂未开放")
end
return false,needsys,true
end
if warning then
local name=UIDiscipleModel:getJJName(jjlv+1)
local sptips=spNeedSystemTips[needsys]
if sptips then
UIManager.error(FMT.fmt(sptips,name))
else
UIManager.error(FMT.fmt('解锁{0}后可突破至{1}',systemConfig.getSystemName(needsys),name))
end
end
if jump then
if spNeedSystemJump[needsys]then
spNeedSystemJump[needsys]()
end
end
return false,needsys
end
return true
end


function UIDiscipleModel:checkJJAutoBrokeConditon2(strGuid)
local checkChuiwei=UIDiscipleModel:checkDiscipleState2ByStr(strGuid,DISCIPLE_STATE_TYPE.eChuiWei)
return not checkChuiwei

end

function UIDiscipleModel:checkJJAutoBrokeConditon3(jjlv,warning)
local sectlv=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'sectlv')
if sectlv~=nil then
local lv=zongmenModel:getLevel()
local flag=lv>=sectlv
if not flag and warning==true then
UIManager.error(FMT.fmt('宗门等级需达到{0}级',sectlv))
end
return flag
end
return true
end

function UIDiscipleModel:checkDiscipleJJNeedBroke(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local jingjielv=netData.jingjielv
local cfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,jingjielv)
local curjjexp=UIDiscipleModel:calculationJJExpByData(netData)
local nxjjexp=cfg.exp


if nxjjexp~=0 then
if curjjexp>=nxjjexp then
if UIDiscipleModel:checkNextJJNeedBroke(jingjielv)then
return true
end
end
end
return false
end


function UIDiscipleModel:checkJJNeedNonAutoBroke(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local jjlv=netData.jingjielv
return UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData)and UIDiscipleModel:checkNextJJNeedBroke(jjlv)and UIDiscipleModel:checkJJAutoBrokeConditon2(netData.discipleguiStr)
and not UIDiscipleModel:checkJJAutoBrokeConditon(jjlv)
end

function UIDiscipleModel:checkJJLevelFull(jjlv)

local nxjjexp=cfg_disciplejingjieconfig_get(jjlv).exp
return nxjjexp<=0
end
function UIDiscipleModel:checkJJLevelFullEx(jjcfg)
local nxjjexp=jjcfg.exp
return nxjjexp<=0
end

function UIDiscipleModel:getDuJieDanRate(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.jingjierate
end

function UIDiscipleModel:getDuJieFailNum(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.jingjietimes
end

function UIDiscipleModel:getTuPoDanUseCount(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.dujiesoulnum
end

function UIDiscipleModel:getJJNameX(jjlv)
local p,pN=UIDiscipleModel.getJJSuffix(jjlv)
return UIDiscipleModel:getJJName(jjlv),p,pN
end

function UIDiscipleModel.getJJSuffix(jjlv)
local jingjie_suffix=cfgHelper.getglobal1('jingjie_suffix')
local p=nil
local pN=''
local pIndex=nil
if jjlv>0 then
p=jjlv%10
if p==0 then
p=10
end
for i,v in ipairs(jingjie_suffix)do
if p>=v[1]and p<=v[2]then

if pfwindowslController:checkIsGameVersion_yuenan()then
pN=" "..v[3]
else
pN=v[3]
end
pIndex=i
break
end
end
end
return p,pN,pIndex
end

function UIDiscipleModel:getJJNameXX(jjlv)
return UIDiscipleModel.getJJNameCommon(jjlv,1)
end

function UIDiscipleModel:getJJNameEx(jjlv)
return UIDiscipleModel.getJJNameCommon(jjlv,2)
end

function UIDiscipleModel:getJJName3(jjlv)
return UIDiscipleModel.getJJNameCommon(jjlv,3)
end

function UIDiscipleModel:getJJName4(jjlv)
return UIDiscipleModel.getJJNameCommon(jjlv,4)
end

function UIDiscipleModel.getJJNameCommon(jjlv,typo)
typo=typo or 1
local p,pN=UIDiscipleModel.getJJSuffix(jjlv)
local fname=UIDiscipleModel:getJJFloorNameEx(jjlv)
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

function UIDiscipleModel:getJJName(jjlv)
local floor=UIDiscipleModel:getJJFloor(jjlv)
return UIDiscipleModel:getJJFloorName(floor)
end

function UIDiscipleModel:getJJFloor(jjlv)
return cfg_disciplejingjieconfig_get(jjlv).floor
end

function UIDiscipleModel:getJJExp(jjlv)
return cfg_disciplejingjieconfig_get(jjlv).exp
end

function UIDiscipleModel:getJJFloorName(floor)
return cfg_globalconfig_get(1).jingjiename[floor]
end
function UIDiscipleModel:getJJFloorNameEx(jjlv)
local floor=UIDiscipleModel:getJJFloor(jjlv)
return UIDiscipleModel:getJJFloorName(floor)
end
function UIDiscipleModel:checkJJFullFloor(floor)
local name=cfgHelper.getglobal2('jingjiename',floor)
return name==nil
end
function UIDiscipleModel:checkJJFullFloorEx(guid)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local floor=UIDiscipleModel:getJJFloor(jjlv)
floor=floor+1
return UIDiscipleModel:checkJJFullFloor(floor)
end

function UIDiscipleModel:getUseGoodStr(cond)
local str=''
local line=0
local jingjie=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eJingjieLv,cond)
if jingjie then
local jj_name=UIDiscipleModel:getJJName(jingjie[1])
str=str..FMT.fmt('{0}期弟子才可以服用',jj_name)
line=line+1
end
local attr6=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eAttr6,cond)
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

local tezhi=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eTeZhi,cond)
if tezhi then

for i,v in ipairs(tezhi)do
if v[1]==DISCIPLE_SPECIALITY_TYPE.eBody then
if line>0 then
str=str..'\n'
end
str=str..'该弟子已拥有特殊体质'
break
end
end
end
return str
end

function UIDiscipleModel:useJJGoodBack(guid,itemid,showType,num,args)
local itemcfg=itemsHelper:get_item_config(itemid)
local funcparam=itemcfg.funcparam
showType=showType or 1
num=num or 1
local isBroke=guid~=nil and UIDiscipleModel:checkDiscipleJJNeedBroke(guid)
if funcparam.exp and not isBroke then
local exp=funcparam.exp


local guidstr=tostring(guid)
local rate=DiscipleCoupleModel:getCoupleDzRate(guidstr)
local addExp=exp*(rate/100)

if guid~=nil then
exp=UIDiscipleModel:calculationJJMedicineGrow(guid,exp,itemid)
end
local freenum=0
local freerate=0
if args and args.freenum then
freenum=args.freenum
freerate=args.freerate
end

local sub=exp*num+math.floor(exp*(1+freerate/100)*freenum)+math.floor(addExp*num)
local str=FMT.fmt('+{0}修为',sub)
commonTipsHelper.addThrowOutAndSliderTips(showType,str)
end
if funcparam.attr6 then
for i,v in ipairs(funcparam.attr6)do
local exp=v[2]*num
local str=FMT.fmt('+{0}{1}',exp,UIDiscipleModel:getDiscipleBaseAttrName(v[1]))
commonTipsHelper.addThrowOutAndSliderTips(showType,str)
end
end
if funcparam.rate then
local exp=funcparam.rate*num
local str=FMT.fmt('+{0}%突破成功率',exp)
commonTipsHelper.addThrowOutAndSliderTips(showType,str)
end
end

function UIDiscipleModel:rateJJName(cond)
if cond then
local jingjie=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eJingjieLv,cond)
if jingjie then
local ceng=jingjie[2]+1
local jj_name=UIDiscipleModel:getJJName(ceng)
return jj_name
end
end
return'突破'
end

function UIDiscipleModel:checkJJReddot(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local jjlv=netData.jingjielv
return UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData)and UIDiscipleModel:checkNextJJNeedBroke(jjlv)and
UIDiscipleModel:checkJJBrokeByHand(jjlv)and UIDiscipleModel:checkJJAutoBrokeConditon(jjlv)and
UIDiscipleModel:checkJJAutoBrokeConditon3(jjlv)
end
return false
end

function UIDiscipleModel:checkJJReddotEx(guid)
local chuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
if not chuiwei and UIDiscipleModel:checkJJReddot(guid)then
return true
end
return false
end



























function UIDiscipleModel:findClosestJingJieDZ(jingjielv)
local all=UIDiscipleModel:getAllDiscipleData()
local guid=nil
local jjlv=-1
local jjexp=-1
local fight=-1
for k,v in pairs(all)do
local netData=v.netData.net
if jingjielv==nil or netData.jingjielv<jingjielv then
local guid_=netData.discipleguid
local chuiwei=UIDiscipleModel:checkDiscipleState2(guid_,DISCIPLE_STATE_TYPE.eChuiWei)
if not chuiwei then
if netData.jingjielv>jjlv then
jjlv=netData.jingjielv
jjexp=netData.jingjieexp
fight=UIDiscipleModel:getDiscipleFightValueEx(netData)
guid=guid_
elseif netData.jingjielv==jjlv then
if jingjielv~=nil then
if netData.jingjieexp>jjexp then
jjexp=netData.jingjieexp
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


function UIDiscipleModel:checkJJIsHasAfterTXCost(jjlv)
local cfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,jjlv)
if cfg and cfg.txtpItems then
return true
end
return false
end


function UIDiscipleModel:checkJJIsOverMaxFeiShengLv(jjlv)
local maxFeiShengLv=cfgHelper.get2(cfg_feishengtaiconfig_get,1,'maxFeiShengLv')
if maxFeiShengLv then
return jjlv>=maxFeiShengLv
end
return false
end


function UIDiscipleModel:checkJJBrokeNeedUseFeiShengTai(jjlv)
return not UIDiscipleModel:checkJJAutoBrokeConditon(jjlv)and not UIDiscipleModel:checkJJIsOverMaxFeiShengLv(jjlv)
end