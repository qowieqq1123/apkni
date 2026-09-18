







UIFullMysteryMainControl=gameState.addListener(fullScreenUI.create())

function UIFullMysteryMainControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eMysteryMain,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

local mainWindow=
{
viewNames={'UIMysteryWin','UIMysteryTargetWin','UIMysteryMiniWin'},
}

function UIFullMysteryMainControl:showMysteryMainWindow(argstable)
local viewArgs={['UIMysteryWin']=argstable}
for i,view in ipairs(mainWindow.viewNames)do
UIManager:showWindow(view,viewArgs[view])
end

if mysteryPlayerModel:getGrassWindowState()then
mysteryPlayerController:showGrassWindow(true,true)
end
end

function UIFullMysteryMainControl:hideMysteryMainWindow()
for i,view in ipairs(mainWindow.viewNames)do
UIManager:hideWindow(view)
end
end

function UIFullMysteryMainControl:closeMysteryMainWindow()
for i,view in ipairs(mainWindow.viewNames)do
UIManager:closeWindow(view)
end
end

function UIFullMysteryMainControl:showMysteryChangeTeamWin(winArgs,afterLoading)
winArgs.isFullOpen=true
local mapId=nil
if winArgs.fbId then
mapId=cfgHelper.get2(cfg_secretscenefubenconfig_get,winArgs.fbId,"fightMap")
end

local startCallback=function()
winArgs.selectStage=fightController:showSelectStage(nil,mapId,nil,function()
local args=
{
showBg=false,

viewNames={'UIMysteryChangeTeamWin'},
viewArgs={['UIMysteryChangeTeamWin']=winArgs},
}
self:showUI(args)

if afterLoading then
afterLoading()
end

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end)
end

UIFullFightPrepareControl:showWindow("UIFightPrepareLoading",{
startCallback=startCallback
})
end



UIFullMysteryShopControl=gameState.addListener(fullScreenUI.create())

function UIFullMysteryShopControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eMysteryShop,
skinType=fullScreenSkinType.eSkin1,
}
self:initUI(args)
end
function UIFullMysteryShopControl:showMysteryShopWindow(argstable)

argstable=argstable or{}
argstable.fairType=eFairType.eMysteryMarket


local tips=mysteryShopModel.get_tips_config()
if tips then
argstable.talkTips=tips
end

local args=
{
moneyArgs={{3},{2},{1}},
viewNames={'UIGuiShiWin'},
viewArgs={['UIGuiShiWin']=argstable},
}
self:showUI(args)
end
