







UIFullDaoLvControl=gameState.addListener(fullScreenUI.create())

function UIFullDaoLvControl:onAppStart()
local function _showProductionWindow(...)self:showDzRoomWindow(...)end
local function _showFabaoWindow(...)self:showProductionWindow(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eDaoLvDongFu,callback=_showProductionWindow},

{tabType=FULL_TAB_TYPE.eDaoLvXiuLian,callback=_showFabaoWindow},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eDaoLvDongFu,
attachName={'entityId'}
}
self:initUI(args)
end

function UIFullDaoLvControl:showDzRoomWindow(argstable)
local tabType=FULL_TAB_TYPE.eDaoLvDongFu
argstable.showPage=self:getTabIdx(tabType)
local args={
tabType=tabType,
showBg=true,
viewNames={'UIDLRoomWin'},
viewArgs={['UIDLRoomWin']=argstable},
}

self:showUI(args)
end

function UIFullDaoLvControl:showProductionWindow(argstable)
local tabType=FULL_TAB_TYPE.eDaoLvXiuLian
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDLCultivationWin'},
viewArgs={['UIDLCultivationWin']=argstable},
}

self:showUI(args)
end