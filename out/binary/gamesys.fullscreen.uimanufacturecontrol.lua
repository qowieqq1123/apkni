
UIManufactureControl=gameState.addListener(fullScreenUI.create())

function UIManufactureControl:onAppStart()

end

function UIManufactureControl:init(tabType)
local menulist=
{

{tabType=tabType,callback=function(...)self:showProductionWindow(...)end},
}
local args=
{
menulist=menulist,
fullType=FULL_TYPE.eProduction,
attachName={'entityId'}
}
self:initUI(args)
end


function UIManufactureControl:showProductionWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction
local id=argstable.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
if cfg.page_type then
tabType=FULL_TAB_TYPE[cfg.page_type]
end
self:init(tabType)
local viewName='UIManufactureWin'
local args=
{
tabType=tabType,
showBg=true,
subFullType=fullScreenUI.getSubFullType(viewName,id),
viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end