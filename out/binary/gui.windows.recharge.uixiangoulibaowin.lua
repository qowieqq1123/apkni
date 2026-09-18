







def_class("UIXianGouLiBaoWin",UIWindowBase)









function UIXianGouLiBaoWin:bindComponents()

self.packScrollerView=UIObject.get(self,0)
self.weekSelect=UIObject.get(self,1)
self.weekReddot=UIObject.get(self,2)
self.daySelect=UIObject.get(self,3)
self.dayReddot=UIObject.get(self,4)
self.Content=UIObject.get(self,5)
self.monthSelect=UIObject.get(self,6)
self.monthReddot=UIObject.get(self,7)
self.sloganImg1=UIImage.get(self,8)
self.sloganImg2=UIImage.get(self,9)
self.sloganImg3=UIImage.get(self,10)
self.npcPanel=UIObject.get(self,11)
self.npcModel=UIObject.get(self,12)
self.speakObj=UIObject.get(self,13)
self.speakText=UIText.get(self,14)



end


function UIXianGouLiBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.weekSelect);self.weekSelect=nil;
_UIObject_release(self.weekReddot);self.weekReddot=nil;
_UIObject_release(self.daySelect);self.daySelect=nil;
_UIObject_release(self.dayReddot);self.dayReddot=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.monthSelect);self.monthSelect=nil;
_UIObject_release(self.monthReddot);self.monthReddot=nil;
_UIObject_release(self.sloganImg1);self.sloganImg1=nil;
_UIObject_release(self.sloganImg2);self.sloganImg2=nil;
_UIObject_release(self.sloganImg3);self.sloganImg3=nil;
_UIObject_release(self.npcPanel);self.npcPanel=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
end

















local menuType={
dayPack=1,
weekPack=2,
monthPack=3,
}

local itemIndex={
name=0,
flag=1,
buyBtn=2,
costIcon=3,
root=4,
sellOut=5,
costCount=6,
freeRedot=7,
freeText=8,
rewardItem1=9,
rewardItem2=10,
rewardItem3=11,
icon=12,
limitBg=13,
zhigou=14,
bg=15,
guanggao=16,
buLimit=17,
}
local this


function UIXianGouLiBaoWin:onLoaded(...)
this=self
self:bindComponents()

local _onClickPackItem=function(...)
self:onClickPackItem(...)
end
self.packScrollerView:setChildScrollViewInit(-1,true,_onClickPackItem,nil)





end


function UIXianGouLiBaoWin:__delete()
self:unbindComponents()
self:clearSpeakTimer()
self.curMenuIndex=nil
end




function UIXianGouLiBaoWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
self.curMenuIndex=argtable.libaoType or shopLibaoType.eDay


self:refreshScrollerView(afterOnloaded)
if self.curMenuIndex==shopLibaoType.eGuangGao and rechargeModel:checkXianGouLiBaoIsDay(shopLibaoType.eGuangGao)then

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eGuanYingGe,true)

reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end
end


function UIXianGouLiBaoWin:onHide()
self.packScrollerView:setActive(false)
self:clearSpeakTimer()
end

function UIXianGouLiBaoWin:onShowArgRecv(argtable)
argtable=argtable or{}
self.curMenuIndex=argtable.libaoType or shopLibaoType.eDay
self.packScrollerView:setChildScrollViewCreateGrids(0,0)

if self.curMenuIndex==shopLibaoType.eGuangGao and rechargeModel:checkXianGouLiBaoIsDay(shopLibaoType.eGuangGao)then

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eGuanYingGe,true)


reddotControl.on_change_catch_type(CATCH_TYPE.eXianGouLiBao)
end
self:refreshScrollerView()

end


function UIXianGouLiBaoWin:refreshScrollerView(afterOnloaded)
self:refreshNPCPanel(afterOnloaded)
self.packScrollerView:setActive(true)
self.curGiftConfig=rechargeModel:getSortXianGouLiBaoList(self.curMenuIndex)

self.packScrollerView:setChildScrollViewCreateGrids(#self.curGiftConfig,3)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local config=self.curGiftConfig[i]


local maxcount=config.maxcount
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(config.id)
if maxcount then
item:SetChildActive(itemIndex.limitBg,true)
local resettype=config.resettype
local str=''
if resettype then
if resettype==1 then
str='每日'
elseif resettype==2 then
str='每周'
elseif resettype==3 then
str='每月'
end
end
item:SetChildText(itemIndex.buLimit,FMT.fmt('{2}限购：{0}/{1}',maxcount-buyNum,maxcount,str))
else
item:SetChildActive(itemIndex.limitBg,false)
end
local flag=config.flag
if flag then
item:SetChildActive(itemIndex.limitBg,true)
local str=flag==1 and"<size=26>必买</size>"or FMT.fmt("<size=26>{0}倍</size>\n<size=22>收益</size>",flag)
item:SetChildText(itemIndex.flag,str)
else
item:SetChildActive(itemIndex.limitBg,false)
end
local isSellOut=buyNum>=config.maxcount
if config.icon then
local showIconName=iconHelper.getChongZhiIcon(config.icon)
item:SetChildIcon(itemIndex.icon,showIconName,true)
item:SetChildImageExGray(itemIndex.icon,isSellOut)
end


local price=config.price
local isFree=false
if price then
local moneyCount=price[2]
isFree=moneyCount==0
end

item:SetChildActive(itemIndex.guanggao,config.adid~=nil)

if not isFree then
if config.rechargeid~=nil then
local rechargecfg=cfg_rechargeconfig_get(config.rechargeid)
local rmb=rechargecfg.rmb
if rmb then
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
item:SetChildText(itemIndex.zhigou,str)
item:SetChildActive(itemIndex.zhigou,true)
end
elseif config.adid~=nil then

item:SetChildActive(itemIndex.zhigou,false)
else



local moneyType=price[1]

local iconname=iconHelper.getIconName(moneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)
item:SetChildText(itemIndex.zhigou,FMT.fmt('{0} {1}',iconStr,price[2]))
item:SetChildActive(itemIndex.zhigou,true)
end
else

item:SetChildActive(itemIndex.zhigou,false)
end



item:SetChildActive(itemIndex.sellOut,isSellOut)
item:SetChildActive(itemIndex.bg,not isSellOut)
item:SetChildActive(itemIndex.buyBtn,not isSellOut)




if isSellOut then
item:SetChildActive(itemIndex.limitBg,false)
end


local rewards=rechargeModel:getXianGouLiBaoRewards(config.rewards)
for i=0,2 do
item:SetChildActive(itemIndex.rewardItem1+i,i<#rewards)
if i<#rewards then
local reward=rewards[i+1]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count,showCountBG=count~=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetGray,0)]=isSellOut
prop[PropIndex(DataPropKey.eWidgetGray,1)]=isSellOut
item:SetChildPropData(itemIndex.rewardItem1+i,prop)
local func=function(...)
if isSellOut then
UIManager.error('此礼包售罄')
return
else
self:onClickRewardItem(...)
end
end
item:SetBaseItemClickEvent(itemIndex.rewardItem1+i,func)
end
end


item:SetChildActive(itemIndex.freeRedot,not isSellOut and isFree)
item:SetChildActive(itemIndex.freeText,isFree or config.adid~=nil)
item:SetChildActive(itemIndex.costCount,not isFree)
item:SetChildActive(itemIndex.costIcon,not isFree)

local _onClickPackItem=function(...)
self:onClickPackItem(1,i-1)
end
item:SetChildButtonClick(itemIndex.buyBtn,_onClickPackItem)
end
end

end
















function UIXianGouLiBaoWin:OnEvent(index)

if self.curMenuIndex==index then return end
self.curMenuIndex=index

self:refreshScrollerView()
end

function UIXianGouLiBaoWin:onClickPackItem(clickCount,index)

local config=self.curGiftConfig[index+1]
local isFree=config.price~=nil and config.price[2]==0
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(config.id)
local isSellOut=buyNum>=config.maxcount
if isSellOut then
UIManager.error('此礼包售罄')
return
end

if isFree then
rechargeController:reqXianGouLiBaoBuy(config.id,1)
else
if config.gifttype==shopLibaoType.eGuangGao then
UIManager:showWindow('UIXianGouGuangGaoDialogWin',config)
else

local rechargeid=config.rechargeid
local price=config.price
if not price and rechargeid then

local rechargeAmount=payControl:getRechargeAmount(rechargeid)
local twoTimeCostNum=rechargeAmount*2
local titemid,voucherCount=payControl.getVoucherId(twoTimeCostNum)
local buyFunc=function(count,isItem)
if isItem then
local pram=jsonHelper.encode({rechargeid})
bagProtocolControl.req_1_21(titemid,count*rechargeAmount,pram)
else
payControl.reqPay(rechargeid,count)
end
end
local buyFuncNoVoucher=function()
payControl.reqPayNoVoucher(rechargeid,1)
end
if config.maxcount-buyNum>1 and voucherCount>=twoTimeCostNum then
local rewards=rechargeModel:getXianGouLiBaoRewards(config.rewards)
local args={
rewards=rewards,
name=config.name,
price={titemid,rechargeAmount},
leftNum=buyNum,
maxcount=config.maxcount,
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num,true)
end,
ReqPaycallback=buyFuncNoVoucher
}
UIManager:showWindow("UICommonBuyDialogWin",args)
else

UIManager:showWindow('UIXianGouBuyDialogWin',config)
end
else

UIManager:showWindow('UIXianGouBuyDialogWin',config)
end

end
end
end

function UIXianGouLiBaoWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 or itemId==0 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UIXianGouLiBaoWin:testclick(index)
this.iso=index
end



function UIXianGouLiBaoWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end

function UIXianGouLiBaoWin:clearTalkTween()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
end


function UIXianGouLiBaoWin:onNPCClick()
if shopLibaoType.eGuangGao==self.curMenuIndex then

local curGiftConfig=rechargeModel:getSortXianGouLiBaoList(self.curMenuIndex)
local itemid=cfg_advertconfig().const_def.itemid

local num=itemsModel.getCount(itemid)
local canlist={}
local list={}
for i=1,#curGiftConfig do
local config=curGiftConfig[i]
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(config.id)
local isSellOut=buyNum>=config.maxcount
if not isSellOut then
local id=config.adid
local ext=adController:getParam(config.id)
list[#list+1]={id,ext}
end
end
if#list>0 and num>0 then
for i=1,num do
canlist[#canlist+1]=list[i]
end
end

if#canlist>0 then
rechargeModel:setGuanYinGeOneKeyBuy(true)
rechargeController:reqGuanYinGeOnekeyBuy(#canlist,canlist)
end
end
end



function UIXianGouLiBaoWin:refreshNPCPanel(isInit)
self.npcPanel:setActive(false)
if shopLibaoType.eGuangGao==self.curMenuIndex then

local curGiftConfig=rechargeModel:getSortXianGouLiBaoList(self.curMenuIndex)
local itemid=cfg_advertconfig().const_def.itemid

local num=itemsModel.getCount(itemid)
local isopen=false
for i=1,#curGiftConfig do
local config=curGiftConfig[i]
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(config.id)
local isSellOut=buyNum>=config.maxcount
if not isSellOut and num>0 then
isopen=true
break
end
end

self.npcPanel:setActive(isopen)
if not isopen then
self.npcModel:setChildUIModelRemoveTarget()
self.isShowNpcModel=nil
return
end

if not self.isShowNpcModel then
local fadeTime=isInit and 0 or 0.5
local modelId=4099
self.npcModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.stand,false,false,fadeTime)
self.isShowNpcModel=true
end
self.speakContent=cfg_advertconfig().const_def.npcTalk
self.npcTalkTime=2
self.npcTalkShowTime=3

self:doSpeaking()
end
end

function UIXianGouLiBaoWin:doSpeaking()
self:clearSpeakTimer()
local speakList=self.speakContent

local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()
end

function UIXianGouLiBaoWin:doTalkAnim()
self:clearTalkTween()
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if this==nil then return end
this.talkTween=nil
this.talkTween=this.speakObj:setChildDOScale(1,0.1,function()
if this==nil then return end
this.talkTween=nil
return this:talkEnd()
end)
end)
end)
end

function UIXianGouLiBaoWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end
