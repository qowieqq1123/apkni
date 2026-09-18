







def_class("UIMysteryChangeTeamWin",UIWindowBase)









function UIMysteryChangeTeamWin:bindComponents()

self.FullMask=UIObject.get(self,0)
self.cancelButton=UIButton.get(self,1)
self.dragObject=UIObject.get(self,2)
self.autoSelectButton=UIButton.get(self,3)
self.clearButton=UIButton.get(self,4)
self.zfBtn=UIButton.get(self,5)
self.multiFight=UIObject.get(self,6)
self.titleRoot=UIObject.get(self,7)
self.singleFight=UIObject.get(self,8)
self.selectText=UIText.get(self,9)
self.zfIcon=UIImage.get(self,10)
self.zfName=UIText.get(self,11)
self.titleText=UIText.get(self,12)
self.fightText=UIText.get(self,13)
self.helpButton=UIButton.get(self,14)
self.RoleTypeListPanel=UIObject.get(self,15)
self.diziButton=UIButton.get(self,16)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,17)
self.selectButton=UIButton.get(self,18)
self.mask=UIObject.get(self,19)
self.monsterFightText=UIText.get(self,20)
self.selfFightText=UIText.get(self,21)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.autoSelectButton:setButtonClick(function()self:onAutoSelectButton()end)

self.clearButton:setButtonClick(function()self:onClearButton()end)

self.zfBtn:setButtonClick(function()self:onZfBtn()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.diziButton:setButtonClick(function()self:onDiziButton()end)

self.selectButton:setButtonClick(function()self:onSelectButton()end)



end


function UIMysteryChangeTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.FullMask);self.FullMask=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.dragObject);self.dragObject=nil;
_UIObject_release(self.autoSelectButton);self.autoSelectButton=nil;
_UIObject_release(self.clearButton);self.clearButton=nil;
_UIObject_release(self.zfBtn);self.zfBtn=nil;
_UIObject_release(self.multiFight);self.multiFight=nil;
_UIObject_release(self.titleRoot);self.titleRoot=nil;
_UIObject_release(self.singleFight);self.singleFight=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.zfIcon);self.zfIcon=nil;
_UIObject_release(self.zfName);self.zfName=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.RoleTypeListPanel);self.RoleTypeListPanel=nil;
_UIObject_release(self.diziButton);self.diziButton=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.selectButton);self.selectButton=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.monsterFightText);self.monsterFightText=nil;
_UIObject_release(self.selfFightText);self.selfFightText=nil;
end


















local UIPrepareEnScroller=simple_class(UIEnhancedScroller)

local m_sorttypeindex=eDiscipleSortType.eFightSort

local selectList={}
local selectLookUp={}
local preloadList={}
local npcList={}
local selectNum=0
local selectFight=0
local maxSelect=5
local minSelect=1
local maxPos=5
local selectZF=nil
local _this=nil

local dragIndex=nil
local dragBeginData=nil
local dragEndData=nil
local dragDataIndex=nil
local dragDiziData=nil

local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local imageabname='ui/windows/fight/sharedtextures/fight_prepare.ab'
local diziabname='ui/windows/disciple/sharedtextures/uidisciplecolorframeicons.ab'
local ColorToFrame={
[eQualityColor.eGreen]='frame_dzkplvse',
[eQualityColor.eBlue]='frame_dzkplanse',
[eQualityColor.ePurple]='frame_dzkpzise',
[eQualityColor.eOrange]='frame_dzkpchengse',
[eQualityColor.eRed]='frame_dzkphongse',
}

local sortType=
{
eDiscipleSortType.eFightSort,
eDiscipleSortType.eJingJieSort,
eDiscipleSortType.eLianTiSort,
eDiscipleSortType.eColorSort,
}

local roleItemIndex=
{
name=0,
fight=1,
color=5,
job=8,
state=11,
npc=12,
spDzFlag=38,
}
local imageassetname='icon_zdtabtp_'


function UIMysteryChangeTeamWin:onLoaded(...)
self:bindComponents()

_this=self

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

local _OnClickRoleSortItemCallback=function(...)
self:OnClickRoleSortItemCallback(...)
end

self.RoleTypeListPanel:setChildScrollViewInit(-1,true,_OnClickRoleSortItemCallback,nil)

selectFight=0



end


function UIMysteryChangeTeamWin:__delete()

fightController:closeSelectStage()


self:unbindComponents()
end




function UIMysteryChangeTeamWin:onShow(argtable,afterOnloaded)

selectNum=0
selectList={}
selectLookUp={}
self.needClosePreSelectStage=true
self.skipDiscipleStateCheck=false
if argtable then
self.dontCloseStage=argtable.dontCloseStage
self.isFullOpen=argtable.isFullOpen

self.fbId=argtable.fbId

self.showZhenFa=argtable.showZhenFa or true
self.lockZhenFa=argtable.lockZhenFa
self.enterBehaviorId=argtable.enterBehaviorId
self.sureBodyid=argtable.sureBodyid
self.sureBodyAnim=argtable.sureBodyAnim


self.monsterPosType=stagePosType.TwoThree

if argtable.titleText then
self.titleText:setText(argtable.titleText)
end


self.selectStage=argtable.selectStage
self.selectStage.onEventChange=self.onEventChange
end

self.sortOrder=eSortOrder.eDown

self.zfBtn:setActive(self.showZhenFa and systemModel.isOpen(SYSTEM_DEFINE.eZhenFa))
if self.lockZhenFa then
self:setZhenFa(self.lockZhenFa)
end

local enterTxt="秘境"
self.selectText:setText(enterTxt)

if self.cantEnter then
self.selectButton:setGray(true)
end

if self.sureBodyid then
self.selectButton:setChildDragonTarget(self.sureBodyid,1,nil,eAnimationID.stand,false,0,false,nil)
else
self.selectButton:setChildDragonTarget(2068,1,nil,eAnimationID.stand,false,0,false,nil)
end

if self.enterBehaviorId then
local enterBehaviorCfg=cfgHelper.get1(cfg_fightprepareentergroupconfig_get,self.enterBehaviorId)
self.leftPosBehavior=enterBehaviorCfg.leftPos
self.rightPosBehavior=enterBehaviorCfg.rightPos
self.leftOutPosBehavior=enterBehaviorCfg.leftOutPos
self.rightOutPosBehavior=enterBehaviorCfg.rightOutPos
end


self.useAllDisciple=nil
self:initRoleListPanel(self.leftPosBehavior)

if self.useAllDisciple then
self.RoleTypeListPanel:setActive(true)
self:initRoleTypeListPanel()
self:OnClickRoleSortItemCallback(1,0)
end
self:setFight()
end

function UIMysteryChangeTeamWin.onEventChange(evtType,entityId,posIndex)

if not _this then
return
end
if evtType==1 then
dragIndex=posIndex
if selectList[posIndex]then
dragDiziData=selectList[posIndex]

end

elseif evtType==3 then
if _this then
local xiaZhen=_this.useAllDisciple



if xiaZhen then
if dragIndex then
if posIndex~=-1 then

_this:exchangeRoleItem(dragIndex,posIndex)
else


_this:onSelectDown(dragIndex)
end
else
if posIndex~=-1 then
if dragBeginData then

_this:onSelectUp(dragBeginData[3],posIndex)
end
end
end
else
if dragBeginData and posIndex~=-1 then
if selectList[posIndex]then
_this:exchangeRoleItemWithEntity(dragBeginData[1],posIndex)
else
selectList[dragBeginData[1]]=nil
_this.selectStage:removeEntity(dragBeginData[1])
selectList[posIndex]=dragBeginData[2]
_this:addEntity(posIndex,dragBeginData[2].unitType,dragBeginData[2].unitId)
end
end
if dragIndex then
if posIndex~=-1 then
_this:exchangeRoleItem(dragIndex,posIndex)
end
end
end
end

dragDataIndex=nil
dragDiziData=nil
dragBeginData=nil
dragEndData=nil
dragIndex=nil
end
end

function UIMysteryChangeTeamWin:initRoleTypeListPanel()
self.RoleTypeListPanel:setChildScrollViewCreateGrids(#sortType,1)
local grids=self.RoleTypeListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,eDiscipleSortTypeName:getName1(i))
item:SetChildCSImageSprite(1,imageabname,FMT.fmt('{0}{1}',imageassetname,i))
end
end

function UIMysteryChangeTeamWin:OnClickRoleSortItemCallback(clicknum,index)
local oldIndex
if index+1~=m_sorttypeindex then
oldIndex=m_sorttypeindex
end
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
self:sortDiziList()
self:refreshRoleList()
end
end


function UIMysteryChangeTeamWin:getSelectNum()
local num=0
for i,v in pairs(selectList)do
num=num+1
end
return num
end


function UIMysteryChangeTeamWin:setTopMask(active)
self.topMask:setActive(active)
end


function UIMysteryChangeTeamWin:refreshRoleList()
if self.disciplesList then
local dataNum=#self.disciplesList
self.enhancedscrollscript:initData(self.disciplesList,160,dataNum)
end
end

function UIMysteryChangeTeamWin:getCanUseShouYuanDisciples()
local list={}

local lsDiscipleList=MysteryModel:getLinShiDiscipleList()
if lsDiscipleList then
for i,v in pairs(lsDiscipleList)do
local data=v
local teamDis=MysteryModel:get_fb_probeTeam_disciple(2,v.guid)
if teamDis then
data.blood=teamDis.blood
end
table.insert(list,data)
end
end

local disciples=UIDiscipleModel:getAllDiscipleDataX()
for k,v in pairs(disciples)do
local net=v.netData.net
local guid=net.discipleguid
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(guid)
local checkChuiwei=UIDiscipleModel:checkDiscipleState(guid,DISCIPLE_STATE_TYPE.eChuiWei)

if shouyuan~=0 and not checkChuiwei then
local data={unitType=1,unitId=guid}
local dis=MysteryModel:getHisDisciple(guid)
local teamDis=MysteryModel:get_fb_probeTeam_disciple(1,guid)
if dis then
data.guid=dis.guid
if teamDis then
data.blood=teamDis.blood
else
data.blood=dis.blood
end
table.insert(list,data)
else
data.guid=guid
if teamDis then
data.blood=teamDis.blood
else
data.blood=10000
end
table.insert(list,data)
end

end
end
return list
end

function UIMysteryChangeTeamWin:initRoleListPanel()
self.teamList=MysteryModel:get_fb_probeTeamX()

if self.teamList then
local useAllDisciple=false
if MysteryModel:canUseAllDisciple(self.fbId)then
useAllDisciple=true
end
self.useAllDisciple=useAllDisciple
local fight=0
local list={}
for k,v in pairs(self.teamList)do
if tostring(v.unitId)~='0'then
if not useAllDisciple or v.blood>0 then
table.insert(list,v)
selectList[k]=v
self:addEntity(k,v.unitType,v.unitId)
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
fight=fight+UIDiscipleModel:getDiscipleFightValue(v.unitId)
elseif v.unitType==fightPreSelectModel.teamEntityType.npc then
fight=fight+fightPreSelectModel.getNPCFightValue(v.unitId)
end
end
end
end

if useAllDisciple then
list=self:getCanUseShouYuanDisciples()
end

table.sort(list,function(a,b)
local fightA=0
if a.unitType==fightPreSelectModel.teamEntityType.dizi then
fightA=UIDiscipleModel:getDiscipleFightValue(a.unitId)
elseif a.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(a.unitId))
fightA=fightPreSelectModel.getNPCFightValue(unitId)+1000000000
end
local fightB=0
if b.unitType==fightPreSelectModel.teamEntityType.dizi then
fightB=UIDiscipleModel:getDiscipleFightValue(b.unitId)
elseif b.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(b.unitId))
fightB=fightPreSelectModel.getNPCFightValue(unitId)+1000000000
end
if a.blood<=0 then
fightA=fightA-100000000
end
if b.blood<=0 then
fightB=fightB-100000000
end
return fightA>fightB
end)

self.disciplesList=list

self:refreshRoleList()

self.fightText:setText(fight)

if useAllDisciple then
self:showAutoSelectButton()
end
end
end

function UIMysteryChangeTeamWin:sortDiziList()
local list=self.disciplesList
table.sort(list,function(a,b)
local sortNumA=0
local sortNumB=0
if m_sorttypeindex==eDiscipleSortType.eFightSort then
if a.unitType==fightPreSelectModel.teamEntityType.dizi then
sortNumA=UIDiscipleModel:getDiscipleFightValue(a.unitId)
elseif a.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(a.unitId))
sortNumA=fightPreSelectModel.getNPCFightValue(unitId)+1000000000
end
if b.unitType==fightPreSelectModel.teamEntityType.dizi then
sortNumB=UIDiscipleModel:getDiscipleFightValue(b.unitId)
elseif b.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(b.unitId))
sortNumB=fightPreSelectModel.getNPCFightValue(unitId)+1000000000
end
elseif m_sorttypeindex==eDiscipleSortType.eJingJieSort then
if a.unitType==fightPreSelectModel.teamEntityType.dizi then
local data=UIDiscipleModel:getDiscipleData(a.unitId)
sortNumA=data.jingjielv
elseif a.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(a.unitId))
sortNumA=(fightPreSelectModel.getNPCConfig(unitId).jingjie or 1)+1000000000
end
if b.unitType==fightPreSelectModel.teamEntityType.dizi then
local data=UIDiscipleModel:getDiscipleData(b.unitId)
sortNumB=data.jingjielv
elseif b.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(b.unitId))
sortNumB=(fightPreSelectModel.getNPCConfig(unitId).jingjie or 1)+1000000000
end
elseif m_sorttypeindex==eDiscipleSortType.eLianTiSort then
if a.unitType==fightPreSelectModel.teamEntityType.dizi then
local data=UIDiscipleModel:getDiscipleData(a.unitId)
sortNumA=data.liantilv
elseif a.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(a.unitId))
sortNumA=(fightPreSelectModel.getNPCConfig(unitId).lianti or 1)+1000000000
end
if b.unitType==fightPreSelectModel.teamEntityType.dizi then
local data=UIDiscipleModel:getDiscipleData(b.unitId)
sortNumB=data.liantilv
elseif b.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(b.unitId))
sortNumB=(fightPreSelectModel.getNPCConfig(unitId).lianti or 1)+1000000000
end
elseif m_sorttypeindex==eDiscipleSortType.eColorSort then
if a.unitType==fightPreSelectModel.teamEntityType.dizi then
local data=UIDiscipleModel:getDiscipleImageInfo(a.unitId)
sortNumA=data.color
elseif a.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(a.unitId))
sortNumA=(fightPreSelectModel.getNPCConfig(unitId).color or 1)+1000000000
end
if b.unitType==fightPreSelectModel.teamEntityType.dizi then
local data=UIDiscipleModel:getDiscipleImageInfo(b.unitId)
sortNumB=data.color
elseif b.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(b.unitId))
sortNumB=(fightPreSelectModel.getNPCConfig(unitId).color or 1)+1000000000
end
end

if a.blood<=0 then
sortNumA=sortNumA-100000000
end
if b.blood<=0 then
sortNumB=sortNumB-100000000
end
return sortNumA>sortNumB
end)

self.disciplesList=list
end

function UIMysteryChangeTeamWin:exchangeRoleItem(index,targetindex)
if selectList[index]then
local temp=selectList[index]
selectList[index]=selectList[targetindex]
selectList[targetindex]=temp

self:doRefreshActiveCellViews()
end
end

function UIMysteryChangeTeamWin:exchangeRoleItemWithEntity(index,targetindex)
if selectList[index]then
self:exchangeRoleItem(index,targetindex)
self.selectStage:exchangeEntityIndex(index,targetindex)
end
end


function UIMysteryChangeTeamWin:setFight()
local fight=0
for k,v in pairs(selectList)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
fight=fight+UIDiscipleModel:getDiscipleFightValue(v.unitId)
elseif v.unitType==fightPreSelectModel.teamEntityType.npc then
local unitId=tonumber(tostring(v.unitId))
fight=fight+fightPreSelectModel.getNPCFightValue(unitId)
end
end
return fight
end


function UIMysteryChangeTeamWin:getDiziList()
local guidList={}
for k,v in pairs(selectList)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
guidList[k]=v.unitId
end
end
return guidList
end

function UIMysteryChangeTeamWin:getSendList()
local guidList={}
local zeroNum=0
for i=1,maxPos do
if selectList[i]then
table.insert(guidList,i,{selectList[i].unitType,selectList[i].unitId,selectList[i].blood,selectList[i].guid})
else
table.insert(guidList,i,{0,int64.zero,0,int64.zero})
zeroNum=zeroNum+1
end
end
if zeroNum==maxPos then
return{}
end
return guidList
end

function UIMysteryChangeTeamWin:addEntity(posIndex,uType,guid,behaviour,tips)
if uType==fightPreSelectModel.teamEntityType.npc then
guid=tonumber(tostring(guid))
local jobid=fightPreSelectModel.getNPCJob(guid)
local id=fightPreSelectModel.getNPCMonster(guid)
self.selectStage:addEntity(posIndex,fightEntityType.monster,id,jobid,nil,behaviour,tips)
elseif uType==fightPreSelectModel.teamEntityType.dizi then
local jobid=UIDiscipleModel:getDiscipleJob(guid)
self.selectStage:addEntity(posIndex,fightEntityType.diZi,guid,jobid,nil,behaviour,tips)
end
end

function UIMysteryChangeTeamWin:getEntity(posIndex)
return self.selectStage:getEntity(posIndex)
end


function UIMysteryChangeTeamWin:selectDisciple(listIndex,posIndex,withoutEnt)
self.enhancedscrollscript:onItemClick(nil,nil,listIndex-1,nil,posIndex,withoutEnt)
end

function UIMysteryChangeTeamWin:onSelectUp(dataIndex,posIndex)
local unitData=self.disciplesList[dataIndex]
local index=self:isSelected(unitData.unitType,unitData.unitId)
if index then
self:exchangeRoleItemWithEntity(index,posIndex)
else
if selectList[posIndex]then
selectList[posIndex]=unitData
self.selectStage:removeEntity(posIndex)
self:addEntity(posIndex,unitData.unitType,unitData.unitId)
self:doRefreshActiveCellViews()
else

selectList[posIndex]=unitData
local cell=self.enhancedscrollscript:GetCell(dataIndex-1)
if cell then
cell:SetChildActive(4,true)
end
self:setFight()

self:addEntity(posIndex,unitData.unitType,unitData.unitId)


end
end



AudioManager.playAudio(454)
self:showAutoSelectButton()
end

function UIMysteryChangeTeamWin:onSelectDown(posIndex)
if selectList[posIndex]then
selectList[posIndex]=nil
self.selectStage:removeEntity(posIndex)

self:doRefreshActiveCellViews()
self:setFight()
self:showAutoSelectButton()
end
end


function UIMysteryChangeTeamWin:registerEasyTouch(register)
self.selectStage:registerEasyTouch(register)
end

function UIMysteryChangeTeamWin:printSelectList()

end

function UIMysteryChangeTeamWin:getJobPosPriorty(jobId)
local posIndex
local pospriorty=UIDiscipleModel.getJobPosPriorty(jobId)
if pospriorty then
for i,listPos in ipairs(pospriorty)do
if not selectList[listPos]then
return listPos
end
end
else
posIndex=self.getEmpty()
end
end

function UIMysteryChangeTeamWin.getEmpty()
for i=1,maxPos do
if not selectList[i]then
return i
end
end
end

function UIMysteryChangeTeamWin:isSelected(uType,guid)
for i,v in pairs(selectList)do
if uType==v.unitType and tostring(guid)==tostring(v.guid)then
return i
end
end
end

function UIMysteryChangeTeamWin:checkNPC(data)
if data.unitType==eTeamEntityType.npc then
local id=tonumber(tostring(data.unitId))
local config=fightPreSelectModel.getNPCConfig(id)
local discipleid=config.discipleid
if discipleid then
for i,v in pairs(selectList)do
if v.unitType==eTeamEntityType.dizi then
local otherid=UIDiscipleModel:getDiscipleID(v.unitId)
if otherid==discipleid then
return true
end
elseif v.unitType==eTeamEntityType.npc then
local otherid=tonumber(tostring(v.unitId))
local config=fightPreSelectModel.getNPCConfig(otherid)
local otherdiscipleid=config.discipleid
if otherdiscipleid==discipleid then
return true
end
end
end
end
end
end



function UIMysteryChangeTeamWin:setZhenFa(zfId)
selectZF=zfId
if selectZF then
local zfCfg=cfgHelper.get1(cfg_zhenfaconfig_get,selectZF)
self.zfIcon:setIcon(zfCfg.icon,false)
self.zfName:setText(zfCfg.name)
else
self.zfIcon:setIcon("",false)
self.zfName:setText("")
end
end


function UIMysteryChangeTeamWin:doRefreshActiveCellViews()
self.enhancedscrollscript:doRefreshActiveCellViews()
end



function UIMysteryChangeTeamWin:onDragUpdate()

end


function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local item=cell

local unitData=self.window.disciplesList[dataIndex]
local unitId=unitData.unitId
local guid=unitData.guid
local modelId
if self.window.useAllDisciple then
local selectIdx=self.window:isSelected(unitData.unitType,guid)
item:SetChildActive(4,selectIdx~=nil)
else
item:SetChildActive(4,false)
end

item:SetChildActive(15,self.window.useAllDisciple==true)
item:SetChildActive(17,false)
item:SetChildActive(18,false)

item:SetChildGray(14,unitData.blood<=0)

if unitData.unitType==fightPreSelectModel.teamEntityType.dizi then

local netdata=UIDiscipleModel:getDiscipleData(guid)
modelId=netdata.discipleimage

item:SetChildText(roleItemIndex.name,UIDiscipleModel:getDiscipleName(guid))

if m_sorttypeindex==eDiscipleSortType.eJingJieSort then
local jjlv=netdata.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}阶',n,p)
else
jj_str=n
end
item:SetChildText(roleItemIndex.fight,jj_str)
elseif m_sorttypeindex==eDiscipleSortType.eLianTiSort then
local ltlv=netdata.liantilv
local n1,p1=UIDiscipleModel:getLTNameX(ltlv)
local lt_str=''
if p1~=nil then
lt_str=FMT.fmt('{0}{1}层',n1,p1)
else
lt_str=n1
end
item:SetChildText(roleItemIndex.fight,lt_str)
else
item:SetChildText(roleItemIndex.fight,FMT.fmt('{0} {1}',FMT.cfmt(FONT_COLOR.eOrangeColor,'战'),UIDiscipleModel:getDiscipleFightValue(guid)))
end

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHalf)

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(roleItemIndex.color,diziabname,ColorToFrame[color])

local jobIcon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(roleItemIndex.job,globalab,jobIcon)
local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(roleItemIndex.spDzFlag,isSpDz)
if not self.window.useAllDisciple then
local jj=UIDiscipleModel:getDiscipleJJLevel(guid)
item:SetChildText(16,jj)
end
item:SetChildActive(12,false)
elseif unitData.unitType==fightPreSelectModel.teamEntityType.npc then
unitId=tonumber(tostring(unitId))
modelId=fightPreSelectModel.getNPCOutSideModel(unitId)

local npcConfig=fightPreSelectModel.getNPCConfig(unitId)
local imageInfo=fightPreSelectModel.getNPCInSideModel(unitId)
if imageInfo then
item:SetChildModelCaptureImage(3,imageInfo.body,imageInfo.componets,1,0,0,0,Vector2(0,15),1,false)
end
item:SetChildText(roleItemIndex.name,npcConfig.name)
local color=fightPreSelectModel.getNPCColor(unitId)
item:SetChildCSImageSprite(roleItemIndex.color,diziabname,ColorToFrame[color])

if m_sorttypeindex==eDiscipleSortType.eJingJieSort then
local n,p,pN=UIDiscipleModel:getJJNameX(npcConfig.jingjie or 1)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}阶',n,p)
else
jj_str=n
end
item:SetChildText(roleItemIndex.fight,jj_str)
elseif m_sorttypeindex==eDiscipleSortType.eLianTiSort then
local n1,p1=UIDiscipleModel:getLTNameX(npcConfig.lianti or 1)
local lt_str=''
if p1~=nil then
lt_str=FMT.fmt('{0}{1}层',n1,p1)
else
lt_str=n1
end
item:SetChildText(roleItemIndex.fight,lt_str)
else
item:SetChildText(roleItemIndex.fight,FMT.fmt('{0} {1}',FMT.cfmt(FONT_COLOR.eOrangeColor,'战'),fightPreSelectModel.getNPCFightValue(unitId)))
end

local jobIcon=fightPreSelectModel:getJobIconNameX(unitId)
item:SetChildCSImageSprite(roleItemIndex.job,globalab,jobIcon)
item:SetChildActive(roleItemIndex.spDzFlag,false)

if not self.window.useAllDisciple then
local monsterId=fightPreSelectModel.getNPCMonster(unitId)
local level=cfgHelper.get(cfg_monsterconfig_get,monsterId,"level")
item:SetChildText(16,level)
end


item:SetChildActive(12,true)
end
end

function UIPrepareEnScroller:onItemClick(data,cellIndex,dataIndex,cell,exchangeIndex,withoutEnt)
if not self.window.useAllDisciple then
return
end

dataIndex=dataIndex+1

local unitData=self.window.disciplesList[dataIndex]
local unitId=unitData.unitId
local guid=unitData.guid
local jobId
if unitData.unitType==fightPreSelectModel.teamEntityType.dizi then
jobId=UIDiscipleModel:getDiscipleJob(guid)
elseif unitData.unitType==fightPreSelectModel.teamEntityType.npc then
jobId=fightPreSelectModel.getNPCJob(unitId)
end
local selectIdx=self.window:isSelected(unitData.unitType,guid)

if selectIdx then
selectList[selectIdx]=nil
if cell then
cell:SetChildActive(4,false)
else
cell=self:GetCell(dataIndex-1)
if cell then
cell:SetChildActive(4,false)
end
end
if not withoutEnt then
self.window.selectStage:removeEntity(selectIdx)
end
self.window:setFight()

self.window:showAutoSelectButton()
else

if unitData.blood<=0 then
UIManager.error("阵亡的弟子无法使用")
return
end

if self.window:checkNPC(unitData)then
UIManager.error("相同弟子无法同时上阵")
return
end


local emptyIndex=exchangeIndex or self.window:getJobPosPriorty(jobId)
if emptyIndex then
if cell then
cell:SetChildActive(4,true)
else
cell=self:GetCell(dataIndex-1)
if cell then
cell:SetChildActive(4,true)
end
end
selectList[emptyIndex]=unitData
if cell then
cell:SetChildActive(4,true)
else
cell=self:GetCell(dataIndex-1)
if cell then
cell:SetChildActive(4,true)
end
end
if not withoutEnt then
self.window:addEntity(emptyIndex,unitData.unitType,unitData.unitId)
end
self.window:setFight()


AudioManager.playAudio(454)

self.window:showAutoSelectButton()
end
end

end

function UIPrepareEnScroller:onItemBeginDrag(dataIndex,screenPos,cell)
dataIndex=dataIndex+1

local unitData=_this.disciplesList[dataIndex]
local modelId,jobid
local guid=unitData.unitId

if unitData.blood<=0 then
UIManager.error("阵亡的弟子无法使用")
return
end
if self.window:checkNPC(unitData)then
UIManager.error("相同弟子无法同时上阵")
return
end
local posIndex=nil
for i,v in pairs(selectList)do
if tostring(v.guid)==tostring(guid)then
posIndex=i
end
end
if self.window.useAllDisciple then
dragBeginData={posIndex or-1,unitData,dataIndex}
else
if posIndex then
dragBeginData={posIndex,unitData}
end
end


_this:addEntity(-1,unitData.unitType,guid)

end

function UIPrepareEnScroller:onItemDrag(dataIndex,screenPos)
end

function UIPrepareEnScroller:onItemEndDrag(dataIndex,screenPos,cell)
dragEndData={dataIndex,screenPos,cell}
end


function UIMysteryChangeTeamWin:onHide()

end

function UIMysteryChangeTeamWin:clearSelect()
self.selectStage:clearEntity(true)
selectLookUp={}
selectList={}
selectNum=0

self:doRefreshActiveCellViews()

self:showAutoSelectButton()
end

function UIMysteryChangeTeamWin:showAutoSelectButton()
local empty=self.getEmpty()
self.autoSelectButton:setActive(empty~=nil)
self.clearButton:setActive(empty==nil)
end





function UIMysteryChangeTeamWin:onCancelButton()
self.FullMask:setActive(true)
UIFullMysteryMainControl:closeActiveUI()
end



function UIMysteryChangeTeamWin:onDiziButton()
local teamList=MysteryModel:get_fb_probeTeam()
local roleData=teamList[1]
local discipleList={}

if roleData then
for i,v in ipairs(teamList)do
if v.unitType==eTeamEntityType.dizi then
table.insert(discipleList,UIDiscipleModel:getDiscipleDataX(v.unitId))
end
end

if roleData.unitType==eTeamEntityType.dizi then
UIFullDiscipleMainControl:showWindowInfo({dis_guid=roleData.unitId,disciplelist=discipleList})
else
UIManager.error("不是门中弟子，无法查看信息")
end
end
end



function UIMysteryChangeTeamWin:onSelectButton()
local sendList=self:getSendList()
if#sendList==0 then
UIManager.error("至少上阵一名弟子")
return
end
MysteryController.send_4_59(self.fbId,sendList,selectZF or 0)
self.FullMask:setActive(true)
UIFullMysteryMainControl:closeActiveUI()
end



function UIMysteryChangeTeamWin:onZfBtn()
if self.lockZhenFa then return end

local extraParams={

init=selectZF,
team=self:getDiziList(),
callback=function(zfId)
self:setZhenFa(zfId)
end
}
UIManager:showWindow('UIZhenFaChooseWin',extraParams)
end

function UIMysteryChangeTeamWin:onHelpButton()
UIManager:showWindow("UIFightPrepareTipsWin")
end

function UIMysteryChangeTeamWin:onAutoSelectButton()
for i,v in ipairs(self.disciplesList)do
local empty=self.getEmpty()
if empty then
if not self:isSelected(v.unitType,v.unitId)then
self:selectDisciple(i)
end
else
break
end
end
self:showAutoSelectButton()
end

function UIMysteryChangeTeamWin:onClearButton()
self:clearSelect()
self:showAutoSelectButton()
end
