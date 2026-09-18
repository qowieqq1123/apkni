





systemModel={}


local _systemData={}
local _systemOpenTimeData={}
local _isInit=false



function systemModel.init()
_systemData={}
_systemOpenTimeData={}
_isInit=false
end






function systemModel.onInit(len,list)
if len>0 then
for i=1,len do
local val=list[i]
for j=1,32 do
local flag=mathHelper.getBitValue(val,j-1)
local sysid=(i-1)*32+j
local name=systemConfig.getSystemName(sysid)
if name then

end
systemModel.setOpenFlag(sysid,flag)
end
end
end
_isInit=true
end


function systemModel.checkOpen(index,val)
for j=1,32 do
local flag=mathHelper.getBitValue(val,j-1)
local sysid=(index-1)*32+j
local name=systemConfig.getSystemName(sysid)
if name then

end
end
end


function systemModel.onOpen(sysid)

systemModel.setOpenFlag(sysid,true)
end






function systemModel.setOpenFlag(sysid,flag)
_systemData[sysid]=flag
end

function systemModel.setSystemOpenTime(opensecList)
_systemOpenTimeData={}
for i,v in ipairs(opensecList or{})do
_systemOpenTimeData[v.param_1]=v.param_2
end
end

function systemModel.setSystemOpenStamp(sysid,stamp)
_systemOpenTimeData[sysid]=stamp
end

function systemModel.getSystemOpenTime(sysid)
return _systemOpenTimeData[sysid]
end





function systemModel.isInit()
return _isInit
end

function systemModel.isOpen(sysid,checkShield)
if checkShield~=false and systemConfig.isShield(sysid)then return false end
if systemConfig.isVerifyShield(sysid)then return false end
local ret=_systemData[sysid]or false
return ret
end


function systemModel.isCanOpen(sysid)
if systemConfig.isShield(sysid)then return false end
if systemConfig.isVerifyShield(sysid)then return false end
if systemModel.isOpen(sysid,false)then return false end
local canOpen=systemConfig.isEnoughConfigOpenCnd(sysid,false)
return canOpen
end

function systemModel.getOpenTips(sysid,pre_desc,back_desc)
if systemConfig.isShield(sysid)then return''end
if systemModel.isOpen(sysid,false)then return''end
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(sysid)
if not isCan then
local typo=errArgs[1]
local val=errArgs[2]
local val2=errArgs[3]
local name=systemConfig.getSystemName(sysid)
pre_desc=pre_desc or''
if typo==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then
local level=val
back_desc=back_desc or FMT.fmt('开启{0}',name)
return FMT.fmt('{0}达到宗门{1}级{2}',pre_desc,level,back_desc)
elseif typo==SYSTEM_OPEN_TYPE.eTaskFinish then
local taskname=taskModel:getTaskConfig(val).name
back_desc=back_desc or FMT.fmt('开启{0}',name)
return FMT.fmt('{0}完成任务{1}{2}',pre_desc,taskname,back_desc)
elseif typo==SYSTEM_OPEN_TYPE.eOpenServerTime then
local day=val
back_desc=back_desc or FMT.fmt('开启{0}',name)
return FMT.fmt('{0}开服第{1}天{2}',pre_desc,day,back_desc)
elseif typo==SYSTEM_OPEN_TYPE.eKillBoss then
back_desc=back_desc or FMT.fmt('开启{0}',name)
local boosName=cfgHelper.get1(cfg_monstergroup_get,val).name
return FMT.fmt('{0}击杀{1}{2}',pre_desc,boosName,back_desc)
elseif typo==SYSTEM_OPEN_TYPE.eZheXianLingBook then
local bookStr=mathHelper.numberToChinese(val)
if val2 and val2>0 then
local chapterStr=mathHelper.numberToChinese(val2)
return FMT.fmt('{0}谪仙令{1}卷·第{2}章{3}',pre_desc,bookStr,chapterStr,back_desc or'解锁')
else
return FMT.fmt('{0}谪仙令{1}卷{2}',pre_desc,bookStr,back_desc or'解锁')
end
elseif typo==SYSTEM_OPEN_TYPE.eItemOrMoney then
local itemcfg=itemsConfig.getConfig(val)
back_desc=back_desc or FMT.fmt('开启{0}',name)
return FMT.fmt('{0}{1}数量满足{2}{3}',pre_desc,itemcfg.name,val2,back_desc)
elseif typo==SYSTEM_OPEN_TYPE.eOpenServerTimeRandom then
return'系统尚未开启'
elseif typo==SYSTEM_OPEN_TYPE.eXianTuLevel then
back_desc=back_desc or FMT.fmt('开启{0}',name)
return FMT.fmt('{0}达到仙途{1}级{2}',pre_desc,val,back_desc)
elseif typo==SYSTEM_OPEN_TYPE.eWuXingShengDianOpen then
back_desc=back_desc or FMT.fmt('开启{0}',name)
return FMT.fmt('{0}开启五行圣殿{1}',pre_desc,back_desc)
elseif typo==SYSTEM_OPEN_TYPE.eServerPlatform then
return'系统尚未开放'
elseif typo==SYSTEM_OPEN_TYPE.eServerPlatformOpen then
return'系统尚未开放'
elseif typo==SYSTEM_OPEN_TYPE.eCreatedBuild then
local name=cfgHelper.get2(cfg_monijybuildconfig_get,val,'name')
return FMT.fmt('{0}开启{1}{2}',pre_desc,name,back_desc)
elseif typo==SYSTEM_OPEN_TYPE.eJiuChongTianJieOpenDay then
local sec=JiuChongTianJieEnterModel:getOpenTianJieSec()

local zerotime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())
return FMT.fmt('需要{0}天后开启',(math.floor(sec/86400)+val)-(math.floor(zerotime/86400)))
elseif typo==SYSTEM_OPEN_TYPE.eJiuChongTianJieJinDu then
return'系统尚未开放'
elseif typo==SYSTEM_OPEN_TYPE.eSysOpenDay then
if not systemModel.isOpen(val)then

return FMT.fmt("{0}尚未开启",systemConfig.getSystemName(val))
end
local openSec=systemModel.getSystemOpenTime(val)
if not openSec then
return'系统尚未开启'
end
local zerotime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())

return FMT.fmt('需要{0}天后开启',(math.floor(openSec/86400)+val2-1)-(math.floor(zerotime/86400)))
elseif typo==SYSTEM_OPEN_TYPE.eDiscipleReachJJ then
local jjName=UIDiscipleModel.getJJNameCommon(val,3)
local str
str=FMT.fmt("需要任意弟子达到{0}境界",jjName)
return str
elseif typo==SYSTEM_OPEN_TYPE.eReBuildXianYuTask then
local str
if val2==0 then
str=FMT.fmt("需要开启重建仙域第{0}章",val2)
else
str=FMT.fmt("需要完成重建仙域第{0}章",val2)
end
return str
elseif typo==SYSTEM_OPEN_TYPE.eXianJieEntityStage then
local entityName=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,val,"name")
return FMT.fmt("需要{0}{1}阶",entityName,val2)
elseif typo==SYSTEM_OPEN_TYPE.eZongMenFullLevel then
return'宗门满级开启'
end
end
end

