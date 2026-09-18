







def_class("UIDiscipleSelectWin",UIWindowBase)









function UIDiscipleSelectWin:bindComponents()

self.allDiscipleFight=UIText.get(self,0)
self.ContentEx=UIObject.get(self,1)
self.discipleNumText=UIText.get(self,2)
self.dzCreateImageBtn=UIButton.get(self,3)
self.kickoutBtn=UIButton.get(self,4)
self.kickoutLock=UIObject.get(self,5)
self.noDZTips=UIObject.get(self,6)
self.roleListPanel=UIObject.get(self,7)
self.roleListPanelEx=UIObject.get(self,8)
self.root=UIObject.get(self,9)
self.searchBtn=UIButton.get(self,10)
self.searchCancelBtn=UIButton.get(self,11)
self.searchInput=UIInputField.get(self,12)
self.sortTypeDropdown=UIDropdown.get(self,13)
self.testRoot=UIObject.get(self,14)

self.dzCreateImageBtn:setButtonClick(function()self:onDzCreateImageBtn()end)

self.kickoutBtn:setButtonClick(function()self:onKickoutBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)



end


function UIDiscipleSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.allDiscipleFight);self.allDiscipleFight=nil;
_UIObject_release(self.ContentEx);self.ContentEx=nil;
_UIObject_release(self.discipleNumText);self.discipleNumText=nil;
_UIObject_release(self.dzCreateImageBtn);self.dzCreateImageBtn=nil;
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
_UIObject_release(self.testRoot);self.testRoot=nil;
end
















local _this=nil
local _useLoop=api_Available_GetChildLoopTreeView()or false

function UIDiscipleSelectWin:onLoaded(...)
self:bindComponents()
_this=self




self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)

notifySystem:listenNotify(notifyConfig.onTestModelChange,self.onTestModelChange)

self:showTestRoot()

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


self.sortTypeList={eDiscipleSortType.eFightSort,eDiscipleSortType.eJingJieSort,eDiscipleSortType.eLianTiSort,
eDiscipleSortType.eColorSort,eDiscipleSortType.ePostSort,
eDiscipleSortType.eZiZhi,eDiscipleSortType.eGenGu,eDiscipleSortType.eCongHui,eDiscipleSortType.eQianLi,
eDiscipleSortType.eMeiLi,eDiscipleSortType.eJiYuan,eDiscipleSortType.ePeiZhi,eDiscipleSortType.eDanDao,
eDiscipleSortType.eShangDao,eDiscipleSortType.eFuLu,eDiscipleSortType.eLianQi,eDiscipleSortType.eZhenFa,
eDiscipleSortType.eSiYang,eDiscipleSortType.eJuLing}
end


function UIDiscipleSelectWin:__delete()
self:unbindComponents()
_this=nil

self:clearAllDZNewSign()

notifySystem:removelistener(notifyConfig.onTestModelChange,self.onTestModelChange)
end

function UIDiscipleSelectWin.onTestModelChange(flag)
if _this==nil then return end

_this:showTestRoot()
end

function UIDiscipleSelectWin:showTestRoot()
local show=false



show=show and playerController.testModel
self.testRoot:setActive(show)
local show2=false



self.dzCreateImageBtn:setActive(show2)
end

function UIDiscipleSelectWin:onHide()
self.nameSearchList=nil
self:clearAllDZNewSign()
end

function UIDiscipleSelectWin:clearAllDZNewSign()

if self.hasNewDZ==true and self.clickDZClose~=true then
UIDiscipleModel:clearAllDZNewSign()
end
self.hasNewDZ=nil
self.clickDZClose=nil
end

function UIDiscipleSelectWin:doFadeIn(delay,duration)
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




function UIDiscipleSelectWin:onShow(argtable,afterOnloaded)
self.param=argtable
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end
local sortTypeNamesList=eDiscipleSortTypeName:getName2List2(self.sortTypeList)
self.sortTypeDropdown:setOption(sortTypeNamesList)
if argtable.sortType~=nil then
self.sortTypeIndex=argtable.sortType
UIDiscipleModel:setSaveSortType(self.sortTypeIndex)
else
self.sortTypeIndex=UIDiscipleModel:getSaveSortType()
end
local recordSortCondition=argtable.recordSortCondition
if recordSortCondition==true then
self.sortCondition=UIDiscipleModel:getSaveSortCondition()
else
local sortCondition={}
self.sortCondition=sortCondition
UIDiscipleModel:setSaveSortCondition(sortCondition)
end
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false

local recordIInputstr=argtable.recordIInputstr
if recordIInputstr~=nil then
self.inputstr=recordIInputstr
else
self.inputstr=nil
end

self:initRoleListPanel()
self:refreshInputBtns()
self:refreshAllFightPanel()

local cur=UIDiscipleModel:checkDiscipleCount()
local max=UIRecruitModel:getZongMenPeopleMax()
self.discipleNumText:setText(FMT.fmt('{0}/{1}',cur,max))
self:refreshKickoutBtn()
end

function UIDiscipleSelectWin:refreshAllFightPanel()
local allFight=0
local discipleList=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(discipleList)do
local netData=v.netData.net
local fight=UIDiscipleModel:getDiscipleFightValueEx(netData)
allFight=allFight+fight
end
self.allDiscipleFight:setText(mathHelper.formatNumber3(allFight))
end

function UIDiscipleSelectWin:getNetDataList()
local list={}
local sortType=self.sortTypeList[self.sortTypeIndex]
local sortParams={[1]=true,[3]=true}
if self.param.disciples then
for i,v in ipairs(self.param.disciples)do
table.insert(list,UIDiscipleModel:getDiscipleDataX(v))
end
discipleLookup:sortList(list,sortType,self.sortOrder,sortParams)
else
list=discipleLookup:getSortDiscipleListEx(sortType,self.sortCondition,self.sortOrder,sortParams)
end
if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in ipairs(list)do
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

function UIDiscipleSelectWin:initRoleListPanel()
local list=self:getNetDataList()
if _useLoop then
self:initLoopRoleListPanel(list)
else
self:initNormalRoleListPanel(list)
end
end

function UIDiscipleSelectWin:initNormalRoleListPanel(list)
self.disciplesList=list
local dataNum=#self.disciplesList
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


function UIDiscipleSelectWin:initLoopRoleListPanel(list)
local dataNum=#list
self.disciplesList=list
self.roleListPanelEx:setActive(true)
self.roleListPanel:setActive(false)
self.winlua:SetChildScrollRectStopMovement(self.roleListPanelEx:getID())
self.winlua:SetChildLocalPosY(self.ContentEx:getID(),0)
self.loopTreeView:InitDataList(dataNum,'Item1')
local hasDZ=dataNum>0
self.noDZTips:setActive(not hasDZ)
end

function UIDiscipleSelectWin:startLoopAction()

end

function UIDiscipleSelectWin:freshLoopAction(i,item)
local index=i+1
self:refreshRoleItem(index,item)
end

function UIDiscipleSelectWin:refreshRoleItem(i,item)
local netdata=self.disciplesList[i].netData
local netData=netdata.net
local guid=netData.discipleguid
local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
local beibu=state==DISCIPLE_STATE_TYPE.eBeiBu

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

UIDiscipleModel:setDiscipleXianMoBackImage(item,28,netData)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(29,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,chuiwei,true)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)
local sortType=self.sortTypeList[self.sortTypeIndex]
if sortType==eDiscipleSortType.eJingJieSort then

item:SetChildActive(6,false)

local jjlv=netData.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}阶',n,p)
else
jj_str=n
end
item:SetChildText(4,jj_str)
elseif sortType==eDiscipleSortType.eLianTiSort then

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
elseif sortType==eDiscipleSortType.ePostSort then

item:SetChildActive(6,false)

local post_id=netData.pos
local post_name=eZongMenPostType.getName(post_id)
item:SetChildText(4,post_name)
elseif sortType==eDiscipleSortType.eFightSort or sortType==eDiscipleSortType.eColorSort then

item:SetChildActive(6,true)
local fight=UIDiscipleModel:getDiscipleFightValue(guid)
item:SetChildText(6,UIDiscipleModel:fightValueConversion(fight))

item:SetChildText(4,'')
else
local level=discipleLookup:getValueBySortType(guid,sortType)
local desc_str=discipleLookup:getValueDescBySortType(level,sortType,'<color=#7D3B17>{0}</color> {1}')
item:SetChildActive(6,false)
item:SetChildText(4,desc_str)
end

item:SetChildActive(8,not chuiwei and self.inputstr~=nil)
item:SetChildText(9,UIDiscipleModel:getDiscipleStateDesc(guid,' '))



item:SetChildActive(12,chuiwei)
item:SetChildActive(13,chuiwei)
item:SetChildActive(18,beibu)

local isnew=netdata.isnew==true
if isnew then self.hasNewDZ=true end
item:SetChildActive(7,isnew)

local isdujie=(not chuiwei)and UIDiscipleModel:checkJJReddot(guid)
item:SetChildActive(14,isdujie)


local isreddot=UIDiscipleModel:checkDiscipleSelectReddot(guid)or WenXinGuanModel:dzIsHaveReddot(guid)or UIDiscipleModel:checkDiscipleXianMoTransferReddot(guid)
item:SetChildActive(11,not isdujie and isreddot)

local showOrder=UIDiscipleModel:checkDZHasOrder(guid)
item:SetChildActive(15,showOrder)

local newbieName
local srctype=UIDiscipleModel:getDiscipleSrcType(guid)
if discipleSrcType:isPlot(srctype)then
newbieName=FMT.fmt('UIDiscipleSelectWin.discipleItemPlot_{0}',srctype)
else
newbieName=FMT.fmt('UIDiscipleSelectWin.discipleItem_{0}',i)
end
item:SetChildNewBieComponentId(-1,newbieName)

local func=function()
self:OnClickRoleItemCallback(1,i)
end
item:SetChildButtonClick(-1,func,true)

UIDiscipleController.refreshCommonItemTianMing(item,netData)

local isShuWUDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
item:SetChildActive(22,isShuWUDZ)
item:SetChildText(23,isShuWUDZ and'实'or'战')
if isShuWUDZ then
local shili=UIDiscipleModel:getShuWuFightValue(guid)
item:SetChildText(6,UIDiscipleModel:fightValueConversion(shili))

end

if not chuiwei then
local injury=UIDiscipleModel:getDiscipleInjury(guid)
local injuryIcon
local injuryDesc
local icon_=eInjuryType:getIcon(injury)
if icon_~=nil then
injuryIcon='icon_fushang'
injuryDesc=FMT.fmt('<color=#FD7474>{0}</color>',eInjuryType:getName(injury))
end
local showInjury=injuryIcon~=nil
item:SetChildActive(24,showInjury)
if showInjury then
item:SetChildCSImageSprite(25,globalABLookup.global,injuryIcon)
item:SetChildText(26,injuryDesc)
end
else
item:SetChildActive(24,false)
end

local dzId=UIDiscipleModel:getDiscipleID(guid)
local isLDDZ=liandonModel:getLianDonLinkageIdByDZId(dzId)>0
item:SetChildActive(27,isLDDZ)
end


function UIDiscipleSelectWin:OnClickRoleItemCallback(clicknum,index)





local args=table.deepCopy(self.param)


local dzData=self.disciplesList[index]
local netdata=dzData.netData.net

self.clickDZClose=true
if not _useLoop then
local item=self.roleListPanel:getChildScrollViewItemWidget(index-1)
item:SetChildActive(7,false)
else
local item=self.loopTreeView:GetItemWidget(index-1)
item:SetChildActive(7,false)
end

local list=self:getNetDataList()
local itemid=self.param.itemid
UIFullDiscipleMainControl:showWindowInfo({dis_guid=netdata.discipleguid,disciplelist=list,itemid=itemid})

args.itemid=nil
args.recordSortCondition=true
args.recordIInputstr=self.inputstr
local func=function(args_)
UIFullDiscipleSelectControl:showDiscipleSelectWindow(args_)
end
fullScreenUI.setNextActiveUICallback(func,args)
end

function UIDiscipleSelectWin:onDropdownChange(idx)

if self.lockRefresh then return end
idx=idx+1
self.sortTypeIndex=idx
UIDiscipleModel:setSaveSortType(idx)

self:clearSearchInput()
self:initRoleListPanel()
end

function UIDiscipleSelectWin:onSortConditionClick()
local filterName,filterFlag=discipleLookup:getConditonFilterEx(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')

args.extraWin='UIFilterThreeWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end

function UIDiscipleSelectWin.selecConditionBack(data)

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

UIDiscipleModel:setSaveSortCondition(table.deepCopy(_this.sortCondition))

_this:clearSearchInput()
_this:initRoleListPanel()
end

function UIDiscipleSelectWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:initRoleListPanel()
end

function UIDiscipleSelectWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then

self:initRoleListPanel()
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

UIManager.info('暂无符合条件的弟子')
return
end
self.searchInput:setInputFieldValue('')
self:initRoleListPanel(list)
end

function UIDiscipleSelectWin:onSearchCancelBtn()
if self.inputstr==nil then return end

self.inputstr=nil
self:clearSearchInput()
self:initRoleListPanel()
end

function UIDiscipleSelectWin:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIDiscipleSelectWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIDiscipleSelectWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function UIDiscipleSelectWin:onTestBtnClick()
local sortCondition=table.deepCopy(self.sortCondition)
local sortType=self.sortTypeList[self.sortTypeIndex]
UIManager:showWindow('UIDiscipleGUIDCopylWin',{sortCondition=sortCondition,sortOrder=self.sortOrder,sortType=sortType})
end

function UIDiscipleSelectWin:onTestAttrBtnClick()
UIManager:showWindow('UIDiscipleAttrLookWin')
end

function UIDiscipleSelectWin:refreshKickoutBtn()
local islock=not zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eShuWuDian)
self.kickoutLock:setActive(islock)
end

function UIDiscipleSelectWin:onKickoutBtn()
if not zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eShuWuDian)then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eShuWuDian)
UIManager.error(FMT.fmt('{0}级建造{1}后可用',cfg.show_level,cfg.name))
return
end
UIFullShuWuDianControl:showMyWindowEx(FULL_TAB_TYPE.eShuWuDianKickout,{})
end

function UIDiscipleSelectWin:onDzCreateImageBtn()
UIManager:showWindow('UIDZCreateImageWin')
end
