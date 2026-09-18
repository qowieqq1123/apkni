







def_class("UIYunYouMerchantWin",UIWindowBase)









function UIYunYouMerchantWin:bindComponents()

self.background=UIButton.get(self,0)
self.topHurt=UIText.get(self,1)
self.fightNum=UIText.get(self,2)
self.fightBtnTx=UIText.get(self,3)
self.talkRoot=UIObject.get(self,4)
self.helpBtn=UIButton.get(self,5)
self.progressBar=UIProgress.get(self,6)
self.discountNum=UIText.get(self,7)
self.buyedFlag=UIObject.get(self,8)
self.tipsTx=UIText.get(self,9)
self.closeBtn=UIButton.get(self,10)
self.buyBtn=UIButton.get(self,11)
self.model=UIObject.get(self,12)
self.chafferBtn=UIButton.get(self,13)
self.leaveBtn=UIButton.get(self,14)
self.fightNumRoot=UIObject.get(self,15)
self.fightBtn=UIButton.get(self,16)
self.item_6=UIBaseItem.get(self,17)
self.item_1=UIBaseItem.get(self,18)
self.item_2=UIBaseItem.get(self,19)
self.item_3=UIBaseItem.get(self,20)
self.item_4=UIBaseItem.get(self,21)
self.item_5=UIBaseItem.get(self,22)
self.talkTx=UIText.get(self,23)
self.costIcon=UIImage.get(self,24)
self.costNum=UIText.get(self,25)
self.modelIcon=UIObject.get(self,26)

self.background:setButtonClick(function()self:onBackground()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.chafferBtn:setButtonClick(function()self:onChafferBtn()end)

self.leaveBtn:setButtonClick(function()self:onLeaveBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
self.item_5,
self.item_6,
}



end


function UIYunYouMerchantWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.topHurt);self.topHurt=nil;
_UIObject_release(self.fightNum);self.fightNum=nil;
_UIObject_release(self.fightBtnTx);self.fightBtnTx=nil;
_UIObject_release(self.talkRoot);self.talkRoot=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.discountNum);self.discountNum=nil;
_UIObject_release(self.buyedFlag);self.buyedFlag=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.chafferBtn);self.chafferBtn=nil;
_UIObject_release(self.leaveBtn);self.leaveBtn=nil;
_UIObject_release(self.fightNumRoot);self.fightNumRoot=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.item_6);self.item_6=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.item_4);self.item_4=nil;
_UIObject_release(self.item_5);self.item_5=nil;
_UIObject_release(self.talkTx);self.talkTx=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.modelIcon);self.modelIcon=nil;
self.item=nil;
end















local _this=nil
local _tooSmall=20
local _itemPos={
[1]={{-10,-25}},
[2]={{-60,-25},{45,-25}},
[3]={{-106,-25},{-12,-25},{85,-25}},
[4]={{-55,35},{40,35},{40,-55},{-55,-55}},
[5]={{-106,46},{-6,35},{85,65},{-55,-55},{45,-55}},
[6]={{-106,46},{-6,35},{85,65},{-85,-55},{14,-55},{106,-46}},
}



function UIYunYouMerchantWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIYunYouMerchantWin:__delete()
self:unbindComponents()
_this=nil

if self.talkTween and self.talkTween:IsActive()then
self.talkTween:Kill()
end
end




function UIYunYouMerchantWin:onShow(argtable,afterOnloaded)
self:initView()
self:refreshView()
self:checkSpeak()
end


function UIYunYouMerchantWin:onHide()

end




function UIYunYouMerchantWin:onCloseBtn()
local data=yunyouMerchantModel:getData()
if data.buyFlag then
local config=cfgHelper.get1(cfg_business2config_get,1)
local speaks=config.speak4
local lib=nil
for i,v in ipairs(speaks)do
if data.refreshTimes<=v[1]then
lib=v[2]
break
end
end
if lib==nil then
lib=speaks[#speaks][2]
end
if lib then
local str=lib[math.random(1,#lib)]
local args={
showblack=false,
blackAlpha=1,
isFullOpen=true,
talk=str,
name="老道",
model={
body=config.image[1],
componets=config.image[2],
anim=eAnimationID.stand,
scale=1,
},
}
UIFullStoryBoardControl:showPlotBoardWindow6(args,true)
end
end
UIFullYunYouMerchantControl:closeUI(true,true)
end

function UIYunYouMerchantWin:onLeaveBtn()
UIDialogManager.getCommonDialog(nil,"送客后道长将离开宗门，本次礼包无法购买，是否送客？",function()
yunyouMerchantController:send_33_4()
end)
end

function UIYunYouMerchantWin:onBackground()
self:onCloseBtn()
end


function UIYunYouMerchantWin:onChafferBtn()
self.chafferBtn:setActive(false)
self.fightBtnTx:setText("比试一下")
self:checkSpeak(function(sequence)
sequence:AppendCallback(function()
self.fightBtn:setActive(true)
self.fightNumRoot:setActive(true)
self.fightBtn:setChildCanvasGroupAlpha(0)
self.fightNumRoot:setChildCanvasGroupAlpha(0)
end)
local tween1=self.fightBtn:setChildCanvasGroupDOFade(1,0.2)
local tween2=self.fightNumRoot:setChildCanvasGroupDOFade(1,0.2)
sequence:Append(tween1)
sequence:Join(tween2)
end)
end


function UIYunYouMerchantWin:onFightBtn()
if not yunyouMerchantModel:checkFightTime()then
UIManager.info("道长需要休息一下，请稍后再来")
return
end
local data=yunyouMerchantModel:getData()
local config=cfgHelper.get1(cfg_business2config_get,1)

local level=data.monLevel or 0
local groupByLv=cfgHelper.get2(cfg_business2config_get,1,"mon_id")

local monsterGroup=nil
if groupByLv and type(groupByLv)=="table"then
for _,v in ipairs(groupByLv)do
local minLv,maxLv,groupId=v[1],v[2],v[3]
if type(minLv)=="number"and type(maxLv)=="number"and type(groupId)=="number"then
if level>=minLv and level<=maxLv then
monsterGroup=groupId
break
end
end
end
end

if not monsterGroup then
if data.refreshTimes>config.times then
monsterGroup=config.mon_id
else
local t=config.mon_conf and config.mon_conf[data.refreshTimes]
if t and type(t)=="table"then
monsterGroup=t[1]
end
end
end

local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroup)
local args={
dontCloseStage=false,
enterTxt="云游商人",
groupId=monsterGroup,
monsterList=monsterCfg.monList,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
enterCallBack=function(selectList,zfId)
fightLaunchController:sendFight(eBattleLaunch.yunyouMerchant,selectList,monsterCfg.mapId or 0,zfId)
yunyouMerchantModel:recordFightTime()
end,
cancelCallBack=function()
UIFullYunYouMerchantControl:showMainWindow()
end,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.yunyouMerchant,args,function()
local info={
message=cfgHelper.get2(cfg_business2config_get,1,"fightMessage"),
}
UIFullFightPrepareControl:showWindow("UIFightPrepareMessageWin",info)
end)
end


function UIYunYouMerchantWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='yunyoulaodao_rule_%d'})
end


function UIYunYouMerchantWin:onBuyBtn()
moneySystem:useMoney(self.costItem,self.costPrice,function()
local data=yunyouMerchantModel:getData()
local buyCallback=function()
yunyouMerchantController:send_33_2()
end
if data.damagePercent<_tooSmall*100 then
UIDialogManager.getCommonDialog(nil,'当前折扣力度过小，建议和道长切磋一下获得更好的折扣，是否直接购买？',buyCallback)
else
UIDialogManager.getCommonDialog(nil,FMT.fmt('是否消耗{0}{1}购买货物？',self.costPrice,itemsConfig.getColorName(self.costItem)),buyCallback)
end
end,WARNING_TYPE.eWarning)
end

function UIYunYouMerchantWin:speakWord(str,callback)
if self.talkTween and self.talkTween:IsActive()then
self.talkTween:Kill(true)
end
self.talkTx:setText("")
self.talkRoot:setChildCanvasGroupAlpha(0)
self.talkRoot:setScale(Vector3.zero)
self.talkTween=Lua.SequenceProxy.New()
local talkTxCmp=self.talkTx:getGameObject():GetComponent("Text")
local tween0=Lua.DOTweenProxyExtensions.DOText(talkTxCmp,'',0)
tween0:SetEase(DG.Tweening.Ease.Linear)
local tween1=self.talkRoot:setChildCanvasGroupDOFade(1,0.1)
local tween2=self.talkRoot:setChildDOScale(1.2,0.2)
local tween3=self.talkRoot:setChildDOScale(1,0.1)
local tween4=Lua.DOTweenProxyExtensions.DOText(talkTxCmp,str,1)
local temp=Lua.SequenceProxy.New()
temp:Append(tween2)
temp:Append(tween3)
self.talkTween:Append(tween0)
self.talkTween:Append(temp)
self.talkTween:Join(tween1)
self.talkTween:Join(tween4)
if callback then
callback(self.talkTween)
end
end

function UIYunYouMerchantWin:initView()
local discountPercent=cfgHelper.get2(cfg_business2config_get,1,"discount")
local tipsStr=FMT.fmt("道长每损失{0}%生命\n礼包折扣增加{1}%",discountPercent[1]/100,discountPercent[2])
self.tipsTx:setText(tipsStr)

local imageCfg=cfgHelper.get2(cfg_business2config_get,1,"image")
local scale=imageCfg[3]
local body=imageCfg[1]
local components=imageCfg[2]
self.model:setChildUIModelShowTarget(body,scale,components,eAnimationID.stand)
comHelper.setChildModelRawImageEx(self.modelIcon:getID(),self.winlua,{body=body,componets=components},eHeadCenterType.eHead,nil,false)
end

function UIYunYouMerchantWin:refreshView()
local data=yunyouMerchantModel:getData()
local config=cfgHelper.get1(cfg_business2config_get,1)

local giftCfg=nil
local priceCfg=nil
if data.zmLevel>0 and data.giftIdx>0 then
local giftLib=cfgHelper.get2(cfg_business2randconfig_get,data.zmLevel,"rand_gift")
giftCfg=giftLib[data.giftIdx]
priceCfg=giftCfg[3]
else
local giftLib=config.fix_gifts
giftCfg=giftLib[data.refreshTimes]or giftLib[#giftLib]
priceCfg=giftCfg[2]
end

local rewards=giftCfg[1]
local _pos=_itemPos[#rewards]
for i,v in ipairs(self.item)do
local data=rewards[i]
v:setActive(data~=nil)
if data then
local pos=_pos[i]
local showCountBG=data[2]>1
local countStr=showCountBG and data[2]or""
local conf={itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.winlua:SetChildPropData(v:getID(),prop)
self.winlua:SetBaseItemClickEvent(v:getID(),itemsComponentHelper.onItemClickEx)
v:setChildAnchoredPosition(Vector2.New(pos[1],pos[2]))
end
end

self.costItem=priceCfg[1]
self.costIcon:setImageIcon(iconHelper.getIconName(self.costItem),false)

local oPrice=priceCfg[2]
local buyed=data.buyFlag
local damagePercent=data.damagePercent

local fighted=damagePercent>=0
self.chafferBtn:setActive(not fighted and not buyed)
self.fightBtn:setActive(fighted and not buyed)
self.tipsTx:setActive(not fighted)
self.progressBar:setActive(fighted)
self.buyBtn:setActive(not buyed)
if not buyed then
self.winlua:SetChildImageExGray(self.buyBtn:getID(),data.damagePercent<_tooSmall*100)
end
self.buyedFlag:setActive(buyed)
self.leaveBtn:setActive(not buyed)
self.fightNumRoot:setActive(fighted and not buyed)
local attributes=config.attributes[data.monLevel]or config.attributes[0]
if attributes==nil then
loggerUtil.logErrFMT("云游商人没有对应等级属性或默认等级配置：{0}",data.monLevel)
return
end
local fightNumStr=mathHelper.formatNumber(attributes[2])
self.fightNum:setText(fightNumStr)
if fighted then


self.progressBar:setProgressValue(10000-damagePercent,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}%",(10000-damagePercent)/100))

local discountPercent=cfgHelper.get2(cfg_business2config_get,1,"discount")
local discount=math.ceil(100-damagePercent/discountPercent[1]*discountPercent[2])
discount=math.max(discount,config.low_discount)
self.discountNum:setText(FMT.fmt("{0}%",discount))
self.costPrice=math.floor(oPrice*discount/100)
self.costNum:setText(FMT.fmt("标价：{0}",self.costPrice))
self.fightBtnTx:setText("再来！")
else
self.discountNum:setText(FMT.fmt("{0}%",100))
self.costPrice=oPrice
self.costNum:setText(FMT.fmt("标价：{0}",self.costPrice))
self.fightBtnTx:setText("比试一下")
end
end

function UIYunYouMerchantWin:checkSpeak(callback)
local data=yunyouMerchantModel:getData()
local config=cfgHelper.get1(cfg_business2config_get,1)
local check=not self.winlua:GetChildActiveSelf(self.chafferBtn:getID())

local buyed=data.buyFlag
local damagePercent=data.damagePercent
local lib=nil

if buyed then
local percentIdx=0
for percent,lib in pairs(config.speak2)do
if damagePercent>=percent then
percentIdx=math.max(percentIdx,percent)
end
end
lib=config.speak2[percentIdx]

elseif damagePercent>=0 then
local percentIdx=0
for percent,lib in pairs(config.speak1)do
if damagePercent>=percent then
percentIdx=math.max(percentIdx,percent)
end
end
lib=config.speak1[percentIdx]

elseif check then
lib=config.speak0[2]

else
lib=config.speak0[1]
end
local str=lib[math.random(1,#lib)]
self:speakWord(str,callback)
end

function UIYunYouMerchantWin:afterBuy()
self.buyBtn:setActive(false)
self.buyedFlag:setActive(true)
self.fightBtn:setActive(false)
self.chafferBtn:setActive(false)
self.fightNumRoot:setActive(false)
self.leaveBtn:setActive(false)
self:checkSpeak()
end

function UIYunYouMerchantWin:afterLeave()
self.buyBtn:setActive(false)
self.buyedFlag:setActive(false)
self.fightBtn:setActive(false)
self.chafferBtn:setActive(false)
self.fightNumRoot:setActive(false)
self.leaveBtn:setActive(false)

local lib=cfgHelper.get2(cfg_business2config_get,1,"speak3")
local str=lib[math.random(1,#lib)]
self:speakWord(str,nil)
end