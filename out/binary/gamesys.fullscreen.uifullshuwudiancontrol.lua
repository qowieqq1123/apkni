







UIFullShuWuDianControl=gameState.addListener(fullScreenUI.create())

function UIFullShuWuDianControl:onAppStart()
local function _showWindowKickout(...)self:showWindowKickout(...)end
local function _showWindowFangSheng(...)self:showWindowFangSheng(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eShuWuDianKickout,callback=_showWindowKickout,sendCallback=_initSendPro1},
{tabType=FULL_TAB_TYPE.eLingShouFangSheng,callback=_showWindowFangSheng,sendCallback=_initSendPro2},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eShuWuDian,
skinType=fullScreenSkinType.eSkin12,
attachName={'entityID'},
}
self:initUI(args)
end

function UIFullShuWuDianControl:showMyWindow(tabType,args,nextFunc)
if tabType==FULL_TAB_TYPE.eShuWuDianKickout then
UIFullShuWuDianControl:showWindowKickout(args)
end
if tabType==FULL_TAB_TYPE.eLingShouFangSheng then
UIFullShuWuDianControl:showWindowFangSheng(args)
end
if nextFunc then
local func=function()
nextFunc()
end
fullScreenUI.setNextActiveUICallback(func)
end
end

function UIFullShuWuDianControl:showMyWindowEx(tabType,args,nextFunc,isWarming)
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eShuWuDian,nil,nil,isWarming)then
return false
end
local data=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eShuWuDian)
args.entityID=data[1].entityId
UIFullShuWuDianControl:showMyWindow(tabType,args,nextFunc)
return true
end

function UIFullShuWuDianControl:showMyWindowByBuild(args,nextFunc)
local tabType=FULL_TAB_TYPE.eShuWuDianKickout
if args.args~=nil and args.args.tabType~=nil then
tabType=args.args.tabType
end
local params=args.args or{}
params.entityID=args.data.entityId
UIFullShuWuDianControl:showMyWindow(tabType,params,nextFunc)
end

function UIFullShuWuDianControl:showWindowKickout(argstable)
local tabType=FULL_TAB_TYPE.eShuWuDianKickout
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIShuWuKickoutWin'},
viewArgs={['UIShuWuKickoutWin']=argstable},
}
self:showUI(args)
end

function UIFullShuWuDianControl:showWindowFangSheng(argstable)
local tabType=FULL_TAB_TYPE.eLingShouFangSheng
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILingShouFangShengWin'},
viewArgs={['UILingShouFangShengWin']=argstable},
}
self:showUI(args)
end

function UIFullShuWuDianControl:initSendPro1()

end

function UIFullShuWuDianControl:initSendPro2()

end