







def_class("UICommonLeftMenuWin",UIWindowBase)









function UICommonLeftMenuWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.maskBlock=UIObject.get(self,1)
self.bgImg=UIImage.get(self,2)
self.root=UIObject.get(self,3)
self.menuScrollView=UIObject.get(self,4)
self.menuGrid=UIObject.get(self,5)



end


function UICommonLeftMenuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.menuScrollView);self.menuScrollView=nil;
_UIObject_release(self.menuGrid);self.menuGrid=nil;
end



















function UICommonLeftMenuWin:onLoaded(...)
self:bindComponents()
self.viewCache={}
self.viewLookup={}
self.viewVis={}
self:addNotify(notifyConfig.onTouZiAutoReddotChange,function(list)
self:freshAllReddot(list)
end)
self.reddotNotifyTable={}
end




function UICommonLeftMenuWin:onShow(argtable,afterOnloaded)
local list=UIFullTotalTouZiActivityontrol:getMenulist()
self.sublist=table.deepCopy(list)
self.curSelectIndex=argtable.subIndex or 1
self.extraParams=argtable.extraParams
self.subInfo=self.sublist[self.curSelectIndex]
self:freshInfo()
end

function UICommonLeftMenuWin:onShowArgRecv(argtable)
self:onShow(argtable)
end


function UICommonLeftMenuWin:__delete()
self:unbindComponents()

if self.showMoney then
self:hideWindow('UITopMoneyWin')
end
end


function UICommonLeftMenuWin:onHide()

end

function UICommonLeftMenuWin:freshInfo()
self:stopAllReddotNotify()
self.reddotNotifyTable={}
self:freshMenu()
self:freshUI()
end

function UICommonLeftMenuWin:onChangeTab()
local list=UIFullTotalTouZiActivityontrol:getMenulist()
local sublist=table.deepCopy(list)
local oldsublist=self.sublist
local max=#sublist
local curSelectIndex=self.curSelectIndex
local subInfo=self.subInfo
if curSelectIndex>max then
curSelectIndex=max
end
local newsubInfo=sublist[curSelectIndex]
if newsubInfo.menuType==subInfo.menuType and
newsubInfo.id==subInfo.id then
return
end
self.curSelectIndex=curSelectIndex
self.subInfo=newsubInfo
self:freshInfo()
end

function UICommonLeftMenuWin:showRawMaskWin(vis,args)
local rawImageBackWin='UIRawImageBackWin'
if vis then
self:showWindow(rawImageBackWin,args)
self.rawMaskWinVis=true
else
if not self.rawMaskWinVis then return end
self.rawMaskWinVis=false
UIManager:hideWindow(rawImageBackWin)
end
end

function UICommonLeftMenuWin:freshBG(abname,assetname)
local showBG=abname~=nil and assetname~=nil
self.bgImg:setActive(showBG)

local oldabname=self.abname
local oldassetname=self.assetname
self.abname=abname
self.oldassetname=assetname

if showBG and(oldabname~=abname or oldassetname~=assetname)then
self.bgImg:setSprite(abname,assetname)
self.winlua:SetChildCanvasGroupAlpha(self.bgImg:getID(),0)
self.winlua:SetChildCanvasGroupDOFade(self.bgImg:getID(),1,0.5)
end
end

function UICommonLeftMenuWin:freshMoney(moneytypes)
if moneytypes then
self.showMoney=true
self:showWindow('UITopMoneyWin',moneytypes)
else
if not self.showMoney then return end
self.showMoney=false
self:hideWindow('UITopMoneyWin')
end
end

function UICommonLeftMenuWin:freshMenu()
local c=#self.sublist
self.menuGrid:setChildLayoutGroupCreateItems(c)
if c>0 then
local grids=self.menuGrid:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:freshMenuItem(item,i)
end
end
end

function UICommonLeftMenuWin:freshMenuItem(item,idx)
if item==nil then
item=self.menuGrid:getChildLayoutGroupGridItem(idx-1)
end

local data=self.sublist[idx]
local cfg=data.cfg


self:freshMenuItemSelect(idx)

self:freshMenuItemReddot(idx)

item:SetChildButtonClick(4,function()
self:onMenuClick(idx)
end)
end

function UICommonLeftMenuWin:freshMenuItemSelect(idx)
local item=self.menuGrid:getChildLayoutGroupGridItem(idx-1)

local subInfo=self.sublist[idx]
local cfg=subInfo.cfg
local data=subInfo.data
local flag=idx==self.curSelectIndex
item:SetChildActive(2,not flag)
item:SetChildActive(3,flag)


local nameStr=cfg.name or cfg.namefunc and cfg.namefunc(data)or'没有名称'
if flag then
nameStr=toColorString(FONT_COLOR.eGrayWhiteTxtColor,nameStr)
else
nameStr=FMT.fmt('<color=#d0b496>{0}</color>',nameStr)
end
item:SetChildText(0,nameStr)


local iconFunc=flag and cfg.selectIconFunc or cfg.iconFunc
local showIcon=iconFunc~=nil
item:SetChildActive(5,showIcon)
if showIcon then
local bundlename,assetname=iconFunc(data)
item:SetChildCSImageSprite(5,bundlename,assetname)
end
end

function UICommonLeftMenuWin:freshMenuItemReddot(idx)
local item=self.menuGrid:getChildLayoutGroupGridItem(idx-1)
local subInfo=self.sublist[idx]
local data=subInfo.data
local cfg=subInfo.cfg
local menuType=subInfo.menuType
local id=subInfo.id
local reddotType=cfg.reddotType
local reddotFunc=cfg.reddotFunc
local reddot=false
if reddotType then
reddot=reddotClassManager.get_reddot(reddotType)
elseif reddotFunc then
reddot=reddotFunc(data)
end
local lock=cfg.lockfunc and cfg.lockfunc(data)or false
item:SetChildActive(1,reddot)
item:SetChildActive(7,not lock)
item:SetChildActive(8,lock)

local notify=self.reddotNotifyTable[menuType]and self.reddotNotifyTable[menuType][id]or nil
if reddotType and notify==nil then
local func=function()
self:freshMenuItemReddot(idx)
end
self:addReddotNotify(reddotType,func)
if self.reddotNotifyTable[menuType]==nil then self.reddotNotifyTable[menuType]={}end
self.reddotNotifyTable[menuType][id]=true
end
end

function UICommonLeftMenuWin:freshAllReddot(list)
for i,v in ipairs(list)do
local menuType=v[1]
local id=v[2]
local idx=UIFullTotalTouZiActivityontrol:getMenuIndex(self.sublist,menuType,id)
if idx then
self:freshMenuItemReddot(idx)
end
end
end


function UICommonLeftMenuWin:onMenuClick(idx)
if self.lockClick==true then return end

if self.curSelectIndex==idx then return end

local subInfo=self.sublist[idx]
self.subInfo=subInfo
local data=subInfo.data
local cfg=subInfo.cfg
if cfg.lockfunc and cfg.lockfunc(data)then return end

local oldIdx=self.curSelectIndex
self.curSelectIndex=idx

if oldIdx then
self:freshMenuItemSelect(oldIdx)
end
self:freshMenuItemSelect(idx)

self:freshUI()
end

function UICommonLeftMenuWin:freshUI()
local subInfo=self.subInfo
local cfg=subInfo.cfg
local data=subInfo.data or{}


local showRawBg=cfg.showRawBg==true
local rawBgArgs=data.rawBgArgs
self:showRawMaskWin(showRawBg,rawBgArgs)


local bundlename,assetname=cfg.showBgfunc and cfg.showBgfunc(data)or nil
self:freshBG(bundlename,assetname)


local viewNamesLookup=cfg.viewNames or
cfg.viewNamesfunc and cfg.viewNamesfunc(data)or{}

table.clear(self.viewCache)
local newViewLookup=self.viewCache
for name,sub_args in pairs(viewNamesLookup)do
newViewLookup[name]=sub_args
end

for name,flag in pairs(self.viewVis)do
local cfg_args=newViewLookup[name]
if not flag and not cfg_args then
self.viewVis[name]=false
elseif flag and not cfg_args then
self:hideWindow(name)
self.viewVis[name]=false
else
newViewLookup[name]=nil
self.viewVis[name]=true
local params=self:getParams(self.subInfo,cfg_args,self.extraParams)
local win=UIManager:findActiveWindow(name)
if win and win.onShowArgRecv then
win:setVisible(true)
win:onShowArgRecv(params)
else
self:showWindow(name,params)
end
end
end

for name,cfg_args in pairs(newViewLookup)do
newViewLookup[name]=nil
self.viewVis[name]=true
local params=self:getParams(self.subInfo,cfg_args,self.extraParams)
local win=UIManager:findActiveWindow(name)
if win and win.onShowArgRecv then
win:onShowArgRecv(params)
else
self:showWindow(name,params)
end
end


local moneytypes=cfg.moneytypesfunc and cfg.moneytypesfunc(data)or nil
self:freshMoney(moneytypes)
end

function UICommonLeftMenuWin:getParams(subInfo,cfg_args,extraParams)
local data=subInfo.data
local params
local getParams=subInfo.cfg.getParams
if getParams then
params=getParams({baseTable=data,addTable=cfg_args,extraTable=extraParams})
else
params=table.deepCopy(data)
if params then
params=table.deepCopy(cfg_args,params,false)
else
if cfg_args then
params=table.deepCopy(cfg_args)
else
params={}
end
end
params.extraParams=extraParams
end
return params
end

function UICommonLeftMenuWin:onClickClose()

AudioManager.playBtnClick()
UIFullTotalTouZiActivityontrol:closeUI(nil,true)
end

function UICommonLeftMenuWin:onClickBlock()

end

function UICommonLeftMenuWin:activeRoot(flag)
self.root:setActive(flag)
end

function UICommonLeftMenuWin:activeBlack(flag)
self.blackImg:setActive(flag)
end

function UICommonLeftMenuWin:setLockClick(flag)
self.lockClick=flag
end
