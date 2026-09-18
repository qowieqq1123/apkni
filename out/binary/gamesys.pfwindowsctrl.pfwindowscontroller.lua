






local _MODULENAME="pfwindowslController"

gameState.addListener(def_table(_MODULENAME))
pfwindowslController.name=_MODULENAME


function pfwindowslController:onAppStart()
if not pfwindowslController.onAppStartInit then
pfwindowsModel:onAppStart()
pfwindowslController:init()

pfwindowslController:onAppStart_oumei()
pfwindowslController:onAppStart_uwp()
pfwindowslController:onAppStart_yuenan()
pfwindowslController.onAppStartInit=true
end






end


function pfwindowslController:onEnterState(isReconnect)
self.data={}
pfwindowsModel:onEnterState()

platformSDK:getEfunBindState()
timeEventController.addSlowTimerHandler("pfwindowslController",self)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
notifySystem:listenNotify(notifyConfig.onFreeGiftInit,self.onFreeGiftInit)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
pfwindowslController:onEnterState_uwp(isReconnect)
pfwindowslController:onEnterState_yuenan(isReconnect)
end


function pfwindowslController:onProtocolReq()
pfwindowsModel:onProtocolReq()
platformSDK:invoke("CheckGooglePurchase")
platformSDK:reqEfunShowPlatform()
end


function pfwindowslController:onLeaveState(isReconnect)
pfwindowsModel:onLeaveState(isReconnect)
timeEventController.removeSlowTimerHandler("pfwindowslController")
notifySystem:removelistener(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
notifySystem:removelistener(notifyConfig.onFreeGiftInit,self.onFreeGiftInit)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)

self.data={}
self.enterBindPhoneGuid=nil

pfwindowslController:onLeaveState_uwp(isReconnect)
pfwindowslController:onLeaveState_yuenan(isReconnect)
platformSDK:reqEfunDestoryPlatform()
end


function pfwindowslController:onLostConnection()

end


function pfwindowslController:onReConnection(isInitPro)

end






local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;
local _appConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
local _appConfig_GetString=CS.AppDataModel.AppConfig_GetString






pfwindowslController.sdkPFVersion=
{
game_jianti=1,
game_fanti_GA=2,
game_yuenan=3,
game_oumei=4,
game_taiwen=5,
}


pfwindowslController.dfHaiWaiSdkList=
{
["platformSDK_Android_HWFT"]=pfwindowslController.sdkPFVersion.game_fanti_GA,
["platformSDK_iOS_EFun"]=pfwindowslController.sdkPFVersion.game_fanti_GA,
["platformSDK_PC_Efun"]=pfwindowslController.sdkPFVersion.game_fanti_GA,
["platformSDK_Android_yuenan"]=pfwindowslController.sdkPFVersion.game_yuenan,
["platformSDK_iOS_FeiFang"]=pfwindowslController.sdkPFVersion.game_yuenan,
["platformSDK_Android_HWOuMei"]=pfwindowslController.sdkPFVersion.game_oumei,
["platformSDK_iOS_EFun_Eu"]=pfwindowslController.sdkPFVersion.game_oumei,
["platformSDK_PC_Efun_OuMei"]=pfwindowslController.sdkPFVersion.game_oumei,
["platformSDK_iOS_EFun_US"]=pfwindowslController.sdkPFVersion.game_oumei,
}



pfwindowslController.winType=
{
hideageImageTips=1,
hidejiankangzhonggao=2,
hidePrivacyAgreement=3,
hideGuiShuDi=5,
checkjuelundizi=6,
GABindAccount=7,
batchBuyFixedNum=8,
yiyuanlibao=9,
saomapc=10,
switchAccount=11,
bindAccount=12,
switchZone=13,
LineShare=14,
FBShare=15,
DdShare=16,
openKeFu=17,
}



pfwindowslController.winTypeMappingCfgName=
{
["hideageImageTips"]=pfwindowslController.winType.hideageImageTips,
["hidejiankangzhonggao"]=pfwindowslController.winType.hidejiankangzhonggao,
["hidePrivacyAgreement"]=pfwindowslController.winType.hidePrivacyAgreement,
["hideGuiShuDi"]=pfwindowslController.winType.hideGuiShuDi,
["juelundizi"]=pfwindowslController.winType.checkjuelundizi,
["bindAccount"]=pfwindowslController.winType.GABindAccount,
["batchBuyFixedNum"]=pfwindowslController.winType.batchBuyFixedNum,
["yiyuanlibao"]=pfwindowslController.winType.yiyuanlibao,
}



local VietnamWinTypeCfg=
{
[pfwindowslController.winType.checkjuelundizi]=true,
}



local OuMeiWinTypeCfg=
{
[pfwindowslController.winType.bindAccount]=true,
[pfwindowslController.winType.switchZone]=true,
[pfwindowslController.winType.FBShare]=true,
[pfwindowslController.winType.DdShare]=true,
[pfwindowslController.winType.openKeFu]=true,
}




local OuGangAoTypeCfg=
{
[pfwindowslController.winType.LineShare]=true,
[pfwindowslController.winType.FBShare]=true,
[pfwindowslController.winType.DdShare]=true,
}


local versionWinTypeCfg=
{
["platformSDK_Android_yuenan"]=VietnamWinTypeCfg,
["platformSDK_iOS_FeiFang"]=VietnamWinTypeCfg,
["platformSDK_Android_HWOuMei"]=OuMeiWinTypeCfg,
["platformSDK_iOS_EFun_Eu"]=OuMeiWinTypeCfg,
["platformSDK_Android_HWFT"]=OuGangAoTypeCfg,
["platformSDK_iOS_EFun"]=OuGangAoTypeCfg,
["platformSDK_PC_Efun_OuMei"]=OuMeiWinTypeCfg,
}




pfwindowslController.rechargeType=
{
RMB=1,
USD=2,
HK=3,
NT=4,
VDN=5,
}


pfwindowslController.priceTypeStr=
{
CNY="CNY",
HKD="HKD",
TWD="TWD",
USD="USD",
VND="VND",
}


pfwindowslController.VoiceType=
{
guoyu=1,
yingyu=2,
yueyu=3,
taiwanyu=4,
yuenanyu=5,
omyingyu=6,
taiwen=7,
}



pfwindowslController.sdkVoiceVersion=
{
["zh_CN"]=pfwindowslController.VoiceType.taiwanyu,
["zh_HK"]=pfwindowslController.VoiceType.yueyu
}


pfwindowslController.priceType=
{
[pfwindowslController.priceTypeStr.CNY]=pfwindowslController.rechargeType.RMB,
[pfwindowslController.priceTypeStr.HKD]=pfwindowslController.rechargeType.HK,
[pfwindowslController.priceTypeStr.TWD]=pfwindowslController.rechargeType.NT,
[pfwindowslController.priceTypeStr.USD]=pfwindowslController.rechargeType.USD,
[pfwindowslController.priceTypeStr.VND]=pfwindowslController.rechargeType.VDN,
}



local pvindex=
{
[pfwindowslController.VoiceType.guoyu]=pfwindowslController.sdkPFVersion.game_jianti,
[pfwindowslController.VoiceType.yueyu]=pfwindowslController.sdkPFVersion.game_fanti_GA,
[pfwindowslController.VoiceType.yuenanyu]=pfwindowslController.sdkPFVersion.game_yuenan,
[pfwindowslController.VoiceType.omyingyu]=pfwindowslController.sdkPFVersion.game_oumei,
[pfwindowslController.VoiceType.taiwen]=pfwindowslController.sdkPFVersion.game_taiwen,
}

function pfwindowslController:getPvIndex()
local VoiceVoiceVersion=pfwindowslController:getVoiceVoiceVersion()
return pvindex[VoiceVoiceVersion]or pfwindowslController.sdkPFVersion.game_jianti
end



local checkName=
{
[pfwindowslController.sdkPFVersion.game_jianti]=
{
check=function(namelenCfg,changeName)
if not helper.string_is_ChineseS(changeName)then
UIManager.error('请写汉字名讳')
return false
end
if helper.check_spec_chars(changeName)then
UIManager.info('名称含敏感字符')
return false
end
local len=helper.get_chars_lenght(changeName)
if len<namelenCfg[1]then
UIManager.info(FMT.fmt('名字长度少于{0}个字',namelenCfg[1]))
return false
elseif len>namelenCfg[2]then
UIManager.info(FMT.fmt('名字长度超过{0}个字',namelenCfg[2]))
return false
end
return true
end,
},
[pfwindowslController.sdkPFVersion.game_fanti_GA]=
{
check=function(namelenCfg,changeName)
if not helper.string_is_Invalid(changeName)then
UIManager.info('名稱含有無效字元')
return false
end
if helper.check_spec_chars(changeName)then
UIManager.info('名稱含有無效字元')
return false
end
local allStrCount,len,invalidCharacter=string.customStrLen(changeName)
if invalidCharacter then
UIManager.info('名稱含有無效字元')
return false
end
if allStrCount<namelenCfg[1]then
UIManager.info(FMT.fmt('名字長度少於{0}個字',namelenCfg[1]))
return false
elseif allStrCount>namelenCfg[2]then
UIManager.info('名字需少於6個中文或10個英文字母')
return false
end
return true
end
},
[pfwindowslController.sdkPFVersion.game_yuenan]=
{
check=function(namelenCfg,changeName)
local len=helper.get_chars_lenght(changeName)
if len<namelenCfg[1]then
UIManager.info(FMT.fmt('名字长度少于{0}个字',namelenCfg[1]))
return false
elseif len>namelenCfg[2]then
UIManager.info(FMT.fmt('名字长度超过{0}个字',namelenCfg[2]))
return false
end
return true
end
},
[pfwindowslController.sdkPFVersion.game_oumei]=
{
check=function(namelenCfg,changeName)
if helper.check_spec_chars(changeName)then
UIManager.info('Name contains prohibited characters')
return false
end
local len=helper.get_chars_lenght(changeName)
if len<namelenCfg[1]then
UIManager.info(FMT.fmt('Name is below {0} characters!',namelenCfg[1]))
return false
elseif len>namelenCfg[2]then
UIManager.info(FMT.fmt('Name is above {0} characters!',namelenCfg[2]))
return false
end
return true
end
},
}


local winstate=
{
hide=1,
show=0,
}

local pfwindowsctrlcfg

local winState_ByPFID
local HWLocalRegionName="HKD"
local isguofu=true
local voiceVersion=pfwindowslController.VoiceType.guoyu
local GameVersion=pfwindowslController.sdkPFVersion.game_jianti


local cfgForbidden

function pfwindowslController:init()
pfwindowslController:initGameVersion()
pfwindowslController:initVioceVersion()
pfwindowslController:initRechargeConfig()
end



function pfwindowslController:initVioceVersion()
if GameVersion==pfwindowslController.sdkPFVersion.game_jianti then
pfwindowslController:setVoiceVoiceVersion(voiceVersion)
elseif GameVersion==pfwindowslController.sdkPFVersion.game_fanti_GA then
pfwindowslController:setVoiceVoiceVersion(pfwindowslController.VoiceType.taiwanyu)
pfwindowslController:reqVioceVersion()
elseif GameVersion==pfwindowslController.sdkPFVersion.game_oumei then

pfwindowslController:setVoiceVoiceVersion(pfwindowslController.VoiceType.omyingyu)

elseif GameVersion==pfwindowslController.sdkPFVersion.game_yuenan then
pfwindowslController:setVoiceVoiceVersion(pfwindowslController.VoiceType.yuenanyu)
end
end



function pfwindowslController:checkIsGameVersion_guofu()
return isguofu
end


function pfwindowslController:checkIsGameVersion_HWFT()
return GameVersion==pfwindowslController.sdkPFVersion.game_fanti_GA
end


function pfwindowslController:checkIsGameVersion_HWFT_PC()
return deviceHelper.getAppPlatform()=="platformSDK_PC_Efun"
end


function pfwindowslController:checkIsGameVersion_yuenan()
return GameVersion==pfwindowslController.sdkPFVersion.game_yuenan
end


function pfwindowslController:checkIsGameVersion_oumei()
return GameVersion==pfwindowslController.sdkPFVersion.game_oumei
end


function pfwindowslController:checkSdkIsEFUN(pfName)
local flagGA=pfwindowslController.dfHaiWaiSdkList[pfName]==pfwindowslController.sdkPFVersion.game_fanti_GA
local flagOM=pfwindowslController.dfHaiWaiSdkList[pfName]==pfwindowslController.sdkPFVersion.game_oumei
return flagGA or flagOM
end


function pfwindowslController:checkIsGameVersion_OM_PC()
return deviceHelper.getAppPlatform()=="platformSDK_PC_Efun_OuMei"
end

function pfwindowslController:checkSdkIsEFUN_ByPf()
local pfName=deviceHelper.getAppPlatform()
return pfwindowslController:checkSdkIsEFUN(pfName)
end


function pfwindowslController:checkAmericanNumberSystem()
return pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei()
end


function pfwindowslController:initGameVersion()
if not pfwindowslController.dfHaiWaiSdkList[deviceHelper.getAppPlatform()]then
GameVersion=pfwindowslController.sdkPFVersion.game_jianti
else
GameVersion=pfwindowslController.dfHaiWaiSdkList[deviceHelper.getAppPlatform()]
end
isguofu=GameVersion==pfwindowslController.sdkPFVersion.game_jianti
end


function pfwindowslController:setGameVersion(Version)
GameVersion=Version
isguofu=GameVersion==pfwindowslController.sdkPFVersion.game_jianti
pfwindowslController:initVioceVersion()
pfwindowslController:initRechargeConfig()
end


function pfwindowslController:getGameVersion()
if not pfwindowslController.GameVersionInit then
pfwindowslController:initGameVersion()
pfwindowslController.GameVersionInit=true
end
return GameVersion
end



function pfwindowslController:getVoiceVoiceVersion()
return voiceVersion
end

function pfwindowslController:setVoiceVoiceVersion(invoiceVersion)
voiceVersion=invoiceVersion
pfwindowslController:setMyLanguageType(voiceVersion)
end


function pfwindowslController:setHWLocalRegionName(LocalRegionName)
platformSDK.printSDK('setHWLocalRegionName',LocalRegionName)
HWLocalRegionName=LocalRegionName
if not pfwindowslController.priceType[LocalRegionName]then
HWLocalRegionName=pfwindowslController.priceTypeStr.USD
platformSDK.printSDK('不存在HWLocalRegionName：',LocalRegionName)
end
pfwindowslController:initHWRechargeConfig()
firstRechargeModel:initSortCfgList()





end



function pfwindowslController:setMyLanguageType(version)
platformSDK.printSDK('setMyLanguageType',version)
if api_Available_SetSoundLanguageInfo()then
platformSDK.printSDK('setMyLanguageTypex',version)

CS.GameInterface.SetSoundLanguageInfo(version,{'_gy','_gy','_tw','_ga','_ga','_vnd','_omyy'})
end
end


function pfwindowslController:getPFMoneyType()
if pfwindowslController.dfHaiWaiSdkList[deviceHelper.getAppPlatform()]then
return HWLocalRegionName
end
return pfwindowslController.priceTypeStr.CNY
end





function pfwindowslController:initRechargeConfig()
if pfwindowslController:checkIsGameVersion_guofu()then
pfwindowslController:setHWLocalRegionName(pfwindowslController.priceTypeStr.CNY)
elseif pfwindowslController:checkIsGameVersion_HWFT()then
if pfwindowslController:checkIsGameVersion_HWFT_PC()then
pfwindowslController:setHWLocalRegionName(pfwindowslController.priceTypeStr.USD)
else
pfwindowslController:setHWLocalRegionName(pfwindowslController.priceTypeStr.USD)
end
elseif pfwindowslController:checkIsGameVersion_yuenan()then
pfwindowslController:setHWLocalRegionName(pfwindowslController.priceTypeStr.VND)
elseif pfwindowslController:checkIsGameVersion_oumei()then
pfwindowslController:setHWLocalRegionName(pfwindowslController.priceTypeStr.USD)
end
end


function pfwindowslController:initHWRechargeConfig()
local GameVersion=pfwindowslController:getGameVersion()
local moneyType=HWLocalRegionName
local allConfig=cfg_rechargeconfig()
for i,v in pairs(allConfig)do
if allConfig[i].pay then





if allConfig[i].pay and allConfig[i].pay[GameVersion]then
allConfig[i].rmb=allConfig[i].pay[GameVersion][moneyType]
end
end
end
platformSDK.printSDK('儲值表初始化完成',HWLocalRegionName)
end





function pfwindowslController:initfwindowsctrlcfg()
if not pfwindowsctrlcfg then
pfwindowsctrlcfg=cfg_pfwindowsctrlcfg_get(1)
end
winState_ByPFID={}
local pfid=loginModel:getPfid()
for name,cfg in pairs(pfwindowsctrlcfg)do
local winType=pfwindowslController.winTypeMappingCfgName[name]
if winType then
if not winState_ByPFID[winType]then
winState_ByPFID[winType]={}
end
if cfg[pfid]then
winState_ByPFID[winType][pfid]=true
end
end
end
end



function pfwindowslController:checkPFWinState_ByWinType(winType)
if not pfwindowsctrlcfg then
pfwindowsctrlcfg=cfg_pfwindowsctrlcfg_get(1)
end
if not winState_ByPFID then
pfwindowslController:initfwindowsctrlcfg()
end
local pfName=deviceHelper.getAppPlatform()
if pfwindowslController.dfHaiWaiSdkList[pfName]then
local pfid=loginModel:getPfid()
if winState_ByPFID[winType]and winState_ByPFID[winType][pfid]then
return winState_ByPFID[winType][pfid]
end
return false
end
return true
end




function pfwindowslController:checkPFWinState_ByCfg(winType)
local pfName=deviceHelper.getAppPlatform()
local versionCfg=versionWinTypeCfg[pfName]
if versionCfg and versionCfg[winType]then
return versionCfg[winType]
end
return false
end



function pfwindowslController:checkPFWinState_ByWinType_DfShow(winType)
if not pfwindowsctrlcfg then
pfwindowsctrlcfg=cfg_pfwindowsctrlcfg_get(1)
end
if not winState_ByPFID then
pfwindowslController:initfwindowsctrlcfg()
end
local pfName=deviceHelper.getAppPlatform()
if pfwindowslController:checkSdkIsEFUN(pfName)then
local pfid=loginModel:getPfid()
if winState_ByPFID[winType]and winState_ByPFID[winType][pfid]then
return winState_ByPFID[winType][pfid]
end
return true
else
local versionCfg=versionWinTypeCfg[pfName]
if versionCfg and versionCfg[winType]then
return versionCfg[winType]
end
end
return false
end

local showMoneyStr=
{
[pfwindowslController.priceTypeStr.USD]='US${0}',
[pfwindowslController.priceTypeStr.HKD]='HK${0}',
[pfwindowslController.priceTypeStr.TWD]='NT${0}',
[pfwindowslController.priceTypeStr.CNY]='{0}元',
[pfwindowslController.priceTypeStr.VND]='{0}VND',
}


function pfwindowslController:showDesc_ByMoneyType(config)
local MoneyType=pfwindowslController:getPFMoneyType()
local GameVersion=pfwindowslController:getGameVersion()
local moneyCount=config.pay[GameVersion][MoneyType]
local str=showMoneyStr[MoneyType]
if MoneyType==pfwindowslController.priceTypeStr.USD then
return FMT.fmt(str,moneyCount)
else
return FMT.fmt(str,moneyCount)
end
end

local showMoneyStrTwo=
{
[pfwindowslController.priceTypeStr.USD]='累計{0}天儲值{1}仙緣',
[pfwindowslController.priceTypeStr.HKD]='累計{0}天儲值{1}仙緣',
[pfwindowslController.priceTypeStr.TWD]='累計{0}天儲值{1}仙緣',
[pfwindowslController.priceTypeStr.CNY]='累计{0}天充值{1}元',
[pfwindowslController.priceTypeStr.VND]='累计{0}天充值{1}元',
}



function pfwindowslController:showDescTwo_ByMoneyType(day,config)
local MoneyType=pfwindowslController:getPFMoneyType()
local GameVersion=pfwindowslController:getGameVersion()
local moneyCount=config.pay[GameVersion][MoneyType]
local str=showMoneyStrTwo[MoneyType]
if MoneyType==pfwindowslController.priceTypeStr.CNY then
return FMT.fmt(str,day,moneyCount)
else
local rechargeAmount=payControl:getRechargeAmountByCfg(config)
return FMT.fmt(str,day,rechargeAmount)
end
end

local showMoneyStrThree=
{
[pfwindowslController.priceTypeStr.USD]='今日已儲值{0}仙緣',
[pfwindowslController.priceTypeStr.HKD]='今日已儲值{0}仙緣',
[pfwindowslController.priceTypeStr.TWD]='今日已儲值{0}仙緣',
[pfwindowslController.priceTypeStr.CNY]='今日已充：{0}元',
[pfwindowslController.priceTypeStr.VND]='今日已充：{0}元',
}


function pfwindowslController:showDescThree_ByMoneyType(Recharge)
local MoneyType=pfwindowslController:getPFMoneyType()
local str=showMoneyStrThree[MoneyType]
if MoneyType==pfwindowslController.priceTypeStr.USD then
return FMT.fmt(str,Recharge)
else
return FMT.fmt(str,Recharge)
end
end


local showMoneyFourStr=
{
[pfwindowslController.priceTypeStr.USD]='US${0}',
[pfwindowslController.priceTypeStr.HKD]='HK${0}',
[pfwindowslController.priceTypeStr.TWD]='NT${0}',
[pfwindowslController.priceTypeStr.CNY]='￥{0}',
[pfwindowslController.priceTypeStr.VND]='{0}VND',
}


function pfwindowslController:showDescFour_ByMoneyType(config)
local MoneyType=pfwindowslController:getPFMoneyType()
local GameVersion=pfwindowslController:getGameVersion()
local moneyCount=config.pay[GameVersion][MoneyType]
local str=showMoneyFourStr[MoneyType]
if MoneyType==pfwindowslController.priceTypeStr.USD then
return FMT.fmt(str,moneyCount)
else
return FMT.fmt(str,moneyCount)
end
end




function pfwindowslController:showDescFive_ByMoneyType(config)
local MoneyType=pfwindowslController:getPFMoneyType()
local GameVersion=pfwindowslController:getGameVersion()
local moneyCount=config.pay[GameVersion][MoneyType]
if MoneyType==pfwindowslController.priceTypeStr.CNY then
return moneyCount
else
local rechargeAmount=payControl:getRechargeAmountByCfg(config)
return rechargeAmount
end
end


function pfwindowslController:showDescSix(num)
if pfwindowslController:checkIsGameVersion_guofu()then
return FMT.fmt("{0}折",num)
end
return"热销"
end


function pfwindowslController:convertDiscount_yuenan(text)
if pfwindowslController:checkIsGameVersion_yuenan()then

local function calculateNegativePercent(x)
local reduction=(10-x)*10
if reduction==0 then
return"0%"
end
return string.format("-%g%%",reduction)
end


local replacedText=string.gsub(text,"([%d.]+) ([Cc])hiết khấu",function(xStr,c)
local x=tonumber(xStr)
if not x then
return xStr.." "..c.."hiết khấu"
end
return calculateNegativePercent(x)
end)


replacedText=string.gsub(replacedText,"([Cc])hiết khấu ([%d.]+)",function(c,xStr)
local x=tonumber(xStr)
if not x then
return c.."hiết khấu "..xStr
end
return calculateNegativePercent(x)
end)

return replacedText
else
return text
end
end

local GiftStr=
{
"I",
"II",
"III",
"IV",
"V",
"VI",
"VII",
"VIII",
"IX",
"X",
"XI",
"XII",
"XIII",
"XIV",
"XV",
"XVI",
"XVII",
"XVIII",
"XIX",
"XX",
"XXI",
"XXII",
"XXIII",
"XXIV",
"XXV",
"XXVI",
"XXVII",
"XXVIII",
"XXIX",
"XXX",
}


function pfwindowslController:showDescSix_ByIndex(index)
return GiftStr[index]or""
end

local LeiJieFontMapiingVN=
{
["Đạo Lôi Kiếp thứ nhất"]="ABCDH",
["Đạo Lôi Kiếp thứ hai"]="ABCDI",
["Đạo Lôi Kiếp thứ ba"]="ABCDP",
["Đạo Lôi Kiếp thứ tư"]="ABCDJ",
["Đạo Lôi Kiếp thứ năm"]="ABCDK",
["Đạo Lôi Kiếp thứ sáu"]="ABCDL",
["Đạo Lôi Kiếp thứ bảy"]="ABCDM",
["Đạo Lôi Kiếp thứ tám"]="ABCDN",
["Đạo Lôi Kiếp thứ chín"]="ABCDO",
}


function pfwindowslController:showDescSeven_ByMoneyType(config,num)
local MoneyType=pfwindowslController:getPFMoneyType()
local GameVersion=pfwindowslController:getGameVersion()
local moneyCount=config.pay[GameVersion][MoneyType]
local str=showMoneyStr[MoneyType]
if MoneyType==pfwindowslController.priceTypeStr.USD then
return FMT.fmt(str,moneyCount*num)
else
return FMT.fmt(str,moneyCount*num)
end
end

local LeiJieFontMapiingCfg=
{
[pfwindowslController.sdkPFVersion.game_yuenan]=LeiJieFontMapiingVN,
}


function pfwindowslController:showDescLeiJie_ByIndex(str)
local cfg=LeiJieFontMapiingCfg[GameVersion]
if cfg then
return LeiJieFontMapiingVN[str]or str
end
return str
end



function pfwindowslController:getStageStr(itemId,stageTitile)
local itemConfig=itemsConfig.getConfig(itemId)
local GameVersion=pfwindowslController:getGameVersion()
local stageStr=itemConfig.stage and FMT.fmt('{0}{1}',itemConfig.stage,stageTitile)or''
if pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei()then
stageStr=itemConfig.stage and FMT.fmt('{0} {1}',stageTitile,itemConfig.stage)or''
end
return stageStr
end


function pfwindowslController:OpenURL_By_UIWebViewWin(URL)
LuaApplication.GetApplication().OpenURL(URL)
end



local IOSURL="https://apps.apple.com/tw/app/id6648774034"
local AndroidURL="https://play.google.com/store/apps/details?id=com.mover.twzqzs"
local haoPingGiftId=67


function pfwindowslController.onDiscipleCreate(dis_guid)
if verifyManager:isOpen()then
return false
end
local pfOpen=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.checkjuelundizi)
if pfOpen then
local color=UIDiscipleModel:getDiscipleColor(dis_guid)
local isPlot=UIDiscipleModel:isPlotDisciple(dis_guid)
if color>=4 and not isPlot then
pfwindowslController:checkHaoPingReward()
pfwindowslController:checkHaoPingPopUP_OuMei_Role(dis_guid)
end
end
end


function pfwindowslController.onFreeGiftInit()
pfwindowslController:checkBindPhoneEnter(true)
pfwindowslController:checkBindAccountEnter_OM(true)
end

function pfwindowslController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eYouJian then
pfwindowslController.onFreeGiftInit()
end
end


function pfwindowslController:openHaoPingURL()
if deviceHelper.isRunIOS()then
platformSDK:invoke("reqPingLun")
return
end

pfwindowslController:OpenURL_By_UIWebViewWin(AndroidURL)

timeEventController.delayDo(1,function()
userActorSetting.set("haoPingYouLi",haoPingYouLiTypeEnum.eClickURL)
userActorSetting.flush()
UIManager:invokeUIMethod("UIHaoPingYouLiWin","refreshBtnState")
UIManager:invokeUIMethod("UIHaoPingYouLiPopupWin","refreshBtnState")
pfwindowslController:receiveHaoPingReward()
end)
end

function pfwindowslController:canVisiableHaoPingYouLi()
local pfOpen=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.checkjuelundizi)
local haoPing=userActorSetting.get("haoPingYouLi",0)
return pfOpen and(haoPing==1 or haoPing==2)and FreeGiftController.GetFreeGift(haoPingGiftId)
end

function pfwindowslController:getHaoPingGiftId()
return haoPingGiftId
end

function pfwindowslController:receiveHaoPingReward()
FreeGiftController.SendFreeGift(haoPingGiftId,nil,function()
userActorSetting.set("haoPingYouLi",haoPingYouLiTypeEnum.eReward)
userActorSetting.flush()
UIManager:invokeUIMethod("UIHaoPingYouLiWin","refreshBtnState")
UIManager:invokeUIMethod("UIHaoPingYouLiPopupWin","refreshBtnState")
UIManager:closeWindow("UIHaoPingYouLiPopupWin")
end)
end





function pfwindowslController:checkHaoPingReward()
if pfwindowslController:checkIsGameVersion_oumei()then

return
end
local haoPing=userActorSetting.get("haoPingYouLi",0)
if haoPing==0 and FreeGiftController.GetFreeGift(haoPingGiftId)then
if pfwindowslController:checkIsGameVersion_yuenan()then
pfwindowslController:receiveHaoPingReward_yuenan()
else
userActorSetting.set("haoPingYouLi",haoPingYouLiTypeEnum.ePopUpEnd)
userActorSetting.flush()
timeEventController.delayDo(1,function()
msgWinControl:addMsgWin(msgWinType.eHaoPingYouLi)
end)
end
end
end


function pfwindowslController:checkHaoPingReward_Shouchong()
local haoPing=userActorSetting.get("haoPingYouLi",0)
if haoPing==0 and FreeGiftController.GetFreeGift(haoPingGiftId)then
if pfwindowslController:checkIsGameVersion_yuenan()then
pfwindowslController:receiveHaoPingReward_yuenan()
end
end
end



function pfwindowslController:setPhoneBindState(isBindAccount,isBindPhone,isBindThirdPlatform)
self.data.isBindAccount=isBindAccount
self.data.isBindPhone=isBindPhone
self.data.isBindThirdPlatform=isBindThirdPlatform
timeEventController.delayDo(1,function()
if FreeGiftController:checkInitFinish()then
pfwindowslController:checkBindPhoneEnter()
pfwindowslController:checkBindAccountEnter_OM()
end
end)
end


function pfwindowslController:setBindPhone(isBindPhone)
self.data.isBindPhone=isBindPhone
if isBindPhone then
if pfwindowslController:checkIsGameVersion_oumei()then
if pfwindowslController:canReceiveBindPhoneGift()then
pfwindowslController:receiveBindPhoneReward()
end
return
end
UIManager.info("綁定成功")
else
UIManager.info("綁定失敗")
end
UIManager:invokeUIMethod("UIBindPhoneWin","refreshBtnState")
end



function pfwindowslController:getEfunPhoneBindState()
platformSDK.printSDK("phoneBindState",self.data.isBindPhone)
if self.data.isBindPhone then
return self.data.isBindPhone
end
return false
end


function pfwindowslController:getPhoneCaptcha(phoneNumber)
platformSDK:getPhoneCaptcha(phoneNumber)
end


function pfwindowslController:getPhoneCaptchaCallBack(result)
if result then
UIManager.info("獲取成功")
self.data.codeReqTimeStamp=timeHelper.getServerShortTime()
UIManager:invokeUIMethod("UIBindPhoneWin","refreshCodeBtnState")
else
UIManager.info("獲取失敗,請檢查號碼或聯繫客服")
end
end

function pfwindowslController:getPhoneCaptchaLastTimeStamp()
return self.data.codeReqTimeStamp or 0
end


function pfwindowslController:reqPhoneBind(phoneNumber,captchaCode)
platformSDK:reqPhoneBind(phoneNumber,captchaCode)
end



local bindPhoneGiftId=68

function pfwindowslController:getBindPhoneGiftId()
return bindPhoneGiftId
end

function pfwindowslController:canReceiveBindPhoneGift()
local pfOpen=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.GABindAccount)
local isBind=pfwindowslController:getEfunPhoneBindState()
return pfOpen and isBind and FreeGiftController.GetFreeGift(bindPhoneGiftId)
end

function pfwindowslController:canVisiableBindPhone()
if verifyManager:isOpen()then
return false
end
if pfCommonHelper:isRunPC()then
return false
end
local pfOpen=pfwindowslController:checkPFWinState_ByWinType_DfShow(pfwindowslController.winType.GABindAccount)
platformSDK.printSDK('[bindPhone] pfOpen  GetFreeGift',pfOpen,FreeGiftController.GetFreeGift(bindPhoneGiftId))
return pfOpen and FreeGiftController.GetFreeGift(bindPhoneGiftId)
end

function pfwindowslController:checkBindPhoneReddot()
if pfwindowslController:canReceiveBindPhoneGift()then
return true
end
local lastClickStamp=userActorSetting.get("bindPhoneClickTime",0)
local time=timeHelper.getServerLongTime()
local isSameDay=timeHelper.checkInSameDay(lastClickStamp,time)
return not isSameDay
end



function pfwindowslController:receiveBindPhoneReward()
FreeGiftController.SendFreeGift(bindPhoneGiftId,nil,function()
pfwindowslController:removeBindPhoneEnter()
UIManager:closeWindow("UIBindPhoneWin")
end)
end

function pfwindowslController:checkBindPhoneEnter(needRemove)
platformSDK.printSDK('[bindPhone] checkBindPhoneEnter',self.enterBindPhoneGuid)
if pfwindowslController:checkIsGameVersion_oumei()then

return
end
if pfwindowslController:checkIsGameVersion_HWFT()then
local isHasEnterGuidOriginal=self.enterBindPhoneGuid~=nil
local isOpen=pfwindowslController:canVisiableBindPhone()
local isShowEnter=false
if isOpen then

platformSDK.printSDK('[bindPhone] enterManager:freshEnter',self.enterBindPhoneGuid)
self.enterBindPhoneGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eBindPhone,getReddotFun=function()
return pfwindowslController:checkBindPhoneReddot()
end})
isShowEnter=true
if isHasEnterGuidOriginal then

pfwindowslController:refreshBindPhoneEnterReddot()
end
end

if needRemove and not isShowEnter then
pfwindowslController:removeBindPhoneEnter()
end
end
end


function pfwindowslController:removeBindPhoneEnter()
if self.enterBindPhoneGuid then

enterManager:freshFunc('onClose',ENTER_TYPE.eBindPhone)
local ret=enterManager:removeEnter(self.enterBindPhoneGuid)
self.enterBindPhoneGuid=nil
if ret then

UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end
end


function pfwindowslController:refreshBindPhoneEnterReddot()
enterManager:freshFunc('freshReddot',ENTER_TYPE.eBindPhone)
end

function pfwindowslController:onSlowUpdate()
pfwindowsModel:checkAuctionBroadcast()
end


local voiceURL="https://login.movergames.com/activty/getVoicePacketLanguage.shtml"


function pfwindowslController:reqVioceVersion()
_httpGetRequest(voiceURL,self.onVioceVersionCB)
end

function pfwindowslController.onVioceVersionCB(message,err)
if err==""or not err then
local json_table=jsonHelper.decode(message)
if json_table then
if json_table.code=="e1000"then
local data=json_table.data
local voiceType=data.language
local VoiceVersion=pfwindowslController.sdkVoiceVersion[voiceType]or pfwindowslController.VoiceType.taiwanyu
pfwindowslController:setVoiceVoiceVersion(VoiceVersion)
platformSDK.printSDK('reqVioceVersionlanguage',voiceType)
end
platformSDK.printSDK('reqVioceVersionCode',json_table.code)
end
else
platformSDK.printSDK('reqVioceVersion返回错误',err)
end
end




function pfwindowslController.checkNameLenInvalid(changeName,namelenCfg)
local GameVersion=pfwindowslController:getGameVersion()
local checkHandle=checkName[GameVersion]
if checkHandle then
return checkHandle.check(namelenCfg,changeName)
end
return true
end

function pfwindowslController:needFixedBeginVedio()
local voiceVer=pfwindowslController:getVoiceVoiceVersion()
if deviceHelper.isRunIOS()and voiceVer==pfwindowslController.VoiceType.taiwanyu then
local verifyid=CS.AppDataModel.AppConfig_GetString('verifyid','')
if verifyid and verifyid~=''and tonumber(verifyid)<=7 then
return true
end
end
return false
end


function pfwindowslController:checkSkipCfgForbidden()
if cfgForbidden==nil then
cfgForbidden=_appConfig_GetBool('cfgForbidden',false)
end
if cfgForbidden then
return true
end
return false
end


local EFUN_PC_PfName=
{
EFUN="EFUN",
STEAM="STEAM",
GOOGLE="GOOGLE",
}


function pfwindowslController:checkEfunPFNameIsGoogle()
local pcPfName=_appConfig_GetString('EFUN_PC_PfName','EFUN')
return pcPfName==EFUN_PC_PfName.GOOGLE
end



function pfwindowslController:getDateFormatForVersion(hasNewLine)
local dateFormat
if self:checkIsGameVersion_yuenan()then
dateFormat=hasNewLine and"%d-%m-%Y\n%H:%M:%S"or"%d-%m-%Y %H:%M:%S"
else
dateFormat=hasNewLine and"%Y-%m-%d\n%H:%M:%S"or"%Y-%m-%d %H:%M:%S"
end
return dateFormat
end


local rechargeTestPF=
{
["platformSDK_None"]=true,
["platformSDK_Android_HWFT"]=true,
["platformSDK_Android_yuenan"]=true,
["platformSDK_Android_HWOuMei"]=true,
}

function pfwindowslController:checkIntranetPFRecharge()
local platform=deviceHelper.getAppPlatform()
return rechargeTestPF[platform]
end


function pfwindowslController:Report_255_2_PF()
local guofu=pfwindowslController:checkIsGameVersion_guofu()
local yuenan=pfwindowslController:checkIsGameVersion_yuenan()
return guofu or yuenan
end




function pfwindowslController:getZoneEnterInfo()
return platformSDK:invoke("getEnterInfo")
end
