







def_class("UIYCTB_RankWin",UIWindowBase)









function UIYCTB_RankWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.menuGridPanel=UIObject.get(self,1)
self.rankScrollView=UIObject.get(self,2)
self.rankItem=UIObject.get(self,3)
self.rewardScrollView=UIObject.get(self,4)
self.tipsTxt=UIText.get(self,5)
self.noItemTips=UIText.get(self,6)
self.rewardGridPanel=UIObject.get(self,7)
self.rankGridPanel=UIObject.get(self,8)
self.tipsTxt2=UIText.get(self,9)
self.tipIcon=UIImage.get(self,10)
self.quantipsTxt=UIText.get(self,11)



end


function UIYCTB_RankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.rankItem);self.rankItem=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.rewardGridPanel);self.rewardGridPanel=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
_UIObject_release(self.tipsTxt2);self.tipsTxt2=nil;
_UIObject_release(self.tipIcon);self.tipIcon=nil;
_UIObject_release(self.quantipsTxt);self.quantipsTxt=nil;
end

















local _this
local abnameyc='ui/windows/activities/sub_yunchengtanbao/yunchengtanbao_atlas_pak.ab'


function UIYCTB_RankWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIYCTB_RankWin:__delete()
self:unbindComponents()
end




function UIYCTB_RankWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.alldata=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
end



UIYCTB_RankWin:openMemberPage()
end


function UIYCTB_RankWin:onHide()

end




function UIYCTB_RankWin:openMemberPage()
local cfg_rank_reward=cfg_cloudcitytreasureactconfig_get(_this.subId).rank_reward
_this.rankList=_this.alldata.yctbLiat or{}

local myActorid=playerModel:getActorID()


local cfg_playerank=cfg_cloudcitytreasureactconfig_get(_this.subId).playerank

local only_open_idx=cfg_playerank[1]or 50
local all_open_idx=only_open_idx
if cfg_playerank[2]then
all_open_idx=all_open_idx+#cfg_playerank[2]
end
local num=all_open_idx

local isShow=num>0
_this.rankScrollView:setActive(isShow)
_this.noItemTips:setActive(not isShow)
_this.rankItem:setActive(isShow)
_this.curRank=nil
_this.rank_value=nil
if isShow then
for i,data in ipairs(_this.rankList)do
if data.actor_id and playerModel:checkActorId(data.actor_id)then
_this.curRank=data.rank_id
_this.rank_value=data.rank_value
_this.serverid=data.server_id or 1
break
end
end
local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)
local data=_this.rankList[i]
if data then

local rank=i
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(6,showRankIcon)
item:SetChildActive(0,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(6,globalABLookup.rankList,rankIcon)
item:SetChildText(12,rank_str)
else
item:SetChildText(0,rank_str)
end

local hasMember=data.name~=''
item:SetChildActive(13,hasMember)
local tips2_str=''
local headParams
if hasMember then

item:SetChildActive(7,false)

headParams={iconInfo=data.iconInfo,scale=0.8}

local serverName=loginModel:getServerName(data.server_id)
local str=FMT.fmt('[{0}]{1}',serverName,data.name)
item:SetChildText(1,str)

local quanshu=FMT.fmt('{0}圈',data.rank_value)
item:SetChildText(16,quanshu)
item:SetChildText(15,101)
else
tips2_str=''
end
item:SetChildText(14,tips2_str)
item:SetChildText(17,"")

playerController:setHeadIcon(item,11,headParams)

item:SetChildButtonClick(11,function()
if data.actor_id and not mathHelper.compareInt64(myActorid,data.actor_id)then
self:onClickhead(data.actor_id)
end
end)



local nextrank_under=0
if i>only_open_idx then
local idx=i-only_open_idx
if idx>0 and cfg_playerank[2]and cfg_playerank[2][idx]then
local arry=cfg_playerank[2][idx]
local nextrank_top=arry[1]
nextrank_under=arry[2]
item:SetChildText(0,FMT.fmt('{0}~{1}',nextrank_top,nextrank_under))

item:SetChildActive(13,false)
item:SetChildActive(18,true)

local num=nextrank_under-nextrank_top+1
local showNum=num>3 and 3 or num
item:SetChildLayoutGroupCreateItems(18,showNum)
local grids=item:GetChildLayoutGroupGridList(18)
for j=1,showNum do
local data=_this.rankList[nextrank_top+j-1]
if data then
local widget=grids[j-1]
if widget then
widget:SetChildActive(-1,true)
widget:SetChildButtonClick(2,function(...)
if data.actor_id and not mathHelper.compareInt64(myActorid,data.actor_id)then
self:onClickhead(data.actor_id)
end
end)
playerController:setHeadIcon(widget,0,{scale=0.8,iconInfo=data.iconInfo})
end
end
end
local _data=_this.rankList[nextrank_top]
if not _data then
item:SetChildActive(18,false)
item:SetChildText(17,"虚位以待")
end
end
end


local rewardidx=i
if nextrank_under>0 then
rewardidx=nextrank_under
end
local d=cfg_rank_reward
local rewardList=_this:getRankReward(2,rewardidx,d)
local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(4,showReward)
item:SetChildActive(5,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(4,c)
local grids2=item:GetChildLayoutGroupGridList(4)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
else

local rank=i
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(6,showRankIcon)
item:SetChildActive(0,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(6,globalABLookup.rankList,rankIcon)
item:SetChildText(12,rank_str)
else
item:SetChildText(0,rank_str)
end
item:SetChildActive(13,false)
item:SetChildText(17,"虚位以待")
item:SetChildText(14,"")
local nextrank_under=0
if i>only_open_idx then
local idx=i-only_open_idx
if idx>0 and cfg_playerank[2]and cfg_playerank[2][idx]then
local arry=cfg_playerank[2][idx]
local nextrank_top=arry[1]
nextrank_under=arry[2]

item:SetChildText(0,FMT.fmt('{0}~{1}',nextrank_top,nextrank_under))
end
end


local rewardidx=i
if nextrank_under>0 then
rewardidx=nextrank_under
end
local d=cfg_rank_reward
local rewardList=_this:getRankReward(2,rewardidx,d)
local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(4,showReward)
item:SetChildActive(5,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(4,c)
local grids2=item:GetChildLayoutGroupGridList(4)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end
end
_this.rankGridPanel:setChildLayoutGroupCreateItems(num,func)


local tipsTxtstr=FMT.fmt('我的排名：{0}',_this.curRank and _this.curRank or'未上榜')
_this.tipsTxt:setText(tipsTxtstr)

local quantipsTxtcfg=cfg_cloudcitytreasureactconfig_get(_this.subId).rank_circle_num
_this.quantipsTxt:setText(FMT.fmt('{0}圈才可以参与排名',quantipsTxtcfg))

_this.rankItem:setActive(false)
else
_this.rankItem:setActive(false)
_this.noItemTips:setText('暂无排名信息')
end
end



function UIYCTB_RankWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UIYCTB_RankWin:onClickhead(actorId)
otherPlayerController:openOtherPlayerInfoWin(actorId,nil,actorInterFromType.eCommon)
end


function UIYCTB_RankWin:getRankReward(typo,rank,look)
if self.rankRewardLookup==nil then
self.rankRewardLookup={}
end
if self.rankRewardLookup[typo]==nil then
self.rankRewardLookup[typo]={}
end
if self.rankRewardLookup[typo][rank]==nil then
for i,v in ipairs(look)do
if rank>=v[1]and rank<=v[2]then
self.rankRewardLookup[typo][rank]=v[3]
return v[3]
end
end
end
return self.rankRewardLookup[typo][rank]
end
