







def_class("UICJXYChapterRankListWin",UIWindowBase)









function UICJXYChapterRankListWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.fieldTx_1=UIText.get(self,2)
self.fieldTx_2=UIText.get(self,3)
self.fieldTx_3=UIText.get(self,4)
self.fieldTx_4=UIText.get(self,5)
self.private=UIObject.get(self,6)
self.scroller=UIEnhancedScrollerLua.get(self,7)
self.tabItem_1=UIObject.get(self,8)
self.tabItem_2=UIObject.get(self,9)
self.tips=UIText.get(self,10)
self.titleTx=UIText.get(self,11)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.fieldTx={
self.fieldTx_1,
self.fieldTx_2,
self.fieldTx_3,
self.fieldTx_4,
}
self.tabItem={
self.tabItem_1,
self.tabItem_2,
}



end


function UICJXYChapterRankListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.fieldTx_1);self.fieldTx_1=nil;
_UIObject_release(self.fieldTx_2);self.fieldTx_2=nil;
_UIObject_release(self.fieldTx_3);self.fieldTx_3=nil;
_UIObject_release(self.fieldTx_4);self.fieldTx_4=nil;
_UIObject_release(self.private);self.private=nil;
_UIObject_release(self.scroller);self.scroller=nil;
_UIObject_release(self.tabItem_1);self.tabItem_1=nil;
_UIObject_release(self.tabItem_2);self.tabItem_2=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.titleTx);self.titleTx=nil;
self.fieldTx=nil;
self.tabItem=nil;
end















local _this=nil
local _privateCmp={
noImg=0,
noTx=1,
playerBg=2,
playerHead=3,
playerHeadIcon=4,
guildBg=5,
guildIcon=6,
guildKuangIcon=7,
nameTx=8,
serverTx=9,
scoreTx=10,
rewards=11,
flag_1=12,
flag_2=13,
emptyReward=14,
}
local _itemCmp={
noImg=0,
noTx=1,
nameTx=2,
serverTx=3,
scoreTx=4,
rewards=5,
playerList=6,
guildList=7,
infoTx=8,
}
local _tabCmp={
root=-1,
clickBtn=0,
nameTx=1,
}
local _tabName={
"个人","仙盟"
}
local _titleStr={
{"名次","祖师",nil,"奖励"},
{"名次","仙盟",nil,"奖励"},
}
local menu_slot_name="button_dytab"
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UICJXYChapterRankListWin:onLoaded(...)
self:bindComponents()
_this=self

self.privateWidget=self.private:getChildWidgetBase()
self.scrollerScript=UIPrepareEnScroller(self.scroller:getGameObject(),self.scroller:getCSharpObject(),nil,nil)
self.scrollerScript.window=self
end


function UICJXYChapterRankListWin:__delete()
self:unbindComponents()
_this=nil
end




function UICJXYChapterRankListWin:onShow(argtable,afterOnloaded)
self.handleType=argtable.handleType
self.stageIdx=argtable.stageIdx
self.selectIdx=argtable.selectIdx
self.parentWin=argtable.parentWin
self.stageType=seasonModel:getHandleConfig(self.handleType,"chapter_list",self.stageIdx,2)
self.stageCfg=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)

local show1=self.stageCfg.person_rank_cnt~=nil
local show2=self.stageCfg.guild_rank_cnt~=nil
local show=show1 and show2
self.tabItem_1:setActive(show)
self.tabItem_2:setActive(show)
if self.selectIdx==nil then
if show1 then
self.selectIdx=eSeasonRankType.ePlayer
elseif show2 then
self.selectIdx=eSeasonRankType.eGuild
end
elseif self.selectIdx==eSeasonRankType.ePlayer and not show1 then
self.selectIdx=eSeasonRankType.eGuild
elseif self.selectIdx==eSeasonRankType.eGuild and not show2 then
self.selectIdx=eSeasonRankType.ePlayer
end

self.banClickTab=#self.tabItem
for i,v in ipairs(self.tabItem)do
local widget=v:getChildWidgetBase()
widget:SetChildButtonClick(_tabCmp.clickBtn,function()
self:onClickTab(i)
end)
widget:SetChildUIModelShowTarget(_tabCmp.root,2017,1,{},eAnimationID.common_window_enter,false,false,0,function()
self:refreshTabSelect(widget,self.selectIdx==i)
widget:SetChildCanvasGroupAlpha(_tabCmp.nameTx,1)
self.banClickTab=self.banClickTab-1
end)
end

self:refreshRankView()
end


function UICJXYChapterRankListWin:onHide()

end




function UICJXYChapterRankListWin:onBackground()
self:onCloseBtn()
end


function UICJXYChapterRankListWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UICJXYChapterRankListWin:onClickTab(index)
if self.banClickTab>0 then return end
if self.selectIdx~=index then
self:refreshTabSelectEx(self.selectIdx,false)
self.selectIdx=index
self:refreshTabSelectEx(self.selectIdx,true)
self:refreshRankView()
end
end

function UICJXYChapterRankListWin:refreshTabSelectEx(index,select)
local item=self.tabItem[index]:getChildWidgetBase()
self:refreshTabSelect(item,select)
end

function UICJXYChapterRankListWin:refreshTabSelect(item,select)
local name=FMT.fmt("{0}_{1}",menu_slot_name,select and 2 or 1)
item:SetChildUIModelShowSlotAttachment(_tabCmp.root,menu_slot_name,name)
end

function UICJXYChapterRankListWin:refreshRankView()
self.titleTx:setText(FMT.fmt("{0}排行",_tabName[self.selectIdx]))

local tipsStr=self.stageCfg[self.selectIdx==eSeasonRankType.ePlayer and"person_rank_tips"or"guild_rank_tips"]
self.tips:setText(tipsStr)
self.winlua:ForceLayoutRect(self.tips:getID())
self:refreshTitleList()
self:refreshPrivate()
self:refreshRankList()
end

function UICJXYChapterRankListWin:refreshTitleList()
local titleStrs=_titleStr[self.selectIdx]
for i,v in ipairs(self.fieldTx)do
if titleStrs[i]then
v:setText(titleStrs[i])
else
v:setText(self.stageCfg.score_title)
end
end
end

function UICJXYChapterRankListWin:refreshRankList()
self.rankDatas=seasonModel:getRankList(self.handleType,self.stageIdx,self.selectIdx)or{}
self.rankConfigs=self.stageCfg[self.selectIdx==eSeasonRankType.ePlayer and'person_rank_reward'or'guild_rank_reward']
self.scrollerScript:initData(self.rankConfigs,94,#self.rankConfigs)
end

function UICJXYChapterRankListWin:refreshPrivate()
if self.selectIdx==eSeasonRankType.eGuild and not xianmengModel:hasXM()then
self.privateWidget:SetChildLayoutGroupCreateItems(_privateCmp.rewards,0)
self.privateWidget:SetChildActive(_privateCmp.playerBg,false)
self.privateWidget:SetChildActive(_privateCmp.guildBg,false)
self.privateWidget:SetChildCSImageIcon(_privateCmp.noImg,"",false)
self.privateWidget:SetChildText(_privateCmp.noTx,"")
self.privateWidget:SetChildText(_privateCmp.scoreTx,"未加入仙盟")
return
end

local rankData=seasonModel:getMyRank(self.handleType,self.stageIdx,self.selectIdx)
if rankData then
if rankData.rank<=3 then
self.privateWidget:SetChildCSImageSprite(_privateCmp.noImg,globalABLookup.global,FMT.fmt("icon_phbmingci_{0}",rankData.rank))
else
self.privateWidget:SetChildCSImageIcon(_privateCmp.noImg,"",false)
end
self.privateWidget:SetChildText(_privateCmp.noTx,rankData.rank)
else
self.privateWidget:SetChildCSImageIcon(_privateCmp.noImg,"",false)
self.privateWidget:SetChildText(_privateCmp.noTx,"<color=#c82c2c>未上榜</color>")
end

self.privateWidget:SetChildActive(_privateCmp.playerBg,self.selectIdx==eSeasonRankType.ePlayer)
self.privateWidget:SetChildActive(_privateCmp.guildBg,self.selectIdx==eSeasonRankType.eGuild)
self.privateWidget:SetChildActive(_privateCmp.flag_1,self.selectIdx==eSeasonRankType.ePlayer)
self.privateWidget:SetChildActive(_privateCmp.flag_2,self.selectIdx==eSeasonRankType.eGuild)

local score=rankData and rankData.score or 0
score=seasonModel:getRankScoreStr(self.stageType,score)
score=FMT.fmt("{0}{1}",score,self.stageCfg.score_unit or"")
if self.selectIdx==2 then
self.privateWidget:SetChildText(_privateCmp.scoreTx,score)

local detailData=xianmengModel:getMyXMDetialData()
local serverName=FMT.fmt("[{0}]",loginModel:getServerName(detailData.leaderserverid))
self.privateWidget:SetChildText(_privateCmp.nameTx,detailData.guildname or"")
self.privateWidget:SetChildText(_privateCmp.serverTx,serverName)

local image=xianmengModel.splitGuildIcon(detailData.guildicon)
local abname=globalABLookup.xianmengicons
self.privateWidget:SetChildCSImageSprite(_privateCmp.guildIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
self.privateWidget:SetChildCSImageSprite(_privateCmp.guildBg,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
self.privateWidget:SetChildCSImageSprite(_privateCmp.guildKuangIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
self.privateWidget:SetChildText(_privateCmp.nameTx,playerModel:getActorName())
self.privateWidget:SetChildText(_privateCmp.serverTx,FMT.fmt("[{0}]",loginModel:getMyServerName()))
self.privateWidget:SetChildText(_privateCmp.scoreTx,score)

playerController:setHeadIcon(self.privateWidget,_privateCmp.playerHead,{scale=0.6})
end

local rewards={}
if rankData then
local rewardCol=self.selectIdx==eSeasonRankType.ePlayer and"person_rank_reward"or"guild_rank_reward"
local rewardCfg=self.stageCfg[rewardCol]
for i,v in ipairs(rewardCfg)do
if v[1]<=rankData.rank and rankData.rank<=v[2]then
rewards=v[3]
break
end
end
end
local rewardCnt=#rewards
self.privateWidget:SetChildLayoutGroupCreateItems(_privateCmp.rewards,rewardCnt,function(index)
local item=self.privateWidget:GetChildLayoutGroupGridItem(_privateCmp.rewards,index-1)
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
self.privateWidget:SetChildActive(_privateCmp.emptyReward,rewardCnt<=0)
end

function UICJXYChapterRankListWin:refreshRankItem(dataIndex,cell)
local rankConfig=self.rankConfigs[dataIndex]
local rankNum=rankConfig[2]-rankConfig[1]+1
local rankData=seasonModel:getMyRank(self.handleType,self.stageIdx,self.selectIdx)
if rankNum==1 then
if rankConfig[1]<=3 then
cell:SetChildCSImageSprite(_itemCmp.noImg,globalABLookup.global,FMT.fmt("icon_phbmingci_{0}",rankConfig[1]))
else
cell:SetChildCSImageIcon(_itemCmp.noImg,"",false)
end
cell:SetChildText(_itemCmp.noTx,rankConfig[1])
else
cell:SetChildCSImageIcon(_itemCmp.noImg,"",false)
cell:SetChildText(_itemCmp.noTx,FMT.fmt("{0}~{1}",rankConfig[1],rankConfig[2]))
end

if self.selectIdx==eSeasonRankType.eGuild then
local count=math.min(rankNum,4)
local first=nil
cell:SetChildLayoutGroupClearAllItems(_itemCmp.guildList)
cell:SetChildLayoutGroupClearAllItems(_itemCmp.playerList)
cell:SetChildLayoutGroupCreateItems(_itemCmp.guildList,count,function(index)
local item=cell:GetChildLayoutGroupGridItem(_itemCmp.guildList,index-1)
local data=seasonModel:getRankData(self.handleType,self.stageIdx,self.selectIdx,rankConfig[1]+index-1)
first=first or data
if data then
local image=xianmengModel.splitGuildIcon(data.guildicon)
local abname=globalABLookup.xianmengicons
item:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
item:SetChildCSImageSprite(-1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
item:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
item:SetChildButtonClick(-1,function()
xianmengController:openXMDetailInfoWin(data.guildid)
end)
end
end)
if rankNum<=1 and first then
local serverName=FMT.fmt("[{0}]",loginModel:getServerName(first.leaderserverid))
local score=first.score
score=seasonModel:getRankScoreStr(self.stageType,score)
cell:SetChildText(_itemCmp.nameTx,first.guildname)
cell:SetChildText(_itemCmp.serverTx,serverName)
cell:SetChildText(_itemCmp.scoreTx,FMT.fmt("<color=#7D3B17>{0}{1}</color>",score,self.stageCfg.score_unit or""))
cell:SetChildText(_itemCmp.infoTx,"")
elseif not first then
cell:SetChildText(_itemCmp.nameTx,'')
cell:SetChildText(_itemCmp.serverTx,'')
cell:SetChildText(_itemCmp.scoreTx,'虚位以待')
cell:SetChildText(_itemCmp.infoTx,'虚位以待')
else
cell:SetChildText(_itemCmp.nameTx,'')
cell:SetChildText(_itemCmp.serverTx,'')
cell:SetChildText(_itemCmp.scoreTx,'')
cell:SetChildText(_itemCmp.infoTx,'')
end
else
local count=math.min(rankNum,4)
local first=nil
cell:SetChildLayoutGroupClearAllItems(_itemCmp.guildList)
cell:SetChildLayoutGroupClearAllItems(_itemCmp.playerList)
cell:SetChildLayoutGroupCreateItems(_itemCmp.playerList,count,function(index)
local item=cell:GetChildLayoutGroupGridItem(_itemCmp.playerList,index-1)
local data=seasonModel:getRankData(self.handleType,self.stageIdx,self.selectIdx,rankConfig[1]+index-1)
first=first or data
if data then
playerController:setHeadIcon(item,0,{iconInfo=data.iconInfo,scale=0.6})
item:SetChildButtonClick(-1,function()
otherPlayerController:openOtherPlayerInfoWin(data.actor_id,nil,nil,{serverid=data.server_id})
end)
end
end)
if rankNum<=1 and first then
local serverName=FMT.fmt("[{0}]",loginModel:getServerName(first.server_id))
local score=first.score
score=seasonModel:getRankScoreStr(self.stageType,score)
cell:SetChildText(_itemCmp.nameTx,first.actor_name)
cell:SetChildText(_itemCmp.serverTx,serverName)
cell:SetChildText(_itemCmp.scoreTx,FMT.fmt("<color=#7D3B17>{0}{1}</color>",score,self.stageCfg.score_unit or""))
cell:SetChildText(_itemCmp.infoTx,'')
elseif not first then
cell:SetChildText(_itemCmp.nameTx,'')
cell:SetChildText(_itemCmp.serverTx,'')
cell:SetChildText(_itemCmp.scoreTx,'虚位以待')
cell:SetChildText(_itemCmp.infoTx,'虚位以待')
else
cell:SetChildText(_itemCmp.nameTx,'')
cell:SetChildText(_itemCmp.serverTx,'')
cell:SetChildText(_itemCmp.scoreTx,'')
cell:SetChildText(_itemCmp.infoTx,'')
end
end

local rewards=rankConfig[3]
local rewardCnt=#rewards
cell:SetChildLayoutGroupCreateItems(_itemCmp.rewards,rewardCnt,function(index)
local item=cell:GetChildLayoutGroupGridItem(_itemCmp.rewards,index-1)
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
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
self.window:refreshRankItem(dataIndex,cell)
end