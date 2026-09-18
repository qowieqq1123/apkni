







def_class("UIDiscipleSelectTwoWin",UIWindowBase)









function UIDiscipleSelectTwoWin:bindComponents()

self.btnOkTxt=UIText.get(self,0)
self.roleListPanel=UIObject.get(self,1)
self.sortTypeDropdown=UIDropdown.get(self,2)
self.discipleNumText=UIText.get(self,3)
self.btnOK=UIButton.get(self,4)
self.root=UIObject.get(self,5)

self.btnOK:setButtonClick(function()self:onBtnOK()end)



end


function UIDiscipleSelectTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnOkTxt);self.btnOkTxt=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.discipleNumText);self.discipleNumText=nil;
_UIObject_release(self.btnOK);self.btnOK=nil;
_UIObject_release(self.root);self.root=nil;
end


















local _this=nil
local sortTypeKey='discipleSelectSortType'


function UIDiscipleSelectTwoWin:onLoaded(...)
self:bindComponents()
_this=self
local _OnClickRoleItemCallback=function(...)
self:OnClickRoleItemCallback(...)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIDiscipleSelectTwoWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleSelectTwoWin:onShow(argtable,afterOnloaded)
self.selectList={}
self.selectLookup={}
argtable=argtable or{}
self.param=argtable
self.sortArgs=argtable.sortArgs or{}
self.limitArgs=argtable.limitArgs or{}
self.sortType=self.sortArgs[1]or eDiscipleSortType.eJingJieSort









local nameList=eDiscipleSortTypeName:getName2List2({self.sortType})
self.sortTypeDropdown:setOption(nameList)
self.sortCondition={}
self.sortOrder=eSortOrder.eDown
self.sortTypeDropdown:setValue(self.sortType-1)

self:initRoleListPanel()
self.btnOkTxt:setText(argtable.btnTxt or'')
self:setCommonInfo()
end

function UIDiscipleSelectTwoWin:setCommonInfo()
local numFun=self.param.numFun
if numFun then
local txt=numFun and numFun(#self.selectList)or''
self.discipleNumText:setText(txt)
self.discipleNumText:setActive(true)
else
self.discipleNumText:setActive(false)
end
end

function UIDiscipleSelectTwoWin:getNetDataList()
local list=discipleLookup:getSortDiscipleList(self.sortArgs,self.sortCondition,self.sortOrder)
if self.param.sortFun then
list=self.param.sortFun(list)
end
return list
end

function UIDiscipleSelectTwoWin:initRoleListPanel()
self.disciplesList=self:getNetDataList()
local dataNum=#self.disciplesList
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,6)

local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local netdata=self.disciplesList[i].netData

local guid=netdata.net.discipleguid
local item=grids[i-1]

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(29,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

local scale=0.65
comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netdata.net.jingjielv)
item:SetChildText(5,lv_str)
if self.sortType==eDiscipleSortType.eJingJieSort then

item:SetChildActive(6,false)

local jjlv=netdata.net.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}阶',n,p)
else
jj_str=n
end
item:SetChildText(4,jj_str)
elseif self.sortType==eDiscipleSortType.eAttr6 then

item:SetChildActive(6,false)

local baseAttrType=self.sortArgs[2]
local jjlv=UIDiscipleModel:getDiscipleBaseAttr(guid,baseAttrType)
local name=UIDiscipleModel:getDiscipleBaseAttrName(baseAttrType)
local jj_str=FMT.fmt('{0}{1}',name,jjlv)
item:SetChildText(4,jj_str)
elseif self.sortType==eDiscipleSortType.eProSkill then

item:SetChildActive(6,false)

local jobType=self.sortArgs[2]
local jjlv=UIDiscipleModel:getDiscipleJobLevel(guid,jobType)
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,jobType,'name')
local jj_str=FMT.fmt('{0}{1}级',name,jjlv)
item:SetChildText(4,jj_str)
elseif self.sortType==eDiscipleSortType.eLianTiSort then

item:SetChildActive(6,false)

local ltlv=netdata.net.liantilv
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

local post_id=netdata.net.pos
local post_name=eZongMenPostType.getName(post_id)
item:SetChildText(4,post_name)
else

item:SetChildActive(6,true)
item:SetChildText(6,UIDiscipleModel:getDiscipleFightValue(guid))

item:SetChildText(4,'')
end




local isnew=netdata.isnew==true
item:SetChildActive(7,false)

item:SetChildActive(10,self.selectLookup[tostring(guid)]or false)

local isreddot=UIDiscipleModel:checkReddot(guid)
item:SetChildActive(11,false)
end
end


function UIDiscipleSelectTwoWin:OnClickRoleItemCallback(clicknum,index)
index=index+1
if index==0 then
return
end
local netdata=self.disciplesList[index].netData.net

local canSelect,errStr=self:checkCanSelect(netdata)
if not canSelect then
UIManager.error(errStr)
return
end

local guid=netdata.discipleguid
local guidStr=tostring(guid)
local item=self.roleListPanel:getChildScrollViewItemWidget(index-1)
local lastSelect=self.selectLookup[guidStr]~=nil
if lastSelect then
if self.param.unSelectFun and not self.param.unSelectFun(guid,self.selectList)then return end
self.selectLookup[guidStr]=nil
for i,v in ipairs(self.selectList)do
if tostring(v)==guidStr then
table.remove(self.selectList,i)
break
end
end
else
local ret=false
local needChange=true
if self.param.selectFun then
ret,needChange=self.param.selectFun(guid,self.selectList)
if not ret then
return
end
end
if needChange then

local lastGuid=self.selectList[1]
local isCanUnSelect=true
if self.param.unSelectFun then
isCanUnSelect=self.param.unSelectFun(lastGuid,self.selectList)
if not isCanUnSelect then
return
end
end

local lastGuidStr=tostring(lastGuid)
local lastSelectIndex=self.selectLookup[lastGuidStr]
self.selectLookup[lastGuidStr]=nil
local lastSelectItem=self.roleListPanel:getChildScrollViewItemWidget(lastSelectIndex-1)
lastSelectItem:SetChildActive(10,false)
table.remove(self.selectList,1)
end
if self.param.selectFun and not self.param.selectFun(guid,self.selectList)then return end
self.selectLookup[tostring(guid)]=index
self.selectList[#self.selectList+1]=guid
end
item:SetChildActive(10,not lastSelect)

self:setCommonInfo()
end

function UIDiscipleSelectTwoWin:onDropdownChange(idx)




end

function UIDiscipleSelectTwoWin:onSortConditionClick()
if self.filterName==nil or self.filterFlag==nil then
self.filterName,self.filterFlag=discipleLookup:getConditonFilter()
end
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIDiscipleSelectTwoWin.selecConditionBack(data)
if _this==nil then
return
end
_this.filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(_this.filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end

_this:initRoleListPanel()
end


function UIDiscipleSelectTwoWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:initRoleListPanel()
end

function UIDiscipleSelectTwoWin:onBtnOK()
local flag=true
if self.param then
if self.param.click then
flag=self.param.click(self.selectList)
end
if flag and self.param.parentWin then
self.param.parentWin:closeSelf()
end
end
if flag then
self:closeSelf()
end
end

function UIDiscipleSelectTwoWin:checkCanSelect(netData)
if not self.limitArgs or not next(self.limitArgs)then

return true
end

local limitType=self.limitArgs[1]
if limitType==1 then

local minJingJie=self.limitArgs[2]
local maxJingJie=self.limitArgs[3]
local jjlv=netData.jingjielv
if minJingJie and jjlv<minJingJie then
local jjName,p,pN=UIDiscipleModel:getJJNameX(minJingJie)
local errStr=FMT.fmt("需要{0}境界以上弟子",jjName)
return false,errStr
end

if maxJingJie and jjlv>maxJingJie then
local jjName,p,pN=UIDiscipleModel:getJJNameX(maxJingJie)
local errStr=FMT.fmt("需要{0}境界以下弟子",jjName)
return false,errStr
end
elseif limitType==2 then

local jobType=self.limitArgs[2]
local minJobLv=self.limitArgs[3]
local maxJobLv=self.limitArgs[4]
local jobLv=UIDiscipleModel:getDiscipleJobLevelEx(netData,jobType)
local jobName=UIDiscipleModel:getDiscipleJobName(jobType)

if minJobLv and jobLv<minJobLv then
local errStr=FMT.fmt("需要{0}{1}级以上弟子",jobName,minJobLv)
return false,errStr
end

if maxJobLv and jobLv>maxJobLv then
local errStr=FMT.fmt("需要{0}{1}以下弟子",jobName,maxJobLv)
return false,errStr
end
elseif limitType==3 then

local dzIdList=self.limitArgs[2]
local dzId=netData.id
local ret=false
local errShowDzId=dzIdList[1]
local targetDzName="指定弟子"
local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,errShowDzId)
if diziCfg and diziCfg.name then
targetDzName=diziCfg.name
end
local errStr=FMT.fmt("请祖师派遣弟子{0}",targetDzName)
for _,targetDzId in ipairs(dzIdList)do
if targetDzId==dzId then
ret=true
break
end
end

return ret,errStr
end

return true
end
