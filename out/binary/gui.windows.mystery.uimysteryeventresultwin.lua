







def_class("UIMysteryEventResultWin",UIWindowBase)









function UIMysteryEventResultWin:bindComponents()

self.EventGroupText=UIText.get(self,0)
self.itemPanel=UIObject.get(self,1)
self.resetText=UIText.get(self,2)
self.confirmText=UIText.get(self,3)
self.funcText=UIText.get(self,4)
self.shaneAddText=UIText.get(self,5)
self.shaneSubText=UIText.get(self,6)
self.shaneRoot=UIObject.get(self,7)
self.eventRoot=UIObject.get(self,8)
self.ItemRoot=UIObject.get(self,9)
self.resetButton=UIButton.get(self,10)
self.confirmButton=UIButton.get(self,11)
self.funcButton=UIButton.get(self,12)
self.shanepoint=UIObject.get(self,13)

self.resetButton:setButtonClick(function()self:onResetButton()end)

self.confirmButton:setButtonClick(function()self:onConfirmButton()end)

self.funcButton:setButtonClick(function()self:onFuncButton()end)



end


function UIMysteryEventResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.EventGroupText);self.EventGroupText=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.resetText);self.resetText=nil;
_UIObject_release(self.confirmText);self.confirmText=nil;
_UIObject_release(self.funcText);self.funcText=nil;
_UIObject_release(self.shaneAddText);self.shaneAddText=nil;
_UIObject_release(self.shaneSubText);self.shaneSubText=nil;
_UIObject_release(self.shaneRoot);self.shaneRoot=nil;
_UIObject_release(self.eventRoot);self.eventRoot=nil;
_UIObject_release(self.ItemRoot);self.ItemRoot=nil;
_UIObject_release(self.resetButton);self.resetButton=nil;
_UIObject_release(self.confirmButton);self.confirmButton=nil;
_UIObject_release(self.funcButton);self.funcButton=nil;
_UIObject_release(self.shanepoint);self.shanepoint=nil;
end

















local _attrWidgetIdx=
{
greenRoot=0,
redRoot=1,
diziRoot=2,
greenStr=3,
redStr=4,
diziStr=5,
tou=6,
name=7,
}

local height=
{
[MysteryEventDiceResultAttrType.eCommonGreen]=47,
[MysteryEventDiceResultAttrType.eCommonRed]=47,
[MysteryEventDiceResultAttrType.eDizi]=84,
}


function UIMysteryEventResultWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryEventResultWin:__delete()
MysteryEventModel:set_select_disciple(nil)
MysteryEventModel:clear_event_str_list()
MysteryEventModel:clear_event_dice_str_list()

if not MysteryEventModel:have_event_flag()then
if MysteryModel:is_enter_Mystery()then

mysteryAIManager:update_queue()
end
end
self:unbindComponents()
end




function UIMysteryEventResultWin:onShow(argtable,afterOnloaded)
if not argtable then
UIManager:closeWindow("UIMysteryEventResultWin")
return
end

local mainArgs=argtable.mainArgs
self.groupId=mainArgs.groupId
self.optionId=mainArgs.optionId
self.resultIndex=mainArgs.resultIndex

self.confirmCallBack=mainArgs.confirmCallBack
self.confirmText:setText(mainArgs.confirmText or"确认")
self.resetCallBack=mainArgs.resetCallBack
self.resetText:setText(mainArgs.resetText or"重掷")
self.funcCallBack=mainArgs.funcCallBack
self.funcText:setText(mainArgs.funcText or"")

self.funcButton:setActive(mainArgs.funcBtnShow~=nil)

self.confirmButton:setActive(mainArgs.confirmHide==nil)

local diceCount=MysteryEventModel:get_dice_count()
self.resetButton:setActive(mainArgs.isdice and diceCount>0)

self.childWinArgs=argtable.childWinArgs

self.groupCfg=MysteryEventModel.get_group_cfg(self.groupId)
self.optionCfg=self.groupCfg[self.optionId]

if self.resultIndex then
local resultTxt=self.optionCfg[MysteryEventSystem.diceCfg[self.resultIndex].result]
self.EventGroupText:setText(resultTxt)
end

local delay=self:setTimer(0.02,1,function()
if self.childWinArgs then
for i,v in ipairs(self.childWinArgs)do
if v.name then
self:showPanel(v.name,v.args)
end
end
end
end)

end


function UIMysteryEventResultWin:OnEnable()

end


function UIMysteryEventResultWin:OnDisable()

end

function UIMysteryEventResultWin:showPanel(childWin,args)
if childWin==MysteryEventSystem.ResultPanel.Item then
self:showItemPanel(args)
elseif childWin==MysteryEventSystem.ResultPanel.Attr then
self:showAttrPanel(args)
elseif childWin==MysteryEventSystem.ResultPanel.Shane then
self:showShanePanel(args)
end
end

function UIMysteryEventResultWin:showItemPanel(args)
local itemList=args.itemList
if itemList then
local length=200
local count=#itemList
self.ItemRoot:setActive(true)
self.itemPanel:setChildLayoutGroupCreateItems(count)
length=(math.ceil(count/4)-1)*82+length
local items=self.itemPanel:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local data=itemList[i+1]
local widget=item:GetChildWidgetBase(0)
widgetHelper.setNormalRewardItem(widget,0,data)
end

self.winid:SetChildLayoutElementPreferredHeight(self.ItemRoot:getID(),length)
else
self.ItemRoot:setActive(false)
end
end

function UIMysteryEventResultWin:showAttrPanel(args)
local length=0

self.eventRoot:setActive(true)
local eventlist=MysteryEventModel:get_event_dice_str_list()
table.sort(eventlist,function(a,b)return a.uiType<b.uiType end)
self.eventRoot:setChildLayoutGroupCreateItems(#eventlist)
local grids=self.eventRoot:getChildLayoutGroupGridList()
for i,v in ipairs(eventlist)do
local item=grids[i-1]
if item then
local str=v.str
local uiType=v.uiType
local guid=v.guid
if uiType==MysteryEventDiceResultAttrType.eCommonGreen then
item:SetChildActive(_attrWidgetIdx.greenRoot,true)
item:SetChildText(_attrWidgetIdx.greenStr,str)
length=length+height[MysteryEventDiceResultAttrType.eCommonGreen]
elseif uiType==MysteryEventDiceResultAttrType.eCommonRed then
item:SetChildActive(_attrWidgetIdx.redRoot,true)
item:SetChildText(_attrWidgetIdx.redRoot,str)
length=length+height[MysteryEventDiceResultAttrType.eCommonRed]
elseif uiType==MysteryEventDiceResultAttrType.eDizi then
item:SetChildActive(_attrWidgetIdx.diziRoot,true)
item:SetChildText(_attrWidgetIdx.diziStr,str)
comHelper.setChildModelRawImage(item,guid,_attrWidgetIdx.tou,0,eHeadCenterType.eHalf,0.7)
item:SetChildText(_attrWidgetIdx.name,UIDiscipleModel:getDiscipleName(guid))
length=length+height[MysteryEventDiceResultAttrType.eDizi]
end
end
end
self.winid:SetChildLayoutElementPreferredHeight(self.eventRoot:getID(),length)
end

local shaneRectLength=160
function UIMysteryEventResultWin:showShanePanel(args)
self.shaneRoot:setActive(true)
local previewValue=args.previewValue or 0
local shaneValue=UISectPalaceModel:getShanEValue()
local value=shaneValue+previewValue
local shaneConfig=cfgHelper.get2(cfg_guilddadianconfig_get,1,'shane_conf')
local section=shaneConfig[3][2]-shaneConfig[1][1]
local posX=(value-shaneConfig[1][1])/section*shaneRectLength
self.shanepoint:setChildAnchoredPosition(mathHelper.convertArrayToVector({posX,0}))

if previewValue>0 then
self.shaneAddText:setText(FMT.fmt("{0}+{1}",shaneValue,previewValue))
else
self.shaneSubText:setText(FMT.fmt("{0}{1}",shaneValue,previewValue))
end
end





function UIMysteryEventResultWin:onCloseClick()







UIFullMysteryEventControl:closeUIEX(false,true)
end

function UIMysteryEventResultWin:onResetButton()
if self.resetCallBack then
self.resetCallBack()
end
UIManager:invokeUIMethod("UIMysteryEventDiceWin","onDice")
end

function UIMysteryEventResultWin:onConfirmButton()
if self.confirmCallBack then
self.confirmCallBack()
end
UIFullMysteryEventControl:closeUIEX(true,true)
end

function UIMysteryEventResultWin:onFuncButton()
if self.funcCallBack then
self.funcCallBack()
end
if self.onCloseClick then
self.onCloseClick()
end
end