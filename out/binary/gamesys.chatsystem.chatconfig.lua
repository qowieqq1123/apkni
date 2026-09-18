





chatConfig={}


CHAT_CHANNNEL=
{
eNone=0,
eSystem=1,
eJianwen=2,
eWorld=3,
eKuafu=4,
eXianmeng=5,
ePrivate=6,
eBattleField=7,
eXianJie=8,
eMoGong=17,
eSeasonZZSH=18,
}







CHAT_CHANNNEL_NAME=
{
[CHAT_CHANNNEL.eSystem]='系统',
[CHAT_CHANNNEL.eJianwen]='见闻',
[CHAT_CHANNNEL.eKuafu]='跨服',
[CHAT_CHANNNEL.eWorld]='世界',
[CHAT_CHANNNEL.eXianmeng]='仙盟',
[CHAT_CHANNNEL.ePrivate]='私聊',
[CHAT_CHANNNEL.eBattleField]='战场',
[CHAT_CHANNNEL.eMoGong]='战场',
[CHAT_CHANNNEL.eSeasonZZSH]='战场',
[CHAT_CHANNNEL.eXianJie]='仙界',
}


local _PosGUID=0
local _index=function()
_PosGUID=_PosGUID+1
return _PosGUID
end
CHAT_SYSYTEM_POS=
{
eSystem=_index(),
eJianwen=_index(),
eXianJie=_index(),
eWorld=_index(),
eKuafu=_index(),
eXianmeng=_index(),
ePrivate=_index(),
eTopHourse=_index(),
eMidHourse=_index(),
eBattleField=_index(),
eMoGong=_index(),
eSeasonZZSH=_index(),
}


CHAT_REF_CHANNNEL=
{
[CHAT_CHANNNEL.eSystem]=CHAT_SYSYTEM_POS.eSystem,
[CHAT_CHANNNEL.eJianwen]=CHAT_SYSYTEM_POS.eJianwen,
[CHAT_CHANNNEL.eXianJie]=CHAT_SYSYTEM_POS.eXianJie,
[CHAT_CHANNNEL.eWorld]=CHAT_SYSYTEM_POS.eWorld,
[CHAT_CHANNNEL.eKuafu]=CHAT_SYSYTEM_POS.eKuafu,
[CHAT_CHANNNEL.eXianmeng]=CHAT_SYSYTEM_POS.eXianmeng,
[CHAT_CHANNNEL.ePrivate]=CHAT_SYSYTEM_POS.ePrivate,
[CHAT_CHANNNEL.eBattleField]=CHAT_SYSYTEM_POS.eBattleField,
[CHAT_CHANNNEL.eMoGong]=CHAT_SYSYTEM_POS.eMoGong,
[CHAT_CHANNNEL.eSeasonZZSH]=CHAT_SYSYTEM_POS.eSeasonZZSH,
}

CHAT_DECODE_TYPE=
{
eEmot=1,
eLink=2,
}


CHAT_PRIVATE_PLAYER_FROM_TYPE=
{
eRecent=1,
eFriend=2,
eAlly=3,
}


CHAT_MSG_SORT_TYPE=
{
eSetTop=-10000,
eBefore_GameTips=-1000,
eBefore_JianWen=-990,
eBehind_XMGongGao=-900,
eBehind_RecentMsg=-800,
eNone=0,

}


CHAT_MESSAGE_TYPE=
{
eNone=0,
eSystem=1,
ePublic=2,
ePrivate=3,
}


CHAT_COM_TYPE=
{
eMainChat=1,
eChatSimple=2,
eChatLeft=3,
eChatRight=4,
eChatMain=5,
eChatBigEmotLeft=6,
eChatBigEmotRight=7,
eChatLeftVoice=8,
eChatRightVoice=9,
eChatMainVoice=10,
eChatLeftCangBaoGeShare=11,
eChatRightCangBaoGeShare=12,
eChatLeftCangBaoGeSOS=13,
eChatRightCangBaoGeSOS=14,
eChatLeftShareDiscipleInfo=15,
eChatRightShareDiscipleInfo=16,
eChatLeftShareQieCuoInfo=17,
eChatRightShareQieCuoInfo=18,
eChatLeftShareLXWJInfo=19,
eChatRightShareLXWJInfo=20,
eChatLeftTianMoRuQin=21,
eChatRightTianMoRuQin=22,
eChatLeftTianMoJie=23,
eChatRightTianMoJie=24,
eChatLeftXJZongMenUnderAttack=25,
eChatRightXJZongMenUnderAttack=26,
eChatLeftXGJX=27,
eChatRightXGJX=28,
eChatLeftShareCSJD=29,
eChatRightShareCSJD=30,
eChatLeftShareXMHB=31,
eChatRightShareXMHB=32,
eChatLeftShareLingShouInfo=33,
eChatRightShareLingShouInfo=34,
}

CHAT_COM_TYPE_NAME=
{
[CHAT_COM_TYPE.eMainChat]='UIChatMainItem',
[CHAT_COM_TYPE.eChatSimple]='UIChatSimpleItem',
[CHAT_COM_TYPE.eChatLeft]='UIChatLeftChildItem',
[CHAT_COM_TYPE.eChatRight]='UIChatRightChildItem',
[CHAT_COM_TYPE.eChatMain]='UIChatMainItem',
[CHAT_COM_TYPE.eChatBigEmotLeft]='UIChatLeftBigEmotItem',
[CHAT_COM_TYPE.eChatBigEmotRight]='UIChatRightBigEmotItem',
[CHAT_COM_TYPE.eChatLeftVoice]='UIChatLeftVoiceChildItem',
[CHAT_COM_TYPE.eChatRightVoice]='UIChatRightVoiceChildItem',
[CHAT_COM_TYPE.eChatMainVoice]='UIChatMainVoiceItem',
[CHAT_COM_TYPE.eChatLeftCangBaoGeShare]='UIChatLeftCangBaoGeShareItem',
[CHAT_COM_TYPE.eChatRightCangBaoGeShare]='UIChatRightCangBaoGeShareItem',
[CHAT_COM_TYPE.eChatLeftCangBaoGeSOS]='UIChatLeftCangBaoGeSOSItem',
[CHAT_COM_TYPE.eChatRightCangBaoGeSOS]='UIChatRightCangBaoGeSOSItem',
[CHAT_COM_TYPE.eChatLeftShareDiscipleInfo]='UIChatLeftShareDiscipleInfoItem',
[CHAT_COM_TYPE.eChatRightShareDiscipleInfo]='UIChatRightShareDiscipleInfoItem',
[CHAT_COM_TYPE.eChatLeftShareQieCuoInfo]='UIChatLeftShareQieCuoInfoItem',
[CHAT_COM_TYPE.eChatRightShareQieCuoInfo]='UIChatRightShareQieCuoInfoItem',
[CHAT_COM_TYPE.eChatLeftShareLXWJInfo]='UIChatLeftShareLXWJInfoItem',
[CHAT_COM_TYPE.eChatRightShareLXWJInfo]='UIChatRightShareLXWJInfoItem',
[CHAT_COM_TYPE.eChatLeftTianMoRuQin]='UIChatLeftTianMoRuQinItem',
[CHAT_COM_TYPE.eChatRightTianMoRuQin]='UIChatRightTianMoRuQinItem',
[CHAT_COM_TYPE.eChatLeftTianMoJie]='UIChatLeftTianMoJieShareItem',
[CHAT_COM_TYPE.eChatRightTianMoJie]='UIChatRightTianMoJieShareItem',
[CHAT_COM_TYPE.eChatLeftXJZongMenUnderAttack]='UIChatLeftZongMenUnderAttackShareItem',
[CHAT_COM_TYPE.eChatRightXJZongMenUnderAttack]='UIChatRightZongMenUnderAttackShareItem',
[CHAT_COM_TYPE.eChatLeftXGJX]='UIChatLeftShareXGJXItem',
[CHAT_COM_TYPE.eChatRightXGJX]='UIChatRightShareXGJXItem',
[CHAT_COM_TYPE.eChatLeftShareCSJD]='UIChatLeftShareCSJDItem',
[CHAT_COM_TYPE.eChatRightShareCSJD]='UIChatRightShareCSJDItem',
[CHAT_COM_TYPE.eChatLeftShareXMHB]='UIChatLeftShareXMHBItem',
[CHAT_COM_TYPE.eChatRightShareXMHB]='UIChatRightShareXMHBItem',
[CHAT_COM_TYPE.eChatLeftShareLingShouInfo]='UIChatLeftShareLingShouInfoItem',
[CHAT_COM_TYPE.eChatRightShareLingShouInfo]='UIChatRightShareLingShouInfoItem',
}

LD_CHAT_COM_TYPE_NAME=
{
[CHAT_COM_TYPE.eMainChat]='UIChatMainItem',
[CHAT_COM_TYPE.eChatSimple]='UIChatSimpleItem',
[CHAT_COM_TYPE.eChatLeft]='UILDChatLeftChildItem',
[CHAT_COM_TYPE.eChatRight]='UILDChatRightChildItem',
[CHAT_COM_TYPE.eChatMain]='UIChatMainItem',
[CHAT_COM_TYPE.eChatBigEmotLeft]='UILDChatLeftBigEmotItem',
[CHAT_COM_TYPE.eChatBigEmotRight]='UILDChatRightBigEmotItem',
[CHAT_COM_TYPE.eChatLeftVoice]='UIChatLeftVoiceChildItem',
[CHAT_COM_TYPE.eChatRightVoice]='UIChatRightVoiceChildItem',
[CHAT_COM_TYPE.eChatLeftCangBaoGeShare]='UIChatLeftCangBaoGeShareItem',
[CHAT_COM_TYPE.eChatRightCangBaoGeShare]='UIChatRightCangBaoGeShareItem',
[CHAT_COM_TYPE.eChatLeftCangBaoGeSOS]='UIChatLeftCangBaoGeSOSItem',
[CHAT_COM_TYPE.eChatRightCangBaoGeSOS]='UIChatRightCangBaoGeSOSItem',
[CHAT_COM_TYPE.eChatLeftShareDiscipleInfo]='UILDChatLeftShareDiscipleInfoItem',
[CHAT_COM_TYPE.eChatRightShareDiscipleInfo]='UILDChatRightShareDiscipleInfoItem',
[CHAT_COM_TYPE.eChatLeftShareQieCuoInfo]='UILDChatLeftShareQieCuoInfoItem',
[CHAT_COM_TYPE.eChatRightShareQieCuoInfo]='UILDChatRightShareQieCuoInfoItem',
[CHAT_COM_TYPE.eChatLeftShareLXWJInfo]='UILDChatLeftShareLXWJInfoItem',
[CHAT_COM_TYPE.eChatRightShareLXWJInfo]='UILDChatRightShareLXWJInfoItem',
[CHAT_COM_TYPE.eChatLeftTianMoRuQin]='UIChatLeftTianMoRuQinItem',
[CHAT_COM_TYPE.eChatRightTianMoRuQin]='UIChatRightTianMoRuQinItem',
[CHAT_COM_TYPE.eChatLeftTianMoJie]='UIChatLeftTianMoJieShareItem',
[CHAT_COM_TYPE.eChatRightTianMoJie]='UIChatRightTianMoJieShareItem',
[CHAT_COM_TYPE.eChatLeftXJZongMenUnderAttack]='UIChatLeftZongMenUnderAttackShareItem',
[CHAT_COM_TYPE.eChatRightXJZongMenUnderAttack]='UIChatRightZongMenUnderAttackShareItem',
[CHAT_COM_TYPE.eChatLeftXGJX]='UIChatLeftShareXGJXItem',
[CHAT_COM_TYPE.eChatRightXGJX]='UIChatRightShareXGJXItem',
[CHAT_COM_TYPE.eChatLeftShareCSJD]='UIChatLeftShareCSJDItem',
[CHAT_COM_TYPE.eChatRightShareCSJD]='UIChatRightShareCSJDItem',
[CHAT_COM_TYPE.eChatLeftShareXMHB]='UIChatLeftShareXMHBItem',
[CHAT_COM_TYPE.eChatRightShareXMHB]='UIChatRightShareXMHBItem',
[CHAT_COM_TYPE.eChatLeftShareLingShouInfo]='UIChatLeftShareLingShouInfoItem',
[CHAT_COM_TYPE.eChatRightShareLingShouInfo]='UIChatRightShareLingShouInfoItem',
}


CHAT_EMOT_STYPE={
eSystem=-1,
eDefine=0,
}

CHAT_EMOT_TYPE=
{
eSystem=1,
eDefine=2,
ePacakge=3,
eItemEmot=4,
}

CHAT_EMOT_DESC_TYPE=
{
eTop=1,
eBottom=2,
eLeft=3,
eRight=4,
}

CHAT_EMOT_UNLOCK_CND_TYPE=
{
eZongmenLv=1,
}


CHAT_REGEX_TYPE=
{
eQieCuo=1,
eShareLXWJ=2,
eSharedz=3,
eShareCBG=4,
eAskCBG=5,
eTianMoRuQin=6,
eZZSHPosShare=7,
eTianMoJie=8,
csFairyLand=9,
csFairyLandHelp=10,
csOfficerElectionHelp=11,
csOfficerElection2Help=12,
csCaiShenJiaDaoHongBao=13,
csPuTongZhenJi=14,
csXianMengHongBao=15,
eShareLingShou=16,
}

CHAT_MESG_REFRESH_TYPE=
{
eRefreshServerName=1,
}

CHAT_MESG_NOTIFY_TYPE=
{
eFilterMesg=1,
}

chatConfig.voiceRegex="<#V_O_I_C_E! CK=(.*) fileid=(.*) lenth=(.*) /> txt=(.*)"
chatConfig.voiceString="<#V_O_I_C_E! CK={0} fileid={1} lenth={2} /> txt={3}"


chatConfig.linkRegex="<a;(.-);(.-);(.-);(.-);/>"
chatConfig.linkRegexFormat="<a;[{0}];{1};{2};{3};/>"
chatConfig.linkRegexFormatEx="<a;{0};{1};{2};{3};/>"

chatConfig.bigEmot_or="<#BIG_EMOT=(%d*);(.*)>"
chatConfig.bigEmot="<#BIG_EMOT=(%d*);(%d*);(%d*)>"
chatConfig.bigEmotFormat="<#BIG_EMOT={0};{1};{2}>"

chatConfig.emotRuleFormat='quad-{0}-quad'
chatConfig.emotfmt='quad-ani={0}-quad'
chatConfig.iconEmotTagFormat='icon={0}'


chatConfig.shareDiscipleInfo="<#SHARE_ROLEINFO=(.*);(.*);(.*);(.*);(.*);(.*);(.*);(.*);(.*)>"
chatConfig.shareDiscipleInfoFormat="<#SHARE_ROLEINFO={0};{1};{2};{3};{4};{5};{6};{7};{8}>"


chatConfig.shareQieCuoInfo="<#SHARE_ROLEINFO=(.*);(.*);(.*);(.*);(.*);(.*);(.*);(.*)>"

chatConfig.actRegex="<#ACT_CHAT=(.*);(.*)>"


chatConfig.chatRegex="<#CHAT=(%d*);(.-)>"

function chatConfig.getLangMsgType(key)
local cfg=cfg_lang_get(key)
if cfg==nil then return end
local cfg=cfg_langconfig_get(key)
local msgType=CHAT_MSG_TYPE.eNoFitler
if cfg and cfg.msgType then
msgType=cfg.msgType
end
return msgType
end

function chatConfig.getCmpSrcName(type)
return CHAT_COM_TYPE_NAME[type]
end

function chatConfig.getCommonConfig()
return cfg_chatconfig_get(1)
end

function chatConfig.getChannelConfig(channelId)
return cfg_chatchannnelconfig_get(channelId)
end

function chatConfig.getChannelUnlockLevel(channelId)
if chatConfig.getChannelConfig(channelId).level then
local cfglevel=pfwindowsModel:getVersionAndPfCfg(chatConfig.getChannelConfig(channelId).level)
return cfglevel
end
return 1
end

function chatConfig.getChannelUnlockSystem(channelId)
return chatConfig.getChannelConfig(channelId).sysid
end

function chatConfig.getAllChannelConfig()
return cfg_chatchannnelconfig()
end

function chatConfig.getLinkStr(name,color,underline,args)
local linkFlag=underline and 1 or 0
return FMT.fmt(chatConfig.linkRegexFormat,name,color,linkFlag,args)
end


function chatConfig.getSystemShowChannels(showPosValue)
local channels={}
for i,v in pairs(CHAT_CHANNNEL)do
local pos=CHAT_REF_CHANNNEL[v]
if pos and mathHelper.getBitValue(showPosValue,pos)then
channels[#channels+1]=v
end
end
return channels
end

function chatConfig.getHourPosValue(showPosValue)
local posArray={CHAT_SYSYTEM_POS.eTopHourse,CHAT_SYSYTEM_POS.eMidHourse}
local val=0
for i,pos in ipairs(posArray)do
if mathHelper.getBitValue(showPosValue,pos)then
val=val+math.pow(2,pos)
end
end
return val
end

function chatConfig.getSystemPosValue(channels)
if channels==nil then return 0 end
local posValue=0
for _,channelId in ipairs(channels)do
local pos=CHAT_REF_CHANNNEL[channelId]
if pos then
posValue=posValue+math.pow(2,pos)
end
end
return posValue
end

function chatConfig.contactHourPosValue(posValue1,posValue2)
local posArray={CHAT_SYSYTEM_POS.eTopHourse,CHAT_SYSYTEM_POS.eMidHourse}
local val=0
local lookup={}
for i,pos in ipairs(posArray)do
if mathHelper.getBitValue(posValue1,pos)then
val=val+math.pow(2,pos)
lookup[pos]=true
end

if lookup[pos]==nil and mathHelper.getBitValue(posValue2,pos)then
val=val+math.pow(2,pos)
lookup[pos]=true
end
end
return val
end


function chatConfig.getSmallEmotConfig()
return cfg_chatesystemmotconfig()
end


function chatConfig.getPackageEmotConfig()
return cfg_chatemotpackageconfig()
end


function chatConfig.getPackageEmotConfigById(id)
return cfg_chatemotpackageconfig_get(id)
end


function chatConfig.getBigEmotConfig()
return cfg_chatebigmotconfig()
end


function chatConfig.getSmallEmotConfigById(id)
return cfg_chatesystemmotconfig_get(id)
end


function chatConfig.getBigEmotConfigById(id)
return cfg_chatebigmotconfig_get(id)
end


function chatConfig.getDefineEmotConfig()
return cfg_chatdefinemotconfig()
end


function chatConfig.getDefineEmotConfigById(id)
return cfg_chatdefinemotconfig_get(id)
end


function chatConfig.getDefineEmotPosById(id)
return cfg_chatdefinemotconfig_get(id).pos
end

function chatConfig.getMaxDefineEmotNum()
return chatConfig.getCommonConfig().maxDefineEmot
end

function chatConfig.isPackageEmotShow(id)
local emotConfig=chatConfig.getPackageEmotConfigById(id)
if emotConfig then
return emotConfig.show==true
end
return false
end

function chatConfig.getCompType(chatInfo)
local msgType=chatInfo.msgType
local mesg=chatInfo.mesg
local isSelf=chatInfo:isSelfActor()
local regexType=chatInfo.regexType
local cmpTypeName
if regexType then
if regexType==CHAT_REGEX_TYPE.eSharedz then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightShareDiscipleInfo or
CHAT_COM_TYPE.eChatLeftShareDiscipleInfo
elseif regexType==CHAT_REGEX_TYPE.eQieCuo then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightShareQieCuoInfo or
CHAT_COM_TYPE.eChatLeftShareQieCuoInfo
elseif regexType==CHAT_REGEX_TYPE.eShareLXWJ then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatLeftShareLXWJInfo or
CHAT_COM_TYPE.eChatLeftShareLXWJInfo
elseif regexType==CHAT_REGEX_TYPE.eTianMoRuQin then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightTianMoRuQin or
CHAT_COM_TYPE.eChatLeftTianMoRuQin
elseif regexType==CHAT_REGEX_TYPE.eTianMoJie then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightTianMoJie or
CHAT_COM_TYPE.eChatLeftTianMoJie
elseif regexType==CHAT_REGEX_TYPE.csFairyLandHelp then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightXJZongMenUnderAttack or
CHAT_COM_TYPE.eChatLeftXJZongMenUnderAttack
elseif regexType==CHAT_REGEX_TYPE.csOfficerElectionHelp or regexType==CHAT_REGEX_TYPE.csOfficerElection2Help then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightXGJX or CHAT_COM_TYPE.eChatLeftXGJX
elseif regexType==CHAT_REGEX_TYPE.csCaiShenJiaDaoHongBao then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightShareCSJD or CHAT_COM_TYPE.eChatLeftShareCSJD
elseif regexType==CHAT_REGEX_TYPE.csXianMengHongBao then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightShareXMHB or CHAT_COM_TYPE.eChatLeftShareXMHB
elseif regexType==CHAT_REGEX_TYPE.eShareLingShou then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightShareLingShouInfo or CHAT_COM_TYPE.eChatLeftShareLingShouInfo
else
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRight or
CHAT_COM_TYPE.eChatLeft
end
else
local isSystemMesg=msgType==CHAT_MESSAGE_TYPE.eSystem
local isBigEmot=chatEmotHelper.containsBigEmot(mesg)
local isShareDiscipleInfo=chatEmotHelper.containsShareDiscipleInfo(chatInfo)
local isVoice=chatInfo.isVoice
local actArgs=chatInfo.actArgs
if isVoice then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightVoice or
CHAT_COM_TYPE.eChatLeftVoice
elseif actArgs then
cmpTypeName=chatActivityHelper:getCmpTypeName(actArgs.subType,actArgs.hType,isSelf)
elseif isBigEmot then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatBigEmotRight or
CHAT_COM_TYPE.eChatBigEmotLeft
elseif isShareDiscipleInfo then
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRightShareDiscipleInfo or
CHAT_COM_TYPE.eChatLeftShareDiscipleInfo
elseif isSystemMesg then
cmpTypeName=CHAT_COM_TYPE.eChatSimple
else
cmpTypeName=isSelf and CHAT_COM_TYPE.eChatRight or
CHAT_COM_TYPE.eChatLeft
end
end
return cmpTypeName
end

function chatConfig.getCompName(chatInfo)
local cmpTypeName=chatConfig.getCompType(chatInfo)
return chatConfig.getCmpSrcName(cmpTypeName)
end

function chatConfig.getLunDaoCompName(chatInfo)
local cmpTypeName=chatConfig.getCompType(chatInfo)
return LD_CHAT_COM_TYPE_NAME[cmpTypeName]
end

function chatConfig.hasNomalEmotAsset(assetName)
if chatConfig.emotAssetLookup==nil then
local lookup={}
for k,v in pairs(cfg_chatesystemmotconfig())do
lookup[v.assetname]=v.id
end
chatConfig.emotAssetLookup=lookup
end
return chatConfig.emotAssetLookup[assetName]~=nil
end


local _uploadMesgType=
{
ePrivate=1,
eWorld=4,
eXianMeng=6,
eOther=9,
}

function chatConfig.getUploadMesgType(msgInfoEx)
local channelId=msgInfoEx.channelId
local msgType=msgInfoEx.msgType
if msgType==CHAT_MESSAGE_TYPE.ePublic then
if channelId==CHAT_CHANNNEL.eWorld then
return _uploadMesgType.eWorld
elseif channelId==CHAT_CHANNNEL.eXianmeng then
return _uploadMesgType.eXianMeng
else
return _uploadMesgType.eOther
end
elseif msgType==CHAT_MESSAGE_TYPE.ePrivate then
return _uploadMesgType.ePrivate
end
end