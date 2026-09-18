







def_class("UIYYHYSpecialityWin",UIWindowBase)









function UIYYHYSpecialityWin:bindComponents()

self.root=UIObject.get(self,0)
self.specialityIcon=UIImage.get(self,1)
self.specialityTypeTxt=UIText.get(self,2)
self.specialityDesc=UIText.get(self,3)
self.specialityInfo=UIText.get(self,4)
self.timeObj=UIObject.get(self,5)
self.specialityName=UIText.get(self,6)
self.timeTxt=UIText.get(self,7)
self.specialityNameEx=UIText.get(self,8)



end


function UIYYHYSpecialityWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.specialityIcon);self.specialityIcon=nil;
_UIObject_release(self.specialityTypeTxt);self.specialityTypeTxt=nil;
_UIObject_release(self.specialityDesc);self.specialityDesc=nil;
_UIObject_release(self.specialityInfo);self.specialityInfo=nil;
_UIObject_release(self.timeObj);self.timeObj=nil;
_UIObject_release(self.specialityName);self.specialityName=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.specialityNameEx);self.specialityNameEx=nil;
end



















function UIYYHYSpecialityWin:onLoaded(...)
self:bindComponents()
end


function UIYYHYSpecialityWin:__delete()
self:unbindComponents()
end




function UIYYHYSpecialityWin:onShow(argtable,afterOnloaded)

end


function UIYYHYSpecialityWin:onHide()

end




function UIYYHYSpecialityWin:onLoaded(...)
self:bindComponents()
end


function UIYYHYSpecialityWin:__delete()
self:unbindComponents()
end




function UIYYHYSpecialityWin:onShow(argtable,afterOnloaded)
local item=argtable.item
local move_pos=argtable.node
local guid=argtable.guid
local guidNetData=argtable.guidNetData
local config=argtable.config
local specialityList=argtable.specialityList


if argtable.pivot then
self.root:setChildPivot(argtable.pivot)
end

if item then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.1,function()
self.root:setChildCanvasGroupAlpha(1)
self:showPosition(item,move_pos)
end)
else
self.root:setChildCanvasGroupAlpha(1)
end


if config then
local len=0
local specialitytype=config.specialitytype or config.typo
local spe
if guid then
guidNetData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(guid))
len=UIDiscipleModel:getDiscipleSpecialityLen(guidNetData,specialitytype)
spe=UIDiscipleModel:getDiscipleSpecialityByID(guid,specialitytype,config.id)
elseif guidNetData then
len=UIDiscipleModel:getDiscipleSpecialityLen(guidNetData,specialitytype)
spe=UIDiscipleModel:getDiscipleSpecialityByIDEx(guidNetData,specialitytype,config.id)
end
local abName="ui/windows/activities/sub_dropact/dropact_title_atlas_pak.ab"
self.specialityNameEx:setText(config[1])
self.specialityName:setText(config[1])
self.specialityDesc:setText('')

self.specialityTypeTxt:setText('[渔技]')

local framecolor=config.framecolor
self.specialityIcon:setSprite(abName,FMT.fmt('image_huodedzui_{0}',config[2]))

local infoStr=zongmenControl:getSpecialityAddDesc(len,config)
local infoStr=config[3]
self.specialityInfo:setText(infoStr)


self:clearTimeDescTimer()
local lerpTime=-1
if spe then
lerpTime=UIDiscipleModel:getDZSpeLeftTime(spe)
end
local showTime=lerpTime>0
local showTimeObj=false
if showTime then
showTimeObj=true
self.speData=spe

self.timeDescTimer=self:setTimer(1,0,function()
self:refreshTimeDesc()
end)
self:refreshTimeDesc()
else
local duration=config.duration
showTimeObj=duration~=nil
if showTimeObj then
local time_str=FMT.fmt('{0}后将自动遗忘',timeHelper.format_time_stamp11(duration,true))
self.timeTxt:setText(time_str)
end
end
self.timeObj:setActive(showTimeObj)
end
end

function UIYYHYSpecialityWin:clearTimeDescTimer()
if self.timeDescTimer~=nil then
self:stopTimerByID(self.timeDescTimer)
self.timeDescTimer=nil
end
end

function UIYYHYSpecialityWin:refreshTimeDesc()
local lerpTime=UIDiscipleModel:getDZSpeLeftTime(self.speData)
if lerpTime>0 then
local time_str=FMT.fmt('{0}后将自动遗忘',timeHelper.format_time_stamp11(lerpTime,true))
self.timeTxt:setText(time_str)
else
self:clearTimeDescTimer()
self:closeSelf()
end
end


function UIYYHYSpecialityWin:onHide()

end




function UIYYHYSpecialityWin:showPosition(item,move_pos)

local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.root:getTransform()
local selfSize=selfTrans.sizeDelta

local offsetX=0
local offsetY=0
move_pos=move_pos or'bottom'

if move_pos=='bottom'then
offsetY=-itemSize.y*itemPivot.y
offsetX=-(itemPivot.x-0.5)*itemSize.x
elseif move_pos=='top'then
offsetY=-(itemPivot.y-1)*itemSize.y
offsetX=-(itemPivot.x-0.5)*itemSize.x
elseif move_pos=='left'then
offsetY=-(itemPivot.y-0.5)*itemSize.y
offsetX=-itemPivot.x*itemSize.x

offsetX=offsetX-selfSize.x/2
offsetY=offsetY+selfSize.y/2
elseif move_pos=='right'then
offsetY=-(itemPivot.y-0.5)*itemSize.y
offsetX=-(itemPivot.x-1)*itemSize.x

offsetX=offsetX+selfSize.x/2
offsetY=offsetY+selfSize.y/2
end
local rootPosX=screenPoint.x+offsetX
local rootPosY=screenPoint.y+offsetY


local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local itemHeight=selfSize.y
local halfHeight=UnityEngine.Screen.height/scaleFactor.y/2
if rootPosY-itemHeight<-halfHeight then
rootPosY=-halfHeight+itemHeight
end
if rootPosY>halfHeight then
rootPosY=halfHeight
end

self.winlua:SetChildLocalPosition(self.root:getID(),Vector3(rootPosX,rootPosY,0))
end
