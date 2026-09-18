







def_class("UIFightAdverseSquadWin",UIWindowBase)









function UIFightAdverseSquadWin:bindComponents()

self.singleFight=UIObject.get(self,0)
self.cancelButton=UIButton.get(self,1)
self.fightText=UIText.get(self,2)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,3)
self.rightTeam=UIObject.get(self,4)
self.rRole1=UIImage.get(self,5)
self.rRole2=UIImage.get(self,6)
self.rRole3=UIImage.get(self,7)
self.rRole4=UIImage.get(self,8)
self.rRole5=UIImage.get(self,9)
self.selectText=UIText.get(self,10)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)



end


function UIFightAdverseSquadWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.singleFight);self.singleFight=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.rightTeam);self.rightTeam=nil;
_UIObject_release(self.rRole1);self.rRole1=nil;
_UIObject_release(self.rRole2);self.rRole2=nil;
_UIObject_release(self.rRole3);self.rRole3=nil;
_UIObject_release(self.rRole4);self.rRole4=nil;
_UIObject_release(self.rRole5);self.rRole5=nil;
_UIObject_release(self.selectText);self.selectText=nil;
end

















local UIAdverseEnScroller=simple_class(UIEnhancedScroller)

local _this
local imageabname='ui/windows/fight/sharedtextures/fight_prepare.ab'
local ColorToFrame={
[eQualityColor.eGreen]='frame_dzkplvse_2',
[eQualityColor.eBlue]='frame_dzkplanse_2',
[eQualityColor.ePurple]='frame_dzkpzise_2',
[eQualityColor.eOrange]='frame_dzkpchengse_2',
[eQualityColor.eRed]='frame_dzkphongse_2',
}
local roleItemIndex=
{
name=0,
fight=1,
color=5,
job=8,
state=11,
npc=12,
selectbg=15,
level=16,
spDzFlag=38,
}


function UIFightAdverseSquadWin:onLoaded(...)
self:bindComponents()
_this=self
self.enhancedscrollscript=UIAdverseEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self
end


function UIFightAdverseSquadWin:__delete()
fightController:closeSelectStage()
self:unbindComponents()
_this=nil

viewModeControl:exitMode()
end




function UIFightAdverseSquadWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end

local enterTxt=argtable.enterTxt
self.isFullOpen=argtable.isFullOpen
self.disciplesList=argtable.disciplesList
self.cancelCallBack=argtable.cancelCallBack
self.monstersList=argtable.monstersList
self.npcList=argtable.npcList
self.averageLevel=argtable.averageLevel

self.selectStage=argtable.selectStage
self.selectStage.onEventChange=self.onEventChange

if self.isFullOpen then
baseFullScreenUI:openMain(false)
end

if enterTxt then
self.selectText:setText(enterTxt)
else
self.cancelButton:setActive(false)
end

self:initDisciplesList()
self:setFight()
self:initRoleListPanel()
self:initEnemyList()
end


function UIFightAdverseSquadWin:onHide()

end

function UIFightAdverseSquadWin.onEventChange(evtType,entityId,posIndex)

if evtType==1 then
UIAdverseEnScroller:onItemClick(nil,nil,posIndex-6,nil,nil)
end
end

function UIFightAdverseSquadWin:initDisciplesList()
if self.disciplesList then
local list={}
for k,v in pairs(self.disciplesList)do
if tostring(v.guid)~='0'then
table.insert(list,v)
end
end
self.disciplesList=list
end
end

function UIFightAdverseSquadWin:setFight()
local fight=0
if self.disciplesList then
for i,v in ipairs(self.disciplesList)do
fight=fight+UIDiscipleModel:getDiscipleFightValue(v.guid)
end
elseif self.npcList then
for i,v in ipairs(self.npcList)do
fight=fight+fightPreSelectModel.getNPCFightValue(v)
end
end
self.fightText:setText(fight)
end

function UIFightAdverseSquadWin:initEnemyList()
if self.disciplesList then
for i,v in ipairs(self.disciplesList)do
self.selectStage:addEntity(5+i,fightEntityType.diZi,v.guid)
end
elseif self.monstersList then
for i,v in ipairs(self.monstersList)do
self.selectStage:addEntity(5+i,fightEntityType.monster,v)
end
end
end

function UIFightAdverseSquadWin:initRoleListPanel()
if self.disciplesList then
self.enhancedscrollscript:initData(self.disciplesList,147,#self.disciplesList)
elseif self.npcList then
self.enhancedscrollscript:initData(self.npcList,147,#self.npcList)
end
end


function UIAdverseEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIAdverseEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIAdverseEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local item=cell
if _this.disciplesList then
local disciplesInfo=_this.disciplesList[dataIndex]
local modelId
local guid=disciplesInfo.guid
item:SetChildText(roleItemIndex.name,UIDiscipleModel:getDiscipleName(guid))
item:SetChildText(roleItemIndex.fight,FMT.fmt('{0} {1}',FMT.cfmt(FONT_COLOR.eOrangeColor,'战'),UIDiscipleModel:getDiscipleFightValue(guid)))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead)

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(roleItemIndex.color,imageabname,ColorToFrame[color])

local jobIcon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(roleItemIndex.job,globalABLookup.global,jobIcon)
local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(roleItemIndex.spDzFlag,isSpDz)
local jjLevel=UIDiscipleModel:getDiscipleJJLevel(guid)
item:SetChildText(roleItemIndex.level,jjLevel)
elseif _this.npcList then
local npcId=_this.npcList[dataIndex]
local npcConfig=fightPreSelectModel.getNPCConfig(npcId)
local imageInfo=fightPreSelectModel.getNPCInSideModel(npcId)
if imageInfo then
comHelper.setChildModelRawImageEx(3,item,imageInfo,0,eHeadCenterType.eHead)
end
item:SetChildText(roleItemIndex.name,npcConfig.name)
local fight=fightPreSelectModel.getNPCFightValue(npcId)
item:SetChildText(roleItemIndex.fight,FMT.fmt('{0} {1}',FMT.cfmt(FONT_COLOR.eOrangeColor,'战'),fight))
local color=fightPreSelectModel.getNPCColor(npcId)
item:SetChildCSImageSprite(roleItemIndex.color,imageabname,ColorToFrame[color])
local jobIcon=fightPreSelectModel:getJobIconNameX(npcId)
item:SetChildCSImageSprite(roleItemIndex.job,globalABLookup.global,jobIcon)
item:SetChildActive(roleItemIndex.spDzFlag,false)
local averageLevel=_this.averageLevel or 0
item:SetChildText(roleItemIndex.level,averageLevel)
end
item:SetChildActive(roleItemIndex.selectbg,false)
end

function UIAdverseEnScroller:onItemClick(data,cellIndex,dataIndex,cell,exchangeIndex)
if _this.disciplesList then
local disciplesInfo=_this.disciplesList[dataIndex+1]
local list={}
for k,v in pairs(_this.disciplesList)do
local dzData=UIDiscipleModel:getDiscipleDataX(v.guid)
table.insert(list,dzData)
end
UIFullDiscipleMainControl:showWindowInfo({dis_guid=disciplesInfo.guid,disciplelist=list})
else
UIManager.info('对手过于神秘，无法查看信息')
end
end

function UIAdverseEnScroller:onItemBeginDrag(dataIndex,screenPos,cell)
end

function UIAdverseEnScroller:onItemDrag(dataIndex,screenPos)
end

function UIAdverseEnScroller:onItemEndDrag(dataIndex,screenPos,cell)
end



function UIFightAdverseSquadWin:onCancelButton()
local isFullOpen_=self.isFullOpen
local cb=self.cancelCallBack
if isFullOpen_ then
UIFullFightPrepareControl:closeActiveUI()
else
UIManager:closeWindow('UIFightAdverseSquadWin')
end
if cb then
cb()
end
end
