







def_class("UIXianZhanTransactionWin",UIWindowBase)









function UIXianZhanTransactionWin:bindComponents()

self.speakText=UIText.get(self,0)
self.head=UIObject.get(self,1)
self.tipsBtn=UIButton.get(self,2)
self.giftHanGanDu=UIObject.get(self,3)
self.exchangeBtn=UIButton.get(self,4)
self.baipiaoBtn=UIButton.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.rewardEffect=UIObject.get(self,7)
self.speakObj=UIObject.get(self,8)
self.biaoqingObj=UIObject.get(self,9)
self.biaoqingTxt=UILinkImageText.get(self,10)
self.pageBtnsGrid=UIObject.get(self,11)
self.selfScrollView=UIScrollViewSlow.get(self,12)
self.visitorScrollView=UIScrollViewSlow.get(self,13)
self.visitorBagNameText=UIText.get(self,14)
self.selfExChange=UIScrollViewSlow.get(self,15)
self.visitorExChange=UIScrollViewSlow.get(self,16)
self.visitorName=UIText.get(self,17)
self.itemsPanel=UIObject.get(self,18)
self.exchangeBtnText=UIText.get(self,19)
self.progressTxt=UIText.get(self,20)
self.progressGreen=UIObject.get(self,21)
self.progressValue=UIObject.get(self,22)
self.hgdNameTxt=UIText.get(self,23)
self.visitorNotExChange=UIObject.get(self,24)
self.selfNotExChange=UIObject.get(self,25)
self.giftHanGanDuTxt=UIText.get(self,26)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.exchangeBtn:setButtonClick(function()self:onExchangeBtn()end)

self.baipiaoBtn:setButtonClick(function()self:onBaipiaoBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianZhanTransactionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.giftHanGanDu);self.giftHanGanDu=nil;
_UIObject_release(self.exchangeBtn);self.exchangeBtn=nil;
_UIObject_release(self.baipiaoBtn);self.baipiaoBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rewardEffect);self.rewardEffect=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.biaoqingObj);self.biaoqingObj=nil;
_UIObject_release(self.biaoqingTxt);self.biaoqingTxt=nil;
_UIObject_release(self.pageBtnsGrid);self.pageBtnsGrid=nil;
_UIObject_release(self.selfScrollView);self.selfScrollView=nil;
_UIObject_release(self.visitorScrollView);self.visitorScrollView=nil;
_UIObject_release(self.visitorBagNameText);self.visitorBagNameText=nil;
_UIObject_release(self.selfExChange);self.selfExChange=nil;
_UIObject_release(self.visitorExChange);self.visitorExChange=nil;
_UIObject_release(self.visitorName);self.visitorName=nil;
_UIObject_release(self.itemsPanel);self.itemsPanel=nil;
_UIObject_release(self.exchangeBtnText);self.exchangeBtnText=nil;
_UIObject_release(self.progressTxt);self.progressTxt=nil;
_UIObject_release(self.progressGreen);self.progressGreen=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.hgdNameTxt);self.hgdNameTxt=nil;
_UIObject_release(self.visitorNotExChange);self.visitorNotExChange=nil;
_UIObject_release(self.selfNotExChange);self.selfNotExChange=nil;
_UIObject_release(self.giftHanGanDuTxt);self.giftHanGanDuTxt=nil;
end

















local _selfColomn=5
local _fkColomn=4
local _creatGirdPrecent=100

local maxGoodsCount=99
local showUseTipsCount=1

local _selfExChangeNum=10
local _fkExChangeNum=6

local _selfItemsList={}
local _selfItemsLookup={}
local _selfSelectLookup={}
local _selfSelectList={}

local _fkItemsList={}
local _fkItemsLookup={}
local _fkSelectLookup={}
local _fkSelectList={}

local pageType={
eItem=1,
eCaiLiao=2,
eEquip=3,
eElse=4,
}
local itemOffset={41,-41}


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


function UIXianZhanTransactionWin:onLoaded(...)
_this=self
self:bindComponents()

self.filter={}
self.selfScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindSelfGrid(...)
end
end)
self.visitorScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindCustomerGrid(...)
end
end)

self.selfExChange:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindSelfExChangeGrid(...)
end
end)
self.visitorExChange:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindCustomerExChangeGrid(...)
end
end)
self.pageTypeList={pageType.eItem,pageType.eCaiLiao,pageType.eEquip,pageType.eElse}

notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end


function UIXianZhanTransactionWin:__delete()
_this=nil
_selfItemsList={}
_selfItemsLookup={}
_selfSelectLookup={}
_selfSelectList={}

_fkItemsList={}
_fkItemsLookup={}
_fkSelectLookup={}
_fkSelectList={}
self.rewardEffect:setChildShowEffect(0,false)
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
end

function UIXianZhanTransactionWin.onShowPrize(prizeType,prizelist,effectData)
if _this==nil then return end
if prizeType==ePrizeType.eXianZhanBaiPiao then
_this.bpRewardList=prizelist
end
end




function UIXianZhanTransactionWin:onShow(argtable,afterOnloaded)
self.roomId=argtable
self.data=xianzhanModel:getRoomDataByRoomId(self.roomId)
self.fkConfig=cfgHelper.get1(cfg_xianzhanfangkeconfig_get,self.data.customerId)
self:initFangKeLikeLookup()
self:initFangKeInfo()

self:freshExChangeGrids()
self.selectPageType=pageType.eItem
self:initPageBtns()
self:freshSelfBag()
self:refreshCustomerBag()
self:refreshSpeakText(true)
self:refreshExchangeBtn()
self:refreshFangKeInfo()
self:refreshBaiPiaoBtn(self.data)
end


function UIXianZhanTransactionWin:onHide()

end

function UIXianZhanTransactionWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.2,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end)
end

function UIXianZhanTransactionWin:freshExChangeGrids()
self:freshSelfExChangeGrids()
self:freshFKExChangeGrids()
end

function UIXianZhanTransactionWin:freshSelfExChangeGrids()
_selfSelectLookup={}
_selfSelectList={}
self.selfExChange:clearSlowItems()
self.selfNotExChange:setActive(true)
self.selfExChange:freshSlowGrids(_selfExChangeNum,2,_selfExChangeNum/2,true)
end

function UIXianZhanTransactionWin:freshSelfExChangeGridsEx()
self.selfExChange:freshAllItems()
end

function UIXianZhanTransactionWin:freshFKExChangeGrids()
_fkSelectLookup={}
_fkSelectList={}
self.visitorExChange:clearSlowItems()
self.visitorNotExChange:setActive(true)
self.visitorExChange:freshSlowGrids(_fkExChangeNum,2,_fkExChangeNum/2,true)
end

function UIXianZhanTransactionWin:freshFKExChangeGridsEx()
self.visitorExChange:freshAllItems()
end

function UIXianZhanTransactionWin:refreshSelfNotExhange()
local selfNum=#_selfSelectList
self.selfNotExChange:setActive(selfNum<=0)
end

function UIXianZhanTransactionWin:refreshFKNotExhange()
local fkNum=#_fkSelectList
self.visitorNotExChange:setActive(fkNum<=0)
end


function UIXianZhanTransactionWin:initFangKeInfo()
local fkname=xianzhanModel.getFangKeName(self.fkConfig.id)
self.visitorName:setText(fkname)
local modelParams=xianzhanModel:getCustomerInSideModelInfo(self.fkConfig)
local scale=0.8
self.head:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,eAnimationID.stand,false,true)

self.visitorBagNameText:setText(FMT.fmt('{0}的背包',fkname))

local likeThing=cfgHelper.get2(cfg_xianzhanfangkeconfig_get,self.data.customerId,'likeThing')
local grid=self.itemsPanel:getChildCommonLayoutGroupWidgetList()
local count=grid.Count
for i=1,count do
local item=grid[i-1]
local data=likeThing[i]
local isshow=data~=nil
item:SetChildActive(-1,isshow)
if isshow then
item:SetChildCSImageIcon(0,data[2],false)
end
end
end


function UIXianZhanTransactionWin:refreshFangKeInfo(animation)
local data=xianzhanModel:getRoomDataByRoomId(self.roomId)
local hgd=data.haoGanDu
local lv,rate,cur,max,isFull=npcModel.getHaoGanDuLevel(hgd)
if isFull then
rate=1
end
local hgdname=npcModel.getHaoGanDuName(hgd)
local changehgd=self.changehgd or 0

if animation then
helper.playProgressAnim(self.progressValue,rate,0,nil,nil,nil,2)
else
self.progressValue:setChildIconFillAmount(rate)
end
local showGreen=changehgd>0 and not isFull
self.progressGreen:setActive(showGreen)
if showGreen then
local hgd_g=hgd+changehgd
local lv_g,rate_g,cur_g,max_g=npcModel.getHaoGanDuLevel(hgd_g,false)
if lv_g>lv then
rate_g=1
end

helper.playProgressAnim(self.progressGreen,rate_g,0,nil,nil,nil,0.1)
end
self.hgdNameTxt:setText(hgdname)

local numstr
if not isFull then
if changehgd>0 then
numstr=FMT.fmt('{0}<color=#0ee918>+{1}</color>/{2}',cur,changehgd,max)
else
numstr=FMT.fmt('{0}/{1}',cur,max)
end
else
numstr='已满'
end
self.progressTxt:setText(numstr)
end

function UIXianZhanTransactionWin:refreshExchangeBtn()
local selfLen=#_selfSelectList
local fkLen=#_fkSelectList
local str
local changehgd=0
local showGift=false
if selfLen>0 and fkLen==0 then
str='赠与'
showGift=true
local hgdSongLiAdd=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'hgdSongLiAdd')
local maxGiftHGD=hgdSongLiAdd[2]
local useHGD=self.data.hgdToadyAdd
local selfValue=self:getSelfGoodsValue()
local rate=hgdSongLiAdd[1]
self.selectHGD=selfValue*rate
self.selectHGD=math.floor(self.selectHGD)
local lerp=maxGiftHGD-useHGD
if lerp<0 then lerp=0 end
self.lerpHGD=lerp
local addhgd
if self.selectHGD>=self.lerpHGD then
addhgd=self.lerpHGD
else
addhgd=self.selectHGD
end
changehgd=addhgd
else
str='成交'
end
self.changehgd=changehgd
self.exchangeBtnText:setText(str)
self.giftHanGanDu:setActive(showGift)
if showGift then
local gift_str=FMT.fmt('今日可提升亲密度：{0}',self.lerpHGD)
self.giftHanGanDuTxt:setText(gift_str)
end
end


function UIXianZhanTransactionWin:refreshSpeakText(isfirst)
local selfLen=#_selfSelectList
local fkLen=#_fkSelectList
local selfValue=self:getSelfGoodsValue()
local fkValue=self:getCustomerGoodsValue()


local speakType
if isfirst then

speakType=5
elseif fkLen==0 and selfLen==0 then

speakType=4
elseif fkLen==0 and selfLen>0 then


speakType=0
elseif fkLen>0 and selfLen==0 then

speakType=4
else

if selfValue<fkValue then
speakType=2
elseif selfValue<fkValue*1.5 then
speakType=3
else
speakType=1
end
end
self:refreshSpeakTextEx(speakType,'shopcontent')
self:showEmot(speakType)
end

function UIXianZhanTransactionWin:refreshSpeakTextEx(speakType,contentKey,func,nextSpeak)
local speakContent=self.fkConfig[contentKey]
local speakList=speakContent[speakType]
if speakList==nil then
speakList=speakContent[#speakContent]
end
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
self:doSpeaking(speakStr,func,nextSpeak)
end

function UIXianZhanTransactionWin:doSpeaking(speakStr,func,nextSpeak)
self:stopTimerByName('nextSpeakTimer')
local speed=30
local func2=function()
if _this==nil then return end
if func then
func()
end
if nextSpeak==true then
_this.nextSpeakTimer=_this:delayDo(3,function()
if _this==nil then return end
_this:stopTimerByName('nextSpeakTimer')
_this:refreshSpeakText()
end)
end
end
self.speakText:setChildTrendsTextPlay(speakStr,speed,func2)
self:doTalkAnim()
end

function UIXianZhanTransactionWin:showEmot(speakType)
local shopEmot=cfgHelper.get2(cfg_xianzhanfangkeconfig_get,self.data.customerId,'shopEmot')
local emot=shopEmot[speakType]
if emot==nil then return end
self.biaoqingObj:setChildCanvasGroupAlpha(1)
local str=chatEmotHelper.getSmallEmotMesg(emot)
self.biaoqingTxt:setText(chatEmotHelper.decodeEmot(str))

if self.showEmotTimer~=nil then
self:stopTimerByID(self.showEmotTimer)
self.showEmotTimer=nil
end
self.showEmotTimer=self:delayDo(3,function()
self.showEmotTimer=nil
self.biaoqingObj:setChildCanvasGroupAlpha(0)
end)
end


function UIXianZhanTransactionWin:getSelfGoodsValue()
local value=0
for i,selectInfo in ipairs(_selfSelectList)do
local itemid=selectInfo.itemid
local count=selectInfo.count
local itemConfig=itemsConfig.getConfig(itemid)
local likeItem=self:getCustomerLikeItemVal(itemid)
local hideWorth=itemConfig.hideWorth
if likeItem~=nil and likeItem>0 then
value=value+likeItem*count
elseif hideWorth then
value=value+hideWorth*count
end
end
return value
end


function UIXianZhanTransactionWin:getCustomerGoodsValue()
local value=0
for i,selectInfo in ipairs(_fkSelectList)do
local itemid=selectInfo.itemid
local count=selectInfo.count
local itemConfig=itemsConfig.getConfig(itemid)
local likeItem=self:getCustomerLikeItemVal(itemid)
local hideWorth=itemConfig.hideWorth
if likeItem~=nil and likeItem>0 then
value=value+likeItem*count
elseif hideWorth then
value=value+hideWorth*count
end
end
if value>0 then
local data=xianzhanModel:getRoomDataByRoomId(self.roomId)
local hgd=data.haoGanDu
local lv=npcModel.getHaoGanDuLevel(hgd)
local rate=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'gxjyFix')
value=value-(lv-1)*rate
end
return value
end

function UIXianZhanTransactionWin:initFangKeLikeLookup()
local npcid=self.data.customerId
self.fangkeLikeLookup=npcModel:getNPCLikeItems(npcid)or{}
end


function UIXianZhanTransactionWin:getCustomerLikeItemVal(itemid)
local lookup=self.fangkeLikeLookup
local val=lookup[itemid]
if val~=nil then
return val
end
return 0
end

function UIXianZhanTransactionWin:refreshBaiPiaoBtn(data)
local suoyaoNum=data.suoyaoNum
local limit=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'daySuoYaoNum')
local isGray=suoyaoNum>=limit
self.baipiaoBtn:setChildImageExGray(isGray)
end

function UIXianZhanTransactionWin:onEdgeEvent()

end




function UIXianZhanTransactionWin:onPageClick(pageType)
if self.selectPageType==pageType then return end
local old=self.selectPageType
if old~=nil then
local olditem=self.pageBtnsGrid:getChildLayoutGroupGridItem(old-1)
olditem:SetChildActive(1,false)
end
local item=self.pageBtnsGrid:getChildLayoutGroupGridItem(pageType-1)
item:SetChildActive(1,true)
self.selectPageType=pageType

self:freshSelfBag()
end

function UIXianZhanTransactionWin:getPageItemsList()
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

function UIXianZhanTransactionWin:initPageBtns()
local func=function(index)
local item=self.pageBtnsGrid:getChildLayoutGroupGridItem(index-1)
self:refreshPageBtn(item,index)
end
self.pageBtnsGrid:setChildLayoutGroupCreateItems(#self.pageTypeList,func)
end

function UIXianZhanTransactionWin:refreshPageBtn(item,index)
local pageType=self.pageTypeList[index]
local pcfg=pageConfig[pageType]
item:SetChildButtonClick(0,function()
self:onPageClick(pageType)
end)
local isSelect=pageType==self.selectPageType
item:SetChildActive(1,isSelect)

item:SetChildText(2,pcfg.name)
end

function UIXianZhanTransactionWin:freshSelfBag()
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

local selectInfo=_selfSelectLookup[itemid]
if selectInfo then
if selectInfo.lookup then
local temp=selectInfo.lookup[itemguidStr]
if temp then
itemcount=itemcount-temp.count
end
end
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


function UIXianZhanTransactionWin:bindSelfGrid(index,item)
local itemInfo=_selfItemsList[index]
local isTemp=itemInfo==nil
local conf
if not isTemp then
local itemid=itemInfo.itemid
local count=itemInfo.itemcount
conf={itemid=itemid,count=count,itemguid=itemInfo.itemguid,love=itemInfo.love,jinglianlv=itemInfo.jinglianlv}
end
self:setItemData(index,item,conf,isTemp,1)
end

function UIXianZhanTransactionWin:onSelfItemClick(itemid,index,guid,attach)

if itemid<=0 then return end
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig then
local bagIdx=index
local itemInfo=_selfItemsList[bagIdx]
local itemguid=itemInfo.itemguid

if itemInfo.jinglianlv and itemInfo.jinglianlv>0 then
UIManager.info("精练过的装备无法交易")
return
end

if itemInfo.love~=nil and itemInfo.love<0 then
local npcid=self.data.customerId
UIManager.info(FMT.fmt('{0}讨厌该物品，拒绝接收',npcModel:getNPCName(npcid)))
return
end

local h_count=itemInfo.itemcount
if h_count<=0 then
return
end

local s_count=0
local selectInfo=_selfSelectLookup[itemid]
if selectInfo then
s_count=selectInfo.count
else

local len=#_selfSelectList
if len>=_selfExChangeNum then
UIManager.info('桌子已放不下更多物品')
return
end
end

if s_count>=maxGoodsCount then
UIManager.info(FMT.fmt('相同物品不可超过{0}个',maxGoodsCount))
return
end


local l_count=maxGoodsCount-s_count
local max_count=math.min(l_count,h_count)
if max_count<=0 then
return
end
if max_count>showUseTipsCount then
local attach_={}
local selectNumCmpArgs={numFormat='数量：<color=#f1ce78>{0}/{1}</color>',
min=1,max=max_count,val=1}
attach_.selectNumCmpArgs=selectNumCmpArgs
attach_.tipsCommonUseItemCB=function(attach__)
if _this==nil then return end
local num=attach__.selectNumCmpArgs and attach__.selectNumCmpArgs.selectNum or 1
_this:onSelfItemClick_use(itemid,index,num)
end
attach_.insertBtnList={TIPS_BTNS_TYPE.eCommonUseItem}
tipsManager.showTips({itemid=itemid,itemguid=itemguid,attach=attach_})
else
self:onSelfItemClick_use(itemid,index,1)
end
else
loggerUtil.logErrFMT('没有找到此道具：',itemid)
end
end

function UIXianZhanTransactionWin:onSelfItemClick_use(itemid,index,num)
local selectInfo=_selfSelectLookup[itemid]
local bagIdx=index
local itemInfo=_selfItemsList[bagIdx]
local itemguidStr=itemInfo.itemguidStr
local itemguid=itemInfo.itemguid


local exchangIdx
local isNew=false
local s_count=0
if selectInfo~=nil then
s_count=selectInfo.count+num
else
s_count=num
end

if s_count>maxGoodsCount then
UIManager.info(FMT.fmt('相同物品不可超过{0}个',maxGoodsCount))
return
end
if selectInfo~=nil then
for i,selectInfo_ in ipairs(_selfSelectList)do
if selectInfo_.itemid==itemid then
exchangIdx=i
break
end
end
local temp=selectInfo.lookup[itemguidStr]
if temp then
temp.count=temp.count+num
else
temp={itemguid=itemguid,itemguidStr=itemguidStr,count=num}
selectInfo.lookup[itemguidStr]=temp
end
selectInfo.count=selectInfo.count+num
else

local len=#_selfSelectList
if len>=_selfExChangeNum then
UIManager.info('桌子已放不下更多物品')
return
end
exchangIdx=len+1
selectInfo={itemid=itemid,count=num,lookup={},love=itemInfo.love}
selectInfo.lookup[itemguidStr]={itemguid=itemguid,itemguidStr=itemguidStr,count=num}
_selfSelectList[exchangIdx]=selectInfo
_selfSelectLookup[itemid]=selectInfo
isNew=true
end
local exItem=self.selfExChange:getSlowItemByIndex(exchangIdx-1)
if isNew then
self.selfExChange:freshSlowItem(exchangIdx-1)
exItem:SetChildActive(3,false)
end

itemInfo.itemcount=itemInfo.itemcount-num
if selectInfo.count>=maxGoodsCount then
for bagIdx_,itemInfo_ in ipairs(_selfItemsList)do
if itemInfo_.itemid==itemid then
self.selfScrollView:freshSlowItem(bagIdx_-1)
end
end
else
self.selfScrollView:freshSlowItem(bagIdx-1)
end


local bagItem=self.selfScrollView:getSlowItemByIndex(bagIdx-1)
local spos=bagItem:GetChildScreenPointToLocalPointRectangle(-1)
spos.x=spos.x+itemOffset[1]
spos.y=spos.y+itemOffset[2]
local epos=exItem:GetChildScreenPointToLocalPointRectangle(-1)
epos.x=epos.x+itemOffset[1]
epos.y=epos.y+itemOffset[2]
self.lockAddItem=self.lockAddItem or 0
self:setChildGreateExpandUI(-1,-1,INSTANCE_TYPE.eCommonFlyItemUIExpand,function(guid)
if _this==nil then return end
_this.lockAddItem=_this.lockAddItem+1
local widget=_this:getChildExpandUI(-1,guid)
widget:SetChildLocalPos(-1,spos.x,spos.y,0)
local prop_conf={itemid=itemid,itemcount='',showCountBG=false,
showStage=false,gray=0,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(prop_conf)
widget:SetChildPropData(0,prop)
widget:SetChildDOScale(-1,1.4,0.15,function()
if _this==nil then return end
widget:SetChildDOScale(-1,1,0.4)
end)
widget:SetChildDOLocalMove(-1,Vector3(epos.x,epos.y,0),0.5,function()
if _this==nil then return end
widget:SetChildRemoveExpandUI(-1,guid)
if isNew then
exItem:SetChildActive(3,true)
else
_this.selfExChange:freshSlowItem(exchangIdx-1)
end
_this.lockAddItem=_this.lockAddItem-1
end)
end)


self:refreshSpeakText()
self:refreshExchangeBtn()
self:refreshFangKeInfo(true)
self:refreshSelfNotExhange()
end


function UIXianZhanTransactionWin:bindSelfExChangeGrid(index,item)
local selectInfo=_selfSelectList[index]
local isTemp=selectInfo==nil
local conf
if not isTemp then
local itemid=selectInfo.itemid
local count=selectInfo.count
conf={itemid=itemid,count=count,itemguid=selectInfo.itemid,love=selectInfo.love}
end
self:setItemData(index,item,conf,isTemp,2)
end

function UIXianZhanTransactionWin:onSelfExChangeItemClick(itemid,index,guid,attach)
if self.lockAddItem>0 then return end
if itemid<=0 then return end


local selectInfo=_selfSelectList[index]
if selectInfo==nil then return end
if selectInfo.itemid~=itemid then return end
local islast=index==#_selfSelectList
table.remove(_selfSelectList,index)
_selfSelectLookup[itemid]=nil
if islast then
self.selfExChange:freshSlowItem(index-1)
else
self:freshSelfExChangeGridsEx()
end


for bagIdx,itemInfo in ipairs(_selfItemsList)do
if itemInfo.itemid==itemid then
local d=selectInfo.lookup[itemInfo.itemguidStr]
if d then
itemInfo.itemcount=itemInfo.itemcount+d.count
end
self.selfScrollView:freshSlowItem(bagIdx-1)
end
end


self:refreshSpeakText()
self:refreshExchangeBtn()
self:refreshFangKeInfo(true)
self:refreshSelfNotExhange()
end


function UIXianZhanTransactionWin:refreshCustomerBag()
_fkItemsList={}
self.visitorScrollView:clearSlowItems()
local data=xianzhanModel:getRoomDataByRoomId(self.roomId)
local haogandu=data.haoGanDu
local itemsList=data.exchList or{}
local list={}
for i,v in ipairs(itemsList)do
local itemid=v.itemId
local itemConfig=itemsConfig.getConfig(itemid)
local itemNumMax=v.itemNum
local itemNum=v.itemNum
local need=v.hgdLevel
local fix=haogandu>=need

local color=itemConfig.color or 0
local stage=itemConfig.stage or 0
local weight=(10-color)*100+(10-stage)

local selectInfo=_fkSelectLookup[itemid]
if selectInfo then
itemNum=itemNum-selectInfo.count
end
table.insert(_fkItemsList,{hgdLevel=need,itemNum=itemNum,itemNumMax=itemNumMax,itemid=itemid,weight=weight,fix=fix})
end
local itemsLen=#_fkItemsList
if itemsLen>1 then
table.sort(_fkItemsList,function(a,b)
if a.fix==b.fix then
if a.fix==true then
return a.weight>b.weight
else
return a.hgdLevel<b.hgdLevel
end
else
local afix=a.fix==true and 1 or 0
local bfix=b.fix==true and 1 or 0
return afix>bfix
end
end)
end
for i,v in ipairs(_fkItemsList)do
_fkItemsLookup[v.itemid]=i
end

local tNum=100
local row=math.ceil(tNum/_fkColomn)
tNum=row*_fkColomn
self.visitorScrollView:freshSlowGrids(tNum,row,_fkColomn,true)
end


function UIXianZhanTransactionWin:bindCustomerGrid(index,item)
local itemInfo=_fkItemsList[index]
local isTemp=itemInfo==nil
local conf
if not isTemp then
local itemid=itemInfo.itemid
local count=itemInfo.itemNum
local hgdLevel=itemInfo.hgdLevel
conf={itemid=itemid,count=count,hgdLevel=hgdLevel}
end
self:setItemData(index,item,conf,isTemp,3)
end

function UIXianZhanTransactionWin:onCustomerItemClick(itemid,index,guid,attach)
if itemid<=0 then return end
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig then
local bagIdx=index
local itemInfo=_fkItemsList[bagIdx]

local needHgd=itemInfo.hgdLevel
local flag,flagstr=self:checkCustomerItemLimit(needHgd)
if flag then
UIManager.info(flagstr)
return
end

local h_count=itemInfo.itemNum
if h_count<=0 then
return
end

local s_count=0
local selectInfo=_fkSelectLookup[itemid]
if selectInfo then
s_count=selectInfo.count
else

local len=#_fkSelectList
if len>=_fkExChangeNum then
UIManager.info('桌子已放不下更多物品')
return
end
end
if s_count>=itemInfo.itemNumMax then
return
end

if s_count>=maxGoodsCount then
UIManager.info(FMT.fmt('相同物品不可超过{0}个',maxGoodsCount))
return
end


if h_count>showUseTipsCount then
local attach_={}
local selectNumCmpArgs={numFormat='数量：<color=#f1ce78>{0}/{1}</color>',
min=1,max=h_count,val=1}
attach_.selectNumCmpArgs=selectNumCmpArgs
attach_.tipsCommonUseItemCB=function(attach__)
if _this==nil then return end
local num=attach__.selectNumCmpArgs and attach__.selectNumCmpArgs.selectNum or 1
_this:onCustomerItemClick_use(itemid,index,num)
end
attach_.insertBtnList={TIPS_BTNS_TYPE.eCommonUseItem}
tipsManager.showTips({itemid=itemid,itemguid=nil,attach=attach_})
else
self:onCustomerItemClick_use(itemid,index,1)
end
else
loggerUtil.logErrFMT('没有找到此道具：',itemid)
end
end

function UIXianZhanTransactionWin:onCustomerItemClick_use(itemid,index,num)
local bagIdx=index
local itemInfo=_fkItemsList[bagIdx]
local selectInfo=_fkSelectLookup[itemid]


local exchangIdx
local isNew=false
local h_count=itemInfo.itemNum
if h_count<=0 then
return
end

local s_count=0
if selectInfo~=nil then
s_count=selectInfo.count+num
else
s_count=num
end
if s_count>itemInfo.itemNumMax then
return
end

if s_count>maxGoodsCount then
UIManager.info(FMT.fmt('相同物品不可超过{0}个',maxGoodsCount))
return
end

if selectInfo~=nil then
for i,selectInfo_ in ipairs(_fkSelectList)do
if selectInfo_.itemid==itemid then
exchangIdx=i
break
end
end
selectInfo.count=selectInfo.count+num
else

local len=#_fkSelectList
if len>=_fkExChangeNum then
UIManager.info('桌子已放不下更多物品')
return
end
exchangIdx=len+1
selectInfo={itemid=itemid,count=num,m_count=itemInfo.itemNumMax}
_fkSelectList[exchangIdx]=selectInfo
_fkSelectLookup[itemid]=selectInfo
isNew=true
end
local exItem=self.visitorExChange:getSlowItemByIndex(exchangIdx-1)
if isNew then
self.visitorExChange:freshSlowItem(exchangIdx-1)
exItem:SetChildActive(3,false)
end


itemInfo.itemNum=itemInfo.itemNum-num
self.visitorScrollView:freshSlowItem(bagIdx-1)


local bagItem=self.visitorScrollView:getSlowItemByIndex(bagIdx-1)
local spos=bagItem:GetChildScreenPointToLocalPointRectangle(-1)
spos.x=spos.x+itemOffset[1]
spos.y=spos.y+itemOffset[2]
local epos=exItem:GetChildScreenPointToLocalPointRectangle(-1)
epos.x=epos.x+itemOffset[1]
epos.y=epos.y+itemOffset[2]
self.lockAddItem=self.lockAddItem or 0
self:setChildGreateExpandUI(-1,-1,INSTANCE_TYPE.eCommonFlyItemUIExpand,function(guid)
if _this==nil then return end
_this.lockAddItem=_this.lockAddItem+1
local widget=_this:getChildExpandUI(-1,guid)
widget:SetChildLocalPos(-1,spos.x,spos.y,0)
local prop_conf={itemid=itemid,itemcount='',showCountBG=false,
showStage=false,gray=0,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(prop_conf)
widget:SetChildPropData(0,prop)
widget:SetChildDOScale(-1,1.4,0.15,function()
if _this==nil then return end
widget:SetChildDOScale(-1,1,0.4)
end)
widget:SetChildDOLocalMove(-1,Vector3(epos.x,epos.y,0),0.5,function()
if _this==nil then return end
widget:SetChildRemoveExpandUI(-1,guid)
if isNew then
exItem:SetChildActive(3,true)
else
_this.visitorExChange:freshSlowItem(exchangIdx-1)
end
_this.lockAddItem=_this.lockAddItem-1
end)
end)


self:refreshSpeakText()
self:refreshExchangeBtn()
self:refreshFangKeInfo(true)
self:refreshFKNotExhange()
end


function UIXianZhanTransactionWin:bindCustomerExChangeGrid(index,item)
local selectInfo=_fkSelectList[index]
local isTemp=selectInfo==nil
local conf
if not isTemp then
local itemid=selectInfo.itemid
local count=selectInfo.count
conf={itemid=itemid,count=count}
end
self:setItemData(index,item,conf,isTemp,4)
end

function UIXianZhanTransactionWin:onCustomerExChangeItemClick(itemid,index,guid,attach)
if self.lockAddItem>0 then return end
if itemid<=0 then return end


local selectInfo=_fkSelectList[index]
if selectInfo==nil then return end
if selectInfo.itemid~=itemid then return end
local islast=index==#_fkSelectList
table.remove(_fkSelectList,index)
_fkSelectLookup[itemid]=nil

if islast then
self.visitorExChange:freshSlowItem(index-1)
else
self:freshFKExChangeGridsEx()
end


local bagIdx=_fkItemsLookup[itemid]
if bagIdx then
local itemInfo=_fkItemsList[bagIdx]
itemInfo.itemNum=itemInfo.itemNum+selectInfo.count
self.visitorScrollView:freshSlowItem(bagIdx-1)
end


self:refreshSpeakText()
self:refreshExchangeBtn()
self:refreshFangKeInfo(true)
self:refreshFKNotExhange()
end


function UIXianZhanTransactionWin:setItemData(index,item,conf,clear,checkType)
local has=false
local itemid
local itemguid
if conf then
has=true

itemid=conf.itemid
itemguid=conf.itemguid or-1
local showJinglianlv=conf.jinglianlv and conf.jinglianlv>0
local count=showJinglianlv and conf.jinglianlv or conf.count
local showCount=count>1
local countStr=showCount and(showJinglianlv and string.format("+%s",count)or count)or''
local grayNum=0
if count<=0 or showJinglianlv then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
end
local showlock=false
if checkType==1 then

if conf.love~=nil and conf.love<0 then
showlock=true
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
else
local selectInfo=_selfSelectLookup[itemid]
if selectInfo then
if selectInfo.count>=maxGoodsCount then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
end
end
end
elseif checkType==2 then


elseif checkType==3 then

local check,str=self:checkCustomerItemLimit(conf.hgdLevel)
if check then
showlock=true
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
else
local selectInfo=_fkSelectLookup[itemid]
if selectInfo then
if selectInfo.count>=maxGoodsCount then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
end
end
end
elseif checkType==4 then


end
item:SetChildActive(2,showlock)

local showlove=conf.love~=nil and conf.love>0
item:SetChildActive(4,showlove)

local showStage=itemsConfig.isEquip(itemid)

local prop_conf={itemid=itemid,itemguid=itemguid,itemcount=countStr,showCountBG=showCount,
showStage=showStage,gray=grayNum,showname=false,itemIndex=index}
local prop=itemsComponentHelper.getCommonFillDataSmall(prop_conf)
item:SetChildActive(3,true)
item:SetChildPropData(1,prop)

item:SetChildActive(0,false)

local suitIconName=equipsHelper.getSuitIconByArgs(itemguid,itemid)
item:SetChildIcon(5,suitIconName,false)
elseif clear then
item:SetChildActive(3,false)
item:SetChildActive(2,false)
item:SetChildActive(4,false)

local showbg=checkType==1 or checkType==3
item:SetChildActive(0,showbg)

item:SetChildIcon(5,'',false)
end
if has then
if checkType==1 then

item:SetChildButtonClick(3,function(...)
self:onSelfItemClick(itemid,index,itemguid,nil)
end)
elseif checkType==2 then

item:SetChildButtonClick(3,function(...)
self:onSelfExChangeItemClick(itemid,index,itemguid,nil)
end)
elseif checkType==3 then

item:SetChildButtonClick(3,function(...)
self:onCustomerItemClick(itemid,index,itemguid,nil)
end)
elseif checkType==4 then

item:SetChildButtonClick(3,function(...)
self:onCustomerExChangeItemClick(itemid,index,itemguid,nil)
end)
end
item:SetChildLongTouch(3,index,0.5,function(...)
self:onItemLongClick(itemid,index,itemguid,nil)
end)
end
end

function UIXianZhanTransactionWin:checkCustomerItemLimit(itemhgdlv)
local hgd=self.data.haoGanDu
local lv=npcModel.getHaoGanDuLevel(hgd)
if lv<itemhgdlv then
local name=npcModel.getHaoGanDuNameEx(itemhgdlv)
local str=FMT.fmt('需要关系达到{0}',name)
return true,str
end
return false
end

function UIXianZhanTransactionWin:onItemLongClick(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end



function UIXianZhanTransactionWin:onCloseBtn()
UIManager:invokeUIMethod('UIXianZhanInteractWin','restChatSpeak')
xianzhanController:closeInteractAttachWin(XianZhanInteractType.eTransaction)
end

function UIXianZhanTransactionWin:onLikeClick()
UIManager:showWindow('UIXianZhanLikeTipsWin',{customerId=self.data.customerId})
end

function UIXianZhanTransactionWin:onTipsBtn()
local d={}
d.title='提示'
d.mode=3
d.name='xianzhan_jiaoyi_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXianZhanTransactionWin:onBaipiaoBtn()
if self.lockAddItem and self.lockAddItem>0 then return end
local limit=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'daySuoYaoNum')
local data=xianzhanModel:getRoomDataByRoomId(self.roomId)
local suoyaoNum=data.suoyaoNum
if suoyaoNum>=limit then
UIManager.error('今日不能再向其索要物品')
return
end
local fkList={}
for i,selectInfo in ipairs(_fkSelectList)do
if selectInfo.count<=selectInfo.m_count then
table.insert(fkList,{selectInfo.itemid,selectInfo.count})
else
UIManager.error('选择的物品超出上限')
return
end
end
if#fkList<=0 then
UIManager.error('请选择索要的物品')
return
end
xianzhanController:req_shop_Transaction({0,{},#fkList,fkList,2,self.roomId})
end

function UIXianZhanTransactionWin:onExchangeBtn()
if self.lockAddItem and self.lockAddItem>0 then return end
local selfList={}
for i,selectInfo in ipairs(_selfSelectList)do
table.insert(selfList,{selectInfo.itemid,selectInfo.count})
end
local fkList={}
for i,selectInfo in ipairs(_fkSelectList)do
if selectInfo.count<=selectInfo.m_count then
table.insert(fkList,{selectInfo.itemid,selectInfo.count})
else
UIManager.error('选择的物品超出上限')
return
end
end

local selfValue=self:getSelfGoodsValue()
local fkValue=self:getCustomerGoodsValue()
self.goodValueData={selfValue,fkValue}

local roomId=self.roomId
if#selfList>0 and#fkList==0 then

if self.lerpHGD<=0 then

local npcid=self.data.customerId
local talk=npcModel:getNPCEnoughGiftTalk(npcid)
self:doSpeaking(talk)
return
end

local fkname=xianzhanModel.getFangKeName(self.fkConfig.id)
local desc_str
if self.selectHGD>self.lerpHGD then
local lerp=self.selectHGD-self.lerpHGD
desc_str=FMT.fmt('本次赠礼会溢出{0}点亲密度，是否确认？',lerp)
else
desc_str=FMT.fmt('确认将以下物品赠与<{0}>吗？',fkname)
end

local rewards=selfList
local args={
title='提示',
desc1=desc_str,
desc2=nil,
rewards=rewards,
rewardTitle=-1,
showCancel=true,
cancelName='容我三思',
commitName='确认赠予',
cancelCB=nil,
commitCB=function()
xianzhanController:req_shop_Transaction({#selfList,selfList,#fkList,fkList,3,roomId})
end,
}
UIManager:showWindow('UIDialougeRewardWin',args)
else
if#selfList<=0 then
self:refreshSpeakTextEx(5,'resultcontent',nil,true)
return
end


xianzhanController:req_shop_Transaction({#selfList,selfList,#fkList,fkList,1,roomId})
end
end










function UIXianZhanTransactionWin:rec_jiaoyi(roomData,exchType,result,goodlist)
if self.roomId~=roomData.roomId then return end
self.data=roomData
if result==0 then
if exchType==2 then
UIManager.info('索要成功')
self:refreshFangKeInfo(true)
self:freshFKExChangeGrids()
self:refreshBaiPiaoBtn(roomData)

local func=function()
if _this==nil then return end
showPrizeControl.showWindow(_this.bpRewardList)
end
self:refreshSpeakTextEx(result+1,'baipiaoSpeak',func,true)
elseif exchType==3 then
UIManager.info('赠送成功')
self:freshSelfExChangeGrids()
self:refreshExchangeBtn()
self:refreshFangKeInfo(true)

self:refreshSpeakTextEx(0,'resultcontent',nil,true)
else
self:freshExChangeGrids()

local selfValue=self.goodValueData[1]
local fkValue=self.goodValueData[2]
local speakType
if selfValue<fkValue then
speakType=2
elseif selfValue<fkValue*1.5 then
speakType=4
else
speakType=1
end
local func=function()
if _this==nil then return end
_this.rewardEffect:setChildShowEffect(10060,true)
_this:delayDo(1,function()
showPrizeControl.showWindow(goodlist)
end)
end
self:refreshSpeakTextEx(speakType,'resultcontent',func,true)
end
self:freshSelfBag()
self:refreshCustomerBag(roomData.roomId)
else
if exchType==2 then
UIManager.info('索要失败')
self:refreshFangKeInfo(true)
self:refreshBaiPiaoBtn(roomData)

self:refreshSpeakTextEx(result+1,'baipiaoSpeak',nil,true)
elseif exchType==3 then


else
UIManager.error('交易失败')

self:refreshSpeakTextEx(3,'resultcontent',nil,true)
end
end
end


