







def_class("UIMLingShouSelect",UIWindowBase)









function UIMLingShouSelect:bindComponents()

self.confirmBtn=UIButton.get(self,0)
self.none=UIObject.get(self,1)
self.roleGrid=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.sortConditionButton=UIButton.get(self,4)
self.sortOrderButton=UIButton.get(self,5)
self.sortTypeDropdown=UIDropdown.get(self,6)
self.tips=UIText.get(self,7)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)



end


function UIMLingShouSelect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.none);self.none=nil;
_UIObject_release(self.roleGrid);self.roleGrid=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.tips);self.tips=nil;
end
















local _this=nil
local childCmp={
select=0,
head=1,
name=2,
signIcon=3,
colorframe=4,
curSign=5,
jingjie=6,
fight=7,
xuemai=8,
}




function UIMLingShouSelect:onLoaded(...)
self:bindComponents()
_this=self
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIMLingShouSelect:__delete()
self:unbindComponents()
_this=nil
end




function UIMLingShouSelect:onShow(argtable,afterOnloaded)




self.param=argtable
self.selected=argtable.current

self.sortTypeList=eLingShouSortType:getLSSortList4()
self.sortTypeDropdown:setOption(eLingShouSortTypeName:getName2List2(self.sortTypeList))
self.sortType=eLingShouSortType.eFightSort
for i,v in ipairs(self.sortTypeList)do
if v==self.sortType then
self.sortTypeIndex=i
end
end
if self.sortTypeIndex==nil then
self.sortTypeIndex=1
self.sortType=self.sortTypeList[self.sortTypeIndex]
end
self.sortCondition={}
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false

self.tips:setText(self.param.noneTips or"")
self:initRoleGrid()
end


function UIMLingShouSelect:onHide()

end




function UIMLingShouSelect:onConfirmBtn()
if not self.selected then
UIManager.error("请选择灵兽")
return
end

local guid=self.selected
local callback=self.param.callback

self:onClickClose()

if callback then
callback(guid)
end
end


function UIMLingShouSelect:onClickClose()
self.param.parentWin:closeSelf()
end


function UIMLingShouSelect:getRoleList()
local list={}
if self.param.lingshous then
for i,guid in ipairs(self.param.lingshous)do
table.insert(list,lingshouModel:getLingShouData(guid))
end
lingshouLookup:sortList(list,self.sortType,self.sortOrder)
else
list=lingshouLookup:getSortList(self.sortType,self.sortCondition,self.sortOrder)
end
return list
end


function UIMLingShouSelect:initRoleGrid()
local list=self:getRoleList()
self:initRoleGridEx(list)
end


function UIMLingShouSelect:initRoleGridEx(list)
self.rolelist=list
local sIdx=self:findIndexByGuid(self.selected)
if not sIdx then
if#list>0 then
self.selected=list[1].guid
else
self.selected=nil
end
end
local pagenum=#self.rolelist
local func=function(idx)
local item=self.roleGrid:getChildLayoutGroupGridItem(idx-1)
self:refreshRoleItem(item,idx)
end
self.roleGrid:setChildLayoutGroupCreateItems(pagenum,func)
self.none:setActive(#self.rolelist<=0)
end


function UIMLingShouSelect:refreshRoleItem(item,idx)
local lsData=self.rolelist[idx]
local lsID=lsData.id
local lscfg=lsData.cfg
local guid=lsData.guid

local color=lingshouModel:getColor(guid)
item:SetChildCSImageSprite(childCmp.colorframe,globalABLookup.lingshoumain,lingshouColorToFrame[color])

local name_str=lsData.name
item:SetChildText(childCmp.name,name_str)

comHelper.setChildModelRawImage_lingshou(item,lsID,childCmp.head,0,eHeadCenterType.eHead,1)

local jj_str=lingshouModel:getJJName(guid,2)
item:SetChildText(childCmp.jingjie,FMT.fmt("境界：{0}",jj_str))

local fight=lingshouModel:getFightValue(guid)
item:SetChildText(childCmp.fight,FMT.fmt("战力：{0}",fight))

local xm_str=lingshouModel.getXueMaiDescEx(lscfg.race,lsData.xuemai_type,math.min(lsData.xuemai_val,100))
item:SetChildText(childCmp.xuemai,FMT.fmt("血脉：{0}",xm_str))

local showSign=lscfg.bianyi==1
item:SetChildActive(childCmp.signIcon,showSign)

local showCurrent=self.param.current==guid
item:SetChildActive(childCmp.curSign,showCurrent)

local isSelect=self.selected==guid
item:SetChildActive(childCmp.select,isSelect)

local func=function()
self:onRoleItemClick(idx)
end
item:SetChildButtonClick(-1,func,true)
end


function UIMLingShouSelect:onRoleItemClick(index)
local lsData=self.rolelist[index]
if self.selected~=lsData.guid then
if self.selected then
local selectedIndex=self:findIndexByGuid(self.selected)
local item=self.roleGrid:getChildLayoutGroupGridItem(selectedIndex-1)
item:SetChildActive(childCmp.select,false)
end
self.selected=lsData.guid
local item=self.roleGrid:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(childCmp.select,true)





end
end

function UIMLingShouSelect:findIndexByGuid(guid)
for i,v in ipairs(self.rolelist)do
if mathHelper.compareInt64(v.guid,guid)then
return i
end
end
end


function UIMLingShouSelect:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
if self.sortTypeIndex==idx then return end
self.sortTypeIndex=idx
self.sortType=self.sortTypeList[idx]

self:initRoleGrid()
end


function UIMLingShouSelect:onSortConditionButton()
if self.filterName==nil or self.filterFlag==nil then
self.filterName,self.filterFlag=lingshouLookup:getConditonFilter(self.sortCondition)
end
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end


function UIMLingShouSelect:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:initRoleGrid()
end


function UIMLingShouSelect.selecConditionBack(data)
if _this==nil then
return
end

_this.filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(_this.filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end

_this:initRoleGrid()
end