







def_class("UIFightTeamEditPanel",UIWindowBase)









function UIFightTeamEditPanel:bindComponents()

self.txtWork=UIText.get(self,0)
self.nullObject=UIObject.get(self,1)
self.nullBg=UIObject.get(self,2)
self.scrollview=UIEnhancedScrollerLua.get(self,3)
self.DragRect=UIObject.get(self,4)
self.teamNum=UIText.get(self,5)
self.roleListPanel=UIObject.get(self,6)
self.sortTypeDropdown=UIDropdown.get(self,7)
self.UITeamWidgetDrag=UIObject.get(self,8)
self.zhenfaListPanel=UIObject.get(self,9)
self.btnFire=UIButton.get(self,10)
self.btnWork=UIButton.get(self,11)
self.contect=UIObject.get(self,12)

self.btnFire:setButtonClick(function()self:onBtnFire()end)

self.btnWork:setButtonClick(function()self:onBtnWork()end)



end


function UIFightTeamEditPanel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.txtWork);self.txtWork=nil;
_UIObject_release(self.nullObject);self.nullObject=nil;
_UIObject_release(self.nullBg);self.nullBg=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.DragRect);self.DragRect=nil;
_UIObject_release(self.teamNum);self.teamNum=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.UITeamWidgetDrag);self.UITeamWidgetDrag=nil;
_UIObject_release(self.zhenfaListPanel);self.zhenfaListPanel=nil;
_UIObject_release(self.btnFire);self.btnFire=nil;
_UIObject_release(self.btnWork);self.btnWork=nil;
_UIObject_release(self.contect);self.contect=nil;
end



















local widgetIndex=
{
select=0,
gridLayout=1,
name=2,
nameBtn=3,
removeBtn=4,
root=5,
this=6,
leftBg=7,
posWidget={
8,9,10,11,12
},
selectTeam=13,
zhenfa=14,
zhenfaName=15,
addZF=16,
selectZF=17,
iconKuang=18,
zhanli=19,
nullzf=20,
zhanliImg=21,
}

local roleItemIndex=
{
color=0,
head=1,
name=2,
sortAttr=3,
job=4,
dark=5,
root=6,
bgRoot=7,
colorRoot=8,
level=9,
chuiweiback=10,
chuiweiImg=11,
levelBg=12,
hasTeamMark=13,
spDzFlag=15,
}

local zhenFaWidget=
{
icon=0,
name=1,
desc=2,
select=3,
lock=4,
desc2=5,
using=6,
}

local ePanelType=
{
eDizi=1,
eZhenFa=2,
}

local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'

local UIEnScroller=simple_class(UIEnhancedScroller)

local this=nil


function UIFightTeamEditPanel:onLoaded(...)
this=self
UIManager:invokeUIMethod("UIFightPrepareWin","registerEasyTouch",false)
self:bindComponents()
self.zhenfaList={}
self.enhancedscrollscript=UIEnScroller(self.scrollview:getGameObject(),self.scrollview:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self
local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickDiscipleItem(i+1,true)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
local _OnClickZhenFaItemCallback=function(clicknum,i)
self:onClickZhenFaItem(i+1,true)
end
self.zhenfaListPanel:setChildScrollViewInit(-1,true,_OnClickZhenFaItemCallback,nil)

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIFightTeamEditPanel:__delete()
self:unbindComponents()
UIManager:invokeUIMethod("UIFightPrepareWin","registerEasyTouch",true)
this=nil
end




function UIFightTeamEditPanel:onShow(argtable,afterOnloaded)
self.editMode=false
self.selectTeamIndex=1
self.selectTeamPosIndex=1
self.selectDiziIndex=1
self.selectZhenFaIndex=1

self.showPanel=ePanelType.eDizi

self.nameTypeList={eDiscipleSortType.eFightSort,eDiscipleSortType.eLianTiSort,eDiscipleSortType.eColorSort}

self.sortTypeDropdown:setOption(eDiscipleSortTypeName:getName2List2(self.nameTypeList))
self.sortType=eDiscipleSortType.eFightSort
self.sortCondition=UIDiscipleModel:getSaveSortCondition()
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortType-1)
self.lockRefresh=false

self:setTeamList(true)
self:refreshDiscipleList()
end


function UIFightTeamEditPanel:onHide()

end

function UIFightTeamEditPanel:setTeamList(init)
self.teamList=table.deepCopy(fightPreSelectModel:getTeamPrefabList())

self.enhancedscrollscript:initData(self.teamList,165,fightPreSelectModel.maxTeamNum)

self.nullBg:setActive(false)

self:refreshTeamNum()
if init then
self:onClickItem(self.selectTeamIndex,self.selectTeamPosIndex)
end
end

function UIFightTeamEditPanel:refreshTeamNum()
local num=0
if self.teamList then
local team=nil
for i,v in pairs(self.teamList)do
team=v[2]
local allZero=true
for i,v in pairs(team)do
local diziData=UIDiscipleModel:getMyDiscipleData(v)
if diziData==nil then
v=0
end
if tostring(v)~='0'then
allZero=false
break
end
end
if not allZero then
num=num+1
end
end
end
self.teamNum:setText(FMT.fmt("编队数量：{0}/{1}",num,fightPreSelectModel.maxTeamNum))
end

function UIFightTeamEditPanel:refreshItem(id,item)
local teamData=self.teamList[id]

if teamData then

else
self.teamList[id]={"阵容名称",{int64.zero,int64.zero,int64.zero,int64.zero,int64.zero},0}
teamData=self.teamList[id]


end

local gridNum=#widgetIndex.posWidget

local name=teamData[1]
local team=teamData[2]or{}

local zfId=teamData[3]or 0

local grid=nil
local guid=nil
local fight=0
for i=1,gridNum do
grid=item:GetChildWidgetBase(widgetIndex.posWidget[i])
guid=team[i]
if grid then
local diziData=UIDiscipleModel:getMyDiscipleData(guid)
if diziData==nil then
team[i]=int64.zero
guid=int64.zero
end
self:refreshTeamGrid(grid,guid)


grid:SetChildActive(2,self.selectTeamIndex==id and self.selectTeamPosIndex==i)

grid:SetChildButtonClick(3,function()
self:showRightPanel(ePanelType.eDizi)
self:onClickItem(id,i,false)
end)
if guid and tonumber(tostring(guid))>0 then
fight=fight+UIDiscipleModel:getDiscipleFightValue(guid)
end
end
end
local showZF=systemModel.isOpen(SYSTEM_DEFINE.eZhenFa)
item:SetChildActive(widgetIndex.selectTeam,self.selectTeamIndex==id)
item:SetChildActive(widgetIndex.selectZF,showZF and self.selectZF~=nil and self.selectTeamIndex==id)
item:SetChildText(widgetIndex.name,name or"")
item:SetChildText(widgetIndex.zhanli,fight or 0)
item:SetChildActive(widgetIndex.zhanliImg,fight>0)
item:SetChildButtonClick(widgetIndex.nameBtn,function()self:changeName(id)end)
item:SetChildActive(widgetIndex.addZF,showZF)
if not showZF then
item:SetChildAnchoredPos(widgetIndex.gridLayout,0,-16.5)
end
item:SetChildButtonClick(widgetIndex.addZF,function()
self:onClickItem(id,0,true)
self:showRightPanel(ePanelType.eZhenFa)
end)
item:SetChildActive(widgetIndex.nullzf,zfId==0)
if zfId~=0 then
local zhenfaCfg=cfgHelper.get(cfg_zhenfaconfig_get,zfId)
if zhenfaCfg then
item:SetChildActive(widgetIndex.iconKuang,true)
item:SetChildActive(widgetIndex.zhenfa,true)
item:SetChildCSImageIcon(widgetIndex.zhenfa,zhenfaCfg.icon,false)
item:SetChildText(widgetIndex.zhenfaName,zhenfaCfg.name)
end
else

item:SetChildActive(widgetIndex.iconKuang,false)
item:SetChildActive(widgetIndex.zhenfa,false)
item:SetChildText(widgetIndex.zhenfaName,"")
end
end

function UIFightTeamEditPanel:refreshTeamGrid(grid,guid)
local cardGrid=grid:GetChildWidgetBase(0)
if guid and tonumber(tostring(guid))>0 then
local state=UIDiscipleModel:getDiscipleState(guid)
local checkImminent=state==DISCIPLE_STATE_TYPE.eChuiWei
cardGrid:SetChildActive(roleItemIndex.colorRoot,true)
cardGrid:SetChildActive(roleItemIndex.bgRoot,false)
cardGrid:SetChildText(roleItemIndex.name,UIDiscipleModel:getDiscipleName(guid))
comHelper.setChildModelRawImage(cardGrid,guid,roleItemIndex.head,0,eHeadCenterType.eHead,nil,checkImminent)
local color=UIDiscipleModel:getDiscipleColor(guid)
cardGrid:SetChildCSImageSprite(roleItemIndex.color,globalABLookup.diciplecolorframe,discipleColorToFrame[color])
cardGrid:SetChildActive(roleItemIndex.chuiweiback,checkImminent)
cardGrid:SetChildActive(roleItemIndex.chuiweiImg,checkImminent)
local jobIcon=UIDiscipleModel:getJobIconNameX(guid)
cardGrid:SetChildCSImageSprite(roleItemIndex.job,globalab,jobIcon)
local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
cardGrid:SetChildActive(roleItemIndex.spDzFlag,isSpDz)
cardGrid:SetChildText(roleItemIndex.sortAttr,FMT.fmt('<color=#7d3b17>战</color> {0}',UIDiscipleModel:getDiscipleFightValue(guid)))

cardGrid:SetChildText(roleItemIndex.level,UIDiscipleModel:getDiscipleJJLevel(guid)or 0)
cardGrid:SetChildCSImageSprite(roleItemIndex.levelBg,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

UIDiscipleController.refreshCommonItemTianMing(cardGrid,UIDiscipleModel:getDiscipleData(guid),14)
cardGrid:SetChildLocalPosX(14,-48)
cardGrid:SetChildLocalPosY(14,20)
cardGrid:SetChildScale(14,Vector3.New(0.75,0.75,1))
grid:SetChildActive(1,false)
else
cardGrid:SetChildActive(roleItemIndex.colorRoot,false)
cardGrid:SetChildActive(roleItemIndex.bgRoot,true)

grid:SetChildActive(1,true)
end
end

function UIFightTeamEditPanel:getDiscipleList()

local list=discipleLookup:getSortDiscipleList(self.nameTypeList[self.sortType],self.sortCondition,self.sortOrder,{})

self.disciplelist=list

end

function UIFightTeamEditPanel:refreshDiscipleList()
self:getDiscipleList()

local dataNum=#self.disciplelist
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,3)

local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
self:refreshDiscipleGrid(i,item)
end
end

function UIFightTeamEditPanel:refreshDiscipleGrid(id,item)
local netdata=self.disciplelist[id].netData.net

local guid=netdata.discipleguid





local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(roleItemIndex.color,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(roleItemIndex.job,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(roleItemIndex.spDzFlag,isSpDz)

item:SetChildText(roleItemIndex.name,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,roleItemIndex.head,0,eHeadCenterType.eHalf)

item:SetChildText(roleItemIndex.level,UIDiscipleModel:getDiscipleJJLevel(guid)or 0)
item:SetChildCSImageSprite(roleItemIndex.levelBg,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])
UIDiscipleController.refreshCommonItemTianMing(item,UIDiscipleModel:getDiscipleData(guid),14)
if self.nameTypeList[self.sortType]==eDiscipleSortType.eLianTiSort then
local ltlv=netdata.liantilv
local n1,p1=UIDiscipleModel:getLTNameX(ltlv)
local lt_str=''
if p1~=nil then
lt_str=FMT.fmt('{0}{1}层',n1,p1)
else
lt_str=n1
end
item:SetChildText(roleItemIndex.sortAttr,lt_str)
else
item:SetChildText(roleItemIndex.sortAttr,FMT.fmt('<color=#7d3b17>战</color> {0}',UIDiscipleModel:getDiscipleFightValue(guid)))
end

local allTeamData=self.teamList
item:SetChildActive(roleItemIndex.levelBg,true)
item:SetChildActive(roleItemIndex.dark,false)
item:SetChildActive(roleItemIndex.hasTeamMark,false)

local isMarkDark=false
local isMarkTeam=false
for teamIndex,teamData in pairs(allTeamData)do
local team=teamData[2]or{}
if next(team)then
for i,g in pairs(team)do
if tostring(g)==tostring(guid)then
if teamIndex==self.selectTeamIndex then

item:SetChildActive(roleItemIndex.dark,true)
item:SetChildActive(roleItemIndex.levelBg,false)
isMarkDark=true
else

item:SetChildActive(roleItemIndex.hasTeamMark,true)
isMarkTeam=true
end

break
end
end
end

if isMarkDark and isMarkTeam then
break
end
end

end


function UIFightTeamEditPanel:onClickItem(teamIndex,posIndex,clickZF)
local oldTeamIndex=self.selectTeamIndex
local oldPosIndex=self.selectTeamPosIndex
self.selectZF=clickZF
local showZF=systemModel.isOpen(SYSTEM_DEFINE.eZhenFa)
if oldTeamIndex~=teamIndex then
local changeCell=self.enhancedscrollscript:GetCell(oldTeamIndex-1)
if changeCell then
if oldPosIndex~=0 then
local grid=changeCell:GetChildWidgetBase(widgetIndex.posWidget[oldPosIndex])
grid:SetChildActive(2,false)
end
changeCell:SetChildActive(widgetIndex.selectTeam,false)
if showZF then
changeCell:SetChildActive(widgetIndex.selectZF,false)
end
end
changeCell=self.enhancedscrollscript:GetCell(teamIndex-1)
if changeCell then
if clickZF then
if showZF then
changeCell:SetChildActive(widgetIndex.selectZF,true)
end
changeCell:SetChildActive(widgetIndex.selectTeam,true)
else
local grid=changeCell:GetChildWidgetBase(widgetIndex.posWidget[posIndex])
grid:SetChildActive(2,true)
changeCell:SetChildActive(widgetIndex.selectTeam,true)
if showZF then
changeCell:SetChildActive(widgetIndex.selectZF,false)
end
end
end
else
if oldPosIndex~=posIndex then
local changeCell=self.enhancedscrollscript:GetCell(oldTeamIndex-1)
if changeCell then
local grid
if oldPosIndex~=0 then
grid=changeCell:GetChildWidgetBase(widgetIndex.posWidget[oldPosIndex])
grid:SetChildActive(2,false)
end
if clickZF then
if showZF then
changeCell:SetChildActive(widgetIndex.selectZF,true)
end
else
grid=changeCell:GetChildWidgetBase(widgetIndex.posWidget[posIndex])
grid:SetChildActive(2,true)
if showZF then
changeCell:SetChildActive(widgetIndex.selectZF,false)
end
end
end
end
end
self.selectTeamIndex=teamIndex
self.selectTeamPosIndex=posIndex

if oldTeamIndex~=teamIndex or oldPosIndex~=posIndex then
self:refreshDiscipleList()
end
end

function UIFightTeamEditPanel:onClickDiscipleItem(index,isClick)
local cancelDisciple=nil
local oldDiscipleIndex=nil
local netdata=self.disciplelist[index].netData.net
if netdata then
local guid=netdata.discipleguid
local teamData=self.teamList[self.selectTeamIndex]
local team=teamData[2]or{}
local selectedIndex=0
if next(team)then
for i,g in pairs(team)do
if tostring(g)==tostring(guid)then
selectedIndex=i
cancelDisciple=true
break







end
end
end
if cancelDisciple then
self.teamList[self.selectTeamIndex][2][selectedIndex]=int64.zero
self.selectTeamPosIndex=selectedIndex
else
local oldGuid=self.teamList[self.selectTeamIndex][2][self.selectTeamPosIndex]
self.teamList[self.selectTeamIndex][2][self.selectTeamPosIndex]=guid
local oldStrGuid=tostring(oldGuid)
if oldGuid and oldStrGuid~=tostring(int64.zero)then
for i,v in pairs(self.disciplelist)do
if oldStrGuid==tostring(v.netData.net.discipleguid)then
oldDiscipleIndex=i
break
end
end
end


teamData=self.teamList[self.selectTeamIndex]
team=teamData[2]or{}
if next(team)then
local newIndex=nil
for i,g in pairs(team)do
if tostring(g)=='0'then
newIndex=i
break
end
end
if newIndex then
self.selectTeamPosIndex=newIndex
end
end

end
local grid=self.roleListPanel:getChildScrollViewItemWidget(index-1)
if grid then
self:refreshDiscipleGrid(index,grid)
end
if oldDiscipleIndex then
grid=self.roleListPanel:getChildScrollViewItemWidget(oldDiscipleIndex-1)
if grid then
self:refreshDiscipleGrid(oldDiscipleIndex,grid)
end
end
local changeCell=self.enhancedscrollscript:GetCell(self.selectTeamIndex-1)
if changeCell then
self:refreshItem(self.selectTeamIndex,changeCell)
end


self:refreshTeamNum()
end
end

function UIFightTeamEditPanel:refreshZhenFaList()

if not next(self.zhenfaList)then
local cfg=cfg_zhenfaconfig()
for i,v in pairs(cfg)do
table.insert(self.zhenfaList,i)
end
table.sort(self.zhenfaList)
end

local dataNum=#self.zhenfaList
self.zhenfaListPanel:setChildScrollViewCreateGrids(dataNum,1)

local grids=self.zhenfaListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
self:refreshZhenFaGrid(i,item)
end
end

function UIFightTeamEditPanel:refreshZhenFaGrid(index,item)
local zhenfaCfg=cfgHelper.get(cfg_zhenfaconfig_get,self.zhenfaList[index])
if not zhenfaCfg then
return
end
local id=zhenfaCfg.id
if id==self.teamList[self.selectTeamIndex][3]then
self.selectZhenFaIndex=index
end
local level=zhenfaModel:getZhenFaData(id)
local isActived=level>0

item:SetChildCSImageIcon(zhenFaWidget.icon,zhenfaCfg.icon,false)

item:SetChildImageExGray(zhenFaWidget.icon,not isActived)

item:SetChildText(zhenFaWidget.name,zhenfaCfg.name)
item:SetChildActive(zhenFaWidget.lock,not isActived)
item:SetChildActive(zhenFaWidget.select,id==self.teamList[self.selectTeamIndex][3])
item:SetChildActive(zhenFaWidget.using,id==self.teamList[self.selectTeamIndex][3])
if isActived then
local str=zhenfaCfg.desc[level]
local round=0
for i,v in ipairs(zhenfaCfg.extra)do
if v[1]<=self.totalZFLv then
if type(v[2])=='number'then
round=math.max(round,v[2])
end
end
end

item:SetChildText(zhenFaWidget.desc,str)

else
item:SetChildText(zhenFaWidget.desc,zhenfaCfg.desc[1])
end

end

function UIFightTeamEditPanel:calZFLevel()

local teamData=self.teamList[self.selectTeamIndex]
local team=teamData[2]or{}
self.totalZFLv=0
if next(team)then
for i,g in pairs(team)do
if tostring(g)~="0"then
self.totalZFLv=self.totalZFLv+UIDiscipleModel:getDiscipleJobLevel(g,DISCIPLE_PROSKILL_TYPE.eZhenFa)
end
end
end
self:refreshZhenFaList()
end


function UIFightTeamEditPanel:onClickZhenFaItem(index)
local zhenfaCfg=cfgHelper.get(cfg_zhenfaconfig_get,self.zhenfaList[index])
if not zhenfaCfg then
return
end
local id=zhenfaCfg.id
local level=zhenfaModel:getZhenFaData(id)
local isActived=level>0
if not isActived then
UIManager.error("阵法未激活")
return
end

local oldIndex=self.selectZhenFaIndex
if oldIndex~=index then
local grid=self.zhenfaListPanel:getChildScrollViewItemWidget(oldIndex-1)
if grid then
grid:SetChildActive(zhenFaWidget.select,false)
end
end
local grid=self.zhenfaListPanel:getChildScrollViewItemWidget(index-1)
if grid then
grid:SetChildActive(zhenFaWidget.select,true)
end
self.selectZhenFaIndex=index

self.teamList[self.selectTeamIndex][3]=id

local changeCell=self.enhancedscrollscript:GetCell(self.selectTeamIndex-1)
if changeCell then
self:refreshItem(self.selectTeamIndex,changeCell)
end
end

function UIFightTeamEditPanel:showRightPanel(pType)
if pType==ePanelType.eDizi then
self.roleListPanel:setActive(true)
self.zhenfaListPanel:setActive(false)
else
self.roleListPanel:setActive(false)
self.zhenfaListPanel:setActive(true)
self:calZFLevel()
end
end

function UIFightTeamEditPanel:changeName(id)
local setNameCB=function(teamName)
self.teamList[id][1]=teamName
fightPreSelectModel:setTeamPrefab(id,teamName or"")
local cell=self.enhancedscrollscript:GetCell(id-1)
if cell then
cell:SetChildText(widgetIndex.name,teamName)
end
fightController.saveTeamPrefabListData()
UIManager.info("更改成功")
end
UIManager:showWindow("UIChangeFightTeamNameWin",{title="更改名称",callback=setNameCB})
end

function UIFightTeamEditPanel:onDropdownChange(idx)

if self.lockRefresh then return end
idx=idx+1
self.sortType=idx

self:refreshDiscipleList()
end

function UIFightTeamEditPanel:onSortConditionClick()
if self.filterName==nil or self.filterFlag==nil then
self.filterName,self.filterFlag=discipleLookup:getConditonFilter(self.sortCondition)
end
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=3
args.extraWin='UIFilterWin'
local extraParams={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIFightTeamEditPanel.selecConditionBack(data)

if this==nil then
return
end
this.filterFlag=data.filterFlag
this.sortCondition={}
for i,v in ipairs(this.filterFlag)do
this.sortCondition[i]={}
local fns=this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(this.sortCondition[i],fns[i1].typeid)
end
end
end

this:refreshDiscipleList()
end

function UIEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIEnScroller:RefreshCell(dataIndex,cellIndex,cell)
self.window:refreshItem(dataIndex,cell)
end

function UIEnScroller:onItemBeginDrag(dataIndex,screenPos,cell)
local gridNum=#widgetIndex.posWidget

local grid=nil
local gridPos=nil
local leftTop=nil
local rightDown=nil
for i=1,gridNum do
grid=cell:GetChildWidgetBase(widgetIndex.posWidget[i])
leftTop=grid:GetChildUIScreenPos(4)
rightDown=grid:GetChildUIScreenPos(5)
gridPos=cell:GetChildUIScreenPos(widgetIndex.posWidget[i])
if screenPos.x>=leftTop.x and screenPos.x<=rightDown.x and screenPos.y<=leftTop.y and screenPos.y>=rightDown.y then
self.dragIndex=i
self.posY=gridPos.y
end
if i==1 then
self.posMinX=gridPos.x
elseif i==gridNum then
self.posMaxX=gridPos.x
end
end
if self.dragIndex then
local teamData=self.window.teamList[dataIndex+1]
if teamData then
local team=teamData[2]or{}
local guid=team[self.dragIndex]
if guid and tostring(guid)~='0'then
grid=self.window.UITeamWidgetDrag:getWidgetBase()
self.window:refreshTeamGrid(grid,guid)
self.window.UITeamWidgetDrag:setChildUIScreenPos(screenPos)
self.window.UITeamWidgetDrag:setActive(true)

cell:SetChildActive(widgetIndex.posWidget[self.dragIndex],false)
else
self.dragIndex=nil
end
end
end
end

function UIEnScroller:onItemDrag(dataIndex,screenPos,cell)
if self.dragIndex then
local posX=screenPos.x
if posX<self.posMinX then
posX=self.posMinX
elseif posX>self.posMaxX then
posX=self.posMaxX
end
local pos=Vector3.New(posX,self.posY,screenPos.z)
self.window.UITeamWidgetDrag:setChildUIScreenPos(pos)
end
end

function UIEnScroller:onItemEndDrag(dataIndex,screenPos,cell)
if self.dragIndex then
local changeIndex=nil
local posX=screenPos.x
if posX<self.posMinX then
posX=self.posMinX
elseif posX>self.posMaxX then
posX=self.posMaxX
end
local pos=Vector3.New(posX,self.posY,screenPos.z)
local gridNum=#widgetIndex.posWidget
local grid=nil
local leftTop=nil
local rightDown=nil
for i=1,gridNum do
grid=cell:GetChildWidgetBase(widgetIndex.posWidget[i])
leftTop=grid:GetChildUIScreenPos(4)
rightDown=grid:GetChildUIScreenPos(5)
if pos.x>=leftTop.x and pos.x<=rightDown.x and pos.y<=leftTop.y and pos.y>=rightDown.y then
changeIndex=i
break
end
end

if changeIndex then
local teamData=self.window.teamList[dataIndex+1]
if teamData then
local team=teamData[2]or{}
local temp=team[self.dragIndex]
team[self.dragIndex]=team[changeIndex]
team[changeIndex]=temp
self.window:refreshItem(dataIndex+1,cell)
end
end

cell:SetChildActive(widgetIndex.posWidget[self.dragIndex],true)
self.window.UITeamWidgetDrag:setActive(false)
self.dragIndex=nil
end
end





function UIFightTeamEditPanel:onBtnFire()
fightPreSelectModel:setTeamPrefabList(self.teamList)
fightController.saveTeamPrefabListData()
UIManager.info("保存成功")
UIManager:invokeUIMethod("UIFightTeamPrefabPanel","freshInfo")
self:onClickClose()
end



function UIFightTeamEditPanel:onBtnWork()
end

function UIFightTeamEditPanel:onEdit()
self.editMode=not self.editMode
self:refreshEditItem()

self.btnWork:setActive(not self.editMode)
self.btnFire:setActive(self.editMode)
self.contect:getChildPosition()
end

function UIFightTeamEditPanel:onClickClose()
UIManager:closeWindow("UIFightTeamEditPanel")
end
