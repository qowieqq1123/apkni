







UIFullXianBangControl=gameState.addListener(fullScreenUI.create())

function UIFullXianBangControl:onAppStart()
local menulist=
{
{tabType=FULL_TAB_TYPE.eXianBang,callback=function(...)self:showXianBangWindow(...)end,
sendCallback=function()end},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eXianBang,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end


function UIFullXianBangControl:showXianBangWindow(argstable)
local isOpenSys=true
if isOpenSys then
local args=
{
tabType=FULL_TAB_TYPE.eXianBang,
showBg=true,
viewNames={'UIXianBangWin'},
viewArgs={['UIXianBangWin']=argstable},
}
self:showUI(args)
else
UIManager.info("仙榜暂未开启")
end
end
