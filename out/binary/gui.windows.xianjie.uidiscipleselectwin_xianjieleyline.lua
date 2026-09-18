







def_class("UIDiscipleSelectWin_XianJieLeyLine",UIWindowBase)









function UIDiscipleSelectWin_XianJieLeyLine:bindComponents()

self.back=UIObject.get(self,0)
self.closebtn=UIButton.get(self,1)
self.ContentEx=UIObject.get(self,2)
self.discipleNumText=UIText.get(self,3)
self.emptyTx=UIText.get(self,4)
self.noDZTips=UIObject.get(self,5)
self.roleListPanelEx=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.sortTypeDropdown=UIDropdown.get(self,8)
self.sureBtn=UIButton.get(self,9)
self.title=UIText.get(self,10)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)



end


function UIDiscipleSelectWin_XianJieLeyLine:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.ContentEx);self.ContentEx=nil;
_UIObject_release(self.discipleNumText);self.discipleNumText=nil;
_UIObject_release(self.emptyTx);self.emptyTx=nil;
_UIObject_release(self.noDZTips);self.noDZTips=nil;
_UIObject_release(self.roleListPanelEx);self.roleListPanelEx=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.title);self.title=nil;
end















local _this=nil



function UIDiscipleSelectWin_XianJieLeyLine:onLoaded(...)
self:bindComponents()
_this=self

self.loopTreeView=self.winlua:GetChildUILoopTreeView(self.roleListPanelEx:getID())
self.loopTreeView:SetAction(function(...)
if not self or self.isClose then return end
self:freshLoopAction(...)
end,function()
if not self or self.isClose then return end
self:startLoopAction()
end)
self._selectDiscipleFunc=function(...)
return self:selectDiscipleFunc(...)
end
self._sortDiscipleFunc=function(...)
return self:sortDiscipleFunc(...)
end
end


function UIDiscipleSelectWin_XianJieLeyLine:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleSelectWin_XianJieLeyLine:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.callback=argtable.callback
self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,nil)
self.emptyTx:setText(argtable.emptyTips or"")
self:refresDiscipleList()

local index=self:findDiscipleIndex(argtable.disciple)
if index then
self:onClickItem(index)
end
end


function UIDiscipleSelectWin_XianJieLeyLine:onHide()

end




function UIDiscipleSelectWin_XianJieLeyLine:onClosebtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIDiscipleSelectWin_XianJieLeyLine:onSureBtn()
if self.selectIdx then
local netData=self.disciplelist[self.selectIdx]
local guid=netData.discipleguid
local state=xianjieModel:checkDZState(guid,true)
if state~=nil then
return
end
if self.callback then
self.callback(guid)
end
self:onClosebtn()
else
if self.callback then
self.callback()
end
self:onClosebtn()
end
end

function UIDiscipleSelectWin_XianJieLeyLine:freshLoopAction(i,item)
local index=i+1
self:refreshRoleItem(index,item)
end

function UIDiscipleSelectWin_XianJieLeyLine:startLoopAction()

end

function UIDiscipleSelectWin_XianJieLeyLine:selectDiscipleFunc(netData)
return netData.jingjielv>=90
end

function UIDiscipleSelectWin_XianJieLeyLine:sortDiscipleFunc(a,b)
local aState=xianjieModel:getDZState(a.discipleguid,false)
local bState=xianjieModel:getDZState(a.discipleguid,false)
aState=aState~=nil and 0 or 1
bState=bState~=nil and 0 or 1
if aState~=bState then
return aState>bState
elseif a.jingjielv~=b.jingjielv then
return a.jingjielv>b.jingjielv
else
return UIDiscipleModel:getDiscipleFightValue(a.discipleguid)>UIDiscipleModel:getDiscipleFightValue(b.discipleguid)
end
end

function UIDiscipleSelectWin_XianJieLeyLine:onLongClickItem(index)
local netData=self.disciplelist[index]
local guid=netData.discipleguid
otherPlayerController:openSelfPlayerDZInfoWin({guid})
end

function UIDiscipleSelectWin_XianJieLeyLine:onClickItem(index)
local netData=self.disciplelist[index]
local guid=netData.discipleguid
local state=xianjieModel:checkDZState(guid,true)
if state~=nil then
return
end

if self.selectIdx~=index then
if self.selectIdx then
local item=self.loopTreeView:GetItemWidget(self.selectIdx-1)
item:SetChildActive(10,false)
end
self.selectIdx=index
local item=self.loopTreeView:GetItemWidget(index-1)
item:SetChildActive(10,true)
else
self.selectIdx=nil
local item=self.loopTreeView:GetItemWidget(index-1)
item:SetChildActive(10,false)
end
end

function UIDiscipleSelectWin_XianJieLeyLine:refresDiscipleList()
self.disciplelist=UIDiscipleModel:getSortList(self._selectDiscipleFunc,self._sortDiscipleFunc)
local dataNum=#self.disciplelist
self.winlua:SetChildScrollRectStopMovement(self.roleListPanelEx:getID())
self.winlua:SetChildLocalPosY(self.ContentEx:getID(),0)
self.loopTreeView:InitDataList(dataNum,'Item')
self.noDZTips:setActive(dataNum<=0)
end

function UIDiscipleSelectWin_XianJieLeyLine:refreshRoleItem(i,item)
local netData=self.disciplelist[i]
local guid=netData.discipleguid

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(24,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,false,true)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)

item:SetChildLongTouch(-1,i,0.5,function(...)
self:onLongClickItem(i)
end)
item:SetChildButtonClick(-1,function()
self:onClickItem(i)
end)

item:SetChildActive(6,true)
item:SetChildText(6,UIDiscipleModel:getDiscipleFightValue(guid))

UIDiscipleController.refreshCommonItemTianMing(item,netData)

local showOrder=UIDiscipleModel:checkDZHasOrder(guid)
item:SetChildActive(15,showOrder)

local stateType,stateDesc=xianjieModel:getDZState(guid,true)
item:SetChildActive(16,stateType~=nil)
item:SetChildActive(8,stateType~=nil)
item:SetChildText(9,stateDesc or"")

item:SetChildActive(10,self.selectIdx==i)
end

function UIDiscipleSelectWin_XianJieLeyLine:findDiscipleIndex(guid)
for i,v in ipairs(self.disciplelist)do
if mathHelper.compareInt64(v.discipleguid,guid)then
return i
end
end
end