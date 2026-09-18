





fullScreenModel={}
local _cfg

local _fullTabLimitType=
{
eSystem=1,
eLevel=2,
eZheXianLing=3,
eBuildLevel=4,
eVerifyShield=10,
}

fullScreenModel.LimitType=_fullTabLimitType


function fullScreenModel.getFullTabConfig(tabType)
if _cfg==nil then
_cfg={}
local cfgs=cfg_fulltabconfig()
for _,v in pairs(cfgs)do
_cfg[v.cfgid]=v
end
end
return _cfg[tabType]
end

function fullScreenModel.getFullTabAssetConfig(tabType)
local tabConfig=fullScreenModel.getFullTabConfig(tabType)
return cfg_fulltabassetconfig_get(tabConfig.icon)
end


function fullScreenModel.getActiveTablist(tablist,attach)
local temp={}
for i,v in ipairs(tablist)do
local tabType=v.tabType
if fullScreenModel.isTabActive(tabType,v.checkOpen,attach)then
v.tabIndex=i
temp[#temp+1]=v
end
end
return temp
end


function fullScreenModel.isTabActive(tabType,checkFunc,attach)
local fulltabconfig=fullScreenModel.getFullTabConfig(tabType)
local rule=fulltabconfig.localshowrule
if rule~=1 then
local ret,args=fullScreenModel.checkCND(fulltabconfig.cnd)
if not ret then
return ret,args
end
if checkFunc then
return checkFunc(attach)
end
return true
end
return true
end

function fullScreenModel.showTabWarning(tabType)
local fulltabconfig=fullScreenModel.getFullTabConfig(tabType)
local ret,args=fullScreenModel.checkCND(fulltabconfig.cnd)
if ret==false then
local typo=args[1]
local val=args[2]
local val2=args[3]
if typo==_fullTabLimitType.eSystem then
local desc=systemModel.getOpenTips(val)
UIManager.error(desc)
elseif typo==_fullTabLimitType.eLevel then
local sysname=systemConfig.getSystemName(val)
UIManager.error(FMT.fmt('宗门等级达到{0}级开启',val))
elseif typo==_fullTabLimitType.eZheXianLing then
local bookStr=mathHelper.numberToChinese(val)
if val2 and val2>0 then
local chapterStr=mathHelper.numberToChinese(val2)
return FMT.fmt('完成谪仙令{0}卷{1}章开启',bookStr,chapterStr)
else
return FMT.fmt('完成谪仙令{0}卷开启',bookStr)
end
elseif typo==_fullTabLimitType.eBuildLevel then
local sfId=zongmenModel:getMountainId()
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,val)
local level=0
if bdDatas[1]and bdDatas[1].level then
level=bdDatas[1].level
end
if not level or level<val2 then
local config=cfgHelper.get1(cfg_monijybuildconfig_get,val)
local name=config.name
return FMT.fmt('{0}{1}级解锁{2}',name,val2,fulltabconfig.tabname)
end
end
end
end

function fullScreenModel.checkTabEnoughCND(tabType,warning)
local fulltabconfig=fullScreenModel.getFullTabConfig(tabType)
local ret,args=fullScreenModel.checkCND(fulltabconfig.cnd)
if warning and ret==false then
local typo=args[1]
local val=args[2]
local val2=args[3]
if typo==_fullTabLimitType.eSystem then
local sysname=systemConfig.getSystemName(val)
UIManager.info(FMT.fmt('{0}系统开启后开启',sysname))
elseif typo==_fullTabLimitType.eLevel then
UIManager.info(FMT.fmt('宗门等级达到{0}级开启',val))
elseif typo==_fullTabLimitType.eZheXianLing then
local bookStr=mathHelper.numberToChinese(val)
local str
if val2 and val2>0 then
local chapterStr=mathHelper.numberToChinese(val2)
str=FMT.fmt('完成谪仙令{0}卷·第{1}章开启',bookStr,chapterStr)
else
str=FMT.fmt('完成谪仙令{0}卷开启',bookStr)
end
UIManager.info(str)
elseif typo==_fullTabLimitType.eBuildLevel then
local sfId=zongmenModel:getMountainId()
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,val)
local level=0
if bdDatas[1]and bdDatas[1].level then
level=bdDatas[1].level
end
if not level or level<val2 then
local config=cfgHelper.get1(cfg_monijybuildconfig_get,val)
local name=config.name
local str=FMT.fmt('{0}{1}级解锁{2}',name,val2,fulltabconfig.tabname)
UIManager.info(str)
end
elseif typo==_fullTabLimitType.eVerifyShield then
UIManager.info('系统尚未开启')
end
end
return ret
end

function fullScreenModel.isTabOpen(tabType,warning)
if not fullScreenModel.checkTabEnoughCND(tabType,warning)then
return false
end
return true
end


function fullScreenModel.checkCND(cnd)
if cnd==nil then return true end
local GameVersion=pfwindowslController:getGameVersion()
cnd=cnd[GameVersion]or cnd[1]
if cnd==nil then return true end
local args=nil
for i,v in ipairs(cnd)do
local openFlag=true
for ii,vv in ipairs(v)do
local typo=vv[1]
local val=vv[2]
local val2=vv[3]
openFlag=openFlag and fullScreenModel.isEnoughSingleCnd(typo,val,val2)
if not openFlag and args==nil then
args={typo,val,val2}
end
end
if openFlag then
return true
end
end
return false,args
end


function fullScreenModel.isEnoughSingleCnd(typo,val,val2)
if val==nil then



return true
end
if typo==_fullTabLimitType.eSystem then
return systemModel.isOpen(val)
elseif typo==_fullTabLimitType.eLevel then
return playerModel:getActorLevel()>=val
elseif typo==_fullTabLimitType.eZheXianLing then
local book_id=val
local index=val2
if index and index>0 then
local chapterid=zheXianLingConfig.getChapterId(book_id,index)
return zheXianLingModel:isRewardChapter(chapterid)
else
return zheXianLingModel:isRewardBook(book_id)
end
elseif typo==_fullTabLimitType.eBuildLevel then
local sfId=zongmenModel:getMountainId()
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,val)
local level=0
if bdDatas[1]and bdDatas[1].level then
level=bdDatas[1].level
end
return level and level>=val2
elseif typo==_fullTabLimitType.eVerifyShield then
if verifyManager:isOpen()then
return false
end
return true
else



end
return false
end


function fullScreenModel.getFullTabMoneyByConfig(tabType)
local fulltabconfig=fullScreenModel.getFullTabConfig(tabType)
return fulltabconfig.money
end
