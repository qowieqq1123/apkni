







def_class("UIChuangongSelectWin_LingShou",UIWindowBase)









function UIChuangongSelectWin_LingShou:bindComponents()

self.applyBtn=UIButton.get(self,0)
self.applyBtnText=UIText.get(self,1)
self.cancelBtn=UIButton.get(self,2)
self.root=UIObject.get(self,3)
self.scrollView=UIObject.get(self,4)
self.searchBtn=UIButton.get(self,5)
self.searchCancelBtn=UIButton.get(self,6)
self.searchInput=UIInputField.get(self,7)
self.sortOrderButton=UIButton.get(self,8)
self.sortTypeDropdown=UIDropdownEx.get(self,9)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)



end


function UIChuangongSelectWin_LingShou:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.applyBtnText);self.applyBtnText=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
end
















local _this=nil
local _item_index={
icon=0,
name=1,
select=2,
desc=3,
zizhi=4,
sign=5,
frame=6,
fight=7,
jingjieInfo=8,
jingjieTxt=9,
zizhiInfo=10,
zizhiTxt=11,
detailBtn=12,
zizhiReduceBtn=13,
quguan=14,
order=15,
stateInfo=16,
stateTxt=17,
cur=18,
}




function UIChuangongSelectWin_LingShou:onLoaded(...)
self:bindComponents()

_this=self

_this.selectIndex=0

self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5,nil)

self.sortCondition={}
self.sortType=eLingShouSortType.eFightSort
self.sortOrder=eSortOrder.eDown

self.onlyCanUse=true

self.hiddenOrderGuidMap={}

self.scrollView:setChildScrollViewInit(0.5,true,self.on_item_click,nil)

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.searchInput:setChildInputFieldChange(true,function(...)
if _this==nil then return end
_this:onSearchChange(...)
end)
end


function UIChuangongSelectWin_LingShou:__delete()
_this=nil

self:unbindComponents()
end




function UIChuangongSelectWin_LingShou:onShow(argtable,afterOnloaded)
self.param=argtable
self.selected=argtable.current

self.selectType=argtable.selectType
self.otherSelectGuid=argtable.otherSelectGuid
self.selfSelectGuid=argtable.selfSelectGuid

self.sortTypeList=eLingShouSortType:getLSSortList4()
self.sortTypeDropdown:setOption(eLingShouSortTypeName:getName2List2(self.sortTypeList))
self.sortType=eLingShouSortType.eJingJieSort
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
if self.selectType==1 then
self.sortOrder=eSortOrder.eUp
else
self.sortOrder=eSortOrder.eDown
end
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false

self:initLsDataList(afterOnloaded)
self:showList()
end


function UIChuangongSelectWin_LingShou:onHide()

end





function UIChuangongSelectWin_LingShou:onApplyBtn()
if not _this.selectIndex then
UIManager.error("请选择灵兽")
return
end

local lsData=self.lsDataList[_this.selectIndex+1]
local guid=lsData and lsData.guid
if guid==nil then
UIManager.error("请选择灵兽")
return
end


if self.selectType==1 and lingshouModel and lingshouModel.checkLSHasOrder and lingshouModel:checkLSHasOrder(guid)then
UIManager.error("关注的灵兽不可传功")
return
end

local parent=self.param.parentWin
local callback=self.param.callback
lingshouModel:removeLingShouResponsbility(guid,function()
if callback then
callback(guid)
end
if parent then
parent:onClickClose()
end
end)
end

function UIChuangongSelectWin_LingShou:onCancelBtn()
self:onApplyBtn()
end

function UIChuangongSelectWin_LingShou:refreshBtn()
if not mathHelper.validInt64(self.selfSelectGuid)then
self.applyBtn:setActive(true)
self.cancelBtn:setActive(false)
else
local lsData=self.lsDataList[_this.selectIndex+1]
local guid=lsData and lsData.guid or Int64_0

local isSame=mathHelper.compareInt64(guid,self.selfSelectGuid)

self.applyBtn:setActive(not isSame)
self.cancelBtn:setActive(isSame)
end


end

function UIChuangongSelectWin_LingShou.on_item_click(clicknum,index)
local lsData=_this.lsDataList[index+1]

if _this.selectType==1 and lingshouModel:checkLingshouZiZhiIsReduce(lsData.guid)then
UIManager.error("资质受损，无法成为传功灵兽")
return
end

local isOther=_this.otherSelectGuid and mathHelper.compareInt64(_this.otherSelectGuid,lsData.guid)
local isSelf=_this.selfSelectGuid and mathHelper.compareInt64(_this.selfSelectGuid,lsData.guid)
local isNeedCheck=not(isOther or isSelf)

if isNeedCheck and _this.otherSelectGuid then
if _this.selectType==1 then
if _this.otherSelectGuid then
local slsData=lingshouModel:getLingShouData2(_this.otherSelectGuid)
if slsData and slsData.jj_lvl>=lsData.jj_lvl then
UIManager.error("传功灵兽境界等级必须比受功灵兽高")
return
end
end
elseif _this.selectType==2 then
local slsData=lingshouModel:getLingShouData2(_this.otherSelectGuid)
if slsData and lsData.jj_lvl>=slsData.jj_lvl then
UIManager.error("受功灵兽境界等级必须比传功灵兽等级低")
return
end
end
end

if _this.selectIndex then
local item=_this.scrollView:getChildScrollViewItemWidget(_this.selectIndex)
item:SetChildActive(_item_index.select,false)
end

_this.selectIndex=index

local item=_this.scrollView:getChildScrollViewItemWidget(_this.selectIndex)
item:SetChildActive(_item_index.select,true)

_this:refreshBtn()
end

function UIChuangongSelectWin_LingShou:initLsDataList(isInit)
local list
if isInit then
list=lingshouLookup:getSortList(self.sortType,self.sortCondition,self.sortOrder)
else
list=self.lsDataList or{}
end

for index=#list,1,-1 do
local lsData=list[index]
local isRemove=false

if self.inputstr then
if not string.find(lsData.name,self.inputstr)then
isRemove=true
end
end

if isRemove then
table.remove(list,index)
end
end


local locDataList={}
for index,lsData in ipairs(list)do
local locData={}

locData.lsData=lsData

local sorts={}
locData.sorts=sorts

local isOtherSide=mathHelper.compareInt64(self.otherSelectGuid,lsData.guid)
local isSelectIn=mathHelper.compareInt64(self.selfSelectGuid,lsData.guid)
local selectVal=isSelectIn and 1 or(isOtherSide and-1 or 0)

sorts[1]=selectVal
sorts[2]=self.selectType==1 and lsData.follow_level or 1
sorts[3]=index

locDataList[index]=locData
end
mathHelper.sortWeightList(locDataList)

local list2={}

for index,locData in ipairs(locDataList)do
list2[index]=locData.lsData
end

self.lsDataList=list2
end

function UIChuangongSelectWin_LingShou:showList()
local len=#self.lsDataList

local datas=self.lsDataList

self.scrollView:setChildScrollViewDelayCreateGrids(len,2,0.02,1,false,false,function(index,item)
if _this==nil then return end
local data=datas[index+1]
local lsGuid=data.guid
comHelper.setChildModelRawImage_lingshou(item,data.id,_item_index.icon,0,eHeadCenterType.eHead,1)
item:SetChildText(_item_index.name,data.name)

local color=lingshouModel:getColor(data.guid)
item:SetChildCSImageSprite(_item_index.frame,globalABLookup.lingshoumain,lingshouColorToFrame[color])


item:SetChildText(_item_index.jingjieTxt,lingshouModel:getJJName(lsGuid,2))


item:SetChildText(_item_index.zizhiTxt,lingshouModel.getLingShouPropertyVal(data,lingshouPropertyType.ZIZHI))

item:SetChildText(_item_index.stateTxt,lingshouModel:getStateName(lsGuid)or"")


item:SetChildActive(_item_index.fight,true)
item:SetChildText(_item_index.fight,lingshouModel:getFightValue(lsGuid))

item:SetChildActive(_item_index.select,_this.selectIndex==index)
item:SetChildActive(_item_index.cur,mathHelper.compareInt64(lsGuid,_this.selfSelectGuid))


local showOrder=lingshouModel:checkLSHasOrder(lsGuid)and _this.selectType==1
local guidKey=tostring(lsGuid)
if _this.hiddenOrderGuidMap and _this.hiddenOrderGuidMap[guidKey]then
showOrder=false
end
item:SetChildActive(15,showOrder)
item:SetChildActive(14,showOrder)
item:SetChildButtonClick(14,function()
if _this==nil then return end
lingshouModel:setLSOrder(lsGuid,0,true)
_this.hiddenOrderGuidMap=_this.hiddenOrderGuidMap or{}
_this.hiddenOrderGuidMap[guidKey]=true
item:SetChildActive(14,false)
item:SetChildActive(15,false)

lingshouController:reqLSRefreshOrder(lsGuid,0)
UIManager.info('已取消关注灵兽')
end,true)

item:SetChildButtonClick(_item_index.detailBtn,function()
UIFullLingShouMainControl:showWindow_SingleInfoTab(_this,{
lslist=_this.lsDataList,
ls_guid=data.guid,

hideOrderBtn=true,
},{ls_guid=data.guid,})
end,true)

local isReduce=lingshouModel:checkLingshouZiZhiIsReduce(lsGuid)
item:SetChildActive(_item_index.zizhiReduceBtn,isReduce)
if isReduce then
item:SetChildButtonClick(_item_index.zizhiReduceBtn,function()
local args={}

args.item=item:GetChildWidgetBase(_item_index.zizhiReduceBtn)
args.node='right'
args.lsGuid=lsGuid

_this:showWindow('UILingShouZiZhiRestoreTipsWin',args)
end,true)
end
end)

self:refreshBtn()
end



function UIChuangongSelectWin_LingShou:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
if self.sortTypeIndex==idx then return end
self.sortTypeIndex=idx
self.sortType=self.sortTypeList[idx]

self:initLsDataList(true)

self:showList()
end


function UIChuangongSelectWin_LingShou:onSortBtn()
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


function UIChuangongSelectWin_LingShou:onSortOrderButton()
self.sortOrder=self.sortOrder==eSortOrder.eDown and eSortOrder.eUp or eSortOrder.eDown
self:initLsDataList(true)
self:showList()
end


function UIChuangongSelectWin_LingShou.selecConditionBack(data)
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

_this:showList()
end


function UIChuangongSelectWin_LingShou:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self:showList()
else
UIManager.info('请输入搜索内容')
end
return
end
if self.inputstr==inputstr then
return
end
if helper.check_spec_chars(inputstr)then
UIManager.info('名称含敏感字符')
return
end
self.inputstr=inputstr
self:initLsDataList(true)
local list=self.lsDataList
if#list<=0 then

UIManager.info('暂无符合条件的灵兽')
return
end

self.searchInput:setInputFieldValue('')
self:showList()
end

function UIChuangongSelectWin_LingShou:onSearchCancelBtn()
if self.inputstr==nil then return end
self.inputstr=nil
self:clearSearchInput()

self:initLsDataList(true)
self:showList()
end

function UIChuangongSelectWin_LingShou:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIChuangongSelectWin_LingShou:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIChuangongSelectWin_LingShou:clearSearchInput()

local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end