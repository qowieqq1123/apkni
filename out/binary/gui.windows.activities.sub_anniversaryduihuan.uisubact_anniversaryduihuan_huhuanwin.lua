







def_class("UISubAct_AnniversaryDuiHuan_HuHuanWin",UIWindowBase)









function UISubAct_AnniversaryDuiHuan_HuHuanWin:bindComponents()

self.canDHTimes=UIText.get(self,0)
self.canDHTimesDi=UIImage.get(self,1)
self.closeClick=UIButton.get(self,2)
self.frame=UIImage.get(self,3)
self.huhuanBtn=UIButton.get(self,4)
self.huhuanScrollView=UIEnhancedScrollerLua.get(self,5)
self.leftDi=UIButton.get(self,6)
self.leftItem=UIBaseItem.get(self,7)
self.leftTabBtn=UIButton.get(self,8)
self.mbg=UIObject.get(self,9)
self.notHuHuan=UIText.get(self,10)
self.notRecord=UIText.get(self,11)
self.panel_1=UIObject.get(self,12)
self.panel_2=UIObject.get(self,13)
self.recordScrollView=UIObject.get(self,14)
self.rightDi=UIButton.get(self,15)
self.rightItem=UIBaseItem.get(self,16)
self.rightTabBtn=UIButton.get(self,17)
self.root=UIObject.get(self,18)
self.tabList=UIObject.get(self,19)
self.zhezhaoImg=UIImage.get(self,20)

self.closeClick:setButtonClick(function()self:onCloseClick()end)

self.huhuanBtn:setButtonClick(function()self:onHuhuanBtn()end)

self.leftDi:setButtonClick(function()self:onLeftDi()end)

self.leftTabBtn:setButtonClick(function()self:onLeftTabBtn()end)

self.rightDi:setButtonClick(function()self:onRightDi()end)

self.rightTabBtn:setButtonClick(function()self:onRightTabBtn()end)
self.panel={
self.panel_1,
self.panel_2,
}



end


function UISubAct_AnniversaryDuiHuan_HuHuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.canDHTimes);self.canDHTimes=nil;
_UIObject_release(self.canDHTimesDi);self.canDHTimesDi=nil;
_UIObject_release(self.closeClick);self.closeClick=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.huhuanBtn);self.huhuanBtn=nil;
_UIObject_release(self.huhuanScrollView);self.huhuanScrollView=nil;
_UIObject_release(self.leftDi);self.leftDi=nil;
_UIObject_release(self.leftItem);self.leftItem=nil;
_UIObject_release(self.leftTabBtn);self.leftTabBtn=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.notHuHuan);self.notHuHuan=nil;
_UIObject_release(self.notRecord);self.notRecord=nil;
_UIObject_release(self.panel_1);self.panel_1=nil;
_UIObject_release(self.panel_2);self.panel_2=nil;
_UIObject_release(self.recordScrollView);self.recordScrollView=nil;
_UIObject_release(self.rightDi);self.rightDi=nil;
_UIObject_release(self.rightItem);self.rightItem=nil;
_UIObject_release(self.rightTabBtn);self.rightTabBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.zhezhaoImg);self.zhezhaoImg=nil;
self.panel=nil;
end
















local _this
local UISubAct_AnniversaryDuiHuan_huhuanScroller=simple_class(UIEnhancedScroller)




function UISubAct_AnniversaryDuiHuan_HuHuanWin:onLoaded(...)
_this=self
self:bindComponents()
self.tabSelecctIdx=1

self.huhuanscrollscript=UISubAct_AnniversaryDuiHuan_huhuanScroller(self.huhuanScrollView:getGameObject(),self.huhuanScrollView:getCSharpObject(),nil,nil)
end


function UISubAct_AnniversaryDuiHuan_HuHuanWin:__delete()
self:unbindComponents()

_this=nil
end




function UISubAct_AnniversaryDuiHuan_HuHuanWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local selfShareList,otherShareList=self.sub_actInfo:GetShareList()
self.selfShareList=selfShareList or{}
self.otherShareList=otherShareList or{}

self:refreshTabBar()
self:refreshAll()

if afterOnloaded then
if self.sub_actcfg.showHHModel and self.sub_actcfg.showHHModel.bgModel then
local bgModel=self.sub_actcfg.showHHModel.bgModel
self.mbg:setChildUIModelShowTarget(bgModel[1],bgModel[2]or 1,{},eAnimationID.enter,false,false,0,nil)
if bgModel[3]then
self.mbg:setChildUIModelShowTargetOffset(bgModel[3]or 0,bgModel[4]or 0)
end
self.closeClick:setLocalPosX(-386)
else
self.closeClick:setLocalPosX(-303)
self.mbg:setChildUIModelShowTarget(6136,1,{},eAnimationID.enter,false,false,0,nil)
end

local isShowZZ,_ab1,icon1,x,y=self.sub_actInfo:getZZIconFrame()
self.zhezhaoImg:setActive(isShowZZ)
if isShowZZ then
self.zhezhaoImg:setCSImageSprite(_ab1,icon1)
self.zhezhaoImg:setLocalPos(x,y,0)
end

local isShowDi,_ab2,icon2=self.sub_actInfo:getDiIconFrame()
self.canDHTimesDi:setActive(isShowDi)
if isShowDi then
self.canDHTimesDi:setCSImageSprite(_ab2,icon2)
end

local _ab3,icon3=self.sub_actInfo:getIconFrame("image_cailiaohuzhu_db1")
self.frame:setCSImageSprite(_ab3,icon3)

self.root:setChildCanvasGroupAlpha(0)
self:setTimer(0.4,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end

function UISubAct_AnniversaryDuiHuan_HuHuanWin:refreshAll()
for i=1,#self.panel do
self.panel[i]:setActive(self.tabSelecctIdx==i)
end

self:refreshList()

if self.tabSelecctIdx==1 then
self:refreshSelfPanel()
end
end

function UISubAct_AnniversaryDuiHuan_HuHuanWin:refreshTabBar()
local list={"发起\n互换","互换\n列表"}
self.tabList:setChildLayoutGroupCreateItems(#list)
local grids=self.tabList:getChildLayoutGroupGridList()
for i=1,#list do
local widget=grids[i-1]
local tabName=list[i]
local isSelect=self.tabSelecctIdx==i
widget:SetChildActive(0,isSelect)
widget:SetChildText(1,tabName)
local _ab1,icon1=self.sub_actInfo:getIconFrame("button_cailiaohuzhu_anniu2")
local _ab2,icon2=self.sub_actInfo:getIconFrame("button_cailiaohuzhu_anniu1")
widget:SetChildCSImageSprite(-1,_ab1,icon1)
widget:SetChildCSImageSprite(0,_ab2,icon2)

widget:SetChildButtonClick(-1,function(...)
if _this==nil then return end
if _this.tabSelecctIdx==i then
return
end
local oldWidget=grids[_this.tabSelecctIdx-1]
if oldWidget then
oldWidget:SetChildActive(0,false)
end
_this.tabSelecctIdx=i
widget:SetChildActive(0,true)

_this:refreshAll()
end)
end
end

function UISubAct_AnniversaryDuiHuan_HuHuanWin:refreshList()
if self.tabSelecctIdx==1 then
self:refreshSelfList()
else
self:refreshOtheList()
end
local num=self.sub_actInfo:GetMyLeftShareTimes()
self.canDHTimes:setText(string.format("每日可互换数量：%d个",num))
end
function UISubAct_AnniversaryDuiHuan_HuHuanWin:refreshSelfList()
local len=#self.selfShareList
local isShow=len>0

self.notRecord:setActive(not isShow)
self.recordScrollView:setActive(isShow)
if len>0 then
self.recordScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.recordScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
self:refreshSelfItem(i,item)
end
end
end

function UISubAct_AnniversaryDuiHuan_HuHuanWin:refreshSelfItem(index,item)
local data=self.selfShareList[index]
local count=data.item_num

local _ab,icon=self.sub_actInfo:getIconFrame("image_cailiaohuzhu_db1")
item:SetChildCSImageSprite(3,_ab,icon)

local _ab2,icon2=self.sub_actInfo:getIconFrame("image_cailiaohuzhu_hhz")
item:SetChildCSImageSprite(4,_ab2,icon2)

local conf1={showname=false,showcount=true,showCountBG=count>0,itemcount=count,showStageBg=false}
local item1={itemid=data.item_id_1,itemcount=count}
local itemProp1=itemsComponentHelper.getCommonFillData(item1,conf1)
item:SetChildPropData(0,itemProp1)

local conf2={showname=false,showcount=true,showCountBG=count>0,itemcount=count,showStageBg=false}
local item2={itemid=data.item_id_2,itemcount=count}
local itemProp2=itemsComponentHelper.getCommonFillData(item2,conf2)
item:SetChildPropData(1,itemProp2)

item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
item:SetBaseItemClickEvent(1,itemsComponentHelper.onItemClick)

item:SetChildButtonClick(2,function(...)
if _this==nil then return end
_this.sub_actInfo:reqDelShare(data.share_id)
end)
end

function UISubAct_AnniversaryDuiHuan_HuHuanWin:refreshOtheList()
local len=#self.otherShareList
local isShow=len>0

self.notHuHuan:setActive(not isShow)
self.huhuanScrollView:setActive(isShow)

if isShow then
self.huhuanscrollscript:initData(self.otherShareList,120,len)
end
end

function UISubAct_AnniversaryDuiHuan_huhuanScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISubAct_AnniversaryDuiHuan_huhuanScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISubAct_AnniversaryDuiHuan_huhuanScroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
local data=_this.otherShareList[dataIndex]
local count=data.item_num
local isSelf=playerModel:checkActorId(data.actor_id)
local maxNum=_this.sub_actInfo:GetLeftShareTimes(data)

local conf1={showname=false,showcount=true,showCountBG=count>0,itemcount=count,showStageBg=false}
local item1={itemid=data.item_id_1,itemcount=count}
local itemProp1=itemsComponentHelper.getCommonFillData(item1,conf1)
item:SetChildPropData(0,itemProp1)

local conf2={showname=false,showcount=true,showCountBG=count>0,itemcount=count,showStageBg=false}
local item2={itemid=data.item_id_2,itemcount=count}
local itemProp2=itemsComponentHelper.getCommonFillData(item2,conf2)
item:SetChildPropData(1,itemProp2)

item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
item:SetBaseItemClickEvent(1,itemsComponentHelper.onItemClick)

item:SetChildGray(2,maxNum==0)
item:SetChildActive(2,not isSelf)
item:SetChildButtonClick(2,function(...)
if _this==nil then return end
_this:onHuHuanDialog(data)
end)

item:SetChildText(5,data.name)
playerController:setHeadIcon(item,3,{iconInfo=data.iconInfo,scale=1})
item:SetChildButtonClick(4,function(...)
if _this==nil or isSelf then return end
otherPlayerController:openOtherPlayerInfoWin(data.actor_id,nil,actorInterFromType.eCommon)
end)

item:SetChildActive(6,isSelf)
item:SetChildActive(7,isSelf)

local _ab,icon=_this.sub_actInfo:getIconFrame("image_cailiaohuzhu_db1")
item:SetChildCSImageSprite(8,_ab,icon)

local _ab2,icon2=_this.sub_actInfo:getIconFrame("image_cailiaohuzhu_db2")
item:SetChildCSImageSprite(6,_ab2,icon2)
end

function UISubAct_AnniversaryDuiHuan_HuHuanWin:refreshSelfPanel()
local hasLeft=self.meItemData~=nil
self.leftItem:setActive(hasLeft)
self.leftTabBtn:setActive(hasLeft)
if hasLeft then
local count=self.meItemData[2]
local conf={showname=false,showcount=true,showCountBG=count>0,itemcount=count,showStageBg=false}
local item={itemid=self.meItemData[1],itemcount=0}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
self.leftItem:setChildPropData(prop)
self.leftItem:setBaseItemClickEvent(itemsComponentHelper.onItemClick)
end

local hasRight=self.otherItemData~=nil
self.rightItem:setActive(hasRight)
self.rightTabBtn:setActive(hasRight)
if hasRight then
local count=self.otherItemData[2]
local conf={showname=false,showcount=true,showCountBG=count>0,itemcount=count,showStageBg=false}
local item={itemid=self.otherItemData[1],itemcount=0}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
self.rightItem:setChildPropData(prop)
self.rightItem:setBaseItemClickEvent(itemsComponentHelper.onItemClick)
end

local len=#self.selfShareList
local maxLen=self.sub_actcfg.selfMaxShareLen
self.huhuanBtn:setGray(not hasLeft or not hasRight or len>=maxLen)
end


function UISubAct_AnniversaryDuiHuan_HuHuanWin:onHide()

end

function UISubAct_AnniversaryDuiHuan_HuHuanWin:setSelectCose(isMe)
local showItem={}
local defaultCnt=self.meItemData and self.meItemData[2]or 1
for id,v in pairs(self.sub_actcfg.item_list)do
if isMe or not self.meItemData or self.meItemData[1]~=id then
local have=bagModel.getNotExpireItemCountById(id)
local max=self.sub_actInfo:GetMyLeftShareMaxTimes()
if have<max then
max=have
end
table.insert(showItem,{id,isMe and max or self.meItemData[2]})
end
end
local show_data={
type='UIDialougeSelectCountTip',
rewards=showItem,
tips='',
oktext='确认',
tipContent='',
hideSlider=not isMe,
defaultCnt=defaultCnt,
tipsPos=Vector2.New(152,-7),
okcallback=function(id,num)
if isMe then
if num==0 then
UIManager.error("互换材料数量不足")
return
end
self.meItemData={id,num}
if self.otherItemData~=nil then
if self.otherItemData[1]==id then
self.otherItemData=nil
else
self.otherItemData[2]=num
end
end
else
self.otherItemData={id,num}
end
self:refreshSelfPanel()
end,
}
if isMe then
show_data.title='选择互换材料'
if self.meItemData~=nil then
show_data.selectItemId=self.meItemData[1]
end
else
show_data.title='选择求助材料'
show_data.rewardCountDesc='数量:{0}'
if self.otherItemData~=nil then
show_data.selectItemId=self.otherItemData[1]
end
end
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UISubAct_AnniversaryDuiHuan_HuHuanWin:onHuHuanDialog(data)
local itemName1=itemsConfig.getItemName(data.item_id_1)
local itemName2=itemsConfig.getItemName(data.item_id_2)

local maxNum,tipsStr=self.sub_actInfo:GetLeftShareTimes(data)
if maxNum<=0 then
UIManager.error(tipsStr or"兑换次数不足")
return
end
local contentStr=FMT.fmt('您将使用<color=#ca631d>[{0}]</color>换取<color=#ca631d>[{1}]</color>',itemName2,itemName1)
local show_data={
type='UIDialougeHuHuanCountTip',
leftItemId=data.item_id_2,
rightItemId=data.item_id_1,
title='材料互换',
max=math.min(data.item_num,maxNum),
tips='',
oktext='交换',
tipContent='',
content=contentStr,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
_this.sub_actInfo:reqGetOtherShare(data.actor_id,data.share_id,num)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


function UISubAct_AnniversaryDuiHuan_HuHuanWin:rec_shareList()
local selfShareList,otherShareList=self.sub_actInfo:GetShareList()
self.selfShareList=selfShareList or{}
self.otherShareList=otherShareList or{}

self:refreshList()
end


function UISubAct_AnniversaryDuiHuan_HuHuanWin:onCloseClick()
self:closeSelf()
end




function UISubAct_AnniversaryDuiHuan_HuHuanWin:onHuhuanBtn()
if not self.meItemData then
UIManager.error("未选择互换材料")
return
end
if not self.otherItemData then
UIManager.error("未选择求助材料")
return
end
local len=#self.selfShareList
local maxLen=self.sub_actcfg.selfMaxShareLen
if len>=maxLen then
UIManager.error("发起互换列表达到上限")
return
end
self.sub_actInfo:reqAddSelfShare(self.meItemData[1],self.otherItemData[1],self.meItemData[2])

self.meItemData=nil
self.otherItemData=nil
self:refreshSelfPanel()
end



function UISubAct_AnniversaryDuiHuan_HuHuanWin:onLeftTabBtn()
self:setSelectCose(true)
end



function UISubAct_AnniversaryDuiHuan_HuHuanWin:onRightTabBtn()
if not self.meItemData then
UIManager.error("请先选择互换材料")
return
end
self:setSelectCose(false)
end



function UISubAct_AnniversaryDuiHuan_HuHuanWin:onLeftDi()
self:setSelectCose(true)
end



function UISubAct_AnniversaryDuiHuan_HuHuanWin:onRightDi()
if not self.meItemData then
UIManager.error("请先选择互换材料")
return
end
self:setSelectCose(false)
end

