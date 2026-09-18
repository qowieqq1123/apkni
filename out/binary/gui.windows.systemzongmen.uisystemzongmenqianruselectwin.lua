







def_class("UISystemZongMenQianRuSelectWin",UIWindowBase)









function UISystemZongMenQianRuSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.tipText=UIText.get(self,1)
self.btnOK=UIButton.get(self,2)
self.btnCancel=UIButton.get(self,3)
self.tipsCostIcon=UIImage.get(self,4)
self.roleListPanel=UIObject.get(self,5)
self.Template=UIObject.get(self,6)
self.btnOkTxt=UIText.get(self,7)
self.btnCancelTxt=UIText.get(self,8)
self.tipCostTx1=UIText.get(self,9)
self.tipCostTx2=UIText.get(self,10)
self.sortConditionButton=UIButton.get(self,11)
self.sortTypeDropdown=UIDropdown.get(self,12)
self.sortOrderButton=UIButton.get(self,13)

self.btnOK:setButtonClick(function()self:onBtnOK()end)

self.btnCancel:setButtonClick(function()self:onBtnCancel()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)



end


function UISystemZongMenQianRuSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
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
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
end
















local _this=nil




function UISystemZongMenQianRuSelectWin:onLoaded(...)
self:bindComponents()
_this=self
local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UISystemZongMenQianRuSelectWin:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end




function UISystemZongMenQianRuSelectWin:onShow(argtable,afterOnloaded)
self.disciplesList=argtable.disciples
self.serial=argtable.serial
self.parentWin=argtable.parentWin
self.current=argtable.current
self.selected=argtable.current

self.sortOrder=eSortOrder.eDown
self.sortTypeList=eDiscipleSortType:getSystemZongMenList1()
self.sortTypeIndex=1
self.sortType=self.sortTypeList[self.sortTypeIndex]
self.limitLv=systemZongMenModel:getQianRuLevel(self.serial)

self.sortTypeDropdown:setOption(eDiscipleSortTypeName:getName2List2(self.sortTypeList))
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.sortConditionButton:setActive(false)

local height=#self.sortTypeList*40+8
local haveDz=self.current~=nil and self.current~=int64.zero
self.winlua:SetChildSizeDelta(self.Template:getID(),180,height)


self.btnOkTxt:setText("潜入")
self.btnCancelTxt:setText("撤离")
self.btnOK:setActive(not haveDz)
self.btnCancel:setActive(haveDz)

self:initRoleListPanel()

if self.selected==nil or self.selected==int64.zero then
local data=self.dataList[1].netData.net
if self:checkClick(data.discipleguid,false)then
self:onClickItem(1)
end
end
end


function UISystemZongMenQianRuSelectWin:onHide()

end




function UISystemZongMenQianRuSelectWin:onBtnOK()
if self.selected==nil or self.selected==int64.zero then
return
end
if self.selected==self.current then
return UIManager.info("已选中该弟子")
end
local func=function()
systemZongMenController:req_infiltrated(self.serial,self.selected)
self.parentWin:closeSelf()
end
local check=UIDiscipleModel:checkDiscipleState(self.selected,DISCIPLE_STATE_TYPE.eQianRu)
if check then
local zmInfo=systemZongMenModel:findInfoDataByDisciple(self.selected)
if zmInfo.serial~=self.serial then
local show_data={
type='UIDialouge',
title='提示',
content="该弟子已潜入其他宗门\n是否替换？",
oktext='替换',
canceltext='取消',
okcallback=function()
systemZongMenController:req_infiltrated(zmInfo.serial,int64.zero)
systemZongMenController:req_infiltrated(self.serial,self.selected)
self.parentWin:closeSelf()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
else
systemZongMenController:req_infiltrated(self.serial,self.selected)
self.parentWin:closeSelf()
end
end


function UISystemZongMenQianRuSelectWin:onBtnCancel()
if self.current==nil or self.selected==int64.zero then
return
end
if self.selected~=self.current then
return UIManager.info("不能取消其他弟子")
end
systemZongMenController:req_infiltrated(self.serial,int64.zero)
self.parentWin:closeSelf()
end

function UISystemZongMenQianRuSelectWin:onDropdownChange(idx)
self.sortTypeIndex=idx+1
self.sortType=self.sortTypeList[self.sortTypeIndex]
self:initRoleListPanel()
end

function UISystemZongMenQianRuSelectWin:onSortConditionButton()
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

function UISystemZongMenQianRuSelectWin.selecConditionBack(data)
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

function UISystemZongMenQianRuSelectWin:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:initRoleListPanel()
end

function UISystemZongMenQianRuSelectWin:initRoleListPanel()
self.dataList=self:sortList()
self:initRoleListPanelEx()
end

function UISystemZongMenQianRuSelectWin:initRoleListPanelEx()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.dataList,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
end

function UISystemZongMenQianRuSelectWin:refreshItem(id,item)
local index=id+1
local data=self.dataList[index].netData.net
local guid=data.discipleguid

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
local val2=UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eZhenFa)
local name2=FMT.fmt("{0}等级",cfgHelper.get2(cfg_discipleproskillconfig_get,DISCIPLE_PROSKILL_TYPE.eZhenFa,"name"))
local desc2=FMT.fmt("{0}：<color=#171311>{2}</color>\t\t{1}：<color=#171311>{3}</color>",name1,name2,val1,val2)

local name3="境界"
local val3=UIDiscipleModel:getJJName3(UIDiscipleModel:getDiscipleJJLevel(guid))
local desc1=FMT.fmt("{0}：<color=#171311>{1}</color>",name3,val3)

local stateStr=UIDiscipleModel:getDiscipleStateDesc(guid,'')
local checkTY=false
if UIDiscipleModel:checkDiscipleState(guid,DISCIPLE_STATE_TYPE.eQianRu)or UIDiscipleModel:checkDiscipleState(guid,DISCIPLE_STATE_TYPE.eBeiBu)then
local zmInfo=systemZongMenModel:findInfoDataByDisciple(guid)
if zmInfo then
stateStr=FMT.fmt("潜入{0}",systemZongMenModel:getNameStr(zmInfo.id,zmInfo.nameIdx))
end
if zmInfo then
checkTY=zmInfo.tayin>0
end
end

local checkJJ=UIDiscipleModel:getDiscipleJJLevel(guid)<self.limitLv
local checkTZ=dzSpecialitySpecialEffectController:getCantQianRuSystemZM(data)
if checkTZ then
item:SetChildActive(item_cmp_index_.blackRoot,true)
item:SetChildText(item_cmp_index_.blackTx,"无法潜入")
elseif checkJJ then
item:SetChildActive(item_cmp_index_.blackRoot,true)
item:SetChildText(item_cmp_index_.blackTx,"境界不足")
elseif checkTY then
item:SetChildActive(item_cmp_index_.blackRoot,true)
item:SetChildText(item_cmp_index_.blackTx,"拓印中")
else
item:SetChildActive(item_cmp_index_.blackRoot,false)
end
local isFree=UIDiscipleModel:checkDiscipleState(guid,DISCIPLE_STATE_TYPE.eFree)
local desc3=FMT.fmt("状态：<color={1}>{0}</color>",stateStr,isFree and"green"or"red")
discipleSelectController.refreshDesc(item,desc1,desc2,desc3)
end

function UISystemZongMenQianRuSelectWin:onClickItem(idx)
local data=self.dataList[idx].netData.net
local cmpIdx=discipleSelectController.item_cmp_index
if self.selected~=data.discipleguid then
if not self:checkClick(data.discipleguid)then
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

function UISystemZongMenQianRuSelectWin.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.dataList[disIdx]
local guid=data.netData.net.discipleguid
local effects=discipleSelectController.getSpeciallistByFunction(guid,edzFuncSpecialityType.eSpeciality_SystemZongMen)or{}
local cfg=effects[speIdx]
local item=_this.roleListPanel:getChildScrollViewItemWidget(disIdx-1)
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.netData.net.discipleguid,config=cfg})
end

function UISystemZongMenQianRuSelectWin:checkClick(guid,warning)
if mathHelper.compareInt64(guid,self.current)then
return true
end
warning=warning==nil or warning
local infoData=systemZongMenModel:findInfoDataByDisciple(guid)
local checkTY=infoData and infoData.tayin>0 or false
local checkQianRu=UIDiscipleModel:checkDiscipleState(guid,DISCIPLE_STATE_TYPE.eQianRu)
local checkJJ=UIDiscipleModel:getDiscipleJJLevel(guid)<self.limitLv
local netData=UIDiscipleModel:getDiscipleData(guid)
local checkTZ=dzSpecialitySpecialEffectController:getCantQianRuSystemZM(netData)
if checkTY then
if warning then
UIManager.error("拓印中")
end
return false
elseif checkJJ then
if warning then
UIManager.error("境界不足")
end
return false
elseif checkTZ then
if warning then
UIManager.error("无法潜入")
end
return false
elseif checkQianRu then
return true
elseif not UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eQianRu,warning)then
return false
end
return true
end

function UISystemZongMenQianRuSelectWin:sortList()
local discipleList=self.disciplesList
if not discipleList then
discipleList={}
local dList=UIDiscipleModel:getAllDiscipleDataX()
for i,v in pairs(dList)do
table.insert(discipleList,v)
end
end
local sort={
[1]={},
[2]={},
[3]={},
[4]={},
[5]={},
}
for i,v in ipairs(discipleList)do
local data=v.netData.net

if mathHelper.compareInt64(data.discipleguid,self.current)then
table.insert(sort[1],v)

elseif dzSpecialitySpecialEffectController:getCantQianRuSystemZM(data)then
table.insert(sort[5],v)

elseif not UIDiscipleModel:checkDZStateToDoSomething(data.discipleguid,eCheckDiscipleStateOpType.eQianRu,false)then
table.insert(sort[4],v)

elseif UIDiscipleModel:getDiscipleJJLevel(data.discipleguid)<self.limitLv then
table.insert(sort[3],v)
else
local infoData=systemZongMenModel:findInfoDataByDisciple(data.discipleguid)
if infoData and infoData.tayin>0 then
table.insert(sort[4],v)
else
table.insert(sort[2],v)
end
end
end
local list={}
local sortParams={}
for i,v in ipairs(sort)do
discipleLookup:sortList(v,self.sortType,self.sortOrder,sortParams)
for j,w in ipairs(v)do
table.insert(list,w)
end
end
return list
end