







def_class("UIMoJieRankMoHeXMWin",UIWindowBase)









function UIMoJieRankMoHeXMWin:bindComponents()

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


function UIMoJieRankMoHeXMWin:unbindComponents()
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
XMiconbg=11,
XMicon=12,
XMKuangicon=13,
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
XMiconbg=10,
XMicon=11,
XMKuangicon=12,
}
local _this

function UIMoJieRankMoHeXMWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIMoJieRankMoHeXMWin:__delete()
self:unbindComponents()
end




function UIMoJieRankMoHeXMWin:onShow(argtable,afterOnloaded)

local nowsaijiid=xianjieController:getMoJieSaiJiID()
self.mojiecfg=cfgHelper.get1(cfg_mojiemoherankconfig_get,nowsaijiid)

if self.mojiecfg then

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end

self:refreshRankList()
self:frsehSelfRank()
end
end


function UIMoJieRankMoHeXMWin:onHide()

end
function UIMoJieRankMoHeXMWin:onStartAction()

end


function UIMoJieRankMoHeXMWin:severmkrankfresh()
if _this then
_this:refreshRankList()
_this:frsehSelfRank()
end
end


function UIMoJieRankMoHeXMWin:refreshRankList()

local rankDatas=rankListModel:getRankList(eRankListType.eMoHeXMRank)
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

function UIMoJieRankMoHeXMWin:onFreshAction(i,grid)
local rankDatas=self.rankDatas
local cfgrewards=self.mojiecfg.reward2
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

if xmname==""then
xmname="暂无"
end

local val=mathHelper.formatNumber4(tonumber(tostring(data.score)),2)
if serverId then
local serverName=loginModel:getServerName(serverId)
if xianmengModel:hasXM()then
local selfXMid=tostring(xianmengModel:myXMGuildID())
if tostring(data.xmGuid)==selfXMid then
namestr=FMT.fmt('<color=#ca631d>[{0}]</color>\n<color=#549327>{1}</color>',serverName,xmname)
val=FMT.cfmt(FONT_COLOR.eGreenColor,val)
else
namestr=FMT.fmt('<color=#ca631d>[{0}]</color>\n{1}',serverName,xmname)
end
else
namestr=FMT.fmt('<color=#ca631d>[{0}]</color>\n{1}',serverName,xmname)
end

end

local image=xianmengModel.splitGuildIcon(data.xmIcon)
local abname=globalABLookup.xianmengicons

grid:SetChildCSImageSprite(rwitemidx.XMicon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

grid:SetChildCSImageSprite(rwitemidx.XMiconbg,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

grid:SetChildCSImageSprite(rwitemidx.XMKuangicon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

grid:SetChildText(rwitemidx.name,namestr)
grid:SetChildActive(rwitemidx.meng,false)


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


function UIMoJieRankMoHeXMWin:frsehSelfRank()
local widget=self.selfitem:getWidgetBase()

local myscore=xianjieModel:GetMoHe_XMScore()
local myRank=xianjieModel:GetMoHe_XMrank()
local cfgrewards=self.cfgrewards

local isInList=myRank>0
widget:SetChildText(rwitemidxself.rank,isInList and myRank or'未上榜')

local xmName=xianmengModel:hasXM()and xianmengModel:getXMName()
widget:SetChildActive(rwitemidxself.value2,false)
local num=tonumber(tostring(myscore))
local val=mathHelper.formatNumber4(num,2)
widget:SetChildText(rwitemidxself.value,val)
if num<=0 then
widget:SetChildText(rwitemidxself.rank,'待参与')
end
if xianmengModel:hasXM()then
local namestr=FMT.fmt('<color=#ca631d>[{0}]</color>\n{1}',loginModel:getMyServerName(),xmName)

widget:SetChildText(rwitemidxself.name,namestr)
local image=xianmengModel:getGuildImage()
local abname=globalABLookup.xianmengicons
widget:SetChildCSImageSprite(rwitemidxself.XMicon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(rwitemidxself.XMiconbg,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(rwitemidxself.XMKuangicon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
if myRank>0 and myRank<=3 then
local rankIcon=FMT.fmt('icon_phbmingci_{0}',myRank)
widget:SetChildCSImageSprite(rwitemidxself.rankbg,globalABLookup.rankList,rankIcon)
widget:SetChildActive(rwitemidxself.rankbg,true)
else
widget:SetChildActive(rwitemidxself.rankbg,false)
end

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
cfgrewards=self.mojiecfg.reward2
rewardList=self:getRewardByRank(cfgrewards,myRank)
else
cfgrewards=self.mojiecfg.reward4
rewardList=cfgrewards
end


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
else
widget:SetChildActive(rwitemidxself.value,false)
widget:SetChildActive(rwitemidxself.rankbg,false)
widget:SetChildActive(rwitemidxself.value3,false)
widget:SetChildActive(rwitemidxself.name,false)
widget:SetChildActive(rwitemidxself.value2,true)
widget:SetChildText(rwitemidxself.value2,FMT.cfmt(FONT_COLOR.eRedColor,'请祖师先加入仙盟'))
end



end


function UIMoJieRankMoHeXMWin:getRewardByRank(cfg,rank)
if cfg then
for k,v in ipairs(cfg)do
if v[3]and v[1]<=rank and rank<=v[2]then
return v[3]
end
end
end
end


function UIMoJieRankMoHeXMWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end


