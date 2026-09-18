







def_class("UIMysteryEventOutResultWin",UIWindowBase)









function UIMysteryEventOutResultWin:bindComponents()

self.resetText=UIText.get(self,0)
self.confirmText=UIText.get(self,1)
self.funcText=UIText.get(self,2)
self.oneText=UIText.get(self,3)
self.eventPanel=UIObject.get(self,4)
self.resetButton=UIButton.get(self,5)
self.confirmButton=UIButton.get(self,6)
self.funcButton=UIButton.get(self,7)
self.itemPanel=UIObject.get(self,8)
self.ruleRoot=UIObject.get(self,9)
self.shaneRoot=UIObject.get(self,10)
self.BtnRoot=UIObject.get(self,11)
self.EventGroupText=UIText.get(self,12)
self.AttrRoot=UIObject.get(self,13)
self.ItemRoot=UIObject.get(self,14)
self.frameButton=UIButton.get(self,15)
self.root=UIObject.get(self,16)
self.tips=UIText.get(self,17)
self.MysteryEventOptionsItem1=UIObject.get(self,18)
self.shanepoint=UIObject.get(self,19)
self.lshane=UIObject.get(self,20)
self.rshane=UIObject.get(self,21)
self.shaneAddText=UIText.get(self,22)
self.shaneSubText=UIText.get(self,23)
self.rulePanel=UIObject.get(self,24)

self.resetButton:setButtonClick(function()self:onResetButton()end)

self.confirmButton:setButtonClick(function()self:onConfirmButton()end)

self.funcButton:setButtonClick(function()self:onFuncButton()end)

self.frameButton:setButtonClick(function()if self and not self.isClose then self:onFrameButton()end end)



end


function UIMysteryEventOutResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.resetText);self.resetText=nil;
_UIObject_release(self.confirmText);self.confirmText=nil;
_UIObject_release(self.funcText);self.funcText=nil;
_UIObject_release(self.oneText);self.oneText=nil;
_UIObject_release(self.eventPanel);self.eventPanel=nil;
_UIObject_release(self.resetButton);self.resetButton=nil;
_UIObject_release(self.confirmButton);self.confirmButton=nil;
_UIObject_release(self.funcButton);self.funcButton=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.ruleRoot);self.ruleRoot=nil;
_UIObject_release(self.shaneRoot);self.shaneRoot=nil;
_UIObject_release(self.BtnRoot);self.BtnRoot=nil;
_UIObject_release(self.EventGroupText);self.EventGroupText=nil;
_UIObject_release(self.AttrRoot);self.AttrRoot=nil;
_UIObject_release(self.ItemRoot);self.ItemRoot=nil;
_UIObject_release(self.frameButton);self.frameButton=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.MysteryEventOptionsItem1);self.MysteryEventOptionsItem1=nil;
_UIObject_release(self.shanepoint);self.shanepoint=nil;
_UIObject_release(self.lshane);self.lshane=nil;
_UIObject_release(self.rshane);self.rshane=nil;
_UIObject_release(self.shaneAddText);self.shaneAddText=nil;
_UIObject_release(self.shaneSubText);self.shaneSubText=nil;
_UIObject_release(self.rulePanel);self.rulePanel=nil;
end





















function UIMysteryEventOutResultWin:onLoaded(...)
self:bindComponents()

self.childWinQueue=queue.New()
self.showChildQueue=queue.New()
end


function UIMysteryEventOutResultWin:__delete()
self:unbindComponents()
self.isConfirmed=nil
MysteryEventModel:set_select_disciple(nil)
MysteryEventModel:clear_event_str_list()
MysteryEventModel:clear_event_dice_str_list()

if not MysteryEventModel:have_event_flag()then
if MysteryModel:is_enter_Mystery()then

mysteryAIManager:update_queue()
end
end
if self.shaneTweener then
self.shaneTweener:Kill()
self.shaneTweener=nil
end
if self.fadeRoot then
self.fadeRoot:Kill()
self.fadeRoot=nil
end

if self.sendFinish then
timeEventController.delayDo(0.1,function()
local result_group=MysteryEventModel:get_result_select()
if result_group then
MysteryEventModel:set_result_select()
notifySystem:postNotify(notifyConfig.on_mystery_event_finish,unpack(result_group))
end
end)
end
end




function UIMysteryEventOutResultWin:onShow(argtable,afterOnloaded)
local mainArgs=argtable.mainArgs
self.groupId=mainArgs.groupId
self.optionId=mainArgs.optionId
self.resultIndex=mainArgs.resultIndex or 1

self.confirmCallBack=mainArgs.confirmCallBack
self.funcCallBack=mainArgs.funcCallBack
self.confirmButton:setActive(mainArgs.confirmHide==nil)

self.root:setChildCanvasGroupAlpha(0)
self.fadeRoot=self.root:setChildCanvasGroupDOFade(1,0.5)


self.childWinArgs=argtable.childWinArgs

self.groupCfg=MysteryEventModel.get_group_cfg(self.groupId)
self.optionCfg=self.groupCfg[self.optionId]

self.childWinQueue:clear()
self.showChildQueue:clear()
if self.childWinArgs and next(self.childWinArgs)then
self.root:setActive(true)
for i,v in ipairs(self.childWinArgs)do
if v.name then

self.childWinQueue:enqueue(v)
end
end
else
self.root:setActive(false)
local resultCfg=self.optionCfg[MysteryEventSystem.diceCfg[self.resultIndex].args]

if resultCfg and resultCfg[1]==nil then
self.sendFinish=true
end
end

if self.childWinQueue:isEmpty()then
local notNull=self:showChangedEventList(self.optionId,self.resultIndex)
local resultTxt=self.optionCfg[MysteryEventSystem.diceCfg[self.resultIndex].result]
if not notNull and not resultTxt then

self:onConfirmButton()
end
else
self:pop()
end


end


function UIMysteryEventOutResultWin:onHide()

end


function UIMysteryEventOutResultWin:showChangedEventList(optionId,resultIndex)
self.MysteryEventOptionsItem1:setActive(false)
if not self.groupCfg then
return
end
local optionCfg=self.groupCfg[optionId]
if not optionCfg then

return
end
local explain=optionCfg[MysteryEventSystem.diceCfg[resultIndex].explain]
if explain and explain[2]then
explain=explain[2]
if optionCfg then
self.MysteryEventOptionsItem1:setActive(true)
local item=self.MysteryEventOptionsItem1:getChildWidgetBase()
item:SetChildText(0,explain)
local flagIcon=iconHelper.getEventIcon(2)
item:SetChildActive(4,true)
item:SetChildCSImageIcon(2,flagIcon,false)
item:SetChildButtonClick(6,function()
if self and not self.isClose then
item:SetChildActive(1,true)
self:onConfirmButton()
end
end)
self.tips:setActive(false)
self.frameButton:setActive(false)
return explain
end
end
end

function UIMysteryEventOutResultWin:pop()
local v=self.showChildQueue:dequeue()
if v then
self:hidePanel(v)
end
v=self.childWinQueue:dequeue()
if v then
self:showPanel(v.name,v.args)
self.showChildQueue:enqueue(v.name)
end
end

function UIMysteryEventOutResultWin:showPanel(childWin,args)
if childWin==MysteryEventSystem.ResultPanel.Item then
self:showItemPanel(args)
elseif childWin==MysteryEventSystem.ResultPanel.Attr then
self:showAttrPanel(args)
elseif childWin==MysteryEventSystem.ResultPanel.Shane then
self:showShanePanel(args)
elseif childWin==MysteryEventSystem.ResultPanel.Rule then
self:showRulePanel(args)
end
end

function UIMysteryEventOutResultWin:hidePanel(childWin)
if childWin==MysteryEventSystem.ResultPanel.Item then

self.ItemRoot:setChildCanvasGroupDOFade(0,0.5)
elseif childWin==MysteryEventSystem.ResultPanel.Attr then

self.AttrRoot:setChildCanvasGroupDOFade(0,0.5)
elseif childWin==MysteryEventSystem.ResultPanel.Shane then

self.shaneRoot:setChildCanvasGroupDOFade(0,0.5)
if self.shaneTweener then
self.shaneTweener:Complete()
self.shaneTweener=nil
end
elseif childWin==MysteryEventSystem.ResultPanel.Rule then
self.ruleRoot:setChildCanvasGroupDOFade(0,0.5)
end
end

function UIMysteryEventOutResultWin:showItemPanel(args)
local itemList=args.itemList
if itemList then
self.ItemRoot:setActive(true)
self.ItemRoot:setChildCanvasGroupAlpha(0)
self.ItemRoot:setChildCanvasGroupDOFade(1,0.5)
self.itemPanel:setChildLayoutGroupCreateItems(#itemList)
local items=self.itemPanel:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local data=itemList[i+1]
local itemConfig=itemsConfig.getConfig(data[1])
data.stage=itemConfig.stage
widgetHelper.setNormalRewardItem(item,0,data)
end
else
self.ItemRoot:setActive(false)
end
end

function UIMysteryEventOutResultWin:showAttrPanel(args)
self.AttrRoot:setActive(true)
self.AttrRoot:setChildCanvasGroupAlpha(0)
self.AttrRoot:setChildCanvasGroupDOFade(1,0.5)
local eventlist=MysteryEventModel:get_event_str_list()

if#eventlist==1 then
self.oneText:setText(eventlist[1])
else
local num=#eventlist
local cnum=math.ceil(num/6)
self.eventPanel:setChildScrollViewCreateGrids(cnum,cnum)

local grids=self.eventPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local n=6
if i==count then
local f=math.fmod(num,6)
n=f==0 and 6 or f
end
grid:SetChildLayoutGroupCreateItems(0,n)
local items=grid:GetChildLayoutGroupGridList(0)
for ii=1,items.Count do
local item=items[ii-1]
item:SetChildText(0,eventlist[(i-1)*6+ii])
end
end






end
end

function UIMysteryEventOutResultWin:showRulePanel(args)
local ruleList=args.ruleList
if ruleList then
self.ruleRoot:setActive(true)
self.ruleRoot:setChildCanvasGroupAlpha(0)
self.ruleRoot:setChildCanvasGroupDOFade(1,0.5)
self.rulePanel:setChildLayoutGroupCreateItems(#ruleList)
local items=self.rulePanel:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local data=ruleList[i+1]
local ruleId
local lv
if type(data)=="table"then
ruleId=data[1]
lv=data[2]
else
ruleId=data
lv=1
end
if ruleId then
local ruleCfg=cfgHelper.getSSlawRule(ruleId)
if ruleCfg then
local icon=ruleCfg.image
local name=ruleCfg.name
item:SetChildIcon(0,icon,false)
item:SetChildText(1,name)
item:SetChildButtonClick(0,function()
self:showWindow("UIMysteryRuleViewWin",{id=ruleId,level=lv})
end)
if i==0 then
self:showWindow("UIMysteryRuleViewWin",{id=ruleId,level=lv})
end
end
end
end
else
self.ruleRoot:setActive(false)
end
end


local shaneRectLength=185
function UIMysteryEventOutResultWin:showShanePanel(args)
self.shaneRoot:setActive(true)
self.shaneRoot:setChildCanvasGroupAlpha(0)
self.shaneRoot:setChildCanvasGroupDOFade(1,0.5)
local lPos=self.lshane:getChildLocalPosition()
local rPos=self.rshane:getChildLocalPosition()
shaneRectLength=(rPos.x-lPos.x)/2
local previewValue=args.previewValue or 0
local shaneValue=UISectPalaceModel:getShanEValue()
local value=shaneValue+previewValue
local shaneConfig=cfgHelper.get2(cfg_guilddadianconfig_get,1,'shane_conf')
local section=shaneConfig[3][2]-shaneConfig[1][1]
local posX=(shaneValue-shaneConfig[1][1])/section*shaneRectLength

self.shanepoint:setLocalPosX(posX)
posX=(value-shaneConfig[1][1])/section*shaneRectLength
self.shaneTweener=self.shanepoint:setChildDOLocalMoveX(posX,1,nil)

if previewValue>0 then
self.shaneAddText:setText(FMT.fmt("{0}+{1}",shaneValue,previewValue))
else
self.shaneSubText:setText(FMT.fmt("{0}{1}",shaneValue,previewValue))
end
end

function UIMysteryEventOutResultWin:onCloseClick()

UIFullMysteryEventControl:closeUIEX(true,true)
end





function UIMysteryEventOutResultWin:onResetButton()
end



function UIMysteryEventOutResultWin:onConfirmButton()

if self.childWinQueue:size()>0 then
self:pop()
else
if self.isConfirmed then
return
end

if self and not self.isClose and self.funcCallBack then
self.funcCallBack()
end
if self and not self.isClose and self.confirmCallBack then
self:delayDo(2,function()
if self and not self.isClose then
self:waitToConfirm()
end
end)
self.isConfirmed=true
self.confirmCallBack()

else
if self and not self.isClose and self.onCloseClick then
self.onCloseClick()
end
end

end

end

function UIMysteryEventOutResultWin:waitToConfirm()
self.isConfirmed=nil
if self and not self.isClose and self.onCloseClick then
self.onCloseClick()
end
end



function UIMysteryEventOutResultWin:onFuncButton()
end

function UIMysteryEventOutResultWin:onFrameButton()
self:onConfirmButton()
end
