







def_class("UIMDiscipleSelect_yifanglingtian",UIMDiscipleSelect)
























local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local level_fmt='{0}：<color=#171311>{1}{2}</color>'
local state_fmt='{0}：{1}'


function UIMDiscipleSelect_yifanglingtian:onLoaded(...)
self:bindComponents()
_this=self

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_yifanglingtian:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
_this=nil
end

function UIMDiscipleSelect_yifanglingtian:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
_insert(list,v)
end
end
return list
end




function UIMDiscipleSelect_yifanglingtian:onShow(argtable,afterOnloaded)
self.args=argtable
self.bdData=argtable.bdData
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.sfId=argtable.sfId or zongmenModel:getMountainId()
self.bdType=self.bdData.build_id
self.funcIndex=argtable.funcIndex or 1
self.effectType=argtable.effectType
self.isShowCharm=argtable.isShowCharm
self.isPrison=argtable.isPrison
self.parentWin:setCanvasIndex(-1,5)
self:setCanvasIndex(-1,5)

if argtable.frjingjieLv then
self.frjingjieLv=argtable.frjingjieLv
end

self.bd_tybe_cfg=cfg_monijybuildconfig_get(self.bdType)
self.pro_skill_id=self.bd_tybe_cfg.pro_skill_id
if self.pro_skill_id then
self.pro_skill_cfg=cfg_discipleproskillconfig_get(self.pro_skill_id)
end

self:initView()



self.select_index=nil
self.select_dz=nil
self:refreshView()
end

function UIMDiscipleSelect_yifanglingtian:initView()

end

function UIMDiscipleSelect_yifanglingtian:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_yifanglingtian:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_yifanglingtian:getNetDataList()
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








function UIMDiscipleSelect_yifanglingtian:initDiscipleList()
self.dzIdStr=nil
if self.bdData.dizi_id then
self.dzIdStr=tostring(self.bdData.dizi_id)
end

self.disciplelist={}
local list=self:getNetDataList()
for i,data in ipairs(list)do
local locData={}
locData.disciple=data
local guid=data.discipleguid
local checkCurrent=data.discipleguidStr==self.dzIdStr
local checkFlag,cantStateType=UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eSelectWork,false)
locData.checkFlag=checkFlag
locData.cantStateType=cantStateType
local checkWorkRoom=zongmenModel:getDiscipleWorkroom(guid)~=nil
locData.checkCurrent=checkCurrent
locData.checkWorkRoom=checkWorkRoom


local level=0
if self.pro_skill_id~=nil then
level=UIDiscipleModel:getDiscipleJobLevel(data.discipleguid,self.pro_skill_id)
else
level=data.jingjielv
end
locData.level=level


local build_effects=discipleSelectController.getSpeciallistByBuildEx(data,self.bdType,self.funcIndex)or{}
locData.build_effects=build_effects
locData.effectnum=#build_effects

local offset=0
if self.pro_skill_id~=nil then
local proskill_sort_offset=cfgHelper.get2(cfg_disciplespecialityconfig_get,1,'proskill_sort_offset')
for i,v in ipairs(build_effects)do
if proskill_sort_offset[v.typo]~=nil then
local offset_=proskill_sort_offset[v.typo][v.id]
if offset_~=nil then
offset=offset+offset_
end
end
end
end













local sorts={}
locData.sorts=sorts
local stateWeight=0
if not checkFlag then
if cantStateType then
if not DISCIPLE_STATE_TYPE:isClientState(cantStateType)then
stateWeight=cfgHelper.get2(cfg_disciplestateconfig_get,cantStateType,'priority_weight')
else
stateWeight=99999
end
end
end
stateWeight=100000-stateWeight

if self.isPrison then

local charm=0
if self.isShowCharm then
if self.isShowCharm==1 then
charm=data.attrList[5]
elseif self.isShowCharm==2 then
charm=data.attrList[3]
end
end

if self.frjingjieLv then
if data.jingjielv<=self.frjingjieLv then
checkWorkRoom=true
end
end

local shenWenList=UIPrisonModel:getshenWenStateList()
local name=UIDiscipleModel:getDiscipleData(guid).disciplename

if shenWenList[name]then
checkWorkRoom=true
elseif UIDiscipleModel:getDiscipleStateDesc(guid,'',nil,nil)=="垂危中"then
checkWorkRoom=true
else
checkWorkRoom=false
end

sorts[1]=checkCurrent==true and 1 or 0
sorts[2]=checkWorkRoom==true and 0 or 1
sorts[3]=level+offset
sorts[4]=charm
sorts[5]=guid
else
sorts[1]=checkCurrent==true and 1 or 0
sorts[2]=stateWeight
sorts[3]=checkWorkRoom==true and 0 or 1
sorts[4]=level+offset
sorts[5]=UIDiscipleModel:getDiscipleColor(guid)
sorts[6]=guid
end


_insert(self.disciplelist,locData)
end

if not self.isPrison then

self.check_tuijian=true
self.tuijian_dizi_str=nil
end
end

local addValueToList=function(list,type1,value)
if value==0 then
return
end
local pv=list[type1]or 0
pv=pv+value
list[type1]=pv
end

function UIMDiscipleSelect_yifanglingtian:getSpecialScore(cfg,dzId,build_effects,bdType)
local list={}
for i,v in ipairs(build_effects)do
if v.build_effects then
for ii,vv in ipairs(v.build_effects)do
local param=vv.param
if vv.type==1 then
local elist=param[0]
if elist then
for iii,vvv in ipairs(elist)do
addValueToList(list,vvv[1],vvv[2])
end
end
elist=param[bdType]
if elist then
for iii,vvv in ipairs(elist)do
addValueToList(list,vvv[1],vvv[2])
end
end
else
if param then
for iii,vvv in ipairs(param)do
addValueToList(list,vvv[1],vvv[2])
end
end
end
end
end
end












local score=0
for k,v in pairs(list)do
if v~=0 then
if k==1 or k==2 then
score=score+v>0 and-1 or 1
elseif k==3 then
score=score+v<0 and-1 or 1
end
end
end
return score
end

function UIMDiscipleSelect_yifanglingtian:refreshScrollView()
self:initDiscipleList()
mathHelper.sortWeightList(self.disciplelist)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_yifanglingtian:checkRecommend(guid_str)
if self.check_tuijian==true then
self.check_tuijian=nil
if#self.disciplelist>0 then

local cp_list=mathHelper.sortWeightList(self.disciplelist,nil,4,true)

local curIdx=nil
if not discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)then
for i,v in ipairs(cp_list)do
if v.checkCurrent then
curIdx=i
end
end
end
for i,v in ipairs(cp_list)do
local disdata=v.disciple

local checkPass=false

if not v.checkCurrent and not v.checkWorkRoom and v.checkFlag then
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

function UIMDiscipleSelect_yifanglingtian:refreshItem(id,item)
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
if self.pro_skill_id then
level_title_str=self.pro_skill_cfg.name
level_effect_str=string.format("(生长效率+%d%%)",YiFangLingTianModel:GetLVReduceTime(data.level))

level_level_str=FMT.fmt('{0}级',data.level)
else
level_title_str='境界'
level_level_str=UIDiscipleModel:getJJNameEx(data.level)
end
level_desc=FMT.fmt(level_fmt,level_title_str,level_level_str,level_effect_str)
desc_str_1=level_desc

local state_desc
local state_title_str='状态'
local state_state_str
local state_color_fmt

if self.isShowCharm then
if self.isShowCharm==2 then

state_title_str='聪慧'
state_color_fmt='<color=#599820>{0}</color>'
state_state_str=data.disciple.attrList[3]
elseif self.isShowCharm==1 then
state_title_str='魅力'
state_color_fmt='<color=#599820>{0}</color>'
state_state_str=data.disciple.attrList[5]
end
else

if data.checkFlag then
state_state_str=UIDiscipleModel:getDiscipleStateDesc(guid,"",nil,nil)
if data.checkWorkRoom then
state_color_fmt='<color=#bb7a28>{0}</color>'
else
state_color_fmt='<color=#599820>{0}</color>'
end
else
if not DISCIPLE_STATE_TYPE:isClientState(data.cantStateType)then
state_state_str=DISCIPLE_STATE_TYPE:getName(data.cantStateType)
else
state_state_str=UIDiscipleModel:checkDZClientStateDesc(data.cantStateType)
end
state_color_fmt='<color=#c82c2c>{0}</color>'
end
end
state_state_str=FMT.fmt(state_color_fmt,state_state_str)
state_desc=FMT.fmt(state_fmt,state_title_str,state_state_str)
desc_str_2=state_desc

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

discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2,desc_str_3)


local istuijian=self:checkRecommend(disdata.discipleguidStr)
discipleSelectController.refreshSign(item,istuijian,guid)


discipleSelectController.refreshSpeciality(item,index,data.build_effects,self.onDescSlotClick)


local checkCurrent=data.checkCurrent
item:SetChildActive(item_cmp_index_.icon_cursign,checkCurrent)


discipleSelectController.refreshChuiWei(item,guid)



end

function UIMDiscipleSelect_yifanglingtian.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_yifanglingtian:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_yifanglingtian:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_yifanglingtian:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local checkCurrent=data.checkCurrent
self.btnFire:setActive(checkCurrent)
self.btnWork:setActive(not checkCurrent)
self.txtWork:setText(discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)and'安排'or'替换')
self.txtFire:setText('卸任')
else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end


function UIMDiscipleSelect_yifanglingtian:OnEnable()

end


function UIMDiscipleSelect_yifanglingtian:OnDisable()

end



function UIMDiscipleSelect_yifanglingtian:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_yifanglingtian:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
local checkCurrent=data.checkCurrent
if checkCurrent then

UIManager.error(cfgHelper.getlang('disciple_select_tips_1'))
else
if not self.isPrison then
if UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eSelectWork,true)then
if not discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)then
local curDZ=self.bdData.dizi_id
if not UIDiscipleModel:checkDZStateToDoSomething(curDZ,eCheckDiscipleStateOpType.eFireWork,true)then
return
end
end
local bdData=zongmenModel:getDiscipleWorkroom(guid)
if bdData then
local sfId_=zongmenModel:getBuildingLocationMapId(bdData.un_build_id)
local func=function()
if _this==nil or not _this.isVisible then return end
_this.wait_replace_building_mgr=bdData.un_build_id
zongmenControl:reqChangeBuildingManager(sfId_,bdData.un_build_id,int64.new(0))
end

local checkFunc=function()
local isCanFire=zongmenControl:checkBuildingManagerCanFire(sfId_,bdData.un_build_id,func)
if isCanFire then
return func()
end
end

local content=cfgHelper.getlang('disciple_select_tips_2')
discipleSelectController.showReplaceManagerDialog(nil,content,checkFunc)
else
self.callback(guid)
end
end
else
self.callback(guid)
end
end
else

UIManager.error(cfgHelper.getlang('disciple_select_tips_5'))
end
end

function UIMDiscipleSelect_yifanglingtian:onBtnFire()
if not discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)then
local guid=self.bdData.dizi_id
if not UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eFireWork,true)then
return
end
self.be_fire_building_mgr_id=guid
local sfId_=_MapManager.GetObjectMapID(self.bdData.entityId)
zongmenControl:reqChangeBuildingManager(sfId_,self.bdData.un_build_id,int64.new(0))
else

UIManager.error(cfgHelper.getlang('disciple_select_tips_6'))
end
end

function UIMDiscipleSelect_yifanglingtian.on_building_event(etype,sfId,ubdId,dzId,olddzId)
if etype==buildingEvent.replaceDisciple then
if _this.bdData.un_build_id~=ubdId and _this.wait_replace_building_mgr~=ubdId then
return
end
local data=_this.disciplelist[_this.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
if _this.wait_replace_building_mgr then

_this.wait_replace_building_mgr=nil
local cb=_this.callback
if cb~=nil then
cb(guid)
end
return
elseif _this.be_fire_building_mgr_id then

_this.dzIdStr=nil
_this.be_fire_building_mgr_id=nil
_this:refreshView()
end

local hasOld=olddzId~=nil and tostring(olddzId)~='0'
local hasNew=dzId~=nil and tostring(dzId)~='0'
if not hasOld and hasNew then

UIManager.info(cfgHelper.getlang('disciple_select_tips_9'))
_this:onClickClose()
elseif hasOld and hasNew then

UIManager.info(cfgHelper.getlang('disciple_select_tips_7'))
_this:onClickClose()
elseif hasOld and not hasNew then
local dzName=UIDiscipleModel:getDiscipleName(olddzId)

UIManager.info(FMT.fmt(cfgHelper.getlang('disciple_select_tips_8'),dzName))
end
end
end

function UIMDiscipleSelect_yifanglingtian:onSearchBtn()
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

function UIMDiscipleSelect_yifanglingtian:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_yifanglingtian:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_yifanglingtian:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_yifanglingtian:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_yifanglingtian:hasAnyAnPaiDZ()

if not discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)then return false end

for i,v in ipairs(self.disciplelist)do
local data=self.disciplelist[i]
local disdata=data.disciple
local guid=disdata.discipleguid
local checkCurrent=data.checkCurrent
if not checkCurrent then
if UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eSelectWork,true)then
local bdData=zongmenModel:getDiscipleWorkroom(guid)
if not bdData then
return true
end
end
end
end
return false
end
