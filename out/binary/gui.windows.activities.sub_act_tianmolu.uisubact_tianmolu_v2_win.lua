







def_class("UISubAct_tianmolu_v2_Win",UIWindowBase)









function UISubAct_tianmolu_v2_Win:bindComponents()

self.rwScrollView=UIObject.get(self,0)
self.spReward=UIObject.get(self,1)
self.count=UIText.get(self,2)
self.suo=UIObject.get(self,3)
self.payBtn=UIButton.get(self,4)
self.rechargeText=UIText.get(self,5)
self.moneyText=UILinkImageText.get(self,6)
self.cd=UIText.get(self,7)

self.payBtn:setButtonClick(function()self:onPayBtn()end)



end


function UISubAct_tianmolu_v2_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.spReward);self.spReward=nil;
_UIObject_release(self.count);self.count=nil;
_UIObject_release(self.suo);self.suo=nil;
_UIObject_release(self.payBtn);self.payBtn=nil;
_UIObject_release(self.rechargeText);self.rechargeText=nil;
_UIObject_release(self.moneyText);self.moneyText=nil;
_UIObject_release(self.cd);self.cd=nil;
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



function UISubAct_tianmolu_v2_Win:onLoaded(...)
self:bindComponents()

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.winlua:SetChildScrollViewInitScrollEvent(self.rwScrollView:getID(),-172,46,function(index)
self:setSPRewards(index+2)
end)
end


function UISubAct_tianmolu_v2_Win:__delete()
self:unbindComponents()
end




function UISubAct_tianmolu_v2_Win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eInvestAct2
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

self.taskaim=self.config.taskaim

if self.config.recharge then
self.rechargeText:setActive(true)
self.moneyText:setActive(false)
local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,self.config.recharge)
local price=rechargeCfg.rmb
if price then
self.rechargeText:setText(price)
end
elseif self.config.consume then
self.rechargeText:setActive(false)
self.moneyText:setActive(true)
local iconname=iconHelper.getIconName(self.config.consume[1][1])
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,32)
self.moneyText:setText(FMT.fmt("{0}{1}解锁",iconStr,self.config.consume[1][2]))

end
self.rwScrollView:setChildScrollRectEnable(true)
self:refresh()
end


function UISubAct_tianmolu_v2_Win:onHide()
self.rwScrollView:setChildScrollRectEnable(false)
end



function UISubAct_tianmolu_v2_Win:setSPRewards()
local ttimes=self:getTimes()
local num=#self.taskaim
for i=1,num do
local cfg=nil
local index=nil
if i<num then
if ttimes>=self.taskaim[i][1]and ttimes<self.taskaim[i+1][1]then
cfg=self.taskaim[i+1]
index=i+1
end
else
cfg=self.taskaim[num]
index=num
end
if cfg then
local check=ttimes>=cfg[1]
local item=self.spReward:getChildWidgetBase()
item:SetChildText(_item_index.count,cfg[1])
item:SetChildIconFillAmount(_item_index.jindu1,0)
item:SetChildActive(_item_index.jindu2,not check)
item:SetChildIconFillAmount(_item_index.jindu3,0)
item:SetChildActive(_item_index.jindu4,check)
self:setRewards(item,cfg,check,index)
break
end
end

end

function UISubAct_tianmolu_v2_Win:getTimes()
if not self.info then
return 0
end
return self.info:getTimes()
end

function UISubAct_tianmolu_v2_Win:isOpenEx()
if not self.info then
return false
end
return self.info:isOpenEx()
end

function UISubAct_tianmolu_v2_Win:isGotReward(rewardIdx)
if not self.info then
return false
end
return self.info:isGotReward(rewardIdx)
end

function UISubAct_tianmolu_v2_Win:isGotExReward(rewardIdx)
if not self.info then
return false
end
return self.info:isGotExReward(rewardIdx)
end

function UISubAct_tianmolu_v2_Win:refresh()
local ttimes=self:getTimes()
self.count:setText(ttimes)

self.isPaid=self:isOpenEx()
self.payBtn:setActive(not self.isPaid)
self.suo:setActive(not self.isPaid)

local cfgs=self.taskaim
local len=#cfgs
local index=0
local rindex
self.rwScrollView:setChildScrollViewDelayCreateGrids(len,1,0.01,5,false,false,function(i,item)
i=i+1
local lastCfg=cfgs[i-1]
local cfg=cfgs[i]
local nextCfg=cfgs[i+1]
local checkLast=lastCfg~=nil
local check=ttimes>=cfg[1]
local checkNext=nextCfg~=nil
item:SetChildText(_item_index.count,cfg[1])
item:SetChildIconFillAmount(_item_index.jindu1,i==1 and 0 or 1)
item:SetChildActive(_item_index.jindu2,not check)
local jd=0
if i>1 then
if check then
jd=1
else
if checkLast then
local hf=(cfg[1]-lastCfg[1])
local dv=ttimes-lastCfg[1]
jd=dv/hf
else
jd=ttimes/cfg[1]
end
end
end
jd=math.max(0,jd)
item:SetChildIconFillAmount(_item_index.jindu3,jd)
item:SetChildActive(_item_index.jindu4,check)
local state=self:setRewards(item,cfg,check,i)
if check then
index=i-1
end
if not rindex and state==1 then
rindex=i-1
end

local sindex=rindex or index
if len-1==i then
self.rwScrollView:setChildScrollViewSelectItem(sindex,false,false,false)
end

end)



self:setSPRewards()
end

function UISubAct_tianmolu_v2_Win:setRewards(item,cfg,unlock,rewardIdx)
local activeClick=false
local rws=cfg[2]
local receiveState=0
for ii,vv in ipairs(_item_index.items_left)do
local rw=rws[ii]
if rw then
item:SetChildActive(vv,true)
local widget=item:GetChildWidgetBase(vv)
widgetHelper.setNormalRewardItem(widget,0,rw)
local receive=self:isGotReward(rewardIdx)
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
rws=cfg[3]
for ii,vv in ipairs(_item_index.items_right)do
local rw=rws[ii]
if rw then
item:SetChildActive(vv,true)
local widget=item:GetChildWidgetBase(vv)
rw.showStage=true
widgetHelper.setNormalRewardItem(widget,0,rw)
if self.isPaid then
local receive=self:isGotExReward(rewardIdx)
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
local list1=self:getInvestIdxList()
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({1,unpack(list1)}))
end)
end
return receiveState
end


function UISubAct_tianmolu_v2_Win:showDialog(content,callback)
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

function UISubAct_tianmolu_v2_Win:checkPay(callback)
callback()
end

function UISubAct_tianmolu_v2_Win:getInvestIdxList()
local cfgs=self.taskaim
local list1={}
local ttimes=self:getTimes()
local openEx=self:isOpenEx()
for i,v in ipairs(cfgs)do
local check=ttimes>=v[1]
local isGot=self:isGotReward(i)
local isGotEx=self:isGotExReward(i)
if check and((not isGot)or(openEx and(not isGotEx)))then
table.insert(list1,i)
end
end
return list1
end

function UISubAct_tianmolu_v2_Win:getInvestRewards()
local cfgs=self.taskaim
local list1={}
local list2={}
local ttimes=self:getTimes()
for i,v in ipairs(cfgs)do
local check=ttimes>=v[1]
for ii,vv in ipairs(v[3])do
table.insert(list1,vv)
if check then
table.insert(list2,vv)
end
end
end
return self:mergeReward(list1),self:mergeReward(list2)
end

function UISubAct_tianmolu_v2_Win:mergeReward(list)
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





function UISubAct_tianmolu_v2_Win:onPayBtn()
self:checkPay(function()
local rlist1,rList2=self:getInvestRewards()
local rechargeId=self.config.recharge
local consume=self.config.consume
local actid,subType,subid=self.actid,self.subType,self.subid
local nameStr=''
if rechargeId then
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,self.config.recharge)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
nameStr=str
elseif consume then
local itemName=itemsConfig.getItemName(consume[1][1])
nameStr=FMT.fmt("{0}{1}",consume[1][2],itemName)
end
local args={
totalRewards=rlist1,
activeRewards=rList2,
title='天魔录',
jihuoText='解锁',
confirmText='解锁',
bgmodel=4931,
bgmodelOffset={0,53},
titleType=2,
payCall=function()
if rechargeId then
payControl.reqPay(rechargeId)
elseif consume then
moneySystem:useMoney(consume[1][1],consume[1][2],function()
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,subType,subid,jsonHelper.encode({2}))
end,WARNING_TYPE.eWarning)
end
end,
}
UIManager:showWindow('UIXFWDInvestBuyWin',args)
end)
end

