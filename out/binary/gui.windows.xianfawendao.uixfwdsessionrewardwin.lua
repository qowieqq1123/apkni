







def_class("UIXFWDSessionRewardWin",UIWindowBase)









function UIXFWDSessionRewardWin:bindComponents()

self.rwScrollView=UIObject.get(self,0)
self.spReward=UIObject.get(self,1)
self.suo=UIObject.get(self,2)
self.payBtn=UIButton.get(self,3)
self.cd=UIText.get(self,4)
self.count=UIText.get(self,5)

self.payBtn:setButtonClick(function()self:onPayBtn()end)



end


function UIXFWDSessionRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.spReward);self.spReward=nil;
_UIObject_release(self.suo);self.suo=nil;
_UIObject_release(self.payBtn);self.payBtn=nil;
_UIObject_release(self.cd);self.cd=nil;
_UIObject_release(self.count);self.count=nil;
end
















local _item_index=
{
count=0,
jindu1=1,
jindu2=2,
jindu3=3,
jindu4=4,
items_left={5,6,7,8},
items_right={9,10,11,12},
}




function UIXFWDSessionRewardWin:onLoaded(...)
self:bindComponents()

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.winlua:SetChildScrollViewInitScrollEvent(self.rwScrollView:getID(),-172,46,function(index)
self:setSPRewards(index+2)
end)
end

function UIXFWDSessionRewardWin:getLastSPRewardIndex(index)
for i=index,1,-1 do
local cfg=cfgHelper.get1(cfg_xianfawendaoinvestconfig_get,i)
if cfg and cfg.is_sp_reward then
return i
end
end
return 1
end

function UIXFWDSessionRewardWin:setSPRewards(index)
local sIndex=self:getLastSPRewardIndex(index)
if sIndex~=self.showSPIndex then
local cfg=cfgHelper.get1(cfg_xianfawendaoinvestconfig_get,sIndex)
if cfg and cfg.is_sp_reward then
self.showSPIndex=sIndex
local ttimes=UIXianFaWenDaoControl:getTotalTimes()
local check=ttimes>=cfg.times
local item=self.spReward:getChildWidgetBase()
item:SetChildText(_item_index.count,cfg.times)
item:SetChildIconFillAmount(_item_index.jindu1,0)
item:SetChildActive(_item_index.jindu2,not check)
item:SetChildIconFillAmount(_item_index.jindu3,0)
item:SetChildActive(_item_index.jindu4,check)
self:setRewards(item,cfg,check)
end
end
end


function UIXFWDSessionRewardWin:__delete()
self:unbindComponents()
end




function UIXFWDSessionRewardWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UIXFWDSessionRewardWin:refresh()
local ttimes=UIXianFaWenDaoControl:getTotalTimes()
self.count:setText(ttimes)

self.isPaid=UIXianFaWenDaoControl:isInvestPaid()
self.payBtn:setActive(not self.isPaid)
self.suo:setActive(not self.isPaid)

local cfgs=cfg_xianfawendaoinvestconfig()
local len=#cfgs
self.rwScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
local index=0
local rindex
for i=1,count do
local item=grids[i-1]
local lastCfg=cfgs[i-1]
local cfg=cfgs[i]
local nextCfg=cfgs[i+1]
local checkLast=lastCfg~=nil
local check=ttimes>=cfg.times
local checkNext=nextCfg~=nil
item:SetChildText(_item_index.count,cfg.times)
item:SetChildIconFillAmount(_item_index.jindu1,i==count and 0.5 or 1)
item:SetChildActive(_item_index.jindu2,not check)
local jd=0
if check then
if checkNext then
local hf=(nextCfg.times-cfg.times)/2
local dv=ttimes-cfg.times
jd=math.min(1,(dv/hf)*0.5+0.5)
else
jd=0.5
end
else
if checkLast then
local hf=(cfg.times-lastCfg.times)/2
local dv=ttimes-lastCfg.times-hf
jd=math.min(0.5,(dv/hf)*0.5)
else
jd=math.min(0.5,(ttimes/cfg.times)*0.5)
end
end
jd=math.max(0,jd)
item:SetChildIconFillAmount(_item_index.jindu3,jd)
item:SetChildActive(_item_index.jindu4,check)
local state=self:setRewards(item,cfg,check)
if check then
index=i-1
end
if not rindex and state==1 then
rindex=i-1
end
end

local sindex=rindex or index
self.rwScrollView:setChildScrollViewSelectItem(sindex,false,false,false)

self:setSPRewards(sindex+2)

self.showSPIndex=nil


self:startCountDowm()
end

function UIXFWDSessionRewardWin:setRewards(item,cfg,unlock)
local activeClick=false
local rws=cfg.free
local receiveState=0
for ii,vv in ipairs(_item_index.items_left)do
local rw=rws[ii]
if rw then
item:SetChildActive(vv,true)
local widget=item:GetChildWidgetBase(vv)
widgetHelper.setNormalRewardItem(widget,0,rw)
local receive=UIXianFaWenDaoControl:checkInvestFlag(cfg.id,true)
if receive then
widget:SetChildActive(1,true)
widget:SetChildActive(2,true)
widget:SetChildActive(3,false)
receiveState=2
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
if unlock then
widget:SetChildActive(3,true)
widget:SetChildAnimationStringID(3,"xianshu_light",false)
activeClick=true
receiveState=1
else
widget:SetChildActive(3,false)
end
end
else
item:SetChildActive(vv,false)
end
end
rws=cfg.invest
for ii,vv in ipairs(_item_index.items_right)do
local rw=rws[ii]
if rw then
item:SetChildActive(vv,true)
local widget=item:GetChildWidgetBase(vv)
widgetHelper.setNormalRewardItem(widget,0,rw)
if self.isPaid then
local receive=UIXianFaWenDaoControl:checkInvestFlag(cfg.id,false)
if receive then
widget:SetChildActive(1,true)
widget:SetChildActive(2,true)
widget:SetChildActive(3,false)
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
if unlock then
widget:SetChildActive(3,true)
widget:SetChildAnimationStringID(3,"xianshu_light",false)
activeClick=true
receiveState=1
else
widget:SetChildActive(3,false)
end
end
else
widget:SetChildActive(1,true)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
end
else
item:SetChildActive(vv,false)
end
end
item:SetChildActive(13,activeClick)
if activeClick then
item:SetChildButtonClick(13,function()
UIXianFaWenDaoControl:reqInvestReward()
end)
end
return receiveState
end

function UIXFWDSessionRewardWin:startCountDowm()
local isTruce=UIXianFaWenDaoControl:isInTruceTime()
local ttime
local fstr
if isTruce then
ttime=UIXianFaWenDaoControl:getSessionTruceEndTime()
fstr='休战结束倒计时：{0}'
else
ttime=UIXianFaWenDaoControl:getSessionEndTime()
fstr='赛季结束倒计时：{0}'
end
self:clearTimer()
local tick=function()
local dt=ttime-gameUtilityModel.getServerShortTime()
if dt>0 then
self.cd:setText(FMT.fmt(fstr,timeHelper.format_time_stamp11(dt,true)))
else
self:clearTimer()
self:refresh()
end
end
self.timer=self:setTimer(1,0,tick)
tick()
end

function UIXFWDSessionRewardWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIXFWDSessionRewardWin:onHide()

end

function UIXFWDSessionRewardWin:showDialog(content,callback)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIXFWDSessionRewardWin:checkPay(callback)
local ttime=UIXianFaWenDaoControl:getSessionEndTime()
local currtime=gameUtilityModel.getServerShortTime()
local day=math.floor((ttime-currtime)/86400)
local times=UIXianFaWenDaoControl:getChallengeTimes()
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local dt=cfg.free+#cfg.consume
local lt=dt-times
local count=lt+dt*day

local cfgs=cfg_xianfawendaoinvestconfig()
local maxCfg=cfgs[#cfgs]
local need=maxCfg.times
local curr=UIXianFaWenDaoControl:getTotalTimes()
local dis=need-curr

if dis>count then
self:showDialog(FMT.fmt('每天可挑战<color=#549327>{0}</color>次，赛季剩余次数不能达标最终档奖励，是否继续购买？',dt),callback)
else
callback()
end
end

function UIXFWDSessionRewardWin:getInvestRewards()
local cfgs=cfg_xianfawendaoinvestconfig()
local list1={}
local list2={}
local ttimes=UIXianFaWenDaoControl:getTotalTimes()
for i,v in ipairs(cfgs)do
local check=ttimes>=v.times
for ii,vv in ipairs(v.invest)do
table.insert(list1,vv)
if check then
table.insert(list2,vv)
end
end
end
return self:mergeReward(list1),self:mergeReward(list2)
end

function UIXFWDSessionRewardWin:mergeReward(list)
local mtb={}
for i,v in ipairs(list)do
local count=mtb[v[1]]or 0
mtb[v[1]]=count+v[2]
end
local ret={}
for k,v in pairs(mtb)do
table.insert(ret,{k,v})
end
return ret
end




function UIXFWDSessionRewardWin:onPayBtn()
self:checkPay(function()
local rlist1,rList2=self:getInvestRewards()
local args={
rechargeId=cfgHelper.getdef1(cfg_xianfawendaoinvestconfig,'rechargeid'),
totalRewards=rlist1,
activeRewards=rList2,
title='赛季投资'
}
UIManager:showWindow('UIXFWDInvestBuyWin',args)
end)
end

function UIXFWDSessionRewardWin:onCloseClick()
self:closeSelf()
end