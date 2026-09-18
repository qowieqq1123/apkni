




UIFullBingGongChangControl=gameState.addListener(fullScreenUI.create())

function UIFullBingGongChangControl:onAppStart()
local function _showDanYaoWindow(...)self:showBGFWindow(...)end
local function _showDianHuaWindow(...)self:showDianHuaWindow(...)end

local menulist=
{
{tabType=FULL_TAB_TYPE.eBingGongFang,callback=_showDanYaoWindow,},
{tabType=FULL_TAB_TYPE.eEquipDianHua,callback=_showDianHuaWindow,},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eBingGongFang,
attachName={'entityId'},
}
self:initUI(args)
end


function UIFullBingGongChangControl:showBGFWindow(argstable)
local tabType=FULL_TAB_TYPE.eBingGongFang
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIBingGongChangWin'},
viewArgs={['UIBingGongChangWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullBingGongChangControl:showDianHuaWindow(argstable)
local tabType=FULL_TAB_TYPE.eEquipDianHua
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIEquipDianHuaWin'},
viewArgs={['UIEquipDianHuaWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullBingGongChangControl:showMyWindowByBuild(args)
local tabType=FULL_TAB_TYPE.eBingGongFang
if args.args~=nil and args.args.tabType~=nil then
tabType=args.args.tabType
end
UIFullBingGongChangControl:myShowWindow(args.data,tabType)
end

function UIFullBingGongChangControl:myShowWindow(argstable,tabType)
tabType=tabType or FULL_TAB_TYPE.eBingGongFang
if tabType==FULL_TAB_TYPE.eBingGongFang then
self:showBGFWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eEquipDianHua then
self:showDianHuaWindow(argstable)
end
end
