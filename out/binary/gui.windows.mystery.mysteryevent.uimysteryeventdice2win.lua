







def_class("UIMysteryEventDice2Win",UIWindowBase)









function UIMysteryEventDice2Win:bindComponents()

self.diceRoot=UIObject.get(self,0)
self.listButton2=UIButton.get(self,1)
self.resultText=UIText.get(self,2)
self.diceNum=UIText.get(self,3)
self.listButton1=UIButton.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.hideEvent2=UIObject.get(self,6)
self.hideEvent=UIObject.get(self,7)
self.dicepanel=UIObject.get(self,8)
self.comfirmButton=UIButton.get(self,9)
self.restartDiceButton=UIButton.get(self,10)
self.startDiceButton=UIButton.get(self,11)
self.diceCount=UIText.get(self,12)
self.touzi1=UIObject.get(self,13)
self.touzi2=UIObject.get(self,14)
self.touzi3=UIObject.get(self,15)
self.lastTipsList=UIObject.get(self,16)
self.lastTips=UIObject.get(self,17)

self.listButton2:setButtonClick(function()self:onListButton2()end)

self.listButton1:setButtonClick(function()self:onListButton1()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.comfirmButton:setButtonClick(function()self:onComfirmButton()end)

self.restartDiceButton:setButtonClick(function()self:onRestartDiceButton()end)

self.startDiceButton:setButtonClick(function()self:onStartDiceButton()end)



end


function UIMysteryEventDice2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.diceRoot);self.diceRoot=nil;
_UIObject_release(self.listButton2);self.listButton2=nil;
_UIObject_release(self.resultText);self.resultText=nil;
_UIObject_release(self.diceNum);self.diceNum=nil;
_UIObject_release(self.listButton1);self.listButton1=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.hideEvent2);self.hideEvent2=nil;
_UIObject_release(self.hideEvent);self.hideEvent=nil;
_UIObject_release(self.dicepanel);self.dicepanel=nil;
_UIObject_release(self.comfirmButton);self.comfirmButton=nil;
_UIObject_release(self.restartDiceButton);self.restartDiceButton=nil;
_UIObject_release(self.startDiceButton);self.startDiceButton=nil;
_UIObject_release(self.diceCount);self.diceCount=nil;
_UIObject_release(self.touzi1);self.touzi1=nil;
_UIObject_release(self.touzi2);self.touzi2=nil;
_UIObject_release(self.touzi3);self.touzi3=nil;
_UIObject_release(self.lastTipsList);self.lastTipsList=nil;
_UIObject_release(self.lastTips);self.lastTips=nil;
end



















function UIMysteryEventDice2Win:onLoaded(...)
self:bindComponents()
end


function UIMysteryEventDice2Win:__delete()
self:unbindComponents()
end




function UIMysteryEventDice2Win:onShow(argtable,afterOnloaded)
if argtable then
self.optionCfg=MysteryEventModel.get_option_cfg(argtable.groupId,argtable.optionId)
self.guid=argtable.guid
self.resultIndex=argtable.resultIndex
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

self.diceCount:setText("")

self:initExplainList()

if self.resultIndex then
self:hideStartButton()
self:refreshDiceCount()
local tempArgs=MysteryEventModel:get_result_temp()
if tempArgs then

local qiyuItem=tempArgs[1]
local sysId=tempArgs[2]
local after=function()
MysteryEventSystem:event_result(qiyuItem.guid,sysId,qiyuItem.eventGroupId,qiyuItem.choiceId,qiyuItem.resultConf,nil)
end
self:refreshDice(tempArgs[4],after)

end
end
end

function UIMysteryEventDice2Win:initExplainList()
local optionCfg=self.optionCfg
local diceCfg={}
local hideDiceCfg={}

local diceConfig=optionCfg.dice

if diceConfig then
for i,v in ipairs(diceConfig)do
if v[1]==1 then
local diceNum1=v[2]
local diceNum2=v[3]
local resultIndex=v[4]
local explain=optionCfg[MysteryEventSystem.diceCfg.getExplain(resultIndex)]
local resultStr=optionCfg[MysteryEventSystem.diceCfg.getResultTxt(resultIndex)]
table.insert(diceCfg,{diceNum1,diceNum2,resultIndex,explain,resultStr})
elseif v[1]==2 then
local diceNum=v[2]
local resultIndex=v[3]
local explain=optionCfg[MysteryEventSystem.diceCfg.getExplain(resultIndex)]
local resultStr=optionCfg[MysteryEventSystem.diceCfg.getResultTxt(resultIndex)]
table.insert(hideDiceCfg,{diceNum,resultIndex,explain,resultStr})
end
end
end

self.diceCfg=diceCfg
self.hideDiceCfg=hideDiceCfg

self.lastTipsList:setChildLayoutGroupCreateItems(#diceCfg)
local grids=self.lastTipsList:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local dice=diceCfg[i]

item:SetChildText(0,FMT.fmt("<color=#7d3b17>点数[{0}-{1}]</color>{2}",dice[1],dice[2],dice[4][1]))
end

local widget=self.lastTips:getWidgetBase()
if widget then
local dice=diceCfg[#diceCfg]
widget:SetChildText(0,FMT.fmt("<color=#7d3b17>点数[{0}-{1}]</color>{2}",dice[1],dice[2],dice[4][1]))
end

self.lastTips:setActive(true)
self.lastTipsList:setActive(false)
end

function UIMysteryEventDice2Win:refreshDiceCount()
self.diceCount:setText(FMT.fmt("次数：{0}",MysteryEventModel:get_dice_count()))
end

function UIMysteryEventDice2Win:refreshDice(diceList,afterAction)

local dice=0
local dice1=diceList[1]

local diceCount=#diceList
local isDiceIdentical=diceCount>1
for i,v in ipairs(diceList)do
dice=dice+v
if dice1~=v then
isDiceIdentical=false
end
end

self.diceNum:setText(dice)

self.touzi1:setActive(diceCount>=1)
self.touzi2:setActive(diceCount>=2)
self.touzi3:setActive(diceCount>=3)

if isDiceIdentical then
self.identicaldice=dice1
else
self.identicaldice=nil
end


local animid=MysteryEventModel:get_dice_anim(diceCount,diceList)
self.diceRoot:setAnimatorInteger('nState',animid,true)
if afterAction then
self:delayDo(2,afterAction)
end
end

function UIMysteryEventDice2Win:refreshResult(args)
local mainArgs=args.mainArgs

local resultIndex=mainArgs.resultIndex
local resultStr
if self.identicaldice then
for i,v in ipairs(self.hideDiceCfg)do
if resultIndex==v[2]then
resultStr=v[4]
break
end
end
else
for i,v in ipairs(self.diceCfg)do
if resultIndex==v[3]then
resultStr=v[5]
break
end
end
end
if resultStr then
self.resultText:setText(self.identicaldice and FMT.fmt("触发额外事件：{0}",resultStr)or FMT.fmt("触发事件：{0}",resultStr))
end
MysteryEventModel:set_result_temp()

self.confirmCallBack=mainArgs.confirmCallBack

if self.identicaldice then
self.hideEvent:setChildCanvasGroupAlpha(0)
self.hideEvent:setChildCanvasGroupDOFade(1,0.5,nil)
local tweener=self.hideEvent:setChildCanvasGroupDOFade(0,0.5,nil)
tweener:SetDelay(1)





self:delayDo(1,function()
self.hideEvent2:setChildShowEffect(10248,true)
end)


self:delayDo(2,function()
self.dicepanel:setChildCanvasGroupAlpha(1)
end)
else
self.dicepanel:setChildCanvasGroupAlpha(1)
end

self.inDice=false
end


function UIMysteryEventDice2Win:onHide()

end

function UIMysteryEventDice2Win:hideStartButton()
self.startDiceButton:setActive(false)
self.restartDiceButton:setActive(true)
self.comfirmButton:setActive(true)
end





function UIMysteryEventDice2Win:onDice()
local diceTimes=MysteryEventModel:get_dice_count()
if diceTimes<=0 then
return
end
self.dicepanel:setChildCanvasGroupAlpha(0)
if self.optionCfg then
local guidList={}
local team=MysteryEventModel:get_team_data()
for i,v in ipairs(team)do
if v.unitType~=0 then
table.insert(guidList,type(v.unitId)=="number"and int64.new(v.unitId)or v.unitId)
end
end
MysteryEventSystem.send_18_7(self.evtGuid,self.optionCfg.choiceid,guidList,self.sysId)

self.inDice=true
end
end



function UIMysteryEventDice2Win:onStartDiceButton()
self:hideStartButton()
self:onDice()
end



function UIMysteryEventDice2Win:onRestartDiceButton()
if self.inDice then
return
end
self:onDice()
end



function UIMysteryEventDice2Win:onComfirmButton()
if self.inDice then
return
end
if self.confirmCallBack then
self.confirmCallBack()
end

MysteryEventModel:set_select_disciple(nil)
MysteryEventModel:clear_event_str_list()
MysteryEventModel:clear_event_dice_str_list()

if not MysteryEventModel:have_event_flag()then
if MysteryModel:is_enter_Mystery()then

mysteryAIManager:update_queue()
end
end

UIFullMysteryEventControl:closeUI(true,true)
end



function UIMysteryEventDice2Win:onListButton1()
self.lastTipsList:setActive(true)
self.lastTips:setActive(false)
end



function UIMysteryEventDice2Win:onListButton2()
self.lastTipsList:setActive(false)
self.lastTips:setActive(true)
end

function UIMysteryEventDice2Win:onCloseBtn()
notifySystem:postNotify(notifyConfig.on_mystery_event_break,self.sysId,self.groupId,self.evtGuid)
MysteryEventModel:set_event_flag(nil)
UIFullMysteryEventControl:closeUI(true,true)
end