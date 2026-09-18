







UIFullXianMengPalaceControl=gameState.addListener(fullScreenUI.create())

function UIFullXianMengPalaceControl:onAppStart()
local function _showWindowPalaceInfo(...)self:showWindowPalaceInfo(...)end
local function _showWindowXMListInfo(...)self:showWindowXMListInfo(...)end
local function _showWindowXMPostInfo(...)self:showWindowXMPostInfo(...)end
local function _showWindowMouLueInfo(...)self:showWindowXMMouLueInfo(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local function _initSendPro3(...)self:initSendPro3(...)end
local function _initSendPro4(...)self:initSendPro4(...)end

local function _checkClick(attach)return self:check_ClickMouLue(attach,false)end

local function _checkLinggenGray(attach)return self:check_GrayMouLue(attach,false)end
local menulist=
{

{tabType=FULL_TAB_TYPE.eXianMengPalaceInfo,callback=_showWindowPalaceInfo,reddotType=REDDIT_TYPE.eXianMengPalace,sendCallback=_initSendPro1},

{tabType=FULL_TAB_TYPE.eXianMengListInfo,callback=_showWindowXMListInfo,sendCallback=_initSendPro2},

{tabType=FULL_TAB_TYPE.eXianMengPostInfo,callback=_showWindowXMPostInfo,sendCallback=_initSendPro3},

{tabType=FULL_TAB_TYPE.eXianMengMouLueSetInfo,callback=_showWindowMouLueInfo,sendCallback=_initSendPro4,clickCond=_checkClick,checkGray=_checkLinggenGray,},






}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eXianMengPalace,
skinType=fullScreenSkinType.eSkin3,
attachName={},
}
self:initUI(args)
end



function UIFullXianMengPalaceControl:showMyWindow(tabType,args,nextFunc)
if tabType==FULL_TAB_TYPE.eXianMengPalaceInfo then
UIFullXianMengPalaceControl:showWindowPalaceInfo(args)
elseif tabType==FULL_TAB_TYPE.eXianMengListInfo then
UIFullXianMengPalaceControl:showWindowXMListInfo(args)
elseif tabType==FULL_TAB_TYPE.eXianMengPostInfo then

end
if nextFunc then
local func=function()
nextFunc()
end
fullScreenUI.setNextActiveUICallback(func)
end
end

function UIFullXianMengPalaceControl:showMyWindowEx(tabType,nextFunc)
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianMengDaDian)then
return false
end
UIFullXianMengPalaceControl:showMyWindow(tabType,{},nextFunc)
return true
end

function UIFullXianMengPalaceControl:showMyWindowByBuild(args,nextFunc)
local tabType=FULL_TAB_TYPE.eXianMengPalaceInfo
if args.args~=nil and args.args.tabType~=nil then
tabType=args.args.tabType
end
UIFullXianMengPalaceControl:showMyWindow(tabType,{},nextFunc)
end

function UIFullXianMengPalaceControl:showWindowPalaceInfo(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eXianMengPalaceInfo
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIXianMengPalaceWin'},
viewArgs={['UIXianMengPalaceWin']=argstable},
}
self:showUI(args)
end

function UIFullXianMengPalaceControl:showWindowXMListInfo(argstable)
local tabType=FULL_TAB_TYPE.eXianMengListInfo
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIXianMengListWin'},
viewArgs={['UIXianMengListWin']=argstable},
}
self:showUI(args)
end

function UIFullXianMengPalaceControl:showWindowXMPostInfo(argstable)
local tabType=FULL_TAB_TYPE.eXianMengPostInfo
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIXianMengPostSetWin'},
viewArgs={['UIXianMengPostSetWin']=argstable},
}
self:showUI(args)
end

function UIFullXianMengPalaceControl:showWindowXMMouLueInfo(argstable)
local tabType=FULL_TAB_TYPE.eXianMengMouLueSetInfo
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIXianMengMouLueSetWin'},
viewArgs={['UIXianMengMouLueSetWin']=argstable},
}
self:showUI(args)
end

function UIFullXianMengPalaceControl:initSendPro1()

end

function UIFullXianMengPalaceControl:initSendPro2()

end

function UIFullXianMengPalaceControl:initSendPro3()

end
function UIFullXianMengPalaceControl:initSendPro4()

end


function UIFullXianMengPalaceControl:check_GrayMouLue(attach,isWarning)
return not xianmengController:judeMouLueOpen()
end

function UIFullXianMengPalaceControl:check_ClickMouLue(attach,isWarning)
if xianmengController:judeMouLueOpen()then

return true
else

local config=systemConfig.getSystemConfig(SYSTEM_DEFINE.eXianMengMouLueSetInfo)
local openargs=config.openargs[1]
local str='需要开服天数达到x天'

for k,v in ipairs(openargs)do
if v[1]==3 then
str=FMT.fmt("需要开服天数达到{0}天",v[2])
end
end
UIManager.error(str)

















return false

end

end
