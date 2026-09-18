







def_class("UIKickoutLSSelectWin",UIWindowBase)









function UIKickoutLSSelectWin:bindComponents()

self.commitBtn=UIButton.get(self,0)
self.commonDZSelectRoot=UIObject.get(self,1)
self.Content=UIObject.get(self,2)
self.noDZTips=UIObject.get(self,3)
self.roleListPanel=UIObject.get(self,4)
self.sortConditionButton=UIButton.get(self,5)
self.sortOrderButton=UIButton.get(self,6)
self.sortTypeDropdown=UIDropdown.get(self,7)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)



end


function UIKickoutLSSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commonDZSelectRoot);self.commonDZSelectRoot=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.noDZTips);self.noDZTips=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
end
















local _this=nil
local _useLoop=api_Available_GetChildLoopTreeView()or false

local _itemCmpIndex={
back=0,
name=1,
rawimg=2,
level=3,
fight=4,
state=5,
statename=6,
select=7,
order=8,
black=9,
lv_obj=10,
select2=11,
fight_des=12,
jingjie=13,
}




function UIKickoutLSSelectWin:onLoaded(...)
self:bindComponents()

_this=self
local _OnClickRoleItemCallback=function(...)

end

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)

self.maxLimit=cfgHelper.get2(cfg_lingshoufangshengbaseconfig_get,1,'maxKickoutOneTime')
self.loopTreeView=self.winlua:GetChildUILoopTreeView(self.roleListPanel:getID())
self.loopTreeView:SetAction(function(...)
if not self or self.isClose then return end
self:freshLoopAction(...)
end,function()
if not self or self.isClose then return end
self:startLoopAction()
end)
end


function UIKickoutLSSelectWin:__delete()
_this=nil

self:unbindComponents()
end




function UIKickoutLSSelectWin:onShow(args,afterOnloaded)

self.param=args
self:doFadeIn(0.15,0.5)

self.parentWin=args.parentWin
self.lsSelectLookup=args.lsSelectLookup or{}
self.onSelectFunc=args.onSelectFunc

self.sortTypeList=eLingShouSortType:getLSSortList8()
self.sortTypeDropdown:setOption(eLingShouSortTypeName:getName2List2(self.sortTypeList))

self.sortType=eLingShouSortType.eJingJieSort


for i,v in ipairs(self.sortTypeList)do
if v==self.sortType then
self.sortTypeIndex=i
end
end

self.sortCondition=lingshouModel:getSaveSortCondition()
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false

self:initRoleListPanel()
self:refreshBtn()
end


function UIKickoutLSSelectWin:onHide()

end




function UIKickoutLSSelectWin:doFadeIn(delay,duration)
self.commonDZSelectRoot:setChildCanvasGroupAlpha(0)
local func=function()
self.commonDZSelectRoot:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end

function UIKickoutLSSelectWin:refreshBtn()
local num=self:getSelectNum()
local has=num>0
self.commitBtn:setButtonInteractable(has)
self.commitBtn:setChildImageExGray(not has)
end

function UIKickoutLSSelectWin:getNetDataList()
local list=self:getSortLingShouList(self.sortCondition)
return list
end

function UIKickoutLSSelectWin:getSortLingShouList(sortCondition_)
local lsDataList=lingshouLookup:getSortList10(self.sortType,self.sortCondition,self.sortOrder)
local result={}
for index,lsData in pairs(lsDataList)do
local loc={}
loc.lsData=lsData


local state=lingshouModel:getHighestStateType(lsData.guid)
loc.state=state



local sorts={}
loc.sorts=sorts

local isFollow=loc.lsData.follow_level and loc.lsData.follow_level>0
local isIdle=(state==eLingShouStateType.petFree or state==eLingShouStateType.petBuild)



loc[1]=isIdle and 0 or 1
loc[2]=state
loc[3]=lingshouModel:getFightValue(lsData.guid)or 0


result[#result+1]=loc
end

return result
end


function UIKickoutLSSelectWin:initLoopLsListPanel(list)
local dataNum=#list
self.lingShouList=list
self.winlua:SetChildScrollRectStopMovement(self.roleListPanel:getID())
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
self.loopTreeView:InitDataList(dataNum,'lsItem')
end

function UIKickoutLSSelectWin:startLoopAction()

end


function UIKickoutLSSelectWin:freshLoopAction(i,item)
local index=i+1
self:refreshLsItem(index,item)
end

function UIKickoutLSSelectWin:refreshLsItem(index,item)
local locData=self.lingShouList[index]
local netData=locData.lsData
local lsID=netData.id
local lscfg=netData.cfg
local guid=netData.guid
local lsGuidStr=netData.guid_str
local state=locData.state
local hasOrder=netData.follow_level>0
local isIdleState=(state==eLingShouStateType.petFree or state==eLingShouStateType.petBuild)

local color=lingshouModel:getColor(guid)
item:SetChildCSImageSprite(0,globalABLookup.lingshoumain,lingshouColorToFrame[color])


local name=netData.name or lscfg.name
item:SetChildText(1,name)



comHelper.setChildModelRawImage_lingshou(item,lsID,2,0,eHeadCenterType.eHead,1)


if self.sortType==eLingShouSortType.eJingJieSort then

item:SetChildActive(5,false)

local jj_str=lingshouModel:getJJName(guid,2)

item:SetChildText(4,jj_str)
elseif self.sortType==eLingShouSortType.eQianLi then

item:SetChildActive(5,false)

local ql_str=lingshouModel:getQianLiDesc(guid)
ql_str=FMT.fmt("潜力：<color=#171311>{0}</color>",ql_str)
item:SetChildText(4,ql_str)
elseif self.sortType==eLingShouSortType.eZiZhi then

item:SetChildActive(5,false)

local str=FMT.fmt("资质：<color=#171311>{0}</color>",lingshouModel.getLingShouPropertyVal(netData,lingshouPropertyType.ZIZHI))
item:SetChildText(4,str)
else

item:SetChildActive(5,true)
local fight=lingshouModel:getFightValue(guid)
item:SetChildText(5,FMT.fmt("<color=#7D3B17>战力</color> {0}",mathHelper.formatNumber7(fight,1,2)))

item:SetChildText(4,'')
end


local showSign=lscfg.bianyi==1
item:SetChildActive(3,showSign)


local generation=netData.generation
item:SetChildText(8,FMT.fmt("{0}代",generation))
local generationShowParams=cfgHelper.get2(cfg_lingshoubasicconfig_get,1,'generationShowBg')
local generationParam=generationShowParams[generation]or generationShowParams[#generationShowParams]
local abName=generationParam.abname
local iconName=generationParam.icon

item:SetChildCSImageSprite(7,abName,iconName)


item:SetChildActive(13,not isIdleState)


item:SetChildActive(10,true)
item:SetChildText(11,lingshouModel:getStateNameEx(state))



item:SetChildActive(9,hasOrder)

local isSelect=self.lsSelectLookup[lsGuidStr]~=nil
self:refreshRoleItemSelect(item,index,isSelect)


local newbieName=FMT.fmt('UILingShouListSelectWin.lingShouItem_{0}',index)
item:SetChildNewBieComponentId(-1,newbieName)

local func=function()
self:OnClickRoleItemCallback(1,index)
end
item:SetChildButtonClick(-1,func,true)
item:SetChildLongTouch(-1,index,0.5,function(...)
self:onLongClickRoleItem(index)
end)

end

function UIKickoutLSSelectWin:initRoleListPanel()
local list=self:getNetDataList()


self:initRoleListPanelEx(list)
end

function UIKickoutLSSelectWin:initRoleListPanelEx(list)
self.lsLocDataList=list
self.fullLingShouList=list

mathHelper.sortWeightList(self.lsLocDataList,nil,nil,nil,1,eSortOrder.eDown,self.sortOrder)

local dataNum=#self.lsLocDataList

local hasLS=dataNum>0
if hasLS then
self:initLoopLsListPanel(self.lsLocDataList)
end
self.noDZTips:setActive(not hasLS)
self.roleListPanel:setActive(hasLS)
end

function UIKickoutLSSelectWin:refreshRoleItemSelect(item,idx,isSelect)
if item==nil then
item=self.loopTreeView:GetItemWidget(idx-1)
end
item:SetChildActive(12,isSelect)
end


function UIKickoutLSSelectWin:OnClickRoleItemCallback(clicknum,index)
local locData=self.lsLocDataList[index]
local netData=locData.lsData
local guid=netData.guid
local lsGuidStr=netData.guid_str
local jingjie=lingshouModel.getJJFloor(netData.jj_lvl)

if lingshouModel:checkNoOptState(guid)then return end


if locData.state~=eLingShouStateType.petFree and locData.state~=eLingShouStateType.petBuild then
local stateName=lingshouModel:getStateNameEx(locData.state)
UIManager.info(stateName)
return
end
if netData.follow_level>0 then
UIManager.error("关注的灵兽不可放生")
return
end


local isSelect=self.lsSelectLookup[lsGuidStr]~=nil
local doFunc=function()
if _this==nil then return end
if isSelect then
_this.lsSelectLookup[lsGuidStr]=nil
else
_this.lsSelectLookup[lsGuidStr]=guid
end
isSelect=not isSelect

_this:refreshRoleItemSelect(nil,index,isSelect)
_this:refreshBtn()
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLingShouFangShengTiXing)
if(jingjie>=5)and not isSelect and not flag then
local showdata=
{
type='UIDialouge',
title='提示',
content='灵兽境界等级较高，是否确认选择',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=doFunc,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLingShouFangShengTiXing,flag)
end,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
else
doFunc()
end
end

function UIKickoutLSSelectWin:onLongClickRoleItem(index)
local locData=self.lingShouList[index]
if locData==nil then return end

local slist={}

list=self:getNetDataList()

for index,locData in ipairs(list)do
slist[index]=locData.lsData
end

UIFullLingShouMainControl:showWindow_SingleInfoTab(_this,{
lslist=slist,
ls_guid=locData.lsData.guid,
},{ls_guid=locData.lsData.guid,})
end

function UIKickoutLSSelectWin:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
self.sortTypeIndex=idx
self.sortType=self.sortTypeList[self.sortTypeIndex]


self:initRoleListPanel()
end

function UIKickoutLSSelectWin:onSortConditionButton()
local filterName,filterFlag,filterConflict=lingshouLookup:getConditonFilter4(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack,conflictList=filterConflict}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end


function UIKickoutLSSelectWin.selecConditionBack(data)
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

shuwudianModel.saveSortCondition_kickout(table.deepCopy(_this.sortCondition))

_this:initRoleListPanel()
_this:refreshBtn()
end

function UIKickoutLSSelectWin:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:initRoleListPanel()
end

function UIKickoutLSSelectWin:onCommitBtn()
local num=self:getSelectNum()
if num>self.maxLimit then
UIManager.error(FMT.fmt('本次最多放生{0}个灵兽',self.maxLimit))
return
end

if self.onSelectFunc then
self.onSelectFunc(table.deepCopy(self.lsSelectLookup))
end
self.parentWin:onClickClose()
end

function UIKickoutLSSelectWin:getSelectNum()
local num=0
for guid_str,guid in pairs(self.lsSelectLookup)do
if guid~=nil then
num=num+1
end
end
return num
end