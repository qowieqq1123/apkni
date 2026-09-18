




UIFullYaoPuControl=gameState.addListener(fullScreenUI.create())

function UIFullYaoPuControl:onAppStart()
local function _showProductionWindow(...)self:showProductionWindow(...)end

local function _initSendProductionPro(...)self:initSendProductionPro(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eProduction_yaoyuan,callback=_showProductionWindow,sendCallback=_initSendProductionPro},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eYaoPu,
}
self:initUI(args)
end


function UIFullYaoPuControl:showProductionWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_yaoyuan
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIManufactureWin'},
viewArgs={['UIManufactureWin']=argstable},
}
self:showUI(args)
end

function UIFullYaoPuControl:initSendProductionPro()

end

function UIFullYaoPuControl:initSendFabaoPro()

end
