







def_class("UIDiscipleSelectThreeWin",UIWindowBase)









function UIDiscipleSelectThreeWin:bindComponents()

self.root=UIObject.get(self,0)
self.sortTypeDropdown=UIDropdown.get(self,1)
self.sortConditionButton=UIButton.get(self,2)
self.sortOrderButton=UIButton.get(self,3)
self.tipText=UIText.get(self,4)
self.btnOK=UIButton.get(self,5)
self.btnCancel=UIButton.get(self,6)
self.tipsCostIcon=UIImage.get(self,7)
self.roleListPanel=UIObject.get(self,8)
self.Template=UIObject.get(self,9)
self.btnOkTxt=UIText.get(self,10)
self.btnCancelTxt=UIText.get(self,11)
self.tipCostTx1=UIText.get(self,12)
self.tipCostTx2=UIText.get(self,13)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)

self.btnOK:setButtonClick(function()self:onBtnOK()end)

self.btnCancel:setButtonClick(function()self:onBtnCancel()end)



end


function UIDiscipleSelectThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.tipText);self.tipText=nil;
_UIObject_release(self.btnOK);self.btnOK=nil;
_UIObject_release(self.btnCancel);self.btnCancel=nil;
_UIObject_release(self.tipsCostIcon);self.tipsCostIcon=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.Template);self.Template=nil;
_UIObject_release(self.btnOkTxt);self.btnOkTxt=nil;
_UIObject_release(self.btnCancelTxt);self.btnCancelTxt=nil;
_UIObject_release(self.tipCostTx1);self.tipCostTx1=nil;
_UIObject_release(self.tipCostTx2);self.tipCostTx2=nil;
end
















local _this=nil




function UIDiscipleSelectThreeWin:onLoaded(...)
self:bindComponents()
_this=self
local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIDiscipleSelectThreeWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleSelectThreeWin:onShow(argtable,afterOnloaded)
self.disciplesList=argtable.disciples
self.refreshType=argtable.refreshType or 1
self.parentWin=argtable.parentWin
self.okCallback=argtable.okCallback
self.cancelCallback=argtable.cancelCallback
self.sortTypeList=argtable.sortList
self.current=argtable.current
self.selected=argtable.current
self.sortTypeDropdown:setOption(eDiscipleSortTypeName:getName2List2(self.sortTypeList))
self.sortType=argtable.defaultSort
self.sortOrder=argtable.sortOrder or eSortOrder.eDown
self.showFilter=argtable.showFilter or argtable.showFilter==nil
for i,v in ipairs(self.sortTypeList)do
if v==self.sortType then
self.sortTypeIndex=i
end
end
if self.sortTypeIndex==nil then
self.sortTypeIndex=1
self.sortType=self.sortTypeList[self.sortTypeIndex]
end
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.sortConditionButton:setActive(self.showFilter)
local height=#self.sortTypeList*40+8
self.winlua:SetChildSizeDelta(self.Template:getID(),180,height)
self.tipText:setText(argtable.tips or"")
self.btnOkTxt:setText(argtable.okBtnTips or"确定")
self.btnCancelTxt:setText(argtable.cancelBtnTips or"取消")
local haveDz=self.current~=nil and self.current~=int64.zero
self.btnOK:setActive(not haveDz)
self.btnCancel:setActive(haveDz)
self:initRoleListPanel()
end


function UIDiscipleSelectThreeWin:onHide()

end




function UIDiscipleSelectThreeWin:onBtnOK()
if self.selected==nil or self.selected==int64.zero then
return
end
if self.selected==self.current then
return UIManager.info("已选中该弟子")
end
if self.okCallback then
self.okCallback(self.selected)
end
self.parentWin:closeSelf()
end


function UIDiscipleSelectThreeWin:onBtnCancel()
if self.current==nil or self.selected==int64.zero then
return
end
if self.selected~=self.current then
return UIManager.info("不能取消其他弟子")
end
if self.cancelCallback then
self.cancelCallback()
end
self.parentWin:closeSelf()
end

function UIDiscipleSelectThreeWin:onDropdownChange(idx)
self.sortTypeIndex=idx+1
self.sortType=self.sortTypeList[self.sortTypeIndex]
self:initRoleListPanel()
end

function UIDiscipleSelectThreeWin:onSortConditionButton()
local filterName,filterFlag=discipleLookup:getConditonFilterEx(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIDiscipleSelectThreeWin.selecConditionBack(data)
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

_this:initRoleListPanel()
end

function UIDiscipleSelectThreeWin:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:initRoleListPanel()
end

function UIDiscipleSelectThreeWin:initRoleListPanel()
self.dataList=self:getNetDataList()
self:initRoleListPanelEx(list)
end

function UIDiscipleSelectThreeWin:getNetDataList()
local list={}
local sortParams={}
if self.disciplesList then
for i,v in ipairs(self.disciplesList)do
table.insert(list,UIDiscipleModel:getDiscipleDataX(v))
end
discipleLookup:sortList(list,self.sortType,self.sortOrder,sortParams)
else
list=discipleLookup:getSortDiscipleListEx(self.sortType,self.sortCondition,self.sortOrder,sortParams)
end
return list
end

function UIDiscipleSelectThreeWin:initRoleListPanelEx()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.dataList,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
end

function UIDiscipleSelectThreeWin:refreshItem(id,item)
local index=id+1
local data=self.dataList[index].netData.net
local guid=data.discipleguid
self:refreshItemImp(index,item,guid)




end

function UIDiscipleSelectThreeWin:onClickItem(idx)
local data=self.dataList[idx].netData.net
local cmpIdx=discipleSelectController.item_cmp_index
if self.selected~=data.discipleguid then






if not self:checkClick()then
return
end

for i,v in ipairs(self.dataList)do
if mathHelper.compareInt64(v.netData.net.discipleguid,self.selected)then
local item=self.roleListPanel:getChildScrollViewItemWidget(i-1)
item:SetChildActive(cmpIdx.img_select,false)
break
end
end
self.selected=data.discipleguid
local item=self.roleListPanel:getChildScrollViewItemWidget(idx-1)
item:SetChildActive(cmpIdx.img_select,true)

local temp=self.selected==self.current
self.btnOK:setActive(not temp)
self.btnCancel:setActive(temp)
end
end

function UIDiscipleSelectThreeWin.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.dataList[disIdx]
local effects=discipleSelectController.getSpeciallistByFunction(guid,edzFuncSpecialityType.eSpeciality_SystemZongMen)or{}
local cfg=effects[speIdx]
local item=self.roleListPanel:getChildScrollViewItemWidget(disIdx-1)
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.netData.net.discipleguid,config=cfg})
end

function UIDiscipleSelectThreeWin:refreshItemImp(index,item,guid)

local item_cmp_index_=discipleSelectController.item_cmp_index

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(item_cmp_index_.img_color,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local chuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
comHelper.setChildModelRawImage(item,guid,item_cmp_index_.icon_head,0,eHeadCenterType.eHalf,nil,chuiwei)

local name=UIDiscipleModel:getDiscipleName(guid)
item:SetChildText(item_cmp_index_.txt_name,name)

local jjLv=UIDiscipleModel:getDiscipleJJLevel(guid)
local jjStr=UIDiscipleModel:getJJNameEx(jjLv)
item:SetChildText(item_cmp_index_.fightTxt,jjStr)

item:SetChildActive(item_cmp_index_.img_select,self.selected==guid)

local build_effects=discipleSelectController.getSpeciallistByFunction(guid,edzFuncSpecialityType.eSpeciality_SystemZongMen)or{}
discipleSelectController.refreshSpeciality(item,index,build_effects,self.onDescSlotClick)

item:SetChildActive(item_cmp_index_.icon_cursign,self.current==guid)

discipleSelectController.refreshChuiWei(item,guid)

local name1=UIDiscipleModel:getDiscipleBaseAttrName(DISCIPLE_BASE_ATTR_TYPE.eCongHui)
local val1=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
local name2=UIDiscipleModel:getDiscipleBaseAttrName(DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
local val2=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
local desc1=FMT.fmt("{0}：<color=#171311>{2}</color>\t{1}：<color=#171311>{3}</color>",name1,name2,val1,val2)
local stateStr=UIDiscipleModel:getDiscipleStateDesc(guid,'')
local isFree=UIDiscipleModel:checkDiscipleState(guid,DISCIPLE_STATE_TYPE.eFree)
local desc2=FMT.fmt("状态：<color={1}>{0}</color>",stateStr,isFree and"green"or"red")
discipleSelectController.refreshDesc(item,desc1,desc2)
end

function UIDiscipleSelectThreeWin:checkClick(guid)
if guid==self.current then
return true
end
if not UIDiscipleModel:checkDiscipleFightPriorityStateEx(guid)then
UIManager.error(UIDiscipleModel:getDiscipleStateDesc(guid,''))
return false
end
return true
end