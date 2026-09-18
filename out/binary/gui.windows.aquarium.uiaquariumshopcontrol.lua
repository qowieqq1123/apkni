

UIAquariumShopControl=gameState.addListener(fullScreenUI.create())

function UIAquariumShopControl:onAppStart()

local menulist=
{
{tabType=FULL_TAB_TYPE.eDiaoYuShop,callback=function(...)self:showYuZhiGeShopWin(...)end,sendCallback=function()end},
{tabType=FULL_TAB_TYPE.eYuJuShengJiShop,callback=function(...)self:showYuJuShengJiShopWin(...)end,sendCallback=function()end,reddotType=REDDIT_SUB_TYPE.eYiYuHuiYouShopShengji},
{tabType=FULL_TAB_TYPE.eLongChiShop,callback=function(...)self:showLongChiShopWin(...)end,sendCallback=function()end},
}
local args=
{
menulist=menulist,
fullType=FULL_TYPE.eYueLongChiShop,
skinType=fullScreenSkinType.eSkin20,
}
self:initUI(args)
end

function UIAquariumShopControl:onEnterState(isReconnect)
if isReconnect then
return
end
end

function UIAquariumShopControl:onLeaveState(isReconnect)
if isReconnect then
return
end
end

function UIAquariumShopControl:onReConnection(isReconnect)
if not isReconnect then
return
end
end

function UIAquariumShopControl:showLongChiShopWin(argstable)
local tabType=FULL_TAB_TYPE.eLongChiShop

local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIAquariumShopWin'},
viewArgs={['UIAquariumShopWin']=argstable},
}
self:showUI(args)
end


function UIAquariumShopControl:showYuZhiGeShopWin(argstable)
local tabType=FULL_TAB_TYPE.eDiaoYuShop

local args=
{
tabType=tabType,
showBg=true,
viewNames={'YYHYMainShopWin'},
viewArgs={['YYHYMainShopWin']=argstable},
}
self:showUI(args)
end


function UIAquariumShopControl:showYuJuShengJiShopWin(argstable)
local tabType=FULL_TAB_TYPE.eYuJuShengJiShop

local args=
{
tabType=tabType,
showBg=true,
viewNames={'YYHYyuzhigeShopWin'},
viewArgs={['YYHYyuzhigeShopWin']=argstable},
}
self:showUI(args)
end


