







def_class("UIVisitWin",UIWindowBase)









function UIVisitWin:bindComponents()

self.fvalue=UIText.get(self,0)
self.groundBtn=UIToggleButton.get(self,1)
self.head=UIObject.get(self,2)
self.icon=UIImage.get(self,3)
self.kuang=UIImage.get(self,4)
self.leaveBtn=UIButton.get(self,5)
self.level=UIText.get(self,6)
self.msgList=UIObject.get(self,7)
self.name=UIText.get(self,8)
self.time=UIText.get(self,9)
self.timeClick=UIButton.get(self,10)

self.leaveBtn:setButtonClick(function()self:onLeaveBtn()end)

self.timeClick:setButtonClick(function()self:onTimeClick()end)



end


function UIVisitWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fvalue);self.fvalue=nil;
_UIObject_release(self.groundBtn);self.groundBtn=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.kuang);self.kuang=nil;
_UIObject_release(self.leaveBtn);self.leaveBtn=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.msgList);self.msgList=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeClick);self.timeClick=nil;
end















local _msgItemCmp={
widget=0,
desc=1,
icon=2,
bg=3,
root=4,
}
local _msgItemHandle={
[1]={
desc="访客来访",
icon={globalABLookup.hud_atlas,"icon_fangke"},
check=function(playId)
if zongmenVisitorController.showOther then
local visitor=zongmenVisitorModel:getVisitor(playId)
return visitor and visitor.id>0 or false
end
return false
end,
click=function(playId)
zongmenVisitorController:moveCameraToVisitorEntity()
end,
},
[2]={
desc="天魔劫",
icon={globalABLookup.mainwin,"icon_tianmoruqing"},
check=function(playId)
return tianMoJieModel:haveMonsterByActor(playId)
end,
click=function(playId)
UIManager:showWindow("UITianMoJieMonsterListWin")
end,
},
}




function UIVisitWin:onLoaded(...)
self:bindComponents()

self:RefreshGroundBtn()

self.groundBtn:setToggleChange(function(name,isOn)
if isOn then
isometricMapSystem:enterGroundModel()
else
isometricMapSystem:leaveGroundModel()
end
end)
end


function UIVisitWin:__delete()
self:unbindComponents()
end




function UIVisitWin:onShow(argtable,afterOnloaded)

local data=visitControl:getActorData()


self.name:setText(data.actorName)
local time=gameUtilityModel.getServerShortTime()
self.dtime=gameUtilityModel.getGameYearPass2(data.createTime,time)

self.time:setText(FMT.fmt('{0}年',mathHelper.formatNumber4(self.dtime,1)))

local fvalue=tonumber(tostring(data.zmFValue))
self.fvalue:setText(mathHelper.formatNumber(fvalue))
self.level:setText(data.zmLevel)














local args={iconInfo=data.actorIcon,scale=0.65}
playerController:setHeadIcon(self.winlua,self.head:getID(),args)

self:refreshMsgList()
end


function UIVisitWin:onHide()

end

function UIVisitWin:RefreshGroundBtn()
local inGroundMode=isometricMapSystem:isInGroundModel()
self.groundBtn:setToggle(inGroundMode)
end




function UIVisitWin:onLeaveBtn()
visitControl:leaveVisitMap()
end

function UIVisitWin:onTimeClick()
if not self.dtime then
return
end


local desc=FMT.fmt('{0}年',self.dtime)
UIManager:showWindow('UIConditionTipsOne',{showType=3,str=desc,posItem=self.time,pos={x=-45,y=-20}})
end

function UIVisitWin:showMsgItem(widget,text,icon,callback)

widget:SetChildCSImageSprite(_msgItemCmp.icon,icon[1],icon[2])
widget:SetChildText(_msgItemCmp.desc,text)

widget:SetChildButtonClick(_msgItemCmp.bg,callback)
widget:SetChildDOAnchorPosX(_msgItemCmp.root,0,0.3)
end

function UIVisitWin:hideMsgItem(widget)

widget:SetChildDOAnchorPosX(_msgItemCmp.root,-250,0.3)
end














function UIVisitWin:refreshMsgList()
local playId=visitControl:getCurrentActor()
local msgList={}
for i,v in ipairs(_msgItemHandle)do
if v.check(playId)then
table.insert(msgList,i)
end
end
self.msgList:setChildLayoutGroupCreateItems(#msgList,function(index)
local item=self.msgList:getChildLayoutGroupGridItem(index-1)
local msg=msgList[index]
local handle=_msgItemHandle[msg]
self:showMsgItem(item,handle.desc,handle.icon,handle.click)
end)
end
