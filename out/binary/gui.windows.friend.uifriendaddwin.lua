







def_class("UIFriendAddWin",UIWindowBase)









function UIFriendAddWin:bindComponents()

self.fCloseButton=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.allAddBtn=UIButton.get(self,2)
self.changeBtn=UIButton.get(self,3)
self.listScroller=UIObject.get(self,4)
self.NullTxt=UIText.get(self,5)
self.title=UIText.get(self,6)
self.findInputField=UIInputField.get(self,7)
self.findBtn=UIButton.get(self,8)

self.fCloseButton:setButtonClick(function()self:onFCloseButton()end)

self.allAddBtn:setButtonClick(function()self:onAllAddBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.findBtn:setButtonClick(function()self:onFindBtn()end)



end


function UIFriendAddWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fCloseButton);self.fCloseButton=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.allAddBtn);self.allAddBtn=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.NullTxt);self.NullTxt=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.findInputField);self.findInputField=nil;
_UIObject_release(self.findBtn);self.findBtn=nil;
end

















local ListCmpIndex=
{
select=0,
name=1,
guild=2,
level=3,
head=4,
addBtn=5,
addBtnText=6,
headBg=7,
}




function UIFriendAddWin:onLoaded(...)
self:bindComponents()
self:initData()
self:initUI()
end


function UIFriendAddWin:__delete()
self:unbindComponents()
end

function UIFriendAddWin:onFCloseButton()
UIFullFriendMainControl:closeUI(true,true)
end




function UIFriendAddWin:onShow(argtable,afterOnloaded)
self:updateData(argtable)
self:refreshUI()
if afterOnloaded then
self.title:setText("推荐仙友")
end
end


function UIFriendAddWin:onHide()

end






function UIFriendAddWin:initData()
self.addedList={}
self.addableList={}
end

function UIFriendAddWin:updateData(argtable)
if argtable then
self.addedList=argtable.added or{}
end
self.addableList=friendModel:getList(eFriendDataType.eAddable)
end




function UIFriendAddWin:initUI()
self:initList()
end


function UIFriendAddWin:initList()

self.listScroller:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIFriendAddWin:refreshUI()
self:refreshList()
end


function UIFriendAddWin:refreshList()
local dataList=self.addableList
local hasData=#dataList>0
if not hasData then
self.NullTxt:setActive(true)
self.NullTxt:setText("未搜索到该仙友")
self.listScroller:setActive(false)
return
else
self.NullTxt:setActive(false)
end

self.listScroller:setActive(true)
self.listScroller:setChildScrollViewCreateGrids(#dataList,2)

local grids=self.listScroller:getChildScrollViewItemWidgets()
for i,v in ipairs(dataList)do
local slot=grids[i-1]

slot:SetChildText(ListCmpIndex.name,FMT.fmt("{0}",v.playerName))
slot:SetChildText(ListCmpIndex.guild,FMT.fmt("{0}",v.zmName))
slot:SetChildText(ListCmpIndex.level,FMT.fmt("{0}",v.zmLevel))






























playerController:setHeadIcon(slot,ListCmpIndex.head,{iconInfo=v.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})

slot:SetChildButtonClickWithID(ListCmpIndex.headBg,function(index)
self:onClickList(index)
end,i)


local isEnable=v.sqFlag~=1






slot:SetChildText(ListCmpIndex.addBtnText,isEnable and"添加"or"已添加")
slot:SetChildActive(ListCmpIndex.addBtn,isEnable)
slot:SetChildActive(ListCmpIndex.select,not isEnable)
slot:SetChildButtonClick(ListCmpIndex.addBtn,function()self:onClickAdd(1,i-1)end)
end
end




function UIFriendAddWin:onClickAdd(chickNum,index)
local data=self.addableList[index+1]
local playerIdList={data.actorId}
local friendType=data.crossServerName==""and eFriendListType.eLocal or eFriendListType.eCross

friendProtocolController.req_add_friend(friendType,playerIdList)
end


function UIFriendAddWin:onAllAddBtn()

local local_playerIdList={}

local cross_playerIdList={}


for i,v in pairs(self.addableList)do
if v.crossServerName==""then
local_playerIdList[#local_playerIdList+1]=v.actorId
else
cross_playerIdList[#cross_playerIdList+1]=v.actorId
end
end


if#local_playerIdList>0 then
friendProtocolController.req_add_friend(eFriendListType.eLocal,local_playerIdList)
friendModel:setSqFlagByPlayIdList(local_playerIdList)
end
if#cross_playerIdList>0 then
friendProtocolController.req_add_friend(eFriendListType.eCross,cross_playerIdList)
friendModel:setSqFlagByPlayIdList(cross_playerIdList)
end
end


function UIFriendAddWin:onChangeBtn()
friendProtocolController.req_find_friend()
end


function UIFriendAddWin:onFindBtn()
local playerName=self.findInputField:getInputFieldValue()
friendProtocolController.req_find_friend(playerName)
self.title:setText("搜索结果")
end

function UIFriendAddWin:onClickList(index)

local data=self.addableList[index]

otherPlayerController:openOtherPlayerInfoWin(data.actorId)
end