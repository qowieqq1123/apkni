







def_class("UIAirGameBaoWuWin",UIWindowBase)









function UIAirGameBaoWuWin:bindComponents()

self.bwitem_1=UIObject.get(self,0)
self.bwitem_2=UIObject.get(self,1)
self.bwitem_3=UIObject.get(self,2)
self.bwitem_4=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.Content=UIObject.get(self,5)
self.scrollView=UIObject.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.bwitem={
self.bwitem_1,
self.bwitem_2,
self.bwitem_3,
self.bwitem_4,
}



end


function UIAirGameBaoWuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bwitem_1);self.bwitem_1=nil;
_UIObject_release(self.bwitem_2);self.bwitem_2=nil;
_UIObject_release(self.bwitem_3);self.bwitem_3=nil;
_UIObject_release(self.bwitem_4);self.bwitem_4=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
self.bwitem=nil;
end
















local _this

local CmpBaoWuSlotIndex={
model=0,
costRoot=1,
costTypeName=2,
costList=3,
lockInfo=4,
addLevelBtn=5,
activeBtn=6,
attrType=7,
attrVal=8,
lockTip=10,
lv=11,
activeEffect=12,
upLevelEffect=13,
addLevelReddot=14,
activeReddot=15,
resetBtn=16,
}




function UIAirGameBaoWuWin:onLoaded(...)
self:bindComponents()

_this=self

self:addNotify(notifyConfig.onAirBaoWuUpdate,function(...)
self:refreshAll(...)
self:playEffect(...)
end)
end


function UIAirGameBaoWuWin:__delete()
self:unbindComponents()

_this=nil

if UIManager:isActive('UIAirGameEnterWin')then
UIManager:invokeUIMethod("UIAirGameEnterWin","refreshMoneyBar")
end
if UIManager:isActive('UIAirGamePrepareWin')then
UIManager:invokeUIMethod("UIAirGameEnterWin","refreshMoneyBar")
end
end




function UIAirGameBaoWuWin:onShow(argtable,afterOnloaded)
self.parent=argtable and argtable.parent or self

self:refreshAll()


UIFullAirGameEnterController:showWindow("UITopMoneyWin2",{{eMoneyType.mtBaiLianHuo},{eMoneyType.mtZaoWuGuo},})
end


function UIAirGameBaoWuWin:onHide()

end


function UIAirGameBaoWuWin:refreshAll()

for index=1,4 do
self:freshItem(index)
end
end

function UIAirGameBaoWuWin:freshItem(index)
local itemObj=self.bwitem[index]
local item=itemObj:getWidgetBase()
local baoWuDataList=airGameEnterModel:getBaoWuData()
local bwData=baoWuDataList[index]


local isUnLock=airGameEnterConfig.checkXianBaoOpenCondition(bwData.condition)


local levelInfo=FMT.fmt("等级: {0}级",bwData.level)
item:SetChildText(CmpBaoWuSlotIndex.lv,levelInfo)







item:SetChildGray(CmpBaoWuSlotIndex.model,not bwData.isActive)


local attrParam=bwData.attrParam
local addType=attrParam[1]
local addVal=attrParam[2]
local valStr=airController:getAttrStr(addType,addVal)

item:SetChildText(CmpBaoWuSlotIndex.attrVal,valStr)


local isShowCost=bwData.costList~=nil
item:SetChildActive(CmpBaoWuSlotIndex.costRoot,isShowCost)
if isShowCost then
local costList=bwData.costList
local costLen=#costList
item:SetChildLayoutGroupCreateItems(CmpBaoWuSlotIndex.costList,costLen,function(cindex)
local citem=item:GetChildLayoutGroupGridItem(CmpBaoWuSlotIndex.costList,cindex-1)
local costData=costList[cindex]

local itemId=costData[1]
local itemCount=costData[2]
local isEnough=itemsModel.checkItemEnough(itemId,itemCount)
local isShowCountBg=itemCount>1 or(not isEnough)
local countStr=isShowCountBg and itemCount or""
countStr=isEnough and countStr or toColorString(FONT_COLOR.eRedColor,countStr)

local conf={itemid=itemId,itemcount=countStr,showCountBG=isShowCountBg,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
citem:SetChildPropData(0,propData)

citem:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemId)
end)
end)

item:SetChildText(CmpBaoWuSlotIndex.costTypeName,bwData.costTypeName)
end

local isShowActiveBtn=not bwData.isActive and isUnLock and not bwData.isFullLv
local isShowAddLevelBtn=bwData.isActive and isUnLock and not bwData.isFullLv
item:SetChildActive(CmpBaoWuSlotIndex.activeBtn,isShowActiveBtn)
item:SetChildActive(CmpBaoWuSlotIndex.addLevelBtn,isShowAddLevelBtn)
item:SetChildActive(CmpBaoWuSlotIndex.lockInfo,not isUnLock or bwData.isFullLv)
item:SetChildActive(CmpBaoWuSlotIndex.costRoot,isUnLock and(not bwData.isFullLv))

local conditionReddotState=(bwData.condition and next(bwData.condition))and airGameEnterConfig.checkXianBaoOpenCondition(bwData.condition)or true

if isShowActiveBtn then
local costActiveReddotState=airGameEnterModel:checkBaoWuActiveCostEnough(bwData.cfg.id,false)
item:SetChildActive(CmpBaoWuSlotIndex.activeReddot,conditionReddotState and costActiveReddotState)

end

if isShowAddLevelBtn then
local costUpLevelReddotState=airGameEnterModel:checkBaoWuAddLevelCostEnough(bwData.cfg.id,false)
item:SetChildActive(CmpBaoWuSlotIndex.addLevelReddot,conditionReddotState and costUpLevelReddotState)
end

if isShowActiveBtn then
item:SetChildButtonEnable(CmpBaoWuSlotIndex.activeBtn,true,not bwData.isCanActive)
end

if not isUnLock then
local info=airGameEnterConfig.checkXianBaoOpenConditionDesc(bwData.condition)
item:SetChildText(CmpBaoWuSlotIndex.lockTip,info)
end

if bwData.isFullLv then
item:SetChildText(CmpBaoWuSlotIndex.lockTip,"已满级")
end




local addLevelClickFunc=function()
_this:onClickAddLevel(bwData)
end
item:SetChildButtonClick(CmpBaoWuSlotIndex.addLevelBtn,addLevelClickFunc)

local activeClickFunc=function()
_this:onClickActive(bwData)
end
item:SetChildButtonClick(CmpBaoWuSlotIndex.activeBtn,activeClickFunc)

local isShowResetBtn=bwData.level>1
item:SetChildActive(CmpBaoWuSlotIndex.resetBtn,isShowResetBtn)
local resetClickFunc=function()
local continueInfo=' 重置会返还升级消耗的所有百炼火和云中精粹\n是否确认重置？'
local showdata=
{
type='UIDialouge',
title='提示',
content=continueInfo,
oktext='确认',
canceltext='取消',
allowclickBG=true,
okcallback=function()
airGameEnterController:reqResetBwLv(bwData.cfg.id)
end,
cancelcallback=function()

end,
showclosebtn=true,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()
end
item:SetChildButtonClick(CmpBaoWuSlotIndex.resetBtn,resetClickFunc)
end

function UIAirGameBaoWuWin:playEffect(bwid,type)
local index=bwid
local itemObj=self.bwitem[index]
local item=itemObj:getWidgetBase()

if type==1 then
item:SetChildShowEffect(CmpBaoWuSlotIndex.activeEffect,22610,true)
elseif type==2 then
item:SetChildShowEffect(CmpBaoWuSlotIndex.upLevelEffect,22611,true)
end
end


function UIAirGameBaoWuWin:onClickAddLevel(bwData)
local bwid=bwData.cfg.id
if bwData.condition and next(bwData.condition)then
if not airGameEnterConfig.checkXianBaoOpenCondition(bwData.condition)then
local info=airGameEnterConfig.checkXianBaoOpenConditionDesc(bwData.condition)
UIManager.error(info)
return
end
end

if airGameEnterModel:checkBaoWuAddLevelCostEnough(bwid,true)then
airGameEnterController:reqAddLevleXianBao(bwid)
end
end

function UIAirGameBaoWuWin:onClickActive(bwData)
local bwid=bwData.cfg.id

if bwData.condition and next(bwData.condition)then
if not airGameEnterConfig.checkXianBaoOpenCondition(bwData.condition)then
local info=airGameEnterConfig.checkXianBaoOpenConditionDesc(bwData.condition)
UIManager.error(info)
return
end
end

if airGameEnterModel:checkBaoWuActiveCostEnough(bwid,true)then
airGameEnterController:reqActiveXianBao(bwid)
end
end







function UIAirGameBaoWuWin:onCloseBtn()
self:closeSelf()
end

