







def_class("UIFightTeamPrefabPanel",UIWindowBase)









function UIFightTeamPrefabPanel:bindComponents()

self.txtWork=UIText.get(self,0)
self.nullObject=UIObject.get(self,1)
self.nullBg=UIObject.get(self,2)
self.scrollview=UIObject.get(self,3)
self.DragRect=UIObject.get(self,4)
self.teamNum=UIText.get(self,5)
self.btnFire=UIButton.get(self,6)
self.btnWork=UIButton.get(self,7)
self.contect=UIObject.get(self,8)
self.teamBg=UIObject.get(self,9)

self.btnFire:setButtonClick(function()self:onBtnFire()end)

self.btnWork:setButtonClick(function()self:onBtnWork()end)



end


function UIFightTeamPrefabPanel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.txtWork);self.txtWork=nil;
_UIObject_release(self.nullObject);self.nullObject=nil;
_UIObject_release(self.nullBg);self.nullBg=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.DragRect);self.DragRect=nil;
_UIObject_release(self.teamNum);self.teamNum=nil;
_UIObject_release(self.btnFire);self.btnFire=nil;
_UIObject_release(self.btnWork);self.btnWork=nil;
_UIObject_release(self.contect);self.contect=nil;
_UIObject_release(self.teamBg);self.teamBg=nil;
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
zf=13,
fight=15,
zhenfaKuang=16,
zhenfaNull=17,
img_logo=18,
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
spDzFlag=15,
}

local ColorToFrame={
[eQualityColor.eGreen]='frame_dzkplvse',
[eQualityColor.eBlue]='frame_dzkplanse',
[eQualityColor.ePurple]='frame_dzkpzise',
[eQualityColor.eOrange]='frame_dzkpchengse',
[eQualityColor.eRed]='frame_dzkphongse',
}
local diziabname='ui/windows/disciple/sharedtextures/uidisciplecolorframeicons.ab'
local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local imageabname='ui/windows/fight/sharedtextures/fight_prepare.ab'
local imageassetname='icon_zdtabtp_'

local _this=nil


function UIFightTeamPrefabPanel:onLoaded(...)
self:bindComponents()
_this=self
self.scrollview:setChildScrollViewInit(0.5,true,function(clicknum,i)
self:onClickItem(i+1,true)
end,function(clicknum,i)
self:onLongClickItem(i+1)
end)
local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]-1
UIManager:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,sortOrder=sortOrder})

end


function UIFightTeamPrefabPanel:__delete()
self.scrollview:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=self
UIManager:closeWindow("UIRawImageBackWin")
end




function UIFightTeamPrefabPanel:onShow(argtable,afterOnloaded)

self.inputTeamList=argtable.teamList

self.selectWinName=argtable.winName

self:freshInfo()
end


function UIFightTeamPrefabPanel:onHide()

end

function UIFightTeamPrefabPanel:freshInfo()
self.editMode=false

self:setTeamList(true)
end

function UIFightTeamPrefabPanel:setTeamList(init)
self.teamList=fightPreSelectModel:getTeamPrefabList()

local list=self:getPrePanelTeam()
local haveTeam=fightPreSelectModel:haveTeamPrefab(list)
self.select_index=haveTeam
self.last_select_index=self.select_index
if init then
self.scrollview:setChildScrollViewCreateGrids(fightPreSelectModel.maxTeamNum,1)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local isZero=0
for i=1,fightPreSelectModel.maxTeamNum do
local item=self.grids[i-1]
if item then
local rZero=self:refreshItem(i-1,item)
if not rZero then
isZero=isZero+1
end
end
end
local num=fightPreSelectModel.maxTeamNum-isZero

if self.select_index then
if num>=3 then
self.scrollview:setChildScrollViewSelectItem(self.select_index-1,true,false,false)
end
end

self.nullBg:setActive(num==0)
self.teamBg:setActive(num~=0)
self.teamNum:setText(FMT.fmt("编队数量：{0}/{1}",num,fightPreSelectModel.maxTeamNum))
else
self:refreshAllItem()
end
end

function UIFightTeamPrefabPanel:refreshItem(id,item)
id=id+1
local teamData=self.teamList[id]

if teamData and next(teamData[2])then
local allZero=true
for i,v in pairs(teamData[2])do
if tostring(v)~='0'then
allZero=false
break
end
end
if allZero then
item:SetChildActive(widgetIndex.this,false)
return false
else
item:SetChildActive(widgetIndex.this,true)
end
else
item:SetChildActive(widgetIndex.this,false)
return false
end



local gridNum=#widgetIndex.posWidget

local name=teamData[1]
local team=teamData[2]
local zf=teamData[3]or 0
local fight=0
local grid=nil
local guid=nil
for i=1,gridNum do
grid=item:GetChildWidgetBase(widgetIndex.posWidget[i])
guid=team[i]
if grid then
local diziData=UIDiscipleModel:getMyDiscipleData(guid)
if diziData==nil then
team[i]=int64.zero
guid=int64.zero
end
if guid and tonumber(tostring(guid))>0 then
local state=UIDiscipleModel:getDiscipleState(guid)
local checkImminent=state==DISCIPLE_STATE_TYPE.eChuiWei
grid:SetChildActive(roleItemIndex.colorRoot,true)
grid:SetChildActive(roleItemIndex.bgRoot,false)
grid:SetChildText(roleItemIndex.name,UIDiscipleModel:getDiscipleName(guid))
comHelper.setChildModelRawImage(grid,guid,roleItemIndex.head,0,eHeadCenterType.eHead,nil,checkImminent)
local color=UIDiscipleModel:getDiscipleColor(guid)
grid:SetChildCSImageSprite(roleItemIndex.color,diziabname,ColorToFrame[color])
grid:SetChildActive(roleItemIndex.chuiweiback,checkImminent)
grid:SetChildActive(roleItemIndex.chuiweiImg,checkImminent)
local jobIcon=UIDiscipleModel:getJobIconNameX(guid)
grid:SetChildCSImageSprite(roleItemIndex.job,globalab,jobIcon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
grid:SetChildActive(roleItemIndex.spDzFlag,isSpDz)
local onefight=UIDiscipleModel:getDiscipleFightValue(guid)

fight=fight+onefight
grid:SetChildText(roleItemIndex.sortAttr,FMT.fmt('<color=#7d3b17>战</color> {0}',mathHelper.formatNumber3(onefight)))
UIDiscipleController.refreshCommonItemTianMing(grid,UIDiscipleModel:getDiscipleData(guid),14)
grid:SetChildLocalPos(14,-48,20,0)
grid:SetChildScale(14,Vector3.New(0.75,0.75,1))
if self.select_index==id then
grid:SetChildActive(roleItemIndex.dark,true)
grid:SetChildText(roleItemIndex.level,"")
else
grid:SetChildActive(roleItemIndex.dark,false)
grid:SetChildText(roleItemIndex.level,UIDiscipleModel:getDiscipleJJLevel(guid)or 0)
end
else
grid:SetChildActive(roleItemIndex.colorRoot,false)
grid:SetChildActive(roleItemIndex.bgRoot,true)
end
end
end

item:SetChildText(widgetIndex.name,name or"")
item:SetChildActive(widgetIndex.select,self.select_index==id)
item:SetChildActive(widgetIndex.img_logo,self.select_index~=id)
item:SetChildActive(widgetIndex.nameBtn,self.select_index~=id)
item:SetChildText(widgetIndex.fight,fight)
item:SetChildButtonClick(widgetIndex.nameBtn,function()self:onClickItem(id,true)end)

item:SetChildButtonClick(widgetIndex.removeBtn,function()self:removeTeam(id)end)

if zf~=0 then
item:SetChildActive(widgetIndex.zf,true)
local zhenfaCfg=cfgHelper.get(cfg_zhenfaconfig_get,zf)
if zhenfaCfg then
item:SetChildCSImageIcon(widgetIndex.zf,zhenfaCfg.icon,false)
item:SetChildText(14,zhenfaCfg.name)
end
item:SetChildActive(widgetIndex.zhenfaKuang,true)
item:SetChildActive(widgetIndex.zhenfaNull,false)
else
item:SetChildActive(widgetIndex.zf,false)
item:SetChildText(14,"")
item:SetChildActive(widgetIndex.zhenfaKuang,false)
item:SetChildActive(widgetIndex.zhenfaNull,true)
end

return true
end


function UIFightTeamPrefabPanel:refreshAllItem()
if self.grids then
local grid=nil
for i=1,self.grids.Count do
grid=self.grids[i-1]
if grid then
self:refreshItem(i-1,grid)
end
end
end
end

function UIFightTeamPrefabPanel:refreshEditItem()
if self.grids then
local grid=nil
for i=1,self.grids.Count do
grid=self.grids[i-1]
if grid then
grid:SetChildActive(widgetIndex.leftBg,not self.editMode)
grid:SetChildActive(widgetIndex.removeBtn,self.editMode)
end
end
end
end


function UIFightTeamPrefabPanel:refreshSelect(index)
local item=self.grids[index-1]
self:refreshItem(index-1,item)

end

function UIFightTeamPrefabPanel:onClickItem(index,isClick)
if self.editMode then
return
end
if index<=self.grids.Count then
self.select_index=index
self:refreshSelect(index)
if self.last_select_index then
self:refreshSelect(self.last_select_index)
end
if isClick and self.last_select_index~=self.select_index then
self:selectTeam(index)
end
self.last_select_index=self.select_index
end

self:onClickClose()
end

function UIFightTeamPrefabPanel:onLongClickItem(index)
self.longSelect=index

end

function UIFightTeamPrefabPanel:selectTeam(id)
if self.teamList[id]then
local diziLookUp={}
local diziList={}
local guid
for i,v in ipairs(self.teamList[id][2])do
guid=tostring(v)
if tonumber(guid)~=0 then
diziLookUp[guid]=i
end
diziList[i]=guid
end
local win=UIManager:findActiveWindow(self.selectWinName)
if win then
win:onFastSelect(diziLookUp,diziList)
end

if self.teamList[id][3]and self.teamList[id][3]~=0 then
if win then
win:setZhenFa(self.teamList[id][3])
end

end
UIManager.info("更换阵容成功")
end
end

function UIFightTeamPrefabPanel:changeName(id)
local setNameCB=function(teamName)
fightPreSelectModel:setTeamPrefab(id,teamName or"")
local item=self.grids[id-1]
item:SetChildText(widgetIndex.name,teamName)
fightController.saveTeamPrefabListData()
UIManager.info("更改成功")
end
UIManager:showWindow("UIChangeFightTeamNameWin",{title="更改名称",callback=setNameCB})
end

function UIFightTeamPrefabPanel:removeTeam(id)
fightPreSelectModel:removeTeamPrefab(id)
self:setTeamList()
fightController.saveTeamPrefabListData()
UIManager.info("删除阵容成功")
end


function UIFightTeamPrefabPanel:getPrePanelTeam()
local teamList=self.inputTeamList
if not teamList then
return
end
local list={}
for i=1,5 do
if teamList[i]then
table.insert(list,i,teamList[i][2])
else
table.insert(list,i,int64.zero)
end
end
return list
end

function UIFightTeamPrefabPanel:onSave()

if#fightPreSelectModel:getTeamPrefabList()>=10 then
UIManager.error("编队数量已达上限")
return
end

local list=self:getPrePanelTeam()
local isAllZero=true
for i,v in pairs(list)do
if tonumber(tostring(v))~=0 then
isAllZero=false
break
end
end
if isAllZero then
UIManager.error("请选择弟子上阵")
return
end

local haveTeam=fightPreSelectModel:haveTeamPrefab(list)
if not haveTeam then
local setNameCB=function(teamName)
fightPreSelectModel:insertTeamPrefab(nil,teamName or"",list)
self:setTeamList()
fightController.saveTeamPrefabListData()
UIManager.info("保存成功")
end
UIManager:showWindow("UIChangeFightTeamNameWin",{title="阵容名称",callback=setNameCB})
else
UIManager.error("已有该阵容")
end
end

function UIFightTeamPrefabPanel:onEdit()






UIManager:showWindow("UIFightTeamEditPanel")
end

function UIFightTeamPrefabPanel:onClickClose()
UIManager:closeWindow("UIFightTeamPrefabPanel")
end


































function UIFightTeamPrefabPanel:onBtnFire()

self:onEdit()
end



function UIFightTeamPrefabPanel:onBtnWork()
self:onEdit()
end

