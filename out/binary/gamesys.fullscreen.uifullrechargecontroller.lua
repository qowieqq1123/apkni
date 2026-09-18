








UIFullRechargeController=gameState.addListener(fullScreenUI.create())

function UIFullRechargeController:onAppStart()
local function _showRechargeWindow(...)self:showRechargeWindow(...)end
local function _showXianGouLiBaoWin(argstable)
self:showXianGouLiBaoWin(argstable)
end
local function _showXianGouWeekLiBaoWin(argstable)
self:showXianGouWeekLiBaoWin(argstable)
end
local function _showXianGouMonthLiBaoWin(argstable)
self:showXianGouMonthLiBaoWin(argstable)
end
local function _showXianGouGuangGaoLiBaoWin(argstable)
self:showXianGouGuangGaoLiBaoWin(argstable)
end
local function _showMonthInvestorWin(argstable)
self:showMonthInvestorWin(argstable)
end
local function _showLingCuiShopWin(argstable)
self:showLingCuiShopWin(argstable)
end
local function _showDailyTeHuiWin(argstable)
self:showDailyTeHuiWin(argstable)
end
local function _showPushGiftWin(argstable)
self:showPushGiftWin(argstable)
end
local function _showPushGiftThreeWin(argstable)
self:showPushGiftThreeWin(argstable)
end
local function _showDailyTeHuiSingleDayWin(argstable)
self:showDailyTeHuiSingleDayWin(argstable)
end

local function _showSelectLiBaoWin(argstable)
self:showSelectLiBaoWin(argstable)
end

local function _checkPushGiftOpen()
return self:checkPushGiftOpen()
end

local function _checkPushGiftThreeOpen()
return self:checkPushGiftThreeOpen()
end

local function _checkGuanYingGe()
return adController:supportPlayAD()
end

local menulist=
{

{tabType=FULL_TAB_TYPE.eMonthInvestor,callback=_showMonthInvestorWin,reddotType=REDDIT_SUB_TYPE.sMonthInvestor},

{tabType=FULL_TAB_TYPE.ePushGift,callback=_showPushGiftWin,reddotType=REDDIT_SUB_TYPE.sPushGift,checkOpen=_checkPushGiftOpen},

{tabType=FULL_TAB_TYPE.ePushGiftThree,callback=_showPushGiftThreeWin,reddotType=REDDIT_SUB_TYPE.sPushGift,checkOpen=_checkPushGiftThreeOpen},

{tabType=FULL_TAB_TYPE.eRechargeDailyTeHui,callback=_showDailyTeHuiWin,reddotType=REDDIT_SUB_TYPE.sRechargeDailyTeHui},

{tabType=FULL_TAB_TYPE.eRechargeDailyTeHuiSingleDay,callback=_showDailyTeHuiSingleDayWin,reddotType=REDDIT_SUB_TYPE.sRechargeDailyTeHuiSingleDay},

{tabType=FULL_TAB_TYPE.eSelfSelectGif,callback=_showSelectLiBaoWin,reddotType=REDDIT_SUB_TYPE.sSelectLiBao},

{tabType=FULL_TAB_TYPE.eReChargeLiBao,callback=_showXianGouLiBaoWin,reddotType=REDDIT_SUB_TYPE.sXianGouLiBao},

{tabType=FULL_TAB_TYPE.eReChargeWeekLiBao,callback=_showXianGouWeekLiBaoWin,reddotType=REDDIT_SUB_TYPE.sXianGouWeekLiBao},





{tabType=FULL_TAB_TYPE.eReChargeGuanYingGe,callback=_showXianGouGuangGaoLiBaoWin,reddotType=REDDIT_SUB_TYPE.sXianGouGuangGaoLiBao,checkOpen=_checkGuanYingGe},

{tabType=FULL_TAB_TYPE.eRecharge,callback=_showRechargeWindow},

}
if verifyManager:isHideBusinessActivity()then
menulist={

{tabType=FULL_TAB_TYPE.eRecharge,callback=_showRechargeWindow},
}
end
local args=
{
skinType=fullScreenSkinType.eSkin8,
menulist=menulist,
fullType=FULL_TYPE.eRecharge,
defaultTabType=FULL_TAB_TYPE.eReChargeLiBao,
}
self:initUI(args)
end

function UIFullRechargeController:showMyWindow(args)


if verifyManager:isHideBusinessActivity()then
return UIFullRechargeController:showRechargeWindow(args)
end

if verifyManager:isHideRecharge()then
return false
end

local page=args and args.tabType
if not page then
if systemModel.isOpen(SYSTEM_DEFINE.eNewDayDiscounts)then
page=FULL_TAB_TYPE.eRechargeDailyTeHuiSingleDay
elseif systemModel.isOpen(SYSTEM_DEFINE.eDayDiscounts)then
page=FULL_TAB_TYPE.eRechargeDailyTeHui
else
page=FULL_TAB_TYPE.eReChargeLiBao
end
end
if page==FULL_TAB_TYPE.eReChargeLiBao then
return UIFullRechargeController:showXianGouLiBaoWin(args)
elseif page==FULL_TAB_TYPE.eReChargeWeekLiBao then
return UIFullRechargeController:showXianGouWeekLiBaoWin(args)
elseif page==FULL_TAB_TYPE.eReChargeGuanYingGe then
return UIFullRechargeController:showXianGouGuangGaoLiBaoWin(args)
elseif page==FULL_TAB_TYPE.eRecharge then
return UIFullRechargeController:showRechargeWindow(args)
elseif page==FULL_TAB_TYPE.eMonthInvestor then
return UIFullRechargeController:showMonthInvestorWin(args)
elseif page==FULL_TAB_TYPE.ePushGift then
return UIFullRechargeController:showPushGiftWin(args)
elseif page==FULL_TAB_TYPE.eRechargeDailyTeHui then
return UIFullRechargeController:showDailyTeHuiWin(args)
elseif page==FULL_TAB_TYPE.eRechargeDailyTeHuiSingleDay then
return UIFullRechargeController:showDailyTeHuiSingleDayWin(args)
elseif page==FULL_TAB_TYPE.eSelfSelectGif then
return UIFullRechargeController:showSelectLiBaoWin(args)


end
return false
end


function UIFullRechargeController:showRechargeWindow(argstable)
if verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_yuenan()and deviceHelper.isRunIOS()then
UIManager:showWindow("UIYueNanIosReChargeWin")
return
end


if verifyManager:isHideRecharge()then
return false
end
if not systemModel.isOpen(SYSTEM_DEFINE.eRechage)then
return false
end
local args=
{
tabType=FULL_TAB_TYPE.eRecharge,
showBg=true,
showTopMask=true,

viewNames={'UIReChargeWin','UIZhenBaoGeFrontWin'},
viewArgs={['UIReChargeWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullRechargeController:showXianGouLiBaoWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
if not systemModel.isOpen(SYSTEM_DEFINE.eGiftRechage)then
return false
end
local args=
{
tabType=FULL_TAB_TYPE.eReChargeLiBao,
showBg=true,
showTopMask=true,

viewNames={'UIXianGouLiBaoWin','UIZhenBaoGeFrontWin'},
viewArgs={['UIXianGouLiBaoWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullRechargeController:showXianGouWeekLiBaoWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
if not systemModel.isOpen(SYSTEM_DEFINE.eGiftRechage)then
return false
end
argstable=argstable or{}
argstable.libaoType=shopLibaoType.eWeek
local args=
{
tabType=FULL_TAB_TYPE.eReChargeWeekLiBao,
showBg=true,
showTopMask=true,

viewNames={'UIXianGouLiBaoWin','UIZhenBaoGeFrontWin'},
viewArgs={['UIXianGouLiBaoWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullRechargeController:showXianGouMonthLiBaoWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
argstable=argstable or{}
argstable.libaoType=shopLibaoType.eMonth
local args=
{
tabType=FULL_TAB_TYPE.eReChargeMonthLiBao,
showBg=true,
showTopMask=true,

viewNames={'UIXianGouLiBaoWin','UIZhenBaoGeFrontWin'},
viewArgs={['UIXianGouLiBaoWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullRechargeController:showXianGouGuangGaoLiBaoWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
if not systemModel.isOpen(SYSTEM_DEFINE.eGuanYingGe)then
return false
end
argstable=argstable or{}
argstable.libaoType=shopLibaoType.eGuangGao
local args=
{
tabType=FULL_TAB_TYPE.eReChargeGuanYingGe,
showBg=true,
showTopMask=true,

viewNames={'UIXianGouLiBaoWin','UIZhenBaoGeFrontWin'},
viewArgs={['UIXianGouLiBaoWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullRechargeController:showMonthInvestorWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
if not systemModel.isOpen(SYSTEM_DEFINE.eYueKa)then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.eMonthInvestor,
showBg=true,
showTopMask=true,

viewNames={'UIInvestorListWin','UIZhenBaoGeFrontWin'},
viewArgs={['UIInvestorListWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullRechargeController:showDailyTeHuiWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.eRechargeDailyTeHui,
showBg=true,
showTopMask=true,
viewNames={'UIDailyTeHuiWin','UIZhenBaoGeFrontWin'},
viewArgs={['UIDailyTeHuiWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullRechargeController:showDailyTeHuiSingleDayWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.eRechargeDailyTeHuiSingleDay,
showBg=true,
showTopMask=true,
viewNames={'UIDailyTeHui_singleDayWin','UIZhenBaoGeFrontWin'},
viewArgs={['UIDailyTeHui_singleDayWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullRechargeController:showLingCuiShopWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.eLingCuiShop,
showBg=true,
showTopMask=true,
viewNames={'UILingCuiShopWin','UIZhenBaoGeFrontWin'},
viewArgs={['UILingCuiShopWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullRechargeController:showPushGiftWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.ePushGift,
showBg=true,
showTopMask=true,
viewNames={'UIPushGiftBuyWin','UIZhenBaoGeFrontWin'},
viewArgs={['UIPushGiftBuyWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullRechargeController:showPushGiftThreeWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.ePushGiftThree,
showBg=true,
showTopMask=true,
viewNames={'UIPushGiftBuyThreeWin','UIZhenBaoGeFrontWin'},
viewArgs={['UIPushGiftBuyThreeWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullRechargeController:showMonthInvestorCatAccountBookWin(argstable)
if not systemModel.isOpen(SYSTEM_DEFINE.eYueKa)then
return false
end
argstable=argstable or{}

self:showWindow("UIMonthInvestorCatAccountBookWin",argstable)
return true
end

function UIFullRechargeController:showSelectLiBaoWin(argstable)

if verifyManager:isHideBusinessActivity()then
return false
end

if verifyManager:isHideRecharge()then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.eSelfSelectGif,
showBg=true,
showTopMask=true,
viewNames={'UISelectLiBaoWin','UIZhenBaoGeFrontWin'},
viewArgs={['UISelectLiBaoWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullRechargeController:checkPushGiftOpen()
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift2)then
return false
end
local list=pushGiftTwoModel:getGiftIds()
if list==nil or#list==0 then return false end
return true
end

function UIFullRechargeController:checkPushGiftThreeOpen()
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift3)then
return false
end
local list=pushGiftThreeModel:getGiftIds()
if list==nil or#list==0 then return false end
return true
end