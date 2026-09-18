







def_class("UIMDiscipleSelect_systemzongmenoutgoer_multiSelect",UIMDiscipleSelect)




















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local level_fmt='{0}：<color=#171311>{1}</color>'



function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:onLoaded(...)
self:bindComponents()
_this=self

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)

self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end




function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:onShow(argtable,afterOnloaded)
self.args=argtable
self.currentGuids={}
self.selectIndexes={}
self.selectGuids={}
for i,v in ipairs(argtable.discipleguids)do
table.insert(self.currentGuids,tostring(v))
table.insert(self.selectGuids,tostring(v))
end
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.funcType=argtable.funcType
self.callback=argtable.callback
self.maxSelectCount=argtable.maxSelectCount or 1

self:refreshScrollView()
self:refreshButtons()
end


function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:onHide()

end



function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
_insert(list,v)
end
end
return list
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:reSelectDisciple()
local c=#self.disciplelist
if c>0 then
if#self.selectGuids>0 then
for i,v in ipairs(self.selectGuids)do
for j,w in ipairs(self.disciplelist)do
if w.disciple.discipleguidStr==v then
self.selectIndexes[i]=j
break
end
end
end
else
self.selectIndexes={}
end
else
self.selectGuids={}
self.selectIndexes={}
end
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:getNetDataList()
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
for i,v in ipairs(self.selectGuids)do
local netData=UIDiscipleModel:getDiscipleData(v)
table.insert(temp,netData)
end
for i,v in ipairs(temp_search)do
local guid_str=v[1].discipleguidStr
if not table.containsValue(self.selectGuids,guid_str)then
local str=v[2]
if string.find(str,self.inputstr)then
table.insert(temp,v[1])
end
end
end
end
return temp
else
return list
end
end



function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:initDiscipleList()
self.disciplelist={}
local list=self:getNetDataList()
for i,data in ipairs(list)do
local locData={}
locData.disciple=data
local guid=data.discipleguid

local checkCurrent=table.containsValue(self.currentGuids,data.discipleguidStr)
local checkChuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
locData.checkCurrent=checkCurrent
locData.checkChuiwei=checkChuiwei


local level=data.jingjielv
locData.level=level


local build_effects=discipleSelectController.getSpeciallistByFunctionEX(data,self.funcType)or{}
locData.build_effects=build_effects
locData.effectnum=#build_effects

local state=0
if checkCurrent then
state=3
elseif not checkChuiwei then
state=2
end

local sorts={}
locData.sorts=sorts
sorts[1]=state
sorts[2]=level
sorts[3]=locData.effectnum
sorts[4]=UIDiscipleModel:getDiscipleColor(guid)

_insert(self.disciplelist,locData)
end

self.check_tuijian=true
self.tuijian_dizi_str={}

mathHelper.sortWeightList(self.disciplelist)
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:refreshScrollView()
self:initDiscipleList()
self:reSelectDisciple()
self:refreshScrollViewImp()
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:refreshScrollViewImp()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:checkRecommend(guid_str)
if self.check_tuijian==true then
self.check_tuijian=nil
if#self.disciplelist>0 then

local cp_list=mathHelper.sortWeightList(self.disciplelist,nil,#self.currentGuids+1,true)

local curIdx=nil
if#self.currentGuids>0 then
for i,v in ipairs(cp_list)do
if v.checkCurrent then
curIdx=curIdx and math.max(curIdx,i)or i
end
end
end
for i,v in ipairs(cp_list)do
local disdata=v.disciple

local checkPass=false

if not v.checkCurrent and not v.checkChuiwei then
checkPass=true
end

local checkIdx=true
if curIdx~=nil then
checkIdx=false
if i<curIdx then
checkIdx=true
end
end
if checkPass and checkIdx then
table.insert(self.tuijian_dizi_str,disdata.discipleguidStr)
break
end
end
end
end
return#self.tuijian_dizi_str>0 and table.containsValue(self.tuijian_dizi_str,guid_str)
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index

discipleSelectController.refreshItemHead(item,guid)

item:SetChildActive(item_cmp_index_.img_select,table.containsValue(self.selectIndexes,index))


local ml_desc


local level_desc
local level_title_str
local level_str
level_title_str='境界'
level_str=UIDiscipleModel:getJJNameEx(data.level)
level_desc=FMT.fmt(level_fmt,level_title_str,level_str)

local desc_str_1=level_desc
local desc_str_2=nil
if self.funcType~=edzFuncSpecialityType.eSpeciality_SystemZongMenOutgoer_Arrest then
local ml_title_str=UIDiscipleModel:getDiscipleBaseAttrName(DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
local ml_level_str=tostring(disdata.attrList[DISCIPLE_BASE_ATTR_TYPE.eMeiLi])
desc_str_2=FMT.fmt(level_fmt,ml_title_str,ml_level_str)
end
local desc_str_3=nil
discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2,desc_str_3)


local istuijian=self:checkRecommend(disdata.discipleguidStr)
discipleSelectController.refreshSign(item,istuijian,guid)


discipleSelectController.refreshSpeciality(item,index,data.build_effects,self.onDescSlotClick)


local checkCurrent=data.checkCurrent
item:SetChildActive(item_cmp_index_.icon_cursign,checkCurrent)


discipleSelectController.refreshChuiWei(item,guid)
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:onClickItem(index)
local selectIdx=table.findValue(self.selectIndexes,index)
if selectIdx then
self:refreshSelect(index,false)
table.remove(self.selectIndexes,selectIdx)
table.remove(self.selectGuids,selectIdx)
return
end
local guidStr=self.disciplelist[index].disciple.discipleguidStr
if#self.selectIndexes<self.maxSelectCount then
table.insert(self.selectIndexes,index)
table.insert(self.selectGuids,guidStr)
self:refreshSelect(index,true)
else
local oldIndex=self.selectIndexes[self.maxSelectCount]
self:refreshSelect(oldIndex,false)

self.selectIndexes[self.maxSelectCount]=index
self.selectGuids[self.maxSelectCount]=guidStr
self:refreshSelect(index,true)
end
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:refreshButtons()
local c=#self.disciplelist
if c>0 then
self.btnFire:setActive(false)
self.btnWork:setActive(true)
self.txtWork:setText('确定')
else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end


function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:OnEnable()

end


function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:OnDisable()

end



function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:onBtnWork()
if#self.selectIndexes>0 then
local guids={}
for i,v in ipairs(self.selectIndexes)do
local data=self.disciplelist[v]
local disdata=data.disciple
local chuiwei=data.checkChuiwei
if chuiwei then
UIManager.error('垂危弟子无法设置')
return
end
table.insert(guids,disdata.discipleguid)
end

if self.callback then
self.callback(guids)
end
self.parentWin:closeSelf()
else

UIManager.error('请选择弟子')
end
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:onBtnFire()

end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()
if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
self:refreshScrollView()
else
UIManager.info('请输入搜索内容')
end
return
end
if self.inputstr==inputstr then
return
end
if helper.check_spec_chars(inputstr)then
UIManager.info('名称含非法字符')
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
self:refreshScrollView()
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshScrollView()
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_systemzongmenoutgoer_multiSelect:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end