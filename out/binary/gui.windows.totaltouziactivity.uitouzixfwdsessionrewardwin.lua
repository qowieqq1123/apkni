







def_class("UITouZiXFWDSessionRewardWin",UIWindowBase)









function UITouZiXFWDSessionRewardWin:bindComponents()

self.rwScrollView=UIObject.get(self,0)
self.spReward=UIObject.get(self,1)
self.suo=UIObject.get(self,2)
self.payBtn=UIButton.get(self,3)
self.cd=UIText.get(self,4)
self.helpbtn=UIButton.get(self,5)
self.bgmodel=UIObject.get(self,6)
self.price=UIText.get(self,7)
self.Image=UIImage.get(self,8)

self.payBtn:setButtonClick(function()self:onPayBtn()end)

self.helpbtn:setButtonClick(function()self:onHelpbtn()end)



end


function UITouZiXFWDSessionRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.spReward);self.spReward=nil;
_UIObject_release(self.suo);self.suo=nil;
_UIObject_release(self.payBtn);self.payBtn=nil;
_UIObject_release(self.cd);self.cd=nil;
_UIObject_release(self.helpbtn);self.helpbtn=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.price);self.price=nil;
_UIObject_release(self.Image);self.Image=nil;
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

local rwItemIndex={
Desc=0,
baseRewards=1,
upRewards=2,
baseGot=3,
upGot=4,
Desc2=5,
}

local commonItemIndex={
itemSmall=0,
gotFlag=1,
lock=2,
get=3,
}



local PfSpriteCfg=
{
[pfwindowslController.priceTypeStr.CNY]={'image_zmdjtzui_2',{31.3,12.6},{-81,12.6}},
[pfwindowslController.priceTypeStr.USD]={'image_zmdjtzui_8',{-20.3,12.6},{-11.7,12.6}},
[pfwindowslController.priceTypeStr.HKD]={'image_zmdjtzui_9',{-20.3,12.6},{-11.7,12.6}},
[pfwindowslController.priceTypeStr.TWD]={'image_zmdjtzui_11',{-20.3,12.6},{-11.7,12.6}},
[pfwindowslController.priceTypeStr.VND]={'image_zmdjtzui_2',{85,12.6},{-140,12.6}},
}




function UITouZiXFWDSessionRewardWin:onLoaded(...)
self:bindComponents()
self.bgmodel:setChildUIModelShowTarget(5540,1,{},eAnimationID.stand)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)




end

function UITouZiXFWDSessionRewardWin:onShowArgRecv()

end

function UITouZiXFWDSessionRewardWin:getLastSPRewardIndex(index)
for i=index,1,-1 do
local cfg=cfgHelper.get1(cfg_xianfawendaoinvestconfig_get,i)
if cfg and cfg.is_sp_reward then
return i
end
end
return 1
end

function UITouZiXFWDSessionRewardWin:setSPRewards(index)
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


function UITouZiXFWDSessionRewardWin:__delete()
self:unbindComponents()
end




function UITouZiXFWDSessionRewardWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UITouZiXFWDSessionRewardWin:refresh()
local ttimes=UIXianFaWenDaoControl:getTotalTimes()

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
item:SetChildText(rwItemIndex.Desc,FMT.fmt("{0}次",cfg.times))
local descStr2=FMT.fmt("(<color=#{0}>{1}/{2}</color>)",check and"298a1c"or"e03333",ttimes,cfg.times)
item:SetChildText(rwItemIndex.Desc2,descStr2)


























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


self.showSPIndex=nil


self:startCountDowm()
self:setMoney()
end
function UITouZiXFWDSessionRewardWin:setMoney()
local rechargeId=cfgHelper.getdef1(cfg_xianfawendaoinvestconfig,'rechargeid')
local rechargecfg=cfg_rechargeconfig_get(rechargeId)
local MoneyType=pfwindowslController:getPFMoneyType()
local GameVersion=pfwindowslController:getGameVersion()
local cfg=PfSpriteCfg[MoneyType]
local moneyCount=rechargecfg.pay[GameVersion][MoneyType]
if cfg then
self.price:setText(moneyCount)
self.price:setChildAnchoredPosition(Vector2.New(cfg[3][1],cfg[3][2]))
self.Image:setSprite(globalABLookup.zongmenlevelinvestor,cfg[1],true)
self.Image:setChildAnchoredPosition(Vector2.New(cfg[2][1],cfg[2][2]))
end
end


function UITouZiXFWDSessionRewardWin:setRewards(item,cfg,unlock)
local activeClick=false
local rws=cfg.free
local receiveState=0
local isFinish=unlock

local baseRewards=cfg.free
item:SetChildLayoutGroupCreateItems(rwItemIndex.baseRewards,#baseRewards)
local grids=item:GetChildLayoutGroupGridList(rwItemIndex.baseRewards)
for i=1,#baseRewards do
local widget=grids[i-1]
local reward=baseRewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={gray=isFinish and 0 or 0,itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)



local baseRecvFlag=UIXianFaWenDaoControl:checkInvestFlag(cfg.id,true)
if baseRecvFlag then
receiveState=2
else
if isFinish then
receiveState=1
end
end
local isGrayMask=baseRecvFlag
prop[PropIndex(DataPropKey.eWidgetActive,7)]=baseRecvFlag

widget:SetChildActive(-1,true)
widget:SetChildPropData(commonItemIndex.itemSmall,prop)
widget:SetBaseItemClickEvent(commonItemIndex.itemSmall,function(...)
if isFinish and not baseRecvFlag then
self:onClickGetRewardBtn()
else
self:onClickRewardItem(...)
end

end)
widget:SetChildActive(commonItemIndex.lock,false)
widget:SetChildActive(commonItemIndex.get,isFinish and not baseRecvFlag)
widget:SetChildActive(commonItemIndex.gotFlag,baseRecvFlag)
end


local upRewards=cfg.invest
item:SetChildLayoutGroupCreateItems(rwItemIndex.upRewards,#upRewards)
local grids=item:GetChildLayoutGroupGridList(rwItemIndex.upRewards)
for i=1,#upRewards do
local widget=grids[i-1]
local reward=upRewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={gray=isFinish and 0 or 0,itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


local isLock=not self.isPaid
local upRecvFlag=UIXianFaWenDaoControl:checkInvestFlag(cfg.id,false)
if not isLock and not upRecvFlag and isFinish then
receiveState=1
end

local isGrayMask=upRecvFlag or isLock
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(commonItemIndex.itemSmall,prop)
widget:SetBaseItemClickEvent(commonItemIndex.itemSmall,function(...)
if isFinish and not upRecvFlag and not isLock then
self:onClickGetRewardBtn()
else
self:onClickRewardItem(...)
end

end)

widget:SetChildActive(commonItemIndex.lock,isLock)

widget:SetChildActive(commonItemIndex.get,not isLock and isFinish and not upRecvFlag)

widget:SetChildActive(commonItemIndex.gotFlag,upRecvFlag)
end






































































return receiveState
end

function UITouZiXFWDSessionRewardWin:startCountDowm()
local isTruce=UIXianFaWenDaoControl:isInTruceTime()
local ttime
local fstr
if isTruce then
ttime=UIXianFaWenDaoControl:getSessionTruceEndTime()
fstr='休战结束倒计时：{0}'
else
ttime=UIXianFaWenDaoControl:getSessionEndTime()
fstr='结束倒计时：{0}'
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

function UITouZiXFWDSessionRewardWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UITouZiXFWDSessionRewardWin:onHide()

end

function UITouZiXFWDSessionRewardWin:showDialog(content,callback)
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

function UITouZiXFWDSessionRewardWin:checkPay(callback)
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

function UITouZiXFWDSessionRewardWin:CheckXiuZhanPay(callback)
local ttime=UIXianFaWenDaoControl:getSessionTruceEndTime()
local currtime=gameUtilityModel.getServerShortTime()
local day=math.floor((ttime-currtime)/86400)
local times=UIXianFaWenDaoControl:getTotalTimes()
local cfgs=cfg_xianfawendaoinvestconfig()
local maxCfg=cfgs[#cfgs]
local need=maxCfg.times
if times<need then
self:showDialog(FMT.fmt('累计挑战次数未满<color=#c82c2c>{0}</color>次，购买投资无法获\n得全部奖励，是否要购买？',need),callback)
else
callback()
end

end


function UITouZiXFWDSessionRewardWin:getInvestRewards()
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

function UITouZiXFWDSessionRewardWin:mergeReward(list)
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




function UITouZiXFWDSessionRewardWin:onPayBtn()
local func=function()
local rlist1,rList2=self:getInvestRewards()
local args={
rechargeId=cfgHelper.getdef1(cfg_xianfawendaoinvestconfig,'rechargeid'),
totalRewards=rlist1,
activeRewards=rList2,
title='赛季投资'
}
UIManager:showWindow('UIXFWDInvestBuyWin',args)
end
local ttime=UIXianFaWenDaoControl:getSessionEndTime()
local currtime=gameUtilityModel.getServerShortTime()
if ttime>=currtime then
self:checkPay(func)
else
self:CheckXiuZhanPay(func)
end
end

function UITouZiXFWDSessionRewardWin:onCloseClick()
self:closeSelf()
end

function UITouZiXFWDSessionRewardWin:onHelpbtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='xfwd_reward_help_%s'})
end



function UITouZiXFWDSessionRewardWin:onClickGetRewardBtn()
UIXianFaWenDaoControl:reqInvestReward()
end

function UITouZiXFWDSessionRewardWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})

end

function UITouZiXFWDSessionRewardWin:enter()
jumpManager:jump({id=JUMP_TYPE.eXianFaWenDao},nil,JUMP_BACK.eNoBack)
end

