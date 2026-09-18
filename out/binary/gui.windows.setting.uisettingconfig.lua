UISettingConfig={}

local kuangType={
head=1,
headKuang=2,
chatKuang=3,
zongmen=4,
feijian=5,
yunzhou=6,
}

local unlockType=
{
eLevel=1,
eItem=2,
eItemChange=3,
eFSRank=4,
}

local kuangHideType=
{
eNotHide=0,
eLockHide=1,
eAlwaysHide=2,
}

local settingActiveType=
{
eLimit=1,
eForever=2,
}

KUANGE_TYPE=kuangType
KUANGE_UNLOCK_TYPE=unlockType
KUANGE_HIDE_TYPE=kuangHideType
SETTING_ACTIVE_TYPE=settingActiveType

local _cfg
local _lookup
local _list
local _sexlookup

function UISettingConfig.initCfg()
if _cfg==nil then
_cfg={}
_lookup={}
_list={}
_sexlookup={}

local typo=KUANGE_TYPE.head
_cfg[typo]={}
_lookup[typo]={}
_list[typo]={}

local headCfg=_cfg[typo]
local headCfgLookup=_lookup[typo]
local headCfgList=_list[typo]

local cfgs=cfg_headportraitconfig()
for i,v in ipairs(cfgs)do
headCfg[v.id]=v

if v.unlock and v.unlock.type==2 then
if headCfgLookup[v.sex]==nil then headCfgLookup[v.sex]={}end
local headSexCfgLookup=headCfgLookup[v.sex]
headSexCfgLookup[v.unlock.param[1]]=v

if _sexlookup[v.sex]==nil then _sexlookup[v.sex]={}end
local sexlookup=_sexlookup[v.sex]
sexlookup[v.unlock.param[1]]={v,typo}
end

if headCfgList[v.sex]==nil then headCfgList[v.sex]={}end
local headSexCfgList=headCfgList[v.sex]
headSexCfgList[#headSexCfgList+1]=v

end

local typo=KUANGE_TYPE.headKuang
_cfg[typo]={}
_lookup[typo]={}
_list[typo]={}

local headKuangCfg=_cfg[typo]
local headKuangLookup=_lookup[typo]
local headKuangList=_list[typo]

local cfgs=cfg_headportraitframeconfig()
for i,v in ipairs(cfgs)do
headKuangCfg[v.id]=v

if v.unlock and v.unlock.type==2 then
if headKuangLookup[0]==nil then headKuangLookup[0]={}end
local headKuangSexLookup=headKuangLookup[0]
headKuangSexLookup[v.unlock.param[1]]=v

if _sexlookup[0]==nil then _sexlookup[0]={}end
local sexlookup=_sexlookup[0]
sexlookup[v.unlock.param[1]]={v,typo}
end
end
headKuangList[0]=cfgs


local typo=KUANGE_TYPE.chatKuang
_cfg[typo]={}
_lookup[typo]={}
_list[typo]={}

local chatKuangCfg=_cfg[typo]
local chatKuangLookup=_lookup[typo]
local chatKuangList=_list[typo]

local cfgs=cfg_bubbleframeconfig()
for i,v in ipairs(cfgs)do
chatKuangCfg[v.id]=v

if v.unlock and v.unlock.type==2 then
if chatKuangLookup[0]==nil then chatKuangLookup[0]={}end
local chatKuangSexLookup=chatKuangLookup[0]
chatKuangSexLookup[v.unlock.param[1]]=v

if _sexlookup[0]==nil then _sexlookup[0]={}end
local sexlookup=_sexlookup[0]
sexlookup[v.unlock.param[1]]={v,typo}
end
end
chatKuangList[0]=cfgs

local newType={
{typo=KUANGE_TYPE.zongmen,cfgs=cfg_sectdressconfig()},

{typo=KUANGE_TYPE.yunzhou,cfgs=cfg_boatdressconfig()},
}
for _,V in ipairs(newType)do
local typo=V.typo
_cfg[typo]={}
_lookup[typo]={}
_list[typo]={}

local settingtypeCfg=_cfg[typo]
local settingtypeLookup=_lookup[typo]
local settingtypeList=_list[typo]

local cfgs=V.cfgs
for i,v in pairs(cfgs)do
settingtypeCfg[v.id]=v
if v.unlock then
if v.unlock.type==2 then
if settingtypeLookup[0]==nil then settingtypeLookup[0]={}end
local settingtypeSexLookup=settingtypeLookup[0]
settingtypeSexLookup[v.unlock.param[1]]=v
if _sexlookup[0]==nil then _sexlookup[0]={}end
local sexlookup=_sexlookup[0]
sexlookup[v.unlock.param[1]]={v,typo}
elseif v.unlock.type==3 then
for __,vv in ipairs(v.unlock.param)do
if settingtypeLookup[0]==nil then settingtypeLookup[0]={}end
local settingtypeSexLookup=settingtypeLookup[0]
settingtypeSexLookup[vv[1]]=v
if _sexlookup[0]==nil then _sexlookup[0]={}end
local sexlookup=_sexlookup[0]
sexlookup[vv[1]]={v,typo}
end
end
end
end
settingtypeList[0]=cfgs
end
end
end

function UISettingConfig.getCfg(typo,id)
UISettingConfig.initCfg()
return _cfg[typo][id]
end

function UISettingConfig.getSelfCfgByItemid(typo,itemid)
if not playerModel:checkInit()then return end
local sex=playerModel:getActorSex()
return UISettingConfig.getCfgByItemid(typo,sex,itemid)
end

function UISettingConfig.getCfgByItemid(typo,sex,itemid)
UISettingConfig.initCfg()
local sexlookup=_lookup[typo][sex]or _lookup[typo][0]
return sexlookup[itemid]
end

function UISettingConfig.getSelfAllCfg(typo)
if not playerModel:checkInit()then return end
local sex=playerModel:getActorSex()
return UISettingConfig.getAllCfg(typo,sex)
end

function UISettingConfig.getAllCfg(typo,sex)
UISettingConfig.initCfg()
return _list[typo][sex]or _list[typo][0]
end

function UISettingConfig.getSelfCfgBySex(itemid)
UISettingConfig.initCfg()
local sex=playerModel:getActorSex()
return UISettingConfig.getCfgBySex(sex,itemid)
end


function UISettingConfig.getCfgBySex(sex,itemid)
UISettingConfig.initCfg()
return _sexlookup[sex][itemid]or _sexlookup[0][itemid]
end