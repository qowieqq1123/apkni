







def_class("UIXingChenRongHeSelect2Win",UIWindowBase)









function UIXingChenRongHeSelect2Win:bindComponents()

self.BagList=UILoopListView.new(self,0)
self.closeBg=UIButton.get(self,1)
self.emptyRoot=UIObject.get(self,2)
self.gainScrollerView=UIObject.get(self,3)
self.posText=UIText.get(self,4)
self.title=UIText.get(self,5)

self.BagList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)

self:onStartAction(...)
end)
self.closeBg:setButtonClick(function()
self:onCloseBg()
end)



end


function UIXingChenRongHeSelect2Win:unbindComponents()
local _UIObject_release=UIObject.release
self.BagList:deleteSelf();
self.BagList=nil;
_UIObject_release(self.closeBg);
self.closeBg=nil;
_UIObject_release(self.emptyRoot);
self.emptyRoot=nil;
_UIObject_release(self.gainScrollerView);
self.gainScrollerView=nil;
_UIObject_release(self.posText);
self.posText=nil;
_UIObject_release(self.title);
self.title=nil;
end


















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

function UIXingChenRongHeSelect2Win:onLoaded(...)
self:bindComponents()

self.sortOrder=ITEM_SORT_COMPARE_TYPE.eUpOrder
end


function UIXingChenRongHeSelect2Win:__delete()
self:unbindComponents()
end




function UIXingChenRongHeSelect2Win:onShow(argtable,afterOnloaded)
local isLeft=argtable.isLeft
self.selectMainItem=argtable.selectMainItem
self.selectChildItem=argtable.selectChildItem
self.callback=argtable.callback
self.isLeft=isLeft
self.pos=argtable.pos
self.title:setText(self.isLeft and"选择主星辰"or"选择副星辰")
self.posText:setText(cfgHelper.get(cfg_starsbasicconfig_get,1,"pos")[self.pos])
self:refreshBag()
end


function UIXingChenRongHeSelect2Win:onHide()

end

function UIXingChenRongHeSelect2Win:onCloseBg()
self:closeSelf()
end

function UIXingChenRongHeSelect2Win:refreshBag()


self.filter=self.filter or{}
self.filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eEquals,{eQualityColor.eRed}}

local bagList=xingChenHelper.sortEquip(self.pos,nil,nil,self.filter)

table.sort(bagList,function(a,b)
return a.itemData.star>b.itemData.star
end)


if xingChenBagModel.equipsLookup[self.pos]then
if itemsConfig.getItemColor(xingChenBagModel.equipsLookup[self.pos].itemid)==eQualityColor.eRed then
table.insert(bagList,1,xingChenBagModel.equipsLookup[self.pos])
end
end




self.itemsList=bagList

local jump=1
local select=self.isLeft and self.selectMainItem or self.selectChildItem
if select then
local selectGuid=tostring(select.itemguid)
for i,v in ipairs(bagList)do
if tostring(v.itemguid)==selectGuid then
jump=i
end
end
end

self.emptyRoot:setActive(#bagList==0)
if#bagList>0 then
self.BagList:initData('equipItem',bagList)
self.selectIdx=jump
self.BagList:jumpItem(jump)
else
local itemIdCfg=cfgHelper.get(cfg_starsbasicconfig_get,1,"empty_item_jump")
local itemid=itemIdCfg[self.pos]
local config=itemsConfig.getConfig(itemid)
local produce=config.produce
local showList=gainControl:getGainSortList(produce,itemid)
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

end

function UIXingChenRongHeSelect2Win:getIconInfo(v)
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

function UIXingChenRongHeSelect2Win:getCommonIconArgs(param)
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

function UIXingChenRongHeSelect2Win:isGray(v)
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

function UIXingChenRongHeSelect2Win:onFreshAction(index,grid)
self:bindGrid(index,grid)
end

function UIXingChenRongHeSelect2Win:onStartAction()

end

function UIXingChenRongHeSelect2Win:bindGrid(index,grid)
local item=self.itemsList[index]
if item then
local itemid=item.itemid
local itemguidStr=tostring(item.itemguid)
local config=itemsConfig.getConfig(itemid)
local prop={}
local colorPage=config.colorPage or 0
local itemColor=colorPage*100+config.color
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconHelper.getIconName(itemid)
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=itemColor
prop[PropIndex(DataPropKey.eWidgetText,3)]=xingChenHelper.getXingChenName(item)

grid:SetChildPropData(-1,prop)

xingChenHelper.setStarFlag(grid:GetChildWidgetBase(9),xingChenHelper.getStarLevel(item),true)

grid:SetChildActive(13,(self.selectMainItem and itemguidStr==tostring(self.selectMainItem.itemguid)))
grid:SetChildActive(14,(self.selectChildItem and itemguidStr==tostring(self.selectChildItem.itemguid)))
grid:SetChildActive(12,xingChenBagModel:getEquip(item.itemguid)~=nil)

local affixList=xingChenHelper.getAffixList(item)

local num=#affixList

if num>2 then
grid:SetChildActive(11,false)
grid:SetChildText(4,FMT.fmt("词缀数量：{0}",num))
else
grid:SetChildActive(11,true)
grid:SetChildText(4,"")
grid:SetChildLayoutGroupCreateItems(11,num)
local cGrids=grid:GetChildLayoutGroupGridList(11)
if#affixList>0 then
for i=1,cGrids.Count do
local cGrid=cGrids[i-1]
local affix=affixList[i]
if affix then
local aConfig=cfgHelper.get(cfg_starsaffixconfig_get,affix)
local ab,frame=xingChenHelper.getAffixColorFrame(aConfig.color)
local name=xingChenHelper.getAffixNameStr(aConfig.name)
cGrid:SetChildText(1,name)
cGrid:SetChildCSImageSprite(0,ab,frame)
cGrid:SetChildButtonClick(0,function()
self:showWindow("UILittleWorldAffixWin",{item=grid,node='bottom',config=aConfig})
end)
end
cGrid:SetChildActive(4,affix~=nil)
cGrid:SetChildActive(5,affix==nil)
end
end
end

grid:SetBaseItemClickEvent(-1,function(...)
if self.selectIdx then
local pItem=self.BagList:getListViewItemWidgetByDataIndex(self.selectIdx)
if pItem then
pItem:SetChildActive(5,false)
end
end

self.selectIdx=index
self.selectGuid=item.itemguid
grid:SetChildActive(5,true)

self:openSelectMode(item,grid)
end)

end

grid:SetChildActive(5,self.selectIdx==index)

end

function UIXingChenRongHeSelect2Win:openSelectMode(item)
local args={}
args.equip=item
args.selectMainItem=self.selectMainItem
args.selectChildItem=self.selectChildItem
args.isLeft=self.isLeft
args.callback=function(...)
self:refreshSelect(...)
if self.callback then
self.callback(...)
end
end
self:showWindow("UIXingChenRongHePutWin",args)
end

function UIXingChenRongHeSelect2Win:refreshSelect(selectMainItem,selectChildItem)
self.selectMainItem=selectMainItem
self.selectChildItem=selectChildItem
local startIndex,endIndex=self.BagList:getVisableIndex()
for i=startIndex,endIndex do
local grid=self.BagList:getListViewItemWidgetByDataIndex(i)
if grid then
local item=self.itemsList[i]
local itemguidStr=tostring(item.itemguid)
grid:SetChildActive(13,(self.selectMainItem and itemguidStr==tostring(self.selectMainItem.itemguid)))
grid:SetChildActive(14,(self.selectChildItem and itemguidStr==tostring(self.selectChildItem.itemguid)))
end
end
end


