




pfwindowsModel={}
pfwindowsModel.auctionBroadcastCfg={

{"20","00"},
{"20","20"},
{"20","40"},
{"21","00"},
}
local _appConfig_GetString=CS.AppDataModel.AppConfig_GetString

function pfwindowsModel:onAppStart()

end


function pfwindowsModel:onEnterState(isReconnect)
self:initAuctionBroadcast()
end


function pfwindowsModel:onProtocolReq()

end


function pfwindowsModel:onLeaveState(isReconnect)

self.data={}
self.auctionBroadcast=nil
end



function pfwindowsModel:initAuctionBroadcast()
if pfwindowslController:checkIsGameVersion_HWFT()or pfwindowslController:checkIsGameVersion_oumei()then
self.auctionBroadcast={}
for i,v in ipairs(self.auctionBroadcastCfg)do
table.insert(self.auctionBroadcast,{hour=v[1],minute=v[2]})
end
end
end
function pfwindowsModel:checkAuctionBroadcast()
if not self.auctionBroadcast then
return
end

local open=systemModel.isOpen(SYSTEM_DEFINE.eWanBaoShangHuiOpen)
if open then
local now_hour=timeHelper.dateServerStamp('%H',timeHelper.getServerLongTime())
local now_minute=timeHelper.dateServerStamp('%M',timeHelper.getServerLongTime())
local idx=nil
for i,v in ipairs(self.auctionBroadcast or{})do
if v.hour==now_hour and v.minute==now_minute then
idx=i
break
end
end
if idx then
table.remove(self.auctionBroadcast,idx)
UIManager.topHourceLamp('萬寳商會有低價好物正在拍賣，距離拍賣截止時間不多了！快來拍賣行看看，別錯過這次搶購機會！')
end
end
end


local sdkLoginData={}

function pfwindowsModel:setSdkLoginData(data)
sdkLoginData=data
end

function pfwindowsModel:getSdkLoginData()
return sdkLoginData
end

local gameCodeList=
{
["platformSDK_Android_HWFT"]="twzqzs",
["platformSDK_iOS_EFun"]="twzqzsios",
["platformSDK_PC_Efun"]=
{
["EFUN"]="twzqzspc",
["STEAM"]="twzqzssteam"
},


["platformSDK_Android_HWOuMei"]="euzqzs",
["platformSDK_iOS_EFun_Eu"]="euzqzs",
["platformSDK_PC_Efun_OuMei"]="euzqzs",
["platformSDK_iOS_EFun_US"]="euzqzs",
}


local DEFAULT_GAME_CODE="twzqzs"

function pfwindowsModel:getGameCode()
local pfname=deviceHelper.getAppPlatform()


if pfname=="platformSDK_PC_Efun"then
local pcPfName=_appConfig_GetString('EFUN_PC_PfName','EFUN')
return gameCodeList[pfname][pcPfName]or DEFAULT_GAME_CODE
end


return gameCodeList[pfname]or DEFAULT_GAME_CODE
end




function pfwindowsModel:getVersionAndPfCfg(cfgList)
local outCfg
local defaultVersionId=pfwindowslController.sdkPFVersion.game_jianti
local defaultPfId=-1
local versionId=pfwindowslController:getGameVersion()
local pfId=loginModel:getPfid()
if cfgList[versionId]then
if cfgList[versionId][pfId]then
outCfg=cfgList[versionId][pfId]
else

outCfg=cfgList[versionId][defaultPfId]
end
else

if cfgList[defaultVersionId][pfId]then
outCfg=cfgList[defaultVersionId][pfId]
else
outCfg=cfgList[defaultVersionId][defaultPfId]
end
end
return outCfg
end



function pfwindowsModel:getVersionAndPfCfg_2(cfgList)
local outCfg

local defaultPfId=-1
local versionId=pfwindowslController:getGameVersion()

local pfId=loginModel:getPfid()
if cfgList[versionId]then
if cfgList[versionId][pfId]then
outCfg=cfgList[versionId][pfId]
else

return cfgList[versionId][defaultPfId]
end
else

return
end
return outCfg
end



function pfwindowsModel:getVersionAndPfCfg_severPf(cfgList)
local outCfg
local defaultVersionId=pfwindowslController.sdkPFVersion.game_jianti
local defaultPfId=-1
local versionId=pfwindowslController:getGameVersion()
local pfId=gameUtilityModel.getServerPlatform()
if cfgList[versionId]then
if cfgList[versionId][pfId]then
outCfg=cfgList[versionId][pfId]
else

outCfg=cfgList[versionId][defaultPfId]
end
else

if cfgList[defaultVersionId][pfId]then
outCfg=cfgList[defaultVersionId][pfId]
else
outCfg=cfgList[defaultVersionId][defaultPfId]
end
end
return outCfg
end
