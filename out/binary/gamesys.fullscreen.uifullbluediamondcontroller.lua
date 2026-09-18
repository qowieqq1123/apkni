








UIFullBlueDiamondController=gameState.addListener(fullScreenUI.create())

function UIFullBlueDiamondController:onAppStart()
local function _showDailyGiftWim(argstable)
self:showDailyGiftWin(argstable)
end

local function _showGrowUpGiftWin(argstable)
self:showGrowUpGiftWin(argstable)
end

local function _showNewBieGiftWin(argstable)
self:showNewBieGiftWin(argstable)
end

local function _showTeQuanInfoWin(argstable)
self:showTeQuanInfoWin(argstable)
end

local menulist=
{

{tabType=FULL_TAB_TYPE.eBlueDiamond_DailyGift,callback=_showDailyGiftWim,reddotType=REDDIT_SUB_TYPE.sBlueDiamondDailyGift},

{tabType=FULL_TAB_TYPE.eBlueDiamond_NewBieGift,callback=_showNewBieGiftWin,reddotType=REDDIT_SUB_TYPE.sBlueDiamondNewBieGift},

{tabType=FULL_TAB_TYPE.eBlueDiamond_GrowUpGift,callback=_showGrowUpGiftWin,reddotType=REDDIT_SUB_TYPE.sBlueDiamondGrowUpGift},

{tabType=FULL_TAB_TYPE.eBlueDiamond_TeQuanInfo,callback=_showTeQuanInfoWin},
}
local args=
{
skinType=fullScreenSkinType.eSkin28,
menulist=menulist,
fullType=FULL_TYPE.eBlueDiamond,
defaultTabType=FULL_TAB_TYPE.eBlueDiamond_DailyGift,
}
self:initUI(args)
end

function UIFullBlueDiamondController:showMyWindow(args)
local page=args and args.tabType
if not page then
page=FULL_TAB_TYPE.eBlueDiamond_DailyGift
end
if page==FULL_TAB_TYPE.eBlueDiamond_DailyGift then
return UIFullBlueDiamondController:showDailyGiftWin(args)
elseif page==FULL_TAB_TYPE.eBlueDiamond_GrowUpGift then
return UIFullBlueDiamondController:showGrowUpGiftWin(args)
elseif page==FULL_TAB_TYPE.eBlueDiamond_NewBieGift then
return UIFullBlueDiamondController:showNewBieGiftWin(args)
elseif page==FULL_TAB_TYPE.eBlueDiamond_TeQuanInfo then
return UIFullBlueDiamondController:showTeQuanInfoWin(args)
end
return false
end


function UIFullBlueDiamondController:showDailyGiftWin(argstable)
if not blueDiamondModel:checkOpen()then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.eBlueDiamond_DailyGift,
showBg=true,
showTopMask=true,
viewNames={'UIBlueDiamondDailyGiftWin'},
viewArgs={['UIBlueDiamondDailyGiftWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullBlueDiamondController:showGrowUpGiftWin(argstable)
if not blueDiamondModel:checkOpen()then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.eBlueDiamond_GrowUpGift,
showBg=true,
showTopMask=true,
viewNames={'UIBlueDiamondGrowUpGiftWin'},
viewArgs={['UIBlueDiamondGrowUpGiftWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullBlueDiamondController:showNewBieGiftWin(argstable)
if not blueDiamondModel:checkOpen()then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.eBlueDiamond_NewBieGift,
showBg=true,
showTopMask=true,
viewNames={'UIBlueDiamondNewBieGiftWin'},
viewArgs={['UIBlueDiamondNewBieGiftWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullBlueDiamondController:showTeQuanInfoWin(argstable)
if not blueDiamondModel:checkOpen()then
return false
end
argstable=argstable or{}
local args=
{
tabType=FULL_TAB_TYPE.eBlueDiamond_TeQuanInfo,
showBg=true,
showTopMask=true,
viewNames={'UIBlueDiamondTeQuanInfoWin'},
viewArgs={['UIBlueDiamondTeQuanInfotWin']=argstable},
}
self:showUI(args)
return true
end

