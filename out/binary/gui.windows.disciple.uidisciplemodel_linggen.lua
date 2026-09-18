






function UIDiscipleModel:getDiscipleVarysrid(disciple_guid)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
if netData==nil then

netData=otherPlayerModel:getDZBaseData(disciple_guid)
end
return netData.varysrid
end


function UIDiscipleModel:getDiscipleHoard(disciple_guid)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)

local default={}
local pos={-1,-2,-3,-4,-5,1,2,3,4,5}
for k,v in pairs(pos)do
default[v]={
pos=v,
activelistlen=0,
}
end

for k,v in pairs(netData.hoardList or{})do
if v.pos>0 then
if self:checkHiddenSkillSlotUnlock(disciple_guid,v.pos)then
default[v.pos]=v
end
else
if self:checkDiscipleAssertVary(disciple_guid)then
default[v.pos]=v
end
end
end

return default
end

function UIDiscipleModel:getDiscipleHoardTotal(disciple_guid)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)

local default={}
local pos={-1,-2,-3,-4,-5,1,2,3,4,5}
for k,v in pairs(pos)do
default[v]={
pos=v,
activelistlen=0,
}
end

for k,v in pairs(netData.hoardList or{})do
default[v.pos]=v
end

return default
end

function UIDiscipleModel:getDiscipleHoardEx(disciple_guid)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
local varyid=self:getDiscipleVarysrid(disciple_guid)

local default={}
local pos={-1,-2,-3,-4,-5,1,2,3,4,5}
for k,v in pairs(pos)do
default[v]={
pos=v,
activelistlen=0,
}
end

for k,v in pairs(netData.hoardList or{})do
if v.pos>0 then
if self:checkHiddenSkillSlotUnlock(disciple_guid,v.pos)then
default[v.pos]=v
end
else
if varyid==Mathf.Abs(v.pos)then
if self:checkDiscipleAssertVary(disciple_guid)then
default[v.pos]=v
end
end
end
end

return default
end

function UIDiscipleModel:checkDiscipleHoardFree(disciple_guid,pos)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
local randlist,randpos,randlistlen=UIDiscipleModel:getDiscipleRandomHoard(disciple_guid)
for k,v in pairs(netData.hoardList or{})do
if v.pos==pos then
return false
end
end
return true and pos~=randpos
end

function UIDiscipleModel:getDiscipleRandomHoard(disciple_guid)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
return netData.randHoardList,netData.randhoardpos,netData.randhoardlistlen
end


function UIDiscipleModel:getDiscipleTotalLinggenLevel(disciple_guid)
local lglist=UIDiscipleModel:getDiscipleSpeciality(disciple_guid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
local totallv=0
if lglist then
local normalMaxLv=self:getLingGenAverageMaxLevel(disciple_guid)
local extra=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'extra')
local nowVarysrId=self:getDiscipleVarysrid(disciple_guid)
for k,v in pairs(lglist)do
local type=v.param_1
local actualLv=v.param_2
local maxLevel=normalMaxLv
if nowVarysrId==type then

maxLevel=normalMaxLv+extra
end
local lv=actualLv>maxLevel and maxLevel or actualLv
totallv=totallv+lv
end
end
return totallv
end

function UIDiscipleModel:checkLinggenVary(disciple_guid)
return self:getDiscipleVarysrid(disciple_guid)~=0
end

function UIDiscipleModel:checkHasVaryLinggen(disciple_guid)
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(disciple_guid)
for i,v in ipairs(lglist)do
if v.varyState>0 then

return true
end
end
return false
end

function UIDiscipleModel:getLingGenAverageMaxLevel(disciple_guid)
local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(disciple_guid))
local len=UIDiscipleModel:getDiscipleSpecialityLen(netData,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
if len>0 then
local max=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'max')
return max/len
end
return 0
end

function UIDiscipleModel:getLingGenTotalMaxLevel(disciple_guid)
local linggenBaseCfg=cfgHelper.get1(cfg_disciplespiritrootbaseconfig_get,1)
local varySrid=UIDiscipleModel:getDiscipleVarysrid(disciple_guid)


local maxTotalLv=linggenBaseCfg.max
local isAssertVary=self:checkDiscipleAssertVary(disciple_guid)
if varySrid>0 and isAssertVary then
maxTotalLv=maxTotalLv+linggenBaseCfg.extra
end
return maxTotalLv
end

function UIDiscipleModel:checkDiscipleAssertVary(disciple_guid)
local assertState=true

local openState=self:checkDiscipleOpenVary(disciple_guid)
assertState=assertState and openState
local varyid=self:getDiscipleVarysrid(disciple_guid)
if varyid>0 then
local canVaryState=self:checkDiscipleCanVary(disciple_guid)
assertState=assertState and canVaryState
end

return assertState
end

function UIDiscipleModel:checkDiscipleAssertVary2(netData)
local assertState=true

assertState=assertState and self:checkDiscipleOpenVary(netData.discipleguidStr)

local varyid=netData.varysrid
if varyid>0 then
local canVaryState=self:checkDiscipleCanVary(netData.discipleguidStr,varyid)
assertState=assertState and canVaryState
end

return assertState
end

function UIDiscipleModel:checkDiscipleOpenVary(disciple_guid)
local state=true

local linggenBaseCfg=cfgHelper.get1(cfg_disciplespiritrootbaseconfig_get,1)
local varyLevel=linggenBaseCfg.vary[2]
local curTotalLv=self:getDiscipleTotalLinggenLevel(disciple_guid)
state=state and curTotalLv>=varyLevel
return state
end

function UIDiscipleModel:checkDiscipleCanVary(disciple_guid,linggen_type)
linggen_type=linggen_type or self:getDiscipleVarysrid(disciple_guid)

local state=true
if linggen_type>0 then
local lgList,lgloopup=UIDiscipleModel:getDiscipleLingGenData(disciple_guid)
local linggenBaseCfg=cfgHelper.get1(cfg_disciplespiritrootbaseconfig_get,1)
local baseVaryLevel=linggenBaseCfg.vary[1]
local varyData=lgloopup[linggen_type]
state=state and varyData.lv>=baseVaryLevel
end
return state
end

function UIDiscipleModel:getDiscipleLingGenData(disciple_guid)
local lglist=UIDiscipleModel:getDiscipleSpeciality(disciple_guid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
local trans_lglist={}
local lookup_lglist={}
local len=0
if lglist then
len=#lglist
local normalMaxLv=self:getLingGenAverageMaxLevel(disciple_guid)
local extra=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'extra')
local nowVarysrId=self:getDiscipleVarysrid(disciple_guid)
for k,data in pairs(lglist)do
local len=data.param_0
local type=data.param_1
local actualLv=data.param_2
local varyState=data.param_3


local maxLevel=normalMaxLv
if nowVarysrId==type then

maxLevel=normalMaxLv+extra
end
local lv=actualLv>maxLevel and maxLevel or actualLv

local temp={
len=len,
type=type,
maxLevel=maxLevel,
actualLv=actualLv,
lv=lv,
varyState=varyState,
source=data
}

table.insert(trans_lglist,temp)

lookup_lglist[type]=temp
end
end
return trans_lglist,lookup_lglist,len
end

function UIDiscipleModel:getDiscipleLingGenData2(disciple_guid,type)
local lglist=UIDiscipleModel:getDiscipleSpeciality(disciple_guid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
for k,v in pairs(lglist)do
if v.param_1==type then
return v
end
end
end

function UIDiscipleModel:checkHiddenSkillSlotUnlock(disciple_guid,index)
local limit=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,"limit")
local linggenTotalLv=UIDiscipleModel:getDiscipleTotalLinggenLevel(disciple_guid)
if index>0 then
return linggenTotalLv>=limit[index]
else
return UIDiscipleModel:checkDiscipleAssertVary(disciple_guid)
end
end

function UIDiscipleModel:getDiscipleVaryTypeList(disciple_guid)
local lgList,lgLookup,lgLen=UIDiscipleModel:getDiscipleLingGenData(disciple_guid)

local hoards=UIDiscipleModel:getDiscipleHoard(disciple_guid)

local list={}

for index=1,5,1 do
local lgData=lgLookup[index]
local type=-index
if lgData and lgData.varyState==1 and hoards[type]and hoards[type].activelistlen>0 then
list[#list+1]=type
end
end

return list
end




function UIDiscipleModel:checkDiscipleStrengthenLingGenReddot(dzguid)
if not systemModel.isOpen(SYSTEM_DEFINE.eSpiritRootStrengthen)then
return false
end
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(dzguid)
for k,data in pairs(lglist)do
local state=UIDiscipleModel:checkDiscipleStrengthenLingGenReddotByLgdata(dzguid,data)
if state then
return true
end
end
return false
end

function UIDiscipleModel:checkDiscipleStrengthenLingGenReddotByLgdata(dzguid,Lgdata)
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(dzguid)
local extraLv=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'extra')
local varySrid=UIDiscipleModel:getDiscipleVarysrid(dzguid)
local averageMaxLv=UIDiscipleModel:getLingGenAverageMaxLevel(dzguid)

local totalLv=Lgdata.type==varySrid and averageMaxLv+extraLv or averageMaxLv
if totalLv>Lgdata.lv then
local nextLvCost=cfgHelper.get4(cfg_disciplespiritrootlevelconfig_get,lglen,Lgdata.type,Lgdata.lv,'consume')
local state=true
for _,v in pairs(nextLvCost)do
local itemid=v[1]
local needNum=v[2]
local hasNum=itemsModel.getCount(itemid)
state=hasNum>=needNum and state
end
if state then
return true
end
end
return false
end


function UIDiscipleModel:checkDiscipleVaryLingGenReddot(dzguid)
if not systemModel.isOpen(SYSTEM_DEFINE.eVarySpriteRoot)then
return false
end
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(dzguid)
local vary=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'vary')
local totalLv=UIDiscipleModel:getDiscipleTotalLinggenLevel(dzguid)
local varySrid=UIDiscipleModel:getDiscipleVarysrid(dzguid)
local conditionState=false
local cunsumeState=true


return conditionState and cunsumeState
end


function UIDiscipleModel:checkDiscipleCanEquipHoardReddot(dzguid)
local hoardDatas=UIDiscipleModel:getDiscipleHoard(dzguid)
local limit=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'limit')
local totalLv=UIDiscipleModel:getDiscipleTotalLinggenLevel(dzguid)
local varySrid=UIDiscipleModel:getDiscipleVarysrid(dzguid)
local state=false
local cosumeState=UIDiscipleModel:checkDiscipleCanFindHoardReddot(dzguid)
for k,v in pairs(limit)do
if totalLv>=v then
local data=hoardDatas[k]
local isfree=UIDiscipleModel:checkDiscipleHoardFree(dzguid,k)
state=(data==nil or data.activelistlen==0)and(cosumeState or isfree)
if state then
break
end
end
end
if varySrid>0 then
local data=hoardDatas[-varySrid]
local isfree=UIDiscipleModel:checkDiscipleHoardFree(dzguid,-varySrid)
state=(data==nil or data.activelistlen==0)and(cosumeState or isfree)
end

return state
end


function UIDiscipleModel:checkDiscipleCanFindHoardReddot(disciple_guid)
local findConsume=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'search')

local state=true
for k,v in pairs(findConsume)do
local itemid=v[1]
local needNum=v[2]
local hasNum=itemsModel.getCount(itemid)
state=state and hasNum>=needNum
if not state then
break
end
end

return state
end





function UIDiscipleModel:getDiscipleLingGenSkillLevelAddList(guid)
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleRealLevelLinggenData(guid)

local jobSkillList={}
local extraSkillList={}
local gongfaSkillList={}

for k,lgdata in pairs(lglist)do
local lgLvCfg=cfgHelper.get3(cfg_disciplespiritrootlevelconfig_get,lglen,lgdata.type,lgdata.lv)
if lgLvCfg.bonus~=nil then
for k,v in pairs(lgLvCfg.bonus)do
if jobSkillList[k]==nil then
jobSkillList[k]=v
else
jobSkillList[k]=v+jobSkillList[k]
end
end
end

if lgLvCfg.skill~=nil then
local skillid=lgLvCfg.skill[1]
local skilllv=lgLvCfg.skill[2]

if extraSkillList[skillid]==nil then
extraSkillList[skillid]=skilllv
else
extraSkillList[skillid]=extraSkillList[skillid]+skilllv
end
end
end

local varySrid=UIDiscipleModel:getDiscipleVarysrid(guid)
if varySrid>0 then
local varyLgData=lglist_lookup[varySrid]
local varyCfg=cfgHelper.get2(cfg_disciplespiritrootvaryconfig_get,lglen,varyLgData.type)

if varyCfg and varyCfg.skill then
local skillid=varyCfg.skill[1]
local skilllv=varyCfg.skill[2]

if extraSkillList[skillid]==nil then
extraSkillList[skillid]=skilllv
else
extraSkillList[skillid]=extraSkillList[skillid]+skilllv
end
end
end

local hoardDatas=UIDiscipleModel:getDiscipleHoardEx(guid)
for k,hdata in pairs(hoardDatas)do
if hdata.activelistlen>0 and UIDiscipleModel:checkHoardLockState(guid,hdata.pos)then
local pdata=hdata.activeList[1]
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,pdata.hoardid)

if hoardCfg.gongfa~=nil then
for skillid,addlv in pairs(hoardCfg.gongfa)do
if gongfaSkillList[skillid]==nil then
gongfaSkillList[skillid]=addlv
else
gongfaSkillList[skillid]=gongfaSkillList[skillid]+addlv
end
end
end
end
end

return jobSkillList,extraSkillList,gongfaSkillList
end

function UIDiscipleModel:getDiscipleLingGenGFSkillAddList(guid)
local gongfaSkillList={}

local hoardDatas=UIDiscipleModel:getDiscipleHoardEx(guid)
for k,hdata in pairs(hoardDatas)do
if hdata.activelistlen>0 and UIDiscipleModel:checkHoardLockState(guid,hdata.pos)then
local pdata=hdata.activeList[1]
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,pdata.hoardid)
local isAssert=self:checkHiddenSkillAssert(guid,pdata.hoardid)
if hoardCfg.gongfa~=nil and isAssert then
for skillid,addlv in pairs(hoardCfg.gongfa)do
if gongfaSkillList[skillid]==nil then
gongfaSkillList[skillid]=addlv
else
gongfaSkillList[skillid]=gongfaSkillList[skillid]+addlv
end
end
end
end
end

return gongfaSkillList
end

function UIDiscipleModel:getDiscipleLingGenSkillAddList(guid)
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleRealLevelLinggenData(guid)

local extraSkillList={}

for k,lgdata in pairs(lglist)do
local lgLvCfg=cfgHelper.get3(cfg_disciplespiritrootlevelconfig_get,lglen,lgdata.type,lgdata.lv)
if lgLvCfg.skill~=nil then
local skillid=lgLvCfg.skill[1]
local skilllv=lgLvCfg.skill[2]

if extraSkillList[skillid]==nil then
extraSkillList[skillid]=skilllv
else
extraSkillList[skillid]=extraSkillList[skillid]+skilllv
end
end
end

local varySrid=UIDiscipleModel:getDiscipleVarysrid(guid)
if varySrid>0 then
local varyLgData=lglist_lookup[varySrid]
local varyCfg=cfgHelper.get2(cfg_disciplespiritrootvaryconfig_get,lglen,varyLgData.type)
if varyCfg and varyCfg.skill then
local skillid=varyCfg.skill[1]
local skilllv=varyCfg.skill[2]

if extraSkillList[skillid]==nil then
extraSkillList[skillid]=skilllv
else
extraSkillList[skillid]=extraSkillList[skillid]+skilllv
end
end
end

local hoardDatas=UIDiscipleModel:getDiscipleHoardEx(guid)
for k,hdata in pairs(hoardDatas)do
if hdata.activelistlen>0 and UIDiscipleModel:checkHoardLockState(guid,hdata.pos)then
local pdata=hdata.activeList[1]
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,pdata.hoardid)
if hoardCfg.skillid and hoardCfg.skilllv and pdata.skilllv>0 then
local skillid=hoardCfg.skillid
local skilllv=pdata.skilllv

if extraSkillList[skillid]==nil then
extraSkillList[skillid]=skilllv
else
extraSkillList[skillid]=extraSkillList[skillid]+skilllv
end
end
end
end

return extraSkillList
end

function UIDiscipleModel:getHoardRecordQualityIcon(quality)
return FMT.fmt('image_linggen_card{0}',quality),FMT.fmt('ui/windows/disciple/sharedtextures/linggenhoardqualitycard{0}.ab',quality)
end

function UIDiscipleModel:checkHoardLockState(dzguid,index)
local state
if index>0 then
local totalLv=UIDiscipleModel:getDiscipleTotalLinggenLevel(dzguid)
local limit=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'limit')
state=totalLv>=limit[index]
elseif index<0 then
local varySrid=UIDiscipleModel:getDiscipleVarysrid(dzguid)
state=varySrid~=0 and-varySrid==index
end
return state
end

function UIDiscipleModel:getDiscipleHoardDesc(data)
local desc
local boardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.hoardid)
if data.skilllv>0 then
desc=skillModel:getSkillDesc(boardCfg.skillid,data.skilllv)
else
if data.len2>0 then
for k,v in pairs(data.list2)do
local str=helper.getAttributeStr(v.param_1,v.param_2,1,"{0}+{1}")
if desc then
desc=FMT.fmt('{0}\n{1}',desc,str)
else
desc=str
end
end
end
if boardCfg.gongfa~=nil then
local gfname=cfgHelper.get2(cfg_disciplegongfaconfig_get,boardCfg.gongfaid,'name')
for k,v in pairs(boardCfg.gongfa)do
local jnname=cfgHelper.get2(cfg_skillconfig_get,k,'name')
local str=FMT.fmt('{0}功法技能"{1}"等级+{2}',gfname,jnname,v)
if desc then
desc=FMT.fmt('{0}\n{1}',desc,str)
else
desc=str
end
end
end
end
return desc
end

local qualityNameColorList={
[1]='#ffefa4',
[2]='#c8ffac',
[3]='#c5ebff',
[4]='#ffe0e0',
[5]='#ffd1a0',
}
function UIDiscipleModel:getLingGenTypeNameColor(quality)
local qualityNameColorList=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'qualityNameColorList')
return qualityNameColorList[quality]
end

local hoardNameColorList={
[1]='#2f7322',
[2]='#225573',
[3]='#552273',
[4]='#734c22',
[5]='#732222',
[6]='#2c1b84'
}
function UIDiscipleModel:getHoardNameColor(quality)
local hoardNameColorList=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'hoardNameColorList')
return hoardNameColorList[quality]
end

function UIDiscipleModel:getHoardAblationEffectIdByQuality(quality)
local hoardablationeffectlist=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'hoardablationeffectlist')
return hoardablationeffectlist[quality]
end

local checkCondition=function(condition,data,totallv)
for k,v in pairs(condition)do
if v[1]==1 and v[2]>data.lv then
return false
elseif v[1]==2 and v[2]>totallv then
return false
end
end
return true
end

function UIDiscipleModel:getPreViewHoardList(disciple_guid,isAddAll,isShowVary)
local lglist=UIDiscipleModel:getDiscipleLingGenData(disciple_guid)
local varySrid=UIDiscipleModel:getDiscipleVarysrid(disciple_guid)
local totallv=UIDiscipleModel:getDiscipleTotalLinggenLevel(disciple_guid)
local lgtypelist={}
local hoardList={}
local hoardList_loop={}

if isAddAll then
table.insert(lgtypelist,{type=0,showVary=0})
end

for k,lgdata in pairs(lglist)do

if lgdata.lv>0 then
local showVary=isShowVary and 1 or 0
local randomBoardCfg=cfgHelper.get2(cfg_disciplespiritroothoardrandconfig_get,showVary,lgdata.type)
local libtemp
if randomBoardCfg then
for k,rv in pairs(randomBoardCfg.lib)do
local condition=rv[1]
if checkCondition(condition,lgdata,totallv)then
libtemp=rv[2]
else
break
end
end
end

if libtemp then
hoardList[lgdata.type]={}
if(isShowVary and lgdata.type==varySrid)or(not isShowVary)then
table.insert(lgtypelist,{type=lgdata.type,showVary=showVary})
for _,data in pairs(libtemp)do
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data[1])
if hoardCfg then
local pfcfg=pfwindowsModel:getVersionAndPfCfg_2(hoardCfg.hide and hoardCfg.hide or{})
if not pfcfg then
if#hoardCfg.element>1 then
if not hoardList[ELEMENT_TYPE.eVaryYu]then
hoardList[ELEMENT_TYPE.eVaryYu]={}
table.insert(lgtypelist,{type=ELEMENT_TYPE.eVaryYu,showVary=0})
end
if not hoardList_loop[hoardCfg.id]then
table.insert(hoardList[ELEMENT_TYPE.eVaryYu],hoardCfg)
hoardList_loop[hoardCfg.id]=true
end
else
if not hoardList_loop[hoardCfg.id]then
table.insert(hoardList[lgdata.type],hoardCfg)
hoardList_loop[hoardCfg.id]=true
end
end
end
end
end
end
end
end
end

if isAddAll then
local temp={}
for k,v in pairs(hoardList)do
for kk,vv in pairs(v)do
table.insert(temp,vv)
end
end
hoardList[0]=temp
end

table.sort(lgtypelist,function(a,b)
return a.type<b.type
end)

return lgtypelist,hoardList
end



function UIDiscipleModel:getTipsSwitch(tip_type)
if not self.linggen_tips_switch then
self.linggen_tips_switch={}
end
return self.linggen_tips_switch[tip_type]==true
end

function UIDiscipleModel:setTipsSwitch(tip_type,state)
if not self.linggen_tips_switch then
self.linggen_tips_switch={}
end

self.linggen_tips_switch[tip_type]=state
end


function UIDiscipleModel:getDiscipleCount_linggenLevel(level)
local c=0
local all=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(all)do
local netData=v.netData.net
local lv=UIDiscipleModel:getDiscipleTotalLinggenLevel(netData.discipleguid)
if lv>=level then
c=c+1
end
end
return c
end


function UIDiscipleModel:findClosestLinggenLvDZ(lglevel)
local all=UIDiscipleModel:getAllDiscipleData()
local guid=nil
local lglv=-1
local fight=-1
for k,v in pairs(all)do
local netData=v.netData.net
if not UIDiscipleModel:isShuWuDisciple(netData.id)then
local guid_=netData.discipleguid
local lglv_=UIDiscipleModel:getDiscipleTotalLinggenLevel(guid_)
if lglevel==nil or lglv_<lglevel then
local chuiwei=UIDiscipleModel:checkDiscipleState2(guid_,DISCIPLE_STATE_TYPE.eChuiWei)
if not chuiwei then
if lglv_>lglv then
lglv=lglv_
fight=UIDiscipleModel:getDiscipleFightValueEx(netData)
guid=guid_
elseif lglv_==lglv then
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

function UIDiscipleModel:getDiscipleHoardEffectBySkillId(disciple_guid,skill_id)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
if not netData then return{}end

local hoardList=self:getDiscipleHoardEx(disciple_guid)
local varyid=UIDiscipleModel:getDiscipleVarysrid(disciple_guid)
local tempList={}

for pos,boardListData in pairs(hoardList)do
if pos>0 or Mathf.Abs(pos)==varyid then
for index=1,boardListData.activelistlen do
local boardData=boardListData.activeList[index]
local hoardId=boardData.hoardid
local hoardLevel=Mathf.Max(boardData.skilllv,1)
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,hoardId)
if hoardCfg.additionskillid and hoardCfg.additionskillid==skill_id and hoardCfg.skillid~=nil then
local skillId=hoardCfg.skillid
local list=skillModel:getSkillGiveStateList(skillId,hoardLevel)
tempList=table.concatTable(tempList,list)
end
end
end
end
return tempList
end

function UIDiscipleModel:getDiscipleHoardDescBySkillId(disciple_guid,skill_id)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
if not netData then return{}end
local hoardList=self:getDiscipleHoardEx(disciple_guid)
local varyid=UIDiscipleModel:getDiscipleVarysrid(disciple_guid)

local descList={}

for pos,boardListData in pairs(hoardList)do
if pos>0 or Mathf.Abs(pos)==varyid then
for index=1,boardListData.activelistlen do
local boardData=boardListData.activeList[index]
local hoardId=boardData.hoardid
local hoardLevel=Mathf.Max(boardData.skilllv,1)
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,hoardId)
if hoardCfg.additionskillid and hoardCfg.additionskillid==skill_id then
local gf_descParams=hoardCfg.gf_descParams[hoardLevel]or{}
local params=gf_descParams[1]or{}
local desc=FMT.fmt(hoardCfg.gf_desc[1][1],unpack(params))
table.insert(descList,desc)
end
end
end
end
return descList
end

function UIDiscipleModel:getDiscipleRealLevelLinggenData(disciple_guid)
local lglist,lgloopup,len=self:getDiscipleLingGenData(disciple_guid)
local averageLv=self:getLingGenAverageMaxLevel(disciple_guid)
local isOpenVary=self:checkDiscipleOpenVary(disciple_guid)

if not isOpenVary then
for k,lgData in pairs(lglist)do
lgData.lv=Mathf.Min(averageLv,lgData.lv)
end
end

return lglist,lgloopup,len
end

function UIDiscipleModel:checkHiddenSkillAssert(disciple_guid,hskill_id)
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,hskill_id)
local result=UIDiscipleModel:getDiscipleStudyGFSkillList(disciple_guid)
if hoardCfg.additionskillid~=nil and hoardCfg.gongfaid then
if table.containsValue(result,hoardCfg.gongfaid)then
return true
end
else
return true
end
return false
end

local _lgmeta={
__index=function(t,key)
local isVary=rawget(t,'isVary')
if isVary then
local varyCfg=rawget(t,'varyCfg')
if varyCfg~=nil then
local ret=varyCfg[key]
if ret~=nil then
return ret
end
end
end

local baseCfg=rawget(t,'baseCfg')
if baseCfg~=nil then
local ret=baseCfg[key]
if ret~=nil then
return ret
end
end

return rawget(t,key)
end
}
function UIDiscipleModel:getLinggenSpecialCfg(type,isVary)
local temp={}

temp.isVary=isVary
temp.baseCfg=cfgHelper.get1(cfg_disciplespiritrootconfig_get,type)
temp.varyCfg=cfgHelper.get1(cfg_disciplespiritroottypeconfig_get,type)

return setmetatable(temp,_lgmeta)
end

function UIDiscipleModel:resetHiddenSkill(disciple_guid,giveuppos)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
for k,v in pairs(netData.hoardList or{})do
if v.pos==giveuppos then
v.activelistlen=0
v.activeList={}
end
end


UIDiscipleController.refreshDiscipleLingGenEffect(disciple_guid)
end

function UIDiscipleModel:getDiscipleLinggenVaryElement(disciple_guid)
local varyId=UIDiscipleModel:getDiscipleVarysrid(disciple_guid)
local varyCfg=UIDiscipleModel:getLinggenSpecialCfg(varyId,true)
return varyCfg.element
end

function UIDiscipleModel:checkRankBoardMutexOtherSlot(disciple_guid,rankIdx)
local randlist,randpos,randlistlen=UIDiscipleModel:getDiscipleRandomHoard(disciple_guid)
local rankHoardData=randlist[rankIdx]
local dzHoardDataList=UIDiscipleModel:getDiscipleHoardEx(disciple_guid)

local rankGroup=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,rankHoardData.hoardid,'group')

for pos,data in pairs(dzHoardDataList)do
if data.activelistlen>0 then
local hoardData=data.activeList[1]
local group=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,hoardData.hoardid,'group')
if rankGroup==group then
return true,data,rankHoardData
end
end
end

return false
end

function UIDiscipleModel:clearDiscipleRankHoardData(disciple_guid)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
if not netData then
logErr("清除弟子随机秘藏数据，弟子数据丢失")
return
end

netData.randhoardlistlen=0
netData.randhoardpos=0
netData.randHoardList=nil
end


function UIDiscipleModel:initHiddenSkillLookup()
self.hiddenSkillLookup_Common_GF={}
self.hiddenSkillLookup_Group={sortStateLoolup={}}
self.hiddenSkillLookup_Common={}
self.hiddenSkillLookup_Vary={sortStateLoolup={}}
self.hiddenSkillLoopup_Vary_GF={}
self.hiddenSkillLoopup_Vary_Element={}
self.hiddenSkillLoopup_AdditionSkill_GF={sortStateLoolup={}}
self.hiddenSkillLookup_Vary_Common={}


local allHiddenSkillCfg=cfg_disciplespiritroothoardconfig()

local gfid,gfInfo,gfGroup,gfTotalGroup,gfCommonGroup,gfVaryGroup
local group
local isCommom,commonGroup,commonTotalGroup
local isVary,element,varyGroup,varyGfId,varyGfInfo,varyHSCInfo
local varyElemntGroup,elementGroup
local additionGroup,additionSkillGroup
local commonVaryGroup
for id,cfg in pairs(allHiddenSkillCfg)do

group=self.hiddenSkillLookup_Group[cfg.group]or{}
self.hiddenSkillLookup_Group[cfg.group]=group
group[#group+1]=cfg


isCommom=#cfg.element>1
if isCommom then
commonGroup=self.hiddenSkillLookup_Common[cfg.group]or{}
self.hiddenSkillLookup_Common[cfg.group]=commonGroup
commonGroup[#commonGroup+1]=cfg

commonTotalGroup=self.hiddenSkillLookup_Common[0]or{}
self.hiddenSkillLookup_Common[0]=commonTotalGroup
commonTotalGroup[#commonTotalGroup+1]=cfg
end


element=cfg.element[1]
isVary=ELEMENT_TYPE:isVary(element)
if isVary then
varyGroup=self.hiddenSkillLookup_Vary[cfg.group]or{}
self.hiddenSkillLookup_Vary[cfg.group]=varyGroup
varyGroup[#varyGroup+1]=cfg

varyGfId=cfg.gongfaid or 0
varyGfInfo=self.hiddenSkillLoopup_Vary_GF[varyGfId]or{}
self.hiddenSkillLoopup_Vary_GF[varyGfId]=varyGfInfo
varyGfInfo[#varyGfInfo+1]=cfg

if varyGfId==0 then
commonVaryGroup=self.hiddenSkillLookup_Vary_Common[cfg.group]or{}
self.hiddenSkillLookup_Vary_Common[cfg.group]=commonVaryGroup
commonVaryGroup[#commonVaryGroup+1]=cfg
end

varyElemntGroup=self.hiddenSkillLoopup_Vary_Element[element]or{}
self.hiddenSkillLoopup_Vary_Element[element]=varyElemntGroup
elementGroup=varyElemntGroup[cfg.group]or{}
varyElemntGroup[cfg.group]=elementGroup
elementGroup[#elementGroup+1]=cfg
end


gfid=cfg.gongfaid or 0

gfInfo=self.hiddenSkillLookup_Common_GF[gfid]or{}
self.hiddenSkillLookup_Common_GF[gfid]=gfInfo

gfGroup=gfInfo[cfg.group]or{}
gfInfo[cfg.group]=gfGroup


gfCommonGroup=gfGroup[0]or{}
gfGroup[0]=gfCommonGroup

gfVaryGroup=gfGroup[1]or{}
gfGroup[1]=gfVaryGroup

if isVary then
gfVaryGroup[#gfVaryGroup+1]=cfg
else
gfCommonGroup[#gfCommonGroup+1]=cfg
end

gfTotalGroup=gfInfo[0]or{}
gfInfo[0]=gfTotalGroup

gfCommonGroup=gfTotalGroup[0]or{}
gfTotalGroup[0]=gfCommonGroup

gfVaryGroup=gfTotalGroup[1]or{}
gfTotalGroup[1]=gfVaryGroup

if isVary then
gfVaryGroup[#gfVaryGroup+1]=cfg
else
gfCommonGroup[#gfCommonGroup+1]=cfg
end


if cfg.additionskillid~=nil then
additionGroup=self.hiddenSkillLoopup_AdditionSkill_GF[cfg.additionskillid]or{}
self.hiddenSkillLoopup_AdditionSkill_GF[cfg.additionskillid]=additionGroup

additionSkillGroup=additionGroup[cfg.group]or{}
additionGroup[cfg.group]=additionSkillGroup
additionSkillGroup[#additionSkillGroup+1]=cfg
end
end
end

function UIDiscipleModel:get_hiddenSkillLookup_Common_GF()
return self.hiddenSkillLookup_Common_GF
end

function UIDiscipleModel:get_hiddenSkillLookup_Common()
if not self.hiddenSkillLookup_Common_SortState then
for groupid,group in pairs(self.hiddenSkillLookup_Common)do
table.sort(group,function(a,b)
return a.color>b.color
end)
end
self.hiddenSkillLookup_Common_SortState=true
end
return self.hiddenSkillLookup_Common
end

function UIDiscipleModel:get_hiddenSkillLookup_Vary_Common()
if not self.hiddenSkillLookup_Vary_Common_SortState then
for groupid,group in pairs(self.hiddenSkillLookup_Vary_Common)do
table.sort(group,function(a,b)
return a.color>b.color
end)
end
self.hiddenSkillLookup_Vary_Common_SortState=true
end
return self.hiddenSkillLookup_Vary_Common
end

function UIDiscipleModel:get_hiddenSkillLookup_Vary()
return self.hiddenSkillLookup_Vary or{}
end

function UIDiscipleModel:get_hiddenSkillLookup_Group()
return self.hiddenSkillLookup_Group
end

function UIDiscipleModel:get_hiddenSkillLookup_Vary_GF()
return self.hiddenSkillLoopup_Vary_GF
end

function UIDiscipleModel:get_hiddenSkillLoopup_Vary_Element()
return self.hiddenSkillLoopup_Vary_Element
end

function UIDiscipleModel:get_hiddenSkillGroup_GFID(gfid)
return self.hiddenSkillLookup_Common_GF[gfid]
end

function UIDiscipleModel:get_hiddenSkillGroup_AdditionSkill_SkillID(skillid)
local lookup=self.hiddenSkillLoopup_AdditionSkill_GF
local additionGroup=lookup[skillid]

if additionGroup==nil then return end

if not lookup.sortStateLoolup[skillid]then
for group,data in pairs(additionGroup)do
table.sort(data,function(a,b)
return a.color>b.color
end)
end
lookup.sortStateLoolup[skillid]=true
end

return additionGroup
end
function UIDiscipleModel:get_hiddenSkillGroup_GroupID(groupid)
local lookup=self.hiddenSkillLookup_Group
local hiddenGroup=lookup[groupid]

if hiddenGroup==nil then return end

if not lookup.sortStateLoolup[groupid]then
table.sort(hiddenGroup,function(a,b)
return a.color>b.color
end)
lookup.sortStateLoolup[groupid]=true
end

return hiddenGroup
end

function UIDiscipleModel:get_varyHiddenSkillGroup_GroupID(groupid)
local lookup=self.hiddenSkillLookup_Vary
local hiddenGroup=lookup[groupid]

if hiddenGroup==nil then return end

if not lookup.sortStateLoolup[groupid]then
table.sort(hiddenGroup,function(a,b)
return a.color>b.color
end)
lookup.sortStateLoolup[groupid]=true
end

return hiddenGroup
end

function UIDiscipleModel:get_Common_HiddenSkillLookUp(discipleGuid)
local lgList,lgLookup=UIDiscipleModel:getDiscipleLingGenData(discipleGuid)

local list=self.hiddenSkillLookup_Common_GF[0][0]
local group={}

local isAdd
for index,cfg in ipairs(list)do
isAdd=false
for _,element in ipairs(cfg.element)do
if lgLookup[element]~=nil then
isAdd=true
break
end
end
if isAdd then
group[#group+1]=cfg
end
end

return group
end


function UIDiscipleModel:get_Common_HiddenSkillLookUp_Color(discipleGuid)
local lgList,lgLookup=UIDiscipleModel:getDiscipleLingGenData(discipleGuid)

local list=self.hiddenSkillLookup_Common_GF[0][0]
local group={}

local isAdd,subGroup
for index,cfg in ipairs(list)do
isAdd=false
for _,element in ipairs(cfg.element)do
if lgLookup[element]~=nil then
isAdd=true
break
end
end
if isAdd then
subGroup=group[cfg.group]or{}
group[cfg.group]=subGroup
subGroup[#subGroup+1]=cfg
end
end


for group,subGroup in pairs(group)do
table.sort(subGroup,function(a,b)
return a.color>b.color
end)
end

return group
end


function UIDiscipleModel:get_Vary_Common_HiddenSkillLookUp_Color(discipleGuid)
local varyElement=UIDiscipleModel:getDiscipleLinggenVaryElement(discipleGuid)

local list=self.hiddenSkillLoopup_Vary_GF[0]
local group={}

local eindex,element,subGroup
for index,cfg in ipairs(list)do
eindex,element=next(cfg.element)
if element==varyElement then
subGroup=group[cfg.group]or{}
group[cfg.group]=subGroup
subGroup[#subGroup+1]=cfg
end
end

for group,subGroup in pairs(group)do
table.sort(subGroup,function(a,b)
return a.color>b.color
end)
end

return group
end


local conditionTypeEnum={
curLgLv=1,
totalLv=2,
}

local conditionCheckFunc={
[conditionTypeEnum.curLgLv]=function(condition,data,args)
local needLv=condition[2]
local curLv=data.lv
return curLv>=needLv
end,
[conditionTypeEnum.totalLv]=function(condition,data,args)
local needLv=condition[2]
return args.totalLv>=needLv
end,
}

function UIDiscipleModel:getHiddenSkillRandomList(disciple_guid,isVary)
local lookup={}

local conditionArgs={}

local varyVal=isVary and 1 or 0

conditionArgs.totalLv=self:getDiscipleTotalLinggenLevel(disciple_guid)

local tlist,lookup_lg,len=UIDiscipleModel:getDiscipleLingGenData(disciple_guid)

local lgdata,lib,condition_s,mcData_s,isPass,conditionType,conditionCheckFunc_m,mcData_id
for index=1,len do
lgdata=tlist[index]
lib=cfgHelper.get3(cfg_disciplespiritroothoardrandconfig_get,varyVal,lgdata.type,'lib')
for _,slib in ipairs(lib)do
isPass=true
condition_s=slib[1]
mcData_s=slib[2]

for _,condition in ipairs(condition_s)do
conditionType=condition[1]
conditionCheckFunc_m=conditionCheckFunc[conditionType]
if conditionCheckFunc_m then
if not conditionCheckFunc_m(condition,lgdata,conditionArgs)then
isPass=false
break
end
else



end
end

if isPass then
for _,mcData in ipairs(mcData_s)do
mcData_id=mcData[1]
lookup[mcData_id]=1
end
end
end
end

return lookup
end


local autoFindConditionTypeEnum={
totalLv=1,
}

local autoFindConditionCheckFunc={
[autoFindConditionTypeEnum.totalLv]=function(condition,args)
local needLv=condition[2]
return args.totalLv>=needLv
end,
}
function UIDiscipleModel:checkDiscipleCanAutoFindHiddenSkill(disciple_guid)
local autoFindCondition=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'autoFindCondition')
local conditionArgs={}
conditionArgs.totalLv=self:getDiscipleTotalLinggenLevel(disciple_guid)

local isOpen=true

local conditionType,conditionCheckFunc_m
for index,condition in ipairs(autoFindCondition)do
conditionType=condition[1]
conditionCheckFunc_m=autoFindConditionCheckFunc[conditionType]
if conditionCheckFunc_m then
if not conditionCheckFunc_m(condition,conditionArgs)then
isOpen=false
end
end
end

return isOpen
end



function UIDiscipleModel:getDiscipleCanFindHiddenSkill_Element_List(disciple_guid)
local elementlist={}

local baseLv=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'findHiddenSkillBaseLv')
local lglist,lgLookup=UIDiscipleModel:getDiscipleLingGenData(disciple_guid)

for index,lgData in ipairs(lglist)do
if lgData.lv>=baseLv then
elementlist[#elementlist+1]=lgData.type
end
end

return elementlist
end


function UIDiscipleModel:getUseItemList(discipleGuid,pos)
local itemlist=cfgHelper.getdef1(cfg_disciplespiritroothoardrandconfig,'item')
local useitemlist={}
for itemid,condition in pairs(itemlist)do
local hasnum=itemsModel.getCount(itemid)
if hasnum>0 then
local colorVal=itemsConfig.getItemColor(itemid)
local isCanUse,errParams=self:checkItemUse(itemid,pos,discipleGuid)
local widget=isCanUse and 100 or 0
widget=widget+colorVal
table.insert(useitemlist,{itemid=itemid,itemcount=hasnum,widget=widget,isCanUse=isCanUse,errParams=errParams,condition=condition})
end
end
if#useitemlist>1 then
table.sort(useitemlist,function(a,b)
if a.widget==b.widget then
return a.itemid>b.itemid
else
return a.widget>b.widget
end
end)
end
return useitemlist
end

function UIDiscipleModel:checkItemUse(itemId,pos,discipleGuid)
local lglist,lglist_lookup,lglist_len=UIDiscipleModel:getDiscipleLingGenData(discipleGuid)
local itemlist=cfgHelper.getdef1(cfg_disciplespiritroothoardrandconfig,'item')
local condition=itemlist[itemId]
if condition then
local errParams
local ret=true

if condition.vary==1 then

ret=pos<0
else

ret=pos>0
end
if not ret then
errParams={
errorType=1,
varyFlag=condition.vary,
}
return ret,errParams
end


if condition.srid~=nil then
ret=lglist_lookup[condition.srid]~=nil
if not ret then
errParams={
errorType=2,
srid=condition.srid,
}
return ret,errParams
end
end


if condition.srlv then
local st=true
if condition.srid~=nil then
local lgdata=lglist_lookup[condition.srid]
if lgdata then
st=lgdata.lv>=condition.srlv
else
st=false
end
else
local totallv=UIDiscipleModel:getDiscipleTotalLinggenLevel(discipleGuid)
st=st and totallv>=condition.srlv
end

ret=ret and st
if not ret then
errParams={
errorType=3,
srid=condition.srid,
srlv=condition.srlv,
}
return ret,errParams
end
end

return ret
else
return false
end
end


function UIDiscipleModel:initHoardLib(discipleGuid,hoardID)

end

function UIDiscipleModel:checkHoardCanUse(discipleGuid,hoardID,isVary)
local lookup=UIDiscipleModel:getHiddenSkillRandomList(discipleGuid,isVary)
if lookup==nil then return false end

return lookup[hoardID]~=nil
end


function UIDiscipleModel:getPosSlotName_linggen(pos)
if pos>0 then
return FMT.fmt("{0}号普通秘藏",pos)
else
local type=-pos
local varyCfg=UIDiscipleModel:getLinggenSpecialCfg(type,true)
local elementName=varyCfg.elementname
return FMT.fmt("变异秘藏·{0}",elementName)
end
end
