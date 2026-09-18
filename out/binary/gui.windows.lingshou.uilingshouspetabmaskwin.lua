







def_class("UILingShouSpeTabMaskWin",UIWindowBase)








function UILingShouSpeTabMaskWin:bindComponents()

self.animRoot=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.menuGrid=UIObject.get(self,2)
self.titleTxt=UIText.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UILingShouSpeTabMaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.menuGrid);self.menuGrid=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end
















local animLookup={
'lingshoukaihua_lock',
'lingshoukaihua_close_idle',
'lingshoukaihua_close',
'lingshoukaihua_open_idle',
'lingshoukaihua_open',
}


function UILingShouSpeTabMaskWin:onLoaded(...)
self:bindComponents()
end


function UILingShouSpeTabMaskWin:__delete()
self:unbindComponents()
end


function UILingShouSpeTabMaskWin:onHide()
self.isPlay=false
self:clearReddotFunction()
end




function UILingShouSpeTabMaskWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}

self.selectMenuIdx=argtable.selectMenuIdx
self.mainWinArgs=argtable.mainWinArgs
self.canvas=argtable.canvas
if self.canvas then
self.winlua:SetCanvasIndex(-1,self.canvas)
end

self.titleName=argtable.titleName
self.menuConfig=argtable.menuConfig

self.showMenu=true
self.showMenuNum=#self.menuConfig

if not self.isPlay then
if not afterOnloaded then

self.animRoot:setAnimatorInteger('state',0,true)
end
self.menuGrid:setActive(false)
local func=function()
self.menuGrid:setActive(true)
end
self:delayDo(0.2,func)

self:refreshTitle()
self:refreshMenuList()
end
self:setAsFirstSibling()
self.isPlay=true
self:refreshTitle()
self:refreshMenuList()

if afterOnloaded then
self:on_click_callback(self.selectMenuIdx)
end
end

function UILingShouSpeTabMaskWin:refreshAttach(ls_guid)
self.mainWinArgs.ls_guid=ls_guid
end

function UILingShouSpeTabMaskWin:setTitle(title)
self.titleTxt:setText(title)
end

function UILingShouSpeTabMaskWin:refreshTitle()
self:setTitle(self.titleName)
end


function UILingShouSpeTabMaskWin:onCloseBtn()

AudioManager.playBtnClick()
self:onClickClose()
end

function UILingShouSpeTabMaskWin:onClickClose()
self:closeSelf()
end

function UILingShouSpeTabMaskWin:refreshMenuList()
if fullScreenUI.activeUI==nil then
return
end
local num=self.showMenuNum
self.menuGrid:setChildLayoutGroupCreateItems(num)
local gridlist=self.menuGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
self:fillMenu(item,i,self.menuConfig[i])
local func=function()
if i==self.selectMenuIdx then return end
self:on_click_callback(i)
end
item:SetChildButtonClick(3,func,true)
end
end

function UILingShouSpeTabMaskWin:fillMenu(item,index,config)
local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local selectMenuIdx=self.selectMenuIdx

item:SetChildCSImageSprite(1,nomalicon[1],nomalicon[2])
local animIdx=selectMenuIdx==index and 4 or 2
item:SetChildAnimationStringID(0,animLookup[animIdx])

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
item:SetChildActive(2,isreddot)

item:SetChildNewBieComponentId(3,FMT.fmt('UILingShouSpeTabMaskWin.btnClick.{0}',index))
end

function UILingShouSpeTabMaskWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.menuGrid:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(2,flag)
end

function UILingShouSpeTabMaskWin:refreshMenuSelect(index,is_select)
local item=self.menuGrid:getChildLayoutGroupGridItem(index-1)
local animIdx=is_select==true and 5 or 3
item:SetChildAnimationStringID(0,animLookup[animIdx],true,nil)
end

function UILingShouSpeTabMaskWin:on_click_callback(index)
self:refreshMenuSelect(self.selectMenuIdx,false)
self:refreshMenuSelect(index,true)
self.selectMenuIdx=index

local argstable=self.mainWinArgs
argstable.showPage=index
argstable.canvas=self.canvas
self:showWindow("UILingShouSpeMainWin",argstable)
end