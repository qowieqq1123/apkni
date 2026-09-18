







def_class("UIAquariumLYRankWin",UIWindowBase)









function UIAquariumLYRankWin:bindComponents()

self.scrollView=UIObject.get(self,0)
self.myInfo=UIObject.get(self,1)



end


function UIAquariumLYRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.myInfo);self.myInfo=nil;
end



















function UIAquariumLYRankWin:onLoaded(...)
self:bindComponents()

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIAquariumLYRankWin:__delete()
self:unbindComponents()
end




function UIAquariumLYRankWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIAquariumLYRankWin:onHide()

end

function UIAquariumLYRankWin:refresh()
local myRank=UIAquariumControl:getMyRank()
self.rankDatas=UIAquariumControl:getRankList()
local len=#self.rankDatas
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,i)
local data=self.rankDatas[i]
playerController:setHeadIcon(item,1,{scale=0.6,iconInfo=data.iconInfo})
local sname=loginModel:getServerName(data.serverId)
item:SetChildText(2,FMT.fmt('[{0}]{1}',sname,data.name))
item:SetChildText(3,FMT.fmt('灵韵：{0}',data.lingyun))
item:SetChildActive(4,i~=myRank)
item:SetChildButtonClick(4,function()
UIAquariumControl:reqActorInfo(data.serverId,data.actorId)
self:onCloseClick()
end)
item:SetChildActive(5,i==myRank)
item:SetChildActive(6,i==1)
item:SetChildActive(7,i==2)
item:SetChildActive(8,i==3)
end

self:setMyInfo()
end

function UIAquariumLYRankWin:setMyInfo()
local myRank=UIAquariumControl:getMyRank()
local isInList=myRank>0 and myRank<=#self.rankDatas
local widget=self.myInfo:getChildWidgetBase()
widget:SetChildText(0,isInList and myRank or'未上榜')
playerController:setHeadIcon(widget,1,{scale=0.6,iconInfo=nil})
local sname=loginModel:getMyServerName()
widget:SetChildText(2,FMT.fmt('[{0}]{1}',sname,playerModel:getActorName()))
if isInList then
local data=self.rankDatas[myRank]
widget:SetChildText(3,FMT.fmt('灵韵：{0}',data.lingyun))
else
local lingyun=UIAquariumControl:countTotalLingyun()
widget:SetChildText(3,FMT.fmt('灵韵：{0}',lingyun))
end
widget:SetChildActive(5,true)
widget:SetChildActive(6,myRank==1)
widget:SetChildActive(7,myRank==2)
widget:SetChildActive(8,myRank==3)
end




function UIAquariumLYRankWin:onCloseClick()
self:closeSelf()
end