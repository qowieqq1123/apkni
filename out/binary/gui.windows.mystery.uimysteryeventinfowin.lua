







def_class("UIMysteryEventInfoWin",UIWindowBase)









function UIMysteryEventInfoWin:bindComponents()

self.flow=UIHUDFlow.get(self,0)
self.rightdown=UIObject.get(self,1)
self.center=UIObject.get(self,2)



end


function UIMysteryEventInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.flow);self.flow=nil;
_UIObject_release(self.rightdown);self.rightdown=nil;
_UIObject_release(self.center);self.center=nil;
end



















local _attrWidgetIdx=
{
greenRoot=2,
redRoot=0,
diziRoot=1,
greenStr=7,
redStr=3,
diziStr=5,
tou=6,
name=4,
root=8,
}

local flowTypoMap=
{

[MysteryEventSystem.flowType.strTips]=function(win,root,offset,params)
local cmpOnSpwan=function(item)
local str=params.str
local uiType=params.uiType
local guid=params.guid
if uiType==MysteryEventDiceResultAttrType.eCommonGreen then
item:SetChildActive(_attrWidgetIdx.greenRoot,true)
item:SetChildText(_attrWidgetIdx.greenStr,str)
elseif uiType==MysteryEventDiceResultAttrType.eCommonRed then
item:SetChildActive(_attrWidgetIdx.redRoot,true)
item:SetChildText(_attrWidgetIdx.redStr,str)
elseif uiType==MysteryEventDiceResultAttrType.eDizi then
item:SetChildActive(_attrWidgetIdx.diziRoot,true)
item:SetChildText(_attrWidgetIdx.diziStr,str)
comHelper.setChildModelRawImage(item,guid,_attrWidgetIdx.tou,0,eHeadCenterType.eHalf,0.7)
item:SetChildText(_attrWidgetIdx.name,UIDiscipleModel:getDiscipleName(guid))
end
local t=item:SetChildCanvasGroupDOFade(_attrWidgetIdx.root,0,0.2,nil)
t:SetDelay(2)
item:SetChildLocalPosX(_attrWidgetIdx.root,50)
item:SetChildDOLocalMoveX(_attrWidgetIdx.root,0,0.2)

item:SetChildLocalPosY(_attrWidgetIdx.root,-300)
item:SetChildDOLocalMoveY(_attrWidgetIdx.root,offset*30-300,0.5)
end
win.flow:genFlowObj(0,1,2.5,root:getChildPosition(),Vector3.New(0,0,0),cmpOnSpwan)
end,


[MysteryEventSystem.flowType.itemTips]=function(win,root,offset,itemid,num)
local cmpOnSpwan=function(flowObjWin)

local itemIcon=iconHelper.getIconName(itemid)
flowObjWin:SetChildIcon(2,itemIcon,true)
flowObjWin:SetChildText(1,FMT.fmt("+ {0}",num or 1))

end
win.flow:genFlowObj(1,0.7,1.0,root:getChildPosition(),Vector3.New(0,offset or 2.2,0),cmpOnSpwan)
end,
}

local addTipTimeDelta=2


function UIMysteryEventInfoWin:onLoaded(...)
self:bindComponents()
self.rootMap=
{
[MysteryEventSystem.flowRoot.center]=self.center,
[MysteryEventSystem.flowRoot.rightDown]=self.rightdown,
}
self.rootQueue=
{
[MysteryEventSystem.flowRoot.center]=queue.New(),
[MysteryEventSystem.flowRoot.rightDown]=queue.New(),
}


self.addFlowTimer={}
self.addFlowCount=0
end


function UIMysteryEventInfoWin:__delete()
self:unbindComponents()

end




function UIMysteryEventInfoWin:onShow(argtable,afterOnloaded)

end


function UIMysteryEventInfoWin:onHide()

end

function UIMysteryEventInfoWin:flowText(flowType,rootType,offset,...)
local root=self.rootMap[rootType]
if not self.offsetNum then
self.offsetNum=0
end
if self.addFlowCount<5 then
self:flowTextNow(flowType,root,self.offsetNum,...)
self.offsetNum=self.offsetNum+offset
if not self.addFlowTimer[rootType]then
self.addFlowTimer[rootType]=self:setTimer(addTipTimeDelta,1,function()
local args=self.rootQueue[rootType]:dequeue()
self.addFlowTimer[rootType]=nil
self.addFlowCount=self.addFlowCount-5
self.offsetNum=0
if self.addFlowCount<0 then self.addFlowCount=0 end
if args then
self:flowText(args[1],rootType,offset,unpack(args[2]))
end
end)
end
else
self.rootQueue[rootType]:enqueue({flowType,{...}})
end
self.addFlowCount=self.addFlowCount+1

end

function UIMysteryEventInfoWin:flowTextNow(flowType,root,offset,...)
local flowFunc=flowTypoMap[flowType]
if root and flowFunc then
flowFunc(self,root,offset,...)
end
end



