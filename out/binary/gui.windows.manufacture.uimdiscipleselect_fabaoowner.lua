







def_class("UIMDiscipleSelect_fabaoOwner",UIMDiscipleSelect)























local _level_fmt='{0}：<color=#171311>{1}</color>'

function UIMDiscipleSelect_fabaoOwner:onLoaded(...)
self:bindComponents()
local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end

function UIMDiscipleSelect_fabaoOwner:__delete()
self:unbindComponents()
end

function UIMDiscipleSelect_fabaoOwner:onShow(argtable,afterOnloaded)
self.args=argtable
self.callback=argtable.callback
self.dzguid=argtable.dzguid
self.parentWin=argtable.parentWin
self:refreshView()
if argtable.canvasIdx then
self:setCanvasIndex(-1,argtable.canvasIdx)
end
end

function UIMDiscipleSelect_fabaoOwner:onHide()

end




function UIMDiscipleSelect_fabaoOwner:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_fabaoOwner:getNetDataList()
local list=UIDiscipleModel:getSortList()
local dzguid=self.dzguid
local has=false
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
has=has or tostring(v[1].discipleguid)==tostring(dzguid)
end
end
end
if not has then
self.dzguid=nil
self.select_index=nil
end
return temp
else
return list
end
end

function UIMDiscipleSelect_fabaoOwner:initDiscipleList()
local temp=self:getNetDataList()
local list={}
for i,data in ipairs(temp)do
local guid=data.discipleguid
local chuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
if not chuiwei then
list[#list+1]=data
end
end
local sortTag={}
for i,v in ipairs(list)do
sortTag[v.discipleguid]=UIDiscipleModel:getDiscipleFightValue(v.discipleguid)*100+i
end

table.sort(list,function(a,b)
return sortTag[a.discipleguid]>sortTag[b.discipleguid]
end)

if self.dzguid and self.select_index==nil then
for i,v in ipairs(list)do
if tostring(v.discipleguid)==tostring(self.dzguid)then
self.select_index=i
break
end
end
end

self.disciplelist=list
local len=#list
if self.dzguid==nil and len>0 then
self.dzguid=list[1].discipleguid
self.select_index=1
end

end

function UIMDiscipleSelect_fabaoOwner:refreshScrollView()
self:initDiscipleList()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
if self and not self.isClose then
self:refreshItem(id,item)
end
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()
end

function UIMDiscipleSelect_fabaoOwner:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local dzguid=data.discipleguid
local item_cmp_index_=discipleSelectController.item_cmp_index

discipleSelectController.refreshItemHead(item,dzguid)

local isSelect=self.select_index==index
item:SetChildActive(item_cmp_index_.img_select,isSelect)
item:SetChildActive(item_cmp_index_.icon_cursign,isSelect)

local level_level_str=UIDiscipleModel:getJJNameEx(data.jingjielv)
local desc1=FMT.fmt(_level_fmt,'境界',level_level_str)

local jy_level_str=UIDiscipleModel:getLTNameEx(data.liantilv)
local desc2=FMT.fmt(_level_fmt,'炼体',jy_level_str)

discipleSelectController.refreshDesc(item,desc1,desc2)

local jobicon=UIDiscipleModel:getJobIconNameX(dzguid)
item:SetChildActive(item_cmp_index_.dis_job,true)
item:SetChildCSImageSprite(item_cmp_index_.dis_job,globalABLookup.global,jobicon)

local fight_str=FMT.fmt('<color=#7d3b17>战</color> {0}',UIDiscipleModel:getDiscipleFightValue(dzguid))
item:SetChildText(item_cmp_index_.fightTxt,fight_str)
end

function UIMDiscipleSelect_fabaoOwner:refreshSelect(index,flag)
if index==nil then return end
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
item:SetChildActive(item_cmp_index_.icon_cursign,flag)
end

function UIMDiscipleSelect_fabaoOwner:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.dzguid=self.disciplelist[self.select_index].discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_fabaoOwner:refreshButtons()
local c=#self.disciplelist
if c>0 then
self.btnFire:setActive(false)
self.btnWork:setActive(true)
self.txtWork:setText(self.dzguid and'选择'or'更换')
self.btnFire:setActive(false)
else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end


function UIMDiscipleSelect_fabaoOwner:OnEnable()

end


function UIMDiscipleSelect_fabaoOwner:OnDisable()

end



function UIMDiscipleSelect_fabaoOwner:onClickClose()
if not self.wait_replace_building_mgr then
self.parentWin:closeSelf()
end
end

function UIMDiscipleSelect_fabaoOwner:onBtnWork()
self.callback(self.dzguid)
self.parentWin:closeSelf()
end


function UIMDiscipleSelect_fabaoOwner:onSearchBtn()
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

function UIMDiscipleSelect_fabaoOwner:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_fabaoOwner:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_fabaoOwner:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_fabaoOwner:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end
