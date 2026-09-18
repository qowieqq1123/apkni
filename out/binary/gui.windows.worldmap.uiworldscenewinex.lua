







def_class("UIWorldSceneWinEx",UIWindowBase)









function UIWorldSceneWinEx:bindComponents()

self.TitleName=UIText.get(self,0)
self.ButtonClose=UIButton.get(self,1)
self.Map=UIImage.get(self,2)
self.Content=UIObject.get(self,3)
self.Mask=UIObject.get(self,4)

self.ButtonClose:setButtonClick(function()self:onButtonClose()end)



end


function UIWorldSceneWinEx:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.TitleName);self.TitleName=nil;
_UIObject_release(self.ButtonClose);self.ButtonClose=nil;
_UIObject_release(self.Map);self.Map=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.Mask);self.Mask=nil;
end
















local _this=nil
local mapItemCmp={
owner=0,
icon=1,
attach=2,
}
local iconName={
"icon_sjbiaoshi_1",
"icon_sjbiaoshi_2",
"icon_sjbiaoshi_3",
}



function UIWorldSceneWinEx:onLoaded(...)
self:bindComponents()
_this=self
self:showWindow("UITopMaskWin")
end


function UIWorldSceneWinEx:__delete()
worldController:releaseCloudMask()
self:unbindComponents()
_this=nil
self:stopTimerByName('closeTimer')
end




function UIWorldSceneWinEx:onShow(argtable,afterOnloaded)





self.callback=argtable.callback
self.world=argtable.world
self.list=argtable.list
self.openType=argtable.openType
self.worldCfg=cfgHelper.get1(cfg_worldconfig_get,self.world)
self.mapCfg=cfgHelper.get1(cfg_worldscenemapconfig_get,self.worldCfg.sceneMap)
self.TitleName:setText(self.worldCfg.name)
self.Map:setSprite(self.mapCfg.res[1],self.mapCfg.res[2])
self.Map:setScale(Vector3.one*self.mapCfg.uiScale)
self.Map:setChildAnchoredPosition(mathHelper.convertArrayToVector(self.mapCfg.mapAnchoredPos))
local maskInfo=self.mapCfg.maskParams
local clouds=worldBlockModel:getMasks(self.world)
self.winlua:SetChildCSImageMatTextureEx(self.Map:getID(),"_ControlTex",maskInfo,clouds)
self.winlua:SetChildCSImageMatVector(self.Map:getID(),"_CtrOffset",worldSceneMapModel:getMaskUVRect(self.world))
self.Mask:setChildLayoutGroupCreateItems(#self.list,self.refreshMapItem)

if self.openType==1 then
self.clickLock=true
local func=function()
if _this==nil then return end
_this.clickLock=false
end
self:delayDo(2,func)
self:startCloseTimer(7)
end
end


function UIWorldSceneWinEx:onHide()

end

function UIWorldSceneWinEx:startCloseTimer(time)
self.time=time or 0
local func=function(...)
self.time=self.time-1
if self.time<=0 then
self:stopTimerByName('closeTimer')
self.clickLock=false
self:onButtonClose()
end
end
self.closeTimer=self:setTimer(1,time,func)
end





function UIWorldSceneWinEx:onButtonClose()
if self.clickLock then return end
local cb=self.callback
self:closeSelf()
if cb then
cb()
end
end

function UIWorldSceneWinEx.refreshMapItem(index)
if _this==nil then return end
local item=_this.winlua:GetChildLayoutGroupGridItem(_this.Mask:getID(),index-1)
local data=_this.list[index]
local x=data.x
local y=data.y
local iconTpye=data.icon
local anchoredPos=worldSceneMapModel:changePosition(x,y,_this.world)
item:SetChildAnchoredPosition(mapItemCmp.owner,anchoredPos)
item:SetChildCSImageIcon(mapItemCmp.icon,iconName[iconTpye],true)
if _this.openType==1 then
item:SetChildScale(-1,Vector3(0,0,0))
_this:delayDo(0.7,function(...)
local t=item:SetChildDOScale(-1,1,0.8)
t:SetEase(DG.Tweening.Ease.OutElastic)
end)
end
end

