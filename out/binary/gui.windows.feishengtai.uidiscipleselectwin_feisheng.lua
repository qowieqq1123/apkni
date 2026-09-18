







def_class("UIDiscipleSelectWin_feisheng",UIWindowBase)









function UIDiscipleSelectWin_feisheng:bindComponents()

self.back=UIObject.get(self,0)
self.closebg=UIButton.get(self,1)
self.closebtn=UIButton.get(self,2)
self.ContentEx=UIObject.get(self,3)
self.discipleNumText=UIText.get(self,4)
self.kickoutBtn=UIButton.get(self,5)
self.kickoutLock=UIObject.get(self,6)
self.noDZTips=UIObject.get(self,7)
self.roleListPanel=UIObject.get(self,8)
self.roleListPanelEx=UIObject.get(self,9)
self.root=UIObject.get(self,10)
self.searchBtn=UIButton.get(self,11)
self.searchCancelBtn=UIButton.get(self,12)
self.searchInput=UIInputField.get(self,13)
self.sortTypeDropdown=UIDropdown.get(self,14)
self.sureBtn=UIButton.get(self,15)
self.title=UIText.get(self,16)

self.closebg:setButtonClick(function()self:onClosebg()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.kickoutBtn:setButtonClick(function()self:onKickoutBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)



end


function UIDiscipleSelectWin_feisheng:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.closebg);self.closebg=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.ContentEx);self.ContentEx=nil;
_UIObject_release(self.discipleNumText);self.discipleNumText=nil;
_UIObject_release(self.kickoutBtn);self.kickoutBtn=nil;
_UIObject_release(self.kickoutLock);self.kickoutLock=nil;
_UIObject_release(self.noDZTips);self.noDZTips=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.roleListPanelEx);self.roleListPanelEx=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.title);self.title=nil;
end


















local _useLoop=api_Available_GetChildLoopTreeView()or false
local _this=nil

function UIDiscipleSelectWin_feisheng:onLoaded(...)
self:bindComponents()
_this=self
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)

if _useLoop then
self.loopTreeView=self.winlua:GetChildUILoopTreeView(self.roleListPanelEx:getID())
self.loopTreeView:SetAction(function(...)
if not self or self.isClose then return end
self:freshLoopAction(...)
end,function()
if not self or self.isClose then return end
self:startLoopAction()
end)
end
end


function UIDiscipleSelectWin_feisheng:__delete()
self:unbindComponents()
end
local body_id={
back=2016,
menu=2017,
}



function UIDiscipleSelectWin_feisheng:onShow(argtable,afterOnloaded)
if argtable then

self.callback=argtable.callback
end
self.sortType=0
self.sortCondition={}
self.back:setChildUIModelShowTarget(body_id.back,1,{},eAnimationID.common_window_enter,false,false,0,nil)
self.sortTypeDropdown:setOption(eDiscipleSortTypeName:getName6List())

self:initDiscipleList()

self:initRoleListPanel()

end


function UIDiscipleSelectWin_feisheng:onHide()

end

function UIDiscipleSelectWin_feisheng:startLoopAction()

end
function UIDiscipleSelectWin_feisheng:onLongClickRoleItem(index)
local locData=self.disciplelist[index]
local netData=locData.disciple
local guid=netData.discipleguid
otherPlayerController:openSelfPlayerDZInfoWin({guid})
end
function UIDiscipleSelectWin_feisheng:freshLoopAction(i,item)
local index=i+1
self:refreshRoleItem(index,item)
end
local cmp=
{
back=0,
dis_name=2,
}
function UIDiscipleSelectWin_feisheng:refreshRoleItem(i,item)
local netdata=self.disciplelist[i]
local netData=netdata.disciple
local guid=netData.discipleguid
local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
local beibu=state==DISCIPLE_STATE_TYPE.eBeiBu

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(29,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,chuiwei,true)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)
item:SetChildLongTouch(-1,i,0.5,function(...)
self:onLongClickRoleItem(i)
end)
local func=function()

if self.nowitem then

self.nowitem:SetChildActive(10,false)
end
self:OnClickRoleItemCallback(1,i,item)
end
item:SetChildButtonClick(-1,func,true)


if self.sortType==0 or self.sortType==2 then
item:SetChildActive(6,true)

item:SetChildText(6,UIDiscipleModel:getDiscipleFightValue(guid))

item:SetChildText(4,'')
elseif self.sortType==1 then
item:SetChildActive(6,false)


local ltlv=netData.liantilv
local n1,p1=UIDiscipleModel:getLTNameX(ltlv)
local lt_str=''
if p1~=nil then
lt_str=FMT.fmt('{0}{1}层',n1,p1)
else
lt_str=n1
end
item:SetChildText(4,lt_str)

end
end

function UIDiscipleSelectWin_feisheng:OnClickRoleItemCallback(clicknum,index,item)
local netdata=self.disciplelist[index]
local netData=netdata.disciple
local guid=netData.discipleguid
if self.nowGuid==guid then
self.nowGuid=0
self.nowitem=nil
self.nowindex=nil
return
end

self.nowGuid=guid

self.nowitem=item
self.nowindex=index
local item=self.loopTreeView:GetItemWidget(index-1)
item:SetChildActive(10,true)
end

function UIDiscipleSelectWin_feisheng:refreshwin()
self:initDiscipleList()
end

function UIDiscipleSelectWin_feisheng:getNetDataList()

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

function UIDiscipleSelectWin_feisheng:initDiscipleList()
self.disciplelist={}
local list=self:getNetDataList()

for i,data in ipairs(list)do
local level=data.jingjielv

local check=UIDiscipleModel:isDiscipleJJLevelWillChangeX(data)and UIDiscipleModel:checkNextJJNeedBroke(level)and not UIDiscipleModel:checkJJAutoBrokeConditon(level)and level==90


if check then
local locData={}

locData.disciple=data
local scoreWeight=0

scoreWeight=scoreWeight+level*1000
local netData=locData.disciple
local guid=netData.discipleguid

locData.scoreWeight=scoreWeight
locData.level=level
local flag=self:judeshow(guid)
if flag then
table.insert(self.disciplelist,locData)
end
end
end
self:dizipaixu()
end


function UIDiscipleSelectWin_feisheng:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:initRoleListPanel()
end


function UIDiscipleSelectWin_feisheng:dizipaixu()
if not self.sortOrder then
if self.sortType==0 then

table.sort(self.disciplelist,function(a,b)
return UIDiscipleModel:getDiscipleFightValue(a.disciple.discipleguidStr)>UIDiscipleModel:getDiscipleFightValue(b.disciple.discipleguidStr)
end)
elseif self.sortType==1 then

table.sort(self.disciplelist,function(a,b)
return a.disciple.liantilv>b.disciple.liantilv
end)
elseif self.sortType==2 then

table.sort(self.disciplelist,function(a,b)
return a.disciple.imageInfo.color>b.disciple.imageInfo.color
end)
end
else
if self.sortType==0 then

table.sort(self.disciplelist,function(a,b)
return UIDiscipleModel:getDiscipleFightValue(a.disciple.discipleguidStr)<UIDiscipleModel:getDiscipleFightValue(b.disciple.discipleguidStr)
end)
elseif self.sortType==1 then

table.sort(self.disciplelist,function(a,b)
return a.disciple.liantilv<b.disciple.liantilv
end)
elseif self.sortType==2 then

table.sort(self.disciplelist,function(a,b)
return a.disciple.imageInfo.color<b.disciple.imageInfo.color
end)
end
end

end


function UIDiscipleSelectWin_feisheng:initRoleListPanel()
self:dizipaixu()
if _useLoop then
self:initLoopRoleListPanel()
else
self:initNormalRoleListPanel()
end
end


function UIDiscipleSelectWin_feisheng:initLoopRoleListPanel()
self.roleListPanelEx:setActive(true)
self.roleListPanel:setActive(false)
local dataNum=#self.disciplelist
self.loopTreeView:InitDataList(dataNum,'Item1')
local hasDZ=dataNum>0
self.noDZTips:setActive(not hasDZ)
end

function UIDiscipleSelectWin_feisheng:initNormalRoleListPanel()
local dataNum=#self.disciplelist
self.roleListPanelEx:setActive(false)
self.roleListPanel:setActive(true)
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,6)
local hasDZ=dataNum>0
self.hasNewDZ=nil
if hasDZ then
local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
self:refreshRoleItem(i,item)
end
end
self.noDZTips:setActive(not hasDZ)
end


function UIDiscipleSelectWin_feisheng:onDropdownChange(idx)

if self.lockRefresh then return end
self.sortType=idx


self:clearSearchInput()
self:initRoleListPanel()
end

function UIDiscipleSelectWin_feisheng:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function UIDiscipleSelectWin_feisheng:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end




function UIDiscipleSelectWin_feisheng:onKickoutBtn()
end



function UIDiscipleSelectWin_feisheng:onSearchBtn()
end



function UIDiscipleSelectWin_feisheng:onSearchCancelBtn()
end


function UIDiscipleSelectWin_feisheng:onClosebtn()
self:closeSelf()
end


function UIDiscipleSelectWin_feisheng:onSureBtn()
if self.nowGuid and self.nowGuid~=0 then
if UIDiscipleModel:checkDZStateToDoSomething(self.nowGuid,eCheckDiscipleStateOpType.eFeiSheng,true)then
self.callback(self.nowGuid)
self:onClosebtn()
end
else
self.callback(0)
self:onClosebtn()
end
end

function UIDiscipleSelectWin_feisheng:onSortConditionClick()
local filterName,filterFlag=self.getConditonFilter(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterThreeWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end

function UIDiscipleSelectWin_feisheng.getConditonFilter(sortCondition_)
local c=1
local filterName={}
local filterFlag={}

filterName[c]={}
filterName[c][1]='灵根'
filterName[c][2]={}
filterFlag[c]={}
local lgcfgs=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
for i,v in ipairs(lgcfgs)do
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition_,c,v.id)
table.insert(filterFlag[c],flag)
end
c=c+1
filterName[c]={}
filterName[c][1]='职业'
filterName[c][2]={}
filterFlag[c]={}
local jobcfgs=cfg_disciplevocationconfig()
for k,v in pairs(jobcfgs)do
if v.id~=nil and not v.hide then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition_,c,v.id)
table.insert(filterFlag[c],flag)
end
end
return filterName,filterFlag
end

function UIDiscipleSelectWin_feisheng.selecConditionBack(data)

if _this==nil then
return
end
local filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end
_this:initDiscipleList()
_this:initRoleListPanel()
_this.nowGuid=0
if _this.nowitem then
_this.nowitem:SetChildActive(10,false)
end
end


function UIDiscipleSelectWin_feisheng:judeshow(guid)
if not next(self.sortCondition)then
return true
end
if next(self.sortCondition[1])then

local linggentb=FeiShengTaiModel:judelinggen(guid)
for k,v in ipairs(self.sortCondition[1])do
if linggentb[v]then
return true
end
end
end
if next(self.sortCondition[2])then
local job=UIDiscipleModel:getDiscipleJob(guid)
for k,v in ipairs(self.sortCondition[2])do
if job==v then
return true
end
end
end
if not next(self.sortCondition[1])and not next(self.sortCondition[2])then
return true
end
return false

end

function UIDiscipleSelectWin_feisheng:onClosebg()
self:closeSelf()
end
