







def_class("UICommonActForeGroundTwoWin",UIWindowBase)









function UICommonActForeGroundTwoWin:bindComponents()

self.back=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.bg=UIImage.get(self,2)
self.menu=UIObject.get(self,3)
self.scrollView=UIScrollView.get(self,4)
self.btnClose=UIButton.get(self,5)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UICommonActForeGroundTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
end
















local _CMP_INDEX={
cmpSelfItem=0,
cmpName=1,
cmpReddot=2,
cmpBg=3,
cmpNomalIcon=4,
select=5,
}

local _this=nil
local _scrollLen=7
local _defaultSelectPageIndex=1




function UICommonActForeGroundTwoWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)
end


function UICommonActForeGroundTwoWin:__delete()
self.scrollView:setClickAction(nil)
self:unbindComponents()
self:clearReddotFunction()
end




function UICommonActForeGroundTwoWin:onShow(argtable,afterOnloaded)
self.initPageIndex=argtable and argtable.pageIndex
self.pageCfg=argtable and argtable.pageCfg or{}


self:showWindow("UICommonActBottomWin")
self:freshMenuList()
if not self.isPlay then

self.root:setChildCanvasGroupAlpha(0)
local cavasGroup=self.root:getCommonComponent('CanvasGroup')
if self.tweener then
self.tweener:Kill(false)
self.tweener=nil
end
self.tweener=_DOTweenProxy.DOFade(cavasGroup,1,1)
self.tweener:SetDelay(0.2)
end
self:setAsFirstSibling()
self.isPlay=true

if not afterOnloaded and argtable and argtable.isJump then
local jumpIndex=argtable and argtable.pageIndex
if jumpIndex then
self:on_click_callback(nil,jumpIndex)
end
end
end


function UICommonActForeGroundTwoWin:onHide()
self.isPlay=false
self:clearReddotFunction()
if self.selectMenuIdx then

self.selectMenuIdx=nil
end
end

function UICommonActForeGroundTwoWin:freshMenuList()
if self.selectMenuIdx then
return
end

self:clearReddotFunction()

local activeSubMenu=self.pageCfg
if activeSubMenu and#activeSubMenu>0 then
self.menu:setActive(true)


local tNum=#activeSubMenu

self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>_scrollLen)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(activeSubMenu)do
self:fillMenu(i,v)
end


local initPageIndex=self.initPageIndex or _defaultSelectPageIndex
self:on_click_callback(nil,initPageIndex)
else
self.menu:setActive(false)
end
end

function UICommonActForeGroundTwoWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end


function UICommonActForeGroundTwoWin:fillMenu(index,config)
local tabIndex=index
local tabConfig=fullScreenModel.getFullTabConfig(config.tabType)
local selectMenuIdx=self.selectMenuIdx
local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildActive(_CMP_INDEX.cmpBg,true)
item:SetChildActive(_CMP_INDEX.select,selectMenuIdx==tabIndex)
local tabName
if selectMenuIdx==tabIndex then
item:SetChildActive(_CMP_INDEX.cmpBg,false)

local selecticon=assetConfig.selecticon
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,selecticon[1],selecticon[2])
tabName=tabConfig.tabname
else
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
tabName=FMT.fmt("<color=#d0b496>{0}</color>",tabConfig.tabname)
end
item:SetChildText(_CMP_INDEX.cmpName,tabName)

local isreddot=false
local reddotType=config.reddotType
if reddotType then
isreddot=reddotClassManager.get_reddot(reddotType)
local func=function(...)
if self==nil or self.isClose then return end
self:refreshReddot(index,...)
end
self.reddotfuncs[reddotType]=func
reddotClassManager.register_event(reddotType,func)
end
item:SetChildActive(_CMP_INDEX.cmpReddot,isreddot)
end

function UICommonActForeGroundTwoWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.cmpReddot,flag)
end

function UICommonActForeGroundTwoWin:freshMenuSelect(index)
if index==nil then
return
end
local config=self.pageCfg[index]
if config==nil then
return
end
local selectMenuIdx=self.selectMenuIdx
local item=self.scrollView:getGridObjectByindex(index-1)

local isSelect=selectMenuIdx~=index
item:SetChildActive(_CMP_INDEX.cmpBg,not isSelect)
item:SetChildActive(_CMP_INDEX.select,isSelect)

local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local tabConfig=fullScreenModel.getFullTabConfig(tabType)
local tabName
if isSelect then
local selecticon=assetConfig.selecticon
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,selecticon[1],selecticon[2])
tabName=tabConfig.tabname
else
local nomalicon=assetConfig.nomalicon
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
tabName=FMT.fmt("<color=#d0b496>{0}</color>",tabConfig.tabname)
end
item:SetChildText(_CMP_INDEX.cmpName,tabName)
end

function UICommonActForeGroundTwoWin:on_click_callback(id,index,guid,attach)
if index==self.selectMenuIdx then
return
end
if self.pageCfg[index]then
local conf=self.pageCfg[index]
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
self.selectMenuIdx=index

if not fullScreenModel.isTabOpen(tabType,true)then return end

local win=conf.win
if self.pagewin==win then
return
end
if self.pagewin then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.pagewin=win
self:showWindow(win)
end
end
end




function UICommonActForeGroundTwoWin:onBtnClose()
self.selectMenuIdx=nil
self:closeSelf()
end

