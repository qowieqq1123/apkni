







def_class("UISubAct_ShiLianMuBiaoRankWin",UIWindowBase)









function UISubAct_ShiLianMuBiaoRankWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.item=UIObject.get(self,1)
self.timeText=UIText.get(self,2)
self.selfDuanWeiIcon=UIImage.get(self,3)
self.selfDuanWeiVal=UIText.get(self,4)
self.selfRankImg=UIImage.get(self,5)
self.selfRank=UIText.get(self,6)
self.selfHeadIcon=UIImage.get(self,7)
self.selfHeadKuang=UIImage.get(self,8)
self.selfName=UIText.get(self,9)
self.selfFight=UIText.get(self,10)
self.selfRewardList=UIObject.get(self,11)
self.notrank=UIText.get(self,12)
self.lundaoFlag=UIObject.get(self,13)
self.selfScoreVal=UIText.get(self,14)
self.selfScoreIcon=UIImage.get(self,15)
self.Content=UIObject.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_ShiLianMuBiaoRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.selfDuanWeiIcon);self.selfDuanWeiIcon=nil;
_UIObject_release(self.selfDuanWeiVal);self.selfDuanWeiVal=nil;
_UIObject_release(self.selfRankImg);self.selfRankImg=nil;
_UIObject_release(self.selfRank);self.selfRank=nil;
_UIObject_release(self.selfHeadIcon);self.selfHeadIcon=nil;
_UIObject_release(self.selfHeadKuang);self.selfHeadKuang=nil;
_UIObject_release(self.selfName);self.selfName=nil;
_UIObject_release(self.selfFight);self.selfFight=nil;
_UIObject_release(self.selfRewardList);self.selfRewardList=nil;
_UIObject_release(self.notrank);self.notrank=nil;
_UIObject_release(self.lundaoFlag);self.lundaoFlag=nil;
_UIObject_release(self.selfScoreVal);self.selfScoreVal=nil;
_UIObject_release(self.selfScoreIcon);self.selfScoreIcon=nil;
_UIObject_release(self.Content);self.Content=nil;
end



















function UISubAct_ShiLianMuBiaoRankWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_ShiLianMuBiaoRankWin:__delete()
self:unbindComponents()
end




function UISubAct_ShiLianMuBiaoRankWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

if not self.sub_actInfo:sendRankFunc(self.sub_actcfg.rank_type)then
self:freshInfo()
end
end


function UISubAct_ShiLianMuBiaoRankWin:onHide()

end

function UISubAct_ShiLianMuBiaoRankWin:freshInfo()

local rankInfo=self.sub_actInfo:getRankData(self.sub_actcfg.rank_type)or{}
local ranklist=rankInfo.ranlist or{}
local myrank=rankInfo.myrank
local ranklookup={}
local myIndex
for i,v in ipairs(ranklist)do
if ranklookup[v.rank_id]==nil then ranklookup[v.rank_id]={}end
ranklookup[v.rank_id]=v
if myrank==v.rank_id then myIndex=i end
end
self.ranklookup=ranklookup
local cfgs=self.sub_actcfg.rank_reward
local rewardsLookup={}

local len=cfgHelper.getdef1(cfg_fiveelementstempleshoutongconfig,'rank_max')

local data={}

for i,v in ipairs(cfgs)do

for j=v[1][1],v[1][2]do
rewardsLookup[j]=v
if v[1][3]~=1 then
table.insert(data,{rankInfo={self.ranklookup[j]},reward=v,rank=j})
end
end
if v[1][3]==1 then

local last=(v[1][2]-v[1][1])>3 and v[1][1]+3 or(v[1][2]-v[1][1]+1)
local d={rankInfo={},reward=v,rank=FMT.fmt("{0}~{1}",v[1][1],v[1][2])}
for ii=v[1][1],last do
if ranklookup[ii]then
table.insert(d.rankInfo,ranklookup[ii])
end
end

table.insert(data,d)
else

end
end
self.rewardsLookup=rewardsLookup
self.rankData=data




self.winlua:SetChildLayoutGroupCreateItems(self.Content:getID(),#data,function(index)
local widget=self.winlua:GetChildLayoutGroupGridItem(self.Content:getID(),index-1)
self:fillItem(widget,index)
end)














if myIndex then
if rewardsLookup[myIndex]then
self:setMyItem(myrank)
else
self:setTempItem()
end



else
self:setTempItem()
end
end

function UISubAct_ShiLianMuBiaoRankWin:fillItem(widget,index,me)
local rankData=self.rankData[index]
local rewards=rankData.reward[2]

local actorinfo=rankData.rankInfo
widget:SetChildText(0,rankData.rank)
widget:SetChildActive(4,actorinfo==nil)
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
widget:SetChildText(2,actorinfo.zm_name)
widget:SetChildText(3,actorinfo.name)
widget:SetChildText(5,FMT.fmt('<color=#ca631d>{0}层</color>',actorinfo.layer))
widget:SetChildButtonClick(11,function()
self:onClickPlayer(actorinfo.actor_id)
end)
end


else
if not me then
local cfg=cfgHelper.get(cfg_fiveelementstempleconfig_get,self.sub_actcfg.rank_type,"rank_layer")
widget:SetChildText(5,FMT.fmt('<color=#65615f>{0}通关{1}层可上榜</color>',self.sub_actInfo:getName(self.sub_actcfg.rank_type),cfg))
else
widget:SetChildText(0,'<color=#c82c2c>未上榜</color>')
end
widget:SetChildText(2,'')
widget:SetChildText(3,'')
widget:SetChildActive(1,false)
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

widget:SetChildActive(7,index==1)
widget:SetChildActive(8,index==2)
widget:SetChildActive(9,index==3)
end


function UISubAct_ShiLianMuBiaoRankWin:onClickPlayer(actorId)
local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=eRankListType.eShiLianTa
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end
function UISubAct_ShiLianMuBiaoRankWin:setTempItem()
local widget=self.item:getChildWidgetBase()
local iconInfo=playerModel:getActorIconInfo()

widget:SetChildText(0,'<color=#c82c2c>未上榜</color>')
widget:SetChildActive(4,false)
playerController:setHeadIcon(widget,1,{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
widget:SetChildText(2,UISettingModel:getZMName())
widget:SetChildText(3,playerModel:getActorName())
widget:SetChildText(5,FMT.fmt('{0}层',self.sub_actInfo:getMyScore(self.sub_actcfg.rank_type)))
widget:SetChildLayoutGroupCreateItems(6,0)

widget:SetChildActive(7,false)
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
end

function UISubAct_ShiLianMuBiaoRankWin:setMyItem(myrank)
local widget=self.item:getChildWidgetBase()
local iconInfo=playerModel:getActorIconInfo()

widget:SetChildText(0,myrank)
widget:SetChildActive(4,false)
playerController:setHeadIcon(widget,1,{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
widget:SetChildText(2,UISettingModel:getZMName())
widget:SetChildText(3,playerModel:getActorName())
widget:SetChildText(5,FMT.fmt('{0}层',self.sub_actInfo:getMyScore(self.sub_actcfg.rank_type)))

local rewards=self.rewardsLookup[myrank][2]
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






function UISubAct_ShiLianMuBiaoRankWin:onCloseBtn()
self:closeSelf()
end

