







def_class("UIMDiscipleSelect_houshanjindi",UIMDiscipleSelect)





















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local level_fmt='{0}：<color=#171311>{1}</color>'
local state_fmt='{0}：{1}'

local get_desc={

[1]=function(discipleguid,cfg,param1)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(discipleguid)
local str=UIDiscipleModel.getJJNameCommon(jjlv,1)
return FMT.fmt("境界：<color=#171311>{0}</color>",str)
end,

[2]=function(discipleguid,cfg,param1)
local ltlv=UIDiscipleModel:getDiscipleLTLevel(discipleguid)
local str=UIDiscipleModel.getLTNameCommon(ltlv,1)
return FMT.fmt("炼体：<color=#171311>{0}</color>",str)
end,

[3]=function(discipleguid,cfg,param1)
local value=UIDiscipleModel:getDiscipleShouYuan(discipleguid)
value=UIDiscipleModel:getDiscipleShouYuanDescX(value)
return FMT.fmt("寿元：<color=#171311>{0}</color>",value)
end,

[4]=function(discipleguid,cfg,param1)
local value=UIDiscipleModel:getDiscipleInjury(discipleguid)

return FMT.fmt("负伤值：<color=#171311>{0}</color>",value)
end,

[5]=function(discipleguid,cfg,param1)
local name=UIDiscipleModel:discipleBaseAttrName(param1)
local value=UIDiscipleModel:getDiscipleBaseAttr(discipleguid,param1)
return FMT.fmt("{1}：<color=#171311>{0}</color>",value,name)
end,

[6]=function(discipleguid,id,param1)
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,param1,"name")
local value=UIDiscipleModel:getDiscipleJobLevel(discipleguid,param1)
return FMT.fmt("{1}：<color=#171311>{0}</color>",value,name)
end,

[7]=function(discipleguid,cfg,param1)
local jjRateList=UIDiscipleModel:getDuJieDanRate(discipleguid)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(discipleguid)
local floor=UIDiscipleModel:getJJFloor(jjlv)
local floorcfg=cfgHelper.getdef1(cfg_disciplejingjieconfig,'floor')
local offsetRate=floorcfg[floor][8]
local baseRate=FeiShengTaiModel.getSuccessRate(floor)+jjRateList[1]+offsetRate
local jdRate=jjRateList[4]or 0
local rate=jdRate+baseRate
rate=Mathf.Clamp(rate,0,100)

local desc
if jdRate>0 then
desc=FMT.fmt("基础成功率：<color=#171311>{0}%</color><color=#549327>(+{1}%)</color>",rate,jdRate)
else
desc=FMT.fmt("基础成功率：<color=#171311>{0}%</color>",rate)
end
return desc
end,

[8]=function(discipleguid,cfg,param1)
local cfg=cfg_discipleproskillconfig()
local max=nil
for id,config in pairs(cfg)do
local level=UIDiscipleModel:getDiscipleJobLevel(discipleguid,id)
if max then
if level>max[2]then
max={id,level}
end
else
max={id,level}
end
end
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,max[1],"name")
local value=max[2]
return FMT.fmt("{1}：<color=#171311>{0}</color>",value,name)
end,
}




function UIMDiscipleSelect_houshanjindi:onLoaded(...)
self:bindComponents()
_this=self

self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setActive(true)
self.selectType:setActive(false)
self.condition:setActive(false)
self.btnFire:setActive(false)
self.check1:setSprite(globalABLookup.global,"icon_gantanhao_1")
self.txtWork:setText("派遣弟子")
end


function UIMDiscipleSelect_houshanjindi:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end




function UIMDiscipleSelect_houshanjindi:onShow(argtable,afterOnloaded)
self.args=argtable
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin

self.cfg=cfgHelper.get1(cfg_backmountainareaconfig_get,argtable.cfgId)

self.select_dz=argtable.select
self.select_index=nil


self:refreshView()
end


function UIMDiscipleSelect_houshanjindi:onHide()
self.nameSearchList=nil

end



function UIMDiscipleSelect_houshanjindi:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_houshanjindi:initDiscipleList()
self.disciplelist={}
local list=self:getNetDataList()
for i,data in pairs(list)do
local guid=data.netData.net.discipleguid
if not self.cfg.notShuWu or not UIDiscipleModel:isShuWuDiscipleEx(guid)then
local locData={}
locData.disciple=data.netData.net

local sorts={}
locData.sorts=sorts
sorts[1]=self.select_dz==guid and 1 or 0
sorts[2]=self:getDiscipleSpeSort(guid,self.cfg.sortsSpe)
sorts[3]=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)and 0 or 1
sorts[4]=UIDiscipleModel:getDiscipleBaseAttr(guid,self.cfg.attr_id)

table.insert(self.disciplelist,locData)
end
end
end


function UIMDiscipleSelect_houshanjindi:getDiscipleSpeSort(guid,spelist)
if not spelist then
return 0
end
for i,v in ipairs(spelist)do
if UIDiscipleModel:getDiscipleSpecialityByID(guid,v[1],v[2],false)then
return 1
end
end
return 0
end

function UIMDiscipleSelect_houshanjindi:getNetDataList()
local list=UIDiscipleModel:getAllDiscipleData()
if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in pairs(list)do
local netData=v.netData.net
local guid_str=netData.discipleguidStr
local str=self.nameSearchList[guid_str]
if str==nil then
local stateStr=UIDiscipleModel:getDiscipleStateDesc(netData.discipleguid,' ')
str=UIDiscipleModel.getSearchName(guid_str,netData.disciplename,stateStr)
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

function UIMDiscipleSelect_houshanjindi:refreshSelectIndex(isOne)
if isOne then
if self.disciplelist[1]then
self.select_dz=self.disciplelist[1].disciple.discipleguid
else
self.select_dz=nil
end
end
if self.select_dz then
for i,v in ipairs(self.disciplelist)do
if v.disciple.discipleguid==self.select_dz then
self.select_index=i
break
end
end
else
self.select_index=nil
end
end

function UIMDiscipleSelect_houshanjindi:refreshScrollView(isOne)
self:initDiscipleList()
mathHelper.sortWeightList(self.disciplelist)
self:refreshSelectIndex(isOne)
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_houshanjindi:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index

discipleSelectController.refreshItemHead(item,guid)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)



if self.cfg.selectAttr then
local desc_str={}
local ex_str=nil
for i,v in ipairs(self.cfg.selectAttr)do
local t=v[1]
local p1=v[2]
local f=get_desc[t]
local desc=nil
local ex=nil
if f then
desc,ex=f(guid,self.cfg,p1)
if ex then
ex_str=ex
end
end
desc_str[i]=desc
end
discipleSelectController.refreshDesc(item,desc_str[1],desc_str[2],desc_str[3])
if ex_str then
item:SetChildText(item_cmp_index_.ex_info,ex_str)
end
end


local isCurrent=self.select_dz==guid
item:SetChildActive(item_cmp_index_.icon_cursign,isCurrent)


discipleSelectController.refreshChuiWei(item,guid)

if self.cfg.selectSpe then
data.effects={}
for i,v in ipairs(self.cfg.selectSpe)do
if UIDiscipleModel:getDiscipleSpecialityByID(guid,v[1],v[2],false)then
local speCfg=UIDiscipleModel:getSpecialityConfig(v[1],v[2])
speCfg.specialitytype=speCfg.typo
table.insert(data.effects,speCfg)
end
end
discipleSelectController.refreshSpeciality(item,index,data.effects,self.onDescSlotClick)
end


local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(item_cmp_index_.dis_job,globalABLookup.global,jobicon)
item:SetChildActive(item_cmp_index_.dis_job,true)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(item_cmp_index_.spDzFlag,isSpDz)
end

function UIMDiscipleSelect_houshanjindi.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_houshanjindi:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_houshanjindi:onClickItem(index)
if self.select_index==index then return end
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
if UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)then
UIManager.error("弟子垂危无法派遣")
return
end

if self.select_index then
self:refreshSelect(self.select_index,false)
end
self.select_index=index
self.select_dz=guid
self:refreshSelect(index,true)
end

function UIMDiscipleSelect_houshanjindi:refreshButtons()
local c=#self.disciplelist
self.btnWork:setActive(c>0)
end

function UIMDiscipleSelect_houshanjindi:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_houshanjindi:onBtnWork()
if self.select_dz then
if not UIDiscipleModel:checkDiscipleState2(self.select_dz,DISCIPLE_STATE_TYPE.eChuiWei)then
local func=function()
_this.callback(_this.cfg.id,_this.select_dz)
_this:onClickClose()
end

local totalCount=UIHuanJingControl:getJDTotalCount(self.cfg.id)
local times=self.cfg.times or 0
local flag=times-totalCount<=1
if flag then
local canMinAttr=true
local attrValue=UIDiscipleModel:getDiscipleBaseAttr(self.select_dz,self.cfg.attr_id)
if self.cfg.speMinAttr~=nil and attrValue<self.cfg.speMinAttr then
canMinAttr=false
end
if not canMinAttr then
local attrName=eSpecialAttrName:getName(self.cfg.attr_id)
local showdata=
{
type='UIDialouge',
title='提 示',
content=FMT.fmt('当前弟子{0}不足{1}，无法获得特质，保底次数不会被消耗，是否继续派遣？',attrName,self.cfg.speMinAttr),
canceltext='取 消',
oktext='继 续',
allowclickBG=true,
okcallback=function(...)
func()
end,

showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
return
end

local specialityList=UIDiscipleModel.getSpecialityList(self.select_dz)
local bodyList=specialityList[DISCIPLE_SPECIALITY_TYPE.eBody]
local notAddbody=bodyList and bodyList.len>0

local hasSpe=false
local hasBody=false
local canAddSpe=false
local isMax=UIDiscipleModel.checkSpecialtyCountMax(DISCIPLE_SPECIALITY_TYPE.eTalent,self.select_dz)
if not isMax then
for i,v in ipairs(self.cfg.jyTips)do
if v.tzlist~=nil and#v.tzlist>0 then
for i1,v1 in ipairs(v.tzlist)do
if not canAddSpe and v1[1]==DISCIPLE_SPECIALITY_TYPE.eTalent then
hasSpe=true
local spe,extraFlag=UIDiscipleModel:getDiscipleSpecialityByID(self.select_dz,v1[1],v1[2],false,true)
if not spe and extraFlag then
canAddSpe=true
end
elseif not hasBody and v1[1]==DISCIPLE_SPECIALITY_TYPE.eBody then
hasBody=true
end
if canAddSpe and hasBody then
break
end
end
end
end
else

for i,v in ipairs(self.cfg.jyTips)do
if v.tzlist~=nil and#v.tzlist>0 then
for i1,v1 in ipairs(v.tzlist)do
if not hasSpe and v1[1]==DISCIPLE_SPECIALITY_TYPE.eTalent then
hasSpe=true
elseif not hasBody and v1[1]==DISCIPLE_SPECIALITY_TYPE.eBody then
hasBody=true
end
if hasSpe and hasBody then
break
end
end
end
end
end


if canAddSpe and hasBody and notAddbody then
local showdata=
{
type='UIDialouge',
title='提 示',
content='当前弟子已有体质，不会获得新体质，是否继续派遣？',
canceltext='取 消',
oktext='继 续',
allowclickBG=true,
okcallback=function(...)
func()
end,

showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
return
end

local flag1=not hasBody and hasSpe and not canAddSpe
local flag2=hasSpe and hasBody and not canAddSpe and notAddbody
if flag1 or flag2 then
local showdata=
{
type='UIDialouge',
title='提 示',
content='弟子已拥有当前禁地所有可获得的特质或拥有特质达到上限，不会获得新的特质，且此次保底会被消耗，是否继续派遣？',
canceltext='取 消',
oktext='继 续',
allowclickBG=true,
okcallback=function(...)
func()
end,

showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
return
end
end
func()
else
UIManager.error("弟子垂危无法派遣")
end
else
UIManager.error("请先选择弟子")
end
end

function UIMDiscipleSelect_houshanjindi:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
self:refreshScrollView(true)
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
UIManager.info('暂无符合条件的弟子')
return
end
self.searchInput:setInputFieldValue('')
self:refreshScrollView(true)
end

function UIMDiscipleSelect_houshanjindi:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshScrollView()
end

function UIMDiscipleSelect_houshanjindi:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_houshanjindi:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_houshanjindi:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end
