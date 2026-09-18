
UINaturalControl=gameState.addListener(fullScreenUI.create())

function UINaturalControl:onAppStart()

end

function UINaturalControl:init(tabType)
local menulist=
{

{tabType=tabType,callback=function(...)self:showNaturalWindow(...)end},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eNatural,
attachName={'entityId'}
}
self:initUI(args)
end


function UINaturalControl:showNaturalWindow(argstable)
local tabType=FULL_TAB_TYPE.eNatural
local id=argstable.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
if cfg.page_type then
tabType=FULL_TAB_TYPE[cfg.page_type]
end
local viewName='UINaturalWin'
self:init(tabType)
local args=
{
tabType=tabType,
showBg=true,
subFullType=FMT.fmt('{0}_{1}',viewName,tabType),
viewNames={'UINaturalWin'},
viewArgs={['UINaturalWin']=argstable},
}
self:showUI(args)
end