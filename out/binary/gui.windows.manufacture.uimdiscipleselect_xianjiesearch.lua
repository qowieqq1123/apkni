







def_class("UIMDiscipleSelect_xianjieSearch",UIMDiscipleSelect)





















local _this
local level_fmt='{0}：<color=#171311>{1}</color>'


function UIMDiscipleSelect_xianjieSearch:onLoaded(...)
_this=self
self:bindComponents()

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setActive(false)
end


function UIMDiscipleSelect_xianjieSearch:__delete()
_this=nil
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
end


function UIMDiscipleSelect_xianjieSearch:onHide()

end




function UIMDiscipleSelect_xianjieSearch:onShow(argtable,afterOnloaded)
self.args=argtable
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.cloudid=argtable.cloudid

self.dzIdStr=nil
if self.args.select_dis then
self.dzIdStr=tostring(self.args.select_dis)
end

self.select_index=nil
self.select_dz=nil
if afterOnloaded then
local condtypelist={}
local condlist=cfgHelper.get2(cfg_fairylandcloudconfig_get,self.cloudid,'disciple')
if condlist then
for i=1,2 do
local cnd=condlist[i]
if cnd and cnd[1]==1 then
table.insert(condtypelist,cnd[2])
end
end
self:showWindow('UIMDiscipleSelect_xianjieSearchEx',{cloudid=self.cloudid})
end
if#condtypelist<=0 then
table.insert(condtypelist,eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_JINGJIE)
end
self.condtypelist=condtypelist
end
self:refreshView()
end

function UIMDiscipleSelect_xianjieSearch:refreshView()
self:refreshScrollView()
self:refreshButtons()
local c=#self.disciplelist
local noTips=c<=0
self.emptyPart:setActive(noTips)
if noTips then
local str='暂无可派遣的弟子'
self.emptyTip:setText(str)
end
end

function UIMDiscipleSelect_xianjieSearch:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_xianjieSearch:getNetDataList()
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

function UIMDiscipleSelect_xianjieSearch:initDiscipleList()
self.disciplelist={}
local condtypelist=self.condtypelist
local list=self:getNetDataList()
local cloudid=self.cloudid
for i,data in pairs(list)do
local guid=data.discipleguid
local check=xianjieController:checkSeardCloudSelectDZ(cloudid,guid)
if check then
local locData={}
locData.disciple=data
local checkCurrent=data.discipleguidStr==self.dzIdStr
locData.checkCurrent=checkCurrent
local stateType,stateName=xianjieModel:getDZState(guid,true)
locData.stateName=stateName
locData.checkFlag=not UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)

local cndType=condtypelist[1]
locData.value1=eSpecialAttrFunc:getValue(cndType,guid)

cndType=condtypelist[2]
if cndType then
locData.value2=eSpecialAttrFunc:getValue(cndType,guid)
else
locData.value2=0
end

local sorts={}
locData.sorts=sorts
local stateWeight=locData.checkFlag and 1 or 0



local build_effects={}
locData.build_effects=build_effects
locData.effectnum=#build_effects

sorts[1]=stateName and 0 or 1
sorts[2]=checkCurrent and 1 or 0
sorts[3]=stateWeight
sorts[4]=locData.value1
sorts[5]=locData.value2
sorts[6]=UIDiscipleModel:getDiscipleColor(guid)

table.insert(self.disciplelist,locData)
end
end
end

function UIMDiscipleSelect_xianjieSearch:refreshScrollView()
self:initDiscipleList()
self.tuijian_dizi_str=nil
mathHelper.sortWeightList(self.disciplelist)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_xianjieSearch:checkRecommend(guid_str)
return self.tuijian_dizi_str==guid_str
end

function UIMDiscipleSelect_xianjieSearch:refreshItem(id,item)
local index=id+1
local locData=self.disciplelist[index]
local disdata=locData.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index

discipleSelectController.refreshItemHead(item,guid)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)


local desc_str_1,desc_str_2
local condtypelist=self.condtypelist

local cndType=condtypelist[1]
desc_str_1=FMT.fmt(level_fmt,eSpecialAttrName:getName(cndType),eSpecialAttrFunc:getValueStr(cndType,guid,locData.value1))

cndType=condtypelist[2]
if cndType then
desc_str_2=FMT.fmt(level_fmt,eSpecialAttrName:getName(cndType),eSpecialAttrFunc:getValueStr(cndType,guid,locData.value2))
else
desc_str_2=nil
end

discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2)


local istuijian=self:checkRecommend(disdata.discipleguidStr)
discipleSelectController.refreshSign(item,istuijian,guid)


discipleSelectController.refreshSpeciality(item,index,locData.build_effects,self.onDescSlotClick)


local isCurrent=disdata.discipleguidStr==self.dzIdStr
item:SetChildActive(item_cmp_index_.icon_cursign,isCurrent)


discipleSelectController.refreshChuiWei(item,guid)

local gray=not locData.checkFlag or locData.stateName~=nil
item:SetChildImageExGray(item_cmp_index_.img_color,gray)
item:SetChildCaptureImageGray(item_cmp_index_.icon_head,gray)

item:SetChildActive(item_cmp_index_.stateObj,false)
if locData.stateName==nil then
item:SetChildText(item_cmp_index_.stateName,UIDiscipleModel:getDiscipleStateDesc(guid,'',nil,'暂无居所'))
else
item:SetChildText(item_cmp_index_.stateName,locData.stateName)
end
end

function UIMDiscipleSelect_xianjieSearch.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local locData=_this.disciplelist[disIdx]
local effects=locData.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=locData.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_xianjieSearch:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_xianjieSearch:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
end

function UIMDiscipleSelect_xianjieSearch:refreshButtons()
local c=#self.disciplelist
local has=c>0
self.btnWork:setActive(has)
self.btnFire:setActive(false)
if has then
self.txtWork:setText('派遣')
end
end

function UIMDiscipleSelect_xianjieSearch:onClickClose()
self.parentWin:closeSelf()
end

function UIMDiscipleSelect_xianjieSearch:onBtnWork()
if self.select_index then
local locData=self.disciplelist[self.select_index]
local disdata=locData.disciple
local guid=disdata.discipleguid
local checkCurrent=locData.checkCurrent
if checkCurrent then


else

if locData.stateName~=nil then
local str=FMT.fmt('该弟子正在{0}，请师尊安排其他弟子',locData.stateName)
UIManager.error(str)
else
local flag=self.callback(guid)
if flag then
self:onClickClose()
end
end



end
else

UIManager.error(cfgHelper.getlang('disciple_select_tips_5'))
end
end

function UIMDiscipleSelect_xianjieSearch:onBtnFire()

end