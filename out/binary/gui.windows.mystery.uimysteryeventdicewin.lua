







def_class("UIMysteryEventDiceWin",UIWindowBase)









function UIMysteryEventDiceWin:bindComponents()

self.diceImage=UIObject.get(self,0)
self.dice=UIButton.get(self,1)
self.optionTextBg=UIObject.get(self,2)
self.helpPanel=UIObject.get(self,3)
self.diceTitle=UIText.get(self,4)
self.diceCount=UIText.get(self,5)
self.head=UIObject.get(self,6)

self.dice:setButtonClick(function()self:onDice()end)



end


function UIMysteryEventDiceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.diceImage);self.diceImage=nil;
_UIObject_release(self.dice);self.dice=nil;
_UIObject_release(self.optionTextBg);self.optionTextBg=nil;
_UIObject_release(self.helpPanel);self.helpPanel=nil;
_UIObject_release(self.diceTitle);self.diceTitle=nil;
_UIObject_release(self.diceCount);self.diceCount=nil;
_UIObject_release(self.head);self.head=nil;
end




















local optionCfg
local guid
local resultIndex

local diceBodyId=2012

local diceAni=
{
eAnimationID.dice1,
eAnimationID.dice2,
eAnimationID.dice3,
eAnimationID.dice4,
eAnimationID.dice5,
eAnimationID.dice6,
}


function UIMysteryEventDiceWin:onChildLoaded(child)
self.child=child
self:bindChildComponents()
end


function UIMysteryEventDiceWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryEventDiceWin:__delete()
self:unbindComponents()
self.child=nil
optionCfg=nil
guid=nil
end




function UIMysteryEventDiceWin:onShow(argtable,afterOnloaded)
if argtable then
optionCfg=MysteryEventModel.get_option_cfg(argtable.groupId,argtable.optionId)
guid=argtable.guid
resultIndex=argtable.resultIndex
self.evtGuid=argtable.evtGuid
self.sysId=argtable.sysId
self.eSendType=argtable.eSendType
self.sendParam=argtable.sendParam
self.groupId=argtable.groupId
self.optionId=argtable.optionId
else
error("error:group id is null")
return
end
local maxDice=MysteryEventModel:get_dice_max_count(self.evtGuid)

MysteryEventModel:set_dice_count(maxDice)

self:initExplainList()

if guid then
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(guid)
self.winid:SetChildUIModelShowTarget(self.head:getID(),modelParams.body,modelParams.scale*0.8,modelParams.componets,modelParams.anim,true)
self.winid:SetChildUIModelShowTargetOffset(self.head:getID(),modelParams.offset[1],modelParams.offset[2])
end
self:refreshDiceCount()

if resultIndex then
self.diceImage:setActive(false)
local after=function()
MysteryEventSystem:event_result(self.evtGuid,self.sysId,argtable.groupId,argtable.optionId,resultIndex)
self:refreshExplain(resultIndex)
end
self:refreshDice(resultIndex,after)
end
end

function UIMysteryEventDiceWin:initExplainList()
local diceCfg={}
local explain=nil
for i,v in ipairs(MysteryEventSystem.diceCfg)do
if optionCfg[v.point]then
explain=optionCfg[v.explain]~=nil and optionCfg[v.explain][1]or""
table.insert(diceCfg,{point=optionCfg[v.point],result=optionCfg[v.result],explain=optionCfg[v.explain]and optionCfg[v.explain][1]})
end
end

self.helpPanel:setChildScrollViewCreateGrids(#diceCfg,1)
local grids=self.helpPanel:getChildScrollViewItemWidgets()
local count=grids.Count
self.helpCount=count or 0
for i=1,count do
local item=grids[i-1]
local dice=diceCfg[i]
local point=dice.point
local pointstr=point[1]
if#point>0 then
pointstr=FMT.fmt("{0}-{1}",pointstr,#point+point[1]-1)
end
item:SetChildText(0,FMT.fmt("骰子：{0}",pointstr))
item:SetChildText(1,dice.explain)
end
end

function UIMysteryEventDiceWin:refreshExplain(index)
if self.helpCount>0 then
local item=self.helpPanel:getChildScrollViewItemWidget(index-1)
if item then
item:SetChildActive(2,true)
end
end
end

function UIMysteryEventDiceWin:refreshDiceCount()
self.diceCount:setText(FMT.fmt("投掷次数：{0}",MysteryEventModel:get_dice_count()))
end

function UIMysteryEventDiceWin:refreshDice(dice,afterAction)
local anim=diceAni[dice]or diceAni[1]
self.dice:setChildDragonTarget(diceBodyId,1,nil,anim,
false,0,false,function()
if afterAction then
afterAction()
end
end)
end


function UIMysteryEventDiceWin:onHide()

end

function UIMysteryEventDiceWin:onDice()
local diceTimes=MysteryEventModel:get_dice_count()
if diceTimes<=0 then
return
end
self.optionTextBg:setActive(false)

if optionCfg then
if guid then
MysteryEventSystem.send_18_7(self.evtGuid,optionCfg.choiceid,guid,self.sysId)
else
local guidList={}
local team=MysteryEventModel:get_team_data()
for i,v in ipairs(team)do
if v.unitType~=0 then
table.insert(guidList,type(v.unitId)=="number"and int64.new(v.unitId)or v.unitId)
end
end
MysteryEventSystem.send_18_7(self.evtGuid,optionCfg.choiceid,guidList,self.sysId)
end

end
self.diceImage:setActive(false)

UIManager:closeWindow("UIMysteryEventResultWin")


end

function UIMysteryEventDiceWin:onDiceClick()

end



