







def_class("UIJiuYouTaRankPlayerWin",UIWindowBase)









function UIJiuYouTaRankPlayerWin:bindComponents()

self.back=UIButton.get(self,0)
self.rankList=UILoopListView.new(self,1)

self.back:setButtonClick(function()self:onBack()end)

self.rankList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIJiuYouTaRankPlayerWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
self.rankList:deleteSelf();self.rankList=nil;
end



















function UIJiuYouTaRankPlayerWin:onLoaded(...)
self:bindComponents()
end


function UIJiuYouTaRankPlayerWin:__delete()
self:unbindComponents()
end




function UIJiuYouTaRankPlayerWin:onShow(argtable,afterOnloaded)
local dataList=argtable
self.dataList=dataList
self.rankList:initData('item',dataList)
end


function UIJiuYouTaRankPlayerWin:onHide()

end

function UIJiuYouTaRankPlayerWin:onStartAction()

end

function UIJiuYouTaRankPlayerWin:onFreshAction(i,grid)

local data=self.dataList[i]
local widget=grid:GetChildWidgetBase(1)
playerController:setHeadIcon(widget,0,{iconInfo=data.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
widget:SetChildButtonClick(1,function()
self:onClickPlayer(data.actorId,data.serverId)
end)

grid:SetChildText(0,data.name)
grid:SetChildText(2,data.zmName)
end

function UIJiuYouTaRankPlayerWin:onClickPlayer(actorId,server)
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local attach={
type=otherPlayerController.eAttachType.Rank,
serverid=server,
isXianJie=rankType==3,
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end




function UIJiuYouTaRankPlayerWin:onBack()
self:closeSelf()
end

