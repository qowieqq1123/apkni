







def_class("UIMDiscipleSelect_chuangongge",UIMDiscipleSelect)





















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
local typeList={'境界','炼体'}


function UIMDiscipleSelect_chuangongge:onLoaded(...)
self:bindComponents()
_this=self

self.sortIndexs={
[0]={1,2,3,4,5,6,7,8,9},
[1]={9,2,5,1,3,4,6,7,8},
[2]={9,3,5,1,2,4,6,7,8},
}

self.quguanFunc=function(index)
local data=self.disciplelist[index]
UIDiscipleController:reqDZRefreshOrder(data.disciple.discipleguid,0)
end

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)

self:addNotify(notifyConfig.onDiscipleOrderChange,self.onDiscipleOrderChange)
end

function UIMDiscipleSelect_chuangongge.onDiscipleOrderChange(dis_guid,oldOrder,order)
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


function UIMDiscipleSelect_chuangongge:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
_this=nil
end

function UIMDiscipleSelect_chuangongge:getDiscipleDatas()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
_insert(list,v)
end
end
return list
end




function UIMDiscipleSelect_chuangongge:onShow(argtable,afterOnloaded)
self.args=argtable
self.bdData=argtable.bdData
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.sfId=mapIdType.zhufeng
self.bdType=self.bdData.build_id
self.funcIndex=argtable.funcIndex or 1
self.effectType=argtable.effectType

self.ignore=argtable.ignore or{}
self.dzIdStr=argtable.currDZ
self.cmpDZ=argtable.cmpDZ
self.dztype=argtable.dztype

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

function UIMDiscipleSelect_chuangongge:initView()
self.selectType:setActive(true)
end

function UIMDiscipleSelect_chuangongge:refreshView()
self:refreshSelecetTypeList()
self:refreshButtons()
end

function UIMDiscipleSelect_chuangongge:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_chuangongge:getNetDataList()
local list=UIDiscipleModel:getSortList()
if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in ipairs(list)do
local guid=v.discipleguid
if not self.ignore[tostring(guid)]and not UIDiscipleModel:isShuWuDisciple(v.id)then
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








function UIMDiscipleSelect_chuangongge:initDiscipleList()





self.disciplelist={}
local list=self:getNetDataList()
for i,data in ipairs(list)do
local guid=data.discipleguid
if not self.ignore[tostring(guid)]and not UIDiscipleModel:isShuWuDisciple(data.id)then
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

_insert(self.disciplelist,locData)
end
end

self.check_tuijian=true
self.tuijian_dizi_str=nil
end

function UIMDiscipleSelect_chuangongge:refreshScrollView(beginIdx)
self:initDiscipleList()


local sort_index=self.sortIndexs[self.selectTypeIdx]
mathHelper.sortWeightListEx(self.disciplelist,'sorts',sort_index)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_chuangongge:checkRecommend(guid_str)
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

function UIMDiscipleSelect_chuangongge:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index

discipleSelectController.refreshItemHead(item,guid)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)


local hasOrder=UIDiscipleModel:checkDZHasOrder(guid)
item:SetChildActive(item_cmp_index_.order,self.dztype==1 and hasOrder)
item:SetChildActive(item_cmp_index_.quguan,self.dztype==1 and hasOrder)
item:SetChildButtonClickWithID(item_cmp_index_.quguan,self.quguanFunc,index)


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
local state_title_str='炼体'

local state_color_fmt

local ltlv=disdata.liantilv
local n1,p1=UIDiscipleModel:getLTNameX(ltlv)
local lt_str=''
if p1~=nil then
lt_str=FMT.fmt('{0}{1}层',n1,p1)
else
lt_str=n1
end
local state_state_str=lt_str














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






if UIDiscipleModel:getDiscipleSpecialityByID(guid,DISCIPLE_SPECIALITY_TYPE.eXX,1,false)then
local speCfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eXX,1)
speCfg.specialitytype=speCfg.typo
table.insert(data.build_effects,speCfg)
end
discipleSelectController.refreshSpeciality(item,index,data.build_effects,self.onDescSlotClick)


local checkCurrent=data.checkCurrent
item:SetChildActive(item_cmp_index_.icon_cursign,checkCurrent)


discipleSelectController.refreshChuiWei(item,guid)

local checkChuiWei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
local showState=not data.canSelect
local showGray=showState or checkChuiWei
item:SetChildImageExGray(item_cmp_index_.img_color,showGray)
item:SetChildCaptureImageGray(item_cmp_index_.icon_head,showGray)
if checkChuiWei then
item:SetChildGraphicGray(item_cmp_index_.chuiweiBack,showGray)
item:SetChildGraphicGray(item_cmp_index_.chuiweiImg,showGray)
end
item:SetChildActive(item_cmp_index_.stateObj,showState)
if showState then
if data.canSelect then
item:SetChildText(item_cmp_index_.stateName,UIDiscipleModel:getDiscipleStateDesc(guid,' '))
else
if data.reason==1 then
item:SetChildText(item_cmp_index_.stateName,'境界过低')
elseif data.reason==2 then
item:SetChildText(item_cmp_index_.stateName,'炼体过低')
elseif data.reason==3 then
item:SetChildText(item_cmp_index_.stateName,'境界过高')
elseif data.reason==4 then
item:SetChildText(item_cmp_index_.stateName,'炼体过高')
elseif data.reason==5 then
item:SetChildText(item_cmp_index_.stateName,'无法调换')
elseif data.reason==6 then
item:SetChildText(item_cmp_index_.stateName,'拥有道劫')
elseif data.reason==7 then
item:SetChildText(item_cmp_index_.stateName,'拥有思绪')
elseif data.reason==-1 then
item:SetChildText(item_cmp_index_.stateName,'派遣中')
end
end
end
item:SetChildActive(item_cmp_index_.jiuzhiBtn,false)
item:SetChildActive(item_cmp_index_.xiangxi,true)
item:SetChildLocalPosX(item_cmp_index_.xiangxi,200)
item:SetChildScale(item_cmp_index_.xiangxi,Vector3(0.9,0.9,1))
item:SetChildButtonClick(item_cmp_index_.xiangxi,function()
local dzList=self:getDiscipleGuidList()
otherPlayerController:openSelfPlayerDZInfoWin(dzList,dzList[index])
end)

local isLDLock=UIDiscipleModel:checkDZClientState(guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
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
item:SetChildActive(item_cmp_index_.spDzFlag,isSpDz)
end

function UIMDiscipleSelect_chuangongge:getDiscipleGuidList()
local list={}
for i,v in ipairs(self.disciplelist)do
table.insert(list,v.disciple.discipleguid)
end
return list
end

function UIMDiscipleSelect_chuangongge.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end


local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)

UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_chuangongge:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_chuangongge:onClickItem(index)
if self.select_index==index then return end









local isLDLock=UIDiscipleModel:checkDZClientState(self.disciplelist[index].disciple.discipleguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
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

function UIMDiscipleSelect_chuangongge:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local checkCurrent=data.checkCurrent
self.btnFire:setActive(checkCurrent)
self.btnWork:setActive(not checkCurrent)
self.txtWork:setText(discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)and'安排'or'替换')
self.txtFire:setText('卸任')
else
self.btnFire:setActive(isshow)
self.btnWork:setActive(isshow)
end
end


function UIMDiscipleSelect_chuangongge:OnEnable()

end


function UIMDiscipleSelect_chuangongge:OnDisable()

end


function UIMDiscipleSelect_chuangongge:refreshSelecetTypeList()
local selectTypeIdx=self.selectTypeIdx or 1
local num=#typeList
self.selectType:setChildLayoutGroupCreateItems(num)
local gridlist=self.selectType:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
discipleSelectController.refreshSelectTypeListItem(item,i,typeList[i],i==selectTypeIdx,self.onClickSelectTypeItem)
end
self.onClickSelectTypeItem(selectTypeIdx)
end

function UIMDiscipleSelect_chuangongge.onClickSelectTypeItem(index)
if _this.selectTypeIdx then
local lastItem=_this.selectType:getChildLayoutGroupGridItem(_this.selectTypeIdx-1)
discipleSelectController.refreshSelectTypeListItemSelect(lastItem,false)
end
_this.selectTypeIdx=index
local item=_this.selectType:getChildLayoutGroupGridItem(index-1)
discipleSelectController.refreshSelectTypeListItemSelect(item,true)
if index==typeIndex.jingjie then
_this:refreshScrollView(2)
elseif index==typeIndex.lianti then
_this:refreshScrollView(3)
end
_this:onClickItem(1)
end

function UIMDiscipleSelect_chuangongge:getLevelDesc(guid,level_fmt,level_title_str,level_level_str,level_effect_str)
local defaultStr=FMT.fmt(level_fmt,level_title_str,level_level_str,level_effect_str)
local desc_str_1=''



















desc_str_1=defaultStr

return desc_str_1
end

function UIMDiscipleSelect_chuangongge:getShangDaoAddRate(guid,level)
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

function UIMDiscipleSelect_chuangongge:getCongHuiAddRate(guid)
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

function UIMDiscipleSelect_chuangongge:getMeiLiAddRate(guid)
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



function UIMDiscipleSelect_chuangongge:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_chuangongge:onBtnWork()













































local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
if self.dztype==1 then
local hasOrder=UIDiscipleModel:checkDZHasOrder(guid)
if hasOrder then
UIManager.error("关注的弟子不可传功")
return
end
end

if UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)then
UIManager.error('弟子垂危')
return
end
local isLDLock=UIDiscipleModel:checkDZClientState(guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end

if UIDiscipleModel:checkDiscipleXianMoVoc(guid)then
local showdata=
{
type='UIDialouge',
title='提示',
content='弟子已完成转职，传功将自动斩念重修并重置问心关，返回所有材料与75%的传道点数与仙魔气，是否继续传功？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
if self:checkSelect(guid,true)then
self.callback(guid)
self.parentWin:closeSelf()
end
end,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
return
else
local curID=WenXinGuanModel:getDtDzGuid()

if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie3)and not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
if curID==guid then
UIManager.error('九重天劫期间，参与问心关的弟子无法传功')
return
elseif WenXinGuanModel:checkDzWXGState(guid)then
UIManager.error('九重天劫期间，完成问心关的弟子无法传功')
return
end
else
if curID==guid or WenXinGuanModel:checkDzWXGState(guid)then
local showdata=
{
type='UIDialouge',
title='提示',
content='弟子参与了问心关，传功将清除问心关状态并返回所有材料和75%传道点数，是否继续？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
if self:checkSelect(guid,true)then
self.callback(guid)
self.parentWin:closeSelf()
end
end,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
return
end
end
end

if self:checkSelect(guid,true)then
self.callback(guid)
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_chuangongge:checkSelect(dzId,wraning)
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

function UIMDiscipleSelect_chuangongge:checkSelectWithDZID(selDZ,cmpDZ,wraning)
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

function UIMDiscipleSelect_chuangongge:onBtnFire()







self.callback(self.dzIdStr)
self.parentWin:closeSelf()
end

function UIMDiscipleSelect_chuangongge.on_building_event(etype,sfId,ubdId,dzId,olddzId)
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

function UIMDiscipleSelect_chuangongge:onSearchBtn()
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

function UIMDiscipleSelect_chuangongge:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_chuangongge:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_chuangongge:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_chuangongge:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end