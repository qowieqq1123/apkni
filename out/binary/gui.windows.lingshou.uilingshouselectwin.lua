







def_class("UILingShouSelectWin",UIWindowBase)









function UILingShouSelectWin:bindComponents()

self.roleGrid=UIObject.get(self,0)
self.sortTypeDropdown=UIDropdown.get(self,1)
self.numText=UIText.get(self,2)
self.root=UIObject.get(self,3)
self.testRoot=UIObject.get(self,4)



end


function UILingShouSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.roleGrid);self.roleGrid=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.numText);self.numText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.testRoot);self.testRoot=nil;
end
















local _this=nil


function UILingShouSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)

local showTest=false



self.testRoot:setActive(showTest)
end


function UILingShouSelectWin:__delete()
self:unbindComponents()
_this=nil
end

function UILingShouSelectWin:doFadeIn(delay,duration)
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




function UILingShouSelectWin:onShow(argtable,afterOnloaded)
self.param=argtable
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end
self.sortTypeList=eLingShouSortType:getLSSortList()
self.sortTypeDropdown:setOption(eLingShouSortTypeName:getName2List2(self.sortTypeList))
self.sortType=eLingShouSortType.eFightSort
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

self:initRoleGrid()

local cur=lingshouModel:getLSCount()
local max=lingshouModel:getLSMaxCount()
self.numText:setText(FMT.fmt('{0}/{1}',cur,max))
end

function UILingShouSelectWin:getRoleList()
local list={}
if self.param.lingshous then
for i,guid in ipairs(self.param.lingshous)do
table.insert(list,lingshouModel:getLingShouData(guid))
end
lingshouLookup:sortList(list,self.sortType,self.sortOrder)
else
list=lingshouLookup:getSortList(self.sortType,self.sortCondition,self.sortOrder)

end
return list
end

function UILingShouSelectWin:initRoleGrid()
local list=self:getRoleList()
self:initRoleGridEx(list)
end

function UILingShouSelectWin:initRoleGridEx(list)
self.rolelist=list
local pagenum=#self.rolelist
local func=function(idx)
local item=self.roleGrid:getChildLayoutGroupGridItem(idx-1)
self:refreshRoleItem(item,idx)
end
self.roleGrid:setChildLayoutGroupCreateItems(pagenum,func)
end

function UILingShouSelectWin:refreshRoleItem(item,idx)
local lsData=self.rolelist[idx]
local lsID=lsData.id
local lscfg=lsData.cfg
local guid=lsData.guid

local color=lingshouModel:getColor(guid)
item:SetChildCSImageSprite(0,globalABLookup.lingshoumain,lingshouColorToFrame[color])

local name_str=lsData.name
item:SetChildText(1,name_str)


comHelper.setChildModelRawImage_lingshou(item,lsID,2,0,eHeadCenterType.eHead,1)

if self.sortType==eLingShouSortType.eJingJieSort then

item:SetChildActive(5,false)

local jj_str=lingshouModel:getJJName(guid,2)
item:SetChildText(4,jj_str)
elseif self.sortType==eLingShouSortType.eQianLi then

item:SetChildActive(5,false)

local ql_str=lingshouModel:getQianLiDesc(guid)
item:SetChildText(4,ql_str)
else

item:SetChildActive(5,true)
local fight=lingshouModel:getFightValue(guid)
item:SetChildText(5,tostring(fight))

item:SetChildText(4,'')
end

local showSign=lscfg.bianyi==1
item:SetChildActive(3,showSign)

local isreddot=false
item:SetChildActive(6,isreddot)

local func=function()
self:onRoleItemClick(idx)
end
item:SetChildButtonClick(-1,func,true)
end


function UILingShouSelectWin:onRoleItemClick(index)
local args=table.deepCopy(self.param)

local list=self:getRoleList()
local data=self.rolelist[index]
UIFullLingShouMainControl:myShowWindow({ls_guid=data.guid,lslist=list})

local func=function(args_)
UIFullLingShouSelectControl:showLingShouSelectWindowEx(args_)
end
fullScreenUI.setNextActiveUICallback(func,args)
end

function UILingShouSelectWin:onDropdownChange(idx)

if self.lockRefresh then return end
idx=idx+1
if self.sortTypeIndex==idx then return end
self.sortTypeIndex=idx
self.sortType=self.sortTypeList[idx]
lingshouModel:setSaveSortType(self.sortTypeIndex)

self:initRoleGrid()
end

function UILingShouSelectWin:onSortConditionClick()
if self.filterName==nil or self.filterFlag==nil then
self.filterName,self.filterFlag=lingshouLookup:getConditonFilter(self.sortCondition)
end
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UILingShouSelectWin.selecConditionBack(data)

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
lingshouModel:setSaveSortCondition(_this.sortCondition)

_this:initRoleGrid()
end

function UILingShouSelectWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:initRoleGrid()
end

function UILingShouSelectWin:onTestAttrBtnClick()

end
