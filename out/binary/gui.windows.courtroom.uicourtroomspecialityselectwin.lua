







def_class("UICourtroomSpecialitySelectWin",UIWindowBase)









function UICourtroomSpecialitySelectWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.Condition=UIText.get(self,1)
self.Desc=UIText.get(self,2)
self.descListPanel=UIObject.get(self,3)
self.descListPanel2=UIObject.get(self,4)
self.frame=UIButton.get(self,5)
self.guaipiRoot=UIObject.get(self,6)
self.leftRoot=UIObject.get(self,7)
self.Name=UIText.get(self,8)
self.roleListPanel=UIObject.get(self,9)
self.searchBtn=UIButton.get(self,10)
self.searchCancelBtn=UIButton.get(self,11)
self.searchInput=UIInputField.get(self,12)
self.SelectButton=UIButton.get(self,13)
self.sortTypeMenu=UIDropdown.get(self,14)
self.tianfuRoot=UIObject.get(self,15)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UICourtroomSpecialitySelectWin")end)

self.frame:setButtonClick(function()self:onFrame()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)

self.SelectButton:setButtonClick(function()self:onSelectButton()end)



end


function UICourtroomSpecialitySelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.Condition);self.Condition=nil;
_UIObject_release(self.Desc);self.Desc=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.descListPanel2);self.descListPanel2=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.guaipiRoot);self.guaipiRoot=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.Name);self.Name=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.SelectButton);self.SelectButton=nil;
_UIObject_release(self.sortTypeMenu);self.sortTypeMenu=nil;
_UIObject_release(self.tianfuRoot);self.tianfuRoot=nil;
end


















local _this
local _format=string.format
local _insert=table.insert
local _sort=table.sort

local _sort_type={
eFight=1,
eTalent=2,
eStrange=3,
}

local _sort_type_name={
[_sort_type.eFight]="战力顺序",
[_sort_type.eTalent]="天赋数量顺序",
[_sort_type.eStrange]="怪癖数量顺序",
}

local dzselect_lft_savakey='courtroomSortKey'
local level_fmt='{0}：<color=#171311>{1}</color>'
local state_fmt='{0}：{1}'


function UICourtroomSpecialitySelectWin:onLoaded(...)
self:bindComponents()

_this=self

self.sortTypeMenu:setChangeAction(function(id)
self:onDropDownChange(id)
end)

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)

self.select_index=1

self.searchInput:setChildInputFieldChange(true,function(...)
if _this==nil then return end
_this:onSearchChange(...)
end)
end


function UICourtroomSpecialitySelectWin:__delete()
self:unbindComponents()

_this=nil
end




function UICourtroomSpecialitySelectWin:onShow(argtable,afterOnloaded)
self.args=argtable

self.selectGuid=self.args.guid

self.selectTezhiType=self.args.tezhiType
self.selectTezhiIdx=self.args.tezhiIdx

self.sortTypeMenu:setOption(_sort_type_name)
self.sortType=_sort_type.eFight
self.sortOrder=eSortOrder.eDown



self:onDropDownChange(self.sortType-1)
end

function UICourtroomSpecialitySelectWin:onDropDownChange(id)
self.sortType=id+1

self:refreshDiscipleGrid(self.selectGuid)
end

function UICourtroomSpecialitySelectWin:refreshSpecialityPanel(guid)
self.selectGuid=guid
courtroomModel:recordGuid(self.selectGuid)
local configs=UIDiscipleModel:getDiscipleSpecialityConfig(guid)
local talentList={}
local strangeList={}
local selectIdx=nil
local talentIdx=1
local strangeIdx=1
for _,v in ipairs(configs)do
if v.specialitytype==DISCIPLE_SPECIALITY_TYPE.eTalent then
table.insert(talentList,v)
talentIdx=talentIdx+1
end
if v.specialitytype==DISCIPLE_SPECIALITY_TYPE.eStrange then
table.insert(strangeList,v)
strangeIdx=strangeIdx+1
end
end

self.talentList=talentList
self.strangeList=strangeList

self:refreshTalent()

self:refreshStrange()

if self.selectTezhiIdx then
selectIdx=self.selectTezhiIdx
end

if self.selectTezhiType then
if self.selectTezhiType==DISCIPLE_SPECIALITY_TYPE.eTalent then
self:onZlDescSlotClick(DISCIPLE_SPECIALITY_TYPE.eTalent,selectIdx or 1)
else
self:onZlDescSlotClick(DISCIPLE_SPECIALITY_TYPE.eStrange,selectIdx or 1)
end
self.selectTezhiType=nil
self.selectTezhiId=nil
self.selectTezhiIdx=nil
else
if next(strangeList)then
self:onZlDescSlotClick(DISCIPLE_SPECIALITY_TYPE.eStrange,selectIdx or 1)
else
if next(talentList)then
self:onZlDescSlotClick(DISCIPLE_SPECIALITY_TYPE.eTalent,selectIdx or 1)
end
end
end

end

function UICourtroomSpecialitySelectWin:getDiscipleList()
local list=UIDiscipleModel:getSortList()
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJielu)or{}
if#dis_list>0 then
local ddata=dis_list[1]
self.zlguid=ddata.discipleguid
end
self.disciplelist={}
local disciple
for i,v in ipairs(list)do
disciple=v
local temp=UIDiscipleModel:getDiscipleSpecialityConfigByData(v)
local talentList={}
local strangeList={}
for _,vv in ipairs(temp)do
if vv.specialitytype==DISCIPLE_SPECIALITY_TYPE.eTalent then
table.insert(talentList,vv)
elseif vv.specialitytype==DISCIPLE_SPECIALITY_TYPE.eStrange then
table.insert(strangeList,vv)
end
end
disciple.talentList=talentList
disciple.score_talent=#talentList

disciple.strangeList=strangeList
disciple.score_strange=#strangeList

if disciple.score_talent>0 or disciple.score_strange>0 then
if self.sortType==_sort_type.eFight then

disciple.sorts={UIDiscipleModel:getDiscipleFightValue(v.discipleguid)}
table.insert(self.disciplelist,disciple)

elseif self.sortType==_sort_type.eTalent then

disciple.sorts={disciple.score_talent}
table.insert(self.disciplelist,disciple)

elseif self.sortType==_sort_type.eStrange then

disciple.sorts={disciple.score_strange}
table.insert(self.disciplelist,disciple)

end
end

end

mathHelper.sortWeightList(self.disciplelist,"sorts",1,false,1,self.sortOrder)

if self.inputstr~=nil then
self.disciplelist=self:getSearchDiscipleList()
end
end

function UICourtroomSpecialitySelectWin:onClickSort()
self.sortOrder=not self.sortOrder
self:onDropDownChange(self.sortType-1)
end

function UICourtroomSpecialitySelectWin:getSelectDisciple()
if self.select_index and self.disciplelist then
return self.disciplelist[self.select_index]
end
end

function UICourtroomSpecialitySelectWin:refreshDiscipleGrid(selectGuid)
self:getDiscipleList()

local dataNum=#self.disciplelist
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,3)


local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local netdata=self.disciplelist[i]

local guid=netdata.discipleguid

if guid==selectGuid then
self.select_index=i
end

local item=grids[i-1]

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame2[color])




item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHalf)

local sortVal=netdata.sorts[1]
item:SetChildText(12,sortVal)
if self.sortType==_sort_type.eFight then
item:SetChildText(12,FMT.fmt("战：{0}",sortVal))
elseif self.sortType==_sort_type.eTalent then
item:SetChildText(12,FMT.fmt("天赋数量：{0}",sortVal))
elseif self.sortType==_sort_type.eStrange then
item:SetChildText(12,FMT.fmt("怪癖数量：{0}",sortVal))
end
item:SetChildActive(10,false)
end

self:onClickItem(self.select_index,true)

self.roleListPanel:setChildScrollViewSelectItem(self.select_index-1,true,false,false)
end

function UICourtroomSpecialitySelectWin:refreshDisclpleSelect(idx,isselect)
local item=self.roleListPanel:getChildScrollViewItemWidget(idx-1)
self:refreshDisclpleSelectEx(item,isselect)
end

function UICourtroomSpecialitySelectWin:refreshDisclpleSelectEx(item,isselect)
item:SetChildActive(10,isselect)
end

function UICourtroomSpecialitySelectWin:onClickItem(index,first)
if not first and self.select_index==index then return end
if self.inputstr~=nil then
self.select_index=1
end
local old=self.select_index
self.select_index=index
self:refreshDisclpleSelect(old,false)
self:refreshDisclpleSelect(index,true)

local disciple=self:getSelectDisciple()
if disciple then
local recordSpe=courtroomModel:getRecordSpe(disciple.discipleguid)
if recordSpe then
self.selectTezhiType=recordSpe[1]
self.selectTezhiIdx=recordSpe[2]
end


self:refreshSpecialityPanel(disciple.discipleguid)
end
end

function UICourtroomSpecialitySelectWin:refreshTalent()
local dataNum=#self.talentList
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
self.tianfuRoot:setActive(true)
for i=1,count do
local cfg=self.talentList[i]
local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItemExx(item,cfg)
item:SetChildButtonClick(1,function()
self:onZlDescSlotClick(DISCIPLE_SPECIALITY_TYPE.eTalent,i)
end)
item:SetChildLongTouch(1,i,0.5,function()
self:onDescSlotClick(item,self.selectGuid,cfg)
end)

end
else
self.tianfuRoot:setActive(false)
end
end

function UICourtroomSpecialitySelectWin:refreshStrange()
local dataNum=#self.strangeList
self.descListPanel2:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel2:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
self.guaipiRoot:setActive(true)
for i=1,count do
local cfg=self.strangeList[i]
local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItemExx(item,cfg)
item:SetChildButtonClick(1,function()
self:onZlDescSlotClick(DISCIPLE_SPECIALITY_TYPE.eStrange,i)
end)
item:SetChildLongTouch(1,i,0.5,function()
self:onDescSlotClick(item,self.selectGuid,cfg)
end)
end
else
self.guaipiRoot:setActive(false)
end
end

function UICourtroomSpecialitySelectWin:onZlDescSlotClick(specialityType,idx)

if self.selectType and self.selectIdx then
if self.selectType==DISCIPLE_SPECIALITY_TYPE.eTalent then
local item=self.descListPanel:getChildLayoutGroupGridItem(self.selectIdx-1)
if item then
item:SetChildActive(2,false)
end
elseif self.selectType==DISCIPLE_SPECIALITY_TYPE.eStrange then
local item=self.descListPanel2:getChildLayoutGroupGridItem(self.selectIdx-1)
if item then
item:SetChildActive(2,false)
end
end
end

self.selectType=specialityType
self.selectIdx=idx

courtroomModel:recordSpe(self.selectGuid,self.selectType,self.selectIdx)



local guid
local jjlv=0
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJielu)or{}
if#dis_list>0 then
local ddata=dis_list[1]
guid=ddata.discipleguid
jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
end
self.canSelect=false
self.tipsSelect=nil
if specialityType==DISCIPLE_SPECIALITY_TYPE.eTalent then
local cfg=self.talentList[idx]
self.cfg=cfg
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)
if item then
item:SetChildActive(2,true)
self.Name:setText(cfg.name)
local desc=cfg.effects_desc and FMT.fmt('{0}\n',cfg.effects_desc)or''
local infoStr=zongmenControl:getSpecialityAddDesc(nil,cfg)
self.Desc:setText(FMT.fmt('{0}{1}',desc,infoStr))
local forgetConfig=courtroomModel.getForgetConfig(DISCIPLE_SPECIALITY_TYPE.eTalent,cfg.id)
if forgetConfig then
local str=jjlv>=forgetConfig.jingjie and FMT.cfmt(FONT_COLOR.eGreenColor,'{0}',UIDiscipleModel:getJJNameEx(forgetConfig.jingjie))or FMT.cfmt(FONT_COLOR.eRedColor,'{0}',UIDiscipleModel:getJJNameEx(forgetConfig.jingjie))
self.Condition:setText(FMT.fmt('长老境界要求：{0}',str))
self.canSelect=jjlv>=forgetConfig.jingjie
if not self.canSelect then
self.tipsSelect="长老境界不足"
end
else

self.Condition:setText("此特质无法遗忘")
self.tipsSelect="此特质无法遗忘"
self.canSelect=false
end
end
elseif specialityType==DISCIPLE_SPECIALITY_TYPE.eStrange then
local cfg=self.strangeList[idx]
self.cfg=cfg
local item=self.descListPanel2:getChildLayoutGroupGridItem(idx-1)
if item then
item:SetChildActive(2,true)
self.Name:setText(cfg.name)
local desc=cfg.effects_desc and FMT.fmt('{0}\n',cfg.effects_desc)or''
local infoStr=zongmenControl:getSpecialityAddDesc(nil,cfg)
self.Desc:setText(FMT.fmt('{0}{1}',desc,infoStr))
local forgetConfig=courtroomModel.getForgetConfig(DISCIPLE_SPECIALITY_TYPE.eStrange,cfg.id)
if forgetConfig then
local str=jjlv>=forgetConfig.jingjie and FMT.cfmt(FONT_COLOR.eGreenColor,'{0}',UIDiscipleModel:getJJNameEx(forgetConfig.jingjie))or FMT.cfmt(FONT_COLOR.eRedColor,'{0}',UIDiscipleModel:getJJNameEx(forgetConfig.jingjie))
self.Condition:setText(FMT.fmt('长老境界要求：{0}',str))
self.canSelect=jjlv>=forgetConfig.jingjie
if not self.canSelect then
self.tipsSelect="长老境界不足"
end
else
self.Condition:setText("此特质无法遗忘")
self.tipsSelect="此特质无法遗忘"

self.canSelect=false
end
end
end
self.SelectButton:setButtonEnable(true,not self.canSelect)
end


function UICourtroomSpecialitySelectWin:onHide()

end




function UICourtroomSpecialitySelectWin:onSelectButton()
if self.cfg then

if UIDiscipleModel:checkDisciplePost(self.selectGuid,eZongMenPostType.eZhangMen)then
UIManager.error('掌门乃一宗之主，不接受训诫')
return
end

if self.zlguid==self.selectGuid then
UIManager.error("不能选择律法长老为对象")
return
end

if not self.zlguid then
UIManager.error('请先安排戒律长老')
return
end
if self.canSelect then
UIManager:invokeUIMethod('UICourtroomMainWin','selectDisciple',self.selectGuid)
UIManager:invokeUIMethod('UICourtroomMainWin','refreshTeZhiPanel',self.selectType,self.cfg)
UIManager:closeWindow("UICommonDragonBoneWin")
else
if self.tipsSelect then
UIManager.error(self.tipsSelect)
end
end
else
UIManager.error('需要先选择一项特质')
end
end

function UICourtroomSpecialitySelectWin:onFrame()
UIManager:closeWindow("UICommonDragonBoneWin")
end

function UICourtroomSpecialitySelectWin:onDescSlotClick(item,guid,cfg)
UIFullCourtroomControl:showWindow('UISpecialityWin',{item=item,node='bottom',guid=guid,config=cfg})
end


function UICourtroomSpecialitySelectWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then

self:refreshDiscipleGrid(self.selectGuid)
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
local list=self:getSearchDiscipleList()
if#list<=0 then

UIManager.info('暂无符合条件的弟子')
return
end
local selectDzData=self.disciplelist[self.select_index]
self.select_index=1
if selectDzData then
for index,dzData in ipairs(list)do
if dzData.discipleguidStr==selectDzData.discipleguidStr then
self.select_index=index
break
end
end
end

self.searchInput:setInputFieldValue('')
self:refreshDiscipleGrid(self.selectGuid)

end

function UICourtroomSpecialitySelectWin:onSearchCancelBtn()
if self.inputstr==nil then return end
self.inputstr=nil
self:clearSearchInput()

local list=self:getSearchDiscipleList()
local selectDzData=self.disciplelist[self.select_index]
self.select_index=1
if selectDzData then
for index,dzData in ipairs(list)do
if dzData.discipleguidStr==selectDzData.discipleguidStr then
self.select_index=index
break
end
end
end
self:refreshDiscipleGrid(self.selectGuid)
end

function UICourtroomSpecialitySelectWin:onSearchChange(str)
self:refreshInputBtns(str)
end

function UICourtroomSpecialitySelectWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UICourtroomSpecialitySelectWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function UICourtroomSpecialitySelectWin:getSearchDiscipleList()
local list=UIDiscipleModel:getSortList()
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJielu)or{}
local exincludeGuid
if#dis_list>0 then
local ddata=dis_list[1]
exincludeGuid=ddata.discipleguidStr
end

if self.inputstr~=nil and exincludeGuid~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in ipairs(list)do
local netData=v
local guid_str=netData.discipleguidStr
if exincludeGuid~=guid_str then
local str=self.nameSearchList[guid_str]
if str==nil then
local stateStr=UIDiscipleModel:getDiscipleStateDesc(netData.discipleguid,' ')
str=UIDiscipleModel.getSearchName(guid_str,netData.disciplename,stateStr)
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