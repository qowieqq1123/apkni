







def_class("UIJiuYouTaRankWin",UIWindowBase)









function UIJiuYouTaRankWin:bindComponents()

self.back=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.emptyItem=UIText.get(self,2)
self.headBtn=UIButton.get(self,3)
self.icon=UIObject.get(self,4)
self.itemList=UIObject.get(self,5)
self.layer=UIText.get(self,6)
self.name=UIText.get(self,7)
self.rankList=UILoopListView.new(self,8)
self.title=UIText.get(self,9)

self.back:setButtonClick(function()self:onBack()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.headBtn:setButtonClick(function()self:onHeadBtn()end)

self.rankList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIJiuYouTaRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.emptyItem);self.emptyItem=nil;
_UIObject_release(self.headBtn);self.headBtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.name);self.name=nil;
self.rankList:deleteSelf();self.rankList=nil;
_UIObject_release(self.title);self.title=nil;
end


















local _this=nil
local title={"赛季奖励","赛季奖励","赛季奖励"}

function UIJiuYouTaRankWin:onLoaded(...)
self:bindComponents()
self.rankDataList={}
JiuYouTaController.req_rank_list()
_this=self
self:addNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
end


function UIJiuYouTaRankWin:__delete()
self:unbindComponents()
_this=nil
end




function UIJiuYouTaRankWin:onShow(argtable,afterOnloaded)
self:initRankList()
self:refreshRank()
end


function UIJiuYouTaRankWin:onHide()

end

function UIJiuYouTaRankWin.onRankListRefresh(rankType)
if rankType==eRankListType.eJiuYouTa1 or rankType==eRankListType.eJiuYouTa2 or rankType==eRankListType.eJiuYouTa3 then
if _this then
_this:refreshRank()
end
end
end

function UIJiuYouTaRankWin:initRankList()
local createList={}
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
self.rankType=rankType
local config=JiuYouTaModel:getRankConfig(rankType)
for i,v in ipairs(config)do
if v.rank_reward then
table.insert(createList,{layer=v.layer_id,cfg=v,})
end
end

table.sort(createList,function(a,b)
return a.layer>b.layer
end)

self.createList=createList

self.title:setText(title[rankType])
end

function UIJiuYouTaRankWin:refreshRank()
local createList=self.createList

local rankDataList=rankListModel:getRankList(JiuYouTaModel:getJiuYouTaRankListType(self.rankType))or{}

local layerRankList={}
local createLength=#self.createList
local layer
for i,v in ipairs(rankDataList)do
layer=mathHelper.int64_to_number(v.zmFight)
v.layer=layer
for ii=1,createLength,1 do
local cfg_item=self.createList[ii]
if layer>=cfg_item.layer then
layerRankList[cfg_item.layer]=layerRankList[cfg_item.layer]or{}
table.insert(layerRankList[cfg_item.layer],v)
break
end
end
end
self.allRankList=rankDataList
self.rankDataList=layerRankList



self.rankList:initData('item',createList)

self:refreshMyRank()
end

function UIJiuYouTaRankWin:onFreshAction(i,grid)
local info=self.createList[i]
local cfg=info.cfg
local layer=info.layer

grid:SetChildText(0,FMT.fmt("通关{0}层",layer))
local rewardList=cfg.rank_reward
grid:SetChildLayoutGroupCreateItems(2,#rewardList)
local headGrids=grid:GetChildLayoutGroupGridList(2)
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


local dataList=self.rankDataList[layer]

if dataList and next(dataList)then

grid:SetChildActive(3,false)
grid:SetChildActive(4,true)

local length=math.min(#dataList,4)
grid:SetChildLayoutGroupCreateItems(1,length)
local headGrids=grid:GetChildLayoutGroupGridList(1)
for i=1,headGrids.Count do
local widget=headGrids[i-1]
local data=dataList[i]
if widget then
if i<4 then
widget:SetChildActive(0,true)
widget:SetChildActive(2,false)
playerController:setHeadIcon(widget,0,{iconInfo=data.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
else
widget:SetChildActive(0,false)
widget:SetChildActive(2,true)
end
end
end


grid:SetChildButtonClick(5,function()
self:showWindow("UIJiuYouTaRankPlayerWin",dataList)
end)
else
grid:SetChildActive(3,true)
grid:SetChildActive(4,false)
end
end

function UIJiuYouTaRankWin:onStartAction(i,grid)

end

function UIJiuYouTaRankWin:refreshMyRank()
local playerId=playerModel:getActorID()
local data={rank=0,sec=0,name=playerModel:getActorName(),serverId=playerModel:getActorServerID(),actorId=playerId}

for i,v in ipairs(self.allRankList)do
if mathHelper.compareInt64(playerId,v.actorId)then
data=v
break
end
end


local clearLayer=JiuYouTaModel:getClearLayer()
self.layer:setText(FMT.fmt("通关{0}层",clearLayer))

local serverName=loginModel:getServerName(data.serverId)
self.name:setText(FMT.fmt("<color=#ca631d>[{0}]</color>\n{1}",serverName,data.name))

local rewardLayer
local createLength=#self.createList
for ii=1,createLength,1 do
local cfg_item=self.createList[ii]
if clearLayer>=cfg_item.layer then
rewardLayer=cfg_item.layer
break
end
end
if rewardLayer then
local config=JiuYouTaModel:getRankConfig(self.rankType)
local cfg=config[rewardLayer]
local rewardList=cfg.rank_reward
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
end

function UIJiuYouTaRankWin:onClickPlayer(actorId)
local attach={
type=otherPlayerController.eAttachType.Rank,

}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end




function UIJiuYouTaRankWin:onBack()
UIManager:closeWindow("UIJiuYouTaRankTpyeWin")
end

function UIJiuYouTaRankWin:onCloseBtn()
UIManager:closeWindow("UIJiuYouTaRankTpyeWin")
end


function UIJiuYouTaRankWin:onHeadBtn()
local playerId=playerModel:getActorID()
self:onClickPlayer(playerId)
end
