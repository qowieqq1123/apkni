







def_class("UISubAct_tongbaoxianshi_Win",UIWindowBase)









function UISubAct_tongbaoxianshi_Win:bindComponents()

self.name=UIText.get(self,0)
self.packScrollerView=UIObject.get(self,1)
self.sortTypeDropdown=UIDropdown.get(self,2)
self.time=UIText.get(self,3)
self.moneyRoot_1=UIObject.get(self,4)
self.moneyRoot_2=UIObject.get(self,5)
self.moneyRoot_3=UIObject.get(self,6)
self.moneyRoot_4=UIObject.get(self,7)
self.moneyRoot_5=UIObject.get(self,8)
self.speakObj=UIObject.get(self,9)
self.speakText=UIText.get(self,10)
self.Content=UIObject.get(self,11)
self.npcModel=UIObject.get(self,12)
self.moneyRoot={
self.moneyRoot_1,
self.moneyRoot_2,
self.moneyRoot_3,
self.moneyRoot_4,
self.moneyRoot_5,
}



end


function UISubAct_tongbaoxianshi_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.moneyRoot_1);self.moneyRoot_1=nil;
_UIObject_release(self.moneyRoot_2);self.moneyRoot_2=nil;
_UIObject_release(self.moneyRoot_3);self.moneyRoot_3=nil;
_UIObject_release(self.moneyRoot_4);self.moneyRoot_4=nil;
_UIObject_release(self.moneyRoot_5);self.moneyRoot_5=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
self.moneyRoot=nil;
end



















function UISubAct_tongbaoxianshi_Win:onLoaded(...)
self:bindComponents()
self.npcModel:setChildUIModelShowTarget(4016,0.3,{},eAnimationID.stand)

self.speakText:setText("欢迎仙友光顾鄙人小店，我这儿的每个宝物，都可以选择合适的兑换方式，欢迎多多选购")

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self._onMoneyChange=function(...)self:onMoneyChange(...)end
self._onItemChange=function(...)self:onItemChange(...)end
self._onShowPrize=function(...)self:onShowPrize(...)end
self:addNotify(notifyConfig.on_money_changed,self._onMoneyChange)
self:addNotify(notifyConfig.on_item_changed,self._onItemChange)
self:addNotify(notifyConfig.onShowPrize,self._onShowPrize)
end

function UISubAct_tongbaoxianshi_Win:onMoneyChange(moneyType,lastVal,val)
if UIManager:isActive("UISubAct_tongbaoxianshi_Win")then
local moneyList=self.config.moneyList
for i,v in ipairs(moneyList)do
if v==moneyType then
self:freshMoneyValue(i,val)
break
end
end

end


end

function UISubAct_tongbaoxianshi_Win:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
if UIManager:isActive("UISubAct_tongbaoxianshi_Win")then
local moneyList=self.config.moneyList
for i,v in ipairs(moneyList)do
if v==itemid then
self:freshMoneyValue(i,itemcount)
break
end
end

end
end

function UISubAct_tongbaoxianshi_Win:onShowPrize(prizeType,temp,effectData)
if prizeType==ePrizeType.eCommon then
self:refresh(nil,true)
end
end


function UISubAct_tongbaoxianshi_Win:__delete()
self:unbindComponents()
end




function UISubAct_tongbaoxianshi_Win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eTongBaoXianShi
self.subid=argtable.sub_act_id

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)


local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)or{}
local unlockFlag=data.unlockReddot
if unlockFlag then
data.unlockReddot=nil
activitiesModel:setSubActInfoData(self.actid,self.subType,self.subid,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
end


self:refreshMoney()

local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
local actStartTime=0
if info then
actStartTime=info.start_time
end
self.actStartTime=actStartTime
self:setSortTypeList()

self:refreshTime(info)
end

function UISubAct_tongbaoxianshi_Win:refreshTime(info)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("{0}结束",timeHelper.format_time_stamp2(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("{0}结束",timeHelper.format_time_stamp2(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end

end)
else
self.time:setText("活动已结束")
self.isOver=true
end
end

function UISubAct_tongbaoxianshi_Win:refresh(jumpId,jumpBuyIdx)
local list=self:getSortList()

self.packScrollerView:setChildScrollViewCreateGrids(#list,1)

local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
local jumpIdx=1
for i=1,count do
local item=grids[i-1]
if item then
self:refreshItem(i,item,list[i])
if jumpId==list[i].id then
jumpIdx=i
end
end
end

if jumpBuyIdx then
jumpIdx=self.selectIndex

end

if jumpIdx then

end
end

function UISubAct_tongbaoxianshi_Win:refreshItem(index,widget,data)
local infoData=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)or{}
local exchangeList=infoData.exchangeList or{}
local exchange=exchangeList[data.id]or 0
local config=data.config
local dayReset=config.dayReset
local startTime=config.startTime
local dhCount=config.dhCount or-1
local itemId=config.itemId
local itemNum=config.itemNum
local conf={showname=true,showcount=itemNum>1,showCountBG=itemNum>1,itemcount=itemNum,nomalname=true,showStageBg=true}
local item={itemid=itemId,itemcount=itemNum}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
prop[PropIndex(DataPropKey.eWidgetActive,10)]=itemsConfig.isRare(itemId)

widget:SetChildPropData(9,prop)
widget:SetBaseItemClickEvent(9,itemsComponentHelper.onItemClick)
local fangAnList=config.fangAn

local selectFangAnList=infoData.selectFangAn or{}
local selectIndex=selectFangAnList[data.id]

local isSelect=selectIndex~=nil

widget:SetChildLayoutGroupCreateItems(0,3)
local grids=widget:GetChildLayoutGroupGridList(0)
for i=0,grids.Count-1 do
local grid=grids[i]
if isSelect then
local fangAn=fangAnList[selectIndex][i+1]
if fangAn then
local have=itemsModel.getCount(fangAn[1])
local countStr
if itemsConfig.isMoney(fangAn[1])then
if have>=fangAn[2]then
countStr=mathHelper.formatNumber(fangAn[2])
else
countStr=FMT.fmt("<color=#c82c2c>{0}</color>",mathHelper.formatNumber(fangAn[2]))
end
else
if have>=fangAn[2]then
countStr=FMT.fmt("{0}/{1}",mathHelper.formatNumber(have),mathHelper.formatNumber(fangAn[2]))
else
countStr=FMT.fmt("<color=#c82c2c>{0}/{1}</color>",mathHelper.formatNumber(have),mathHelper.formatNumber(fangAn[2]))
end
end

local conf={showname=false,showcount=true,showCountBG=false,itemcount=countStr,showStageBg=true}
local item={itemid=fangAn[1],itemcount=fangAn[2]}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
grid:SetChildActive(-1,true)
grid:SetChildActive(0,true)
grid:SetChildActive(1,false)
grid:SetChildActive(2,false)
grid:SetChildPropData(0,prop)
grid:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
else
grid:SetChildActive(-1,false)
end
grid:SetChildText(4,"")
else
grid:SetChildActive(0,false)
grid:SetChildActive(1,true)
grid:SetChildActive(2,true)
grid:SetChildText(4,"0/0")
grid:SetChildButtonClick(2,function()
self:showWindow("UITBXSDuiHuanWin",{id=data.id,list=fangAnList,actid=self.actid,subid=self.subid})
end)
end
end
widget:SetChildActive(7,isSelect)
if isSelect then
widget:SetChildButtonClick(7,function()
self:showWindow("UITBXSDuiHuanWin",{id=data.id,actid=self.actid,subid=self.subid,list=fangAnList,selectIndex=selectIndex})
end)
end

local showBtn=true

if startTime then
local time=timeHelper.getServerShortTime()
local endTime=startTime+self.actStartTime
local leftTime=endTime-time
showBtn=leftTime<=0
if not showBtn then
local timeStr=timeHelper.format_time_stamp7(leftTime)
widget:SetChildText(8,FMT.fmt('{0}后开启',timeStr))
else
widget:SetChildText(8,"")
end
else
widget:SetChildText(8,"")
end
widget:SetChildGray(9,(not showBtn)or(dhCount>0 and dhCount-exchange<=0))
widget:SetChildActive(11,showBtn and((dhCount>0 and dhCount-exchange>0)or dhCount<0))
widget:SetChildActive(5,dhCount>0 and dhCount-exchange<=0)
local reddot=false
if showBtn then
if dhCount>0 then
widget:SetChildText(10,FMT.fmt("可兑换{0}",dhCount-exchange))
else
widget:SetChildText(10,"")
end
if selectIndex then
reddot=true
for i,v in ipairs(fangAnList[selectIndex])do
local have=itemsModel.getCount(v[1])
if have<v[2]then
reddot=false
break
end
end
end
widget:SetChildActive(4,dayReset==1)
widget:SetChildButtonClick(2,function()
if selectIndex then
local fangAn=fangAnList[selectIndex]
self:useItem(data.id,selectIndex,dhCount,exchange,fangAn,{itemId,itemNum},index)
else

self:showWindow("UITBXSDuiHuanWin",{id=data.id,list=fangAnList,actid=self.actid,subid=self.subid})
end
end)
end
widget:SetChildActive(12,reddot)
end

function UISubAct_tongbaoxianshi_Win:useItem(id,selectIndex,dhCount,exchange,fangAn,showItem,sortIdx)
local canBuy=true
if dhCount>0 then
canBuy=dhCount-exchange>0
end
if canBuy then
local maxCount=dhCount-exchange
for i,v in ipairs(fangAn)do
local have=itemsModel.getCount(v[1])
if v[1]==eMoneyType.mtLingYu then
have=have+itemsModel.getCount(eMoneyType.mtXianYu)
end
if have<v[2]then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(v[1])))
gainControl:showGainWin(v[1])
return
else
local min=math.floor(have/v[2])
if min<maxCount then
maxCount=min
end
end
end
if maxCount>1 then
UIManager:showWindow("UICommonBuyDialogWin",{rewards=fangAn,comfirmText="兑换",name="购买礼包",leftNum=0,maxcount=maxCount,callback=function(num)
self.refreshInit=true
local list={}
for i,v in ipairs(fangAn)do
table.insert(list,{v[1],v[2]*num})
end
moneySystem:countAndExchangeEx(list,{[2]=3},
function()
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({1,id,selectIndex,num}))
end,WARNING_TYPE.eWarning)

end})
else
self.refreshInit=true
local list={}
for i,v in ipairs(fangAn)do
table.insert(list,{v[1],v[2]})
end
moneySystem:countAndExchangeEx(list,{[2]=3},
function()
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({1,id,selectIndex,1}))
end,WARNING_TYPE.eWarning)
end

self.selectIndex=sortIdx
else
UIManager.error("兑换次数不足")
end
end

function UISubAct_tongbaoxianshi_Win:refreshMoney()
local moneyList=self.config.moneyList
for i,v in ipairs(moneyList)do
local moneyRoot=self.moneyRoot[i]
moneyRoot:setActive(true)
local moneyType=v
local moneyVal=0
local widget=moneyRoot:getChildWidgetBase()
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,true)
widget:SetChildButtonClick(3,function()
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end)
end
end

function UISubAct_tongbaoxianshi_Win:freshMoneyValue(index,lastVal)
local moneyRoot=self.moneyRoot[index]
if moneyRoot then
local widget=moneyRoot:getChildWidgetBase()
local moneyStr=mathHelper.formatNumber(lastVal,true)
widget:SetChildText(1,moneyStr)
end
end

function UISubAct_tongbaoxianshi_Win:setSortTypeList()
local typeList=activitiesHandle_tongbaoxianshi:getTypeList()
self.sortTypeList=typeList
local typeNameList=activitiesHandle_tongbaoxianshi:getNameList()
self.sortTypeDropdown:setOption(typeNameList)
self.sortType=typeList[1]
self.sortTypeIndex=self.sortType
self.sortCondition={}
self.sortOrder=eSortOrder.eDown
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
end

function UISubAct_tongbaoxianshi_Win:getSortList()
local dhList=self.config.dhList
local sortType=self.sortType
local list={}
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)or{}

local time=timeHelper.getServerShortTime()
local exchangeList=data.exchangeList or{}
for i,v in ipairs(dhList)do
local config=cfgHelper.get(cfg_tongbaoxianshiduihuanconfig_get,v)
local dhType=config.dhType

local sort=i
local dhCount=config.dhCount or-1
local startTime=config.startTime
local exchange=exchangeList[v]or 0
if dhCount>0 then
if dhCount-exchange<=0 then
sort=sort+1000000
end
end

if startTime then
if(startTime+self.actStartTime)-time>0 then
sort=sort+100000
end
end

if(dhType==sortType or sortType==0)then
table.insert(list,{id=v,config=config,exchange=exchange,sort=sort})
end
end

table.sort(list,function(a,b)
return a.sort<b.sort
end)

return list
end


function UISubAct_tongbaoxianshi_Win:onDropdownChange(idx)

idx=idx+1
if self.sortTypeIndex==idx then return end
self.sortTypeIndex=idx
self.sortType=self.sortTypeList[idx]

self:refresh()
end


function UISubAct_tongbaoxianshi_Win:onHide()

end



