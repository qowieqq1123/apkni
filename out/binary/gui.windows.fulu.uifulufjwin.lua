







def_class("UIFuLuFJWin",UIWindowBase)









function UIFuLuFJWin:bindComponents()

self.comboBoxStage=UIObject.get(self,0)
self.scrollview=UIObject.get(self,1)
self.fenjie=UIButton.get(self,2)
self.rewardItem=UIBaseItem.get(self,3)
self.comboBoxColor=UIObject.get(self,4)
self.btnSelecFubaoAll=UIButton.get(self,5)
self.btnEMSAllImg=UIObject.get(self,6)
self.fbsxbtn=UIButton.get(self,7)
self.spine=UIObject.get(self,8)
self.root=UIObject.get(self,9)

self.fenjie:setButtonClick(function()self:onFenjie()end)

self.btnSelecFubaoAll:setButtonClick(function()self:onBtnSelecFubaoAll()end)

self.fbsxbtn:setButtonClick(function()self:onFbsxbtn()end)



end


function UIFuLuFJWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.comboBoxStage);self.comboBoxStage=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.fenjie);self.fenjie=nil;
_UIObject_release(self.rewardItem);self.rewardItem=nil;
_UIObject_release(self.comboBoxColor);self.comboBoxColor=nil;
_UIObject_release(self.btnSelecFubaoAll);self.btnSelecFubaoAll=nil;
_UIObject_release(self.btnEMSAllImg);self.btnEMSAllImg=nil;
_UIObject_release(self.fbsxbtn);self.fbsxbtn=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this




function UIFuLuFJWin:onLoaded(...)
self:bindComponents()

_this=self

self.selectList={}
self.fubaoBagFilter={}
self.isSelectAllEquip=false
self.comboBoxStage:setChildComboBoxInit(self.on_combobox_change)
self.comboBoxColor:setChildComboBoxInit(self.on_combobox_color_change)

self.scrollview:setChildScrollViewInit(0,false,self.on_item_click,self.on_item_long_touch)


notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self.onFuBaoLockChanged)
end



















function UIFuLuFJWin.on_combobox_change(index)
_this.selectStageIdx=index
local stage=_this.indexToStage[index+1]
_this.selectStage=stage
_this.scrollview:setChildScrollViewCreateGrids(0,0)
_this:refreshItems()
end

function UIFuLuFJWin.on_combobox_color_change(index)
_this.selectColorIdx=index
local color=_this.indexToColor[index+1]
_this.selectColor=color
_this.scrollview:setChildScrollViewCreateGrids(0,0)
_this:refreshItems()
end


function UIFuLuFJWin:__delete()
self:unbindComponents()

_this=nil

notifySystem:removelistener(notifyConfig.on_item_lock_changed,self.onFuBaoLockChanged)
end

function UIFuLuFJWin.onFuBaoLockChanged(itemid,itemguid,isUnlock)
local index=_this:getIndexByItemGuid(itemguid)
if not isUnlock then
_this.selectList[index]=nil
end
_this:setGridItemByIndex(index)
end

function UIFuLuFJWin.on_item_long_touch(clicknum,index)
local data=_this.items[index+1]
if data then
local itemId=_this.items[index+1].itemid
local guid=_this.items[index+1].itemguid
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=itemId,itemguid=guid})
end
end

function UIFuLuFJWin.on_item_click(clicknum,index)
local data=_this.items[index+1]
if data then
local lockType=UIFuLuFangModel:getLockBtnType(data.itemguid)
if lockType==TIPS_BTNS_TYPE.eUnlockEquip then
UIManager.error('该玉符已锁定，不可分解')




















else
local data=UIYuFuLingZhenControl:getLingZhenData(data.itemguid)
if data and data.zhentuId~=0 and data.len>0 then
UIManager.error("此玉符已镶嵌灵阵，无法分解")
return
end
_this:selectItem(index)
end
end
end

function UIFuLuFJWin:selectItem(index)
local item=_this.scrollview:getChildScrollViewItemWidget(index)
local isSelect=_this.selectList[index]
isSelect=not isSelect
_this.selectList[index]=isSelect
item:SetChildActive(1,isSelect)
_this:checkShowReward()
end




function UIFuLuFJWin:onShow(argtable,afterOnloaded)


self.root:setChildCanvasGroupAlpha(0)
self.spine:setChildUIModelShowTarget(6443,1,nil,eAnimationID.enter)
_this:delayDo(0.3,function()
if _this==nil then return end
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end)














self:initSort()
end

function UIFuLuFJWin:refreshArgRecv()
self.scrollview:setChildScrollViewCreateGrids(0,0)
self:refreshItems(true)
end


function UIFuLuFJWin:onHide()

end























function UIFuLuFJWin:initSort()
local stageOption={

'5阶及以下',
'4阶及以下',
'3阶及以下',
'2阶及以下',
'1阶玉符',
}
self.indexToStage={5,4,3,2,1}
local selectStage=_this.selectStageIdx or 4
self.comboBoxStage:setChildComboBoxOption(selectStage,stageOption)
local colorOption={

'红色及以下',
'橙色及以下',
'紫色及以下',
'蓝色及以下',
'绿色玉符',
}
self.indexToColor={5,4,3,2,1}
local selectColor=_this.selectColorIdx or 4
self.comboBoxColor:setChildComboBoxOption(selectColor,colorOption)
end

function UIFuLuFJWin:getFuBaoDatas()
local filter={}










if self.fubaoBagFilter and next(self.fubaoBagFilter)then
filter=self.fubaoBagFilter
filter[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eFubao}}
else
filter[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eFubao}}
end
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eFubaoBag,filter)

local sortRule={}
sortRule[1]={ITEM_SORT_TYPE.eColor}
sortRule[2]={ITEM_SORT_TYPE.eStage}
sortRule.sort=ITEM_SORT_COMPARE_TYPE.eUpOrder
table.sort(items,function(a,b)
local aVal=itemsSortHelper.sort(a,sortRule)
local bVal=itemsSortHelper.sort(b,sortRule)
return aVal<bVal
end)
return items
end

function UIFuLuFJWin:getIndexByItemGuid(itemguid)
local idStr=tostring(itemguid)
for i,v in ipairs(self.items)do
if tostring(v.itemguid)==idStr then
return i-1
end
end
end


function UIFuLuFJWin:firstrefreshItems()

self.items=self:getFuBaoDatas()
local stage=_this.selectStage or 1
local color=_this.selectColor or 1
local selectLookup={}
for k,v in ipairs(self.items)do
local lockType=UIFuLuFangModel:getLockBtnType(v.itemguid)
if lockType==TIPS_BTNS_TYPE.eLockEquip then
local itemConfig=itemsConfig.getConfig(v.itemid)

if itemConfig.color<=color and itemConfig.stage<=stage then
selectLookup[tostring(v.itemguid)]=true
end
end
end

self:onSortBag(selectLookup,self.items)
end


function UIFuLuFJWin:onSortBag(selectLookup,bagList)
local sortTag={}
for i,v in ipairs(bagList)do
local guidStr=tostring(v.itemguid)
local len=string.len(guidStr)
local numStr=string.sub(guidStr,len-3,len)
local guidNum=tonumber(numStr)
local itemid=v.itemid
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color
local stage=cfg.stage or 0
local isSelect=selectLookup[guidStr]or false
local val=0
if isSelect then
val=val-100000000
end
val=val+1000000*stage+10000*color+0.0001*itemid-guidNum
sortTag[guidStr]=val
end

table.sort(bagList,function(a,b)
local itemguid_a=tostring(a.itemguid)
local itemguid_b=tostring(b.itemguid)
return sortTag[itemguid_a]<sortTag[itemguid_b]
end)
end

function UIFuLuFJWin:refreshItems(notAuto)
self.selectList={}
self:firstrefreshItems()


if not notAuto then

if#self.items>0 then


for i=0,#self.items-1 do
local item=self.items[i+1]
local lockType=UIFuLuFangModel:getLockBtnType(item.itemguid)
if lockType==TIPS_BTNS_TYPE.eLockEquip then

local stage=_this.selectStage or 1
local color=_this.selectColor or 1
local itemConfig=itemsConfig.getConfig(item.itemid)
if itemConfig.color<=color and itemConfig.stage<=stage then
local data=UIYuFuLingZhenControl:getLingZhenData(item.itemguid)
if not(data and data.zhentuId~=0 and data.len>0)then
self.selectList[i]=true
end
end
end
end

end
end
local showNum=#self.items<45 and 45 or#self.items














self.scrollview:setChildScrollViewDelayCreateGrids(showNum,0,0.02,12,false,false,function(index,item)













self:setGridItem(index,item)
end)
self:checkShowReward()
end

function UIFuLuFJWin:setGridItemByIndex(index)
local item=self.scrollview:getChildScrollViewItemWidget(index)
self:setGridItem(index,item)
end

function UIFuLuFJWin:setGridItem(index,item)
local data=self.items[index+1]
if data then
local itemid=data.itemid
local lockType=UIFuLuFangModel:getLockBtnType(data.itemguid)
local isLock=lockType==TIPS_BTNS_TYPE.eUnlockEquip
local conf={itemid=itemid,showCountBG=false,showStage=true,gray=0}
if isLock then
conf.gray=mathHelper.setbit(conf.gray,eGrayType.eLock-1)
end
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildActive(1,self.selectList[index]or false)
end
end

function UIFuLuFJWin:checkShowReward()
local show=false
for k,v in pairs(self.selectList)do
if v then
show=true
break
end
end
self.rewardItem:setActive(show)
if show then
local itemId,count=self:getRewardInfo()
local conf={itemid=itemId,itemcount=count}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.rewardItem:setChildPropData(prop)
self.rewardItem:setBaseItemClickEvent(function(itemid,index,guid,attach)
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end)
end



















end

function UIFuLuFJWin:getRewardInfo()
local list={}
local itemid
local add=0
for k,v in pairs(self.selectList)do
if v then
local fbId=self.items[k+1].itemid
local config=itemsConfig.getConfig(fbId)
local decompose=config.decomposeItems
itemid=decompose[1][1]
local count=decompose[1][2]
add=add+count
end
end
if itemid~=nil then

local rate=1+gubaoModel:getGBSkil_MoneyUpRate(7,itemid)/100
add=math.floor(add*rate+0.00001)
end
return itemid,add
end

function UIFuLuFJWin:flyIcon()
local itemId=self:getRewardInfo()
local spos=self.rewardItem:getChildPosition()
UIManager:invokeUIMethod('UITopMoneyWin','flyMoneyIcon',spos,itemId)
end














function UIFuLuFJWin:onFenjie()
local list={}
for k,v in pairs(self.selectList)do
if v then
local guid=self.items[k+1].itemguid
table.insert(list,guid)
end
end
local len=#list
if len>0 then

local tishiState=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eFuLuDecomposeDialog)
if not tishiState then

















local content='确定要分解所选中的玉符吗？'
local okcallback=function(...)
UIFullFuLuFangControl:reqDecomposeFuBao(len,list)
end
UIDialogManager.getConfirmDialog3(nil,content,okcallback,REPEAT_TYPE.eFuLuDecomposeDialog)
else
UIFullFuLuFangControl:reqDecomposeFuBao(len,list)
end
else
UIManager.error('未选择需分解的玉符')
return
end
end

function UIFuLuFJWin:onCloseClick()
self:closeSelf()
end


function UIFuLuFJWin:onBtnSelecFubaoAll()
if UIManager:isActive("UIYuFuFilterPartWin")then
UIManager:closeWindow("UIYuFuFilterPartWin")
end
self.isSelectAllEquip=not self.isSelectAllEquip
self.btnEMSAllImg:setActive(self.isSelectAllEquip)
if self.isSelectAllEquip then
self:mutipleSelectAll(true)
else
self:mutipleSelectAll(false)
end
end
function UIFuLuFJWin:mutipleSelectAll(flag)
for k,v in ipairs(_this.items)do
local lockType=UIFuLuFangModel:getLockBtnType(v.itemguid)
if lockType==TIPS_BTNS_TYPE.eUnlockEquip then

else
local data=UIYuFuLingZhenControl:getLingZhenData(v.itemguid)
if data and data.zhentuId~=0 and data.len>0 then


else
local item=self.scrollview:getChildScrollViewItemWidget(k-1)
self.selectList[k-1]=flag
item:SetChildActive(1,flag)
end
end
end
self:checkShowReward()
end


function UIFuLuFJWin:onFbsxbtn()
if UIManager:isActive("UIYuFuFilterPartWin")then
UIManager:closeWindow("UIYuFuFilterPartWin")
end
self:showFilterWin()
end

function UIFuLuFJWin:showFilterWin()
if UIManager:isActive("UIYuFuFilterPartWin")then
UIManager:invokeUIMethod('UIYuFuFilterPartWin','onCloseBtn')
self.fubaoFilterPartAcive=false
return
end
local comfirmCallback=function(equipBagFilter)
self.fubaoBagFilter=equipBagFilter
self.equipMutipleSelectList={}
self:refreshArgRecv()
end
local closeCallBack=function()
self.fubaoFilterPartAcive=false
end
local args={
attach=BAG_TYPE.eFubaoBag,
fubaoBagFilter=self.fubaoBagFilter,
comfirmCallback=comfirmCallback,
closeCallBack=closeCallBack,
}
self:showWindow("UIYuFuFilterPartWin",args)
self.fubaoFilterPartAcive=true
end

function UIFuLuFJWin:testtshowFilterWin()
_this:showFilterWin()
end