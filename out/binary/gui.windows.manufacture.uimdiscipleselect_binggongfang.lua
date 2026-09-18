







def_class("UIMDiscipleSelect_binggongfang",UIMDiscipleSelect)























local _this
local _insert=table.insert


function UIMDiscipleSelect_binggongfang:onLoaded(...)
_this=self
self:bindComponents()
local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_binggongfang:__delete()
self:unbindComponents()
_this=nil
end




function UIMDiscipleSelect_binggongfang:onShow(argtable,afterOnloaded)
self.args=argtable
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin


self.funcIndex=argtable.funcIndex or 1
self.effectType=argtable.effectType
self.bdType=SLG_SYSTEM_TYPE.eBingGongFang
self.bd_tybe_cfg=cfg_monijybuildconfig_get(self.bdType)
self.pro_skill_id=self.bd_tybe_cfg.pro_skill_id
if self.pro_skill_id then
self.pro_skill_cfg=cfg_discipleproskillconfig_get(self.pro_skill_id)
end

local showSuitList=equipsHelper.getFilterSuit()
local suitMap={}
for i,v in ipairs(showSuitList)do
suitMap[v.id]=true
end
self.suitMap=suitMap


self.select_index=nil
self.select_dz=nil
self:refreshView()
end


function UIMDiscipleSelect_binggongfang:onHide()

end

function UIMDiscipleSelect_binggongfang:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_binggongfang:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_binggongfang:getNetDataList()
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






function UIMDiscipleSelect_binggongfang:initDiscipleList()
self.dzIdStr=nil

local selectDiziData=bingGongChangModel:getDiziData()

if selectDiziData and selectDiziData.guid then
self.dzIdStr=tostring(selectDiziData.guid)
end

self.disciplelist={}
local list=self:getNetDataList()
for i,data in ipairs(list)do
local locData={}
locData.disciple=data
local guid=data.discipleguid

local checkCurrent=data.discipleguidStr==self.dzIdStr


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

local voc=UIDiscipleModel:getDiscipleJob(guid)
local taozhuangCfg=cfgHelper.get(cfg_binggongfangtaozhuangconfig_get,voc)
if taozhuangCfg then
locData.taozhuang=taozhuangCfg.taozhuang
end

local sorts={}
locData.sorts=sorts

sorts[1]=checkCurrent==true and 1 or 0
sorts[2]=level+offset
sorts[3]=UIDiscipleModel:getDiscipleColor(guid)
sorts[4]=guid

_insert(self.disciplelist,locData)
end

self.check_tuijian=true
self.tuijian_dizi_str=nil
end

function UIMDiscipleSelect_binggongfang:refreshItem(id,item)
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

local fight_str=FMT.fmt('<color=#7d3b17>{1}等级：</color>{0}',data.level,UIDiscipleModel:getDiscipleJobName(self.pro_skill_id))
item:SetChildText(item_cmp_index_.fightTxt,fight_str)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)

UIDiscipleModel:setDiscipleXianMoBackImage(item,item_cmp_index_.img_xianmo,disdata)


local desc_str_1=nil
local desc_str_2=nil
local desc_str_3=nil
discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2,desc_str_3)


discipleSelectController.refreshSpeciality(item,index,data.build_effects,self.onDescSlotClick)



local taozhuang=data.taozhuang
if taozhuang then
local ttable={}
for i,v in ipairs(taozhuang)do
if self.suitMap[v]then
table.insert(ttable,v)
end
end
if next(ttable)then
item:SetChildActive(item_cmp_index_.taozhuangGrid,true)
item:SetChildLayoutGroupCreateItems(item_cmp_index_.taozhuangGrid,#ttable)
local grids=item:GetChildLayoutGroupGridList(item_cmp_index_.taozhuangGrid)
for i=0,grids.Count-1 do
local tzcfg=cfgHelper.get1(cfg_discipleequipsuitconfig_get,ttable[i+1])
grids[i]:SetChildText(1,tzcfg.name)
grids[i]:SetChildIcon(2,equipsHelper.getEquipSuitIconById(tzcfg.id),true)
end
item:SetChildAnchoredPos(item_cmp_index_.scrollView_spe,-67,-50)
else
item:SetChildActive(item_cmp_index_.taozhuangGrid,false)

end
else
item:SetChildActive(item_cmp_index_.taozhuangGrid,false)
end


local isCurrent=disdata.discipleguidStr==self.dzIdStr
item:SetChildActive(item_cmp_index_.icon_cursign,isCurrent)




local job=UIDiscipleModel:getDiscipleJob(guid)
item:SetChildActive(25,true)
item:SetChildCSImageSprite(26,globalABLookup.global,UIDiscipleModel:getJobIconName(job))
item:SetChildText(27,UIDiscipleModel:getJobName(job))
end

function UIMDiscipleSelect_binggongfang:refreshScrollView()
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

function UIMDiscipleSelect_binggongfang:refreshButtons()
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

function UIMDiscipleSelect_binggongfang.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_binggongfang:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_binggongfang:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_binggongfang:onClickClose()
self.parentWin:closeSelf()
end

function UIMDiscipleSelect_binggongfang:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
self.callback(guid)
self:onClickClose()
else

end
end

function UIMDiscipleSelect_binggongfang:onBtnFire()
if not discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)then
self.callback(0)
self:onClickClose()
else

UIManager.error('该位置并未安排弟子')
end
end

function UIMDiscipleSelect_binggongfang:onSearchBtn()
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

function UIMDiscipleSelect_binggongfang:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_binggongfang:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_binggongfang:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_binggongfang:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end




