







def_class("UIAirMiniGame_settlementWin",UIWindowBase)









function UIAirMiniGame_settlementWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.mask=UIButton.get(self,1)
self.bagItemScrollView=UIScrollViewSlow.get(self,2)
self.selectItemInfo=UIObject.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.victoryFlag=UIObject.get(self,5)
self.loseFlag=UIObject.get(self,6)
self.dmgGridsGroup=UIObject.get(self,7)
self.rewardPanel=UIObject.get(self,8)
self.rewardGridGroup=UIObject.get(self,9)
self.exitBtn=UIButton.get(self,10)
self.nextBtn=UIButton.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.exitBtn:setButtonClick(function()self:onExitBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)



end


function UIAirMiniGame_settlementWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.bagItemScrollView);self.bagItemScrollView=nil;
_UIObject_release(self.selectItemInfo);self.selectItemInfo=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.victoryFlag);self.victoryFlag=nil;
_UIObject_release(self.loseFlag);self.loseFlag=nil;
_UIObject_release(self.dmgGridsGroup);self.dmgGridsGroup=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardGridGroup);self.rewardGridGroup=nil;
_UIObject_release(self.exitBtn);self.exitBtn=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
end
















local bagItemCmpIndex={
bg=0,
qualityIcon=1,
icon=2,
select=3,
stageBg=4,
stageText=5,
countBg=6,
countText=7,
suitIcon=8,
}

local dmgItemCmpIndex={
equipItem=0,
itemName=1,
progressBar=2,
progressValue=3,
}

local bagColumn=4
local bagMinRow=4

local oppositeAttrList={
[aiAttributeType.ePriceReduct]=true,
[aiAttributeType.eRecvDamage]=true,
}



function UIAirMiniGame_settlementWin:onLoaded(...)
self:bindComponents()
self.bagItemScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)

self.bagItemScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
end


function UIAirMiniGame_settlementWin:__delete()
self:unbindComponents()
end




function UIAirMiniGame_settlementWin:onShow(argtable,afterOnloaded)
self.resultFlag=argtable and argtable.resultFlag

self:refresh(true)


self:checkShowNewBie()
end


function UIAirMiniGame_settlementWin:onHide()

end

function UIAirMiniGame_settlementWin:refresh(isInit)

local isVictory=self.resultFlag==1
self.victoryFlag:setActive(isVictory)
self.loseFlag:setActive(not isVictory)




self:refreshBagPanel(isInit)


self:refreshEquipDmgPanel()


self:refreshRewardPanel()


self.nextBtn:setActive(false)
end

function UIAirMiniGame_settlementWin:refreshBagPanel(isInit)

self.bagItemList=self:getBagItemSortList()
local count=#self.bagItemList
if isInit then
if count>0 then
self.selectBagItemIndex=1
else
self.selectBagItemIndex=nil
end
end
local minCount=bagMinRow*bagColumn
if count<=0 then
count=minCount
end

local row=math.ceil(count/bagColumn)
if row<bagMinRow then
row=bagMinRow
elseif row>=bagMinRow then
row=row+2
end

self.bagItemScrollView:freshSlowGrids(row*bagColumn,row,bagColumn,isInit)


self:refreshSelectBagItemInfo()
end

function UIAirMiniGame_settlementWin:refreshSelectBagItemInfo()
if self.selectBagItemIndex then

self.selectItemInfo:setActive(true)
local widget=self.selectItemInfo:getWidgetBase()
local itemInfo=self.bagItemList[self.selectBagItemIndex]
local itemId=itemInfo.itemId
local itemConfig=cfgHelper.get(cfg_airitemconfig_get,itemId)


local itemName=itemConfig.name
local itemColor=itemConfig.color
widget:SetChildText(0,FMT.cfmt(itemColor,itemName))


local attrList=self:getItemAttrSortList(itemId)
local grids=widget:GetChildCommonLayoutGroupWidgetList(1)
for i=1,grids.Count do
local attrWidget=grids[i-1]
local attrData=attrList[i]
if attrData then
attrWidget:SetChildActive(-1,true)
local attrId=attrData.attrId
local attrVal=attrData.attrVal
local isPercent=attrData.isPercent
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrName=attrCfg.attrname

attrWidget:SetChildText(0,FMT.fmt("{0}：",attrName))
local attrValStr
if not isPercent then
attrValStr=airController:getAttrStr(attrId,attrVal)
else
local percent=attrVal/100
percent=math.floor(percent)
attrValStr=FMT.fmt("{0}%",percent)
end

if attrVal>=0 then
attrValStr=FMT.fmt("+{0}",attrValStr)
if oppositeAttrList[attrId]then

attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
else
if not oppositeAttrList[attrId]then

attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
end
attrWidget:SetChildText(1,attrValStr)
else
attrWidget:SetChildActive(-1,false)
end
end


local itemDesc=itemConfig.desc
if itemDesc then

if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
itemDesc=string.gsub(itemDesc," ","\194\160")
end
widget:SetChildActive(2,true)
widget:SetChildText(2,FMT.fmt("道具效果：{0}",itemDesc))
else
widget:SetChildActive(2,false)
end
else

self.selectItemInfo:setActive(false)
end
end

function UIAirMiniGame_settlementWin:bindGrid(idx,widget)
widget:SetChildActive(-1,true)
local index=idx
local itemInfo=self.bagItemList[index]
local isTemp=itemInfo==nil
if not isTemp then
local itemid=itemInfo.itemId

local itemcount=itemInfo.itemCount
local itemConfig=cfgHelper.get(cfg_airitemconfig_get,itemid)
local color=itemConfig.color
local stage=itemConfig.stage
local showStage=stage~=nil
local iconName=FMT.fmt("icon_item_{0}",itemConfig.icon)
local stageTitile="品"
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local isSelect=self.selectBagItemIndex==index
local suitIcon=''
local showCountBG=itemcount>1
local countStr=showCountBG and mathHelper.formatNumber(itemcount)or''

widget:SetChildQulaityEx(bagItemCmpIndex.qualityIcon,0,color)
widget:SetChildIcon(bagItemCmpIndex.icon,iconName,false)
widget:SetChildActive(bagItemCmpIndex.select,isSelect)
widget:SetChildActive(bagItemCmpIndex.stageBg,showStage)
widget:SetChildText(bagItemCmpIndex.stageText,stageStr)
widget:SetChildText(bagItemCmpIndex.countText,countStr)
widget:SetChildActive(bagItemCmpIndex.countBg,showCountBG)

widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,-1)
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildActive(4,false)
widget:SetChildText(5,'')
widget:SetChildActive(6,false)
widget:SetChildText(7,'')

widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIAirMiniGame_settlementWin:refreshEquipDmgPanel()

local equipList=airModel:getEquipList()or{}
local dmgGrids=self.dmgGridsGroup:getChildCommonLayoutGroupWidgetList()



local maxDmgVal=0
for i=1,dmgGrids.Count do
local equipDmg=airModel:getStatisticData_getWeaponDmg(i)or 0
if equipDmg>maxDmgVal then
maxDmgVal=equipDmg
end
end

for i=1,dmgGrids.Count do
local widget=dmgGrids[i-1]
local itemId=equipList[i]
local itemWidget=widget:GetChildWidgetBase(dmgItemCmpIndex.equipItem)
if itemId then
widget:SetChildActive(-1,true)
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)

local prop={}
local iconName=FMT.fmt("icon_item_{0}",itemCfg.icon)
local itemColor=itemCfg.color
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetText,3)]=''
prop[PropIndex(DataPropKey.eWidgetText,4)]=''
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false
widget:SetChildActive(dmgItemCmpIndex.equipItem,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickBagEquipItem(i,itemId)
end)


local equipName=itemCfg.name
widget:SetChildText(dmgItemCmpIndex.itemName,equipName)


local equipDmg=airModel:getStatisticData_getWeaponDmg(i)or 0
widget:SetChildProgressValue(dmgItemCmpIndex.progressBar,equipDmg,maxDmgVal)
widget:SetChildProgressText(dmgItemCmpIndex.progressBar,mathHelper.formatNumber(equipDmg))
else
widget:SetChildActive(-1,false)
end
end
end

function UIAirMiniGame_settlementWin:refreshRewardPanel()
local rewardList=airModel:getSettlementRewardList()
if rewardList and next(rewardList)then

self.rewardPanel:setActive(true)
self.rewardGridGroup:setChildLayoutGroupCreateItems(#rewardList,function(index)
local widget=self.rewardGridGroup:getChildLayoutGroupGridItem(index-1)
local reward=rewardList[index]
local itemid=reward.itemid
local itemCount=reward.num
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end)
else

self.rewardPanel:setActive(false)
end

end

function UIAirMiniGame_settlementWin:getItemAttrSortList(itemId)
if not self.itemAttrListLookup then
self.itemAttrListLookup={}
end

if self.itemAttrListLookup[itemId]then
return self.itemAttrListLookup[itemId]
end
local attrListLookup=airModel:getItemAttrListLookup(itemId)
local sortList={}
for attrId,v in pairs(attrListLookup)do
local sortId
if not v.cfgIdx then
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
sortId=attrCfg.showSortId
else
sortId=v.cfgIdx
end
sortList[#sortList+1]={
attrId=attrId,
attrVal=v.val,
isPercent=v.isPercent,
sortId=sortId,
}
end

table.sort(sortList,function(a,b)
return a.sortId<b.sortId
end)

self.itemAttrListLookup[itemId]=sortList
return self.itemAttrListLookup[itemId]
end

function UIAirMiniGame_settlementWin:getBagItemSortList()
local bagItemList=airModel:getItemBag()
local sortList={}
for i,v in ipairs(bagItemList)do
local itemId=v.itemId
local itemConfig=cfgHelper.get(cfg_airitemconfig_get,itemId)
local color=itemConfig.color
sortList[#sortList+1]={
itemId=itemId,
itemCount=v.itemCount,
color=color,
}
end

table.sort(sortList,function(a,b)
if a.color==b.color then
return a.itemId<b.itemId
else
return a.color>b.color
end
end)

return sortList
end




function UIAirMiniGame_settlementWin:onCloseBtn()
end



function UIAirMiniGame_settlementWin:onMask()
end



function UIAirMiniGame_settlementWin:onHelpBtn()
end



function UIAirMiniGame_settlementWin:onExitBtn()

airLevelSystem:onClearNowLevel()
airController:returnBackGame()
self:closeSelf()
end



function UIAirMiniGame_settlementWin:onNextBtn()

UIManager:showWindow("UIFightPrepareLoading",{startCallback=function()
airController:nextLevelGame()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end})
self:closeSelf()
end

function UIAirMiniGame_settlementWin:onClickGrid(id,index,guid,attach)
local itemid=id
if itemid==-1 then return end
local originalSelectBagItemIndex=self.selectBagItemIndex
self.selectBagItemIndex=index


self.bagItemScrollView:freshSlowItem(originalSelectBagItemIndex-1)
self.bagItemScrollView:freshSlowItem(index-1)


self:refreshSelectBagItemInfo()
end

function UIAirMiniGame_settlementWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,showModel=true,})
end

function UIAirMiniGame_settlementWin:onClickBagEquipItem(idx,itemId)
local isVictory=self.resultFlag==1
if not isVictory then

return
end


self:showWindow("UIAirMiniGame_itemTipsWin",{itemId=itemId,itemType=1,fromType=3,equipIndex=idx})
end


function UIAirMiniGame_settlementWin:checkShowNewBie()
if self.resultFlag==0 then
local config=newbieModel.getLookupConfig(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.KongZhanLuaFunc2)
if config then
local newbieId=config.id
if not newbieModel.isFinish(newbieId)then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.KongZhanLuaFunc2)
end
end
end
end