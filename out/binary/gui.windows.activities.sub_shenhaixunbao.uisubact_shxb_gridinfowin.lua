







def_class("UISubAct_SHXB_gridInfoWin",UIWindowBase)









function UISubAct_SHXB_gridInfoWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.spGridInfo=UIObject.get(self,2)
self.itemGridInfo=UIObject.get(self,3)
self.eventGridInfo=UIObject.get(self,4)
self.rareGridInfo=UIObject.get(self,5)
self.boxGridInfo=UIObject.get(self,6)
self.titleText=UIText.get(self,7)

self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UISubAct_SHXB_gridInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spGridInfo);self.spGridInfo=nil;
_UIObject_release(self.itemGridInfo);self.itemGridInfo=nil;
_UIObject_release(self.eventGridInfo);self.eventGridInfo=nil;
_UIObject_release(self.rareGridInfo);self.rareGridInfo=nil;
_UIObject_release(self.boxGridInfo);self.boxGridInfo=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end
















local _boxItemQualityIconNameList={
[1]="image_tuisongpj_1",
[2]="image_tuisongpj_2",
[3]="image_tuisongpj_3",
[4]="image_tuisongpj_4",
[5]="image_tuisongpj_5",
}




function UISubAct_SHXB_gridInfoWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_SHXB_gridInfoWin:__delete()
self:unbindComponents()
end




function UISubAct_SHXB_gridInfoWin:onShow(argtable,afterOnloaded)
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
end

self.gridIdx=argtable and argtable.gridIdx


self.myData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.sub_actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

self:refresh()
end


function UISubAct_SHXB_gridInfoWin:onHide()

end

function UISubAct_SHXB_gridInfoWin:refresh()
local mapData=self.myData.mapData
local gridIdx=self.gridIdx
local gridData=mapData[self.gridIdx]
if gridData and next(gridData)~=nil then
local itemGridData=gridData.itemGridData
local eventGridData=gridData.eventGridData
local boxGridData=gridData.boxGridData
local rareGridData=gridData.rareGridData
local spGridData=gridData.spGridData
local gridTitleStr=""

local isShowStartPoint=spGridData~=nil
self.spGridInfo:setActive(isShowStartPoint)
if isShowStartPoint then
local widget=self.spGridInfo:getWidgetBase()
local gridCfgId=spGridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
local infoParams=gridCfg.infoParams
local desc1=infoParams[1]
local desc2=infoParams[2]
widget:SetChildText(0,desc1)
widget:SetChildText(1,desc2)
gridTitleStr="起点格"
end

local isShowBox=boxGridData~=nil
self.boxGridInfo:setActive(isShowBox)
if isShowBox then
local widget=self.boxGridInfo:getWidgetBase()
local gridCfgId=boxGridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
local infoParams=gridCfg.infoParams
local rewards=infoParams
widget:SetChildLayoutGroupCreateItems(0,#rewards,function(index)
local item=widget:GetChildLayoutGroupGridItem(0,index-1)
item:SetChildActive(-1,true)
local itemWidget=item:GetChildWidgetBase(0)
local reward=rewards[index]
local itemid=reward[1]
local count=reward[2]
local rate=reward[3]
local countStr=mathHelper.formatNumber(count)
local showCountBG=true
itemWidget:SetChildActive(4,showCountBG)
itemWidget:SetChildText(5,countStr)

local iconName=iconHelper.getIconName(itemid)
itemWidget:SetChildIcon(1,iconName,true)









local gailvStr=FMT.fmt("{0}%",rate)
itemWidget:SetChildText(3,gailvStr)

itemWidget:SetChildActive(-1,true)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(itemid)
end)

end)
gridTitleStr="宝箱格"
end

local isShowItem=itemGridData~=nil
self.itemGridInfo:setActive(isShowItem)
if isShowItem then
local widget=self.itemGridInfo:getWidgetBase()
local gridExp=itemGridData.exp or 0
local gridCfgId=itemGridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
local expCfg=gridCfg.levelExp
local level=1
local showExp=0
local levelExp=0
local lastLevelExp=0
local maxLevel=#expCfg+1
for idx,lvExp in ipairs(expCfg)do
local lv=idx+1
showExp=gridExp-lastLevelExp
levelExp=lvExp-lastLevelExp
if gridExp>=lvExp then
level=lv
else
break
end
lastLevelExp=lvExp
end
local levelStr=FMT.fmt("等级：{0}",level)
local expStr=""
local isMaxLevel=level>=maxLevel
local nowLevelShowStr="当前等级奖励预览"
if isMaxLevel then
expStr="已满"
nowLevelShowStr=FMT.cfmt1(FONT_COLOR.eOrangeColor,nowLevelShowStr)
else
expStr=FMT.fmt("经验值：{0}/{1}",showExp,levelExp)
end
widget:SetChildText(0,levelStr)
widget:SetChildText(1,expStr)
widget:SetChildText(5,nowLevelShowStr)

local infoParams=gridCfg.infoParams
local nowLvParams=infoParams[level]
local nowLvShowItemCount=nowLvParams[1]
local nowLvRewards=nowLvParams[2]
local itemWidget=widget:GetChildWidgetBase(2)
local nowLvShowItemCountStr=mathHelper.formatNumber(nowLvShowItemCount)
itemWidget:SetChildText(3,nowLvShowItemCountStr)






local isShowNext=not isMaxLevel
widget:SetChildActive(4,isShowNext)
if isShowNext then
local nextLvParams=infoParams[level+1]
local nextLvShowItemCount=nextLvParams[1]
local nextLvRewards=nextLvParams[2]

local itemWidget=widget:GetChildWidgetBase(3)
local nextLvShowItemCountStr=mathHelper.formatNumber(nextLvShowItemCount)
itemWidget:SetChildText(3,nextLvShowItemCountStr)





end

local count=#nowLvRewards

widget:SetChildLayoutGroupCreateItems(6,count,function(i)
local item=widget:GetChildLayoutGroupGridItem(6,i-1)
local reward=nowLvRewards[i]
local itemId=reward[1]
local itemCount=reward[2]
local rate=reward[3]
local itemCountStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
itemCountStr=mathHelper.formatNumber(itemCount)
end

local conf={itemid=itemId,itemcount=itemCountStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildActive(-1,true)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


local gailvStr=FMT.fmt("{0}%",rate)
item:SetChildText(1,gailvStr)
end)
gridTitleStr="道具格"
end

local isShowRare=rareGridData~=nil
self.rareGridInfo:setActive(isShowRare)
if isShowRare then
local widget=self.rareGridInfo:getWidgetBase()
local gridCfgId=rareGridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
local infoParams=gridCfg.infoParams
local rewards=infoParams
widget:SetChildScrollViewCreateGrids(0,#rewards,5)
local grids=widget:GetChildScrollViewItemWidgets(0)
for index=1,grids.Count do
local item=grids[index-1]
item:SetChildActive(-1,true)
local reward=rewards[index]
local itemid=reward[1]
local count=reward[2]
local rate=reward[3]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local gailvStr=FMT.fmt("{0}%",rate)
item:SetChildText(1,gailvStr)

item:SetChildActive(-1,true)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
gridTitleStr="珍稀格"
end

local isShowEvent=eventGridData~=nil
self.eventGridInfo:setActive(isShowEvent)
if isShowEvent then
local widget=self.eventGridInfo:getWidgetBase()
local gridCfgId=eventGridData.confId
local gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)

local infoParams=gridCfg.infoParams
local eventDescList=infoParams
widget:SetChildLayoutGroupCreateItems(0,#eventDescList,function(index)
local item=widget:GetChildLayoutGroupGridItem(0,index-1)
local descData=eventDescList[index]
local descStr=descData[1]
local rate=descData[2]
local iconName=descData[3]
local iconAb=descData[4]

item:SetChildText(2,descStr)

local gailvStr=FMT.fmt("{0}%",rate)
item:SetChildText(3,gailvStr)

if iconName then
item:SetChildCSImageSprite(1,iconAb,iconName)
local iconSize=1
if index==1 then
iconSize=0.9
end
item:SetChildScale(1,Vector3.New(iconSize,iconSize,iconSize))
end
end)
gridTitleStr="事件格"
end

self.titleText:setText(gridTitleStr)
end
end





function UISubAct_SHXB_gridInfoWin:onClickMask()
self:closeSelf()
end

function UISubAct_SHXB_gridInfoWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UISubAct_SHXB_gridInfoWin:onClickItemGridShowReward(rewardList,widget)
local posWidget=widget
local offset={-166,50}
self:showWindow("UISubAct_SHXB_itemGirdRewardWin",{rewardList=rewardList,posWidget=posWidget,offset=offset})
end
