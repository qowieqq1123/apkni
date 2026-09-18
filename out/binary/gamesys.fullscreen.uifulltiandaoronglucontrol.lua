




UIFullTianDaoRongLuControl=gameState.addListener(fullScreenUI.create())

function UIFullTianDaoRongLuControl:onAppStart()
local function _showTianDaoRongDingWindow(...)self:showTianDaoRongDingWindow(...)end

local menulist=
{

}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eTianDaoRongDing,
attachName={'entityId'}
}
self:initUI(args)
end

function UIFullTianDaoRongLuControl:showMyWindowByBuild(args)
local tabType=FULL_TAB_TYPE.eTianDaoRongDing
if args.args~=nil and args.args.tabType~=nil then
tabType=args.args.tabType
end
local argstable=args.data
if tabType==FULL_TAB_TYPE.eTianDaoRongDing then
return self:showTianDaoRongDingWindow(argstable)
else
loggerUtil.logErrFMT('尚未实现页签：{0}',tabType)
return false
end
end

function UIFullTianDaoRongLuControl:showTianDaoRongDingWindow(argstable)
local sysid=SYSTEM_DEFINE.eTianDaoRongLu
if not systemModel.isOpen(sysid)then
UIManager.error(systemModel.getOpenTips(sysid))
return false
end
local tabType=FULL_TAB_TYPE.eTianDaoRongDing
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UITianDaoRongDingWin'},
viewArgs={['UITianDaoRongDingWin']=argstable},
}
return self:showUI(args)
end