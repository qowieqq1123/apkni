





local _SendHorseLampMessage=CS.GameInterface.SendHorseLampMessage
local _SendMidHorseLampMessage=CS.GameInterface.SendMidHorseLampMessage
local _SendSystemNotify=CS.GameInterface.SendSystemNotify
local _SendSystemNotifyMergeMsg=CS.GameInterface.SendSystemNotifyMergeMsg
local _SendPlayerNotify=CS.GameInterface.SendPlayerNotify
local _SendPlayerNotifyMergeMsg=CS.GameInterface.SendPlayerNotifyMergeMsg
local _SendPlayerWarning=CS.GameInterface.SendPlayerWarning
local _SendPlayerEXPCrit=CS.GameInterface.SendPlayerEXPCrit
local _SendPlayerComnon=CS.GameInterface.SendPlayerComnon
local _SendPlayerColorNotify=CS.GameInterface.SendPlayerColorNotify
local _SendServerErrorOnEditor=CS.GameInterface.SendServerErrorOnEditor
local _SendAddMoneyNotify=CS.GameInterface.SendAddMoneyNotify
local _SetMoneyMsgShowState=CS.GameInterface.SetMoneyMsgShowState
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool

local _TipsType=
{
eInfo=1,
eError=2,
eTopHource=3,
emidHource=4,
eServer=5,
eMoney=6,
}

local _disableArray={}


function UIManager.info(msg)
if UIManager.isEnableInfoTips()then
_SendPlayerNotify(msg)
end
end


function UIManager.error(msg)
if UIManager.isEnableErrorTips()then
_SendPlayerWarning(msg)
end
end


function UIManager.topHourceLamp(msg)
if UIManager.isEnableTopHourceTips()then
_SendHorseLampMessage(msg)
end
end


function UIManager.midHourceLamp(msg)
if UIManager.isEnableMidHourceTips()then
_SendMidHorseLampMessage(msg)
end
end


function UIManager.serverError(msg)
if UIManager.isEnableServerTips()then
if deviceHelper.isRunEditor()or _AppConfig_GetBool("serverLog",false)then
_SendServerErrorOnEditor(msg)
end
end
end


function UIManager.rewardInfo(iconName,num)
if UIManager.isEnableMoneyTips()then
_SendAddMoneyNotify(iconName,num)
end
end


function UIManager.moneyInfo(moneyType,num)
if not moneySystem.moneyList then
moneySystem.moneyList={}
end
if not moneySystem.moneyList[moneyType]then
moneySystem.moneyList[moneyType]={}
end
local iconName=iconHelper.getIconName(moneyType)
local len=#moneySystem.moneyList[moneyType]
moneySystem.moneyList[moneyType][len+1]={index=len+1,icon=iconName,text=num}
UIManager:invokeUIMethod('UITopMoneyWin','flyMoneyInfoTips',moneyType,len+1)
end





































function UIManager.setMoneyMsgShowState(show,clearExit)
_SetMoneyMsgShowState(show,clearExit)
end


function UIManager.clearTipsFlag()
_disableArray={}
end


function UIManager.enableTips(idx,flag)
_disableArray[idx]=not flag
end

local function isEnableTips(idx)
return not _disableArray[idx]
end


function UIManager.enableByFlag(flag)
if flag==nil then return end
for _,v in pairs(_TipsType)do
local enable=mathHelper.getBitValue(v-1,flag)
isEnableTips(v,not enable)
end
end

function UIManager.closeTopHourceLamp()
CS.GameInterface.CloseHorseRaceLampMsg()
end


function UIManager.enableInfoTips(enable)
UIManager.enableTips(_TipsType.eInfo,enable)
end

function UIManager.enableErrorTips(enable)
UIManager.enableTips(_TipsType.eError,enable)
end

function UIManager.enableTopHourceTips(enable)
UIManager.enableTips(_TipsType.eTopHource,enable)
end

function UIManager.enableMidHourceTips(enable)
UIManager.enableTips(_TipsType.emidHource,enable)
end

function UIManager.enableServerTips(enable)
UIManager.enableTips(_TipsType.eServer,enable)
end

function UIManager.enableMoneyTips(enable)
UIManager.enableTips(_TipsType.eMoney,enable)
end



function UIManager.isEnableInfoTips()
return isEnableTips(_TipsType.eInfo)
end

function UIManager.isEnableErrorTips()
return isEnableTips(_TipsType.eError)
end

function UIManager.isEnableTopHourceTips()
return isEnableTips(_TipsType.eTopHource)
end

function UIManager.isEnableMidHourceTips()
return isEnableTips(_TipsType.emidHource)
end

function UIManager.isEnableServerTips()
return isEnableTips(_TipsType.eServer)
end

function UIManager.isEnableMoneyTips()
return isEnableTips(_TipsType.eMoney)
end



function UIManager.disableAllTips(closeTips)
if closeTips~=false then
UIManager.enableTopHourceTips(false)
UIManager.closeTopHourceLamp()
end
hudControl:setContainerAlpha(hudContainerType.eDefault,0)
hudControl:setContainerRaycast(hudContainerType.eDefault,false)
hudControl:setContainerGRActive(hudContainerType.eDefault,false)
hudControl:setContainerAlpha(hudContainerType.eStory,1)
hudControl:setContainerGRActive(hudContainerType.eStory,true)
end


function UIManager.enableAllTips()
UIManager.clearTipsFlag()
hudControl:setContainerAlpha(hudContainerType.eDefault,1)
hudControl:setContainerRaycast(hudContainerType.eDefault,true)
hudControl:setContainerGRActive(hudContainerType.eDefault,true)
hudControl:setContainerAlpha(hudContainerType.eStory,0)
hudControl:setContainerGRActive(hudContainerType.eStory,false)
end