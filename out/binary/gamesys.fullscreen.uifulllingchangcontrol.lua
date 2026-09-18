




UIFullLingChangControl=gameState.addListener(fullScreenUI.create())

function UIFullLingChangControl:onAppStart()
local function _showProductionWindow(...)self:showProductionWindow(...)end

local function _initSendProductionPro(...)self:initSendProductionPro(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eProduction_lindi,callback=_showProductionWindow,sendCallback=_initSendProductionPro},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eLinChang,
}
self:initUI(args)
end


function UIFullLingChangControl:showProductionWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_lindi
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIManufactureWin'},
viewArgs={['UIManufactureWin']=argstable},
}
self:showUI(args)
end

function UIFullLingChangControl:initSendProductionPro()

end

function UIFullLingChangControl:initSendFabaoPro()

end
