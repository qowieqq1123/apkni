







def_class("UIPushGiftAdvertThreeWin",UIWindowBase)








function UIPushGiftAdvertThreeWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.bg=UIImage.get(self,2)
self.modelEffect=UIObject.get(self,3)
self.model=UIObject.get(self,4)
self.descImage=UIImage.get(self,5)
self.tabRoot=UIObject.get(self,6)
self.arrowRoot=UIObject.get(self,7)
self.btnClose=UIButton.get(self,8)
self.numberRoot=UIObject.get(self,9)
self.leftTime=UIText.get(self,10)
self.btnBuy=UIButton.get(self,11)
self.buyTitle=UIText.get(self,12)
self.txtYuan=UIText.get(self,13)
self.item_1=UIObject.get(self,14)
self.item_2=UIObject.get(self,15)
self.item_3=UIObject.get(self,16)
self.item_4=UIObject.get(self,17)
self.item_5=UIObject.get(self,18)
self.numberBg=UIImage.get(self,19)
self.numberImage=UIImage.get(self,20)
self.btnTab_1=UIButton.get(self,21)
self.btnTab_2=UIButton.get(self,22)
self.btnTab_3=UIButton.get(self,23)
self.btnRightArrow=UIButton.get(self,24)
self.btnLeftArrow=UIButton.get(self,25)
self.timeRoot=UIObject.get(self,26)
self.bottomBg=UIImage.get(self,27)
self.effectRoot=UIObject.get(self,28)
self.effectTxt=UIText.get(self,29)
self.btnTab_4=UIButton.get(self,30)
self.dltipsRoot=UIObject.get(self,31)
self.dltxt=UIText.get(self,32)
self.zkbg=UIObject.get(self,33)
self.zktxt=UIText.get(self,34)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnBuy:setButtonClick(function()self:onBtnBuy()end)

self.btnTab_1:setButtonClick(function()self:onBtnTab_1()end)

self.btnTab_2:setButtonClick(function()self:onBtnTab_2()end)

self.btnTab_3:setButtonClick(function()self:onBtnTab_3()end)

self.btnRightArrow:setButtonClick(function()self:onBtnRightArrow()end)

self.btnLeftArrow:setButtonClick(function()self:onBtnLeftArrow()end)

self.btnTab_4:setButtonClick(function()self:onBtnTab_4()end)
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
self.item_5,
}
self.btnTab={
self.btnTab_1,
self.btnTab_2,
self.btnTab_3,
self.btnTab_4,
}



end


function UIPushGiftAdvertThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.modelEffect);self.modelEffect=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.descImage);self.descImage=nil;
_UIObject_release(self.tabRoot);self.tabRoot=nil;
_UIObject_release(self.arrowRoot);self.arrowRoot=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.numberRoot);self.numberRoot=nil;
_UIObject_release(self.leftTime);self.leftTime=nil;
_UIObject_release(self.btnBuy);self.btnBuy=nil;
_UIObject_release(self.buyTitle);self.buyTitle=nil;
_UIObject_release(self.txtYuan);self.txtYuan=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.item_4);self.item_4=nil;
_UIObject_release(self.item_5);self.item_5=nil;
_UIObject_release(self.numberBg);self.numberBg=nil;
_UIObject_release(self.numberImage);self.numberImage=nil;
_UIObject_release(self.btnTab_1);self.btnTab_1=nil;
_UIObject_release(self.btnTab_2);self.btnTab_2=nil;
_UIObject_release(self.btnTab_3);self.btnTab_3=nil;
_UIObject_release(self.btnRightArrow);self.btnRightArrow=nil;
_UIObject_release(self.btnLeftArrow);self.btnLeftArrow=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.bottomBg);self.bottomBg=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.effectTxt);self.effectTxt=nil;
_UIObject_release(self.btnTab_4);self.btnTab_4=nil;
_UIObject_release(self.dltipsRoot);self.dltipsRoot=nil;
_UIObject_release(self.dltxt);self.dltxt=nil;
_UIObject_release(self.zkbg);self.zkbg=nil;
_UIObject_release(self.zktxt);self.zktxt=nil;
self.item=nil;
self.btnTab=nil;
end

















local _quality=
{
[eQualityColor.eGreen]='image_tuisongpj_1',
[eQualityColor.eBlue]='image_tuisongpj_2',
[eQualityColor.ePurple]='image_tuisongpj_3',
[eQualityColor.eOrange]='image_tuisongpj_4',
[eQualityColor.eRed]='image_tuisongpj_5',
}

function UIPushGiftAdvertThreeWin:onLoaded(...)
self:bindComponents()
self.arrowTweener={}

self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
self.modelArgs={}
self.btntimer={}
self.optionSelectLookup={}
self.optionDefaultLookup={}
end

function UIPushGiftAdvertThreeWin:__delete()
self:unbindComponents()
pushGiftThreeController.onCloseAdvert()
end

function UIPushGiftAdvertThreeWin:onShow(argtable,afterOnloaded)


local ids=pushGiftThreeController:getAdvertParams()
local len=#ids
self.ids=ids
if len<=0 then
self:onBtnClose()
return
end
local selectIdx=len
self.giftId=nil
self:onSelectDefaultGiftByIdx(selectIdx)
end

function UIPushGiftAdvertThreeWin:onHide()

end

function UIPushGiftAdvertThreeWin:onSelectDefaultGiftByIdx(selectIdx)
local id=self.ids[selectIdx]
if self.giftId==id then return end
self.giftId=id
self.idx=nil
self.selectIdx=selectIdx
local idx=pushGiftThreeModel:getNextHasLeftBuyTimesGift(id)
self:onSelectPage(idx)
end

function UIPushGiftAdvertThreeWin:onSelectGift(id,idx)
if self.giftId==id and self.idx==idx then return end
self.giftId=id
local selectIdx=nil
for i,v in ipairs(self.ids)do
if v==id then
selectIdx=i
break
end
end
self.selectIdx=selectIdx
self:onSelectPage(1)
end

function UIPushGiftAdvertThreeWin:onSelectPage(idx)
if self.idx==idx then return end
self.idx=idx
pushGiftThreeModel:flushPushAdvert(self.giftId)
self:freshInfo()
end

function UIPushGiftAdvertThreeWin:freshInfo()
self:freshTabBtns()
self:setArrowStatus()
self:freshGiftInfo()
end

function UIPushGiftAdvertThreeWin:freshTabBtns()
local id=self.giftId
local idx=self.idx
local cfg=pushGiftThreeConfig.getConfig(id)
local consume=cfg.consume
local recharge=cfg.recharge
local len=#cfg.times

for i,v in pairs(self.btntimer)do
self:stopTimerByID(v)
end
self.btntimer={}

for i,v in ipairs(self.btnTab)do
local isSelect=i==idx
local has=len>=i
self.btnTab[i]:setActive(has)
if has then
self:freshTabInfo(i)
end
end
end

function UIPushGiftAdvertThreeWin:freshTabInfo(index)
local id=self.giftId
local idx=self.idx
local widget=self.btnTab[index]:getChildWidgetBase()
local cfg=pushGiftThreeConfig.getConfig(id)
local isSelect=idx==index
local isNew=pushGiftThreeModel:isNewGift(id)
local isForver=pushGiftThreeConfig.isForver(id)
widget:SetChildActive(1,not isSelect)
widget:SetChildActive(2,isSelect)
widget:SetChildText(3,cfg.name)
widget:SetChildLocalPosY(3,isForver and 0 or 13)
widget:SetChildActive(4,isNew)
widget:SetChildActive(5,not isForver and not isSelect)
widget:SetChildActive(6,not isForver and isSelect)

if self.btntimer[id]then
self:stopTimerByID(self.btntimer[id])
self.btntimer[id]=nil
end
local data=pushGiftThreeModel:getAllData(id)
if not isForver then
local starttime=data.starttime
local fixTime=pushGiftThreeConfig.getOpenTime(id)
local curStamp=timeHelper.getServerShortTime()
local endStamp=starttime+fixTime
local left=endStamp-curStamp

if left>0 then
local tick=function()
local curStamp=timeHelper.getServerShortTime()
local left1=endStamp-curStamp
if left1>=0 then
widget:SetChildText(7,timeHelper.format_time_stamp3(left1))
else
widget:SetChildText(7,'')
end
end
self.btntimer[id]=self:setTimer(1,0,tick)
tick()
else
widget:SetChildText(7,'')
end
else
widget:SetChildText(7,'')
end
end

function UIPushGiftAdvertThreeWin:freshGiftInfo()
local id=self.giftId
local idx=self.idx
local cfg=pushGiftThreeConfig.getConfig(id)
self.cfg=cfg


local rewardsCfg=cfg.reward
local optionRewardsCfg=cfg.rewards
local rewards=rewardsCfg and rewardsCfg[idx]or{}
local optionRewards=optionRewardsCfg and optionRewardsCfg[idx]or{}
local len=#cfg.times


local consume=(cfg.consume or{})[idx]
local rechargeid=(cfg.recharge or{})[idx]
local args=(cfg.args or{})[idx]or{}
args=args[1]or{}
local isForver=pushGiftThreeConfig.isForver(id)

local data=pushGiftThreeModel:getAllData(id)
local maxTimes=pushGiftThreeConfig.getBuyTimesByCfg(id,idx)
local leftTimes=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)

local title=FMT.fmt('活动限购{0}次({1}/{0})',maxTimes,leftTimes)
local buytxt=''
local hasLeftTimes=leftTimes>0

if consume then
local moneyCfg=consume[1]
local moneyType=moneyCfg[1]
local moneyValue=moneyCfg[2]
local moneyName=moneyModel.getMoneyName(moneyType)
buytxt=FMT.fmt('{0}{1}',moneyValue,moneyName)
else
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
buytxt=str
end

if not hasLeftTimes then
buytxt='已售罄'
end

local nameArgs=args.name
local shouyiArgs=args.shouyi
local modelArgs=args.model
local effectArgs=args.effect
local itemArgs=args.item
local bgArgs=args.bg or''
local bottombgArgs=args.bg1 or''
local effectdesc=args.effectdesc

local dlname=args.dlname or{}
local dltips=args.dltips
if dltips then
self.dltipsRoot:setActive(true)
self.dltxt:setActive(dltips)
else
self.dltipsRoot:setActive(false)
end

local bgbundle=FMT.fmt('ui/windows/pushgifttwo/sharedtextures/{0}.ab',
string.lower(bgArgs))
local bottombgbundle=FMT.fmt('ui/windows/pushgifttwo/sharedtextures/{0}.ab',
string.lower(bottombgArgs))
self.bg:setSprite(bgbundle,bgArgs)
self.bottomBg:setSprite(bottombgbundle,bottombgArgs)
self.buyTitle:setText(title)
self.txtYuan:setText(buytxt)
self.btnBuy:setChildImageExGray(not hasLeftTimes)


local zktxt=cfg.zktxt
if zktxt and zktxt[idx]then
self.zkbg:setActive(true)
self.zktxt:setText(zktxt[idx])
else
self.zkbg:setActive(false)
end


for i=1,5 do
local itemSlot=self.item[i]
local widget1=itemSlot:getWidgetBase()
local isOption=optionRewards[i]~=nil
local itemInfo=rewards[i]
if isOption then
itemInfo=nil
local len=#pushGiftThreeConfig:getOptionCfg(id,idx,i)
if len>1 then
local selectIdx=pushGiftThreeModel:getSelectGiftItemIdx(id,idx,i)or nil

if selectIdx and pushGiftThreeModel:isOptionItemUnlock(id,idx,i,selectIdx)then
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,selectIdx)[1]
if self.optionSelectLookup[id]==nil then self.optionSelectLookup[id]={}end
if self.optionSelectLookup[id][idx]==nil then self.optionSelectLookup[id][idx]={}end
self.optionSelectLookup[id][idx][i]=selectIdx
end
else
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,1)[1]
isOption=false
if self.optionDefaultLookup[id]==nil then self.optionDefaultLookup[id]={}end
if self.optionDefaultLookup[id][idx]==nil then self.optionDefaultLookup[id][idx]={}end
self.optionDefaultLookup[id][idx][i]=1
end
end
local has=rewards[i]~=nil or optionRewards and optionRewards[i]~=nil
itemSlot:setActive(has)
if has then
if itemInfo then
local hasName=itemArgs and itemArgs.name and itemArgs.name[i]==1
local itemid=itemInfo[1]
local num=itemInfo[2]
local numStr=mathHelper.formatNumber(num)
local iconname=iconHelper.getIconName(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
widget1:SetChildActive(0,true)
widget1:SetChildIcon(1,iconname,false)
widget1:SetChildText(2,FMT.fmt('x{0}',numStr))
widget1:SetChildActive(3,hasName)
widget1:SetChildText(4,hasName and itemsModel.getName(itemid)or'')
if dlname[i]then
widget1:SetChildActive(3,true)
widget1:SetChildText(4,dlname[i])
end
widget1:SetChildCSImageSprite(0,globalABLookup.pushGiftTwo,_quality[itemCfg.color])
widget1:SetChildButtonClick(0,function()
tipsManager.showTips({itemid=itemid})
end,true)
widget1:SetChildActive(5,itemsConfig.isFabao(itemid))
widget1:SetChildActive(6,false)
widget1:SetChildActive(7,isOption)
if isOption then
widget1:SetChildButtonClick(7,function()
self:showOptionSelect(id,idx,i)
end,true)
end
local itemConfig=itemsConfig.getConfig(itemid)
local suitConfig
if itemConfig.bagType==16 then
suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,itemConfig.color)
end
local isZQ=suitConfig~=nil
widget1:SetChildActive(9,isZQ)
widget1:SetChildActive(10,isZQ)
if isZQ then
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
widget1:SetChildIcon(10,suitIconName,false)
local star=itemConfig.stage
widget1:SetChildGroundStarNum(9,star)
widget1:SetChildStarNumber(9,star)
end
else
widget1:SetChildActive(0,false)
widget1:SetChildIcon(1,'',false)
widget1:SetChildText(2,'')
widget1:SetChildActive(3,false)
widget1:SetChildText(4,'')
widget1:SetChildActive(5,false)
widget1:SetChildActive(6,true)
widget1:SetChildActive(7,false)
widget1:SetChildButtonClick(7,function()
self:showOptionSelect(id,idx,i)
end,true)
widget1:SetChildButtonClick(8,function()
self:showOptionSelect(id,idx,i)
end,true)
widget1:SetChildActive(9,false)
widget1:SetChildActive(10,false)
end
else
widget1:SetChildActive(0,false)
widget1:SetChildIcon(1,'',false)
widget1:SetChildText(2,'')
widget1:SetChildActive(3,false)
widget1:SetChildText(4,'')
widget1:SetChildActive(5,false)
widget1:SetChildActive(6,false)
widget1:SetChildActive(7,false)
widget1:SetChildActive(9,false)
widget1:SetChildActive(10,false)
end
end

if nameArgs then
local lowname=string.lower(nameArgs[1])
local bundle=FMT.fmt('ui/windows/pushgifttwo/sharedtextures/{0}.ab',lowname)
self.descImage:setActive(true)
self.descImage:setSprite(bundle,nameArgs[1])
self.winlua:SetChildLocalPos(self.descImage:getID(),nameArgs[2],nameArgs[3],0)
else
self.descImage:setActive(false)
end

if modelArgs then
local modelId=modelArgs[1]
local scale=modelArgs[2]or 1
local offsetX=modelArgs[3]or 0
local offsetY=modelArgs[4]or 0
local ani=modelArgs[5]or 0

local oldmodelArgs=self.modelArgs
if modelId~=oldmodelArgs[1]or scale~=oldmodelArgs[2]or
ani~=oldmodelArgs[3]then
oldmodelArgs[1]=modelId
oldmodelArgs[2]=scale
oldmodelArgs[3]=ani
self.model:setChildUIModelShowTarget(modelId,scale,{},ani)
end
if offsetX~=0 or offsetY~=0 then
self.model:setChildUIModelShowTargetOffset(offsetX,offsetY)
end
else
self.modelArgs={}
self.model:setChildUIModelRemoveTarget()
end

if effectArgs then
local effectId=effectArgs[1]
local scale=effectArgs[2]or 1
local xPos=effectArgs[3]or 0
local yPos=effectArgs[4]or 0
self.modelEffect:setChildShowEffect(effectId,true)
self.modelEffect:setLocalPos(xPos,yPos,0)
self.modelEffect:setScale(Vector3.New(scale,scale,scale))
else
self.modelEffect:setChildShowEffect(0,false)
end

self.effectRoot:setActive(effectdesc~=nil)
if effectdesc then
local xPos=effectdesc[1]
local yPos=effectdesc[2]
self.effectRoot:setLocalPos(xPos,yPos,0)
self.effectTxt:setText(effectdesc[3])
end

if self.ticktimer then
self:stopTimerByID(self.ticktimer)
self.ticktimer=nil
end
if not isForver and hasLeftTimes then
self.timeRoot:setActive(true)
local starttime=data.starttime
local fixTime=pushGiftThreeConfig.getOpenTime(id)
local curStamp=timeHelper.getServerShortTime()
local endStamp=starttime+fixTime
local tick=function()
local curStamp=timeHelper.getServerShortTime()
local left=endStamp-curStamp
if left>0 then
self.leftTime:setText(FMT.fmt('剩余时间:{0}',timeHelper.format_time_stamp3(left)))
else
self.timeRoot:setActive(false)
self.leftTime:setText('')
if self.ticktimer then
self:stopTimerByID(self.ticktimer)
end
self.ticktimer=nil
self:onBtnClose()
end
end

self.ticktimer=self:setTimer(1,0,tick)
tick()
else
self.timeRoot:setActive(false)
self.leftTime:setText('')
end
end

function UIPushGiftAdvertThreeWin:freshItemList()
local id=self.giftId
local idx=self.idx
local cfg=pushGiftThreeConfig.getConfig(id)
self.cfg=cfg

local rewardsCfg=cfg.reward
local optionRewardsCfg=cfg.rewards
local rewards=rewardsCfg and rewardsCfg[idx]or{}
local optionRewards=optionRewardsCfg and optionRewardsCfg[idx]or{}
local args=(cfg.args or{})[idx]or{}
args=args[1]or{}
local itemArgs=args.item


for i=1,5 do
local itemSlot=self.item[i]
local widget1=itemSlot:getWidgetBase()

local itemInfo=rewards[i]
local isOption=optionRewards[i]~=nil
if isOption then
itemInfo=nil
local len=#pushGiftThreeConfig:getOptionCfg(id,idx,i)
if len>1 then
local selectIdx=pushGiftThreeModel:getSelectGiftItemIdx(id,idx,i)or nil

if selectIdx and pushGiftThreeModel:isOptionItemUnlock(id,idx,i,selectIdx)then
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,selectIdx)[1]
if self.optionSelectLookup[id]==nil then self.optionSelectLookup[id]={}end
if self.optionSelectLookup[id][idx]==nil then self.optionSelectLookup[id][idx]={}end
self.optionSelectLookup[id][idx][i]=selectIdx
end
else
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,1)[1]
isOption=false
if self.optionDefaultLookup[id]==nil then self.optionDefaultLookup[id]={}end
if self.optionDefaultLookup[id][idx]==nil then self.optionDefaultLookup[id][idx]={}end
self.optionDefaultLookup[id][idx][i]=1
end
end

local has=rewards[i]~=nil or optionRewards and optionRewards[i]~=nil
itemSlot:setActive(has)
if has then
if itemInfo then
local hasName=itemArgs and itemArgs.name and itemArgs.name[i]==1
local itemid=itemInfo[1]
local num=itemInfo[2]
local numStr=mathHelper.formatNumber(num)
local iconname=iconHelper.getIconName(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
widget1:SetChildActive(0,true)
widget1:SetChildIcon(1,iconname,false)
widget1:SetChildText(2,FMT.fmt('x{0}',numStr))
widget1:SetChildActive(3,hasName)
widget1:SetChildText(4,hasName and itemsModel.getName(itemid)or'')
widget1:SetChildCSImageSprite(0,globalABLookup.pushGiftTwo,_quality[itemCfg.color])
widget1:SetChildButtonClick(0,function()
tipsManager.showTips({itemid=itemid})
end,true)
widget1:SetChildActive(5,itemsConfig.isFabao(itemid))
widget1:SetChildActive(6,false)
widget1:SetChildActive(7,isOption)
if isOption then
widget1:SetChildButtonClick(7,function()
self:showOptionSelect(id,idx,i)
end,true)
end
local itemConfig=itemsConfig.getConfig(itemid)
local suitConfig
if itemConfig.bagType==16 then
suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,itemConfig.color)
end
local isZQ=suitConfig~=nil
widget1:SetChildActive(9,isZQ)
widget1:SetChildActive(10,isZQ)
if isZQ then
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
widget1:SetChildIcon(10,suitIconName,false)
local star=itemConfig.stage
widget1:SetChildGroundStarNum(9,star)
widget1:SetChildStarNumber(9,star)
end
else
widget1:SetChildActive(0,false)
widget1:SetChildIcon(1,'',false)
widget1:SetChildText(2,'')
widget1:SetChildActive(3,false)
widget1:SetChildText(4,'')
widget1:SetChildActive(5,false)
widget1:SetChildActive(6,true)
widget1:SetChildActive(7,false)
widget1:SetChildButtonClick(7,function()
self:showOptionSelect(id,idx,i)
end,true)
widget1:SetChildButtonClick(8,function()
self:showOptionSelect(id,idx,i)
end,true)
widget1:SetChildActive(9,false)
widget1:SetChildActive(10,false)
end
else
widget1:SetChildActive(0,false)
widget1:SetChildIcon(1,'',false)
widget1:SetChildText(2,'')
widget1:SetChildActive(3,false)
widget1:SetChildText(4,'')
widget1:SetChildActive(5,false)
widget1:SetChildActive(6,false)
widget1:SetChildActive(7,false)
widget1:SetChildActive(9,false)
widget1:SetChildActive(10,false)
end
end
end

function UIPushGiftAdvertThreeWin:setArrowStatus()
local idLen=#self.ids
local selectIdx=self.selectIdx
local visRight=idLen>0 and selectIdx<idLen
local visLeft=idLen>0 and selectIdx>1
self.btnRightArrow:setActive(visRight)
self.btnLeftArrow:setActive(visLeft)
end

function UIPushGiftAdvertThreeWin:onBuySuccess(id,idx)
if id==self.giftId and idx==self.idx then
local left=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)
if left<=0 then
local len=#pushGiftThreeConfig.getTotalBuyTimes(id)
while left<=0 and idx<len do
idx=idx+1
left=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)
end
if left<=0 then
local len=#self.ids
if len>1 then
self:removeId(id)
end
self:moveNext()
else
self.idx=idx
self:freshInfo()
end
else
self:freshInfo()
end
end
end

function UIPushGiftAdvertThreeWin:removeId(id)
for i,v in ipairs(self.ids)do
if v==id then
table.remove(self.ids,i)
break
end
end

end

function UIPushGiftAdvertThreeWin:moveNext()
local selectIdx=self.selectIdx
local len=#self.ids
self.giftId=nil
selectIdx=selectIdx+1
if selectIdx>len then selectIdx=len end
self:onSelectDefaultGiftByIdx(selectIdx)
end




function UIPushGiftAdvertThreeWin:onBtnBuy()
local idx=self.idx
local id=self.giftId
local leftTimes=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)
if leftTimes<=0 then
UIManager.error('购买次数不足')
return
end
local lookup=self.optionSelectLookup[id]and self.optionSelectLookup[id][idx]or nil
local defaultlookup=self.optionDefaultLookup[id]and self.optionDefaultLookup[id][idx]or nil
if not pushGiftThreeModel:isFillAllOption(id,idx,lookup,defaultlookup)then
UIManager.error('请选择自选道具！')
return
end
local cfg=pushGiftThreeConfig.getConfig(id)
if self.cfg.consume and self.cfg.consume[idx]then
local consume=self.cfg.consume[idx]
local moneyType=consume[1][1]
local moneyCount=consume[1][2]
local func=function()
if not moneyModel.checkEnoughMoney(moneyType,moneyCount)then
local moneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt('{0}不足',moneyName))
gainControl:showGainWin(moneyType)
return
end

pushGiftThreeController.buyGift(id,idx,lookup,defaultlookup)
end

local isEnough=moneyModel.checkEnoughMoney(moneyType,moneyCount)
if not isEnough and moneyType==eMoneyType.mtLingYu then

local hasLingYuCount=moneyModel.getMoney(moneyType)
local needXianYuCount=moneyCount-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end
if not isEnough then
local MoneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt("{0}不足",MoneyName))
gainControl:showGainWin(moneyType)
return
end


local content="是否花费 {0}<color=#549327>{1}</color> 购买？"
local itemIconName=iconHelper.getIconName(moneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(itemIconName,36)
content=FMT.fmt(content,iconStr,moneyCount)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function(...)
moneySystem:useMoney(moneyType,moneyCount,func,WARNING_TYPE.eWarning)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()

else
local optionStr=''
if lookup or defaultlookup then
local t={}
if lookup then
for hoidIdx,_idx in pairs(lookup)do
t[#t+1]={hoidIdx,_idx}
end
end

if defaultlookup then
for hoidIdx,_idx in pairs(defaultlookup)do
t[#t+1]={hoidIdx,_idx}
end
end

table.sort(t,function(a,b)
return a[1]<b[1]
end)

for i,v in ipairs(t)do
optionStr=FMT.fmt('{0}-{1}',optionStr,v[2])
end
end
local rechargeid=cfg.recharge[idx]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local numStr=str:match("^%d+")

local rechargeAmount=payControl:getRechargeAmount(rechargeid)
local twoTimeCostNum=rechargeAmount*2
local titemid,voucherCount=payControl.getVoucherId(twoTimeCostNum)
local buyFunc=function(count,isItem)
if isItem then
local param=FMT.fmt('{0}-{1}{2}',id,idx,optionStr)
local pram=jsonHelper.encode({rechargeid,param})
bagProtocolControl.req_1_21(titemid,count*rechargeAmount,pram)
else
payControl.reqPay(rechargeid,count)
end
end
local leftTimes=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)
local buyTimes=pushGiftThreeModel:getAlreadyBuyTimes(id,idx)
local totalTimes=pushGiftThreeConfig.getBuyTimesByCfg(id,idx)
if leftTimes>1 and voucherCount>=twoTimeCostNum then
local totalRewards={}
local cfg=pushGiftThreeConfig.getConfig(id)
local rewardsCfg=cfg.reward
if cfg.clientreward then
rewardsCfg=cfg.clientreward
end
local optionRewardsCfg=cfg.rewards
local rewards=rewardsCfg and rewardsCfg[idx]or{}
local optionRewards=optionRewardsCfg and optionRewardsCfg[idx]or{}
for i=1,5 do
local itemInfo=rewards[i]
local isOption=optionRewards[i]~=nil
if isOption then
itemInfo=nil
local len=#pushGiftThreeConfig:getOptionCfg(id,idx,i)
if len>1 then
local selectIdx=pushGiftThreeModel:getSelectGiftItemIdx(id,idx,i)or nil

if selectIdx and pushGiftThreeModel:isOptionItemUnlock(id,idx,i,selectIdx)then
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,selectIdx)[1]
if self.optionSelectLookup[id]==nil then self.optionSelectLookup[id]={}end
if self.optionSelectLookup[id][idx]==nil then self.optionSelectLookup[id][idx]={}end
self.optionSelectLookup[id][idx][i]=selectIdx
end
else
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,1)[1]
isOption=false
if self.optionDefaultLookup[id]==nil then self.optionDefaultLookup[id]={}end
if self.optionDefaultLookup[id][idx]==nil then self.optionDefaultLookup[id][idx]={}end
self.optionDefaultLookup[id][idx][i]=1
end
end
table.insert(totalRewards,{itemInfo[1],itemInfo[2]})
end
local args={
rewards=totalRewards,
name=cfg.name,
price={titemid,rechargeAmount},
leftNum=buyTimes,
maxcount=totalTimes,
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num,true)
end
}
UIManager:showWindow("UICommonBuyDialogWin",args)
else
local rechargeId=cfg.recharge[idx]
local param=FMT.fmt('{0}-{1}{2}',id,idx,optionStr)
payControl.reqPay(rechargeId,1,param)
end
end
end



function UIPushGiftAdvertThreeWin:onBtnClose()

self:closeSelf()
end



function UIPushGiftAdvertThreeWin:onBtnTab_1()
self:onSelectPage(1)
end



function UIPushGiftAdvertThreeWin:onBtnTab_2()
self:onSelectPage(2)
end



function UIPushGiftAdvertThreeWin:onBtnTab_3()
self:onSelectPage(3)
end

function UIPushGiftAdvertThreeWin:onBtnTab_4()
self:onSelectPage(4)
end



function UIPushGiftAdvertThreeWin:onBtnRightArrow()
local selectIdx=self.selectIdx
local len=#self.ids
if len<=0 or selectIdx==len then return end
local nextidx=selectIdx+1
self:onSelectDefaultGiftByIdx(nextidx)
end



function UIPushGiftAdvertThreeWin:onBtnLeftArrow()
local selectIdx=self.selectIdx
local len=#self.ids
if len<=0 or selectIdx<=1 then return end
local nextidx=selectIdx-1
self:onSelectDefaultGiftByIdx(nextidx)
end

function UIPushGiftAdvertThreeWin.onItemClick(itemid,index,itemguid,attach)
if itemid==nil or itemid==-1 then return end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,attach=attach,showModel=true})
end













function UIPushGiftAdvertThreeWin:onSelectOption(selectLookup,args)
local giftId=args.giftId
local lvIdx=args.lvIdx
if self.giftId~=giftId or self.idx~=lvIdx then return end
local oldLookup=self.optionSelectLookup[giftId]and self.optionSelectLookup[giftId][lvIdx]or{}
local changed=false
for hoidIdx,idx in pairs(selectLookup)do
if oldLookup[hoidIdx]~=idx then
changed=true
break
end
end
if changed then
if self.optionSelectLookup[giftId]==nil then self.optionSelectLookup[giftId]={}end
self.optionSelectLookup[giftId][lvIdx]=selectLookup
for hoidIdx,index in pairs(selectLookup)do
pushGiftThreeModel:setSelectGiftItemIdx(giftId,lvIdx,hoidIdx,index,false)
end
pushGiftThreeModel:flushSelectGiftItem()
self:freshItemList()
end
end

function UIPushGiftAdvertThreeWin:showOptionSelect(giftId,lvIdx,shoidIdx)
local rewards=pushGiftThreeConfig:getOptionRewards(giftId,lvIdx)
if rewards==nil then return end
local itemList={}
local selectLookup={}
local holeList={}
for hoidIdx,v in pairs(rewards)do
local selectIdx=pushGiftThreeModel:getSelectGiftItemIdx(giftId,lvIdx,hoidIdx)
local len=#pushGiftThreeConfig:getOptionCfg(giftId,lvIdx,hoidIdx)
if len>1 then
holeList[#holeList+1]=hoidIdx
if itemList[hoidIdx]==nil then itemList[hoidIdx]={}end
local itemholeList=itemList[hoidIdx]
for i,vv in ipairs(v)do
if pushGiftThreeModel:isOptionItemUnlock(giftId,lvIdx,hoidIdx,i)then
itemholeList[#itemholeList+1]={i,vv[1]}
if selectIdx==i then
selectLookup[hoidIdx]=selectIdx
end
end
end
end
end
if self.optionSelectLookup[giftId]==nil then self.optionSelectLookup[giftId]={}end
self.optionSelectLookup[giftId][lvIdx]=selectLookup
table.sort(holeList,function(a,b)
return a<b
end)
local args={
selectLookup=table.deepCopy(selectLookup),
itemList=itemList,
holeList=holeList,
selectHoleIdx=shoidIdx,
selectCallback=function(...)
if self and not self.isClose then
self:onSelectOption(...)
end
end,
attach={giftId=giftId,lvIdx=lvIdx},
}
self:showWindow('UIPushGiftSelectWin',args)
end