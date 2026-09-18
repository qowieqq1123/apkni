




UIFullKuangMaiControl=gameState.addListener(fullScreenUI.create())

function UIFullKuangMaiControl:onAppStart()
local function _showProductionWindow(...)self:showProductionWindow(...)end

local function _initSendProductionPro(...)self:initSendProductionPro(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eProduction_kuangkeng,callback=_showProductionWindow,sendCallback=_initSendProductionPro},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eKuangmai,
attachName={'entityId'}
}
self:initUI(args)
end


function UIFullKuangMaiControl:showProductionWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_kuangkeng
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIManufactureWin'},
viewArgs={['UIManufactureWin']=argstable},
}
self:showUI(args)
end

function UIFullKuangMaiControl:initSendProductionPro()

end

function UIFullKuangMaiControl:initSendFabaoPro()

end
