







def_class("UIDiscipleBattleSelectWin",UIWindowBase)







function UIDiscipleBattleSelectWin:bindComponents()

self.dragObject=UIObject.get(self,0)
self.RoleListPanel=UIObject.get(self,1)
self.selectButton=UIButton.get(self,2)
self.RoleTypeListPanel=UIObject.get(self,3)
self.selectText=UIText.get(self,4)
self.leftTeam=UIObject.get(self,5)

self.selectButton:setButtonClick(function()self:onSelectButton()end)



end

function UIDiscipleBattleSelectWin:bindChildComponents()

self.child=self.child or{}
if self.child['dragObject']then
self.child['dragObject']:setWidget(self.winlua:GetChildWidgetBase(self.dragObject:getID()))
self.child['dragObject']:onLoaded()
end

end


function UIDiscipleBattleSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dragObject);self.dragObject=nil;
_UIObject_release(self.RoleListPanel);self.RoleListPanel=nil;
_UIObject_release(self.selectButton);self.selectButton=nil;
_UIObject_release(self.RoleTypeListPanel);self.RoleTypeListPanel=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.leftTeam);self.leftTeam=nil;
end

















local RoleModel=
{
[1]={index=0,x=107,y=94},
[2]={index=1,x=89,y=-76},
[3]={index=2,x=-58,y=140},
[4]={index=3,x=-80,y=2},
[5]={index=4,x=-99,y=-137},
}
local m_sorttype=eDiscipleSortTypeName:getName2(eDiscipleSortType.eFightSort)
local m_sorttypeindex=eDiscipleSortType.eFightSort

local selectList={}
local selectLookUp={}
local selectNum=0
local maxSelect=5



function UIDiscipleBattleSelectWin:onLoaded(...)
self:bindComponents()


maxSelect=5
local _onClickRoleSortItemCallback=function(...)
self:onClickRoleSortItemCallback(...)
end
local _onClickRoleItemCallback=function(...)
self:onClickRoleItemCallback(...)
end
self.RoleTypeListPanel:setChildScrollViewInit(-1,true,_onClickRoleSortItemCallback,nil)
self.RoleListPanel:setChildScrollViewInit(-1,true,_onClickRoleItemCallback,nil)

local _beginDragCallback=function(...)
self:beginDragCallback(...)
end
local _dragCallback=function(...)
self:dragCallback(...)
end
local _endDragCallback=function(...)
self:endDragCallback(...)
end
self.leftTeam:initDragView(_beginDragCallback,_dragCallback,_endDragCallback)

self:initRoleModelPanel()
end


function UIDiscipleBattleSelectWin:__delete()
self:unbindComponents()
selectNum=0
selectList={}
selectLookUp={}
end




function UIDiscipleBattleSelectWin:onShow(argtable,afterOnloaded)




self.data=argtable

self.sortCondition={lglist={},joblist={}}
self.sortOrder=eSortOrder.eDown
self.data.disciples=self.data.disciples or discipleLookup:getSortDiscipleList(m_sorttypeindex,self.sortCondition,self.sortOrder)

m_sorttypeindex=eDiscipleSortType.eFightSort
m_sorttype=eDiscipleSortTypeName:getName2(m_sorttype)

selectNum=0
selectList={}
selectLookUp={}
self.selectText:setText(self.data.tipsText)
self:initRoleTypeListPanel()
self:initRoleListPanel()
self:onClickRoleSortItemCallback(1,0)
end

function UIDiscipleBattleSelectWin:initRoleTypeListPanel()
self.RoleTypeListPanel:setChildScrollViewCreateGrids(#eDiscipleSortTypeName,1)
local grids=self.RoleTypeListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,eDiscipleSortTypeName:getName2(i))
end
end

function UIDiscipleBattleSelectWin:onClickRoleSortItemCallback(clicknum,index)
local oldIndex
if index+1~=m_sorttypeindex then
oldIndex=m_sorttypeindex
end
m_sorttype=eDiscipleSortTypeName:getName2(index+1)
m_sorttypeindex=index+1
local grid=self.RoleTypeListPanel:getChildScrollViewItemWidget(index)
if grid then
grid:SetChildActive(2,true)
end
if oldIndex then
grid=self.RoleTypeListPanel:getChildScrollViewItemWidget(oldIndex-1)
if grid then
grid:SetChildActive(2,false)
end
discipleLookup:sortList(self.data.disciples,m_sorttypeindex,self.sortOrder)
self:initRoleListPanel()
end
end

function UIDiscipleBattleSelectWin:initRoleModelPanel()
for i,v in ipairs(RoleModel)do
self.leftTeam:addDragViewItemPos(v.index,v.x,v.y)
end
end

function UIDiscipleBattleSelectWin:initRoleListPanel()
local dataNum=#self.data.disciples
self.RoleListPanel:setChildScrollViewCreateGrids(dataNum,dataNum)
selectNum=0
local grids=self.RoleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local netdata=self.data.disciples[i].netData.net
local item=grids[i-1]
local guid=self.data.disciples[i].netData.net.discipleguid
item:SetChildText(0,UIDiscipleModel:getDiscipleColorName(guid))
if m_sorttypeindex==eDiscipleSortType.eJingJieSort then
local jjlv=netdata.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}阶（{2}）',n,p,pN)
else
jj_str=n
end
item:SetChildText(1,jj_str)
elseif m_sorttypeindex==eDiscipleSortType.eLianTiSort then
local ltlv=netdata.liantilv
local n1,p1=UIDiscipleModel:getLTNameX(ltlv)
local lt_str=''
if p1~=nil then
lt_str=FMT.fmt('{0}{1}层',n1,p1)
else
lt_str=n1
end
item:SetChildText(1,lt_str)
else
item:SetChildText(1,UIDiscipleModel:getDiscipleFightValue(guid))
end
item:SetChildActive(4,selectLookUp[guid]~=nil)

local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(guid)
item:SetChildUIModelShowTarget(3,modelParams.body,modelParams.scale,modelParams.componets,eAnimationID.stand,true)
item:SetChildUIModelShowTargetOffset(3,modelParams.offset[1],modelParams.offset[2])
end
end


function UIDiscipleBattleSelectWin:onClickRoleItemCallback(clicknum,index)
index=index+1
if index==0 then
return
end
local netdata=self.data.disciples[index].netData.net
local grid=self.RoleListPanel:getChildScrollViewItemWidget(index-1)

if selectLookUp[netdata.discipleguid]then
selectNum=selectNum-1
local guidIndex=self.getGUIDIndex(netdata.discipleguid)
selectList[guidIndex]=nil
selectLookUp[netdata.discipleguid]=nil
if grid then
grid:SetChildActive(4,false)
end
self:setRoleModel(guidIndex-1,-1)
else
local emptyIndex=self.getEmpty()
if emptyIndex then
selectNum=selectNum+1
selectList[emptyIndex]=netdata.discipleguid
selectLookUp[netdata.discipleguid]=true
if grid then
grid:SetChildActive(4,true)
end
self:setRoleModel(emptyIndex-1,netdata.discipleguid)
end
end
end

function UIDiscipleBattleSelectWin:exchangeRoleItem(index,targetindex)
if selectList[index]then
local temp=selectList[index]
selectList[index]=selectList[targetindex]
selectList[targetindex]=temp
self:setRoleModel(index-1,selectList[index]or-1)
self:setRoleModel(targetindex-1,selectList[targetindex]or-1)
end
end

function UIDiscipleBattleSelectWin:setRoleModel(roleIndex,guid)
local role=self.leftTeam:getDragViewItem(roleIndex)
if role then
if guid~=-1 then
role:SetChildActive(0,true)
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(guid)
role:SetChildUIModelShowTarget(0,modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,true)
role:SetChildUIModelShowTargetOffset(0,modelParams.offset[1],modelParams.offset[2])
else
role:SetChildActive(0,false)
end
end
end

function UIDiscipleBattleSelectWin.getEmpty()
for i=1,maxSelect do
if not selectList[i]then
return i
end
end
end

function UIDiscipleBattleSelectWin.getGUIDIndex(guid)
for i,v in pairs(selectList)do
if v==guid then
return i
end
end
end

function UIDiscipleBattleSelectWin:onSelectButton()
self.data.callback(selectList)
end

function UIDiscipleBattleSelectWin:beginDragCallback(index,position)
self.dragObject:setActive(true)
if selectList[index+1]then
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(selectList[index+1])
self.winid:SetChildUIModelShowTarget(self.dragObject:getID(),modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,true)
self.winid:SetChildUIModelShowTargetOffset(self.dragObject:getID(),modelParams.offset[1],modelParams.offset[2])
local role=self.leftTeam:getDragViewItem(index)
role:SetChildUIModelShowTarget(0,modelParams.body,0,modelParams.componets,eAnimationID.stand,true)
end
end

function UIDiscipleBattleSelectWin:dragCallback(index,position)
self.dragObject:setChildPosition(Vector3(position.x,position.y,1))
end

function UIDiscipleBattleSelectWin:endDragCallback(index,position)
self.dragObject:setActive(false)
local x=position.x
local y=position.y

for i,v in ipairs(RoleModel)do
local role=self.leftTeam:getDragViewItem(v.index)
local pos=role:GetChildGameObject(0).transform.position
if pos.x-1.5/2<=x and pos.x+1.5/2>=x and pos.y-1.5/2<=y and pos.y+1.5/2>=y then
self:exchangeRoleItem(index+1,i)
break
end
end
self:setRoleModel(index,selectList[index+1]or-1)
end


function UIDiscipleBattleSelectWin:OnEnable()

end


function UIDiscipleBattleSelectWin:OnDisable()

end


