







def_class("UIRankListTabListWin",UIWindowBase)









function UIRankListTabListWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.closeTx=UIText.get(self,1)
self.content=UIObject.get(self,2)
self.tabList=UILoopListView.new(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tabList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIRankListTabListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeTx);self.closeTx=nil;
_UIObject_release(self.content);self.content=nil;
self.tabList:deleteSelf();self.tabList=nil;
end















local _this=nil
local _tabCmp={
root=-1,
select=0,
name=1,
}
local _LuaComboTreeView=simple_class(LuaComboTreeView)
local _tabItem1Name="tabItem1"
local _tabItem2Name="tabItem2"



function UIRankListTabListWin:onLoaded(...)
self:bindComponents()
_this=self
self.tabView=_LuaComboTreeView(self.winlua,self.tabList)
self._onItemRefresh1=function(widget,mainIndex,subIndex)
self:onItemRefresh1(widget,mainIndex,subIndex)
end
self.tabView:setItemRefresh(_tabItem1Name,self._onItemRefresh1)
self._onItemRefresh2=function(widget,mainIndex,subIndex)
self:onItemRefresh2(widget,mainIndex,subIndex)
end
self.tabView:setItemRefresh(_tabItem2Name,self._onItemRefresh2)
end


function UIRankListTabListWin:__delete()
self:unbindComponents()
_this=nil
end




function UIRankListTabListWin:onShow(argtable,afterOnloaded)
self.config=cfgHelper.get1(cfg_steletypeconfig_get,argtable.id)
self.closeTx:setText(self.config.name)
self.selectMain=nil
self.selectSub=nil
self:refreshTabList()
self:onClickMainItem(1)
end


function UIRankListTabListWin:onHide()

end




function UIRankListTabListWin:onCloseBtn()
UIFullZaoHuaTianBeiControl:closeNormalRankListWin()
end

function UIRankListTabListWin:onStartAction()
end

function UIRankListTabListWin:onFreshAction()
end

function UIRankListTabListWin:onItemRefresh1(item,mainIndex,subIndex)
local selected=self.tabView:isExpanding(mainIndex)
local data=self.tabDatas[mainIndex]
local index=data[1]
local info=self.config.panelArgs[index]
local nameStr=info.name or cfgHelper.get2(cfg_stelerankconfig_get,info.list[1],"name")
item:SetChildText(_tabCmp.name,nameStr)
item:SetChildActive(_tabCmp.select,selected)
item:SetChildButtonClick(_tabCmp.root,function()
self:onClickMainItem(mainIndex)
end)
end

function UIRankListTabListWin:onClickMainItem(mainIndex)
if self.selectMain~=mainIndex then
self.selectMain=mainIndex
self.selectSub=1
self.tabView:expandMain(mainIndex)
self:showContentPanel(mainIndex)
end
end

function UIRankListTabListWin:onItemRefresh2(item,mainIndex,subIndex)
local selected=self.tabView:isExpanding(mainIndex)and self.selectSub==subIndex
local data=self.tabDatas[mainIndex]
local mIdx=data[1]
local info=self.config.panelArgs[mainIndex]
local nameStr=cfgHelper.get2(cfg_stelerankconfig_get,info.list[subIndex],"name")
item:SetChildText(_tabCmp.name,nameStr)
item:SetChildActive(_tabCmp.select,selected)
item:SetChildButtonClick(_tabCmp.root,function()
self:onClickSubItem(mainIndex,subIndex)
end)
end

function UIRankListTabListWin:onClickSubItem(mainIndex,subIndex)
local oMain=self.selectMain
local oSub=self.selectSub
self.selectMain=mainIndex
self.selectSub=subIndex
if oMain~=self.selectMain or oSub~=self.selectSub then
if oMain then
self.tabView:refreshItem(oMain,oSub or 0)
end
self.tabView:refreshItem(self.selectMain,self.selectSub or 0)

self:showContentPanel(mainIndex,subIndex)
end
end

function UIRankListTabListWin:refreshTabList()
self.mainNames={}
self.subNames={}
self.tabDatas={}
for i,v in ipairs(self.config.panelArgs)do
local count=#v.list
local subs={}
local temp={}
if count>0 then
for j,w in ipairs(v.list)do
local cfg=cfgHelper.get1(cfg_stelerankconfig_get,w)
if rankListModel:checkStelePaneShow(cfg.show)then
table.insert(subs,_tabItem2Name)
table.insert(temp,j)
end
end
end
if#temp>0 then
local index=#self.mainNames+1
self.mainNames[index]=_tabItem1Name
self.subNames[index]=#subs>1 and subs or defaultT
self.tabDatas[index]={i,temp}
end
end

self.tabView:setMainData(self.mainNames)
for i,v in ipairs(self.subNames)do
self.tabView:setSubData(i,v)
end
self.tabView:refreshView()
end

function UIRankListTabListWin:showContentPanel(mainIndex,subIndex)
local data=self.tabDatas[mainIndex]
local mIdx=data[1]
local info=self.config.panelArgs[mIdx]
local sIdx=data[2][subIndex or 1]
local rank=info.list[sIdx]
local config=cfgHelper.get1(cfg_stelerankconfig_get,rank)

if self.exPanel and config.winName~=self.exPanel then
self:hideWindow(self.exPanel)
end
self.exPanel=config.winName
local args={
server=self.config.server,
rank=config.rank,
args=config.winArgs,
}
self:showWindow(config.winName,args)
end