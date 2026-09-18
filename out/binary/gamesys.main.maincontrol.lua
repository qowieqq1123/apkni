








local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
mainControl=gameState.addListener({})

eSceneType={
eZongmen=1,
eWorld=2,
eXianJie=3,
eAirGame=4,
eMiniGame=5,


}

sceneNames={
[eSceneType.eZongmen]='宗门',
[eSceneType.eWorld]='大世界',
[eSceneType.eXianJie]='仙界',
[eSceneType.eAirGame]='空战'

}


local _curSceneType=nil
local _curSceneData=nil
local _sceneTypeData={}

local _mapReqData
local _mainFirstLoad=true
local _mapEnterCall={}
local _isChangeScene=false


function mainControl:onEnterState(isReconnet)

_isChangeScene=false
if isReconnet then
inputSystem:enter()
return
end
_mapReqData={}
_mainFirstLoad=true
_mapEnterCall={}
end

function mainControl:enter()
local timefunc={
{

cond=function()
return worldModel:checkInits({eWorldUnitTpye.FOG,eWorldUnitTpye.EXPERIENCE,eWorldUnitTpye.MISSION})
end,

func=function()
self:reqEnterGameScene()
end,
},
}
timeEventController.createConditionTimer('checkEnterGame',timefunc,0.01,6000)
inputSystem:enter()
end


function mainControl:onLeaveState(isReconnet)

_isChangeScene=false
if isReconnet then
inputSystem:leave()
return
end


mainControl:leaveSceneData()
_curSceneType=nil
_curSceneData=nil
_mapReqData=nil
_mapEnterCall={}
_mainFirstLoad=true
end

function mainControl:onAppStart()
socketManager:register_receiver(254,30,self.recv_254_30)
end


function mainControl.recv_254_30(mapType)
if socketManager.connecting==false then return end
_isChangeScene=false
local args=_mapReqData[mapType]
local enterCall=_mapEnterCall[mapType]
_mapReqData[mapType]=nil
_mapEnterCall[mapType]=nil
if webGLHelper:isRunMiniGame()then
resourceUtility.releaseAll()
end
mainControl:changeScene(mapType,args,enterCall)
end



function mainControl:enterHome(args,enterCall,preCheckRecord)
if args==nil or#args==0 then args={mapIdType.zhufeng}end
local mapId=args[1]
local inScene=_curSceneType~=nil
local ret,errType=downAssetManager:needDownLoadScene(SCENE_TYPE.home,mapId,inScene)
if ret then
if not inScene then
if not mainControl:enterWorld()then
logErr('大世界1没有放入首包')
mainControl:reqEnterMap(eSceneType.eWorld)
return true
end
end
return false
end

local preCheckResult=changeSceneConfig.changeScenePreCheck(preCheckRecord,eSceneType.eZongmen,args,enterCall,mainControl.enterHome)
if not preCheckResult then
return false
end

mainControl:reqEnterMap(eSceneType.eZongmen,args,enterCall)
return true
end



function mainControl:enterWorld(args,enterCall,preCheckRecord)
if args==nil or#args==0 then args={1}end
local world=args[1]
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world)
if worldCfg.sceneid~=1 then
local ret,errType=downAssetManager:needDownLoadScene(worldCfg.sceneid)
if ret then return false end
end
local preCheckResult=changeSceneConfig.changeScenePreCheck(preCheckRecord,eSceneType.eWorld,args,enterCall,mainControl.enterWorld)
if not preCheckResult then
return false
end
mainControl:reqEnterMap(eSceneType.eWorld,args,enterCall)
return true
end



function mainControl:enterXianJie(args,enterCall,preCheckRecord)
if args==nil or#args==0 then args={1}end
local sceneType=args[1]
local sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,sceneType)

local ret,errType=downAssetManager:needDownLoadScene(sceneCfg.sceneid)
if ret then return false end
local preCheckResult=changeSceneConfig.changeScenePreCheck(preCheckRecord,eSceneType.eXianJie,args,enterCall,mainControl.enterXianJie)
if not preCheckResult then
return false
end
mainControl:reqEnterMap2(eSceneType.eXianJie,args,enterCall)
return true
end

function mainControl:enterAirGame(args,enterCall,preCheckRecord)
if not airController:api_Available()then return false end

local sceneType=args[1]
local ret,errType=downAssetManager:needDownLoadScene(sceneType)
if ret then return false end
local preCheckResult=changeSceneConfig.changeScenePreCheck(preCheckRecord,eSceneType.eAirGame,args,enterCall,mainControl.enterAirGame)
if not preCheckResult then
return false
end
mainControl:reqEnterMap2(eSceneType.eAirGame,args,enterCall)
return true
end


function mainControl:reqEnterMap(mapType,args,enterCall)
_mapReqData[mapType]=args
_mapEnterCall[mapType]=enterCall
socketManager:send_254_30(mapType)
_isChangeScene=true
end

function mainControl:reqEnterMap2(mapType,args,enterCall)
_mapReqData[mapType]=args
_mapEnterCall[mapType]=enterCall
_isChangeScene=true
timeEventController.delayDo(0.1,function()
mainControl.recv_254_30(mapType)
end)
end

function mainControl:regSceneTypo(typo,data)
_sceneTypeData=_sceneTypeData or{}
if _sceneTypeData[typo]==nil then
data.typo=typo
_sceneTypeData[typo]=data
else
logErr(FMT.fmt("repeat reg _sceneTypeData {0}",typo))
end
end


function mainControl:changeScene(typo,args,enterCall)
local sceneData=_sceneTypeData[typo]
if sceneData then
local startCall=function()
mainControl:leaveCurrentScene()
_curSceneType=typo
mainViewsControl.onChangeScene(typo)
end
local endCall=function()
mainControl:onLoadedScene(typo,args or{})
end
sceneControl:setEnterArgs({sceneType=typo,enterCall=enterCall})
sceneControl:setLoadCallBack(startCall,endCall)
sceneData:load(unpack(args or{}))
end
end


function mainControl:onLoadedScene(typo,argstable)
_curSceneType=typo
mainControl:refreshEnoughServerInitProTag()
mainViewsControl.onChangeScene(typo)
mainControl:onShowShuiYin(typo)
_curSceneData=_sceneTypeData[typo]



mainControl:enterSceneData(argstable)
end

function mainControl:leaveCurrentScene()
mainControl:leaveSceneData()
if _curSceneType then
gameState:onLeaveScene(_curSceneType)
end
end

function mainControl:leaveSceneData()
if _curSceneData~=nil then
xpcall(function()
_curSceneData:leave()
end,function(err)
logErr('leaveSceneData err:',err)
end)
end
end

function mainControl:enterSceneData(argstable)
if _curSceneData~=nil then
xpcall(function()
_curSceneData:enter(unpack(argstable))
end,function(err)
logErr('enterSceneData err:',err)
end)
end
end


function mainControl:refreshEnoughServerInitProTag()
if mainControl:isSceneType(eSceneType.eXianJie)then
local isOpenHuJianXianJie=xianjieModel:isOpenHuJianXianJie()
local num=mathHelper.setbit(0,eInitProType.eKF)

if isOpenHuJianXianJie then
num=mathHelper.setbit(num,eInitProType.eBigKF)
end
reconnectState:setEnoughServerInitProTag(num)
else
reconnectState:setEnoughServerInitProTag(0)
end
end

function mainControl:isInScenes(stypes)
for _,v in ipairs(stypes)do
if mainControl:isInScene(v)then
return true
end
end
return false
end

function mainControl:isInScene(stype)
return mainControl:isSceneLoaded(stype)
end


function mainControl:isSceneLoaded(stype)
if _curSceneType==stype then
local lstate=sceneControl:getLoadingState()
return lstate~=eSceneLoadState.Loading
end
return false
end


function mainControl:isSceneLoading(stype)
if _curSceneType==stype then
local lstate=sceneControl:getLoadingState()
return lstate==eSceneLoadState.Loading
end
return false
end

function mainControl:getSceneType()
return _curSceneType
end

function mainControl:isSceneType(sceneType)
return _curSceneType==sceneType
end

function mainControl:getSubSceneID()
if _curSceneType==eSceneType.eZongmen then
return zongmenModel:getMountainId()
elseif _curSceneType==eSceneType.eWorld then
return worldModel.world
end
end

function mainControl:isInSubScene(sceneType,mountain)
if self:isSceneType(sceneType)then
local subId=self:getSubSceneID()
return mountain==subId
end
return false
end

function mainControl:isInSubScenes(sceneType,mountains)
if self:isSceneType(sceneType)then
local subId=self:getSubSceneID()
return table.containsValue(mountains,subId)
end
return false
end

function mainControl:getSubSceneName(sceneType,mountain)
if _curSceneType==eSceneType.eZongmen then
return cfgHelper.get2(cfg_monijysfconfig_get,mountain,"name")
elseif _curSceneType==eSceneType.eWorld then
return cfgHelper.get2(cfg_worldconfig_get,mountain,"name")
end
end






function mainControl:showWindow(argstable)


UIManager:showWindow('UIMain',argstable)

return true
end

function mainControl:openWindow()
if not UIManager:isActive('UIMain')then
mainControl:showWindow()
end
end

function mainControl:closeWindow()
UIManager:closeWindow('UIMain')
end

function mainControl:hideWindow()
UIManager:hideWindow('UIMain')
end

function mainControl:checkMain(name)
return name=='UIMain'
end


function mainControl:reqEnterGameScene()
local cfg=cfgHelper.get2(cfg_worldglobalconfig_get,"noviciateBlock","value")
local world=cfg[1]
local block=cfg[2]
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.UNLOCK)then
if worldExperienceModel:checkCurrent(world,block)then
worldController:enterWorld(world,{block=block})
return
end
end

self:enterHome()
end

function mainControl:isFirstLoad()
return _mainFirstLoad or false
end

function mainControl:setFirstLoad(flag)
_mainFirstLoad=flag
end

function mainControl:getUICamera()
if self.UICamera==nil then
self.UICamera=GameObject.Find('GUI_ROOT/UICamera')
end
return self.UICamera
end

function mainControl:setMainWin(flag)
local sceneType=mainControl:getSceneType()
if sceneType==nil then return end
if not flag then
UIManager:hideWindow('UIMain')
else
UIManager:showWindow('UIMain')
end
mainViewsControl.onChangeMain(sceneType,flag)
end


function mainControl:isWaitSceneChange()
return _isChangeScene==true
end


function mainControl:jumpMain()
if mainControl:isInScene(eSceneType.eZongmen)then
if zongmenControl:isMountid(mapIdType.zhufeng)then
return jumpManager:jump({id=JUMP_TYPE.eMain})
elseif zongmenControl:isMountid(mapIdType.xianzhan)then
return jumpManager:jump({id=JUMP_TYPE.eXianZhan})
elseif zongmenControl:isMountid(mapIdType.fort)then
return jumpManager:jump({id=JUMP_TYPE.eMain,args={mapid=mapIdType.fort}})
else
return jumpManager:jump({id=JUMP_TYPE.eMain})
end
elseif mainControl:isInScene(eSceneType.eWorld)then
return jumpManager:jump({id=JUMP_TYPE.eWorld})
elseif mainControl:isInScene(eSceneType.eXianJie)then
return jumpManager:jump({id=JUMP_TYPE.eXianJie,args={mapid=xjJumpSceneType.eNowPos}})
elseif mainControl:isInScene(eSceneType.eAirGame)then
return jumpManager:jump({id=JUMP_TYPE.eAirGameEnter})
end
end

function mainControl:onShowShuiYin(typo,...)
if self.hideShuiYin==true then return end

if UIManager:isActive('UIShuiYinWin')then
UIManager:invokeUIMethod("UIShuiYinWin","resetMap",typo)
return
end

self.hideShuiYin=true

local pfid=loginModel:getPfid()
local showShuiYinInfos=cfgHelper.getglobal1('showShuiYinInfos')
if showShuiYinInfos and showShuiYinInfos[pfid]~=nil then
local local_cur_serveStr=userGlobalSetting.get('server_ip',loginModel.server_ip_string)
local name,serveid=string.match(local_cur_serveStr or'',loginModel.matchStr)
for i,v in pairs(showShuiYinInfos[pfid])do
if serveid==tostring(v)then
self.hideShuiYin=false
UIManager:showWindow('UIShuiYinWin',{eSceneType.eZongmen})
break
end
end
end
end