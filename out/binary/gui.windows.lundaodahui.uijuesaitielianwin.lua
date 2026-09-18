







def_class("UIJueSaiTieLianWin",UIWindowBase)









function UIJueSaiTieLianWin:bindComponents()

self.model=UIObject.get(self,0)
self.name=UIImage.get(self,1)
self.watchText=UIText.get(self,2)
self.iconHeadItem1=UIObject.get(self,3)
self.iconHeadItem2=UIObject.get(self,4)
self.watchButton=UIButton.get(self,5)
self.time=UIText.get(self,6)

self.watchButton:setButtonClick(function()self:onWatchButton()end)



end


function UIJueSaiTieLianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.watchText);self.watchText=nil;
_UIObject_release(self.iconHeadItem1);self.iconHeadItem1=nil;
_UIObject_release(self.iconHeadItem2);self.iconHeadItem2=nil;
_UIObject_release(self.watchButton);self.watchButton=nil;
_UIObject_release(self.time);self.time=nil;
end


















local abName='ui/windows/lundaodahui/lundaodahuiyugao_atlas_pak.ab'

function UIJueSaiTieLianWin:onLoaded(...)
self:bindComponents()
self.model:setChildUIModelShowTarget(4119,1,{},eAnimationID.enter,false,nil,0)
end


function UIJueSaiTieLianWin:__delete()
self:unbindComponents()
end




function UIJueSaiTieLianWin:onShow(argtable,afterOnloaded)
local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]-1
self:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,sortOrder=sortOrder})
local match1=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)

local match2=lundaodahuiModel:getMatchTime(eLDMatchType.juesai)

local nowTime=timeHelper.getServerLongTime()
local matchName='image_saijiygbt_2'
if(nowTime>=match1-600 and nowTime<match1)then
self.matchType=eLDMatchType.jijunsai
self.group=lundaodahuiModel:getTTSGroupInfo(24)
self.time:setText(timeHelper.dateServerStamp('%H点%M分进行对决',match1))
elseif(nowTime>=match2-600 and nowTime<match2)then
self.matchType=eLDMatchType.juesai
self.group=lundaodahuiModel:getTTSGroupInfo(32)
self.time:setText(timeHelper.dateServerStamp('%H点%M分进行对决',match2))
matchName='image_saijiygbt_1'
elseif(nowTime>=match1 and nowTime<=match1+120)then
self.matchType=eLDMatchType.jijunsai
self.group=lundaodahuiModel:getTTSGroupInfo(24)
self.watchText:setText("对决开始！")
self.watchText:setChildAnchoredPosition(Vector2.New(10,152))
elseif(nowTime>=match2 and nowTime<=match2+120)then
self.matchType=eLDMatchType.juesai
self.group=lundaodahuiModel:getTTSGroupInfo(32)
matchName='image_saijiygbt_1'
self.watchText:setText("对决开始！")
self.watchText:setChildAnchoredPosition(Vector2.New(10,152))
end

self:refreshHead()
self.name:setCSImageSprite(abName,matchName)
end

function UIJueSaiTieLianWin:refreshHead()
local group=self.group
local dzInfo=group
local listLen=dzInfo and dzInfo.listLen or 0
local dzPlayer1,dzPlayer2

local widget1=self.iconHeadItem1:getChildWidgetBase()
local widget2=self.iconHeadItem2:getChildWidgetBase()

if listLen==1 then
dzPlayer1=dzInfo.dzPalyerList[1]
elseif listLen==2 then
dzPlayer1=dzInfo.dzPalyerList[1]
dzPlayer2=dzInfo.dzPalyerList[2]
end

if dzPlayer1 then
local serverName=loginModel:getServerName(dzPlayer1.serverId)
widget1:SetChildText(0,dzPlayer1.name)
widget1:SetChildText(3,FMT.fmt("{0}",serverName))
self:refreshPlayer(dzPlayer1,widget1)

widget1:SetChildActive(2,false)
widget1:SetChildActive(4,true)
else

widget1:SetChildActive(2,true)
widget1:SetChildActive(4,false)
end

if dzPlayer2 then
local serverName=loginModel:getServerName(dzPlayer2.serverId)
widget2:SetChildText(0,dzPlayer2.name)
widget2:SetChildText(3,FMT.fmt("{0}",serverName))
self:refreshPlayer(dzPlayer2,widget2)

widget2:SetChildActive(2,false)
widget2:SetChildActive(4,true)
else

widget2:SetChildActive(4,false)
widget2:SetChildActive(2,true)

end
end

function UIJueSaiTieLianWin:refreshPlayer(dzPlayer,widget)
local headWiget=widget:GetChildWidgetBase(1)
playerController:setHeadIcon(headWiget,-1,{scale=0.8,iconInfo=dzPlayer.iconInfo})
widget:SetChildButtonClick(1,function()



UIFullLunDaoDaHuiControl:showLookRivalWinNew(dzPlayer.playerId,{dzPlayer.serverId,dzPlayer.iconInfo,dzPlayer.name},true)
end)
end


function UIJueSaiTieLianWin:onHide()

end





function UIJueSaiTieLianWin:onFightFlag()
end



function UIJueSaiTieLianWin:onWatchButton()
if self.matchType==eLDMatchType.juesai then
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=3,subPage=2})
else
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=3,subPage=1})
end
end

