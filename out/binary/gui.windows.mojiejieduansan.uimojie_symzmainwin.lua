







def_class("UIMoJie_SYMZMainWin",UIWindowBase)









function UIMoJie_SYMZMainWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.uipanel=UIObject.get(self,2)
self.rewardBtn=UIButton.get(self,3)
self.jumpAnimation=UIToggleButton.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.moneyBg=UIButton.get(self,6)
self.moneyIcon=UIImage.get(self,7)
self.moneyNum=UIText.get(self,8)
self.nextTx=UIText.get(self,9)
self.onceBtn=UIButton.get(self,10)
self.onceBtnTx=UIText.get(self,11)
self.onceNum=UIText.get(self,12)
self.onceIcon=UIImage.get(self,13)
self.onceBtnReddot=UIObject.get(self,14)
self.manyBtn=UIButton.get(self,15)
self.manyBtnTx=UIText.get(self,16)
self.manyNum=UIText.get(self,17)
self.manyIcon=UIImage.get(self,18)
self.manyBtnReddot=UIObject.get(self,19)
self.spineeffect=UIObject.get(self,20)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.onceBtn:setButtonClick(function()self:onOnceBtn()end)

self.manyBtn:setButtonClick(function()self:onManyBtn()end)



end


function UIMoJie_SYMZMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uipanel);self.uipanel=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.jumpAnimation);self.jumpAnimation=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.nextTx);self.nextTx=nil;
_UIObject_release(self.onceBtn);self.onceBtn=nil;
_UIObject_release(self.onceBtnTx);self.onceBtnTx=nil;
_UIObject_release(self.onceNum);self.onceNum=nil;
_UIObject_release(self.onceIcon);self.onceIcon=nil;
_UIObject_release(self.onceBtnReddot);self.onceBtnReddot=nil;
_UIObject_release(self.manyBtn);self.manyBtn=nil;
_UIObject_release(self.manyBtnTx);self.manyBtnTx=nil;
_UIObject_release(self.manyNum);self.manyNum=nil;
_UIObject_release(self.manyIcon);self.manyIcon=nil;
_UIObject_release(self.manyBtnReddot);self.manyBtnReddot=nil;
_UIObject_release(self.spineeffect);self.spineeffect=nil;
end
















local _this



function UIMoJie_SYMZMainWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_change)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)


self.isSkipAnim=false
self.isSkipAnim=userActorSetting.get('UIMoJie_SYMZMainWin_Anim',false)
self.jumpAnimation:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle(self.isSkipAnim)


self.isAnim=false

end


function UIMoJie_SYMZMainWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_change)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
userActorSetting.flushVal('UIMoJie_SYMZMainWin_Anim',self.isSkipAnim)
_this=nil
end

function UIMoJie_SYMZMainWin.on_item_change(changeType,itemguid,itemid,lastcount,itemcount)
if _this.moneyId==itemid then
_this:refreshMoney()
_this:refreshBtnPanel()

end
end
function UIMoJie_SYMZMainWin.on_money_changed(mType,oldValue,newValue)
if _this.moneyId==mType then
_this:refreshMoney()
_this:refreshBtnPanel()

end
end


function UIMoJie_SYMZMainWin:onMoneyBg()
local itemId=self.moneyId
gainControl:showGainWin(itemId)
end

function UIMoJie_SYMZMainWin:onToggleChanged(name,isToggle,data)
if self.isSkipAnim==isToggle then return end
self.isSkipAnim=isToggle
self:freshToggle(isToggle)
end
function UIMoJie_SYMZMainWin:freshToggle(isToggle)
self.jumpAnimation:setToggle(isToggle)
end

function UIMoJie_SYMZMainWin:onRewardBtn()
if self.isAnim then
return
end
local csid=xianjieModel:getMoJieEnterConfig("csid")
local args={



configstr='UIMoJie_SYMZMainWin',
configidx=csid,
proTitle='大奖道具预览',
normalTitle='珍稀道具预览',
}
oneTabScreenController:openUI(SEC_FULL_TYPE.lotterySecondary_noActivity,args)
end

function UIMoJie_SYMZMainWin:onOnceBtn()
if self.isAnim then
return
end
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime


if self.Cost1 then
local num=itemsModel.getCount(self.moneyId)
local cnt=self.Cost1[2]
local choujian=self.Cost1[3]
if num<cnt then
gainControl:showGainWin(self.moneyId)
else
xianjieController:send_35_236(choujian)
AudioManager.playAudio(407)
end
end
end

function UIMoJie_SYMZMainWin:onManyBtn()
if self.isAnim then
return
end
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime


if self.Cost2 then
local num=itemsModel.getCount(self.moneyId)
local cnt=self.Cost2[2]
local choujian=self.Cost2[3]
if num<cnt then
gainControl:showGainWin(self.moneyId)
else
xianjieController:send_35_236(choujian)
AudioManager.playAudio(407)
end
end
end





function UIMoJie_SYMZMainWin:onShow(argtable,afterOnloaded)
self:showWindow("UITopMaskWin")
self.bgModel:setChildUIModelShowTarget(6286,1,{},eAnimationID.stand,false,false,0)
self.uipanel:setChildCanvasGroupAlpha(0)
self.uipanel:setChildCanvasGroupDOFade(1,0.6,nil)
local csid=xianjieModel:getMoJieEnterConfig("csid")
self.cfg=cfg_devildomshenyuanmizangconfig_get(csid)
if not self.cfg then
self.cfg=cfg_devildomshenyuanmizangconfig_get(1)
end
self.cost=self.cfg.cost
self.Cost1=self.cost[1]
self.Cost2=self.cost[2]
self.moneyId=self.Cost1[1]


self:initButton()

self:refreshBtnPanel()

self:refreshNext()
end


function UIMoJie_SYMZMainWin:onHide()

end
function UIMoJie_SYMZMainWin:closeWin()
self:closeSelf()
end
function UIMoJie_SYMZMainWin:onCloseBtn()
self:closeSelf()
end


function UIMoJie_SYMZMainWin:SrverrefreshView(cnt,big_cnt,sbig_cnt)
_this:refreshNext()
_this:refreshBtnPanel()
_this:refreshMoney()

end

function UIMoJie_SYMZMainWin:initButton()

local one=self.Cost1[3]
self.onceBtnTx:setText(FMT.fmt("炼化{0}次",one))
self.onceIcon:setImageIcon(iconHelper.getIconName(self.moneyId),false)
self.onceNum:setText(self.Cost1[2])

if self.Cost2 then
self.manyBtn:setActive(true)
local many=self.Cost2[3]
self.manyBtnTx:setText(FMT.fmt("炼化{0}次",many))
self.manyIcon:setImageIcon(iconHelper.getIconName(self.moneyId),false)
self.manyNum:setText(self.Cost2[2])
else
self.manyBtn:setActive(false)
end

self.moneyIcon:setImageIcon(iconHelper.getIconName(self.moneyId),false)
self:refreshMoney()
end

function UIMoJie_SYMZMainWin:refreshMoney()
local num=itemsModel.getCount(self.moneyId)
self.moneyNum:setText(num)
end

function UIMoJie_SYMZMainWin:refreshBtnPanel()
local num=itemsModel.getCount(self.moneyId)

if self.Cost1 then
local one=self.Cost1[2]
local onceNumStr=tostring(one)
if num<one then
onceNumStr=FMT.cfmt(FONT_COLOR.eRedColor,onceNumStr)
self.onceBtnReddot:setActive(false)
else
self.onceBtnReddot:setActive(true)
end
self.onceNum:setText(onceNumStr)
end


if self.Cost2 then
local many=self.Cost2[2]
local manyNumStr=tostring(many)
if num<many then
manyNumStr=FMT.cfmt(FONT_COLOR.eRedColor,manyNumStr)
self.manyBtnReddot:setActive(false)
else
self.manyBtnReddot:setActive(true)
end
self.manyNum:setText(manyNumStr)
end
end

function UIMoJie_SYMZMainWin:refreshNext()
local bigcnt=xianjieController:get_MjJieDuanSan_bigcnt()
local maxTimes=self.cfg.big_reward_cnt
self.nextTx:setText(maxTimes-bigcnt)
end


function UIMoJie_SYMZMainWin:isBigReward(cnt,big_cnt,sbig_cnt)
local big_reward_cnt=xianjieController:get_MjJieDuanSan_bigcnt()
local sbig_reward_cnt=xianjieController:get_MjJieDuanSan_Sbigcnt()
if(big_reward_cnt+cnt)<big_cnt then
return true
end
if(sbig_reward_cnt+cnt)<sbig_cnt then
return true
end
end

function UIMoJie_SYMZMainWin.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eShengYuanMiZang then

if _this==nil then return end
local csid=xianjieModel:getMoJieEnterConfig("csid")
local cfg=cfg_devildomshenyuanmizangconfig_get(csid)
if cfg then
cfg=cfg_devildomshenyuanmizangconfig_get(1)
end
local reset_big_cnt_list=cfg.reset_big_cnt_list or{}
local sreset_big_cnt_list=cfg.sreset_big_cnt_list or{}
local isbig=false
for i,v in ipairs(prizelist)do
if reset_big_cnt_list[v.itemid]and reset_big_cnt_list[v.itemid]==v.num then
isbig=true
break
end
if sreset_big_cnt_list[v.itemid]and sreset_big_cnt_list[v.itemid]==v.num then
isbig=true
break
end
end
_this:doAnimation(isbig,prizelist)
end
end

function UIMoJie_SYMZMainWin:doAnimation(_isbig,prizelist)
self.isAnim=true
if self.isSkipAnim then

local list=prizelist or{}
local conf={}
for i,v in ipairs(list)do
table.insert(conf,{itemid=v.itemid,num=v.num})
end
showPrizeControl.showWindow(conf)
self.isAnim=false
else
if _isbig then

self.winlua:SetChildShowEffect(self.spineeffect:getID(),22664,true)
else

self.spineeffect:setChildShowEffect(22665,true)
end

self:delayDo(3.6,function()
if _this==nil then return end
local list=prizelist or{}
local conf={}
for i,v in ipairs(list)do
table.insert(conf,{itemid=v.itemid,num=v.num})
end
showPrizeControl.showWindow(conf)
self.spineeffect:setChildShowEffect(-1,false)
self.isAnim=false
end)
end
end
