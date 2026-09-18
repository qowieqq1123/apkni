







def_class("UIRankListEnterWin1",UIWindowBase)









function UIRankListEnterWin1:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.enterList=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.spineList=UIObject.get(self,3)
self.tabList=UIObject.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIRankListEnterWin1:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.enterList);self.enterList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spineList);self.spineList=nil;
_UIObject_release(self.tabList);self.tabList=nil;
end















local _this=nil
local _tabCmp={
root=-1,
select=0,
name=1,
reddot=2,
}
local _enterCmp={
root=0,
reddot=1,
}



function UIRankListEnterWin1:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onNewDay,self.onNewDay)
end


function UIRankListEnterWin1:__delete()
self:unbindComponents()
_this=nil

self:stopAnimDelay()
end




function UIRankListEnterWin1:onShow(argtable,afterOnloaded)
self.tabIndex=argtable and argtable.tab or self.tabIndex or 1
self:refreshTabList()
self:refreshSpine(true)
self:refreshEnterList()
end


function UIRankListEnterWin1:onHide()

end




function UIRankListEnterWin1:onCloseBtn()
UIFullZaoHuaTianBeiControl:closeUI(true)
end

function UIRankListEnterWin1:onClickTab(index)
if self.tabIndex~=index then
if self.tabIndex then
local item=self.tabList:getChildLayoutGroupGridItem(self.tabIndex-1)
item:SetChildActive(_tabCmp.select,false)
end

self.tabIndex=index

local item=self.tabList:getChildLayoutGroupGridItem(self.tabIndex-1)
item:SetChildActive(_tabCmp.select,true)

self:refreshSpine(false)
self:refreshEnterList()
end
end

function UIRankListEnterWin1:onClickEnter(index)
local lookup=cfgHelper.get1(cfg_lookupsteletypeconfig_get,self.datas[self.tabIndex])
local id=lookup[index]
local cfg=cfgHelper.get1(cfg_steletypeconfig_get,id)
local args={
id=id,
}
rankListModel:doStelePanelOpen(cfg.panelType,args)
end

function UIRankListEnterWin1:refreshTabList()
self.datas={}
local config=cfg_steleserverconfig()
for id,cfg in ipairs(config)do
if cfg.show then
local check=true
for i,v in ipairs(cfg.show)do
if v[1]==1 then
local value=timeHelper.getServerOpenDay()
if value<v[2]then
check=false
break
end
end
end
if check then
table.insert(self.datas,id)
end
else
table.insert(self.datas,id)
end
end
local tabCnt=#self.datas
local showTab=tabCnt>1
self.tabList:setActive(showTab)
if showTab then
self.tabList:setChildLayoutGroupCreateItems(#self.datas,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local id=self.datas[index]
local cfg=config[id]
item:SetChildButtonClick(_tabCmp.root,function()
self:onClickTab(index)
end)
item:SetChildActive(_tabCmp.select,index==self.tabIndex)
item:SetChildText(_tabCmp.name,cfg.name)
item:SetChildActive(_tabCmp.reddot,rankListModel:getSteleServerReddot(id))
end)
end
end

function UIRankListEnterWin1:refreshSpine(isInit)
self:stopAnimDelay()
local config=cfgHelper.get1(cfg_steleserverconfig_get,self.datas[self.tabIndex])
self.spineList:setChildLayoutGroupCreateItems(#config.spine,function(index)
local item=self.spineList:getChildLayoutGroupGridItem(index-1)
local spineInfo=config.spine[index]
item:SetChildUIModelShowTarget(-1,spineInfo[1],1,{},isInit and eAnimationID.enter or eAnimationID.stand,false,true,0)
item:SetChildAnchoredPos(-1,spineInfo[2],spineInfo[3])
end)
if isInit then
self.animDelay=self:delayDo(1.25,function()
self.animDelay=nil
local items=self.enterList:getChildLayoutGroupGridList()
for i=1,items.Count do
local item=items[i-1]
item:SetChildCanvasGroupAlpha(_enterCmp.root,1)
end
end)
end
end

function UIRankListEnterWin1:stopAnimDelay()
if self.animDelay then
self:stopTimerByID(self.animDelay)
self.animDelay=nil
end
end

function UIRankListEnterWin1:refreshEnterList()
local server=self.datas[self.tabIndex]
local lookup=cfgHelper.get1(cfg_lookupsteletypeconfig_get,server)
self.enterList:setChildLayoutGroupCreateItems(#lookup,function(index)
local item=self.enterList:getChildLayoutGroupGridItem(index-1)
local id=lookup[index]
local cfg=cfgHelper.get1(cfg_steletypeconfig_get,id)
item:SetChildButtonClick(_enterCmp.root,function()
self:onClickEnter(index)
end)
item:SetChildNewBieComponentId(_enterCmp.root,FMT.fmt("UIRankListEnterWin1.enter_{0}_{1}",server,index))
item:SetChildAnchoredPos(_enterCmp.root,cfg.pos[1],cfg.pos[2])
item:SetChildSizeDelta(_enterCmp.root,cfg.size[1],cfg.size[2])

item:SetChildActive(_enterCmp.reddot,rankListModel:getStelePanelReddot(cfg.panelType,cfg.panelArgs))
item:SetChildCanvasGroupAlpha(_enterCmp.root,self.animDelay and 0 or 1)
end)
end

function UIRankListEnterWin1:showRoot(show)
self.root:setActive(show)
end

function UIRankListEnterWin1:refreshReddotByPanelType(panelType)
local tabItems=self.tabList:getChildLayoutGroupGridList()
for i=1,tabItems.Count do
local lookup=cfgHelper.get1(cfg_lookupsteletypeconfig_get,i)
for j,id in ipairs(lookup)do
local config=cfgHelper.get(cfg_steletypeconfig_get,id)
if config.panelType==panelType then
local item=tabItems[i-1]
if item then
item:SetChildActive(_tabCmp.reddot,rankListModel:getSteleServerReddot(i))
end

item=self.enterList:getChildLayoutGroupGridItem(j-1)
if item then
item:SetChildActive(_enterCmp.reddot,rankListModel:getStelePanelReddot(config.panelType,config.panelArgs))
end
break
end
end
end
end

function UIRankListEnterWin1:onNewDay()
_this:refreshTabList()
end