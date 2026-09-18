








UIFullAuctionController=gameState.addListener(fullScreenUI.create())

function UIFullAuctionController:onAppStart()
local function _showXianMengAuctionWindow(...)
self:showXianMengAuctionWindow(...)
end
local function _showCrossAuctionWin(...)
self:showCrossAuctionWin(...)
end
local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eXianMengAuction,callback=_showXianMengAuctionWindow,sendCallback=_initSendPro1},

{tabType=FULL_TAB_TYPE.eCrossAuction,callback=_showCrossAuctionWin,sendCallback=_initSendPro2},

}

local args=
{
skinType=fullScreenSkinType.eSkin11,
menulist=menulist,
fullType=FULL_TYPE.eAuction,
}
self:initUI(args)
end


function UIFullAuctionController:showXianMengAuctionWindow(argstable)
if not systemModel.isOpen(SYSTEM_DEFINE.eAuction)then
return false
end
if not argstable then
argstable={}
end

argstable.serverType=AUCTION_SERVER_TYPE.eLocal
local args=
{
tabType=FULL_TAB_TYPE.eXianMengAuction,
showBg=true,
showTopMask=true,
viewNames={'UIAuctionWin'},
viewArgs={['UIAuctionWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullAuctionController:showCrossAuctionWin(argstable)
if not systemModel.isOpen(SYSTEM_DEFINE.eAuction)then
return false
end
if not argstable then
argstable={}
end
argstable.serverType=AUCTION_SERVER_TYPE.eCross
local args=
{
tabType=FULL_TAB_TYPE.eCrossAuction,
showBg=true,
showTopMask=true,
viewNames={'UIAuctionWin'},
viewArgs={['UIAuctionWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullAuctionController:initSendPro1()

end

function UIFullAuctionController:initSendPro2()

end

function UIFullAuctionController:showMainUI(args)
if not auctionController:checkXianMenAuctionEnd()then

self:showXianMengAuctionWindow(args)
else

self:showCrossAuctionWin(args)
end
end