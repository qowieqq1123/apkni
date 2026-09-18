







def_class("UIJiuYouTaRank2Win",UIWindowBase)









function UIJiuYouTaRank2Win:bindComponents()

self.back=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.emptyItem=UIText.get(self,2)
self.headBtn=UIButton.get(self,3)
self.helpButton=UIButton.get(self,4)
self.icon=UIObject.get(self,5)
self.itemList=UIObject.get(self,6)
self.name=UIText.get(self,7)
self.rank=UIText.get(self,8)
self.rankbg=UIImage.get(self,9)
self.rankList=UILoopListView.new(self,10)
self.score=UIText.get(self,11)
self.server=UIText.get(self,12)
self.title=UIText.get(self,13)

self.back:setButtonClick(function()self:onBack()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.headBtn:setButtonClick(function()self:onHeadBtn()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.rankList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIJiuYouTaRank2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.emptyItem);self.emptyItem=nil;
_UIObject_release(self.headBtn);self.headBtn=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.rank);self.rank=nil;
_UIObject_release(self.rankbg);self.rankbg=nil;
self.rankList:deleteSelf();self.rankList=nil;
_UIObject_release(self.score);self.score=nil;
_UIObject_release(self.server);self.server=nil;
_UIObject_release(self.title);self.title=nil;
end


















local _this=nil

function UIJiuYouTaRank2Win:onLoaded(...)
self:bindComponents()
self.rankDataList={}
_this=self
JiuYouTaController.req_rank_score_list()

self:addNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
end


function UIJiuYouTaRank2Win:__delete()
self:unbindComponents()
end




function UIJiuYouTaRank2Win:onShow(argtable,afterOnloaded)
self:initRankList()
self:refreshRank()
end


function UIJiuYouTaRank2Win:onHide()

end

function UIJiuYouTaRank2Win.onRankListRefresh(rankType)
if rankType==eRankListType.eJiuYouTaJiFen1 or rankType==eRankListType.eJiuYouTaJiFen2 or rankType==eRankListType.eJiuYouTaJiFen3 then
if _this then
_this:refreshRank()
end
end
end


function UIJiuYouTaRank2Win:initRankList()
local createList={}
local config=cfg_jiuyoutascorerankrwconfig()
for _,v in ipairs(config)do
if v.merge then
table.insert(createList,{rank=FMT.fmt("{0}~{1}",v.rank[1],v.rank[2]),config=v,merge=true})
else
for i=v.rank[1],v.rank[2]do
table.insert(createList,{rank=i,config=v,merge=false})
end
end
end
self.createList=createList
end

function UIJiuYouTaRank2Win:refreshRank()
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local data=rankListModel:getRankList(JiuYouTaModel:getJiuYouTaScoreRankListType(rankType))or{}
self.rankType=rankType
self.rankData=data

local _slotName='item'
self.rankList:initData(_slotName,self.createList)
self.rankList:jumpItem(1)

self:refreshMyRank()
end

function UIJiuYouTaRank2Win:fillItem(widget,index)
local data=self.createList[index]
if not data then return end

local rank=data.rank

widget:SetChildText(0,rank)

if data.merge then
widget:SetChildActive(6,false)

local rankNum=data.config.rank
local playerList={}
local last=math.min(rankNum[2],rankNum[1]+3)
local info
for i=rankNum[1],last do
info=self.rankData[i]
table.insert(playerList,info)
end
local length=#playerList
if length>0 then
widget:SetChildActive(3,false)
widget:SetChildActive(4,true)
widget:SetChildActive(1,true)
widget:SetChildLayoutGroupCreateItems(1,length)
local headGrids=widget:GetChildLayoutGroupGridList(1)
for i=1,headGrids.Count do
local widget_c=headGrids[i-1]
local data=playerList[i]
if widget_c then
playerController:setHeadIcon(widget_c,0,{iconInfo=data.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
widget_c:SetChildButtonClick(1,function()
self:onClickPlayer(data.actorId,data.serverId)
end)
end
end

widget:SetChildText(10,"")
else
widget:SetChildActive(3,true)
widget:SetChildActive(4,false)
widget:SetChildText(10,"")
widget:SetChildActive(1,false)
end

else
local rankIcon
if data.rank<=3 and data.rank>=1 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',data.rank)
end
local showRankIcon=rankIcon~=nil
widget:SetChildActive(12,showRankIcon)
if showRankIcon then
widget:SetChildCSImageSprite(12,globalABLookup.rankList,rankIcon)
end

local player=self.rankData[rank]
if player then
widget:SetChildActive(3,false)
widget:SetChildActive(4,true)

widget:SetChildActive(6,true)
widget:SetChildActive(1,false)

widget:SetChildText(9,player.name)
widget:SetChildActive(8,self.rankType~=1)
if self.rankType~=1 then
widget:SetChildText(8,FMT.fmt("<color=#ca631d>[{0}]</color>",player.zmName))
end

widget:SetChildText(10,mathHelper.int64_to_number(player.zmFight))
widget:SetChildButtonClick(11,function()
self:onClickPlayer(player.actorId,player.serverId)
end)

playerController:setHeadIcon(widget,7,{iconInfo=player.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
else
widget:SetChildActive(3,true)
widget:SetChildActive(4,false)
widget:SetChildText(10,"")
end

end


local rewardList=data.config.rewards[self.rankType]
widget:SetChildLayoutGroupCreateItems(2,#rewardList)
local headGrids=widget:GetChildLayoutGroupGridList(2)
for i=1,headGrids.Count do
local widget=headGrids[i-1]
local reward=rewardList[i]
if widget then
local countStr=reward[2]>1 and reward[2]or''
local conf={itemid=reward[1],itemcount=countStr,showCountBG=reward[2]>1,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end
end
end

function UIJiuYouTaRank2Win:onClickPlayer(actorId,server)
local attach={
type=otherPlayerController.eAttachType.Rank,
serverid=server,
isXianJie=self.rankType==3,
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end

function UIJiuYouTaRank2Win:refreshMyRank()
local playerId=playerModel:getActorID()
local data={rank=0,sec=0,name=playerModel:getActorName(),serverId=playerModel:getActorServerID(),actorId=playerId}

for i,v in ipairs(self.rankData)do
if mathHelper.compareInt64(playerId,v.actorId)then
data=v
break
end
end

self.rank:setText(data.rank==0 and"未上榜"or data.rank)
local rankIcon
if data.rank<=3 and data.rank>=1 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',data.rank)
end
local showRankIcon=rankIcon~=nil
self.rankbg:setActive(showRankIcon)
if showRankIcon then
self.rankbg:setCSImageSprite(globalABLookup.rankList,rankIcon)
end

self.server:setActive(self.rankType~=1)
if self.rankType~=1 then
local serverName=loginModel:getServerName(data.serverId)
self.server:setText(FMT.fmt("<color=#ca631d>[{0}]</color>",serverName))
end

self.name:setText(data.name)

local rewardLayer
local config=cfg_jiuyoutascorerankrwconfig()
for _,v in ipairs(config)do
if data.rank>=v.rank[1]and data.rank<=v.rank[2]then
rewardLayer=v.rewards
break
end
end

if rewardLayer then
local rewardList=rewardLayer[self.rankType]
self.itemList:setChildLayoutGroupCreateItems(#rewardList)
local headGrids=self.itemList:getChildLayoutGroupGridList()
for i=1,headGrids.Count do
local widget=headGrids[i-1]
local reward=rewardList[i]
if widget then
local countStr=reward[2]>1 and reward[2]or''
local conf={itemid=reward[1],itemcount=countStr,showCountBG=reward[2]>1,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end
end

self.emptyItem:setActive(false)
else
self.emptyItem:setActive(true)
end

playerController:setHeadIcon(self.winlua,self.icon:getID(),{iconInfo=data.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})

self.score:setText(JiuYouTaModel:getAllScore())
end




function UIJiuYouTaRank2Win:onBack()
UIManager:closeWindow("UIJiuYouTaRankTpyeWin")
end

function UIJiuYouTaRank2Win:onCloseBtn()
UIManager:closeWindow("UIJiuYouTaRankTpyeWin")
end



function UIJiuYouTaRank2Win:onHeadBtn()
end



function UIJiuYouTaRank2Win:onHelpButton()
local d={}
d.title='提示'
d.mode=3
d.name='jiuyouta_rank_help_%d'
self:showWindow('UIRuleWin',d)
end

function UIJiuYouTaRank2Win:onFreshAction(i,grid)
self:fillItem(grid,i)
end

function UIJiuYouTaRank2Win:onStartAction(i,grid)

end