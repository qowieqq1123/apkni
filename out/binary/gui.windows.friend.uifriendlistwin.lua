







def_class("UIFriendListWin",UIWindowBase)









function UIFriendListWin:bindComponents()

self.fCloseButton=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.pointTxt=UIText.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.allPrizeBtn=UIButton.get(self,4)
self.allGiveBtn=UIButton.get(self,5)
self.countTxt=UIText.get(self,6)
self.tabScroller=UIObject.get(self,7)
self.listScroller=UIObject.get(self,8)
self.NullTxt=UIText.get(self,9)
self.editBtn=UIButton.get(self,10)
self.editModePanel=UIObject.get(self,11)
self.removeBtn=UIButton.get(self,12)
self.exitEditModeBtn=UIButton.get(self,13)

self.fCloseButton:setButtonClick(function()self:onFCloseButton()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.allPrizeBtn:setButtonClick(function()self:onAllPrizeBtn()end)

self.allGiveBtn:setButtonClick(function()self:onAllGiveBtn()end)

self.editBtn:setButtonClick(function()self:onEditBtn()end)

self.removeBtn:setButtonClick(function()self:onRemoveBtn()end)

self.exitEditModeBtn:setButtonClick(function()self:onExitEditModeBtn()end)



end


function UIFriendListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fCloseButton);self.fCloseButton=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.pointTxt);self.pointTxt=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.allPrizeBtn);self.allPrizeBtn=nil;
_UIObject_release(self.allGiveBtn);self.allGiveBtn=nil;
_UIObject_release(self.countTxt);self.countTxt=nil;
_UIObject_release(self.tabScroller);self.tabScroller=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.NullTxt);self.NullTxt=nil;
_UIObject_release(self.editBtn);self.editBtn=nil;
_UIObject_release(self.editModePanel);self.editModePanel=nil;
_UIObject_release(self.removeBtn);self.removeBtn=nil;
_UIObject_release(self.exitEditModeBtn);self.exitEditModeBtn=nil;
end

















local ListCmpIndex=
{
select=0,
name=1,
guild=2,
offline=3,
level=4,
pointBtn=5,
head=6,
normalRoot=7,
blackRoot=8,
blackBtn=9,
pointBtnTxt=10,
visitBtn=11,
selectPoint=12,
selectTick=13,
headBg=14,
}


local TabCmpIndex=
{
select=0,
name=1,
}


local _tabList=
{
{name="本服仙友",null="暂无本服仙友",data="localList",max=friendModel.get_local_limit(),type=eFriendListType.eLocal},

{name="黑名单",null="暂无黑名单成员",data="blackList",max=friendModel.get_black_limit(),type=eFriendListType.eBlack},
}

local abname='ui/sharedtextures/uiglobalspriteatlas_1.ab'




function UIFriendListWin:onLoaded(...)
self:bindComponents()
self:initData()
self:initUI()
end


function UIFriendListWin:__delete()
self:unbindComponents()
end

function UIFriendListWin:onFCloseButton()
UIFullFriendMainControl:closeUI(true,true)
end




function UIFriendListWin:onShow(argtable,afterOnloaded)
if argtable and argtable.tabIndex then
self.tabIndex=argtable.tabIndex
end

self.isEditMode=false
self.removeList={}
self.selectCount=0
self:updateData(argtable)
self:refreshUI()
end


function UIFriendListWin:onHide()

end






function UIFriendListWin:initData()
self.tabIndex=1
self.localList={}
self.crossList={}
self.blackList={}
end

function UIFriendListWin:updateData(argtable)
if not self.isEditMode then
self.localList=friendModel:getSortList(friendModel:getList(eFriendDataType.eLocal))
self.crossList=friendModel:getSortList(friendModel:getList(eFriendDataType.eCross))
else
self.localList=friendModel:getSortList_remove(friendModel:getList(eFriendDataType.eLocal))
self.crossList=friendModel:getSortList_remove(friendModel:getList(eFriendDataType.eCross))
end
self.blackList=friendModel:getSortList(friendModel:getList(eFriendDataType.eBlack))
self.friendPoint=friendModel:getFriendPoint()
end




function UIFriendListWin:initUI()
self:initList()
self:initTab()
end


function UIFriendListWin:initList()
self.listScroller:setChildScrollViewInit(0.5,true,function(...)self:onClickList(...)end,nil)
end


function UIFriendListWin:initTab()
self.tabScroller:setChildScrollViewInit(0.5,false,function(...)self:onClickTab(...)end)
self.tabScroller:setChildScrollViewCreateGrids(#_tabList,#_tabList)
local grids=self.tabScroller:getChildScrollViewItemWidgets()
for i,v in ipairs(_tabList)do
local slot=grids[i-1]
slot:SetChildActive(TabCmpIndex.select,i==self.tabIndex)
slot:SetChildText(TabCmpIndex.name,FMT.fmt("{0}",_tabList[i].name))
end
end

function UIFriendListWin:onShowArgRecv()
self:updateData()
self:refreshUI()
end


function UIFriendListWin:refreshUI()
local tab=_tabList[self.tabIndex]
local tabListType=tab.type
local dataList=self[tab.data]
local hasData=#dataList>0
if not hasData then

self.isEditMode=false
end
self.editBtn:setActive(hasData and not self.isEditMode and tabListType~=eFriendListType.eBlack)
self.editModePanel:setActive(hasData and self.isEditMode and tabListType~=eFriendListType.eBlack)

self:refreshCount()
self:refreshPoint()
self:refreshList()
end


function UIFriendListWin:refreshPoint()


self.pointTxt:setActive(false)
self.helpBtn:setActive(false)
local limit=friendModel.get_friend_point_limit()
if self.friendPoint>0 then
self.pointTxt:setText(FMT.fmt("今日已领取：<color=#549327>{0}/{1}</color>",self.friendPoint,limit))
else
self.pointTxt:setText(FMT.fmt("今日已领取：{0}/{1}",self.friendPoint,limit))
end



end


function UIFriendListWin:refreshCount()
local tab=_tabList[self.tabIndex]
local tabListType=tab.type
local dataList=self[tab.data]
local len=#dataList

if tabListType~=eFriendListType.eBlack and self.isEditMode then
self.countTxt:setText(FMT.fmt("{0}：{1}/{2}",tab.name,self.selectCount,len))
else
self.countTxt:setText(FMT.fmt("{0}：{1}/{2}",tab.name,len,tab.max))
end
end


function UIFriendListWin:refreshList()
local tab=_tabList[self.tabIndex]
local tabListType=tab.type
local dataList=self[tab.data]
local hasData=#dataList>0
if not hasData then
self.NullTxt:setActive(true)
self.NullTxt:setText(tab.null)
self.listScroller:setActive(false)


return
else
self.NullTxt:setActive(false)
end










self.listScroller:setActive(true)
self.listScroller:setChildScrollViewCreateGrids(#dataList,1)

local grids=self.listScroller:getChildScrollViewItemWidgets()
for i,v in ipairs(dataList)do
local slot=grids[i-1]

local friendType=v.crossServerName==""and eFriendListType.eLocal or eFriendListType.eCross
slot:SetChildText(ListCmpIndex.name,FMT.fmt("{0}",v.playerName))
if friendType==eFriendListType.eCross then
slot:SetChildText(ListCmpIndex.guild,FMT.fmt("<color=#6833c0>{0}</color>\n{1}",v.crossServerName,v.zmName==""and"暂无宗门"or v.zmName))
else
slot:SetChildText(ListCmpIndex.guild,FMT.fmt("{0}",v.zmName==""and"暂无宗门"or v.zmName))
end

slot:SetChildText(ListCmpIndex.level,FMT.fmt("{0}",v.zmLevel))

















local isGray=v.offline>0


playerController:setHeadIcon(slot,ListCmpIndex.head,{iconInfo=v.iconInfo,scale=HEAD_SCALE_TYPE.e60x60,gray=isGray})

















slot:SetChildButtonClickWithID(ListCmpIndex.headBg,function(index)
self:onClickHead(index)
end,i)

slot:SetChildActive(ListCmpIndex.normalRoot,tabListType~=eFriendListType.eBlack)
slot:SetChildActive(ListCmpIndex.blackRoot,tabListType==eFriendListType.eBlack)

if tabListType==eFriendListType.eBlack then

slot:SetChildButtonClick(ListCmpIndex.blackBtn,function()self:onClickRemoveBlack(1,i-1)end)
else

local strOffline="在线"
local offlineDayCount=0
if v.offline>0 then
local offline=gameUtilityModel.getServerShortTime()-v.offline
if offline<60 then
strOffline="<color=#65615f>刚刚</color>"
else
strOffline=FMT.fmt("<color=#65615f>{0}前</color>",timeHelper.format_time_stamp7(offline))
offlineDayCount=math.floor(offline/86400+1)
end
end
slot:SetChildText(ListCmpIndex.offline,strOffline)

if not self.isEditMode then

local strPointState="button_aixin_3"
if v.pointButton==eFriendPointButton.eGive then
strPointState="button_aixin_2"
elseif v.pointButton==eFriendPointButton.ePrize then
strPointState="button_aixin_1"
elseif v.pointButton==eFriendPointButton.eGray then
strPointState="button_aixin_3"
end

slot:SetChildCSImageSprite(ListCmpIndex.pointBtn,globalABLookup.global,strPointState)


if v.pointButton~=eFriendPointButton.eGray then

slot:SetChildButtonClick(ListCmpIndex.pointBtn,function()self:onClickPointOper(1,i-1)end)
end


slot:SetChildActive(ListCmpIndex.visitBtn,true)
if offlineDayCount<7 then

slot:SetChildGray(ListCmpIndex.visitBtn,false)
slot:SetChildButtonClick(ListCmpIndex.visitBtn,function()
visitControl:reqEnterVisitMap(nil,v.actorId)
UIFullFriendMainControl:closeUI()
end)
else

slot:SetChildGray(ListCmpIndex.visitBtn,true)
slot:SetChildButtonClick(ListCmpIndex.visitBtn,function()
UIManager.error("仙友离线天数过长，暂无法访问")
end)
end


slot:SetChildActive(ListCmpIndex.selectPoint,false)
slot:SetChildActive(ListCmpIndex.selectTick,false)
else

slot:SetChildActive(ListCmpIndex.pointBtn,false)

slot:SetChildActive(ListCmpIndex.visitBtn,false)

local isSelect=self.removeList[i]or false
slot:SetChildActive(ListCmpIndex.selectPoint,not isSelect)
slot:SetChildActive(ListCmpIndex.selectTick,isSelect)
end
end
end
end

function UIFriendListWin:refreshItemGiveStateById(playerId,opType)
local tab=_tabList[self.tabIndex]
local dataList=self[tab.data]
if#dataList==0 then
return
end
local grids=self.listScroller:getChildScrollViewItemWidgets()
for i,v in ipairs(dataList)do
if tostring(v.playerId)==tostring(playerId)then
local slot=grids[i-1]

local strPointState="button_aixin_3"
if v.pointButton==eFriendPointButton.eGive then
strPointState="button_aixin_2"
elseif v.pointButton==eFriendPointButton.ePrize then
strPointState="button_aixin_1"
elseif v.pointButton==eFriendPointButton.eGray then
strPointState="button_aixin_3"
end

slot:SetChildCSImageSprite(ListCmpIndex.pointBtn,globalABLookup.global,strPointState)
break
end
end
end



function UIFriendListWin:onClickList(chickNum,index)
local tab=_tabList[self.tabIndex]
local tabListType=tab.type
local dataList=self[tab.data]
local data=dataList[index+1]






if tabListType~=eFriendListType.eBlack and self.isEditMode then

local listIndex=index+1

local isSelect=not(self.removeList[listIndex]or false)
self.removeList[listIndex]=isSelect


local item=self.listScroller:getChildScrollViewItemWidget(index)
if item then
item:SetChildActive(ListCmpIndex.selectPoint,not isSelect)
item:SetChildActive(ListCmpIndex.selectTick,isSelect)
end


self.selectCount=isSelect and self.selectCount+1 or self.selectCount-1
if self.selectCount<0 then
self.selectCount=0
end
self:refreshCount()
else
otherPlayerController:openOtherPlayerInfoWin(data.actorId)
end

end

function UIFriendListWin:onClickHead(index)
local tab=_tabList[self.tabIndex]
local dataList=self[tab.data]
local data=dataList[index]
otherPlayerController:openOtherPlayerInfoWin(data.actorId)
end


function UIFriendListWin:onClickTab(chickNum,index)
if self.tabIndex==index+1 then
return
end

local grids=self.tabScroller:getChildScrollViewItemWidgets()

local oldSlot=grids[self.tabIndex-1]
if oldSlot then
oldSlot:SetChildActive(TabCmpIndex.select,false)
end

local newSlot=grids[index]
if newSlot then
newSlot:SetChildActive(TabCmpIndex.select,true)
end

self.tabIndex=index+1
self.isEditMode=false

self:updateData()
self:refreshUI()

end


function UIFriendListWin:onClickPointOper(clickNum,index)
local tab=_tabList[self.tabIndex]
local dataList=self[tab.data]
local data=dataList[index+1]

if data.pointButton==eFriendPointButton.eGive then
if not friendModel:isGivePointLimit(true)then
friendProtocolController.req_point_oper(eFriendPointOper.eGiveOne,data.actorId)
end

elseif data.pointButton==eFriendPointButton.ePrize then
if not friendModel:isFriendPointLimit(true)then
friendProtocolController.req_point_oper(eFriendPointOper.ePrizeOne,data.actorId)
end

end
end


function UIFriendListWin:onClickRemoveBlack(clickNum,index)
local tab=_tabList[self.tabIndex]
local dataList=self[tab.data]
local data=dataList[index+1]

friendProtocolController.req_black_list(eFriendBlackOper.eRemove,data.actorId)
end


function UIFriendListWin:onAllPrizeBtn()
if friendModel:isFriendPointLimit(true)then
return
end
if not friendModel:hasGivedFriendPoint(true)then
return
end
friendProtocolController.req_point_oper(eFriendPointOper.ePrizeAll)
end


function UIFriendListWin:onAllGiveBtn()
if friendModel:isGivePointLimit(true)then
return
end
if not friendModel:hasGivedFriend(true)then
return
end
friendProtocolController.req_point_oper(eFriendPointOper.eGiveAll)
end


function UIFriendListWin:onHelpBtn()
local d={}
d.title='仙友规则'
d.mode=3
d.name='friend_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UIFriendListWin:onEditBtn()

self.isEditMode=true
self.removeList={}
self.selectCount=0

self:updateData()
self:refreshUI()
end


function UIFriendListWin:onRemoveBtn()

local tab=_tabList[self.tabIndex]
local dataList=self[tab.data]

if self.selectCount<=0 then
UIManager.error(FMT.fmt("当前并未选择仙友"))
return
else
local removePlayerList={}
for index,v in pairs(self.removeList)do
if v then
local data=dataList[index]
local playerId=data.actorId
table.insert(removePlayerList,playerId)
end
end

friendProtocolController.req_remove_friend(removePlayerList,"是否删除选中的仙友")
end

end


function UIFriendListWin:onExitEditModeBtn()

self.isEditMode=false

self:updateData()
self:refreshUI()
end