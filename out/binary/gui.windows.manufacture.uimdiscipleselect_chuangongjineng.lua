







def_class("UIMDiscipleSelect_chuangongjineng",UIWindowBase)









function UIMDiscipleSelect_chuangongjineng:bindComponents()

self.btnFire=UIButton.get(self,0)
self.btnWork=UIButton.get(self,1)
self.check1=UIImage.get(self,2)
self.check2=UIImage.get(self,3)
self.condition=UIObject.get(self,4)
self.condition1=UIText.get(self,5)
self.condition2=UIText.get(self,6)
self.costTips=UIObject.get(self,7)
self.emptyIcon=UIObject.get(self,8)
self.emptyPart=UIObject.get(self,9)
self.emptyTip=UIText.get(self,10)
self.filterTip=UIText.get(self,11)
self.roleListPanel=UIObject.get(self,12)
self.searchBtn=UIButton.get(self,13)
self.searchCancelBtn=UIButton.get(self,14)
self.searchInput=UIInputField.get(self,15)
self.selectType=UIObject.get(self,16)
self.sortTypeDropdown=UIDropdown.get(self,17)
self.txtFire=UIText.get(self,18)
self.txtWork=UIText.get(self,19)

self.btnFire:setButtonClick(function()self:onBtnFire()end)

self.btnWork:setButtonClick(function()self:onBtnWork()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIMDiscipleSelect_chuangongjineng:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnFire);self.btnFire=nil;
_UIObject_release(self.btnWork);self.btnWork=nil;
_UIObject_release(self.check1);self.check1=nil;
_UIObject_release(self.check2);self.check2=nil;
_UIObject_release(self.condition);self.condition=nil;
_UIObject_release(self.condition1);self.condition1=nil;
_UIObject_release(self.condition2);self.condition2=nil;
_UIObject_release(self.costTips);self.costTips=nil;
_UIObject_release(self.emptyIcon);self.emptyIcon=nil;
_UIObject_release(self.emptyPart);self.emptyPart=nil;
_UIObject_release(self.emptyTip);self.emptyTip=nil;
_UIObject_release(self.filterTip);self.filterTip=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.selectType);self.selectType=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.txtFire);self.txtFire=nil;
_UIObject_release(self.txtWork);self.txtWork=nil;
end


















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort



function UIMDiscipleSelect_chuangongjineng:onLoaded(...)
self:bindComponents()
_this=self
local cfg=cfg_discipleproskillconfig()

local typeList={{0,'综合'},}
for i,v in ipairs(cfg)do
_insert(typeList,{i,v.name})
end
self.typeList=typeList

self.sortIndexs={
[1]={1,2},
[2]={1,3,2},
[3]={1,4,2},
}

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)

self.sortTypeList={"专业等级","品质排序","聪慧排序"}

local sortTypeNamesList=self.sortTypeList
self.sortTypeDropdown:setOption(sortTypeNamesList)
end

function UIMDiscipleSelect_chuangongjineng:onDropdownChange(idx)

if self.lockRefresh then return end
idx=idx+1
self.sortTypeIndex=idx

self:clearSearchInput()

self:refreshScrollView()
end

function UIMDiscipleSelect_chuangongjineng:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:refreshScrollView()
end


function UIMDiscipleSelect_chuangongjineng:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end




function UIMDiscipleSelect_chuangongjineng:onShow(argtable,afterOnloaded)
self.args=argtable
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.sfId=mapIdType.zhufeng

self.sortTypeIndex=1

self.funcIndex=argtable.funcIndex or 1
self.effectType=argtable.effectType

self.ignore=argtable.ignore or{}
self.dzIdStr=argtable.currDZ
self.cmpDZ=argtable.cmpDZ
self.dztype=argtable.dztype

self.selectPageCB=argtable.selectPageCB

self:initView()



self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false

self.select_index=nil
self.select_dz=nil

self:refreshView()
if argtable.selectPage then
self.onClickSelectTypeItem(argtable.selectPage)
end

end


function UIMDiscipleSelect_chuangongjineng:onHide()

end


function UIMDiscipleSelect_chuangongjineng:initView()
self.selectType:setActive(true)
end

function UIMDiscipleSelect_chuangongjineng:refreshView()
self:refreshSelecetTypeList()
self:refreshButtons()
end

function UIMDiscipleSelect_chuangongjineng:refreshButtons()
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


function UIMDiscipleSelect_chuangongjineng:refreshSelecetTypeList()
local selectTypeIdx=self.selectTypeIdx or 1
local num=#self.typeList
self.selectType:setChildLayoutGroupCreateItems(num)
local gridlist=self.selectType:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
self.refreshSelectTypeListItem(item,i,self.typeList[i][2],i==selectTypeIdx,self.onClickSelectTypeItem)
end
self.onClickSelectTypeItem(selectTypeIdx)
end


function UIMDiscipleSelect_chuangongjineng.refreshSelectTypeListItem(item,idx,name,flag,func)
item:SetChildButtonClickWithID(0,func,idx)
item:SetChildText(1,name)
item:SetChildCSImageSprite(0,globalABLookup.global,flag==true and'button_yeqiantab_2'or'button_yeqiantab_1')
end

function UIMDiscipleSelect_chuangongjineng.refreshSelectTypeListItemSelect(item,flag)
item:SetChildCSImageSprite(0,globalABLookup.global,flag==true and'button_yeqiantab_2'or'button_yeqiantab_1')
end


function UIMDiscipleSelect_chuangongjineng.onClickSelectTypeItem(index)
if _this.selectTypeIdx then
local lastItem=_this.selectType:getChildLayoutGroupGridItem(_this.selectTypeIdx-1)
_this.refreshSelectTypeListItemSelect(lastItem,false)
end
_this.selectTypeIdx=index
local item=_this.selectType:getChildLayoutGroupGridItem(index-1)
_this.refreshSelectTypeListItemSelect(item,true)

_this:refreshScrollView()

_this:onClickItem(1)

if _this.selectPageCB then
_this.selectPageCB(index)
end
end

function UIMDiscipleSelect_chuangongjineng:refreshScrollView()
self:initDiscipleList()

local sort_index=self.sortIndexs[self.sortTypeIndex]

mathHelper.sortWeightListEx(self.disciplelist,'sorts',sort_index,self.sortOrder)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
if self.typeList[self.selectTypeIdx][1]==0 then
self:refreshItemAllSkill(id,item)
else
self:refreshItem(id,item)
end
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_chuangongjineng:reSelectDisciple(default_idx)
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

local item_cmp_index_extra=
{
rightRoot2=42,
jobScroll=43,
expBar=44,
}

function UIMDiscipleSelect_chuangongjineng:refreshItemAllSkill(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index
local proskill=self.typeList[self.selectTypeIdx]

discipleSelectController.refreshItemHead(item,guid)

item:SetChildText(item_cmp_index_.fightTxt,FMT.fmt('聪慧：{0}',UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)))

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)

local checkCurrent=data.checkCurrent
item:SetChildActive(item_cmp_index_.icon_cursign,checkCurrent)

item:SetChildActive(item_cmp_index_.order,false)
item:SetChildActive(item_cmp_index_.quguan,false)


discipleSelectController.refreshDesc(item,FMT.fmt("{0}：{1}级",proskill[2],data.level))

item:SetChildActive(item_cmp_index_.rightRoot,false)


local showState=not data.canSelect
local showGray=showState
item:SetChildImageExGray(item_cmp_index_.img_color,showGray)
item:SetChildCaptureImageGray(item_cmp_index_.icon_head,showGray)
item:SetChildActive(item_cmp_index_.stateObj,showState)

if showState then
if data.canSelect then
item:SetChildText(item_cmp_index_.stateName,UIDiscipleModel:getDiscipleStateDesc(guid,' '))
else
if data.reason==1 then
item:SetChildText(item_cmp_index_.stateName,'技能过低')
elseif data.reason==2 then
item:SetChildText(item_cmp_index_.stateName,'技能过高')
elseif data.reason==5 then
item:SetChildText(item_cmp_index_.stateName,'无法调换')
end
end
end

local isLDLock=false
if isLDLock then
item:SetChildActive(item_cmp_index_.exx_info_root,true)
item:SetChildActive(item_cmp_index_.frame,false)
item:SetChildActive(item_cmp_index_.lockRoot,true)
item:SetChildActive(item_cmp_index_extra.rightRoot2,false)
item:SetChildText(item_cmp_index_.lockText,"弟子已锁定于论道大会阵容\n锁定期间暂不可操作")
else
item:SetChildActive(item_cmp_index_.exx_info_root,false)
item:SetChildActive(item_cmp_index_.lockRoot,false)
item:SetChildActive(item_cmp_index_extra.rightRoot2,true)
end

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildActive(item_cmp_index_.dis_job,true)
item:SetChildCSImageSprite(item_cmp_index_.dis_job,globalABLookup.global,jobicon)


local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(46,isSpDz)

item:SetChildLayoutGroupCreateItems(item_cmp_index_extra.jobScroll,8)
local descExGrid=item:GetChildLayoutGroupGridList(item_cmp_index_extra.jobScroll)
for i=1,descExGrid.Count do
local grid=descExGrid[i-1]
grid:SetChildText(0,FMT.fmt("<color=#7d3b17>{0}</color>{1}级",UIDiscipleModel:getDiscipleJobName(i),UIDiscipleModel:getDiscipleJobLevel(guid,i)))
local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,i,'icon')
grid:SetChildCSImageSprite(1,globalABLookup.proskill,FMT.fmt('image_gongzhongtp_{0}',icon))
end
end

function UIMDiscipleSelect_chuangongjineng:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index
local proskill=self.typeList[self.selectTypeIdx]

discipleSelectController.refreshItemHead(item,guid)

item:SetChildText(item_cmp_index_.fightTxt,FMT.fmt('聪慧：{0}',UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)))

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)


local hasOrder=UIDiscipleModel:checkDZHasOrder(guid)
item:SetChildActive(item_cmp_index_.order,false)
item:SetChildActive(item_cmp_index_.quguan,false)


discipleSelectController.refreshDesc(item,FMT.fmt("<color=#7d3b17>{0}</color>{1}级",proskill[2],data.level))


item:SetChildActive(item_cmp_index_extra.rightRoot2,false)



discipleSelectController.refreshSpeciality(item,index,data.build_effects,self.onDescSlotClick)


local checkCurrent=data.checkCurrent
item:SetChildActive(item_cmp_index_.icon_cursign,checkCurrent)
local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,proskill[1],'icon')
item:SetChildCSImageSprite(45,globalABLookup.proskill,FMT.fmt('image_gongzhongtp_{0}',icon))




local showState=not data.canSelect
local showGray=showState
item:SetChildImageExGray(item_cmp_index_.img_color,showGray)
item:SetChildCaptureImageGray(item_cmp_index_.icon_head,showGray)

item:SetChildActive(item_cmp_index_.stateObj,showState)
if showState then
if data.canSelect then
item:SetChildText(item_cmp_index_.stateName,UIDiscipleModel:getDiscipleStateDesc(guid,' '))
else
if data.reason==1 then
item:SetChildText(item_cmp_index_.stateName,'技能过低')
elseif data.reason==2 then
item:SetChildText(item_cmp_index_.stateName,'技能过高')
elseif data.reason==5 then
item:SetChildText(item_cmp_index_.stateName,'无法调换')
end
end
end
item:SetChildActive(item_cmp_index_.jiuzhiBtn,false)
item:SetChildActive(item_cmp_index_.xiangxi,false)

local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local curexp=UIDiscipleModel:getDiscipleJobExp(guid,proskill[1])
local maxexp=explist[data.level]
local nextexp=explist[data.level+1]
local isFull=nextexp==nil
local a,b=curexp,maxexp
if not isFull then
if a>b then
a=b
end
else
a=1
b=1
end
item:SetChildProgress(item_cmp_index_extra.expBar,a,b)
if not isFull then
local rate=math.floor((a/b)*100)
local str1=FMT.fmt('{0}%',rate)
item:SetChildProgressText(item_cmp_index_extra.expBar,str1)
else
local str='已满级'
item:SetChildProgressText(item_cmp_index_extra.expBar,str)
end

local isLDLock=false
if isLDLock then
item:SetChildActive(item_cmp_index_.exx_info_root,true)
item:SetChildActive(item_cmp_index_.frame,false)
item:SetChildActive(item_cmp_index_.lockRoot,true)
item:SetChildActive(item_cmp_index_.rightRoot,false)
item:SetChildText(item_cmp_index_.lockText,"弟子已锁定于论道大会阵容\n锁定期间暂不可操作")
else
item:SetChildActive(item_cmp_index_.exx_info_root,false)
item:SetChildActive(item_cmp_index_.lockRoot,false)
item:SetChildActive(item_cmp_index_.rightRoot,true)
end

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildActive(item_cmp_index_.dis_job,true)
item:SetChildCSImageSprite(item_cmp_index_.dis_job,globalABLookup.global,jobicon)


local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(46,isSpDz)
end

function UIMDiscipleSelect_chuangongjineng:getNetDataList()
local list=UIDiscipleModel:getSortList()
if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in ipairs(list)do
local guid=v.discipleguid
if not self.ignore[tostring(guid)]then
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





function UIMDiscipleSelect_chuangongjineng:initDiscipleList()
local selectTypeIdx=self.selectTypeIdx or 1
local pro_skill_id=self.typeList[selectTypeIdx][1]
self.disciplelist={}
local list=self:getNetDataList()
for i,data in ipairs(list)do
local guid=data.discipleguid
if not self.ignore[tostring(guid)]then
local locData={}
locData.disciple=data

local checkCurrent=data.discipleguidStr==tostring(self.dzIdStr)

locData.checkCurrent=checkCurrent

locData.conghui=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)


local level=0
if pro_skill_id>0 then
level=UIDiscipleModel:getDiscipleJobLevel(data.discipleguid,pro_skill_id)
else
for i=1,8 do
level=level+UIDiscipleModel:getDiscipleJobLevel(data.discipleguid,i)
end
end
locData.level=level

local spelist=UIDiscipleModel:getDiscipleSpecialityConfigByData(data)or defaultT
local masklist=self:getSpecialityList(pro_skill_id)or defaultT
local build_effects=discipleSelectController.calculateSpeciallist(spelist,masklist)or{}
locData.build_effects=build_effects
locData.effectnum=#build_effects

local check,reason=self:checkSelect(guid)
locData.canSelect=check
locData.reason=reason

local sorts={}
locData.sorts=sorts

local jjlevel=level
if self.dztype==2 then
jjlevel=-jjlevel
end

if self.sortOrder then
sorts[1]=locData.canSelect and 0 or 1
else
sorts[1]=locData.canSelect and 1 or 0
end
sorts[2]=jjlevel
sorts[3]=UIDiscipleModel:getDiscipleColor(guid)
sorts[4]=locData.conghui

_insert(self.disciplelist,locData)
end
end

self.check_tuijian=true
self.tuijian_dizi_str=nil
end

function UIMDiscipleSelect_chuangongjineng:checkSelect(dzId,wraning)
if tostring(dzId)==tostring(self.cmpDZ)then
if self.dzIdStr==nil then
return true
else
local check,flag=self:checkSelectWithDZID(self.cmpDZ,dzId,wraning)
return check,flag
end
end
return self:checkSelectWithDZID(dzId,self.cmpDZ,wraning)
end

function UIMDiscipleSelect_chuangongjineng:checkSelectWithDZID(selDZ,cmpDZ,wraning)
if self.dztype==1 then
if cmpDZ then
if selDZ==cmpDZ then
return true
end
local canSelect_job=false
for _,jobType in pairs(DISCIPLE_PROSKILL_TYPE)do
if UIDiscipleModel:getDiscipleJobLevel(selDZ,jobType)>UIDiscipleModel:getDiscipleJobLevel(cmpDZ,jobType)then
canSelect_job=true
break
end
end

if canSelect_job then
return true
else
if wraning then
UIManager.error('因技能等级过低无法成为传功者')
end
return false,1
end
else
return true
end
else
if cmpDZ then
if selDZ==cmpDZ then
return true
end
local canSelect_job=false
for _,jobType in pairs(DISCIPLE_PROSKILL_TYPE)do
if UIDiscipleModel:getDiscipleJobLevel(cmpDZ,jobType)>UIDiscipleModel:getDiscipleJobLevel(selDZ,jobType)then
canSelect_job=true
break
end
end
if canSelect_job then
return true
else
if wraning then
UIManager.error('因技能等级过高无法成为受功者')
end
return false,2
end
else
return true
end
end
return false,0
end

function UIMDiscipleSelect_chuangongjineng:getSpecialityList(proSkillId)
local chuangonggeconfig=cfgHelper.get(cfg_chuangonggeconfig_get,1,"functionspeciality")
if chuangonggeconfig then
local proSkillConfig=chuangonggeconfig[proSkillId]or defaultT
if proSkillConfig[1]==1 then
return cfgHelper.get(cfg_disciplefunctionspecialityconfig_get,proSkillConfig[2],"spelist")
elseif proSkillConfig[1]==2 then
return proSkillConfig[2]
end
end
end

function UIMDiscipleSelect_chuangongjineng:onClickItem(index)
if self.select_index==index then return end

local isLDLock=false
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end

local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid


self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_chuangongjineng:refreshSelect(index,flag)
if index>self.grids.Count then return end
local item=self.grids[index-1]
if item then
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end
end

function UIMDiscipleSelect_chuangongjineng.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end


local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)

UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end




function UIMDiscipleSelect_chuangongjineng:onBtnFire()
self.callback(self.dzIdStr)
self.parentWin:closeSelf()
end



function UIMDiscipleSelect_chuangongjineng:onBtnWork()
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid


local isLDLock=false
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end


if self:checkSelect(guid,true)then
self.callback(guid)
self.parentWin:closeSelf()
end
end


function UIMDiscipleSelect_chuangongjineng:onSearchBtn()
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

function UIMDiscipleSelect_chuangongjineng:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_chuangongjineng:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_chuangongjineng:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_chuangongjineng:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end
