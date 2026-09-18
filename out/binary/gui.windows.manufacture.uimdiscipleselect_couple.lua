







def_class("UIMDiscipleSelect_couple",UIMDiscipleSelect)























local _this

function UIMDiscipleSelect_couple:onLoaded(...)
self:bindComponents()
_this=self
local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_couple:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end




function UIMDiscipleSelect_couple:onShow(argtable,afterOnloaded)
self.args=argtable
self.openType=argtable.openType
self.callback=argtable.callback
self.sex=argtable.sex
self.parentWin=argtable.parentWin
self.otherGuid=argtable.otherGuid
local canvasIdx=argtable.canvasIdx
if canvasIdx then
self:setCanvasIndex(-1,canvasIdx)
end
self.txtWork:setText('确定')
self:refreshView()
end

function UIMDiscipleSelect_couple:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_couple:getNetDataList()
local selectFunc=function(netData)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)or{}
if imageInfo.sex~=_this.sex then
return false
end
local guid=netData.discipleguid
if UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)then
return false
end
return true
end
local list=UIDiscipleModel:getSortList(selectFunc)
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




function UIMDiscipleSelect_couple:initDiscipleList()
self.disciplelist={}
local list=self:getNetDataList()

for k,data in ipairs(list)do
local guid=data.discipleguid
local temp={}
local sorts={}
temp.sorts=sorts
temp.disciple=data

local isValid,validCode=DiscipleCoupleModel:checkSingleDiscipleCoupleValid(guid,false)
if not isValid then
temp.validCode=validCode
end

sorts[1]=isValid and 1 or 0
sorts[2]=data.jingjielv
sorts[3]=UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)



table.insert(self.disciplelist,temp)

end
end

function UIMDiscipleSelect_couple:reSelectDisciple(default_idx)
default_idx=default_idx or 1
local dzNum=#self.disciplelist
if dzNum>0 then
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

function UIMDiscipleSelect_couple:refreshScrollView()
self:initDiscipleList()
mathHelper.sortWeightList(self.disciplelist)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_couple:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index

discipleSelectController.refreshItemHead(item,guid)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)

if self.args.exInfoFunc then
local text1,text2=self.args.exInfoFunc(disdata)
item:SetChildText(item_cmp_index_.ex_info,text1)

if text2 then
item:SetChildActive(item_cmp_index_.exx_info_root,true)
item:SetChildText(item_cmp_index_.exx_info,text2)
else
item:SetChildActive(item_cmp_index_.exx_info_root,false)
end
else
item:SetChildText(item_cmp_index_.ex_info,'')
end
local desc1=FMT.fmt('境界：<color=#171311>{0}</color>',UIDiscipleModel:getJJNameEx(disdata.jingjielv))
local desc2=FMT.fmt('魅力：<color=#171311>{0}</color>',UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi))
local desc3=nil
local desc4=nil
local stand=cfgHelper.get2(cfg_disciplestandconfig_get,disdata.stand,'name')
if self.otherGuid then
local releationValue=UIDiscipleModel:getReleationValue(guid,self.otherGuid,DISCIPLE_RELATION_TYPE.eFriend)
local releationType,releationStr=UIDiscipleModel:getRelationChildType(DISCIPLE_RELATION_TYPE.eFriend,releationValue)
if releationType~=0 then
desc3=FMT.fmt('关系：<color=#171311>{0}</color>',releationStr)
desc4=FMT.fmt('立场：<color=#171311>{0}</color>',stand)
else
desc3=FMT.fmt('立场：<color=#171311>{0}</color>',stand)
end
else
desc3=FMT.fmt('立场：<color=#171311>{0}</color>',stand)
end
discipleSelectController.refreshDesc(item,desc1,desc2,desc3,desc4)

local validCode=data.validCode
if validCode then
item:SetChildActive(item_cmp_index_.blackRoot,true)
local blackTxStr=""
if validCode==1 then
blackTxStr="该弟子已有道侣"
elseif validCode==2 then
blackTxStr="该弟子职业不符合"
elseif validCode==3 then
blackTxStr="该弟子为庶务弟子"
elseif validCode==4 then
blackTxStr="该弟子境界等级不足"
elseif validCode==5 then
blackTxStr="该弟子不能结为道侣"
elseif validCode==6 then
blackTxStr="该弟子不接受道侣"
end
item:SetChildText(item_cmp_index_.blackTx,blackTxStr)
else
item:SetChildActive(item_cmp_index_.blackRoot,false)
end



end

function UIMDiscipleSelect_couple:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_couple:onClickItem(index)
if self.select_index==index then return end
if self.disciplelist[index].validCode then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_couple:refreshButtons()
local c=#self.disciplelist
if c>0 then
self.btnWork:setActive(true)
else
self.btnWork:setActive(false)
end
end

function UIMDiscipleSelect_couple:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_couple:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_couple:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_couple:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_couple:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
if data.validCode then
return
end
local disdata=data.disciple
if self.callback then
self.callback(disdata.discipleguid)
self:onClickClose()
else
logErr("缺少callback 回调方法")
end
else
UIManager.error(cfgHelper.getlang('disciple_select_tips_5'))
end
end

function UIMDiscipleSelect_couple:onClickClose()
self.parentWin:closeSelf()
end

function UIMDiscipleSelect_couple:onSearchBtn()
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
