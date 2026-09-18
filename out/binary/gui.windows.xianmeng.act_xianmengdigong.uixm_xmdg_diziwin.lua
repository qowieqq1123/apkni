







def_class("UIXM_XMDG_DiZiWin",UIWindowBase)









function UIXM_XMDG_DiZiWin:bindComponents()

self.root=UIObject.get(self,0)
self.sortTypeDropdown=UIDropdown.get(self,1)
self.desc1Txt=UIText.get(self,2)
self.desc2Txt=UIText.get(self,3)
self.itemGridPanel=UIObject.get(self,4)



end


function UIXM_XMDG_DiZiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.desc1Txt);self.desc1Txt=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
end
















local _this=nil


function UIXM_XMDG_DiZiWin:onLoaded(...)
_this=self
self:bindComponents()

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIXM_XMDG_DiZiWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_DiZiWin:onHide()

end




function UIXM_XMDG_DiZiWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.sortTypeDropdown:setOption(eDiscipleSortTypeName:getName2List())
self.sortType=xianmengdigongModel:getSaveSortType()

local sortCondition={}
self.sortCondition=sortCondition
xianmengdigongModel:setSaveSortCondition(sortCondition)

self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortType-1)
self.lockRefresh=false

self:refreshDZListPanel()
self:refreshDesc()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.2,function()
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end

function UIXM_XMDG_DiZiWin:refreshDesc()
self.desc1Txt:setText('弟子受伤血量<color=#7d3b17>每天凌晨5点</color>恢复')




self.desc2Txt:setText('阵亡弟子<color=#7d3b17>每天凌晨5点</color>复活或使用特定道具立刻救治')
end

function UIXM_XMDG_DiZiWin:getDZIndex(dzguid)
for i,v in ipairs(self.dzList)do
local dz_guid=v.netData.discipleguid
if mathHelper.compareInt64(dzguid,dz_guid)then
return i
end
end
end

function UIXM_XMDG_DiZiWin:refreshDZListPanel()
self.dzList={}
local list=discipleLookup:getSortDiscipleList(nil,self.sortCondition,self.sortOrder)
for i,data in ipairs(list)do
local locData={}
locData.netData=data.netData.net
local guid=locData.netData.discipleguid
local flag,room,event=xianmengdigongModel:checkDZInRoom(guid)

local sorts={}
locData.sorts=sorts
sorts[1]=flag==true and 1 or 0
local fight=UIDiscipleModel:getDiscipleFightValue(guid)
if self.sortType==eDiscipleSortType.eJingJieSort or self.sortType==eDiscipleSortType.eLianTiSort then
sorts[2]=discipleLookup:getValueBySortType(guid,self.sortType)
else
sorts[2]=fight
end
table.insert(self.dzList,locData)
end
mathHelper.sortWeightList(self.dzList,nil,nil,nil,2,self.sortOrder)
local c=#self.dzList
self.itemGridPanel:setChildLayoutGroupCreateItems(c,function(idx)
if _this==nil then return end
_this:initGridItem(nil,idx)
end)
end

function UIXM_XMDG_DiZiWin:initGridItem(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end

local netData=self.dzList[idx].netData
local dz_guid=netData.discipleguid

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onDZCheck(idx)
end)

comHelper.setChildModelHeadIconBG(item,1,dz_guid)

comHelper.setChildModelRawImage(item,dz_guid,2,0,eHeadCenterType.eHead)

item:SetChildText(3,FMT.fmt('<color=#7d3b17>名称：</color>{0}',UIDiscipleModel:getDiscipleName(dz_guid)))

local desc_str
if self.sortType==eDiscipleSortType.eJingJieSort then
local jjlv=netData.jingjielv
desc_str=FMT.fmt('<color=#7d3b17>境界：</color>{0}',UIDiscipleModel.getJJNameCommon(jjlv,3))
elseif self.sortType==eDiscipleSortType.eLianTiSort then
local ltlv=netData.liantilv
desc_str=FMT.fmt('<color=#7d3b17>炼体：</color>{0}',UIDiscipleModel.getLTNameCommon(ltlv,3))
else
desc_str=FMT.fmt('<color=#7d3b17>战力：</color>{0}',UIDiscipleModel:getDiscipleFightValue(dz_guid))
end
item:SetChildText(4,desc_str)

self:refreshGridItemState(item,idx)
end

function UIXM_XMDG_DiZiWin:refreshGridItemState(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end

local netData=self.dzList[idx].netData
local dzguid=netData.discipleguid
local hp=xianmengdigongModel:getDZBlood(dzguid)

item:SetChildIconFillAmount(5,hp/10000)
item:SetChildText(6,FMT.fmt('血量：{0}%',hp/100))

local isLife=hp>0
local state_str
if isLife then
local flag,room,event=xianmengdigongModel:checkDZInRoom(dzguid)
if flag then
local e_name=cfgHelper.get2(cfg_guilddigongeventconfig_get,event.eventId,'title')
state_str=FMT.fmt('处理事件 <color=#ca631d>[{0}]</color>',e_name)
else
state_str='空闲'
end
else
state_str='<color=#c82c2c>濒危</color>'
end
state_str=FMT.fmt('<color=#7d3b17>状态：</color>{0}',state_str)
item:SetChildText(7,state_str)

item:SetChildActive(8,not isLife)
if not isLife then
item:SetChildButtonClick(8,function()
if _this==nil then return end
_this:onDZAddLife(idx)
end)
end
end

function UIXM_XMDG_DiZiWin:onDZCheck(idx)
local netData=self.dzList[idx].netData
local dzguid=netData.discipleguid
local hp=xianmengdigongModel:getDZBlood(dzguid)
if hp<=0 then
self:onDZAddLife(idx)
else
local flag,room,event=xianmengdigongModel:checkDZInRoom(dzguid)
if flag then
local flag=xianmengdigongController:jump(room.base.x,room.base.y)
if flag then
self.parentWin:onClickClose()
end
end
end
end

function UIXM_XMDG_DiZiWin:onDZAddLife(idx)
local item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
local netData=self.dzList[idx].netData
local dzguid=netData.discipleguid
local pos=item:GetChildScreenPointToLocalPointRectangle(8)
local args={dzguid=dzguid,posx=pos.x-40,posy=pos.y}
self:showWindow('UIXM_XMDG_reliveWin',args)
end

function UIXM_XMDG_DiZiWin:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
self.sortType=idx
xianmengdigongModel:setSaveSortType(idx)

self:refreshDZListPanel()
end

function UIXM_XMDG_DiZiWin:onSortConditionClick()
local filterName,filterFlag=discipleLookup:getConditonFilter(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIXM_XMDG_DiZiWin.selecConditionBack(data)
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

xianmengdigongModel:setSaveSortCondition(table.deepCopy(_this.sortCondition))

_this:refreshDZListPanel()
end

function UIXM_XMDG_DiZiWin:onSortOrderClick()
self.sortOrder=not self.sortOrder
self:refreshDZListPanel()
end

function UIXM_XMDG_DiZiWin:rec_dzRelive(dzguid)
local idx=self:getDZIndex(dzguid)
if idx then
self:refreshGridItemState(nil,idx)
end
self:closeWindow('UIXM_XMDG_reliveWin')
end