







def_class("UIDanFangWin",UIWindowBase)









function UIDanFangWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.addImgClick=UIObject.get(self,1)
self.addPlanBtn=UIButton.get(self,2)
self.blueRoot=UIObject.get(self,3)
self.btnHuan=UIButton.get(self,4)
self.danFangItem=UIObject.get(self,5)
self.danFangList=UIScrollView.get(self,6)
self.dzLevelText=UIText.get(self,7)
self.effect_1=UIObject.get(self,8)
self.effect_2=UIObject.get(self,9)
self.effect3=UIObject.get(self,10)
self.effectText_1=UIText.get(self,11)
self.effectText_2=UIText.get(self,12)
self.effectText3=UIText.get(self,13)
self.greenRoot=UIObject.get(self,14)
self.handImgClick=UIObject.get(self,15)
self.handleImg=UIObject.get(self,16)
self.materials=UIObject.get(self,17)
self.materialsItem_1=UIBaseItem.get(self,18)
self.materialsItem_2=UIBaseItem.get(self,19)
self.materialsItem_3=UIBaseItem.get(self,20)
self.materialsItem_4=UIBaseItem.get(self,21)
self.materialsItem_5=UIBaseItem.get(self,22)
self.materialsItem_6=UIBaseItem.get(self,23)
self.materialsItem_7=UIBaseItem.get(self,24)
self.matTypeText=UIText.get(self,25)
self.maxCnt=UIButton.get(self,26)
self.orangeRoot=UIObject.get(self,27)
self.purpleRoot=UIObject.get(self,28)
self.quickAddMoneyBtn=UIButton.get(self,29)
self.redRoot=UIObject.get(self,30)
self.selectBtn=UIButton.get(self,31)
self.selectBtnText=UIText.get(self,32)
self.selectCntSlider=UIObject.get(self,33)
self.selectCntText=UIText.get(self,34)
self.subBtn=UIButton.get(self,35)
self.subImgClick=UIObject.get(self,36)
self.timeText=UIText.get(self,37)
self.title=UIText.get(self,38)
self.toggleGroup=UIObject.get(self,39)
self.UIComboBox=UIObject.get(self,40)
self.unLockBtn=UIButton.get(self,41)
self.unLockBtnText=UIText.get(self,42)
self.unLockText=UIText.get(self,43)
self.unLockTextZM=UIText.get(self,44)
self.wieghtRoot=UIObject.get(self,45)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.addPlanBtn:setButtonClick(function()self:onAddPlanBtn()end)

self.btnHuan:setButtonClick(function()self:onBtnHuan()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.quickAddMoneyBtn:setButtonClick(function()self:onQuickAddMoneyBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.unLockBtn:setButtonClick(function()self:onUnLockBtn()end)
self.effect={
self.effect_1,
self.effect_2,
}
self.effectText={
self.effectText_1,
self.effectText_2,
}
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
self.materialsItem_4,
self.materialsItem_5,
self.materialsItem_6,
self.materialsItem_7,
}



end


function UIDanFangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.addImgClick);self.addImgClick=nil;
_UIObject_release(self.addPlanBtn);self.addPlanBtn=nil;
_UIObject_release(self.blueRoot);self.blueRoot=nil;
_UIObject_release(self.btnHuan);self.btnHuan=nil;
_UIObject_release(self.danFangItem);self.danFangItem=nil;
_UIObject_release(self.danFangList);self.danFangList=nil;
_UIObject_release(self.dzLevelText);self.dzLevelText=nil;
_UIObject_release(self.effect_1);self.effect_1=nil;
_UIObject_release(self.effect_2);self.effect_2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effectText_1);self.effectText_1=nil;
_UIObject_release(self.effectText_2);self.effectText_2=nil;
_UIObject_release(self.effectText3);self.effectText3=nil;
_UIObject_release(self.greenRoot);self.greenRoot=nil;
_UIObject_release(self.handImgClick);self.handImgClick=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.materialsItem_4);self.materialsItem_4=nil;
_UIObject_release(self.materialsItem_5);self.materialsItem_5=nil;
_UIObject_release(self.materialsItem_6);self.materialsItem_6=nil;
_UIObject_release(self.materialsItem_7);self.materialsItem_7=nil;
_UIObject_release(self.matTypeText);self.matTypeText=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.orangeRoot);self.orangeRoot=nil;
_UIObject_release(self.purpleRoot);self.purpleRoot=nil;
_UIObject_release(self.quickAddMoneyBtn);self.quickAddMoneyBtn=nil;
_UIObject_release(self.redRoot);self.redRoot=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.selectBtnText);self.selectBtnText=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.subImgClick);self.subImgClick=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.toggleGroup);self.toggleGroup=nil;
_UIObject_release(self.UIComboBox);self.UIComboBox=nil;
_UIObject_release(self.unLockBtn);self.unLockBtn=nil;
_UIObject_release(self.unLockBtnText);self.unLockBtnText=nil;
_UIObject_release(self.unLockText);self.unLockText=nil;
_UIObject_release(self.unLockTextZM);self.unLockTextZM=nil;
_UIObject_release(self.wieghtRoot);self.wieghtRoot=nil;
self.effect=nil;
self.effectText=nil;
self.materialsItem=nil;
end

















local menuItemInex=
{
select=0,
showItem=1,
require=2,
lock=3,
reddot=4,
name=5,
newImg=6,
canUnlock=7,
}

local _this=nil
local menu_slot_name='button_dytab'

local _btnsInfoEx=
{
{
type=DANYAO_FILTER_TYPE.eJingjie,
name='境界',
},
{
type=DANYAO_FILTER_TYPE.eLianTi,
name='炼体',
},
{
type=DANYAO_FILTER_TYPE.eLingshou,
name='灵兽',
},
{
type=DANYAO_FILTER_TYPE.eOther,
name='其他',
},
}

local _pageLookup={}
for i,v in ipairs(_btnsInfoEx)do
_pageLookup[v.type]=i
end

local _btnsInfo={}
local _defaultDFId=1


function UIDanFangWin:onLoaded(...)
self:bindComponents()
_this=self
self.weightWidgetList={
self.greenRoot,
self.blueRoot,
self.purpleRoot,
self.orangeRoot,
self.redRoot
}

local _onClickMenuCallBack=function(...)
self:onClickMenuCallBack(...)
end
self.danFangList:setClickAction(_onClickMenuCallBack)

local longPressFunc=function(...)
self:onLongPressBtn(...)
end
self.winlua:SetChildLongPress(self.subBtn:getID(),1,longPressFunc,nil)
self.winlua:SetChildLongPress(self.addBtn:getID(),2,longPressFunc,nil)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)

self.UIComboBox:setChildComboBoxInit(self.on_combobox_change)
self.gainTable={}
self:refreshBtnsInfo()
end


function UIDanFangWin:__delete()
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)

self:unbindComponents()
_this=nil
self:clearNewFlag()
end

function UIDanFangWin:refreshAfterItemUse(utype,arg1,arg2)
self:freshRightPanel()
end




function UIDanFangWin:onShow(argtable,afterOnloaded)
local entityId=argtable.entityId
self.dfId=argtable.danFangId
self.num=argtable.selectCnt
self.dzId=argtable.dzId
self.defaultPage=argtable.page

self.needFresh=true
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
zongmenModel:countManufacturePercent(self.bdData)

self:refresh()
end

function UIDanFangWin:setSelectBtnName()
if UIDanYaoController:isDingDanSystemOpen()then
local data=UIDanYaoModel:getBatchData(self.bdData.un_build_id)
local name=(data and#data.ddList>0)and'加入炼丹'or'开始炼丹'
self.selectBtnText:setText(name)
end
end

function UIDanFangWin:refresh(dfId,num)
dfId=dfId or self.dfId
num=num or self.dfNum
if dfId==nil then
if self.defaultPage then
local page=self.defaultPage
self.defaultPage=nil
self:onSelectPage(page)
else
self:onSelectPage(1)
end

else
self:onSelect(dfId,num)
end
self:loadBtns()
self:freshBtnsReddot()
end

function UIDanFangWin:checkAndRefresh()
self.needFresh=true
self:freshDFList()
local dfList=self.dfList
local dfId=dfList[1].id
local num
if dfId==self.dfId then
num=self.dfNum
end
self:refreshMaterialsCnt()
self:onSelect(dfId,num)
end


function UIDanFangWin:onHide()

end






function UIDanFangWin:freshFilter()
local dfType=self.dfType
local cfg=UIDanYaoModel:getFilterCfg(dfType)

local option={}
option[#option+1]='所有'

local filter={}
filter[#filter+1]=0
self.filter=filter

for i,v in ipairs(cfg)do
if self:checkHas(i)then
filter[#filter+1]=v.id
option[#option+1]=v.typename
end
end
self.UIComboBox:setChildComboBoxOption(self.filterIdx or 0,option)
end


function UIDanFangWin:freshDFList()
if self.needFresh==false then return end
self.needFresh=false
local page=self.selectPage
local typo=self:getPageType(page)
local filterIdx=self.filterIdx or 1
local stype=self.filter and self.filter[filterIdx]or 0
local percent=self.bdData.pcreatesubpercent or 0
self.dfList=UIDanYaoModel:getDanFangList(self.dzId,typo,stype,percent)
end

function UIDanFangWin:checkHas(stype)
local page=self.selectPage
local typo=self:getPageType(page)
return UIDanYaoModel:hasDanFang(typo,stype)
end


function UIDanFangWin:checkDzProLevel(config)
local textStr=''
local limitLv=config.need_dd_lvl
local proType=DISCIPLE_PROSKILL_TYPE.eDanDao
local proLevel=UIDiscipleModel:getDiscipleJobLevel(self.dzId,proType)
if proLevel<limitLv then
local proName=cfgHelper.get2(cfg_discipleproskillconfig_get,proType,'name')
textStr=FMT.fmt('{0}等级需达到{1}级',proName,limitLv)
end
return proLevel>=limitLv,textStr
end

function UIDanFangWin:freshDanFangList()
self.danFangList:freshGridsNum(#self.dfList,#self.dfList,1,true)

local selectIdx=nil
for i=1,#self.dfList do
local item=self.danFangList:getGridObjectByindex(i-1)
if item then
local config=self.dfList[i]
local btype=config.b_type
local stype=config.s_type
local id=config.id

item:SetChildActive(menuItemInex.select,id==self.dfId)
if id==self.dfId then
selectIdx=i
end

item:SetChildText(menuItemInex.name,config.name)

local isUnLock,desc=UIDanYaoModel:isUnLock(id)
if isUnLock then
desc=config.sdesc
end
item:SetChildActive(menuItemInex.lock,not isUnLock)

local iconName=iconHelper.getIconName(config.itemid)
local widget=item:GetChildWidgetBase(menuItemInex.showItem)
widget:SetChildCSImageIcon(3,iconName,false)
local itemcfg=itemsConfig.getConfig(config.itemid)
widget:SetChildQulaity(2,itemcfg.color)
widget:SetChildImageExGray(2,not isUnLock)
widget:SetChildImageExGray(3,not isUnLock)

item:SetChildText(menuItemInex.require,desc)

local redot=false
if isUnLock then
local checkDz=self:checkDzProLevel(config)
local percent=self.bdData.pcreatesubpercent or 0
local canMake=UIDanYaoModel:isCanLianZhi(config.cost,1,percent)
redot=checkDz and canMake
else
redot=UIDanYaoModel:isCanUnLock(config.unlock)
end
item:SetChildActive(menuItemInex.reddot,redot)

local isNew=UIDanYaoModel:checkDanFangNewFlag(id)
item:SetChildActive(menuItemInex.newImg,isNew)

item:SetBaseItemChildID(-1,id)

local isCanUnlock=false
if not isUnLock then
isCanUnlock=UIDanYaoModel.checkDanFangUpLevelUnlockReddot(id)
end
item:SetChildActive(menuItemInex.canUnlock,isCanUnlock)
end
end
if#self.dfList>0 then
self.danFangList:jumpToLockX(selectIdx)
end
end

function UIDanFangWin:onClickMenuCallBack(id,index,guid,attach)

if self.dfId==id then return end
self.dfId=id
UIDanYaoModel:selectDFId(id)
for i=1,#self.dfList do
local item=self.danFangList:getGridObjectByindex(i-1)
if item then
local config=self.dfList[i]
item:SetChildActive(menuItemInex.select,config.id==id)
end
end

self:_resetPlanStateByCfg(cfg_danfangconfig_get(id))
self.selectCnt=self:getDefaultNum(id)
self:freshRightPanel()
end

function UIDanFangWin:freshRightPanel()
local dfId=self.dfId
local config=cfg_danfangconfig_get(dfId)
if config then
self:_tryRestoreCostPlan(config)
local isUnLock,unLockText=UIDanYaoModel:isUnLock(config.id)
local checkDz,checkStr=self:checkDzProLevel(config)
local lockType=config.unlock and config.unlock[1]
local isZMlocklockType=lockType==3
self.selectCntSlider:setActive(isUnLock)
self.unLockBtn:setActive(not isUnLock and not isZMlocklockType)
self.matTypeText:setText(isUnLock and'炼丹材料'or isZMlocklockType and'炼丹材料'or'激活消耗')

self.materials:setActive(lockType~=2)
self.unLockText:setActive(not isUnLock and lockType==2)
self.unLockText:setText(unLockText)

self.unLockTextZM:setActive(not isUnLock and isZMlocklockType)
self.unLockTextZM:setText(unLockText)

self.selectBtn:setActive(isUnLock and checkDz)
self.dzLevelText:setActive(isUnLock and not checkDz)
self.dzLevelText:setText(checkStr)
self:freshWeight()


local widget=self.danFangItem:getWidgetBase()
local showItemid=config.itemid
local iconName=iconHelper.getIconName(showItemid)
widget:SetChildCSImageIcon(3,iconName,false)
local itemcfg=itemsConfig.getConfig(config.itemid)
widget:SetChildQulaity(2,itemcfg.color)
widget:SetChildText(7,config.name)
widget:SetChildButtonClickDown(0,function(...)
if showItemid==nil or showItemid==-1 then return end

AudioManager.playBtnClick()
tipsManager.showTips({itemid=showItemid,move=TIPS_MOVE_POS.eLeft})
end)


local effectDesc=config.desc
for i=1,2 do
self.winlua:SetChildActive(self.effect[i]:getID(),i<=#effectDesc)
if i<=#effectDesc then
self.winlua:SetChildText(self.effectText[i]:getID(),effectDesc[i])
end
end


local _onClickMaterialItem=function(...)
self:onClickMaterialItem(...)
end
self.gainTable={}
if isUnLock then
local percent=self.bdData.pcreatesubpercent or 0
local func=function(...)
self:onSliderChange(...)
end


local hasPlan=self:_hasCostPlan(config)
local planSelected=hasPlan and(self.selectedPlanIdx~=nil and self.selectedPlanIdx>0)

if hasPlan and planSelected then
self.maxLianZhiCnt=self:getCanMakeMaxCount()
else

self.maxLianZhiCnt=UIDanYaoModel:getMaxLianZhiCount(config,percent)
end

if not self.maxLianZhiCnt or self.maxLianZhiCnt<=0 then
self.maxLianZhiCnt=1
end


local minCount=1
if self.selectCnt==nil or self.selectCnt<=0 then
self.selectCnt=self.maxLianZhiCnt
end
if self.selectCnt>self.maxLianZhiCnt then
self.selectCnt=self.maxLianZhiCnt
elseif self.selectCnt<minCount then
self.selectCnt=minCount
end

self.winlua:SetChildImageRaycast(self.handImgClick:getID(),self.maxLianZhiCnt>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,minCount,self.maxLianZhiCnt,func)


local hasPlan=self:_hasCostPlan(config)
local planSelected=hasPlan and(self.selectedPlanIdx~=nil and self.selectedPlanIdx>0)
self.addPlanBtn:setActive(hasPlan and not planSelected)
if self.btnHuan then
self.btnHuan:setActive(hasPlan and planSelected)
end

self.selectCntSlider:setActive(not(hasPlan and not planSelected))
self.selectBtn:setActive((not(hasPlan and not planSelected))and checkDz)

local cost=self:_getActiveCostList(config)
if hasPlan and not planSelected then
for i=1,#self.materialsItem do
self.materialsItem[i]:setActive(false)
end
self.matTypeText:setText('炼丹材料')
return
end


for i=1,#self.materialsItem do
self.materialsItem[i]:setActive(cost and i<=#cost)
if cost and i<=#cost then
local itemData=cost[i]
local itemId=itemData[1]
local price=itemData[2]
if itemsConfig.isMoney(itemId)then
price=math.ceil(price*(1+percent/100))
end

local needCount=price*self.selectCnt
local countStr=self:getItemCountStr(itemId,needCount)
local have=UIDanYaoModel:getHaveItemCount(itemId)

local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

prop[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
prop[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
prop[PropIndex(DataPropKey.eWidgetActive,7)]=have<needCount
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
self.materialsItem[i]:setChildPropData(prop)
self.materialsItem[i]:setBaseItemChildID(itemId)
self.materialsItem[i]:setBaseItemClickEvent(_onClickMaterialItem)
self.gainTable[itemId]=needCount
end
end
elseif lockType==1 then
self.addPlanBtn:setActive(false)
if self.btnHuan then
self.btnHuan:setActive(false)
end
self.materialsItem[1]:setActive(true)
for i=2,#self.materialsItem do
self.materialsItem[i]:setActive(false)
end
local cost=config.unlock
local itemId=cost[2]
local needCount=cost[3]
local countStr=self:getItemCountStr(itemId,needCount)
local have=UIDanYaoModel:getHaveItemCount(itemId)

local conf={itemid=itemId,itemcount=countStr,showCountBG=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

local notEnough=have<needCount
prop[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
prop[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
prop[PropIndex(DataPropKey.eWidgetActive,7)]=notEnough
local isCanUnlock=UIDanYaoModel.checkDanFangUpLevelUnlockReddot(dfId)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isCanUnlock
self.unLockBtn:setButtonEnable(not notEnough,notEnough)
self.materialsItem[1]:setChildPropData(prop)
self.materialsItem[1]:setBaseItemChildID(itemId)
self.materialsItem[1]:setBaseItemClickEvent(_onClickMaterialItem)
self.gainTable[itemId]=needCount
elseif lockType==3 then
self.addPlanBtn:setActive(false)
if self.btnHuan then
self.btnHuan:setActive(false)
end
local percent=self.bdData.pcreatesubpercent or 0
local cost=config.cost
for i=1,#self.materialsItem do
self.materialsItem[i]:setActive(i<=#cost)
if i<=#cost then
local itemData=cost[i]
local itemId=itemData[1]
local price=itemData[2]
if itemsConfig.isMoney(itemId)then
price=math.ceil(price*(1+percent/100))
end

local needCount=price*self.selectCnt

local countStr=self:getItemCountStr(itemId,needCount)
local have=UIDanYaoModel:getHaveItemCount(itemId)

local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

prop[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
prop[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
prop[PropIndex(DataPropKey.eWidgetActive,7)]=have<needCount
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
self.materialsItem[i]:setChildPropData(prop)
self.materialsItem[i]:setBaseItemChildID(itemId)
self.materialsItem[i]:setBaseItemClickEvent(_onClickMaterialItem)
self.gainTable[itemId]=needCount
end
end
end
end
end

function UIDanFangWin:refreshMaterialsCnt()
local dfId=self.dfId
local config=cfg_danfangconfig_get(dfId)
local cost=self:_getActiveCostList(config)
if not cost then
return
end
local percent=self.bdData.pcreatesubpercent or 0
for i=1,#self.materialsItem do
if i<=#cost then
local itemData=cost[i]
local itemId=itemData[1]
local price=itemData[2]
if itemsConfig.isMoney(itemId)then
price=math.ceil(price*(1+percent/100))
end
local needCount=price*self.selectCnt
local countStr=self:getItemCountStr(itemId,needCount)
local item=self.winlua:GetChildCSGUIBaseItem(self.materialsItem[i]:getID())
item:SetChildText(3,countStr)
local have=UIDanYaoModel:getHaveItemCount(itemId)
item:SetChildImageExGray(0,have==0)
item:SetChildImageExGray(1,have==0)
item:SetChildActive(7,have<needCount)
self.gainTable[itemId]=needCount
end
end
end

function UIDanFangWin:onSliderChange(value)

self.selectCnt=value
self.selectCntText:setText(self.selectCnt)
local dfId=self.dfId
local need=UIDanYaoModel:getDanFangNeedTime(dfId,self.bdData.dizi_id)
local needTime=need*self.selectCnt
self.timeText:setText(timeHelper.format_time_stamp4(needTime))
self:refreshMaterialsCnt()
end


function UIDanFangWin:onClickMaterialItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
local needCount=self.gainTable[itemId]or 0
local have=UIDanYaoModel:getHaveItemCount(itemId)
if have<needCount then
UIDanYaoModel:recordDanFangCanGetTip(self.dfId)
gainControl:showGainWin(itemId)
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,usingType=TIPS_USING_TYPE.eGainWay,move=TIPS_MOVE_POS.eLeft})
end

function UIDanFangWin:getCanMakeMaxCount()
local dfId=self.dfId
local config=cfg_danfangconfig_get(dfId)
local cost=self:_getActiveCostList(config)
if not cost or#cost==0 then
return 1
end
local count=config.maxcnt
local percent=self.bdData.pcreatesubpercent or 0
for i,v in ipairs(cost)do
local itemId=v[1]
local price=v[2]
if itemsConfig.isMoney(itemId)then
price=math.ceil(price*(1+percent/100))
end
local have=UIDanYaoModel:getHaveItemCount(itemId)
local minCnt=math.floor(have/price)
if minCnt<count then
count=minCnt
end
end
if count<=0 then
count=1
end
return count
end

function UIDanFangWin:onSelectDefault()
self.needFresh=true
self:freshDFList()
local dfList=self.dfList
local dfId=dfList[1].id
self:onSelect(dfId)
end

function UIDanFangWin:onSelect(dfId,num)
if dfId==nil then return end
local dfType=UIDanYaoModel:getDFType(dfId)
num=num or self:getDefaultNum(dfId)
if self.dfType==dfType and self.dfId==dfId and self.selectCnt==num then return end

self.dfType=dfType
self.dfId=dfId
self.selectCnt=num
self.selectPage=_pageLookup[dfType]
self:freshFilter()
self:freshDFList()
self:freshDanFangList()
self:freshRightPanel()
self:setSelectBtnName()
end

function UIDanFangWin:onSelectPage(index)
if self.selectPage==index then return end
self.selectPage=index
self.filterIdx=nil
self.dfType=nil
self.dfId=nil
self.selectCnt=nil
self:onSelectDefault()
end

function UIDanFangWin:getDefaultNum(dfId)
local cfg=cfg_danfangconfig_get(dfId)
local isUnlock=UIDanYaoModel:isUnLock(dfId)
if isUnlock then
local percent=self.bdData.pcreatesubpercent or 0
return UIDanYaoModel:getMaxLianZhiCount(cfg,percent)
end
return 1
end


function UIDanFangWin:loadBtns()
local len=#_btnsInfo
self.toggleGroup:setChildLayoutGroupCreateItems(len)
local selectPage=self.selectPage or 1
for i=1,len do
local info=_btnsInfo[i]
local name=info.name
local item=self.toggleGroup:getChildLayoutGroupGridItem(i-1)
item:SetChildButtonClickWithID(0,self.onToggleChange,i,true)
item:SetChildText(1,name)

local isSelected=selectPage==i
local func=function()
if isSelected then

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)


end
end

function UIDanFangWin.onToggleChange(idx)
if _this.selectPage~=idx then
if _this.selectPage then
_this:setToggleOn(_this.selectPage,false)
end
_this:setToggleOn(idx,true)

_this:onSelectPage(idx)
end
end

function UIDanFangWin:getSelectType()
local curSelectPage=self.selectPage
return _btnsInfo[curSelectPage].type
end

function UIDanFangWin:setToggleOn(index,on)
local item=self.toggleGroup:getChildLayoutGroupGridItem(index-1)
if on then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,on and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIDanFangWin:clearNewFlag()
local haveNew=UIDanYaoModel:checkHaveDanFangNew()
UIDanYaoModel:clearDanFangNewFlag()
if haveNew then
UIDanYaoController:refreshAllLianDanFangHud()
reddotControl.on_change_catch_type(CATCH_TYPE.eDanFangNew)
UIManager:invokeUIMethod('UIDanYaoWin','refreshNewImg')
end
end



function UIDanFangWin.on_combobox_change(index)
if _this.filterIdx==index then return end
_this.filterIdx=index
_this.needFresh=true
_this:freshDFList()
if _this.isInit and _this.dfId then
_this.selectCnt=nil
_this.dfId=nil
_this:onSelectDefault()
else
_this:onSelect(_this.dfId)
end
_this.isInit=true
end

function UIDanFangWin:onQuickAddMoneyBtn()
gainControl:showGainWin(eMoneyType.mtLingCao)
end

function UIDanFangWin:onSelectBtn()
if UIDanYaoModel:isDingDanComplete(self.bdData.un_build_id)then
UIManager.error('领取已全部完成的炼丹订单后才能继续添加订单')
return
end
local dfId=self.dfId
local config=cfg_danfangconfig_get(dfId)
local percent=self.bdData.pcreatesubpercent or 0

local cost=self:_getActiveCostList(config)
if self:_hasCostPlan(config)and(not cost or#cost==0)then
UIManager.error('请先选择炼制方案')
return
end

local isCan,itemid=UIDanYaoModel:isCanLianZhi(cost,self.selectCnt,percent)
if isCan then
local win=UIManager:findActiveWindow('UIDanYaoWin')
if win then

local fangan=self:_getActiveFangAn(config)
win:actionLianZhi(config.id,self.selectCnt,fangan)
end
if not UIDanYaoController:isDingDanSystemOpen()then
self:closeSelf()
end
else
UIManager.error('材料不足，无法炼制')
gainControl:showGainWin(itemid)
end
end


function UIDanFangWin:onUnLockBtn()
local dfId=self.dfId
local config=cfg_danfangconfig_get(dfId)
if config.unlock then
local isCanUnLock=UIDanYaoModel:isCanUnLock(config.unlock)
if isCanUnLock then
UIDanYaoController:req_unlock_df(config.id)
else
UIManager.error('条件不足')
end
else
logErr('默认解锁，界面有问题')
end
end

function UIDanFangWin:onSubBtn()
end

function UIDanFangWin:onAddBtn()
end


function UIDanFangWin:onAddPlanBtn()
local dfId=self.dfId
local config=cfg_danfangconfig_get(dfId)

local planCount=0
planCount=#config.cost_plan

UIManager:showWindow('UIDanFangSelectWin',{
dfId=dfId,
selectedPlanIdx=self.selectedPlanIdx,
planCount=planCount,
costPlanList=config.cost_plan,
showSelectedOnInit=false,
onConfirm=function(planIdx)
_this:onClickSelectCostPlanBtn(planIdx)
end
})
end


function UIDanFangWin:onBtnHuan()
local dfId=self.dfId
local config=cfg_danfangconfig_get(dfId)
local planCount=0
planCount=#config.cost_plan

UIManager:showWindow('UIDanFangSelectWin',{
dfId=dfId,
selectedPlanIdx=self.selectedPlanIdx,
planCount=planCount,
costPlanList=config.cost_plan,
showSelectedOnInit=true,
onConfirm=function(planIdx)
_this:onClickSelectCostPlanBtn(planIdx)
end
})
end

function UIDanFangWin:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.maxLianZhiCnt then
return
end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


function UIDanFangWin:onMaxCnt()
local canMaxCnt=self:getCanMakeMaxCount()
self.selectCnt=canMaxCnt
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIDanFangWin:onActive(dfId)
if dfId~=self.dfId then return end
self:freshRightPanel()
self:freshBtnsReddot()
end

function UIDanFangWin.on_item_list_changed()
if _this==nil then return end
_this:freshBtnsReddot()
end

function UIDanFangWin:freshBtnsReddot()

local btnReddots={}
local percent=self.bdData.pcreatesubpercent or 0
for _,v in pairs(DANYAO_FILTER_TYPE)do
local dfList=UIDanYaoModel:getDanFangList(self.dzId,v,0,percent)
local reddot=false
for _,cfg in ipairs(dfList)do
local isUnLock=UIDanYaoModel:isUnLock(cfg.id)
if isUnLock then
local checkDz=self:checkDzProLevel(cfg)
local canMake=UIDanYaoModel:isCanLianZhi(cfg.cost,1,percent)
local flag=checkDz and canMake
reddot=reddot or flag
else
reddot=reddot or UIDanYaoModel:isCanUnLock(cfg.unlock)or UIDanYaoModel.checkDanFangUpLevelUnlockReddot(cfg.id)
end
if reddot then
break
end
end
btnReddots[v]=reddot
end

local len=#_btnsInfo
self.toggleGroup:setChildLayoutGroupCreateItems(len)
local selectPage=self.selectPage or 1
for i=1,len do
local item=self.toggleGroup:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(3,btnReddots[i]or false)
end
end

function UIDanFangWin:getItemCountStr(itemId,needCount)
local have=UIDanFangWin:getHaveItemCount(itemId)
local colorStr=have<needCount and'#E33021FF'or'#ffffffff'
local countStr=''
if moneyConfig.isMoney(itemId)then
countStr=FMT.fmt('<color={0}>{1}</color>',colorStr,UIDanFangWin:formatBIGNumbereEx(needCount))
else
countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,mathHelper.formatBIGNumbereEx(have),mathHelper.formatBIGNumbereEx(needCount))
end
return countStr
end
function UIDanFangWin:getHaveItemCount(itemid)
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
return have
end


function UIDanFangWin:formatBIGNumbereEx(n)
local ret=tostring(n)
if n>=10000 then

ret=mathHelper.formatNumber4(n,1)
end
if n>=100000000 then

ret=mathHelper.formatNumber4(n,1)
end
return ret
end

function UIDanFangWin:countWeightList()
local dfId=self.dfId
local config=cfg_danfangconfig_get(dfId)
local const_def=cfg_danfangconfig().const_def
local bd_tybe_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
local skill_id=bd_tybe_cfg.pro_skill_id
local level=UIDiscipleModel:getDiscipleJobLevel(self.bdData.dizi_id,skill_id)

local random_item_conf=config.random_item_conf
local wdata
for i,v in ipairs(random_item_conf)do
if level>=v[1]and level<=v[2]then
wdata=v[3]
break
end
end
if not wdata then
return nil
end
local checkLevel=config.standard_dd_lvl
local list={}
local tWeight=0
local temp={}
for i,v in ipairs(wdata)do
local itemCfg=itemsConfig.getConfig(v[1])
if v[3]==1 and level>checkLevel then
local lvDiff=level-checkLevel
list[itemCfg.color]=v[2]+const_def.ddUpdateWeight*lvDiff
elseif v[3]==0 and level<checkLevel then
local lvDiff=checkLevel-level
list[itemCfg.color]=v[2]+const_def.ddUpdateWeight*lvDiff
else
list[itemCfg.color]=v[2]
end
tWeight=tWeight+list[itemCfg.color]
end


for i,v in pairs(list)do
temp[i]=math.floor(v/tWeight*10000)
end


tWeight=0
local idxArr={}
for i,v in pairs(temp)do
tWeight=tWeight+v
table.insert(idxArr,i)
end

local precentArray={}
local left=100
local lastColor
for i=#idxArr,1,-1 do
local idx=idxArr[i]
local val=temp[idx]
local precent=math.floor(val*1000/tWeight)/10
precentArray[idx]=precent
left=left-precent
if val>0 then
lastColor=idx
end
end
if left>0 then
precentArray[lastColor]=precentArray[lastColor]+left
end

return precentArray
end

function UIDanFangWin:freshWeight()
local flag=true
if flag then
local weightList=self:countWeightList()
if weightList then
for i=1,5 do
local color=i
local cmp=self.weightWidgetList[i]
local num=weightList[color]or 0
num=string.format('%.1f',num)
num=tonumber(num)
local widget=cmp:getChildWidgetBase()
widget:SetChildText(0,num)
end
else
flag=false
end
end
self.wieghtRoot:setActive(flag)
end

function UIDanFangWin:refreshBtnsInfo()
_btnsInfo={}
for _,v in ipairs(_btnsInfoEx)do
if UIDanYaoModel:hasDanFang(v.type)then
_btnsInfo[#_btnsInfo+1]=v
end
end

for i,v in ipairs(_btnsInfo)do
_pageLookup[v.type]=i
end
end

function UIDanFangWin:getPageType(pageIndex)
return _btnsInfo[pageIndex].type
end


function UIDanFangWin:_hasCostPlan(config)
local plan=config and config.cost_plan
return plan~=nil and type(plan)=='table'and next(plan)~=nil
end

function UIDanFangWin:_getActiveCostList(config)
if not config then return nil end
if self:_hasCostPlan(config)then
local idx=self.selectedPlanIdx
if not idx or idx<=0 then
return nil
end
return config.cost_plan[idx]
end
return config.cost
end

function UIDanFangWin:_getActiveFangAn(config)
if self:_hasCostPlan(config)then
return self.selectedPlanIdx or 0
end
return 0
end

function UIDanFangWin:_resetPlanStateByCfg(config)
if self:_hasCostPlan(config)then
self.selectedPlanIdx=nil
else
self.selectedPlanIdx=0
end
end

function UIDanFangWin:onClickSelectCostPlanBtn(planIdx)
local config=cfg_danfangconfig_get(self.dfId)
if not(config and self:_hasCostPlan(config))then
return
end
planIdx=tonumber(planIdx)
if not planIdx or planIdx<=0 or config.cost_plan[planIdx]==nil then
UIManager.error('请选择有效的炼制方案')
return
end
self.selectedPlanIdx=planIdx
self:_savePlanIdx(self.dfId,planIdx)
self:freshRightPanel()
end


UIDanFangWin._costPlanSaveKeyPrefix='danyao_danfang_cost_plan_idx_'

function UIDanFangWin:_getPlanSaveKey(dfId)
dfId=tonumber(dfId)
if not dfId or dfId<=0 then
return UIDanFangWin._costPlanSaveKeyPrefix..'0'
end
return UIDanFangWin._costPlanSaveKeyPrefix..tostring(dfId)
end

function UIDanFangWin:_loadSavedPlanIdx(dfId,planCount)
planCount=tonumber(planCount)or 0
if planCount<=0 then return nil end
local key=self:_getPlanSaveKey(dfId)
local idx=userActorSetting.get(key,nil)
idx=tonumber(idx)
if idx and idx>0 and idx<=planCount then
return idx
end
return nil
end

function UIDanFangWin:_savePlanIdx(dfId,planIdx)
planIdx=tonumber(planIdx)
if not planIdx or planIdx<=0 then return end
local key=self:_getPlanSaveKey(dfId)
userActorSetting.set(key,planIdx)
userActorSetting.flush(true)
end

function UIDanFangWin:_tryRestoreCostPlan(config)
if not self:_hasCostPlan(config)then
return false
end
if self.selectedPlanIdx and tonumber(self.selectedPlanIdx)and tonumber(self.selectedPlanIdx)>0 then
return false
end
local dfId=self.dfId
local planCount=config and config.cost_plan and#config.cost_plan or 0
local savedIdx=self:_loadSavedPlanIdx(dfId,planCount)
if not savedIdx then
return false
end
self:onClickSelectCostPlanBtn(savedIdx)
return true
end
