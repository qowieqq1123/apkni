













jiuChongTianJieSubSysBase={}
function jiuChongTianJieSubSysBase.new(class)
local _clone={}
if class then
for i,v in pairs(class)do
_clone[i]=v
end
_clone._base=class

end
if class.sysType==nil then
logErr('没有传入类型 ')
end
local clone_mt={}
clone_mt.__index=jiuChongTianJieSubSysBase
setmetatable(_clone,clone_mt)
JiuChongTianJieEnterModel.bindSubClass(_clone)
return _clone
end

jiuChongTianJieSubSysBase.progressType=eJiuChongTianJieSysType.ePrecent

jiuChongTianJieSubSysBase.showProgessNum=0

jiuChongTianJieSubSysBase.isShowProgress=true

function jiuChongTianJieSubSysBase:checkOpen()
local config=self:getConfig()
local sysId=config.sysid
if sysId then
return systemModel.isOpen(sysId)
end
end

function jiuChongTianJieSubSysBase:getOpenTips()
local config=self:getConfig()
local sysId=config.sysid
if sysId then
return systemModel.getOpenTips(sysId)
end
end


function jiuChongTianJieSubSysBase:getColdDay()
local config=self:getConfig()
local sysId=config.sysid
if sysId then
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(sysId,true)
if not isCan then
local typo=errArgs[1]
local val=errArgs[2]
local val2=errArgs[3]
if typo==SYSTEM_OPEN_TYPE.eSysOpenDay then
local openSec=systemModel.getSystemOpenTime(val)
if not openSec then
loggerUtil.logErrFMT("系统配置有误，条件配置了已开过的系统,没有生成开启时间")
return 0
end
local zerotime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())

return(math.floor(openSec/86400)+val2-1)-(math.floor(zerotime/86400))
end
end
end
return 0
end

function jiuChongTianJieSubSysBase:checkFinish()
local progress,Max=self:getProgress()
return Max>0 and progress>=Max
end

function jiuChongTianJieSubSysBase:getProgress()
return 0,100
end


function jiuChongTianJieSubSysBase:getReddot(isEnter)
return false
end

function jiuChongTianJieSubSysBase:getConfig()
return cfgHelper.get(cfg_jctjsubsysconfig_get,self.sysType)
end

function jiuChongTianJieSubSysBase:doJump()
local subConfig=self:getConfig()
local argsScenetype=subConfig.scenetype
local scenetype
if argsScenetype then
scenetype=argsScenetype
end
local func=function()
return self:jump()
end

if scenetype then
local mapid
local mapidlist=subConfig.mapid
if mapidlist then
mapid=mapid or mapidlist[1]
end

local isZongMen=scenetype==eSceneType.eZongmen
local isWorld=scenetype==eSceneType.eWorld
if isZongMen then
mapid=mapid or mapIdType.zhufeng
if not mainControl:isInScene(eSceneType.eZongmen)then
if mountainControl:isOpen(mapid,true)then
local args={mapid}
if mainControl:enterHome(args,func)then
return true
end
end
return false
else
if mapidlist and not mountainControl:isInMounts(mapidlist)then
if mountainControl:isOpen(mapid,true)then
return mountainControl:loadAndswitchMapEx(mapid,true,func)
end
return false
end
end
elseif isWorld then
mapid=mapid or 1
if not mainControl:isInScene(eSceneType.eWorld)then
local isOpenArea,err=worldBlockModel:checkWorldEnterLimit(mapid)
if isOpenArea then
local args={mapid}
if mainControl:enterWorld(args,func)then
return true
end
end
UIManager.error(err)
return false
else
if mapidlist and not table.containsValue(mapidlist,worldModel.world)then
local isOpenArea,err=worldBlockModel:checkWorldEnterLimit(mapid)
if isOpenArea then
local args={mapid}
if mainControl:enterWorld(args,func)then
return true
end
end
UIManager.error(err)
return false
end
end
end
end
return func()
end

function jiuChongTianJieSubSysBase:jump()

end

function jiuChongTianJieSubSysBase:getBuffList()
return{}
end


function jiuChongTianJieSubSysBase:checkReward()
return false
end
