mainBtnConfig=gameState.addListener({})

local _creatorDirectory='lua.gui.windows.main.UIChild.%s'
local _iconCfg={}
local _iconTypeCfg={}
local _ctor={}
local _changeCache={}

local _activeLook={}


MAIN_ICON_GROUP_TYPE=
{
eBottom=1,
eRight=2,
}


local _freshType=
{
eBuild=1,
}

function mainBtnConfig:onEnterState()
_activeLook={}
self:initData()
end

function mainBtnConfig:onLeaveState()
_activeLook={}
end

local _idx=0
local _getIdx=function()
_idx=_idx+1
return _idx
end


local _prefabIndex=
{
base=0,
one=1,
two=2,
three=3,
four=4,
}


MAIN_BTNS_TYPE=
{
eLingShou=_getIdx(),
eXianmeng=_getIdx(),
eGuBao=_getIdx(),
eStoreHourse=_getIdx(),
eDizi=_getIdx(),
eBuild=_getIdx(),
eXianTuChengJiu=_getIdx(),
eShop=_getIdx(),
eTask=_getIdx(),
eFuli=_getIdx(),
eTianDaoShu=_getIdx(),
eXianWuLou=_getIdx(),
eXMShop=_getIdx(),
eXMFXZY=_getIdx(),
eXMDD=_getIdx(),
eLingDi=_getIdx(),
eSubXM=_getIdx(),
eSubZM=_getIdx(),
eSubXJBaoLei=_getIdx(),
eSubSHWorld=_getIdx(),
eSubXianJie=_getIdx(),
eSubXianYu=_getIdx(),
eSubWorld=_getIdx(),
eLittleWorld=_getIdx(),
eXianGong=_getIdx(),
eSubMoJie=_getIdx(),
eMoJieShiLi=_getIdx(),
eXJMoJieShiLi=_getIdx(),
eSubXianGong=_getIdx(),
eSubMoJieShiLi=_getIdx(),
eQuickSoldierBuilder=_getIdx(),
eQuickHospitalBuilder=_getIdx(),
eSubLingShouFeng=_getIdx(),
eXZBX=_getIdx(),
eBackZongMen=_getIdx(),
}





MAIN_BTNS_CONFIG=
{
[MAIN_BTNS_TYPE.eLingShou]=
{
creator='UIChildLingShou',
iconType=ICON_TYPE.mainLingShou,
UIPrefabIndex=_prefabIndex.one,
check=function()







return false
end,
},
[MAIN_BTNS_TYPE.eBuild]=
{
creator='UIChildBuild',
iconType=ICON_TYPE.mainJianZao,
check=function()
local flag=true
if mainControl:isSceneType(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.xianmeng)then
local actorid=playerModel:getActorID()
local postType=xianmengModel:getXMMemberPost(actorid)
local privileType=GUILD_PRIVILE_TYPE.gptBuild
flag=xianmengModel.checkPostPrivile(postType,privileType)

end
return flag
end,
},
[MAIN_BTNS_TYPE.eDizi]=
{
creator='UIChildDizi',
iconType=ICON_TYPE.mainDiZi,
},
[MAIN_BTNS_TYPE.eStoreHourse]=
{
creator='UIChildStoreHourse',
iconType=ICON_TYPE.mainBag,
},
[MAIN_BTNS_TYPE.eXianmeng]=
{
creator='UIChildXianmeng',
iconType=ICON_TYPE.mainXianMeng,
check=function()
local flag=false
local isOpenXianJie=xianjieController:checkXianJieSystemOpen()
local isOpenLingShouFeng=systemModel.isOpen(SYSTEM_DEFINE.eLingShouFeng)
if not isOpenXianJie and not isOpenLingShouFeng then

flag=true
else
if mainControl:isSceneType(eSceneType.eZongmen)and not zongmenControl:isMountid(mapIdType.fort)and not zongmenControl:isMountid(mapIdType.lingshoudao)then
local mapId=mapIdType.fort
local hasXJBaoLei=mountainControl:isOpen(mapId)
if not hasXJBaoLei and not isOpenLingShouFeng then
flag=true
end
end
end
return flag
end,
},
[MAIN_BTNS_TYPE.eGuBao]=
{
creator='UIChildGuBao',
iconType=ICON_TYPE.mainGuBao,
check=function()
local flag=true
if mainControl:isSceneType(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.xianmeng)then

local isOpenXianJie=xianjieController:checkXianJieSystemOpen()
local isOpenLingShouFeng=systemModel.isOpen(SYSTEM_DEFINE.eLingShouFeng)
if not isOpenXianJie and isOpenLingShouFeng then

flag=false
end
end

return flag
end,
},
[MAIN_BTNS_TYPE.eXianTuChengJiu]=
{
creator='UIChildXianTuChengJiu',
iconType=ICON_TYPE.mainXianTuChengJiu,
UIPrefabIndex=_prefabIndex.two,
},

[MAIN_BTNS_TYPE.eShop]=
{
creator='UIChildShop',
iconType=ICON_TYPE.mainRecharge,
check=function()
if verifyManager:isHideRecharge()then
return false
end
return true
end,
reddotType=REDDIT_TYPE.eXianGouLiBao,
},
[MAIN_BTNS_TYPE.eFuli]=
{
creator='UIChildFuli',
iconType=ICON_TYPE.mainWelfare,
check=function()
if verifyManager:isHideWelfare()then
return false
end
return true
end,
reddotType=REDDIT_TYPE.eWelfare,
},
[MAIN_BTNS_TYPE.eTask]=
{
creator='UIChildTask',
iconType=ICON_TYPE.mainRiChang,
reddotType=REDDIT_TYPE.eDailyTask,
},
[MAIN_BTNS_TYPE.eTianDaoShu]=
{
creator='UIChildTianDaoShu',
iconType=ICON_TYPE.xmTiandaoshu,
},
[MAIN_BTNS_TYPE.eXianWuLou]=
{
creator='UIChildXianWuLou',
check=function()
local data=zongmenModel:findBuildingDataByType(mapIdType.xianmeng,SLG_SYSTEM_TYPE.eXianWuLou)
return data~=nil
end,
catchType={_freshType.eBuild,SLG_SYSTEM_TYPE.eXianWuLou},
reddotType=REDDIT_TYPE.eXianWuLou,
},
[MAIN_BTNS_TYPE.eXMShop]=
{
creator='UIChildeXMShop',
check=function()
local data=zongmenModel:findBuildingDataByType(mapIdType.xianmeng,SLG_SYSTEM_TYPE.eXianMengShanDian)
return data~=nil
end,
catchType={_freshType.eBuild,SLG_SYSTEM_TYPE.eXianMengShanDian},
},
[MAIN_BTNS_TYPE.eXMFXZY]=
{
creator='UIChildXMFXZY',
check=function()
local data=zongmenModel:findBuildingDataByType(mapIdType.xianmeng,SLG_SYSTEM_TYPE.eXianWuLou)
return data~=nil

end,
catchType={_freshType.eBuild,SLG_SYSTEM_TYPE.eXianWuLou},
},
[MAIN_BTNS_TYPE.eXMDD]=
{
creator='UIChildXMDD',
},
[MAIN_BTNS_TYPE.eXZBX]=
{
creator='UIChildXZBX',
check=function()
local flag=XianMengBaoXiaController:checkIsOpenBaoXiao()
return flag
end,
},
[MAIN_BTNS_TYPE.eLingDi]=
{
creator='UIChildLingDi',
iconType=ICON_TYPE.mainLingDi,
check=function()
local flag=false
local isOpenXianJie=xianjieController:checkXianJieSystemOpen()
local isOpenLingShou=systemModel.isOpen(SYSTEM_DEFINE.eLingShouFeng)
if isOpenXianJie then
if mainControl:isSceneType(eSceneType.eZongmen)and not zongmenControl:isMountid(mapIdType.fort)then
local mapId=mapIdType.fort
local hasXJBaoLei=mountainControl:isOpen(mapId)
if hasXJBaoLei or isOpenLingShou then
flag=true
end
else
flag=true
end
elseif isOpenLingShou then
flag=true
end
local sceneIdx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
flag=false
end
return flag
end,
},
[MAIN_BTNS_TYPE.eBackZongMen]=
{
creator='UIChildBackZongMen',
check=function()
local flag=false
local isOpenXianJie=xianjieController:checkXianJieSystemOpen()
local isOpenLingShouFeng=systemModel.isOpen(SYSTEM_DEFINE.eLingShouFeng)
local mapId=mapIdType.fort
local hasXJBaoLei=mountainControl:isOpen(mapId)
if(not isOpenXianJie or not hasXJBaoLei)and isOpenLingShouFeng then

if mainControl:isSceneType(eSceneType.eZongmen)and(zongmenControl:isMountid(mapIdType.xianmeng)or zongmenControl:isMountid(mapIdType.lingshoudao))then

flag=true
end
end
return flag
end,
},


[MAIN_BTNS_TYPE.eSubXM]=
{
creator='UIChildSubXM',
check=function()
local flag=false
if not mainControl:isSceneType(eSceneType.eZongmen)or not zongmenControl:isMountid(mapIdType.xianmeng)then
flag=true
end
return flag
end,
},

[MAIN_BTNS_TYPE.eSubZM]=
{
creator='UIChildSubZM',
check=function()
local flag=false
if not mainControl:isSceneType(eSceneType.eZongmen)or not zongmenControl:isMountid(mapIdType.zhufeng)then
flag=true
end
return flag
end,
},

[MAIN_BTNS_TYPE.eSubXJBaoLei]=
{
creator='UIChildSubXJBaoLei',
check=function()
local flag=false
local isOpenXianJie=xianjieController:checkXianJieSystemOpen()
local mapId=mapIdType.fort
local hasXJBaoLei=mountainControl:isOpen(mapId)
if isOpenXianJie and hasXJBaoLei then
if not mainControl:isSceneType(eSceneType.eZongmen)or not zongmenControl:isMountid(mapIdType.fort)then
flag=true
end
end
return flag
end,
},

[MAIN_BTNS_TYPE.eSubSHWorld]=
{
creator='UIChildSubSHWorld',
UIPrefabIndex=_prefabIndex.three,
check=function()
local flag=false
local actId=LIMIT_ACT_TYPE.eZhengZhanShanHai
local actInfo=limitActivitiesModel:getActInfo(actId)
if actInfo then
local condCheck,condStr=actInfo:checkCondition()
flag=condCheck
end
return flag
end,
},

[MAIN_BTNS_TYPE.eSubXianJie]=
{
creator='UIChildSubXianJie',
check=function()
local flag=false
local sceneType=xianjienSceneType.eXianJie
if xianjieController:isSceneOpen(sceneType,nil,false)and(not mainControl:isSceneType(eSceneType.eXianJie)or xianjieModel:getScenceType()~=sceneType)then
flag=true
end
return flag
end,
},

[MAIN_BTNS_TYPE.eSubXianYu]=
{
creator='UIChildSubXianYu',
check=function()
local mySceneidx=xianjieModel:getXianYuSceneIndex()
local curSceneidx=xianjieModel:getSceneIndex()
local flag=mySceneidx~=curSceneidx









return flag
end,
},

[MAIN_BTNS_TYPE.eSubWorld]=
{
creator='UIChildSubWorld',
check=function()
local flag=false
if systemModel.isOpen(SYSTEM_DEFINE.eWorld)and not mainControl:isSceneType(eSceneType.eWorld)then
flag=true
end
return flag
end,
},

[MAIN_BTNS_TYPE.eLittleWorld]=
{
creator='UIChildLittleWorld',
check=function()
local flag=true
return flag
end,
},

[MAIN_BTNS_TYPE.eXianGong]=
{
creator='UIChildXianGong',
iconType=ICON_TYPE.xjXianGong,
check=function()
local flag=true
if xianjieController:isMoJiShiLiShow()then
flag=false
end
return flag
end,
},
[MAIN_BTNS_TYPE.eSubMoJie]=
{
creator='UIChildSubMoJie',
UIPrefabIndex=_prefabIndex.four,
check=function()

local data=xianjieModel:getMoJieEnterData()
local nowTime=timeHelper.getServerShortTime()
if data and nowTime<data.eTime and xianjieModel:checkJoin()and MojiePreviewExtendController.checkPoKaiMoJieFlag()
and seasonController:checkSeasonHandleComplete(0)and not seasonController:checkSeasonHandleCompleteButNotOver(0)then
if not mainControl:isSceneType(eSceneType.eXianJie)then
return true
else
local sceneType=xianjieModel:getScenceType()
if not xianjienSceneType:isMoJie(sceneType)then
return true
end
end
end
return false
end,
},

[MAIN_BTNS_TYPE.eMoJieShiLi]=
{
creator='UIChildMoJieShiLi',
check=function()
local flag=false
if xianjieController:isMoJiShiLiShow()then
local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
if isInMoJie then
flag=true
end
end
local sceneIdx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
flag=false
end
return flag
end,
},

[MAIN_BTNS_TYPE.eXJMoJieShiLi]=
{
creator='UIChildXJMoJieShiLi',
check=function()
local flag=false
if xianjieController:isMoJiShiLiShow()then
local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
if not isInMoJie then
flag=true
end
end
local sceneIdx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
flag=false
end
return flag
end,
},

[MAIN_BTNS_TYPE.eSubXianGong]=
{
creator='UIChildSubXianGong',
check=function()
local flag=true
return flag
end,
},

[MAIN_BTNS_TYPE.eSubMoJieShiLi]=
{
creator='UIChildSubMoJieShiLi',
check=function()
local flag=false
if xianjieController:isMoJiShiLiShow()then
flag=true
end
return flag
end,
},

[MAIN_BTNS_TYPE.eQuickSoldierBuilder]=
{
creator='UIQuickSoldierBuilder',
check=function()






return false
end,
},

[MAIN_BTNS_TYPE.eQuickHospitalBuilder]=
{
creator='UIQuickHospitalBuilder',
check=function()
local flag=false
local sceneIdx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
flag=true
end
return flag
end,
},

[MAIN_BTNS_TYPE.eSubLingShouFeng]=
{
creator='UIChildSubLingShouFeng',

check=function()
local flag=false
local isOpenLingShou=systemModel.isOpen(SYSTEM_DEFINE.eLingShouFeng)
if isOpenLingShou then
if not mainControl:isSceneType(eSceneType.eZongmen)or not zongmenControl:isMountid(mapIdType.lingshoudao)then
flag=true
end
end

return flag
end,
},
}


for k,v in pairs(MAIN_BTNS_CONFIG)do

local keyStr=FMT.fmt('UIMain.{0}',v.creator)
v.key=keyStr


if v.UIPrefabIndex==nil then v.UIPrefabIndex=_prefabIndex.base end


if v.src==nil then
v.src=string.format(_creatorDirectory,v.creator)
end


if v.iconType and cfg_systemiconlockconfig_get(v.iconType)==nil then
v.iconType=nil
end


local iconType=v.iconType
if iconType then
_iconTypeCfg[iconType]=keyStr
end
_iconCfg[keyStr]=v

if v.catchType then
local catchType=v.catchType[1]
local catchArgs=v.catchType[2]
if _changeCache[catchType]==nil then _changeCache[catchType]={}end
if _changeCache[catchType][catchArgs]==nil then _changeCache[catchType][catchArgs]={}end
local cache=_changeCache[catchType][catchArgs]
cache[#cache+1]=k
end
end


function mainBtnConfig:initData()
for k,v in pairs(MAIN_BTNS_CONFIG)do
if mainBtnConfig.isActive(v)then
_activeLook[v]=true
end
end
end

local function _PreloadCtor(info)
local src=info.src
local ctor=_ctor[info.creator]
if ctor==nil then
require(src)
ctor=_G[info.creator]
_ctor[info.creator]=ctor
info.ctor=ctor
end
end
mainBtnConfig.PreloadCtor=_PreloadCtor

function mainBtnConfig.getBtnCfg(btnType)
return MAIN_BTNS_CONFIG[btnType]
end

function mainBtnConfig.getAllBtnCfg()
return MAIN_BTNS_CONFIG
end

function mainBtnConfig.isActive(btnType)
local cfg=MAIN_BTNS_CONFIG[btnType]
if cfg==nil then return false end
local ret=false
if cfg.iconType==nil or
systemIconModel.isUnlock(cfg.iconType)then
local check=true
if cfg.check~=nil then
check=cfg.check()
end
if check then
ret=true
end
end
return ret
end

function mainBtnConfig.getBtnKey(btnType)
return mainBtnConfig.getBtnCfg(btnType).key
end


function mainBtnConfig.getIconKey(iconType)
if iconType==nil then return end
if iconType<0 then return end
return _iconTypeCfg[iconType]
end

function mainBtnConfig.getIconTypeList(btnlist)
if btnlist==nil then return{}end
local ret={}
for k,v in pairs(btnlist)do
local cfg=MAIN_BTNS_CONFIG[v]
if cfg then
if cfg.iconType~=nil then
ret[#ret+1]=cfg.iconType
end
end
end
return ret
end

function mainBtnConfig.getReddot(btnlist)
if btnlist==nil then return false end
for k,v in pairs(btnlist)do
local cfg=MAIN_BTNS_CONFIG[v]
if cfg and cfg.reddotType then
local reddot=reddotClassManager.get_reddot(cfg.reddotType)
if reddot then return true end
end
end
return false
end

function mainBtnConfig.getReddotByCfgList(btnCfglist)
if btnCfglist==nil then return false end
for k,v in pairs(btnCfglist)do
if v and v.reddotType then
local reddot=reddotClassManager.get_reddot(v.reddotType)
if reddot then return true end
end
end
return false
end



function mainBtnConfig.freshBtnVis(btnType)
local oldvis=_activeLook[btnType]
local newvis=mainBtnConfig.isActive(btnType)
if oldvis~=newvis then
notifySystem:postNotify(notifyConfig.on_main_btn_state_changed,btnType,oldvis,newvis)
end
end


function mainBtnConfig.freshBuildBtnVis(buildid)
local catchType=_freshType.eBuild
local catchArgs=buildid
if _changeCache[catchType]==nil then return end
if _changeCache[catchType][catchArgs]==nil then return end
for _,btnType in ipairs(_changeCache[catchType][catchArgs])do
mainBtnConfig.freshBtnVis(btnType)
end
end


function mainBtnConfig.freshBuildBtnVis(buildid)
local catchType=_freshType.eBuild
local catchArgs=buildid
if _changeCache[catchType]==nil then return end
if _changeCache[catchType][catchArgs]==nil then return end
for _,btnType in ipairs(_changeCache[catchType][catchArgs])do
mainBtnConfig.freshBtnVis(btnType)
end
end