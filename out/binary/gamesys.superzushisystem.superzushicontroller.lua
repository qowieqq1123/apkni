








superZuShiController=gameState.addListener({})




local _httpGetRequest=CS.ResourceHelper.HttpGetRequest
function superZuShiController:onAppStart()

superZuShiModel:onAppStart()









end


function superZuShiController:onEnterState(isReconnect)
superZuShiModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.on_level_change)
end


function superZuShiController:onProtocolReq()
superZuShiModel:onProtocolReq()


superZuShiController:requestSuperZuShiData()
end


function superZuShiController:onLeaveState(isReconnect)
superZuShiController:stopSuperZuShiEnterRemoveTimer()
superZuShiController:stopSuperZuShiEnterShowTimer()
notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.on_level_change)
superZuShiModel:onLeaveState(isReconnect)

if self.enterGuid then
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end
self.data={}
end


function superZuShiController:onLostConnection()
superZuShiController:stopSuperZuShiEnterRemoveTimer()
superZuShiController:stopSuperZuShiEnterShowTimer()
end


function superZuShiController:onReConnection(isInitPro)

end






function superZuShiController:checkSuperZuShiEnter()

local nowTime=gameUtilityModel.getServerLongTime()
local isShowEnter,beginShowTime,endShowTime=superZuShiModel:checkSuperZuShiEnterShow()

if isShowEnter then
if not self.enterGuid then
self.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eSuperZuShi})
end

if endShowTime then

superZuShiController:setSuperZuShiEnterRemoveTimer(endShowTime)
end
else

superZuShiController:removeSuperZuShiEnter()

if beginShowTime and nowTime<beginShowTime then
superZuShiController:setSuperZuShiEnterShowTimer(beginShowTime)
end
end
end


function superZuShiController:removeSuperZuShiEnter()

superZuShiController:stopSuperZuShiEnterRemoveTimer()

if self.enterGuid then

enterManager:freshFunc('onClose',ENTER_TYPE.eSuperZuShi)
local ret=enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
if ret then

UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end
end

function superZuShiController:setSuperZuShiEnterRemoveTimer(endShowTime)
self:stopSuperZuShiEnterRemoveTimer()
self.endTimer=timer.new()

local func
func=function()
local nowTime=gameUtilityModel.getServerLongTime()
local lerp=endShowTime-nowTime
if lerp<=0 then

return superZuShiController:removeSuperZuShiEnter()
end
end
self.endTimer:start(1,func)

func()
end

function superZuShiController:stopSuperZuShiEnterRemoveTimer()
if self.endTimer then
self.endTimer:cancel()
end
self.endTimer=nil
end

function superZuShiController:setSuperZuShiEnterShowTimer(beginShowTime)
self:stopSuperZuShiEnterShowTimer()
self.beginTimer=timer.new()

local func
func=function()
local nowTime=gameUtilityModel.getServerLongTime()
local lerp=beginShowTime-nowTime
if lerp<=0 then
superZuShiController:stopSuperZuShiEnterShowTimer()

return superZuShiController:checkSuperZuShiEnter()
end
end
self.beginTimer:start(1,func)

func()
end

function superZuShiController:stopSuperZuShiEnterShowTimer()
if self.beginTimer then
self.beginTimer:cancel()
end
self.beginTimer=nil
end

function superZuShiController:requestSuperZuShiData()
local pfname
local url
local sid
if deviceHelper.isRunEditor()then
pfname="cysh"
url=FMT.fmt("http://10.10.1.25:89/{0}/api/superVip",pfname)
sid=1
else

if deviceHelper.isRunNonePlatform()or verifyManager:isOpen()then
return
end

pfname=gameInfo:getPfname()
url=gameInfo:getParams('superVipURL')
local info=loginModel.phpLoginInfo or{}
sid=info.srvid or 0
end
local channel=loginModel:getChannelID()
local urlStr=FMT.fmt("{0}?sid={1}",url,sid)
if channel and channel~=""then
urlStr=FMT.fmt("{0}&chid={1}",urlStr,channel)
end

local function httpCallBack(jsonStr,err)
platformSDK.printSDK('请求特级祖师数据:',jsonStr,err)
if err==""or not err then
local json_table
local s,e=pcall(function()
json_table=jsonHelper.decode(jsonStr)
end)
if json_table and json_table.code==0 then
superZuShiModel:setSuperZuShiData(json_table.data)


superZuShiController:checkSuperZuShiEnter()
else
platformSDK.printSDK('请求特级祖师数据解析错误',jsonStr)
end
end
end
_httpGetRequest(urlStr,httpCallBack)
end

function superZuShiController.on_level_change(level,exp)

superZuShiController:checkSuperZuShiEnter()
end