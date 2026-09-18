







def_class("UIMoJieRankGRXSWin",UIWindowBase)









function UIMoJieRankGRXSWin:bindComponents()

self.root=UIObject.get(self,0)
self.rankList=UILoopListView.new(self,1)
self.selfitem=UIObject.get(self,2)
self.center=UIObject.get(self,3)
self.norank=UIObject.get(self,4)

self.rankList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIMoJieRankGRXSWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
self.rankList:deleteSelf();self.rankList=nil;
_UIObject_release(self.selfitem);self.selfitem=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.norank);self.norank=nil;
end
















local _this
local rewardtype=
{
rank=1,
xfz=2,
zmgx=3
}
local rewardrank=
{
xf=1,
xs=2,
zm=3,
zmxm=4,
}
local _eRankListType=
{
xf=1,
xs=2,
zm=3,
zmxm=4,
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
addbtn=10,
value3=11,
}



function UIMoJieRankGRXSWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMoJieRankGRXSWin:__delete()
self:unbindComponents()
_this=nil
end


function UIMoJieRankGRXSWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end

function UIMoJieRankGRXSWin:onClickAddBtn(_posWidget)
local _desc={"结丹：123456","元婴：123456","化神：123456"}
UIManager:showWindow('UIMoJieRankTips',{posWidget=_posWidget,posWidgetIndex=rwitemidx.addbtn,pos={x=3,y=35},desc=_desc})
end


function UIMoJieRankGRXSWin:severmkrankfresh(rankType)
if _this then

if rankType==eRankListType.eXianSunRank then
_this:refreshRankList()
_this:frsehSelfRank()
end
end
end




function UIMoJieRankGRXSWin:onShow(argtable,afterOnloaded)
local enterData=xianjieModel:getMoJieEnterData()
self.mojiecfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end

self:refreshRankList()
self:frsehSelfRank()
end


function UIMoJieRankGRXSWin:onHide()
self.center:setActive(false)
self.norank:setActive(false)
end


function UIMoJieRankGRXSWin:getTypeReward(flag)
local cfgrank=self.mojiecfg.rank
return cfgrank[flag]
end

function UIMoJieRankGRXSWin:getRewardByRank(cfg,rank)
if cfg then
for k,v in ipairs(cfg)do
if v[3]and v[1]<=rank and rank<=v[2]then
return v[3]
end
end
if cfg[0]then
return cfg[0]
end
end
end

function UIMoJieRankGRXSWin:refreshRankList()
local cfgrank=self:getTypeReward(rewardtype.rank)
local cfgrewards=cfgrank[rewardrank.xs]
self.cfgrewards=cfgrewards

local rankDatas=xianjieController:getmojieRankList(_eRankListType.xs)
self.rankDatas=rankDatas or{}


self.center:setActive(true)
local len=#rankDatas
if len>0 then
self.norank:setActive(false)

local createCount=len
local createList={}
for i=1,createCount do createList[#createList+1]=i end
self.rankList:initData('item',createList)
else

self.norank:setActive(true)
self.norank:setChildCanvasGroupAlpha(0)
self.norank:setChildCanvasGroupDOFade(1,0.6,nil)
end
end

function UIMoJieRankGRXSWin:onFreshAction(i,grid)
local rankDatas=self.rankDatas
local cfgrewards=self.cfgrewards
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


local namestr=data.actorname
local serverId=data.serverid
if serverId then
local serverName=loginModel:getServerName(serverId)
namestr=FMT.fmt('<color=#ca631d>[{0}]</color>\n{1}',serverName,data.actorname)
end
grid:SetChildText(rwitemidx.name,namestr)
grid:SetChildText(rwitemidx.meng,data.guildname)
local val=mathHelper.formatNumber4(tonumber(tostring(data.val)),2)

grid:SetChildText(rwitemidx.value,val)



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
function UIMoJieRankGRXSWin:onStartAction()

end

function UIMoJieRankGRXSWin:frsehSelfRank()
local widget=self.selfitem:getWidgetBase()
local myRank=xianjieController:getmojieMyRank(_eRankListType.xs)
local rankDatas=self.rankDatas
local cfgrewards=self.cfgrewards
local isshowadd=true
local XianSunList=xianjieController:getXianSunList2()
local xsnum=0
if XianSunList then
for k,v in pairs(XianSunList)do
if v[2]then
xsnum=xsnum+tonumber(tostring(v[2]))
end
end
end


local isInList=myRank>0 and myRank<=#rankDatas
widget:SetChildText(rwitemidx.rank,isInList and myRank or'未上榜')
local namestr=FMT.fmt('<color=#ca631d>[{0}]</color>\n{1}',loginModel:getMyServerName(),playerModel:getActorName())
widget:SetChildText(rwitemidx.name,namestr)

if myRank>0 and myRank<=3 then
local rankIcon=FMT.fmt('icon_phbmingci_{0}',myRank)
widget:SetChildCSImageSprite(rwitemidx.rankbg,globalABLookup.rankList,rankIcon)
widget:SetChildActive(rwitemidx.rankbg,true)
else
widget:SetChildActive(rwitemidx.rankbg,false)
end


if isInList then
local data=rankDatas[myRank]
widget:SetChildText(rwitemidx.meng,data.guildname)
local val=mathHelper.formatNumber4(xsnum,2)

widget:SetChildText(rwitemidx.value,val)

widget:SetChildText(rwitemidx.value3,'')
widget:SetChildActive(rwitemidx.rewscrollview,true)
else
local xmName=xianmengModel:hasXM()and xianmengModel:getXMName()or"暂无"
widget:SetChildText(rwitemidx.meng,xmName)
local val=mathHelper.formatNumber4(xsnum,2)
widget:SetChildText(rwitemidx.value,val)
widget:SetChildText(rwitemidx.value2,0)
if xsnum>0 then
widget:SetChildText(rwitemidx.value3,'')
widget:SetChildActive(rwitemidx.rewscrollview,true)
isInList=true
else
widget:SetChildText(rwitemidx.value3,'请祖师参与活动')
widget:SetChildActive(rwitemidx.rewscrollview,false)
end
isshowadd=false
end


if false then
widget:SetChildActive(rwitemidx.addbtn,true)
widget:SetChildButtonClick(rwitemidx.addbtn,function()
if _this==nil then return end
self:onClickAddBtn(widget)
end)
else
widget:SetChildActive(rwitemidx.addbtn,false)
end


local rewardList=self:getRewardByRank(cfgrewards,myRank)
if isInList and rewardList then
local len=#rewardList
widget:SetChildScrollViewCreateGrids(rwitemidx.rewscrollview,len,len)
local reward_grids=widget:GetChildScrollViewItemWidgets(rwitemidx.rewscrollview)
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
