







def_class("UIKickoutDZSelectWin",UIWindowBase)







function UIKickoutDZSelectWin:bindComponents()

self.commonDZSelectRoot=UIObject.get(self,0)
self.roleListPanel=UIObject.get(self,1)
self.sortTypeDropdown=UIDropdown.get(self,2)
self.sortConditionButton=UIButton.get(self,3)
self.sortOrderButton=UIButton.get(self,4)
self.noDZTips=UIObject.get(self,5)
self.commitBtn=UIButton.get(self,6)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIKickoutDZSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.commonDZSelectRoot);self.commonDZSelectRoot=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.noDZTips);self.noDZTips=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
end
















local _this=nil


function UIKickoutDZSelectWin:onLoaded(...)
self:bindComponents()
_this=self
local _OnClickRoleItemCallback=function(...)

end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)

self.maxLimit=cfgHelper.get2(cfg_disciplekickoutconfig_get,1,'maxKickoutOneTime')

self.sortTypeList={eDiscipleSortType.eFightSort,eDiscipleSortType.eColorSort,eDiscipleSortType.eZiZhi,
eDiscipleSortType.eGenGu,eDiscipleSortType.eCongHui,eDiscipleSortType.eQianLi,eDiscipleSortType.eMeiLi,
eDiscipleSortType.eJiYuan,eDiscipleSortType.ePeiZhi,eDiscipleSortType.eDanDao,eDiscipleSortType.eShangDao,
eDiscipleSortType.eFuLu,eDiscipleSortType.eLianQi,eDiscipleSortType.eZhenFa,eDiscipleSortType.eSiYang,
eDiscipleSortType.eJuLing}
end


function UIKickoutDZSelectWin:__delete()
self:unbindComponents()
_this=nil
end

function UIKickoutDZSelectWin:onHide()
end

function UIKickoutDZSelectWin:doFadeIn(delay,duration)
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




function UIKickoutDZSelectWin:onShow(args,afterOnloaded)
self:doFadeIn(0.15,0.5)

self.parentWin=args.parentWin
self.dzSelectLookup=args.dzSelectLookup or{}
self.onSelectFunc=args.onSelectFunc

local sortTypeNamesList=eDiscipleSortTypeName:getName2List2(self.sortTypeList)
self.sortTypeDropdown:setOption(sortTypeNamesList)
self.sortTypeIndex=shuwudianModel.getSortType_kickout()or 1
self.sortCondition=shuwudianModel.getSortCondition_kickout()
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false

self:initRoleListPanel()
self:refreshBtn()
end

function UIKickoutDZSelectWin:refreshBtn()
local num=self:getSelectNum()
local has=num>0
self.commitBtn:setButtonInteractable(has)
self.commitBtn:setChildImageExGray(not has)
end

function UIKickoutDZSelectWin:getNetDataList()
local list=self.getSortDiscipleList(self.sortCondition)
return list
end

function UIKickoutDZSelectWin.getSortDiscipleList(sortCondition_)
local result={}
local discipleNetData=UIDiscipleModel:getAllDiscipleDataX()
if discipleNetData~=nil then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
local discipleguidStr=netData.discipleguidStr
local add=true
local c=1
if sortCondition_~=nil then
if sortCondition_[c]~=nil and#sortCondition_[c]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition_[c])do
local checkfree=UIDiscipleModel:checkDiscipleState(netData.discipleguid,DISCIPLE_STATE_TYPE.eFree)
local checkWorkRoom=zongmenModel:getDiscipleWorkroom(netData.discipleguid)~=nil
local checkDispatch=UIDiscipleModel:checkDiscipleState2(netData.discipleguid,DISCIPLE_STATE_TYPE.edsDispatch)
local cszData=chuanSongZhenModel:findDiscipleData(netData.discipleguid)
local falg=checkfree and not checkWorkRoom and not checkDispatch and not cszData

if v1==1 and falg then
addx=true
break
end
if v1==2 and not falg then
addx=true
break
end
end
add=add and addx
end
c=c+1

if sortCondition_[c]~=nil and#sortCondition_[c]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition_[c])do
if UIDiscipleModel:getDiscipleSpecialityByID(netData.discipleguid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,v1)then
addx=true
break
end
end
add=add and addx
end
c=c+1

if sortCondition_[c]~=nil and#sortCondition_[c]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition_[c])do
if discipleLookup:checkDiscipleHasJob(v1,netData.discipleguidStr)then
addx=true
break
end
end
add=add and addx
end
end
if add then
result[#result+1]=netData
end
end
end
return result
end

function UIKickoutDZSelectWin:initRoleListPanel()
local list={}
local temp=self:getNetDataList()
for i,netData in ipairs(temp)do
local locData={}
locData.disciple=netData
local guid=netData.discipleguid

local sortType=self.sortTypeList[self.sortTypeIndex]
local level=discipleLookup:getValueBySortType(guid,sortType)
locData.level=level

local flag,statetype=UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eKickout,false)
locData.checkFlag=flag
locData.cantStateType=statetype

local sorts={}
locData.sorts=sorts

sorts[1]=locData.checkFlag==true and 1 or 0
sorts[2]=level
sorts[3]=guid

table.insert(list,locData)
end
self:initRoleListPanelEx(list)
end

function UIKickoutDZSelectWin:initRoleListPanelEx(list)
self.disciplesList=list
mathHelper.sortWeightList(self.disciplesList,nil,nil,nil,1,eSortOrder.eDown,self.sortOrder)
local dataNum=#self.disciplesList
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,6)
local hasDZ=dataNum>0
if hasDZ then
local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local locData=self.disciplesList[i]
local netData=locData.disciple
local guid=netData.discipleguid
local discipleguidStr=netData.discipleguidStr
local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
local item=grids[i-1]

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(29,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,chuiwei)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)

local sortType=self.sortTypeList[self.sortTypeIndex]
local desc_str=discipleLookup:getValueDescBySortType(locData.level,sortType,'<color=#7D3B17>{0}</color> {1}')
if sortType~=eDiscipleSortType.eFightSort then
item:SetChildActive(6,false)
item:SetChildText(4,desc_str)
else

item:SetChildActive(6,true)
item:SetChildText(6,desc_str)

item:SetChildText(4,'')
end

item:SetChildActive(8,true)
local state_str
local showBlack=false
if locData.checkFlag then
state_str=UIDiscipleModel:getDiscipleStateDesc(guid,' ')
else
showBlack=true
state_str=UIDiscipleModel:getCantKickOutDZDesc(locData.cantStateType)
end
item:SetChildText(9,state_str)
item:SetChildActive(16,showBlack)

item:SetChildActive(8,not chuiwei)
item:SetChildActive(9,not chuiwei)
item:SetChildActive(12,chuiwei)
item:SetChildActive(13,chuiwei)

local hasOrder=UIDiscipleModel:checkDZHasOrder(guid)
item:SetChildActive(15,hasOrder)

local isSelect=self.dzSelectLookup[discipleguidStr]~=nil
self:refreshRoleItemSelect(item,i,isSelect)

local func=function()
self:OnClickRoleItemCallback(1,i)
end
item:SetChildButtonClick(-1,func,true)
item:SetChildLongTouch(-1,i,0.5,function(...)
self:onLongClickRoleItem(i)
end)
end
end
self.noDZTips:setActive(not hasDZ)
end

function UIKickoutDZSelectWin:refreshRoleItemSelect(item,idx,isSelect)
if item==nil then
item=self.roleListPanel:getChildScrollViewItemWidget(idx-1)
end
item:SetChildActive(10,isSelect)
end


function UIKickoutDZSelectWin:OnClickRoleItemCallback(clicknum,index)
local locData=self.disciplesList[index]
local netData=locData.disciple
local guid=netData.discipleguid
local hasOrder=UIDiscipleModel:checkDZHasOrder(guid)
if hasOrder then
UIManager.error("关注的弟子不可被驱逐")
return
end

local discipleguidStr=netData.discipleguidStr

if not locData.checkFlag then
UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eKickout,true)
return
end

local isSelect=self.dzSelectLookup[discipleguidStr]~=nil
local doFunc=function()
if _this==nil then return end
if isSelect then
_this.dzSelectLookup[discipleguidStr]=nil
else
_this.dzSelectLookup[discipleguidStr]=guid
end
isSelect=not isSelect

_this:refreshRoleItemSelect(nil,index,isSelect)
_this:refreshBtn()
end

local curID=WenXinGuanModel:getDtDzGuid()

if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie3)and not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
if curID==guid then
UIManager.error('九重天劫期间，参与问心关的弟子无法逐出')
return
elseif WenXinGuanModel:checkDzWXGState(guid)then
UIManager.error('九重天劫期间，完成问心关的弟子无法逐出')
return
end
end
local xianmoCheckFunc=function()
if UIDiscipleModel:checkDiscipleXianMoVoc(guid)then
local showdata=
{
type='UIDialouge',
title='提示',
content='弟子已完成转职，是否驱逐？驱逐后将返还弟子在转职与问心关的所有材料与75%的传道点数与仙魔气',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=doFunc,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
elseif curID==guid or WenXinGuanModel:checkDzWXGState(guid)then
local showdata=
{
type='UIDialouge',
title='提示',
content='弟子参与了问心关，逐出将清除问心关状态并返回所有材料和75%传道点数，是否继续？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=doFunc,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
else
doFunc()
end
end


local doColorFunc=function()
local color=UIDiscipleModel:getDiscipleColor(guid)
local checkColor=onlineDataSetting:getData(onlineDataKeyType.eDiscipleDickoutSelectCheckColor,false)
if color>=eQualityColor.eOrange and not checkColor then
local content=UIDiscipleModel.getDiscipleColorDesc(color)
content=toColorString(color,content)
content=FMT.fmt('确定选择该名{0}品质弟子吗？',content)
UIDialogManager.getConfirmDialog3(nil,content,xianmoCheckFunc,REPEAT_TYPE.eKickoutDZSelect)
else
xianmoCheckFunc()
end
end
if not isSelect then
local coupleGuid=DiscipleCoupleModel:getDiscipleCoupleGuid(guid)
if coupleGuid then
local coupleName=UIDiscipleModel:getDiscipleName(coupleGuid)
local coupleSpeList=UIDiscipleModel:getDiscipleSpeciality(coupleGuid,DISCIPLE_SPECIALITY_TYPE.eDaoLv)or{}
local speStr=""
for _,v in pairs(coupleSpeList)do
local sid=v.param_1
local speName=UIDiscipleModel:getSpecialityName(DISCIPLE_SPECIALITY_TYPE.eDaoLv,sid,true)
speStr=string.format("%s“<color=#CA631D>%s</color>”",speStr,speName)
end
local content=string.format("逐出弟子将<color=#C82C2C>解除</color>与“<color=#CA631D>%s</color>”的<color=#C82C2C>道侣关系</color>,其道侣“<color=#CA631D>%s</color>”将<color=#C82C2C>失去特质</color>%s",coupleName,coupleName,speStr)
UIDialogManager.getConfirmDialog3(nil,content,doColorFunc,REPEAT_TYPE.eKickoutDiscipleCouple)
else
doColorFunc()
end
else
doFunc()
end
end

function UIKickoutDZSelectWin:onLongClickRoleItem(index)
local locData=self.disciplesList[index]
local netData=locData.disciple
local guid=netData.discipleguid
otherPlayerController:openSelfPlayerDZInfoWin({guid})
end

function UIKickoutDZSelectWin:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
self.sortTypeIndex=idx
shuwudianModel.saveSortType_kickout(idx)

self:initRoleListPanel()
end

function UIKickoutDZSelectWin:onSortConditionButton()
local filterName,filterFlag,filterConflict=self.getConditonFilter(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack,conflictList=filterConflict}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIKickoutDZSelectWin.getConditonFilter(sortCondition_)
local c=1
local filterName={}
local filterFlag={}
local filterConflict={}

filterName[c]={}
filterName[c][1]='状态'
filterName[c][2]={}
filterFlag[c]={}
filterConflict[c]={}
table.insert(filterName[c][2],{name="未安排",typeid=1})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition_,c,1)
table.insert(filterFlag[c],flag)
table.insert(filterConflict[c],{2})

table.insert(filterName[c][2],{name="已安排",typeid=2})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition_,c,2)
table.insert(filterFlag[c],flag)
table.insert(filterConflict[c],{1})
c=c+1
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
return filterName,filterFlag,filterConflict
end

function UIKickoutDZSelectWin.selecConditionBack(data)
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

function UIKickoutDZSelectWin:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:initRoleListPanel()
end

function UIKickoutDZSelectWin:onCommitBtn()
local num=self:getSelectNum()
if num>self.maxLimit then
UIManager.error(FMT.fmt('本次最多逐出{0}个弟子',self.maxLimit))
return
end

if self.onSelectFunc then
self.onSelectFunc(table.deepCopy(self.dzSelectLookup))
end
self.parentWin:onClickClose()
end

function UIKickoutDZSelectWin:getSelectNum()
local num=0
for guid_str,guid in pairs(self.dzSelectLookup)do
if guid~=nil then
num=num+1
end
end
return num
end