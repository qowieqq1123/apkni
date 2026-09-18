





systemConfig={}


SYSTEM_OPEN_TYPE=
{
eZongmemLevelChanged=1,
eTaskFinish=2,
eOpenServerTime=3,
eKillBoss=4,
eCreatedBuild=5,
eZheXianLingBook=6,
eItemOrMoney=7,
eOpenServerTimeRandom=8,
eXianTuLevel=9,
eWuXingShengDianOpen=10,
eServerPlatform=11,
eServerPlatformOpen=12,
eJiuChongTianJieOpenDay=13,
eJiuChongTianJieJinDu=14,
eSysOpenDay=15,
eDiscipleReachJJ=16,
eDiscipleXianMoNum=17,
eReBuildXianYuTask=18,
eGameAreaVersion=19,
eZongMenFullLevel=20,
eXianJieEntityStage=21,
eQuKuaiUnLock=22,
}

local _systemOpenCndLookup=nil

local _extraSystemOpenCndLookup=
{
[SYSTEM_DEFINE.eLimitedTimeGift2]=function()

return not pushGiftThreeConfig.isCanOpenByPf()
end,
[SYSTEM_DEFINE.eLimitedTimeGift3]=function()
return pushGiftThreeConfig.isCanOpenByPf()
end,
}


local _retSkipCND=
{
[SYSTEM_OPEN_TYPE.eOpenServerTimeRandom]=true,
[SYSTEM_OPEN_TYPE.eServerPlatform]=true,
[SYSTEM_OPEN_TYPE.eServerPlatformOpen]=true,
[SYSTEM_OPEN_TYPE.eGameAreaVersion]=true,
}


function systemConfig.getAllSystemConfig()
return cfg_systemopenconfig()
end

function systemConfig.getSystemConfig(sysid)
return cfg_systemopenconfig_get(sysid)
end

function systemConfig.getSystemName(sysid)
local conf=systemConfig.getSystemConfig(sysid)
if conf then
return conf.name
end
end


function systemConfig.handleConfigOpenCnd()
if not _systemOpenCndLookup then
_systemOpenCndLookup={}
local systemopenconfigs=systemConfig.getAllSystemConfig()
for id,v in pairs(systemopenconfigs)do
local sysid=id
for i,v in ipairs(v.openargs)do
for ii,vv in ipairs(v)do
local typo=vv[1]
local val=vv[2]or 0
local val2=vv[3]
if typo==SYSTEM_OPEN_TYPE.eZheXianLingBook then
val2=val2 or 0
end
if _systemOpenCndLookup[typo]==nil then _systemOpenCndLookup[typo]={}end
if _systemOpenCndLookup[typo][val]==nil then _systemOpenCndLookup[typo][val]={}end
local lookup=_systemOpenCndLookup[typo][val]
if val2 then
if _systemOpenCndLookup[typo][val][val2]==nil then _systemOpenCndLookup[typo][val][val2]={}end
lookup=_systemOpenCndLookup[typo][val][val2]
end
lookup[#lookup+1]=sysid
end
end
end
end
end


function systemConfig.getCheckListByConfig(openType,val,val2)
systemConfig.handleConfigOpenCnd()
if _systemOpenCndLookup[openType]==nil then return{}end
if val2==nil then
return _systemOpenCndLookup[openType][val]or{}
else
if _systemOpenCndLookup[openType][val]==nil then return{}end
return _systemOpenCndLookup[openType][val][val2]or{}
end
end


function systemConfig.isEnoughConfigOpenCnd(sysid,retErr)
if retErr==nil then retErr=true end

if _extraSystemOpenCndLookup[sysid]then
if not _extraSystemOpenCndLookup[sysid]()then
if retErr then
return false,{-1,sysid}
end
return false
end
end
local config=systemConfig.getSystemConfig(sysid)
if config==nil then return false end
local firstArgs=nil
local args
local group
for i,v in ipairs(config.openargs)do
local openFlag=true
local enoughGroup=true
local curArgs
for ii,vv in ipairs(v)do
local canOpen=systemConfig.isEnoughSingleCnd(unpack(vv))
openFlag=openFlag and canOpen
if retErr then
if not canOpen and group==nil then

if i==1 then
if firstArgs==nil then
firstArgs=vv
else
local openType=firstArgs[1]
if _retSkipCND[openType]then
firstArgs=vv
end
end
end


if curArgs==nil then
curArgs=vv
else
local openType=curArgs[1]
if _retSkipCND[openType]then
curArgs=vv
end
end


local openType=vv[1]
if _retSkipCND[openType]then
enoughGroup=false
end
end
end
end
if openFlag then
return true
end
if retErr then
if enoughGroup and group==nil and not openFlag then
group=true
args=curArgs
end
end
end
args=args or firstArgs
return false,args
end

function systemConfig.isEnoughReallyConfigOpenCnd(sysid)
local config=systemConfig.getSystemConfig(sysid)
if config==nil then return false end
for i,v in ipairs(config.openargs)do
local openFlag=true
for ii,vv in ipairs(v)do
openFlag=openFlag and systemConfig.isEnoughSingleCnd(unpack(vv))
end
if openFlag then
return true
end
end
return false
end

local _openCND={
[SYSTEM_OPEN_TYPE.eZongmemLevelChanged]=function(val,val2)
local curVal=zongmenModel:getLevel()
return curVal>=val
end,
[SYSTEM_OPEN_TYPE.eTaskFinish]=function(val,val2)
local isFinish=taskModel:checkTaskFinish(val)
return isFinish
end,
[SYSTEM_OPEN_TYPE.eOpenServerTime]=function(val,val2)
local openDay=timeHelper.getServerOpenDay()
return openDay>=val
end,
[SYSTEM_OPEN_TYPE.eKillBoss]=function(val,val2)
return false
end,
[SYSTEM_OPEN_TYPE.eCreatedBuild]=function(val,val2)
local datas=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,val)
return datas and#datas>0
end,
[SYSTEM_OPEN_TYPE.eZheXianLingBook]=function(val,val2)
local book_id=val
local index=val2
return zheXianLingModel:checkFinish(book_id,index)
end,
[SYSTEM_OPEN_TYPE.eItemOrMoney]=function(val,val2)
local num=itemsModel.getCount(val)
return num>=val2
end,
[SYSTEM_OPEN_TYPE.eOpenServerTimeRandom]=function(val,val2)
local startStamp=timeHelper.getDateStamp(val)
local endStamp=timeHelper.getDateStamp(val2)
local stamp=timeHelper.getServerOpenLongTime()
return stamp>=startStamp and stamp<=endStamp
end,
[SYSTEM_OPEN_TYPE.eXianTuLevel]=function(val,val2)
return xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.ZongMenXianTu,val)
end,
[SYSTEM_OPEN_TYPE.eWuXingShengDianOpen]=function(val,val2)
return wuXingDianModel:isOpenSDByData()
end,
[SYSTEM_OPEN_TYPE.eServerPlatform]=function(val,val2)
local serverPlatform=gameUtilityModel.getServerPlatform()
local check=val[serverPlatform]
return check==nil
end,
[SYSTEM_OPEN_TYPE.eServerPlatformOpen]=function(val,val2)
local serverPlatform=gameUtilityModel.getServerPlatform()
local check=val[serverPlatform]
return check~=nil
end,
[SYSTEM_OPEN_TYPE.eJiuChongTianJieOpenDay]=function(val,val2)
local sec=JiuChongTianJieEnterModel:getOpenTianJieSec()


local zerotime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())
return(math.floor(sec/86400)+val-1)*86400<=zerotime
end,
[SYSTEM_OPEN_TYPE.eJiuChongTianJieJinDu]=function(val,val2)
if not systemModel.isOpen(SYSTEM_DEFINE.eTianJieQianZou)then
return false
end
local progress=JiuChongTianJieEnterModel:getAllProgress()
if val==100 then
return progress>=val and JiuChongTianJieEnterModel:isSelectFeiShengGuid()and JiuChongTianJieEnterController.isPVComplete~=nil
else
return progress>=val
end


end,
[SYSTEM_OPEN_TYPE.eSysOpenDay]=function(val,val2)


if not systemModel.isOpen(val)then
return false
end
local openSec=systemModel.getSystemOpenTime(val)
if not openSec then
return false
end
local zerotime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())
return(math.floor(openSec/86400)+val2-1)*86400<=zerotime
end,
[SYSTEM_OPEN_TYPE.eDiscipleReachJJ]=function(val,val2)
local selectFunc=function(netData)
return netData.jingjielv>=val
end
local dzlist=UIDiscipleModel:getSortList(selectFunc,nil)or{}

return#dzlist>0
end,
[SYSTEM_OPEN_TYPE.eReBuildXianYuTask]=function(val,val2)
if val2==0 and seasonController:checkSeasonStageBegined_NotCheckCondition(0,val)then
return true
end
if val2==1 and seasonController:checkSeasonStageEnded_NotCheckCondition(0,val)then
return true
end
return false
end,
[SYSTEM_OPEN_TYPE.eGameAreaVersion]=function(val,val2)
return pfwindowslController:getGameVersion()==val
end,
[SYSTEM_OPEN_TYPE.eXianJieEntityStage]=function(val,val2)
local value=xianjieController:getjieshuData(val)
if value then
return value>=val2
end
return false
end,
[SYSTEM_OPEN_TYPE.eZongMenFullLevel]=function(val,val2)
return zongmenModel:isMaxLv()
end,
[SYSTEM_OPEN_TYPE.eQuKuaiUnLock]=function(val,val2)
local data=worldBlockModel:getBlockState(val,val2)
return data==eWorldBlockState.OPEN
end,

}


function systemConfig.isEnoughSingleCnd(typo,val,val2)
if _openCND[typo]then
return _openCND[typo](val,val2)
end
return false
end

function systemConfig.isShield(sysid)
local config=systemConfig.getSystemConfig(sysid)
if config==nil then return true end
return config.shield==true
end


function systemConfig.isVerifyShield(sysid)
local config=systemConfig.getSystemConfig(sysid)
if config==nil then return true end
if config.verifyShield and verifyManager:isOpen()then
local GameVersion=pfwindowslController:getGameVersion()
if config.verifyShield[GameVersion]then
return true
end
end
return false
end
