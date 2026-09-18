







def_class("UIMDiscipleSelect_wenxinguan",UIMDiscipleSelect)




















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local level_fmt='{0}：<color=#171311>{1}{2}</color>'
local state_fmt='{0}：{1}'


function UIMDiscipleSelect_wenxinguan:onLoaded(...)
self:bindComponents()
_this=self

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_wenxinguan:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end




function UIMDiscipleSelect_wenxinguan:onShow(argtable,afterOnloaded)
self.args=argtable
self.bdData=argtable.bdData
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.effectType=argtable.effectType
self.discipleGuid=argtable.discipleGuid
self.filterTipDesc=argtable.filterTipDesc
self.emptyTipDesc=argtable.emptyTipDesc
self.isNotShowSearchBox=argtable.isNotShowSearchBox

self.filterTip:setActive(self.filterTipDesc~=nil)
if self.filterTipDesc then
self.filterTip:setText(self.filterTipDesc)
end

self.emptyTip:setActive(self.emptyTipDesc~=nil)
if self.emptyTipDesc then
self.emptyTip:setText(self.emptyTipDesc)
end

self.searchInput:setActive(not self.isNotShowSearchBox)

self:initView()

self.select_index=nil
self.select_dz=nil
self:refreshView()
end

function UIMDiscipleSelect_wenxinguan:initView()

end

function UIMDiscipleSelect_wenxinguan:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_wenxinguan:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_wenxinguan:getNetDataList()
local list={}
local disciples={}
if JiuChongTianJieEnterModel:isJiuChongTianJieComplete()then
disciples=UIDiscipleModel:getSortList()

for k,v in ipairs(disciples)do
local guid=v.discipleguid
local state=WenXinGuanModel:checkDzWXGState(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)

if netData and not state then
table.insert(list,netData)
end
end
else
disciples=WenXinGuanModel:getHCJDzList()

for k,v in ipairs(disciples)do
local state=WenXinGuanModel:checkDzWXGState(v)
local netData=UIDiscipleModel:getDiscipleData(v)

if netData and not state then
table.insert(list,netData)
end
end
end

return list
end



function UIMDiscipleSelect_wenxinguan:initDiscipleList()
self.dzIdStr=nil
if self.discipleGuid then
self.dzIdStr=tostring(self.discipleGuid)
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
level=data.jingjielv
locData.level=level


local build_effects=discipleSelectController.getSpeciallistByBuildEx(data,self.bdType,self.funcIndex)or{}
locData.build_effects=build_effects
locData.effectnum=#build_effects


local fightValue=UIDiscipleModel:getDiscipleFightValue(guid)

local sorts={}
locData.sorts=sorts

local checkChuiWei
if UIDiscipleModel:getDiscipleStateDesc(guid,'',nil,nil)=="垂危中"then
checkChuiWei=true
else
checkChuiWei=false
end

sorts[1]=checkCurrent==true and 1 or 0
sorts[2]=checkChuiWei==true and 0 or 1
sorts[3]=fightValue
sorts[4]=UIDiscipleModel:getDiscipleColor(guid)
sorts[5]=guid

_insert(self.disciplelist,locData)
end


self.check_tuijian=true
self.tuijian_dizi_str=nil
end

function UIMDiscipleSelect_wenxinguan:refreshScrollView()
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

function UIMDiscipleSelect_wenxinguan:checkRecommend(guid_str)
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

function UIMDiscipleSelect_wenxinguan:refreshItem(id,item)
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


local stand=cfgHelper.get2(cfg_disciplestandconfig_get,disdata.stand,'name')

desc_str_1=FMT.fmt('立场：<color=#171311>{0}</color>',stand)
desc_str_2=""
discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2,desc_str_3)


local istuijian=false
discipleSelectController.refreshSign(item,istuijian,guid)


item:SetChildActive(item_cmp_index_.scrollView_spe,false)
local speciallist=WenXinGuanModel:checkSpeList(guid,speXMType.all)

if speciallist~=nil and#speciallist>0 then
item:SetChildActive(item_cmp_index_.scrollView_spe_wenixnguan,true)

local count=#speciallist
item:SetChildLayoutGroupCreateItems(item_cmp_index_.grid_spe_wenixnguan,count)
local spegrids=item:GetChildLayoutGroupGridList(item_cmp_index_.grid_spe_wenixnguan)
for i=1,count do
local speitem=spegrids[i-1]
local effectcfg=speciallist[i]
UIDiscipleModel.refreshSpecialityItemExx(speitem,effectcfg)
speitem:SetChildButtonClick(1,function()
self.onDescSlotClick(i,guid,speciallist,speitem)
end)
end
else
item:SetChildActive(item_cmp_index_.scrollView_spe_wenixnguan,false)
item:SetChildText(item_cmp_index_.txt_tips,'')
end


local checkCurrent=data.checkCurrent
item:SetChildActive(item_cmp_index_.icon_cursign,checkCurrent)


discipleSelectController.refreshChuiWei(item,guid)
end

function UIMDiscipleSelect_wenxinguan.onDescSlotClick(speIdx,guid,build_effects,speitem)
if _this==nil then return end
local effects=build_effects
local cfg=effects[speIdx]
local speitem=speitem
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=guid,config=cfg})
end

function UIMDiscipleSelect_wenxinguan:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_wenxinguan:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_wenxinguan:refreshButtons()
self.btnFire:setActive(false)
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local checkCurrent=data.checkCurrent

self.btnWork:setActive(not checkCurrent)
self.txtWork:setText(discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)and'安排'or'替换')

else
self.btnWork:setActive(false)
end
end


function UIMDiscipleSelect_wenxinguan:OnEnable()

end


function UIMDiscipleSelect_wenxinguan:OnDisable()

end



function UIMDiscipleSelect_wenxinguan:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_wenxinguan:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid

local str
local netData=UIDiscipleModel:getDiscipleData(guid)
local lv=netData.jingjielv
local show_broke=UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData)and UIDiscipleModel:checkNextJJNeedBroke(lv)and
UIDiscipleModel:checkJJBrokeByHand(lv)and lv<99
local isShuWUDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
local isPlotDZ=UIDiscipleModel:isPlotDisciple(guid)
if netData.disciplename=='白子灵'then isPlotDZ=true end

if lv<90 or lv==90 and not show_broke then
str="弟子境界未达到渡劫圆满且满经验，无法参与问心关"
elseif isShuWUDZ then
str="庶务弟子不愿意参与问心关"
elseif isPlotDZ then
str="弟子红尘未了，无法进入问心关"
end

if str then
UIManager.error(str)
return
else
if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie3)and not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
local str=string.format('九重天劫期间，参与问心关的弟子无法更换，是否选择%s弟子参与问心关？',netData.disciplename)
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
_this.callback(guid)
end,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
else
_this.callback(guid)
end
end
else

UIManager.error('请选择需要进入问心关的弟子')
end
end

function UIMDiscipleSelect_wenxinguan:onBtnFire()
self.callback(nil)
end

function UIMDiscipleSelect_wenxinguan:onSearchBtn()
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

function UIMDiscipleSelect_wenxinguan:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_wenxinguan:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_wenxinguan:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_wenxinguan:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_wenxinguan:hasAnyAnPaiDZ()

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