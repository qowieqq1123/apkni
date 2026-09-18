




UIFullLianQiGeControl=gameState.addListener(fullScreenUI.create())

function UIFullLianQiGeControl:onAppStart()
local function _showProductionWindow(...)self:showProductionWindow(...)end
local function _showFabaoWindow(...)self:showFabaoWindow(...)end
local function _showBenMingFabaoWindow(...)self:showBenMingFabaoWindow(...)end
local function _showBenMingAgainRefineWindow(...)self:showBenMingAgainRefineWindow(...)end

local function _checkBMFBRemakOpen(...)return systemModel.isOpen(SYSTEM_DEFINE.eBenMingFabaoRemake)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eProduction_lianqige,callback=_showProductionWindow},

{tabType=FULL_TAB_TYPE.eFabao,callback=_showFabaoWindow},

{tabType=FULL_TAB_TYPE.eCreateBenMingFabao,callback=_showBenMingFabaoWindow},

{tabType=FULL_TAB_TYPE.eBenMingAgainRefine,callback=_showBenMingAgainRefineWindow,checkOpen=_checkBMFBRemakOpen},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eLianqi,
attachName={'entityId'}
}
self:initUI(args)
end

function UIFullLianQiGeControl:myShowWindow(argstable,tabType)
tabType=tabType or FULL_TAB_TYPE.eProduction_lianqige
if tabType==FULL_TAB_TYPE.eProduction_lianqige then
self:showProductionWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eFabao then
self:showFabaoWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eCreateBenMingFabao then
self:showBenMingFabaoWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eBenMingAgainRefine then
self:showBenMingAgainRefineWindow(argstable)
end
end

function UIFullLianQiGeControl:showMyWindowByBuild(args)
local tabType=FULL_TAB_TYPE.eProduction_lianqige
if args.args~=nil and args.args.tabType~=nil then
tabType=args.args.tabType
end
UIFullLianQiGeControl:myShowWindow(args.data,tabType)
end

function UIFullLianQiGeControl:showProductionWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_lianqige
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIManufactureWin'},
viewArgs={['UIManufactureWin']=argstable},
}
return self:showUIRellay(args)
end


function UIFullLianQiGeControl:showFabaoWindow(argstable)
local tabType=FULL_TAB_TYPE.eFabao
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIFabaoWin'},
viewArgs={['UIFabaoWin']=argstable},
}
self:showUIRellay(args)
return true
end

function UIFullLianQiGeControl:showBenMingFabaoWindow(argstable)
local tabType=FULL_TAB_TYPE.eCreateBenMingFabao
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIBenMingFabaoWin'},
viewArgs={['UIBenMingFabaoWin']=argstable},
}
self:showUIRellay(args)
return true
end

function UIFullLianQiGeControl:showBenMingAgainRefineWindow(argstable)
local tabType=FULL_TAB_TYPE.eBenMingAgainRefine
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIBenMingAgainRefineWin'},
viewArgs={['UIBenMingAgainRefineWin']=argstable},
}
self:showUIRellay(args)
return true
end

function UIFullLianQiGeControl:showUIRellay(args)
local attach=self:tryGetAttachArgs(args)
local entityId=attach.entityId
self:addFabaoReddot(entityId)
return self:showUI(args)
end

function UIFullLianQiGeControl:addFabaoReddot(entityId)
local sfId=zongmenModel:getMountainId()
local bdData=zongmenModel:findBuildingByEntityId(entityId)
local ubdId=bdData.un_build_id
local key=fabaoCreateSheetReddot.addConfig(ubdId)
self:reviseSubMenuValue(FULL_TAB_TYPE.eFabao,'reddotType',key)
end