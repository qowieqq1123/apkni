







def_class("UISubAct_KuaFuLieBiaoWin",UIWindowBase)









function UISubAct_KuaFuLieBiaoWin:bindComponents()

self.root=UIObject.get(self,0)
self.ScrollView=UIObject.get(self,1)



end


function UISubAct_KuaFuLieBiaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end





















local listRoot={{29.7,-11.92},{246,-60},{427,17},
{-548,-313},{-259.9,-331},
{-1289.7,-623},{-1065,-589},{-891,-674},
{-1825,-895.3},[0]={-1675,-927},}

function UISubAct_KuaFuLieBiaoWin:onLoaded(...)
self:bindComponents()

self:addNotify(notifyConfig.serverZoneFresh,function()
if self and not self.isClose then
local serverList=xianmengModel:getDaQianShiJieData()
self:refreshList(serverList)
end
end)
end


function UISubAct_KuaFuLieBiaoWin:__delete()
self:unbindComponents()
end




function UISubAct_KuaFuLieBiaoWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
local t=self.root:setChildCanvasGroupDOFade(1,0.5)


local serverList=xianmengModel:getDaQianShiJieData()
if not serverList then
xianmengController.req_254_85()
else
self:refreshList(serverList)
end
end

function UISubAct_KuaFuLieBiaoWin:refreshList(serverList)
serverList=serverList or{}


local allServerList=table.deepCopy(loginModel:getServerList())

local serverId=playerModel:getActorServerID()

table.sort(allServerList,function(a,b)
local sortA=a==serverId and 1 or 0
local sortB=b==serverId and 1 or 0
return sortA>sortB end)

local col=10
self.ScrollView:setChildScrollViewCreateGrids(#allServerList,col)
local grids=self.ScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
local myServer=playerModel:getActorServerID()
for i=1,count do
local grid=grids[i-1]
local sId=allServerList[i]
local serverData=serverList[sId]
if serverData then

local actorname=serverData.actorname
grid:SetChildText(1,actorname)
grid:SetChildActive(2,true)
grid:SetChildActive(6,false)
playerController:setImage(grid,2,nil,serverData.iconInfo)
grid:SetChildButtonClick(7,function()

local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=eRankListType.eDouFaTai,
serverid=serverData.serverid,
}
otherPlayerController:openOtherPlayerInfoWin(serverData.actorid,true,nil,attach)
end)
else
grid:SetChildActive(2,false)
grid:SetChildText(1,"虚位以待")
grid:SetChildActive(6,true)
end
local serverName=loginModel:getServerName(sId)
grid:SetChildText(0,serverName)

grid:SetChildActive(5,myServer==sId)








grid:SetChildAnchoredPos(4,listRoot[i%col][1],listRoot[i%col][2])
end
end


function UISubAct_KuaFuLieBiaoWin:onHide()

end



