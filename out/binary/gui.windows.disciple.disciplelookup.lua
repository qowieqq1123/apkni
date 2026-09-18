







discipleLookup={}


discipleLookup.confgs={
jjbackeffectID=10001,
ltbackeffectID=10002,
ltbrokeeffectID=10013,
jjbackeffectID2=20256,
}

local table_insert=table.insert
local table_sort=table.sort

local discipleJobLookup=nil
local jobskilllvlookup=nil
local jobImageLookup=nil

local sortFunctionLookup={
[eDiscipleSortType.eFightSort]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleFightValueEx(a.netData.net)
local vb=UIDiscipleModel:getDiscipleFightValueEx(b.netData.net)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eJingJieSort]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=a.netData.net.jingjielv
local vb=b.netData.net.jingjielv
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eLianTiSort]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local check1=UIDiscipleModel:isShuWuDisciple(a.netData.net.id)
local check2=UIDiscipleModel:isShuWuDisciple(b.netData.net.id)
if check1 and not check2 then
return false
elseif not check1 and check2 then
return true
end
local va=a.netData.net.liantilv
local vb=b.netData.net.liantilv
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eColorSort]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleImageInfoEx(a.netData.net).color
local vb=UIDiscipleModel:getDiscipleImageInfoEx(b.netData.net).color
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.ePostSort]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDisciplePostEX(a.netData.net)
local vb=UIDiscipleModel:getDisciplePostEX(b.netData.net)
return discipleLookup:commonSortDisciple(va,vb,a,b,not sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eFuShang]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleInjury(a.netData.net.discipleguid)
local vb=UIDiscipleModel:getDiscipleInjury(b.netData.net.discipleguid)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eShouYuan]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleShouYuan(a.netData.net.discipleguid,true)
local vb=UIDiscipleModel:getDiscipleShouYuan(b.netData.net.discipleguid,true)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eProSkill]=function(result,sortTypeArgs,sortOrder,sortParams)
local proSkillType=sortTypeArgs[2]
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleJobLevel(a.netData.net.discipleguid,proSkillType)
local vb=UIDiscipleModel:getDiscipleJobLevel(b.netData.net.discipleguid,proSkillType)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eAttr6]=function(result,sortTypeArgs,sortOrder,sortParams)
local attrType=sortTypeArgs[2]
local limit=sortTypeArgs[3]
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleBaseAttr(a.netData.net.discipleguid,attrType)
local vb=UIDiscipleModel:getDiscipleBaseAttr(b.netData.net.discipleguid,attrType)
if limit then
if va<limit[2]or va>limit[3]then
va=-1
end
if vb<limit[2]or vb>limit[3]then
vb=-1
end
end

return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eBaseAttr6]=function(result,sortTypeArgs,sortOrder,sortParams)
local attrType=sortTypeArgs[2]
local limit=sortTypeArgs[3]
table_sort(result,function(a,b)
local attrList=UIDiscipleModel:getFixAttrBase(a.netData.net)
local va=attrList[attrType]or 0
attrList=UIDiscipleModel:getFixAttrBase(b.netData.net)
local vb=attrList[attrType]or 0
if limit then
if va<limit[2]or va>limit[3]then
va=-1
end
if vb<limit[2]or vb>limit[3]then
vb=-1
end
end
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eLoyalty]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=a.netData.net.loyalty
local vb=b.netData.net.loyalty
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eMeiLi]=function(result,sortTypeArgs,sortOrder,sortParams)
local attrType=DISCIPLE_BASE_ATTR_TYPE.eMeiLi
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleBaseAttr(a.netData.net.discipleguid,attrType)
local vb=UIDiscipleModel:getDiscipleBaseAttr(b.netData.net.discipleguid,attrType)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eCongHui]=function(result,sortTypeArgs,sortOrder,sortParams)
local attrType=DISCIPLE_BASE_ATTR_TYPE.eCongHui
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleBaseAttr(a.netData.net.discipleguid,attrType)
local vb=UIDiscipleModel:getDiscipleBaseAttr(b.netData.net.discipleguid,attrType)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eTeZhi]=function(result,sortTypeArgs,sortOrder,sortParams)
local specialityType=sortTypeArgs[2]
local check=sortTypeArgs[3]or 0
table_sort(result,function(a,b)
local isMaxA,numA=UIDiscipleModel.checkSpecialtyCountMax(specialityType,a.netData.net.discipleguid)
local isMaxB,numB=UIDiscipleModel.checkSpecialtyCountMax(specialityType,b.netData.net.discipleguid)
local va=numA
local vb=numB
if check==1 then
va=isMaxA and-1 or numA
vb=isMaxB and-1 or numB
elseif check==2 then
local extra=sortTypeArgs[4]
local showTipsA,huchiSpeA,checkHaveFlagA,checkStandFlagA=UIFuncItemUseModel:checkSpecialityGroupByList(a.netData.net.discipleguid,extra,true,true)
local showTipsB,huchiSpeB,checkHaveFlagB,checkStandFlagB=UIFuncItemUseModel:checkSpecialityGroupByList(b.netData.net.discipleguid,extra,true,true)
va=(isMaxA or showTipsA or checkHaveFlagA or checkStandFlagA)and-1 or numA
vb=(isMaxB or showTipsB or checkHaveFlagB or checkStandFlagB)and-1 or numB
end
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eAttr6Sum]=function(result,sortTypeArgs,sortOrder,sortParams)
local target=sortTypeArgs[2]
table_sort(result,function(a,b)
local netDataA=a.netData.net
local netDataB=b.netData.net
local va=UIDiscipleModel:getFixAttrBaseSum(netDataA)
local vb=UIDiscipleModel:getFixAttrBaseSum(netDataB)
if target then
local attrListA=UIDiscipleModel:getFixAttrBase(netDataA)
local attrListB=UIDiscipleModel:getFixAttrBase(netDataB)


va=UIDiscipleModel:canAddBaseAttrToTarget(va,target,attrListA)and va or-1
vb=UIDiscipleModel:canAddBaseAttrToTarget(vb,target,attrListB)and vb or-1
local target_color=sortTypeArgs[3]
if target_color then
if va>0 then
local colorA=UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx3(va)
va=colorA<target_color and va or-1
end
if vb>0 then
local colorB=UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx3(vb)
vb=colorB<target_color and vb or-1
end
end
end


return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eClothing]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local netDataA=a.netData.net.discipleguid
local netDataB=b.netData.net.discipleguid
local va=ClothingHelper.getClothingSort(netDataA)
local vb=ClothingHelper.getClothingSort(netDataB)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eZhenFa]=function(result,sortTypeArgs,sortOrder,sortParams)
discipleLookup:sortList(result,{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eZhenFa},sortOrder,sortParams)
end,
[eDiscipleSortType.ePeiZhi]=function(result,sortTypeArgs,sortOrder,sortParams)
discipleLookup:sortList(result,{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.ePeiZhi},sortOrder,sortParams)
end,
[eDiscipleSortType.eDanDao]=function(result,sortTypeArgs,sortOrder,sortParams)
discipleLookup:sortList(result,{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eDanDao},sortOrder,sortParams)
end,
[eDiscipleSortType.eShangDao]=function(result,sortTypeArgs,sortOrder,sortParams)
discipleLookup:sortList(result,{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eShangDao},sortOrder,sortParams)
end,
[eDiscipleSortType.eFuLu]=function(result,sortTypeArgs,sortOrder,sortParams)
discipleLookup:sortList(result,{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eFuLu},sortOrder,sortParams)
end,
[eDiscipleSortType.eLianQi]=function(result,sortTypeArgs,sortOrder,sortParams)
discipleLookup:sortList(result,{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eLianQi},sortOrder,sortParams)
end,
[eDiscipleSortType.eSiYang]=function(result,sortTypeArgs,sortOrder,sortParams)
discipleLookup:sortList(result,{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eSiYang},sortOrder,sortParams)
end,
[eDiscipleSortType.eJuLing]=function(result,sortTypeArgs,sortOrder,sortParams)
discipleLookup:sortList(result,{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eJuLing},sortOrder,sortParams)
end,
[eDiscipleSortType.eZiZhi]=function(result,sortTypeArgs,sortOrder,sortParams)
local attrType=DISCIPLE_BASE_ATTR_TYPE.eZiZhi
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleBaseAttr(a.netData.net.discipleguid,attrType)
local vb=UIDiscipleModel:getDiscipleBaseAttr(b.netData.net.discipleguid,attrType)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eGenGu]=function(result,sortTypeArgs,sortOrder,sortParams)
local attrType=DISCIPLE_BASE_ATTR_TYPE.eGenGu
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleBaseAttr(a.netData.net.discipleguid,attrType)
local vb=UIDiscipleModel:getDiscipleBaseAttr(b.netData.net.discipleguid,attrType)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eQianLi]=function(result,sortTypeArgs,sortOrder,sortParams)
local attrType=DISCIPLE_BASE_ATTR_TYPE.eQianLi
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleBaseAttr(a.netData.net.discipleguid,attrType)
local vb=UIDiscipleModel:getDiscipleBaseAttr(b.netData.net.discipleguid,attrType)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eJiYuan]=function(result,sortTypeArgs,sortOrder,sortParams)
local attrType=DISCIPLE_BASE_ATTR_TYPE.eJiYuan
table_sort(result,function(a,b)
local va=UIDiscipleModel:getDiscipleBaseAttr(a.netData.net.discipleguid,attrType)
local vb=UIDiscipleModel:getDiscipleBaseAttr(b.netData.net.discipleguid,attrType)
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eDiscipleSortType.eMYZS_Hp]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=myzsModel:getDiscipleDataAttr(a.netData.net.discipleguid,'sortWidget')or-99
local vb=myzsModel:getDiscipleDataAttr(b.netData.net.discipleguid,'sortWidget')or-99
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end)
end,
}

local sortTypeValueLookup={
[eDiscipleSortType.eFightSort]=function(guid)
return UIDiscipleModel:getDiscipleFightValue(guid)
end,
[eDiscipleSortType.eJingJieSort]=function(guid)
return UIDiscipleModel:getDiscipleJJLevel(guid)
end,
[eDiscipleSortType.eLianTiSort]=function(guid)
return UIDiscipleModel:getDiscipleLTLevel(guid)
end,
[eDiscipleSortType.eColorSort]=function(guid)
return UIDiscipleModel:getDiscipleColor(guid)
end,
[eDiscipleSortType.ePostSort]=function(guid)
return UIDiscipleModel:getDisciplePost(guid)
end,
[eDiscipleSortType.eFuShang]=function(guid)
return UIDiscipleModel:getDiscipleInjury(guid)
end,
[eDiscipleSortType.eZiZhi]=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eZiZhi)
end,
[eDiscipleSortType.eGenGu]=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eGenGu)
end,
[eDiscipleSortType.eCongHui]=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
end,
[eDiscipleSortType.eQianLi]=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eQianLi)
end,
[eDiscipleSortType.eMeiLi]=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
end,
[eDiscipleSortType.eJiYuan]=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eJiYuan)
end,
[eDiscipleSortType.ePeiZhi]=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.ePeiZhi)
end,
[eDiscipleSortType.eDanDao]=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eDanDao)
end,
[eDiscipleSortType.eShangDao]=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eShangDao)
end,
[eDiscipleSortType.eFuLu]=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eFuLu)
end,
[eDiscipleSortType.eLianQi]=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eLianQi)
end,
[eDiscipleSortType.eZhenFa]=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eZhenFa)
end,
[eDiscipleSortType.eSiYang]=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eSiYang)
end,
[eDiscipleSortType.eJuLing]=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eJuLing)
end,
[eDiscipleSortType.eLoyalty]=function(guid)
return UIDiscipleModel:getDiscipleLoyalty(guid)
end,
[eDiscipleSortType.eClothing]=function(guid)
ClothingHelper.getClothingSort(guid)
end,
[eDiscipleSortType.eShangShi]=function(guid)
local injury=UIDiscipleModel:getDiscipleInjury(guid)
local injuryType=eInjuryType.getType(injury)
return injuryType
end,
}

local sortTypeValueDescLookup={
[eDiscipleSortType.eFightSort]=function(val,fmt_str)
return tostring(val)
end,
[eDiscipleSortType.eColorSort]=function(val,fmt_str)
return UIDiscipleModel.getDiscipleColorDesc(val)
end,
[eDiscipleSortType.eZiZhi]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleBaseAttrDesc(DISCIPLE_BASE_ATTR_TYPE.eZiZhi,val,fmt_str)
end,
[eDiscipleSortType.eGenGu]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleBaseAttrDesc(DISCIPLE_BASE_ATTR_TYPE.eGenGu,val,fmt_str)
end,
[eDiscipleSortType.eCongHui]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleBaseAttrDesc(DISCIPLE_BASE_ATTR_TYPE.eCongHui,val,fmt_str)
end,
[eDiscipleSortType.eQianLi]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleBaseAttrDesc(DISCIPLE_BASE_ATTR_TYPE.eQianLi,val,fmt_str)
end,
[eDiscipleSortType.eMeiLi]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleBaseAttrDesc(DISCIPLE_BASE_ATTR_TYPE.eMeiLi,val,fmt_str)
end,
[eDiscipleSortType.eJiYuan]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleBaseAttrDesc(DISCIPLE_BASE_ATTR_TYPE.eJiYuan,val,fmt_str)
end,
[eDiscipleSortType.ePeiZhi]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleJobLevelDesc(DISCIPLE_PROSKILL_TYPE.ePeiZhi,val,fmt_str)
end,
[eDiscipleSortType.eDanDao]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleJobLevelDesc(DISCIPLE_PROSKILL_TYPE.eDanDao,val,fmt_str)
end,
[eDiscipleSortType.eShangDao]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleJobLevelDesc(DISCIPLE_PROSKILL_TYPE.eShangDao,val,fmt_str)
end,
[eDiscipleSortType.eFuLu]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleJobLevelDesc(DISCIPLE_PROSKILL_TYPE.eFuLu,val,fmt_str)
end,
[eDiscipleSortType.eLianQi]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleJobLevelDesc(DISCIPLE_PROSKILL_TYPE.eLianQi,val,fmt_str)
end,
[eDiscipleSortType.eZhenFa]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleJobLevelDesc(DISCIPLE_PROSKILL_TYPE.eZhenFa,val,fmt_str)
end,
[eDiscipleSortType.eSiYang]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleJobLevelDesc(DISCIPLE_PROSKILL_TYPE.eSiYang,val,fmt_str)
end,
[eDiscipleSortType.eJuLing]=function(val,fmt_str)
return UIDiscipleModel:getDiscipleJobLevelDesc(DISCIPLE_PROSKILL_TYPE.eJuLing,val,fmt_str)
end,
[eDiscipleSortType.eLoyalty]=function(val,fmt_str)
return FMT.fmt("忠诚度：{0}",val)
end
}

function discipleLookup:clearData()
discipleJobLookup=nil
jobskilllvlookup=nil
end

function discipleLookup:initLookup()
local discipleNetData=UIDiscipleModel:getAllDiscipleDataX()
if discipleNetData~=nil then
for k,v in pairs(discipleNetData)do
discipleLookup:addLookup(v)
end
end
end

function discipleLookup:addLookup(data)
local netData=data.netData.net

if discipleJobLookup==nil then
discipleJobLookup={}
local cfgs=cfg_disciplevocationconfig()
for k,v in pairs(cfgs)do
if v.id~=nil then
discipleJobLookup[v.id]={}
end
end
end
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
if imageInfo then
local lp=discipleJobLookup[imageInfo.job]
if lp~=nil then
lp[netData.discipleguidStr]=true
end
end
end

function discipleLookup:checkDiscipleHasJob(jobID,discipleguidStr)
local lp=discipleJobLookup[jobID]
if lp then
return lp[discipleguidStr]~=nil
end
return false
end











function discipleLookup:getSortDiscipleList(sortTypeArgs,filterCondition,sortOrder,sortParams)
local result={}
local discipleNetData=UIDiscipleModel:getAllDiscipleDataX()
if discipleNetData~=nil then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local discipleguidStr=netData.discipleguidStr
local add=true
if filterCondition~=nil then
if filterCondition[1]~=nil and#filterCondition[1]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[1])do
if UIDiscipleModel:getDiscipleSpecialityByID(netData.discipleguid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,v1)then
addx=true
break
end
end
add=add and addx
end
if filterCondition[2]~=nil and#filterCondition[2]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[2])do
if discipleLookup:checkDiscipleHasJob(v1,netData.discipleguidStr)then
addx=true
break
end
end
add=add and addx
end
if filterCondition[3]~=nil then
if not ClothingHelper.checkDiziConfig(v.netData.net.id)then
add=false
end
end
if filterCondition[4]~=nil and#filterCondition[4]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[4])do
local tzcfg=cfg_discipletzclientconfig_get(v1)
for i2,list in pairs(tzcfg.tzmatelist)do
if#list==0 then
if i2==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then
local specialityList=UIDiscipleModel.getSpecialityList(netData.discipleguid,i2)
if specialityList and specialityList.len==5 then
addx=true
end
elseif i2==DISCIPLE_SPECIALITY_TYPE.eBody then
local specialityList=UIDiscipleModel.getSpecialityList(netData.discipleguid,i2)
if specialityList and specialityList.len>=1 then
addx=true
end
end
else
for i3,v3 in ipairs(list)do
if i2==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then

local specialityList=UIDiscipleModel.getSpecialityList(netData.discipleguid,i2)
local flag=UIDiscipleModel:getDiscipleSpecialityByID(netData.discipleguid,i2,v3)
if specialityList and specialityList.len==1 and flag then
addx=true
end
elseif UIDiscipleModel:getDiscipleSpecialityByID(netData.discipleguid,i2,v3)then
addx=true
break
end
end
end
if addx then
break
end
end
if addx then
break
end
end
add=add and addx
end
if filterCondition[5]~=nil and#filterCondition[5]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[5])do
local tzcfg=cfg_discipleqcclientconfig_get(v1)
for i2,list in pairs(tzcfg.tzmatelist)do
for i3,v3 in ipairs(list)do
if UIDiscipleModel:getDiscipleSpecialityByID(netData.discipleguid,i2,v3)then
addx=true
break
end
end
if addx then
break
end
end
if addx then
break
end
end
add=add and addx
end
end
if add then
result[#result+1]=v
end
end
if#result>0 then
self:sortList(result,sortTypeArgs,sortOrder,sortParams)
end
end
return result
end

function discipleLookup:getSortDiscipleListEx(sortTypeArgs,filterCondition,sortOrder,sortParams)
local result={}
local discipleNetData=UIDiscipleModel:getAllDiscipleDataX()
if discipleNetData~=nil then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local discipleguidStr=netData.discipleguidStr
local add=true
if filterCondition~=nil then
if filterCondition[1]~=nil and#filterCondition[1]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[1])do
if v1==1 then

if UIDiscipleModel:checkJJReddotEx(netData.discipleguid)then
addx=true
end
elseif v1==2 then

if UIDiscipleModel:checkDiscipleState2(netData.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)then
addx=true
end
end
end
add=add and addx
end
if filterCondition[2]~=nil and#filterCondition[2]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[2])do
if UIDiscipleModel:getDiscipleSpecialityByID(netData.discipleguid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,v1)then
addx=true
break
end
end
add=add and addx
end
if filterCondition[3]~=nil and#filterCondition[3]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[3])do
if discipleLookup:checkDiscipleHasJob(v1,netData.discipleguidStr)then
addx=true
break
end
end
add=add and addx
end
if filterCondition[4]~=nil and#filterCondition[4]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[4])do
local tzcfg=cfg_discipletzclientconfig_get(v1)
for i2,list in pairs(tzcfg.tzmatelist)do
if#list==0 then
if i2==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then
local specialityList=UIDiscipleModel.getSpecialityList(netData.discipleguid,i2)
if specialityList and specialityList.len==5 then
addx=true
end
elseif i2==DISCIPLE_SPECIALITY_TYPE.eBody then
local specialityList=UIDiscipleModel.getSpecialityList(netData.discipleguid,i2)
if specialityList and specialityList.len>=1 then
addx=true
end
end
else
for i3,v3 in ipairs(list)do
if i2==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then

local specialityList=UIDiscipleModel.getSpecialityList(netData.discipleguid,i2)
local flag=UIDiscipleModel:getDiscipleSpecialityByID(netData.discipleguid,i2,v3)
if specialityList and specialityList.len==1 and flag then
addx=true
end
elseif UIDiscipleModel:getDiscipleSpecialityByID(netData.discipleguid,i2,v3)then
addx=true
break
end
end
end
if addx then
break
end
end
if addx then
break
end
end
add=add and addx
end
if filterCondition[5]~=nil and#filterCondition[5]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[5])do
local tzcfg=cfg_discipleqcclientconfig_get(v1)
for i2,list in pairs(tzcfg.tzmatelist)do
for i3,v3 in ipairs(list)do
if UIDiscipleModel:getDiscipleSpecialityByID(netData.discipleguid,i2,v3)then
addx=true
break
end
end
if addx then
break
end
end
if addx then
break
end
end
add=add and addx
end
if filterCondition[6]~=nil and#filterCondition[6]>0 then
local addx=false
local issp=UIDiscipleModel:isSpecialDZ(netData.discipleguid)
local issw=UIDiscipleModel:isShuWuDisciple(netData.id)
for i1,v1 in ipairs(filterCondition[6])do
if v1==1 then
if issp and not issw then
addx=true
end
elseif v1==2 then
if issw then
addx=true
end
elseif v1==3 then
if not issp then
addx=true
end
end
if addx then
break
end
end
add=add and addx
end
if filterCondition[7]~=nil and#filterCondition[7]>0 then
local addx=false
local xm_voc=netData.xianmo_voc or 0
for i1,v1 in ipairs(filterCondition[7])do
if xm_voc==v1 then
addx=true
end
if addx then
break
end
end
add=add and addx
end
if filterCondition[8]~=nil and#filterCondition[8]>0 then
local addx=false
for i1,v1 in ipairs(filterCondition[8])do
local spetype=math.floor(v1/10000)
local speid=math.floor(v1%10000)

if spetype==1 and speid>5 then
if speid-5==netData.varysrid and UIDiscipleModel:checkDiscipleAssertVary2(netData)then
addx=true
break
end
else
if UIDiscipleModel:getDiscipleSpecialityByID(netData.discipleguid,spetype,speid)then
addx=true
break
end
end

end
add=add and addx
end
end
if add then
result[#result+1]=v
end
end
if#result>0 then
self:sortList(result,sortTypeArgs,sortOrder,sortParams)
end
end
return result
end

function discipleLookup:sortList(result,sortTypeArgs,sortOrder,sortParams)
if sortTypeArgs~=nil then
sortOrder=sortOrder or eSortOrder.eDown
local sortType
if type(sortTypeArgs)=='table'then
sortType=sortTypeArgs[1]
else
sortType=sortTypeArgs
end
local func=sortFunctionLookup[sortType]

if func then
func(result,sortTypeArgs,sortOrder,sortParams)
else
if sortParams then
if type(sortParams)=='function'then
sortParams(result,sortTypeArgs,sortOrder)
end
end
end
end
end


function discipleLookup:fusionSortList(result,sortTypeArgs,sortOrderList,sortParams)
if sortTypeArgs~=nil then
sortOrderList=sortOrderList or{eSortOrder.eDown}
if type(sortTypeArgs)~='table'then
local sortOrder=type(sortTypeArgs)~='table'and sortOrderList or sortTypeArgs[1]
return discipleLookup:sortList(result,sortTypeArgs,sortOrder,sortParams)
else
table_sort(result,function(a,b)
local sortTypeCount=#sortTypeArgs
for idx=1,sortTypeCount do
local sortType=sortTypeArgs[idx]
local va=discipleLookup:getValueBySortType(a.netData.net.discipleguid,sortType)
local vb=discipleLookup:getValueBySortType(b.netData.net.discipleguid,sortType)
local sortOrder=sortOrderList[idx]
if sortOrder==nil then
sortOrder=sortOrderList[1]
end
if idx==sortTypeCount or va~=vb then
return discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
end
end

return false
end)
end
end
end

function discipleLookup:commonSortDisciple(va,vb,a,b,sortOrder,sortParams)
sortParams=sortParams or{}
local check_a=0
local check_b=0
local netData_a=a.netData.net
local netData_b=b.netData.net
local guid_a=netData_a.discipleguid
local guid_b=netData_b.discipleguid
if sortParams[1]==true then

if a.netData.isnew==true then check_a=check_a+100 end
if b.netData.isnew==true then check_b=check_b+100 end
end
if sortParams[2]==true then

local state_a=UIDiscipleModel:getDiscipleState(guid_a)
local state_b=UIDiscipleModel:getDiscipleState(guid_b)
if UIDiscipleModel:checkDiscipleFightPriorityState(state_a)then check_a=check_a+1 end
if UIDiscipleModel:checkDiscipleFightPriorityState(state_b)then check_b=check_b+1 end
end
if sortParams[3]==true then

if netData_a.order>0 then check_a=check_a+10 end
if netData_b.order>0 then check_b=check_b+10 end
end

if sortParams[4]then

if sortParams[4][netData_a.id]then
check_a=check_a+1000
end
if sortParams[4][netData_b.id]then
check_b=check_b+1000
end
end
if sortParams[5]then

local color_a=UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx2(UIDiscipleModel:getFixAttrBase(UIDiscipleModel:getDiscipleData(guid_a)))
local color_b=UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx2(UIDiscipleModel:getFixAttrBase(UIDiscipleModel:getDiscipleData(guid_b)))

if color_a<sortParams[5]then check_a=check_a+10000 end
if color_b<sortParams[5]then check_b=check_b+10000 end
end
if sortParams[6]then

local checkFunc=sortParams[6]
local c_a=checkFunc(guid_a)
local c_b=checkFunc(guid_b)
if c_a then check_a=check_a+100000 end
if c_b then check_b=check_b+100000 end
end
if sortParams[7]then

local checkFunc=sortParams[7]
local funcParam=sortParams[8]
local c_a=checkFunc(guid_a,funcParam)
local c_b=checkFunc(guid_b,funcParam)
if c_a then check_a=check_a+10000000*c_a end
if c_b then check_b=check_b+10000000*c_b end
end
if sortParams[9]then
local checkFunc=sortParams[9]
local c_a=checkFunc(guid_a)
local c_b=checkFunc(guid_b)
if c_a then check_a=check_a+100000 end
if c_b then check_b=check_b+100000 end
end

if sortParams and sortParams.sortFunc then
if not sortParams.sortFunc(a)then
check_a=-1
end
if not sortParams.sortFunc(b)then
check_b=-1
end
end
if check_a==check_b then
if va==vb then
if sortParams[-1]==true then

local fa=netData_a.fightvalue
local fb=netData_b.fightvalue
return fa>fb
else
local fa=UIDiscipleModel:getDiscipleFightValueEx(netData_a)
local fb=UIDiscipleModel:getDiscipleFightValueEx(netData_b)
return fa>fb
end
else
return helper.sortOrderComparis(va,vb,sortOrder)
end
else
return check_a>check_b
end
end

function discipleLookup:getConditonFilter(sortCondition)
local c=1
local filterName={}
local filterFlag={}
filterName[c]={}
filterName[c][1]='灵根'
filterName[c][2]={}
filterFlag[c]={}
local lgcfgs=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
for i,v in ipairs(lgcfgs)do
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,v.id)
table.insert(filterFlag[c],flag)
end
c=c+1
filterName[c]={}
filterName[c][1]='职业'
filterName[c][2]={}
filterFlag[c]={}
local jobcfgs=cfg_disciplevocationconfig()
for k,v in pairs(jobcfgs)do
if v.id~=nil and not v.hide then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,v.id)
table.insert(filterFlag[c],flag)
end
end
return filterName,filterFlag
end

function discipleLookup:getConditonFilterEx(sortCondition)
local speLookup={}

local c=1
local filterName={}
local filterFlag={}

filterName[c]={}
filterName[c][1]='状态'
filterName[c][2]={}
filterFlag[c]={}
table.insert(filterName[c][2],{name='可渡劫',typeid=1})
local flag_1=discipleLookup.getFilterFlagByCondition(sortCondition,c,1)
table.insert(filterFlag[c],flag_1)
table.insert(filterName[c][2],{name='垂危',typeid=2})
local flag_2=discipleLookup.getFilterFlagByCondition(sortCondition,c,2)
table.insert(filterFlag[c],flag_2)

c=c+1
filterName[c]={}
filterName[c][1]='灵根'
filterName[c][2]={}
filterFlag[c]={}
local lgcfgs=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
if not speLookup[DISCIPLE_SPECIALITY_TYPE.eSpiritRoot]then
speLookup[DISCIPLE_SPECIALITY_TYPE.eSpiritRoot]={}
end
for i,v in ipairs(lgcfgs)do
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,v.id)
table.insert(filterFlag[c],flag)
speLookup[DISCIPLE_SPECIALITY_TYPE.eSpiritRoot][v.id]=true
end
c=c+1
filterName[c]={}
filterName[c][1]='职业'
filterName[c][2]={}
filterFlag[c]={}
local jobcfgs=cfg_disciplevocationconfig()
for k,v in pairs(jobcfgs)do
if v.id~=nil and not v.hide then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,v.id)
table.insert(filterFlag[c],flag)
end
end
c=c+1
filterName[c]={}
filterName[c][1]='特质'
filterName[c][2]={}
filterFlag[c]={}
local tzcfgs=cfg_discipletzclientconfig()
for i,v in ipairs(tzcfgs)do
table.insert(filterName[c][2],{name=v.tzname,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,v.id)
table.insert(filterFlag[c],flag)
end
c=c+1
filterName[c]={}
filterName[c][1]='奇才'
filterName[c][2]={}
filterFlag[c]={}
local tzcfgs=cfg_discipleqcclientconfig()
for i,v in ipairs(tzcfgs)do
table.insert(filterName[c][2],{name=v.tzname,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,v.id)
table.insert(filterFlag[c],flag)

for ii,vv in pairs(v.tzmatelist)do
if not speLookup[ii]then
speLookup[ii]={}
end
for iii,vvv in ipairs(vv)do
speLookup[ii][vvv]=true
end
end
end
c=c+1
filterName[c]={}
filterName[c][1]='类型'
filterName[c][2]={}
filterFlag[c]={}
local dztypecfgs={{dzname='仙缘',id=1},{dzname='庶务',id=2},{dzname='普通',id=3}}
for i,v in ipairs(dztypecfgs)do
table.insert(filterName[c][2],{name=v.dzname,typeid=v.id})
local flag2=discipleLookup.getFilterFlagByCondition(sortCondition,c,v.id)
table.insert(filterFlag[c],flag2)
end
c=c+1
filterName[c]={}
filterName[c][1]='转职'
filterName[c][2]={}
filterFlag[c]={}

table.insert(filterName[c][2],{name="成仙",typeid=1})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,1)
table.insert(filterFlag[c],flag)

table.insert(filterName[c][2],{name="化魔",typeid=2})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,2)
table.insert(filterFlag[c],flag)

if TeZhiTuJianController:checkSysOpen()then
local loveList=discipleLookup:getLoveList()
c=c+1
filterName[c]={}
filterName[c][1]='关注'
filterName[c][2]={}
filterName[c][3]='可前往弟子特质图鉴关注心仪特质'
filterFlag[c]={}
local config2=TeZhiTuJianModel:getConfigLoolup2()
for i,v in pairs(loveList)do
local spetype=v[1]
local speid=v[2]
if not speLookup[spetype]or not speLookup[spetype][speid]then
local cfg=config2[spetype][speid]
local typeid=spetype*10000+speid
table.insert(filterName[c][2],{name=cfg.name,typeid=typeid})
local flag2=discipleLookup.getFilterFlagByCondition(sortCondition,c,typeid)
table.insert(filterFlag[c],flag2)
end
end
end

return filterName,filterFlag
end

function discipleLookup:getLoveList()
local loveSpeList={}
local c=0
local lp=UIDiscipleModel.getSpecialityLoveLookup()
if lp~=nil then
local config2=TeZhiTuJianModel:getConfigLoolup2()
for spetype,v in pairs(lp)do
for speid,_ in pairs(v)do
c=c+1
local cfg=config2[spetype][speid]
local book_id=cfg.id
local d={spetype,speid}
local sorts={}
sorts[1]=10-cfg.showType
local state=TeZhiTuJianModel:getTuJianState(book_id)
if state~=TeZhiTuJianModel.TempState.eNotRecv then
sorts[2]=1
else
sorts[2]=0
end
sorts[3]=10000-book_id
d.sorts=sorts
loveSpeList[c]=d
end
end
if c>1 then
mathHelper.sortWeightList(loveSpeList)
end
end
return loveSpeList
end

function discipleLookup.getFilterFlagByCondition(sortCondition,idx,typeid)
if sortCondition==nil or sortCondition[idx]==nil then return false end
local arr=sortCondition[idx]
for i,v in ipairs(arr)do
if v==typeid then
return true
end
end
return false
end

function discipleLookup:initOtherLookup()
jobskilllvlookup={}
local vocskill=cfgHelper.getdef1(cfg_disciplejingjieconfig,'vocskill')
local cfgs=cfg_disciplevocationconfig()
for k,cfg in pairs(cfgs)do
if cfg.id~=nil then
for groupid,group in ipairs(cfg.skills)do
for idx,skillId in ipairs(group)do
if jobskilllvlookup[skillId]==nil then
jobskilllvlookup[skillId]={}
for floor,levels in pairsBySortKey(vocskill)do
if idx==1 then

jobskilllvlookup[skillId][floor]=1
else

jobskilllvlookup[skillId][floor]=levels[idx-1]
end
end
end
end
end
end
end
end

function discipleLookup:isJobSkil(skillID)
return jobskilllvlookup[skillID]~=nil
end


function discipleLookup:getJobSkilLevelByJJLevel(skillID,jjlv)
local lookup=jobskilllvlookup[skillID]
if lookup then
local floor=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'floor')
if lookup[floor]then
return lookup[floor]
end
end
return nil
end


function discipleLookup:getJJFloorByJobSkilLevel(skillID,skilllv)
local lookup=jobskilllvlookup[skillID]
if lookup then
for floor,skill_lv in pairsBySortKey(lookup)do
if skill_lv==skilllv then
return floor
end
end
end
return nil
end


function discipleLookup:getValueBySortType(guid,sortType)
local func=sortTypeValueLookup[sortType]
if func then
return func(guid)
else
logErr(FMT.fmt('sortTypeValueLookup缺少类型:{0}',sortType))
end
end


function discipleLookup:getValueDescBySortType(val,sortType,fmt_str)
local func=sortTypeValueDescLookup[sortType]
if func then
return func(val,fmt_str)
else
logErr(FMT.fmt('sortTypeValueDescLookup:{0}',sortType))
end
end

function discipleLookup:getJobImageLookup()
if jobImageLookup==nil then
jobImageLookup={}
local cfgs
cfgs=cfg_disciplerandimageconfig00001()
discipleLookup:initJobImageLookup(jobImageLookup,1,cfgs)
cfgs=cfg_disciplerandimageconfig00002()
discipleLookup:initJobImageLookup(jobImageLookup,2,cfgs)
end
return jobImageLookup
end

function discipleLookup:initJobImageLookup(lp,sex,cfgs)
local voclist,sexlist,newVoc,newSex,in_side,check
for voc,v in pairs(cfgs)do
check=true

for partid,v2 in pairs(v)do
if v2.lib2~=nil and#v2.lib2>0 then
if check then
check=false

newVoc=false
if lp[voc]==nil then
lp[voc]={}
newVoc=true
end
if newVoc then
voclist=lp.voclist
if voclist==nil then
voclist={}
lp.voclist=voclist
end
table.insert(voclist,voc)
end

newSex=false
if lp[voc][sex]==nil then
lp[voc][sex]={insidelp={}}
newSex=true
end
if newSex then
sexlist=lp[voc].sexlist
if sexlist==nil then
sexlist={}
lp[voc].sexlist=sexlist
end
table.insert(sexlist,sex)
end
end
for i3,v3 in ipairs(v2.lib2)do
in_side=discipleLookup:getImageInside(partid,v3)
if in_side then
local c=in_side==0 or lp[voc][sex].insidelp[in_side]==nil
if c then
lp[voc][sex].insidelp[in_side]=true
if lp[voc][sex][partid]==nil then
lp[voc][sex][partid]={}
end
table.insert(lp[voc][sex][partid],v3)
end
end
end
end
end
end
end

function discipleLookup:getImageInside(partid,id)
if id==0 then
return 0
end
if partid==1 then
return cfgHelper.get2(cfg_disciplehairimageconfig_get,id,'in_side')
elseif partid==2 then
return cfgHelper.get2(cfg_disciplefaceimageconfig_get,id,'in_side')
elseif partid==3 then
return cfgHelper.get2(cfg_disciplebodyimageconfig_get,id,'in_side')
elseif partid==4 then
return cfgHelper.get2(cfg_disciplefaceaccessoryimageconfig_get,id,'in_side')
end
end