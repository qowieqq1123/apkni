







def_class("UIXTCJForeGroundWin",UIWindowBase)









function UIXTCJForeGroundWin:bindComponents()

self.root=UIObject.get(self,0)
self.menu=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXTCJForeGroundWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end















local _this=nil
local _menuItemCmp={
root=-1,
background=0,
selected=1,
name1=2,
name2=3,
reddot=4,
}



function UIXTCJForeGroundWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskOpen,self.onXianTuChengJiuTaskChange)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskReward,self.onXianTuChengJiuTaskChange)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskComplete,self.onXianTuChengJiuTaskChange)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuSystemInit,self.onXianTuChengJiuSystemInit)
notifySystem:listenNotify(notifyConfig.onZongMenXianTuStage,self.onZongMenXianTuStage)
notifySystem:listenNotify(notifyConfig.onZongMenXianTuReward,self.onZongMenXianTuStage)
notifySystem:listenNotify(notifyConfig.onGuBaoSkillLevelChange,self.onGuBaoSkillLevelChange)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.onZongMenXianTuAnimation,self.onZongMenXianTuStage)

notifySystem:listenNotify(notifyConfig.onXianZhiLevelChange,self.onFreshXianZhiTab)
notifySystem:listenNotify(notifyConfig.onXianZhiXianBaoLevelChange,self.onFreshXianZhiTab)
notifySystem:listenNotify(notifyConfig.onXianZhiTaskStateChange,self.onFreshXianZhiTab)
notifySystem:listenNotify(notifyConfig.onXianZhiWagesReceive,self.onFreshXianZhiTab)
end


function UIXTCJForeGroundWin:__delete()
cameraControl.setCameraActive(true)
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskOpen,self.onXianTuChengJiuTaskChange)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskReward,self.onXianTuChengJiuTaskChange)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskComplete,self.onXianTuChengJiuTaskChange)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuSystemInit,self.onXianTuChengJiuSystemInit)
notifySystem:removelistener(notifyConfig.onZongMenXianTuStage,self.onZongMenXianTuStage)
notifySystem:removelistener(notifyConfig.onZongMenXianTuReward,self.onZongMenXianTuStage)
notifySystem:removelistener(notifyConfig.onGuBaoSkillLevelChange,self.onGuBaoSkillLevelChange)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.onZongMenXianTuAnimation,self.onZongMenXianTuStage)
notifySystem:removelistener(notifyConfig.onXianZhiLevelChange,self.onFreshXianZhiTab)
notifySystem:removelistener(notifyConfig.onXianZhiXianBaoLevelChange,self.onFreshXianZhiTab)
notifySystem:removelistener(notifyConfig.onXianZhiTaskStateChange,self.onFreshXianZhiTab)
notifySystem:removelistener(notifyConfig.onXianZhiWagesReceive,self.onFreshXianZhiTab)


end




function UIXTCJForeGroundWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local clickMenu=argtable.clickMenu or false
self.args=argtable or{}
self:refreshMenu()

cameraControl.setCameraActive(false)
end


function UIXTCJForeGroundWin:onHide()
cameraControl.setCameraActive(true)
end






function UIXTCJForeGroundWin:onCloseBtn()
if self.args.close then
self.args.close()
else
fullScreenUI.closeActiveUI(true)
end
end

function UIXTCJForeGroundWin:refreshMenu()
if fullScreenUI.activeUI==nil then
return
end
self.activeUI=fullScreenUI.activeUI

self.selectMenuIdx=self.activeUI.activeMenuIndex
self.menuData=self.activeUI.activeSubMenu
local menuCnt=self.menuData and#self.menuData or 0
self.menu:setChildLayoutGroupCreateItems(menuCnt,function(index)
self:refreshMenuItem(index)
end)
end

function UIXTCJForeGroundWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIXTCJForeGroundWin:refreshMenuItem(index)
local config=self.menuData[index]
local tabType=config.tabType
local tabConfig=fullScreenModel.getFullTabConfig(tabType)
local item=self.menu:getChildLayoutGroupGridItem(index-1)

local isActive=true
if config.checkopen then
isActive=config.checkopen()
end
item:SetChildActive(-1,isActive)
if not isActive then return end

if pfwindowslController:checkIsGameVersion_oumei()then
if index==2 then
local width=74
local height=120
item:SetChildSizeDelta(_menuItemCmp.name1,width,height)
item:SetChildSizeDelta(_menuItemCmp.name2,width,height)
end
end
item:SetChildText(_menuItemCmp.name1,tabConfig.tabname)
item:SetChildText(_menuItemCmp.name2,tabConfig.tabname)
item:SetChildActive(_menuItemCmp.background,self.selectMenuIdx~=index)
item:SetChildActive(_menuItemCmp.selected,self.selectMenuIdx==index)
item:SetChildButtonClick(_menuItemCmp.root,function()
self:onClickItem(index)
end)
local isreddot=false
local reddotType=config.reddotType
if reddotType then
isreddot=reddotClassManager.get_reddot(reddotType)






end
item:SetChildActive(_menuItemCmp.reddot,isreddot)
end

function UIXTCJForeGroundWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.menu:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_menuItemCmp.reddot,flag)
end

function UIXTCJForeGroundWin:onClickItem(index)
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI
if index==self.selectMenuIdx then
return
end
if activeUI.activeSubMenu and activeUI.activeSubMenu[index]then
local conf=activeUI.activeSubMenu[index]
local tabType=conf.tabType
if not fullScreenModel.checkTabEnoughCND(tabType,true)then return end
local clickCond=conf.clickCond
if clickCond~=nil then
if not clickCond()then
return
end
end
self:freshMenuSelect(self.selectMenuIdx)
self:freshMenuSelect(index)
activeUI.activeMenuIndex=index
self.selectMenuIdx=index

local clickCall=conf.callback
if clickCall==nil then
loggerUtil.logErrFMT('没有找到配置页签类型：{0}的点击事件',tabType)
return
end
if not fullScreenModel.isTabOpen(tabType,true)then return end
local isload=activeUI.showTabTypeList[tabType]
local argstable=nil
if activeUI.attach then
argstable=activeUI.attach
if argstable then
argstable.clickMenu=true
end
else
argstable={clickMenu=true}
end
clickCall(argstable)
if argstable then
argstable.clickMenu=nil
end
end
end

function UIXTCJForeGroundWin:freshMenuSelect(index)
if index==nil then
return
end
local activeUI=fullScreenUI.activeUI
local activeSubMenu=activeUI.activeSubMenu
local config=activeSubMenu[index]
if config==nil then
return
end
local selectMenuIdx=activeUI.activeMenuIndex
local item=self.menu:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_menuItemCmp.background,selectMenuIdx~=index)
item:SetChildActive(_menuItemCmp.selected,selectMenuIdx==index)
end

function UIXTCJForeGroundWin:setRootVisible(visible)
self.root:setActive(visible)
end

function UIXTCJForeGroundWin.onXianTuChengJiuSystemInit()

for i,v in pairs(eXianTuChengJiuFullScreenTabType)do

local reddot=xiantuchengjiuModel:getTabReddot(i)
_this:refreshReddot(v,nil,nil,nil,reddot)
end
end

function UIXTCJForeGroundWin.onXianTuChengJiuTaskChange(notifys)
local types={}
for i,v in ipairs(notifys)do
types[v[1]]=true
end

for i,v in pairs(types)do

local reddot=xiantuchengjiuModel:getTabReddot(i)
local v=eXianTuChengJiuFullScreenTabType[i]
_this:refreshReddot(v,nil,nil,nil,reddot)
end
end

function UIXTCJForeGroundWin.onZongMenXianTuStage()

local reddot=xiantuchengjiuModel:getTabReddot(eXianTuChengJiuTabType.ZongMenXianTu)
local v=eXianTuChengJiuFullScreenTabType[eXianTuChengJiuTabType.ZongMenXianTu]
_this:refreshReddot(v,nil,nil,nil,reddot)
end

function UIXTCJForeGroundWin.onGuBaoSkillLevelChange(gbid,skilllv,oldLv)

local reddot=xiantuchengjiuModel:getTabReddot(eXianTuChengJiuTabType.XianTuChengJiu)
local v=eXianTuChengJiuFullScreenTabType[eXianTuChengJiuTabType.XianTuChengJiu]
_this:refreshReddot(v,nil,nil,nil,reddot)
end

function UIXTCJForeGroundWin.on_money_changed(moneyType,lastVal,val)
if moneyType==eMoneyType.mtDaoXun then
_this.onFreshXianZhiTab()
end

local lookup=cfg_lookupxiantuachieveconfig()
for i,v in ipairs(lookup)do
local gubaoid=v[1]
local gubaoCfg=cfgHelper.get1(cfg_gubaoconfig_get,gubaoid)
local gubaoData=gubaoModel:getDataByID(gubaoid)
if gubaoData then
if moneyType==gubaoCfg.level[gbData.gubaoskilllv][1]then

local reddot=xiantuchengjiuModel:getTabReddot(eXianTuChengJiuTabType.XianTuChengJiu)
local v=eXianTuChengJiuFullScreenTabType[eXianTuChengJiuTabType.XianTuChengJiu]
_this:refreshReddot(v,nil,nil,nil,reddot)
return
end
end
end
end

function UIXTCJForeGroundWin.onFreshXianZhiTab()
local reddot=xianzhiModel:getReddot()
_this:refreshReddot(eXianTuChengJiuScreneTabType.XianZhi,nil,nil,nil,reddot)
end