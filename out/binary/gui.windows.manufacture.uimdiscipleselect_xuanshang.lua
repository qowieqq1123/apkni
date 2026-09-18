







def_class("UIMDiscipleSelect_xuanshang",UIMDiscipleSelect)





















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local level_fmt='{0}：<color=#171311>{1}{2}</color>'
local state_fmt='{0}：{1}'

local typeIndex=
{
jingjie=1,
pinzhi=2,
zhiye=3,
}
local typeList={'境界','品质','职业'}


function UIMDiscipleSelect_xuanshang:onLoaded(...)
self:bindComponents()
_this=self

self.sortIndexs={
[0]={1,2,3,4,5,6,7,8,9,10},
[1]={10,9,2,4,8,1,3,5,6,7},
[2]={10,9,4,2,8,1,3,5,6,7},
[3]={10,9,8,2,4,1,3,5,6,7},
}

self.conditions={
self.condition1,
self.condition2,
}

self.checks={
self.check1,
self.check2,
}

self.searchInput:setActive(false)
self.condition:setActive(true)

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_xuanshang:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
_this=nil
end

function UIMDiscipleSelect_xuanshang:getCondition(cfg)
local zmLevel=zongmenModel:getLevel()
for i,v in ipairs(cfg.condition)do
if zmLevel>=v[1]and zmLevel<=v[2]then
return v[3]
end
end
return nil
end

function UIMDiscipleSelect_xuanshang:setConditions()
local cfg=cfgHelper.get1(cfg_zongmenxuanshangtaskconfig_get,self.taskId)
local list={}
for k,v in pairs(self.dzList)do
list[k]=v
end

local data=self.disciplelist[self.select_index]
if data then
local disdata=data.disciple
local guid=disdata.discipleguid
list[self.selectIndex]=guid
end

local condition=self:getCondition(cfg)
for i,v in ipairs(self.conditions)do
local cnd=condition[i]
local check=self.checks[i]
if cnd then
v:setActive(true)
v:setText(UIXuanShangControl:getConditionText(cnd))
check:setImageSprite(UIXuanShangControl:checkPQCondition(list,cnd,false)and self.sprite_image_dygou or self.sprite_image_dycha)
else
v:setActive(false)
end
end
end

function UIMDiscipleSelect_xuanshang:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
_insert(list,v)
end
end
return list
end




function UIMDiscipleSelect_xuanshang:onShow(argtable,afterOnloaded)
self.args=argtable
self.bdData=argtable.bdData
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.sfId=mapIdType.zhufeng
self.bdType=self.bdData.build_id
self.funcIndex=argtable.funcIndex or 1
self.effectType=argtable.effectType

self.useList=argtable.useList
self.sortList=argtable.sortList
self.jobList=argtable.jobList
self.ignore=argtable.ignore
self.dzIdStr=argtable.currDZ
self.dzList=argtable.dzList
self.taskId=argtable.taskId
self.selectIndex=argtable.selectIndex

self.bd_tybe_cfg=cfg_monijybuildconfig_get(self.bdType)
self.pro_skill_id=self.bd_tybe_cfg.pro_skill_id
if self.pro_skill_id then
self.pro_skill_cfg=cfg_discipleproskillconfig_get(self.pro_skill_id)
end

self:initView()



self.select_index=nil
self.select_dz=nil
self:refreshView()

self:setConditions()
end

function UIMDiscipleSelect_xuanshang:initView()
self.selectType:setActive(true)
end

function UIMDiscipleSelect_xuanshang:refreshView()
self:refreshSelecetTypeList()
self:refreshButtons()
end

function UIMDiscipleSelect_xuanshang:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_xuanshang:getNetDataList()
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








function UIMDiscipleSelect_xuanshang:initDiscipleList()





self.disciplelist={}
local list=self:getNetDataList()
for i,data in ipairs(list)do
local guid=data.discipleguid
if not self.ignore[tostring(guid)]then
local locData={}
locData.disciple=data

local checkCurrent=data.discipleguidStr==tostring(self.dzIdStr)
local check_in=data:check_in()
local checkfree=UIDiscipleModel:checkDiscipleState(guid,DISCIPLE_STATE_TYPE.eFree)
local checkWorkRoom=zongmenModel:getDiscipleWorkroom(guid)~=nil
local checkChuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
local checkLowLoyalty=UIDiscipleModel:checkLowLoyalty(guid)
local checkDispatch=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.edsDispatch)
locData.checkCurrent=checkCurrent
locData.check_in=check_in
locData.checkfree=checkfree
locData.checkWorkRoom=checkWorkRoom
locData.checkChuiwei=checkChuiwei
locData.checkLowLoyalty=checkLowLoyalty
locData.checkDispatch=checkDispatch


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

local conghui=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)

local meili=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)

local job=UIDiscipleModel:getDiscipleJob(guid)
local needJob=self.jobList[self.selectTypeIdx]
local checkJob=needJob==job and 1 or 0

local sorts={}
locData.sorts=sorts
local state=0
local state1=0
local state2=0
local state3=0
if checkCurrent then
state1=10
else
if check_in then
state1=9
if checkfree then
state2=2
if not checkWorkRoom then
state3=2
else
state3=1
end
else
state2=1
end
else
state1=8
end
if checkChuiwei then state1=7 end
if checkLowLoyalty then state1=6 end
if checkDispatch then state1=5 end
end
state=state1*10000+state2*1000+state3*100
sorts[1]=state
sorts[2]=level
sorts[3]=locData.effectnum
sorts[4]=UIDiscipleModel:getDiscipleColor(guid)
sorts[5]=guid
sorts[6]=conghui+state
sorts[7]=meili+state
sorts[8]=checkJob
sorts[9]=UIXuanShangControl:isDiscipleInTask(guid)and 0 or 1
sorts[10]=checkCurrent and 1 or 0

if needJob<0 or checkJob==1 then
_insert(self.disciplelist,locData)
end
end
end

self.check_tuijian=true
self.tuijian_dizi_str=nil
end

function UIMDiscipleSelect_xuanshang:refreshScrollView(beginIdx)
self:initDiscipleList()
self.emptyIcon:setActive(#self.disciplelist<=0)

local stype=self.useList[self.selectTypeIdx]
local sort_index=self.sortIndexs[stype]
mathHelper.sortWeightListEx(self.disciplelist,'sorts',sort_index)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_xuanshang:checkRecommend(guid_str)
if self.check_tuijian==true then
self.check_tuijian=nil
if#self.disciplelist>0 then

local cp_list=mathHelper.sortWeightList(self.disciplelist,nil,2,true)

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

if not v.checkCurrent and v.check_in then

if not v.checkWorkRoom and v.checkfree then

if not v.checkChuiwei and not v.checkLowLoyalty and not v.checkDispatch then
checkPass=true
end
end
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

function UIMDiscipleSelect_xuanshang:refreshItem(id,item)
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



local level_title_str
local level_level_str
local level_effect_str=''
if self.pro_skill_id then
level_title_str=self.pro_skill_cfg.name
level_effect_str=discipleSelectController.getEffectDesc(self.effectType,self.pro_skill_cfg,data)
level_level_str=FMT.fmt('{0}级',data.level)
else
level_title_str='境界'
level_level_str=UIDiscipleModel:getJJNameEx(data.level)
end
desc_str_1=self:getLevelDesc(guid,level_fmt,level_title_str,level_level_str,level_effect_str)

local state_desc
local state_title_str='状态'

local state_color_fmt

local isInTask=UIXuanShangControl:isDiscipleInTask(guid)
local state_state_str=isInTask and'<color=red>悬赏任务中</color>'or'<color=green>未执行悬赏任务</color>'














state_color_fmt='<color=#171311>{0}</color>'
state_state_str=FMT.fmt(state_color_fmt,state_state_str)
state_desc=FMT.fmt(state_fmt,state_title_str,state_state_str)
desc_str_2=state_desc

if self.args.exInfoFunc then
item:SetChildText(item_cmp_index_.ex_info,self.args.exInfoFunc(disdata))
else
item:SetChildText(item_cmp_index_.ex_info,'')
end

discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2,desc_str_3)






discipleSelectController.refreshSpeciality(item,index,data.build_effects,self.onDescSlotClick)


local checkCurrent=data.checkCurrent
item:SetChildActive(item_cmp_index_.icon_cursign,checkCurrent)


discipleSelectController.refreshChuiWei(item,guid)
end

function UIMDiscipleSelect_xuanshang.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_xuanshang:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_xuanshang:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
self:setConditions()
end

function UIMDiscipleSelect_xuanshang:refreshButtons()
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


function UIMDiscipleSelect_xuanshang:OnEnable()

end


function UIMDiscipleSelect_xuanshang:OnDisable()

end


function UIMDiscipleSelect_xuanshang:refreshSelecetTypeList()
local selectTypeIdx=self.selectTypeIdx or 1
local tlist=self.sortList
if not tlist then
for i,v in ipairs(self.useList)do
table.insert(tlist,typeList[v])
end
end
local num=#tlist
self.selectType:setChildLayoutGroupCreateItems(num)
local gridlist=self.selectType:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
discipleSelectController.refreshSelectTypeListItem(item,i,typeList[i],i==selectTypeIdx,self.onClickSelectTypeItem)
end
self.onClickSelectTypeItem(selectTypeIdx)
end

function UIMDiscipleSelect_xuanshang.onClickSelectTypeItem(index)
if _this.selectTypeIdx then
local lastItem=_this.selectType:getChildLayoutGroupGridItem(_this.selectTypeIdx-1)
discipleSelectController.refreshSelectTypeListItemSelect(lastItem,false)
end
_this.selectTypeIdx=index
local item=_this.selectType:getChildLayoutGroupGridItem(index-1)
discipleSelectController.refreshSelectTypeListItemSelect(item,true)
local stype=_this.useList[index]
if stype==typeIndex.jingjie then
_this:refreshScrollView(2)
elseif stype==typeIndex.pinzhi then
_this:refreshScrollView(6)
elseif stype==typeIndex.zhiye then
_this:refreshScrollView(7)
end
end

function UIMDiscipleSelect_xuanshang:getLevelDesc(guid,level_fmt,level_title_str,level_level_str,level_effect_str)
local defaultStr=FMT.fmt(level_fmt,level_title_str,level_level_str,level_effect_str)
local desc_str_1=''




















desc_str_1=defaultStr

return desc_str_1
end

function UIMDiscipleSelect_xuanshang:getShangDaoAddRate(guid,level)
local config=cfg_xianzhanshangdaozengyiconfig()
local rate=0
for i,v in ipairs(config)do
local range=v.range
if level>=range[1]and level<=range[2]then
rate=v.lingshiZengYi
break
end
end
return rate
end

function UIMDiscipleSelect_xuanshang:getCongHuiAddRate(guid)
local conghui=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
local config=cfg_xianzhanconghuizengyiconfig()
local rate=0
for i,v in ipairs(config)do
local range=v.conghuiRange
if conghui>=range[1]and conghui<=range[2]then
rate=v.mydZengYi
break
end
end
return rate
end

function UIMDiscipleSelect_xuanshang:getMeiLiAddRate(guid)
local meili=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
local config=cfg_xianzhanmeilizhizengyiconfig()
local rate=0
for i,v in ipairs(config)do
local range=v.mlzRange
if meili>=range[1]and meili<=range[2]then
rate=v.hgdZengYi
break
end
end
return rate
end



function UIMDiscipleSelect_xuanshang:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_xuanshang:onBtnWork()











































local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
if UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)then
UIManager.error('弟子垂危')
return
end
if UIXuanShangControl:isDiscipleInTask(guid)then
UIManager.error('弟子执行任务中')
return
end
self.callback(guid)
self.parentWin:closeSelf()
end

function UIMDiscipleSelect_xuanshang:onBtnFire()








self.callback()
self.parentWin:closeSelf()
end

function UIMDiscipleSelect_xuanshang.on_building_event(etype,sfId,ubdId,dzId,olddzId)
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

function UIMDiscipleSelect_xuanshang:onSearchBtn()
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

function UIMDiscipleSelect_xuanshang:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_xuanshang:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_xuanshang:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_xuanshang:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end