








UIFullShangHangController=gameState.addListener(fullScreenUI.create())




















function UIFullShangHangController:onAppStart()
local function _showShangHangTouZiWindow(...)
self:showShangHangTouZiWindow(...)
end
local function _showhangHangPaiHangWindow(...)
self:showhangHangPaiHangWindow(...)
end
local function _showShangHangMuBiaoWindow(...)
self:showShangHangMuBiaoWindow(...)
end

local menulist=
{

{tabType=FULL_TAB_TYPE.eShangHangTouZi,callback=_showShangHangTouZiWindow,},

{tabType=FULL_TAB_TYPE.eShangHangPaiHang,callback=_showhangHangPaiHangWindow,},

{tabType=FULL_TAB_TYPE.eShangHangMuBiao,callback=_showShangHangMuBiaoWindow,},
}

local args=
{
skinType=fullScreenSkinType.eSkin5,
menulist=menulist,
fullType=FULL_TYPE.eShangHang,
}
self:initUI(args)
end

function UIFullShangHangController:showShangHangTouZiWindow(argstable)
if not argstable then argstable={}end

local args=
{
tabType=FULL_TAB_TYPE.eShangHangTouZi,
showBg=true,
viewNames={'UIShangHangLeftWin','UIShangHangMainWin'},
viewArgs={['UIShangHangMainWin']=argstable,},
}
self.activeMenuIndex=1
self:showUI(args)
shangHangController:loadLeaveData()


return true
end

function UIFullShangHangController:showhangHangPaiHangWindow(argstable)
if not argstable then argstable={}end

local args=
{
tabType=FULL_TAB_TYPE.eShangHangPaiHang,
showBg=true,
viewNames={'UIShangHangLeftWin','UIShangHangRankWin'},
viewArgs={['UIShangHangRankWin']=argstable},
}
self.activeMenuIndex=2
self:showUI(args)

return true
end

function UIFullShangHangController:showShangHangMuBiaoWindow(argstable)
if not argstable then argstable={}end

local args=
{
tabType=FULL_TAB_TYPE.eShangHangMuBiao,
showBg=true,
viewNames={'UIShangHangLeftWin','UIShangHangMuBiaoWin'},
viewArgs={['UIShangHangMuBiaoWin']=argstable},
}
self.activeMenuIndex=3
self:showUI(args)
return true
end
