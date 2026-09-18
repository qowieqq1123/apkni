







def_class("UIXianMengRequireWin",UIWindowBase)









function UIXianMengRequireWin:bindComponents()

self.actorListPanel=UIObject.get(self,0)



end


function UIXianMengRequireWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actorListPanel);self.actorListPanel=nil;
end

















function UIXianMengRequireWin:onLoaded(...)
self:bindComponents()
end


function UIXianMengRequireWin:__delete()
self:unbindComponents()
end


function UIXianMengRequireWin:onHide()

end




function UIXianMengRequireWin:onShow(argtable,afterOnloaded)
if self.actorDataList==nil then
self.actorDataList=xianmengModel:getApplicationList()
self:refreshView()
end
end

function UIXianMengRequireWin:refreshView()
local c=#self.actorDataList
self.actorListPanel:setChildScrollViewCreateGrids(c,1)

local grids=self.actorListPanel:getChildScrollViewItemWidgets()
for i=1,c do
self:refreshXMItem(grids[i-1],i)
end
end

function UIXianMengRequireWin:refreshXMItem(item,index)
if item==nil then
item=self.actorListPanel:getChildScrollViewItemWidget(index-1)
end

local actorData=self.actorDataList[index]


item:SetChildText(1,actorData.actorname)

item:SetChildText(2,tostring(actorData.actorlevel))

local fightnum=tonumber(tostring(actorData.actorfight))
item:SetChildText(3,fightnum)

item:SetChildButtonClick(0,function()
self:onItemClick(index)
end)
item:SetChildButtonClick(4,function()
self:onCommitClick(index)
end)
item:SetChildButtonClick(5,function()
self:onCancelClick(index)
end)
end

function UIXianMengRequireWin:onItemClick(index)
local actorData=self.actorDataList[index]
otherPlayerController:openOtherPlayerInfoWin(actorData.actorid)
end

function UIXianMengRequireWin:onCommitClick(index)
local actorData=self.actorDataList[index]

xianmengController:reqHandelXMRequir(actorData.actorid,1)
end

function UIXianMengRequireWin:onCancelClick(index)
local actorData=self.actorDataList[index]

xianmengController:reqHandelXMRequir(actorData.actorid,-1)
end

function UIXianMengRequireWin:onAllCommitBtn()
if#self.actorDataList>0 then
xianmengController:reqHandelXMRequir(int64.new('0'),1)
self:closeSelf()
end
end

function UIXianMengRequireWin:onAllCancelBtn()
if#self.actorDataList>0 then
xianmengController:reqHandelXMRequir(int64.new('0'),-1)
self:closeSelf()
end
end

function UIXianMengRequireWin:rec_refresh()
self.actorDataList=xianmengModel:getApplicationList()
self:refreshView()
end