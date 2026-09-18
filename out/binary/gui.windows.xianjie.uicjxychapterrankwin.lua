







def_class("UICJXYChapterRankWin",UIWindowBase)









function UICJXYChapterRankWin:bindComponents()

self.guild_1=UIObject.get(self,0)
self.guild_2=UIObject.get(self,1)
self.guild_3=UIObject.get(self,2)
self.player_1=UIObject.get(self,3)
self.player_2=UIObject.get(self,4)
self.player_3=UIObject.get(self,5)
self.private=UIObject.get(self,6)
self.tabBtn_1=UIButton.get(self,7)
self.tabBtn_2=UIButton.get(self,8)
self.timeTx=UIText.get(self,9)
self.titleImg=UIImage.get(self,10)

self.tabBtn_1:setButtonClick(function()self:onTabBtn_1()end)

self.tabBtn_2:setButtonClick(function()self:onTabBtn_2()end)
self.guild={
self.guild_1,
self.guild_2,
self.guild_3,
}
self.player={
self.player_1,
self.player_2,
self.player_3,
}
self.tabBtn={
self.tabBtn_1,
self.tabBtn_2,
}



end


function UICJXYChapterRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.guild_1);self.guild_1=nil;
_UIObject_release(self.guild_2);self.guild_2=nil;
_UIObject_release(self.guild_3);self.guild_3=nil;
_UIObject_release(self.player_1);self.player_1=nil;
_UIObject_release(self.player_2);self.player_2=nil;
_UIObject_release(self.player_3);self.player_3=nil;
_UIObject_release(self.private);self.private=nil;
_UIObject_release(self.tabBtn_1);self.tabBtn_1=nil;
_UIObject_release(self.tabBtn_2);self.tabBtn_2=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
self.guild=nil;
self.player=nil;
self.tabBtn=nil;
end















local _this=nil
local _tabCmp={
select=0,
}
local _privateCmp={
empty=0,
emptyBtn=1,
have=2,
noTx=3,
upBtn=4,
rewardView=5,
rewardList=6,
rankBtn=7,
guildInfo=8,
guildName=9,
guildServer=10,
guildScore=11,
playerInfo=12,
playerName=13,
playerScore=14,
rewardEmpty=15,
}
local _guildCmp={
root=-1,
have=0,
empty=1,
check=2,
name=3,
server=4,
score=5,
guildBG=6,
guildIcon=7,
guildKuangIcon=8,
}
local _playerCmp={
root=-1,
have=0,
empty=1,
playerBG=2,
playerHead=3,
playerHeadIcon=4,
server=5,
name=6,
score=7,
}



function UICJXYChapterRankWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSeasonRankChange,self.onSeasonRankChange)
self:initView()
end


function UICJXYChapterRankWin:__delete()
self:unbindComponents()
_this=nil
end




function UICJXYChapterRankWin:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.stageType=seasonModel:getHandleConfig(self.showParams.handleType,"chapter_list",self.showParams.stageIdx,2)
self.stageCfg=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx)

local seasonName=seasonModel:getHandleConfig(self.showParams.handleType,"name")
local stageName=self.stageCfg.name
local timeStr=FMT.fmt("排行结算时间：完成【{0}·{1}】",seasonName,stageName)
self.timeTx:setText(timeStr)

local titleImg=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx,"rankTitle")
self.titleImg:setSprite(titleImg[1],titleImg[2])

local show1=self.stageCfg.person_rank_cnt~=nil
local show2=self.stageCfg.guild_rank_cnt~=nil
local show=show1 and show2
self.tabBtn_1:setActive(show)
self.tabBtn_2:setActive(show)
if self.showParams.funcIdx2==nil then
if show1 then
self.showParams.funcIdx2=eSeasonRankType.ePlayer
elseif show2 then
self.showParams.funcIdx2=eSeasonRankType.eGuild
end
elseif self.showParams.funcIdx2==eSeasonRankType.ePlayer and not show1 then
self.showParams.funcIdx2=eSeasonRankType.eGuild
elseif self.showParams.funcIdx2==eSeasonRankType.eGuild and not show2 then
self.showParams.funcIdx2=eSeasonRankType.ePlayer
end
self:reqRankData()

for i,v in ipairs(self.tabBtn)do
self:refreshTabSelect(i,self.showParams.funcIdx2==i)
end
self:refreshPrivate()
self:refreshRank()
end


function UICJXYChapterRankWin:onHide()

end




function UICJXYChapterRankWin:onTabBtn_1()
self:onClickTab(1)
end


function UICJXYChapterRankWin:onTabBtn_2()
self:onClickTab(2)
end

function UICJXYChapterRankWin:onClickUpBtn()
local colName=self.showParams.funcIdx2==eSeasonRankType.ePlayer and"person_rank_jump"or"guild_rank_jump"
local jumps=self.stageCfg[colName]
local scoreName=self.stageCfg.score_name
local args={
scoreName=scoreName,
jumps=jumps,
parentWin=self,
}
self:showWindow("UICJXYChapterRankScoreWayWin",args)
end

function UICJXYChapterRankWin:onClickRankBtn()
local args={
handleType=self.showParams.handleType,
stageIdx=self.showParams.stageIdx,
selectIdx=self.showParams.funcIdx2,
parentWin=self,
}
self:showWindow("UICJXYChapterRankListWin",args)
end

function UICJXYChapterRankWin:onClickEmptyBtn()
jumpManager:jump({id=4805})
end

function UICJXYChapterRankWin:onClickTab(index)
local selectIdx=self.showParams.funcIdx2
if selectIdx~=index then
self:refreshTabSelect(selectIdx,false)
self.showParams.funcIdx2=index
self:reqRankData()
self:refreshTabSelect(index,true)
self:refreshPrivate()
self:refreshRank()
end
end

function UICJXYChapterRankWin:onClickPlayer(index)
local rankData=seasonModel:getRankData(self.showParams.handleType,self.showParams.stageIdx,eSeasonRankType.ePlayer,index)
if rankData then
otherPlayerController:openOtherPlayerInfoWin(rankData.actor_id,nil,nil,{serverid=rankData.server_id})
end
end

function UICJXYChapterRankWin:onClickGuild(index)
local rankData=seasonModel:getRankData(self.showParams.handleType,self.showParams.stageIdx,eSeasonRankType.eGuild,index)
if rankData then
local wincfg=UIManager.get_window_config(self.__name)
xianmengController:openXMDetailInfoWin(rankData.guildid,wincfg.canvas+1)
end
end

function UICJXYChapterRankWin:reqRankData()
if self.showParams.funcIdx2==eSeasonRankType.ePlayer then
seasonController:send_39_5(self.showParams.handleType,self.showParams.stageIdx)
else
seasonController:send_39_6(self.showParams.handleType,self.showParams.stageIdx)
end
end

function UICJXYChapterRankWin:refreshTabSelect(index,select)
local widget=self.tabBtn[index]:getChildWidgetBase()
widget:SetChildActive(_tabCmp.select,select)
end

function UICJXYChapterRankWin:initView()
self.privateWidget=self.private:getChildWidgetBase()
self.privateWidget:SetChildText(_privateCmp.playerName,playerModel:getActorName())

local hasXM=xianmengModel:hasXM()
if hasXM then
local detailData=xianmengModel:getMyXMDetialData()
local serverName=FMT.fmt("[{0}]",loginModel:getServerName(detailData.leaderserverid))
self.privateWidget:SetChildText(_privateCmp.guildName,detailData.guildname or"")
self.privateWidget:SetChildText(_privateCmp.guildServer,serverName)
end

self.privateWidget:SetChildButtonClick(_privateCmp.upBtn,function()
self:onClickUpBtn()
end)
self.privateWidget:SetChildButtonClick(_privateCmp.rankBtn,function()
self:onClickRankBtn()
end)
self.privateWidget:SetChildButtonClick(_privateCmp.emptyBtn,function()
self:onClickEmptyBtn()
end)

for i,v in ipairs(self.player)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_playerCmp.root,function()
self:onClickPlayer(i)
end)
end

for i,v in ipairs(self.guild)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_guildCmp.root,function()
self:onClickGuild(i)
end)
end
end

function UICJXYChapterRankWin:refreshPrivate()
local have=self.showParams.funcIdx2==eSeasonRankType.ePlayer or xianmengModel:hasXM()
self.privateWidget:SetChildActive(_privateCmp.have,have)
self.privateWidget:SetChildActive(_privateCmp.empty,not have)
if have then
local myRank=seasonModel:getMyRank(self.showParams.handleType,self.showParams.stageIdx,self.showParams.funcIdx2)
self.privateWidget:SetChildText(_privateCmp.noTx,myRank and myRank.rank>0 and myRank.rank or"未上榜")

local rewards={}
if myRank then
local rewardCol=self.showParams.funcIdx2==eSeasonRankType.ePlayer and"person_rank_reward"or"guild_rank_reward"
local rewardCfg=self.stageCfg[rewardCol]
for i,v in ipairs(rewardCfg)do
if v[1]<=myRank.rank and myRank.rank<=v[2]then
rewards=v[3]
break
end
end
end
local rewardCnt=#rewards
self.privateWidget:SetChildLayoutGroupCreateItems(_privateCmp.rewardList,rewardCnt,function(index)
local item=self.privateWidget:GetChildLayoutGroupGridItem(_privateCmp.rewardList,index-1)
local data=rewards[index]
local itemId=data[1]
local itemNum=data[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=countStr,showname=false,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
self.privateWidget:SetChildScrollRectEnable(_privateCmp.rewardView,rewardCnt>3)
self.privateWidget:SetChildActive(_privateCmp.rewardEmpty,rewardCnt<=0)

self.privateWidget:SetChildActive(_privateCmp.guildInfo,self.showParams.funcIdx2==eSeasonRankType.eGuild)
self.privateWidget:SetChildActive(_privateCmp.playerInfo,self.showParams.funcIdx2==eSeasonRankType.ePlayer)
local scoreCmp=self.showParams.funcIdx2==eSeasonRankType.ePlayer and _privateCmp.playerScore or _privateCmp.guildScore
local rankName=self.showParams.funcIdx2==eSeasonRankType.ePlayer and"个人"or"仙盟"
local score=myRank and myRank.score or 0
score=seasonModel:getRankScoreStr(self.stageType,score)
local nameCol=self.showParams.funcIdx2==eSeasonRankType.ePlayer and"person_rank_score_name"or"guild_rank_score_name"
local preStr=self.stageCfg[nameCol]and FMT.fmt("{0}: ",self.stageCfg[nameCol])or""
local scoreStr=FMT.fmt("{1}<color=#CA631D>{0}</color>",score,preStr)
self.privateWidget:SetChildText(scoreCmp,scoreStr)

local colName=self.showParams.funcIdx2==eSeasonRankType.ePlayer and"person_rank_jump"or"guild_rank_jump"
local jumps=self.stageCfg[colName]
self.privateWidget:SetChildActive(_privateCmp.upBtn,jumps~=nil and#jumps>0)
end
end

function UICJXYChapterRankWin:refreshRank()
local showPlayer=self.showParams.funcIdx2==eSeasonRankType.ePlayer
for i,v in ipairs(self.player)do
v:setActive(showPlayer)
if showPlayer then
self:refreshPlayer(i,v)
end
end

local showGuild=self.showParams.funcIdx2==eSeasonRankType.eGuild
for i,v in ipairs(self.guild)do
v:setActive(showGuild)
if showGuild then
self:refreshGuild(i,v)
end
end
end

function UICJXYChapterRankWin:refreshPlayer(index,item)
local rankData=seasonModel:getRankData(self.showParams.handleType,self.showParams.stageIdx,eSeasonRankType.ePlayer,index)
local widget=item:getChildWidgetBase()
widget:SetChildActive(_playerCmp.have,rankData~=nil)
widget:SetChildActive(_playerCmp.empty,rankData==nil)
if rankData then
local serverName=FMT.fmt("[{0}]",loginModel:getServerName(rankData.server_id))
widget:SetChildText(_playerCmp.name,rankData.actor_name)
widget:SetChildText(_playerCmp.server,serverName)
local scoreName=self.stageCfg.person_rank_score_name and FMT.fmt("{0}: ",self.stageCfg.person_rank_score_name)or""
local scoreValue=seasonModel:getRankScoreStr(self.stageType,rankData.score)
local scoreStr=FMT.fmt("{1}<color=#CA631D>{0}</color>",scoreValue,scoreName)
widget:SetChildText(_playerCmp.score,scoreStr)

local replace={[PLAYER_IMAGE_TYPE.eBodyOrnament]=1}
playerController:setImage(widget,_playerCmp.playerHeadIcon,nil,rankData.iconInfo,false,nil,replace)
end
end

function UICJXYChapterRankWin:refreshGuild(index,item)
local rankData=seasonModel:getRankData(self.showParams.handleType,self.showParams.stageIdx,eSeasonRankType.eGuild,index)
local widget=item:getChildWidgetBase()
widget:SetChildActive(_guildCmp.have,rankData~=nil)
widget:SetChildActive(_guildCmp.empty,rankData==nil)
if rankData then
local serverName=FMT.fmt("[{0}]",loginModel:getServerName(rankData.leaderserverid))
widget:SetChildText(_guildCmp.name,rankData.guildname)
widget:SetChildText(_guildCmp.server,serverName)
local scoreName=self.stageCfg.guild_rank_score_name and FMT.fmt("{0}: ",self.stageCfg.guild_rank_score_name)or""
local scoreValue=seasonModel:getRankScoreStr(self.stageType,rankData.score)
local scoreStr=FMT.fmt("{1}<color=#CA631D>{0}</color>",scoreValue,scoreName)
widget:SetChildText(_guildCmp.score,scoreStr)

if rankData.guildicon>0 then
local image=xianmengModel.splitGuildIcon(rankData.guildicon)
local abname=globalABLookup.xianmengicons
widget:SetChildCSImageSprite(_guildCmp.guildIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
widget:SetChildCSImageSprite(_guildCmp.guildBG,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
widget:SetChildCSImageSprite(_guildCmp.guildKuangIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
widget:SetChildCSImageIcon(_guildCmp.guildBG,"",false)
widget:SetChildCSImageIcon(_guildCmp.guildIcon,"",false)
widget:SetChildCSImageIcon(_guildCmp.guildKuangIcon,"",false)
end
end
end

function UICJXYChapterRankWin.onSeasonRankChange(season_id,chapter_idx,rankType)
if _this.showParams.handleType==season_id and _this.showParams.stageIdx==chapter_idx and _this.showParams.funcIdx2==rankType then
_this:refreshPrivate()
_this:refreshRank()
end
end