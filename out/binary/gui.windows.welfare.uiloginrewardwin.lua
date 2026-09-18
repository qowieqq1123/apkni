







def_class("UILoginRewardWin",UIWindowBase)









function UILoginRewardWin:bindComponents()

self.buyBtnText=UIText.get(self,0)
self.scrollView=UIObject.get(self,1)
self.suo=UIObject.get(self,2)
self.buyBtn=UIButton.get(self,3)
self.time=UIText.get(self,4)
self.ratio=UIText.get(self,5)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)



end


function UILoginRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buyBtnText);self.buyBtnText=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.suo);self.suo=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.ratio);self.ratio=nil;
end
















local _item_index={
count=0,
item1=1,
item2=2,
item3=3,
recv_btn=4,
recv_btn_txt=5,
flag1=6,
flag2=7,
star=8,
reddot=9,
}




function UILoginRewardWin:onLoaded(...)
self:bindComponents()

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UILoginRewardWin:__delete()
self:unbindComponents()
end

function UILoginRewardWin:getDatas()
local cfg=cfgHelper.get1(cfg_logingiftconfig_get,self.data.id)
local list={}
for k,v in pairs(cfg.login_gift)do
local data={}
data.day=k
data.reward1=zongmenControl:getRewardConfigData(v[1],self.data.level)
data.reward2=zongmenControl:getRewardConfigData(v[2],self.data.level)
local pass=self.day>=data.day
local recv1=self.data.recv_day1>=data.day
local recv2=self.data.recv_day2>=data.day
if pass then
if recv1 and recv2 then
data.sort=1
else
if not recv1 then
data.sort=4
else
if self.isPaid then
data.sort=4
else
data.sort=3
end
end
end
else
data.sort=2
end
table.insert(list,data)
end
table.sort(list,function(a,b)
if a.sort>b.sort then
return true
elseif a.sort==b.sort then
return a.day<b.day
else
return false
end
end)
return list
end




function UILoginRewardWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UILoginRewardWin:refresh()
self:setInfo()
self:setTargetList()
end

function UILoginRewardWin:setInfo()
self.data=welfareModel:getLoginRewardData()

local lcfg=cfgHelper.get1(cfg_logingiftconfig_get,self.data.id)
self.rechargeId=lcfg.recharge_id
local rechargecfg=cfg_rechargeconfig_get(self.rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.buyBtnText:setText(str)

self.ratio:setText(FMT.fmt('{0}倍',lcfg.ratio))

self.isPaid=self.data.recharge_id>0
self.suo:setActive(not self.isPaid)
self.buyBtn:setActive(not self.isPaid)
local btime=self.data.beginTime
local ctime=gameUtilityModel.getServerShortTime()
local dtime=ctime-btime
self.day=math.ceil(dtime/86400)

self:clearTimer()
local cfg=cfgHelper.get1(cfg_logingiftconfig_get,self.data.id)
local etime=btime+cfg.duration*86400
local tick=function()
local dt=etime-gameUtilityModel.getServerShortTime()
if dt>0 then
self.time:setText(FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp11(dt,true)))
else
self.time:setText('活动已结束')
self:clearTimer()
end
end
self.timer=self:setTimer(1,0,tick)
tick()
end

function UILoginRewardWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UILoginRewardWin:setTargetList()
local passDay=1
self.datas=self:getDatas()
local len=#self.datas
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.datas[i]
local pass=self.day>=data.day
if pass then
if passDay<data.day then
passDay=data.day
end
end
local color=pass and'#549327'or'#c82c2c'
local sday=math.min(self.day,data.day)
item:SetChildText(_item_index.count,FMT.fmt('第{0}天\n（<color={3}>{1}/{2}</color>）',data.day,sday,data.day,color))
local recv1=self.data.recv_day1>=data.day
local recv2=self.data.recv_day2>=data.day
local rw=data.reward1[1]
self:setReward(item,_item_index.item1,rw,pass,true,recv1)
rw=data.reward2[1]
self:setReward(item,_item_index.item2,rw,pass,self.isPaid,recv2)
rw=data.reward2[2]
self:setReward(item,_item_index.item3,rw,pass,self.isPaid,recv2)
if pass then
item:SetChildActive(_item_index.flag1,false)
if recv1 and recv2 then
item:SetChildActive(_item_index.flag2,true)
item:SetChildActive(_item_index.recv_btn,false)
else
item:SetChildActive(_item_index.flag2,false)
item:SetChildActive(_item_index.recv_btn,true)
local no_recv=not recv1 or(not recv2 and self.isPaid)
item:SetChildText(_item_index.recv_btn_txt,no_recv and'领取'or'继续领取')
item:SetChildActive(_item_index.reddot,no_recv)
item:SetChildButtonClick(_item_index.recv_btn,function()
if not no_recv and not self.isPaid then
self:onBuyBtn()
else
welfareController:reqLoginReward(passDay)
end
end)
end
else
item:SetChildActive(_item_index.flag1,true)
item:SetChildActive(_item_index.flag2,false)
item:SetChildActive(_item_index.recv_btn,false)
end
item:SetChildActive(_item_index.star,pass)
end
end

function UILoginRewardWin:setReward(item,index,rw,pass,paid,recv)
local showGrayImage=not paid
local widget=item:GetChildWidgetBase(index)
widgetHelper.setNormalRewardItem(widget,0,{rw[1],rw[2],showGrayImage=showGrayImage})
widget:SetChildActive(1,recv)
end


function UILoginRewardWin:onHide()

end

function UILoginRewardWin:getInvestRewards()
local list1={}
local list2={}
for i,v in ipairs(self.datas)do
local pass=self.day>=v.day
for ii,vv in ipairs(v.reward2)do
table.insert(list1,vv)
if pass then
table.insert(list2,vv)
end
end
end
return self:mergeReward(list1),self:mergeReward(list2)
end

function UILoginRewardWin:mergeReward(list)
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



function UILoginRewardWin:onBuyBtn()
local rlist1,rList2=self:getInvestRewards()
local cfg=cfgHelper.get1(cfg_logingiftconfig_get,self.data.id)
local args={
rechargeId=cfg.recharge_id,
totalRewards=rlist1,
activeRewards=rList2,
title='登录投资'
}
UIManager:showWindow('UIXFWDInvestBuyWin',args)
end

