







def_class("UIMDiscipleSelect_youli",UIMDiscipleSelect)




















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local level_fmt='{0}：<color=#171311>{1}</color>'


function UIMDiscipleSelect_youli:onLoaded(...)
self:bindComponents()
_this=self

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
end


function UIMDiscipleSelect_youli:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end

function UIMDiscipleSelect_youli:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
_insert(list,v)
end
end
return list
end




function UIMDiscipleSelect_youli:onShow(argtable,afterOnloaded)
self.args=argtable
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.pointCfg=argtable.pointCfg
self.cost=argtable.cost
self.funcType=edzFuncSpecialityType.eSpeciality_YouLi

self.dzIdStr=nil
if self.args.select_dis then
self.dzIdStr=tostring(self.args.select_dis)
end





self.select_index=nil
self.select_dz=nil
self:refreshView()
end








function UIMDiscipleSelect_youli:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_youli:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_youli:getNetDataList()
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

function UIMDiscipleSelect_youli:initDiscipleList()






self.disciplelist={}
local list=self:getNetDataList()
for i,data in pairs(list)do
local locData={}
locData.disciple=data
local guid=data.discipleguid

local checkCurrent=data.discipleguidStr==self.dzIdStr
locData.checkCurrent=checkCurrent
local ylData,ylWorld,ylIndex=chuanSongZhenModel:findDiscipleData(guid)
locData.youli=ylWorld



locData.checkFlag=not UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
local jjLv=data.jingjielv
local jyNum=data.attrList[DISCIPLE_BASE_ATTR_TYPE.eJiYuan]

locData.level=jjLv
locData.jyNum=jyNum



local sorts={}
locData.sorts=sorts
local stateWeight=locData.checkFlag and 1 or 0











local build_effects=discipleSelectController.getSpeciallistByFunctionEX(data,self.funcType)or{}
locData.build_effects=build_effects
locData.effectnum=#build_effects

sorts[1]=checkCurrent and 1 or 0
sorts[2]=stateWeight
sorts[3]=ylWorld and-ylWorld or 0
sorts[4]=jyNum
sorts[5]=-jjLv
sorts[6]=-UIDiscipleModel:getDiscipleColor(guid)

table.insert(self.disciplelist,locData)
end
end

function UIMDiscipleSelect_youli:refreshScrollView()
self:initDiscipleList()
self.tuijian_dizi_str=nil
mathHelper.sortWeightList(self.disciplelist)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_youli:checkRecommend(guid_str)
return self.tuijian_dizi_str==guid_str
end

function UIMDiscipleSelect_youli:refreshItem(id,item)
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
local level_title_str='境界'
local level_level_str
level_level_str=UIDiscipleModel:getJJNameEx(data.level)
level_desc=FMT.fmt(level_fmt,level_title_str,level_level_str)
desc_str_1=level_desc

local jy_desc
local jy_title_str=UIDiscipleModel:getDiscipleBaseAttrName(DISCIPLE_BASE_ATTR_TYPE.eJiYuan)
local jy_level_str=tostring(data.jyNum)
jy_desc=FMT.fmt(level_fmt,jy_title_str,jy_level_str)
desc_str_2=jy_desc







discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2)


local istuijian=self:checkRecommend(disdata.discipleguidStr)
discipleSelectController.refreshSign(item,istuijian,guid)


discipleSelectController.refreshSpeciality(item,index,data.build_effects,self.onDescSlotClick)


local isCurrent=disdata.discipleguidStr==self.dzIdStr
item:SetChildActive(item_cmp_index_.icon_cursign,isCurrent)


discipleSelectController.refreshChuiWei(item,guid)

local gray=not data.checkFlag or data.youli~=nil
item:SetChildImageExGray(item_cmp_index_.img_color,gray)
item:SetChildCaptureImageGray(item_cmp_index_.icon_head,gray)
item:SetChildActive(item_cmp_index_.stateObj,data.checkFlag)
if data.youli==nil then
item:SetChildText(item_cmp_index_.stateName,UIDiscipleModel:getDiscipleStateDesc(guid,'',nil,'暂无居所'))
else
item:SetChildText(item_cmp_index_.stateName,"游历中")
end
end

function UIMDiscipleSelect_youli.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_youli:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_youli:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_youli:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local isCurrent=data.disciple.discipleguidStr==self.dzIdStr
self.btnFire:setActive(isCurrent)
self.btnWork:setActive(not isCurrent)
self.txtWork:setText(discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)and'派遣'or'更换')
self.txtFire:setText('移除')
else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end


function UIMDiscipleSelect_youli:OnEnable()

end


function UIMDiscipleSelect_youli:OnDisable()

end



function UIMDiscipleSelect_youli:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_youli:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
local checkCurrent=data.checkCurrent
if checkCurrent then


else


















if data.checkFlag then
if data.youli~=nil then
local show_data={
type='UIDialouge',
title='提示',
content='该弟子正在其他位置游历，确认把该弟子调配至此？',
oktext='确定',
canceltext='取消',
okcallback=function()
chuanSongZhenController:send_5_93(data.youli,guid)
self.callback(guid)
self:onClickClose()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
self.callback(guid)
self:onClickClose()
end
else
UIManager.error("弟子垂危，无法派遣")
end
end
else

UIManager.error(cfgHelper.getlang('disciple_select_tips_5'))
end
end

function UIMDiscipleSelect_youli:onBtnFire()
if not discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)then
self.callback(0)
self:onClickClose()
else

UIManager.error('该位置并未安排弟子')
end
end

function UIMDiscipleSelect_youli:onSearchBtn()
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

function UIMDiscipleSelect_youli:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_youli:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_youli:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_youli:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end