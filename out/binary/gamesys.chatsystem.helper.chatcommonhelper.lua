




chatCommonHelper={}

function chatCommonHelper.checkMesgLen(mesg)
local msg=chatLinkHelper.clearLink(mesg)
msg=chatLinkHelper.clearRich(msg)
local len=string.lenEx(msg)
local chatconfig=chatConfig.getCommonConfig()
return len<=chatconfig.maxinput
end


function chatCommonHelper.isCanSpeakOnChannel(channelId,mesg,warn)
local channelConfig=chatConfig.getChannelConfig(channelId)
if channelConfig==nil then
loggerUtil.logErrFMT('没有找到当前频道的配置：{0}',channelId)
return false
end

if not chatCommonHelper.checkMesgLen(mesg)then
if warn then
UIManager.error('字数超过限制')
end
return false
end

local cdtime=channelConfig.cdtime
local stamp=timeHelper.getServerLongTime()
local lastStamp=chatModel.getSpeakStampOnChannel(channelId)
local div=stamp-lastStamp
if div<cdtime then
if warn then
UIManager.error('喝杯茶休息一下')
end
return false
end

local htlimitInfo=houtaiModel:getChatLimitInfo()
if htlimitInfo and htlimitInfo[channelId]then
local limit=htlimitInfo[channelId]
local needlv=limit.level
if not playerModel:checkActorLevel(needlv)then
if warn then
UIManager.error(FMT.fmt('宗门等级需达到{0}级',needlv))
end
return false
end

local needRecharge=limit.recharge or 0
local recharge=rechargeModel:getTotalRecharge()
if needRecharge>recharge then
if warn then
UIManager.error(FMT.fmt('累计充值仙玉数量达到{0}后开启聊天',needRecharge))
end
return false
end

local needFightValue=limit.fightvalue or 0
local fightvalue=playerModel:getActorFightValue()
if fightvalue<needFightValue then
if warn then
local str=mathHelper.formatNumber(needFightValue,true)
UIManager.error('祖师的实力还不够强，请努力提升宗门实力！')
end
return false
end
end

local needLv=1
if channelConfig.level then
local cfglevel=pfwindowsModel:getVersionAndPfCfg(channelConfig.level)
needLv=cfglevel or 1
end

if not playerModel:checkActorLevel(needLv)then
if warn then
UIManager.error(FMT.fmt('宗门等级需达到{0}级',needLv))
end
return false
end
if channelConfig.serverday then
local cfgserday=pfwindowsModel:getVersionAndPfCfg(channelConfig.serverday)
local serverday=cfgserday
local openDay=timeHelper.getServerOpenDay()
if serverday and openDay<serverday then
if warn then
UIManager.error(FMT.fmt('开服第{0}天开启',serverday))
end
return false
end
end

return true
end

function chatCommonHelper.canNeedShowInput(mesg)
if chatEmotHelper.containsBigEmot(mesg)then
return false
end
return true
end

function chatCommonHelper.isChannelUnlock(channelId)
local channelConfig=chatConfig.getChannelConfig(channelId)

local unlockLv=chatConfig.getChannelUnlockLevel(channelId)
local level=playerModel:getActorLevel()or 1
local enoughlv=unlockLv<=level
if not enoughlv then return false end


local unlockSysId=chatConfig.getChannelUnlockSystem(channelId)
local enoughSys=unlockSysId==nil or systemModel.isOpen(unlockSysId)
if not enoughSys then return false end


if channelConfig.serverday then
local cfgserday=pfwindowsModel:getVersionAndPfCfg(channelConfig.serverday)
local serverday=cfgserday
local openDay=timeHelper.getServerOpenDay()
if serverday and openDay<serverday then return false end
end


if channelId==CHAT_CHANNNEL.eBattleField or channelId==CHAT_CHANNNEL.eSeasonZZSH then
if zhengzhanshanhaiController:checkInMap()then

local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

if channelId==CHAT_CHANNNEL.eBattleField then
return true
end
else

if channelId==CHAT_CHANNNEL.eSeasonZZSH then
return true
end
end
end

return false
elseif channelId==CHAT_CHANNNEL.eMoGong then
return moGongZhengDuoActModel:checkInActScene()or false
end

return true
end

function chatCommonHelper.isShowChannel(channelId)
local ret=chatCommonHelper.isChannelUnlock(channelId)
if ret then
if channelId==CHAT_CHANNNEL.eJianwen then
return(not zhengzhanshanhaiController:checkInMap())and(not moGongZhengDuoActModel:checkInActScene())
end
end
return ret
end

function chatCommonHelper:matchChatRegex(mesg)
local temp
for id,str in string.gmatch(mesg,chatConfig.chatRegex)do
if temp==nil then temp={}end
temp[#temp+1]={id,str}
end
return temp
end