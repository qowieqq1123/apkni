







def_class("UIMDiscipleSelect_systemzongmenoutgoer",UIMDiscipleSelect)





















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local level_fmt='{0}：<color=#171311>{1}</color>'




function UIMDiscipleSelect_systemzongmenoutgoer:onLoaded(...)
self:bindComponents()
_this=self

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)

self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_systemzongmenoutgoer:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end




function UIMDiscipleSelect_systemzongmenoutgoer:onShow(argtable,afterOnloaded)
self.args=argtable
self.currentGuids={}
for i,v in ipairs(argtable.discipleguids)do
table.insert(self.currentGuids,tostring(v))
end
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.funcType=argtable.funcType
self.callback=argtable.callback

self:initView()

self.select_index=nil
self.select_dz=nil
self:refreshView()
end


function UIMDiscipleSelect_systemzongmenoutgoer:onHide()

end



function UIMDiscipleSelect_systemzongmenoutgoer:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
_insert(list,v)
end
end
return list
end

function UIMDiscipleSelect_systemzongmenoutgoer:initView()

end

function UIMDiscipleSelect_systemzongmenoutgoer:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_systemzongmenoutgoer:reSelectDisciple(default_idx)
default_idx=default_idx or 1
local c=#self.disciplelist
if c>0 then
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

function UIMDiscipleSelect_systemzongmenoutgoer:getNetDataList()
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



function UIMDiscipleSelect_systemzongmenoutgoer:initDiscipleList()
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
self.tuijian_dizi_str=nil
end

function UIMDiscipleSelect_systemzongmenoutgoer:refreshScrollView()
self:initDiscipleList()
mathHelper.sortWeightList(self.disciplelist)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_systemzongmenoutgoer:checkRecommend(guid_str)
if self.check_tuijian==true then
self.check_tuijian=nil
if#self.disciplelist>0 then

local cp_list=mathHelper.sortWeightList(self.disciplelist,nil,2,true)

local curIdx=nil
if#self.currentGuids>0 then
for i,v in ipairs(cp_list)do
if v.checkCurrent then
curIdx=i
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
self.tuijian_dizi_str=disdata.discipleguidStr
break
end
end
end
end
return self.tuijian_dizi_str~=nil and self.tuijian_dizi_str==guid_str
end

function UIMDiscipleSelect_systemzongmenoutgoer:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index

discipleSelectController.refreshItemHead(item,guid)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)


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

function UIMDiscipleSelect_systemzongmenoutgoer.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_systemzongmenoutgoer:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_systemzongmenoutgoer:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_systemzongmenoutgoer:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local checkCurrent=data.checkCurrent
self.btnFire:setActive(false)
self.btnWork:setActive(not checkCurrent)
self.txtWork:setText('选择')

else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end


function UIMDiscipleSelect_systemzongmenoutgoer:OnEnable()

end


function UIMDiscipleSelect_systemzongmenoutgoer:OnDisable()

end



function UIMDiscipleSelect_systemzongmenoutgoer:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_systemzongmenoutgoer:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
local checkCurrent=data.checkCurrent
if checkCurrent then

UIManager.error('已选择该弟子')
else
local chuiwei=data.checkChuiwei
if chuiwei then
UIManager.error('垂危弟子无法设置')
else
if self.callback then
self.callback(guid)
end
self.parentWin:closeSelf()
end
end
else

UIManager.error('请选择弟子')
end
end

function UIMDiscipleSelect_systemzongmenoutgoer:onBtnFire()

end

function UIMDiscipleSelect_systemzongmenoutgoer:onSearchBtn()
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
self:refreshView()
end

function UIMDiscipleSelect_systemzongmenoutgoer:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_systemzongmenoutgoer:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_systemzongmenoutgoer:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_systemzongmenoutgoer:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end