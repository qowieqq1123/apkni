







def_class("UILingShouQianLiUpgradeWin",UIWindowBase)









function UILingShouQianLiUpgradeWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.baseAttr=UIObject.get(self,1)
self.countSelectSlider=UIObject.get(self,2)
self.emptyListRoot=UIObject.get(self,3)
self.listRoot=UIObject.get(self,4)
self.listRootTipsTex=UIText.get(self,5)
self.maxCnt=UIButton.get(self,6)
self.middleRoot=UIObject.get(self,7)
self.qianLiDanYaoItemScrollView=UIObject.get(self,8)
self.rightContent=UIObject.get(self,9)
self.root=UIObject.get(self,10)
self.subBtn=UIButton.get(self,11)
self.useBtn=UIButton.get(self,12)
self.sortTypeDropdown=UIDropdown.get(self,13)
self.sortConditionButton=UIButton.get(self,14)
self.sortOrderButton=UIButton.get(self,15)
self.lingShouScrollView=UIObject.get(self,16)
self.Content=UIObject.get(self,17)
self.Itemone=UIObject.get(self,18)
self.Itemone2=UIObject.get(self,19)
self.Itemone3=UIObject.get(self,20)
self.qltxt=UIText.get(self,21)
self.tipsbtn=UIButton.get(self,22)
self.danyaopg=UIObject.get(self,23)
self.danyaopg2=UIObject.get(self,24)
self.danyaopg3=UIObject.get(self,25)
self.selectedNumText=UIText.get(self,26)
self.sximg=UIObject.get(self,27)
self.qlitxt=UIText.get(self,28)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.useBtn:setButtonClick(function()self:onUseBtn()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)



end


function UILingShouQianLiUpgradeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.baseAttr);self.baseAttr=nil;
_UIObject_release(self.countSelectSlider);self.countSelectSlider=nil;
_UIObject_release(self.emptyListRoot);self.emptyListRoot=nil;
_UIObject_release(self.listRoot);self.listRoot=nil;
_UIObject_release(self.listRootTipsTex);self.listRootTipsTex=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.middleRoot);self.middleRoot=nil;
_UIObject_release(self.qianLiDanYaoItemScrollView);self.qianLiDanYaoItemScrollView=nil;
_UIObject_release(self.rightContent);self.rightContent=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.useBtn);self.useBtn=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.lingShouScrollView);self.lingShouScrollView=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.Itemone);self.Itemone=nil;
_UIObject_release(self.Itemone2);self.Itemone2=nil;
_UIObject_release(self.Itemone3);self.Itemone3=nil;
_UIObject_release(self.qltxt);self.qltxt=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.danyaopg);self.danyaopg=nil;
_UIObject_release(self.danyaopg2);self.danyaopg2=nil;
_UIObject_release(self.danyaopg3);self.danyaopg3=nil;
_UIObject_release(self.selectedNumText);self.selectedNumText=nil;
_UIObject_release(self.sximg);self.sximg=nil;
_UIObject_release(self.qlitxt);self.qlitxt=nil;
end
















local _this
local _useLoop=api_Available_GetChildLoopTreeView()or false

local _middleRootSubWidget
local _bottomRootSubWidget
local _qianLiItemSubWidget

local _qianLiItemComp=function(aCfg,bCfg)
local selectedLsData=_this.lingShouList[_this.currentSelectedLsItemIndex]

local aCanUse=lingshouModel:isCanUseQianLiDanYaoItem(selectedLsData,aCfg)
local bCanUse=lingshouModel:isCanUseQianLiDanYaoItem(selectedLsData,bCfg)

if aCanUse~=bCanUse then
return aCanUse or(not bCanUse or false)
end


if aCfg.color~=bCfg.color then
return aCfg.color>bCfg.color
end

return aCfg.id>bCfg.id
end

local _lingShouItemSubWidget=
{
bg=0,
portraitIcon=1,
nameTex=2,
qianLiAttrValueTex=3,
mutationMark=4,
selected=5,
daishuimg=6,
daishutxt=7,
}
local _itemindex=
{
baseitem=0,
select=1,
button=2,
flag=3,
}
local itemcolor={3,4,5}
local itemcolorName=
{
[1]='#6833c0',
[2]='#ca631d',
[3]='#c82c2c',
}
local dyprogressidx=
{
selfitem=0,
name=1,
progress1=2,
progress2=3,
progressTxt=4,
}




function UILingShouQianLiUpgradeWin:onLoaded(...)
self:bindComponents()
_this=self
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.sortTypeList=eLingShouSortType:getLSSortList7()
self.lingShouList={}
self.select_idx=1
self.select_guid=-1
self.itemlists={self.Itemone,self.Itemone2,self.Itemone3}
self.danyaolist={}
self.danyaoidx=1
self.danyaoprogressList={self.danyaopg,self.danyaopg2,self.danyaopg3}
self.qlLooklist={}
self.now_choose_num=0
self.color_ql_max={}
self.generation_ql_max={}
self.ls_generation=0
self.ls_color=3
self.chavalue=0


self.currentSelectedLsItemIndex=-1

self.currentSelectedObjGuid=-1
self.currentSortTypeOptionIndex=1

self.currentSortCond={}
self.currentSortOrder=eSortOrder.eDown


self.currentSelectedQianLiItemIndex=-1
self.currentSelectedQianLiItemId=-1


self.currentSelectCount=-1
self.minQianLiItemCount=-1
self.maxQianLiItemCount=-1

self.qianLiItemCfgList={}
self.qianLiOwnedItemCfgList={}







notifySystem:listenNotify(notifyConfig.onLingShouGetOrUpdate,self.onLingShouGetOrUpdateCallback)



if _useLoop then
self.loopTreeView=self.winlua:GetChildUILoopTreeView(self.lingShouScrollView:getID())
self.loopTreeView:SetAction(function(...)
if not self or self.isClose then return end
self:freshLoopAction(...)
end,function()
if not self or self.isClose then return end
self:startLoopAction()
end)
end

end


function UILingShouQianLiUpgradeWin:__delete()
self:unbindComponents()
if self.closeCallback then
self.closeCallback()
end
notifySystem:removelistener(notifyConfig.onLingShouGetOrUpdate,self.onLingShouGetOrUpdateCallback)
_this=nil
end


function UILingShouQianLiUpgradeWin:onTipsbtn()









local temp=
{
title='灵兽的品质和代数越高，则可服用的潜力丹药数量上限也就越高',
posItem=self.tipsbtn,
pos={x=-101,y=-70},
}
self:showWindow('UILingShouQLTips',temp)
end

function UILingShouQianLiUpgradeWin:onClickRewardItem(itemId)

if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,move=TIPS_MOVE_POS.eCenter})
end

function UILingShouQianLiUpgradeWin:onDropdownChange(idx)

if self.lockRefresh then return end
idx=idx+1
if self.sortTypeIndex==idx then return end
self.sortTypeIndex=idx
self.sortType=self.sortTypeList[idx]

self:freshSortLSList()
end

function UILingShouQianLiUpgradeWin:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:freshSortLSList()
end

function UILingShouQianLiUpgradeWin:onSortConditionButton()
local filterName,filterFlag=lingshouLookup:getConditonFilter3(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.extraWin='UIFilterThreeWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end

function UILingShouQianLiUpgradeWin.selecConditionBack(data)
if _this==nil then
return
end
local filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end

_this:freshSortLSList()
end


function UILingShouQianLiUpgradeWin:onLsLoopGridViewItemClick(itemIndex,itemGuid)
if itemIndex==self.select_idx then
return
end
local old_idx=self.select_idx
self.select_idx=itemIndex
self.select_guid=itemGuid

if old_idx then
local old_item=self.loopTreeView:GetItemWidget(old_idx-1)
if old_item then
old_item:SetChildActive(_lingShouItemSubWidget.selected,false)
end
end
if itemIndex then
local item=self.loopTreeView:GetItemWidget(itemIndex-1)
if item then
item:SetChildActive(_lingShouItemSubWidget.selected,true)
end
end

self:setqianliLookup()
self:freshNextItemSelect()
self:refreshitemlist()
self:refreshAttrBase()
self:freshsilder()

end

function UILingShouQianLiUpgradeWin:onDanYaoClick(index,_itemid)
if self.danyaoidx==index then
return
end
local dydata=self.danyaolist[index]
local itemid=dydata.itemid
local maxnum=self:getDYDaiShuColorNum(itemid)
local now_Num=self.qlLooklist[itemid]or 0
if now_Num>=maxnum then
UIManager.info("该丹药使用量已达上限")
return
end
local old_idx=self.danyaoidx
self.danyaoidx=index

if old_idx then
local old_Widget=self.itemlists[old_idx]:getWidgetBase()
if old_Widget then
old_Widget:SetChildActive(_itemindex.select,false)
end
end
if index then
local Widget=self.itemlists[index]:getWidgetBase()
if Widget then
Widget:SetChildActive(_itemindex.select,true)
end
end
self:freshsilder()

end

function UILingShouQianLiUpgradeWin:onUseBtn()
if lingshouModel:checkNoOptState(_this.select_guid)then return end

local dydata=self.danyaolist[self.danyaoidx]
local itemid=dydata.itemid
local have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if have<=0 then


gainControl:showGainWin(itemid)
return
end
if not self.select_idx then
return
end
if not self.select_guid then
return
end
local maxnum=self:getDYDaiShuColorNum(itemid)
local now_Num=self.qlLooklist[itemid]or 0
if now_Num>=maxnum then
UIManager.info("该丹药使用量已达上限")
return
end
local selectnum=self.now_choose_num
if selectnum==0 then
UIManager.info("使用的丹药数量不能为0")
return
end

local lsData=lingshouModel:getLingShouData(_this.select_guid)
local lsCfg=lsData.cfg

local hasTips=not dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLingShouQianLiDanYaoUseItem)
if hasTips then
local itemCfg=itemsConfig.getConfig(itemid)
local contentText=FMT.fmt("是否确认使用<color={2}>{0}*{1}</color>？",itemCfg.name,selectnum,FONT_COLOR_VAL[itemCfg.color])
local tipsArgs={
type="UIDialouge",
title="提示",
content=contentText,
oktext="确定",
canceltext="取消",
allowclickBG="false",
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLingShouQianLiDanYaoUseItem,flag)
end,
okcallback=function()
bagProtocolControl.req_lingshou_use_item(_this.select_guid,itemid,selectnum)
UIManager.info(FMT.fmt('{0}增加{1}点潜力',lsCfg.name,_this.chavalue))
end,
showclosebtn=true
}
local tipsDialog=UIDialogManager.newDialog(tipsArgs)
tipsDialog:show()
else
bagProtocolControl.req_lingshou_use_item(_this.select_guid,itemid,selectnum)
UIManager.info(FMT.fmt('{0}增加{1}点潜力',lsCfg.name,_this.chavalue))
end


end




function UILingShouQianLiUpgradeWin:onShow(argtable,afterOnloaded)

local sortTypeNamesList=eLingShouSortTypeName:getName2List2(self.sortTypeList)
self.sortTypeDropdown:setOption(sortTypeNamesList)






self.sortType=eLingShouSortType.eQianLi
for i,v in ipairs(self.sortTypeList)do
if v==self.sortType then
self.sortTypeIndex=i
end
end

local recordSortCondition=argtable.recordSortCondition
if recordSortCondition==true then
self.sortCondition=lingshouModel:getSaveSortCondition()
else
local sortCondition={}
self.sortCondition=sortCondition
end
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false

self.config=cfgHelper.get1(cfg_lingshoubasicconfig_get,1)

local ql_itemlist=self.config.ql_itemlist
for k,v in ipairs(ql_itemlist)do



table.insert(self.danyaolist,{itemid=v[1],maxnum=0,name=v[2]})
end


self.color_ql_max=self.config.color_ql_max

self.generation_ql_max=self.config.generation_ql_max

self:setLingshouList()
self.select_guid=argtable.selectedLingShouGuid or false
if self.select_guid then
self.select_idx=self:getLingShouIndexByGuid(self.select_guid)
if not self.select_idx then
logErr('传入的灵兽下标为nil')
return
end
else
logErr('传入的灵兽guid为nil')
return
end


self:freshLsListPanel()
self:LSjumpindex()


self:setqianliLookup()
self:freshNextItemSelect()
self:refreshitemlist()
self:refreshAttrBase()
self:freshsilder()
end


function UILingShouQianLiUpgradeWin:onHide()

end


function UILingShouQianLiUpgradeWin:LSjumpindex()
if self.lingShouList and#self.lingShouList>15 then
if self.select_idx and self.select_idx>15 then
self.loopTreeView:JumpIndex(self.select_idx-1)
end
end
end

function UILingShouQianLiUpgradeWin:getLingShouIndexByGuid(guid)
for index,data in ipairs(self.lingShouList)do
if mathHelper.compareInt64(guid,data.guid)then
return index
end
end
return false
end

function UILingShouQianLiUpgradeWin:getDYisFull()
if self.danyaolist and#self.danyaolist>0 then
for k,dydata in ipairs(self.danyaolist)do
local itemid=dydata.itemid
local maxnum=self:getDYDaiShuColorNum(itemid)
local now_Num=self.qlLooklist[itemid]or 0
if now_Num<maxnum then
return false
end
end
end
return true
end

function UILingShouQianLiUpgradeWin:getDYDaiShuColorNum(itemid)
local num=0






local lsData=lingshouModel:getLingShouData(self.select_guid)
num=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLIDAN_COUNT_MAXVAL,itemid)
return num
end

function UILingShouQianLiUpgradeWin:freshNextItemSelect()
local dydata=self.danyaolist[self.danyaoidx]
local itemid=dydata.itemid
local maxnum=self:getDYDaiShuColorNum(itemid)
local now_Num=self.qlLooklist[itemid]or 0
local ischeck=false
if now_Num>=maxnum then
ischeck=true
end
if ischeck then

local changeidx=false
local changeitemid=false
for k,v in ipairs(self.itemlists)do
local _dydata=self.danyaolist[k]
if _dydata then
local _itemid=_dydata.itemid
local _maxnum=self:getDYDaiShuColorNum(_itemid)
local _now_Num=self.qlLooklist[_itemid]or 0
if _now_Num<_maxnum then
local have=bagControl.invokeFuncByItemId(_itemid,'getItemCountByItemID',_itemid)
if have>0 then
changeidx=k
changeitemid=_itemid
break
end
end
end
end
if changeidx and changeitemid then
self:onDanYaoClick(changeidx,changeitemid)
end
end
end


function UILingShouQianLiUpgradeWin.onLingShouGetOrUpdateCallback(lsData,isNew)
_this:freshsever()
end

function UILingShouQianLiUpgradeWin:freshsever(guid)

if _this==nil then return end
self:setqianliLookup()
self:refreshitemlist()
self:refreshAttrBase()
self:freshsilder()
self:refreshLsSingleItem(self.select_idx)
self:freshNextItemSelect()

UIManager:invokeUIMethod("UILingShouInfoWin","refreshTipsRedDot")
UIManager:invokeUIMethod("UILingShouInfoWin","refreshView")
UIManager:invokeUIMethod("UILingShouModelWin","freshLingShouCZ")
end

function UILingShouQianLiUpgradeWin:getLsList()
local list=lingshouLookup:getSortList3(self.sortType,self.sortCondition,self.sortOrder)
return list
end

function UILingShouQianLiUpgradeWin:freshSortLSList()
self:setLingshouList()
self.select_idx=self:getLingShouIndexByGuid(self.select_guid)
if not self.select_idx then
self.select_idx=1
if self.lingShouList[self.select_idx]then
self.select_guid=self.lingShouList[self.select_idx].guid
end

end
self:freshLsListPanel()
end

function UILingShouQianLiUpgradeWin:setLingshouList()
self.lingShouList=self:getLsList()
end

function UILingShouQianLiUpgradeWin:freshLsListPanel()
if _useLoop then
local dataNum=#self.lingShouList
self.winlua:SetChildScrollRectStopMovement(self.lingShouScrollView:getID())
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
self.loopTreeView:InitDataList(dataNum,'lsItem')
end
end
function UILingShouQianLiUpgradeWin:startLoopAction()
end
function UILingShouQianLiUpgradeWin:freshLoopAction(i,item)
local index=i+1
self:refreshLsItem(index,item)
end

function UILingShouQianLiUpgradeWin:refreshLsItem(index,item)
local itemIndex=index
local lsData=self.lingShouList[itemIndex]
local lsId=lsData.id
local lsGUid=lsData.guid
local lsCfg=lsData.cfg
local lsName=lsData.name
local lsColor=lsCfg.color
local lsQianLiValue=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)
local lsIsMutation=lsCfg.bianyi==1
local generation=lsData.generation or 0


item:SetChildCSImageSprite(_lingShouItemSubWidget.bg,globalABLookup.lingshoumain,lingshouColorToFrame[lsColor])

comHelper.setChildModelRawImage_lingshou(item,lsId,_lingShouItemSubWidget.portraitIcon,0,eHeadCenterType.eHead,1)

item:SetChildText(_lingShouItemSubWidget.nameTex,lsName)

item:SetChildText(_lingShouItemSubWidget.qianLiAttrValueTex,"潜力："..lsQianLiValue)

item:SetChildActive(_lingShouItemSubWidget.mutationMark,lsIsMutation)

item:SetChildActive(_lingShouItemSubWidget.daishuimg,generation>0)
item:SetChildActive(_lingShouItemSubWidget.daishutxt,generation>0)
item:SetChildText(_lingShouItemSubWidget.daishutxt,FMT.fmt("{0}代",generation))



if self.select_idx==itemIndex then
item:SetChildActive(_lingShouItemSubWidget.selected,true)
else
item:SetChildActive(_lingShouItemSubWidget.selected,false)
end


item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onLsLoopGridViewItemClick(itemIndex,lsGUid,item)
end)
end

function UILingShouQianLiUpgradeWin:refreshLsSingleItem(index)
local item=self.loopTreeView:GetItemWidget(index-1)
local lsData=lingshouModel:getLingShouData(self.select_guid)
self.lingShouList[index]=lsData
local lsCfg=lsData.cfg
local lsQianLiValue=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)
local lsIsMutation=lsCfg.bianyi==1
local generation=lsData.generation or 0


item:SetChildText(_lingShouItemSubWidget.qianLiAttrValueTex,"潜力："..lsQianLiValue)

item:SetChildActive(_lingShouItemSubWidget.mutationMark,lsIsMutation)

item:SetChildActive(_lingShouItemSubWidget.daishuimg,generation>0)
item:SetChildActive(_lingShouItemSubWidget.daishutxt,generation>0)
item:SetChildText(_lingShouItemSubWidget.daishutxt,FMT.fmt("{0}代",generation))
end



function UILingShouQianLiUpgradeWin:setqianliLookup()
self.qlLooklist={}
local lsData=lingshouModel:getLingShouData(self.select_guid)
local qianliItemList=lsData.qianliItemList
self.ls_generation=lsData.generation or 0
local fyCfg=cfgHelper.get1(cfg_lingshouconfig_get,lsData.id)
self.ls_color=fyCfg.color or 3
if qianliItemList then
for k,v in ipairs(qianliItemList)do
if v.param_1 and v.param_2 then
self.qlLooklist[v.param_1]=v.param_2
end
end
end
end

function UILingShouQianLiUpgradeWin:refreshitemlist()
for k,v in ipairs(self.itemlists)do
local itemWidget=v:getWidgetBase()
local dydata=self.danyaolist[k]
if dydata then
itemWidget:SetChildActive(-1,true)
local itemid=dydata.itemid
local maxnum=self:getDYDaiShuColorNum(itemid)
local bagcount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local countStr=mathHelper.formatNumber(bagcount)
local showCountBG=true
local grayNum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=grayNum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildPropData(_itemindex.baseitem,prop)


if self.danyaoidx==k then
itemWidget:SetChildActive(_itemindex.select,true)
else
itemWidget:SetChildActive(_itemindex.select,false)
end

local now_Num=self.qlLooklist[itemid]or 0
if now_Num>=maxnum then
itemWidget:SetChildActive(_itemindex.flag,true)
itemWidget:SetChildActive(_itemindex.select,false)
else
itemWidget:SetChildActive(_itemindex.flag,false)
end


local longPressFunc=function(...)
if _this==nil then return end
self:onClickRewardItem(itemid)
end
itemWidget:SetChildLongTouch(_itemindex.button,k,0.5,longPressFunc)


itemWidget:SetChildButtonClick(_itemindex.button,function()
if _this==nil then return end
self:onDanYaoClick(k,itemid)
end)
else
itemWidget:SetChildActive(-1,false)
end
end
end

function UILingShouQianLiUpgradeWin:refreshAttrBase()

local lsData=lingshouModel:getLingShouData(self.select_guid)
local qianli=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)or""
self.qltxt:setText(FMT.fmt("潜力：{0}",qianli))


local baseAttrWb=self.baseAttr:getChildWidgetBase()
local percent=lingshouModel.getQianLiToJJAttrRate(qianli)
baseAttrWb:SetChildText(0,FMT.fmt("{0}%",percent))









end

function UILingShouQianLiUpgradeWin:refreshNextAttr()
local num=1
local dydata=self.danyaolist[self.danyaoidx]
local itemid=dydata.itemid
local config=itemsConfig.getConfig(itemid)
local funcparam=config.funcparam
if funcparam and funcparam.extra and funcparam.extra[1]and funcparam.extra[1][2]then
if funcparam.extra[1][2][10]then
num=funcparam.extra[1][2][10][2]or 1
end
end

local lsData=lingshouModel:getLingShouData(self.select_guid)
local qianli=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)
local nextqianli=0
if self.now_choose_num>0 then
nextqianli=qianli+num*self.now_choose_num
end
self.chavalue=num*self.now_choose_num
local baseAttrWb=self.baseAttr:getChildWidgetBase()
if nextqianli>0 then
local now_percent=lingshouModel.getQianLiToJJAttrRate(qianli)or 0
local next_percent=lingshouModel.getQianLiToJJAttrRate(nextqianli)or 0
local cha=next_percent*1000-now_percent*1000
if cha and cha>0 and not self.isfull then
local _cha=mathHelper.decimal(cha/1000,2)
baseAttrWb:SetChildActive(1,true)
baseAttrWb:SetChildText(1,FMT.fmt("{0}%",_cha))

self.qlitxt:setActive(true)
local str=FMT.fmt('灵兽可提升<color=#ca631d>{0}</color>点潜力',self.chavalue)
self.qlitxt:setText(str)
else
baseAttrWb:SetChildActive(1,false)
self.qlitxt:setActive(false)
end
else
baseAttrWb:SetChildActive(1,false)
self.qlitxt:setActive(false)
end
end

function UILingShouQianLiUpgradeWin:refreshProgressPanel()
for k,v in ipairs(self.danyaoprogressList)do
local itemWidget=v:getWidgetBase()
local dydata=self.danyaolist[k]
if dydata then
itemWidget:SetChildActive(-1,true)
local itemid=dydata.itemid
local name=dydata.name
local maxnum=self:getDYDaiShuColorNum(itemid)

itemWidget:SetChildText(dyprogressidx.name,FMT.fmt('<color={0}>{1}</color>',itemcolorName[k],name))

local now_Num=self.qlLooklist[itemid]or 0
if now_Num>maxnum then
now_Num=maxnum
end

local new_Num=now_Num
if self.danyaoidx==k then
new_Num=now_Num+self.now_choose_num
end
if new_Num>maxnum then
new_Num=maxnum
end



itemWidget:SetProgressBarAniWithThreeParams(dyprogressidx.progress1,now_Num*100,maxnum*100,0.4)
itemWidget:SetProgressBarAniWithThreeParams(dyprogressidx.progress2,new_Num*100,maxnum*100,0.4)



if new_Num<=now_Num then
itemWidget:SetChildText(dyprogressidx.progressTxt,FMT.fmt("{0}/{1}",now_Num,maxnum))
else
local cha=new_Num-now_Num
itemWidget:SetChildText(dyprogressidx.progressTxt,FMT.fmt("{0}<color=#aae252>(+{1})</color>/{2}",now_Num,cha,maxnum))
end
else
itemWidget:SetChildActive(-1,false)
end
end
self:refreshNextAttr()
end


function UILingShouQianLiUpgradeWin:onSubBtn()
if self.now_choose_num<=self.min then
return
end
self.now_choose_num=self.now_choose_num-1
self.countSelectSlider:setChildSliderValue(self.now_choose_num)
end
function UILingShouQianLiUpgradeWin:onAddBtn()
if self.min>=self.max then
return
end
if self.now_choose_num>=self.max then
return
end
self.now_choose_num=self.now_choose_num+1
self.countSelectSlider:setChildSliderValue(self.now_choose_num)
end
function UILingShouQianLiUpgradeWin:onSliderChange(value)
self.now_choose_num=value
self.selectedNumText:setText(self.now_choose_num)
self:refreshProgressPanel()
end

function UILingShouQianLiUpgradeWin:freshsilder()
local isfull=self:getDYisFull()
if isfull then
self.isfull=true
self.listRoot:setActive(false)
self.sximg:setActive(true)
self:refreshProgressPanel()
else
self.isfull=false
self.listRoot:setActive(true)
self.sximg:setActive(false)
local dydata=self.danyaolist[self.danyaoidx]
local itemid=dydata.itemid
local maxnum=self:getDYDaiShuColorNum(itemid)
local now_Num=self.qlLooklist[itemid]or 0
local bagcount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local usenum=maxnum-now_Num
if usenum<0 then usenum=0 end

local _min=1
local _max=math.min(usenum,bagcount)
if _max<0 then _max=0 end
self.min=_min
self.max=_max

local func=function(...)
self:onSliderChange(...)
end

if _max==0 then

self.now_choose_num=0
self.countSelectSlider:setChildCanvasGroupRaycast(false)
self.countSelectSlider:setChildSliderInit(0,0,1,func)
self.countSelectSlider:setChildSliderValue(1)
elseif _max==1 then

self.now_choose_num=1
self.countSelectSlider:setChildCanvasGroupRaycast(false)
self.countSelectSlider:setChildSliderInit(1,0,1,func)
self.countSelectSlider:setChildSliderValue(1)
else
self.now_choose_num=1
self.countSelectSlider:setChildCanvasGroupRaycast(true)
self.countSelectSlider:setChildSliderInit(self.now_choose_num,_min,_max,func)
self.countSelectSlider:setChildSliderValue(self.now_choose_num)
end
end
end

