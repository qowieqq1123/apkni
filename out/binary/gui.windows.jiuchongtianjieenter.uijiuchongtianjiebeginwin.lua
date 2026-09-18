







def_class("UIJiuChongTianJieBeginWin",UIWindowBase)









function UIJiuChongTianJieBeginWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.finishTipsButton=UIButton.get(self,1)
self.level=UIText.get(self,2)
self.playerEmpty=UIObject.get(self,3)
self.playerNoEmpty=UIObject.get(self,4)
self.playerYingJie=UIObject.get(self,5)
self.rankButton=UIButton.get(self,6)
self.rankList=UIObject.get(self,7)
self.reddot=UIObject.get(self,8)
self.time=UIText.get(self,9)
self.timeFame=UIObject.get(self,10)
self.timeFame2=UIObject.get(self,11)
self.timeFame3=UIObject.get(self,12)
self.tips=UIText.get(self,13)
self.tipsFrame=UIButton.get(self,14)
self.yingjieBtn=UIButton.get(self,15)
self.yingjieHalf=UIObject.get(self,16)
self.yingjieIcon=UIObject.get(self,17)
self.yingjieName=UIText.get(self,18)
self.yingjieServer=UIText.get(self,19)
self.zheButton=UIButton.get(self,20)
self.zongmenCount=UIText.get(self,21)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.finishTipsButton:setButtonClick(function()self:onFinishTipsButton()end)

self.rankButton:setButtonClick(function()self:onRankButton()end)

self.tipsFrame:setButtonClick(function()self:onTipsFrame()end)

self.yingjieBtn:setButtonClick(function()self:onYingjieBtn()end)

self.zheButton:setButtonClick(function()self:onZheButton()end)



end


function UIJiuChongTianJieBeginWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.finishTipsButton);self.finishTipsButton=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.playerEmpty);self.playerEmpty=nil;
_UIObject_release(self.playerNoEmpty);self.playerNoEmpty=nil;
_UIObject_release(self.playerYingJie);self.playerYingJie=nil;
_UIObject_release(self.rankButton);self.rankButton=nil;
_UIObject_release(self.rankList);self.rankList=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeFame);self.timeFame=nil;
_UIObject_release(self.timeFame2);self.timeFame2=nil;
_UIObject_release(self.timeFame3);self.timeFame3=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsFrame);self.tipsFrame=nil;
_UIObject_release(self.yingjieBtn);self.yingjieBtn=nil;
_UIObject_release(self.yingjieHalf);self.yingjieHalf=nil;
_UIObject_release(self.yingjieIcon);self.yingjieIcon=nil;
_UIObject_release(self.yingjieName);self.yingjieName=nil;
_UIObject_release(self.yingjieServer);self.yingjieServer=nil;
_UIObject_release(self.zheButton);self.zheButton=nil;
_UIObject_release(self.zongmenCount);self.zongmenCount=nil;
end


















local _this

function UIJiuChongTianJieBeginWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
rankListController:req_rankList_data(eRankListType.eYinJieKaiTian)
JiuChongTianJieEnterController:req_kaitian_my_rank()
end


function UIJiuChongTianJieBeginWin:__delete()
self:unbindComponents()
_this=nil
end




function UIJiuChongTianJieBeginWin:onShow(argtable,afterOnloaded)
self:refreshRank()

local state=JiuChongTianJieEnterModel:getState()
if state==eJiuChongTianJieStateType.ePreview then
self.timeFame:setActive(false)
self.timeFame2:setActive(false)
self.timeFame3:setActive(true)
self.finishTipsButton:setActive(false)
local isOpen,ret=systemConfig.isEnoughConfigOpenCnd(SYSTEM_DEFINE.eTianJieQianZou,true)
if ret and ret[1]==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then
self.level:setText(FMT.fmt("{0}级",ret[2]))
end
else
local sec=JiuChongTianJieEnterModel:getOpenTianJieSec()
local now=timeHelper.getServerShortTime()
local dur=JiuChongTianJieEnterModel:getOpenTianJieDur()
self.finishTipsButton:setActive(true)
if math.ceil((sec+dur-now)/86400)>1 then
self.timeFame:setActive(true)
self.timeFame2:setActive(false)
self.time:setText(math.floor((sec+dur-now)/86400))
else
self.timeFame:setActive(false)
self.timeFame2:setActive(true)

self.time:setText('')
end
end


self:freshJiYuan()
end


function UIJiuChongTianJieBeginWin:onHide()

end

function UIJiuChongTianJieBeginWin.onRankListRefresh(rankType)
if rankType==eRankListType.eYinJieKaiTian then
if _this then
_this:refreshRank()
end
end
end

function UIJiuChongTianJieBeginWin:refreshRank()
local rankList=rankListModel:getRankList(eRankListType.eYinJieKaiTian)
self.rankList:setChildLayoutGroupCreateItems(3)
local grids=self.rankList:getChildLayoutGroupGridList()
for i=1,3 do
local grid=grids[i-1]
local data=rankList[i]
grid:SetChildText(0,i)
grid:SetChildActive(4,data==nil)
grid:SetChildActive(5,data~=nil)
if data then
playerController:setHeadIcon(grid,3,{iconInfo=data.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
local serverName=loginModel:getServerName(data.serverId)
grid:SetChildButtonClick(7,function()
otherPlayerController:openOtherPlayerInfoWin(data.actorId)
end)
grid:SetChildText(1,serverName)
grid:SetChildText(2,data.name)
else

end

if i==1 then
self:refreshTop(data)
end
local rankIcon
if i<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',i)
grid:SetChildCSImageSprite(6,globalABLookup.rankList,rankIcon)
end

end
self.rankLen=#rankList


self.zongmenCount:setText(FMT.fmt("即将渡劫的宗门：{0}",#rankList))


end

function UIJiuChongTianJieBeginWin:refreshTop(rankData)
if rankData then
self.playerEmpty:setActive(false)
self.playerNoEmpty:setActive(true)
playerController:setHeadIcon(self.winid,self.yingjieIcon:getID(),{iconInfo=rankData.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
local serverName=loginModel:getServerName(rankData.serverId)
self.yingjieName:setText(rankData.name)
self.yingjieServer:setText(serverName)
self.yingjieCall=function()
otherPlayerController:openOtherPlayerInfoWin(rankData.actorId)
end
local playerImage=rankData.iconInfo.piList or playerImageModel:getDefaultImage()
playerImageController.setPlayerModel(self.winid,self.yingjieHalf:getID(),playerImage,0.75,eAnimationID.idle,0,0)
else
self.yingjieCall=nil
self.playerEmpty:setActive(true)
self.playerNoEmpty:setActive(false)
end
end

function UIJiuChongTianJieBeginWin:freshJiYuan()
local jiYuan=zheXianLingModel:hasJiYuanItems()
if jiYuan then
self.zheButton:setActive(true)
self.reddot:setActive(zheXianLingModel:hasJiYuanTimes())
else
self.zheButton:setActive(false)
end
end




function UIJiuChongTianJieBeginWin:onFinishTipsButton()

local desc_str="天门将开，每有一位宗门达到<color=#f36666>44级</color>且完成谪仙令的宗门可提前<color=#f36666>24小时</color>开启<color=#f36666>九重天劫</color>"




self.tipsFrame:setActive(true)
self.tips:setText(desc_str)
self.tipsFrame:setChildCanvasGroupAlpha(0)
self.tipsFrame:setChildCanvasGroupDOFade(1,0.2,nil)
end



function UIJiuChongTianJieBeginWin:onCloseBtn()
self:closeSelf()
end

function UIJiuChongTianJieBeginWin:onRankButton()
self:showWindow("UIJCKTRankWin",{openType=1})
end

function UIJiuChongTianJieBeginWin:onTipsFrame()
self.tipsFrame:setChildCanvasGroupAlpha(1)
self.tipsFrame:setChildCanvasGroupDOFade(0,0.2,function()
self.tipsFrame:setActive(false)
end)
end

function UIJiuChongTianJieBeginWin:onZheButton()
UIFullZheXianControl:showZheXianLingWindow({winType=UIFullZheXianControl.winType.eJiYuan})
end

function UIJiuChongTianJieBeginWin:onYingjieBtn()
if self.yingjieCall then
self.yingjieCall()
end
end