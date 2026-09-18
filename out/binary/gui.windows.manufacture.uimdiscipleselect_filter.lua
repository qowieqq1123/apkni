







def_class("UIMDiscipleSelect_filter",UIMDiscipleSelect)





















local typeEnum={
jingJie=1,
sixAttrTotal=2,
}

local typeInfoList={
[typeEnum.jingJie]={
name='境界',
getInfo=function(data)
local jjlv=data.jingjielv

local jjName=UIDiscipleModel:getJJName3(jjlv)

return FMT.fmt("{0}{1}",toColorString(FONT_COLOR.eOrangeColor,"境界："),jjName)
end,
fitler=function(data,param)

local range=param[2]
local lv=data.jingjielv
local state=true
if range[1]then
state=state and lv>=range[1]
end

if range[2]then
state=state and range[2]>=lv
end

return state
end,
weight=function(data,param)
return data.jingjielv*param[2]
end
},
[typeEnum.sixAttrTotal]={
name='六维总和',
getInfo=function(data)
local totalVal=UIDiscipleModel:getSixAttrTotalVal(data.discipleguid)

return FMT.fmt("{0}{1}",toColorString(FONT_COLOR.eOrangeColor,"六维总和："),totalVal)
end,
fitler=function(data,param)
return true
end,
weight=function(data,param,selectDisciple)
local totalVal=UIDiscipleModel:getSixAttrTotalVal(data.discipleguid)
local selectOffsetVal=mathHelper.compareInt64(data.discipleguid,selectDisciple or Int64_0)and 100000 or 0
return totalVal*param[2]+selectOffsetVal
end
},
}

local sortPlan={
[1]={{typeEnum.jingJie,10000}},
[2]={{typeEnum.sixAttrTotal,1}}
}

local dealTypeFunc=function(type,funcName,data,param,selectDzGuid)
if typeInfoList[type]then
local func=typeInfoList[type][funcName]
if func then
return func(data,param,selectDzGuid)
else
logErr(FMT.fmt("缺少 类型{0}的 {1} 代码配置",type,funcName))
end
else
logErr(FMT.fmt("缺少 类型{0}的代码配置",type))
end
end

local _this



function UIMDiscipleSelect_filter:onLoaded(...)
self:bindComponents()
_this=self

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_filter:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end














function UIMDiscipleSelect_filter:onShow(argtable,afterOnloaded)
self.args=argtable

self.parentWin=argtable.parentWin

self.dzFilterTypeList=argtable.dzFilterTypeList or{}
self.sortPlanId=argtable.sortPlanId
self.selectdzguid=argtable.selectdzguid
self.dzShowTypeList=argtable.dzShowTypeList

self.workCallBack=argtable.workCallBack
self.fireCallBack=argtable.fireCallBack

self.filterTipDesc=argtable.filterTipDesc
self.emptyTipDesc=argtable.emptyTipDesc

self.isNotShowSearchBox=argtable.isNotShowSearchBox
self.isShowFireBtn=argtable.isShowFireBtn

self.select_index=nil
self.select_dz=self.selectdzguid

local canvasIdx=argtable.canvasIdx
if canvasIdx then
self:setCanvasIndex(-1,canvasIdx)
end

self.filterTip:setActive(self.filterTipDesc~=nil)
if self.filterTipDesc then
self.filterTip:setText(self.filterTipDesc)
end

self.emptyTip:setActive(self.emptyTipDesc~=nil)
if self.emptyTipDesc then
self.emptyTip:setText(self.emptyTipDesc)
end

self.searchInput:setActive(not self.isNotShowSearchBox)

self:refreshView()
end


function UIMDiscipleSelect_filter:onHide()

end

function UIMDiscipleSelect_filter:initDiscipleList()
self.disciplelist={}
local list=self:getNetDataList()

for k,data in ipairs(list)do
local state=true
local guid=data.discipleguid

for _,filterTypeData in ipairs(self.dzFilterTypeList)do
local type=filterTypeData[1]
state=state and dealTypeFunc(type,'fitler',data,filterTypeData)
end

if state then
local temp={}
local sorts={}
temp.sorts=sorts
temp.disciple=data
local plan=sortPlan[self.sortPlanId]or{}
for sortIndex,sortSub in ipairs(plan)do
local type=sortSub[1]
sorts[sortIndex]=sorts[sortIndex]or 0
sorts[sortIndex]=sorts[sortIndex]+dealTypeFunc(type,'weight',data,sortSub,self.selectdzguid)or 0
end

if UIDiscipleModel:getDiscipleStateDesc(guid,'',nil,nil)=="审问中"then
temp.isInterrogation=true
elseif UIDiscipleModel:getDiscipleStateDesc(guid,'',nil,nil)=="垂危中"then
temp.isChuiWei=true
end

temp.checkCurrent=mathHelper.compareInt64(data.discipleguidStr,self.select_dz)

table.insert(self.disciplelist,temp)
end
end
end

function UIMDiscipleSelect_filter:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_filter:reSelectDisciple(default_idx)
default_idx=default_idx or 1
local dzNum=#self.disciplelist
if dzNum>0 then
if self.select_dz~=nil then
local f=nil
for i,v in ipairs(self.disciplelist)do
if mathHelper.compareInt64(v.disciple.discipleguid,self.select_dz)then
f=i
break
end
end
if f then
self.select_index=f
else
self.select_index=default_idx
end
elseif self.select_index~=nil then
local f=self.disciplelist[self.select_index]
if f==nil then
self.select_index=default_idx
end
else
self.select_index=default_idx
end
else
self.select_index=nil
self.select_dz=nil
end
if self.select_index then
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
end
end

function UIMDiscipleSelect_filter:getNetDataList()
local list=UIDiscipleModel:getSortList()
if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in ipairs(list)do
local netData=v
local guid_str=netData.discipleguidStr
local str=self.nameSearchList[guid_str]
if str==nil then
str=UIDiscipleModel.getSearchName(guid_str,netData.disciplename)
self.nameSearchList[guid_str]=str
end
local d={v,str}
table.insert(temp_search,d)
end
if#temp_search>0 then
for i,v in ipairs(temp_search)do
local str=v[2]
if string.find(str,self.inputstr)then
table.insert(temp,v[1])
end
end
end
return temp
else
return list
end
end

function UIMDiscipleSelect_filter:refreshScrollView()
self:initDiscipleList()
mathHelper.sortWeightList(self.disciplelist)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()

local isShowEmpty=#self.disciplelist==0
self.emptyPart:setActive(isShowEmpty)
end

function UIMDiscipleSelect_filter:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index

discipleSelectController.refreshItemHead(item,guid)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)


local desc_str_list={}

for k,showTypeData in ipairs(self.dzShowTypeList)do
local showType=showTypeData[1]
local desc=dealTypeFunc(showType,'getInfo',data.disciple,showTypeData)
table.insert(desc_str_list,desc)
end

if self.args.exInfoFunc then
local text1,text2=self.args.exInfoFunc(disdata)
item:SetChildText(item_cmp_index_.ex_info,text1)

if text2 then
item:SetChildActive(item_cmp_index_.exx_info_root,true)
item:SetChildText(item_cmp_index_.exx_info,text2)
else
item:SetChildActive(item_cmp_index_.exx_info_root,false)
end
else
item:SetChildText(item_cmp_index_.ex_info,'')
end

discipleSelectController.refreshDesc(item,desc_str_list[1],desc_str_list[2],desc_str_list[3])









local checkCurrent=data.checkCurrent
item:SetChildActive(item_cmp_index_.icon_cursign,checkCurrent)


discipleSelectController.refreshChuiWei(item,guid)
if WenXinGuanModel:judgeIsCanEnter(guid)then
item:SetChildActive(item_cmp_index_.hcjFkag,true)
item:SetChildCSImageSprite(item_cmp_index_.hcjFkag,"ui/windows/hongchenjie/hongchenjie_atlas_pak.ab","image_hongchenjie_wz11")
else
item:SetChildActive(item_cmp_index_.hcjFkag,false)
end
end

function UIMDiscipleSelect_filter.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_filter:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_filter:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_filter:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local checkCurrent=data.checkCurrent
self.btnFire:setActive(checkCurrent and self.isShowFireBtn)
self.btnWork:setActive(not checkCurrent)

self.txtWork:setText(discipleSelectController.isDiziEmptyOrNil(self.selectdzguid)and'安排'or'替换')
self.txtFire:setText('卸任')
else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end


function UIMDiscipleSelect_filter:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_filter:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_filter:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_filter:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end



function UIMDiscipleSelect_filter:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local checkCurrent=data.checkCurrent
if checkCurrent then
UIManager.error("已安排此弟子")
else
if self.workCallBack then
self.workCallBack(disdata)
self:onClickClose()
else
logErr("缺少安排 回调方法")
end
end
else
UIManager.error(cfgHelper.getlang('disciple_select_tips_5'))
end
end

function UIMDiscipleSelect_filter:onBtnFire()
if not discipleSelectController.isDiziEmptyOrNil(self.select_dz)then
if self.select_index then
if self.fireCallBack then
self.fireCallBack()
self:onClickClose()
else
logErr("缺少卸任 回调方法")
end
else
UIManager.error(cfgHelper.getlang('disciple_select_tips_5'))
end
else

UIManager.error('还未选择弟子')
end
end

function UIMDiscipleSelect_filter:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_filter:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()
if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
self:refreshView()
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
local list=self:getNetDataList()
if#list<=0 then
self.inputstr=nil
UIManager.info('宗门查无此人')
return
end
self.searchInput:setInputFieldValue('')
self:refreshView()
end


