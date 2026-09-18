







def_class("UICaiShenJiaDaoRedPacketDetailWin",UIWindowBase)









function UICaiShenJiaDaoRedPacketDetailWin:bindComponents()

self.background=UIButton.get(self,0)
self.bottom=UIObject.get(self,1)
self.cover=UIImage.get(self,2)
self.head=UIObject.get(self,3)
self.headBG=UIButton.get(self,4)
self.headEmpty=UIObject.get(self,5)
self.leastTx=UIText.get(self,6)
self.myBig=UIObject.get(self,7)
self.myHead=UIObject.get(self,8)
self.myItem=UIBaseItem.get(self,9)
self.myName=UIText.get(self,10)
self.myRoot=UIObject.get(self,11)
self.playerName=UIText.get(self,12)
self.recordList=UIEnhancedScrollerLua.get(self,13)
self.rewardBtn=UIButton.get(self,14)
self.spine=UIObject.get(self,15)
self.titleImg=UIImage.get(self,16)

self.background:setButtonClick(function()self:onBackground()end)

self.headBG:setButtonClick(function()self:onHeadBG()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UICaiShenJiaDaoRedPacketDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.cover);self.cover=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headBG);self.headBG=nil;
_UIObject_release(self.headEmpty);self.headEmpty=nil;
_UIObject_release(self.leastTx);self.leastTx=nil;
_UIObject_release(self.myBig);self.myBig=nil;
_UIObject_release(self.myHead);self.myHead=nil;
_UIObject_release(self.myItem);self.myItem=nil;
_UIObject_release(self.myName);self.myName=nil;
_UIObject_release(self.myRoot);self.myRoot=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.recordList);self.recordList=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
end















local _this=nil
local _recordCmp={
headBG=0,
headEmpty=1,
head=2,
item=3,
big=4,
name=5,
}
local _abName="ui/windows/activities/sub_caishenjiadao/caishenjiadao_atlas_pak.ab"
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UICaiShenJiaDaoRedPacketDetailWin:onLoaded(...)
self:bindComponents()
_this=self
self.listScript=UIPrepareEnScroller(self.recordList:getGameObject(),self.recordList:getCSharpObject(),nil,nil)
self.listScript.window=self

self.myItem:setBaseItemClickEvent(itemsComponentHelper.onItemClickEx)
playerController:setHeadIcon(self.winlua,self.myHead:getID(),{})

self:addNotify(notifyConfig.onCSJDGuildDataChange,self.onCSJDGuildDataChange)
end


function UICaiShenJiaDaoRedPacketDetailWin:__delete()
self:unbindComponents()
_this=nil
end




function UICaiShenJiaDaoRedPacketDetailWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.info=argtable.info
self.key=argtable.key or tostring(argtable.guid)
self.config=self.info:getSubActConfig()
self.guildData=self.info:getGuildDataEx(self.key)
if self.guildData then
self:refreshDispatch()
self:refreshList()
self.winlua:SetChildSpineAnimation(self.spine:getID(),eAnimationID.enter,1,nil)
else
self:onCloseBtn()
end
end


function UICaiShenJiaDaoRedPacketDetailWin:onHide()

end




function UICaiShenJiaDaoRedPacketDetailWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UICaiShenJiaDaoRedPacketDetailWin:onHeadBG()
local member=xianmengModel:getXMMemberData(self.guildData.dispatcher)
if member then
otherPlayerController:openOtherPlayerInfoWin(member.actorid)
end
end


function UICaiShenJiaDaoRedPacketDetailWin:onRewardBtn()
local hb_conf=self.config.hb_conf[self.guildData.id]
local args={
config=hb_conf,
parentWin=self,
}
self:showWindow("UICaiShenJiaDaoRedPacketRewardWin",args)
end

function UICaiShenJiaDaoRedPacketDetailWin:refreshDispatch()
local member=xianmengModel:getXMMemberData(self.guildData.dispatcher)
local hb_conf=self.config.hb_conf[self.guildData.id]
local bless_conf=hb_conf.blessing[self.guildData.bless]
self.titleImg:setSprite(_abName,bless_conf[2])
self.cover:setSprite(_abName,bless_conf[3])
self.headEmpty:setActive(member==nil)
self.head:setActive(member~=nil)
local nameStr=member and member.actorname or"不知名的盟友"
self.playerName:setText(FMT.fmt("来自【{0}】的红包",nameStr))
if member then
playerController:setHeadIcon(self.winlua,self.head:getID(),{iconInfo=member.iconInfo})
end
end


function UICaiShenJiaDaoRedPacketDetailWin:onClickActor(dataIndex)
local receiverKey=self.guildData.receiverList[dataIndex]
local receiverData=self.guildData.receiverLookup[receiverKey]
local member=xianmengModel:getXMMemberData(receiverData.actor)
if member then
otherPlayerController:openOtherPlayerInfoWin(member.actorid)
end
end

function UICaiShenJiaDaoRedPacketDetailWin:refreshList()
self.leastTx:setText(FMT.fmt("剩余红包：{0}",self.guildData.getMax-self.guildData.getCnt))

local key=tostring(playerModel:getActorID())
local receiverData=self.guildData.receiverLookup[key]
self.myRoot:setActive(receiverData~=nil)
if receiverData then
local hb_conf=self.config.hb_conf[self.guildData.id]
local reward_conf=hb_conf.rand_reward_lib[receiverData.reward]
local isBig=reward_conf[2]==1
local showReward=reward_conf[4][1]
local itemId=showReward[1]
local itemNum=showReward[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
self.myItem:setChildPropData(itemProp)
self.myBig:setActive(isBig)
self.myName:setText(playerModel:getActorName())
end
self.winlua:ForceLayoutRect(self.bottom:getID())

local receiverList=self.guildData.receiverList or{}
self.listScript:initData(receiverList,78,#receiverList)
end

function UICaiShenJiaDaoRedPacketDetailWin:refreshItem(dataIndex,widget)
local receiverKey=self.guildData.receiverList[dataIndex]
local receiverData=self.guildData.receiverLookup[receiverKey]

local member=xianmengModel:getXMMemberData(receiverData.actor)
local hb_conf=self.config.hb_conf[self.guildData.id]
local reward_conf=hb_conf.rand_reward_lib[receiverData.reward]
local isBig=reward_conf[2]==1
local showReward=reward_conf[4][1]
local itemId=showReward[1]
local itemNum=showReward[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
widget:SetChildPropData(_recordCmp.item,itemProp)
widget:SetBaseItemClickEvent(_recordCmp.item,itemsComponentHelper.onItemClickEx)
widget:SetChildActive(_recordCmp.big,isBig)
widget:SetChildButtonClick(_recordCmp.headBG,function()
self:onClickActor(dataIndex)
end)
widget:SetChildActive(_recordCmp.headEmpty,member==nil)
widget:SetChildActive(_recordCmp.head,member~=nil)
widget:SetChildText(_recordCmp.name,member and member.actorname or"不知名的盟友")
if member then
playerController:setHeadIcon(widget,_recordCmp.head,{iconInfo=member.iconInfo})
end
end

function UICaiShenJiaDaoRedPacketDetailWin.onCSJDGuildDataChange(actId,subType,subId,guid,reSort)
if _this==nil then
return
end
if _this.info:compare(actId,subType,subId)and(guid==nil or guid==_this.guildData.guid)then
_this.guildData=_this.info:getGuildDataEx(_this.key)
if _this.guildData then
_this:refreshList()
else
_this:onCloseBtn()
end
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
if self.window and self.window.isClose then
return
end
self.window:refreshItem(dataIndex,cell)
end
