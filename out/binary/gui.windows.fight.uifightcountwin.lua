







def_class("UIFightCountWin",UIWindowBase)









function UIFightCountWin:bindComponents()

self.allmsgBtn=UIButton.get(self,0)
self.desccreater=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.roundTxt=UIText.get(self,3)
self.teamGrid=UIObject.get(self,4)
self.titleTxt=UIText.get(self,5)

self.allmsgBtn:setButtonClick(function()self:onAllmsgBtn()end)



end


function UIFightCountWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.allmsgBtn);self.allmsgBtn=nil;
_UIObject_release(self.desccreater);self.desccreater=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roundTxt);self.roundTxt=nil;
_UIObject_release(self.teamGrid);self.teamGrid=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end



















local _this


function UIFightCountWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIFightCountWin:__delete()
self:unbindComponents()
UIManager:invokeUIMethod("UICommonVictoryWin","reStartContinue")
_this=nil
end


function UIFightCountWin:onHide()

end




function UIFightCountWin:onShow(argtable,afterOnloaded)
self.fightDataList=argtable.fightData
self.fightData=self.fightDataList[1]



self.battleId=argtable.battleId
self.battleType=argtable.battleType
self.isShareFight=argtable.isShareFight
local title_str=argtable.title or'战斗统计'
self.titleTxt:setText(title_str)

self.teamIndex=1
self:setTeamList()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.3,nil)
self:updateView()
end
self:delayDo(0.2,func)
else
self:updateView()
end
end

function UIFightCountWin:setTeamList()
local count=#self.fightDataList
if count>1 then
self.teamGrid:setChildLayoutGroupCreateItems(count,function(idx)
local item=self.teamGrid:getChildLayoutGroupGridItem(idx-1)
item:SetChildText(1,FMT.fmt("第{0}场",idx))
item:SetChildButtonClick(0,function()
self.fightData=self.fightDataList[idx]
self:updateView()
local old=self.teamIndex
if old then
local oitem=self.teamGrid:getChildLayoutGroupGridItem(old-1)
oitem:SetChildActive(2,false)
end
self.teamIndex=idx
item:SetChildActive(2,true)
end)

item:SetChildActive(2,self.teamIndex==idx)

end)
end
end

function UIFightCountWin:initDesc()
self.descList={}
local leftId=self.fightData.leftId
local rightId=self.fightData.rightId
local actorId=playerModel:getActorID()
local isLeftSelf=leftId~=nil and mathHelper.int64_to_number(leftId)==mathHelper.int64_to_number(actorId)
local isRightSelf=rightId~=nil and mathHelper.int64_to_number(rightId)==mathHelper.int64_to_number(actorId)

local data1=
{
name=isLeftSelf and'image_zhandoutongji_2'or'image_zhandoutongji_3',
childlist=table.weakCopy(self.fightData.left),
}
data1.totalAttack_max=self.getMaxValue(data1.childlist,'totalAttack')
data1.totalDefend_max=self.getMaxValue(data1.childlist,'totalDefend')
data1.totalCue_max=self.getMaxValue(data1.childlist,'totalCue')
table.sort(data1.childlist,function(a,b)
return a.totalAttack>b.totalAttack
end)
self.descList[1]=data1

local isShowEnemy=true
if self.battleType and self.battleType==eBattleType.tianyuanshouchao then

isShowEnemy=false
end
if isShowEnemy then

local data2=
{
name=isRightSelf and'image_zhandoutongji_2'or'image_zhandoutongji_3',
childlist=table.weakCopy(self.fightData.right),
}
data2.totalAttack_max=self.getMaxValue(data2.childlist,'totalAttack')
data2.totalDefend_max=self.getMaxValue(data2.childlist,'totalDefend')
data2.totalCue_max=self.getMaxValue(data2.childlist,'totalCue')
table.sort(data2.childlist,function(a,b)
return a.totalAttack>b.totalAttack
end)
self.descList[2]=data2

self.totalAttack_max=math.max(data1.totalAttack_max,data2.totalAttack_max)
self.totalDefend_max=math.max(data1.totalDefend_max,data2.totalDefend_max)
self.totalCue_max=math.max(data1.totalCue_max,data2.totalCue_max)
else
self.totalAttack_max=data1.totalAttack_max
self.totalDefend_max=data1.totalDefend_max
self.totalCue_max=data1.totalCue_max
end

end

function UIFightCountWin.getMaxValue(res,key)
local max=0
for i,v in ipairs(res)do
if v[key]>max then
max=v[key]
end
end
return max
end

function UIFightCountWin:updateView()
self:initDesc()
self.roundTxt:setText(FMT.fmt('战斗回合数：{0}',self.fightData.round))
local descnum=#self.descList
self.desccreater:setChildLayoutGroupCreateItems(descnum)
local grids=self.desccreater:getChildLayoutGroupGridList()
for i=1,descnum do
local item=grids[i-1]
self:refreshDescItem(item,i)
end
end

function UIFightCountWin:refreshDescItem(item,descidx)
local descData=self.descList[descidx]
item:SetChildCSImageSprite(0,globalABLookup.fight_lost,descData.name)

local childnum=#descData.childlist
item:SetChildLayoutGroupCreateItems(1,childnum)
local childGrids=item:GetChildLayoutGroupGridList(1)
for i=1,childnum do
local childItem=childGrids[i-1]
local childData=descData.childlist[i]
local enityType=childData.enityType
if enityType==fightEntityType.diZi then
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(childData.image)
comHelper.setChildModelRawImageEx(0,childItem,modelParams,eHeadCenterType.eHead)
else
comHelper.setChildModelRawImage_monster(childItem,childData.monsterID,0,0,eHeadCenterType.eHead)
end


childItem:SetChildProgressValue(1,0,100)
self:setProgressView(childItem,1,childData.totalAttack,self.totalAttack_max)

childItem:SetChildProgressValue(2,0,100)
self:setProgressView(childItem,2,childData.totalDefend,self.totalDefend_max)

childItem:SetChildProgressValue(3,0,100)
self:setProgressView(childItem,3,childData.totalCue,self.totalCue_max)
end
end

function UIFightCountWin:setProgressView(childItem,idx,cur,max)
local cur_=cur
local max_=max
if max==0 then
cur_=0
max_=1
elseif cur_>max then
cur_=max
end
childItem:SetChildProgress(idx,cur_/max_*100,100)
childItem:SetChildProgressText(idx,mathHelper.formatNumber7(cur,1,2))
end


function UIFightCountWin:onAllmsgBtn()
local arg={fightData=self.fightDataList,battleId=self.battleId,battleType=self.battleType,teamIndex=self.teamIndex,isShareFight=self.isShareFight}
UIManager:showWindow("UIFightAllMsgWin",arg)
end