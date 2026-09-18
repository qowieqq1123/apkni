







def_class("UIJiuChongTianJieFirstAscentWin",UIWindowBase)









function UIJiuChongTianJieFirstAscentWin:bindComponents()

self.mbg=UIObject.get(self,0)
self.mbg1=UIObject.get(self,1)
self.mbg2=UIObject.get(self,2)
self.modelImage=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.topPlayerInfo=UIObject.get(self,5)



end


function UIJiuChongTianJieFirstAscentWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mbg1);self.mbg1=nil;
_UIObject_release(self.mbg2);self.mbg2=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.topPlayerInfo);self.topPlayerInfo=nil;
end
















local CmpWidgetIndex={
self=0,
name=1,
server=2,
iconHead=3,
mobai=4,
headBg=5,
mobaiCount=6,
zanNum=7,
mobaiTips=8,
}
local _this




function UIJiuChongTianJieFirstAscentWin:onLoaded(...)
self:bindComponents()
_this=self

jiuchongtianjieFirstAscentModel:saveAutoShowFirstAscentTips()
end


function UIJiuChongTianJieFirstAscentWin:__delete()
self:unbindComponents()
_this=nil
end




function UIJiuChongTianJieFirstAscentWin:onShow(argtable,afterOnloaded)
self:refreshView()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.modelImage:setChildCanvasGroupAlpha(0)
self.mbg1:setChildUIModelShowTarget(6178,1,{},eAnimationID.enter,false,false,0)
self.mbg2:setChildUIModelShowTarget(6177,1,{},eAnimationID.enter,false,false,0)
self.mbg:setChildUIModelShowTarget(6176,1,{},eAnimationID.enter,false,false,0)

self:delayDo(0.3,function()
if not _this then return end
_this.modelImage:setChildCanvasGroupDOFade(1,0.5)
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
end

function UIJiuChongTianJieFirstAscentWin:refreshView()
self:refreshPanel()
self:refreshLike()
end

function UIJiuChongTianJieFirstAscentWin:refreshPanel()
local data=jiuchongtianjieFirstAscentModel:getData()
local serverId=data.serverId
local actorId=data.actorId
local name=data.name
local iconInfo=data.iconInfo

playerImageController.setPlayerModel(self.winlua,self.modelImage:getID(),iconInfo.piList,0.66,eAnimationID.idle,0,0,playerController:supportDynamic(),nil,true)

local widget=self.topPlayerInfo:getWidgetBase()
playerController:setHeadIcon(widget,CmpWidgetIndex.iconHead,{scale=0.8,iconInfo=iconInfo})

local serverName=loginModel:getServerName(serverId)
serverName=FMT.fmt("[{0}]",serverName)
widget:SetChildText(CmpWidgetIndex.server,serverName)
widget:SetChildText(CmpWidgetIndex.name,playerModel:getOtherActorName(name))


widget:SetChildButtonClick(CmpWidgetIndex.headBg,function()
local attach={serverid=serverId}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end)

self:delayDo(0.8,function()
widget:SetChildActive(CmpWidgetIndex.mobaiTips,true)
widget:SetChildCanvasGroupAlpha(CmpWidgetIndex.mobaiTips,1)
self.btnReddotIndex=self:doPunchRotation(widget,CmpWidgetIndex.mobaiTips,self.btnReddotIndex,true)
end)
end

function UIJiuChongTianJieFirstAscentWin:refreshLike()
local isCanLike,count=jiuchongtianjieFirstAscentModel:getIsCanLike()
local days=cfgHelper.get2(cfg_shouweifeishengtishibaseconfig_get,1,"days")
local fsDay=jiuchongtianjieFirstAscentModel:getFSDay()
local likeTotal=jiuchongtianjieFirstAscentModel:getLikeTotal()

local widget=self.topPlayerInfo:getWidgetBase()
widget:SetChildText(CmpWidgetIndex.mobaiCount,likeTotal)
widget:SetChildGray(CmpWidgetIndex.mobai,count<=0)
widget:SetChildText(CmpWidgetIndex.zanNum,FMT.fmt("剩余点赞次数：{0}",count))
widget:SetChildButtonClick(CmpWidgetIndex.mobai,function()
if fsDay>days then
return
end
if isCanLike and count>0 then
count=count-1
jiuchongtianjieFirstAscentController:req_firstAscentLike()
else
UIManager.info('次数不足')
end
end,true)

end


function UIJiuChongTianJieFirstAscentWin:onHide()

end

function UIJiuChongTianJieFirstAscentWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,-5),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end



