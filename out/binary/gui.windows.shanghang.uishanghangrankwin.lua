







def_class("UIShangHangRankWin",UIWindowBase)









function UIShangHangRankWin:bindComponents()

self.money1Btn=UIButton.get(self,0)
self.ScrollView=UILoopListView.new(self,1)
self.item=UIObject.get(self,2)
self.timeText=UIText.get(self,3)
self.moneyRoot=UIObject.get(self,4)
self.closeButton=UIButton.get(self,5)
self.Content=UIObject.get(self,6)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.closeButton:setButtonClick(function()UIManager:closeWindow("UIShangHangRankWin")end)



end


function UIShangHangRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.money1Btn);self.money1Btn=nil;
self.ScrollView:deleteSelf();self.ScrollView=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.Content);self.Content=nil;
end



















function UIShangHangRankWin:onLoaded(...)
self:bindComponents()

notifySystem:listenNotify(notifyConfig.serverZoneFresh,function()
self:freshInfo()
end)
end


function UIShangHangRankWin:__delete()
self:unbindComponents()
end




function UIShangHangRankWin:onShow(argtable,afterOnloaded)

if not shangHangController:send_248_99()then
self:freshInfo()
end

self:freshMoney()

local rank_max=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"rank_max")

self.timeText:setText(FMT.fmt("至少进行一次交易且玉券数量前<color=#ca631d>{0}</color>名可上榜（玉券数量相同时，将按宗门实力高低进行排名）",rank_max))
end


function UIShangHangRankWin:onHide()

end

function UIShangHangRankWin:onShowArgRecv()
self:freshMoney()
end

function UIShangHangRankWin:freshInfo()

local ranklist=shangHangModel:getRankList()or{}
local myrank=shangHangModel:getMyRank()

local ranklookup={}
local myIndex
for i,v in ipairs(ranklist)do






if ranklookup[v.rank_idx]==nil then ranklookup[v.rank_idx]={}end
table.insert(ranklookup[v.rank_idx],v)

if myrank==v.rank_idx then myIndex=i end
end
self.ranklookup=ranklookup
local cfgs=cfg_shanghangrankconfig()
local rewardsLookup={}

local data={}

local nextListNum=0
for i,v in ipairs(cfgs)do

for j=v.rank[1],v.rank[2]do
rewardsLookup[j]=v
if not v.merge then
if ranklookup[j]then
nextListNum=#ranklookup[j]-1
for _,vv in ipairs(ranklookup[j])do
table.insert(data,{rankInfo={vv},reward=v.rewards,rank=j})
end
else
if nextListNum<=0 then
table.insert(data,{rankInfo=nil,reward=v.rewards,rank=j})
end
nextListNum=nextListNum-1
end
end
end
if v.merge then

local last=(v.rank[2]-v.rank[1]+1)
local d={rankInfo={},reward=v.rewards,rank=FMT.fmt("{0}~{1}",v.rank[1],v.rank[2])}
local n=0
for ii=v.rank[1],v.rank[2]do
if ranklookup[ii]then
for _,vv in ipairs(ranklookup[ii])do
table.insert(d.rankInfo,vv)
n=n+1
if n>3 then
break
end
end
end
if n>3 then
break
end
end
nextListNum=nextListNum-(v.rank[2]-v.rank[1]+1)
table.insert(data,d)
end
end
self.rewardsLookup=rewardsLookup
self.rankData=data







local _slotName='item'
self.ScrollView:initData(_slotName,data)


if myrank>0 then
if rewardsLookup[myIndex]then
self:setMyItem(myrank)
else
self:setTempItem()
end

else
self:setTempItem()
end
end

function UIShangHangRankWin:onFreshAction(i,widget)
self:fillItem(widget,i,false)
end
function UIShangHangRankWin:onStartAction()

end

function UIShangHangRankWin:fillItem(widget,index,me)
local rankData=self.rankData[index]
local rewards=rankData.reward

local actorinfo=rankData.rankInfo
widget:SetChildText(0,rankData.rank)
widget:SetChildActive(4,actorinfo==nil)

local iconStr=shangHangModel.getYuQuanIconStr()
if actorinfo and next(actorinfo)then

if#actorinfo>1 then
widget:SetChildActive(1,false)
widget:SetChildText(2,'')
widget:SetChildText(3,'')
widget:SetChildText(5,'')
widget:SetChildActive(12,true)
widget:SetChildActive(11,false)
widget:SetChildLayoutGroupCreateItems(12,#actorinfo,function(i)
local w=widget:GetChildLayoutGroupGridItem(12,i-1)
w:SetChildActive(0,true)
playerController:setHeadIcon(w,0,{iconInfo=actorinfo[i].iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
w:SetChildButtonClick(1,function()
self:onClickPlayer(actorinfo[i].actor_id)
end)
end)
else
widget:SetChildActive(11,true)
widget:SetChildActive(12,false)
actorinfo=actorinfo[1]
widget:SetChildActive(1,true)
playerController:setHeadIcon(widget,1,{iconInfo=actorinfo.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
local serverName=loginModel:getServerName(actorinfo.server_id)
widget:SetChildText(2,serverName)
widget:SetChildText(3,actorinfo.name)
widget:SetChildText(5,FMT.fmt('{0}{1}玉券',iconStr,mathHelper.formatNumber5(actorinfo.point,2)))
widget:SetChildButtonClick(11,function()
self:onClickPlayer(actorinfo.actor_id)
end)
end

widget:SetChildActive(4,false)
else
if not me then
widget:SetChildText(5,"")
else
widget:SetChildText(0,'<color=#c82c2c>未上榜</color>')
end
widget:SetChildText(2,'')
widget:SetChildText(3,'')

widget:SetChildActive(1,false)
widget:SetChildActive(4,true)
widget:SetChildIcon(10,'image_txdk_1',false)
end
local len=rewards~=nil and#rewards or 0
widget:SetChildLayoutGroupCreateItems(6,len,function(i)
local data={}
local reward=rewards[i]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(6,i-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
end)

widget:SetChildActive(7,rankData.rank==1)
widget:SetChildActive(8,rankData.rank==2)
widget:SetChildActive(9,rankData.rank==3)
widget:SetChildActive(13,index==1)
end


function UIShangHangRankWin:onClickPlayer(actorId)
local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=eRankListType.eShiLianTa
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end

function UIShangHangRankWin:setTempItem()
local widget=self.item:getChildWidgetBase()
local iconInfo=playerModel:getActorIconInfo()

widget:SetChildText(0,'<color=#c82c2c>未上榜</color>')
widget:SetChildActive(4,false)
playerController:setHeadIcon(widget,1,{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
local serverName=loginModel:getServerName(playerModel:getActorServerID())
widget:SetChildText(2,serverName)
widget:SetChildText(3,playerModel:getActorName())
local iconStr=shangHangModel.getYuQuanIconStr()
widget:SetChildText(5,FMT.fmt('{0}{1}玉券',iconStr,mathHelper.formatNumber5(shangHangModel:getZiChanZongZhi(),2)))
widget:SetChildLayoutGroupCreateItems(6,0)

widget:SetChildActive(7,false)
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
end

function UIShangHangRankWin:setMyItem(myrank)
local widget=self.item:getChildWidgetBase()
local iconInfo=playerModel:getActorIconInfo()
local iconStr=shangHangModel.getYuQuanIconStr()
widget:SetChildText(0,myrank)
widget:SetChildActive(4,false)
playerController:setHeadIcon(widget,1,{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
local serverName=loginModel:getServerName(playerModel:getActorServerID())
widget:SetChildText(2,serverName)
widget:SetChildText(3,playerModel:getActorName())
widget:SetChildText(5,FMT.fmt('{0}{1}玉券',iconStr,mathHelper.formatNumber5(shangHangModel:getZiChanZongZhi(),2)))

local rewards=self.rewardsLookup[myrank]
local len=rewards~=nil and#rewards or 0
widget:SetChildLayoutGroupCreateItems(6,len,function(i)
local data={}
local reward=rewards[i]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local widget1=widget:GetChildLayoutGroupGridItem(6,i-1)
widgetHelper.setNormalRewardItem(widget1,0,data)
end)

widget:SetChildActive(7,myrank==1)
widget:SetChildActive(8,myrank==2)
widget:SetChildActive(9,myrank==3)
end

function UIShangHangRankWin:freshMoney()
local moneyRoot=self.moneyRoot:getChildWidgetBase()
local money=shangHangModel:getActorMoney()
if not self.initMoneyIcon then
local iconname=shangHangModel.getYuQuanIcon()
moneyRoot:SetChildIcon(0,iconname,false)
self.initMoneyIcon=true
end
moneyRoot:SetChildText(1,mathHelper.formatNumber5(money,2))
end

function UIShangHangRankWin:onMoney1Btn()
shangHangController.showTransformMoney(self.moneyRoot,Vector2(-70,-100))
end



