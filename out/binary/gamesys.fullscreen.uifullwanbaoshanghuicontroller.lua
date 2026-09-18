








UIFullWanBaoShangHuiController=gameState.addListener(fullScreenUI.create())

function UIFullWanBaoShangHuiController:onAppStart()
local function _showWanBaoShangHuiAuctionWindow(...)
self:showWanBaoShangHuiAuctionWindow(...)
end
local function _showWanBaoShangHuiSellWindow(...)
self:showWanBaoShangHuiSellWindow(...)
end
local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eWBSH_Auction,callback=_showWanBaoShangHuiAuctionWindow,sendCallback=_initSendPro1},

{tabType=FULL_TAB_TYPE.eWBSH_Sell,callback=_showWanBaoShangHuiSellWindow,sendCallback=_initSendPro2},
}

local args=
{
skinType=fullScreenSkinType.eSkin11,
menulist=menulist,
fullType=FULL_TYPE.eWanBaoShangHui,
}
self:initUI(args)
end


function UIFullWanBaoShangHuiController:showWanBaoShangHuiAuctionWindow(argstable)
if not argstable then
argstable={}
end


local isCross=auctionModel:checkPersonAuctionIsCrossModel()
argstable.serverType=isCross and AUCTION_SERVER_TYPE.eCross or AUCTION_SERVER_TYPE.eLocal
local args=
{
tabType=FULL_TAB_TYPE.eWBSH_Auction,
showBg=true,
showTopMask=true,
viewNames={'UIWanBaoShangHui_auctionWin'},
viewArgs={['UIWanBaoShangHui_auctionWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullWanBaoShangHuiController:showWanBaoShangHuiSellWindow(argstable)
if not argstable then
argstable={}
end

argstable.serverType=AUCTION_SERVER_TYPE.eLocal
local args=
{
tabType=FULL_TAB_TYPE.eWBSH_Sell,
showBg=true,
showTopMask=true,
viewNames={'UIWanBaoShangHui_sellWin'},
viewArgs={['UIWanBaoShangHui_sellWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullWanBaoShangHuiController:initSendPro1()

end

function UIFullWanBaoShangHuiController:initSendPro2()

end

function UIFullWanBaoShangHuiController:showMainUI(args)
if verifyManager:isHideWanBaoShangHui()then
return
end

self:showWanBaoShangHuiAuctionWindow(args)
end


function UIFullWanBaoShangHuiController.testEnterWBSH()
UIFullWanBaoShangHuiController:showMainUI()
end


function UIFullWanBaoShangHuiController.testEnterWBSH_Filter()
UIFullWanBaoShangHuiController:showWindow("UIWanBaoShangHui_filterWin")
end


function UIFullWanBaoShangHuiController.test_openWBSHQuestion()
local args={type=SLG_SYSTEM_TYPE.eWanBaoShangHui}
local data,mountid,buildid=zongmenControl:getBuilding(args,true)
if data then
UIManager:showWindow('UIWanBaoShangHui_questionWin',data)
end
end