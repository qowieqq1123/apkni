







def_class("UISubAct_CrossRankingInfoWin",UIWindowBase)









function UISubAct_CrossRankingInfoWin:bindComponents()

self.cd=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.flag=UIImage.get(self,2)
self.infoScrollView=UILoopListView.new(self,3)
self.infoTitle_1=UIText.get(self,4)
self.infoTitle_2=UIText.get(self,5)
self.infoTitle_3=UIText.get(self,6)
self.infoTitle_4=UIText.get(self,7)
self.myInfo=UIObject.get(self,8)
self.noXmInfo=UIObject.get(self,9)
self.tabItem_1=UIObject.get(self,10)
self.tabItem_2=UIObject.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.infoScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)self.infoTitle={
self.infoTitle_1,
self.infoTitle_2,
self.infoTitle_3,
self.infoTitle_4,
}
self.tabItem={
self.tabItem_1,
self.tabItem_2,
}



end


function UISubAct_CrossRankingInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cd);self.cd=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.flag);self.flag=nil;
self.infoScrollView:deleteSelf();self.infoScrollView=nil;
_UIObject_release(self.infoTitle_1);self.infoTitle_1=nil;
_UIObject_release(self.infoTitle_2);self.infoTitle_2=nil;
_UIObject_release(self.infoTitle_3);self.infoTitle_3=nil;
_UIObject_release(self.infoTitle_4);self.infoTitle_4=nil;
_UIObject_release(self.myInfo);self.myInfo=nil;
_UIObject_release(self.noXmInfo);self.noXmInfo=nil;
_UIObject_release(self.tabItem_1);self.tabItem_1=nil;
_UIObject_release(self.tabItem_2);self.tabItem_2=nil;
self.infoTitle=nil;
self.tabItem=nil;
end
















local _tabCmp={
root=-1,
clickBtn=0,
nameTx=1,
}

local menu_slot_name="button_dytab"

local _item_index=
{
rank=0,
server=1,
name=2,
score=3,
items={4,5,6,7,16},
info=8,
tips=9,
ctips=10,
items_root=11,
rw_tips=12,
rankIcon=13,
playerList=14,
guildList=15,
scrollview=17,
content=18,
}

local _tabEnum={
ePlayer=1,
eXianmeng=2,
}

local _tabConfig={
[_tabEnum.ePlayer]={
type=_tabEnum.ePlayer,
name="个人",
isOpen=function(self)
return self.config.rankNum>0
end,
reqRankData=function(self)

activitiesController:sendProtocol(actSendType.eComonReqInfo,self.activityId,self.subType,self.subId)
end,
getData=function(self)
return self.activityData.data.zsRankData,self.activityData.data.zsRankItemInfoLookup,self.config.join_reward
end,
titleNameList={"名次","祖师","个人积分","奖励",}
},
[_tabEnum.eXianmeng]={
type=_tabEnum.eXianmeng,
name="仙盟",
isOpen=function(self)
return self.config.rankNum2>0
end,
reqRankData=function(self)

local selfXmGuildId=xianmengModel:myXMGuildID()or Int64_0
selfXmGuildId=tostring(selfXmGuildId)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jsonHelper.encode({1,selfXmGuildId}))
end,
getData=function(self)
return self.activityData.data.xmRankData,self.activityData.data.xmRankItemInfoLookup,self.config.join_reward2
end,
titleNameList={"名次","仙盟","仙盟积分","奖励",}
},
}

local _this




function UISubAct_CrossRankingInfoWin:onLoaded(...)
self:bindComponents()

_this=self

local _recv_247_3=function()
if _this.rankType==_tabEnum.ePlayer then

_this:refresh()
end
end
self:addProNotify(247,3,_recv_247_3)

local _recv_247_97=function()
if _this.rankType==_tabEnum.eXianmeng then

_this:refresh()
end
end
self:addProNotify(247,97,_recv_247_97)
end


function UISubAct_CrossRankingInfoWin:__delete()

_this=nil

self:unbindComponents()
end




function UISubAct_CrossRankingInfoWin:onShow(argtable,afterOnloaded)
if argtable then
self.argtable=argtable
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

self.minUpRankVal=self.config.jifenMin
self.maxRankCount=self.config.rankNum

self.tabConfig={}

for type,config in ipairs(_tabConfig)do
if config.isOpen(self)then
self.tabConfig[#self.tabConfig+1]=config
end
end
self.tablen=#self.tabConfig
if self.tablen>0 then
self.tabIndex=1
self.rankType=self.tabConfig[self.tabIndex].type

for index=1,self.tablen do
local config=self.tabConfig[index]
config.reqRankData(self)
end
else
logErr(FMT.fmt("未检测到是祖师排行或者仙盟排行，请求策划检查配. 活动id: {0}, 活动类型: {1}, 子活动id: {2}",self.activityId,self.subType,self.subId))
end

if self.tablen>1 then
self.banClickTab=#self.tabItem
for i,v in ipairs(self.tabItem)do
local config=self.tabConfig[i]
local isShow=config~=nil
local widget=v:getChildWidgetBase()
widget:SetChildActive(-1,isShow)

if isShow then
widget:SetChildButtonClick(_tabCmp.clickBtn,function()
self:onClickTab(i)
end)
widget:SetChildUIModelShowTarget(_tabCmp.root,2017,1,{},eAnimationID.common_window_enter,false,false,0,function()
self:refreshTabSelect(widget,self.tabIndex==i)
widget:SetChildCanvasGroupAlpha(_tabCmp.nameTx,1)
self.banClickTab=self.banClickTab-1
widget:SetChildText(_tabCmp.nameTx,config.name)
end)
end
end
end

self.cd:setText(self.config.rank_end_tips)
self:refresh()
end


function UISubAct_CrossRankingInfoWin:onHide()

end

function UISubAct_CrossRankingInfoWin:reqTabData()
local config=self.tabConfig[self.tabIndex]
config.reqRankData(self)
end

function UISubAct_CrossRankingInfoWin:onClickTab(index)
if self.banClickTab>0 then return end
if self.tabIndex~=index then
self:refreshTabSelectEx(self.tabIndex,false)
self.tabIndex=index
self:refreshTabSelectEx(self.tabIndex,true)
self.rankType=self.tabConfig[self.tabIndex].type

self:refresh()
end
end

function UISubAct_CrossRankingInfoWin:refreshTabSelectEx(index,select)
local item=self.tabItem[index]:getChildWidgetBase()
self:refreshTabSelect(item,select)
end

function UISubAct_CrossRankingInfoWin:refreshTabSelect(item,select)
local name=FMT.fmt("{0}_{1}",menu_slot_name,select and 2 or 1)
item:SetChildUIModelShowSlotAttachment(_tabCmp.root,menu_slot_name,name)
end

function UISubAct_CrossRankingInfoWin:refresh()

local tabConfig=_tabConfig[self.rankType]
self.activityRankData,self.activityRankLookup,self.join_reward=tabConfig.getData(self)

local infoTitle=tabConfig.titleNameList
for index=1,#self.infoTitle do
local title=infoTitle[index]
local titleObj=self.infoTitle[index]
titleObj:setText(title)
end

local rankMaxNum=#self.activityRankLookup

self:setMyInfo()


self.infoScrollView:refreshAllItems()
self.infoScrollView:initData('item',self.activityRankLookup,rankMaxNum)
end

function UISubAct_CrossRankingInfoWin:setMyInfo()
local isShowPlayerInfo=self.rankType==_tabEnum.ePlayer
local isShowXMInfo=self.rankType==_tabEnum.eXianmeng
local isHasXM=xianmengModel:hasXM()

local widget=self.myInfo:getChildWidgetBase()

widget:SetChildActive(_item_index.playerList,isShowPlayerInfo)
widget:SetChildActive(_item_index.guildList,isShowXMInfo and isHasXM)

if isShowPlayerInfo then
self:freshPlayerSelfInfo()
elseif isShowXMInfo and isHasXM then
self:freshXmSelfInfo()
end

self.myInfo:setActive(isShowPlayerInfo or(isHasXM and isShowXMInfo))
self.noXmInfo:setActive(not isHasXM and isShowXMInfo)
end

function UISubAct_CrossRankingInfoWin:freshPlayerSelfInfo()
local scoreUnitName=self.config.rank_val_unit_name
local myRank=self.activityRankData.myRank
local myRewardIndex=self.activityRankData.myRewardIndex
local inRank=myRank>0

local widget=self.myInfo:getChildWidgetBase()


widget:SetChildText(_item_index.rank,inRank and myRank or'未上榜')
local showRIcon=inRank and myRank<=3
widget:SetChildActive(_item_index.rankIcon,showRIcon)
if showRIcon then
widget:SetChildCSImageSprite(_item_index.rankIcon,globalABLookup.global,'icon_phbmingci_'..myRank)
end


widget:SetChildLayoutGroupCreateItems(_item_index.playerList,1,function(index)
local item=widget:GetChildLayoutGroupGridItem(_item_index.playerList,index-1)

local iconInfo=playerModel:getActorIconInfo()

playerController:setHeadIcon(item,0,{scale=0.75,iconInfo=iconInfo,updateRendererSize=true})
item:SetChildButtonClick(-1,function()
otherPlayerController:openOtherPlayerInfoWin(playerModel:getActorID(),true,nil,nil)
end,true)
end)
widget:SetBaseItemClickEvent(_item_index.info,function()
otherPlayerController:openOtherPlayerInfoWin(playerModel:getActorID(),true,nil,nil)
end)


local sname=loginModel:getMyServerName()
widget:SetChildText(_item_index.server,sname)


widget:SetChildText(_item_index.name,playerModel:getActorName())


local score=self.activityRankData.myScore
widget:SetChildText(_item_index.score,FMT.fmt("{0}{1}",score,scoreUnitName))


widget:SetChildText(_item_index.ctips,'')
widget:SetChildText(_item_index.tips,'')


if inRank then
widget:SetChildActive(_item_index.items_root,true)
widget:SetChildText(_item_index.rw_tips,'')

local rewards=self.activityRankLookup[myRewardIndex]and self.activityRankLookup[myRewardIndex].reward or self.config.join_reward
self:setRewards(widget,rewards)
else
widget:SetChildActive(_item_index.items_root,true)
widget:SetChildText(_item_index.rw_tips,'')
self:setRewards(widget,self.config.join_reward)
end

self.flag:setActive(true)
self.flag:setCSImageSprite('ui/sharedtextures/uiglobalspriteatlas_1.ab','image_ziji_1')
end

function UISubAct_CrossRankingInfoWin:freshXmSelfInfo()



local scoreUnitName=self.config.rank_val_unit_name
local myRank=self.activityRankData.myRank
local myRewardIndex=self.activityRankData.myRewardIndex
local inRank=myRank>0


local widget=self.myInfo:getChildWidgetBase()


widget:SetChildText(_item_index.rank,inRank and myRank or'未上榜')
local showRIcon=inRank and myRank<=3
widget:SetChildActive(_item_index.rankIcon,showRIcon)
if showRIcon then
widget:SetChildCSImageSprite(_item_index.rankIcon,globalABLookup.global,'icon_phbmingci_'..myRank)
end


widget:SetChildLayoutGroupCreateItems(_item_index.guildList,1,function(index)
local item=widget:GetChildLayoutGroupGridItem(_item_index.guildList,index-1)

local image=xianmengModel:getGuildImage()
local signIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon')
item:SetChildCSImageSprite(0,globalABLookup.xianmengicons,signIconName)

local signBgIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon')
item:SetChildCSImageSprite(-1,globalABLookup.xianmengicons,signBgIconName)

local signKuangIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon')
item:SetChildCSImageSprite(1,globalABLookup.xianmengicons,signKuangIconName)

item:SetChildButtonClick(-1,function()
xianmengController:openXMDetailInfoWin(xianmengModel:getMyXMGuildID(),8)
end,true)
end)
widget:SetBaseItemClickEvent(_item_index.info,function()
xianmengController:openXMDetailInfoWin(xianmengModel:getMyXMGuildID(),8)
end)


local sname=loginModel:getServerName(playerModel:getActorServerID())
sname=FMT.fmt("[{0}]",sname)
widget:SetChildText(_item_index.server,sname)


widget:SetChildText(_item_index.name,xianmengModel:getXMName())


local score=self.activityRankData.myScore
widget:SetChildText(_item_index.score,FMT.fmt("{0}{1}",score,scoreUnitName))


widget:SetChildText(_item_index.ctips,'')
widget:SetChildText(_item_index.tips,'')


if inRank then
widget:SetChildActive(_item_index.items_root,true)
widget:SetChildText(_item_index.rw_tips,'')

local rewards=self.activityRankLookup[myRewardIndex]and self.activityRankLookup[myRewardIndex].reward or self.config.join_reward2
self:setRewards(widget,rewards)
else
widget:SetChildActive(_item_index.items_root,true)
widget:SetChildText(_item_index.rw_tips,'')
self:setRewards(widget,self.config.join_reward2)
end

self.flag:setActive(xianmengModel:hasXM())
self.flag:setCSImageSprite('ui/windows/xianmeng/act_zhengzhanshanhai/zhengzhanshanhaiicons_atlas_pak.ab','image_benmeng_1')
end


function UISubAct_CrossRankingInfoWin:onFreshAction(index,item)

local data=self.activityRankLookup[index]

local isShow=data~=nil
item:SetChildActive(-1,isShow)
if data==nil then return end

if self.rankType==_tabEnum.ePlayer then
self:onFreshPlayerInfo(index,item)
elseif self.rankType==_tabEnum.eXianmeng then
self:onFreshXMInfo(index,item)
end

local rewards=data.reward
self:setRewards(item,rewards)
end

function UISubAct_CrossRankingInfoWin:onFreshPlayerInfo(id,item)

local i=id
local showRIcon=i<=3
local scoreUnitName=self.config.rank_val_unit_name



item:SetChildActive(_item_index.rankIcon,showRIcon)
if showRIcon then
item:SetChildCSImageSprite(_item_index.rankIcon,globalABLookup.global,'icon_phbmingci_'..i)
end

local data=self.activityRankLookup[i]

item:SetChildText(_item_index.rank,i)



local isShowActorRoot=data.rankPlayerLen>0
local showActorLen=0
if data.showNum==1 then
if data.rankPlayerLen==1 then
local rankData=data.rankPlayerList[1]

showActorLen=1
item:SetChildActive(_item_index.info,true)
item:SetChildActive(_item_index.score,true)

item:SetBaseItemClickEvent(_item_index.info,function()
local attach={
serverid=rankData.serverId
}
otherPlayerController:openOtherPlayerInfoWin(rankData.actorid,true,nil,attach)
end)

local sname=loginModel:getServerName(rankData.serverId)
item:SetChildText(_item_index.server,sname)

item:SetChildText(_item_index.name,rankData.actorname)
item:SetChildText(_item_index.score,FMT.fmt("{0}{1}",rankData.score,scoreUnitName))
item:SetChildText(_item_index.tips,'')
item:SetChildText(_item_index.ctips,'')
elseif data.rankPlayerLen==0 then
local conditionVal=data.upRankMinVal
local isShowConditionTip=conditionVal and conditionVal>0
item:SetChildActive(_item_index.ctips,true)
if isShowConditionTip then
item:SetChildText(_item_index.ctips,FMT.fmt('{0}<color=#ca631d>{1}{2}</color>',self.config.rank_tips_pre,mathHelper.formatNumber9(conditionVal,2),scoreUnitName))
else
item:SetChildText(_item_index.ctips,'虚位以待')
end
item:SetChildText(_item_index.tips,'虚位以待')
item:SetChildActive(_item_index.info,false)
item:SetChildActive(_item_index.score,false)
end
else

item:SetChildActive(_item_index.info,false)
item:SetChildActive(_item_index.score,false)

item:SetChildText(_item_index.rank,FMT.fmt('{0}~{1}',data.range[1],data.range[2]))

local isShowHeads=data.rankPlayerLen>0
showActorLen=data.rankPlayerLen
local tipsInfo=(not isShowHeads)and"虚位以待"or""

item:SetChildText(_item_index.tips,tipsInfo)
local conditionVal=data.upRankMinVal
local isShowConditionTip=conditionVal and conditionVal>0
item:SetChildActive(_item_index.ctips,isShowConditionTip and(not isShowHeads))
if isShowConditionTip then
item:SetChildText(_item_index.ctips,FMT.fmt('{0}<color=#ca631d>{1}{2}</color>',self.config.rank_tips_pre,conditionVal,scoreUnitName))
end
end


item:SetChildActive(_item_index.tips,not isShowActorRoot)

item:SetChildActive(_item_index.playerList,true and isShowActorRoot)
item:SetChildActive(_item_index.guildList,false)

if isShowActorRoot then
item:SetChildLayoutGroupCreateItems(_item_index.playerList,data.rankPlayerLen,function(index)
local item=item:GetChildLayoutGroupGridItem(_item_index.playerList,index-1)

local rankData=data.rankPlayerList[index]

playerController:setHeadIcon(item,0,{scale=0.75,iconInfo=rankData.iconInfo,updateRendererSize=true})
item:SetChildButtonClick(-1,function()
local attach={
serverid=rankData.serverId
}
otherPlayerController:openOtherPlayerInfoWin(rankData.actorid,true,nil,attach)
end,true)
end)
end

end

function UISubAct_CrossRankingInfoWin:onFreshXMInfo(id,item)
local i=id
local showRIcon=i<=3
local scoreUnitName=self.config.rank_val_unit_name



item:SetChildActive(_item_index.rankIcon,showRIcon)
if showRIcon then
item:SetChildCSImageSprite(_item_index.rankIcon,globalABLookup.global,'icon_phbmingci_'..i)
end

local data=self.activityRankLookup[i]

item:SetChildText(_item_index.rank,i)

local isShowActorRoot=data.rankPlayerLen>0
local showActorLen=0
if data.showNum==1 then
if data.rankPlayerLen==1 then
local rankData=data.rankPlayerList[1]

showActorLen=1
item:SetChildActive(_item_index.info,true)
item:SetChildActive(_item_index.score,true)

item:SetBaseItemClickEvent(_item_index.info,function()
xianmengController:openXMDetailInfoWin(rankData.xmGuid,8)
end)

local sname=loginModel:getServerName(rankData.xmServerId)
sname=FMT.fmt("[{0}]",sname)
item:SetChildText(_item_index.server,sname)

item:SetChildText(_item_index.name,rankData.xmName)
item:SetChildText(_item_index.score,FMT.fmt("{0}{1}",rankData.xmScore,scoreUnitName))
item:SetChildText(_item_index.tips,'')
item:SetChildText(_item_index.ctips,'')
elseif data.rankPlayerLen==0 then
local conditionVal=data.upRankMinVal
local isShowConditionTip=conditionVal and conditionVal>0
item:SetChildActive(_item_index.ctips,true)
if isShowConditionTip then
item:SetChildText(_item_index.ctips,FMT.fmt('{0}<color=#ca631d>{1}{2}</color>',self.config.rank_tips_pre,mathHelper.formatNumber9(conditionVal,2),scoreUnitName))
else
item:SetChildText(_item_index.ctips,'虚位以待')
end
item:SetChildText(_item_index.tips,'虚位以待')
item:SetChildActive(_item_index.info,false)
item:SetChildActive(_item_index.score,false)
end
else

item:SetChildActive(_item_index.info,false)
item:SetChildActive(_item_index.score,false)

item:SetChildText(_item_index.rank,FMT.fmt('{0}~{1}',data.range[1],data.range[2]))

local isShowHeads=data.rankPlayerLen>0
showActorLen=data.rankPlayerLen
local tipsInfo=(not isShowHeads)and"虚位以待"or""

item:SetChildText(_item_index.tips,tipsInfo)
local conditionVal=data.upRankMinVal
local isShowConditionTip=conditionVal and conditionVal>0
item:SetChildActive(_item_index.ctips,isShowConditionTip and(not isShowHeads))
if isShowConditionTip then
item:SetChildText(_item_index.ctips,FMT.fmt('{0}<color=#ca631d>{1}{2}</color>',self.config.rank_tips_pre,conditionVal,scoreUnitName))
end
end


item:SetChildActive(_item_index.tips,not isShowActorRoot)

item:SetChildActive(_item_index.playerList,false)
item:SetChildActive(_item_index.guildList,true and isShowActorRoot)


if isShowActorRoot then
item:SetChildLayoutGroupCreateItems(_item_index.guildList,data.rankPlayerLen,function(index)
local widget=item:GetChildLayoutGroupGridItem(_item_index.guildList,index-1)
local subData=data.rankPlayerList[index]

local image=xianmengModel.splitGuildIcon(subData.xmIcon)
local signIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon')
widget:SetChildCSImageSprite(0,globalABLookup.xianmengicons,signIconName)

local signBgIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon')
widget:SetChildCSImageSprite(-1,globalABLookup.xianmengicons,signBgIconName)

local signKuangIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon')
widget:SetChildCSImageSprite(1,globalABLookup.xianmengicons,signKuangIconName)

widget:SetChildButtonClick(-1,function()
xianmengController:openXMDetailInfoWin(subData.xmGuid,8)
end,true)
end)
end
end

function UISubAct_CrossRankingInfoWin:onStartAction()

end

function UISubAct_CrossRankingInfoWin:setRewards(item,rewards)
local rwlist=_item_index.items
local rLen=#rewards
for ii=1,#rwlist do
local index=rwlist[ii]
local rw=rewards[ii]
if rw then
item:SetChildActive(index,true)
widgetHelper.setNormalRewardItem(item,index,rw)
else
item:SetChildActive(index,false)
end
end

item:SetChildScrollRectEnable(_item_index.scrollview,rLen>4)
item:SetChildAnchoredPos(_item_index.content,0,0)

end





function UISubAct_CrossRankingInfoWin:onCloseBtn()
UIManager:invokeUIMethod("UISubAct_CrossRankingMainWin","refresh")
self:closeSelf()
end

