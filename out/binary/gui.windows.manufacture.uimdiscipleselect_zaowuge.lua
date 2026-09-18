







def_class("UIMDiscipleSelect_zaowuge",UIMDiscipleSelect)























local _this
local _insert=table.insert


function UIMDiscipleSelect_zaowuge:onLoaded(...)
_this=self
self:bindComponents()
local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UIMDiscipleSelect_zaowuge:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
_this=nil
end




function UIMDiscipleSelect_zaowuge:onShow(argtable,afterOnloaded)
self.args=argtable
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.bdData=argtable.bdData


self.funcIndex=argtable.funcIndex or 1
self.effectType=argtable.effectType
self.bdType=SLG_SYSTEM_TYPE.eZaoWuGe
self.bd_tybe_cfg=cfg_monijybuildconfig_get(self.bdType)
self.pro_skill_id=self.bd_tybe_cfg.pro_skill_id
if self.pro_skill_id then
self.pro_skill_cfg=cfg_discipleproskillconfig_get(self.pro_skill_id)
end

self.select_index=nil
self.select_dz=nil








self.select_dz=zaoWuGeModel:getBuildDisciple()
self.isHasDz=not mathHelper.compareInt64(self.select_dz,Int64_0)
if self.select_dz and self.isHasDz then
self.dzIdStr=tostring(self.select_dz)
end

self:refreshView()
end


function UIMDiscipleSelect_zaowuge:onHide()

end

function UIMDiscipleSelect_zaowuge:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_zaowuge:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_zaowuge:getNetDataList()
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






function UIMDiscipleSelect_zaowuge:initDiscipleList()

self.disciplelist={}
local list=self:getNetDataList()
for i,data in ipairs(list)do
local locData={}
local sorts={}
locData.disciple=data
locData.sorts=sorts
local guid=data.discipleguid

local checkFlag,cantStateType=UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eSelectWork,false)
locData.checkFlag=checkFlag
locData.cantStateType=cantStateType
local checkCurrent=data.discipleguidStr==self.dzIdStr

local sorts={}
locData.sorts=sorts

sorts[1]=checkCurrent==true and 1 or 0
sorts[2]=UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eZhenFa)+UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eLianQi)
sorts[3]=UIDiscipleModel:getDiscipleColor(guid)
sorts[4]=guid

_insert(self.disciplelist,locData)
end

self.check_tuijian=true
self.tuijian_dizi_str=nil
end

function UIMDiscipleSelect_zaowuge:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(item_cmp_index_.img_color,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

comHelper.setChildModelRawImage(item,guid,item_cmp_index_.icon_head,0,eHeadCenterType.eHalf,nil,false)

local name=UIDiscipleModel:getDiscipleName(guid)
item:SetChildText(item_cmp_index_.txt_name,name)

local state_state_str
local state_color_fmt
if data.checkFlag then
state_state_str=UIDiscipleModel:getDiscipleStateDesc(guid,'',nil,nil)
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
item:SetChildText(item_cmp_index_.fightTxt,state_state_str)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)

UIDiscipleModel:setDiscipleXianMoBackImage(item,item_cmp_index_.img_xianmo,disdata)


local desc_str_1=nil
local desc_str_2=nil
local desc_str_3=nil


local zflv=UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eZhenFa)
desc_str_1=FMT.fmt("<color=#7d3b17>阵法等级：</color>{0}级",zflv)

local lqlv=UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eLianQi)
desc_str_2=FMT.fmt("<color=#7d3b17>炼器等级：</color>{0}级",lqlv)

discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2,desc_str_3)


discipleSelectController.refreshSpeciality(item,index,data.build_effects,self.onDescSlotClick)














end

function UIMDiscipleSelect_zaowuge:refreshScrollView()
self:initDiscipleList()
mathHelper.sortWeightList(self.disciplelist)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
if self and not self.isClose then
self:refreshItem(id,item)
end
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_zaowuge:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local isCurrent=data.disciple.discipleguidStr==self.dzIdStr

self.btnWork:setActive(not isCurrent)
self.txtWork:setText(discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)and'选择'or'更换')

else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end

function UIMDiscipleSelect_zaowuge.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_zaowuge:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_zaowuge:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_zaowuge:onClickClose()
self.parentWin:closeSelf()
end

function UIMDiscipleSelect_zaowuge:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
local checkCurrent=data.checkCurrent
if checkCurrent then

UIManager.error(cfgHelper.getlang('disciple_select_tips_1'))
else
























self.callback(guid)
_this:onClickClose()

end
else

UIManager.error(cfgHelper.getlang('disciple_select_tips_5'))
end
end

function UIMDiscipleSelect_zaowuge:onBtnFire()
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

function UIMDiscipleSelect_zaowuge.on_building_event(etype,sfId,ubdId,dzId,olddzId)
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

function UIMDiscipleSelect_zaowuge:onSearchBtn()
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

function UIMDiscipleSelect_zaowuge:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_zaowuge:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_zaowuge:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_zaowuge:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end




