







def_class("UIMDiscipleSelect_jctjFeiSheng",UIMDiscipleSelect)























local _this
local _insert=table.insert

function UIMDiscipleSelect_jctjFeiSheng:onLoaded(...)
_this=self
self:bindComponents()
local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIMDiscipleSelect_jctjFeiSheng:__delete()
self:unbindComponents()
_this=nil
end




function UIMDiscipleSelect_jctjFeiSheng:onShow(argtable,afterOnloaded)
self.args=argtable
self.openType=argtable.openType
self.callback=argtable.callback
self.parentWin=argtable.parentWin

self.select_index=nil
self.select_dz=nil

self.dzIdStr=nil

self:refreshView()

self.filterTip:setText("已完成<color=#CA631D>红尘劫、问心关且渡劫圆满弟子</color>弟子方可渡劫飞升")
self.filterTip:setActive(true)
self.searchInput:setActive(false)
end


function UIMDiscipleSelect_jctjFeiSheng:onHide()

end

function UIMDiscipleSelect_jctjFeiSheng:refreshView()
self:refreshScrollView()
self:refreshButtons()
end

function UIMDiscipleSelect_jctjFeiSheng:reSelectDisciple(default_idx)
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

function UIMDiscipleSelect_jctjFeiSheng:getNetDataList()
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






function UIMDiscipleSelect_jctjFeiSheng:initDiscipleList()


self.disciplelist={}
local list=self:getNetDataList()

local cfg=cfgHelper.get(cfg_jctjbaseconfig_get,1,"disciple")
local needLv=90
if cfg then
needLv=cfg[1]
end

for i,data in ipairs(list)do
local locData={}
locData.disciple=data
local guid=data.discipleguid

local checkCurrent=data.discipleguidStr==self.dzIdStr


local fight=UIDiscipleModel:getDiscipleFightValue(guid)
locData.fight=fight


local isFinishHong=WenXinGuanModel:judgeIsCanEnter(guid)

local isFinishWen=WenXinGuanModel:checkDzWXGState(guid)



local sorts={}
locData.sorts=sorts

sorts[1]=checkCurrent==true and 1 or 0
sorts[2]=fight
sorts[3]=UIDiscipleModel:getDiscipleColor(guid)
sorts[4]=guid


if isFinishHong and isFinishWen and data.jingjielv>=needLv then
local flag=true
if data.jingjielv==needLv then
local jjlv,point,curjjexp,nxjjexp=UIDiscipleModel:getDiscipleJJLevelAndPoint2(guid)
if curjjexp<nxjjexp then
flag=false
end
end
if flag then
_insert(self.disciplelist,locData)
end
end
end

self.check_tuijian=true
self.tuijian_dizi_str=nil
end

function UIMDiscipleSelect_jctjFeiSheng:refreshItem(id,item)
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

local fight_str=FMT.fmt('<color=#7d3b17>战力：</color>{0}',mathHelper.formatNumber(data.fight))
item:SetChildText(item_cmp_index_.fightTxt,fight_str)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)

UIDiscipleModel:setDiscipleXianMoBackImage(item,item_cmp_index_.img_xianmo,disdata)


local desc_str_1=nil
local desc_str_2=nil
local desc_str_3=nil
discipleSelectController.refreshDesc(item,desc_str_1,desc_str_2,desc_str_3)

item:SetChildText(item_cmp_index_.txt_tips,"\n\n\n\n境界：已渡劫圆满\n\n红尘劫：已完成历练\n\n问心关：已明悟己心")



local isCurrent=disdata.discipleguidStr==self.dzIdStr
item:SetChildActive(item_cmp_index_.icon_cursign,isCurrent)








end

function UIMDiscipleSelect_jctjFeiSheng:refreshScrollView()
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

function UIMDiscipleSelect_jctjFeiSheng:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local isCurrent=data.disciple.discipleguidStr==self.dzIdStr
self.btnFire:setActive(isCurrent)
self.btnWork:setActive(not isCurrent)
self.txtWork:setText('选择')
self.txtFire:setText('移除')
else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end

function UIMDiscipleSelect_jctjFeiSheng.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_jctjFeiSheng:refreshSelect(index,flag)
local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_jctjFeiSheng:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
self:refreshSelect(old,false)
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_jctjFeiSheng:onClickClose()
self.parentWin:closeSelf()
end

function UIMDiscipleSelect_jctjFeiSheng:onBtnWork()
if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local guid=disdata.discipleguid
self.callback(guid)
self:onClickClose()
else

end
end

function UIMDiscipleSelect_jctjFeiSheng:onBtnFire()
if not discipleSelectController.isDiziEmptyOrNil(self.dzIdStr)then
self.callback(0)
self:onClickClose()
else

UIManager.error('该位置并未安排弟子')
end
end

function UIMDiscipleSelect_jctjFeiSheng:onSearchBtn()
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

function UIMDiscipleSelect_jctjFeiSheng:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_jctjFeiSheng:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_jctjFeiSheng:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_jctjFeiSheng:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end


