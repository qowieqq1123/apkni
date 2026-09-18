







def_class("UIFriendApplyWin",UIWindowBase)









function UIFriendApplyWin:bindComponents()

self.fCloseButton=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.allYesBtn=UIButton.get(self,2)
self.allNoBtn=UIButton.get(self,3)
self.listScroller=UIObject.get(self,4)
self.NullTxt=UIText.get(self,5)

self.fCloseButton:setButtonClick(function()self:onFCloseButton()end)

self.allYesBtn:setButtonClick(function()self:onAllYesBtn()end)

self.allNoBtn:setButtonClick(function()self:onAllNoBtn()end)



end


function UIFriendApplyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fCloseButton);self.fCloseButton=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.allYesBtn);self.allYesBtn=nil;
_UIObject_release(self.allNoBtn);self.allNoBtn=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.NullTxt);self.NullTxt=nil;
end

















local ListCmpIndex=
{
select=0,
name=1,
guild=2,
level=3,
head=4,
noBtn=5,
yesBtn=6,
online=7,
}




function UIFriendApplyWin:onLoaded(...)
self:bindComponents()
self:initData()
self:initUI()

end


function UIFriendApplyWin:__delete()
self:unbindComponents()
end

function UIFriendApplyWin:onFCloseButton()
UIFullFriendMainControl:closeUI(true,true)
end





function UIFriendApplyWin:onShow(argtable,afterOnloaded)
self:updateData(argtable)
self:refreshUI()
end


function UIFriendApplyWin:onHide()

end







function UIFriendApplyWin:initData()
self.applyList={}
end

function UIFriendApplyWin:updateData(argtable)
self.applyList=friendModel:getList(eFriendDataType.eApply)
end




function UIFriendApplyWin:initUI()
self:initList()
end


function UIFriendApplyWin:initList()
self.listScroller:setChildScrollViewInit(0.5,true,function(...)self:onClickList(...)end,nil)
end


function UIFriendApplyWin:refreshUI()
self:refreshList()
end


function UIFriendApplyWin:refreshList()
local dataList=self.applyList
local hasData=#dataList>0
if not hasData then
self.NullTxt:setActive(true)
self.NullTxt:setText("当前暂无仙友申请")
self.listScroller:setActive(false)
self.allYesBtn:setActive(false)
self.allNoBtn:setActive(false)
return
else
self.NullTxt:setActive(false)
end
self.allYesBtn:setActive(true)
self.allNoBtn:setActive(true)

self.listScroller:setActive(true)
self.listScroller:setChildScrollViewCreateGrids(#dataList,1)

local grids=self.listScroller:getChildScrollViewItemWidgets()
for i,v in ipairs(dataList)do
local slot=grids[i-1]

slot:SetChildText(ListCmpIndex.name,FMT.fmt("{0}",v.playerName))

slot:SetChildText(ListCmpIndex.level,FMT.fmt("{0}",v.zmLevel))
local friendType=v.crossServerName==""and eFriendListType.eLocal or eFriendListType.eCross
if friendType==eFriendListType.eCross then
slot:SetChildText(ListCmpIndex.guild,FMT.fmt("<color=#6833c0>{0}</color>\n{1}",v.crossServerName,v.zmName==""and"暂无"or v.zmName))
else
slot:SetChildText(ListCmpIndex.guild,FMT.fmt("{0}",v.zmName==""and"暂无"or v.zmName))
end






























playerController:setHeadIcon(slot,ListCmpIndex.head,{iconInfo=v.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})

slot:SetChildButtonClick(ListCmpIndex.yesBtn,function()self:onClickYes(1,i-1)end)
slot:SetChildButtonClick(ListCmpIndex.noBtn,function()self:onClickNo(1,i-1)end)

local strOffline="在线"
if v.offline>0 then
local offline=gameUtilityModel.getServerShortTime()-v.offline
if offline<60 then
strOffline="<color=#65615f>刚刚</color>"
else
strOffline=FMT.fmt("<color=#65615f>{0}前</color>",timeHelper.format_time_stamp7(offline))
end
end
slot:SetChildText(ListCmpIndex.online,strOffline)
end
end




function UIFriendApplyWin:onClickList(chickNum,index)
local data=self.applyList[index+1]

otherPlayerController:openOtherPlayerInfoWin(data.actorId)
end


function UIFriendApplyWin:onClickYes(chickNum,index)
local data=self.applyList[index+1]
friendProtocolController.req_apply_confirm(eFriendApplyConfirm.eAgreeOne,data.actorId)
end


function UIFriendApplyWin:onClickNo(chickNum,index)
local data=self.applyList[index+1]
friendProtocolController.req_apply_confirm(eFriendApplyConfirm.eRefuseOne,data.actorId)
end


function UIFriendApplyWin:onAllYesBtn()
friendProtocolController.req_apply_confirm(eFriendApplyConfirm.eAgreeAll)
end


function UIFriendApplyWin:onAllNoBtn()
friendProtocolController.req_apply_confirm(eFriendApplyConfirm.eRefuseAll)
end