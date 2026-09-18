







def_class("UIXM_LXWJ_stateWin",UIWindowBase)









function UIXM_LXWJ_stateWin:bindComponents()

self.root=UIObject.get(self,0)
self.stateIcon=UIImage.get(self,1)
self.leftInfoItem=UIObject.get(self,2)
self.rightInfoItem=UIObject.get(self,3)
self.timeObj=UIObject.get(self,4)
self.timeTxt=UIText.get(self,5)
self.messageFrame=UIObject.get(self,6)
self.messageMask=UIObject.get(self,7)
self.messageTxt=UIText.get(self,8)
self.message2Txt=UIText.get(self,9)



end


function UIXM_LXWJ_stateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.stateIcon);self.stateIcon=nil;
_UIObject_release(self.leftInfoItem);self.leftInfoItem=nil;
_UIObject_release(self.rightInfoItem);self.rightInfoItem=nil;
_UIObject_release(self.timeObj);self.timeObj=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.messageFrame);self.messageFrame=nil;
_UIObject_release(self.messageMask);self.messageMask=nil;
_UIObject_release(self.messageTxt);self.messageTxt=nil;
_UIObject_release(self.message2Txt);self.message2Txt=nil;
end
















local _this=nil


function UIXM_LXWJ_stateWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_stateWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_stateWin:onHide()
self:clearMyTimer()
end




function UIXM_LXWJ_stateWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self:initMessage()
end

if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end
self:refreshTime()
self:refreshInfo()
end

function UIXM_LXWJ_stateWin:clearMyTimer()
if self.mytimer~=nil then
self:stopTimerByID(self.mytimer)
self.mytimer=nil
end
end

function UIXM_LXWJ_stateWin:refreshTime()
local raceState,left,left2=lingxuwenjianModel:getLunState()
local raceState_old=self.raceState
self.raceState=raceState
if self.raceState~=raceState_old then
local abname,icon=lingxuwenjianModel:getLunStateIcon(self.raceState)
self.stateIcon:setSprite(abname,icon)
end
local time_str
local left_
if raceState==eLXWJ_State.eFight and lingxuwenjianModel:checkBattleResult()~=nil then
left_=left2
else
left_=left
end

if left_<=10800 then
time_str=FMT.fmt('{0}',timeHelper.format_time_stamp3(left_))
end
local showTime=time_str~=nil
self.timeObj:setActive(showTime)
if showTime then
self.timeTxt:setText(time_str)
end

self:updateMessage()
end

function UIXM_LXWJ_stateWin:refreshInfo(anim)
local hasEnemy=lingxuwenjianModel:hasEnemy()
self.leftInfoItem:setActive(hasEnemy)
self.rightInfoItem:setActive(hasEnemy)
if hasEnemy then
self:refreshLeftInfo(anim)
self:refreshRightInfo(anim)
end
end

function UIXM_LXWJ_stateWin:refreshLeftInfo(anim)
local widget=self.leftInfoItem:getWidgetBase()
local image=xianmengModel:getGuildImage()
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local name=xianmengModel:getXMName()
widget:SetChildText(3,name)

local score=lingxuwenjianModel:getMyRaceScore()or 0
widget:SetChildText(4,tostring(score))

local max=lingxuwenjianModel:getMaxBattleScore()
local rate=score/max
if rate>1 then
rate=1
end
if self.leftProgressTween~=nil then
if not self.leftProgressTween:IsComplete()then
self.leftProgressTween:OnComplete(nil)
self.leftProgressTween:Complete()
end
self.leftProgressTween=nil
end
if anim then
local speed=1
local old_rate=widget:GetChildIconFillAmount(5)
self.leftProgressTween=widget:SetChildImageDOFillAmount(5,rate,math.abs(rate-old_rate)*speed,function()
if _this==nil then return end
_this.leftProgressTween=nil
end)
else
widget:SetChildIconFillAmount(5,rate)
end

local result=lingxuwenjianModel:checkBattleResult()
local isshow=result~=nil
widget:SetChildActive(6,isshow)
if isshow then
local abname_,icon_=lingxuwenjianModel:getResultIcon(result,true)
widget:SetChildCSImageSprite(6,abname_,icon_)
end
end

function UIXM_LXWJ_stateWin:refreshRightInfo(anim)
local widget=self.rightInfoItem:getWidgetBase()
local enemyData=lingxuwenjianModel:getEnemyData()
local image=xianmengModel.splitGuildIcon(enemyData.enemyguildicon)
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local name=enemyData.enemyname
widget:SetChildText(3,name)

local score=lingxuwenjianModel:getEnemyRaceScore()or 0
widget:SetChildText(4,tostring(score))

local max=lingxuwenjianModel:getMaxBattleScore()
local rate=score/max
if rate>1 then
rate=1
end
if self.rightProgressTween~=nil then
if not self.rightProgressTween:IsComplete()then
self.rightProgressTween:OnComplete(nil)
self.rightProgressTween:Complete()
end
self.rightProgressTween=nil
end
if anim then
local speed=1
local old_rate=widget:GetChildIconFillAmount(5)
self.rightProgressTween=widget:SetChildImageDOFillAmount(5,rate,math.abs(rate-old_rate)*speed,function()
if _this==nil then return end
_this.rightProgressTween=nil
end)
else
widget:SetChildIconFillAmount(5,rate)
end

local result=lingxuwenjianModel:checkBattleResult()
local isshow=result~=nil
widget:SetChildActive(6,isshow)
if isshow then
local abname_,icon_=lingxuwenjianModel:getResultIcon(result,false)
widget:SetChildCSImageSprite(6,abname_,icon_)
end
end



function UIXM_LXWJ_stateWin:initMessage()
self.messageSpeed=150
self.messageSpace=1.5
self.messageObjLookup={}
self.messageObjLookup[1]=self.messageTxt
self.messageObjLookup[2]=self.message2Txt
self.messageObjUsedLookup={}
self.messageList={}
self.messageBoxWidth=self.messageMask:getChildSizeDeltaX()
end

function UIXM_LXWJ_stateWin:updateMessage()
local c=#self.messageList
if c<2 then
local l_time
if c>0 then
for i,meassge in ipairs(self.messageList)do
if l_time==nil or meassge.endTime>l_time then
l_time=meassge.endTime
end
end
end
if l_time==nil or Time.realtimeSinceStartup>l_time then
self:addMessage()
end
end
end

function UIXM_LXWJ_stateWin:addMessage()
local obj_idx=nil
for idx,obj in pairs(self.messageObjLookup)do
if self.messageObjUsedLookup[idx]==nil then
obj_idx=idx
break
end
end
if obj_idx then
local message_str=lingxuwenjianModel:getMessageStr()
if message_str then
self.messageFrame:setActive(true)

local message={}
message.obj_idx=obj_idx
local obj=self.messageObjLookup[obj_idx]
self.messageObjUsedLookup[obj_idx]=true
obj:setChildCanvasGroupAlpha(0)
obj:setText(message_str)
self:delayDo(0.2,function()
local w=obj:getChildSizeDeltaX()
local time=(w+self.messageBoxWidth)/self.messageSpeed
local time2=w/self.messageSpeed+self.messageSpace
message.endTime=Time.realtimeSinceStartup+time2
local h_w=self.messageBoxWidth/2
obj:setChildAnchoredPos(h_w,2)
local tweener=obj:setChildDOAnchorPosX(-h_w-w,time,function()
if _this==nil then return end
self:removeMessage(obj_idx)
end)
tweener:SetEase(_Ease.Linear)
obj:setChildCanvasGroupAlpha(1)
table.insert(self.messageList,message)
end)
end
end
end

function UIXM_LXWJ_stateWin:removeMessage(idx)
local f
for i,message_ in ipairs(self.messageList)do
if message_.obj_idx==idx then
f=i
break
end
end
if f then
local message=table.remove(self.messageList,f)
local obj_idx=message.obj_idx
local obj=self.messageObjLookup[obj_idx]
obj:setChildCanvasGroupAlpha(0)
self.messageObjUsedLookup[obj_idx]=nil
end
end



function UIXM_LXWJ_stateWin:rec_enemy()
self:refreshInfo()
end

function UIXM_LXWJ_stateWin:rec_result()
self:refreshInfo()
end