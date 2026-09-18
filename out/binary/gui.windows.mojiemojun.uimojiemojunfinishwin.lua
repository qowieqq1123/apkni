







def_class("UIMoJieMoJunFinishWin",UIWindowBase)









function UIMoJieMoJunFinishWin:bindComponents()

self.background=UIButton.get(self,0)
self.effect=UIObject.get(self,1)
self.head=UIObject.get(self,2)
self.headBG=UIButton.get(self,3)
self.headEmpty=UIObject.get(self,4)
self.playerName=UIText.get(self,5)
self.root=UIObject.get(self,6)
self.serverName=UIText.get(self,7)
self.spine=UIObject.get(self,8)
self.xmBGIcon=UIImage.get(self,9)
self.xmClick=UIButton.get(self,10)
self.xmEmpty=UIObject.get(self,11)
self.xmIcon=UIImage.get(self,12)
self.xmKuangIcon=UIImage.get(self,13)
self.xmName=UIText.get(self,14)
self.xmServerName=UIText.get(self,15)

self.background:setButtonClick(function()self:onBackground()end)

self.headBG:setButtonClick(function()self:onHeadBG()end)

self.xmClick:setButtonClick(function()self:onXmClick()end)



end


function UIMoJieMoJunFinishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headBG);self.headBG=nil;
_UIObject_release(self.headEmpty);self.headEmpty=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.serverName);self.serverName=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.xmBGIcon);self.xmBGIcon=nil;
_UIObject_release(self.xmClick);self.xmClick=nil;
_UIObject_release(self.xmEmpty);self.xmEmpty=nil;
_UIObject_release(self.xmIcon);self.xmIcon=nil;
_UIObject_release(self.xmKuangIcon);self.xmKuangIcon=nil;
_UIObject_release(self.xmName);self.xmName=nil;
_UIObject_release(self.xmServerName);self.xmServerName=nil;
end



















function UIMoJieMoJunFinishWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieMoJunFinishWin:__delete()
self:unbindComponents()
end




function UIMoJieMoJunFinishWin:onShow(argtable,afterOnloaded)
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex

self.killData=xianjieModel:getMoJunKillDatas(self.seasonType,self.stageIndex)
if not self.killData then
xianjieController:reqMoJunFinishData(self.seasonType,self.stageIndex)
else
self:refreshInfo()
end

local params=seasonModel:getStageConfigEx(argtable.seasonType,argtable.stageIndex,"finishWinParam")

self.root:setChildCanvasGroupAlpha(0)
self.spine:setChildUIModelShowTarget(params[1],1,defaultT,eAnimationID.enter,false,false,0)
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
self.effect:setChildShowEffect(params[2],true)
end)
xianjieModel:setMoJunFinishFlag(self.seasonType,self.stageIndex)
xianjieController:reqMoJunSetFinishTip(self.seasonType,self.stageIndex)

if not xianjieModel:checkMoJunDeadPlot(self.seasonType,self.stageIndex)then
local plots=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"plots")
if plots[2]then
xianjieModel:setMoJunDeadPlot(self.seasonType,self.stageIndex)
worldStoryController:showStoryTree(plots[2],nil,nil,nil,{isFullOpen=false})
end
end
end


function UIMoJieMoJunFinishWin:onHide()

end

function UIMoJieMoJunFinishWin:refreshView()
self.killData=xianjieModel:getMoJunKillDatas(self.seasonType,self.stageIndex)
self:refreshInfo()
end

function UIMoJieMoJunFinishWin:refreshInfo()
local bestGuild=self.killData.bestGuild
if bestGuild then
local xmName=bestGuild.xmName
local xmIcon=bestGuild.xmIcon
local xmServerId=bestGuild.xmServerId

self.xmEmpty:setActive(false)
self.xmBGIcon:setActive(true)
self.xmName:setText(xmName)

local image=xianmengModel.splitGuildIcon(xmIcon)
local abname=globalABLookup.xianmengicons
self.xmIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon or 1,'icon'))
self.xmBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
self.xmKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

self.xmServerName:setText(loginModel:getServerName(xmServerId))
else
self.xmEmpty:setActive(true)
self.xmBGIcon:setActive(false)
self.xmName:setText("——")
self.xmServerName:setText("")
end

local bestPlayer=self.killData.bestPlayer
if bestPlayer then
local actorId=bestPlayer.actorId
local actorServer=bestPlayer.actorServer
local actorName=bestPlayer.actorName
local iconInfo=bestPlayer.iconInfo

self.headEmpty:setActive(false)
playerController:setHeadIcon(self.winlua,self.head:getID(),{infoInfo=iconInfo})
self.playerName:setText(actorName)
self.serverName:setText(loginModel:getServerName(actorServer))
else
self.headEmpty:setActive(true)
playerController:setHeadIcon(self.winlua,self.head:getID(),nil)
self.playerName:setText("")
self.serverName:setText("")
end





end





function UIMoJieMoJunFinishWin:onBackground()
self:onCloseBtn()
end



function UIMoJieMoJunFinishWin:onHeadBG()
local handleType=self.seasonType
local stageIdx=self.stageIndex
local args={
handleType=handleType,
stageIdx=stageIdx,
selectIdx=eSeasonRankType.ePlayer,
closeBackFunc=function()
local firstTemp,num=xianjieModel:getMoJunFirstBox(handleType,stageIdx)
if num>0 then
msgWinControl:addMsgWin(msgWinType.eMoJunBoxTips,{seasonType=handleType,stageIndex=stageIdx})
end
end,
}
UIManager:showWindow("UIMJMBChapterRankListWin",args)
self:onCloseBtn(true)
end



function UIMoJieMoJunFinishWin:onXmClick()
local handleType=self.seasonType
local stageIdx=self.stageIndex
local args={
handleType=handleType,
stageIdx=stageIdx,
selectIdx=eSeasonRankType.eGuild,
closeBackFunc=function()
local firstTemp,num=xianjieModel:getMoJunFirstBox(handleType,stageIdx)
if num>0 then
msgWinControl:addMsgWin(msgWinType.eMoJunBoxTips,{seasonType=handleType,stageIndex=stageIdx})
end
end,
}
UIManager:showWindow("UIMJMBChapterRankListWin",args)
self:onCloseBtn(true)
end

function UIMoJieMoJunFinishWin:onCloseBtn(isShowRank)
if not isShowRank then
self:showBoxWin()
end
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIMoJieMoJunFinishWin:showBoxWin()
local firstTemp,num=xianjieModel:getMoJunFirstBox(self.seasonType,self.stageIndex)
if num>0 then
msgWinControl:addMsgWin(msgWinType.eMoJunBoxTips,{seasonType=self.seasonType,stageIndex=self.stageIndex})
end
end


