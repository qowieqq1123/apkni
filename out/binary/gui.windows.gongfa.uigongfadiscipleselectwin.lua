







def_class("UIGongFaDiscipleSelectWin",UIWindowBase)









function UIGongFaDiscipleSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.roleListPanel=UIObject.get(self,1)



end


function UIGongFaDiscipleSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
end
















local _this=nil


function UIGongFaDiscipleSelectWin:onLoaded(...)
self:bindComponents()
_this=self
local onClickRoleItemCallback_=function(...)
self:onClickRoleItemCallback(...)
end
self.roleListPanel:setChildScrollViewInit(-1,true,onClickRoleItemCallback_,nil)
end


function UIGongFaDiscipleSelectWin:__delete()
self:unbindComponents()
_this=nil
UIManager:closeWindow('UIGongFaDiscipleInfoWin')
end


function UIGongFaDiscipleSelectWin:onHide()

end

function UIGongFaDiscipleSelectWin:doFadeIn(fadeInData,old_page,page)
local delay=0
if fadeInData then
delay=delay+fadeInData[1]
end
if old_page==1 then
delay=delay+0.2
end
if delay>0 then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.5,nil)
end
self:delayDo(delay,func)
else
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5,nil)
end
end




function UIGongFaDiscipleSelectWin:onShow(argtable,afterOnloaded)
local fadeInData=argtable.fadeInData
if not afterOnloaded then
fadeInData=nil
end
local page=argtable.page
local old_page=argtable.old_page
self:doFadeIn(fadeInData,old_page,page)

self.parentWin=argtable.parent

self.sortType=argtable.sortType
self.sortCondition={}
self.sortOrder=eSortOrder.eDown

self:initRoleListPanel()

if argtable.guid~=nil then
UIManager:showWindow('UIGongFaDiscipleInfoWin',{guid=argtable.guid})
elseif argtable.plotType~=nil then
local disData=UIDiscipleModel:getPlotDiscipleByIndex(argtable.plotType)
if disData~=nil then
UIManager:showWindow('UIGongFaDiscipleInfoWin',{guid=disData.discipleguid})
end
end
end

function UIGongFaDiscipleSelectWin:getNetDataList()
local sortParams={false}
local list=discipleLookup:getSortDiscipleList(self.sortType,self.sortCondition,self.sortOrder,sortParams)
self.disciplesList=list
end

function UIGongFaDiscipleSelectWin:findItemIndex(guid_)
for i,v in ipairs(self.disciplesList)do
local guid=v.netData.net.discipleguid
if mathHelper.compareInt64(guid,guid_)then
return i
end
end
return nil
end

function UIGongFaDiscipleSelectWin:initRoleListPanel()
self:getNetDataList()
local dataNum=#self.disciplesList
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,5)

local grids=self.roleListPanel:getChildScrollViewItemWidgets()
for i=1,dataNum do
self:refreshRoleItem(grids[i-1],i)
end
end

function UIGongFaDiscipleSelectWin:refreshRoleItem(item,index)
if item==nil then
item=self.roleListPanel:getChildScrollViewItemWidget(index-1)
end
item:SetChildNewBieComponentId(-1,FMT.fmt('UIGongFaDiscipleSelectWin.item1.{0}',index))
local netData=self.disciplesList[index].netData.net
local guid=netData.discipleguid

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(29,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

local scale=0.65
comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHalf)

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

item:SetChildActive(6,false)


local gongfalist=UIDiscipleModel:getDiscipleAllGFData(guid)
local desc=FMT.fmt('掌握功法：{0}',#gongfalist)
item:SetChildText(4,desc)
end
local isLDLock=UIDiscipleModel:checkDZClientState(guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
item:SetChildActive(16,isLDLock)
item:SetChildActive(8,isLDLock)
if isLDLock then
item:SetChildText(9,"论道大会锁定")
end
local dzId=UIDiscipleModel:getDiscipleID(guid)
local isLDDZ=liandonModel:getLianDonLinkageIdByDZId(dzId)>0
item:SetChildActive(27,isLDDZ)





UIDiscipleController.refreshCommonItemTianMing(item,netData)
end


function UIGongFaDiscipleSelectWin:onClickRoleItemCallback(clicknum,index)
index=index+1
if index==0 then
return
end

local netData=self.disciplesList[index].netData.net
local guid=netData.discipleguid




local isLDLock=UIDiscipleModel:checkDZClientState(guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end

UIManager:showWindow('UIGongFaDiscipleInfoWin',{guid=guid})
end

function UIGongFaDiscipleSelectWin:onSortTypeChange(args)
self.sortType=args.sortType
self:initRoleListPanel()
end

function UIGongFaDiscipleSelectWin:onSortConditionClick()
if self.filterName==nil or self.filterFlag==nil then
self.filterName,self.filterFlag=discipleLookup:getConditonFilter()
end
local args={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selecConditionBack}
args.titleName=cfgHelper.getlang('filter_title_name')
UIManager:showWindow('UIFilterTwoWin',args)
end

function UIGongFaDiscipleSelectWin.selecConditionBack(data)

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



function UIGongFaDiscipleSelectWin:rec_learGF(guid)
local found=self:findItemIndex(guid)
if found then
self:refreshRoleItem(nil,found)
end
end

function UIGongFaDiscipleSelectWin:rec_forgetGF(guid,gfID,pos)
local found=self:findItemIndex(guid)
if found then
self:refreshRoleItem(nil,found)
end
end
