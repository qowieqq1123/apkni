







def_class("UIZSitemDiscipleSelect",UIWindowBase)









function UIZSitemDiscipleSelect:bindComponents()

self.roleListPanel=UIObject.get(self,0)
self.btnFire=UIButton.get(self,1)
self.btnWork=UIButton.get(self,2)
self.searchInput=UIInputField.get(self,3)
self.selectType=UIObject.get(self,4)
self.condition=UIObject.get(self,5)
self.txtFire=UIText.get(self,6)
self.txtWork=UIText.get(self,7)
self.costTips=UIObject.get(self,8)
self.searchBtn=UIButton.get(self,9)
self.searchCancelBtn=UIButton.get(self,10)
self.condition1=UIText.get(self,11)
self.condition2=UIText.get(self,12)
self.check1=UIImage.get(self,13)
self.check2=UIImage.get(self,14)
self.emptyIcon=UIObject.get(self,15)
self.back=UIObject.get(self,16)

self.btnFire:setButtonClick(function()self:onBtnFire()end)

self.btnWork:setButtonClick(function()self:onBtnWork()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIZSitemDiscipleSelect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.btnFire);self.btnFire=nil;
_UIObject_release(self.btnWork);self.btnWork=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.selectType);self.selectType=nil;
_UIObject_release(self.condition);self.condition=nil;
_UIObject_release(self.txtFire);self.txtFire=nil;
_UIObject_release(self.txtWork);self.txtWork=nil;
_UIObject_release(self.costTips);self.costTips=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.condition1);self.condition1=nil;
_UIObject_release(self.condition2);self.condition2=nil;
_UIObject_release(self.check1);self.check1=nil;
_UIObject_release(self.check2);self.check2=nil;
_UIObject_release(self.emptyIcon);self.emptyIcon=nil;
_UIObject_release(self.back);self.back=nil;
end

















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local level_fmt='{0}：<color=#171311>{1}{2}</color>'
local state_fmt='{0}：{1}'

local typeIndex=
{
jingjie=1,
lianti=2,
}
local typeList={'境界','潜力'}


function UIZSitemDiscipleSelect:onLoaded(...)
self:bindComponents()
_this=self
self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,nil)
self.curDzIdx=1
self.selectIndex=1
self.sortIndexs={
[0]={10},
[1]={10},
[2]={11},
}
local _OnClickRoleItemCallback=function(clicknum,i)
self:OnClickRoleItemCallback(1,i)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end

function UIZSitemDiscipleSelect.onDiscipleOrderChange(dis_guid,oldOrder,order)
if _this==nil then return end
for i,v in ipairs(_this.disciplelist)do
if mathHelper.compareInt64(dis_guid,v.disciple.discipleguid)then
local index=i-1
local item=_this.roleListPanel:getChildScrollViewItemWidget(index)
_this:refreshItem(index,item)
if oldOrder>0 and order==0 then
UIManager.info('已取消关注弟子')
end
break
end
end
end


function UIZSitemDiscipleSelect:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()

_this=nil
end

function UIZSitemDiscipleSelect:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
_insert(list,v)
end
end
return list
end




function UIZSitemDiscipleSelect:onShow(argtable,afterOnloaded)
self.args=argtable
self.ignore=argtable.ignore or{}
self.itemid=argtable.itemid
self.itemConfig=itemsConfig.getConfig(self.itemid)
self.funcparam=self.itemConfig.funcparam
self.sortOrder=eSortOrder.eUp
self.sortType=eDiscipleSortType.eJingJieSort
self.selectTypeIdx=1

self.selectType:setActive(true)
self.select_index=nil
self.select_dz=nil


local selectTypeIdx=self.selectTypeIdx or 1
local num=#typeList
self.selectType:setChildLayoutGroupCreateItems(num)
local gridlist=self.selectType:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
discipleSelectController.refreshSelectTypeListItem(item,i,typeList[i],i==selectTypeIdx,self.onClickSelectTypeItem)
end

self:initRoleListPanel()
end


function UIZSitemDiscipleSelect:initRoleListPanel()
local list=self:getNetDataList()
self:freshRoleListPanel(list,true)
end


function UIZSitemDiscipleSelect:getNetDataList()

local list={}
local sortParams={}
if false then
for i,v in ipairs(self.param.disciples)do
table.insert(list,UIDiscipleModel:getDiscipleDataX(v))
end
discipleLookup:sortList(list,self.sortType,self.sortOrder,sortParams)
else

list=discipleLookup:getSortDiscipleList(self.sortType,self.sortCondition,self.sortOrder,sortParams)
end
if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in ipairs(list)do

if not UIDiscipleModel:isShuWuDisciple(v.id)and self:isCanPass(v)then
local netData=v.netData.net
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
local list2={}
for i,v in ipairs(list)do

if not UIDiscipleModel:isShuWuDisciple(v.id)and self:isCanPass(v)then
table.insert(list2,v)
end
end
return list2
end
end

function UIZSitemDiscipleSelect:isCanPass(netData)
local iscan=false
local jingjielv=netData.netData.net.jingjielv
local limit=_this.funcparam.limit

if limit[1]<=jingjielv and jingjielv<=limit[2]then
iscan=true
end
return iscan
end


function UIZSitemDiscipleSelect:freshRoleListPanel(list,init)
self.curDzIdx=1
self:initRoleListPanelEx(list)
end


function UIZSitemDiscipleSelect:initRoleListPanelEx(list)
_this.disciplesList=list
local dataNum=#_this.disciplesList
_this.roleListPanel:setChildScrollViewCreateGrids(dataNum,2)
local hasDZ=dataNum>0
_this.hasNewDZ=nil
if hasDZ then
local grids=_this.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
_this:refreshItem(i,item)
end
end
end


function UIZSitemDiscipleSelect:refreshItem(id,item)
local index=id
local netdata=self.disciplesList[index].netData
local netData=netdata.net
local guid=netData.discipleguid

local item_cmp_index_=discipleSelectController.item_cmp_index

discipleSelectController.refreshItemHead(item,guid)


item:SetChildActive(item_cmp_index_.img_select,index==self.curDzIdx)



item:SetChildActive(item_cmp_index_.order,false)
item:SetChildActive(item_cmp_index_.quguan,false)



local desc_str_1=nil
local desc_str_2=nil
local desc_str_3=nil


local level_title_str
local level_level_str
local level_effect_str=''
if self.pro_skill_id then
level_title_str=self.pro_skill_cfg.name
level_effect_str=discipleSelectController.getEffectDesc(self.effectType,self.pro_skill_cfg,netData)
level_level_str=FMT.fmt('{0}级',netData.jingjielv)
else
level_title_str='境界'
level_level_str=UIDiscipleModel:getJJNameEx(netData.jingjielv)
end

desc_str_1=self:getLevelDesc(guid,level_fmt,level_title_str,level_level_str,level_effect_str)


local state_desc
local state_title_str='潜力'
local qianli=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eQianLi)

local state_color_fmt=FMT.fmt('<color=#171311>{0}</color>',qianli)
state_desc=FMT.fmt(state_fmt,state_title_str,state_color_fmt)
desc_str_2=state_desc


item:SetChildText(item_cmp_index_.ex_info,'')

discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2,desc_str_3)





discipleSelectController.refreshChuiWei(item,guid)

item:SetChildActive(item_cmp_index_.jiuzhiBtn,false)
item:SetChildActive(item_cmp_index_.xiangxi,true)
item:SetChildButtonClick(item_cmp_index_.xiangxi,function()
local dzList=self:getDiscipleGuidList()
otherPlayerController:openSelfPlayerDZInfoWin(dzList,dzList[index])
end)







local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildActive(item_cmp_index_.dis_job,true)
item:SetChildCSImageSprite(item_cmp_index_.dis_job,globalABLookup.global,jobicon)


local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(item_cmp_index_.spDzFlag,isSpDz)
end


function UIZSitemDiscipleSelect:OnClickRoleItemCallback(clicknum,index)

if self.curDzIdx==index+1 then return end
self.lastDzIndex=self.curDzIdx
self.curDzIdx=index+1
local item_cmp_index_=discipleSelectController.item_cmp_index
local lastWidget=self.roleListPanel:getChildScrollViewItemWidget(self.lastDzIndex-1)
local widget=self.roleListPanel:getChildScrollViewItemWidget(self.curDzIdx-1)
lastWidget:SetChildActive(item_cmp_index_.img_select,false)
widget:SetChildActive(item_cmp_index_.img_select,true)
end


function UIZSitemDiscipleSelect:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:initRoleListPanel()
end


function UIZSitemDiscipleSelect.onClickSelectTypeItem(index)

if _this.selectTypeIdx==index then
return
end
if _this.selectTypeIdx then
local lastItem=_this.selectType:getChildLayoutGroupGridItem(_this.selectTypeIdx-1)
discipleSelectController.refreshSelectTypeListItemSelect(lastItem,false)
end
_this.selectTypeIdx=index
local item=_this.selectType:getChildLayoutGroupGridItem(index-1)
discipleSelectController.refreshSelectTypeListItemSelect(item,true)

if _this.selectTypeIdx==1 then
_this.sortType=eDiscipleSortType.eJingJieSort
_this.sortOrder=eSortOrder.eUp
else
_this.sortType={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eQianLi}
_this.sortOrder=eSortOrder.eDown
end
_this:initRoleListPanel()
end


function UIZSitemDiscipleSelect:getCurSelectDzGuid()
local netdata=_this.disciplesList[_this.curDzIdx].netData
local guid=netdata.net.discipleguid
return guid
end


function UIZSitemDiscipleSelect:getDiscipleGuidList()
local list={}
for i,v in ipairs(_this.disciplesList)do
table.insert(list,v.netData.net.discipleguid)
end
return list
end




function UIZSitemDiscipleSelect:refreshView(init)
self:refreshSelecetTypeList(init)
end

function UIZSitemDiscipleSelect:refreshSelecetTypeList(init)
local selectTypeIdx=self.selectTypeIdx or 1
local num=#typeList
self.selectType:setChildLayoutGroupCreateItems(num)
local gridlist=self.selectType:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
discipleSelectController.refreshSelectTypeListItem(item,i,typeList[i],i==selectTypeIdx,self.onClickSelectTypeItem)
end
self.onClickSelectTypeItem(selectTypeIdx,init)
end

function UIZSitemDiscipleSelect:initDiscipleList()







self.disciplelist={}
local list=self:getNetDataList()
for i,data in ipairs(list)do
local guid=data.discipleguid
if not self.ignore[tostring(guid)]and not UIDiscipleModel:isShuWuDisciple(data.id)and self:isCanPass(data)then
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


local level=data.jingjielv
locData.level=level

local build_effects=discipleSelectController.getSpeciallistByBuildEx(data,self.bdType,self.funcIndex)or{}
locData.build_effects=build_effects
locData.effectnum=#build_effects

local conghui=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)

local meili=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)

local qianli=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.qianli)

local diziId=data.id

local check,reason=self:checkSelect(guid)
locData.canSelect=check
locData.reason=reason

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
local jjlevel=level
if self.dztype==2 then
jjlevel=-jjlevel
end
state=state1*10000+state2*1000+state3*100
sorts[1]=state
sorts[2]=jjlevel
sorts[3]=data.liantilv
sorts[4]=locData.effectnum
sorts[5]=UIDiscipleModel:getDiscipleColor(guid)
sorts[6]=guid
sorts[7]=conghui+state
sorts[8]=meili+state
sorts[9]=locData.canSelect and 1 or 0

sorts[10]=level*100000+diziId
sorts[11]=qianli*100000+diziId

_insert(self.disciplelist,locData)
end
end

self.check_tuijian=true
self.tuijian_dizi_str=nil
end

function UIZSitemDiscipleSelect:reSelectDisciple(default_idx)
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

function UIZSitemDiscipleSelect:onBtnWork()



local guid=self:getCurSelectDzGuid()

UIManager:invokeUIMethod('UIZhiShengItemWin','refreshrole',guid)
self:closeSelf()

end

function UIZSitemDiscipleSelect.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIZSitemDiscipleSelect:refreshSelect(index,flag)
local item=_this.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIZSitemDiscipleSelect:onClickItem(index)

if self.select_index==index then return end








local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)

end



function UIZSitemDiscipleSelect:refreshButtons()
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

function UIZSitemDiscipleSelect:OnEnable()

end

function UIZSitemDiscipleSelect:OnDisable()

end
function UIZSitemDiscipleSelect:getLevelDesc(guid,level_fmt,level_title_str,level_level_str,level_effect_str)
local defaultStr=FMT.fmt(level_fmt,level_title_str,level_level_str,level_effect_str)
local desc_str_1=''
desc_str_1=defaultStr
return desc_str_1
end

function UIZSitemDiscipleSelect:getShangDaoAddRate(guid,level)
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

function UIZSitemDiscipleSelect:getCongHuiAddRate(guid)
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

function UIZSitemDiscipleSelect:getMeiLiAddRate(guid)
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

function UIZSitemDiscipleSelect:checkRecommend(guid_str)
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



function UIZSitemDiscipleSelect:onClickClose()
self:closeSelf()
end

function UIZSitemDiscipleSelect:checkSelect(dzId,wraning)
if tostring(dzId)==tostring(self.cmpDZ)then
if self.dzIdStr==nil then
return true
else
local check,flag=self:checkSelectWithDZID(self.cmpDZ,dzId,wraning)
if check then
return check,flag
else
return check,5
end
end
end
return self:checkSelectWithDZID(dzId,self.cmpDZ,wraning)
end

function UIZSitemDiscipleSelect:checkSelectWithDZID(selDZ,cmpDZ,wraning)
local netData=UIDiscipleModel:getDiscipleData(selDZ)
if self.dztype==1 and dzSpecialitySpecialEffectController:getNotChuangGong(netData)and dzSpecialitySpecialEffectController:getNotGetXieWeiAndLianTi(netData)then
if wraning then
UIManager.error('因思绪无法成为传功者')
end
return false,7
end
if self.dztype==1 and dzSpecialitySpecialEffectController:getNotChuangGong(netData)then
if wraning then
if self.dztype==1 then
UIManager.error('因道劫无法成为传功者')
else
UIManager.error('因道劫无法成为受功者')
end
end
return false,6
end
if UIDiscipleModel:checkDiscipleState(selDZ,DISCIPLE_STATE_TYPE.edsDispatch)then
if wraning then
UIManager.error('弟子派遣中')
end
return false,-1
end
if self.dztype==1 then
if cmpDZ then
local cmpData=UIDiscipleModel:getDiscipleData(cmpDZ)
local dzData=UIDiscipleModel:getDiscipleData(selDZ)
if dzData.jingjielv>cmpData.jingjielv or dzData.liantilv>cmpData.liantilv then
return true
else
if dzData.jingjielv<=cmpData.jingjielv then
if wraning then
UIManager.error('因境界过低无法成为传功者')
end
return false,1
else
if wraning then
UIManager.error('因炼体过低无法成为传功者')
end
return false,2
end
end
else
return true
end
else
if cmpDZ then
local cmpData=UIDiscipleModel:getDiscipleData(cmpDZ)
local dzData=UIDiscipleModel:getDiscipleData(selDZ)
if dzData.jingjielv<cmpData.jingjielv or dzData.liantilv<cmpData.liantilv then
return true
else
if dzData.jingjielv>=cmpData.jingjielv then
if wraning then
UIManager.error('因境界过高无法成为受功者')
end
return false,3
else
if wraning then
UIManager.error('因炼体过高无法成为受功者')
end
return false,4
end
end
else
return true
end
end
return false,0
end

function UIZSitemDiscipleSelect:onBtnFire()







self.callback(self.dzIdStr)
self.parentWin:closeSelf()
end

function UIZSitemDiscipleSelect.on_building_event(etype,sfId,ubdId,dzId,olddzId)
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

function UIZSitemDiscipleSelect:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()
if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
self:initRoleListPanel()
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
self:freshRoleListPanel(list)
end

function UIZSitemDiscipleSelect:onSearchCancelBtn()
if self.inputstr==nil then return end
self:clearSearchInput()
self:initRoleListPanel()
end

function UIZSitemDiscipleSelect:onSearchChange(str)
self:refreshInputBtns(str)
end
function UIZSitemDiscipleSelect:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end
function UIZSitemDiscipleSelect:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end
