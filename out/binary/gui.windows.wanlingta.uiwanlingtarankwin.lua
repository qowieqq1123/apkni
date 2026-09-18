







def_class("UIWanLingTaRankWin",UIWindowBase)









function UIWanLingTaRankWin:bindComponents()

self.back=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.headBtn=UIButton.get(self,2)
self.icon=UIObject.get(self,3)
self.levelExp=UIText.get(self,4)
self.name=UIText.get(self,5)
self.progress=UIObject.get(self,6)
self.rank=UIText.get(self,7)
self.rankbg=UIImage.get(self,8)
self.rankList=UILoopListView.new(self,9)
self.server=UIText.get(self,10)
self.title=UIText.get(self,11)

self.back:setButtonClick(function()self:onBack()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.headBtn:setButtonClick(function()self:onHeadBtn()end)

self.rankList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIWanLingTaRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.headBtn);self.headBtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.levelExp);self.levelExp=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rank);self.rank=nil;
_UIObject_release(self.rankbg);self.rankbg=nil;
self.rankList:deleteSelf();self.rankList=nil;
_UIObject_release(self.server);self.server=nil;
_UIObject_release(self.title);self.title=nil;
end


















local this

function UIWanLingTaRankWin:onLoaded(...)
self:bindComponents()
this=self
rankListController:req_rankList_data(eRankListType.eWanLingTaRank,true)
self:addNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
self.maxLevel=#cfg_xumitatllevelconfig()
end


function UIWanLingTaRankWin:__delete()
self:unbindComponents()
this=nil
end




function UIWanLingTaRankWin:onShow(argtable,afterOnloaded)
self.rankType=eRankListType.eWanLingTaRank

end

function UIWanLingTaRankWin.onRankListRefresh(rankType)
if rankType==eRankListType.eWanLingTaRank then
if this then
this:refreshRank()
end
end
end

function UIWanLingTaRankWin:refreshRank()
local data=rankListModel:getRankList(self.rankType)
self.rankData=data
local showNum=cfgHelper.get2(cfg_rankbasicconfig_get,1,"showNum")
local count=showNum[self.rankType]or showNum[0]
local createList={}
for i=1,count do
table.insert(createList,i)
end
local _slotName='item'
self.rankList:initData(_slotName,createList)
self.rankList:jumpItem(1)

self:refreshMyRank()
end

function UIWanLingTaRankWin:onFreshAction(i,grid)
self:fillItem(grid,i)
end

function UIWanLingTaRankWin:onStartAction(i,grid)

end

function UIWanLingTaRankWin:fillItem(widget,index)
local rankData=self.rankData[index]
if not rankData then
rankData=defaultT
end

local showRankImage=1<=index and index<=3
widget:SetChildActive(0,showRankImage)
if showRankImage then
widget:SetChildCSImageSprite(0,globalABLookup.global,'icon_phbmingci_'..index)
end
widget:SetChildText(1,index)
widget:SetChildText(2,rankData.playerName or"")
local serverName=rankData.server and string.format("[%s]",loginModel:getServerName(rankData.server))or""
widget:SetChildText(3,serverName)

if rankData.actorId then
playerController:setHeadIcon(widget,4,{iconInfo=rankData.head,scale=HEAD_SCALE_TYPE.e60x60})
widget:SetChildButtonClick(5,function()
self:onClickPlayer(rankData.actorId,rankData.server)
end)

local level=rankData.lv
local cur=rankData.exp
local max=wanLingTaModel:getTaLingNeedExp(level+1)
if level>=self.maxLevel then
widget:SetChildIconFillAmount(6,1)
widget:SetChildText(7,string.format("%d级（%d）",level,cur))
else
local percent=mathHelper.floor((cur/max)*100)
widget:SetChildIconFillAmount(6,cur/max)
widget:SetChildText(7,string.format("%d级（%d%%）",level,percent))
end

widget:SetChildActive(8,false)
else
playerController:setHeadIcon(widget,4,nil)
widget:SetChildButtonClick(5,nil)
widget:SetChildIconFillAmount(6,0)
widget:SetChildText(7,"0级（0%）")
widget:SetChildActive(8,true)
end
end

function UIWanLingTaRankWin:onClickPlayer(actorId,server)
local attach={
type=otherPlayerController.eAttachType.Rank,
serverid=server,
}
otherPlayerController:openOtherPlayerInfoWin(actorId,nil,nil,attach)
end

function UIWanLingTaRankWin:refreshMyRank()
local playerId=playerModel:getActorID()
local rankData={rankNum=0,playerName=playerModel:getActorName(),server=playerModel:getActorServerID(),actorId=playerId,lv=0,exp=0}

for i,v in ipairs(self.rankData)do
if mathHelper.compareInt64(playerId,v.actorId)then
rankData=v
break
end
end

local showRankImage=1<=rankData.rankNum and rankData.rankNum<=3
self.rankbg:setActive(showRankImage)
if showRankImage then
self.rankbg:setSprite(globalABLookup.global,'icon_phbmingci_'..rankData.rankNum)
end
self.rank:setText(rankData.rankNum==0 and"未上榜"or rankData.rankNum)
self.name:setText(rankData.playerName or"")
local serverName=rankData.server and string.format("[%s]",loginModel:getServerName(rankData.server))or""
self.server:setText(serverName)

playerController:setHeadIcon(self.winlua,self.icon:getID(),{iconInfo=rankData.head,scale=HEAD_SCALE_TYPE.e60x60})

local level=rankData.lv
local cur=rankData.exp
local max=wanLingTaModel:getTaLingNeedExp(level+1)
if level>=self.maxLevel then
self.progress:setChildIconFillAmount(1)
self.levelExp:setText(string.format("%d级（%d）",level,cur))
else
local percent=mathHelper.floor((cur/max)*100)
self.progress:setChildIconFillAmount(cur/max)
self.levelExp:setText(string.format("%d级（%d%%）",level,percent))
end
end


function UIWanLingTaRankWin:onBack()
self:closeSelf()
end

function UIWanLingTaRankWin:onCloseBtn()
self:closeSelf()
end

function UIWanLingTaRankWin:onHeadBtn()

end

