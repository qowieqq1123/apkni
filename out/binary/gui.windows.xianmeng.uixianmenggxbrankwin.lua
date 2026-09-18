







def_class("UIXianMengGXBRankWin",UIWindowBase)









function UIXianMengGXBRankWin:bindComponents()

self.no_1=UIObject.get(self,0)
self.no_2=UIObject.get(self,1)
self.no_3=UIObject.get(self,2)
self.ownerNo=UIText.get(self,3)
self.ownerIcon=UIImage.get(self,4)
self.ownerNum=UIText.get(self,5)
self.ownerName=UIText.get(self,6)
self.rankList=UIObject.get(self,7)
self.ownerHead=UIObject.get(self,8)
self.no={
self.no_1,
self.no_2,
self.no_3,
}



end


function UIXianMengGXBRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.no_1);self.no_1=nil;
_UIObject_release(self.no_2);self.no_2=nil;
_UIObject_release(self.no_3);self.no_3=nil;
_UIObject_release(self.ownerNo);self.ownerNo=nil;
_UIObject_release(self.ownerIcon);self.ownerIcon=nil;
_UIObject_release(self.ownerNum);self.ownerNum=nil;
_UIObject_release(self.ownerName);self.ownerName=nil;
_UIObject_release(self.rankList);self.rankList=nil;
_UIObject_release(self.ownerHead);self.ownerHead=nil;
self.no=nil;
end
















local _this=nil
local _topCmp={
headBg=0,
head=1,
name=2,
icon=3,
num=4,
no=5,
numRoot=6,
none=7,
}
local _itemCmp={
headBg=0,
head=1,
name=2,
icon=3,
num=4,
no=5,
none=6,
noneTx=7,
}



function UIXianMengGXBRankWin:onLoaded(...)
self:bindComponents()
_this=self

xianmengController.req_protocol_20_35()

end


function UIXianMengGXBRankWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianMengGXBRankWin:onShow(argtable,afterOnloaded)

end


function UIXianMengGXBRankWin:onHide()

end



function UIXianMengGXBRankWin:refreshView()
self.dataList=xianmengModel:getGXRankList()

local topCnt=#self.no
for i=1,topCnt do
local widget=self.no[i]:getChildWidgetBase()
widget:SetChildButtonClick(_topCmp.headBg,function()
self:onClickHead(i)
end)
self:refreshTop(widget,self.dataList[i])
end

local cnt=math.max(#self.dataList-topCnt,7)
self.rankList:setChildLayoutGroupCreateItems(cnt,function(index)
local item=self.rankList:getChildLayoutGroupGridItem(index-1)
local no=index+topCnt
local data=self.dataList[no]
item:SetChildButtonClick(_itemCmp.headBg,function()
self:onClickHead(no)
end)
self:refreshListItem(item,data,no)
end)

local no=xianmengModel:getGXRankNo()
self.ownerNo:setText(no<=0 and"未上榜"or no)
local num=xianmengModel:getGXBValue()or 0
self.ownerNum:setText(tostring(num))
local iconInfo=playerModel:getActorIconInfo()
playerController:setHeadIcon(self.winlua,self.ownerHead:getID(),{iconInfo=iconInfo})
self.ownerName:setText(playerModel:getActorName())
end

function UIXianMengGXBRankWin:refreshTop(item,data)
if data then


playerController:setImage(item,_topCmp.head,nil,data.iconInfo,false)

item:SetChildText(_topCmp.name,data.name)
item:SetChildText(_topCmp.num,mathHelper.formatNumber(data.week_score,true))
item:SetChildActive(_topCmp.none,false)
item:SetChildActive(_topCmp.numRoot,true)
item:ForceLayoutRect(_topCmp.numRoot)
else

item:SetChildUIModelRemoveTarget(_topCmp.head)

item:SetChildText(_topCmp.name,"虚位以待")
item:SetChildText(_topCmp.num,"")
item:SetChildActive(_topCmp.numRoot,false)
item:SetChildActive(_topCmp.none,true)
end

end

function UIXianMengGXBRankWin:refreshListItem(item,data,no)
item:SetChildText(_itemCmp.no,no)
if data then
playerController:setHeadIcon(item,_itemCmp.head,{iconInfo=data.iconInfo})
item:SetChildText(_itemCmp.name,data.name)
item:SetChildText(_itemCmp.num,data.week_score)
item:SetChildActive(_itemCmp.none,false)
item:SetChildActive(_itemCmp.noneTx,false)
item:SetChildActive(_itemCmp.name,true)
item:SetChildActive(_itemCmp.num,true)
item:SetChildActive(_itemCmp.icon,true)
else
playerController:setHeadIcon(item,_itemCmp.head,nil)
item:SetChildActive(_itemCmp.none,true)
item:SetChildActive(_itemCmp.noneTx,true)
item:SetChildActive(_itemCmp.name,false)
item:SetChildActive(_itemCmp.num,false)
item:SetChildActive(_itemCmp.icon,false)
end
end

function UIXianMengGXBRankWin:onClickHead(index)
local data=self.dataList[index]
if data then
local myActorid=playerModel:getActorID()
if not mathHelper.compareInt64(myActorid,data.actor_id)then
otherPlayerController:openOtherPlayerInfoWin(data.actor_id,nil,actorInterFromType.eXianMeng)
end
end
end