








local _MODULENAME="UICatchLingShouController"




gameState.addListener(def_table(_MODULENAME))
UICatchLingShouController.name=_MODULENAME
UICatchLingShouController.data={}


function UICatchLingShouController:onAppStart()
socketManager:register_receiver(19,100,self.recv_19_100)
socketManager:register_receiver(19,101,self.recv_19_101)
socketManager:register_receiver(19,102,self.recv_19_102)
socketManager:register_receiver(19,103,self.recv_19_103)
end


function UICatchLingShouController:onEnterState()
UICatchLingShouModel:onEnterState()
end


function UICatchLingShouController:onLeaveState()

UICatchLingShouModel:onLeaveState()
end

function UICatchLingShouController.recv_19_100(len,gameInfoList)
if len<=0 then return end

for index=1,len do
local gameInfo=gameInfoList[index]

UICatchLingShouModel:setGameInfo(gameInfo)
end
end

function UICatchLingShouController.recv_19_101(index,gameInfo,len,lsGuidList)

gameInfo.getLSLen=len
gameInfo.lsGuidList=lsGuidList

UICatchLingShouModel:setGameInfo(gameInfo)
end

function UICatchLingShouController.recv_19_102(gameInfo)
UICatchLingShouModel:setGameInfo(gameInfo)

if self.newGameCallBack then
self.newGameCallBack()
self.newGameCallBack=nil
end
end

function UICatchLingShouController.recv_19_103(len,gameInfoList)
if len<=0 then return end

for index=1,len do
local gameInfo=gameInfoList[index]

UICatchLingShouModel:setGameInfo(gameInfo)
end
end

function UICatchLingShouController.req_open_obstruction(gameGuid,index)
socketManager:send_19_101(gameGuid,index)
end




function UICatchLingShouController:req_New_Game(gameGuid,callback)
local gameGuidStr=tostring(gameGuid)

local gameData=UICatchLingShouModel:getGameData(gameGuidStr)

if gameData==nil then
socketManager:send_19_102(gameGuid)

self.newGameCallBack=callback
else
if callback then
callback()
end
end
end

function UICatchLingShouController:openNewGame(args)
if not systemModel.isOpen(SYSTEM_DEFINE.eBuZhuoLingShouGame)then return end

local gameType=args.gameType
local gameID=args.mapId
local bzlsGameData=UICatchLingShouModel:getGameDataById(tostring(args.guid))
if bzlsGameData==nil then
logErr("捕捉灵兽 游戏数据 缺失",gameType,gameID,tostring(args.guid))
return
end

local callback=function()
args.gameGuid=bzlsGameData.gameGuid
UIManager:showWindow("UILittleGame_CatchLingShouWin",args)
end

UICatchLingShouController:req_New_Game(bzlsGameData.gameGuid,callback)
end