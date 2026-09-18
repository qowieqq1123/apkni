







def_class("UIWagesInfoWin",UIWindowBase)









function UIWagesInfoWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.catModel=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.flagSpine=UIObject.get(self,3)
self.maskBtn=UIButton.get(self,4)
self.menuList=UIObject.get(self,5)
self.menuScrollView=UIObject.get(self,6)
self.quickBtn=UIButton.get(self,7)
self.Root=UIObject.get(self,8)
self.uiRoot=UIObject.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maskBtn:setButtonClick(function()self:onMaskBtn()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)



end


function UIWagesInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.catModel);self.catModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.flagSpine);self.flagSpine=nil;
_UIObject_release(self.maskBtn);self.maskBtn=nil;
_UIObject_release(self.menuList);self.menuList=nil;
_UIObject_release(self.menuScrollView);self.menuScrollView=nil;
_UIObject_release(self.quickBtn);self.quickBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this




function UIWagesInfoWin:onLoaded(...)
self:bindComponents()

_this=self

self.spineAnim=eAnimationID.enter
end


function UIWagesInfoWin:__delete()
_this=nil

self:unbindComponents()
self:stopCloseDelay()
end




function UIWagesInfoWin:onShow(argtable,afterOnloaded)
self.bgSpine:setChildUIModelShowTarget(5633,1,nil,eAnimationID.enter)

self:refreshAll()
end


function UIWagesInfoWin:onHide()

end

function UIWagesInfoWin:refreshAll()

self.selectIndex=1

self.wagesInfoList=wagesMsgConfig.getWagesInfoList()
local len=#self.wagesInfoList

if len==0 then
self:closeSelf()
return
end

local isShow=len>1
local isJustNotify=len==1

self.menuScrollView:setActive(isShow)
self.quickBtn:setActive(isShow)
if isShow then
local createFunc=function(index)
if _this==nil then return end

local item=_this.menuList:getChildLayoutGroupGridItem(index-1)

local info=_this.wagesInfoList[index]

local isShowItem=info~=nil
item:SetChildActive(-1,isShowItem)
if isShowItem then
local isSelect=_this.selectIndex==index
item:SetChildActive(0,isSelect)
item:SetChildCSImageSprite(1,'ui/windows/wages/wages_atlas_pak.ab',info.menuName)

item:SetBaseItemClickEvent(-1,function()
if _this==nil then return end
_this:onClickItem(index,item)
end)


_this:addNotify(info.receiveNotify,function()

if not _this then return end
_this:hideWindow(info.winName)
_this:refreshAll()
end)
end
end
self.menuList:setChildLayoutGroupCreateItems(len,createFunc)
elseif isJustNotify then
local info=self.wagesInfoList[1]
self:addNotify(info.receiveNotify,function()

if not _this then return end
_this:hideWindow(info.winName)
_this:refreshAll()
end)
end
self.closeBtn:setActive(false)
self:stopCloseDelay()
self:showSelectWindow()
end

function UIWagesInfoWin:showSelectWindow()
local info=self.wagesInfoList[self.selectIndex]
self:showWindow(info.winName)


self.flagSpine:setChildUIModelShowTarget(info.flagSpineId,1,nil,self.spineAnim,false,false,0.4)
self.spineAnim=eAnimationID.stand

self:freshQuickBtn()
end


function UIWagesInfoWin:freshQuickBtn()
local info=self.wagesInfoList[self.selectIndex]

local isShowSubWinNpc=info.checkShowNpc()
local isShowQuickBtn=(not isShowSubWinNpc)and#self.wagesInfoList>1
self.quickBtn:setActive(isShowQuickBtn)

self.catModel:setChildUIModelShowTarget(4015,0.24,nil,eAnimationID.stand)
end


function UIWagesInfoWin:onClickItem(index,item)
if index==self.selectIndex then return end

local preItem=self.menuList:getChildLayoutGroupGridItem(self.selectIndex-1)
preItem:SetChildActive(0,false)
local preInfo=self.wagesInfoList[self.selectIndex]
self:hideWindow(preInfo.winName)

self.selectIndex=index
item:SetChildActive(0,true)
self:showSelectWindow()
end





function UIWagesInfoWin:onQuickBtn()
wagesMsgController:reqQuickReceiveWages()
end

function UIWagesInfoWin:onMaskBtn()
local info=self.wagesInfoList[self.selectIndex]
if info.maskReceive then
info.maskReceive()

self:showCloseBtn()
end
end

function UIWagesInfoWin:onCloseBtn()
wagesMsgController:reqQuickReceiveWages()

self:closeSelf()
end

function UIWagesInfoWin:showCloseBtn()
if self.closeDelayTime then return end

self.closeDelayTime=self:delayDo(3,function()
self.closeBtn:setActive(true)
end)
end

function UIWagesInfoWin:stopCloseDelay()
if self.closeDelayTime then
self:stopTimerByID(self.closeDelayTime)
self.closeDelayTime=nil
end
end
