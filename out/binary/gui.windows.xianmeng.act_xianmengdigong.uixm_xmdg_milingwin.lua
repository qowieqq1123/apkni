







def_class("UIXM_XMDG_MiLingWin",UIWindowBase)









function UIXM_XMDG_MiLingWin:bindComponents()

self.all_jifen=UIText.get(self,0)
self.buyProgressBtn=UIButton.get(self,1)
self.buyProgressBtnReddot=UIObject.get(self,2)
self.Content=UIObject.get(self,3)
self.jumpBtn=UIButton.get(self,4)
self.lefttime=UIText.get(self,5)
self.modelBg=UIObject.get(self,6)
self.ratio1=UIText.get(self,7)
self.ratio2=UIText.get(self,8)
self.rewadProgress=UIObject.get(self,9)
self.rewadProgressbg=UIObject.get(self,10)
self.rewardProgressBar=UIObject.get(self,11)
self.root=UIObject.get(self,12)
self.ScrollerView=UIObject.get(self,13)
self.suo1=UIObject.get(self,14)
self.suo2=UIObject.get(self,15)
self.TipsBtn=UIButton.get(self,16)
self.titleImgae=UIImage.get(self,17)
self.unlcokBtn=UIButton.get(self,18)

self.buyProgressBtn:setButtonClick(function()self:onBuyProgressBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.TipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)
self.all={
["jifen"]=self.all_jifen,
}



end


function UIXM_XMDG_MiLingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.all_jifen);self.all_jifen=nil;
_UIObject_release(self.buyProgressBtn);self.buyProgressBtn=nil;
_UIObject_release(self.buyProgressBtnReddot);self.buyProgressBtnReddot=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.ratio1);self.ratio1=nil;
_UIObject_release(self.ratio2);self.ratio2=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewadProgressbg);self.rewadProgressbg=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollerView);self.ScrollerView=nil;
_UIObject_release(self.suo1);self.suo1=nil;
_UIObject_release(self.suo2);self.suo2=nil;
_UIObject_release(self.TipsBtn);self.TipsBtn=nil;
_UIObject_release(self.titleImgae);self.titleImgae=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
self.all=nil;
end



















local itemSize=89
local itemSpace=5
local firstitemsize=84
local RewardState={
eRecved=1,
eNotRecv=2,
eRecv=3,
}


function UIXM_XMDG_MiLingWin:onLoaded(...)
self:bindComponents()
self.modelBg:setChildUIModelShowTarget(6305,1,{},0)
end


function UIXM_XMDG_MiLingWin:__delete()
self:stopCDTick()
self:unbindComponents()
end




function UIXM_XMDG_MiLingWin:onShow(argtable,afterOnloaded)
self.config=xianmengdigongModel:getPassInvestList()
self.baseCfg=cfgHelper.get1(cfg_xmdgtongxingzhengbaseconfig_get,1)
self.titleImgae:setSprite("ui/windows/xianmeng/act_xianmengdigong/xmdg_miling_atlas_pak.ab",self.baseCfg.titleImg)
local ratio1,ratio2=unpack(self.baseCfg.ratio)
self.ratio1:setText(string.format("%d倍返利",ratio1))
self.ratio2:setText(string.format("%d倍返利",ratio2))
self.ScrollerView:setActive(true)
self:initdata()
self:refresh()
end


function UIXM_XMDG_MiLingWin:onHide()
self.ScrollerView:setActive(false)
end

function UIXM_XMDG_MiLingWin:onShowArgRecv()
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
local function getIdxLength(idx)
return itemSize/2+(itemSize+itemSpace)*(idx-1)
end


function UIXM_XMDG_MiLingWin:initdata()

self:startCDTick()


local len=#self.config
self.ScrollerView:setChildScrollViewCreateGrids(len,1)
local grids=self.ScrollerView:getChildScrollViewItemWidgets()
for i=1,len do
self:SetItemData_Init(grids[i-1],i)
end





self.rewardProgressBar:setChildSizeDelta(16,getIdxLength(len))
end

function UIXM_XMDG_MiLingWin:refresh()

local curConsume=xianmengdigongModel:getPassXDL()

local curIndex=0
local len=0
for i,v in ipairs(self.config)do
local complete_cnt=v.id
if curConsume>=complete_cnt then

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
deno=cfg.id
jindu=curConsume
elseif curIndex<len then
local curCfg=self.config[curIndex]
local nextCfg=self.config[curIndex+1]
local cur_complete_cnt=curCfg.id
local next_complete_cnt=nextCfg.id
deno=next_complete_cnt-cur_complete_cnt
jindu=curConsume-cur_complete_cnt
end

self.rewadProgressbg:setActive(curConsume>0)

local curStageProgress=jindu/deno
local left=curIndex==0 and(itemSize/2)*curStageProgress or(itemSize+itemSpace)*curStageProgress
self.rewadProgress:setChildSizeDelta(6,curIndex==0 and left or left+getIdxLength(curIndex))



self.all_jifen:setText(curConsume)


local buyFlag_Money=xianmengdigongModel:getPassInvestFlag(XMDG_Pass_Invest_Type.eMoney)
local buyFlag_Recharge=xianmengdigongModel:getPassInvestFlag(XMDG_Pass_Invest_Type.eRecharge)
local Flag_Money=not buyFlag_Money
local Flag_Recharge=not buyFlag_Recharge
self.suo1:setActive(Flag_Money)
self.suo2:setActive(Flag_Recharge)
self.unlcokBtn:setActive(Flag_Money or Flag_Recharge)

local showBuyProgress=xianmengdigongModel:checkPassBuyProgressVisiable()
self.buyProgressBtn:setActive(showBuyProgress)
if showBuyProgress then
local reddot=xianmengdigongModel:checkPassBuyProgressReddot()
self.buyProgressBtnReddot:setActive(reddot)
end
end



function UIXM_XMDG_MiLingWin:SetItemData_Init(widget,index)
if widget==nil then
widget=self.ScrollerView:getChildScrollViewItemWidget(index-1)
end
local cfg=self.config[index]
if widget and cfg then
local temp={
{cmpIndex=itemcmp.freeCreat,rewards=cfg.freeItems},
{cmpIndex=itemcmp.moneyCreat,rewards=cfg.lyItems},
{cmpIndex=itemcmp.rmbCreat,rewards=cfg.czItems}
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

function UIXM_XMDG_MiLingWin:SetItemData_Refresh(widget,index)
if widget==nil then
widget=self.ScrollerView:getChildScrollViewItemWidget(index-1)
end

local cfg=self.config[index]
local curConsume=xianmengdigongModel:getPassXDL()

if widget and cfg then
local complete_cnt=cfg.id
widget:SetChildActive(itemcmp.activebg,complete_cnt<=curConsume)
local cnt_str=complete_cnt
widget:SetChildText(itemcmp.countTxt,cnt_str)
local temp={
{cmpIndex=itemcmp.freeCreat,rewards=cfg.freeItems},
{cmpIndex=itemcmp.moneyCreat,rewards=cfg.lyItems},
{cmpIndex=itemcmp.rmbCreat,rewards=cfg.czItems}
}
for i,v in ipairs(temp)do
local cmpIndex=v.cmpIndex
local rewards=v.rewards
for ii,vv in ipairs(rewards)do
local itemwidget=widget:GetChildLayoutGroupGridItem(cmpIndex,ii-1)
local state=self:getRewardState(complete_cnt,cmpIndex)
local lockFlag=self:getItemLockFlag(complete_cnt,cmpIndex)
local grayFlag=lockFlag or state==RewardState.eRecved
itemwidget:SetChildActive(item2cmp.gray,grayFlag)
itemwidget:SetChildActive(item2cmp.lock,lockFlag)
itemwidget:SetChildActive(2,state==RewardState.eRecv)
itemwidget:SetChildActive(item2cmp.select,state==RewardState.eRecved)
end
end
end
end

function UIXM_XMDG_MiLingWin:onUnlcokBtn()
UIManager:showWindow("UIXM_XMDG_TouziUnLockWin")
end

function UIXM_XMDG_MiLingWin:onJumpBtn()
xianmengdigongController:finishFightOpen()
end


function UIXM_XMDG_MiLingWin:onTipsBtn()
local descFMT='XMDGTXZ_wanfa_%s'
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=descFMT})
end

function UIXM_XMDG_MiLingWin:onPrize()
xianmengdigongController:reqPassRewards()
end

function UIXM_XMDG_MiLingWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIXM_XMDG_MiLingWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXM_XMDG_MiLingWin:updateCDTick()
local time=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eXianMengDiGong)
self.lefttime:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end

function UIXM_XMDG_MiLingWin:getRewardState(id,cmpIndex)
local type=XMDG_Pass_Invest_Type.eFree
if cmpIndex==itemcmp.freeCreat then
type=XMDG_Pass_Invest_Type.eFree
elseif cmpIndex==itemcmp.moneyCreat then
type=XMDG_Pass_Invest_Type.eMoney
elseif cmpIndex==itemcmp.rmbCreat then
type=XMDG_Pass_Invest_Type.eRecharge
end
local passClaimedXDL=xianmengdigongModel:getPassClaimedXDL(type)
if passClaimedXDL>=id then
return RewardState.eRecved
end
local curConsume=xianmengdigongModel:getPassXDL()
if curConsume>=id and xianmengdigongModel:getPassInvestFlag(type)then
return RewardState.eRecv
end
return RewardState.eNotRecv
end


function UIXM_XMDG_MiLingWin:getItemLockFlag(id,cmpIndex)
if cmpIndex==itemcmp.freeCreat then
return false
elseif cmpIndex==itemcmp.moneyCreat then
return not xianmengdigongModel:getPassInvestFlag(XMDG_Pass_Invest_Type.eMoney)
elseif cmpIndex==itemcmp.rmbCreat then
return not xianmengdigongModel:getPassInvestFlag(XMDG_Pass_Invest_Type.eRecharge)
end
return false
end

function UIXM_XMDG_MiLingWin:onBuyProgressBtn()
if not dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXMDGPassBuyProgress)then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXMDGPassBuyProgress,true)
xianmengdigongController.refreshXMDGPassReddot()
end
self.buyProgressBtnReddot:setActive(false)
self:showWindow("UIXM_XMDG_MiLingBuyProgressWin")
end