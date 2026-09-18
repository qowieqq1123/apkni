







def_class("UIWuXingDianSDRankWin",UIWindowBase)









function UIWuXingDianSDRankWin:bindComponents()

self.desc=UIText.get(self,0)
self.Content=UIObject.get(self,1)
self.item=UIObject.get(self,2)



end


function UIWuXingDianSDRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.item);self.item=nil;
end


















function UIWuXingDianSDRankWin:onLoaded(...)
self:bindComponents()
end

function UIWuXingDianSDRankWin:__delete()
self:unbindComponents()
end

function UIWuXingDianSDRankWin:onShow(argtable,afterOnloaded)
local id=argtable and argtable.id or 0
if not wuXingDianController:send_25_21(id)then
self:freshInfo()
end
end

function UIWuXingDianSDRankWin:onHide()

end



function UIWuXingDianSDRankWin:freshInfo()

local rankInfo=wuXingDianModel:getRankList()or{}
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
local cfgs=cfgHelper.getdef1(cfg_fiveelementstempleshoutongconfig,'rank_rewards',1)
local rewardsLookup={}
for i,v in ipairs(cfgs)do
for j=v[1][1],v[1][2]do
rewardsLookup[j]=v[2]
end
end
self.rewardsLookup=rewardsLookup
local len=cfgHelper.getdef1(cfg_fiveelementstempleshoutongconfig,'rank_max')

self.winlua:SetChildLayoutGroupCreateItems(self.Content:getID(),len,function(index)
local widget=self.winlua:GetChildLayoutGroupGridItem(self.Content:getID(),index-1)
self:fillItem(widget,index)
end)

local tick=function()
local jie,endStamp=wuXingDianModel:getCurJie()
local left=endStamp-timeHelper.getServerLongTime()
if left>=0 then
local endStr=timeHelper.format_time_stamp3(left)
self.desc:setText(FMT.fmt('<color=#7d3b17>结算剩余时间：</color><color=#171311>{0}</color>',endStr))
else
self.desc:setText('')
end
end
self.tickTimer=self:setTimer(1,0,tick)
tick()

if myIndex then
local widget=self.item:getChildWidgetBase()
self:fillItem(widget,myIndex)
else
self:setTempItem()
end
end

function UIWuXingDianSDRankWin:fillItem(widget,index)
local cfgs=cfgHelper.getdef1(cfg_fiveelementstempleshoutongconfig,'rank_rewards',2)
local rewards=self.rewardsLookup[index]
local actorinfo=self.ranklookup[index]
widget:SetChildText(0,index)

widget:SetChildActive(4,actorinfo==nil)
if actorinfo then
widget:SetChildActive(1,true)
playerController:setHeadIcon(widget,1,{iconInfo=actorinfo.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
widget:SetChildText(2,actorinfo.zm_name)
widget:SetChildText(3,actorinfo.name)
widget:SetChildText(5,FMT.fmt('{0}层',actorinfo.layer))
else
widget:SetChildText(5,'')
widget:SetChildText(2,'')
widget:SetChildText(3,'')
widget:SetChildActive(1,false)
widget:SetChildIcon(10,'image_txdk_1',false)
end
local len=rewards~=nil and 1 or 0
widget:SetChildLayoutGroupCreateItems(6,len,function(i)
local data={}
local reward=rewards
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

function UIWuXingDianSDRankWin:setTempItem()
local widget=self.item:getChildWidgetBase()
local iconInfo=playerModel:getActorIconInfo()

widget:SetChildText(0,'未上榜')
widget:SetChildActive(4,false)
playerController:setHeadIcon(widget,1,{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
widget:SetChildText(2,UISettingModel:getZMName())
widget:SetChildText(3,playerModel:getActorName())
widget:SetChildText(5,FMT.fmt('{0}层',wuXingDianModel:getFinishLayer(wuXingDianConfig.getSDType())))
widget:SetChildLayoutGroupCreateItems(6,0)

widget:SetChildActive(7,false)
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
end