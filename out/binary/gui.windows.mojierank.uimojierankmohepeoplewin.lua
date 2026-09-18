







def_class("UIMoJieRankMoHePeopleWin",UIWindowBase)









function UIMoJieRankMoHePeopleWin:bindComponents()

self.center=UIObject.get(self,0)
self.norank=UIObject.get(self,1)
self.rankList=UILoopListView.new(self,2)
self.root=UIObject.get(self,3)
self.selfitem=UIObject.get(self,4)
self.spinebg=UIObject.get(self,5)

self.rankList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIMoJieRankMoHePeopleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.norank);self.norank=nil;
self.rankList:deleteSelf();self.rankList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selfitem);self.selfitem=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
end


















local rwitemidxself=
{
rwself=0,
root=1,
bg=2,
rankbg=3,
rank=4,
name=5,
meng=6,
value=7,
value2=8,
rewscrollview=9,
value3=10,
headicon=11,
}
local rwitemidx=
{
rwself=0,
root=1,
bg=2,
rankbg=3,
rank=4,
name=5,
meng=6,
value=7,
value2=8,
rewscrollview=9,
headicon=10,
}
local _this

function UIMoJieRankMoHePeopleWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIMoJieRankMoHePeopleWin:__delete()
_this=nil
self:unbindComponents()
end




function UIMoJieRankMoHePeopleWin:onShow(argtable,afterOnloaded)


local nowsaijiid=xianjieController:getMoJieSaiJiID()
self.mojiecfg=cfgHelper.get1(cfg_mojiemoherankconfig_get,nowsaijiid)

if self.mojiecfg then

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
if _this==nil then return end
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end)
end

self:refreshRankList()
self:frsehSelfRank()
end

end


function UIMoJieRankMoHePeopleWin:onHide()

end
function UIMoJieRankMoHePeopleWin:onStartAction()

end


function UIMoJieRankMoHePeopleWin:severmkrankfresh()
if _this then
_this:refreshRankList()
_this:frsehSelfRank()
end
end


function UIMoJieRankMoHePeopleWin:refreshRankList()

local rankDatas=rankListModel:getRankList(eRankListType.eMoHePersonalRank)
self.rankDatas=rankDatas or{}


local len=#rankDatas
if len>0 then
local createCount=len
local createList={}
for i=1,createCount do createList[#createList+1]=i end
self.rankList:initData('item',createList)
self.norank:setActive(false)
else
self.norank:setActive(true)
end
end

function UIMoJieRankMoHePeopleWin:onFreshAction(i,grid)
local rankDatas=self.rankDatas
local cfgrewards=self.mojiecfg.reward1
local data=rankDatas[i]
local rank=data.rankNum
if rank<=3 then
local rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
grid:SetChildCSImageSprite(rwitemidx.rankbg,globalABLookup.rankList,rankIcon)
grid:SetChildActive(rwitemidx.rankbg,true)
else
grid:SetChildActive(rwitemidx.rankbg,false)
end
grid:SetChildText(rwitemidx.rank,rank)


local namestr=data.name
local serverId=data.serverid
local xmname=data.xmName
local selfactid=tostring(playerModel:getActorID())
if xmname==""then
xmname="暂无"
end
if tostring(data.actorid)==selfactid then
xmname=FMT.cfmt(FONT_COLOR.eGreenColor,xmname)
end
local val=mathHelper.formatNumber4(tonumber(tostring(data.score)),2)
if serverId then
local serverName=loginModel:getServerName(serverId)
if tostring(data.actorid)==selfactid then
namestr=FMT.fmt('<color=#ca631d>[{0}]</color>\n<color=#549327>{1}</color>',serverName,data.name)
val=FMT.cfmt(FONT_COLOR.eGreenColor,val)
else
namestr=FMT.fmt('<color=#ca631d>[{0}]</color>\n{1}',serverName,data.name)
end

end

grid:SetChildText(rwitemidx.name,namestr)
grid:SetChildActive(rwitemidx.meng,true)
grid:SetChildText(rwitemidx.meng,xmname)


grid:SetChildText(rwitemidx.value,val)

playerController:setHeadIcon(grid,rwitemidx.headicon,{iconInfo=data.iconInfo,scale=0.6})


local rewardList=self:getRewardByRank(cfgrewards,rank)
if rewardList then
local len=#rewardList
grid:SetChildScrollViewCreateGrids(rwitemidx.rewscrollview,len,len)
local reward_grids=grid:GetChildScrollViewItemWidgets(rwitemidx.rewscrollview)
for j=1,len do
local reward=rewardList[j]
local itemid=reward[1]
local count=reward[2]
local widget=reward_grids[j-1]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end


function UIMoJieRankMoHePeopleWin:frsehSelfRank()
local widget=self.selfitem:getWidgetBase()

local myscore=xianjieModel:GetMoHe_playerScore()
local myRank=xianjieModel:GetMoHe_playerrank()
local cfgrewards=self.cfgrewards

local isInList=myRank>0
widget:SetChildText(rwitemidxself.rank,isInList and myRank or'保底奖')


local namestr=FMT.fmt('<color=#ca631d>[{0}]</color>\n{1}',loginModel:getMyServerName(),playerModel:getActorName())
widget:SetChildText(rwitemidxself.name,namestr)

if myRank>0 and myRank<=3 then
local rankIcon=FMT.fmt('icon_phbmingci_{0}',myRank)
widget:SetChildCSImageSprite(rwitemidxself.rankbg,globalABLookup.rankList,rankIcon)
widget:SetChildActive(rwitemidxself.rankbg,true)
else
widget:SetChildActive(rwitemidxself.rankbg,false)
end


local xmName=xianmengModel:hasXM()and xianmengModel:getXMName()or"暂无"
widget:SetChildText(rwitemidxself.meng,xmName)
local num=tonumber(tostring(myscore))
local val=mathHelper.formatNumber4(num,2)
widget:SetChildText(rwitemidxself.value,val)
widget:SetChildText(rwitemidxself.value2,0)
if num>0 then
widget:SetChildText(rwitemidxself.value3,'')
widget:SetChildActive(rwitemidxself.rewscrollview,true)
isInList=true
else
widget:SetChildText(rwitemidxself.value3,'请祖师参与活动')
widget:SetChildActive(rwitemidxself.rewscrollview,false)
end
local rewardList
if myRank>0 then
cfgrewards=self.mojiecfg.reward1
rewardList=self:getRewardByRank(cfgrewards,myRank)
else
widget:SetChildText(rwitemidxself.rank,'未上榜')
cfgrewards=self.mojiecfg.reward3
rewardList=cfgrewards
end
if tonumber(tostring(myscore))<=0 then
widget:SetChildText(rwitemidxself.rank,'待参与')
end

playerController:setHeadIcon(widget,rwitemidxself.headicon,{scale=0.6})


if isInList and rewardList then
local len=#rewardList
widget:SetChildScrollViewCreateGrids(rwitemidxself.rewscrollview,len,len)
local reward_grids=widget:GetChildScrollViewItemWidgets(rwitemidxself.rewscrollview)
for j=1,len do
local reward=rewardList[j]
local itemid=reward[1]
local count=reward[2]
local widget2=reward_grids[j-1]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget2:SetChildActive(-1,true)
widget2:SetChildPropData(0,prop)
widget2:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end


function UIMoJieRankMoHePeopleWin:getRewardByRank(cfg,rank)
if cfg then
for k,v in ipairs(cfg)do
if v[3]and v[1]<=rank and rank<=v[2]then
return v[3]
end
end
end
end


function UIMoJieRankMoHePeopleWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end


