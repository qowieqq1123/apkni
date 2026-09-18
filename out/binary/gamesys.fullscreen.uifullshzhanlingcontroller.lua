








UIFullSHZhanLingController=gameState.addListener(fullScreenUI.create())

function UIFullSHZhanLingController:onAppStart()

local function _showWindowSHZhanLingWin(...)self:showWindowSHZhanLingWin(...)end
local function _showWindowSJXianZangWin(...)self:showWindowSJXianZangWin(...)end

local function _checkOpen1(...)return self:checkOpen1(...)end
local function _checkOpen2(...)return self:checkOpen2(...)end


local menulist=
{

{tabType=FULL_TAB_TYPE.eSHZhanLing,callback=_showWindowSHZhanLingWin,reddotType=REDDIT_SUB_TYPE.sSHZhanLing,checkOpen=_checkOpen1,},

{tabType=FULL_TAB_TYPE.eSaiJiXianZang,callback=_showWindowSJXianZangWin,reddotType=REDDIT_SUB_TYPE.sSaiJiXianZang,checkOpen=_checkOpen2,}
}

local args=
{
skinType=fullScreenSkinType.eSkin11,
menulist=menulist,
fullType=FULL_TYPE.eSHZhanLing,
}
self:initUI(args)
end

function UIFullSHZhanLingController:showWindowSHZhanLingWin(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eSHZhanLing,
showBg=true,
showTopMask=true,
viewNames={'UIXM_ZZSH_ShanHaiZhanLingWin'},
viewArgs={['UIXM_ZZSH_ShanHaiZhanLingWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullSHZhanLingController:showWindowSJXianZangWin(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eSaiJiXianZang,
showBg=true,
showTopMask=true,
viewNames={'UIXM_ZZSH_SaiJiXianZangWin'},
viewArgs={['UIXM_ZZSH_SaiJiXianZangWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullSHZhanLingController:checkOpen1(argstable)
return zhengzhanshanhaiController.checkSHZhanLingOpen()
end

function UIFullSHZhanLingController:checkOpen2(argstable)
return zhengzhanshanhaiController.checkSJXianZangOpen()
end

function UIFullSHZhanLingController:showMainWindow(argstable)
local tabType=argstable.tabType or self:getReddotTab()
if tabType==FULL_TAB_TYPE.eSHZhanLing then
self:showWindowSHZhanLingWin(argstable)
elseif tabType==FULL_TAB_TYPE.eSaiJiXianZang then
self:showWindowSJXianZangWin(argstable)
end
if argstable.nextFunc then
local func=function()
argstable.nextFunc()
end
fullScreenUI.setNextActiveUICallback(func)
end
end

function UIFullSHZhanLingController:getReddotTab()
local tabType
for i,v in ipairs(self.subMenu)do
local isOpen=true
if v.checkOpen~=nil then
isOpen=v.checkOpen()
end
if isOpen then
if not tabType then
tabType=v.tabType
end
local reddotSubType=v.reddotType
if reddotSubType then
local isreddot=reddotClassManager.get_sub_reddot(reddotSubType)
if isreddot then
return v.tabType
end
end
end
end
return tabType
end

