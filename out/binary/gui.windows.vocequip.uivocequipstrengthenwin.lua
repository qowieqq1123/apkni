







def_class("UIVocEquipStrengthenWin",UIWindowBase)









function UIVocEquipStrengthenWin:bindComponents()

self.disciplePanel=UIObject.get(self,0)
self.leftPanel=UIObject.get(self,1)
self.effectRoot=UIObject.get(self,2)
self.showItem=UIBaseItem.get(self,3)
self.desc=UIText.get(self,4)
self.equipItem=UIBaseItem.get(self,5)
self.effect1=UIObject.get(self,6)
self.effect2=UIObject.get(self,7)
self.effect3=UIObject.get(self,8)
self.effect4=UIObject.get(self,9)
self.effect0=UIObject.get(self,10)
self.effect=UIObject.get(self,11)
self.effect5=UIObject.get(self,12)
self.DropdownMask=UIObject.get(self,13)
self.Dropdown=UIDropdownEx.get(self,14)
self.name=UIText.get(self,15)
self.progressBar=UIProgressBarAni.get(self,16)
self.progressCountReverse=UIText.get(self,17)
self.nowLevelText=UIText.get(self,18)
self.progressBarReverse=UIProgressBarAni.get(self,19)
self.progressCount=UIText.get(self,20)
self.discipleList=UIScrollView.get(self,21)
self.resetLvBtn=UIButton.get(self,22)
self.strengthenBtn=UIButton.get(self,23)
self.costTitleText=UIText.get(self,24)
self.costMoneyGroup=UIObject.get(self,25)
self.strengthenPanel=UIObject.get(self,26)
self.breakPanel=UIObject.get(self,27)
self.breakBtn=UIButton.get(self,28)
self.baseAttrsGroup=UIObject.get(self,29)
self.vocAttrInfoBtn=UIButton.get(self,30)
self.vocAttrsGroup=UIObject.get(self,31)
self.leftDialogue=UIButton.get(self,32)
self.leftdialogueinfo=UIObject.get(self,33)
self.ScrollView=UIScrollViewSlow.get(self,34)
self.Dropdown1_Dialogue=UIDropdownEx.get(self,35)
self.Dropdown2_Dialogue=UIDropdownEx.get(self,36)
self.putBtnReddot_Dialogue=UIObject.get(self,37)
self.putItemBtn=UIButton.get(self,38)
self.resetItemBtn=UIButton.get(self,39)
self.costItemGroup=UIObject.get(self,40)
self.vocAttrsScrollView=UIObject.get(self,41)
self.unMaxLvPanel=UIObject.get(self,42)
self.maxLvPanel=UIObject.get(self,43)
self.putItemOutBtn=UIButton.get(self,44)

self.resetLvBtn:setButtonClick(function()self:onResetLvBtn()end)

self.strengthenBtn:setButtonClick(function()self:onStrengthenBtn()end)

self.breakBtn:setButtonClick(function()self:onBreakBtn()end)

self.vocAttrInfoBtn:setButtonClick(function()self:onVocAttrInfoBtn()end)

self.leftDialogue:setButtonClick(function()self:onLeftDialogue()end)

self.putItemBtn:setButtonClick(function()self:onPutItemBtn()end)

self.resetItemBtn:setButtonClick(function()self:onResetItemBtn()end)

self.putItemOutBtn:setButtonClick(function()self:onPutItemOutBtn()end)
self.Dropdown1={
["Dialogue"]=self.Dropdown1_Dialogue,
}
self.Dropdown2={
["Dialogue"]=self.Dropdown2_Dialogue,
}
self.putBtnReddot={
["Dialogue"]=self.putBtnReddot_Dialogue,
}



end


function UIVocEquipStrengthenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.disciplePanel);self.disciplePanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.showItem);self.showItem=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.equipItem);self.equipItem=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect0);self.effect0=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.DropdownMask);self.DropdownMask=nil;
_UIObject_release(self.Dropdown);self.Dropdown=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressCountReverse);self.progressCountReverse=nil;
_UIObject_release(self.nowLevelText);self.nowLevelText=nil;
_UIObject_release(self.progressBarReverse);self.progressBarReverse=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
_UIObject_release(self.resetLvBtn);self.resetLvBtn=nil;
_UIObject_release(self.strengthenBtn);self.strengthenBtn=nil;
_UIObject_release(self.costTitleText);self.costTitleText=nil;
_UIObject_release(self.costMoneyGroup);self.costMoneyGroup=nil;
_UIObject_release(self.strengthenPanel);self.strengthenPanel=nil;
_UIObject_release(self.breakPanel);self.breakPanel=nil;
_UIObject_release(self.breakBtn);self.breakBtn=nil;
_UIObject_release(self.baseAttrsGroup);self.baseAttrsGroup=nil;
_UIObject_release(self.vocAttrInfoBtn);self.vocAttrInfoBtn=nil;
_UIObject_release(self.vocAttrsGroup);self.vocAttrsGroup=nil;
_UIObject_release(self.leftDialogue);self.leftDialogue=nil;
_UIObject_release(self.leftdialogueinfo);self.leftdialogueinfo=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Dropdown1_Dialogue);self.Dropdown1_Dialogue=nil;
_UIObject_release(self.Dropdown2_Dialogue);self.Dropdown2_Dialogue=nil;
_UIObject_release(self.putBtnReddot_Dialogue);self.putBtnReddot_Dialogue=nil;
_UIObject_release(self.putItemBtn);self.putItemBtn=nil;
_UIObject_release(self.resetItemBtn);self.resetItemBtn=nil;
_UIObject_release(self.costItemGroup);self.costItemGroup=nil;
_UIObject_release(self.vocAttrsScrollView);self.vocAttrsScrollView=nil;
_UIObject_release(self.unMaxLvPanel);self.unMaxLvPanel=nil;
_UIObject_release(self.maxLvPanel);self.maxLvPanel=nil;
_UIObject_release(self.putItemOutBtn);self.putItemOutBtn=nil;
self.Dropdown1=nil;
self.Dropdown2=nil;
self.putBtnReddot=nil;
end















local _remove=table.remove
local _insert=table.insert

local _bag_filter_desc={}
local _colomn=4
local _row=5
local _maxAttrLine=7
local _fillItemLen=3
local _colorFormat=
{
[eQualityColor.eGreen]='#4f851b',
[eQualityColor.eBlue]='#1b4385',
[eQualityColor.ePurple]='#431b85',
[eQualityColor.eOrange]='#85451b',
[eQualityColor.eRed]='#851b1b',

}
local _upImg={1,4,5,2,}
local atlasAb="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"
local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpSuitIcon=13,
cmpSelect=14,
xmicons=15,
xmstagetxt=16,
}




function UIVocEquipStrengthenWin:onLoaded(...)
self:bindComponents()

self._on_select_dis=function(...)
self:on_select_dis(...)
end
self.discipleList:setClickAction(self._on_select_dis)
self.isInitDiscipleList=false

self.showItem:setBaseItemClickEvent(function(...)self:onItemClick(...)end)
self.Dropdown:setDropdownCreatedAction(function(...)self:onDropdownCreated(...)end)


self._onItemLockChanged=function(...)self:onItemLockChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemListChanged(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)

self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)

self.ScrollView:setSlowLongClickAction(function(...)self:onClickLongGridButton(...)end)

local colorlist=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
_bag_filter_desc[ITEM_FILTER_TYPE.eColor]=itemsFilterHelper.getFilterNames(colorlist,function(color)
return FMT.fmt('{0}及以下',eQualityColorName[color])
end)

local stagelist=table.toTable(1,EQUIP_STAGE_MAX)
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=itemsFilterHelper.getFilterNames(stagelist,function(stage)
return FMT.fmt('{0}阶及以下',stage)
end)

self.leftDialogue:setActive(false)

self:resetData()







self.unlockItem={}
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
self.checkList={}
end


function UIVocEquipStrengthenWin:__delete()
self.isRefreshingPutBtnReddot=nil
self.needRefreshPutBtnReddot=nil



local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid

notifySystem:removelistener(notifyConfig.on_item_lock_changed,self._onItemLockChanged)
self:unbindComponents()

self.isInitDiscipleList=false


self:stopBehavior()


discipleEquipSheetReddot:resetConfig()
end




function UIVocEquipStrengthenWin:onShow(argtable,afterOnloaded)
self:freshEquip(argtable)
end


function UIVocEquipStrengthenWin:onHide()
self.discipleList:setActive(false)
self.equipList:setActive(false)
end

function UIVocEquipStrengthenWin:freshEquip(argtable)
self:resetData()
if argtable then
local itemguid=argtable.itemguid
self.item=equipsHelper.getEquip(itemguid)
local isEquip=vocEquipModel:isEquipedOnAnyDizi(itemguid)
self.isEquip=isEquip
end
local item=self.item
local itemid=item.itemid
local vocId=vocEquipHelper.getEquipVocId(itemid)
self.vocAttrList=vocEquipHelper.getVocEquipAllVocAttrsByVocId(vocId,itemid)

self.disciplelist={}
self.jobSkillList=nil
if self.isEquip then
self.disciple_guid=vocEquipModel:getDiziguidByItemguid(argtable.itemguid)
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
local sortType=UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local sortParams={true}
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder,sortParams)
for i,v in ipairs(list)do
local equip=vocEquipModel:getEquipByDizi(v.netData.net.discipleguid)
if equip then
_insert(self.disciplelist,v)
end
end
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,self.disciple_guid)then
self.curDisIndex=i
break
end
end
self.jobSkillList=self.disciple_guid and UIDiscipleModel:getDiscipleJobSkillList(self.disciple_guid)or nil
end
local len=#self.disciplelist
if len>0 then
if not self.isInitDiscipleList then
self.isInitDiscipleList=true
self:refreshDiscipleList()
else
self.discipleList:setActive(true)
end
end
self.disciplePanel:setActive(len>0)

self:freshInfo()

self.strengthenLvIdx=nil
self.DropdownMask:setActive(self.strengthenLvIdx==nil)
end

function UIVocEquipStrengthenWin:resetData()
self.selectItemsLookup={}
self.selectList={}
self.addExp=0
self.leftExp=0
self.overExp=0
self.addItemExp=0
self.addLastItemExp=0
self.addLv=0
self.curPageIndex=1
self.isSetZero=false
self.isNewList={}
end

function UIVocEquipStrengthenWin:freshAddExp()
local selectItems=self.selectList or{}
local addItemExp,addExp,addLv,leftExp,overExp=self:getStrengthenData(selectItems)
self.addItemExp=addItemExp
self.addExp=addExp
self.addLv=addLv
self.leftExp=leftExp
self.overExp=overExp
end

function UIVocEquipStrengthenWin:freshInfo()
self:setShowItems()
self:setProgress()
self:setMoneyCostItems()
self:setDropdowns()
self:refreshCostItems()
self:setAttrs()
end

function UIVocEquipStrengthenWin:setShowItems()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetIcon,0,itemsModel.getIconName(item))
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetText,1,itemsConfig.getItemName(itemid))
self.showItem:setChildItemData(DataPropKey.eItemID,itemid)
self.showItem:setChildItemData(DataPropKey.eItemSeries,itemguid)


local maxlv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
self.desc:setText(FMT.fmt('当前装备最高可强化至<color=#ca631d>{0}级</color>',maxlv))




self:fillItem(item)
end

function UIVocEquipStrengthenWin:setProgress()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local vocId=vocEquipHelper.getEquipVocId(itemid)
local maxlv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)

local enhancelv=item.itemData and item.itemData.enhancelv or 0
local enhanceexp=item.itemData and item.itemData.enhanceexp or 0
local duration=self.progressAni and 0.5 or 0
local durationReverse=self.progressReverseAni and 0.5 or 0
local addExp=self.addExp
local addLv=self.addLv
local isBreak=vocEquipHelper.checkStrengthenLvIsBreak(vocId,enhancelv)
if isBreak then
addLv=1
end
local curIsFull=enhancelv>=maxlv
local lastAddExp=self.addLastItemExp
self.addLastItemExp=self.addItemExp
if curIsFull then
self.progressBar:animateThreeParams(100,100,duration)
self.progressBarReverse:animateThreeParams(0,100,durationReverse)
self.progressCount:setText('已满')
self.progressCountReverse:setText('')
else
local curExp=enhanceexp
local curShowExp=curExp
local fillExp=self.leftExp
local maxExp=0
local targetlv=addLv+enhancelv
local isFull=targetlv>=maxlv
local addItemExp=self.addItemExp
local tExp=0
local spStr
local isTargetBreak=vocEquipHelper.checkStrengthenLvIsBreak(vocId,targetlv)
if isBreak or isTargetBreak then
spStr="需突破 0/1"
end

if addLv<=0 then

maxExp=vocEquipHelper.getStrengthenExp(vocId,enhancelv)
else
if not isFull then

maxExp=vocEquipHelper.getStrengthenExp(vocId,targetlv)
else

maxExp=vocEquipHelper.getStrengthenExp(vocId,maxlv-1)
fillExp=fillExp+maxExp
end
if addLv>0 and not(addLv==1 and enhancelv==maxlv-1)then
curShowExp=0
end
end
if addItemExp==0 then
fillExp=curShowExp
end
local showProgressStr=spStr or FMT.fmt('{0}/{1}',math.floor(fillExp),maxExp)

self.progressBar:animateThreeParams(curShowExp,maxExp,duration,false)
self.progressBarReverse:animateThreeParams(self.progressReverseAni and fillExp or curShowExp,maxExp,durationReverse)
self.progressCount:setText(showProgressStr)
self.progressCountReverse:setText(FMT.fmt('+{0}',math.floor(self.addItemExp)))
end

local needBreakStr=isBreak and"（需突破）"or""
local addLvStr=addLv>0 and string.format("+%d",addLv)or""
local nowLevelStr=FMT.fmt('当前：{0}级{1}  {2}',enhancelv,needBreakStr,addLvStr)

self.nowLevelText:setText(nowLevelStr)
self.progressAni=false
self.progressReverseAni=false

local costTitleStr=isBreak and"突破消耗"or"强化消耗"
self.costTitleText:setText(costTitleStr)
end


function UIVocEquipStrengthenWin:setMoneyCostItems()
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local curlv=item.itemData and item.itemData.enhancelv or 0
local vocId=vocEquipHelper.getEquipVocId(itemid)
local isBreak=vocEquipHelper.checkStrengthenLvIsBreak(vocId,curlv)

local moneyCostList={}
if isBreak then
local allCostList=vocEquipHelper.getStrengthenBreakItemCostByLevel(itemguid,curlv)
for _,v in ipairs(allCostList)do
local itemId=v[1]
if itemsConfig.isMoney(itemId)then
moneyCostList[#moneyCostList+1]=v
end
end
else
moneyCostList=vocEquipHelper.getStrengthenMoneyCost(itemguid,self.addItemExp-self.overExp)or{}
end
local count=#moneyCostList
self.costMoneyGroup:setChildLayoutGroupCreateItems(count,function(index)
local widget=self.costMoneyGroup:getChildLayoutGroupGridItem(index-1)
local moneyCost=moneyCostList[index]
if moneyCost then
widget:SetChildActive(-1,true)
local itemid=moneyCost[1]
self.checkList[itemid]=true
local cost=moneyCost[2]
local has=moneyModel.getMoney(itemid)
local costStr=has>=cost and cost or FMT.cfmt(FONT_COLOR.eRedColor,cost)

widget:SetChildIcon(0,iconHelper.getIconName(itemid),false)
widget:SetChildText(1,costStr)
else
widget:SetChildActive(-1,false)
end
end)
end


function UIVocEquipStrengthenWin:setDropdowns()
local strengthenLvDescList=self:getStrengthenLvDescList()
self.Dropdown:setOption(strengthenLvDescList)
















end

function UIVocEquipStrengthenWin:getStrengthenLvDescList()
local item=self.item
local itemid=item.itemid
local vocId=vocEquipHelper.getEquipVocId(itemid)
local maxlv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
local templist={}
local levellist={}
for i=0,maxlv do
local strengthenConfig=vocEquipHelper.getStrengthenConfig(vocId,i)
if strengthenConfig and i+1<=maxlv then
templist[#templist+1]=FMT.fmt("+{0}级",i+1)
levellist[#levellist+1]=i+1
end
end
return templist,levellist
end





















function UIVocEquipStrengthenWin:freshBagList()
local bagList=vocEquipHelper.getMateriasOnBag(self.item.itemguid)or{}

local list={}
local looupup={}
if#bagList>0 then
for i=#bagList,1,-1 do
local item=bagList[i]
local guidStr=item.guidStr or tostring(item.itemguid)
if not looupup[guidStr]and self:isPutItem(item.itemguid)then
list[#list+1]=item
looupup[guidStr]=true
_remove(bagList,i)
end
end

for i,v in ipairs(list)do
_insert(bagList,1,v)
end
end

self.bagList=bagList
end

function UIVocEquipStrengthenWin:freshProvideSelectGrids(freshData)
if not self.showDialogue then return end
if freshData then
self:freshBagList()
end
local list=self.bagList
local rNum=#list
local pageNum=_row*_colomn
if rNum<pageNum then rNum=pageNum end
local tRow=math.ceil(rNum/_colomn)
local tPage=math.ceil(rNum/pageNum)
self.tPage=tPage
local curPageIndex=self.curPageIndex
local showNum=curPageIndex*pageNum
local showRow=math.ceil(showNum/_colomn)
if curPageIndex==1 then
self.ScrollView:clearSlowItems()
end
self.ScrollView:freshSlowGrids(showNum,showRow,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIVocEquipStrengthenWin:isPutItem(itemguid)
for i=1,_fillItemLen do
local info=self.selectList[i]
if info and info[1]==itemguid and info[2]and info[2]>0 then
return true
end
end
return false
end


function UIVocEquipStrengthenWin:startBehavior()
local flag=0
for i=1,_fillItemLen do
local info=self.selectList[i]
if info then
flag=flag+math.pow(2,i-1)
end
end
local target0=self.effect0:getID()
local target1=self.effect1:getID()
local target2=self.effect2:getID()
local target3=self.effect3:getID()
local target4=self.effect4:getID()
local target5=self.effect5:getID()

local parent=self.effectRoot:getID()
local pos=self.winlua:GetChildPosition(target0)
local v0=Vector2.New(0,0)
local initData=
{
stateId=flag,
widget=self.winlua,
target0=target0,
target1=target1,
target2=target2,
target3=target3,
target4=target4,
target5=target5,
parent=parent,
pos=pos,
duration1=1,
duration2=1.1,
duration3=1.2,
duration4=1.3,
duration5=1.4,


eSlider1=Vector2.New(0.3,0.4),
oSlider1=Vector2.New(0.3,0.4),

eSlider2=Vector2.New(0.1,0.2),
oSlider2=Vector2.New(0.1,0.2),

eSlider3=Vector2.New(0,0),
oSlider3=Vector2.New(0,0),

eSlider4=Vector2.New(-0.1,-0.2),
oSlider4=Vector2.New(-0.1,-0.2),

eSlider5=Vector2.New(-0.3,-0.4),
oSlider5=Vector2.New(-0.3,-0.4),
}
self:stopBehavior()
self.bt=behaviorManager:addBehaviorTree('bt_ui_equip_jinglian_fly',nil,true,initData)

end

function UIVocEquipStrengthenWin:stopBehavior()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end
function UIVocEquipStrengthenWin:fillItem(equip)
local prop={}
local widget=self.equipItem:getWidgetBase()
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local enhanceStr=''
local iconName
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage

local showStage=false
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=showStage and FMT.fmt('仙·{0}{1}',stage,stageTitile)or''
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=showStage and FMT.fmt('魔·{0}{1}',stage,stageTitile)or''
end
local star=0
local reddot=false
local suitIconName=''
if itemsConfig.isVocEquip(itemid)then
local enhancelv=equip.itemData and equip.itemData.enhancelv or 0
enhanceStr=enhancelv>0 and FMT.fmt('+{0}',enhancelv)or''
iconName=itemsModel.getIconName(equip)

end

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,enhanceStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildText(_itemWidgetIdx.xmstagetxt,xmstageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,enhanceStr~='')
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)

widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)

if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end

widget:SetChildActive(_itemWidgetIdx.cmpSelect,true)


local ninglianStar=equipsModel.getNingLianStar(equip)
if ninglianStar and ninglianStar>0 then
widget:SetChildActive(_itemWidgetIdx.xmicons,true)
local xmWidget=widget:GetChildWidgetBase(_itemWidgetIdx.xmicons)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_jinlian1")
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_moyan1")
end
end
end
else
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
end

widget:SetBaseItemClickEvent(-1,function(...)self:onItemClick(...)end)
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
widget:SetBaseItemClickEvent(-1,function(...)end)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIVocEquipStrengthenWin:onStrengthen(oldlv,newlv)
if newlv~=oldlv and self.overExp==0 then
self.winlua:SetChildShowEffect(self.effect:getID(),10060,true)
end
self.onStrengthenFinish=true
self.progressAni=true
self.progressReverseAni=false
self:startBehavior()
self:resetData()
self:freshInfo()
self:freshProvideSelectGrids(true)

local equip=vocEquipModel:getEquipByDizi(self.disciple_guid)
if equip then
self:fillItem(equip)
end

if self.strengthenLvIdx then
local upItem=self.item
local enhancelv=upItem.itemData and upItem.itemData.enhancelv or 0
local strengthenLvDescList,levellist=self:getStrengthenLvDescList()
local targetlevel=levellist[self.strengthenLvIdx+1]

if targetlevel==enhancelv then
self.strengthenLvIdx=nil
self.DropdownMask:setActive(true)
else
self:onPutClick(true)
end
end
end


function UIVocEquipStrengthenWin:checkMaxLv()
local upItem=self.item
local enhancelv=upItem.itemData and upItem.itemData.enhancelv or 0
local maxlv=vocEquipHelper.getStrengthenMaxLvByItemid(upItem.itemid)
if enhancelv>=maxlv then
UIManager.error('装备强化等级达到上限')
return false
end
return true
end



function UIVocEquipStrengthenWin:getStrengthenMetrials(item,list,insertlist,maxLen)

if list==nil or#list<=0 then
return false,vocEquipHelper.strengthenErr.eNotMaterials
end



local tempList={}
for i=1,maxLen do
if insertlist[i]==nil then
tempList[#tempList+1]=i
end
end
local inertLen=#tempList
if inertLen==0 then
return false,vocEquipHelper.strengthenErr.eNotPos
end


local outlist={}
local fillList={}
local idxList={}
local totalExp=0
local useHoleLen=0
local holeIdxList={}
local needMoneyType
local itemLen=#list

for i,v in pairs(insertlist)do
local itemguid=v[1]
local guidStr=tostring(itemguid)
local num=v[2]
local hasExp=vocEquipHelper.getStrengthenExpValue(itemguid,num)
totalExp=totalExp+hasExp
outlist[tostring(itemguid)]=true
useHoleLen=useHoleLen+1
idxList[guidStr]=i
holeIdxList[i]=true
fillList[guidStr]={itemguid,v[2]}
end


local enhancelv=item.itemData and item.itemData.enhancelv
local itemid=item.itemid
local nextBreakLevel=vocEquipHelper.getStrengthenNextBreakLvByItemid(itemid,enhancelv)
local maxLv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
local needMaxExp=vocEquipHelper.getStrengthenExpValueToTargetLevelOnItem(item,nextBreakLevel)
local isNextMax=nextBreakLevel>=maxLv

if self.strengthenLvIdx then
local strengthenLvDescList,levellist=self:getStrengthenLvDescList()
local targetlevel=levellist[self.strengthenLvIdx+1]
needMaxExp=vocEquipHelper.getStrengthenExpValueToTargetLevelOnItem(item,targetlevel)
end
if totalExp>=needMaxExp then
if isNextMax then
return false,vocEquipHelper.strengthenErr.eExpOver_maxLv
else
return false,vocEquipHelper.strengthenErr.eExpOver_break
end
end

local itemguid1=item.itemguid
local ret,moneyType=vocEquipHelper.isCanStrengthenByCostMoney(itemguid1,totalExp)
if not ret then
return false,vocEquipHelper.strengthenErr.eNotEnoughCost,moneyType
end

local sortTag={}
local temp=table.deepCopy(list)
for i,v in ipairs(temp)do
local exp=vocEquipHelper.getStrengthenExpValue(v.itemguid,1)
sortTag[tostring(v.itemguid)]=itemsConfig.getMainType(v.itemid)*-10000000+exp*100-i
end


table.sort(temp,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)

local _getNextHole=function()
for i=1,maxLen do
if not holeIdxList[i]then
return i
end
end
end
local _putItem=function(itemguid,hasExp,holeIdx)
local guidStr=tostring(itemguid)
local targetExp=totalExp+hasExp
local ret,moneyType=vocEquipHelper.isCanStrengthenByCostMoney(itemguid1,targetExp)
if not ret then
needMoneyType=moneyType
return false
end
if holeIdxList[holeIdx]==nil then
holeIdxList[holeIdx]=true
idxList[guidStr]=holeIdx
useHoleLen=useHoleLen+1
end
local lastNum=(fillList[guidStr]or{})[2]or 0
lastNum=lastNum+1
fillList[guidStr]={itemguid,lastNum}
totalExp=totalExp+hasExp
return true
end

local compelementInfo={}
for i,v in ipairs(temp)do
local itemid=v.itemid
local count=v.itemcount
local itemguid=v.itemguid
local guidStr=tostring(itemguid)
if totalExp>=needMaxExp then break end
local lastNum=(fillList[guidStr]or{})[2]or 0
local alreadyPut=lastNum>0
local isNew=not alreadyPut
local leftCount=count-lastNum
local holeIdx=idxList[guidStr]
local isEquip=itemsConfig.isVocEquip(itemid)
if isEquip or isNew then
if(useHoleLen+1)>maxLen then break end
holeIdx=_getNextHole()
end
if leftCount>0 and holeIdx then
local hasExp=vocEquipHelper.getStrengthenExpValue(itemguid,1)
local canPutExp=needMaxExp-totalExp
local max=math.floor(canPutExp/hasExp)
local cnt=math.min(max,leftCount)
for j=1,cnt do
if totalExp>=needMaxExp then break end
if _putItem(itemguid,hasExp,holeIdx)then
leftCount=leftCount-1
else
break
end
end
if leftCount>0 and totalExp<needMaxExp then
if(useHoleLen==maxLen or useHoleLen==itemLen)then
_putItem(itemguid,hasExp,holeIdx)
else
local lastExp=compelementInfo[1]
if lastExp==nil or lastExp>hasExp then
compelementInfo={hasExp,itemguid}
end
end
end
end
end
if totalExp<needMaxExp and#compelementInfo>0 then
local itemguid=compelementInfo[2]
local hasExp=compelementInfo[1]
local guidStr=tostring(itemguid)
local holeIdx=idxList[guidStr]
if holeIdx==nil then
holeIdx=_getNextHole()
end
if holeIdx then
_putItem(itemguid,hasExp,holeIdx)
end
end
if useHoleLen==0 then
if needMoneyType then
return false,vocEquipHelper.strengthenErr.eNotEnoughCost,needMoneyType
end
return false,vocEquipHelper.strengthenErr.eNotMaterials
end
local finalList={}
for key,v in pairs(fillList)do
finalList[idxList[key]]=v
end

return finalList
end

function UIVocEquipStrengthenWin:getStrengthenData(selectItems)
local addItemExp=0
if selectItems then
for k,v in pairs(selectItems)do
local itemguid=v[1]
local num=v[2]
local item=equipsHelper.getEquip(itemguid)
if item then
addItemExp=addItemExp+vocEquipHelper.getStrengthenExpValue(itemguid,num)
end
end
end
local item=self.item
local itemid=item.itemid
local enhancelv=item.itemData and item.itemData.enhancelv or 0
local enhanceexp=item.itemData and item.itemData.enhanceexp or 0
local addLv,leftExp,overExp=vocEquipHelper.getAddStrengthenLv(itemid,enhancelv,enhanceexp,addItemExp)
local addExp=addItemExp-leftExp


return addItemExp,addExp,addLv,leftExp,overExp
end


function UIVocEquipStrengthenWin:refreshDiscipleList()
local tNum=#self.disciplelist
self.discipleList:freshGridsNum(tNum,tNum,1,true)
local idx=1
for i=1,tNum do
local item=self.discipleList:getGridObjectByindex(i-1)
local netdata=self.disciplelist[i].netData.net
local discipleguid=netdata.discipleguid



comHelper.setChildModelHeadIconBG(item,0,discipleguid)

UIDiscipleModel:setDiscipleXianMoHeadImage(item,8,netdata)

comHelper.setChildModelRawImage(item,discipleguid,1,0,eHeadCenterType.eHead)

local isSelect=mathHelper.compareInt64(self.disciple_guid,discipleguid)
if isSelect then
idx=i
self.curDisIndex=idx
end
self:changItemSelect(item,isSelect)

self:refreshItemReddot(item,i)
end
self.discipleList:jumpToLockX(idx)
end

function UIVocEquipStrengthenWin:changItemSelect(item,isSelect)
item:SetChildActive(3,isSelect)
end

function UIVocEquipStrengthenWin:refreshItemReddot(item,idx)
if item==nil then
item=self.discipleList:getGridObjectByindex(idx-1)
end
item:SetChildActive(6,false)
end

function UIVocEquipStrengthenWin:on_select_dis(id,index,guid,attach)
if self.curDisIndex==index then return end

local oldItem=self.item
local old=self.curDisIndex
self.curDisIndex=index
if old then
local olditem=self.discipleList:getGridObjectByindex(old-1)
self:changItemSelect(olditem,false)
end
local item=self.discipleList:getGridObjectByindex(self.curDisIndex-1)
self:changItemSelect(item,true)

local netdata=self.disciplelist[self.curDisIndex].netData.net
local dis_guid=netdata.discipleguid
self.disciple_guid=dis_guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)

local equip=vocEquipModel:getEquipByDizi(self.disciple_guid)
if equip then
self.item=equipsHelper.getEquip(equip.itemguid)
end

local argtable={itemguid=self.item.itemguid}










oneTabScreenController:changeArgs(argtable,true)

self:freshEquip(argtable)
end


function UIVocEquipStrengthenWin:refreshCostItems()
local itemid=self.item.itemid
local enhancelv=self.item.itemData and self.item.itemData.enhancelv or 0


local maxLv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
local isMaxLevel=enhancelv>=maxLv

self.unMaxLvPanel:setActive(not isMaxLevel)
self.maxLvPanel:setActive(isMaxLevel)
if not isMaxLevel then

local vocId=vocEquipHelper.getEquipVocId(itemid)
local isBreak=vocEquipHelper.checkStrengthenLvIsBreak(vocId,enhancelv)

if isBreak then

self:setBreakCostItems()
else

self:setSelectItems()
end
self.strengthenPanel:setActive(not isBreak)
self.breakPanel:setActive(isBreak)
end
end


function UIVocEquipStrengthenWin:setSelectItems()
local selectList=self.selectList or{}
local showGridsCount=_fillItemLen
self.costItemGroup:setChildLayoutGroupCreateItems(showGridsCount,function(index)
local widget=self.costItemGroup:getChildLayoutGroupGridItem(index-1)
local selectInfo=selectList[index]or{}
local itemguid=selectInfo[1]
local num=selectInfo[2]or 0
local item=equipsHelper.getEquip(itemguid)
local showCountBG=false
local itemId=item and item.itemid or nil
if itemId then
self.checkList[itemId]=true
end
local enhancelv=item and item.itemData and item.itemData.enhancelv or 0
local enhanceStr=enhancelv>0 and FMT.fmt('+{0}',enhancelv)or''
local countStr=enhancelv>0 and enhanceStr or num>1 and num or''
local conf={showname=false,itemcount=countStr,showcount=countStr~='',showCountBG=countStr~=''}
local fillData=self:getSelectFillData(item,conf)
widget:SetChildPropData(-1,fillData)
widget:SetBaseItemClickEvent(-1,function(...)self:onSelectItemClick(...)end)
end)
end


function UIVocEquipStrengthenWin:setBreakCostItems()
local level=self.item.itemData and self.item.itemData.enhancelv
local allCostList=vocEquipHelper.getStrengthenBreakItemCostByLevel(self.item.itemguid,level)
local costList={}
for _,v in ipairs(allCostList)do
local itemId=v[1]
if not itemsConfig.isMoney(itemId)then
costList[#costList+1]=v
end
end
local showGridsCount=#costList
self.costItemGroup:setChildLayoutGroupCreateItems(showGridsCount,function(index)
local widget=self.costItemGroup:getChildLayoutGroupGridItem(index-1)
local cost=costList[index]or{}
local itemId=cost[1]
local num=cost[2]or 0
self.checkList[itemId]=true
local hasCount=itemsModel.getCount(itemId)
local item={itemid=itemId,itemcount=num}
local countStr=string.format("%d/%d",hasCount,num)
if hasCount<num then
countStr=FMT.fmt("<color=#FF0000>{0}</color>",countStr)
end

local conf={showname=false,itemcount=countStr,showcount=countStr~='',showCountBG=countStr~=''}
local fillData=self:getSelectFillData(item,conf)
widget:SetChildPropData(-1,fillData)
widget:SetBaseItemClickEvent(-1,function(...)self:onCostItemClick(...)end)
end)
end

function UIVocEquipStrengthenWin:getSelectFillData(item,conf)
if item==nil then
return self:getSelectTempFillData()
end
local prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
return prop
end

function UIVocEquipStrengthenWin:getSelectTempFillData()
local conf={}
conf.showbg=true
local prop=itemsComponentHelper.getTempFillData(conf)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=true
return prop
end

function UIVocEquipStrengthenWin:getNextFillIdx(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then return index end
for i=1,_fillItemLen do
local info=selectList[i]
if not info then
return i
end
end
end

function UIVocEquipStrengthenWin:getSelectIndex(itemguid)
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
if self.selectList==nil then self.selectList={}end
return self.selectItemsLookup[tostring(itemguid)]
end

function UIVocEquipStrengthenWin:setSelectNum(itemguid,index,num)
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
if self.selectList==nil then self.selectList={}end
if num==0 then
self.selectList[index]=nil
self.selectItemsLookup[tostring(itemguid)]=nil
else
self.selectList[index]={itemguid,num}
self.selectItemsLookup[tostring(itemguid)]=index
end
self:freshAddExp()
self.progressReverseAni=true
self.progressAni=false
end

function UIVocEquipStrengthenWin:showProvideSelectGrids()
if self.showDialogue then return end
self.showDialogue=true
self.leftDialogue:setActive(true)
self.winlua:SetChildDOLocalMoveX(self.leftdialogueinfo:getID(),-320,0.5)




self:freshProvideSelectGrids(true)
end

function UIVocEquipStrengthenWin:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
self.curPageIndex=1
self.isSetZero=false
self.ScrollView:clearSlowItems()
local func=function(...)
self.leftDialogue:setActive(false)
end
self.winlua:SetChildDOLocalMoveX(self.leftdialogueinfo:getID(),-890,0.1,func)
end


function UIVocEquipStrengthenWin:resetSelectItems()
self:resetData()
self:freshInfo()
self:freshProvideSelectGrids(true)
end

function UIVocEquipStrengthenWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local isTemp=itemInfo==nil
if not isTemp then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(itemInfo)
local stageTitile=itemsConfig.getStageName(itemid)

local showStage=false
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local num=self:getSelectNum(itemguid)
local enhancelv=itemInfo.itemData and itemInfo.itemData.enhancelv or 0
local enhanceStr=enhancelv>0 and FMT.fmt('+{0}',enhancelv)or''
local countStr=enhancelv>0 and enhanceStr or num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
local has=num>0
local showbg=true
local isLock=bagHelper.isLock(itemInfo)
local isFabao=itemsConfig.isFabao(itemid)
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)
local isLock=bagHelper.isLock(itemInfo)
widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)
widget:SetChildQulaity(2,color)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,isLock)
widget:SetChildActive(10,has)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetChildLongPress(10,index,function(idx)self:longPressAction(idx)end,function(idx)self:finishlongPressAction(idx)end)
widget:SetChildLongPress(11,index,function(idx)self:longPressAction(idx,true)end,function(idx)self:finishlongPressAction(idx,true)end)
else
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildText(4,'')
widget:SetChildActive(5,false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildLongPress(11,index,nil,nil)
widget:SetChildLongPress(10,index,nil,nil)
end
end

function UIVocEquipStrengthenWin:putItem(itemguid,addnum)
local num=self:getSelectNum(itemguid)
local item=equipsHelper.getEquip(itemguid)
local itemcount=item.itemcount
if not self:checkMaxLv()then
return
end
if num>=itemcount then
UIManager.error('物品已达上限')
return
end
local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('当前无空位可放入')
return
end
if bagHelper.isLock(item)then
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'装备锁定','该装备已锁定，是否解锁并进行强化消耗？')
self.dialog.okcallback=function()
bagProtocolControl.req_change_bag_item_lockflag(itemguid,true)
if self and not self.isClose then
self:onUnlockItem(itemguid)
end
end
self.dialog:show()
return
end
if not self:tryPutItem(itemguid,true)then
return
end
self.onStrengthenFinish=false
local lastNum=num
if lastNum==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
end
addnum=addnum or 1
num=num+addnum
self:setSelectNum(itemguid,fillIdx,num)
self:freshProvideSingleGiridText(itemguid)
self:setMoneyCostItems()
self:refreshCostItems()
self:setProgress()
self:setAttrs()
return true
end


function UIVocEquipStrengthenWin:tryPutItem(itemguid,canOverExp)
local addExp=equipsHelper.getJinglianValue(itemguid,1)
local addTExp=self.addItemExp or 0
local enhancelv=self.item.itemData and self.item.itemData.enhancelv
local itemid=self.item.itemid
local nextBreakLevel=vocEquipHelper.getStrengthenNextBreakLvByItemid(itemid,enhancelv)
local maxLv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
local needMaxExp=vocEquipHelper.getStrengthenExpValueToTargetLevelOnItem(self.item,nextBreakLevel)
local isNextMax=nextBreakLevel>=maxLv
if self.strengthenLvIdx then
local strengthenLvDescList,levellist=self:getStrengthenLvDescList()
local targetlevel=levellist[self.strengthenLvIdx+1]
needMaxExp=vocEquipHelper.getStrengthenExpValueToTargetLevelOnItem(self.item,targetlevel)
end
local lastIsFull=addTExp>=needMaxExp
if lastIsFull then
if self.strengthenLvIdx then
UIManager.error('已达指定强化等级最大经验，无法添加')
else
if isNextMax then
UIManager.error('已达到最大经验，无法添加')
else
UIManager.error('已达到当前突破等级最大经验，无法添加')
end
end
return false
end
addTExp=addTExp+addExp
local leftExp=addTExp-needMaxExp
if leftExp>0 then
if not canOverExp then
if self.strengthenLvIdx then
UIManager.error('已达指定强化等级最大经验，无法添加')
else
if isNextMax then
UIManager.error('已达到最大经验，无法添加')
else
UIManager.error('已达到当前突破等级最大经验，无法添加')
end
end
return false
end
end
return true
end


function UIVocEquipStrengthenWin:longPressAction(idx,isAdd)
if isAdd and not self.islong then
return
end
local info=self.bagList[idx]
if not info then
self:StopItemLongPress(idx,isAdd and 11 or 10)
self.useGoodTime=nil
return
end
local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=10 then
num=100
elseif lerp>=6 then
num=50
elseif lerp>=3 then

num=10
elseif lerp>=2 then

num=5
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
local maxNum=isAdd and info.itemcount or self:getSelectNum(info.itemguid)
if num>maxNum then
num=maxNum
end
if isAdd then
if not self:putItem(info.itemguid,num)then
self:StopItemLongPress(idx,11)
self.useGoodTime=nil
end
else
if not self:onClickGridButton(info.itemid,idx,info.itemguid,nil,num)then
self:StopItemLongPress(idx,10)
self.useGoodTime=nil
end
end
end

function UIVocEquipStrengthenWin:StopItemLongPress(idx,index)
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildLongPressStop(index)
end
end


function UIVocEquipStrengthenWin:finishlongPressAction(idx,isAdd)
if isAdd then
self.islong=false
end
self.useGoodTime=nil
end


function UIVocEquipStrengthenWin:getSelectNum(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then
local selectTable=selectList[index]or{}
return selectTable[2]or 0
end
return 0
end

function UIVocEquipStrengthenWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
if not flag then
widget:SetChildLongPressStop(10)
self.useGoodTime=nil
end
end
end
end

function UIVocEquipStrengthenWin:freshProvideSingleGiridText(itemguid)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
local num=self:getSelectNum(itemguid)
local info=self.bagList[idx]
local itemcount=info.itemcount or 0
local enhancelv=info.itemData and info.itemData.enhancelv or 0
local enhanceStr=enhancelv>0 and FMT.fmt('+{0}',enhancelv)or''
local countStr=enhancelv>0 and enhanceStr or num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
end
end
end

function UIVocEquipStrengthenWin:freshProvideGridLock(itemguid,isUnlock)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(9,isUnlock)
end
end
end

function UIVocEquipStrengthenWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i,v
end
end
end

function UIVocEquipStrengthenWin:setAttrs()






local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local addLv=self.addLv
local enhancelv=item.itemData and item.itemData.enhancelv or 0
local vocId=vocEquipHelper.getEquipVocId(itemid)
local isBreak=vocEquipHelper.checkStrengthenLvIsBreak(vocId,enhancelv)
if isBreak then
addLv=1
end

local baseAttrsLookup=vocEquipHelper.getVocEquipBaseAttrsLookupByItemidAndLevel(itemid,enhancelv)

local nextBaseAttrsLookup=addLv>0 and vocEquipHelper.getVocEquipBaseAttrsLookupByItemidAndLevel(itemid,enhancelv+addLv)or{}
local temp={}
for attrId,v in pairs(baseAttrsLookup)do
local attrValue=v.attrValue
local nextAttrValue=nextBaseAttrsLookup[attrId]and nextBaseAttrsLookup[attrId].attrValue or nil
local addValue=(nextAttrValue or attrValue)-attrValue

local weight=0
if attrId>0 then
weight=cfg_attributesconfig_get(attrId).priority
else
weight=10000
end

temp[#temp+1]={
attrId=attrId,
attrValue=attrValue,
addValue=addValue,
attrName=v.attrName,
isPercent=v.isPercent,
weight=weight,
}
end
if#temp>1 then
table.sort(temp,function(a,b)
return a.weight<b.weight
end)
end
local baseLen=#temp
self.baseAttrsGroup:setChildLayoutGroupCreateItems(baseLen,function(index)
self:fillBaseAttr(index,temp[index])
end)

local nextActiveVocAttrList={}
local showLevel
local isFinalActiveLv=self.vocAttrList[#self.vocAttrList].level
local isNext=true
if enhancelv>=isFinalActiveLv then
showLevel=isFinalActiveLv
nextActiveVocAttrList={{isMaxLv=true}}
isNext=false
end
if isNext then
for _,v in ipairs(self.vocAttrList)do
local level=v.level
if not showLevel and level>enhancelv then
showLevel=level
end

if level==showLevel then
nextActiveVocAttrList[#nextActiveVocAttrList+1]=v
elseif showLevel and level>showLevel then
break
end
end
end

local showVocAttrsCount=#nextActiveVocAttrList
local isEnableScroll=showVocAttrsCount>=3
self.vocAttrsScrollView:setChildScrollRectEnable(isEnableScroll)
if not isEnableScroll then
self.vocAttrsGroup:setLocalPos(0,0,0)
end

self.vocAttrsGroup:setChildLayoutGroupCreateItems(showVocAttrsCount,function(index)
self:fillVocAttr(index,nextActiveVocAttrList[index],vocId,isNext)
end)
end

function UIVocEquipStrengthenWin:fillBaseAttr(index,attr)
local widget=self.baseAttrsGroup:getChildLayoutGroupGridItem(index-1)
widget:SetChildActive(-1,attr~=nil)
if attr then
local attrId=attr.attrId
local attrValue=attr.attrValue
local addValue=attr.addValue
local iconname=''
local name,valstr,ifMod
if attrId>0 then
name,valstr,ifMod=equipsHelper.getAttr(attrId,attrValue,TO_INT_TYPE.eDown)
else
name=attr.attrName
ifMod=attr.isPercent
if ifMod then
valstr=string.format('%s%%',attrValue)
else
valstr=string.format('%s',attrValue)
end
end

local handleValue=ifMod and mathHelper.decimal(addValue)or math.floor(addValue)


local upCount=0
local haveUp=upCount>0

local hasAdd=handleValue and handleValue>0 or false

widget:SetChildActive(0,false)
widget:SetChildActive(2,hasAdd or haveUp)
if hasAdd then
local addValStr=ifMod and FMT.fmt('(+{0}%)',mathHelper.decimal(addValue))or FMT.fmt('(+{0})',math.floor(addValue))
widget:SetChildText(3,addValStr)
else
widget:SetChildText(3,'')
end
widget:SetChildActive(4,false)

if haveUp then
widget:SetChildCSImageSprite(2,iconHelper.globalSpriteBundle1,FMT.fmt("icon_jiantou_{0}",_upImg[upCount]))
end

widget:SetChildText(6,haveUp and FMT.fmt("x{0}",upCount)or'')

valstr=FMT.fmt('<color=#7d3b17>{0}：</color>{1}',name,valstr)
widget:SetChildText(1,valstr)
widget:SetChildActive(5,false)
end
end

function UIVocEquipStrengthenWin:fillVocAttr(index,attrData,vocId,isNext)
local widget=self.vocAttrsGroup:getChildLayoutGroupGridItem(index-1)

widget:SetChildActive(1,isNext)
widget:SetChildActive(2,isNext)
widget:SetChildActive(4,not isNext)
if attrData and isNext then
local attrName=attrData.attrName
local attrValueStr=attrData.attrValueStr
local level=attrData.level
local skillPosIndex=attrData.skillPosIndex
if skillPosIndex then
local skillData=self.jobSkillList and self.jobSkillList[skillPosIndex+2]or nil
if skillData then
local skillId=skillData[1]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local skillName=skillCfg.name
attrName=FMT.fmt("<color=#fff600>[{0}]</color>等级",skillName)
end
end
if not attrName or not attrValueStr then
local attrId=attrData.attrId
local attrValue=attrData.attrValue
attrName,attrValueStr=equipsHelper.getAttr(attrId,attrValue)
if attrValue>0 then
attrValueStr=string.format("+%s",attrValueStr)
end
end

local str=string.format("<color=#efb150>%s：</color>%s",attrName,attrValueStr)
widget:SetChildText(1,str)
local activeCntStr
activeCntStr=FMT.fmt("（突破{0}级激活）",level)
widget:SetChildText(2,activeCntStr)
end


local isFirst=index==1
widget:SetChildActive(0,isFirst)
if isFirst then
widget:SetChildButtonClick(0,function()
self:onVocAttrInfoBtn()
end,true)
end
end


function UIVocEquipStrengthenWin:onUnlockItem(itemguid)
self.unlockItem[tostring(itemguid)]=true
end

function UIVocEquipStrengthenWin:onItemLockChanged(itemid,itemguid,isUnlock)
self:freshProvideGridLock(itemguid,isUnlock)
if self.unlockItem[tostring(itemguid)]then
self.unlockItem[tostring(itemguid)]=nil
self:putItem(itemguid)
end
end

function UIVocEquipStrengthenWin:onItemListChanged(list)
if list==nil then return end
local needRefreshCost=false
for i,v in ipairs(list)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
local lastCount=v[4]
local nowCount=v[5]
local isAdd=changeType==CHANGE_TYPE.eAdd or nowCount>lastCount
if self.checkList[itemid]and isAdd then
needRefreshCost=true
break
end
end

if needRefreshCost then
self:refreshCostItems()
end
end

function UIVocEquipStrengthenWin:onMoneyChanged(moneyType)
self:setMoneyCostItems()
end

function UIVocEquipStrengthenWin:onChangeItem(guid)
if tostring(guid)~=tostring(self.disciple_guid)then return end
local diziguid=self.disciple_guid
local equip=vocEquipModel:getEquipByDizi(diziguid)
if equip then
self:fillItem(equip)
end

UIManager:closeWindow('UIVocEquipGainWin')
end




function UIVocEquipStrengthenWin:onResetLvBtn()

local item=self.item
local itemid=item.itemid
local enhancelv,enhanceexp=vocEquipModel.getVocEquipStrengthenLevel(item)
if enhancelv==0 and enhanceexp==0 then
return UIManager.error("当前装备强化等级已为0级，无法回退")
end

local itemName=itemsConfig.getItemName(itemid)
local costStr=""
local desc='是否{0}将<color=#ca631d>{1}</color>等级退回至<color=#ca631d>0级</color>，并退还全部等级提升与突破材料，玄铁会按照一定比例折算为<color=#ca631d>玄铁宝箱</color>'
local resetCost=vocEquipHelper.getdefaultStrengthenLvResetCost()
local hasCost=false
if resetCost and next(resetCost)then
hasCost=true
local costItemStrList={}
for _,v in ipairs(resetCost)do
local costItemId=v[1]
local needCount=v[2]
local name=itemsModel.getName(costItemId)
costItemStrList[#costItemStrList+1]=FMT.fmt("{0}{1}",needCount,name)
end
local costItemStr=table.concat(costItemStrList,"、")
costStr=FMT.fmt("消耗{0}",costItemStr)
end
desc=FMT.fmt(desc,costStr,itemName)

local itemguid=item.itemguid
local pos=0
local guid=itemguid
if self.isEquip then
guid=vocEquipModel:getDiziguidByItemguid(itemguid)
pos=1
end

local reqFunc=function()
vocEquipController.req_vocEquip_resetLv(guid,pos)
end

local fun=function()
if hasCost then
for _,v in ipairs(resetCost)do
local costItemId=v[1]
local needCount=v[2]
local isEnough
if itemsConfig.isMoney(costItemId)then
isEnough=moneyModel.checkEnoughMoney(costItemId,needCount)
else
isEnough=itemsModel.checkItemEnough(costItemId,needCount)
end

if not isEnough then
return itemsModel:useItem(costItemId,needCount,function()
UIManager:invokeUIMethod("UIVocEquipStrengthenWin","onResetLvBtn")
end,WARNING_TYPE.eWarning)
end
end
end
return reqFunc()
end
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,fun)
end



function UIVocEquipStrengthenWin:onStrengthenBtn()
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local vocId=vocEquipHelper.getEquipVocId(itemid)
local enhancelv=item.itemData and item.itemData.enhancelv or 0
local selectItems=self.selectList
local itemsTemp={}
local equipsTemp={}
local flag=false
for k,v in pairs(selectItems)do
local _itemguid=v[1]
local num=v[2]
local item=equipsHelper.getEquip(_itemguid)
if item then
local _itemid=item.itemid
local temp={_itemid,num}
if itemsConfig.isItem(_itemid)then
itemsTemp[#itemsTemp+1]=temp
else
equipsTemp[#equipsTemp+1]=_itemguid
end
flag=true
end
end
if flag==false then
UIManager.error('请放入强化材料')
return
end
local maxlv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
local curlv=item.itemData and item.itemData.enhancelv or 0
local targetlv=self.addLv+curlv
if targetlv>maxlv then targetlv=maxlv end
local ret,errType,errArgs=vocEquipHelper.isCanStrengthen(itemguid,self.addItemExp,targetlv)
if not ret then
if errType==vocEquipHelper.strengthenErr.eNotEnoughCost then
local costItemId=errArgs[1]
local costItemNeedCount=errArgs[2]





return itemsModel:useItem(costItemId,costItemNeedCount,function()
UIManager:invokeUIMethod("UIVocEquipStrengthenWin","onBreakBtn")
end,WARNING_TYPE.eWarning)
elseif errType==vocEquipHelper.strengthenErr.eLevelToCap then
UIManager.error('装备强化等级达到上限')
end
return
end


local itemslen=#itemsTemp
local equipslen=#equipsTemp
local pos=0
local guid=itemguid
if self.isEquip then
guid=vocEquipModel:getDiziguidByItemguid(itemguid)
pos=1
end
local callback=function()
vocEquipController.req_vocEquip_strengthen(guid,pos,itemslen,itemsTemp)
end

callback()
end



function UIVocEquipStrengthenWin:onBreakBtn()
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local vocId=vocEquipHelper.getEquipVocId(itemid)
local curlv=item.itemData and item.itemData.enhancelv or 0
local ret,errType,errArgs=vocEquipHelper.isCanStrengthenBreak(itemguid,curlv)
if not ret then
if errType==vocEquipHelper.strengthenErr.eNotEnoughCost then
local costItemId=errArgs[1]
local costItemNeedCount=errArgs[2]





return itemsModel:useItem(costItemId,costItemNeedCount,function()
UIManager:invokeUIMethod("UIVocEquipStrengthenWin","onBreakBtn")
end,WARNING_TYPE.eWarning)
elseif errType==vocEquipHelper.strengthenErr.eLevelToCap then
UIManager.error('装备强化等级达到上限')
end
return
end

local pos=0
local guid=itemguid
if self.isEquip then
guid=vocEquipModel:getDiziguidByItemguid(itemguid)
pos=1
end
local callback=function()
vocEquipController.req_vocEquip_break(guid,pos)
end

callback()
end



function UIVocEquipStrengthenWin:onVocAttrInfoBtn()
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
self:showWindow("UIVocEquipTips_vocAttrsListWin",{itemid=itemid,itemguid=itemguid})
end

function UIVocEquipStrengthenWin:onLeftDialogue()
self:onClickBg()
end

function UIVocEquipStrengthenWin:onPutItemBtn()
self:onPutClick()
end

function UIVocEquipStrengthenWin:onPutItemOutBtn()
self:onPutClick()
end

function UIVocEquipStrengthenWin:onResetItemBtn()
self:resetSelectItems()
end

function UIVocEquipStrengthenWin:onSelectItemClick(itemid,index,itemguid,attach)
self:showProvideSelectGrids()
end

function UIVocEquipStrengthenWin:onClickBg()
self:closeProvideSelectGrids()
end

function UIVocEquipStrengthenWin:onCostItemClick(itemid,index,itemguid,attach)
return self:onItemClick(itemid,index,itemguid,attach)
end


function UIVocEquipStrengthenWin:onItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UIVocEquipStrengthenWin:onDropdownCreated()
local strengthenLvDescList,levellist=self:getStrengthenLvDescList()
local len=#levellist
local upItem=self.item
local enhancelv=upItem.itemData and upItem.itemData.enhancelv or 0
for i=1,len do
local level=levellist[i]
local isGray=enhancelv>=level
local idx=i-1
local widget=self.Dropdown:getDropdownItemWidget(idx)
widget:SetChildActive(1,true)
widget:SetChildButtonClick(1,function()
self:onDropdownClick(idx,isGray,level)
end)

if isGray then
widget:SetChildCSImageSprite(2,atlasAb,"button_chuangkou_7")
end
widget:SetChildImageExGray(2,isGray)
widget:SetChildActive(3,idx==self.strengthenLvIdx)
end
self.DropdownMask:setActive(self.strengthenLvIdx==nil)
end




















function UIVocEquipStrengthenWin:onDropdownClick(idx,isGray,level)
if isGray then
UIManager.error("装备强化等级已超过该等级")
return
end

local upItem=self.item
local itemid=self.item.itemid
local enhancelv=upItem.itemData and upItem.itemData.enhancelv or 0
local nextBreakLv=vocEquipHelper.getStrengthenNextBreakLvByItemid(itemid,enhancelv)
if level>nextBreakLv then
UIManager.error(FMT.fmt("需要先突破{0}级",nextBreakLv+1))
return
end


if self.strengthenLvIdx==idx then
self.strengthenLvIdx=nil
local widget=self.Dropdown:getDropdownItemWidget(idx)
widget:SetChildActive(3,false)

self:resetSelectItems()
else
self.strengthenLvIdx=idx
self.Dropdown:hideList()
self.Dropdown:setValue(self.strengthenLvIdx)

self:resetSelectItems()
self:onPutClick()
end
self.DropdownMask:setActive(self.strengthenLvIdx==nil)
end


function UIVocEquipStrengthenWin:onPutClick(hideError)
if not self:checkMaxLv()then
return
end
local filterList=vocEquipHelper.getMateriasOnBag(self.item.itemguid,true)or{}

local insertList=self.selectList or{}
local list,errType,errArgs=self:getStrengthenMetrials(self.item,filterList,insertList,_fillItemLen)
if list and#list>0 then
self.onStrengthenFinish=false
for _,v in ipairs(list)do
local itemguid=v[1]
local num=v[2]
local idx=self:getNextFillIdx(itemguid)
self:setSelectNum(itemguid,idx,num)
self:freshProvideSelectSingleGirid(itemguid,true)
end
self:refreshCostItems()
self:setMoneyCostItems()
self:setProgress()
self:setAttrs()
else
if hideError then
return
end
if errType==vocEquipHelper.strengthenErr.eNotMaterials then
UIManager.error('没有材料可放入')
local itemid=vocEquipHelper.getdefaultStrengthenItem()
gainControl:showGainWin(itemid)
elseif errType==vocEquipHelper.strengthenErr.eNotPos then
UIManager.error('当前无空位可放入')
elseif errType==vocEquipHelper.strengthenErr.eExpOver_maxLv or errType==vocEquipHelper.strengthenErr.eExpOver_break then
if self.strengthenLvIdx then
UIManager.error('已达指定强化等级最大经验，无法添加')
else
if errType==vocEquipHelper.strengthenErr.eExpOver_maxLv then
UIManager.error('已达到最大经验，无法添加')
else
UIManager.error('已达到当前突破等级最大经验，无法添加')
end
end
elseif errType==vocEquipHelper.strengthenErr.eNotEnoughCost then
local costItemId=errArgs
local costItemName=itemsModel.getName(costItemId)
UIManager.error(FMT.fmt('{0}不足，不可强化',costItemName))
gainControl:showGainWin(costItemId)
end
end
end

function UIVocEquipStrengthenWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
self:putItem(itemguid)
end

function UIVocEquipStrengthenWin:onClickLongGridButton(itemid,index,itemguid,attach)
if itemid~=-1 then

self.islong=true
end
end

function UIVocEquipStrengthenWin:onClickGridButton(itemid,index,itemguid,attach,delnum)
if itemid==-1 then return end
local num=self:getSelectNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
return
end
self.onStrengthenFinish=false
delnum=delnum or 1
num=num-delnum
local selectIdx=self:getSelectIndex(itemguid)
self:setSelectNum(itemguid,selectIdx,num)
if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:freshProvideSingleGiridText(itemguid)
self:refreshCostItems()
self:setMoneyCostItems()
self:setProgress()
self:setAttrs()
return true
end