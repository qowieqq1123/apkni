







def_class("UIGuBaoCollectWin",UIWindowBase)









function UIGuBaoCollectWin:bindComponents()

self.root=UIObject.get(self,0)
self.sortTypeDropdown=UIDropdown.get(self,1)
self.creater=UIObject.get(self,2)
self.noItemTips=UIText.get(self,3)



end


function UIGuBaoCollectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
end




















local _this=nil

local sortTypeName={'品质','套装'}
local sortTypeKey='gubaoSelectSortType'
local sortCondKey='gubaoSelectSortCond'


function UIGuBaoCollectWin:onLoaded(...)
self:bindComponents()
_this=self


gubaoLianHuaSheetReddot.initConfig()
gubaoUpStarSheetReddot.initConfig()
gubaoAwakeSheetReddot.initConfig()

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIGuBaoCollectWin:__delete()
self:unbindComponents()
_this=nil
end


function UIGuBaoCollectWin:onHide()

end

function UIGuBaoCollectWin:doFadeIn(delay,duration)
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




function UIGuBaoCollectWin:onShow(argtable,afterOnloaded)
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end

self.sortTypeDropdown:setOption(sortTypeName)
self.sortType=userActorSetting.get(sortTypeKey,1)

local saveSortCondition=userActorSetting.get(sortCondKey,{['1']={1}})
self.sortCondition={}
for k,v in pairs(saveSortCondition)do
self.sortCondition[tonumber(k)]=v
end
self.sortOrder=eSortOrder.eDown
self.sortTypeDropdown:setValue(self.sortType-1)

local func=function()
self:initGBListPanel()
end
if afterOnloaded then
self:delayDo(0.01,func)
else
func()
end
end

function UIGuBaoCollectWin:onShowArgRecv(argtable)
self:initGBListPanel()
end

function UIGuBaoCollectWin:getGBList()
if self.allGFList==nil then
self.allGFList=gubaoLookup:getAllList()
end
local list=gubaoLookup:getSortList(self.allGFList,self.sortType,self.sortCondition,self.sortOrder,true)
self.gubaolist=list
local list2=gubaoLookup:getSortList(self.allGFList,self.sortType,nil,self.sortOrder,true)
self.fullgubaolist=list2
local childlist={}
local configs=cfg_gubaoconfig()
for i,gbCfg in pairs(configs)do
local gbid=gbCfg.id
if gubaoModel:checkCanActive(gbid)then
local glid,main=liandonModel:CheckGB_Guanlian(gbid)
if glid then
if not gubaoModel:checkActive(glid)then

if gubaoModel:checkCanActive(glid)then

if main==1 then
table.insert(childlist,gbCfg)
end
else

table.insert(childlist,gbCfg)
end
end
else

table.insert(childlist,gbCfg)
end
end
end
local num=#childlist
if num>0 then
if num>1 then
table.sort(childlist,function(a,b)
return a.color>b.color
end)
end
local canActivePage={}
canActivePage.typo=-2
canActivePage.childlist=childlist
table.insert(self.gubaolist,1,canActivePage)
table.insert(self.fullgubaolist,1,canActivePage)
end

self.maxPageIndex=0
self.maxPageNum=0
self.jumpPageIndex=0
self.jumpPageNum=0
for pageidx,pageData in ipairs(self.gubaolist)do
local n=#pageData.childlist
if n>self.maxPageNum then
self.maxPageIndex=pageidx
self.maxPageNum=n
end
if self.jumpPageIndex==0 then
for childidx,gbCfg in ipairs(pageData.childlist)do
local gbid=gbCfg.id
local active=gubaoModel:checkActive(gbid)
local isreddot=false
if active then
isreddot=gubaoModel:checkCanLianHua(gbid)or gubaoModel:checkCanUpStar(gbid)or gubaoModel:checkCanAwake(gbid)
else
isreddot=gubaoModel:checkCanActive(gbid)
end
if isreddot then
self.jumpPageIndex=pageidx
self.jumpPageNum=childidx
break
end
end
end
end
end

function UIGuBaoCollectWin:initGBListPanel(jump)
self:getGBList()
local pagenum=#self.gubaolist
local func=function(idx)
local item=self.creater:getChildLayoutGroupGridItem(idx-1)
self:refreshPageItem(item,idx,jump)
end
self.noItemTips:setActive(pagenum<=0)
self.creater:setChildLayoutGroupCreateItems(pagenum,func)





end

function UIGuBaoCollectWin:getPageName(pageData)
if self.sortType==1 then

return cfgHelper.get3(cfg_gubaobaseconfig_get,1,'colorNames',pageData.typo)
elseif self.sortType==2 then

if pageData.typo==-1 then
return'无套装'
else
return cfgHelper.get2(cfg_gubaosuitconfig_get,pageData.typo,'name')
end
else

return cfgHelper.get2(cfg_discipleraceconfig_get,pageData.typo,'name')
end
end

function UIGuBaoCollectWin:getPageProgress(pageidx)
local pageData=self.gubaolist[pageidx]
local pageType=pageData.typo
local fullpageData
for i,pageData_ in ipairs(self.fullgubaolist)do
if pageData_.typo==pageType then
fullpageData=pageData_
break
end
end
local cur=0
local max=#fullpageData.childlist
for i,gbCfg in ipairs(pageData.childlist)do
if gubaoModel:checkActive(gbCfg.id)then
cur=cur+1
end
end
return cur,max
end

function UIGuBaoCollectWin:refreshPageItem(item,pageidx,check)
local pageData=self.gubaolist[pageidx]
local pageType=pageData.typo
local name_str
if pageType==-2 then
name_str='可激活'
else
local name_fmt='{0}({1}/{2})'
local name=self:getPageName(pageData)
local cur,max=self:getPageProgress(pageidx)
name_str=FMT.fmt(name_fmt,name,cur,max)
end
item:SetChildText(0,name_str)

local childnum=#pageData.childlist
local func=function(idx)
local childItem=item:GetChildLayoutGroupGridItem(1,idx-1)
childItem:SetChildButtonClick(5,function()
self:onChildItemClick(pageidx,idx)
end)
self:refreshChildItem(childItem,pageidx,idx)
if check then
self:checkRefreshFinish(pageidx,idx)
end
local gbCfg=pageData.childlist[idx]
local gbid=gbCfg.id
childItem:SetChildNewBieComponentId(5,FMT.fmt("UIGuBaoCollectWin.gubaoItem_{0}_{1}",gbid,pageType))
end
item:SetChildLayoutGroupCreateItems(1,childnum,func)








end

function UIGuBaoCollectWin:refreshChildItem(item,pageidx,childidx)
local pageData=self.gubaolist[pageidx]
local pageType=pageData.typo
local gbCfg=pageData.childlist[childidx]
local gbid=gbCfg.id

local isLD=liandonModel:getLianDonLinkageIdByItemId(gbid,ITEM_CONFIG_TYPE.eGuBao)>0
local canActive=gubaoModel:checkCanActive(gbid)
local isShow=true
if pageType~=-2 then


end
item:SetChildActive(-1,isShow)
if not isShow then
return
end

local isSpe=gubaoModel:isSpecial(gbid)
local gbData=gubaoModel:getDataByID(gbid)
local active=gubaoModel:checkActive(gbid)

item:SetChildCSImageIcon(0,gubaoModel:getGuBaoIconName(gbCfg.icon),true)

item:SetChildCSImageSprite(8,globalABLookup.gubaomainicons,gubaoColorFrame:getName(gbCfg.color))

item:SetChildCSImageSprite(7,globalABLookup.gubaomainicons,gbCfg.color<6 and"frame_gubaodikuang_1"or"frame_gubaodikuang_3")


local name_str=gbCfg.name
item:SetChildText(1,name_str)

local isgray=not active
item:SetChildImageExGray(0,isgray)
item:SetChildImageExGray(7,isgray)
item:SetChildImageExGray(8,isgray)
item:SetChildImageExGray(11,isgray)
local isReddot=false
if active then

local showSign=gubaoModel:checkAwake(gbid)
item:SetChildActive(2,showSign)

local lianhua_str=nil
if gbData.gubaolhlv>0 then
lianhua_str=string.format('+%d',gbData.gubaolhlv)
end
local showLianHua=lianhua_str~=nil
item:SetChildActive(3,showLianHua)
if showLianHua then
item:SetChildText(3,lianhua_str)
end

local starlv=gbData.gubaostar
local starWidget=item:GetChildWidgetBase(4)
for i=1,5 do
starWidget:SetChildActive(i-1,i<=starlv)
end

isReddot=gubaoModel:checkCanLianHua(gbid)or gubaoModel:checkCanUpStar(gbid)or gubaoModel:checkCanAwake(gbid)
else

item:SetChildActive(2,false)

item:SetChildActive(3,false)

local starWidget=item:GetChildWidgetBase(4)
for i=1,5 do
starWidget:SetChildActive(i-1,false)
end
end

item:SetChildActive(6,not active and canActive)

item:SetChildActive(10,isReddot)

item:SetChildActive(9,active and isSpe)

item:SetChildActive(11,isLD)
end

function UIGuBaoCollectWin:refreshChildItemReddot(item,gbid)
local active=gubaoModel:checkActive(gbid)
local showActive=false
local isReddot=false
if active then
isReddot=gubaoModel:checkCanLianHua(gbid)or gubaoModel:checkCanUpStar(gbid)or gubaoModel:checkCanAwake(gbid)
else
local canActive=gubaoModel:checkCanActive(gbid)
showActive=canActive
end
item:SetChildActive(6,showActive)
item:SetChildActive(10,isReddot)
end



function UIGuBaoCollectWin:checkRefreshFinish(pageidx,childidx)
if self.maxPageIndex==0 then return end

if pageidx==self.maxPageIndex and childidx==self.maxPageNum and self.jumpPageIndex~=0 then

local pos=self.creater:getChildLocalPosition()
if pos.y<1 then
self:jumpRedItem()
end
end
end


function UIGuBaoCollectWin:jumpRedItem()
local func=function()
local pageItem=self.creater:getChildLayoutGroupGridItem(self.jumpPageIndex-1)
local childItem=pageItem:GetChildLayoutGroupGridItem(1,self.jumpPageNum-1)
local sp=childItem:GetChildUIScreenPos(-1,false)
local sp_=Vector2(sp.x,sp.y)
local lp=self.creater:getChildUIScreenPos2Local(sp_)
local moveY=-lp.y-85

if moveY>=200 then
self.creater:setChildDOLocalMoveY(moveY,0.2,nil)
end
end
self:delayDo(0.1,func)
end


function UIGuBaoCollectWin:onDropdownChange(idx)

idx=idx+1
self.sortType=idx
userActorSetting.flushVal(sortTypeKey,idx)
self:initGBListPanel()
end

function UIGuBaoCollectWin:onSortConditionClick()
if self.filterName==nil or self.filterFlag==nil then
self.filterName,self.filterFlag=gubaoLookup:getConditonFilter(self.sortCondition)
end
local args={}
args.titleName=cfgHelper.getlang('filter_title_name_gb')

args.extraWin='UIFilterThreeWin'
local extraParams={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end

function UIGuBaoCollectWin.selecConditionBack(data)

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

local saveSortCondition={}
for k,v in pairs(_this.sortCondition)do
saveSortCondition[tostring(k)]=v
end
userActorSetting.flushVal(sortCondKey,saveSortCondition)

_this:initGBListPanel()
end

function UIGuBaoCollectWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:initGBListPanel()
end


function UIGuBaoCollectWin:onChildItemClick(pageidx,childidx)
local pageData=self.gubaolist[pageidx]
local gbCfg=pageData.childlist[childidx]
local gbid=gbCfg.id

tipsManager.showTipsGB({formType=TIPS_FORM_TYPE.eGubaoWin,tipsType=TIPS_TYPE.eCommonGubao,itemid=gbid,bg=false})
end



function UIGuBaoCollectWin:refreshChildItemBygbid(gbid)
for i,v in ipairs(self.gubaolist)do
local pageidx=i
for i2,gbCfg in ipairs(v.childlist)do
local gbid_=gbCfg.id
local childidx=i2
local pageItem=self.creater:getChildLayoutGroupGridItem(pageidx-1)
local childItem=pageItem:GetChildLayoutGroupGridItem(1,childidx-1)
if gbid==gbid_ then
self:refreshChildItem(childItem,pageidx,childidx)
else
self:refreshChildItemReddot(childItem,gbid_)
end
end
end
end

function UIGuBaoCollectWin:rec_active(gbid)
self:initGBListPanel()
end

function UIGuBaoCollectWin:rec_lianhua(gbid)

self:initGBListPanel()
end

function UIGuBaoCollectWin:rec_upStar(gbid)

self:initGBListPanel()
end

function UIGuBaoCollectWin:rec_awake(gbid)

self:initGBListPanel()
end
