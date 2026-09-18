







def_class("UIMJMBChapterRankListWin",UIWindowBase)









function UIMJMBChapterRankListWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.fieldTx_1=UIText.get(self,2)
self.fieldTx_2=UIText.get(self,3)
self.fieldTx_3=UIText.get(self,4)
self.fieldTx_4=UIText.get(self,5)
self.jifenBtn=UIButton.get(self,6)
self.jifenDesc_1=UIText.get(self,7)
self.jifenDesc_2=UIText.get(self,8)
self.jifenDesc_3=UIText.get(self,9)
self.jifenDesc_4=UIText.get(self,10)
self.jifenDescRect=UIButton.get(self,11)
self.jifenDescTip=UIObject.get(self,12)
self.private=UIObject.get(self,13)
self.scroller=UIEnhancedScrollerLua.get(self,14)
self.tabItem_1=UIObject.get(self,15)
self.tabItem_2=UIObject.get(self,16)
self.tabList=UIObject.get(self,17)
self.tips=UIText.get(self,18)
self.titleTx=UIText.get(self,19)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.jifenBtn:setButtonClick(function()self:onJifenBtn()end)

self.jifenDescRect:setButtonClick(function()self:onJifenDescRect()end)
self.fieldTx={
self.fieldTx_1,
self.fieldTx_2,
self.fieldTx_3,
self.fieldTx_4,
}
self.jifenDesc={
self.jifenDesc_1,
self.jifenDesc_2,
self.jifenDesc_3,
self.jifenDesc_4,
}
self.tabItem={
self.tabItem_1,
self.tabItem_2,
}



end


function UIMJMBChapterRankListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.fieldTx_1);self.fieldTx_1=nil;
_UIObject_release(self.fieldTx_2);self.fieldTx_2=nil;
_UIObject_release(self.fieldTx_3);self.fieldTx_3=nil;
_UIObject_release(self.fieldTx_4);self.fieldTx_4=nil;
_UIObject_release(self.jifenBtn);self.jifenBtn=nil;
_UIObject_release(self.jifenDesc_1);self.jifenDesc_1=nil;
_UIObject_release(self.jifenDesc_2);self.jifenDesc_2=nil;
_UIObject_release(self.jifenDesc_3);self.jifenDesc_3=nil;
_UIObject_release(self.jifenDesc_4);self.jifenDesc_4=nil;
_UIObject_release(self.jifenDescRect);self.jifenDescRect=nil;
_UIObject_release(self.jifenDescTip);self.jifenDescTip=nil;
_UIObject_release(self.private);self.private=nil;
_UIObject_release(self.scroller);self.scroller=nil;
_UIObject_release(self.tabItem_1);self.tabItem_1=nil;
_UIObject_release(self.tabItem_2);self.tabItem_2=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.titleTx);self.titleTx=nil;
self.fieldTx=nil;
self.jifenDesc=nil;
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
scrollView=15,
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
scrollView=9,
}
local _tabCmp={
root=-1,
clickBtn=0,
nameTx=1,
}
local _tabName={
"个人","仙盟"
}

local _tabConfigList={
[1]={
type=eSeasonRankType.ePlayer,
name="个人",
isShow=function(_self)
return _self.stageCfg.person_rank_cnt~=nil
end,
reqData=function(_self)
seasonController:send_39_5(_self.showParams.handleType,_self.showParams.stageIdx)
end
},
[2]={
type=eSeasonRankType.eGuild,
name="仙盟",
isShow=function(_self)
return _self.stageCfg.guild_rank_cnt~=nil
end,
reqData=function(_self)
seasonController:send_39_6(_self.showParams.handleType,_self.showParams.stageIdx)
end
},
}

local _titleStr={
{"名次","祖师",nil,"奖励"},
{"名次","仙盟",nil,"奖励"},
}
local menu_slot_name="button_dytab"
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UIMJMBChapterRankListWin:onLoaded(...)
self:bindComponents()
_this=self

self.privateWidget=self.private:getChildWidgetBase()
self.scrollerScript=UIPrepareEnScroller(self.scroller:getGameObject(),self.scroller:getCSharpObject(),nil,nil)
self.scrollerScript.window=self

self:addNotify(notifyConfig.onSeasonRankChange,self.onSeasonRankChange)

local _frsehWin1=function()
if _this.selectIdx==eSeasonRankType.ePlayer then
_this:refreshRankView()
end
end
local _frsehWin2=function()
if _this.selectIdx==eSeasonRankType.eGuild then
_this:refreshRankView()
end
end
self:addProNotify(39,5,_frsehWin1)
self:addProNotify(39,6,_frsehWin2)
end


function UIMJMBChapterRankListWin:__delete()
self:unbindComponents()
if self.closeBackFunc then
self.closeBackFunc()
self.closeBackFunc=nil
end
_this=nil
end




function UIMJMBChapterRankListWin:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.handleType=argtable.handleType
self.stageIdx=argtable.stageIdx
self.selectIdx=argtable.selectIdx
self.parentWin=argtable.parentWin
self.closeBackFunc=argtable.closeBackFunc
self.stageType=seasonModel:getHandleConfig(self.handleType,"chapter_list",self.stageIdx,2)
self.stageCfg=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)

self:refreshTabList()

self:refreshRankView()
end


function UIMJMBChapterRankListWin:onHide()

end




function UIMJMBChapterRankListWin:onBackground()
self:onCloseBtn()
end


function UIMJMBChapterRankListWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIMJMBChapterRankListWin:onClickTab(index)
if self.selectIdx~=index then
self:refreshTabSelectEx(self.selectIdx,false)
self.selectIdx=index
self:refreshTabSelectEx(self.selectIdx,true)

self:refreshRankView()
end
end

function UIMJMBChapterRankListWin:refreshTabList()
self.tabConfigList={}
for index,config in ipairs(_tabConfigList)do
if config.isShow(self)then
self.tabConfigList[#self.tabConfigList+1]=config
end
end

local isShowTabList=#self.tabConfigList>1
self.tabList:setActive(isShowTabList)

self.selectIdx=self.selectIdx or 1
if isShowTabList then
for i,v in ipairs(self.tabItem)do
local config=self.tabConfigList[i]
local isShow=config~=nil
v:setActive(isShow)

if isShow then
config.reqData(self)
local widget=v:getChildWidgetBase()
widget:SetChildText(1,config.name)
widget:SetChildButtonClick(_tabCmp.clickBtn,function()
self:onClickTab(i)
end)
widget:SetChildUIModelShowTarget(_tabCmp.root,2017,1,{},eAnimationID.common_window_enter,false,false,0,function()
self:refreshTabSelect(widget,self.selectIdx==i)
widget:SetChildCanvasGroupAlpha(_tabCmp.nameTx,1)
end)
end
end
end
end

function UIMJMBChapterRankListWin:refreshTabSelectEx(index,select)
local item=self.tabItem[index]:getChildWidgetBase()
self:refreshTabSelect(item,select)
end

function UIMJMBChapterRankListWin:refreshTabSelect(item,select)
local name=FMT.fmt("{0}_{1}",menu_slot_name,select and 2 or 1)
item:SetChildUIModelShowSlotAttachment(_tabCmp.root,menu_slot_name,name)
end

function UIMJMBChapterRankListWin:refreshRankView()
self.titleTx:setText(FMT.fmt("{0}排行",_tabName[self.selectIdx]))

local tipsStr=self.stageCfg[self.selectIdx==eSeasonRankType.ePlayer and"person_rank_tips"or"guild_rank_tips"]
self.tips:setActive(tipsStr~=nil and tipsStr~="")
if tipsStr then
self.tips:setText(tipsStr)
self.winlua:ForceLayoutRect(self.tips:getID())
end

local scoreDescStr=self.stageCfg[self.selectIdx==eSeasonRankType.ePlayer and"person_rank_score_desc"or"guild_rank_score_desc"]
self.jifenBtn:setActive(scoreDescStr~=nil)

self:refreshTitleList()
self:refreshPrivate()
self:refreshRankList()
end

function UIMJMBChapterRankListWin:refreshTitleList()
local titleStrs=_titleStr[self.selectIdx]
for i,v in ipairs(self.fieldTx)do
if titleStrs[i]then
v:setText(titleStrs[i])
else
v:setText(self.stageCfg.score_title)
end
end
end

function UIMJMBChapterRankListWin:refreshRankList()
self.rankDatas=seasonModel:getRankList(self.handleType,self.stageIdx,self.selectIdx)or{}
local list={}
if self.stageType==seasonStageType.eTZMJ then
local mojunData=xianjieModel:getMoJunData(self.handleType,self.stageIdx)
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu or 1)
list=cfg[self.selectIdx==eSeasonRankType.ePlayer and'person_rank_reward'or'guild_rank_reward']
else
list=self.stageCfg[self.selectIdx==eSeasonRankType.ePlayer and'person_rank_reward'or'guild_rank_reward']
end
self.rankConfigs={}
self.scroller:setChildScrollRectEnable(false)
self.scrollerScript:jumpToDataIndex(0,0,0,true,0,0,nil)
self.scroller:setChildScrollRectEnable(true)
self:clearScrollerTweener()

for i,v in ipairs(list)do
if v[4]==1 then
for rank=v[1],v[2]do
table.insert(self.rankConfigs,{rank,rank,v[3]})
end
elseif v[4]==2 then
for rank=v[1],v[2]do
if self.rankDatas[rank]then
table.insert(self.rankConfigs,{rank,rank,v[3]})
else
table.insert(self.rankConfigs,{rank,v[2],v[3]})
break
end
end
else
table.insert(self.rankConfigs,v)
end
end

self.scrollerScript:initData(self.rankConfigs,92,#self.rankConfigs)

self.scroller:setChildCanvasGroupAlpha(0)
self:delayDo(0.1,function()
if not _this then return end
_this.scrollerTweener=_this.scroller:setChildCanvasGroupDOFade(1,0.2,function()
_this.scrollerTweener=nil
end)
end)
end

function UIMJMBChapterRankListWin:clearScrollerTweener()
if self.scrollerTweener~=nil then
self.scrollerTweener:Complete()
self.scrollerTweener=nil
end
end

function UIMJMBChapterRankListWin:refreshPrivate()
if self.selectIdx==eSeasonRankType.eGuild and not xianmengModel:hasXM()then
self.privateWidget:SetChildLayoutGroupCreateItems(_privateCmp.rewards,0)
self.privateWidget:SetChildActive(_privateCmp.playerBg,false)
self.privateWidget:SetChildActive(_privateCmp.guildBg,false)
self.privateWidget:SetChildCSImageIcon(_privateCmp.noImg,"",false)
self.privateWidget:SetChildText(_privateCmp.noTx,"")
self.privateWidget:SetChildText(_privateCmp.scoreTx,"未加入仙盟")
self.privateWidget:SetChildText(_privateCmp.nameTx,"")
self.privateWidget:SetChildText(_privateCmp.serverTx,"")
return
end

local rankData=seasonModel:getMyRank(self.handleType,self.stageIdx,self.selectIdx)
if rankData and rankData.rank>0 then
if rankData.rank<=3 then
self.privateWidget:SetChildCSImageSprite(_privateCmp.noImg,globalABLookup.global,FMT.fmt("icon_phbmingci_{0}",rankData.rank))
else
self.privateWidget:SetChildCSImageIcon(_privateCmp.noImg,"",false)
end
self.privateWidget:SetChildText(_privateCmp.noTx,rankData.rank)
else
self.privateWidget:SetChildCSImageIcon(_privateCmp.noImg,"",false)
self.privateWidget:SetChildText(_privateCmp.noTx,"未上榜")
end

self.privateWidget:SetChildActive(_privateCmp.playerBg,self.selectIdx==eSeasonRankType.ePlayer)
self.privateWidget:SetChildActive(_privateCmp.guildBg,self.selectIdx==eSeasonRankType.eGuild)


self.privateWidget:SetChildActive(_privateCmp.flag_1,false)
self.privateWidget:SetChildActive(_privateCmp.flag_2,false)

local score=rankData and rankData.score or 0
score=seasonModel:getRankScoreStr(self.stageType,score,self.selectIdx)
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
local rewardCfg
local rewardCol=self.selectIdx==eSeasonRankType.ePlayer and"person_rank_reward"or"guild_rank_reward"
if self.stageType==seasonStageType.eTZMJ then
local mojunData=xianjieModel:getMoJunData(self.handleType,self.stageIdx)
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu or 1)
rewardCfg=cfg[rewardCol]
else
rewardCfg=self.stageCfg[rewardCol]
end
for i,v in ipairs(rewardCfg)do
if v[1]<=rankData.rank and rankData.rank<=v[2]then
rewards=v[3]
break
end
end
end
if type(rewards)=='number'then
rewards=cfgHelper.get(cfg_awardconfig_get,rewards).showItems
end
local rewardCnt=#rewards
if rewardCnt<=4 then
self.privateWidget:SetChildSizeDelta(_privateCmp.scrollView,rewardCnt*82+8,100)
else
self.privateWidget:SetChildSizeDelta(_privateCmp.scrollView,370,100)
end
self.privateWidget:SetChildLayoutGroupCreateItems(_privateCmp.rewards,rewardCnt,function(index)
local rewardItem=self.privateWidget:GetChildLayoutGroupGridItem(_privateCmp.rewards,index-1)
local rewardData=rewards[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local percent=rewardData[4]
local isxmkf=rewardData.isxmkf or false

local isPercent=percent~=nil
local isShowCount,countStr,range,showCountBG,countStr
if isPercent then
showCountBG=false
countStr=""
else
isShowCount=rewardNum>1 or rewardData.range~=nil
countStr=isShowCount and mathHelper.formatNumber(rewardNum)or""
range=rewardData.range
showCountBG=isShowCount
end

local conf={itemid=rewardId,itemcount=countStr,showname=false,showCountBG=showCountBG,range=range,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
rewardItem:SetChildActive(1,rewardNum==-1 and range==nil and percent==nil)

rewardItem:SetChildActive(2,isPercent)
if isPercent then
rewardItem:SetChildText(3,FMT.fmt("{0}%",percent))
end
rewardItem:SetChildActive(4,isxmkf)
end)
self.privateWidget:SetChildActive(_privateCmp.emptyReward,rewardCnt<=0)
end

function UIMJMBChapterRankListWin:refreshRankItem(dataIndex,cell)
local rankConfig=self.rankConfigs[dataIndex]
local rankNum=rankConfig[2]-rankConfig[1]+1
local rankData=seasonModel:getMyRank(self.handleType,self.stageIdx,self.selectIdx)
if rankNum==1 then
if rankConfig[1]>0 and rankConfig[1]<=3 then
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
local image=(data.guildicon and data.guildicon>0)and xianmengModel.splitGuildIcon(data.guildicon)or xianmengModel.getDefualtGuildIamge()
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
score=seasonModel:getRankScoreStr(self.stageType,score,self.selectIdx)
local ismy=xianmengModel:isMyXM(first.guildid)
local color=ismy and"#549327"or"#7D3B17"
local nameStr=ismy and FMT.fmt("<color=#549327>{0}</color>",first.guildname)or(first.guildicon and first.guildicon>0 and first.guildname or"神秘仙盟")
if ismy then
serverName=FMT.fmt("<color=#549327>{0}</color>",serverName)
end
cell:SetChildText(_itemCmp.nameTx,nameStr)
cell:SetChildText(_itemCmp.serverTx,serverName)
cell:SetChildText(_itemCmp.scoreTx,FMT.fmt("<color={2}>{0}{1}</color>",score,self.stageCfg.score_unit or"",color))
cell:SetChildText(_itemCmp.infoTx,"")
elseif not first then
cell:SetChildText(_itemCmp.nameTx,'')
cell:SetChildText(_itemCmp.serverTx,'')
cell:SetChildText(_itemCmp.scoreTx,'暂无')
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
score=seasonModel:getRankScoreStr(self.stageType,score,self.selectIdx)
local ismy=playerModel:checkActorId(first.actor_id)
local color=ismy and"#549327"or"#7D3B17"
local nameStr=ismy and FMT.fmt("<color=#549327>{0}</color>",first.actor_name)or first.actor_name
if ismy then
serverName=FMT.fmt("<color=#549327>{0}</color>",serverName)
end
cell:SetChildText(_itemCmp.nameTx,nameStr)
cell:SetChildText(_itemCmp.serverTx,serverName)
cell:SetChildText(_itemCmp.scoreTx,FMT.fmt("<color={2}>{0}{1}</color>",score,self.stageCfg.score_unit or"",color))
cell:SetChildText(_itemCmp.infoTx,'')
elseif not first then
cell:SetChildText(_itemCmp.nameTx,'')
cell:SetChildText(_itemCmp.serverTx,'')
cell:SetChildText(_itemCmp.scoreTx,'暂无')
cell:SetChildText(_itemCmp.infoTx,'虚位以待')
else
cell:SetChildText(_itemCmp.nameTx,'')
cell:SetChildText(_itemCmp.serverTx,'')
cell:SetChildText(_itemCmp.scoreTx,'')
cell:SetChildText(_itemCmp.infoTx,'')
end
end

local rewards=rankConfig[3]
if type(rewards)=='number'then
rewards=cfgHelper.get(cfg_awardconfig_get,rewards).showItems
end

local rewardCnt=#rewards
if rewardCnt<=4 then
cell:SetChildSizeDelta(_itemCmp.scrollView,rewardCnt*82+8,100)
else
cell:SetChildSizeDelta(_itemCmp.scrollView,370,100)
end
cell:SetChildLayoutGroupCreateItems(_itemCmp.rewards,rewardCnt,function(index)
local rewardItem=cell:GetChildLayoutGroupGridItem(_itemCmp.rewards,index-1)
local rewardData=rewards[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local percent=rewardData[4]
local isxmkf=rewardData.isxmkf or false

local isPercent=percent~=nil
local isShowCount,countStr,range,showCountBG,countStr
if isPercent then
showCountBG=false
countStr=""
else
isShowCount=rewardNum>1 or rewardData.range~=nil
countStr=isShowCount and mathHelper.formatNumber(rewardNum)or""
range=rewardData.range
showCountBG=isShowCount
end

local conf={itemid=rewardId,itemcount=countStr,showname=false,showCountBG=showCountBG,range=range,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
rewardItem:SetChildActive(1,rewardNum==-1 and range==nil and percent==nil)

rewardItem:SetChildActive(2,isPercent)
if isPercent then
rewardItem:SetChildText(3,FMT.fmt("{0}%",percent))
end
rewardItem:SetChildActive(4,isxmkf)
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



function UIMJMBChapterRankListWin:reqRankData(selectIdx)
selectIdx=selectIdx or self.selectIdx
local config=self.tabConfigList[selectIdx]
if config==nil then return end
config.reqData(self)
end

function UIMJMBChapterRankListWin.onSeasonRankChange(season_id,chapter_idx,rankType)
if _this.showParams.handleType==season_id and _this.showParams.stageIdx==chapter_idx and _this.selectIdx==rankType then
_this:refreshPrivate()
_this:refreshRankView()
end
end

function UIMJMBChapterRankListWin:onJifenBtn()
local scoreDescStr=self.stageCfg[self.selectIdx==eSeasonRankType.ePlayer and"person_rank_score_desc"or"guild_rank_score_desc"]
if not scoreDescStr then
return
end
local rank_score_conf=self.stageCfg.rank_score_conf
local pos=self.jifenBtn:getChildLocalPosition()
self.jifenDescTip:setLocalPosX(pos.x)
for i=1,4 do
if scoreDescStr[i]then
self.jifenDesc[i]:setActive(true)
self.jifenDesc[i]:setText(FMT.fmt(scoreDescStr[i],mathHelper.formatNumber(rank_score_conf[1][2]),rank_score_conf[1][3],rank_score_conf[1][4]))
else
self.jifenDesc[i]:setActive(false)
end
end
self.jifenDescRect:setActive(true)
self.jifenDescTip:setActive(true)
end

function UIMJMBChapterRankListWin:onJifenDescRect()
self.jifenDescRect:setActive(false)
self.jifenDescTip:setActive(false)
end
