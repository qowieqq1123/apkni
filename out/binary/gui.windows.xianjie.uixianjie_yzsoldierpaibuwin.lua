







def_class("UIXianJie_yzSoldierPaiBuWin",UIWindowBase)









function UIXianJie_yzSoldierPaiBuWin:bindComponents()

self.allCntSlider=UIObject.get(self,0)
self.allCntSliderMask=UIObject.get(self,1)
self.allCntText=UIText.get(self,2)
self.averageBtn=UIButton.get(self,3)
self.buffItem1=UIObject.get(self,4)
self.buffItem2=UIObject.get(self,5)
self.clickMask=UIButton.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.confirmBtn=UIButton.get(self,8)
self.downSortBtn=UIButton.get(self,9)
self.jumpBtn=UIButton.get(self,10)
self.menu_anim_1=UIObject.get(self,11)
self.menu_anim_2=UIObject.get(self,12)
self.menu_anim_3=UIObject.get(self,13)
self.menu_anim_4=UIObject.get(self,14)
self.menu_anim_5=UIObject.get(self,15)
self.menu_anim_6=UIObject.get(self,16)
self.menuAnimGrid=UIObject.get(self,17)
self.menulist=UIObject.get(self,18)
self.nameBg=UIObject.get(self,19)
self.notSlider=UIText.get(self,20)
self.resetBtn=UIButton.get(self,21)
self.soldierSliderGridGroup=UIObject.get(self,22)
self.teamScrollView=UIScrollView.get(self,23)
self.titleName=UIText.get(self,24)
self.typeBtnPanel=UIObject.get(self,25)
self.typeName=UIText.get(self,26)
self.upSortBtn=UIButton.get(self,27)
self.usedXsBtn=UIButton.get(self,28)
self.usedXsGridGroup=UIObject.get(self,29)
self.usedXsPanel=UIObject.get(self,30)
self.usedXsScrollView=UIObject.get(self,31)
self.xjyzTips=UIObject.get(self,32)

self.averageBtn:setButtonClick(function()self:onAverageBtn()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.downSortBtn:setButtonClick(function()self:onDownSortBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)

self.upSortBtn:setButtonClick(function()self:onUpSortBtn()end)

self.usedXsBtn:setButtonClick(function()self:onUsedXsBtn()end)
self.menu_anim={
self.menu_anim_1,
self.menu_anim_2,
self.menu_anim_3,
self.menu_anim_4,
self.menu_anim_5,
self.menu_anim_6,
}



end


function UIXianJie_yzSoldierPaiBuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.allCntSlider);self.allCntSlider=nil;
_UIObject_release(self.allCntSliderMask);self.allCntSliderMask=nil;
_UIObject_release(self.allCntText);self.allCntText=nil;
_UIObject_release(self.averageBtn);self.averageBtn=nil;
_UIObject_release(self.buffItem1);self.buffItem1=nil;
_UIObject_release(self.buffItem2);self.buffItem2=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.downSortBtn);self.downSortBtn=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menu_anim_2);self.menu_anim_2=nil;
_UIObject_release(self.menu_anim_3);self.menu_anim_3=nil;
_UIObject_release(self.menu_anim_4);self.menu_anim_4=nil;
_UIObject_release(self.menu_anim_5);self.menu_anim_5=nil;
_UIObject_release(self.menu_anim_6);self.menu_anim_6=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
_UIObject_release(self.menulist);self.menulist=nil;
_UIObject_release(self.nameBg);self.nameBg=nil;
_UIObject_release(self.notSlider);self.notSlider=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.soldierSliderGridGroup);self.soldierSliderGridGroup=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.typeBtnPanel);self.typeBtnPanel=nil;
_UIObject_release(self.typeName);self.typeName=nil;
_UIObject_release(self.upSortBtn);self.upSortBtn=nil;
_UIObject_release(self.usedXsBtn);self.usedXsBtn=nil;
_UIObject_release(self.usedXsGridGroup);self.usedXsGridGroup=nil;
_UIObject_release(self.usedXsPanel);self.usedXsPanel=nil;
_UIObject_release(self.usedXsScrollView);self.usedXsScrollView=nil;
_UIObject_release(self.xjyzTips);self.xjyzTips=nil;
self.menu_anim=nil;
end
















local _this

local menu_slot_name='button_dytab'

local body_id={
back=2016,
menu=2017,
}

local _soldierSliderItemCmpIndex={
name=0,
slider=1,
cntText=2,
subBtn=3,
addBtn=4,
}

local _CMP_INDEX={
cmpSelfItem=0,
cmpReddot=1,
cmpName=2,
cmpNumBg=3,
cmpNumTx=4,
}




function UIXianJie_yzSoldierPaiBuWin:onLoaded(...)
_this=self
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.teamScrollView:setClickAction(self._on_click_callback)
end


function UIXianJie_yzSoldierPaiBuWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJie_yzSoldierPaiBuWin:onShow(argtable,afterOnloaded)
self.nowSelectCountList=argtable and argtable.selectList or{}
self.extraSoldierList=argtable and argtable.extraSoldierList
self.usedSoldierList=argtable and argtable.usedSoldierList
self.orderType=argtable and argtable.orderType
self.dzCount=argtable and argtable.dzCount or 0
self.dzCountList=argtable and argtable.dzCountList
self.isYBDSet=argtable and argtable.isYBDSet
self.isXJYZSet=argtable and argtable.isXJYZSet
self.maxSoldierNum=argtable and argtable.maxSoldierNum
self.minSoldierIdx=argtable and argtable.minSoldierIdx
self.minSoldierNum=argtable and argtable.minSoldierNum
self.yzSoldierList=argtable and argtable.yzSoldierList
self.gxMaxSoldierNum=argtable and argtable.gxMaxSoldierNum
self.selectTeamIndex=argtable and argtable.selectTeamIndex
self.canUseXSList=argtable and argtable.canUseXSList
self.canTzOtherMonsterNum=argtable and argtable.canTzOtherMonsterNum

self.isShowUsed=false
self.initShowUsed=false

self:refreshXJYZSet()

self:refreshYunZhouList()

self:refreshSoldierCount()

if not self.isXJYZSet and self.allSoldierCount<=0 then

local selectList={}
if self.yzSoldierList then
UIManager:invokeUIMethod("UIXianJunYanZhen_YunZhouPrepareWin","onPaiBuSetSelectListRecv",selectList)
else
UIManager:invokeUIMethod("UIXianJie_YunZhouPrepareWin","onPaiBuSetSelectListRecv",selectList)
end
UIManager.error("当前没有可出征的修士")
return self:onCloseBtn()
end

if not self.dzCountList then

local tsdMaxUseCount=xianjieModel:getJiJieAddCount()
if tsdMaxUseCount then
self.maxSelectCount=math.min(self.allSoldierCount,tsdMaxUseCount*self.dzCount)
else
self.maxSelectCount=self.allSoldierCount
end
end


UIManager:invokeUIMethod("UIXianJie_YunZhouPrepareWin","refreshSoldierCount")
UIManager:invokeUIMethod("UIXianJunYanZhen_YunZhouPrepareWin","refreshSoldierCount")

self:refresh(true)

if afterOnloaded then
self:onLoadFinish(true)
end
end


function UIXianJie_yzSoldierPaiBuWin:onHide()

end

function UIXianJie_yzSoldierPaiBuWin:refreshXJYZSet()
local isHasCond=false

self.usedXsBtn:setActive(self.usedSoldierList~=nil and next(self.usedSoldierList)~=nil)

if self.isXJYZSet then
self.buffItem1:setActive(false)
if self.gxMaxSoldierNum then
self.buffItem1:setActive(true)
local widget=self.buffItem1:getWidgetBase()
local max=mathHelper.formatNumber4(self.gxMaxSoldierNum,1)
widget:SetChildText(0,FMT.fmt("本关可携带修士最多共{0}",max))
isHasCond=true
end

self.buffItem2:setActive(false)
if self.minSoldierIdx and self.minSoldierIdx>=1 then
self.buffItem2:setActive(true)
local widget=self.buffItem2:getWidgetBase()
local soldierCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,self.minSoldierIdx)
if self.minSoldierNum>1 then
local min=mathHelper.formatNumber4(self.minSoldierNum,1)
widget:SetChildText(0,FMT.fmt("每队需携带{0}{1}或以上修士",min,soldierCfg.name))
else
widget:SetChildText(0,FMT.fmt("每队需携带{0}或以上修士",soldierCfg.name))
end
isHasCond=true
end
end
self.xjyzTips:setActive(isHasCond)
self.nameBg:setActive(not isHasCond)
self.typeName:setActive(not isHasCond)
self.typeBtnPanel:setActive(not isHasCond)
end

function UIXianJie_yzSoldierPaiBuWin:refreshSoldierCount()
self.yzSoldierLookup={}
local otherTeamTotleXSCount=0
local usedSoldierList=table.weakCopy(self.usedSoldierList)or{}
if self.yzSoldierList and#self.yzSoldierList>0 then
for i,soldierSelectList in ipairs(self.yzSoldierList)do
if self.selectTeamIndex~=i then
for soldierIdx,count in pairs(soldierSelectList)do
self.yzSoldierLookup[soldierIdx]=true
usedSoldierList[soldierIdx]=(usedSoldierList[soldierIdx]or 0)+count
otherTeamTotleXSCount=otherTeamTotleXSCount+count
end
end
end
end
self.userTotleXSCount=0
for soldierIdx,count in pairs(usedSoldierList)do
self.userTotleXSCount=self.userTotleXSCount+count
end

local soldierCountList,allSoldierCount
if self.canUseXSList and next(self.canUseXSList)~=nil then
soldierCountList,allSoldierCount=yunjiayingModel:getSoldierCountEx(self.canUseXSList,usedSoldierList,self.minSoldierIdx)
else
soldierCountList,allSoldierCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy,self.extraSoldierList,usedSoldierList,self.minSoldierIdx)
end
self.soldierCountList=soldierCountList
if self.maxSoldierNum then
local max=self.maxSoldierNum-otherTeamTotleXSCount
if max<0 then
max=0
end
self.allSoldierCount=math.min(max,allSoldierCount)
else
self.allSoldierCount=allSoldierCount
end

if self.dzCountList~=nil then

local tsdMaxUseCount=xianjieModel:getJiJieAddCount()

if tsdMaxUseCount then
local dzCount=self.dzCountList[self.selectTeamIndex]or 0
self.maxSelectCount=math.min(self.allSoldierCount,tsdMaxUseCount*dzCount)
else
self.maxSelectCount=self.allSoldierCount
end
end
end

function UIXianJie_yzSoldierPaiBuWin:refresh(isInit)
self:refreshAllCntSlider(isInit)
if isInit then
self:initSliderList()
else
self:refreshSliderList()
end
end

function UIXianJie_yzSoldierPaiBuWin:refreshAllCntSlider(isInit)

local allSelectCnt=self:getAllSelectCnt()
local minSelectCount=0
local showMaxSelectCount=self.maxSelectCount
local canSelect=self.maxSelectCount>0
if not canSelect then
showMaxSelectCount=1
end

if isInit then
local func=function(...)
if not _this then return end
return _this:onAllCntSliderChange(...)
end
self.allCntSlider:setChildSliderInit(allSelectCnt,minSelectCount,showMaxSelectCount,func)
else
self.allCntSlider:setChildSliderValue(allSelectCnt)
end
self.allCntSliderMask:setActive(not canSelect)
if self.isXJYZSet and not canSelect then
showMaxSelectCount=0
end
self.allCntText:setText(FMT.fmt("{0}/{1}",mathHelper.formatNumber4(allSelectCnt,1),mathHelper.formatNumber4(showMaxSelectCount,1)))

if self.yzSoldierList then
self.yzSoldierList[self.selectTeamIndex]=table.weakCopy(self.nowSelectCountList)
end
end

function UIXianJie_yzSoldierPaiBuWin:initSliderList()
local showSoldierIdxList=self:getShowSoldierIdxList()
self.soldierSliderGridGroup:setChildLayoutGroupCreateItems(#showSoldierIdxList,function(index)
local widget=self.soldierSliderGridGroup:getChildLayoutGroupGridItem(index-1)
widget:SetChildActive(-1,true)
local soldierIdx=showSoldierIdxList[index]

local soldierCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,soldierIdx)
local iconAb="ui/windows/xianjie/xianjiemain_soldiername_atlas_pak.ab"
local iconName=soldierCfg.nameIcon2
widget:SetChildCSImageSprite(_soldierSliderItemCmpIndex.name,iconAb,iconName)


local soldierHasCount=self.soldierCountList[soldierIdx]
local soldierSelectCount=self.nowSelectCountList[soldierIdx]or 0
widget:SetChildText(_soldierSliderItemCmpIndex.cntText,FMT.fmt("{0}/{1}",mathHelper.formatNumber4(soldierSelectCount,1),mathHelper.formatNumber4(soldierHasCount,1)))



local func=function(...)
if not _this then return end
return _this:onSoldierSliderChange(index,soldierIdx,...)
end
widget:SetChildSliderInit(_soldierSliderItemCmpIndex.slider,soldierSelectCount,0,soldierHasCount,func)



widget:SetChildButtonClick(_soldierSliderItemCmpIndex.subBtn,function()
if not _this then return end
return _this:onSubBtn(index,soldierIdx)
end,true)
widget:SetChildButtonClick(_soldierSliderItemCmpIndex.addBtn,function()
if not _this then return end
return _this:onAddBtn(index,soldierIdx)
end,true)
end)
end

function UIXianJie_yzSoldierPaiBuWin:refreshSliderList()
local showSoldierIdxList=self:getShowSoldierIdxList()
local grids=self.soldierSliderGridGroup:getChildLayoutGroupGridList()
for index=1,grids.Count do
local widget=grids[index-1]

local soldierIdx=showSoldierIdxList[index]
local soldierHasCount=self.soldierCountList[soldierIdx]
local soldierSelectCount=self.nowSelectCountList[soldierIdx]or 0
widget:SetChildText(_soldierSliderItemCmpIndex.cntText,FMT.fmt("{0}/{1}",mathHelper.formatNumber4(soldierSelectCount,1),mathHelper.formatNumber4(soldierHasCount,1)))

widget:SetChildSliderValue(_soldierSliderItemCmpIndex.slider,soldierSelectCount)
end
if self.yzSoldierList then
self.yzSoldierList[self.selectTeamIndex]=table.weakCopy(self.nowSelectCountList)
end
end

function UIXianJie_yzSoldierPaiBuWin:getAllSelectCnt(isGetLast)
if isGetLast and self.lastAllSelectCnt then
return self.lastAllSelectCnt
end

local allSelectCnt=0
for _,count in pairs(self.nowSelectCountList)do
allSelectCnt=allSelectCnt+count
end
self.lastAllSelectCnt=allSelectCnt
return allSelectCnt
end

function UIXianJie_yzSoldierPaiBuWin:getShowSoldierIdxList()
if self.showSoldierIdxList then
return self.showSoldierIdxList
end

local list={}
for soldierIdx,count in ipairs(self.soldierCountList)do
if count>0 or self.yzSoldierLookup[soldierIdx]then
list[#list+1]=soldierIdx
end
end

table.sort(list,function(a,b)
return a>b
end)

if self.isXJYZSet then
local isShow=#list>0
self.resetBtn:setActive(isShow)
self.confirmBtn:setActive(isShow)
self.jumpBtn:setActive(not isShow)
self.notSlider:setActive(not isShow)
end

self.showSoldierIdxList=list
return self.showSoldierIdxList
end


function UIXianJie_yzSoldierPaiBuWin:changeAllSelectCnt(value)
local allSelectCnt=self:getAllSelectCnt()
local showSoldierIdxList=self:getShowSoldierIdxList()
self.nowSelectCountList=xianjieModel:getXJYunZhouTeamChangeSoldierSelectList(allSelectCnt,showSoldierIdxList,value,self.nowSelectCountList,self.soldierCountList)
end


function UIXianJie_yzSoldierPaiBuWin:onAllCntSliderChange(value)
if self.onChangeSlider and self.onChangeSlider~=-1 then
return
end

self.onChangeSlider=-1

self:changeAllSelectCnt(value)


local allSelectCnt=self:getAllSelectCnt()
local showMaxSelectCount=self.maxSelectCount
local canSelect=self.maxSelectCount>0
if not canSelect then
showMaxSelectCount=1
end
self.allCntText:setText(FMT.fmt("{0}/{1}",mathHelper.formatNumber4(allSelectCnt,1),mathHelper.formatNumber4(showMaxSelectCount,1)))

self:refreshSliderList()
self.onChangeSlider=nil
end

function UIXianJie_yzSoldierPaiBuWin:onSoldierSliderChange(index,soldierIdx,value)
if self.onChangeSlider and self.onChangeSlider~=index then
return
end

if not value then
return
end

local soldierSelectCount=self.nowSelectCountList[soldierIdx]or 0
if soldierSelectCount==value then
return
end

local widget=self.soldierSliderGridGroup:getChildLayoutGroupGridItem(index-1)
local allSelectCnt=self:getAllSelectCnt(true)
local deltaCount=value-soldierSelectCount
if allSelectCnt+deltaCount>self.maxSelectCount then
local d2v=self.maxSelectCount-allSelectCnt
local v=soldierSelectCount+d2v
return widget:SetChildSliderValue(_soldierSliderItemCmpIndex.slider,v)
end

self.onChangeSlider=index
self.nowSelectCountList[soldierIdx]=value
soldierSelectCount=value
local soldierHasCount=self.soldierCountList[soldierIdx]

widget:SetChildText(_soldierSliderItemCmpIndex.cntText,FMT.fmt("{0}/{1}",mathHelper.formatNumber4(soldierSelectCount,1),mathHelper.formatNumber4(soldierHasCount,1)))

self:refreshAllCntSlider()
self.onChangeSlider=nil
end


function UIXianJie_yzSoldierPaiBuWin:onLoadFinish(isNew)
self.animLock1=nil
self:clearMenuTweener()
self.menuAnimGrid:setChildCanvasGroupAlpha(0)
self.menulist:setChildCanvasGroupAlpha(0)
local len=self.yzSoldierList and#self.yzSoldierList or 0
if len>1 then
self.menuAnimGrid:setActive(true)
local func=function()
self.menuAnimGrid:setChildCanvasGroupAlpha(1)
local selectMenuIdx=self.selectTeamIndex
for i,v in ipairs(self.menu_anim)do
local isshow=i<=len
local anim=self.menu_anim[i]
local func2=function()
if isshow then
local name
if selectMenuIdx==i then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end
self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,name)
end
end
local cb
if isNew then
cb=func2
end
anim:setChildUIModelShowTarget(body_id.menu,1,{},eAnimationID.common_window_enter,false,false,0,cb)
if not isNew then
func2()
end
anim:setActive(isshow)
end
end
self:delayDo(0.1,func)
self.animLock1=true
local func1=function()
self.animLock1=nil
self.menulist:setChildCanvasGroupAlpha(0)
local fun3=function()
self.menuTweener=nil
end
self.menuTweener=self.menulist:setChildCanvasGroupDOFade(1,1,fun3)
end
self:delayDo(0.4,func1)
end
end

function UIXianJie_yzSoldierPaiBuWin:clearMenuTweener()
if self.menuTweener~=nil then
self.menuTweener:Complete()
self.menuTweener=nil
end
end

function UIXianJie_yzSoldierPaiBuWin:refreshYunZhouList()
if not self.yzSoldierList then
return
end
local len=#self.yzSoldierList or 0
if len==1 then
return
end

self.teamScrollView:freshGridsNum(len,len,1,true)
for i,v in ipairs(self.yzSoldierList)do
self:fillMenu(i,v)
end
end

function UIXianJie_yzSoldierPaiBuWin:fillMenu(index,config)
local selectMenuIdx=self.selectTeamIndex

local item=self.teamScrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildText(_CMP_INDEX.cmpName,FMT.fmt("第{0}队",index))
local anim=self.menu_anim[index]

local name
if selectMenuIdx==index then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,name)

item:SetChildActive(_CMP_INDEX.cmpReddot,false)
end

function UIXianJie_yzSoldierPaiBuWin:on_click_callback(id,index,guid,attach)
if self.animLock1==true then return end
if index==self.selectTeamIndex then
return
end
self:freshMenuSelect(self.selectTeamIndex,false)
self:freshMenuSelect(index,true)
self.selectTeamIndex=index

self.nowSelectCountList=table.weakCopy(self.yzSoldierList[self.selectTeamIndex])or{}

self:refreshSoldierCount()

self:refresh(true)
end

function UIXianJie_yzSoldierPaiBuWin:freshMenuSelect(index,is_select)
if index==nil then
return
end
local config=self.yzSoldierList[index]
if config==nil then
return
end

local anim=self.menu_anim[index]
if is_select then
anim:setChildModelAnimationState(eAnimationID.common_window_dianji)
end

local name
if is_select then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,name)
end




function UIXianJie_yzSoldierPaiBuWin:onClickMask()
self:onCloseBtn()
end



function UIXianJie_yzSoldierPaiBuWin:onResetBtn()

self.allCntSlider:setChildSliderValue(0)
end



function UIXianJie_yzSoldierPaiBuWin:onConfirmBtn()
if self.yzSoldierList then
local selectList={}
for i,soldierSelectList in pairs(self.yzSoldierList)do
selectList[i]=soldierSelectList or{}
end
local allSelectCnt=self:getAllSelectCnt(true)


if self.canTzOtherMonsterNum>0 and self.gxMaxSoldierNum and allSelectCnt+self.userTotleXSCount>=self.gxMaxSoldierNum then
local content="本关有可用修士人数上限，当前队伍\n携带修士已达可用上限，将导致其余\n队伍无法出战，是否确定？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
UIManager:invokeUIMethod("UIXianJunYanZhen_YunZhouPrepareWin","onPaiBuSetSelectListRecv",selectList)
_this:onCloseBtn()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return
else
UIManager:invokeUIMethod("UIXianJunYanZhen_YunZhouPrepareWin","onPaiBuSetSelectListRecv",selectList)
end
else
local selectList=self.nowSelectCountList
xianjieModel:setXJYunZhouTeamSoldierSelectList(selectList)
UIManager:invokeUIMethod("UIXianJie_YunZhouPrepareWin","onPaiBuSetSelectListRecv",selectList)
end

self:onCloseBtn()
end



function UIXianJie_yzSoldierPaiBuWin:onCloseBtn()
self:closeSelf()
end



function UIXianJie_yzSoldierPaiBuWin:onDownSortBtn()


local allSelectCnt=self:getAllSelectCnt()
local showSoldierIdxList=self:getShowSoldierIdxList()
local remaining=allSelectCnt

self.nowSelectCountList={}
for _,soldierIdx in ipairs(showSoldierIdxList)do
local maxSelectCount=self.soldierCountList[soldierIdx]
local selectCount=remaining
if selectCount>maxSelectCount then
selectCount=maxSelectCount
end
remaining=remaining-selectCount
self.nowSelectCountList[soldierIdx]=selectCount
if remaining==0 then
break
end
end

self:refreshSliderList()
end



function UIXianJie_yzSoldierPaiBuWin:onUpSortBtn()


local allSelectCnt=self:getAllSelectCnt()
local sortSoldierList={}
for soldierIdx,count in ipairs(self.soldierCountList)do
if count>0 then
sortSoldierList[#sortSoldierList+1]=soldierIdx
end
end
table.sort(sortSoldierList,function(a,b)
return a<b
end)


self.nowSelectCountList={}
local remaining=allSelectCnt
for _,soldierIdx in ipairs(sortSoldierList)do
local maxSelectCount=self.soldierCountList[soldierIdx]
local selectCount=remaining
if selectCount>maxSelectCount then
selectCount=maxSelectCount
end
remaining=remaining-selectCount
self.nowSelectCountList[soldierIdx]=selectCount
if remaining==0 then
break
end
end

self:refreshSliderList()
end



function UIXianJie_yzSoldierPaiBuWin:onAverageBtn()


local allSelectCnt=self:getAllSelectCnt()
local sortSoldierList={}
for soldierIdx,count in ipairs(self.soldierCountList)do
if count>0 then
sortSoldierList[#sortSoldierList+1]={
soldierIdx=soldierIdx,
count=count,
}
end
end
table.sort(sortSoldierList,function(a,b)
if a.count==b.count then
return a.soldierIdx>b.soldierIdx
else
return a.count<b.count
end
end)


self.nowSelectCountList={}
local hasSoldierTypeCount=#sortSoldierList
local remaining=allSelectCnt
for i,v in ipairs(sortSoldierList)do
local typeCount=hasSoldierTypeCount-i+1
local avg=math.floor(remaining/typeCount)
local maxSelectCount=v.count
local soldierIdx=v.soldierIdx
local selectCount=avg
if selectCount>maxSelectCount then
selectCount=maxSelectCount
end
remaining=remaining-selectCount
self.nowSelectCountList[soldierIdx]=selectCount
end

if remaining>0 then

for i,v in ipairs(sortSoldierList)do
local maxSelectCount=v.count
local soldierIdx=v.soldierIdx
local selectCount=self.nowSelectCountList[soldierIdx]or 0
local addCount=0
if selectCount<maxSelectCount then
if selectCount+remaining<=maxSelectCount then
addCount=remaining
else
addCount=maxSelectCount-selectCount
end

if not self.nowSelectCountList[soldierIdx]then
self.nowSelectCountList[soldierIdx]=addCount
else
self.nowSelectCountList[soldierIdx]=self.nowSelectCountList[soldierIdx]+addCount
end
end

remaining=remaining-addCount
if remaining==0 then
break
end
end
end

self:refreshSliderList()
end


function UIXianJie_yzSoldierPaiBuWin:onSubBtn(index,soldierIdx)
if self.onChangeSlider and self.onChangeSlider~=index then
return
end
local soldierSelectCount=self.nowSelectCountList[soldierIdx]or 0
local soldierHasCount=self.soldierCountList[soldierIdx]
if soldierSelectCount<=0 then
return
end

self.onChangeSlider=index
soldierSelectCount=soldierSelectCount-1
self.nowSelectCountList[soldierIdx]=soldierSelectCount
local widget=self.soldierSliderGridGroup:getChildLayoutGroupGridItem(index-1)

widget:SetChildText(_soldierSliderItemCmpIndex.cntText,FMT.fmt("{0}/{1}",mathHelper.formatNumber4(soldierSelectCount,1),mathHelper.formatNumber4(soldierHasCount,1)))

self:refreshAllCntSlider()
self.onChangeSlider=nil
end

function UIXianJie_yzSoldierPaiBuWin:onAddBtn(index,soldierIdx)
if self.onChangeSlider and self.onChangeSlider~=index then
return
end

local soldierSelectCount=self.nowSelectCountList[soldierIdx]or 0
local soldierHasCount=self.soldierCountList[soldierIdx]
if soldierSelectCount>=soldierHasCount then
return
end

local allSelectCnt=self:getAllSelectCnt(true)
if allSelectCnt+1>self.maxSelectCount then
return
end

self.onChangeSlider=index
soldierSelectCount=soldierSelectCount+1
self.nowSelectCountList[soldierIdx]=soldierSelectCount
local widget=self.soldierSliderGridGroup:getChildLayoutGroupGridItem(index-1)

widget:SetChildText(_soldierSliderItemCmpIndex.cntText,FMT.fmt("{0}/{1}",mathHelper.formatNumber4(soldierSelectCount,1),mathHelper.formatNumber4(soldierHasCount,1)))

self:refreshAllCntSlider()
self.onChangeSlider=nil
end

function UIXianJie_yzSoldierPaiBuWin:onUsedXsBtn()
self.isShowUsed=not self.isShowUsed
if self.isShowUsed and not self.initShowUsedthen then
self.initShowUsed=true

local list={}
local allCount=0
for soldierIdx,count in pairs(self.usedSoldierList)do
if count>0 then
table.insert(list,{soldierIdx,count})
allCount=allCount+count
end
end
if allCount>0 then
table.insert(list,{-1,allCount})
end

local len=#list
local _h=len*42+65
local maxH=240
self.usedXsPanel:setChildSizeDelta(260,math.min(_h,maxH))
self.usedXsScrollView:setChildScrollRectEnable(_h>maxH)

self.usedXsGridGroup:setChildLayoutGroupCreateItems(len,function(index)
local widget=self.usedXsGridGroup:getChildLayoutGroupGridItem(index-1)
local soldierIdx=list[index][1]
local count=list[index][2]
local countStr=mathHelper.formatNumber4(count,1)
if soldierIdx==-1 then
widget:SetChildText(0,"总人数")
else
local soldierCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,soldierIdx)
widget:SetChildText(0,soldierCfg.name)
end
widget:SetChildText(1,countStr)
end)
end
self.usedXsPanel:setActive(self.isShowUsed)
end

function UIXianJie_yzSoldierPaiBuWin:onJumpBtn()

local cb=function()
if not _this then return end
end
return jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eYunJiaYing,mapid=mapIdType.fort,scenetype=eSceneType.eZongmen}},cb)
end
