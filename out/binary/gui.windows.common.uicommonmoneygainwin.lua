







def_class("UICommonMoneyGainWin",UIWindowBase)









function UICommonMoneyGainWin:bindComponents()

self.root=UIObject.get(self,0)
self.name=UIText.get(self,1)
self.quality=UIImage.get(self,2)
self.Icon=UIImage.get(self,3)
self.num=UIText.get(self,4)
self.descScrollView=UIObject.get(self,5)
self.arrow=UIObject.get(self,6)
self.adaptation=UIObject.get(self,7)
self.desc=UIText.get(self,8)
self.descContent=UIObject.get(self,9)
self.cdTx=UIText.get(self,10)
self.gainScrollerView=UIObject.get(self,11)



end


function UICommonMoneyGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.quality);self.quality=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.descScrollView);self.descScrollView=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.adaptation);self.adaptation=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.descContent);self.descContent=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.gainScrollerView);self.gainScrollerView=nil;
end
















local _offset=10
local _this=nil
local _cdSpecialStr={
[eMoneyType.mtLingPai]=function(itemId,itemName)
local ccdNum=moneyAutoIncreaseModel:ccdNum(itemId)
local least=moneyAutoIncreaseModel:getLeastTime(itemId)
least=math.max(least,0)
local leastFull=moneyAutoIncreaseModel:getLeastTimeToFull(itemId)
leastFull=math.max(leastFull,0)
local param1=timeHelper.format_time_stamp3(least,true)
local param2=mathHelper.numberToChinese(math.floor(ccdNum))
local param3=itemName
local param4=timeHelper.format_time_stamp3(leastFull,true)
return FMT.fmt("(恢复{1}个{2}：<color=#29ad0f>{0}</color>)\n(恢复至上限值：<color=#29ad0f>{3}</color>)",param1,param2,param3,param4)
end,

[eMoneyType.mtLunHuiDian]=function(itemId,itemName)
local ccdNum=moneyAutoIncreaseModel:ccdNum(itemId)
local least=moneyAutoIncreaseModel:getLeastTime(itemId)
least=math.max(least,0)
local leastFull=moneyAutoIncreaseModel:getLeastTimeToFull(itemId)
leastFull=math.max(leastFull,0)
local param1=timeHelper.format_time_stamp(least,true)
local param2=math.floor(ccdNum)
local param3=itemName
local param4=timeHelper.format_time_stamp3(leastFull,true)
return FMT.fmt("(<color=#29ad0f>{0}</color>后获得<color=#29ad0f>{1}</color>{2})\n(<color=#29ad0f>{3}</color>后达到{2}上限值)",param1,param2,param3,param4)
end,

[eMoneyType.mtXianLing]=function(itemId,itemName)
local ccdNum=moneyAutoIncreaseModel:ccdNum(itemId)
local least=moneyAutoIncreaseModel:getLeastTime(itemId)
least=math.max(least,0)
local leastFull=moneyAutoIncreaseModel:getLeastTimeToFull(itemId)
leastFull=math.max(leastFull,0)
local param1=timeHelper.format_time_stamp3(least,true)
local param2=mathHelper.numberToChinese(math.floor(ccdNum))
local param3=itemName
local param4=timeHelper.format_time_stamp3(leastFull,true)
return FMT.fmt("(恢复{1}个{2}：<color=#29ad0f>{0}</color>)\n(恢复至上限值：<color=#29ad0f>{3}</color>)",param1,param2,param3,param4)
end,

[eMoneyType.mtMoLing]=function(itemId,itemName)
local ccdNum=moneyAutoIncreaseModel:ccdNum(itemId)
local least=moneyAutoIncreaseModel:getLeastTime(itemId)
least=math.max(least,0)
local leastFull=moneyAutoIncreaseModel:getLeastTimeToFull(itemId)
leastFull=math.max(leastFull,0)
local param1=timeHelper.format_time_stamp3(least,true)
local param2=mathHelper.numberToChinese(math.floor(ccdNum))
local param3=itemName
local param4=timeHelper.format_time_stamp3(leastFull,true)
return FMT.fmt("(恢复{1}个{2}：<color=#29ad0f>{0}</color>)\n(恢复至上限值：<color=#29ad0f>{3}</color>)",param1,param2,param3,param4)
end,
}

local _quickBuyfunc=
{
[1]=
{
args=function(self,buyParam)
local args={}
local buyArgs=buyParam.args
local giftid=buyArgs[1]
local cfg=cfg_limitedgiftconfig_get(giftid)
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(giftid)
local maxcount=cfg.maxcount
local leftNum=maxcount-buyNum
local name=cfg.name
local rechargeid=cfg.rechargeid
local price=cfg.price
local btnTxt=''
local func
local buyDialogue=buyParam.buyDialogue~=0
if rechargeid then
local rechargecfg=cfg_rechargeconfig_get(rechargeid)
btnTxt=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
func=function()
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(giftid)
local left=maxcount-buyNum
if left>0 then
self.giftid=giftid
payControl.reqPay(rechargeid)
else
UIManager.error('此礼包已售罄')
end
end
else
local moneyType=price[1]
local moneyCount=price[2]
local moneyname=moneyModel.getMoneyName(moneyType)
btnTxt=FMT.fmt('{0}{1}',moneyCount,moneyname)
func=function()
local cb=function()
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(giftid)
local left=maxcount-buyNum
if left>0 then
self.giftid=giftid
rechargeController:reqXianGouLiBaoBuy(giftid,1)
else
UIManager.error('此礼包已售罄')
end
end
moneySystem:useMoney(moneyType,moneyCount,cb,WARNING_TYPE.eWarning)
end
end
args.rewards=rechargeModel:getXianGouLiBaoRewards(cfg.rewards)
args.title=FMT.fmt('还可购买{0}/{1}次',leftNum,maxcount)
args.btnTxt=btnTxt
args.name=cfg.name
















args.okCallback=function()
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(giftid)
local left=maxcount-buyNum
if left>0 then
if buyDialogue then
local colorStr=FMT.cfmt(FONT_COLOR.eRedColor,btnTxt)
local str=FMT.fmt('祖师您确定要消耗{0}购买该礼包吗？',colorStr)
UIDialogManager.getConfirmDialog3(nil,str,func)
else
func()
end
else
UIManager.error('此礼包已售罄')
end
end
return args
end,
gray=function(self,buyParam)
if buyParam.gray==0 then return false end
local buyArgs=buyParam.args
local giftid=buyArgs[1]
local cfg=cfg_limitedgiftconfig_get(giftid)
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(giftid)
local maxcount=cfg.maxcount
local left=maxcount-buyNum
local ret=left<=0
local tips=''
if ret then
tips='此礼包已售罄'
end
return ret,tips
end,
icon=function(self,buyParam)
return self:getCommonIconArgs(buyParam.icon)
end,
}
}

local _grayfunc=
{
[1]=function(self,grayParam)

local shopId=grayParam.args[1]
local buyId=grayParam.args[2]

if not funcShopModel:checkInit(shopId)then

funcShopController.send_23_1(shopId)
return false
end

local isSellOut=funcShopModel:checkSoldout(shopId,buyId)
if isSellOut then

local shopItemCfg=funcShopModel.get_shop_item_conf(shopId,buyId)
local itemId=shopItemCfg.itemId
local itemName=itemsConfig.getItemName(itemId)
local errStr=FMT.fmt("<{0}>已售罄",itemName)
return true,errStr
end
return false
end,
}

local gainItemCmpIndex={
icon=0,
name=1,
lockImg=2,
goBtn=3,
bg=4,
garyImg=5,
state=6,
selectBg=7,
specialBg=8,
}

function UICommonMoneyGainWin:onLoaded(...)
self:bindComponents()
_this=self
self.gainScrollerView:setChildScrollViewInit(-1,true,nil,nil)
self.descScrollHeight=self.winlua:GetChildSizeDeltaY(self.descScrollView:getID())
self:activeArrow(false)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.onItemChanged)
notifySystem:listenNotify(notifyConfig.onCommonShopData,self.onCommonShopData)

end


function UICommonMoneyGainWin:__delete()
self:unbindComponents()
self:closeWindow('UIQuickUseWin')
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChanged)
notifySystem:removelistener(notifyConfig.on_item_changed,self.onItemChanged)
notifySystem:removelistener(notifyConfig.onCommonShopData,self.onCommonShopData)
_this=nil
self:stopCountDown()
end




function UICommonMoneyGainWin:onShow(argtable,afterOnloaded)
self.jumpCB=argtable.jumpCB
self.parentWin=argtable.parentWin
self.goodId=argtable.goodId
self.goodName=argtable.goodName
self.needCount=argtable.needCount
self.expireCount=argtable.expireCount
local goodNum=argtable.goodNum
local goodIconName=argtable.goodIconName
local goodSignIcon=argtable.goodSignIcon
local goodColorPage=argtable.goodColorPage
local goodColor=argtable.goodColor
local goodDesc=argtable.goodDesc
self.goodProduce=argtable.goodProduce
self.name:setText(self.goodName)
self.desc:setText(goodDesc)

self:refreshGoodNum(goodNum)
self.Icon:setImageIcon(goodIconName,false)
itemsComponentHelper.setUIBaseItemSmallSignCommonEx(self.widget,self.Icon:getID(),goodSignIcon,false)

self.winlua:SetChildQulaityEx(self.quality:getID(),goodColorPage,goodColor)
self:refreshGainList()
self:checkCountDown()

local datas=zongmenControl:getQuickUseItems(self.goodId)
if datas and#datas>0 then
self.parentWin:showCloseBtn(false)
self:delayDo(0.25,function()
self:showQuickWin()
end)
elseif self.quickHeChengInfo then
self:delayDo(0.25,function()
self:showQuickHeChengWin(self.quickHeChengInfo,self.quickHeChengItemIndex)
end)
elseif self.quickShopBuyInfo then
self:delayDo(0.25,function()
self:showQuickShopBuyWin(self.quickShopBuyInfo,self.quickShopBuyItemIndex)
end)
end
end


function UICommonMoneyGainWin:onHide()

end

function UICommonMoneyGainWin:refreshGainList()
local showList=gainControl:getGainSortList(self.goodProduce,self.goodId)
self.gainScrollerView:setChildScrollViewCreateGrids(#showList,1)
local grids=self.gainScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
self.quickHeChengInfo=nil
self.quickHeChengItemIndex=nil
self.quickBuyInfo=nil

for i=1,count do
local item=grids[i-1]
local info=showList[i]
local jump=info.jump
local buy=info.buy
local hecheng=info.hecheng
local shopBuy=info.shopBuy
local hasJump=jump~=nil
local hasBuy=buy~=nil
local hasHeCheng=hecheng~=nil
local hasShopBuy=shopBuy~=nil
local unLock,errArgs=gainControl:isUnlock(info)
local isGray,tips=self:isGray(info)
local canJump=hasJump and unLock or false
local canBuy=hasBuy and unLock or false
local canHeCheng=hasHeCheng and unLock or false
local canShopBuy=hasShopBuy and unLock or false
if canHeCheng then
self.quickHeChengInfo=info
self.quickHeChengItemIndex=i
end
if canBuy then
self.quickBuyInfo=info
end
if canShopBuy then
self.quickShopBuyInfo=info
self.quickShopBuyItemIndex=i
end

local active=(canJump or canBuy or canHeCheng or canShopBuy)and not isGray
local iconInfo=self:getIconInfo(info)
iconHelper.setChildIcon_2(item,gainItemCmpIndex.icon,iconInfo)
local desc,state=gainControl:getJumpDesc(info,unLock,isGray)
item:SetChildText(gainItemCmpIndex.name,desc)
item:SetChildText(gainItemCmpIndex.state,state)
item:SetChildActive(gainItemCmpIndex.lockImg,not unLock)
item:SetChildActive(gainItemCmpIndex.garyImg,unLock and isGray)
local showArrow=gainControl:checkShowArrow(jump,active,state)
item:SetChildActive(gainItemCmpIndex.goBtn,not hasHeCheng and not hasShopBuy and showArrow)
local clickBgFun=function(...)
if _this==nil then return end
if active then
if canJump then

gainControl:handleJump(jump,self.jumpCB)
elseif canBuy then
self:showQuickBuyWin(info)
elseif canHeCheng then
self:showQuickHeChengWin(info,i)
elseif canShopBuy then
self:showQuickShopBuyWin(info,i)
end
else
if not unLock then
gainControl:showTips(errArgs)
elseif isGray then
UIManager.error(tips)
else


end
end
end
if hasHeCheng or hasShopBuy then
item:SetChildActive(gainItemCmpIndex.specialBg,true)
item:SetChildActive(gainItemCmpIndex.bg,false)
item:SetChildButtonClick(gainItemCmpIndex.specialBg,clickBgFun)
else
item:SetChildActive(gainItemCmpIndex.bg,true)
item:SetChildActive(gainItemCmpIndex.specialBg,false)
item:SetChildButtonClick(gainItemCmpIndex.bg,clickBgFun)
end
end
end


function UICommonMoneyGainWin:refreshGoodNum(num)
if self.needCount and self.needCount>0 then
local color=num>=self.needCount and FONT_COLOR.eNomalColor or FONT_COLOR.eRedColor
num=FMT.fmt("{0}/{1}",FMT.cfmt(color,num),self.needCount)
end
if self.expireCount and self.expireCount>0 then
self.num:setText(FMT.fmt('{0}{1}<color=#c82c2c>(已过期:{2})</color>',FMT.cfmt(FONT_COLOR.eOrangeDescColor,'数量:'),num,self.expireCount))
else
self.num:setText(FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eOrangeDescColor,'数量:'),num))
end

end

function UICommonMoneyGainWin:showQuickWin()
self.parentWin:moveRoot(-190,0.5)
self.root:setChildDOLocalMoveX(-190,0.5)


local func=function(...)
if _this==nil then return end
_this:onQuickUseWinShowBack(...)
end
local close=function()
self.parentWin:showCloseBtn(true)
self.parentWin:moveRoot(0,0.5)
self.root:setChildDOLocalMoveX(0,0.5)
self.attachWin=nil
end
local args={itemId=self.goodId,showBack=func,closeBack=close,
parentWin=self.parentWin,needCount=self.needCount}
self:showAttachWindow('UIQuickUseWin',args)
end

function UICommonMoneyGainWin:showQuickBuyWin(info)
local showfunc=function(...)
if self==nil or self.isClose then return end
self:onQuickBuyWinShowBack(...)
end
local closefunc=function()
if self==nil or self.isClose then return end
self.parentWin:showCloseBtn(true)
self.parentWin:moveRoot(0,0.5)
self.root:setChildDOLocalMoveX(0,0.5)
UIManager:closeWindow('UIQuickBuyWin')
self.attachWin=nil
end

if not info then
if self.quickBuyInfo then
info=self.quickBuyInfo
else
return closefunc()
end
end

local buyParam=info.buy
self.parentWin:moveRoot(-190,0.5)
self.root:setChildDOLocalMoveX(-190,0.5)
local args=self:getBuyWinArgs(buyParam)
args.gray=self:isGray(info)
args.showCallback=showfunc
args.parentWin=self.parentWin
args.closeCallback=closefunc
self:showAttachWindow('UIQuickBuyWin',args)
end

function UICommonMoneyGainWin:showQuickHeChengWin(info,itemIndex)
local widget=self.gainScrollerView:getChildScrollViewItemWidget(itemIndex-1)
local isSelect=false
if not UIManager:isActive("UIQuickHeChengWin")then

isSelect=true
local heChengParam=info.hecheng
self.parentWin:moveRoot(-190,0.5)
self.root:setChildDOLocalMoveX(-190,0.5)
local showfunc=function(...)
if self==nil or self.isClose then return end
self:onQuickHeChengWinShowBack(...)
end
local closefunc=function()
if self==nil or self.isClose then return end
self.parentWin:showCloseBtn(true)
self.parentWin:moveRoot(0,0.5)
self.root:setChildDOLocalMoveX(0,0.5)
UIManager:closeWindow('UIQuickHeChengWin')
if widget then
widget:SetChildActive(gainItemCmpIndex.selectBg,false)
end
self.attachWin=nil
end
local args={}
args.itemId=self.goodId
if self.needCount then
local itemHasCount=0
if moneyConfig.isMoney(self.goodId)then
itemHasCount=moneyModel.getMoney(self.goodId)
else
itemHasCount=bagControl.invokeFuncByItemId(self.goodId,'getItemCountByItemID',self.goodId)
end
args.needCount=self.needCount-itemHasCount
if args.needCount<=0 then
args.needCount=nil
end
end
args.heChengParam=heChengParam
args.showCallback=showfunc
args.parentWin=self.parentWin
args.closeCallback=closefunc
self:showAttachWindow('UIQuickHeChengWin',args)
else

UIManager:invokeUIMethod("UIQuickHeChengWin","onCloseBtn")
end
widget:SetChildActive(gainItemCmpIndex.selectBg,isSelect)
end

function UICommonMoneyGainWin:showQuickShopBuyWin(info,itemIndex)
local widget=self.gainScrollerView:getChildScrollViewItemWidget(itemIndex-1)
local isSelect=false
if not UIManager:isActive("UIQuickShopBuyWin")then

isSelect=true
local shopBuyParam=info.shopBuy
self.parentWin:moveRoot(-190,0.5)
self.root:setChildDOLocalMoveX(-190,0.5)
local showfunc=function(...)
if self==nil or self.isClose then return end
self:onQuickShopBuyWinShowBack(...)
end
local closefunc=function()
if self==nil or self.isClose then return end
self.parentWin:showCloseBtn(true)
self.parentWin:moveRoot(0,0.5)
self.root:setChildDOLocalMoveX(0,0.5)
UIManager:closeWindow('UIQuickShopBuyWin')
if widget then
widget:SetChildActive(gainItemCmpIndex.selectBg,false)
end
self.attachWin=nil
end
local args={}
args.shopId=shopBuyParam.shopId
args.itemId=self.goodId
args.showCallback=showfunc
args.parentWin=self.parentWin
args.closeCallback=closefunc
self:showAttachWindow('UIQuickShopBuyWin',args)
else

UIManager:invokeUIMethod("UIQuickShopBuyWin","onCloseBtn")
end
widget:SetChildActive(gainItemCmpIndex.selectBg,isSelect)
end

function UICommonMoneyGainWin:showAttachWindow(name,argstable)
if self.attachWin and name~=self.attachWin then
UIManager:closeWindow(self.attachWin)
end
self:showWindow(name,argstable)
self.attachWin=name
end

function UICommonMoneyGainWin:setRootLPosX(xpos)
local pos=self.root:getChildLocalPosition()
pos.x=xpos
self.root:setChildLocalPosition(pos)
end

function UICommonMoneyGainWin:onQuickUseWinShowBack(win)
local wincfg1=UIManager.get_window_config('UICommonMoneyGainWin')
local canvasIdx1=wincfg1.canvas
local wincfg2=UIManager.get_window_config('UIQuickUseWin')
local canvasIdx2=wincfg2.canvas
if canvasIdx1~=canvasIdx2 then
self.parentWin:setCanvasIndex(-1,canvasIdx2)
self:setCanvasIndex(-1,canvasIdx2)
end

local win2=UIManager:findActiveWindow('UIFabaoWin')
local win3=UIManager:findActiveWindow('UITipsWin')
if win2 and win3 then
local pos=win:getChildCanvas(-1)
self.parentWin:resetRootCanves(pos[1],pos[2]+2)
self:setChildCanvas(-1,pos[1],pos[2]+3)
win:setChildCanvas(-1,pos[1],pos[2]+1)
win3:setChildCanvas(-1,pos[1],pos[2])
else
local pos=win:getChildCanvas(-1)
self.parentWin:resetRootCanves(pos[1],pos[2]+2)
self:setChildCanvas(-1,pos[1],pos[2]+3)
win:setChildCanvas(-1,pos[1],pos[2]+1)
end
end

function UICommonMoneyGainWin:onQuickBuyWinShowBack(win)
local wincfg1=UIManager.get_window_config('UICommonMoneyGainWin')
local canvasIdx1=wincfg1.canvas
local wincfg2=UIManager.get_window_config('UIQuickBuyWin')
local canvasIdx2=wincfg2.canvas
if canvasIdx1~=canvasIdx2 then
self.parentWin:setCanvasIndex(-1,canvasIdx2)
self:setCanvasIndex(-1,canvasIdx2)
end
local pos=win:getChildCanvas(-1)
self.parentWin:resetRootCanves(pos[1],pos[2]+2)
self:setChildCanvas(-1,pos[1],pos[2]+3)
win:setChildCanvas(-1,pos[1],pos[2]+1)
end

function UICommonMoneyGainWin:onQuickHeChengWinShowBack(win)
local wincfg1=UIManager.get_window_config('UICommonMoneyGainWin')
local canvasIdx1=wincfg1.canvas
local wincfg2=UIManager.get_window_config('UIQuickHeChengWin')
local canvasIdx2=wincfg2.canvas
if canvasIdx1~=canvasIdx2 then
self.parentWin:setCanvasIndex(-1,canvasIdx2)
self:setCanvasIndex(-1,canvasIdx2)
end
local pos=win:getChildCanvas(-1)
self.parentWin:resetRootCanves(pos[1],pos[2]+2)
self:setChildCanvas(-1,pos[1],pos[2]+3)
win:setChildCanvas(-1,pos[1],pos[2]+1)
end

function UICommonMoneyGainWin:onQuickShopBuyWinShowBack(win)
local wincfg1=UIManager.get_window_config('UICommonMoneyGainWin')
local canvasIdx1=wincfg1.canvas
local wincfg2=UIManager.get_window_config('UIQuickShopBuyWin')
local canvasIdx2=wincfg2.canvas
if canvasIdx1~=canvasIdx2 then
self.parentWin:setCanvasIndex(-1,canvasIdx2)
self:setCanvasIndex(-1,canvasIdx2)
end
local pos=win:getChildCanvas(-1)
self.parentWin:resetRootCanves(pos[1],pos[2]+2)
self:setChildCanvas(-1,pos[1],pos[2]+3)
win:setChildCanvas(-1,pos[1],pos[2]+1)
end

function UICommonMoneyGainWin:getBuyWinArgs(buyParam)
local typo=buyParam.typo
local info=_quickBuyfunc[typo]
if info and info.args then
return info.args(self,buyParam)
end
return{}
end

function UICommonMoneyGainWin:isGray(v)
local buyParam=v.buy
if buyParam then
local typo=buyParam.typo
local info=_quickBuyfunc[typo]
if info and info.gray then
return info.gray(self,buyParam)
end
end
local gray=v.gray
if gray then
local typo=gray.typo
local func=_grayfunc[typo]
if func then
return func(self,gray)
end
end
return false
end

function UICommonMoneyGainWin:getIconInfo(v)
local buyParam=v.buy
if buyParam and buyParam.icon then
local typo=buyParam.typo
local info=_quickBuyfunc[typo]
if info and info.icon then
return info.icon(self,buyParam)
end
end
return nil
end

function UICommonMoneyGainWin:getCommonIconArgs(param)
if param==nil then return end
local id=param[1]
local abname,assetname=iconHelper.getIconInfo(id)
local sizeX=param[2]
local sizeY=param[3]
local size
if sizeX and sizeY then
size={sizeY,sizeY}
end
return{{abname,assetname},size}
end

function UICommonMoneyGainWin:onValueChanged()












end

function UICommonMoneyGainWin:activeArrow(flag)
if self.arrowFlag==flag then return end
self.arrowFlag=flag
self.arrow:setActive(flag)
end

function UICommonMoneyGainWin:checkCountDown()
if itemsConfig.isMoney(self.goodId)then
local check,buidId=moneyAutoIncreaseModel:checkBuilding(self.goodId)
self:stopCountDown()
if check then
self:startCountDown()
self:updateCountDown()
end
end
self.winlua:ForceLayoutRect(self.adaptation:getID())
end

function UICommonMoneyGainWin:updateCountDown()
if moneyAutoIncreaseModel:isNotMax(self.goodId)then
local strFunc=_cdSpecialStr[self.goodId]
local cdStr=strFunc and strFunc(self.goodId,self.goodName)or self:getNormalCDStr()
self.cdTx:setText(cdStr)
else
local text=FMT.fmt("({0}已达上限)",self.goodName)
if self.goodId==eMoneyType.mtLunHuiDian then
local num=moneyModel.getMoney(eMoneyType.mtHunPo)
local num1=moneyModel.getMoney(eMoneyType.mtLunHuiDian)
if num==0 and num1==0 then
text=''
end
end

self.cdTx:setText(text)
self:stopCountDown()
end
self.winlua:ForceLayoutRect(self.adaptation:getID())
end

function UICommonMoneyGainWin:startCountDown()
if moneyAutoIncreaseModel:isNotMax(self.goodId)then
local strFunc=_cdSpecialStr[self.goodId]
local cdStr=strFunc and strFunc(self.goodId,self.goodName)or self:getNormalCDStr()
self.cdTx:setText(cdStr)
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCountDown()
end)
end
else
local text=FMT.fmt("({0}已达上限)",self.goodName)
if self.goodId==eMoneyType.mtLunHuiDian then
local num=moneyModel.getMoney(eMoneyType.mtHunPo)
local num1=moneyModel.getMoney(eMoneyType.mtLunHuiDian)
if num==0 and num1==0 then
text=''
end
end
self.cdTx:setText(text)
end
end

function UICommonMoneyGainWin:getNormalCDStr()
local least=moneyAutoIncreaseModel:getLeastTime(self.goodId)
least=math.max(least,0)
local param1=timeHelper.format_time_stamp(least,true)
local param2=moneyAutoIncreaseModel:ccdNum(self.goodId)
param2=math.floor(param2)
local param3=self.goodName
return FMT.fmt("(<color=#29ad0f>{0}</color>后获得{1}{2})",param1,param2,param3)
end

function UICommonMoneyGainWin:stopCountDown()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UICommonMoneyGainWin.onMoneyChanged(mType,oldValue,newValue)
if _this and mType==_this.goodId then
_this:checkCountDown()
_this:refreshGoodNum(newValue)
end
end

function UICommonMoneyGainWin.onItemChanged(changeType,_itemguid,lastitemid,lastcount,_itemcount)
if _this and lastitemid==_this.goodId then
_this:refreshGoodNum(_itemcount)
end
end

function UICommonMoneyGainWin.onCommonShopData(shopType)
if _this then

_this:refreshGainList()
end
end

function UICommonMoneyGainWin:onCloseClick()
self.parentWin:onCloseClick()
end
