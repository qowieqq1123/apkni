

















local specialityConfigGetterLookup={}
local specialityConfigGetterLookup2={}

local _dzSpeTimePassLookup
local _specialityLoveLookup

function UIDiscipleModel:updateDZSpeTimePass(netData)
if _dzSpeTimePassLookup==nil then _dzSpeTimePassLookup={}end
if UIDiscipleModel:hasAnyTimeSpecialityByData(netData)then
_dzSpeTimePassLookup[netData.discipleguidStr]=netData
else
_dzSpeTimePassLookup[netData.discipleguidStr]=nil
end
end

function UIDiscipleModel:removeDZSpeTimePass(guid_str)
if _dzSpeTimePassLookup then
_dzSpeTimePassLookup[guid_str]=nil
end
end

function UIDiscipleModel:clearDZSpeTimePass()
_dzSpeTimePassLookup=nil
end

function UIDiscipleModel:getDZSpeTimePass()
return _dzSpeTimePassLookup
end

function UIDiscipleModel:resetEffectTypoLookup(strGuid)
local netData=self:getDiscipleDataByStr(strGuid)
if netData~=nil then
netData.effectTypoLookup=nil
end
end

function UIDiscipleModel:hasAnyTimeSpecialityByData(netData)
local len=netData.speTimePassLen or 0
return len>0
end

function UIDiscipleModel:hasTimeSpecialityByParams2(netData,specialitytype,specialityid)
if netData.speTimePasslookup==nil or netData.speTimePasslookup[specialitytype]==nil then return false end
for i,v in ipairs(netData.speTimePasslookup[specialitytype])do
if v.param_1==specialityid then return true end
end
return false
end

function UIDiscipleModel:hasTimeSpeciality(netData,specialityType)
if netData.speTimePasslookup==nil then return false end
local list=netData.speTimePasslookup[specialityType]or nil
local len=list and#list or 0
return len>0
end

function UIDiscipleModel:removeTimeSpeciality(netData,specialityType,specialityid)
if netData.speTimePasslookup==nil then return false end
if netData.speTimePasslookup==nil or netData.speTimePasslookup[specialityType]==nil then return false end
for i,v in ipairs(netData.speTimePasslookup[specialityType])do
if v.param_1==specialityid then
_remove(netData.speTimePasslookup[specialityType],i)
netData.speTimePassLen=netData.speTimePassLen-1
return true
end
end
return false
end

function UIDiscipleModel:addTimeSpeciality(netData,specialityType,specialityInfo)
if netData.speTimePasslookup==nil then return false end
if not UIDiscipleModel:checkDZSpeHasTime(specialityInfo)or
UIDiscipleModel:checkDZSpeTimeOver(specialityInfo)then
return false
end

if netData.speTimePasslookup[specialityType]==nil then netData.speTimePasslookup[specialityType]={}end
local speTimePasslookup=netData.speTimePasslookup[specialityType]
for i,v in ipairs(speTimePasslookup)do
if v.param_1==specialityInfo.param_1 then
speTimePasslookup[i]=specialityInfo
return
end
end
_insert(speTimePasslookup,specialityInfo)
local len=netData.speTimePassLen or 0
netData.speTimePassLen=len+1
return true
end


function UIDiscipleModel.refreshDiscipleSpecialityLookup(netData)
if netData then
local specialitylistlookup={}
local specialityNoHidelistlookup={}
local specialitytypelookup={}
local speTimePassLen=0
local speTimePasslookup={}
local specialityalllist={}
local specialityallNoHidelist={}
if netData.specialityList~=nil then
for i,v in ipairs(netData.specialityList)do
local specialitytype=v.specialitytype
local lp=specialitytypelookup[specialitytype]
if lp==nil then
lp={}
specialitytypelookup[specialitytype]=lp
end
local list=specialitylistlookup[specialitytype]
if list==nil then
list={}
specialitylistlookup[specialitytype]=list
end
local list1=specialityNoHidelistlookup[specialitytype]
if list1==nil then
list1={}
specialityNoHidelistlookup[specialitytype]=list1
end
if v.specialityLst~=nil then
for i1,v1 in ipairs(v.specialityLst)do
local check=true

if UIDiscipleModel:checkDZSpeHasTime(v1)then
if UIDiscipleModel:checkDZSpeTimeOver(v1)then
check=false
else

speTimePassLen=speTimePassLen+1
speTimePasslookup[specialitytype]=speTimePasslookup[specialitytype]or{}
_insert(speTimePasslookup[specialitytype],v1)
end
end
if check then

_insert(list,v1)
lp[v1.param_1]=v1


if not UIDiscipleModel:hasHideSpecialityType(specialitytype)or v1.param_2~=1 then
_insert(list1,v1)
_insert(specialityallNoHidelist,{specialitytype,v1})
end

specialityalllist[#specialityalllist+1]={specialitytype,v1}
end
end

local n=#list
for i,v in ipairs(list)do
v.param_0=n
end
v.specialityLst=list
v.len=n
end
end
end
netData.specialitylistlookup=specialitylistlookup
netData.specialityNoHidelistlookup=specialityNoHidelistlookup
netData.specialityalllist=specialityalllist
netData.specialityallNoHidelist=specialityallNoHidelist
netData.specialitytypelookup=specialitytypelookup
netData.speTimePassLen=speTimePassLen
netData.speTimePasslookup=speTimePasslookup
netData.specialityEffectList=nil
netData.effectTypoLookup=nil
end
end

function UIDiscipleModel:updateSpeciality(netData,updatetype,specialitystruct)
local specialityList=netData.specialityList

local specialitytype=specialitystruct.specialitytype
local specialityinfo=specialitystruct.specialityInfo
local specialityid=specialityinfo.param_1



netData.specialityEffectList=nil
netData.effectTypoLookup=nil
local change=false
if updatetype==0 then

for i,v in ipairs(netData.specialityalllist)do
if v[1]==specialitytype and v[2].param_1==specialityid then
_remove(netData.specialityalllist,i)
end
end
for i,v in ipairs(netData.specialityallNoHidelist)do
if v[1]==specialitytype and v[2].param_1==specialityid then
_remove(netData.specialityallNoHidelist,i)
end
end
local list=netData.specialitylistlookup[specialitytype]
if list~=nil then
local f
for i,v in ipairs(list)do
if v.param_1==specialityid then
f=i
break
end
end

local list1=netData.specialityNoHidelistlookup[specialitytype]
for i,v in ipairs(list1)do
if v.param_1==specialityid then
_remove(list1,i)
break
end
end
if f then
change=true
local d=table.remove(list,f)
local lp=netData.specialitytypelookup[specialitytype]
if lp then
lp[d.param_1]=nil
end
if UIDiscipleModel:checkDZSpeHasTime(d)then
UIDiscipleModel:removeTimeSpeciality(netData,specialitytype,d.param_1)
end
for i,v in ipairs(specialityList)do
if v.specialitytype==specialitytype then
v.len=#v.specialityLst
break
end
end
local n=#list
for i,v in ipairs(list)do
v.param_0=n
end
end
end
elseif updatetype==1 then

specialityList=netData.specialityList or{}
local f=nil
local f1=nil
for i,v in ipairs(specialityList)do
if v.specialitytype==specialitytype then
f=v
f1=table.deepCopy(v)
break
end
end
if f==nil then
change=true
f={specialitytype=specialitytype,len=1,specialityLst={}}
f1={specialitytype=specialitytype,len=1,specialityLst={}}
_insert(f.specialityLst,specialityinfo)
if not UIDiscipleModel:hasHideSpecialityType(specialitytype)or specialityinfo.param_2~=1 then
_insert(f1.specialityLst,specialityinfo)
end
_insert(specialityList,f)
else
local ff=nil
if f.specialityLst==nil then f.specialityLst={}end
for i,v in ipairs(f.specialityLst)do
if v.param_1==specialityid then
change=true
f.specialityLst[i]=specialityinfo
ff=true
break
end
end

if ff==nil then
change=true
table.insert(f.specialityLst,specialityinfo)
f.len=#f.specialityLst
end

local ff1
if f1.specialityLst==nil then f1.specialityLst={}end
for i,v in ipairs(f1.specialityLst)do
if v.param_1==specialityid then
f1.specialityLst[i]=specialityinfo
ff1=true
break
end
end
if ff1==nil and(not UIDiscipleModel:hasHideSpecialityType(specialitytype)or specialityinfo.param_2~=1)then
_insert(f1.specialityLst,specialityinfo)
f1.len=#f1.specialityLst
end
end
netData.specialityList=specialityList

netData.specialitylistlookup[specialitytype]=f.specialityLst
netData.specialityNoHidelistlookup[specialitytype]=f1.specialityLst
local n=#f.specialityLst
for i,v in ipairs(f.specialityLst)do
v.param_0=n
end

local lp=netData.specialitytypelookup[specialitytype]
if netData.specialitytypelookup[specialitytype]==nil then
lp={}
netData.specialitytypelookup[specialitytype]=lp
end
lp[specialityid]=specialityinfo

UIDiscipleModel:addTimeSpeciality(netData,specialitytype,specialityinfo)

if not UIDiscipleModel:hasHideSpecialityType(specialitytype)or specialityinfo.param_2~=1 then
local has=false
for _,v in ipairs(netData.specialityallNoHidelist)do
if v[1]==specialitytype and v[2].param_1==specialityid then
v[2]=specialityinfo
has=true
break
end
end
if not has then
_insert(netData.specialityallNoHidelist,{specialitytype,specialityinfo})
end
end

local has=false
for _,v in ipairs(netData.specialityalllist)do
if v[1]==specialitytype and v[2].param_1==specialityid then
v[2]=specialityinfo
has=true
break
end
end
if not has then
_insert(netData.specialityalllist,{specialitytype,specialityinfo})
end

else

end
return change
end

function UIDiscipleModel:checkDZSpeHasTime(spe)
return spe.expiresec~=nil and spe.expiresec>0
end

function UIDiscipleModel:checkDZSpeTimeOver(spe)
local cur=gameUtilityModel.getServerShortTime()
if cur>=spe.expiresec then
return true
end
end

function UIDiscipleModel:getDZSpeLeftTime(spe)
if spe.expiresec~=nil and spe.expiresec>0 then
local cur=gameUtilityModel.getServerShortTime()
local lerp=spe.expiresec-cur
if lerp<0 then lerp=0 end
return lerp
end
return 0
end

function UIDiscipleModel:getDiscipleAllSpecialityEx(netData)
if netData.specialityallNoHidelist then

if not UIDiscipleModel:hasTimeSpeciality(netData)then return netData.specialityallNoHidelist end

local list={}
for _,temp in ipairs(netData.specialityallNoHidelist)do
local speType=temp[1]
local spe=temp[2]
local check=true
if UIDiscipleModel:checkDZSpeHasTime(spe)then
if UIDiscipleModel:checkDZSpeTimeOver(spe)then
check=false
end
end
if check then
_insert(list,{speType,spe})
end
end
if#list>0 then
return list
end
end
return nil
end

function UIDiscipleModel:getDiscipleSpecialityLen(netData,specialityType)
if netData.specialityNoHidelistlookup then
local temp=netData.specialityNoHidelistlookup[specialityType]
if not UIDiscipleModel:hasTimeSpeciality(netData,specialityType)then return temp and#temp or 0 end

if temp then
local len=0
for i,spe in ipairs(temp)do
local check=true
if UIDiscipleModel:checkDZSpeHasTime(spe)then
if UIDiscipleModel:checkDZSpeTimeOver(spe)then
check=false
end
end
if check then
len=len+1
end
end
return len
end
end
return 0
end



function UIDiscipleModel:getDiscipleSpeciality(guid,specialityType)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData==nil then

netData=otherPlayerModel:getDZBaseData(guid)
end
return UIDiscipleModel:getDiscipleSpecialityByDataEx(netData,specialityType)
end

function UIDiscipleModel:getDiscipleSpecialityByDataEx(netData,specialityType)
if netData.specialityNoHidelistlookup then
local temp=netData.specialityNoHidelistlookup[specialityType]
if temp then
if not UIDiscipleModel:hasTimeSpeciality(netData,specialityType)then return temp end
local list={}
local num=#temp
for i,spe in ipairs(temp)do
local check=true
if UIDiscipleModel:checkDZSpeHasTime(spe)then
if UIDiscipleModel:checkDZSpeTimeOver(spe)then
check=false
end
end
if check then
_insert(list,spe)
end
end
if#list>0 then
return list
end
end
end
return nil
end


function UIDiscipleModel:getDiscipleAllSpecialityByData(netData,specialityType)
if netData.specialitylistlookup then
local temp=netData.specialitylistlookup[specialityType]
if temp then
if not UIDiscipleModel:hasTimeSpeciality(netData,specialityType)then return temp end

local list={}
local num=#temp
for i,spe in ipairs(temp)do
local check=true
if UIDiscipleModel:checkDZSpeHasTime(spe)then
if UIDiscipleModel:checkDZSpeTimeOver(spe)then
check=false
end
end
if check then
_insert(list,spe)
end
end
if#list>0 then
return list
end
end
end
return nil
end

function UIDiscipleModel:getDiscipleSpecialityByID(guid,specialityType,sID,includeHide,warning)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleSpecialityByIDEx(netData,specialityType,sID,includeHide,warning)
end

function UIDiscipleModel:getDiscipleSpecialityByIDEx(netData,specialityType,sID,includeHide,warning)
if warning==nil then warning=false end
local curTemp=nil
if netData.specialitytypelookup then
if netData.specialitytypelookup[specialityType]then
local temp=netData.specialitytypelookup[specialityType][sID]
if not includeHide and UIDiscipleModel:hasHideSpecialityType(specialityType)then

if temp and temp.param_2==0 then
curTemp=temp
end
else
curTemp=temp
end
end
end

if specialityType~=DISCIPLE_SPECIALITY_TYPE.eSpiritRoot and warning then

local conditionsFlag,conditions_str=UIDiscipleModel:getDiscipleSpecialityConditionsFlag(netData,specialityType,sID)
if not conditionsFlag then
return curTemp,conditionsFlag,conditions_str or nil
end


local standFlag,stand_str=UIDiscipleModel.getDiscipleSpecialityStandFlag(netData,specialityType,sID)
if not standFlag then
return curTemp,standFlag,stand_str or nil
end
return curTemp,conditionsFlag and standFlag,nil
end
return curTemp,nil,nil
end


function UIDiscipleModel.getDiscipleSpecialityStandFlag(netData,specialityType,sID)
local cfg=UIDiscipleModel:getSpecialityConfig(specialityType,sID)
local standFlag=not cfg.stand or cfg.stand[netData.stand]==true
local stand_str=nil
if not standFlag then
local str=nil
for i1,v1 in pairs(cfg.stand)do
local standName=cfgHelper.get2(cfg_disciplestandconfig_get,i1,'name')
if str==nil then
str=standName
else
str=FMT.fmt("{0}、{1}",str,standName)
end
end
stand_str=FMT.fmt("只有立场为{0}的弟子才可使用",str)
end
return standFlag,stand_str
end


function UIDiscipleModel:getDiscipleSpecialityConditionsFlag(netData,specialityType,sID)
local cfg=UIDiscipleModel:getSpecialityConfig(specialityType,sID)
if not cfg.conditions then
return true
end

for i,v in ipairs(cfg.conditions)do
local type=v[1]
if type==1 then

local _speId=v[2]
local haveSpe=false
for i1,v1 in ipairs(netData.specialityList)do
if v1.specialityLst and v1.specialitytype==1 then
for _,spe in ipairs(v1.specialityLst)do
if spe.param_1==_speId then
haveSpe=true
break
end
end
end
end
if not haveSpe then
local name_str=cfgHelper.get2(cfg_disciplespiritrootconfig_get,_speId,'name')
return false,FMT.fmt("拥有{0}的弟子才可使用",name_str)
end
elseif type==2 then

local _sex=v[2]
local sex=UIDiscipleModel:getDiscipleSex(netData.discipleguid)
if sex~=_sex then
local sex_str=cfgHelper.get2(cfg_disciplesexconfig_get,_sex,'name')
return false,FMT.fmt("只有{0}性弟子才可使用",sex_str)
end
elseif type==3 then

local attrType=v[2]
local minAttr=v[3]
local maxAttr=v[4]
local attr=netData.attrList[attrType]==0 and 1 or netData.attrList[attrType]
if attr<minAttr or attr>maxAttr then
local attr_str=UIDiscipleModel:discipleBaseAttrName(attrType)
return false,FMT.fmt("{0}在{1}~{2}的弟子才可使用",attr_str,minAttr,maxAttr)
end
end
end
return true
end

function UIDiscipleModel:hasHideSpecialityType(specialityType)
return specialityType==DISCIPLE_SPECIALITY_TYPE.eBody or specialityType==DISCIPLE_SPECIALITY_TYPE.eTalent
end

function UIDiscipleModel:getSpecialityTypeName(specialityType)
return cfgHelper.get2(cfg_disciplespecialitytypeconfig_get,specialityType,'name')
end

function UIDiscipleModel:getSpecialityName(specialityType,sid,iscolor)
local name=UIDiscipleModel:getSpecialityConfig(specialityType,sid,'name')
if iscolor then
return UIDiscipleModel:getSpecialityNameEx(specialityType,name)
else
return name
end
end

function UIDiscipleModel:getSpecialityNameEx(specialityType,name)
local typecfg=cfgHelper.get1(cfg_disciplespecialitytypeconfig_get,specialityType)
return FMT.fmt('<color={0}>{1}</color>',typecfg.namecolor,name)
end

function UIDiscipleModel:getSpecialityConfigCommon(netData,specialityType,speData)
if specialityType~=DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then
return UIDiscipleModel:getSpecialityConfig(specialityType,speData.param_1)
else
return UIDiscipleModel:getSpecialityConfigEx(netData,specialityType,speData)
end
end

function UIDiscipleModel:getSpecialityConfig(specialityType,sid,...)
local getter=UIDiscipleModel:getSpecialityConfigGetter(specialityType)
if sid==nil then
getter=UIDiscipleModel:getSpecialityConfigGetter(specialityType)
return getter()
else
getter=UIDiscipleModel:getSpecialityConfigGetter2(specialityType)
return cfgHelper.get(getter,sid,...)
end
end




local eSpiritRootCombineCfgCache={}





local __getName=function(self_)
return self_.name
end

function UIDiscipleModel:getSpecialityConfigEx(netData,specialityType,speData)
local num=speData.param_0
local sid=speData.param_1


if netData and specialityType==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot and speData.param_2 then
local lv=speData.param_2
local cacheKey
local cfg2

if sid==netData.varysrid and UIDiscipleModel:checkDiscipleAssertVary2(netData)then
cacheKey=100000+num*10000+sid*1000+lv
local cacheCfg=eSpiritRootCombineCfgCache[cacheKey]
if cacheCfg~=nil then
return cacheCfg
end
cfg2=table.weakCopy(cfgHelper.get3(cfg_disciplespiritrootlevelconfig_get,num,sid,lv))
local varyCfg=cfgHelper.get1(cfg_disciplespiritroottypeconfig_get,sid)
for k,v in pairs(varyCfg)do
cfg2[k]=v
end
else
cacheKey=num*10000+sid*1000+lv
local cacheCfg=eSpiritRootCombineCfgCache[cacheKey]
if cacheCfg~=nil then
return cacheCfg
end
cfg2=table.weakCopy(cfgHelper.get3(cfg_disciplespiritrootlevelconfig_get,num,sid,lv))
end

local cfg1=UIDiscipleModel:getSpecialityConfig(specialityType,sid)
local cfg=table.weakCopy(cfg1)
for k,v in pairs(cfg2)do
cfg[k]=v
end

if specialityType==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot and num==1 then
cfg.name=FMT.fmt('天{0}',cfg.name)
end
cfg.getName=__getName
cfg.specialitytype=cfg.typo
eSpiritRootCombineCfgCache[cacheKey]=cfg
return cfg
end

local cfg1=UIDiscipleModel:getSpecialityConfig(specialityType,sid)
return cfg1
end

function UIDiscipleModel:getSpecialityConfigGetter(specialityType)
local getter=specialityConfigGetterLookup[specialityType]
if getter==nil then
local cfg=cfgHelper.get1(cfg_disciplespecialitytypeconfig_get,specialityType)
getter=cfgHelper.getCofingFunction(cfg.configname)
specialityConfigGetterLookup[specialityType]=getter
end
return getter
end

function UIDiscipleModel:getSpecialityConfigGetter2(specialityType)
local getter=specialityConfigGetterLookup2[specialityType]
if getter==nil then
local cfg=cfgHelper.get1(cfg_disciplespecialitytypeconfig_get,specialityType)
getter=cfgHelper.getCofingGetFunction(cfg.configname)
specialityConfigGetterLookup2[specialityType]=getter
end
return getter
end


function UIDiscipleModel:getDiscipleSpecialityConfig(guid,checkClient)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleSpecialityConfigByData(netData,checkClient)
end

function UIDiscipleModel:getDiscipleSpecialityConfigByData(netData,checkClient)
local configs={}
if netData.specialityList then
for i,v in ipairs(netData.specialityList)do
if v.specialityLst then
local specialitytype=v.specialitytype
for _,spe in ipairs(v.specialityLst)do
local check=true
if UIDiscipleModel:checkDZSpeHasTime(spe)then
if UIDiscipleModel:checkDZSpeTimeOver(spe)then
check=false
end
end
if check then
if UIDiscipleModel:hasHideSpecialityType(specialitytype)then

if spe.param_2==1 then
check=false
end
end
end
if check then
local cfg=UIDiscipleModel:getSpecialityConfigEx(netData,specialitytype,spe)
if cfg then
cfg.specialitytype=cfg.typo
table.insert(configs,cfg)
end
end
end
end
end
end
if checkClient then



if UIDiscipleModel:checkOponTianMing(netData)then
local config=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritClient,1)
local copyCfg=table.weakCopy(config)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
local race=imageInfo.race
local tmname=cfgHelper.get2(cfg_discipleraceconfig_get,race,'tmname')
copyCfg.name=tmname
copyCfg.specialitytype=copyCfg.typo
table.insert(configs,1,copyCfg)
end

if UIDiscipleModel:isShuWuDisciple(netData.id)then
local config=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritClient,2)
local copyCfg=table.weakCopy(config)
copyCfg.specialitytype=copyCfg.typo
table.insert(configs,1,copyCfg)
end
end
return configs
end


function UIDiscipleModel.onClickClientSpeciality(item,netData,specfg,directionType)
if specfg.specialitytype==DISCIPLE_SPECIALITY_TYPE.eSpiritClient then
if specfg.id==1 then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local tmList=UIDiscipleModel:getTianMingByIndexEx(netData,nil)
local image=nil
if netData.imageInfo then
image=netData.imageInfo
else
image=UIDiscipleModel.calculationDiscipleImageBase(netData)
end
local jobid=image.job
local c_tmList=table.deepCopy(tmList)
UIManager:showWindow('UIDiscipleTianMingTipsTwoWin',{item=item,directionType=directionType,config=specfg,
tmlv=tmlv,tmList=c_tmList,jobid=jobid})
elseif specfg.id==2 then
UIManager:showWindow('UIDiscipleShuWuQJWin',{dzData=netData,config=specfg})
end
return true
end
return false
end

function UIDiscipleModel.getSpecialityColorFrame(color)
local abName=globalABLookup.global
local frameIcon='frame_tytezhikuang_'..color
return abName,frameIcon
end

function UIDiscipleModel.getSpecialityNameStr(name)
if pfwindowslController:checkIsGameVersion_yuenan()then
name=string.addNewlineAfterSecondWord(name)
if string.lenEx(name)>22 then
name=utf8.sub(name,1,22)
name=string.format("%s...",name)
end
else
if string.lenEx(name)>4 then
name=utf8.sub(name,1,4)
name=string.format("%s...",name)
end
end
return name
end

function UIDiscipleModel.refreshSpecialityItem(item,speCfg,clickFunc,name)
name=UIDiscipleModel.getSpecialityNameStr(name or speCfg.name)
item:SetChildText(0,name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(speCfg.framecolor)
item:SetChildCSImageSprite(1,abName,frameIcon)

local showEffect=speCfg.effectID~=nil
item:SetChildActive(2,showEffect)
if showEffect then
item:SetChildAnimationStringID(2,speCfg.effectID,true)
end

if clickFunc then
item:SetChildButtonClick(1,clickFunc)
end

end

function UIDiscipleModel.refreshSpecialityItemEx(item,speCfg,name)
name=UIDiscipleModel.getSpecialityNameStr(name or speCfg.name)
item:SetChildText(1,name)
local color=speCfg.framecolor or speCfg.color
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(color)
item:SetChildCSImageSprite(0,abName,frameIcon)
end

function UIDiscipleModel.refreshSpecialityItemExx(item,speCfg,name)
name=UIDiscipleModel.getSpecialityNameStr(name or speCfg.name)
item:SetChildText(0,name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(speCfg.framecolor)
item:SetChildCSImageSprite(1,abName,frameIcon)
end

function UIDiscipleModel.getSpecialtyTypeName(specialityType,sID,iscolor)
local typecfg=cfgHelper.get1(cfg_disciplespecialitytypeconfig_get,specialityType)
local name=typecfg.name
if name==nil then
name=UIDiscipleModel:getSpecialityConfig(specialityType,sID,'name')
end
local str
if iscolor then
str=FMT.fmt('<color={0}>【{1}】</color>',typecfg.namecolor,name)
else
str=FMT.fmt('【{0}】',name)
end
return str
end

function UIDiscipleModel.checkSpecialtyCountMax(specialityType,dzguid)
local const_def=UIDiscipleModel:getSpecialityConfig(specialityType,"const_def")
local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(dzguid))
local num=UIDiscipleModel:getDiscipleSpecialityLen(netData,specialityType)
local max=const_def and const_def.maxnum or 0
return num>=max,num,max
end


function UIDiscipleModel.checkDiscipleSpecialityGroupByID(guid,specialityType,sID)
local grouplist=UIDiscipleModel:getSpecialityConfig(specialityType,sID,'grouplist')
if grouplist then
local groupCfg
local netData=UIDiscipleModel:getDiscipleData(guid)
for _,group in ipairs(grouplist)do
groupCfg=cfgHelper.get(cfg_disciplespecialitygroupconfig_get,group,"sets")
for i,v in ipairs(groupCfg)do
local spe=UIDiscipleModel:getDiscipleSpecialityByIDEx(netData,v[1],v[2],true)
if spe then
return spe,v
end
end
end
end
end

local SpecialityPreviewFunc={
[1]=function(sprcialityList)
local state=false
if sprcialityList[DISCIPLE_SPECIALITY_TYPE.eBody]then
state=sprcialityList[DISCIPLE_SPECIALITY_TYPE.eBody].len>=1
end
return state
end,
[2]=function(sprcialityList)
local state=false
if sprcialityList[DISCIPLE_SPECIALITY_TYPE.eSpiritRoot]then
state=sprcialityList[DISCIPLE_SPECIALITY_TYPE.eSpiritRoot].len==1
end
return state
end,
[3]=function(sprcialityList)
local cfg=cfgHelper.get1(cfg_yinxiantaitzpreviewconfig_get,3)
if cfg.tzmatelist then
for type,list in pairs(cfg.tzmatelist)do
for index,id in pairs(list)do
if sprcialityList[type]and sprcialityList[type][id]then
return true
end
end
end
end
return false
end,
[4]=function(sprcialityList)
local cfg=cfgHelper.get1(cfg_yinxiantaitzpreviewconfig_get,4)
if cfg.tzmatelist then
for type,list in pairs(cfg.tzmatelist)do
for index,id in pairs(list)do
if sprcialityList[type]and sprcialityList[type][id]then
return true
end
end
end
end
return false
end,
[5]=function(sprcialityList)
local state=false
if sprcialityList[DISCIPLE_SPECIALITY_TYPE.eSpiritRoot]then
state=sprcialityList[DISCIPLE_SPECIALITY_TYPE.eSpiritRoot].len==5
end
return state
end,
}
function UIDiscipleModel.getSpecialityPreviewList(netdata)
if netdata.specialitylistlen or 0>0 then
local sprcialityList={}
for k,v in pairs(netdata.specialityList)do
sprcialityList[v.specialitytype]={}
local temp=sprcialityList[v.specialitytype]
temp.len=v.len
if v.specialityLst then
for kk,vv in pairs(v.specialityLst)do
temp[vv.param_1]=vv
end
end
end

local tzpreviewsort=cfgHelper.getdef(cfg_yinxiantaitzpreviewconfig,"sort")
local tzpreviewList={}
local tzpreviewCfg=cfg_yinxiantaitzpreviewconfig()
for k,v in pairs(tzpreviewsort)do
local func=SpecialityPreviewFunc[v]
if func and func(sprcialityList)then
tzpreviewList[#tzpreviewList+1]=tzpreviewCfg[v]
end
end
return tzpreviewList
end
end

function UIDiscipleModel.checkCompareSpecialList(guid,splist)
local netData=UIDiscipleModel:getDiscipleData(guid)
local tzlist=netData.specialitylistlookup
local list={}
for k,v in pairs(splist)do
local tztype=v[1]
local tzid=v[2]
if tzlist[tztype]~=nil then
for _,tzdata in pairs(tzlist[tztype])do
if tzdata.param_1==tzid then
table.insert(list,v)
end
end
end
end
return list
end

function UIDiscipleModel.getSpecialityList(guid,specialityType)
local netdata=UIDiscipleModel:getDiscipleData(guid)
if netdata.specialitylistlen or 0>0 then
local sprcialityList={}
for k,v in pairs(netdata.specialityList)do
sprcialityList[v.specialitytype]={}
local temp=sprcialityList[v.specialitytype]
temp.len=v.len
if v.specialityLst then
for kk,vv in pairs(v.specialityLst)do
temp[vv.param_1]=vv
end
end
end
if specialityType then
return sprcialityList[specialityType]
else
return sprcialityList
end
end
end



function UIDiscipleModel.checkDZHasLoveSpeciality(netdata)
if netdata.specialitylistlen or 0>0 then
for _,v in pairs(netdata.specialityList)do
if v.specialityLst then
local spetype=v.specialitytype
for _,vv in pairs(v.specialityLst)do
local speid=vv.param_1
if UIDiscipleModel.checkSpecialityLove(spetype,speid)then
return true
end
end
end
end
end
return false
end

function UIDiscipleModel.getSpecialityLoveLookup()
return _specialityLoveLookup
end

function UIDiscipleModel.getSpecialityLoveLookupByGuildOrder(specialityLoveList)
local lp=UIDiscipleModel.getSpecialityLoveLookup()
local lp_={}
if lp~=nil and specialityLoveList~=nil then

for i,v in ipairs(specialityLoveList)do
local flag=math.floor(v/1000000)
local n=v%1000000
local spetype=math.floor(n/10000)
local speid=n%10000
if lp_[spetype]==nil then
lp_[spetype]={}
end
if flag==1 then
lp_[spetype][speid]=true
else
lp_[spetype][speid]=false
end
end
end
return lp_
end

function UIDiscipleModel.getSpecialityLoveListByGuildOrder(specialityLoveList)
local lp=UIDiscipleModel.getSpecialityLoveLookup()or{}
local list={}
local c=0
local isChange=false

if specialityLoveList==nil or#specialityLoveList<=0 then
for spetype,v in pairs(lp)do
for speid,_ in pairs(v)do
c=c+1
list[c]=1000000+spetype*10000+speid
end
end
if specialityLoveList==nil then
isChange=true
else
isChange=c>0
end
else
local lp_=UIDiscipleModel.getSpecialityLoveLookupByGuildOrder(specialityLoveList)
for spetype,v in pairs(lp)do
for speid,_ in pairs(v)do
c=c+1
local flag=true
if lp_[spetype]and lp_[spetype][speid]==false then
flag=false
end
local flag_v=flag==true and 1 or 0
list[c]=flag_v*1000000+spetype*10000+speid
local flag2
if lp_[spetype]then
flag2=lp_[spetype][speid]
end
if flag~=flag2 then
isChange=true
end
end
end
for spetype,v in pairs(lp_)do
for speid,_ in pairs(v)do
if lp[spetype]==nil or lp[spetype][speid]==nil then
isChange=true
end
end
end
end
return list,isChange
end

function UIDiscipleModel.clearSpecialityLove()
_specialityLoveLookup=nil
end

function UIDiscipleModel.loveSpeciality(len,array)
local lp={}
if len>0 then
for _,v in ipairs(array)do
local spetype=math.floor(v/10000)
local speid=v%10000
if lp[spetype]==nil then
lp[spetype]={}
end
lp[spetype][speid]=true
end
end
_specialityLoveLookup=lp
end

function UIDiscipleModel.recordSpecialityLove(spetype,speid,flag)
local lp=_specialityLoveLookup
if lp==nil then
UIDiscipleModel.loveSpeciality(0,nil)
lp=_specialityLoveLookup
end
local changed=false
if flag then
if lp[spetype]==nil then
lp[spetype]={}
end
if lp[spetype][speid]==nil then
lp[spetype][speid]=true
changed=true
end
else
if lp[spetype]~=nil then
if lp[spetype][speid]==true then
lp[spetype][speid]=nil
changed=true
end
end
end
if changed then

local orderlist={GUILD_ORDER_TYPE.eQuicklyZhaoMu,GUILD_ORDER_TYPE.eAutoBaiShan}
for _,orderID in ipairs(orderlist)do
local f,flag_
local changed_=false
local setup=guildOrderModel:getSetupData(orderID)

local specialityLoveList=setup.specialityLoveList
for i,v in ipairs(specialityLoveList)do
local flag__=math.floor(v/1000000)
local n=v%1000000
local spetype_=math.floor(n/10000)
local speid_=n%10000
if spetype_==spetype and speid_==speid then
f=i
if flag__==1 then
flag_=true
else
flag_=false
end
break
end
end
if flag then
if flag_~=flag then
local n=flag==true and 1 or 0
local v=n*1000000+spetype*10000+speid
if flag_~=nil then
specialityLoveList[f]=v
else
specialityLoveList[#specialityLoveList+1]=v
end
changed_=true
end
else
if flag_~=nil then
table.remove(specialityLoveList,f)
changed_=true
end
end
if changed_ then
guildOrderModel:flushSetupData(orderID)
end
end

local list={}
local c=0
for spetype_,v in pairs(lp)do
for speid_,_ in pairs(v)do
c=c+1
list[c]=spetype_*10000+speid_
end
end
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.SpecialityMark,c,list)
end
end

function UIDiscipleModel.checkSpecialityLove(spetype,speid)
local lp=_specialityLoveLookup
if lp~=nil then
if lp[spetype]~=nil then
return lp[spetype][speid]==true
end
end
return false
end

function UIDiscipleModel:getSpecialityLoveNum()
local c=0
local lp=_specialityLoveLookup
if lp~=nil then
for spetype_,v in pairs(lp)do
for speid_,_ in pairs(v)do
c=c+1
end
end
end
return c
end

function UIDiscipleModel.getSpecialityLoveNumMax()
return cfgHelper.get2(cfg_disciplespecialityconfig_get,1,'maxLoveNum')
end

function UIDiscipleModel.canSpecialityLove(spetype,speid,isWarning)
local cfg=TeZhiTuJianModel:getCofig(spetype,speid)
if cfg==nil then return end
if not cfg.canLove then return end
local max=UIDiscipleModel.getSpecialityLoveNumMax()
local cur=UIDiscipleModel:getSpecialityLoveNum()
if cur>=max then
if isWarning==true then
UIManager.error(FMT.fmt('最多可关注{0}个特质',max))
end
return false
end
return true
end
