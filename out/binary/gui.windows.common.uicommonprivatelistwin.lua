







def_class("UICommonPrivateListWin",UIWindowBase)









function UICommonPrivateListWin:bindComponents()

self.CSGUIScrollView=UILoopListView.new(self,0)
self.privateTitle=UIText.get(self,1)
self.rightBg=UIButton.get(self,2)
self.rightRoot=UIObject.get(self,3)

self.CSGUIScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.rightBg:setButtonClick(function()self:onRightBg()end)



end


function UICommonPrivateListWin:unbindComponents()
local _UIObject_release=UIObject.release
self.CSGUIScrollView:deleteSelf();self.CSGUIScrollView=nil;
_UIObject_release(self.privateTitle);self.privateTitle=nil;
_UIObject_release(self.rightBg);self.rightBg=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
end
















local _listHandle={
[CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent]={
name='最近联系人',
noneStr='暂无最近联系人',
getList=function()
return chatRecentModel.getRecentList()
end,
},
[CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend]={
name='我的仙友',
noneStr="暂无仙友\n快去添加更多仙友吧！",
getList=function()
return friendModel.getFriendList()
end,
},
[CHAT_PRIVATE_PLAYER_FROM_TYPE.eAlly]={
name='仙盟仙友',
noneStr="请先加入仙盟",
check=function()
return xianmengModel:hasXM()
end,
getList=function()
return xianmengModel.getAllyList()
end,
},
}

local _this=nil
local _LuaComboTreeView=simple_class(LuaComboTreeView)



function UICommonPrivateListWin:onLoaded(...)
self:bindComponents()
_this=self

self._ComboScrollView=_LuaComboTreeView(self.winlua,self.CSGUIScrollView)
self._ComboScrollView:setStartAction(function()self:onStartAction()end)
end


function UICommonPrivateListWin:__delete()
self:unbindComponents()
_this=nil
end




function UICommonPrivateListWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.startCallback=argtable.startCallback
self.closeCallback=argtable.closeCallback
self.formTypes=argtable.formTypes
self.mainPrefab=argtable.mainPrefab
self.mainRefresh=argtable.mainRefresh
self.subPrefab=argtable.subPrefab
self.subRefresh=argtable.subRefresh

self.privateCacheList={}
local mainNames={}
local subNames={}
for i,v in ipairs(self.formTypes)do
local listHandle=_listHandle[v]
if not listHandle.check or listHandle.check()then
local list=listHandle.getList()
self.privateCacheList[v]=list
local temp={}
for j,w in ipairs(list)do
table.insert(temp,self.subPrefab)
end
subNames[i]=temp
mainNames[i]=self.mainPrefab
end
end
self.selectMainIndex=nil
self.selectSubIndex=nil

self._ComboScrollView:setItemRefresh(self.mainPrefab,function(widget,mainIndex)
self:onCreateMainItem(widget,mainIndex)
end)

self._ComboScrollView:setItemRefresh(self.subPrefab,function(widget,mainIndex,subIndex)
self:onCreateSubItem(widget,mainIndex,subIndex)
end)

self._ComboScrollView:setMainData(mainNames)
for i,v in ipairs(subNames)do
self._ComboScrollView:setSubData(i,v)
end
self._ComboScrollView:refreshView()
end


function UICommonPrivateListWin:onHide()

end





function UICommonPrivateListWin:onRightBg()
local cb=self.closeCallback

if self.parentWin then
self.parentWin:closeWindow("UICommonPrivateListWin")
else
self:closeSelf()
end
if cb then
cb()
end
end

function UICommonPrivateListWin:onRectChanged()

end

function UICommonPrivateListWin:onStartAction()
if self.startCallback then
self.startCallback()
end
end

function UICommonPrivateListWin:onCreateMainItem(widget,mainIndex)
local formType=self.formTypes[mainIndex]
local expanding=self._ComboScrollView:isExpanding(mainIndex)
local listHandle=_listHandle[formType]
local name=listHandle.name

if self.mainRefresh then
self.mainRefresh(widget,formType,expanding,name)
end

widget:SetChildButtonClick(-1,function()
self:onClickMainItem(widget,mainIndex)
end)
end

function UICommonPrivateListWin:onCreateSubItem(widget,mainIndex,subIndex)
local formType=self.formTypes[mainIndex]
local list=self.privateCacheList[formType]
local actorInfo=list[subIndex]
local isSelected=self._ComboScrollView:isExpanding(mainIndex)and self.selectSub==subIndex

if self.subRefresh then
self.subRefresh(widget,formType,isSelected,actorInfo)
end

widget:SetChildButtonClick(-1,function()
self:onClickSubItem(mainIndex,subIndex)
end)
end

function UICommonPrivateListWin:onClickMainItem(widget,mainIndex)
if self.selectMainIndex~=mainIndex then
self.selectMainIndex=mainIndex
self.selectSubIndex=nil
end

self._ComboScrollView:expandMain(mainIndex)





end

function UICommonPrivateListWin:onClickSubItem(widget,mainIndex,subIndex)
local oMain=self.selectMainIndex
local oSub=self.selectSubIndex

self.selectMainIndex=mainIndex
self.selectSubIndex=subIndex

if oMain~=self.selectMainIndex or oSub~=self.selectSubIndex then
if oMain then
self._ComboScrollView:refreshItem(oMain,oSub or 0)
end
self._ComboScrollView:refreshItem(self.selectMainIndex,self.selectSubIndex or 0)
end
end

function UICommonPrivateListWin:refreshSubItem(actorId)
local formType=self.formTypes[self.selectMainIndex]
local list=self.privateCacheList[formType]
for subIndex,actorInfo in ipairs(list)do
if actorInfo.actorId==actorId then
self._ComboScrollView:refreshItem(self.selectMainIndex,subIndex)
end
end
end