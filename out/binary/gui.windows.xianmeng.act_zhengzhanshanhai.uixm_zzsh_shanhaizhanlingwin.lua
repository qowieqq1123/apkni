







def_class("UIXM_ZZSH_ShanHaiZhanLingWin",UIWindowBase)









function UIXM_ZZSH_ShanHaiZhanLingWin:bindComponents()

self.modelBg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.unlockText=UIText.get(self,2)
self.unlcokBtn=UIButton.get(self,3)
self.unlcokbg=UIObject.get(self,4)
self.timeRoot=UIObject.get(self,5)
self.jumpBtn=UIButton.get(self,6)
self.TipsBtn=UIButton.get(self,7)
self.ScrollerView=UIObject.get(self,8)
self.titleImgae=UIObject.get(self,9)
self.title=UIText.get(self,10)
self.ratio1=UIImage.get(self,11)
self.suo2=UIObject.get(self,12)
self.touziName=UIText.get(self,13)
self.ratio2=UIImage.get(self,14)
self.suo1=UIObject.get(self,15)
self.lefttime=UIText.get(self,16)
self.all_jifen=UIText.get(self,17)
self.jifenroot=UIObject.get(self,18)
self.rewadProgress=UIObject.get(self,19)
self.jifenitem=UIObject.get(self,20)
self.rewardProgressBar=UIObject.get(self,21)
self.rewadProgressbg=UIObject.get(self,22)
self.Content=UIObject.get(self,23)
self.bottomBg=UIObject.get(self,24)

self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.TipsBtn:setButtonClick(function()self:onTipsBtn()end)
self.all={
["jifen"]=self.all_jifen,
}



end


function UIXM_ZZSH_ShanHaiZhanLingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
_UIObject_release(self.unlcokbg);self.unlcokbg=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.TipsBtn);self.TipsBtn=nil;
_UIObject_release(self.ScrollerView);self.ScrollerView=nil;
_UIObject_release(self.titleImgae);self.titleImgae=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.ratio1);self.ratio1=nil;
_UIObject_release(self.suo2);self.suo2=nil;
_UIObject_release(self.touziName);self.touziName=nil;
_UIObject_release(self.ratio2);self.ratio2=nil;
_UIObject_release(self.suo1);self.suo1=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.all_jifen);self.all_jifen=nil;
_UIObject_release(self.jifenroot);self.jifenroot=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.jifenitem);self.jifenitem=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewadProgressbg);self.rewadProgressbg=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.bottomBg);self.bottomBg=nil;
self.all=nil;
end



















local itemsize=117
local firstitemsize=82
local RewardState={
eRecved=1,
eNotRecv=2,
eRecv=3,
}


function UIXM_ZZSH_ShanHaiZhanLingWin:onLoaded(...)
self:bindComponents()
self.modelBg:setChildUIModelShowTarget(5423,1,{},0)
self.bottomBg:setChildUIModelShowTarget(5422,1,{},0)
end


function UIXM_ZZSH_ShanHaiZhanLingWin:__delete()
self:stopCDTick()
self:unbindComponents()
end




function UIXM_ZZSH_ShanHaiZhanLingWin:onShow(argtable,afterOnloaded)
self.config=zhengzhanshanhaiModel:getZhanLingConfig()
self.ScrollerView:setActive(true)
self:initdata()
self:refresh()
end


function UIXM_ZZSH_ShanHaiZhanLingWin:onHide()
self.ScrollerView:setActive(false)
end

function UIXM_ZZSH_ShanHaiZhanLingWin:onShowArgRecv()
self:onShow()
end

local itemcmp=
{
bg=0,
freeCreat=1,
moneyCreat=2,
rmbCreat=3,
activebg=4,
countTxt=5,
}

local item2cmp=
{
normalReward=0,
select=1,
spriteani=2,
lock=3,
gray=4,
}
local jifencmp=
{
activebg=0,
jifennum=1,
}


function UIXM_ZZSH_ShanHaiZhanLingWin:initdata()

self:startCDTick()


local len=#self.config
self.ScrollerView:setChildScrollViewCreateGrids(len,1)
local grids=self.ScrollerView:getChildScrollViewItemWidgets()
for i=1,len do
self:SetItemData_Init(grids[i-1],i)
end







self.rewardProgressBar:setChildSizeDelta(28,firstitemsize+itemsize*(len-1))
end

function UIXM_ZZSH_ShanHaiZhanLingWin:refresh()


local curConsume=zhengzhanshanhaiModel:getZhanLingData_completeCnt()

local curIndex=0
local len=0
for i,v in ipairs(self.config)do
local complete_cnt=v.complete_cnt
if curConsume>=complete_cnt and curIndex<i then

curIndex=i
end
len=len+1
end

local grids=self.ScrollerView:getChildScrollViewItemWidgets()
for i=1,len do
self:SetItemData_Refresh(grids[i-1],i)
end









self.ScrollerView:setChildScrollViewSelectItem(curIndex,false,false,true)


local jindu=0

local deno=1

if curIndex==0 then
local cfg=self.config[curIndex+1]
deno=cfg.complete_cnt
jindu=curConsume
elseif curIndex<len then
local curCfg=self.config[curIndex]
local nextCfg=self.config[curIndex+1]
local cur_complete_cnt=curCfg.complete_cnt
local next_complete_cnt=nextCfg.complete_cnt
deno=next_complete_cnt-cur_complete_cnt
jindu=curConsume-cur_complete_cnt
end

self.rewadProgressbg:setActive(curConsume>0)

local left=curIndex==0 and firstitemsize*jindu/deno or itemsize*jindu/deno
if curIndex==0 then
self.rewadProgress:setChildSizeDelta(16,left)
else
self.rewadProgress:setChildSizeDelta(16,firstitemsize+(itemsize*(curIndex-1))+left)
end




self.all_jifen:setText(curConsume)


local buyFlag_Money=zhengzhanshanhaiModel:getZhanLingData_buyFlag_Money()
local buyFlag_Recharge=zhengzhanshanhaiModel:getZhanLingData_buyFlag_Recharge()
local Flag_Money=buyFlag_Money==0
local Flag_Recharge=buyFlag_Recharge==0
self.suo1:setActive(Flag_Money)
self.suo2:setActive(Flag_Recharge)
self.unlcokbg:setActive(Flag_Money or Flag_Recharge)
self.unlcokBtn:setActive(Flag_Money or Flag_Recharge)
self.unlockText:setActive(Flag_Money or Flag_Recharge)
end



function UIXM_ZZSH_ShanHaiZhanLingWin:SetItemData_Init(widget,index)
if widget==nil then
widget=self.ScrollerView:getChildScrollViewItemWidget(index-1)
end
local cfg=self.config[index]
if widget and cfg then
local temp={
{cmpIndex=itemcmp.freeCreat,rewards=cfg.fee_rewards[1]},
{cmpIndex=itemcmp.moneyCreat,rewards=cfg.money_rewards[1]},
{cmpIndex=itemcmp.rmbCreat,rewards=cfg.rmb_rewards[1]}
}
for i,v in ipairs(temp)do
local cmpIndex=v.cmpIndex
local rewards=v.rewards
widget:SetChildLayoutGroupCreateItems(cmpIndex,#rewards,function(groupItemIndex)
local data={}
local reward=rewards[groupItemIndex]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local itemwidget=widget:GetChildLayoutGroupGridItem(cmpIndex,groupItemIndex-1)
widgetHelper.setNormalRewardItem(itemwidget,0,data)
itemwidget:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end)
end
end
end

function UIXM_ZZSH_ShanHaiZhanLingWin:SetItemData_Refresh(widget,index)
if widget==nil then
widget=self.ScrollerView:getChildScrollViewItemWidget(index-1)
end

local cfg=self.config[index]
local curConsume=zhengzhanshanhaiModel:getZhanLingData_completeCnt()

if widget and cfg then
local complete_cnt=cfg.complete_cnt
widget:SetChildActive(itemcmp.activebg,complete_cnt<=curConsume)
local cnt_str=""
if curConsume>=complete_cnt then
cnt_str=string.format("<color=#F7F7F7>%d</color>",complete_cnt)
else
cnt_str=string.format("<color=#F7F7F7>%d</color>",complete_cnt)
end
widget:SetChildText(itemcmp.countTxt,cnt_str)
local temp={
{cmpIndex=itemcmp.freeCreat,rewards=cfg.fee_rewards[1]},
{cmpIndex=itemcmp.moneyCreat,rewards=cfg.money_rewards[1]},
{cmpIndex=itemcmp.rmbCreat,rewards=cfg.rmb_rewards[1]}
}
for i,v in ipairs(temp)do
local cmpIndex=v.cmpIndex
local rewards=v.rewards
for ii,vv in ipairs(rewards)do
local itemwidget=widget:GetChildLayoutGroupGridItem(cmpIndex,ii-1)
local id=cfg.conf_id or cfg.id
local state=self:getRewardState(id,cmpIndex)
local lockFlag=self:getItemLockFlag(id,cmpIndex)
local grayFlag=lockFlag or state==RewardState.eRecved
itemwidget:SetChildActive(item2cmp.gray,grayFlag)
itemwidget:SetChildActive(item2cmp.lock,lockFlag)
itemwidget:SetChildActive(2,state==RewardState.eRecv)
itemwidget:SetChildActive(item2cmp.select,state==RewardState.eRecved)
end
end
end
end




function UIXM_ZZSH_ShanHaiZhanLingWin:onUnlcokBtn()
UIManager:showWindow("UIXM_ZZSH_TouziUnLockWin")


end

function UIXM_ZZSH_ShanHaiZhanLingWin:onJumpBtn()




zhengzhanshanhaiController:finishFightOpen({})
end


function UIXM_ZZSH_ShanHaiZhanLingWin:onTipsBtn()
local descFMT='UISHZL_wanfa_%s'
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=descFMT})


end
function UIXM_ZZSH_ShanHaiZhanLingWin:onPrize()

local pVEState=zhengzhanshanhaiController.checkPVEState()
if not pVEState then
return
end
zhengzhanshanhaiController.req_getZZSHZhanLingReward()
end

function UIXM_ZZSH_ShanHaiZhanLingWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIXM_ZZSH_ShanHaiZhanLingWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXM_ZZSH_ShanHaiZhanLingWin:updateCDTick()
local pVEState,time=zhengzhanshanhaiController.checkPVEState()
if pVEState then
self.lefttime:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end
end

function UIXM_ZZSH_ShanHaiZhanLingWin:getFreeRewardState(id)
local rewardFlag_Free=zhengzhanshanhaiModel:getZhanLingData_rewardFlag_Free()
if mathHelper.getBitValue(rewardFlag_Free,id-1)then
return RewardState.eRecved
end
local curConsume=zhengzhanshanhaiModel:getZhanLingData_completeCnt()
local cfg=self.config[id]
local completeCnt=cfg.complete_cnt
if curConsume>=completeCnt then
return RewardState.eRecv
end
return RewardState.eNotRecv
end

function UIXM_ZZSH_ShanHaiZhanLingWin:getMoneyRewardState(id)
local rewardFlag_Money=zhengzhanshanhaiModel:getZhanLingData_rewardFlag_Money()
if mathHelper.getBitValue(rewardFlag_Money,id-1)then
return RewardState.eRecved
end
local curConsume=zhengzhanshanhaiModel:getZhanLingData_completeCnt()
local cfg=self.config[id]
local completeCnt=cfg.complete_cnt
local buyFlag_Money=zhengzhanshanhaiModel:getZhanLingData_buyFlag_Money()
if curConsume>=completeCnt and buyFlag_Money==1 then
return RewardState.eRecv
end
return RewardState.eNotRecv
end

function UIXM_ZZSH_ShanHaiZhanLingWin:getRechargeRewardState(id)
local rewardFlag_Recharge=zhengzhanshanhaiModel:getZhanLingData_rewardFlag_Recharge()
if mathHelper.getBitValue(rewardFlag_Recharge,id-1)then
return RewardState.eRecved
end
local curConsume=zhengzhanshanhaiModel:getZhanLingData_completeCnt()
local cfg=self.config[id]
local completeCnt=cfg.complete_cnt
local buyFlag_Recharge=zhengzhanshanhaiModel:getZhanLingData_buyFlag_Recharge()
if curConsume>=completeCnt and buyFlag_Recharge==1 then
return RewardState.eRecv
end
return RewardState.eNotRecv
end

function UIXM_ZZSH_ShanHaiZhanLingWin:getRewardState(id,cmpIndex)

if cmpIndex==itemcmp.freeCreat then
return self:getFreeRewardState(id)
elseif cmpIndex==itemcmp.moneyCreat then
return self:getMoneyRewardState(id)
elseif cmpIndex==itemcmp.rmbCreat then
return self:getRechargeRewardState(id)
end
return RewardState.eNotRecv
end


function UIXM_ZZSH_ShanHaiZhanLingWin:getItemLockFlag(id,cmpIndex)
if cmpIndex==itemcmp.freeCreat then
return false
elseif cmpIndex==itemcmp.moneyCreat then
local buyFlag_Money=zhengzhanshanhaiModel:getZhanLingData_buyFlag_Money()
return buyFlag_Money==0
elseif cmpIndex==itemcmp.rmbCreat then
local buyFlag_Recharge=zhengzhanshanhaiModel:getZhanLingData_buyFlag_Recharge()
return buyFlag_Recharge==0
end
return false
end
