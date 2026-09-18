







def_class("UISubAct_xiantuzhuli",UIWindowBase)









function UISubAct_xiantuzhuli:bindComponents()

self.layout=UIObject.get(self,0)
self.giftRoot=UIObject.get(self,1)
self.giftListScrollView=UIObject.get(self,2)
self.titleImage=UIImage.get(self,3)
self.timeText=UIText.get(self,4)
self.commonReward=UIButton.get(self,5)
self.commonRewardReddot=UIObject.get(self,6)
self.dzmodel=UIObject.get(self,7)
self.limitCountText=UIText.get(self,8)
self.buyBtn=UIButton.get(self,9)
self.buyBtnText=UIText.get(self,10)
self.selloutFlag=UIObject.get(self,11)
self.item_1=UIObject.get(self,12)
self.item_2=UIObject.get(self,13)
self.item_3=UIObject.get(self,14)
self.item_4=UIObject.get(self,15)
self.zhuliCount=UIText.get(self,16)
self.zhuliScrollView=UIObject.get(self,17)
self.zhuliContent=UIObject.get(self,18)
self.zhuliProgressBar=UIObject.get(self,19)
self.zhuliProgress=UIObject.get(self,20)
self.zhuliGrid=UIObject.get(self,21)
self.npcModel=UIObject.get(self,22)
self.speakObj=UIObject.get(self,23)
self.speakText=UIText.get(self,24)
self.npcClicker=UIButton.get(self,25)
self.packbg=UIImage.get(self,26)
self.packTxt=UIText.get(self,27)
self.zhuliProgressBarEx=UIObject.get(self,28)
self.zhuliProgressEx=UIObject.get(self,29)
self.bgroot=UIObject.get(self,30)
self.bg=UIObject.get(self,31)
self.TipsBtn=UIButton.get(self,32)
self.itembuyText=UIText.get(self,33)
self.itemIcon=UIObject.get(self,34)

self.commonReward:setButtonClick(function()self:onCommonReward()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.npcClicker:setButtonClick(function()self:onNpcClicker()end)

self.TipsBtn:setButtonClick(function()self:onTipsBtn()end)
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
}



end


function UISubAct_xiantuzhuli:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.giftRoot);self.giftRoot=nil;
_UIObject_release(self.giftListScrollView);self.giftListScrollView=nil;
_UIObject_release(self.titleImage);self.titleImage=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.commonReward);self.commonReward=nil;
_UIObject_release(self.commonRewardReddot);self.commonRewardReddot=nil;
_UIObject_release(self.dzmodel);self.dzmodel=nil;
_UIObject_release(self.limitCountText);self.limitCountText=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.buyBtnText);self.buyBtnText=nil;
_UIObject_release(self.selloutFlag);self.selloutFlag=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.item_4);self.item_4=nil;
_UIObject_release(self.zhuliCount);self.zhuliCount=nil;
_UIObject_release(self.zhuliScrollView);self.zhuliScrollView=nil;
_UIObject_release(self.zhuliContent);self.zhuliContent=nil;
_UIObject_release(self.zhuliProgressBar);self.zhuliProgressBar=nil;
_UIObject_release(self.zhuliProgress);self.zhuliProgress=nil;
_UIObject_release(self.zhuliGrid);self.zhuliGrid=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.npcClicker);self.npcClicker=nil;
_UIObject_release(self.packbg);self.packbg=nil;
_UIObject_release(self.packTxt);self.packTxt=nil;
_UIObject_release(self.zhuliProgressBarEx);self.zhuliProgressBarEx=nil;
_UIObject_release(self.zhuliProgressEx);self.zhuliProgressEx=nil;
_UIObject_release(self.bgroot);self.bgroot=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.TipsBtn);self.TipsBtn=nil;
_UIObject_release(self.itembuyText);self.itembuyText=nil;
_UIObject_release(self.itemIcon);self.itemIcon=nil;
self.item=nil;
end


















local giftItemIndex={
btnClick=0,
select=1,
reddot=2,
Icon=3,
name=4,
bg=5,
}

local scrollViewItemCfg={
{
bg={x=-3.5,y=-4,rz=-8.15},
select={x=-9.5,y=0,rz=0},
reddot={x=31.8,y=24.3,rz=0},
name={x=-9.5,y=-21.6,rz=0}
},
{
bg={x=14,y=4.4,rz=3.16},
select={x=7.5,y=7.1,rz=11.019},
reddot={x=40,y=41.4,rz=0},
name={x=9.8,y=-14.2,rz=3.106}
},
{
bg={x=-3.5,y=13,rz=-8.15},
select={x=-9.5,y=18,rz=0},
reddot={x=33.9,y=37,rz=0},
name={x=-9.5,y=-5.1,rz=0}
},
{
bg={x=24.5,y=28.9,rz=3.163},
select={x=17.9,y=31.6,rz=11.019},
reddot={x=58.8,y=59.2,rz=3.163},
name={x=26.4,y=10.4,rz=3.106}
},
{
bg={x=-3.9,y=26.2,rz=0},
select={x=-10.2,y=28.8,rz=5.812},
reddot={x=32.5,y=57.7,rz=0},
name={x=-10.9,y=6.8,rz=3.106}
},
}

local speed=400
local stepHeight=92
local contentOffset={0,0}
local bottomOffset=50
local veiwTopoffest=50
local _this
local abName="ui/windows/activities/sub_xiantuzhuli/xiantuzhuli_atlas_pak.ab"







function UISubAct_xiantuzhuli:onLoaded(...)
_this=self
self:bindComponents()
self.itemWidgetList={}
for i,v in ipairs(self.item)do
self.itemWidgetList[#self.itemWidgetList+1]=v:getChildWidgetBase()
end
self.bg:setChildUIModelShowTarget(5432,1,{},eAnimationID.stand)
self:showWindow('UITopMoneyWin4',{moneys={{eMoneyType.mtLingYu}},offsetX=75.9,offsetY=-29.71})
end


function UISubAct_xiantuzhuli:__delete()
self:unbindComponents()
self:clearSpeakTimer()
self.itemWidgetList=nil
_this=nil
end




function UISubAct_xiantuzhuli:onShow(argtable,afterOnloaded)

self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.rewards=self.config.rewards

self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)


self.giftIndex=1

self:refreshNPCModel()



if self.actTimer==nil then
local func=function()
self:refreshActTimer()
end
self.actTimer=self:setTimer(60,0,func)
end
self:refreshActTimer()
self:createGiftList()
self:refresh()
end


function UISubAct_xiantuzhuli:onHide()

end





function UISubAct_xiantuzhuli:refresh()
local rewards=self.rewards




self:refreshCommonReddot()
self:refreshRewardItemList()
self:refreshBuyData()
self:refreshZhuLiData()
self:refreshPackData()
self:initZhuLiList()
self:refreshZhuLiList()
end


function UISubAct_xiantuzhuli:refreshPackData()
local packBgcfg=self.config.packCfg[self.giftIndex]

self.packbg:setChildUIModelShowTarget(packBgcfg[1],1,{},packBgcfg[2])
local nameTxt=self.config.name[self.giftIndex]
self.packTxt:setText(nameTxt)
self.packTxt:setChildAnchoredPos(packBgcfg[3],packBgcfg[4])
end


function UISubAct_xiantuzhuli:refreshCommonReddot()
local reddot=self:getCommonReddot(self.giftIndex)
self.commonRewardReddot:setActive(reddot)
self.commonReward:setActive(reddot)
end

function UISubAct_xiantuzhuli:refreshRewardItemList()
local curPack=self.rewards[self.giftIndex]
local itemList=curPack[1]
local itemCfg,widget,itemid,countStr,showCountBG,itemcount

for i,v in ipairs(self.itemWidgetList)do
itemCfg=itemList[i]
widget=v
if itemCfg then
widget:SetChildActive(1,true)
itemid=itemCfg[1]
itemcount=itemCfg[2]
countStr=''
showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(1,false)
end
end
end

function UISubAct_xiantuzhuli:refreshBuyData()
local curPack=self.rewards[self.giftIndex]
local limitCount=curPack[3]
local buyCount=self:getBuyCount(self.giftIndex)
local isCanBuy=buyCount<limitCount
self.buyBtn:setActive(isCanBuy)
self.selloutFlag:setActive(not isCanBuy)

local limitTxt=FMT.fmt("限购:{0}次",limitCount-buyCount)
self.limitCountText:setText(limitTxt)
if isCanBuy then
local buyTxt
if type(curPack[2])=='number'then
self.buyBtnText:setActive(true)
self.itembuyText:setActive(false)
local rechargeId=curPack[2]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
buyTxt=str
self.buyBtnText:setText(buyTxt)
else
self.buyBtnText:setActive(false)
self.itembuyText:setActive(true)
local itemId=curPack[2][1][1]
local itemCount=curPack[2][1][2]
local iconName=iconHelper.getIconName(itemId)





self.itemIcon:setChildIcon(iconName)
self.itembuyText:setText(itemCount)
end

end
end

function UISubAct_xiantuzhuli:refreshZhuLiData()
local curPack=self.rewards[self.giftIndex]
local zhuLiCount=self:getZhuLiCount(self.giftIndex)

self.zhuliCount:setText(zhuLiCount)
end


function UISubAct_xiantuzhuli:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
local time_str=FMT.fmt('活动时间：{0}',timeHelper.format_time_stamp3(time,true))
self.timeText:setText(time_str)
end

function UISubAct_xiantuzhuli:createGiftList()
local scrollViewMaxSize=1000
self.widget:SetChildScrollViewAutoSizeOption(self.giftListScrollView:getID(),true,scrollViewMaxSize)
local rewards=self.rewards
local nameList=self.config.name
local count=#rewards
local scrollViewSize=count*127+15
local isEnable=true
if scrollViewSize<scrollViewMaxSize then
isEnable=false
end
self.giftListScrollView:setChildScrollViewCreateGrids(count,1)
local grids=self.giftListScrollView:getChildScrollViewItemWidgets()
for i=1,count do
local itemIndex=i
local widget=grids[itemIndex-1]








local name=nameList[i]

widget:SetChildText(giftItemIndex.name,name)

widget:SetChildButtonClick(giftItemIndex.btnClick,function()
self:selectGift(i)
end)


local isSelect=self.giftIndex==i
widget:SetChildActive(giftItemIndex.select,isSelect)


local reddot=self:getGiftReddot(i)
widget:SetChildActive(giftItemIndex.reddot,reddot)
local cfgCount=#scrollViewItemCfg
local cfgIndex=i%cfgCount
cfgIndex=cfgIndex==0 and cfgCount or cfgIndex
local posCfg=scrollViewItemCfg[cfgIndex]
widget:SetChildAnchoredPosition(giftItemIndex.bg,Vector2(posCfg.bg.x,posCfg.bg.y))
widget:SetChildRotation(giftItemIndex.bg,0,0,posCfg.bg.rz)
widget:SetChildAnchoredPosition(giftItemIndex.select,Vector2(posCfg.select.x,posCfg.select.y))
widget:SetChildRotation(giftItemIndex.select,0,0,posCfg.select.rz)
widget:SetChildAnchoredPosition(giftItemIndex.reddot,Vector2(posCfg.reddot.x,posCfg.reddot.y))
widget:SetChildRotation(giftItemIndex.reddot,0,0,posCfg.reddot.rz)
widget:SetChildAnchoredPosition(giftItemIndex.name,Vector2(posCfg.name.x,posCfg.name.y))
widget:SetChildRotation(giftItemIndex.name,0,0,posCfg.name.rz)
end

local jumpIndex=self.giftIndex-1
self.giftListScrollView:setChildScrollViewSelectItem(jumpIndex,false,false,true)
self.giftListScrollView:setChildScrollRectEnable(isEnable)
end

function UISubAct_xiantuzhuli:refreshGiftList()
local rewards=self.rewards
local count=#rewards
local grids=self.giftListScrollView:getChildScrollViewItemWidgets()
for i=1,count do
local itemIndex=i
local widget=grids[itemIndex-1]

local reddot=self:getGiftReddot(i)
widget:SetChildActive(giftItemIndex.reddot,reddot)
end
end


function UISubAct_xiantuzhuli:initZhuLiList()


local curPack=self.rewards[self.giftIndex]
local zhuliList=curPack[4]
local listCount=#zhuliList
self.zhuliGrid:setChildLayoutGroupCreateItems(listCount)
local grids=self.zhuliGrid:getChildLayoutGroupGridList()
for i=1,listCount do
local item=grids[i-1]
local temp=zhuliList[i]
local num=temp[1]
local reward=temp[2][1]

local posY=i*stepHeight
item:SetChildAnchoredPosition(-1,Vector2(91.5,-posY))

local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickItem(i,itemid)
end)

item:SetChildText(1,num)

item:SetChildActive(2,false)
end
local content_height=listCount*stepHeight+bottomOffset
self.zhuliContent:setChildSizeDelta(183,content_height)

local max_height=listCount*stepHeight
self.zhuliProgressBar:setChildSizeDelta(13,max_height)
end

function UISubAct_xiantuzhuli:refreshZhuLiList()
local curPack=self.rewards[self.giftIndex]
local zhuliList=curPack[4]
local listCount=#zhuliList
local grids=self.zhuliGrid:getChildLayoutGroupGridList()
local recvIndex=self:getZhuLiRecvIndex(self.giftIndex)
local curCount=self:getZhuLiCount(self.giftIndex)
local curIndex=0
for i=1,listCount do
local item=grids[i-1]
local temp=zhuliList[i]
local num=temp[1]
local canReward=curCount>=num
local recvFlag=recvIndex>=i

item:SetChildActive(3,recvFlag)

item:SetChildActive(4,canReward)



item:SetChildActive(6,canReward and not recvFlag)
curIndex=canReward and i or curIndex
end
self.endRecvIndex=curIndex
local max_height=listCount*stepHeight

local cur_height
if curIndex>=listCount then
cur_height=max_height
elseif curIndex<=0 then
cur_height=curCount/zhuliList[curIndex+1][1]*stepHeight
else
local rate=(curCount-zhuliList[curIndex][1])/(zhuliList[curIndex+1][1]-zhuliList[curIndex][1])
cur_height=(curIndex+rate)*stepHeight
end







self.zhuliProgress:setChildSizeDelta(13,cur_height)
self.zhuliProgressEx:setActive(curCount>0)
local targetIndex=self:getjumpIndex()

self:jumpTargetIndexItem_First(targetIndex)
end


function UISubAct_xiantuzhuli:jumpTargetIndexItem_First(index)
local curPack=self.rewards[self.giftIndex]
local zhuliList=curPack[4]
local listCount=#zhuliList
local content_height=listCount*stepHeight+bottomOffset
local showHeight=self.zhuliScrollView:getChildRectHeight()
local moveHeight=index*stepHeight-veiwTopoffest
local moveMax_Height_=content_height-showHeight
if moveHeight>moveMax_Height_ then
moveHeight=moveMax_Height_
end
local moveY=moveHeight

self.zhuliContent:setLocalPosY(moveY)
end










































function UISubAct_xiantuzhuli:getGiftReddot(giftIndex)
return self.sub_actInfo:checkGiftReddot(giftIndex)
end

function UISubAct_xiantuzhuli:getCommonReddot(giftIndex)
return self.sub_actInfo:checkFreeReddot(giftIndex)
end

function UISubAct_xiantuzhuli:getBuyCount(giftIndex)
return self.sub_actInfo:getBuyCount(giftIndex)
end

function UISubAct_xiantuzhuli:getZhuLiCount(giftIndex)
return self.sub_actInfo:getZhuLiCount(giftIndex)
end

function UISubAct_xiantuzhuli:getZhuLiRecvIndex(giftIndex)
return self.sub_actInfo:getRecvIndex(giftIndex)
end


function UISubAct_xiantuzhuli:getjumpIndex()
local maxShowCount=6
local curPack=self.rewards[self.giftIndex]
local zhuliList=curPack[4]
local listCount=#zhuliList
local recvIndex=self:getZhuLiRecvIndex(self.giftIndex)
local curCount=self:getZhuLiCount(self.giftIndex)
local recvCount=0
local canRecvCount=0
local firstCanRecvIndex
local firstNotRecvIndex
for i=1,listCount do
local temp=zhuliList[i]
local num=temp[1]
local canReward=curCount>=num
local recvFlag=recvIndex>=i
if recvFlag then
recvCount=recvCount+1
end
if not recvFlag and canReward then
canRecvCount=canRecvCount+1
if not firstCanRecvIndex then
firstCanRecvIndex=i
end
end
end


if canRecvCount>=maxShowCount then
return firstCanRecvIndex
end
local flagCount=recvCount+canRecvCount

if flagCount>=listCount then

if canRecvCount>0 then
return flagCount-maxShowCount+1
end

return listCount
end

firstNotRecvIndex=flagCount+1


if flagCount>=maxShowCount then
return firstNotRecvIndex-maxShowCount+1
else

return 1
end
end



function UISubAct_xiantuzhuli:onCommonReward()
local freegiftList=self.config.freegiftList
local giftid=freegiftList[self.giftIndex]
call_activitiesHandle_func("activitiesHandle_xiantuzhuli","reqFreeReward",self.actID,self.subid,giftid)
end

function UISubAct_xiantuzhuli:onBuyBtn()
local curPack=self.rewards[self.giftIndex]
if type(curPack[2])=='number'then
local rechargeId=curPack[2]
call_activitiesHandle_func("activitiesHandle_xiantuzhuli","reqBuy",self.actID,self.subid,rechargeId,self.giftIndex,1)
else
local itemId=curPack[2][1][1]
local itemCount=curPack[2][1][2]
if moneyConfig.isMoney(itemId)then
local func=function()

call_activitiesHandle_func("activitiesHandle_xiantuzhuli","reqReward",self.actID,self.subid,1,self.giftIndex,1)
end
moneySystem:useMoney(itemId,itemCount,func,WARNING_TYPE.eWarning)
else
if itemsModel.getCount(itemId)>=itemCount then
call_activitiesHandle_func("activitiesHandle_xiantuzhuli","reqReward",self.actID,self.subid,1,self.giftIndex,1)
else
gainControl:showGainWin(itemId)
end
end


end
end

function UISubAct_xiantuzhuli:onNpcClicker()
self:doSpeaking()
end



function UISubAct_xiantuzhuli:selectGift(index)
if index==self.giftIndex then
return
end
local oldIndex=self.giftIndex
local widget=self.giftListScrollView:getChildScrollViewItemWidget(oldIndex-1)
widget:SetChildActive(giftItemIndex.select,false)
widget=self.giftListScrollView:getChildScrollViewItemWidget(index-1)
widget:SetChildActive(giftItemIndex.select,true)
self.giftIndex=index
self:refresh()
end


function UISubAct_xiantuzhuli:onClickRewardItem(itemId,index,guid,attach)


if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UISubAct_xiantuzhuli:onClickItem(index,itemId)

if self.sub_actInfo:checkRecvState(self.giftIndex,index)then
if not self.sub_actInfo:checkBuyState(self.giftIndex)then
UIManager.error(FMT.fmt("需购买{0}礼包",self.config.name[self.giftIndex]))
return
end
if self.endRecvIndex then
call_activitiesHandle_func("activitiesHandle_xiantuzhuli","reqReward",self.actID,self.subid,2,self.giftIndex,self.endRecvIndex)
end
return
end


if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId})
end


function UISubAct_xiantuzhuli:refreshNPCModel()
local fadeTime=0.5
local npcModel=self.config.npcModel
local modelId=npcModel[1]
local scale=npcModel[2]
local modelOffSet=npcModel[3]
local speakObjOffSet=npcModel[4]
local isFlipX=npcModel[5]==1
self.npcModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand,false,false,fadeTime)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])
self.npcModel:setChildUIModelShowFlipX(isFlipX)
self.speakObj:setChildAnchoredPos(speakObjOffSet[1],speakObjOffSet[2])

self.npcTalkTime=self.config.npcTalkTime
self.npcTalkShowTime=self.config.npcTalkShowTime
self.npcTalk=self.config.npcTalk
self.animId=self.config.animId

self:delayDo(0.3,function()
self:doSpeaking()
end)
end


function UISubAct_xiantuzhuli:doSpeaking()
self:clearSpeakTimer()
local speakList=self.npcTalk or{}
local speakIndex=math.random(1,#speakList)




local speakStr=speakList[speakIndex]
if not speakStr then
return
end
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
if self.animId then
self.npcModel:setChildModelAnimationState(self.animId)
end
self:doTalkAnim()
end


function UISubAct_xiantuzhuli:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end)
end


function UISubAct_xiantuzhuli:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)
self.npcModel:setChildModelAnimationState(eAnimationID.stand)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end


function UISubAct_xiantuzhuli:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UISubAct_xiantuzhuli:onTipsBtn()
local descFMT='UIXTZL_shuoming_%s'
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=descFMT})


end