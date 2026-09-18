







def_class("jctjSysWidget",UICloneObject)





jctjSysWidget.abName="ui/windows/jiuchongtianjieenter/jctjsyswidget.ab"

jctjSysWidget.assetName="jctjSysWidget"


function jctjSysWidget:bindComponents()

self.root=UIObject.get(self,0)
self.scaleRoot=UIObject.get(self,1)
self.cond=UIText.get(self,2)
self.icon=UIButton.get(self,3)
self.effect=UIObject.get(self,4)
self.click=UIButton.get(self,5)
self.road=UIObject.get(self,6)
self.name=UIText.get(self,7)
self.model=UIObject.get(self,8)
self.frame=UIImage.get(self,9)
self.reddot=UIObject.get(self,10)
self.finish=UIObject.get(self,11)
self.progress=UIProgress.get(self,12)

self.icon:setButtonClick(function()self:onIcon()end)

self.click:setButtonClick(function()self:onClick()end)

end


function jctjSysWidget:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scaleRoot);self.scaleRoot=nil;
_UIObject_release(self.cond);self.cond=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.road);self.road=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.finish);self.finish=nil;
_UIObject_release(self.progress);self.progress=nil;
end








local abName="ui/windows/jiuchongtianjieenter/enter_atlas_pak.ab"

local lockTitle="image_jiuchongtianjie_wz7"
local lockIcon="image_jiuchongtianjie_11"
local spName=5438
local efectId={20259,20260}


function jctjSysWidget:onLoaded(...)
self:bindComponents()
self.notifyFunc=function(jctjSubType)
self:refreshReddot()
end
notifySystem:listenNotify(notifyConfig.onJctjReddotChange,self.notifyFunc)

self.onJctjProgressChange=function()
self:refreshProgress()
end
self:addNotify(notifyConfig.onJctjProgressChange,self.onJctjProgressChange)
end


function jctjSysWidget:__delete()
self:doPunchRotation(false)
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onJctjReddotChange,self.notifyFunc)
end




function jctjSysWidget:onShow(argtable,afterOnloaded)
local sysType=argtable.sysType
self.parent=argtable.parent
self.sysType=sysType
self.road:setChildUIModelShowTarget(spName,1,{},eAnimationID.stand,false,false,0.6,nil)
self:refreshProgress(0.5)





self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5,nil)

self:setWidgetPosition(argtable.pos)

self:refreshReddot()

self.click:setChildNewBieComponentId(FMT.fmt('jctjSysWidget_{0}',sysType))
end

function jctjSysWidget:refreshProgress(enterDeday)
local sysType=self.sysType
local config=cfgHelper.get(cfg_jctjsysconfig_get,sysType)
local unlock=JiuChongTianJieEnterModel:getSysConditon(sysType)
local isShield=JiuChongTianJieEnterModel:isShield(sysType)
if unlock then
self.road:setChildModelAnimationState(eAnimationID.stand2,1,nil)
self.frame:setActive(true)
if enterDeday then
self:delayDo(enterDeday,function()
self.effect:setChildShowEffect(efectId[2],true)
end)
else
self.effect:setChildShowEffect(efectId[2],true)
end


self.frame:setCSImageSprite(abName,config.titleImg)
self.icon:setCSImageSprite(abName,config.icon)
local progress,max=JiuChongTianJieEnterModel:getProgressCount(sysType)
self.finish:setActive(progress==max)
if progress==max then
self.progress:setActive(false)
else
self.progress:setActive(true)
self.progress:setProgress(progress,max)
self.progress:setChildProgressText(FMT.fmt("{0}/{1}",progress,max))
end
self.cond:setActive(false)
else
self.road:setChildModelAnimationState(eAnimationID.stand,1,nil)
if enterDeday then
self:delayDo(enterDeday,function()
self.effect:setChildShowEffect(efectId[1],true)
end)
else
self.effect:setChildShowEffect(efectId[1],true)
end

self.progress:setActive(false)
self.finish:setActive(false)
if isShield then
self.icon:setCSImageSprite(abName,lockIcon)
self.frame:setActive(false)
self.cond:setText('')
else
self.frame:setActive(true)
self.frame:setCSImageSprite(abName,config.titleImg)
self.icon:setCSImageSprite(abName,config.icon)
self.cond:setActive(true)
local condText=JiuChongTianJieEnterModel:getConditonTxt(sysType)
self.cond:setText(condText)
end
end
end

function jctjSysWidget:setWidgetPosition(pos)
self.root:setChildAnchoredPosition(Vector2.New(pos[1],pos[2]))
self.scaleRoot:setScale(Vector2.New(pos[3],pos[3]))
end

function jctjSysWidget:setWidgetDoPosition(objPos,dur)
self.root:setChildDOAnchorPos(Vector2(objPos[1],objPos[2]),dur,nil)
self.scaleRoot:setChildDOScale(objPos[3],dur,nil)
end

function jctjSysWidget:setRootActive(show)
self.root:setActive(show)
end


function jctjSysWidget:onHide()


end

function jctjSysWidget:onIcon()
local unlock=JiuChongTianJieEnterModel:getSysConditon(self.sysType)
if not unlock then
local isShield=JiuChongTianJieEnterModel:isShield(self.sysType)
if isShield then
if self.sysType==JIUCHONGTIANJIE_SYS_TYPE.eZhuXianTai then
UIManager.error("请师尊斩断尘缘后再行查看")
else
UIManager.error("敬请期待")
end
else
local condText=JiuChongTianJieEnterModel:getConditonTxt(self.sysType)
UIManager.error(condText)
end
return
end


self.parent:focusObj(self.root:getChildAnchoredPosition(),function()
if self.parent and not self.parent.isClose then
self.parent:showWindow("UIJiuChongTianJieSubWin",{sysType=self.sysType})
end
end)
end

function jctjSysWidget:refreshReddot()
local reddot=JiuChongTianJieEnterModel:getReddot(self.sysType)
self.reddot:setActive(reddot)
self:doPunchRotation(reddot)
end

function jctjSysWidget:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self:setChildRotation(self.reddot:getID(),0,0,0)
local tweener=self:setChildDOPunchRotation(self.reddot:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener;
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self:setChildRotation(self.reddot:getID(),0,0,0)
end
end
end

function jctjSysWidget:onClick()
self:onIcon()
end


