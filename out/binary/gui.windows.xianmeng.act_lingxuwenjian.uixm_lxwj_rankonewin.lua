







def_class("UIXM_LXWJ_RankOneWin",UIWindowBase)









function UIXM_LXWJ_RankOneWin:bindComponents()

self.rankItem=UIObject.get(self,0)
self.rankScrollView=UILoopListView.new(self,1)
self.root=UIObject.get(self,2)

self.rankScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXM_LXWJ_RankOneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rankItem);self.rankItem=nil;
self.rankScrollView:deleteSelf();self.rankScrollView=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this=nil


function UIXM_LXWJ_RankOneWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_RankOneWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_RankOneWin:onHide()

end




function UIXM_LXWJ_RankOneWin:onShow(argtable,afterOnloaded)
local needRefresh=lingxuwenjianModel:checkRefreshRank1()
if not needRefresh then
self:refreshView()
else
self.root:setActive(false)
end
end

function UIXM_LXWJ_RankOneWin:getRewards(rank)
local ranks=cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'reward',2)
for i,v in ipairs(ranks)do
if rank>=v[1]and rank<=v[2]then
return v[3]
end
end
end

function UIXM_LXWJ_RankOneWin:refreshView()
self.root:setActive(true)
local hasXM=xianmengModel:hasXM()
local ranks=cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'reward',2)
local temp=lingxuwenjianModel:getRanklist1()
local list={}
local pre_score,pre_rank,pre_rewards=-1,-1,{}
for i,v in ipairs(ranks)do
if v[1]<100 then
for ii=v[1],v[2]do
local d={}
if temp[ii]and temp[ii].score then
local score=temp[ii].score
if score==pre_score then
d.rank=pre_rank
d.info=temp[ii]
d.rewards=pre_rewards
else
pre_score=score
pre_rank=ii
pre_rewards=v[3]
d.rank=ii
d.info=temp[ii]
d.rewards=v[3]
end
else
d.rank=ii
d.info=temp[ii]
d.rewards=v[3]
end
table.insert(list,d)
end
else
local start_idx=v[1]
if pre_rank<=100 then
for ii=v[1],v[2]do
local d={}
if temp[ii]and temp[ii].score then
local score=temp[ii].score
if score==pre_score then
d.rank=pre_rank
d.info=temp[ii]
d.rewards=pre_rewards
table.insert(list,d)
start_idx=ii+1
else
start_idx=ii
break
end
else
break
end
end
else
for ii=v[1],v[2]do
local d={}
if temp[ii]and temp[ii].score then
local score=temp[ii].score
if score==pre_score then
start_idx=ii+1
else
start_idx=ii
break
end
else
break
end
end
if start_idx>v[1]then
local d=list[#list]
local len=#d.infos
if len<4 then
local n=math.min(start_idx-v[1],4-n)
for i=1,n do
d.infos[len+i]=temp[v[1]+i-1]
end
end
list[#list]=d
end
end
if start_idx<=v[2]then
local d={}
d.ranks=v[1]
local infos={}
local maxNum=math.min(3,(v[2]-start_idx))
for ii=0,maxNum do
infos[ii+1]=temp[start_idx+ii]
end
d.infos=infos
d.rewards=v[3]
table.insert(list,d)
if temp[v[2]]and temp[v[2]].score then
pre_score=temp[v[2]].score
pre_rank=v[1]
pre_rewards=v[3]
end
end
end
end
self.rankList=list
local num=#self.rankList
local isShow=num>0
self.rankScrollView:setActive(isShow)
self.rankItem:setActive(isShow and hasXM)
self.curRank=nil
self.curScore=nil
if isShow then
local pre_score,pre_rank=-1,-1
for i,data in ipairs(temp)do
if xianmengModel:isMyXM(data.guildid)then
self.curRank=data.score==pre_score and pre_rank or i
self.curScore=data.score
break
elseif pre_score~=data.score then
pre_score=data.score
pre_rank=i
end
end
local createCount=num
local createList={}
for i=1,createCount do createList[#createList+1]=i end
self.rankScrollView:initData('rankItem',createList)

self.rankItem:setActive(hasXM)
if hasXM then
self:refreshRankItem()
end
if hasXM then
self.rankScrollView:setChildSizeDelta(1058,408)
else
self.rankScrollView:setChildSizeDelta(1058,502)
end
end
end

function UIXM_LXWJ_RankOneWin:onFreshAction(i,item)
if _this==nil then return end
local data=_this.rankList[i]
if data.rank~=nil then

local rank=data.rank

local rankIcon
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(0,showRankIcon)
item:SetChildActive(2,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(0,globalABLookup.rankList,rankIcon)
item:SetChildText(1,tostring(rank))
else
local rank_str=tostring(rank)
item:SetChildText(2,rank_str)
end

local info=data.info
local hasXM=info~=nil and info.guildname~=''
item:SetChildActive(3,hasXM)
item:SetChildActive(4,false)
local tips2_str
if hasXM then
tips2_str=''
local infoWidget=item:GetChildWidgetBase(3)

local image=xianmengModel.splitGuildIcon(info.guildicon)
local abname=globalABLookup.xianmengicons

infoWidget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

infoWidget:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

infoWidget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local sname=loginModel:getServerName(info.serverid)
local name_str
if sname~=nil and sname~=''then
name_str=FMT.fmt('{0}\n{1}',info.guildname,sname)
else
name_str=info.guildname
end
infoWidget:SetChildText(3,name_str)

infoWidget:SetChildText(4,info.leadername)

local abname,icon,name=lingxuwenjianModel:getScoreCfg(info.score)
infoWidget:SetChildCSImageSprite(5,abname,icon)
infoWidget:SetChildText(6,name)
infoWidget:SetChildText(7,info.score)





else
if info~=nil and info.guildname==''then
tips2_str='该仙盟已解散'
else
tips2_str='虚位以待'
end
end
item:SetChildText(7,tips2_str)
else

local rank=data.ranks

item:SetChildActive(0,false)
local rank_str=FMT.fmt('{0}+',rank)
item:SetChildText(2,rank_str)

local infos=data.infos
local n=#infos
local hasXM=n>0
item:SetChildActive(3,false)
item:SetChildActive(4,hasXM)
local tips2_str
if hasXM then
item:SetChildLayoutGroupCreateItems(4,n)
local grids=item:GetChildLayoutGroupGridList(4)
for idx_=1,n do
local item_=grids[idx_-1]
local d=infos[idx_]

local image=xianmengModel.splitGuildIcon(d.guildicon)
local abname=globalABLookup.xianmengicons

item_:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item_:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item_:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))





end
else
tips2_str='虚位以待'
end
item:SetChildText(7,tips2_str)
end

local rewardList=data.rewards
local c=#rewardList
local showReward=c>0
item:SetChildActive(5,showReward)
item:SetChildActive(6,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(5,c)
local grids2=item:GetChildLayoutGroupGridList(5)
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

function UIXM_LXWJ_RankOneWin:onStartAction()

end

function UIXM_LXWJ_RankOneWin:refreshRankItem()
local item=self.rankItem:getChildWidgetBase()
local rank=self.curRank
local hasRank=rank~=nil
local rewardList
if hasRank then
rewardList=self:getRewards(rank)
end
local score=self.curScore
if score==nil then
score=lingxuwenjianModel:getScore()
end


local rankIcon
local rank_str
if not hasRank then
rank_str='未上榜'
else
rank_str=tostring(rank)
end
if rank~=nil and rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(0,showRankIcon)
item:SetChildActive(2,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(0,globalABLookup.rankList,rankIcon)
item:SetChildText(1,rank_str)
else
item:SetChildText(2,rank_str)
end

local image=xianmengModel:getGuildImage()
item:SetChildActive(3,image~=nil)
if image~=nil then
local abname=globalABLookup.xianmengicons

item:SetChildCSImageSprite(4,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(5,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end

local sname=loginModel:getMyServerName()
local name_str
if sname~=nil and sname~=''then
name_str=FMT.fmt('{0}\n{1}',xianmengModel:getXMName(),sname)
else
name_str=xianmengModel:getXMName()
end
item:SetChildText(6,name_str)

item:SetChildText(7,xianmengModel:getXMLeaderName())

local abname,icon,name=lingxuwenjianModel:getScoreCfg(score)
item:SetChildCSImageSprite(8,abname,icon)
item:SetChildText(9,name)
item:SetChildText(10,score)

local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(11,showReward)
item:SetChildActive(12,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(11,c)
local grids2=item:GetChildLayoutGroupGridList(11)
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

function UIXM_LXWJ_RankOneWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_LXWJ_RankOneWin:rec_ranklist()
self:refreshView()
end