







def_class("UIWDCQLiveBroadcastRoomHotRankWin",UIWindowBase)









function UIWDCQLiveBroadcastRoomHotRankWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.head=UIObject.get(self,2)
self.headBG=UIButton.get(self,3)
self.hotNum=UIText.get(self,4)
self.nameTx=UIText.get(self,5)
self.rank_1=UIObject.get(self,6)
self.rank_2=UIObject.get(self,7)
self.rank_3=UIObject.get(self,8)
self.rankBtn=UIButton.get(self,9)
self.rankNum=UIText.get(self,10)
self.rewardList=UIObject.get(self,11)
self.serverTx=UIText.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.headBG:setButtonClick(function()self:onHeadBG()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)
self.rank={
self.rank_1,
self.rank_2,
self.rank_3,
}



end


function UIWDCQLiveBroadcastRoomHotRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headBG);self.headBG=nil;
_UIObject_release(self.hotNum);self.hotNum=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.rank_1);self.rank_1=nil;
_UIObject_release(self.rank_2);self.rank_2=nil;
_UIObject_release(self.rank_3);self.rank_3=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rankNum);self.rankNum=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.serverTx);self.serverTx=nil;
self.rank=nil;
end















local _this=nil
local _rankCmp={
headBG=0,
head=1,
nameTx=2,
serverTx=3,
rewardList=4,
hotNum=5,
emptyRoot=6,
haveRoot=7,
disciple=8,
model=9,
}



function UIWDCQLiveBroadcastRoomHotRankWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onRequestPhpServerNamesRecv,self.onRequestPhpServerNamesRecv)
self:addProNotify(38,25,self.on_38_25)

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgSpine:getID(),false,true,false)
end
self.bgSpine:setChildUIModelShowTarget(5560,1,{},eAnimationID.enter,false,false,0)
end


function UIWDCQLiveBroadcastRoomHotRankWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWDCQLiveBroadcastRoomHotRankWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc

self:refreshView()
end


function UIWDCQLiveBroadcastRoomHotRankWin:onHide()

end




function UIWDCQLiveBroadcastRoomHotRankWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
UIManager:closeWindow(self.__name)
end
end


function UIWDCQLiveBroadcastRoomHotRankWin:onHeadBG()
end

function UIWDCQLiveBroadcastRoomHotRankWin:onRankBtn()
local args={
parentWin=self,
}
self:showWindow("UIWDCQLiveBroadcastRoomHotRankListWin",args)
end

function UIWDCQLiveBroadcastRoomHotRankWin:refreshView()
local group=wdcqLiveBroadcastRoomModel:getRoomGroup()
if group==nil then
self:onCloseBtn()
return
end
self.group=group
self.rewardCfg=cfgHelper.get3(cfg_wendingcangqiongzhibobasicconfig_get,1,"rdRankReward",self.group)
self.rankList=wdcqLiveBroadcastRoomModel:getHotRank()or{}
self.ownHot=wdcqLiveBroadcastRoomModel:getOwnHot()or 0

for i,v in ipairs(self.rank)do
self:refreshRankItem(i,v:getChildWidgetBase())
end
self:refreshOwn()
end

function UIWDCQLiveBroadcastRoomHotRankWin:refreshRankItem(rank,item)
local rankData=self.rankList[rank]
local rewards=nil
for i,v in ipairs(self.rewardCfg)do
if v[1]<=rank and rank<=v[2]then
rewards=v[3]
break
end
end
local rewardCnt=rewards and#rewards or 0
item:SetChildActive(_rankCmp.emptyRoot,rankData==nil)
item:SetChildActive(_rankCmp.haveRoot,rankData~=nil)
item:SetChildActive(_rankCmp.disciple,rankData~=nil)
item:SetChildLayoutGroupCreateItems(_rankCmp.rewardList,rewardCnt,function(rewardIdx)
local rewardItem=item:GetChildLayoutGroupGridItem(_rankCmp.rewardList,rewardIdx-1)
local rewardData=rewards[rewardIdx]
self:refreshRewardItem(rewardItem,rewardData)
end)
if rankData then
playerController:setHeadIcon(item,_rankCmp.head,{iconInfo=rankData.actorIcon})
item:SetChildButtonClick(_rankCmp.headBG,function()
if not playerModel:checkActorId(rankData.actorId)then


end
end)
item:SetChildText(_rankCmp.nameTx,rankData.actorName)
local serverName=loginModel:getServerNameEx(rankData.serverId,"")
item:SetChildText(_rankCmp.serverTx,serverName)
item:SetChildText(_rankCmp.hotNum,rankData.hot)

local modelParams=nil
if mathHelper.validInt64(rankData.discipledata)or mathHelper.validInt64(rankData.discipleimage)then
local imageInfo=UIDiscipleModel.calculationDiscipleImage(rankData.discipledata,rankData.discipleimage)
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
else
modelParams=npcModel:getImageInfoOutSide(1)
end
item:SetChildUIModelShowTarget(_rankCmp.model,modelParams.body,0.9,modelParams.componets,eAnimationID.stand,false,false,0)
end
end

function UIWDCQLiveBroadcastRoomHotRankWin:refreshOwn()
local ownRank=nil
for rank,rankData in ipairs(self.rankList)do
if playerModel:checkActorId(rankData.actorId)then
ownRank=rank
break
end
end
playerController:setHeadIcon(self.winlua,self.head:getID(),{})
self.nameTx:setText(playerModel:getActorName())
self.serverTx:setText(loginModel:getMyServerName())
self.hotNum:setText(self.ownHot)
self.rankNum:setText(ownRank or"未上榜")
if ownRank then
local rewards=nil
for i,v in ipairs(self.rewardCfg)do
if v[1]<=ownRank and ownRank<=v[2]then
rewards=v[3]
break
end
end
local rewardCnt=rewards and#rewards or 0
self.rewardList:setChildLayoutGroupCreateItems(rewardCnt,function(rewardIdx)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(rewardIdx-1)
local rewardData=rewards[rewardIdx]
self:refreshRewardItem(rewardItem,rewardData)
end)
else
self.rewardList:setChildLayoutGroupCreateItems(0)
end
end

function UIWDCQLiveBroadcastRoomHotRankWin.on_38_25(group,phase,order)
if _this.group==group and _this.phase==phase and _this.order==order then
_this:refreshView()
end
end

function UIWDCQLiveBroadcastRoomHotRankWin:refreshRewardItem(rewardItem,rewardData)
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local showCountBG=rewardNum>1
local countStr=showCountBG and mathHelper.formatNumber(rewardNum)or""
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end

function UIWDCQLiveBroadcastRoomHotRankWin.onRequestPhpServerNamesRecv(secFlag)
if secFlag then
for i,v in ipairs(_this.rank)do
local item=v:getChildWidgetBase()
local rankData=_this.rankList[i]
if rankData then
local serverName=loginModel:getServerNameEx(v.serverId,"")
item:SetChildText(_rankCmp.serverTx,serverName)
end
end
end
end