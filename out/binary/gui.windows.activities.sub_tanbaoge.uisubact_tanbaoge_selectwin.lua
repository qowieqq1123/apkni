







def_class("UISubAct_tanbaoge_selectWin",UIWindowBase)









function UISubAct_tanbaoge_selectWin:bindComponents()

self.selectGridsList=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.selectBtn=UIButton.get(self,2)
self.floorText=UIText.get(self,3)
self.bgModel=UIObject.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)



end


function UISubAct_tanbaoge_selectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.selectGridsList);self.selectGridsList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.floorText);self.floorText=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end















local selectItemCmpIndex={
item=0,
self=1,
itemName=2,
dropNum=3,
selectBtn=4,
blackBg=5,
lockTipsText=6,
selloutFlag=7,
selectFlag=8,
bg=9,
}
local _this




function UISubAct_tanbaoge_selectWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_tanbaoge_selectWin:__delete()
_this=nil
self:unbindComponents()
end




function UISubAct_tanbaoge_selectWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
if argtable.floorIndex then
self.floorIndex=argtable.floorIndex
end
if argtable.floorNum then
self.floorNum=argtable.floorNum
end
if argtable.selectRewardItemId then
self.selectRewardItemId=argtable.selectRewardItemId
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5352,1,{},eAnimationID.stand)
end

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self.nowFloor=self.activityData.data.layer

self:refresh(true)
end


function UISubAct_tanbaoge_selectWin:onHide()

end

function UISubAct_tanbaoge_selectWin:refresh(isInit)
if isInit then

self.selectItemList=self:sortSelectList()
end

local count=#self.selectItemList
self.selectGridsList:setChildLayoutGroupCreateItems(count,function(i)
local widget=self.selectGridsList:getChildLayoutGroupGridItem(i-1)
local data=self.selectItemList[i]
local itemId=data.itemId
local isSelect=itemId==self.selectRewardItemId
local isLock=self.nowFloor<data.unlockFloor
local isSellOut=data.isSellOut
local canDropCount=not isSellOut and data.limitCount-data.selectCount or 0


local countStr=data.itemCount>1 and mathHelper.formatNumber(data.itemCount)or''
local showCountBG=data.itemCount>1
local isDaoBing=itemsConfig.isDaoBing(itemId)
local showStage=not isDaoBing
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetBaseItemClickEvent(selectItemCmpIndex.item,function(...)
itemsComponentHelper.onItemClick(...)
end)
widget:SetChildPropData(selectItemCmpIndex.item,prop)
local itemName=itemsModel.getName(itemId)
widget:SetChildText(selectItemCmpIndex.itemName,itemName)

widget:SetChildActive(selectItemCmpIndex.selectFlag,isSelect)
local isShowSelectBtn=not isSelect and not isLock and not isSellOut
widget:SetChildActive(selectItemCmpIndex.selectBtn,isShowSelectBtn)
if isShowSelectBtn then
widget:SetChildButtonClick(selectItemCmpIndex.selectBtn,function(...)
return self:selectItem(itemId)
end)
end

widget:SetChildActive(selectItemCmpIndex.lockTipsText,isLock)
if isLock then
local lockTipsStr=FMT.fmt("{0} 层解锁",data.unlockFloor)
widget:SetChildText(selectItemCmpIndex.lockTipsText,lockTipsStr)
end

widget:SetChildActive(selectItemCmpIndex.selloutFlag,isSellOut)
widget:SetChildActive(selectItemCmpIndex.blackBg,isLock or isSellOut)
widget:SetChildActive(selectItemCmpIndex.bg,not isLock and not isSellOut)

if canDropCount<0 then
canDropCount=0
end
local isShowDropNum=data.limitCount~=-1
widget:SetChildActive(selectItemCmpIndex.dropNum,isShowDropNum)
if isShowDropNum then
local dropNumStr=FMT.fmt("可抽取次数：{0}",canDropCount)
widget:SetChildText(selectItemCmpIndex.dropNum,dropNumStr)
end
end)


self.floorText:setText(FMT.fmt("{0}层",self.nowFloor))
end

function UISubAct_tanbaoge_selectWin:sortSelectList()
local selectCfgList=self.config.zxReward or{}
local selectData=self.activityData:getSelectRewardItemData()or{}
local sortList={}
for i,v in ipairs(selectCfgList)do
local itemId=v[1]
local itemCount=v[2]
local unlockFloor=v[3]
local limitCount=v[4]
local selectCount=selectData[itemId]or 0
local isLock=self.nowFloor<unlockFloor
local isSellOut=false
if limitCount~=-1 and limitCount~=0 then
isSellOut=selectCount>=limitCount
end

local isHide=limitCount==0
if not isHide then
local weight=i

if isLock then
weight=weight+100
end

if isSellOut then
weight=weight+10000
end

local item={
itemId=itemId,
itemCount=itemCount,
unlockFloor=unlockFloor,
limitCount=limitCount,
selectCount=selectCount,
weight=weight,
isSellOut=isSellOut,
}
sortList[#sortList+1]=item
end
end

if next(sortList)then
table.sort(sortList,function(a,b)
return a.weight<b.weight
end)
end
return sortList
end

function UISubAct_tanbaoge_selectWin:selectItem(itemId)
self.selectRewardItemId=itemId
return self:refresh()
end




function UISubAct_tanbaoge_selectWin:onCloseBtn()
self:closeSelf()
end



function UISubAct_tanbaoge_selectWin:onSelectBtn()
if not self.selectRewardItemId then
UIManager.error("请选择一项道具")
return
end

self.activityData:reqTanBaoGeSetSelectRewardItemId(self.floorNum,self.selectRewardItemId)
end

