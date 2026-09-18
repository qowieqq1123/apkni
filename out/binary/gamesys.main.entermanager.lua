enterManager=gameState.addListener(table.weakCopy(sceneBaseControl))

local _bigMax=2
local _nomalMax=6

local _guid=0
local _nomalEnterArray={}
local _bigEnterArray={}
local _lookupInfo={}
local _lookupGUID={}

local _sceneNomalEnterArray={}
local _sceneBigEnterArray={}

local _sceneExtendNomalEnterArray={}
local _sceneExtendBigEnterArray={}
local _sceneExtendGameEnterArray={}
local _sceneExAllNomalEnterArray={}
local _sceneExAllBigEnterArray={}


function enterManager:onAppStart()
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
end

function enterManager:onEnterState(isReconnet)
if isReconnet then return end
self:reset()
end

function enterManager:onLeaveState(isReconnet)
if isReconnet then return end
self:reset()
end

function enterManager:onProtocolReq(...)

end

local getGUID=function()
_guid=_guid+1
return _guid
end

local _fresh=function()
UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
UIManager:invokeUIMethod("UIAct_ExtendEnterWin","refresh")
end

local _freshInfo=function(enterInfo)
if not enterManager:checkActive(enterInfo)then return end
UIManager:callWindowFunc('UIMainEntryWin','freshByInfo',enterInfo)
UIManager:invokeUIMethod("UIAct_ExtendEnterWin","refresh")
end

function enterManager:onChangeScene_(sceneType)

end

function enterManager:onChangeSceneMap_(sceneType,mapId)
enterManager:freshAllEnter()
_fresh()
end

function enterManager:reset()
_nomalEnterArray={}
_bigEnterArray={}
_lookupInfo={}
_lookupGUID={}

_sceneNomalEnterArray={}
_sceneBigEnterArray={}
end


function enterManager:initFixed(sysid)

if sysid==SYSTEM_DEFINE.eFirstRecharge and systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge)then

firstRechargeController:checkFirstRechargeEnter()
end

if sysid==SYSTEM_DEFINE.eFirstRecharge2 and systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge2)then

firstRechargeNewController:checkFirstRechargeEnter()
end

if sysid==SYSTEM_DEFINE.eFirstRecharge3 and systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge3)then

firstRecharge3Controller:checkFirstRechargeEnter()
end

if sysid==SYSTEM_DEFINE.eSevenDayTarget and systemModel.isOpen(SYSTEM_DEFINE.eSevenDayTarget)then

sevenDayGoalController:checkSevenDayGoalEnter()
end

if systemModel.isOpen(SYSTEM_DEFINE.eAuction)then

auctionController:checkAuctionEnter()
end


lundaodahuiController.checkMatchEnterOpen()
lundaodahuiController.checkRongYuTangOpen()

end








function enterManager:checkActive(enterInfo)
if enterInfo==nil then return false end
local enterType=enterInfo.enterType
local mapId=self.mapId
local sceneType=self.sceneType
local mapCfg=enterConfig.getMapCfg(sceneType,mapId)
if mapCfg==nil then return false end
local unknown=mapCfg.unknown
local func=mapCfg[enterType]
if func==nil then
if unknown==false then return false end
return true
end
return func(enterInfo.id)
end

function enterManager:freshAllEnter()
_sceneNomalEnterArray={}
_sceneBigEnterArray={}

local mapId=self.mapId
local sceneType=self.sceneType
local mapCfg=enterConfig.getMapCfg(sceneType,mapId)

if mapCfg==nil then
_sceneNomalEnterArray=table.deepCopy(_nomalEnterArray)
_sceneBigEnterArray=table.deepCopy(_bigEnterArray)
return
end



for _,enterInfo in ipairs(_nomalEnterArray)do
if self:checkActive(enterInfo)then
_sceneNomalEnterArray[#_sceneNomalEnterArray+1]=enterInfo
end
end

for _,enterInfo in ipairs(_bigEnterArray)do
if self:checkActive(enterInfo)then
_sceneBigEnterArray[#_sceneBigEnterArray+1]=enterInfo
end
end


self:checkExtend()
end











function enterManager:freshEnter(enterInfo)
local enterType=enterInfo.enterType
if enterType==nil then
logErr('必须传入类型参数enterType')
return
end

local enterIconType=enterInfo.enterIconType
local array=enterManager:getDataArray(enterIconType)
if array==nil then return end

local cfg=enterConfig.getConfig(enterIconType,enterType)
if cfg==nil then
loggerUtil.logErrFMT('必须有类型{0}的配置',enterType)
return
end

local iconType=cfg.iconType
if iconType and not systemIconModel.isUnlock(iconType)then

return
end

enterInfo.id=enterInfo.id or 1
local id=enterInfo.id

if _lookupInfo[enterIconType]==nil then _lookupInfo[enterIconType]={}end
local lookIconTable=_lookupInfo[enterIconType]

if lookIconTable[enterType]==nil then lookIconTable[enterType]={}end

local lookupTable=lookIconTable[enterType]

local info=lookupTable[id]

local info1=table.deepCopy(enterInfo)
if info then
local guid=info._guid

info1._guid=guid

enterManager:replaceInfo(info1)

enterManager:freshAllEnter()

lookupTable[id]=info1

_lookupGUID[guid]=info1

_freshInfo(enterInfo)
return guid
end

local guid=getGUID()
info1._guid=guid

lookupTable[id]=info1

_lookupGUID[guid]=info1

array[#array+1]=info1

if#array>1 then
table.sort(array,function(a,b)
local enterWidghtCfg_a=cfgHelper.get2(cfg_activitysenterwidghtconfig_get,a.enterType,a.id)
local enterWidghtCfg_b=cfgHelper.get2(cfg_activitysenterwidghtconfig_get,b.enterType,b.id)
local sortWidght_a=enterWidghtCfg_a and enterWidghtCfg_a.sortwidght or a.id
local sortWidght_b=enterWidghtCfg_b and enterWidghtCfg_b.sortwidght or b.id
return sortWidght_a>sortWidght_b
end)
end

enterManager:freshAllEnter()

if enterManager:checkActive(enterInfo)then
_fresh()
end
return guid
end


function enterManager:removeEnter(guid)
if guid==nil then
logErr('删除入口传参为空')
return false
end

local info=_lookupGUID[guid]
if info==nil then return false end
local enterType=info.enterType
local enterIconType=info.enterIconType
if enterType==nil then
logErr('本地存储数据enterType为空')
return false
end
local id=info.id
if id==nil then
logErr('本地存储数据id为空')
return false
end

if enterIconType==nil then
logErr('iconType为空')
return false
end

if enterManager:removeInfo(info)then
enterManager:freshAllEnter()
if enterManager:checkActive(info)then
_fresh()
end
return true
end
return false
end

function enterManager:hasInfo(guid)
return self:getInfo(guid)~=nil
end

function enterManager:getInfo(guid)
return _lookupGUID[guid]
end

function enterManager:replaceInfo(info)
local enterIconType=info.enterIconType

local array=enterManager:getDataArray(enterIconType)
if array==nil then return end
local guid=info._guid
for i,v in ipairs(array)do
if v._guid==guid then
array[i]=info
return true
end
end
logErr('没有找到历史数据')
return false
end

function enterManager:removeInfo(info)
if info==nil then return false end
local enterIconType=info.enterIconType

local array=enterManager:getDataArray(enterIconType)
if array==nil then return false end
local enterInfo
local idx
local guid=info._guid
for i,v in ipairs(array)do
if v._guid==guid then
enterInfo=v
idx=i
break
end
end
if enterInfo==nil or idx==nil then return false end
local enterType=info.enterType
if enterType==nil then
logErr('本地存储数据enterType为空')
return false
end
if enterInfo.enterType~=enterType then
logErr('guid本地存储数据enterType不匹配')
return false
end
local id=info.id
if id==nil then
logErr('本地存储数据id为空')
return false
end

local id=enterInfo.id
if enterInfo.id~=id then
logErr('guid本地存储数据id不匹配')
return false
end

if _lookupInfo[enterIconType]==nil then _lookupInfo[enterIconType]={}end
local lookIconTable=_lookupInfo[enterIconType]

if lookIconTable[enterType]==nil then lookIconTable[enterType]={}end

local lookupTable=lookIconTable[enterType]
lookupTable[id]=nil

_lookupGUID[guid]=nil

table.remove(array,idx)

return true
end

function enterManager:getBigEnterData()
return _sceneBigEnterArray
end

function enterManager:getEnterData()
return _sceneNomalEnterArray
end

function enterManager:getExtendBigEnterData()
return _sceneExtendBigEnterArray or{}
end

function enterManager:getExtendEnterData()
return _sceneExtendNomalEnterArray or{}
end

function enterManager:getExtendGameEnterData()
return _sceneExtendGameEnterArray or{}
end


function enterManager:getAllEnterReddot()
local bigEnterList=enterManager:getBigEnterData()

for i,info in ipairs(bigEnterList)do
local getReddotFun=info.getReddotFun
local enterReddot=getReddotFun and getReddotFun()or false
if enterReddot then
return true
end
end

local nomalEnterList=enterManager:getEnterData()

for i,info in ipairs(nomalEnterList)do
local getReddotFun=info.getReddotFun
local enterReddot=getReddotFun and getReddotFun()or false
if enterReddot then
return true
end
end

return false
end

function enterManager:getDataArray(enterIconType)
if enterIconType==nil then
logErr('iconType为空')
return nil
end
return enterIconType==ENTER_ICON_TYPE.eBig and _bigEnterArray or
_nomalEnterArray
end


function enterManager:freshFunc(funcName,enterType,id,enterIconType)
id=id or 1
enterIconType=enterIconType or ENTER_ICON_TYPE.eNomal
if _lookupInfo[enterIconType]==nil then return end
local lookIconTable=_lookupInfo[enterIconType]

if lookIconTable[enterType]==nil then return end

local lookupTable=lookIconTable[enterType]

local info=lookupTable[id]
if info==nil then return end
UIManager:callWindowFunc('UIMainEntryWin','freshFuncByByInfo',funcName,info)
UIManager:invokeUIMethod("UIAct_ExtendEnterWin","refresh")
end


function enterManager:freshFuncByGUID(guid,funcName,args)
UIManager:callWindowFunc('UIMainEntryWin','freshFuncByGuid',guid,funcName,args)
end

function enterManager.onSystemOpen(sysid,isNew)
enterManager:initFixed(sysid)
end



local _extendInfo={
id=1,
_guid=getGUID(),
enterIconType=ENTER_ICON_TYPE.eNomal,
enterType=ENTER_TYPE.eExtend,
getReddotFun=function()
return enterManager:checkExtendReddot()
end
}

function enterManager:checkExtend()
local mapId=self.mapId
local sceneType=self.sceneType
local mapCfg=enterConfig.getMapCfg(sceneType,mapId)
local normal_limit=mapCfg and mapCfg.act_extend_limit and
mapCfg.act_extend_limit.normal or ACT_EXTEND_LIMIT.Normal
local big_limit=mapCfg and mapCfg.act_extend_limit and
mapCfg.act_extend_limit.big or ACT_EXTEND_LIMIT.big

local normalLimit=mapCfg.normalLimit or 999
local bigLimit=mapCfg.bigLimit or 999

if#_sceneBigEnterArray>big_limit or#_sceneNomalEnterArray>normal_limit then
table.clear(_sceneExtendNomalEnterArray)
table.clear(_sceneExtendBigEnterArray)
table.clear(_sceneExtendGameEnterArray)
table.clear(_sceneExAllNomalEnterArray)
table.clear(_sceneExAllBigEnterArray)

_sceneExtendNomalEnterArray=table.sub(_sceneNomalEnterArray,ACT_EXTEND_LIMIT.Normal,#_sceneNomalEnterArray)or
_sceneExtendNomalEnterArray


_sceneExtendBigEnterArray=table.sub(_sceneBigEnterArray,ACT_EXTEND_LIMIT.big+1,#_sceneBigEnterArray)or
_sceneExtendBigEnterArray


_sceneExAllBigEnterArray=_sceneBigEnterArray

if next(_sceneNomalEnterArray or{})then
local temp={}
for k,v in pairs(_sceneNomalEnterArray)do
local cfg=cfgHelper.get2(cfg_activitysenterwidghtconfig_get,v.enterType,v.id)
if cfg then
if cfg.kind==ENTER_ACT_Kind.eAct then
table.insert(temp,v)
elseif cfg.kind==ENTER_ACT_Kind.eGame then
table.insert(_sceneExtendGameEnterArray,v)
else
table.insert(temp,v)
end
else
table.insert(temp,v)
end
end

_sceneExAllNomalEnterArray=temp
end

if#_sceneNomalEnterArray>=normalLimit then
_sceneNomalEnterArray=table.sub(_sceneNomalEnterArray,1,normalLimit-1)
end

_sceneNomalEnterArray=table.sub(_sceneNomalEnterArray,1,ACT_EXTEND_LIMIT.Normal-1)or _sceneNomalEnterArray
table.insert(_sceneNomalEnterArray,_extendInfo)
_sceneBigEnterArray=table.sub(_sceneBigEnterArray,1,ACT_EXTEND_LIMIT.big)or _sceneBigEnterArray
end
end

function enterManager:checkExtendReddot()
if next(_sceneExtendBigEnterArray or{})then
for k,v in pairs(_sceneExtendBigEnterArray)do
if v.getReddotFun and v.getReddotFun()then
return true
end
end
end

if next(_sceneExAllNomalEnterArray or{})then
for k,v in pairs(_sceneExAllNomalEnterArray)do
if v.getReddotFun and v.getReddotFun()then
return true
end
end
end

return false
end

function enterManager:getExtendAllNormalData()
return _sceneExAllNomalEnterArray
end

function enterManager:getExtendAllBigEnterData()
return _sceneExAllBigEnterArray
end

