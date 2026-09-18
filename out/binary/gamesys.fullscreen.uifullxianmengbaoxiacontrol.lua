







UIFullXianMengBaoXiaControl=gameState.addListener(fullScreenUI.create())

function UIFullXianMengBaoXiaControl:onAppStart()
local menulist=
{
{tabType=FULL_TAB_TYPE.eXianMengBaoXia,callback=function(...)self:showXianBangWindow(...)end,
sendCallback=function()end},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eXianMengBaoXia,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end


function UIFullXianMengBaoXiaControl:showBaoXiaWindow(argstable)
local isOpenSys=XianMengBaoXiaController:checkIsOpenBaoXiao()
if isOpenSys then
local args=
{
tabType=FULL_TAB_TYPE.eXianMengBaoXia,
showBg=true,
viewNames={'UIXianZhangBaoXia'},
viewArgs={['UIXianZhangBaoXia']=argstable},
}
self:showUI(args)
else
UIManager.info("仙藏宝匣暂未开启")
end
end
