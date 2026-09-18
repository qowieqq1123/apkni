







def_class("UIXFWDRankingWin",UIWindowBase)









function UIXFWDRankingWin:bindComponents()

self.cd=UIText.get(self,0)
self.groupScrollView=UIObject.get(self,1)
self.infoScrollView=UILoopListView.new(self,2)
self.myInfo=UIObject.get(self,3)

self.infoScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXFWDRankingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cd);self.cd=nil;
_UIObject_release(self.groupScrollView);self.groupScrollView=nil;
self.infoScrollView:deleteSelf();self.infoScrollView=nil;
_UIObject_release(self.myInfo);self.myInfo=nil;
end
















local _item_index=
{
rank=0,
heads={1,11,12,13},
server=2,
name=3,
score=4,
items={5,6,7,8},
info=9,
tips=10,
scoreIcon=14,
headRoot=15,
items_root=16,
rw_tips=17,
rankIcon=18,
wdcqflag=19,
}




function UIXFWDRankingWin:onLoaded(...)
self:bindComponents()

local _onItemClick=function(...)self:onItemClick(...)end
self.groupScrollView:setChildScrollViewInit(0.5,true,_onItemClick,nil)

end

function UIXFWDRankingWin:onItemClick(clickNum,index)
if self.selectIndex==index then
return
end

if self.selectIndex then
local item=self.groupScrollView:getChildScrollViewItemWidget(self.selectIndex)
item:SetChildActive(0,false)
end

self.selectIndex=index

local item=self.groupScrollView:getChildScrollViewItemWidget(self.selectIndex)
item:SetChildActive(0,true)

local cfg=self.tabDatas[index+1]
UIXianFaWenDaoControl:reqRankList(cfg.id)
end


function UIXFWDRankingWin:__delete()


self:unbindComponents()
end




function UIXFWDRankingWin:onShow(argtable,afterOnloaded)
local level=UIXianFaWenDaoControl:getLevel()
level=math.max(level,1)
self:refresh(level)
self:setCD()
end

function UIXFWDRankingWin:setCD()
local ttime=UIXianFaWenDaoControl:getSessionEndTime()
self:clearTimer()
local tick=function()
local dt=ttime-gameUtilityModel.getServerShortTime()
if dt>0 then
self.cd:setText(FMT.fmt('奖励结算倒计时：<color=#171311>{0}</color>',timeHelper.format_time_stamp11(dt,true)))
else
self:clearTimer()
self.cd:setText('奖励结算倒计时：<color=#171311>已结算</color>')
end
end
self.timer=self:setTimer(1,0,tick)
tick()
end

function UIXFWDRankingWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIXFWDRankingWin:getRankDatas(level)
local rankDatas=UIXianFaWenDaoControl:getRankDataByLevel(level)
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local cbline=cfg.rank[3]
local len=cbline-1
local nlen=len
local rangList={}
local lcfg=cfgHelper.get1(cfg_xianfawendaolevelconfig_get,level)
for i,v in ipairs(lcfg.rank)do
if v[1]>=cbline then
len=len+1
table.insert(rangList,{v[1],v[2]})
end
end
return rankDatas,nlen,len,rangList
end

function UIXFWDRankingWin:getTabDatas()
local level=UIXianFaWenDaoControl:getLevel()
level=math.max(level,1)
local cfgs=cfg_xianfawendaolevelconfig()
local list={}
for i,v in ipairs(cfgs)do
local num=UIXianFaWenDaoControl:getRankNumData(v.id)
if num>0 or v.id==level then
table.insert(list,v)
end
end
return list
end

function UIXFWDRankingWin:refresh(level)
self.tabDatas=self:getTabDatas()
local len=#self.tabDatas
self.groupScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.groupScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cfg=self.tabDatas[i]
item:SetChildActive(0,cfg.id==level)
item:SetChildText(1,cfg.name)
end

local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local cbnum=cfg.rank[4]
local rdlist=_item_index.heads
local tline=cfg.rank[2]
local nlname=cfgHelper.get2(cfg_xianfawendaoscoreconfig_get,tline,'name')
local icon=UIXianFaWenDaoControl:getScoreIconName()

local rankDatas,nlen,tlen,rangList=self:getRankDatas(level)
self:setMyInfo(level)

self.refreshData={
cbnum=cbnum,
rdlist=rdlist,
tline=tline,
nlname=nlname,
icon=icon,
level=level,
rankDatas=rankDatas,
nlen=nlen,
tlen=tlen,
rangList=rangList
}
self.infoScrollView:initData('item',rankDatas,tlen)


































































end

function UIXFWDRankingWin:checkShowWDCQFlag(id,rankData,nlen)
if not WDCQController.checkSysOpen()then return false end


local isInTruceTime=UIXianFaWenDaoControl:isInTruceTime()
if isInTruceTime then
if id<=nlen and rankData then
local info=WDCQModel:getRankRoleInfo2(rankData.actorid)
return info~=nil
end
else
local len=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'can_attend_rank')
return len>=id
end

return false
end

function UIXFWDRankingWin:onFreshAction(id,item)
local cbnum=self.refreshData.cbnum
local rdlist=self.refreshData.rdlist

local nlname=self.refreshData.nlname
local icon=self.refreshData.icon
local level=self.refreshData.level
local rankDatas=self.refreshData.rankDatas
local nlen=self.refreshData.nlen

local rangList=self.refreshData.rangList

local isShowWdcqFlag=false
item:SetChildActive(_item_index.wdcqflag,isShowWdcqFlag)


local i=id
local showRIcon=i<=3
item:SetChildActive(_item_index.rankIcon,showRIcon)
if showRIcon then
item:SetChildCSImageSprite(_item_index.rankIcon,globalABLookup.global,'icon_phbmingci_'..i)
end
if i<=nlen then
local data=rankDatas[i]
item:SetChildText(_item_index.rank,i)
if data and data.actorname then
item:SetChildActive(_item_index.headRoot,true)
item:SetChildActive(_item_index.info,true)
if data.iconInfo.actoricon==0 then
item:SetChildActive(20,true)
item:SetChildActive(rdlist[1],false)
else
item:SetChildActive(20,false)
item:SetChildActive(rdlist[1],true)
playerController:setHeadIcon(item,rdlist[1],{scale=0.75,iconInfo=data.iconInfo,updateRendererSize=true})
end
local sname=loginModel:getServerName(data.serverid)
item:SetChildText(_item_index.server,sname)
item:SetChildText(_item_index.name,data.actorname)
item:SetChildIcon(_item_index.scoreIcon,icon,true)
item:SetChildText(_item_index.score,data.score)
item:SetChildText(_item_index.tips,'')
else
item:SetChildActive(20,false)
if i<=3 then
item:SetChildText(_item_index.tips,FMT.fmt('需要达到<color=#ca631d>{0}</color>',nlname))
else
item:SetChildText(_item_index.tips,'虚位以待')
end
item:SetChildActive(_item_index.headRoot,false)
item:SetChildActive(_item_index.info,false)
end
for ii=2,cbnum do
local index=rdlist[ii]
item:SetChildActive(index,false)
end
local rewards=self:getReward(level,i)
self:setRewards(item,rewards)
else
local id=i-nlen
local rang=rangList[id]
if not rang then
logErr(id)
end
local lval=rang[1]
item:SetChildText(_item_index.rank,FMT.fmt('{0}~{1}',rang[1],rang[2]))
item:SetChildActive(_item_index.headRoot,true)
item:SetChildActive(_item_index.info,false)
item:SetChildText(_item_index.tips,'')
if rankDatas[lval]then
item:SetChildActive(_item_index.headRoot,true)
for ii=1,cbnum do
local rd=rankDatas[lval+ii-1]
local index=rdlist[ii]
local list={20,21,22,23}
if rd then
if rd.iconInfo.actoricon==0 then
item:SetChildActive(index,true)
item:SetChildActive(list[ii],true)
else
item:SetChildActive(list[ii],false)
item:SetChildActive(index,false)
playerController:setHeadIcon(item,index,{scale=0.75,iconInfo=rd.iconInfo,updateRendererSize=true})
end
else
item:SetChildActive(index,false)
end
end
item:SetChildText(_item_index.tips,'')
else
item:SetChildActive(20,false)
item:SetChildActive(21,false)
item:SetChildActive(22,false)
item:SetChildActive(23,false)
item:SetChildText(_item_index.tips,'虚位以待')
item:SetChildActive(_item_index.headRoot,false)
end
local rewards=self:getReward(level,lval)
self:setRewards(item,rewards)
end
end

function UIXFWDRankingWin:onStartAction()

end

function UIXFWDRankingWin:setRewards(item,rewards)
local rwlist=_item_index.items
for ii=1,4 do
local index=rwlist[ii]
local rw=rewards[ii]
if rw then
item:SetChildActive(index,true)
widgetHelper.setNormalRewardItem(item,index,rw)
else
item:SetChildActive(index,false)
end
end
end

function UIXFWDRankingWin:setMyInfo(level)
local myLevel=UIXianFaWenDaoControl:getLevel()
local myRank=UIXianFaWenDaoControl:getRank()
local widget=self.myInfo:getChildWidgetBase()
local inRank=myLevel==level and myRank>0
widget:SetChildText(_item_index.rank,inRank and myRank or'未上榜')
local showRIcon=inRank and myRank<=3
widget:SetChildActive(_item_index.rankIcon,showRIcon)

local can_attend_rank=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'can_attend_rank')
local isShowWdcqFlag=false
widget:SetChildActive(_item_index.wdcqflag,isShowWdcqFlag)

if showRIcon then
widget:SetChildCSImageSprite(_item_index.rankIcon,globalABLookup.global,'icon_phbmingci_'..myRank)
end
playerController:setHeadIcon(widget,_item_index.heads[1],{scale=0.75,iconInfo=nil})
local sname=loginModel:getMyServerName()
widget:SetChildText(_item_index.server,sname)
widget:SetChildText(_item_index.name,playerModel:getActorName())
local icon=UIXianFaWenDaoControl:getScoreIconName()
widget:SetChildIcon(_item_index.scoreIcon,icon,true)
local score=UIXianFaWenDaoControl:getScore()
widget:SetChildText(_item_index.score,score)
if inRank then
widget:SetChildActive(_item_index.items_root,true)
widget:SetChildText(_item_index.rw_tips,'')
local rewards=self:getReward(level,myRank)
self:setRewards(widget,rewards)
else
widget:SetChildActive(_item_index.items_root,false)
widget:SetChildText(_item_index.rw_tips,'（暂无奖励）')
end
end

function UIXFWDRankingWin:getReward(level,rank)
local cfg=cfgHelper.get1(cfg_xianfawendaolevelconfig_get,level)
for i,v in ipairs(cfg.rank)do
if rank>=v[1]and rank<=v[2]then
return v[3]
end
end
end


function UIXFWDRankingWin:onHide()

end




function UIXFWDRankingWin:onCloseClick()
self:closeSelf()
end