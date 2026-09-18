







def_class("UIDouFaTaiRankWin",UIWindowBase)









function UIDouFaTaiRankWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.lundaoFlag=UIObject.get(self,1)
self.notrank=UIText.get(self,2)
self.scrollerView=UILoopListView.new(self,3)
self.selfDuanWeiIcon=UIImage.get(self,4)
self.selfDuanWeiVal=UIText.get(self,5)
self.selfFight=UIText.get(self,6)
self.selfHeadIcon=UIImage.get(self,7)
self.selfHeadKuang=UIImage.get(self,8)
self.selfName=UIText.get(self,9)
self.selfRank=UIText.get(self,10)
self.selfRankImg=UIImage.get(self,11)
self.selfRewardList=UIObject.get(self,12)
self.selfScoreIcon=UIImage.get(self,13)
self.selfScoreVal=UIText.get(self,14)
self.timeText=UIText.get(self,15)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.scrollerView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIDouFaTaiRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.lundaoFlag);self.lundaoFlag=nil;
_UIObject_release(self.notrank);self.notrank=nil;
self.scrollerView:deleteSelf();self.scrollerView=nil;
_UIObject_release(self.selfDuanWeiIcon);self.selfDuanWeiIcon=nil;
_UIObject_release(self.selfDuanWeiVal);self.selfDuanWeiVal=nil;
_UIObject_release(self.selfFight);self.selfFight=nil;
_UIObject_release(self.selfHeadIcon);self.selfHeadIcon=nil;
_UIObject_release(self.selfHeadKuang);self.selfHeadKuang=nil;
_UIObject_release(self.selfName);self.selfName=nil;
_UIObject_release(self.selfRank);self.selfRank=nil;
_UIObject_release(self.selfRankImg);self.selfRankImg=nil;
_UIObject_release(self.selfRewardList);self.selfRewardList=nil;
_UIObject_release(self.selfScoreIcon);self.selfScoreIcon=nil;
_UIObject_release(self.selfScoreVal);self.selfScoreVal=nil;
_UIObject_release(self.timeText);self.timeText=nil;
end

















local item_index=
{
rankImg=0,
rank=1,
iconList=2,
name=3,
fight=4,
scoreicon=5,
scorevalue=6,
haveplayer=7,
nothaveplayer=8,
itemList=9,
duanweiIcon=10,
duanweiName=11,
iconHeadItem=12,
lundaoFlag=13,
emptyHead=14,
}

local abName='ui/windows/doufatai/doufatai_atlas_pak.ab'



function UIDouFaTaiRankWin:onLoaded(...)
self:bindComponents()
self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIDouFaTaiRankWin:__delete()
self:unbindComponents()
self:stopSelfTimer()
end




function UIDouFaTaiRankWin:onShow(argtable,afterOnloaded)
self.doufataiData=douFaTaiModel:get_doufatai_data()
self:refreshSelfInfo()
self:refreshRank()
self:refreshTime()
end


function UIDouFaTaiRankWin:onHide()

end

function UIDouFaTaiRankWin:onStartAction(i,item)

end


function UIDouFaTaiRankWin:onFreshAction(i,item)
local rankList=douFaTaiModel:get_rank_data()
local showList=self.showList
local config=showList[i][1]
local rank
local have=false
if config.showinfo==1 then
rank=showList[i][2]
local rankData=rankList[rank]
have=rankData~=nil
if rankData then
local name=playerModel:getOtherActorName(rankData.name)
local isEmpty=rankData.name==''
item:SetChildText(item_index.name,name)
local score=rankData.wendao
local iconName=douFaTaiModel:getWenDaoIconName()
item:SetChildCSImageIcon(item_index.scoreicon,iconName,false)
item:SetChildText(item_index.scorevalue,score)
local duanweiName,duanweiIcon=douFaTaiModel:getDuanWeiName(score)
local duanweiIconName=iconHelper.getDouFaTaiIcon(duanweiIcon)
item:SetChildCSImageIcon(item_index.duanweiIcon,duanweiIconName,false)
item:SetChildText(item_index.duanweiName,duanweiName)


item:SetChildActive(item_index.emptyHead,isEmpty)
item:SetChildActive(item_index.iconList,not isEmpty)

if not isEmpty then
item:SetChildLayoutGroupCreateItems(item_index.iconList,1)
local grids=item:GetChildLayoutGroupGridList(item_index.iconList)
local widget=grids[0]
widget:SetChildActive(-1,true)
playerController:setHeadIcon(widget,0,{scale=0.6,iconInfo=rankData.iconInfo})
widget:SetChildButtonClick(2,function(...)
self:onClickPlayer(i,1)
end)

end

else
end


local isShowLundao=lundaodahuiModel:checkShowXuanBaSaiCredentialsByRank(rank)
item:SetChildActive(item_index.lundaoFlag,isShowLundao)
else
local range=config.rank_range
local left=range[1]
local right=range[2]
rank=FMT.fmt('{0}~{1}',left,right)

have=rankList[left]~=nil
local num=right-left+1
local showNum=num>4 and 4 or num

item:SetChildLayoutGroupCreateItems(item_index.iconList,showNum)
local grids=item:GetChildLayoutGroupGridList(item_index.iconList)
for j=1,showNum do
local rankData=rankList[left+j-1]
if rankData then
local widget=grids[j-1]
if widget then
widget:SetChildActive(-1,true)
widget:SetChildButtonClick(2,function(...)
self:onClickPlayer(i,j)
end)
playerController:setHeadIcon(widget,0,{scale=0.6,iconInfo=rankData.iconInfo})
end

end
end


local isShowLundao=lundaodahuiModel:checkShowXuanBaSaiCredentialsByRank(right)
item:SetChildActive(item_index.lundaoFlag,isShowLundao)
end
item:SetChildText(item_index.rank,rank)
item:SetChildActive(item_index.rankImg,i<=3)
if i<=3 then
local imgName=FMT.fmt('icon_phbmingci_{0}',i)
item:SetChildCSImageSprite(item_index.rankImg,abName,imgName)
end

item:SetChildActive(item_index.haveplayer,config.showinfo==1 and have)
item:SetChildActive(item_index.nothaveplayer,not have)
if not have then
item:SetChildLayoutGroupCreateItems(item_index.iconList,0)
end

local rewardList=config.season_rewards
item:SetChildLayoutGroupCreateItems(item_index.itemList,#rewardList)
local grids=item:GetChildLayoutGroupGridList(item_index.itemList)
for i=1,#rewardList do
local widget=grids[i-1]
local reward=rewardList[i]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=mathHelper.formatNumber(count),showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end
end

function UIDouFaTaiRankWin:refreshSelfInfo()
local data=self.doufataiData
playerController:setHeadIcon(self.winid,self.selfHeadIcon:getID(),{scale=0.6})

local name=playerModel:getActorName()
self.selfName:setText(name)
local fight=douFaTaiModel:getSelfFight()
self.selfFight:setText(fight)
local score=data.wendao
local iconName=douFaTaiModel:getWenDaoIconName()
self.selfScoreIcon:setImageIcon(iconName,false)
self.selfScoreVal:setText(score)
local duanweiName,duanweiIcon=douFaTaiModel:getDuanWeiName(score)
local duanweiIconName=iconHelper.getDouFaTaiIcon(duanweiIcon)
self.selfDuanWeiIcon:setImageIcon(duanweiIconName,false)
self.selfDuanWeiVal:setText(duanweiName)
local rank=data.rank
local inRank=rank~=0
self.selfRewardList:setActive(inRank)
self.notrank:setActive(not inRank)
if inRank then
self.selfRank:setText(rank)
local config=douFaTaiModel:getRankRewardConfig(rank)
local rewardList=config.season_rewards
self.selfRewardList:setChildLayoutGroupCreateItems(#rewardList)
local grids=self.selfRewardList:getChildLayoutGroupGridList()
for i=1,#rewardList do
local item=grids[i-1]
local reward=rewardList[i]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=mathHelper.formatNumber(count),showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildActive(-1,true)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end
local isShowLundao=lundaodahuiModel:checkShowXuanBaSaiCredentialsByRank(rank)
self.lundaoFlag:setActive(isShowLundao)
else
self.selfRank:setText('未入榜')
self.lundaoFlag:setActive(false)
end
if rank<=3 then
local imgName=FMT.fmt('icon_phbmingci_{0}',rank)
self.selfRankImg:setSprite(abName,imgName)
end
end

function UIDouFaTaiRankWin:getSplitConfig(config)
local list={}
for i,v in ipairs(config)do
if v.showinfo==1 then
local rankRange=v.rank_range
local left=rankRange[1]
local right=rankRange[2]
for rank=left,right do
table.insert(list,{v,rank})
end
else
table.insert(list,{v,v.id})
end
end
return list
end

function UIDouFaTaiRankWin:refreshRank()
local rankList=douFaTaiModel:get_rank_data()
local rankConfig=cfg_doufatairankrewardconfig()
local showList=self:getSplitConfig(rankConfig)
self.rankList=rankList
self.showList=showList
self.scrollerView:initData('rankItem',showList)
end

function UIDouFaTaiRankWin:onClickPlayer(index,subIdx)
local rankList=self.rankList
local config=self.showList[index][1]
local rankData
local rank
if config.showinfo==1 then
rank=self.showList[index][2]
else
local range=config.rank_range
local left=range[1]
local right=range[2]
rank=left+subIdx-1
end
rankData=rankList[rank]


douFaTaiController:req_actor_detail_new(rankData.actorId,DOUFATAI_ROBOTTYPE.player,DOUFATAI_LOOK_TYPE.eRank,true)
end

function UIDouFaTaiRankWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end

function UIDouFaTaiRankWin:refreshTime()
local func=function()
local serTime=timeHelper.getServerShortTime()
local isTruce=douFaTaiModel:checkIsTruce()
local endTime
if isTruce then

endTime=douFaTaiModel:get_doufatai_truceEndTime()
else

endTime=douFaTaiModel:get_doufatai_settleTime()
end
local dtTime=endTime-serTime
local timeStr
if isTruce then
timeStr=FMT.fmt('<color=#7d3b17>休战结束倒计时：</color>{0}',timeHelper.format_time_stamp3(dtTime))
else
timeStr=FMT.fmt('<color=#7d3b17>奖励结算倒计时：</color>{0}',timeHelper.format_time_stamp3(dtTime))
end
self.timeText:setText(timeStr)
if dtTime<=0 then
self:stopSelfTimer()
end
end
func()
local endTime=douFaTaiModel:get_doufatai_settleTime()
loggerUtil.log(FMT.fmt("斗法台结算时间:{0} 月 {1} 日 {2} 时 {3} 分 {4} 秒",timeHelper.dateServerStamp('%m',endTime),timeHelper.dateServerStamp('%d',endTime),timeHelper.dateServerStamp('%H',endTime),timeHelper.dateServerStamp('%M',endTime),timeHelper.dateServerStamp('%S',endTime)))
self.timer=self:setTimer(1,0,func)
end

function UIDouFaTaiRankWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end





function UIDouFaTaiRankWin:onCloseBtn()
UIFullDouFaTaiControl:closeWindow(self.winlua.name)
end

