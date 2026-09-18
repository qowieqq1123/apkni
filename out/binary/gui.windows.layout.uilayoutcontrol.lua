
UILayoutControl=gameState.addListener(fullScreenUI.create())

function UILayoutControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eLayout,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UILayoutControl:showLayoutWindow(argstable)
local tabType=FULL_TAB_TYPE.eLayout
local args=
{
tabType=tabType,
showBg=false,
showFg=false,
viewNames={'UILayoutWin'},
viewArgs={['UILayoutWin']=argstable},
showMain=false,
}
self:showUI(args)
end

function UILayoutControl:showFeedingLayoutWindow(argstable)
local tabType=FULL_TAB_TYPE.eFeedingLayout
local args=
{
tabType=tabType,
showBg=false,
showFg=false,
viewNames={'UIFeedingLayout'},
viewArgs={['UIFeedingLayout']=argstable},
showMain=false,
}
self:showUI(args)
end

function UILayoutControl:onEnterState(...)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
end

function UILayoutControl:onLeaveState(...)
notifySystem:removelistener(notifyConfig.on_system_open,self.onSystemOpen)
end

function UILayoutControl.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eSkyBuild and api_Available_SetPlaceObjectCover()then
UILayoutControl:openSkyLayout(true)
end
end

function UILayoutControl:onEnterHome()
local check=api_Available_SetPlaceObjectCover()and systemModel.isOpen(SYSTEM_DEFINE.eSkyBuild)
self:openSkyLayout(check)
end

function UILayoutControl:getLayoutPage()
return self.layoutPage or BUILD_TAB_TYPE.eProduction
end

function UILayoutControl:setLayoutPage(page)
self.layoutPage=page
end

function UILayoutControl:openSkyLayout(enable)
self.enableSkyLayout=enable
end

function UILayoutControl:isOpenSkyLayout()
return self.enableSkyLayout
end