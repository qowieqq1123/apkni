







def_class("UIJCKTRankWin",UIWindowBase)









function UIJCKTRankWin:bindComponents()

self.root=UIObject.get(self,0)
self.ScrollView=UILoopListView.new(self,1)
self.item=UIObject.get(self,2)
self.moneyRoot=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.yinJieButton=UIButton.get(self,5)
self.duJieButton=UIButton.get(self,6)
self.tips=UIText.get(self,7)
self.money1Btn=UIButton.get(self,8)
self.progressText=UIText.get(self,9)
self.xgtips=UIButton.get(self,10)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.yinJieButton:setButtonClick(function()self:onYinJieButton()end)

self.duJieButton:setButtonClick(function()self:onDuJieButton()end)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.xgtips:setButtonClick(function()self:onXgtips()end)



end


function UIJCKTRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
self.ScrollView:deleteSelf();self.ScrollView=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.yinJieButton);self.yinJieButton=nil;
_UIObject_release(self.duJieButton);self.duJieButton=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.money1Btn);self.money1Btn=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.xgtips);self.xgtips=nil;
end



















local OPEN_TYPE=
{
eKaiTian=1,
eChengXian=2,
eTwo=3,
}
local _this

function UIJCKTRankWin:onLoaded(...)
self:addNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
self:bindComponents()
JiuChongTianJieEnterController:req_kaitian_my_rank()
_this=self
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.8,nil)
end


function UIJCKTRankWin:__delete()
self:unbindComponents()
_this=nil
end




function UIJCKTRankWin:onShow(argtable,afterOnloaded)
self.xianguanNum=cfg_jctjbaseconfig_get(1).xianguanNum
self:initRankTab(argtable)

self:refreshRank()
end


function UIJCKTRankWin:onHide()

end

function UIJCKTRankWin:initRankTab(argtable)
local openType=argtable.openType
if openType==OPEN_TYPE.eKaiTian then
self.yinJieButton:setActive(false)
self.duJieButton:setActive(false)
self.selectType=1
elseif openType==OPEN_TYPE.eChengXian then
self.yinJieButton:setActive(false)
self.duJieButton:setActive(false)
self.selectType=2
elseif openType==OPEN_TYPE.eTwo then
self.yinJieButton:setActive(true)
self.duJieButton:setActive(true)
self.selectType=argtable.selectType or 1
if self.selectType==1 then
local yinJie=self.yinJieButton:getWidgetBase()
yinJie:SetChildActive(0,true)
elseif self.selectType==2 then
local duJie=self.duJieButton:getWidgetBase()
duJie:SetChildActive(0,true)
end
end

end

function UIJCKTRankWin.onRankListRefresh(rankType)
if _this then
if rankType==eRankListType.eYinJieKaiTian then
_this:refreshKaiTianRank()
elseif rankType==eRankListType.eDuJieFeiSheng then
_this:refreshChengXianRank()
end
end
end

function UIJCKTRankWin:refreshRank()
if self.selectType==1 then
rankListController:req_rankList_data(eRankListType.eYinJieKaiTian)
self:refreshKaiTianRank()
elseif self.selectType==2 then
rankListController:req_rankList_data(eRankListType.eDuJieFeiSheng)
self:refreshChengXianRank()
end
end

function UIJCKTRankWin:refreshKaiTianRank()

local data=rankListModel:getRankList(eRankListType.eYinJieKaiTian)

local len=#data
if len<50 then
for i=len+1,50 do
table.insert(data,{actorId=0,name='虚位以待',serverId=0,rank=i,sec=0})
end
end
self.rankList=data
local _slotName='item'
self.ScrollView:initData(_slotName,data)
self.ScrollView:jumpItem(1)

self.progressText:setText("应劫时间")
self.tips:setText("宗门等级达到<color=#ca631d>44级</color>且完成<color=#ca631d>谪仙令</color>即可应劫")

self:fillItemMyKaiTian()
end

function UIJCKTRankWin:refreshChengXianRank()

local data=rankListModel:getRankList(eRankListType.eDuJieFeiSheng)

local len=#data
if len<50 then
for i=len+1,50 do
table.insert(data,{actorId=0,name='虚位以待',serverId=0,rank=i,percent=0})
end
end
self.rankList=data

local _slotName='item'
self.ScrollView:initData(_slotName,data)
self.ScrollView:jumpItem(1)
local myWidget=self.item:getWidgetBase()
self:fillItemChengXian(myWidget,-1,true)
self.progressText:setText("渡劫进度")
self.tips:setText("")

self:fillItemMyChengXian()
end

function UIJCKTRankWin:onFreshAction(i,widget)
if self.selectType==1 then
self:fillItemKaiTian(widget,i,false)
elseif self.selectType==2 then
self:fillItemChengXian(widget,i,false)
end
end
function UIJCKTRankWin:onStartAction()

end

function UIJCKTRankWin:fillItemKaiTian(widget,index)
local data=self.rankList[index]
if not data then return end
widget:SetChildText(1,data.rank)
widget:SetChildActive(13,data.rank==1)
local rankIcon
if data.rank<=3 and data.rank>1 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',data.rank)
end
local showRankIcon=rankIcon~=nil
widget:SetChildActive(0,showRankIcon)
if showRankIcon then
widget:SetChildCSImageSprite(0,globalABLookup.rankList,rankIcon)
end
if data.actorId==0 then
widget:SetChildActive(7,false)
widget:SetChildActive(8,true)

widget:SetChildActive(12,false)
else
widget:SetChildActive(7,true)
widget:SetChildActive(8,false)

widget:SetChildActive(12,true)

local headWidget=widget:GetChildWidgetBase(12)
playerController:setHeadIcon(headWidget,0,{iconInfo=data.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
headWidget:SetChildButtonClick(2,function()
self:onClickPlayer(data.actorId)
end)
local serverName=loginModel:getServerName(data.serverId)

widget:SetChildText(3,FMT.fmt("<color=#ca631d>[{0}]</color>\n{1}",serverName,data.name))

widget:SetChildText(6,timeHelper.getFormatByShortStamp(data.sec))
end


end

function UIJCKTRankWin:onClickPlayer(actorId)
local attach={
type=otherPlayerController.eAttachType.Rank,
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end
function UIJCKTRankWin:fillItemMyKaiTian()
local widget=self.item:getWidgetBase()

local playerId=playerModel:getActorID()
local data={rank=0,sec=0,name=playerModel:getActorName(),serverId=playerModel:getActorServerID(),actorId=playerId}
for i,v in ipairs(self.rankList)do
if mathHelper.compareInt64(playerId,v.actorId)then
data=v
break
end
end

local rankIcon
if data.rank<=3 and data.rank>1 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',data.rank)
end
local showRankIcon=rankIcon~=nil
widget:SetChildActive(0,showRankIcon)
widget:SetChildText(1,data.rank==0 and"未上榜"or data.rank)
widget:SetChildActive(13,data.rank==1)

widget:SetChildActive(7,true)
widget:SetChildActive(8,false)

local serverName=loginModel:getServerName(data.serverId)
widget:SetChildText(3,FMT.fmt("<color=#ca631d>[{0}]</color>\n{1}",serverName,data.name))

if data.sec~=0 then
widget:SetChildText(6,timeHelper.getFormatByShortStamp(data.sec))
else
widget:SetChildText(6,'')
end

widget:SetChildActive(12,true)

local headWidget=widget:GetChildWidgetBase(12)
playerController:setHeadIcon(headWidget,0,{iconInfo=data.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
headWidget:SetChildButtonClick(2,function()
self:onClickPlayer(data.actorId)
end)

end

function UIJCKTRankWin:fillItemChengXian(widget,index,me)
local data=self.rankList[index]
if not data then return end
widget:SetChildText(1,data.rank)
widget:SetChildActive(13,false)


local rankIcon
if data.rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',data.rank)
end
local showRankIcon=rankIcon~=nil
widget:SetChildActive(0,showRankIcon)
if showRankIcon then
widget:SetChildCSImageSprite(0,globalABLookup.rankList,rankIcon)
end
if data.actorId==0 then
widget:SetChildActive(7,false)
widget:SetChildActive(8,true)
widget:SetChildActive(12,false)
widget:SetChildActive(17,false)
widget:SetChildActive(18,false)
else
widget:SetChildActive(7,true)
widget:SetChildActive(8,false)
local serverName=loginModel:getServerName(data.serverId)
widget:SetChildText(3,FMT.fmt("<color=#ca631d>[{0}]</color>\n{1}",serverName,data.name))

if data.percent>=100 then
widget:SetChildActive(9,false)
widget:SetChildActive(14,true)
widget:SetChildText(6,"")
else
widget:SetChildActive(9,true)
widget:SetChildActive(14,false)
widget:SetChildProgress(9,data.percent,100)
widget:SetChildText(11,FMT.fmt("{0}%",math.floor(data.percent*100)/100))
end

widget:SetChildActive(12,true)
local headWidget=widget:GetChildWidgetBase(12)
playerController:setHeadIcon(headWidget,0,{iconInfo=data.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
headWidget:SetChildButtonClick(2,function()
self:onClickPlayer(data.actorId)
end)

local _index=data.rank
widget:SetChildActive(17,false)
widget:SetChildActive(18,false)
if self.xianguanNum and self.xianguanNum[1]then
if _index<=self.xianguanNum[1]then
local _idx=_index+100
local cfg=cfg_xianguanconfig_get(_idx)

if cfg then
local chatFlagId=cfg.chatFlagId or 3
local flagCfg=cfgHelper.get1(cfg_chatflagconfig_get,chatFlagId)
widget:SetChildActive(17,true)
widget:SetChildText(16,flagCfg.name)
local icon=chatModel:getSignIcon(flagCfg.icon)
if icon then
widget:SetChildIcon(15,icon,true)
end




widget:SetChildButtonClick(15,function()
self:onClickXGtag(cfg,_index)
end)
end
end
end
end
end

function UIJCKTRankWin:fillItemMyChengXian()
local widget=self.item:getWidgetBase()

local playerId=playerModel:getActorID()
local data={rank=0,sec=0,name=playerModel:getActorName(),serverId=playerModel:getActorServerID(),actorId=playerId}
for i,v in ipairs(self.rankList)do
if mathHelper.compareInt64(playerId,v.actorId)then
data=v
break
end
end

local rankIcon
if data.rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',data.rank)
end
local showRankIcon=rankIcon~=nil
widget:SetChildActive(0,showRankIcon)
widget:SetChildText(1,data.rank==0 and"未上榜"or data.rank)
widget:SetChildActive(13,false)
widget:SetChildActive(7,true)
widget:SetChildActive(8,false)
local serverName=loginModel:getServerName(data.serverId)
widget:SetChildText(3,FMT.fmt("<color=#ca631d>[{0}]</color>\n{1}",serverName,data.name))

widget:SetChildText(6,"")

local cur,max=JiuChongTianJieEnterModel:getAllProgress()
if cur>=100 then
widget:SetChildActive(9,false)
widget:SetChildActive(14,true)
widget:SetChildText(6,"")
else
widget:SetChildActive(9,true)
widget:SetChildActive(14,false)
widget:SetChildProgress(9,cur,100)
widget:SetChildText(11,FMT.fmt("{0}%",cur))
end

widget:SetChildActive(12,true)
local headWidget=widget:GetChildWidgetBase(12)
playerController:setHeadIcon(headWidget,0,{iconInfo=data.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
headWidget:SetChildButtonClick(2,function()
self:onClickPlayer(data.actorId)
end)


local _index=data.rank
widget:SetChildActive(17,false)
widget:SetChildActive(18,false)
if _index>0 and self.xianguanNum and self.xianguanNum[1]then
if _index<=self.xianguanNum[1]then
local _idx=_index+100
local cfg=cfg_xianguanconfig_get(_idx)

if cfg then
local chatFlagId=cfg.chatFlagId or 3
local flagCfg=cfgHelper.get1(cfg_chatflagconfig_get,chatFlagId)
widget:SetChildActive(17,true)
widget:SetChildText(16,flagCfg.name)
local icon=chatModel:getSignIcon(flagCfg.icon)
if icon then
widget:SetChildIcon(15,icon,true)
end




widget:SetChildButtonClick(15,function()
self:onClickXGtag(cfg,_index)
end)
end
end
end
end




function UIJCKTRankWin:onYinJieButton()
self.selectType=1
local yinJie=self.yinJieButton:getWidgetBase()
yinJie:SetChildActive(0,true)
local duJie=self.duJieButton:getWidgetBase()
duJie:SetChildActive(0,false)

self:refreshRank()
end



function UIJCKTRankWin:onDuJieButton()
self.selectType=2
local yinJie=self.yinJieButton:getWidgetBase()
yinJie:SetChildActive(0,false)
local duJie=self.duJieButton:getWidgetBase()
duJie:SetChildActive(0,true)

self:refreshRank()
end



function UIJCKTRankWin:onMoney1Btn()
end

function UIJCKTRankWin:onCloseBtn()
self.root:setChildCanvasGroupAlpha(1)
self.ScrollView:initData('item',{})
local widget=self.item:getWidgetBase()
widget:SetChildActive(12,false)
self.root:setChildCanvasGroupDOFade(0,0.5,function()
self:closeSelf()
end)
end


function UIJCKTRankWin:onClickXGtag(_cfg,_index)











end


function UIJCKTRankWin:onXgtips()
local d={}
d.title='说明'
d.mode=3
d.name='UIJCKTRankWin_xgrule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end