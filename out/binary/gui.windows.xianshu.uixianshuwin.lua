







def_class("UIXianShuWin",UIWindowBase)









function UIXianShuWin:bindComponents()

self.exp=UIText.get(self,0)
self.expPB=UIObject.get(self,1)
self.scrollView=UIObject.get(self,2)
self.buyLevelBtn=UIButton.get(self,3)
self.spReward=UIObject.get(self,4)
self.tipsPanel=UIObject.get(self,5)
self.level=UIText.get(self,6)
self.rwImage=UIObject.get(self,7)
self.rwTitle=UIObject.get(self,8)
self.activeBtn=UIButton.get(self,9)
self.timeText=UIText.get(self,10)
self.oneKeyGetRewardBtn=UIButton.get(self,11)

self.buyLevelBtn:setButtonClick(function()self:onBuyLevelBtn()end)

self.activeBtn:setButtonClick(function()self:onActiveBtn()end)

self.oneKeyGetRewardBtn:setButtonClick(function()self:onOneKeyGetRewardBtn()end)


self.sprite_image_xianshuui_15=0
self.sprite_image_xianshuui_14=1

end


function UIXianShuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.exp);self.exp=nil;
_UIObject_release(self.expPB);self.expPB=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.buyLevelBtn);self.buyLevelBtn=nil;
_UIObject_release(self.spReward);self.spReward=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.rwImage);self.rwImage=nil;
_UIObject_release(self.rwTitle);self.rwTitle=nil;
_UIObject_release(self.activeBtn);self.activeBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.oneKeyGetRewardBtn);self.oneKeyGetRewardBtn=nil;
end
















local _rw_index={
level=0,
item1=1,
item2=2,
item3=3,
lock=4,
rclick=5,
rIcon1=6,
rIcon2=7,
levelbg1=8,
levelbg2=9,
select1=10,
select2=11,
select3=12,
mask=13,
effect1=14,
effect2=15,
effect3=16,
spPanel=17,
tips=18,
spItem=19,
expCount=20,
norPanel=21,
effect4=22,
tipsBtn=23,
}

local _this




function UIXianShuWin:onLoaded(...)
_this=self
self:bindComponents()

self.tipsPanel:setActive(false)

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.winlua:SetChildScrollViewInitScrollEvent(self.scrollView:getID(),240,60,function(index)
local slevel=self:getNextSPRewardLevel(index+2)
if self.showSPLevel~=slevel then
self.showSPLevel=slevel
local clevel=self:getNextSPRewardLevel()
local maxLevel=#self.datas
local isFinish=clevel>=maxLevel
if not isFinish then
self:setSpecialReward(slevel)
end
end
end)
end


function UIXianShuWin:__delete()
self.oneKeyBtnIsShow=nil
self.scrollView:setChildScrollViewStopGridCreate()
self:clearTimer()
self:unbindComponents()
_this=nil
end




function UIXianShuWin:onShow(argtable,afterOnloaded)
self.isSpecialRewardEffectInit_1=false
self.isSpecialRewardEffectInit_2=false
self:refresh()
end

function UIXianShuWin:onShowArgRecv(argtable)
self.isHide=false

self:refresh()
end

function UIXianShuWin:refresh()
self.currLevel=UIXianShuControl:getLevel()
self.norRLevel=UIXianShuControl:getReceiveLevel(1)
self.speRLevel=UIXianShuControl:getReceiveLevel(2)

local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local maxLevel=cfg.max_lv

self.level:setText(FMT.fmt('{0}级',self.currLevel))

local needExp=cfgHelper.get2(cfg_fairybookbaseconfig_get,1,'lv_exp')
self.needExp=needExp
if self.currLevel<maxLevel then
local exp=UIXianShuControl:getExp()
self.exp:setText(FMT.fmt('{0}/{1}',exp,needExp))
self.expPB:setChildUIProgressbar(exp,needExp,false)
else
self.exp:setText('已满级')
self.expPB:setChildUIProgressbar(1,1,false)
end

self.datas=cfgHelper.get1(cfg_fairybooklevelconfig_get,UIXianShuControl:getCurrentId())

local rId=UIXianShuControl:getRechargeId()
self.rechargeState=rId>0 and 1 or 0

self:setRewardList()
self:setSpecialReward()
self:setShowReward()
self:setActiveBtnShow()
self:setBuyLevelBtnShow()
self:setOneKeyGetRewardBtnShow()


self:setRemainingTimeTimer()
end

function UIXianShuWin:setShowReward()
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local modelData=cfg.rw_image[1][1]
local model=modelData[1]
local scale=isometricMapSystem:getModelScale(model,true)
scale=scale*modelData[2]
self.rwImage:setChildUIModelShowTarget(model,scale,nil,eAnimationID.stand)
self.rwImage:setLocalPos(modelData[3],modelData[4],0)
self.rwTitle:setImageSprite(modelData[5],true)
end

function UIXianShuWin:setActiveBtnShow()
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local rechargeCfg=cfg.recharge_rw
local rId=UIXianShuControl:getRechargeId()
local isActiveComplete=rId==rechargeCfg[2][1]or rId==rechargeCfg[3][1]
self.activeBtn:setActive(not isActiveComplete)
end

function UIXianShuWin:setBuyLevelBtnShow()
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local maxLevel=cfg.max_lv
local level=UIXianShuControl:getLevel()
local canShow=level<maxLevel
if canShow and cfg.buy_need_day then
local ltime=UIXianShuControl:getRemainingTime()
canShow=ltime<cfg.buy_need_day*86400
end
self.buyLevelBtn:setActive(canShow)
end

function UIXianShuWin:setOneKeyGetRewardBtnShow()
if self.isHide then
return
end

local isShow=self.norRLevel<self.currLevel
if self.oneKeyBtnIsShow~=isShow then
self.oneKeyGetRewardBtn:setActive(isShow)
local originalPos=self.oneKeyGetRewardBtn:getChildAnchoredPosition()
local duration=0.5
if isShow then

self.oneKeyGetRewardBtn:setChildAnchoredPos(originalPos.x,-100)
self.oneKeyGetRewardBtn:setChildDOAnchorPosY(61,duration)
end
self.oneKeyBtnIsShow=isShow
end
end

function UIXianShuWin:onRewardImageClick()
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local rw=cfg.rw_image[1][2]
tipsManager.showTips({formType=TIPS_FORM_TYPE.eNoBtns,itemid=rw,showModel=true})
end


function UIXianShuWin:onHide()
self.isHide=true
self.oneKeyBtnIsShow=nil
end

function UIXianShuWin:setRewardList()
local len=#self.datas
self.scrollView:setChildScrollViewDelayCreateGrids(len,0,0.02,5,false,false,function(index,item)
local level=index+1
self:setRewardItem(level,item)
if level==self.currLevel then
local jumpIndex=self.norRLevel and self.norRLevel-1 or 0
if jumpIndex<0 then
jumpIndex=0
end
self.scrollView:setChildScrollViewSelectItem(jumpIndex,false,false,false)
end
end)
end

function UIXianShuWin:setRewardItem(index,item,isOnSpecialReward)
local data=self.datas[index]
local canReceive=data.level_id<=self.currLevel


item:SetChildActive(_rw_index.mask,self.rechargeState==0)
item:SetChildText(_rw_index.level,FMT.fmt('{0}级',data.level_id))
local rw=data.general_rewards[1]
widgetHelper.setNormalRewardItem(item,_rw_index.item1,rw)
rw=data.luxury_rewards[1]
widgetHelper.setNormalRewardItem(item,_rw_index.item2,rw)
rw=data.luxury_rewards[2]
if rw then
item:SetChildActive(_rw_index.item3,true)
widgetHelper.setNormalRewardItem(item,_rw_index.item3,rw)
else
item:SetChildActive(_rw_index.item3,false)
end
item:SetChildActive(_rw_index.lock,self.rechargeState==0)
item:SetChildActive(_rw_index.rclick,canReceive)
if canReceive then
item:SetChildButtonClick(_rw_index.rclick,function()
self:onReqReward()
end)
end
local cr1=index<=self.norRLevel
local cr2=index<=self.speRLevel
item:SetChildActive(_rw_index.rIcon1,cr1)
item:SetChildActive(_rw_index.rIcon2,cr2)

item:SetChildActive(_rw_index.levelbg1,index>self.currLevel)
item:SetChildActive(_rw_index.levelbg2,index<=self.currLevel)


local rId=UIXianShuControl:getRechargeId()
local checkR=rId>0








local effectId="xianshu_light"













local select1=canReceive and not cr1
local select2=canReceive and not cr2 and checkR
item:SetChildActive(_rw_index.effect1,select1)
item:SetChildActive(_rw_index.effect2,select2)
item:SetChildActive(_rw_index.effect3,select2)
if not isOnSpecialReward or not self.isSpecialRewardEffectInit_1 or not self.isSpecialRewardEffectInit_2 then
if select1 then
item:SetChildAnimationStringID(_rw_index.effect1,effectId,false)
if isOnSpecialReward and not self.isSpecialRewardEffectInit_1 then
self.isSpecialRewardEffectInit_1=true;
end
end
if select2 then
item:SetChildAnimationStringID(_rw_index.effect2,effectId,false)
item:SetChildAnimationStringID(_rw_index.effect3,effectId,false)
if isOnSpecialReward and not self.isSpecialRewardEffectInit_2 then
self.isSpecialRewardEffectInit_2=true;
end
end
end
end

function UIXianShuWin:onReqReward()
if self.norRLevel<self.currLevel then
UIXianShuControl:reqReward(1)
return
end
if self.rechargeState~=0 and self.speRLevel<self.currLevel then
UIXianShuControl:reqReward(1)
return
end
end

function UIXianShuWin:getNextSPRewardLevel(level)
if not level then
level=math.min(self.norRLevel,self.speRLevel)
if level<1 then
level=1
end
end
for i=level,#self.datas do
local cfg=self.datas[i]
if cfg.is_sp_reward then
return i
end
end
return#self.datas
end

function UIXianShuWin:setSpecialReward(index)
local item=self.spReward:getChildWidgetBase()
local slevel=self:getNextSPRewardLevel()
local maxLevel=#self.datas

local level=UIXianShuControl:getLevel()
local isFinish=level>=maxLevel

self:setRewardItem(index or slevel,item,true)

item:SetChildActive(_rw_index.spPanel,isFinish)
item:SetChildActive(_rw_index.norPanel,not isFinish)
item:SetChildActive(_rw_index.tipsBtn,isFinish)
if isFinish then
item:SetChildText(_rw_index.level,'满级')
local exp=UIXianShuControl:getExp()

item:SetChildText(_rw_index.expCount,FMT.fmt('{0}/{1}',exp,self.needExp))
local canReceive=exp>=self.needExp
item:SetChildActive(_rw_index.rclick,canReceive)
item:SetChildActive(_rw_index.effect4,canReceive)
if canReceive then
if not self.isPlayEffect4 then
self.isPlayEffect4=true
item:SetChildAnimationStringID(_rw_index.effect4,'xianshu_light',false)
end
item:SetChildButtonClick(_rw_index.rclick,function()

if level>=maxLevel then
UIXianShuControl:reqReward(2)
else













if self.rechargeState~=0 then

UIXianShuControl:reqReward(1)
return
end
end
end)
end
local spReward=cfgHelper.get2(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId(),'gifts')
local rwId=spReward[1]
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems
widgetHelper.setNormalRewardItem(item,_rw_index.spItem,rewards[1])
item:SetChildButtonClick(_rw_index.tipsBtn,function()
self.tipsPanel:setActive(true)
end,true)
end
end

function UIXianShuWin:showDialog(content,callback,ok,cancel)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext=ok or'确定',
canceltext=cancel or'取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end


function UIXianShuWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local lerp=UIXianShuControl:getRemainingTime()
if lerp>0 then

self.timeText:setText(FMT.fmt("剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("活动已结束")
UIManager.error("本期仙书已结束")
UIXianShuControl:closeAllXianShuWindow()

end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UIXianShuWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end



function UIXianShuWin:onActiveBtn()
UIManager:showWindow('UIXianShuActiveWin')
end

function UIXianShuWin:onBuyLevelBtn()
UIManager:showWindow('UIXianShuBuyLevelWin')
end

function UIXianShuWin:onTipsPanel()
self.tipsPanel:setActive(false)
end

function UIXianShuWin:onOneKeyGetRewardBtn()

UIXianShuControl:reqReward(1)
end