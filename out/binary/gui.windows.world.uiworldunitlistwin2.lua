







def_class("UIWorldUnitListWin2",UIWindowBase)









function UIWorldUnitListWin2:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.tabList=UIObject.get(self,1)
self.uiRoot=UIObject.get(self,2)
self.root=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIWorldUnitListWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this=nil
local _tabCmp={
selected=0,
name=1,
reddot=2,
button=3,
}
local _tabData={
{
id=1,
name="秘境",
system=SYSTEM_DEFINE.eMiJing,
panel="UIMysteryListWin",
reddot=function()
return mysteryZiYuanFuBenModel:checkPassReddot()or false
end,
},
{
id=2,
name="妖怪",
system=SYSTEM_DEFINE.eWorldResPoint,
panel="UIWorldMonsterListWin",
reddot=function()
return huntMonsterTeamModel:existTeamComplete()
end,
},
{
id=3,
name="宗门",
system=SYSTEM_DEFINE.eXiTongZongMen,
panel="UISystemZongMenListWin",
reddot=function()
return systemZongMenModel:getAllReddot()
end,
},
{
id=4,
name="家族",
system=SYSTEM_DEFINE.eXiuZhenFamily,
panel="UIWorldXiuZhenJiaZuListWin",
reddot=function()
return worldXiuZhenJiaZuModel:checkReddot()
end,
},
{
id=5,
name="仙友",
system=SYSTEM_DEFINE.eNPCOpen,
panel="UIWorldNPCListWin",
reddot=function()
return npcModel:getWorldAreaNPCReddot()
end,
},
{
id=6,
name="周常",
system=SYSTEM_DEFINE.eWorldWeek,
panel="UIWeekUnitListWin",
reddot=function()
return false
end,
},
}




function UIWorldUnitListWin2:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpenEvent)
self:refreshList()

self:addNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,self.on_UIWorldUnitListWin2_reddotChange)
end


function UIWorldUnitListWin2:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.on_system_open,self.onSystemOpenEvent)
notifySystem:removelistener(notifyConfig.swipe,self.onSwipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
if self.enterTimer then
self:stopTimerByID(self.enterTimer)
self.enterTimer=nil
end
end

function UIWorldUnitListWin2.on_UIWorldUnitListWin2_reddotChange(systemId)
if _this==nil then return end
_this:refreshReddot(systemId)
end




function UIWorldUnitListWin2:onShow(argtable,afterOnloaded)
notifySystem:listenNotify(notifyConfig.swipe,self.onSwipe)
notifySystem:listenNotify(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)

self.winlua:SwitchChildParent(self.root:getID(),worldController:isInWorld()and-1 or self.uiRoot:getID(),false)
self.root:setChildAnchoredPos(-522,1)
self.root:setChildDOAnchorPosX(14,0.25)

self.enterTimer=self:delayDo(0.25,function()
local specify=argtable and argtable.tab or worldModel:getPanelTab()
if specify then
for i,v in ipairs(self.list)do
local t=_tabData[v]
if t.id==specify then
self:onClickTab(i,argtable and argtable.extra or nil)
return
end
end
if argtable then
local tabData=_tabData[argtable]
UIManager.error(systemModel.getOpenTips(tabData.system))
end
end
if self.selected==nil then
self:onClickTab(1)
end
end)
end


function UIWorldUnitListWin2:onHide()

if self.enterTimer then
self:stopTimerByID(self.enterTimer)
self.enterTimer=nil
end
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
if self.selected~=nil then
local tabData=_tabData[self.list[self.selected]]
self:hideWindow(tabData.panel)
local tabItem=self.tabList:getChildLayoutGroupGridItem(self.selected-1)
tabItem:SetChildActive(_tabCmp.selected,false)
self.selected=nil
end
end



function UIWorldUnitListWin2:onCloseBtn()
if worldController:isInWorld()then
worldController:resetLeftView()
else
if self.selected~=nil then
local tabData=_tabData[self.list[self.selected]]
self:closeWindow(tabData.panel)
end
self:closeSelf()
end
end

function UIWorldUnitListWin2:onClickTab(index,param)

if self.selected~=index then
if self.selected~=nil then
local tabItem=self.tabList:getChildLayoutGroupGridItem(self.selected-1)
local tabData=_tabData[self.list[self.selected]]
tabItem:SetChildActive(_tabCmp.selected,false)
if worldController:isInWorld()then
self:hideWindow(tabData.panel)
else
self:closeWindow(tabData.panel)
end
end
self.selected=index
local tabItem=self.tabList:getChildLayoutGroupGridItem(self.selected-1)
local tabData=_tabData[self.list[self.selected]]
worldModel:setPanelTab(tabData.id)
tabItem:SetChildActive(_tabCmp.selected,true)
self:showWindow(tabData.panel,param)
end
end

function UIWorldUnitListWin2.onSystemOpenEvent(sysId)
for i,v in ipairs(_tabData)do
if v.system==sysId then
_this:refreshList()
return
end
end
end

function UIWorldUnitListWin2:refreshReddot(systemId)
for i,v in ipairs(self.list)do
local tabData=_tabData[v]
if tabData.system==systemId then
local tabItem=self.tabList:getChildLayoutGroupGridItem(i-1)
tabItem:SetChildActive(_tabCmp.reddot,tabData.reddot())
end
end
end

function UIWorldUnitListWin2:refreshList()
self.list={}
for i,v in ipairs(_tabData)do
if systemModel.isOpen(v.system)then
table.insert(self.list,i)
end
end

self.tabList:setChildLayoutGroupCreateItems(#self.list,function(index)
local tabItem=self.tabList:getChildLayoutGroupGridItem(index-1)
local tabData=_tabData[self.list[index]]

tabItem:SetChildText(_tabCmp.name,tabData.name)
tabItem:SetChildActive(_tabCmp.selected,self.selected==index)
tabItem:SetChildActive(_tabCmp.reddot,tabData.reddot())
tabItem:SetChildButtonClick(_tabCmp.button,function()
self:onClickTab(index)
end)
tabItem:SetChildNewBieComponentId(_tabCmp.button,FMT.fmt('UIWorldUnitListWin2.#tabList.button.{0}',index))
end)
end

function UIWorldUnitListWin2.onClickEmptyInWorld()
_this:onCloseBtn()
end

function UIWorldUnitListWin2.onSwipe()
_this:onCloseBtn()
end