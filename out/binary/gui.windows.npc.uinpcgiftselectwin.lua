







def_class("UINPCGiftSelectWin",UIWindowBase)









function UINPCGiftSelectWin:bindComponents()

self.pageBtnsGrid=UIObject.get(self,0)
self.selfScrollView=UIScrollViewSlow.get(self,1)
self.exchangeBtn=UIButton.get(self,2)
self.giftNumTxt=UIText.get(self,3)
self.root=UIObject.get(self,4)

self.exchangeBtn:setButtonClick(function()self:onExchangeBtn()end)



end


function UINPCGiftSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pageBtnsGrid);self.pageBtnsGrid=nil;
_UIObject_release(self.selfScrollView);self.selfScrollView=nil;
_UIObject_release(self.exchangeBtn);self.exchangeBtn=nil;
_UIObject_release(self.giftNumTxt);self.giftNumTxt=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _selfColomn=4
local _creatGirdPrecent=100

local _selfItemsList={}
local _selfItemsLookup={}
local _selfSelectLookup={}
local _selfSelectList={}

local pageType={
eItem=1,
eCaiLiao=2,
eEquip=3,
eElse=4,
}


local pageConfig=
{
[pageType.eItem]={
name='道具',
bagTypes={BAG_TYPE.eItemBag},
check=function(item)
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local pass=true
local type1=itemConfig.type1
if type1~=nil then
pass=type1~=4
end
return pass
end
},
[pageType.eCaiLiao]={
name='材料',
bagTypes={BAG_TYPE.eMaterialsBag},
check=function(item)
return true
end
},
[pageType.eEquip]={
name='装备',
bagTypes={BAG_TYPE.eEquipBag},
check=function(item)
return not bagHelper.isLock(item)
end
},
[pageType.eElse]={
name='其它',
bagTypes={BAG_TYPE.eItemBag},
check=function(item)
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local pass=false
local type1=itemConfig.type1
if type1~=nil then
pass=type1==4
end
return pass
end
},
}
local _this=nil


function UINPCGiftSelectWin:onLoaded(...)
_this=self
self:bindComponents()

self.selfScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindSelfGrid(...)
end
end)
self.pageTypeList={pageType.eItem,pageType.eCaiLiao,pageType.eEquip,pageType.eElse}
end


function UINPCGiftSelectWin:__delete()
_this=nil
self:unbindComponents()

_selfItemsList={}
_selfItemsLookup={}
_selfSelectLookup={}
_selfSelectList={}


UIManager:invokeUIMethod('UINPCInteractWin','onCloseGiftSelect')
end


function UINPCGiftSelectWin:onHide()

end




function UINPCGiftSelectWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.m_cav=self:getChildCanvas(-1)
end
self.selectChangeFunc=argtable.selectChangeFunc
self.npcid=argtable.npcid

self.maxGiftHGD=npcController:getInteractMaxNum(NPC_INTERACT_TYPE.eGift,self.npcid)
self:initNPCLikeLookup()
self.selectPageType=pageType.eItem
self:initPageBtns()
self:freshSelfBagEx()
self:refreshSelectNum()

self:doMyAnim(true,nil)
end

function UINPCGiftSelectWin:freshSelfBagEx()
_selfSelectLookup={}
_selfSelectList={}
self:freshSelfBag()
end

function UINPCGiftSelectWin:initNPCLikeLookup()
local npcid=self.npcid
self.npcLikeLookup=npcModel:getNPCLikeItems(npcid)or{}
end


function UINPCGiftSelectWin:getCustomerLikeItemVal(itemid)
local lookup=self.npcLikeLookup
local val=lookup[itemid]
if val~=nil then
return val
end
return nil
end

function UINPCGiftSelectWin:onPageClick(pageType)
if self.selectPageType==pageType then return end
local old=self.selectPageType
if old~=nil then
local olditem=self.pageBtnsGrid:getChildLayoutGroupGridItem(old-1)
self:changePageSelect(olditem,false)
end
local item=self.pageBtnsGrid:getChildLayoutGroupGridItem(pageType-1)
self:changePageSelect(item,true)
self.selectPageType=pageType

self:freshSelfBag()
end

function UINPCGiftSelectWin:getPageItemsList()
local itemsList={}
local pcfg=pageConfig[self.selectPageType]
local bagTypes=pcfg.bagTypes
for i,bagType in ipairs(bagTypes)do
local list=bagControl.getBagItems(bagType)
for i2,v in ipairs(list)do
if pcfg.check(v)then
table.insert(itemsList,v)
end
end
end
return itemsList
end

function UINPCGiftSelectWin:initPageBtns()
local func=function(index)
local item=self.pageBtnsGrid:getChildLayoutGroupGridItem(index-1)
self:refreshPageBtn(item,index)
end
self.pageBtnsGrid:setChildLayoutGroupCreateItems(#self.pageTypeList,func)
end

function UINPCGiftSelectWin:refreshPageBtn(item,index)
local pageType=self.pageTypeList[index]
local pcfg=pageConfig[pageType]
item:SetChildButtonClick(0,function()
self:onPageClick(pageType)
end)
local isSelect=pageType==self.selectPageType
self:changePageSelect(item,isSelect)

item:SetChildText(1,pcfg.name)
end

function UINPCGiftSelectWin:changePageSelect(item,isSelect)
local iconname=isSelect and'button_zengsongwp_2'or'button_zengsongwp_1'
item:SetChildCSImageSprite(0,globalABLookup.npcIcons,iconname)
end

function UINPCGiftSelectWin:freshSelfBag()
self.curPageIndex=1
_selfItemsList={}
_selfItemsLookup={}
self.selfScrollView:clearSlowItems()

local itemsList=self:getPageItemsList()
for i,v in ipairs(itemsList)do
local itemid=v.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local hideWorth=itemConfig.hideWorth
local show=hideWorth~=nil and hideWorth>0
if show then
local itemguidStr=tostring(v.itemguid)
local itemcount=v.itemcount

if _selfSelectLookup[itemguidStr]~=nil then
itemcount=itemcount-_selfSelectLookup[itemguidStr].count
end

local color=itemConfig.color or 0
local stage=itemConfig.stage or 0
local weight=(10-color)*100+(10-stage)

local love=self:getCustomerLikeItemVal(itemid)
if love and love>0 then
weight=weight+1000
end
local jinglianlv=0
if itemsConfig.isEquip(itemid)then
local equip=equipsHelper.getEquip(v.itemguid)
jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
end
if jinglianlv and jinglianlv>0 then
weight=weight-2000
end
table.insert(_selfItemsList,{itemid=itemid,itemguid=v.itemguid,itemcount=itemcount,
weight=weight,itemguidStr=itemguidStr,love=love,jinglianlv=jinglianlv})
end
end
local itemsLen=#_selfItemsList
if itemsLen>1 then
table.sort(_selfItemsList,function(a,b)
return a.weight>b.weight
end)
end
if itemsLen>0 then
for i,itemInfo in ipairs(_selfItemsList)do
_selfItemsLookup[itemInfo.itemguidStr]=i
end
end

local curPageIndex=self.curPageIndex
local tNum=curPageIndex*_creatGirdPrecent
tNum=math.min(tNum,itemsLen)
local row=math.ceil(tNum/_selfColomn)+7
tNum=(row+7)*_selfColomn
local row=math.ceil(tNum/_selfColomn)

self.selfScrollView:freshSlowGrids(tNum,row,_selfColomn,true)
end

function UINPCGiftSelectWin:bindSelfGrid(index,item)
local itemInfo=_selfItemsList[index]
local isTemp=itemInfo==nil
local conf
if not isTemp then
local itemid=itemInfo.itemid
local count=itemInfo.itemcount
conf={itemid=itemid,count=count,itemguid=itemInfo.itemguid,love=itemInfo.love,itemguidStr=itemInfo.itemguidStr,jinglianlv=itemInfo.jinglianlv}
end
self:setItemData(index,item,conf,isTemp)
end

function UINPCGiftSelectWin:onSelfItemClick(itemid,index,guid,attach)
if itemid<=0 then return end
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig then
local bagIdx=index
local itemInfo=_selfItemsList[bagIdx]
local itemguidStr=itemInfo.itemguidStr
local selectInfo=_selfSelectLookup[itemguidStr]

if itemInfo.jinglianlv and itemInfo.jinglianlv>0 then
UIManager.info("精练过的装备无法作为礼物")
return
end

if itemInfo.love~=nil and itemInfo.love<0 then
UIManager.info(FMT.fmt('{0}讨厌该物品，拒绝接收',npcModel:getNPCName(self.npcid)))
return
end

local selectHGD=self:getSelectHGD()
local useHGD=npcModel:getNPCInteractTypeNum(self.npcid,NPC_INTERACT_TYPE.eGift)
local lerp=math.max(0,self.maxGiftHGD-useHGD-selectHGD)

local maxCount=0
local rate=npcModel:getNPCGiftRate(self.npcid)
local likeItem=self:getCustomerLikeItemVal(itemid)
local hideWorth=itemConfig.hideWorth
if likeItem~=nil and likeItem>0 then
local value=likeItem*rate
maxCount=math.ceil(lerp/value)
elseif hideWorth then
local value=hideWorth*rate
maxCount=math.ceil(lerp/value)
end
maxCount=math.min(maxCount,itemInfo.itemcount)

local count=selectInfo and selectInfo.count or 0
maxCount=maxCount+count

if maxCount>1 then
local attach_={}
local selectNumCmpArgs={numFormat='数量：<color=#f1ce78>{0}/{1}</color>',
min=0,max=maxCount,val=count}
attach_.selectNumCmpArgs=selectNumCmpArgs
attach_.tipsCommonUseItemCB=function(attach__)
if _this==nil then return end
local num=attach__.selectNumCmpArgs and attach__.selectNumCmpArgs.selectNum or 1
self:onCustomerItemClick_use(itemid,index,guid,num)
end
attach_.insertBtnList={TIPS_BTNS_TYPE.eCommonUseItem}
tipsManager.showTips({itemid=itemid,itemguid=nil,attach=attach_})
else
if maxCount<1 then
UIManager.info("仙友表示不能再接受更多礼物")
return
end
self:onCustomerItemClick_use(itemid,index,guid,1)
end
else
loggerUtil.logErrFMT('没有找到此道具：',itemid)
end
end


function UINPCGiftSelectWin:onCustomerItemClick_use(itemid,index,guid,num)
local bagIdx=index
local itemInfo=_selfItemsList[bagIdx]
local itemguidStr=itemInfo.itemguidStr
local selectInfo=_selfSelectLookup[itemguidStr]
local count=selectInfo and selectInfo.count or 0
itemInfo.itemcount=itemInfo.itemcount+count-num

local exchangIdx
if selectInfo~=nil then
for i,v in ipairs(_selfSelectList)do
if v.itemguidStr==itemguidStr then
exchangIdx=i
break
end
end
selectInfo.count=num
else
exchangIdx=#_selfSelectList+1
selectInfo={itemid=itemid,count=num,itemguid=guid,itemguidStr=itemguidStr,love=itemInfo.love}
_selfSelectLookup[itemguidStr]=selectInfo
_selfSelectList[exchangIdx]=selectInfo
end

self.selfScrollView:freshSlowItem(bagIdx-1)

self:refreshSelectNum(true)
end

function UINPCGiftSelectWin:onItemLongClick(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end

function UINPCGiftSelectWin:onSelfItemSubClick(itemid,index,guid,attach)
if itemid<=0 then return end

local itemguidStr=tostring(guid)
local itemInfo=_selfSelectLookup[itemguidStr]
if itemInfo==nil then return end
itemInfo.count=itemInfo.count-1
if itemInfo.count<=0 then
_selfSelectLookup[itemguidStr]=nil
local c=#_selfSelectList
for i,v in ipairs(_selfSelectList)do
if v.itemguidStr==itemguidStr then
table.remove(_selfSelectList,i)
break
end
end
end

local bagIdx=_selfItemsLookup[itemguidStr]
if bagIdx~=nil then
local batItemInfo=_selfItemsList[bagIdx]
batItemInfo.itemcount=batItemInfo.itemcount+1
self.selfScrollView:freshSlowItem(bagIdx-1)
end

self:refreshSelectNum(true)
end

function UINPCGiftSelectWin:setItemData(index,item,conf,clear)
local has=false
local itemid
local itemguid
if conf then
has=true

itemid=conf.itemid
itemguid=conf.itemguid or-1
local itemguidStr=conf.itemguidStr
local showJinglianlv=conf.jinglianlv and conf.jinglianlv>0
local count=showJinglianlv and conf.jinglianlv or conf.count
local s_count=0
if _selfSelectLookup[itemguidStr]~=nil then
s_count=_selfSelectLookup[itemguidStr].count
end
local showCount=count+s_count>1
local countStr=showCount and count or''
if s_count>0 then
countStr=FMT.fmt('{0}/{1}',count+s_count,s_count)
else
countStr=showCount and count or''
end
countStr=showCount and(showJinglianlv and string.format("+%s",count)or countStr)or countStr
local showlock=false
local grayNum=0
if count<=0 then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
elseif showJinglianlv then
showlock=false
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
elseif conf.love~=nil and conf.love<0 then
showlock=true
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
end
item:SetChildActive(5,showlock)

local showlove=conf.love~=nil and conf.love>0
item:SetChildActive(3,showlove)

item:SetChildActive(4,s_count>0)

local showStage=itemsConfig.isEquip(itemid)

local prop_conf={itemid=itemid,itemguid=itemguid,itemcount=countStr,showCountBG=showCount,
showStage=showStage,gray=grayNum,showname=false,itemIndex=index}
local prop=itemsComponentHelper.getCommonFillDataSmall(prop_conf)
item:SetChildActive(2,true)
item:SetChildPropData(1,prop)

item:SetChildActive(0,false)

local suitIconName=equipsHelper.getSuitIconByArgs(itemguid,itemid)
item:SetChildIcon(6,suitIconName,false)
elseif clear then
item:SetChildActive(2,false)
item:SetChildActive(3,false)
item:SetChildActive(4,false)
item:SetChildActive(5,false)

item:SetChildActive(0,true)
item:SetChildIcon(6,'',false)
end
if has then
item:SetChildButtonClick(2,function(...)
self:onSelfItemClick(itemid,index,itemguid,nil)
end)
item:SetChildLongTouch(2,index,0.5,function(...)
self:onItemLongClick(itemid,index,itemguid,nil)
end)
item:SetChildButtonClick(4,function(...)
self:onSelfItemSubClick(itemid,index,itemguid,nil)
end)
end
end

function UINPCGiftSelectWin:getSelectHGD()
local value=0
for i,v in ipairs(_selfSelectList)do
local itemid=v.itemid
local count=v.count
local itemConfig=itemsConfig.getConfig(itemid)
local likeItem=self:getCustomerLikeItemVal(itemid)
local hideWorth=itemConfig.hideWorth
if likeItem~=nil and likeItem>0 then
value=value+likeItem*count
elseif hideWorth then
value=value+hideWorth*count
end
end
local rate=npcModel:getNPCGiftRate(self.npcid)
value=value*rate
value=math.floor(value)
return value
end

function UINPCGiftSelectWin:onEdgeEvent()

end

function UINPCGiftSelectWin:refreshSelectNum(change)
local hgd=self:getSelectHGD()
self.selectHGD=hgd
local useHGD=npcModel:getNPCInteractTypeNum(self.npcid,NPC_INTERACT_TYPE.eGift)
local lerp=self.maxGiftHGD-useHGD
if lerp<0 then lerp=0 end
self.lerpHGD=lerp
local numstr=FMT.fmt('今日可提升亲密度：{0}',lerp)
self.giftNumTxt:setText(numstr)

if change then
if self.selectChangeFunc then
local addhgd
if self.selectHGD>=self.lerpHGD then
addhgd=self.lerpHGD
else
addhgd=self.selectHGD
end
self.selectChangeFunc(_selfSelectList,addhgd)
end
end
end

function UINPCGiftSelectWin:getTalkCanvas()
return{self.m_cav[1],self.m_cav[2]+1}
end

function UINPCGiftSelectWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<1 then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end

function UINPCGiftSelectWin:onExchangeBtn()
if not self:checkClickLock()then
return
end
if#_selfSelectList<=0 then
UIManager.info('请选择要赠予的物品')
return
end
local npcid=self.npcid
local interacttype=NPC_INTERACT_TYPE.eGift

if self.lerpHGD<=0 then

local talk=npcModel:getNPCEnoughGiftTalk(npcid)
local cav=self:getTalkCanvas()
npcController:worldInteractNPCTalk(talk,3,cav)
return
end

local list={}
local list2={}
for i,v in ipairs(_selfSelectList)do
if v.count>0 then
local d={v.itemguid,v.count}
table.insert(list,d)
local d2={v.itemid,v.count}
table.insert(list2,d2)
end
end

if#list<=0 then
UIManager.info('请选择要赠予的物品')
return
end
local otherData={}
otherData.interacttype=interacttype
otherData.list=list

local desc_str=FMT.fmt('确认将以下物品赠与<{0}>吗？',npcModel:getNPCName(npcid))








local args={
title='提示',
desc1=desc_str,
desc2=nil,
rewards=list2,
rewardTitle=-1,
showCancel=true,
cancelName='容我三思',
commitName='确认赠予',
cancelCB=nil,
commitCB=function()
npcController:reqInteract(npcid,otherData)
end,
}
UIManager:showWindow('UIDialougeRewardWin',args)
end

function UINPCGiftSelectWin:onCloseClick()
local callback=function()
if _this==nil then return end
_this:closeSelf()
end
self:doMyAnim(false,callback)
end

function UINPCGiftSelectWin:doMyAnim(flag,callback)
if flag then
self.root:setChildAnchoredPosition(Vector2(-300,-18))
self.root:setChildDOAnchorPosX(293.78,0.25,nil)
else
self.root:setChildDOAnchorPosX(-300,0.25,callback)
end
end



function UINPCGiftSelectWin:rec_gift()
self:freshSelfBagEx()
self:refreshSelectNum()
end

