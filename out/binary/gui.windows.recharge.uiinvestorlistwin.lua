







def_class("UIInvestorListWin",UIWindowBase)









function UIInvestorListWin:bindComponents()

self.tabList=UIObject.get(self,0)
self.tabView=UIObject.get(self,1)



end


function UIInvestorListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.tabView);self.tabView=nil;
end















local _this=nil
local _itemCmp={
bg=0,
select=1,
name=2,
reddot=3,
}
local _config={
{
name="月卡",
show=function()
return true
end,
reddotCatch={
CATCH_TYPE.eXianGouLiBao,
},
reddot=function()
return rechargeModel:checkMonthCardEnterReddot()
end,
viewName="UIMonthInvestorWin",
},
{
name="周卡",
show=function()
return rechargeModel:checkWeekCardTabShow()
end,
reddotCatch={
CATCH_TYPE.eWeekCard,
},
reddot=function()
return rechargeModel:checkWeekCardReddot()
end,
viewName="UIWeekInvestorWin",
},
}




function UIInvestorListWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.on_system_open,self.on_system_open)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.building_event,self.on_building_event)
self:addNotify(notifyConfig.onReddotCatchTypeChange,self.onReddotCatchTypeChange)
self.tabDatas={}
self.hideDatas={}
end


function UIInvestorListWin:__delete()
self:unbindComponents()
_this=nil
end




function UIInvestorListWin:onShow(argtable,afterOnloaded)
self:refreshTabData()
self.tabSelect=table.findValue(self.tabDatas,argtable.subTabType)or 1
self:refreshTabList()
self:showTabSelect(true,argtable.subTabArgs)
end


function UIInvestorListWin:onHide()

end

function UIInvestorListWin:onShowArgRecv()
local id=self.tabDatas[self.tabSelect]
self:refreshTabData()
self.tabSelect=table.findValue(self.tabDatas,id)or 1
self:refreshTabList()
self:showTabSelect(true)
end


function UIInvestorListWin:refreshTabData()
table.clear(self.tabDatas)
table.clear(self.hideDatas)
for i,v in ipairs(_config)do
if v.show()then
table.insert(self.tabDatas,i)
else
table.insert(self.hideDatas,i)
end
end
end

function UIInvestorListWin:refreshTabList()
local dataCnt=#self.tabDatas
local tabCnt=dataCnt>1 and dataCnt or 0
self.tabList:setChildLayoutGroupCreateItems(tabCnt,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local id=self.tabDatas[index]
local config=_config[id]
item:SetChildButtonClick(_itemCmp.bg,function()
self:onClickTab(index)
end)
item:SetChildActive(_itemCmp.select,self.tabSelect==index)
item:SetChildText(_itemCmp.name,config.name)
item:SetChildActive(_itemCmp.reddot,config.reddot())
end)
self.tabView:setChildScrollRectEnable(dataCnt>2)
end

function UIInvestorListWin:refreshAllTabReddot()
if#self.tabDatas>1 then
for index,data in ipairs(self.tabDatas)do
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local id=self.tabDatas[index]
local config=_config[id]
item:SetChildActive(_itemCmp.reddot,config.reddot())
end
end
end

function UIInvestorListWin:onClickTab(index)
if self.tabSelect~=index then
self:showTabSelect(false)

self.tabSelect=index

self:showTabSelect(true)
end
end

function UIInvestorListWin:showTabSelect(show,viewArgs)
local dataCnt=#self.tabDatas
if self.tabSelect then
if dataCnt>1 then
local item=self.tabList:getChildLayoutGroupGridItem(self.tabSelect-1)
item:SetChildActive(_itemCmp.select,show)
end
local id=self.tabDatas[self.tabSelect]
if show then
self:showWindow(_config[id].viewName,viewArgs)
else
self:hideWindow(_config[id].viewName)
end
end
end

function UIInvestorListWin:doReddotRefresh(index)
local id=self.tabDatas[index]
local config=_config[id]
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_itemCmp.reddot,config.reddot())
end

function UIInvestorListWin:checkTabListChange()
for i,v in ipairs(self.hideDatas)do
local config=_config[v]
if config:show()then
return true
end
end
return false
end

function UIInvestorListWin:checkRefreshView()
if self:checkTabListChange()then
local id=self.tabDatas[self.tabSelect]
self:refreshTabData()
self.tabSelect=table.findValue(self.tabDatas,id)or 1
self:refreshTabList()
self:showTabSelect(true)
end
end

function UIInvestorListWin.on_system_open()
_this:checkRefreshView()
end

function UIInvestorListWin.onNewDay()
_this:checkRefreshView()
end

function UIInvestorListWin.on_building_event(eType)
if etype==buildingEvent.zongmenLevelUp then
_this:checkRefreshView()
end
end

function UIInvestorListWin.onReddotCatchTypeChange(catchType)
if#_this.tabDatas>1 then
for i,v in ipairs(_this.tabDatas)do
local config=_config[v]
if table.containsValue(config.reddotCatch,catchType)then
_this:doReddotRefresh(i)
end
end
end
end