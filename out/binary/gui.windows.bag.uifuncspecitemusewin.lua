







def_class("UIFuncSpecItemUseWin",UIWindowBase)









function UIFuncSpecItemUseWin:bindComponents()

self.root=UIObject.get(self,0)
self.testRoot=UIObject.get(self,1)
self.dzCreateImageBtn=UIButton.get(self,2)
self.roleListPanel=UIObject.get(self,3)
self.sortTypeDropdown=UIDropdown.get(self,4)
self.discipleNumText=UIText.get(self,5)
self.searchInput=UIInputField.get(self,6)
self.noDZTips=UIObject.get(self,7)
self.kickoutBtn=UIButton.get(self,8)
self.searchBtn=UIButton.get(self,9)
self.searchCancelBtn=UIButton.get(self,10)
self.kickoutLock=UIObject.get(self,11)
self.descListPanel=UIObject.get(self,12)
self.back=UIObject.get(self,13)
self.proName=UIText.get(self,15)
self.proNamelast=UIText.get(self,16)
self.proExpProgressbar=UIProgressBarAni.get(self,17)
self.proAddExp=UIProgressBarAni.get(self,18)
self.progressText=UIText.get(self,19)
self.normalItemScrollview=UIObject.get(self,20)
self.proName2=UIText.get(self,21)
self.proNamelast2=UIText.get(self,22)
self.proExpProgressbar2=UIProgressBarAni.get(self,23)
self.proAddExp2=UIProgressBarAni.get(self,24)
self.progressText2=UIText.get(self,25)
self.useButton=UIButton.get(self,26)
self.uipanelr=UIObject.get(self,27)
self.proSkillInfo=UIObject.get(self,28)
self.proSkillInfo2=UIObject.get(self,29)

self.dzCreateImageBtn:setButtonClick(function()self:onDzCreateImageBtn()end)

self.kickoutBtn:setButtonClick(function()self:onKickoutBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)

self.useButton:setButtonClick(function()self:onUseButton()end)



end


function UIFuncSpecItemUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.testRoot);self.testRoot=nil;
_UIObject_release(self.dzCreateImageBtn);self.dzCreateImageBtn=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.discipleNumText);self.discipleNumText=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.noDZTips);self.noDZTips=nil;
_UIObject_release(self.kickoutBtn);self.kickoutBtn=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.kickoutLock);self.kickoutLock=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.proName);self.proName=nil;
_UIObject_release(self.proNamelast);self.proNamelast=nil;
_UIObject_release(self.proExpProgressbar);self.proExpProgressbar=nil;
_UIObject_release(self.proAddExp);self.proAddExp=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.normalItemScrollview);self.normalItemScrollview=nil;
_UIObject_release(self.proName2);self.proName2=nil;
_UIObject_release(self.proNamelast2);self.proNamelast2=nil;
_UIObject_release(self.proExpProgressbar2);self.proExpProgressbar2=nil;
_UIObject_release(self.proAddExp2);self.proAddExp2=nil;
_UIObject_release(self.progressText2);self.progressText2=nil;
_UIObject_release(self.useButton);self.useButton=nil;
_UIObject_release(self.uipanelr);self.uipanelr=nil;
_UIObject_release(self.proSkillInfo);self.proSkillInfo=nil;
_UIObject_release(self.proSkillInfo2);self.proSkillInfo2=nil;
end
















local _this=nil

function UIFuncSpecItemUseWin:onLoaded(...)
self:bindComponents()
_this=self


notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
local _OnClickRoleItemCallback=function(...)

end
self.onClickUseItem=function(...)
self:onClickUseItemCallback(...)
end
self.onLongClickUseItemCallBack=function(...)
self:onLongClickUseItem(...)
end
self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,nil)
self.curDzIdx=1
self.selectIndex=1
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
local repeatType=REPEAT_TYPE.eUseExpByAbsorbExp
local clickCount=0
local cb=function(idx)
clickCount=clickCount+1
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,repeatType)
if flag then
clickCount=0
else
if clickCount>1 then return end
end
local func=function()
clickCount=0
if not self or self.isClose then return end
self:onGoodUpBtnClick()
end
local disciple_guid=_this:getCurSelectDzGuid()
local absorbExpRate=fabaoModel.getAbsorbExpRate(disciple_guid)
local isOldUse=self:getIsOldUse()
if absorbExpRate>0 and not isOldUse then
local cancelfunc=function()clickCount=0 end
local closecallback=function()clickCount=0 end
local desc=FMT.fmt('本命法宝蕴养中，50%的丹药修为将被法宝吸收，确定要使用吗？\n<color=#ca631d>（丹药显示的修为值已扣除50%）</color>')
self.dialogue=UIDialogManager.getConfirmDialog3(self.dialogue,desc,func,repeatType,cancelfunc,closecallback)
else
func()
end
end

local fncb=function(idx)
self:onGoodUpBtnClick_fn()
end
self.winlua:SetChildLongPress(self.useButton:getID(),1,cb,fncb)
end


function UIFuncSpecItemUseWin:__delete()
self:unbindComponents()

self:clearAllDZNewSign()


notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
_this=nil
end

function UIFuncSpecItemUseWin:onHide()
self.nameSearchList=nil
self:clearAllDZNewSign()
end

function UIFuncSpecItemUseWin:clearAllDZNewSign()

if self.hasNewDZ==true and self.clickDZClose~=true then
UIDiscipleModel:clearAllDZNewSign()
end
self.hasNewDZ=nil
self.clickDZClose=nil
end

function UIFuncSpecItemUseWin:doFadeIn(delay,duration)
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




function UIFuncSpecItemUseWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
local itemid=argtable.itemid
local funcType=argtable.type
self.skillid=argtable.skillid
self.disciple_guid=argtable.disguid
if itemid then
self.selectItemid=itemid
self.itemConfig=itemsConfig.getConfig(itemid)
end

self.param=argtable
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end
self.nameTypeList={eDiscipleSortType.eFightSort,eDiscipleSortType.eJingJieSort,eDiscipleSortType.eLianTiSort,eDiscipleSortType.eColorSort}
self.sortTypeDropdown:setOption(eDiscipleSortTypeName:getName2List2(self.nameTypeList))
if argtable.sortType~=nil then
self.sortType=argtable.sortType
UIDiscipleModel:setSaveSortType(self.sortType)
else
self.sortType=UIDiscipleModel:getSaveSortType()
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
self.sortTypeDropdown:setValue(self.sortType-1)
self.lockRefresh=false

local recordIInputstr=argtable.recordIInputstr
if recordIInputstr~=nil then
self.inputstr=recordIInputstr
else
self.inputstr=nil
end

self:initItemPanel(true,itemid)
self:initRoleListPanel()
self:refreshInputBtns()
end

function UIFuncSpecItemUseWin:getNetDataList()
local list={}
local sortParams={}
if self.param.disciples then
for i,v in ipairs(self.param.disciples)do
table.insert(list,UIDiscipleModel:getDiscipleDataX(v))
end
discipleLookup:sortList(list,self.sortType,self.sortOrder,sortParams)
else
list=discipleLookup:getSortDiscipleList(self.sortType,self.sortCondition,self.sortOrder,sortParams)
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

function UIFuncSpecItemUseWin:initRoleListPanel()
local list=self:getNetDataList()
self:freshRoleListPanel(list,true)
end


function UIFuncSpecItemUseWin:freshRoleListPanel(list,init)
self.curDzIdx=1
self:initRoleListPanelEx(list)

if list and#list>0 then
self.uipanelr:setActive(true)
self:refreshtezhi()

if init then
self:refreshjinjie(true)
self:refreshlianti(true)
else
self:refreshjinjie(nil,true)
self:refreshlianti(nil,true)
end
self:freshBtnGray()
else
self.uipanelr:setActive(false)
end
end

function UIFuncSpecItemUseWin:initRoleListPanelEx(list)
self.disciplesList=list
local dataNum=#self.disciplesList
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,3)
local hasDZ=dataNum>0
self.hasNewDZ=nil
if hasDZ then
local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local netdata=self.disciplesList[i].netData
local netData=netdata.net
local guid=netData.discipleguid
local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
local beibu=state==DISCIPLE_STATE_TYPE.eBeiBu
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
if self.sortType==eDiscipleSortType.eJingJieSort then

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
elseif self.sortType==eDiscipleSortType.eLianTiSort then

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
elseif self.sortType==eDiscipleSortType.ePostSort then

item:SetChildActive(6,false)

local post_id=netData.pos
local post_name=eZongMenPostType.getName(post_id)
item:SetChildText(4,post_name)
else

item:SetChildActive(6,true)
item:SetChildText(6,UIDiscipleModel:getDiscipleFightValue(guid))

item:SetChildText(4,'')
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


local isreddot=UIDiscipleModel:checkDiscipleSelectReddot(guid)
item:SetChildActive(11,not isdujie and isreddot)

local showOrder=UIDiscipleModel:checkDZHasOrder(guid)
item:SetChildActive(15,showOrder)

local newbieName
local srctype=UIDiscipleModel:getDiscipleSrcType(guid)
if discipleSrcType:isPlot(srctype)then
newbieName=FMT.fmt('UIFuncSpecItemUseWin.discipleItemPlot_{0}',srctype)
else
newbieName=FMT.fmt('UIFuncSpecItemUseWin.discipleItem_{0}',i)
end
item:SetChildNewBieComponentId(-1,newbieName)

local func=function()
self:OnClickRoleItemCallback(1,i)
end
item:SetChildButtonClick(-1,func,true)

item:SetChildActive(20,i==self.curDzIdx)

UIDiscipleController.refreshCommonItemTianMing(item,netData)

local isShuWUDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
item:SetChildActive(22,isShuWUDZ)
item:SetChildText(23,isShuWUDZ and'实'or'战')
if isShuWUDZ then
local shili=UIDiscipleModel:getShuWuFightValue(guid)
item:SetChildText(6,shili)
end
end
end
self.noDZTips:setActive(not hasDZ)
end


function UIFuncSpecItemUseWin:OnClickRoleItemCallback(clicknum,index)

if self.curDzIdx==index then return end
self.lastDzIndex=self.curDzIdx
self.curDzIdx=index
local lastWidget=self.roleListPanel:getChildScrollViewItemWidget(self.lastDzIndex-1)
local widget=self.roleListPanel:getChildScrollViewItemWidget(self.curDzIdx-1)
lastWidget:SetChildActive(20,false)
widget:SetChildActive(20,true)

self:refreshtezhi()
self:refreshjinjie(nil,true)
self:refreshlianti(nil,true)
self:freshBtnGray()
end

function UIFuncSpecItemUseWin:onDropdownChange(idx)

if self.lockRefresh then return end
idx=idx+1
self.sortType=idx
UIDiscipleModel:setSaveSortType(idx)

self:clearSearchInput()
self:initRoleListPanel()
end
function UIFuncSpecItemUseWin:onSortConditionClick()
local filterName,filterFlag=discipleLookup:getConditonFilter(self.sortCondition)

self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')

args.extraWin='UIFilterThreeWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end
function UIFuncSpecItemUseWin.selecConditionBack(data)

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
function UIFuncSpecItemUseWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:initRoleListPanel()
end
function UIFuncSpecItemUseWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
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
self.inputstr=nil
UIManager.info('暂无符合条件的弟子')
return
end
self.searchInput:setInputFieldValue('')
self:freshRoleListPanel(list)
end
function UIFuncSpecItemUseWin:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:initRoleListPanel()
end
function UIFuncSpecItemUseWin:onSearchChange(str)
self:refreshInputBtns(str)
end
function UIFuncSpecItemUseWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end
function UIFuncSpecItemUseWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end


function UIFuncSpecItemUseWin:onTestBtnClick()


end
function UIFuncSpecItemUseWin:onTestAttrBtnClick()

end
function UIFuncSpecItemUseWin:onKickoutBtn()






end


function UIFuncSpecItemUseWin.setUseRecordData()
local netdata=_this.disciplesList[_this.curDzIdx].netData
_this.useDzGuidStr=netdata.net.discipleguidStr
_this.useItemid=_this.selectItemid
end


function UIFuncSpecItemUseWin:getIsOldUse()
local netdata=_this.disciplesList[_this.curDzIdx].netData
local guidStr=netdata.net.discipleguidStr

return _this.useDzGuidStr==guidStr and _this.useItemid==_this.selectItemid
end


function UIFuncSpecItemUseWin:getCurSelectDzGuid()
local netdata=_this.disciplesList[_this.curDzIdx].netData
local guid=netdata.net.discipleguid
return guid
end


function UIFuncSpecItemUseWin:refreshjinjie(init,reverse)

local disciple_guid=self:getCurSelectDzGuid()

local jjlv,point,curjjexp,nxjjexp=UIDiscipleModel:getDiscipleJJLevelAndPoint2(disciple_guid)
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local str_1=''
if p~=nil then
str_1=FMT.fmt('{0}{1}',n,pN)
else
str_1=n
end
self.proNamelast:setText(str_1)


local isfull=UIDiscipleModel:checkJJLevelFull(jjlv)
if isfull then
curjjexp=1
nxjjexp=1
else
if curjjexp>nxjjexp then
curjjexp=nxjjexp
end
end
local exp_str=''
if not isfull then
exp_str=FMT.fmt('{0}/{1}',curjjexp,nxjjexp)
else
exp_str='已满级'
end

local curexp=curjjexp
local maxexp=nxjjexp
local allAddValue=self:getitemExp(disciple_guid)
if init then
self.proAddExp:animateThreeParams(curexp+allAddValue,maxexp,0)
self.proExpProgressbar:animateThreeParams(curexp,maxexp,0)
else
if reverse then
self.proAddExp:animateFourParams(curexp+allAddValue,maxexp,0.5,reverse)
else
self:useHideAddProgress(curexp,maxexp,allAddValue)
end
self.proExpProgressbar:animateFourParams(curexp,maxexp,0.5,reverse)
end
local progressStr=''
if isfull then
progressStr='已满级'
self.proExpProgressbar:animateThreeParams(maxexp,maxexp,0)
else
if curexp>=maxexp then
progressStr=FMT.fmt('{0}/{1}',maxexp,maxexp)
else
if allAddValue>0 then
progressStr=FMT.fmt('{0}<color=#8bf341>（+{1}）</color>/{2}',curexp,allAddValue,maxexp)
else
progressStr=FMT.fmt('{0}/{1}',curexp,maxexp)
end
end
end
self.progressText:setText(progressStr)
end

function UIFuncSpecItemUseWin:refreshlianti(init,reverse)

local disciple_guid=self:getCurSelectDzGuid()
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
local ltlv=netData.liantilv
local n,p,pN=UIDiscipleModel:getLTNameX(ltlv)
local nxltexp=cfgHelper.get2(cfg_disciplelianticonfig_get,ltlv,'exp')
local str_lt=FMT.fmt('{0}{1}',n,pN)
self.proNamelast2:setText(str_lt)

local ltexp=netData.liantiexp
local isfull=false
if nxltexp<=0 then
isfull=true
end
if isfull then
ltexp=1
nxltexp=1
else
if ltexp>nxltexp then
ltexp=nxltexp
end
end
local exp_str=''
if not isfull then
exp_str=FMT.fmt('{0}/{1}',ltexp,nxltexp)
else
exp_str='已满级'
end

local curexp=ltexp
local maxexp=nxltexp
local allAddValue=self:getitemLianTiExp(disciple_guid)
if init then
self.proAddExp2:animateThreeParams(curexp+allAddValue,maxexp,0)
self.proExpProgressbar2:animateThreeParams(curexp,maxexp,0)
else
if reverse then
self.proAddExp2:animateFourParams(curexp+allAddValue,maxexp,0.5,reverse)
else
self:useHideAddProgress(curexp,maxexp,allAddValue)
end
self.proExpProgressbar2:animateFourParams(curexp,maxexp,0.5,reverse)
end
local progressStr=''
if isfull then
progressStr='已满级'
self.proExpProgressbar2:animateThreeParams(maxexp,maxexp,0)
else
if curexp>=maxexp then
progressStr=FMT.fmt('{0}/{1}',maxexp,maxexp)
else
if allAddValue>0 then
progressStr=FMT.fmt('{0}<color=#8bf341>（+{1}）</color>/{2}',curexp,allAddValue,maxexp)
else
progressStr=FMT.fmt('{0}/{1}',curexp,maxexp)
end
end
end
self.progressText2:setText(progressStr)
end


function UIFuncSpecItemUseWin:getitemExp(disciple_guid)
local addexp=0
if _this.itemList and#_this.itemList>0 then
local itemid=_this.itemList[_this.selectIndex].id
local itemConfig=itemsConfig.getConfig(itemid)
local itemID=itemConfig.id

local funcparam=itemConfig.funcparam
local curexp=funcparam.exp
if itemsLookup:checkItemFuncType(itemID,item_funtion_type.jj_xiuweidan)then
addexp=UIDiscipleModel:calculationJJMedicineGrow(disciple_guid,curexp,itemID)
end
end
return addexp
end

function UIFuncSpecItemUseWin:getitemLianTiExp(disciple_guid)
local addexp=0
if _this.itemList and#_this.itemList>0 then
local itemid=_this.itemList[_this.selectIndex].id
local itemConfig=itemsConfig.getConfig(itemid)
local itemID=itemConfig.id
local funcparam=itemConfig.funcparam
local curexp=funcparam.exp
if itemsLookup:checkItemFuncType(itemID,item_funtion_type.lt_jingyandan)then
addexp=UIDiscipleModel:calculationLTMedicineGrow(disciple_guid,curexp,itemID)
end
end
return addexp
end
function UIFuncSpecItemUseWin:useHideAddProgress(curexp,maxexp,allAddValue)
if self.progressTimer1 then
self:stopTimerByID(self.progressTimer1)
self.progressTimer1=nil
end
self.proAddExp:animateThreeParams(0,maxexp,0)
self.progressTimer1=self:delayDo(0.8,function()
self.proAddExp:animateThreeParams(curexp+allAddValue,maxexp,0)
end)
end


function UIFuncSpecItemUseWin:refreshtezhi()
local disciple_guid=self:getCurSelectDzGuid()
self.desclist=UIDiscipleModel:getDiscipleSpecialityConfig(disciple_guid,true)
local dataNum=#self.desclist
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local cfg=self.desclist[i]
local item=gridlist[i-1]
item:SetChildActive(-1,true)
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onDescSlotClick(i,disciple_guid)
end)
end
end

local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
if UIDiscipleModel:isShuWuDisciple(netData.id)then
_this.proSkillInfo2:setActive(false)
else
_this.proSkillInfo2:setActive(true)
end
end

function UIFuncSpecItemUseWin:onDescSlotClick(idx,disciple_guid)
local cfg=self.desclist[idx]
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
if UIDiscipleModel.onClickClientSpeciality(item,netData,cfg,eDirectionType.eLeft)then
return
end
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=disciple_guid,config=cfg})
end


function UIFuncSpecItemUseWin:initItemPanel(init,itemid)
if init then
self.itemsScrollview=self.normalItemScrollview
self.itemsScrollview:setChildScrollViewInit(-1,true,self.onClickUseItem,self.onLongClickUseItemCallBack)
end
_this:refreshItemPanel(true,itemid)
end

function UIFuncSpecItemUseWin:refreshItemPanel(reset,_itemid)
_this:sortShowItems(reset,_itemid)
local length=#_this.itemList
local num=length
if length<6 then
num=6
end
_this.itemsScrollview:setChildScrollViewCreateGrids(num,num)
local grids=_this.itemsScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
if _this.itemList[i]then
local itemid=_this.itemList[i].id
local have=bagModel.getItemCountById(itemid)
local conf={itemid=itemid,itemcount=have,showCountBG=true}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetPropData(propData)
item:SetChildActive(8,_this.selectIndex==i)
else
local propData=itemsComponentHelper.getCommonTempDataSmall()
propData[PropIndex(DataPropKey.eWidgetActive,9)]=true
item:SetPropData(propData)
end
end
end
self.itemsScrollview:setChildScrollRectEnable(false)
self.itemsScrollview:setChildScrollViewSelectItem(_this.selectIndex-1,false,false,false)
self.itemsScrollview:setChildScrollRectEnable(true)
end

function UIFuncSpecItemUseWin:sortShowItems(reset,_itemid)
local filter={}
filter[ITEM_FILTER_TYPE.eIsSpecialWire]={ITEM_FILTER_COMPARE.eEquals,{100}}
local itemList=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter)or{}

local showList={}
for k,v in pairs(itemList)do
local cfg=itemsConfig.getConfig(v.itemid)
local num=bagModel.getItemCountById(cfg.id)
if num>0 then
table.insert(showList,cfg)
local item=showList[#showList]
if item then
local stage=cfg.stage or 0
stage=stage*1000000
local color=cfg.color*10000
item.sortTag=stage+color+cfg.id
end
end
end
table.sort(showList,function(a,b)return a.sortTag>b.sortTag end)
self.itemList=showList

for i,v in ipairs(showList)do
v.sortTag=nil
if self.selectIndex==nil and v.id==self.selectItemid then
self.selectIndex=i
end
end
self.maxUseCnt=0
if#showList>0 then
if self.selectIndex==nil or reset then
self.selectIndex=1
self.selectItemid=showList[self.selectIndex].id
end
if self.selectItemid==nil then
self.selectItemid=showList[self.selectIndex].id
end
if _itemid then
for k,v in ipairs(showList)do
if v.id==_itemid then
self.selectIndex=k
self.selectItemid=showList[self.selectIndex].id
end
end
end
self.itemConfig=itemsConfig.getConfig(self.selectItemid)
end
end


function UIFuncSpecItemUseWin:onGoodUpBtnClick()
local disciple_guid=self:getCurSelectDzGuid()

if _this.itemList and#_this.itemList==0 then
return
end
local itemid=_this.itemList[_this.selectIndex].id
local itemConfig=itemsConfig.getConfig(itemid)
local curItemType=itemConfig.funcparam.type
if curItemType==item_funtion_type.jj_xiuweidan then
if not self:checkGoodUpUseCondition(self.selectIndex,itemid,disciple_guid)then
self:stopItemLongPress()
return
end
elseif curItemType==item_funtion_type.lt_jingyandan then
if not self:checkGoodUpUseConditionLT(self.selectIndex,itemid,disciple_guid)then
self:stopItemLongPress()
return
end
end

local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=10 then
num=100
elseif lerp>=6 then
num=50
elseif lerp>=3 then

num=10
elseif lerp>=2 then

num=5
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
local max=bagModel.getItemCountById(itemid)
if num>max then
num=max
end
self.useItemID=itemid
self.usediziID=disciple_guid

if curItemType==item_funtion_type.jj_xiuweidan then
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
local jingjielv=netData.jingjielv
local cfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,jingjielv)
local curjjexp=UIDiscipleModel:calculationJJExp(disciple_guid)
local nxjjexp=cfg.exp
if curjjexp<nxjjexp then
_this.ispiaozi=true
end
end
local isOldUse=self:getIsOldUse()
bagProtocolControl.req_dizi_use_item(disciple_guid,itemid,num,isOldUse,self.setUseRecordData)
end
function UIFuncSpecItemUseWin:stopItemLongPress(idx)





_this.winlua:SetChildLongPressStop(_this.useButton:getID())
end
function UIFuncSpecItemUseWin:onGoodUpBtnClick_fn()
self.useGoodTime=nil
self:recordClickCount()
end
function UIFuncSpecItemUseWin:recordClickCount()
if self.clickTime==nil or(Time.realtimeSinceStartup-self.clickTime<0.5)then
self.clickCount=self.clickCount==nil and 1 or(self.clickCount+1)
else
self.clickCount=0
end
if self.clickCount>=5 then
self.clickCount=0



end
self.clickTime=Time.realtimeSinceStartup
end


function UIFuncSpecItemUseWin:checkGoodUpUseCondition(idx,itemID,disciple_guid)

if not itemsLookup:checkSatiety(disciple_guid,itemID,true)then
return false
end
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
local jingjielv=netData.jingjielv
local cfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,jingjielv)
local curjjexp=UIDiscipleModel:calculationJJExp(disciple_guid)
local nxjjexp=cfg.exp

local isSpecWine
local itemConfig=itemsConfig.getConfig(itemID)
local funcparam=itemConfig.funcparam
if funcparam then
isSpecWine=funcparam.SpecWine
end

if nxjjexp<=0 and not isSpecWine then
UIManager.error('境界已满')
return false
end

local state=UIDiscipleModel:getDiscipleState(disciple_guid)
if state and state==DISCIPLE_STATE_TYPE.eChuiWei then
UIManager.error('弟子寿元已尽，请先救济')
return false
end

local fix,cond=itemsLookup:checkDicipleUseItemCondition(disciple_guid,itemID)

if not fix then
if cond then
local item=self.itemsScrollview:getChildScrollViewItemWidget(idx-1)
local pos=Vector2.New(0,30)
local cond_str=UIDiscipleModel:getUseGoodStr(cond)
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
end
return false
end

if curjjexp>=nxjjexp and not isSpecWine then
if UIDiscipleModel:checkNextJJNeedBroke(jingjielv)then
if UIDiscipleModel:checkJJBrokeByHand(jingjielv)then
UIManager.error('需要突破境界')
return false
else
FeiShengTaiController.sendJingJieBroke(disciple_guid)
end
else
UIDiscipleController:requireRefreshDiscipleInfo(disciple_guid)
end
end

local useItemFunc=function()
if _this==nil then return end
_this.useItemID=itemID
_this.usediziID=disciple_guid
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
local jingjielv=netData.jingjielv
local cfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,jingjielv)
local curjjexp=UIDiscipleModel:calculationJJExp(disciple_guid)
local nxjjexp=cfg.exp
if curjjexp<nxjjexp then
_this.ispiaozi=true
end
local isOldUse=_this:getIsOldUse()
return bagProtocolControl.req_dizi_use_item(disciple_guid,itemID,1,isOldUse,_this.setUseRecordData)
end
local dzName=UIDiscipleModel:getDiscipleColorName(disciple_guid)
local itemName=itemsConfig.getColorName(itemID)
local itemCfg=itemsHelper:get_item_config(itemID)
local checkSpecialityFunc=function()

local isAddSpeciality=false
local specialityTypeList={}
local specialityList={}
local funcparam=itemCfg.funcparam
local extraList=funcparam and funcparam.extra or{}
for i,v in ipairs(extraList)do
if v[2][5]then
local list=v[2][5][2]or{}
for _,specialityItem in ipairs(list)do
local specialityType=specialityItem[1]
table.insert(specialityTypeList,specialityType)
for _,specialityId in ipairs(specialityItem[2])do
table.insert(specialityList,{specialityType,specialityId})
end
end
end
end
isAddSpeciality=specialityTypeList and next(specialityTypeList)or false
if isAddSpeciality then
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eItemHideFullSpecialityTipsDialog)
local isHideFullSpecialityTipsDialog=check or _this.finishCheckSpecialityItemID==itemID
if isHideFullSpecialityTipsDialog then

return true
end

local isFullSpeciality=false
local fullType
local spName
for i,v in ipairs(specialityTypeList)do
local specialityType=v
if specialityType==DISCIPLE_SPECIALITY_TYPE.eTalent then

local isMax=UIDiscipleModel.checkSpecialtyCountMax(specialityType,disciple_guid)
if isMax then
isFullSpeciality=true
fullType=DISCIPLE_SPECIALITY_TYPE.eTalent
break
end
elseif specialityType==DISCIPLE_SPECIALITY_TYPE.eBody then

local isMax=UIDiscipleModel.checkSpecialtyCountMax(specialityType,disciple_guid)
if isMax then
local list=UIDiscipleModel:getDiscipleSpeciality(disciple_guid,specialityType)
spName=UIDiscipleModel:getSpecialityName(specialityType,list[1].param_1)
fullType=DISCIPLE_SPECIALITY_TYPE.eBody
isFullSpeciality=true
break
end
elseif specialityType==DISCIPLE_SPECIALITY_TYPE.eStrange then

local isMax=UIDiscipleModel.checkSpecialtyCountMax(specialityType,disciple_guid)
if isMax then
isFullSpeciality=true
fullType=DISCIPLE_SPECIALITY_TYPE.eStrange
break
end
end
end
if isFullSpeciality and not isHideFullSpecialityTipsDialog then

local contentStr
if fullType==DISCIPLE_SPECIALITY_TYPE.eTalent then
local notSpeaceItemName=string.replaceSpace(itemName)
contentStr=FMT.fmt("弟子{0}拥有的天赋数量已达上限，使用{1}不会再获得天赋，确定要使用吗？",dzName,notSpeaceItemName)
elseif fullType==DISCIPLE_SPECIALITY_TYPE.eBody then
local colorName=FMT.cfmt(FONT_COLOR.ePurpleColor,spName)
contentStr=FMT.fmt("弟子{0}已经拥有{1}，无法再获得新的体质了，使用可能会浪费道具的效果\n确定要使用吗？",dzName,colorName)
elseif fullType==DISCIPLE_SPECIALITY_TYPE.eStrange then
local notSpeaceItemName=string.replaceSpace(itemName)
contentStr=FMT.fmt("弟子{0}拥有的怪癖数量已达上限，使用{1}不会再获得怪癖，确定要使用吗？",dzName,notSpeaceItemName)
end
local okcallback=function(...)
_this.finishCheckSpecialityItemID=itemID
useItemFunc()
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,REPEAT_TYPE.eItemHideFullSpecialityTipsDialog)
return false
end
end
return true
end

local reconfirmType=itemCfg.reconfirmType
local repeat_type=UIFuncItemUseModel.checkReconfirmType(reconfirmType)

local reconfirmText=itemCfg.reconfirmText
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,repeat_type)
local isdizi=mathHelper.compareInt64(disciple_guid,self.usediziID)
local istips=self.useItemID==itemID and isdizi
local isHideReconfirmDialog=check or istips
if self.useItemID~=itemID or not isdizi then
self.checkNextUseSameItem=nil
end

local newStr=self:judeStrangeChangeText(funcparam,disciple_guid,itemCfg)
if newStr then
reconfirmText=newStr
end
local _fun=function(iscallback)

if reconfirmText then

local isShowDialog=not isHideReconfirmDialog
local showAttrText=""
local has6AttrCondition,conditionList=UIFuncItemUseModel:checkHasBase6AttrCondition(disciple_guid,itemID,true)
if has6AttrCondition then
local tempCheckNextUseSameItemFlag=false
for _,v in ipairs(conditionList)do
local attrName=UIDiscipleModel:getDiscipleBaseAttrName(v.attrType)
showAttrText=FMT.fmt("{0}\n<size=26>弟子基础{1}：<color=#ca631d>{2}</color></size>",showAttrText,attrName,v.actuallyAttr)
if v.actuallyAttr>=v.minAttr and v.actuallyAttr<=v.maxAttr then
tempCheckNextUseSameItemFlag=true
elseif self.checkNextUseSameItem and v.actuallyAttr>v.maxAttr then
isShowDialog=true
self.checkNextUseSameItem=nil
end
end
if tempCheckNextUseSameItemFlag then
self.checkNextUseSameItem=true
end
end
if self:isAddSpecialityItem(itemID,DISCIPLE_SPECIALITY_TYPE.eBody)then
local contentStr=FMT.fmt("{0}{1}",reconfirmText,showAttrText)
local okcallback=function(...)
if checkSpecialityFunc()then
return useItemFunc()
end
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback)
return false
end
if isShowDialog then
local contentStr=FMT.fmt("{0}{1}",reconfirmText,showAttrText)
local okcallback=function(...)
if checkSpecialityFunc()then
return useItemFunc()
end
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,repeat_type)
return false
end
end
if not checkSpecialityFunc()then
return false
end
if iscallback then
return useItemFunc()
else
return true
end
end
local isOldUse=_this:getIsOldUse()

if isSpecWine and curjjexp>=nxjjexp and isOldUse then
local contentStr="弟子当前境界<color=#CB6A28>经验已满</color>，使用将只获得道具效果而不获得境界经验，是否继续使用？"
local okcallback=function(...)
if checkSpecialityFunc()then
return _fun(true)
end
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback)
return false
else
return _fun()
end
return true
end

function UIFuncSpecItemUseWin:judeStrangeChangeText(funcparam,disciple_guid,itemCfg)
if not funcparam then
return
end
local extra=funcparam.extra
if extra then
local movetype=extra[1][2][6]

if movetype then
local tzid=movetype[2][1][1]
if tzid==DISCIPLE_SPECIALITY_TYPE.eStrange then
local flag=self:judeHaveCanDeleteTeZhi(DISCIPLE_SPECIALITY_TYPE.eStrange,disciple_guid)
if not flag then
local str=string.format("道具<color=%s><%s></color>无法消除该弟子身上持有的怪癖\n确定要继续使用吗？",FONT_COLOR_VAL[itemCfg.color],itemCfg.name)
return str
end
end
end
end
return
end


function UIFuncSpecItemUseWin:judeHaveCanDeleteTeZhi(tzType,guid)

local list=UIDiscipleModel:getDiscipleSpeciality(guid,tzType)
if not list then

return true
end
if#list>0 then
for k,v in ipairs(list)do
local forgetConfig=courtroomModel.getForgetConfig(tzType,v.param_1)
if forgetConfig then

return true
end
end
end

return false
end


function UIFuncSpecItemUseWin:isAddSpecialityItem(itemID,temptype)
local itemCfg=itemsHelper:get_item_config(itemID)
local isAddSpeciality=false
local funcparam=itemCfg.funcparam
local extraList=funcparam and funcparam.extra or{}
for i,v in ipairs(extraList)do
if v[2][5]then
local list=v[2][5][2]or{}
for _,specialityItem in ipairs(list)do
local specialityType=specialityItem[1]
if temptype==specialityType then
isAddSpeciality=true
break
end
end
end
end
return isAddSpeciality
end

function UIFuncSpecItemUseWin:checkGoodUpUseConditionLT(idx,itemID,disciple_guid)
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
local ltlv=netData.liantilv
local cfg=cfgHelper.get1(cfg_disciplelianticonfig_get,ltlv)
local ltexp=netData.liantiexp
local nxltexp=cfg.exp

local isSpecWine
local itemConfig=itemsConfig.getConfig(itemID)
local funcparam=itemConfig.funcparam
if funcparam then
isSpecWine=funcparam.SpecWine
end
if UIDiscipleModel:isShuWuDisciple(netData.id)then
local item=self.itemsScrollview:getChildScrollViewItemWidget(idx-1)
local pos=Vector2.New(0,30)
local cond_str="庶务弟子不能使用本道具"
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
return false
end

if nxltexp==0 and not isSpecWine then
UIManager.error('炼体已满级')
return false
end

if ltexp>=nxltexp and not isSpecWine then
if cfg.consume~=nil then
UIManager.error('炼体等级已达上限，请先完成突破！')
return false
end
end

local state=UIDiscipleModel:getDiscipleState(disciple_guid)
if state and state==DISCIPLE_STATE_TYPE.eChuiWei then
UIManager.error('弟子寿元已尽，请先救济')
return false
end
local itemNum=bagModel.getItemCountById(itemID)
if itemNum<=0 then
UIManager.error('道具不足')
gainControl:showGainWin(itemID)
return false
end

local fix,cond=itemsLookup:checkDicipleUseItemCondition(disciple_guid,itemID)

if not fix then
if cond then
local item=self.itemsScrollview:getChildScrollViewItemWidget(idx-1)
local pos=Vector2.New(0,30)
local cond_str=self:getUseGoodStr(cond)
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
end
return false
end

local useItemFunc=function()
if _this==nil then return end
_this.useItemID=itemID
_this.usediziID=disciple_guid
local isOldUse=_this:getIsOldUse()
return bagProtocolControl.req_dizi_use_item(disciple_guid,itemID,1,isOldUse,_this.setUseRecordData)
end
local dzName=UIDiscipleModel:getDiscipleColorName(disciple_guid)
local itemName=itemsConfig.getColorName(itemID)
local itemCfg=itemsHelper:get_item_config(itemID)
local checkSpecialityFunc=function()

local isAddSpeciality=false
local specialityTypeList={}
local specialityList={}
local funcparam=itemCfg.funcparam
local extraList=funcparam and funcparam.extra or{}
for i,v in ipairs(extraList)do
if v[2][5]then
local list=v[2][5][2]or{}
for _,specialityItem in ipairs(list)do
local specialityType=specialityItem[1]
table.insert(specialityTypeList,specialityType)
for _,specialityId in ipairs(specialityItem[2])do
table.insert(specialityList,{specialityType,specialityId})
end
end
end
end
isAddSpeciality=specialityTypeList and next(specialityTypeList)or false
if isAddSpeciality then
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eItemHideFullSpecialityTipsDialog)
local isHideFullSpecialityTipsDialog=check or _this.finishCheckSpecialityItemID==itemID
if isHideFullSpecialityTipsDialog then

return true
end

local isFullSpeciality=false
local fullType
local spName
for i,v in ipairs(specialityTypeList)do
local specialityType=v
if specialityType==DISCIPLE_SPECIALITY_TYPE.eTalent then

local isMax=UIDiscipleModel.checkSpecialtyCountMax(specialityType,disciple_guid)
if isMax then
isFullSpeciality=true
fullType=DISCIPLE_SPECIALITY_TYPE.eTalent
break
end
elseif specialityType==DISCIPLE_SPECIALITY_TYPE.eBody then

local isMax=UIDiscipleModel.checkSpecialtyCountMax(specialityType,disciple_guid)
if isMax then
local list=UIDiscipleModel:getDiscipleSpeciality(disciple_guid,specialityType)
spName=UIDiscipleModel:getSpecialityName(specialityType,list[1].param_1)
fullType=DISCIPLE_SPECIALITY_TYPE.eBody
isFullSpeciality=true
break
end
elseif specialityType==DISCIPLE_SPECIALITY_TYPE.eStrange then

local isMax=UIDiscipleModel.checkSpecialtyCountMax(specialityType,disciple_guid)
if isMax then
isFullSpeciality=true
fullType=DISCIPLE_SPECIALITY_TYPE.eStrange
break
end
end
end
if isFullSpeciality and not isHideFullSpecialityTipsDialog then

local contentStr
if fullType==DISCIPLE_SPECIALITY_TYPE.eTalent then
local notSpeaceItemName=string.replaceSpace(itemName)
contentStr=FMT.fmt("弟子{0}拥有的天赋数量已达上限，使用{1}不会再获得天赋，确定要使用吗？",dzName,notSpeaceItemName)
elseif fullType==DISCIPLE_SPECIALITY_TYPE.eBody then
local colorName=FMT.cfmt(FONT_COLOR.ePurpleColor,spName)
contentStr=FMT.fmt("弟子{0}已经拥有{1}，无法再获得新的体质了，使用可能会浪费道具的效果\n确定要使用吗？",dzName,colorName)
elseif fullType==DISCIPLE_SPECIALITY_TYPE.eStrange then
local notSpeaceItemName=string.replaceSpace(itemName)
contentStr=FMT.fmt("弟子{0}拥有的怪癖数量已达上限，使用{1}不会再获得怪癖，确定要使用吗？",dzName,notSpeaceItemName)
end
local okcallback=function(...)
_this.finishCheckSpecialityItemID=itemID
useItemFunc()
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,REPEAT_TYPE.eItemHideFullSpecialityTipsDialog)
return false
end
end
return true
end

local reconfirmType=itemCfg.reconfirmType
local repeat_type=UIFuncItemUseModel.checkReconfirmType(reconfirmType)


local reconfirmText=itemCfg.reconfirmText
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,repeat_type)
local isdizi=mathHelper.compareInt64(disciple_guid,self.usediziID)
local istips=self.useItemID==itemID and isdizi
local isHideReconfirmDialog=check or istips
if self.useItemID~=itemID or not isdizi then
self.checkNextUseSameLTItem=nil
end
local _fun=function(iscallback)
if reconfirmText then

local isShowDialog=not isHideReconfirmDialog
local showAttrText=""
local has6AttrCondition,conditionList=UIFuncItemUseModel:checkHasBase6AttrCondition(disciple_guid,itemID,true)
if has6AttrCondition then
local tempCheckNextUseSameItemFlag=false
for _,v in ipairs(conditionList)do
local attrName=UIDiscipleModel:getDiscipleBaseAttrName(v.attrType)
showAttrText=FMT.fmt("{0}\n<size=26>弟子基础{1}：<color=#ca631d>{2}</color></size>",showAttrText,attrName,v.actuallyAttr)
if v.actuallyAttr>=v.minAttr and v.actuallyAttr<=v.maxAttr then
tempCheckNextUseSameItemFlag=true
elseif self.checkNextUseSameLTItem and v.actuallyAttr>v.maxAttr then
isShowDialog=true
self.checkNextUseSameLTItem=nil
end
end
if tempCheckNextUseSameItemFlag then
self.checkNextUseSameLTItem=true
end
end
if self:isAddSpecialityItem(itemID,DISCIPLE_SPECIALITY_TYPE.eBody)then
local contentStr=FMT.fmt("{0}{1}",reconfirmText,showAttrText)
local okcallback=function(...)
if checkSpecialityFunc()then
return useItemFunc()
end
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback)
return false
end
if isShowDialog then
local contentStr=FMT.fmt("{0}{1}",reconfirmText,showAttrText)





local okcallback=function(...)
if checkSpecialityFunc()then
return useItemFunc()
end
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,repeat_type)
return false
end
end
if iscallback then
return useItemFunc()
else
return true
end
end
local isOldUse=_this:getIsOldUse()

if isSpecWine and ltexp>=nxltexp and not isOldUse then
local contentStr="弟子当前<color=#CB6A28>炼体境界已满</color>，是否继续使用？"
local okcallback=function(...)
return _fun(true)
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback)
return false
else
return _fun()
end
return true
end

function UIFuncSpecItemUseWin:getUseGoodStr(cond)
local str=''
local line=0
local lianti=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLiantiLv,cond)
if lianti~=nil then
local lt_name=UIDiscipleModel:getLTNameX(lianti[1])
str=str..FMT.fmt('{0}期弟子才可以服用',lt_name)
line=line+1
end
return str
end


function UIFuncSpecItemUseWin:onLongClickUseItem(clickCount,index)

local itemid=_this.itemList[index+1].id
if itemid==-1 or itemid==0 then
return
end
tipsManager.showTips({itemid=itemid})
end

function UIFuncSpecItemUseWin:onClickUseItemCallback(clickCount,index)

if self.selectIndex==index+1 then return end
local itemData=self.itemList[index+1]
if itemData==nil then return end
local itemid=itemData.id
self.selectItemid=itemid

if self.selectIndex then
local lastItem=self.itemsScrollview:getChildScrollViewItemWidget(self.selectIndex-1)
if lastItem then
lastItem:SetChildActive(8,false)
end
end
local item=self.itemsScrollview:getChildScrollViewItemWidget(index)
item:SetChildActive(8,true)
self.selectIndex=index+1


self:refreshjinjie(nil,true)
self:refreshlianti(nil,true)
self:freshBtnGray()
end

function UIFuncSpecItemUseWin:onClickClose()
self:closeSelf()
end


function UIFuncSpecItemUseWin.onDiscipleJJChange(disguid,old_jjlv,jingjielv,old_jjexp,jingjieexp,oldFight,newFight)

if _this==nil then return end
local disciple_guid=UIFuncSpecItemUseWin:getCurSelectDzGuid()
if mathHelper.compareInt64(disguid,disciple_guid)then
_this:refreshView()
local oldfloor=UIDiscipleModel:getJJFloor(old_jjlv)
local floor=UIDiscipleModel:getJJFloor(jingjielv)
if oldfloor~=floor then

else
fightUpRemindController:postDiZiFight(disguid,oldFight,newFight)
end
end

end


function UIFuncSpecItemUseWin.on_item_changed(changeType,itemguid,itemid,oldVal,newVal)
local have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
_this:refreshtezhi()

_this:refreshItemPanel(have==0)
_this:refreshjinjie(nil,true)
_this:refreshlianti(nil,true)

_this:freshBtnGray()
end
function UIFuncSpecItemUseWin:onUseButton()
end


function UIFuncSpecItemUseWin.onShowDiscipleChanged(eType,datas,effectData)
if _this==nil then return end
UIFuncItemUseModel.onShowDiscipleChanged(eType,datas)




local itemid=effectData.itemid

local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
if funcparam then
local curItemType=funcparam.type
local disciple_guid=UIFuncSpecItemUseWin:getCurSelectDzGuid()
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
if curItemType==item_funtion_type.jj_xiuweidan then
local change=true
if change then
local num=effectData.usednum+effectData.freenum
if num>0 then
local args={}
if effectData.freenum>0 then
args={}
local rate1,rate2=dzSpecialityGrowEffectController:getXiuWeiDanYaoNotCostRateLookup(netData)
args.freenum=effectData.freenum
args.freerate=rate2
end





if _this.ispiaozi then
_this:useGoodBack(itemid,effectData.usednum,args,disciple_guid)
_this.ispiaozi=false
end
end
end
elseif curItemType==item_funtion_type.lt_jingyandan then
local change=true
if change then
local num=effectData.usednum+effectData.freenum





if num>0 then
_this:useLTGoodBack(itemid,num,disciple_guid)
end
end
end
end
end
function UIFuncSpecItemUseWin:useLTGoodBack(itemid,num,disciple_guid)
UIDiscipleModel:useLTGoodBack(disciple_guid,itemid,1,num)
end
function UIFuncSpecItemUseWin:useGoodBack(itemid,num,args,disciple_guid)
local win=UIManager:findActiveWindow('UIDiscipleJingJieBrokeWin')
if win then return end
UIDiscipleModel:useJJGoodBack(disciple_guid,itemid,1,num,args)
end


function UIFuncSpecItemUseWin:freshBtnGray()
local disciple_guid=_this:getCurSelectDzGuid()
local netData=UIDiscipleModel:getDiscipleData(disciple_guid)
local jingjielv=netData.jingjielv
local cfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,jingjielv)
local curjjexp=UIDiscipleModel:calculationJJExp(disciple_guid)
local nxjjexp=cfg.exp
local is_gray=false
if nxjjexp<=0 then
is_gray=true
end
if curjjexp>=nxjjexp then
if UIDiscipleModel:checkNextJJNeedBroke(jingjielv)then
if UIDiscipleModel:checkJJBrokeByHand(jingjielv)then
is_gray=true
end
end
end

if _this.itemList and#_this.itemList>0 and _this.selectIndex then
local itemid=_this.itemList[_this.selectIndex].id
local fix,cond=itemsLookup:checkDicipleUseItemCondition(disciple_guid,itemid)
if not fix then
if cond then
is_gray=true
end
end
local isSpecWine
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
if funcparam then
isSpecWine=funcparam.SpecWine
end
if isSpecWine then
is_gray=false
end
local fix,cond=itemsLookup:checkDicipleUseItemCondition(disciple_guid,itemid)
if not fix then
if cond then
is_gray=true
end
end
local curItemType=funcparam.type
if curItemType==item_funtion_type.lt_jingyandan then
if UIDiscipleModel:isShuWuDisciple(netData.id)then
is_gray=true
end
end
end
if _this.itemList and#_this.itemList==0 then
is_gray=true
end
local state=UIDiscipleModel:getDiscipleState(disciple_guid)
if state and state==DISCIPLE_STATE_TYPE.eChuiWei then
is_gray=true
end
_this.winlua:SetChildImageExGray(_this.useButton:getID(),is_gray)
end
