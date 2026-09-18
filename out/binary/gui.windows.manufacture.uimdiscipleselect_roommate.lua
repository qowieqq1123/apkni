







def_class("UIMDiscipleSelect_roommate",UIMDiscipleSelect)




















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local level_fmt='{0}：<color=#171311>{1}{2}</color>'
local state_fmt='{0}：{1}'

local coupleList
local dzList={}


function UIMDiscipleSelect_roommate:onLoaded(...)
self:bindComponents()
_this=self

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_roommate:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
_this=nil
end

function UIMDiscipleSelect_roommate:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
_insert(list,v)
end
end
return list
end




function UIMDiscipleSelect_roommate:onShow(argtable,afterOnloaded)
self.args=argtable
self.bdData=argtable.bdData
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.sfId=mapIdType.zhufeng
self.bdType=self.bdData.build_id
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdType)


local effects=zongmenModel:getBuildingEffect(self.bdData,buildingEffectType.eRoomBuild)
self.roomSpeciality=effects[6]
self.allMultiRoom=zongmenModel:getBuildingDataByBdId(self.sfId,SLG_SYSTEM_TYPE.eDuoRen)
self.allSingleRoom=zongmenModel:getBuildingDataByBdId(self.sfId,SLG_SYSTEM_TYPE.eDanRen)
self.allDaoLvRoom=zongmenModel:getBuildingDataByBdId(self.sfId,SLG_SYSTEM_TYPE.eDaoLv)

self:initView()

self.select_index=nil
self.select_dz=nil
self:refreshView()
end

function UIMDiscipleSelect_roommate:initView()

end

local _filtRoomMate=function(bdData,data)
for i,v in ipairs(bdData)do
if v.caveGeziList then
for i,w in ipairs(v.caveGeziList)do
local id=tostring(w.dizi_id)
if id~='0'then
data[id]=v
end
end
elseif v.build_id==SLG_SYSTEM_TYPE.eDaoLv then
coupleList=DiscipleCoupleModel:getCoupleLiveId(tostring(v.un_build_id))
if coupleList then
local id1=tostring(coupleList.dizi_id_1)
if id1~='0'then
data[id1]=v
dzList[id1]=true
end
local id2=tostring(coupleList.dizi_id_2)
if id2~='0'then
data[id2]=v
dzList[id2]=true
end
end
end
end
end

function UIMDiscipleSelect_roommate:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_roommate:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_roommate:getNetDataList()
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







function UIMDiscipleSelect_roommate:initDiscipleList()
local grid=self.bdData.caveGeziList and self.bdData.caveGeziList[self.args.gridId]
self.dzId=grid and grid.dizi_id or 0
self.dzIdStr=tostring(self.dzId)
self.roomMate={}
_filtRoomMate(self.allMultiRoom,self.roomMate)
_filtRoomMate(self.allSingleRoom,self.roomMate)
_filtRoomMate(self.allDaoLvRoom,self.roomMate)

self.disciplelist={}
local list=self:getNetDataList()

for i,data in ipairs(list)do
local locData={}
locData.disciple=data
local guid=data.discipleguid

local checkCurrent=data.discipleguidStr==self.dzIdStr
local check_in=data:check_in()


if dzList then
if dzList[data.discipleguidStr]then
check_in=true
locData.eDaoLv=true
end
end

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
locData.level=data.jingjielv

local cant_check_in=false
if self.roomSpeciality then

local temp=UIDiscipleModel:getDiscipleSpecialityConfigByData(data)
local temp2={}
for i,v in ipairs(self.roomSpeciality)do
for i2,w in ipairs(temp)do
if v[1]==w.specialitytype and v[2]==w.id then
cant_check_in=true
table.insert(temp2,w)
end
end
end

local build_effects=temp2
locData.build_effects=build_effects
end
locData.cant_check_in=cant_check_in

local sorts={}
locData.sorts=sorts
local state=0
local state1=0
local state2=0
if checkCurrent then
state1=10
else
if not check_in then
state1=9

state2=4
if checkChuiwei then state2=3 end
if checkLowLoyalty then state2=2 end
if checkDispatch then state2=1 end
else
state1=8
end
if cant_check_in then state1=7 end
end
state=state1*10000+state2*1000
sorts[1]=state
sorts[2]=locData.level
sorts[3]=UIDiscipleModel:getDiscipleColor(guid)
sorts[4]=guid

if locData then
_insert(self.disciplelist,locData)
end
end
mathHelper.sortWeightList(self.disciplelist)


self.check_tuijian=true
self.tuijian_dizi_str=nil
end

function UIMDiscipleSelect_roommate:refreshScrollView()
self:initDiscipleList()
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_roommate:checkRecommend(guid_str)
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

if not v.checkCurrent and not v.check_in then

if not v.cant_check_in then

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

function UIMDiscipleSelect_roommate:refreshItem(id,item)
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
local state_state_str
local state_color_fmt
local bdData=self.roomMate[disdata.discipleguidStr]
if bdData then
local bd_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
state_color_fmt='<color=#171311>{0}</color>'
state_state_str=bd_cfg.name
else
state_color_fmt='<color=#c82c2c>{0}</color>'
state_state_str='暂无居所'
end

state_state_str=FMT.fmt(state_color_fmt,state_state_str)
state_desc=FMT.fmt(state_fmt,state_title_str,state_state_str)
desc_str_2=state_desc

discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2,desc_str_3)


local istuijian=self:checkRecommend(disdata.discipleguidStr)
discipleSelectController.refreshSign(item,istuijian,guid)


discipleSelectController.refreshSpeciality(item,index,data.build_effects,self.onDescSlotClick)


local checkCurrent=data.checkCurrent
item:SetChildActive(item_cmp_index_.icon_cursign,checkCurrent)


discipleSelectController.refreshChuiWei(item,guid)
end

function UIMDiscipleSelect_roommate.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_roommate:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_roommate:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_roommate:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local checkCurrent=data.checkCurrent
self.btnFire:setActive(checkCurrent)
self.btnWork:setActive(not checkCurrent)
self.txtWork:setText(discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)and'入住'or'更换')
self.txtFire:setText('搬离')

else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end


function UIMDiscipleSelect_roommate:OnEnable()

end


function UIMDiscipleSelect_roommate:OnDisable()

end



function UIMDiscipleSelect_roommate:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_roommate:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
local netData=UIDiscipleModel:getDiscipleData(guid)
if tostring(guid)~='0'and not netData:check_in()and
tostring(self.dzId)~='0'and
not UIDiscipleModel:checkDZStateToDoSomething(self.dzId,eCheckDiscipleStateOpType.eFireHome,true)then
return
end
local state=UIDiscipleModel:getDiscipleState(guid)


if data.cant_check_in then

local speCfg=data.build_effects[1]
UIManager.error(FMT.fmt('{0}因{1}怪癖不愿入住{2}',UIDiscipleModel:getDiscipleName(guid),speCfg.name,self.buildConfig.name))
elseif data.eDaoLv then
local content=string.format('入住%s,道侣双方会退出已入住的道侣洞府,\n祖师是否继续？',self.buildConfig.name)
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
self.callback(guid)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
local bdData=self.roomMate[disdata.discipleguidStr]
if bdData then
if self.dzIdStr==disdata.discipleguidStr then
UIManager.error(FMT.fmt('已入住当前{0}',self.buildConfig.name))
else




if self.dzIdStr=='0'then


self.callback(guid)
else
local grid=self.bdData.caveGeziList and self.bdData.caveGeziList[self.args.gridId]
local cantReplace,speCfg=self:checkCantRePlace(grid.dizi_id,guid)
if cantReplace then
UIManager.error(FMT.fmt('{0}因{1}怪癖不愿入住{2}',UIDiscipleModel:getDiscipleName(grid.dizi_id),speCfg.name,self.buildConfig.name))
return
else
local content='选中的弟子已入住其他住所\n是否安排他们互换？'
local call=function()
zongmenControl:reqExChangeRoomDizi(grid.dizi_id,guid)
end
discipleSelectController.showReplaceManagerDialog(nil,content,call)
end
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


function UIMDiscipleSelect_roommate:checkCantRePlace(bd_dzId,dzId)

local bdData=zongmenModel:getRoomBuildDataByDzId(dzId)
local config=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local bdType=config.build_type
local effects=zongmenModel:getBuildingEffect(bdData,buildingEffectType.eRoomBuild)

if effects then
local roomSpeciality=effects[6]

local temp=UIDiscipleModel:getDiscipleSpecialityConfig(bd_dzId)
local temp2={}
for i,v in ipairs(roomSpeciality)do
for i2,w in ipairs(temp)do
if v[1]==w.specialitytype and v[2]==w.id then
return true,w
end
end
end
end
return false
end

function UIMDiscipleSelect_roommate:onBtnFire()
if not discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
if tostring(guid)~='0'and
not UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eFireHome,true)then
return
end
local state=UIDiscipleModel:getDiscipleState(guid)
if state~=DISCIPLE_STATE_TYPE.eFree then
UIManager.error('该弟子正在忙碌中，无法搬离')
return
end
zongmenControl:reqSwitchRoomDizi(self.sfId,self.bdData.un_build_id,self.args.gridId,int64.new(0))
else

UIManager.error('该位置并未安排弟子')
end
end

function UIMDiscipleSelect_roommate.on_building_event(etype,sfId,ubdId,gzId,dzId,oldDzId)
if etype==buildingEvent.switchRoomDizi then
if _this.bdData.un_build_id~=ubdId then
return
end
local hasOld=oldDzId~=nil and tostring(oldDzId)~='0'
local hasNew=dzId~=nil and tostring(dzId)~='0'
if not hasOld and hasNew then

UIManager.info(cfgHelper.getlang('disciple_select_tips_11'))



elseif hasOld and hasNew then
UIManager.info(cfgHelper.getlang('disciple_select_tips_13'))
elseif hasOld and not hasNew then
local dzName=UIDiscipleModel:getDiscipleName(oldDzId)



local formatStr=''
if _this.bdType==15 then
formatStr=cfgHelper.getlang('disciple_select_tips_14')
else
formatStr=cfgHelper.getlang('disciple_select_tips_10')
end
UIManager.info(FMT.fmt(formatStr,dzName))
end
_this:onClickClose()
end
end

function UIMDiscipleSelect_roommate:onSearchBtn()
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

function UIMDiscipleSelect_roommate:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_roommate:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_roommate:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_roommate:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end