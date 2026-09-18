







def_class("UIPushGiftWin",UIWindowBase)









function UIPushGiftWin:bindComponents()

self.backImage=UIImage.get(self,0)
self.modelRoot=UIObject.get(self,1)
self.arrowRoot=UIObject.get(self,2)
self.tabRoot=UIObject.get(self,3)
self.btnBuy=UIButton.get(self,4)
self.btnClose=UIButton.get(self,5)
self.items=UIObject.get(self,6)
self.item_3=UIObject.get(self,7)
self.item_2=UIObject.get(self,8)
self.item_1=UIObject.get(self,9)
self.item_4=UIObject.get(self,10)
self.buyTitle=UIText.get(self,11)
self.btn_1=UIButton.get(self,12)
self.btn_2=UIButton.get(self,13)
self.btn_3=UIButton.get(self,14)
self.selectBtn_1=UIObject.get(self,15)
self.btnTxt_1=UIText.get(self,16)
self.btnTxt_2=UIText.get(self,17)
self.selectBtn_2=UIObject.get(self,18)
self.selectBtn_3=UIObject.get(self,19)
self.btnTxt_3=UIText.get(self,20)
self.timeRoot=UIObject.get(self,21)
self.infoRoot=UIObject.get(self,22)
self.timeImage=UIImage.get(self,23)
self.leftTime=UIText.get(self,24)
self.descImage=UIImage.get(self,25)
self.btnRightArrow=UIButton.get(self,26)
self.btnLeftArrow=UIButton.get(self,27)
self.modelDescImage=UIImage.get(self,28)
self.txtYuan=UIText.get(self,29)
self.inModel=UIObject.get(self,30)
self.txtBuy=UIText.get(self,31)
self.yuanIcon=UIObject.get(self,32)
self.outModel=UIObject.get(self,33)
self.modelImage=UIImage.get(self,34)
self.over=UIObject.get(self,35)
self.numberImage=UIImage.get(self,36)
self.bgModel=UIObject.get(self,37)
self.root=UIObject.get(self,38)
self.npcModel=UIObject.get(self,39)

self.btnBuy:setButtonClick(function()self:onBtnBuy()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btn_1:setButtonClick(function()self:onBtn_1()end)

self.btn_2:setButtonClick(function()self:onBtn_2()end)

self.btn_3:setButtonClick(function()self:onBtn_3()end)

self.btnRightArrow:setButtonClick(function()self:onBtnRightArrow()end)

self.btnLeftArrow:setButtonClick(function()self:onBtnLeftArrow()end)
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
}
self.btn={
self.btn_1,
self.btn_2,
self.btn_3,
}
self.selectBtn={
self.selectBtn_1,
self.selectBtn_2,
self.selectBtn_3,
}
self.btnTxt={
self.btnTxt_1,
self.btnTxt_2,
self.btnTxt_3,
}



end


function UIPushGiftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backImage);self.backImage=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.arrowRoot);self.arrowRoot=nil;
_UIObject_release(self.tabRoot);self.tabRoot=nil;
_UIObject_release(self.btnBuy);self.btnBuy=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.items);self.items=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_4);self.item_4=nil;
_UIObject_release(self.buyTitle);self.buyTitle=nil;
_UIObject_release(self.btn_1);self.btn_1=nil;
_UIObject_release(self.btn_2);self.btn_2=nil;
_UIObject_release(self.btn_3);self.btn_3=nil;
_UIObject_release(self.selectBtn_1);self.selectBtn_1=nil;
_UIObject_release(self.btnTxt_1);self.btnTxt_1=nil;
_UIObject_release(self.btnTxt_2);self.btnTxt_2=nil;
_UIObject_release(self.selectBtn_2);self.selectBtn_2=nil;
_UIObject_release(self.selectBtn_3);self.selectBtn_3=nil;
_UIObject_release(self.btnTxt_3);self.btnTxt_3=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.infoRoot);self.infoRoot=nil;
_UIObject_release(self.timeImage);self.timeImage=nil;
_UIObject_release(self.leftTime);self.leftTime=nil;
_UIObject_release(self.descImage);self.descImage=nil;
_UIObject_release(self.btnRightArrow);self.btnRightArrow=nil;
_UIObject_release(self.btnLeftArrow);self.btnLeftArrow=nil;
_UIObject_release(self.modelDescImage);self.modelDescImage=nil;
_UIObject_release(self.txtYuan);self.txtYuan=nil;
_UIObject_release(self.inModel);self.inModel=nil;
_UIObject_release(self.txtBuy);self.txtBuy=nil;
_UIObject_release(self.yuanIcon);self.yuanIcon=nil;
_UIObject_release(self.outModel);self.outModel=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.over);self.over=nil;
_UIObject_release(self.numberImage);self.numberImage=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
self.item=nil;
self.btn=nil;
self.selectBtn=nil;
self.btnTxt=nil;
end


















function UIPushGiftWin:onLoaded(...)
self:bindComponents()
self.arrowTweener={}
end

function UIPushGiftWin:__delete()
self:unbindComponents()
pushGiftController.checkAllGift()
pushGiftController:clearPush()
end

function UIPushGiftWin:onShow(argtable,afterOnloaded)

argtable=argtable or{}
local id=argtable.id

self.root:setChildCanvasGroupAlpha(0)

local bgModelId=4029
self.bgModel:setChildUIModelShowTarget(bgModelId,1,{},eAnimationID.enter,false,false,0,function()
self.root:setChildCanvasGroupDOFade(1,0.3)
end)
if not self:showGift(id)then

self:closeSelf()
end
end

function UIPushGiftWin:onHide()

end

function UIPushGiftWin:onSelectDefaultGiftByIdx(selectIdx)
local id=self.ids[selectIdx]
if self.id==id then return end
self.id=id
self.idx=nil
self.selectIdx=selectIdx
local idx=pushGiftModel:getNextHasLeftBuyTimesGift(id)

self:onSelectPage(idx)
end

function UIPushGiftWin:onSelectGift(id,idx)
if self.id==id and self.idx==idx then return end
self.id=id
local selectIdx=nil
for i,v in ipairs(self.ids)do
if v==id then
selectIdx=i
break
end
end
assert(selectIdx,FMT.fmt('not find selectidx:{0}',id))
self.selectIdx=selectIdx
self:onSelectPage(1)
end

function UIPushGiftWin:onSelectPage(idx)
if self.idx==idx then return end
self.idx=idx
self:freshPage()
end

function UIPushGiftWin:freshPage()
local id=self.id
local idx=self.idx
local cfg=cfg_limitedtimegiftconfig_get(id)
self.cfg=cfg
local rewards=cfg.reward[idx]
local consume=cfg.consume
local recharge=cfg.recharge
local args=(cfg.args or{})[idx]or{}
local data=pushGiftModel:getAllData(id)
local starttime=data.starttime
local fixTime=pushGiftConfig.getOpenTime(id)
local curStamp=timeHelper.getServerShortTime()
local endStamp=starttime+fixTime
local left=endStamp-curStamp

self:setBtnStatus()

local len=#cfg.reward
for i,v in ipairs(self.btn)do
self.btn[i]:setActive(false)
end
self.txtYuan:setActive(true)
local vis=len>1
for i=1,len do
self.btn[i]:setActive(vis==true and len>=i)
local isSelect=i==idx
self.selectBtn[i]:setActive(isSelect)
if isSelect then
local leftTimes=pushGiftModel:getIdxLeftBuyTimes(id,i)
self.buyTitle:setText(leftTimes>0 and FMT.fmt('限购：{0}次',leftTimes)or'')
self.over:setActive(leftTimes<=0)
self.btnBuy:setActive(leftTimes>0)
end
local con=consume and consume[i]
if con then
local moneyCfg=con[1]
local moneyType=moneyCfg[1]
local moneyValue=moneyCfg[2]
local moneyName=moneyModel.getMoneyName(moneyType)
self.btnTxt[i]:setText(FMT.fmt('{0}{1}',moneyValue,moneyName))
if isSelect then
self.txtBuy:setActive(true)
self.txtBuy:setText(moneyValue)
self.yuanIcon:setIcon(iconHelper.getIconName(moneyType),false)
self.txtYuan:setText('')
end
else
local rechargeid=recharge[i]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.btnTxt[i]:setText(str)
if isSelect then
self.txtBuy:setActive(false)
self.txtYuan:setText(str)
end
end
end

for i=1,4 do
local itemSlot=self.item[i]
local widget=itemSlot:getWidgetBase()
local reward=rewards[i]
local has=reward~=nil
itemSlot:setActive(has)
if has then
local itemid=reward[1]
local num=reward[2]
local conf={itemid=itemid,itemcount=num>1 and mathHelper.formatNumber(num)or'',showCountBG=num>1,colorEffect=true}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
local widget1=widget:GetChildWidgetBase(0)
widget1:SetPropData(propData)
widget1:SetBaseItemClickEvent(-1,self.onItemClick)
end
end
local modelArgs=args.npc
local buildArgs=args.build
local gubaoid=args.gubaoid
local npctArgs=args.npctitle
local npcImage=args.npcImage
local npcModelArgs=args.npcModel
local nameArgs=args.name
local shouyiArgs=args.shouyi




if nameArgs then
self.descImage:setActive(true)
self.descImage:setSprite(globalABLookup.pushGift,nameArgs[1])
self.winlua:SetChildLocalPos(self.descImage:getID(),nameArgs[2],nameArgs[3],0)
else
self.descImage:setActive(false)
end

if shouyiArgs then
self.numberImage:setActive(true)
self.numberImage:setSprite(globalABLookup.pushGift,shouyiArgs[1])
self.winlua:SetChildLocalPos(self.numberImage:getID(),shouyiArgs[2],shouyiArgs[3],0)
else
self.numberImage:setActive(false)
end

if npctArgs then
self.modelDescImage:setActive(true)
self.modelDescImage:setSprite(globalABLookup.pushGift,npctArgs[1])
self.winlua:SetChildLocalPos(self.modelDescImage:getID(),npctArgs[2],npctArgs[3],0)
else
self.modelDescImage:setActive(false)
end
local modelArgs=args.npc
local buildArgs=args.build
local gubaoArgs=args.gubaoid
if modelArgs then
self.modelImage:setActive(false)
self.npcModel:setActive(false)
local npcid=modelArgs[1]
local outParams=modelArgs[2]
local intParams=modelArgs[3]
local imageParams=npcModel:getImageInfo(npcid)
local imageOutParams=npcModel:getImageInfoOutSide(npcid)

if outParams and outParams[1]then
local scale=outParams[1]
local offsetX=outParams[2]
local offsetY=outParams[3]
self.outModel:setActive(true)
self.outModel:setChildUIModelShowTarget(imageOutParams.body,scale,imageOutParams.componets,eAnimationID.idle)
if offsetX~=nil and offsetY~=nil then
self.outModel:setChildUIModelShowTargetOffset(offsetX,offsetY)
end
else
self.outModel:setActive(false)
end

if intParams then
local scale=intParams[1]
local offsetX=intParams[2]
local offsetY=intParams[3]
self.inModel:setActive(true)
self.inModel:setChildUIModelShowTarget(imageParams.body,scale,imageParams.componets,eAnimationID.idle)
if offsetX~=nil and offsetY~=nil then
self.outModel:setChildUIModelShowTargetOffset(offsetX,offsetY)
end
else
self.inModel:setActive(false)
end
elseif buildArgs then
self.modelImage:setActive(false)
self.npcModel:setActive(false)
local buildid=buildArgs[1]
local level=buildArgs[2]
local scale=buildArgs[3]or 1
local offsetX=buildArgs[4]
local offsetY=buildArgs[5]
self.inModel:setActive(false)
self.outModel:setActive(true)
local model=cfg_monijybuildconfig_get(buildid).model
self.outModel:setChildUIModelShowTarget(model[level],scale,nil,eAnimationID.idle)
if offsetX~=nil and offsetY~=nil then
self.outModel:setChildUIModelShowTargetOffset(offsetX,offsetY)
end
elseif gubaoArgs then
self.modelImage:setActive(true)
self.inModel:setActive(false)
self.outModel:setActive(false)
self.npcModel:setActive(false)
local gbcfg=cfgHelper.get1(cfg_gubaoconfig_get,gubaoArgs[1])
self.modelImage:setImageIcon(gubaoModel:getGuBaoIconName(gbcfg.icon),true)
self.winlua:SetChildLocalPos(self.modelImage:getID(),gubaoArgs[2],gubaoArgs[3],0)
elseif npcImage then
self.modelImage:setActive(true)
self.inModel:setActive(false)
self.outModel:setActive(false)
self.npcModel:setActive(false)
self.modelImage:setSprite(globalABLookup.pushGift,npcImage[1])
self.winlua:SetChildLocalPos(self.modelImage:getID(),npcImage[2],npcImage[3],0)
elseif npcModelArgs then
local modelId=npcModelArgs[1]
local scale=npcModelArgs[2]or 1
local offsetX=npcModelArgs[3]or 0
local offsetY=npcModelArgs[4]or 0
local anim=npcModelArgs[5]or eAnimationID.stand
self.modelImage:setActive(false)
self.inModel:setActive(false)
self.outModel:setActive(false)

self.npcModel:setActive(true)
self.npcModel:setChildUIModelShowTarget(modelId,scale,nil,anim)
self.npcModel:setChildUIModelShowTargetOffset(offsetX,offsetY)
end

local tick=function()
local curStamp=timeHelper.getServerShortTime()
local left=endStamp-curStamp
self.leftTime:setText(FMT.fmt('剩余时间 {0}',timeHelper.format_time_stamp(left)))
end

if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=self:setTimer(1,0,tick)
tick()
end

function UIPushGiftWin:setBtnStatus()
local idLen=#self.ids
local selectIdx=self.selectIdx
local visRight=idLen>0 and selectIdx<idLen
local visLeft=idLen>0 and selectIdx>1
self.btnRightArrow:setActive(visRight)
self.btnLeftArrow:setActive(visLeft)
end

function UIPushGiftWin:onBuySuccess(id,idx)
if id==self.id and idx==self.idx then
local left=pushGiftModel:getIdxLeftBuyTimes(id,idx)
if left<=0 then
local len=#pushGiftConfig.getTotalBuyTimes(id)
while left<0 and idx<len do
idx=idx+1
left=pushGiftModel:getIdxLeftBuyTimes(id,idx)
end
if left<=0 then
self:freshPage()
else
self.idx=idx
end
else
self:freshPage()
end
end
end

function UIPushGiftWin:showGift(id)
local ids=pushGiftModel:getGiftIds()
local len=#ids
if len<=0 then
return false
end
local idx
if id then
for i,v in ipairs(ids)do
if v==id then
idx=i
break
end
end
end
local selectIdx=idx or len
self.ids=ids
self.id=nil
self:onSelectDefaultGiftByIdx(selectIdx)
return true
end

function UIPushGiftWin:moveNext(id)
self:showGift()
end




function UIPushGiftWin:onBtnBuy()
local idx=self.idx
local id=self.id
local leftTimes=pushGiftModel:getIdxLeftBuyTimes(id,idx)
if leftTimes<=0 then
UIManager.error('购买次数不足')
return
end
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
socketManager:send_15_23(id,idx,1,0,nil)
end
moneySystem:useMoney(moneyType,moneyCount,func,WARNING_TYPE.eWarning)
else
local rechargeid=self.cfg.recharge[idx]
local param=FMT.fmt('{0}-{1}',id,idx)
payControl.reqPay(rechargeid,1,param)
end
end



function UIPushGiftWin:onBtnClose()
self:closeSelf()
end



function UIPushGiftWin:onBtn_1()
self:onSelectPage(1)
end



function UIPushGiftWin:onBtn_2()
self:onSelectPage(2)
end



function UIPushGiftWin:onBtn_3()
self:onSelectPage(3)
end



function UIPushGiftWin:onBtnRightArrow()
local selectIdx=self.selectIdx
local len=#self.ids
if len<=0 or selectIdx==len then return end
local nextidx=selectIdx+1
self:onSelectDefaultGiftByIdx(nextidx)
end



function UIPushGiftWin:onBtnLeftArrow()
local selectIdx=self.selectIdx
local len=#self.ids
if len<=0 or selectIdx<=1 then return end
local nextidx=selectIdx-1
self:onSelectDefaultGiftByIdx(nextidx)
end

function UIPushGiftWin.onItemClick(itemid,index,itemguid,attach)
if itemid==nil or itemid==-1 then return end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,attach=attach,showModel=true})
end
