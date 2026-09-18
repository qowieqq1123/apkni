







def_class("UISubAct_CrossRankingMainWin",UIWindowBase)









function UISubAct_CrossRankingMainWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.canvasGroupLayout=UIObject.get(self,1)
self.dailyRewardBtn=UIButton.get(self,2)
self.goJoinXmBtn=UIButton.get(self,3)
self.goJoinXmLinkTxt=UILinkImageText.get(self,4)
self.hasXM=UIObject.get(self,5)
self.infoBtn=UIButton.get(self,6)
self.noXm=UIObject.get(self,7)
self.playerInfo=UIObject.get(self,8)
self.rankPlayer=UIObject.get(self,9)
self.rankTab=UIObject.get(self,10)
self.rankTabItem_1=UIBaseItem.get(self,11)
self.rankTabItem_2=UIBaseItem.get(self,12)
self.rankXM=UIObject.get(self,13)
self.reddot=UIObject.get(self,14)
self.rewardPlayerPart=UIObject.get(self,15)
self.rewardXMPart=UIObject.get(self,16)
self.root=UIObject.get(self,17)
self.selfInfo=UIObject.get(self,18)
self.selfPlayerRewardScrollView=UIObject.get(self,19)
self.selfRankBg=UIImage.get(self,20)
self.selfRankText=UIText.get(self,21)
self.selfXmRewardScrollView=UIObject.get(self,22)
self.serverListBtn=UIButton.get(self,23)
self.showRankBtn=UIButton.get(self,24)
self.spriteBg=UIImage.get(self,25)
self.timeText=UIText.get(self,26)
self.title=UIImage.get(self,27)
self.upRankingBtn=UIButton.get(self,28)
self.xmInfo=UIObject.get(self,29)

self.dailyRewardBtn:setButtonClick(function()self:onDailyRewardBtn()end)

self.goJoinXmBtn:setButtonClick(function()self:onGoJoinXmBtn()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.serverListBtn:setButtonClick(function()self:onServerListBtn()end)

self.showRankBtn:setButtonClick(function()self:onShowRankBtn()end)

self.upRankingBtn:setButtonClick(function()self:onUpRankingBtn()end)
self.rankTabItem={
self.rankTabItem_1,
self.rankTabItem_2,
}



end


function UISubAct_CrossRankingMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.canvasGroupLayout);self.canvasGroupLayout=nil;
_UIObject_release(self.dailyRewardBtn);self.dailyRewardBtn=nil;
_UIObject_release(self.goJoinXmBtn);self.goJoinXmBtn=nil;
_UIObject_release(self.goJoinXmLinkTxt);self.goJoinXmLinkTxt=nil;
_UIObject_release(self.hasXM);self.hasXM=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.noXm);self.noXm=nil;
_UIObject_release(self.playerInfo);self.playerInfo=nil;
_UIObject_release(self.rankPlayer);self.rankPlayer=nil;
_UIObject_release(self.rankTab);self.rankTab=nil;
_UIObject_release(self.rankTabItem_1);self.rankTabItem_1=nil;
_UIObject_release(self.rankTabItem_2);self.rankTabItem_2=nil;
_UIObject_release(self.rankXM);self.rankXM=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.rewardPlayerPart);self.rewardPlayerPart=nil;
_UIObject_release(self.rewardXMPart);self.rewardXMPart=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selfInfo);self.selfInfo=nil;
_UIObject_release(self.selfPlayerRewardScrollView);self.selfPlayerRewardScrollView=nil;
_UIObject_release(self.selfRankBg);self.selfRankBg=nil;
_UIObject_release(self.selfRankText);self.selfRankText=nil;
_UIObject_release(self.selfXmRewardScrollView);self.selfXmRewardScrollView=nil;
_UIObject_release(self.serverListBtn);self.serverListBtn=nil;
_UIObject_release(self.showRankBtn);self.showRankBtn=nil;
_UIObject_release(self.spriteBg);self.spriteBg=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.upRankingBtn);self.upRankingBtn=nil;
_UIObject_release(self.xmInfo);self.xmInfo=nil;
self.rankTabItem=nil;
end
















local item_index=
{
zmname=0,
playername=1,
floorcount=2,
model=3,
have=4,
nothave=5,
click=6,
}
local _this=nil
local _thisActId=0

local _tabEnum={
ePlayer=1,
eXianmeng=2,
}

local _tabConfig={
[_tabEnum.ePlayer]={
type=_tabEnum.ePlayer,
name="个人",
isOpen=function(_self)
return _self.config.rankNum>0
end,
reqRankData=function(_self)

activitiesController:sendProtocol(actSendType.eComonReqInfo,_self.activityId,_self.subType,_self.subId)
end,
getData=function(_self)
return _self.activityData.data.zsRankData,_self.activityData.data.zsRankItemInfoLookup,_self.config.join_reward,_self.selfPlayerRewardScrollView,_self.config.rankNum
end,
freshRankInfo=function(_self)

_self:refreshPlayerRankInfo()
end,
freshInfo=function(_self)

_self:refreshPlayerInfo()
end,
getBgInfo=function(_self)
return _self.config.ad_res_info,_self.config.bg_res_info
end,
},
[_tabEnum.eXianmeng]={
type=_tabEnum.eXianmeng,
name="仙盟",
isOpen=function(_self)
return _self.config.rankNum2>0
end,
reqRankData=function(_self)

local selfXmGuildId=xianmengModel:myXMGuildID()or Int64_0
selfXmGuildId=tostring(selfXmGuildId)
activitiesController:sendProtocol(actSendType.eComonReqHandle,_self.activityId,_self.subType,_self.subId,jsonHelper.encode({1,selfXmGuildId}))
end,
getData=function(_self)
return _self.activityData.data.xmRankData,_self.activityData.data.xmRankItemInfoLookup,_self.config.join_reward2,_self.selfXmRewardScrollView,_self.config.rankNum2
end,
freshRankInfo=function(_self)

_self:refreshXmRankInfo()
end,
freshInfo=function(_self)

_self:refreshXMInfo()
end,
getBgInfo=function(_self)
return _self.config.ad_res_info2,_self.config.bg_res_info2
end,
},
}




function UISubAct_CrossRankingMainWin:onLoaded(...)
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

self.goJoinXmLinkTxt:setText(FMT.fmt("<a;前往加入;1;1;21;/>"))
end


function UISubAct_CrossRankingMainWin:__delete()

self:clearTimer()
_this=nil

self:unbindComponents()
end




function UISubAct_CrossRankingMainWin:onShow(argtable,afterOnloaded)
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

self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

local isShowInfomationBtn=self.config.infomation_args~=nil
self.infoBtn:setActive(isShowInfomationBtn)

local isShowServerListBtn=self.config.bigCross~=nil
if isShowServerListBtn then
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jsonHelper.encode({2}))
end
self.serverListBtn:setActive(isShowServerListBtn)

self:refreshTab()




self:preFresh()

_thisActId=self.config.id
end


function UISubAct_CrossRankingMainWin:onHide()

end


function UISubAct_CrossRankingMainWin:onShowArgRecv(args)

self:onShow(args)
end

function UISubAct_CrossRankingMainWin:preFresh()
self.canvasGroupLayout:setChildCanvasGroupAlpha(0)
end

function UISubAct_CrossRankingMainWin:refresh()
self:showBg()

self.canvasGroupLayout:setChildCanvasGroupDOFade(1,0.2)

local isPlayerRank=self.rankType==_tabEnum.ePlayer
local isXmRank=self.rankType==_tabEnum.eXianmeng

local isHasXm=xianmengModel:hasXM()



self.selfInfo:setActive(isPlayerRank or(isXmRank and isHasXm))
self.noXm:setActive(isXmRank and not isHasXm)

self.rankPlayer:setActive(isPlayerRank)
self.rankXM:setActive(isXmRank)

self.playerInfo:setActive(isPlayerRank)
self.xmInfo:setActive(isXmRank)


local tabConfig=_tabConfig[self.rankType]

self.activityRankData,self.activityRankLookup,self.join_reward,self.selfRewardScrollView,self.rankNum=tabConfig.getData(self)

tabConfig.freshRankInfo(self)
tabConfig.freshInfo(self)

self:refreshSelfCommonInfo()

self:freshBtns()


self:setRemainingTimeTimer()
end

function UISubAct_CrossRankingMainWin:showBg()
local artWoldArgs,bg_res_info=_tabConfig[self.rankType].getBgInfo(self)

local isShowArtWold=artWoldArgs~=nil
self.title:setActive(isShowArtWold)
if isShowArtWold then
local artWoldAb=artWoldArgs[1]
local artWoldName=artWoldArgs[2]
self.title:setCSImageSprite(artWoldAb,artWoldName)
end

local bgType=bg_res_info[1]
self.spriteBg:setActive(bgType==1)
self.bgSpine:setActive(bgType==2)
if bgType==1 then
local args=bg_res_info[2]
self.spriteBg:setCSImageSprite(args[1],args[2])
elseif bgType==2 then
local spineId=bg_res_info[2]
self.bgSpine:setChildUIModelShowTarget(spineId,1,{},eAnimationID.stand)
end
end


function UISubAct_CrossRankingMainWin:refreshTab()
local isShowTab=self.tablen>1
self.rankTab:setActive(isShowTab)

if not isShowTab then return end

for index=1,#self.rankTabItem do
local obj=self.rankTabItem[index]

local config=_this.tabConfig[index]
local isShow=config~=nil
obj:setActive(isShow)

if isShow then
local item=obj:getWidgetBase()
local isSelect=index==_this.tabIndex
item:SetChildActive(0,isSelect)
item:SetChildText(1,config.name)

item:SetBaseItemClickEvent(-1,function()
if index==_this.tabIndex then return end

local preItem=_this.rankTabItem[_this.tabIndex]
preItem=preItem:getWidgetBase()
preItem:SetChildActive(0,false)

_this.tabIndex=index
_this.rankType=_this.tabConfig[_this.tabIndex].type
item:SetChildActive(0,true)

_this:refresh()
end)
end
end
end

function UISubAct_CrossRankingMainWin:refreshSelfCommonInfo()
local number=self.activityRankData.myRank
local rewardList=self.join_reward

local numStr=toColorString(FONT_COLOR.eRedColor,"未上榜")

if number and number>0 and number<=self.rankNum then
numStr=number


local tempRewardList=self.activityRankLookup[self.activityRankData.myRewardIndex]
if tempRewardList~=nil then
rewardList=tempRewardList.reward
end
end

self.selfRankText:setText(numStr)

local hasRankBg=false
if number>0 and number<=3 then
hasRankBg=true
end
self.selfRankBg:setActive(hasRankBg)
local frameName=rankListModel.getFrameName(number)
if frameName then
self.selfRankBg:setSprite(globalABLookup.rankList,frameName)
else
self.selfRankBg:setImageIcon("",false)
end


local rewardLen=#rewardList
self.selfRewardScrollView:setChildScrollViewCreateGrids(rewardLen,rewardLen)
local grids=self.selfRewardScrollView:getChildScrollViewItemWidgets()
local gCount=grids.Count
for gIndex=1,gCount do
local ritem=grids[gIndex-1]
local rData=rewardList[gIndex]
local isShowRewardItem=rData~=nil
ritem:SetChildActive(-1,isShowRewardItem)
if isShowRewardItem then
local itemid=rData[1]
local itemcount=rData[2]
local showCountBG=itemcount>1
local itemCountStr=showCountBG and itemcount or""

local conf={itemid=itemid,itemcount=itemCountStr,showCountBG=showCountBG,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
ritem:SetChildPropData(0,propData)
ritem:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
end
end
end


function UISubAct_CrossRankingMainWin:refreshPlayerRankInfo()

self.totalRankList=self.activityRankLookup

local rankPlayerWB=self.rankPlayer:getWidgetBase()


for i=1,3 do
local widget=rankPlayerWB:GetChildWidgetBase(i-1)
local rankData=self.totalRankList[i]
if rankData.rankPlayerLen==0 then
widget:SetChildActive(item_index.have,false)
widget:SetChildActive(item_index.nothave,true)
widget:SetChildButtonClick(item_index.click,function()end,true)
else
local actorInfo=rankData.rankPlayerList[1]
widget:SetChildActive(item_index.have,actorInfo~=nil)
widget:SetChildActive(item_index.nothave,actorInfo==nil)
if actorInfo then
local headArgs={}
headArgs.iconInfo=actorInfo.iconInfo
headArgs.scale=0.75
playerController:setHeadIcon(widget,-1,headArgs)


widget:SetChildButtonClick(item_index.click,function()
_this:onClickPlayer(actorInfo.actorid,actorInfo.serverId)
end,true)

local zmName=actorInfo.sectname
local playerName=actorInfo.actorname
widget:SetChildText(item_index.zmname,zmName)
widget:SetChildText(item_index.playername,playerName)
local score=actorInfo.score or 0
score=tonumber(tostring(score))
local scoreInfo=FMT.fmt("{0}{1}",mathHelper.formatNumber9(score,2),self.config.rank_val_unit_name)
widget:SetChildText(item_index.floorcount,scoreInfo)


if tostring(actorInfo.discipledata)~='0'then
local imageInfo=UIDiscipleModel.calculationDiscipleImage(actorInfo.discipledata,actorInfo.discipleimage)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
widget:SetChildUIModelShowTarget(item_index.model,modelParams.body,0.75,modelParams.componets,eAnimationID.stand)
else

end
end
end
end
end

local _playerInfoCmpIndex={
head=0,
name=1,
count=2,
}
function UISubAct_CrossRankingMainWin:refreshPlayerInfo()
local widget=self.playerInfo:getWidgetBase()


local score=self.activityRankData.myScore or 0
score=tonumber(tostring(score))
local val_name=self.config.rank_val_name
local val_unit_name=self.config.rank_val_unit_name
local scoreInfo=FMT.fmt("<color=#7d3b17>{0}{1}</color>",mathHelper.formatNumber9(score,2),val_unit_name)
if pfwindowslController:checkIsGameVersion_yuenan()then
scoreInfo=FMT.fmt("<color=#7d3b17>{1} {0}</color>",mathHelper.formatNumber9(score,2),val_unit_name)
end
widget:SetChildText(_playerInfoCmpIndex.count,scoreInfo)


local headArgs={}
headArgs.iconInfo=playerModel:getActorIconInfo()
headArgs.scale=0.75
playerController:setHeadIcon(widget,_playerInfoCmpIndex.head,headArgs)


widget:SetChildText(_playerInfoCmpIndex.name,playerModel:getActorName())
end


local _xmRankInfoCmpIndex={
xmName=0,
serverName=1,
count=2,
nohave=3,
have=4,
click=5,
signBgIcon=6,
signIcon=7,
signKuangIcon=8,
chakan=9,
info=10,
}
function UISubAct_CrossRankingMainWin:refreshXmRankInfo()

local rankXMWB=self.rankXM:getWidgetBase()

for i=1,3 do
local widget=rankXMWB:GetChildWidgetBase(i-1)

local rankData=self.activityRankLookup[i]
local isHasRankInfo=rankData.rankPlayerLen>0

widget:SetChildActive(_xmRankInfoCmpIndex.nohave,not isHasRankInfo)
widget:SetChildActive(_xmRankInfoCmpIndex.have,isHasRankInfo)
widget:SetChildActive(_xmRankInfoCmpIndex.chakan,isHasRankInfo)
widget:SetChildActive(_xmRankInfoCmpIndex.info,isHasRankInfo)


local xmName="虚位以待"
local serverName="虚位以待"
local score=0


if isHasRankInfo then
local subData=rankData.rankPlayerList[1]
xmName=subData.xmName
serverName=loginModel:getServerName(subData.xmServerId)
serverName=FMT.fmt("[{0}]",serverName)
score=subData.xmScore

local image=xianmengModel.splitGuildIcon(subData.xmIcon)
local signIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon')
widget:SetChildCSImageSprite(_xmRankInfoCmpIndex.signIcon,globalABLookup.xianmengicons,signIconName)

local signBgIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon')
widget:SetChildCSImageSprite(_xmRankInfoCmpIndex.signBgIcon,globalABLookup.xianmengicons,signBgIconName)

local signKuangIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon')
widget:SetChildCSImageSprite(_xmRankInfoCmpIndex.signKuangIcon,globalABLookup.xianmengicons,signKuangIconName)

widget:SetChildButtonClick(_xmRankInfoCmpIndex.click,function()
_this:onClickXM(subData.xmGuid)
end,true)
end

widget:SetChildText(_xmRankInfoCmpIndex.xmName,xmName)
widget:SetChildText(_xmRankInfoCmpIndex.serverName,serverName)

score=tonumber(tostring(score))
local val_name=self.config.rank_val_name
local val_unit_name=self.config.rank_val_unit_name
local scoreInfo=FMT.fmt("<color=#7d3b17>{0}{1}</color>",mathHelper.formatNumber9(score,2),val_unit_name)
widget:SetChildText(_xmRankInfoCmpIndex.count,scoreInfo)
end
end

local _xmInfoCmpIndex={
xmName=0,
score=1,
serverName=2,
signBgIcon=3,
signIcon=4,
signKuangIcon=5,
}
function UISubAct_CrossRankingMainWin:refreshXMInfo()
if not xianmengModel:hasXM()then return end

local widget=self.xmInfo:getWidgetBase()

local score=self.activityRankData.myScore or 0
score=tonumber(tostring(score))
local name=xianmengModel:getXMName()
local serverid=playerModel:getActorServerID()
local serverName=loginModel:getServerName(serverid)
serverName=FMT.fmt("[{0}]",serverName)
local val_name=self.config.rank_val_name
local val_unit_name=self.config.rank_val_unit_name
local scoreInfo=FMT.fmt("<color=#7d3b17>{0}{1}</color>",mathHelper.formatNumber9(score,2),val_unit_name)

widget:SetChildText(_xmInfoCmpIndex.xmName,name)
widget:SetChildText(_xmInfoCmpIndex.serverName,serverName)
widget:SetChildText(_xmInfoCmpIndex.score,scoreInfo)

local image=xianmengModel:getGuildImage()
local signIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon')
widget:SetChildCSImageSprite(_xmInfoCmpIndex.signIcon,globalABLookup.xianmengicons,signIconName)

local signBgIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon')
widget:SetChildCSImageSprite(_xmInfoCmpIndex.signBgIcon,globalABLookup.xianmengicons,signBgIconName)

local signKuangIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon')
widget:SetChildCSImageSprite(_xmInfoCmpIndex.signKuangIcon,globalABLookup.xianmengicons,signKuangIconName)
end






function UISubAct_CrossRankingMainWin:onClickPlayer(actorId,serverId)
local attach={
serverid=serverId
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end

function UISubAct_CrossRankingMainWin:onClickXM(guildId)
xianmengController:openXMDetailInfoWin(guildId,8)
end




function UISubAct_CrossRankingMainWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshRemainingTimeTimer()
end

self.timer=self:setTimer(1,0,func)

self:refreshRemainingTimeTimer()
end


function UISubAct_CrossRankingMainWin:refreshRemainingTimeTimer()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
if time>0 then

local time_str=FMT.fmt('排名结算时间：{0}',timeHelper.format_time_stamp11(time,true))
self.timeText:setText(time_str)
else
local residue=self.endTime-timeHelper.getServerShortTime()
if residue>0 then
local time_str=FMT.fmt('已结算，榜单公布时间：{0}',timeHelper.format_time_stamp11(residue,true))
self.timeText:setText(time_str)
else
self:clearTimer()
self.timeText:setText("活动已结束")
end

end
end



function UISubAct_CrossRankingMainWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_CrossRankingMainWin:freshBtns()

local reddot=self.activityData:checkDailyReward()
self.dailyRewardBtn:setActive(reddot)
end





function UISubAct_CrossRankingMainWin:onDailyRewardBtn()
local cb=function()

self:freshBtns()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,_this.subType)
activitiesModel:callRefreshActEnter(_this.activityId,_this.subType,_this.subId,"onUIEnterBigActivityIconChange",_this.activityId)
end

local data={self.activityId,self.subType,self.subId}
FreeGiftController.SendFreeGift(self.config.free_gift_id,data,cb)
end



function UISubAct_CrossRankingMainWin:onShowRankBtn()
UIManager:showWindow("UISubAct_CrossRankingInfoWin",self.argtable)
end



function UISubAct_CrossRankingMainWin:onUpRankingBtn()
local args={
argtable=self.argtable,
rankType=self.rankType,
}
UIManager:showWindow("UISubAct_CrossRankingUpWin",args)
end

function UISubAct_CrossRankingMainWin:onInfoBtn()
local d=self.config.infomation_args
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_CrossRankingMainWin:onGoJoinXmBtn()
jumpManager:jump({id=JUMP_TYPE.eXianMengJoin})
end

function UISubAct_CrossRankingMainWin:onServerListBtn()
local data=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)or defaultT
local crossIdList=data.crossIdList
if crossIdList and#crossIdList>0 then
self:showWindow("UISubAct_CrossRankingServerListWin",crossIdList)
end
end
