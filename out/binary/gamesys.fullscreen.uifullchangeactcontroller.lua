








UIFullChangeActController=gameState.addListener(fullScreenUI.create())

function UIFullChangeActController:onAppStart()
local function _showXianMengAuctionWindow(...)
self:showUIChangActWin(...)
end
local function _initSendPro1(...)self:initSendPro1(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eChangeAct,callback=_showXianMengAuctionWindow,sendCallback=_initSendPro1},



}

local args=
{
skinType=fullScreenSkinType.eSkin11,
menulist=menulist,
fullType=FULL_TYPE.eChangeAct,
}
self:initUI(args)
end


function UIFullChangeActController:showUIChangActWin(argstable)
if not argstable then
argstable={}
end

local args=
{
tabType=FULL_TAB_TYPE.eChangeAct,
showBg=true,
showTopMask=true,
viewNames={'UIChangActWin'},
viewArgs={['UIChangActWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullChangeActController:initSendPro1()

end

function UIFullChangeActController:initSendPro2()

end
