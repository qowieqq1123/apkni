







def_class("UIShangHangMuBiaoWin",UIWindowBase)









function UIShangHangMuBiaoWin:bindComponents()

self.scrollView=UIObject.get(self,0)
self.spReward=UIObject.get(self,1)
self.timeText=UIText.get(self,2)
self.level=UILinkImageText.get(self,3)
self.expPB=UIObject.get(self,4)
self.rwImage=UIObject.get(self,5)
self.rwTitle=UIObject.get(self,6)
self.activeBtn=UIButton.get(self,7)
self.lockButton=UIButton.get(self,8)
self.buyText=UIText.get(self,9)

self.activeBtn:setButtonClick(function()self:onActiveBtn()end)

self.lockButton:setButtonClick(function()self:onLockButton()end)


self.sprite_image_xianshuui_15=0
self.sprite_image_xianshuui_14=1

end


function UIShangHangMuBiaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.spReward);self.spReward=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.expPB);self.expPB=nil;
_UIObject_release(self.rwImage);self.rwImage=nil;
_UIObject_release(self.rwTitle);self.rwTitle=nil;
_UIObject_release(self.activeBtn);self.activeBtn=nil;
_UIObject_release(self.lockButton);self.lockButton=nil;
_UIObject_release(self.buyText);self.buyText=nil;
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


function UIShangHangMuBiaoWin:onLoaded(...)
self:bindComponents()
end


function UIShangHangMuBiaoWin:__delete()
self:unbindComponents()
end




function UIShangHangMuBiaoWin:onShow(argtable,afterOnloaded)



self:refresh()

end


function UIShangHangMuBiaoWin:onHide()

end

function UIShangHangMuBiaoWin:onShowArgRecv(argtable)

end

function UIShangHangMuBiaoWin:refresh()
local investId=shangHangModel:getInvestId()or 1
self.inCome=shangHangModel:getTotalInCome()

local investCfg=cfgHelper.get(cfg_shanghangtargetconfig_get,investId)
local rewards=investCfg.rewards

self.level:setText(FMT.fmt('累计玉券：{0}',mathHelper.formatNumber(self.inCome)))


self.datas=rewards

local rId=UIXianShuControl:getRechargeId()
self.rechargeState=rId>0 and 1 or 0

self:setRewardList()





self:setRemainingTimeTimer()

local isBuy=shangHangModel:isInvestBuy()
self.lockButton:setActive(not isBuy)
if not isBuy then
local recharge_id=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"recharge_id")
local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,recharge_id)
local str=pfwindowslController:showDesc_ByMoneyType(rechargeCfg)
if rechargeCfg then
self.buyText:setText(FMT.fmt("{0}解锁",str))
end
end
end

function UIShangHangMuBiaoWin:setRewardList()
local len=#self.datas
self.scrollView:setChildScrollViewDelayCreateGrids(len,0,0.02,5,false,false,function(index,item)
local level=index+1
self:setRewardItem(level,item)







end)
self:setSpeItem()

end

function UIShangHangMuBiaoWin:setRewardItem(index,item,isOnSpecialReward)
local data=self.datas[index]

local need=data[1]
local reward=data[2]

local enough=self.inCome>=need

local gotNor=shangHangModel:isInvestRewardGot(index)

local gotEx=shangHangModel:isInvestRewardExGot(index)

local isBuy=shangHangModel:isInvestBuy()



item:SetChildActive(_rw_index.mask,not isBuy)
item:SetChildText(_rw_index.level,FMT.fmt('{0}',mathHelper.formatNumber(need,true)))
local rw=reward[1][1]
widgetHelper.setNormalRewardItem(item,_rw_index.item1,rw)
rw=reward[1][2]
if rw then
item:SetChildActive(_rw_index.item2,true)
widgetHelper.setNormalRewardItem(item,_rw_index.item2,rw)
else
item:SetChildActive(_rw_index.item2,false)
end
rw=reward[2][1]
if rw then
item:SetChildActive(_rw_index.item3,true)
widgetHelper.setNormalRewardItem(item,_rw_index.item3,rw)
else
item:SetChildActive(_rw_index.item3,false)
end
item:SetChildActive(_rw_index.lock,not isBuy)

local canReceive=enough and((not gotNor)or(isBuy and(not gotEx)))

item:SetChildActive(_rw_index.rclick,canReceive)
if canReceive then
item:SetChildButtonClick(_rw_index.rclick,function()
self:onReqReward()
end)
end

item:SetChildActive(_rw_index.rIcon1,gotNor)
item:SetChildActive(_rw_index.rIcon2,gotEx)




local effectId="xianshu_light"

local select1=enough and not gotNor
local select2=enough and not gotEx and isBuy
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

function UIShangHangMuBiaoWin:setSpeItem()
local speItem=self.spReward:getChildWidgetBase()
local length=#self.datas
local nextIdx=length
local curIdx=0
for i,v in ipairs(self.datas)do
local need=v[1]
if self.inCome<need then
if v[3]==1 then
nextIdx=i
end
break
end
curIdx=i
end
self:setRewardItem(nextIdx,speItem)

self.expPB:setChildUIProgressbar(curIdx,length)
end

function UIShangHangMuBiaoWin:onReqReward()
socketManager:send_248_98(0)
end

function UIShangHangMuBiaoWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local lerp=shangHangModel:getRemainingTime()
if lerp>0 then

self.timeText:setText(FMT.fmt("剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("活动已结束")

end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UIShangHangMuBiaoWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UIShangHangMuBiaoWin:onActiveBtn()

end

function UIShangHangMuBiaoWin:onLockButton()
self:showWindow("UIShangHang_limitInvestorBuyWin")
end
