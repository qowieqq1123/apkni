







def_class("UIMDiscipleSelect_feisheng",UIMDiscipleSelect)




















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local level_fmt='{0}：<color=#171311>{1}{2}</color>'
local state_fmt='{0}：{1}'


function UIMDiscipleSelect_feisheng:onLoaded(...)
self:bindComponents()
_this=self

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_feisheng:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end

function UIMDiscipleSelect_feisheng:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
_insert(list,v)
end
end
return list
end




function UIMDiscipleSelect_feisheng:onShow(argtable,afterOnloaded)
self.args=argtable
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.bdType=SLG_SYSTEM_TYPE.eFeiShengTai
self.funcIndex=argtable.funcIndex or 1

self.dzIdStr=nil
if self.args.select_dis then
self.dzIdStr=tostring(self.args.select_dis)
end

self:initView()



self.select_index=nil
self.select_dz=nil
self:refreshView()
end

function UIMDiscipleSelect_feisheng:initView()

end

function UIMDiscipleSelect_feisheng:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_feisheng:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_feisheng:getNetDataList()
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


function UIMDiscipleSelect_feisheng:initDiscipleList()
self.disciplelist={}
local list=self:getNetDataList()

for i,data in ipairs(list)do
local level=data.jingjielv


local check=UIDiscipleModel:isDiscipleJJLevelWillChangeX(data)and UIDiscipleModel:checkNextJJNeedBroke(level)
if check then
local locData={}
local level=data.jingjielv
locData.disciple=data
local sortWeight=0
local scoreWeight=0

scoreWeight=scoreWeight+level*1000
if self.roomSpeciality then

local temp=UIDiscipleModel:getDiscipleSpecialityConfigByData(data)
local temp2={}
local specialityList=FeiShengTaiModel.getFeiShengTaiSpecialityList()
for _,v in ipairs(specialityList)do
for _,w in ipairs(temp)do
if v[1]==w.specialitytype and v[2]==w.id then
table.insert(temp2,w)
end
end
end
scoreWeight=scoreWeight+#temp2
local build_effects=temp2
locData.build_effects=build_effects
end

sortWeight=sortWeight+scoreWeight
if data.discipleguidStr==self.dzIdStr then
sortWeight=sortWeight+1000000
end
locData.sortWeight=sortWeight
locData.scoreWeight=scoreWeight
locData.level=level

_insert(self.disciplelist,locData)
end
end
end

function UIMDiscipleSelect_feisheng:refreshScrollView()
self:initDiscipleList()
table.sort(self.disciplelist,function(a,b)
return a.sortWeight>b.sortWeight
end)
self:reSelectDisciple()
self.tuijian_dizi_str=nil


self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_feisheng:checkRecommend(guid_str)
return self.tuijian_dizi_str==guid_str
end

function UIMDiscipleSelect_feisheng:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index

discipleSelectController.refreshItemHead(item,guid)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)


local desc_str_1=nil
local desc_str_2=nil
local desc_str_3=nil


local level_desc
local level_title_str
local level_level_str
local level_effect_str=''
level_title_str='境界'
level_level_str=UIDiscipleModel:getJJNameEx(data.level)
level_desc=FMT.fmt(level_fmt,level_title_str,level_level_str,level_effect_str)
desc_str_1=level_desc

local state_desc
local state_title_str='状态'
local state=UIDiscipleModel:getDiscipleState(guid)
local state_state_str=UIDiscipleModel:getDiscipleStateDesc(guid,'',nil,'未入住洞府')
local state_color_fmt
if state==DISCIPLE_STATE_TYPE.eFree then
local bdData=zongmenModel:getDiscipleWorkroom(guid)
if bdData then
state_color_fmt='<color=#bb7a28>{0}</color>'
else
if disdata:check_in()then
state_color_fmt='<color=#599820>{0}</color>'
else
state_color_fmt='<color=#c82c2c>{0}</color>'
end
end
else
state_color_fmt='<color=#c82c2c>{0}</color>'
end
state_state_str=FMT.fmt(state_color_fmt,state_state_str)
state_desc=FMT.fmt(state_fmt,state_title_str,state_state_str)
desc_str_2=state_desc

discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2,desc_str_3)


local istuijian=self:checkRecommend(disdata.discipleguidStr)
discipleSelectController.refreshSign(item,istuijian,guid)


discipleSelectController.refreshSpeciality(item,index,data.build_effects,self.onDescSlotClick)


local isCurrent=disdata.discipleguidStr==self.dzIdStr
item:SetChildActive(item_cmp_index_.icon_cursign,isCurrent)


discipleSelectController.refreshChuiWei(item,guid)
end

function UIMDiscipleSelect_feisheng.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_feisheng:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_feisheng:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_feisheng:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local isCurrent=data.disciple.discipleguidStr==self.dzIdStr
self.btnFire:setActive(isCurrent)
self.btnWork:setActive(not isCurrent)
self.txtWork:setText(discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)and'选择'or'更换')
self.txtFire:setText('移除')
else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end


function UIMDiscipleSelect_feisheng:OnEnable()

end


function UIMDiscipleSelect_feisheng:OnDisable()

end



function UIMDiscipleSelect_feisheng:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_feisheng:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
if UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eFeiSheng,true)then
self.callback(guid)
self:onClickClose()
end
else

UIManager.error(cfgHelper.getlang('disciple_select_tips_5'))
end
end

function UIMDiscipleSelect_feisheng:onBtnFire()
if not discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)then
self.callback(0)
self:onClickClose()
else

UIManager.error('该位置并未安排弟子')
end
end

function UIMDiscipleSelect_feisheng:onSearchBtn()
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

function UIMDiscipleSelect_feisheng:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_feisheng:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_feisheng:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_feisheng:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

