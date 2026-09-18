







def_class("UILingShouListSelectWin",UIWindowBase)









function UILingShouListSelectWin:bindComponents()

self.childItem=UIObject.get(self,0)
self.ContentEx=UIObject.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.kickoutBtn=UIButton.get(self,3)
self.lsListPanel=UIObject.get(self,4)
self.lsListPanelEx=UIObject.get(self,5)
self.noLSTips=UIObject.get(self,6)
self.numText=UIText.get(self,7)
self.root=UIObject.get(self,8)
self.searchBtn=UIButton.get(self,9)
self.searchCancelBtn=UIButton.get(self,10)
self.searchInput=UIInputField.get(self,11)
self.sortConditionButton=UIButton.get(self,12)
self.sortOrderButton=UIButton.get(self,13)
self.sortTypeDropdown=UIDropdown.get(self,14)
self.testRoot=UIObject.get(self,15)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.kickoutBtn:setButtonClick(function()self:onKickoutBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)



end


function UILingShouListSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.childItem);self.childItem=nil;
_UIObject_release(self.ContentEx);self.ContentEx=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.kickoutBtn);self.kickoutBtn=nil;
_UIObject_release(self.lsListPanel);self.lsListPanel=nil;
_UIObject_release(self.lsListPanelEx);self.lsListPanelEx=nil;
_UIObject_release(self.noLSTips);self.noLSTips=nil;
_UIObject_release(self.numText);self.numText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.testRoot);self.testRoot=nil;
end
















local _this=nil
local _useLoop=api_Available_GetChildLoopTreeView()or false
local lsDescTypeList={
[eLingShouSortType.eJingJieSort]=1,
[eLingShouSortType.eQianLi]=2,
[eLingShouSortType.eZiZhi]=3,
[eLingShouSortType.eXueMai]=5,

}



function UILingShouListSelectWin:onLoaded(...)
self:bindComponents()
_this=self




self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)

notifySystem:listenNotify(notifyConfig.onTestModelChange,self.onTestModelChange)

self:showTestRoot()

if _useLoop then
self.loopTreeView=self.winlua:GetChildUILoopTreeView(self.lsListPanelEx:getID())
self.loopTreeView:SetAction(function(...)
if not self or self.isClose then return end
self:freshLoopAction(...)
end,function()
if not self or self.isClose then return end
self:startLoopAction()
end)
end

self.sortTypeList=eLingShouSortType:getLSSortList()

self.stackOn=false
self.fullLingShouList=nil
self.showLingShouList=nil

local childItemWidget=self.childItem:getWidgetBase()
local toggleIndex=0

childItemWidget:SetChildToggleChange(toggleIndex,nil)
childItemWidget:SetChildToggle(toggleIndex,false)
childItemWidget:SetChildToggleChange(toggleIndex,function(name,isOn)
self.stackOn=isOn and true or false

if lingshouModel and lingshouModel.setSaveLsSelectStackOn then
lingshouModel:setSaveLsSelectStackOn(self.stackOn)
end
self:initLsListPanel()
end)
end


function UILingShouListSelectWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onTestModelChange,self.onTestModelChange)


self:clearAllLsNewSign()
end




function UILingShouListSelectWin:onShow(argtable,afterOnloaded)
self.param=argtable
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end
local sortTypeNamesList=eLingShouSortTypeName:getName2List2(self.sortTypeList)
self.sortTypeDropdown:setOption(sortTypeNamesList)
if argtable.sortType~=nil then
self.sortTypeIndex=argtable.sortType

lingshouModel:setSaveSortType(self.sortTypeIndex)
else
self.sortTypeIndex=lingshouModel:getSaveSortType()
end
self.sortType=self.sortTypeList[self.sortTypeIndex]

local recordSortCondition=argtable.recordSortCondition
if recordSortCondition==true then
self.sortCondition=lingshouModel:getSaveSortCondition()
else
local sortCondition={}
self.sortCondition=sortCondition

lingshouModel:setSaveSortCondition(sortCondition)
end
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false
self.flag=false

local recordIInputstr=argtable.recordIInputstr
if recordIInputstr~=nil then
self.inputstr=recordIInputstr
else
self.inputstr=nil
end

local stackBefore=lingshouModel.getTempLsSelectStackBefore and lingshouModel:getTempLsSelectStackBefore()or nil
if stackBefore~=nil then
self.stackOn=stackBefore and true or false
if lingshouModel.clearTempLsSelectStackBefore then
lingshouModel:clearTempLsSelectStackBefore()
end
elseif lingshouModel and lingshouModel.getSaveLsSelectStackOn then
self.stackOn=lingshouModel:getSaveLsSelectStackOn()and true or false
end

if self.childItem then
local childItemWidget=self.childItem:getWidgetBase()
if childItemWidget then
local toggleIndex=0
childItemWidget:SetChildToggleChange(toggleIndex,nil)
childItemWidget:SetChildToggle(toggleIndex,self.stackOn)
childItemWidget:SetChildToggleChange(toggleIndex,function(name,isOn)
self.stackOn=isOn and true or false
if lingshouModel and lingshouModel.setSaveLsSelectStackOn then
lingshouModel:setSaveLsSelectStackOn(self.stackOn)
end
self:initLsListPanel()
end)
end
end

self:initLsListPanel()
self:refreshInputBtns()

local cur=lingshouModel:getLSCount()
local max=lingshouModel:getLSMaxCount()
self.numText:setText(FMT.fmt('{0}/{1}',cur,max))
end

function UILingShouListSelectWin:doFadeIn(delay,duration)
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end

function UILingShouListSelectWin:showTestRoot()
local show=false



show=show and playerController.testModel
self.testRoot:setActive(show)
end


function UILingShouListSelectWin:onHide()

self:clearAllLsNewSign()
end

function UILingShouListSelectWin:initLsListPanel()
local fullList=self:getLsList()
self.fullLingShouList=fullList

self.stackCountByGuid=nil
self.stackLeaderGuidById=nil

local showList=fullList
if self.stackOn then
showList=self:buildStackLingShouList(fullList)
end
self.showLingShouList=showList
if self.flag==true then

self.stackOn=self.stackOnBeforeFilterCache and true or false
self.stackOnBeforeFilterCache=nil
self.flag=false
end
if _useLoop then
self:initLoopLsListPanel(showList)
else
self:initNormalLsListPanel(showList)
end
end

function UILingShouListSelectWin:getLsList()
local list={}
local sortParams={[1]=true,[2]=true}
if self.param.lingshous then
for i,guid in ipairs(self.param.lingshous)do
table.insert(list,lingshouModel:getLingShouData(guid))
end
lingshouLookup:sortList(list,self.sortType,self.sortOrder,sortParams)
else
list=lingshouLookup:getSortList(self.sortType,self.sortCondition,self.sortOrder,sortParams)

end

if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in ipairs(list)do
local guid=v.guid
local guid_str=tostring(guid)
local str=self.nameSearchList[guid_str]
if str==nil then
local stateStr=lingshouModel:getStateDesc(guid)
local lsName=v.name
str=lingshouModel.getSearchName(guid_str,lsName,stateStr)
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


function UILingShouListSelectWin:initLoopLsListPanel(list)
local dataNum=#list
self.lingShouList=list
self.lsListPanelEx:setActive(true)
self.lsListPanel:setActive(false)
self.winlua:SetChildScrollRectStopMovement(self.lsListPanelEx:getID())
self.winlua:SetChildLocalPosY(self.ContentEx:getID(),0)
self.loopTreeView:InitDataList(dataNum,'lsItem')
local hasLs=dataNum>0
self.noLSTips:setActive(not hasLs)
end

function UILingShouListSelectWin:startLoopAction()

end

function UILingShouListSelectWin:freshLoopAction(i,item)
local index=i+1
self:refreshLsItem(index,item)
end

function UILingShouListSelectWin:initNormalLsListPanel(list)
self.lingShouList=list
local dataNum=#self.lingShouList
self.lsListPanelEx:setActive(false)
self.lsListPanel:setActive(true)
self.lsListPanel:setChildScrollViewCreateGrids(dataNum,6)
local hasLs=dataNum>0
self.hasNewLs=nil
if hasLs then
local grids=self.lsListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
self:refreshLsItem(i,item)
end
end
self.noLSTips:setActive(not hasLs)
end

function UILingShouListSelectWin:refreshLsItem(idx,item)
local lsData=self.lingShouList[idx]
local lsID=lsData.id
local lscfg=lsData.cfg
local guid=lsData.guid

local descType=lsDescTypeList[self.sortType]
if not descType then
descType=4
end
local clickFunc=function()
return self:onLsItemClick(idx)
end
local cardWidget=item:GetChildWidgetBase(0)
comHelper.setChildLingShouBaseCard(cardWidget,guid,descType,clickFunc)

local isreddot=lingshouModel:checkLingShouReddotAndDiscipleEquip(guid)
cardWidget:SetChildActive(6,isreddot)


local newbieName=FMT.fmt('UILingShouListSelectWin.lingShouItem_{0}',idx)
item:SetChildNewBieComponentId(-1,newbieName)


local showOrder=lingshouModel:checkLSHasOrder(guid)
item:SetChildActive(1,showOrder)


local bgIdx=2
local numTextIdx=3
local cnt=0
local guidStr=tostring(guid)
local isLeader=false
if self.stackOn and self.stackLeaderGuidById~=nil then
local leaderGuidStr=self.stackLeaderGuidById[lsID]
isLeader=leaderGuidStr~=nil and leaderGuidStr==guidStr
end
if isLeader and self.stackCountByGuid~=nil then
cnt=self.stackCountByGuid[guidStr]or 0
end
local showNum=cnt~=nil and cnt>1 and isLeader
item:SetChildActive(bgIdx,showNum)
if showNum then
item:SetChildText(numTextIdx,tostring(cnt))
end


local isnew=lsData.isnew==true
if isnew then self.hasNewLs=true end
item:SetChildActive(5,isnew)


local isLDLS=liandonModel:getLianDonLinkageIdByLsId(lsID)>0
item:SetChildActive(4,isLDLS)
end

function UILingShouListSelectWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UILingShouListSelectWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function UILingShouListSelectWin:clearAllLsNewSign()

if self.hasNewLs==true and self.clickLsClose~=true then
lingshouModel:clearAllLingShouNewSign()
end
self.hasNewLs=nil
self.clickLsClose=nil
end





function UILingShouListSelectWin:onLsItemClick(index)

local args=table.deepCopy(self.param)

local data=self.lingShouList[index]
if data==nil then return end

local list=self.fullLingShouList
if list==nil then
list=self:getLsList()
end

self.clickLsClose=true
if lingshouModel.setTempLsSelectStackBefore then
lingshouModel:setTempLsSelectStackBefore(self.stackOn and true or false)
end


UIFullLingShouMainControl:myShowWindowEx({ls_guid=data.guid,lslist=list,showShareBtn=true})

local func=function(args_)

UIFullDiscipleSelectControl:showLingShouSelectWindow(args_)
end
fullScreenUI.setNextActiveUICallback(func,args)
end


function UILingShouListSelectWin:onDropdownChange(idx)

if self.lockRefresh then return end
idx=idx+1
if self.sortTypeIndex==idx then return end
self.sortTypeIndex=idx
self.sortType=self.sortTypeList[idx]
lingshouModel:setSaveSortType(idx)

self:exitSearchModeIfNeeded(true)
self:initLsListPanel()
end



function UILingShouListSelectWin:exitSearchModeIfNeeded(silentClearInput)
if self.inputstr==nil then
return false
end
if silentClearInput==nil then
silentClearInput=true
end


self.inputstr=nil
if silentClearInput then

self:clearSearchInput()
end


if self.childItem then
self.childItem:setActive(true)
self.helpBtn:setActive(true)
end


local before=self._stackOnBeforeSearch and true or false
self._stackOnBeforeSearch=nil
self.stackOn=before

return true
end

function UILingShouListSelectWin:onSortConditionButton()
local filterName,filterFlag=lingshouLookup:getConditonFilter(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')

args.extraWin='UIFilterThreeWin'

self._stackOnBeforeFilter=self.stackOn
local extraParams={
filterName=filterName,
filterFlag=filterFlag,
comfirmCallback=self.selecConditionBack,
stackBefore=self._stackOnBeforeFilter,
stackConfirmCallback=self.onFilterConfirmStackCallback,
}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end


function UILingShouListSelectWin.onFilterConfirmStackCallback(data)
if _this==nil then return end

local hasAny=false
local filterFlag=data and data.filterFlag
if filterFlag~=nil then
for _,page in ipairs(filterFlag)do
for _,v in ipairs(page)do
if v==true then
hasAny=true
break
end
end
if hasAny then break end
end
end

if hasAny then

_this.stackOnBeforeFilterCache=data and data.stackBefore
_this.stackOn=false
_this.flag=true
if _this.childItem then
_this.childItem:setActive(false)
_this.helpBtn:setActive(false)
end
else

if _this.childItem then
_this.childItem:setActive(true)
_this.helpBtn:setActive(true)
end
local before=data and data.stackBefore
_this.stackOn=before and true or false
_this.stackOnBeforeFilterCache=nil
_this.flag=false
end
end

function UILingShouListSelectWin.selecConditionBack(data)

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
lingshouModel:setSaveSortCondition(table.deepCopy(_this.sortCondition))


_this:exitSearchModeIfNeeded(true)
_this:initLsListPanel()
end

function UILingShouListSelectWin:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:initLsListPanel()
end

function UILingShouListSelectWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then

self:initLsListPanel()
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
if self.inputstr==nil then
self._stackOnBeforeSearch=self.stackOn
end


if self.childItem then
self.childItem:setActive(false)
self.helpBtn:setActive(false)
end

self.stackOn=false
self.inputstr=inputstr
local list=self:getLsList()
if#list<=0 then

UIManager.info('暂无符合条件的灵兽')
return
end
self.searchInput:setInputFieldValue('')
self:initLsListPanel(list)
end

function UILingShouListSelectWin:onSearchCancelBtn()
if self.inputstr==nil then return end

self:exitSearchModeIfNeeded(true)
self:initLsListPanel()
end

function UILingShouListSelectWin:onSearchChange(str)
self:refreshInputBtns(str)
end

function UILingShouListSelectWin:onTestAttrBtnClick()

end

function UILingShouListSelectWin.onTestModelChange(flag)
if _this==nil then return end

_this:showTestRoot()
end

function UILingShouListSelectWin:onHelpBtn()
local baseCfg=cfgHelper.get1(cfg_lingshoubasicconfig_get,1)
local helpList=baseCfg and baseCfg.helpText
local datas=helpList
if datas==nil or#datas<=0 then
UIManager.info('暂无规则说明')
return
end

UIManager:showWindow('UIRuleWin',{
showBlack=true,
mode=1,
title='规则说明',
datas=datas,
})
end


function UILingShouListSelectWin:onKickoutBtn()

UIFullShuWuDianControl:showMyWindowEx(FULL_TAB_TYPE.eLingShouFangSheng,{})
end

function UILingShouListSelectWin:isGuidLess(a,b)
if a==nil then return false end
if b==nil then return true end
local ah,al=mathHelper.splitToInt32(a)
local bh,bl=mathHelper.splitToInt32(b)
if ah~=bh then
return ah<bh
end
return al<bl
end


function UILingShouListSelectWin:buildStackLingShouList(fullList)
if fullList==nil or#fullList<=0 then
self.stackCountByGuid=nil
self.stackLeaderGuidById=nil
return fullList or{}
end


local starkLsCountById={}
for i=1,#fullList do
local v=fullList[i]
if v~=nil then
local guid=v.guid
local id=v.id
local isFollow=lingshouModel:checkLSHasOrder(guid)
local isNew=v.isnew or false
local isSingle=isFollow or isNew
if not isSingle then
starkLsCountById[id]=(starkLsCountById[id]or 0)+1
end
end
end


local bestOverallById={}
local bestOverallFightById={}


local bestOverallFollowById={}


local bestUnfollowById={}
local bestUnfollowFightById={}

for i=1,#fullList do
local v=fullList[i]
if v~=nil then
local guid=v.guid
local id=v.id
local fight=lingshouModel:getFightValue(guid)or 0
local isFollow=lingshouModel:checkLSHasOrder(guid)
local isNew=v.isnew or false
local isSingle=isFollow or isNew

do
local curBest=bestOverallById[id]
if curBest==nil then
bestOverallById[id]=v
bestOverallFightById[id]=fight
bestOverallFollowById[id]=isFollow and true or false
else
local bestFight=bestOverallFightById[id]or 0
if fight>bestFight then
bestOverallById[id]=v
bestOverallFightById[id]=fight
bestOverallFollowById[id]=isFollow and true or false
elseif fight==bestFight then
local curBestIsFollow=bestOverallFollowById[id]and true or false
if curBestIsFollow~=(isFollow and true or false)then

if isFollow then
bestOverallById[id]=v
bestOverallFightById[id]=fight
bestOverallFollowById[id]=true
end
else

if self:isGuidLess(guid,curBest.guid)then
bestOverallById[id]=v
bestOverallFightById[id]=fight
bestOverallFollowById[id]=isFollow and true or false
end
end
end
end
end

if not isSingle then
local curBest=bestUnfollowById[id]
if curBest==nil then
bestUnfollowById[id]=v
bestUnfollowFightById[id]=fight
else
local bestFight=bestUnfollowFightById[id]or 0
if fight>bestFight then
bestUnfollowById[id]=v
bestUnfollowFightById[id]=fight
elseif fight==bestFight then
if self:isGuidLess(guid,curBest.guid)then
bestUnfollowById[id]=v
bestUnfollowFightById[id]=fight
end
end
end
end
end
end


local stackCountByGuid={}
local leaderGuidById={}
for id,leader in pairs(bestOverallById)do
if leader~=nil and leader.guid~=nil then
local leaderGuidStr=tostring(leader.guid)
leaderGuidById[id]=leaderGuidStr

local u=starkLsCountById[id]or 0
local n=u
local leaderIsFollow=bestOverallFollowById[id]and true or false
if leaderIsFollow and u>0 then
n=u+1
end
if n>0 then
stackCountByGuid[leaderGuidStr]=n
end
end
end

self.stackLeaderGuidById=leaderGuidById

local out={}
for i=1,#fullList do
local v=fullList[i]
if v~=nil then
local guid=v.guid
local id=v.id
local isFollow=lingshouModel:checkLSHasOrder(guid)
local isNew=v.isnew or false
local isSingle=isFollow or isNew

if isSingle then
out[#out+1]=v
else
local bestOverall=bestOverallById[id]
if bestOverall~=nil and(not lingshouModel:checkLSHasOrder(bestOverall.guid))then
local bestUnfollow=bestUnfollowById[id]

if bestUnfollow~=nil and mathHelper.compareInt64(bestUnfollow.guid,guid)then
out[#out+1]=v
end
end
end
end
end

self.stackCountByGuid=stackCountByGuid
return out
end
