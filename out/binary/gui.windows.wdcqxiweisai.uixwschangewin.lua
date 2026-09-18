







def_class("UIXWSChangeWin",UIWindowBase)









function UIXWSChangeWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.headIocn=UIObject.get(self,1)
self.itemBg=UIImage.get(self,2)
self.noPos=UIText.get(self,3)
self.playerfight=UIText.get(self,4)
self.playername=UIText.get(self,5)
self.pos=UIText.get(self,6)
self.rank=UIText.get(self,7)
self.root=UIObject.get(self,8)
self.todayNoTip=UIToggleButton.get(self,9)



end


function UIXWSChangeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.headIocn);self.headIocn=nil;
_UIObject_release(self.itemBg);self.itemBg=nil;
_UIObject_release(self.noPos);self.noPos=nil;
_UIObject_release(self.playerfight);self.playerfight=nil;
_UIObject_release(self.playername);self.playername=nil;
_UIObject_release(self.pos);self.pos=nil;
_UIObject_release(self.rank);self.rank=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.todayNoTip);self.todayNoTip=nil;
end



















function UIXWSChangeWin:onLoaded(...)
self:bindComponents()
self.todayNoTip:setToggle(false)
self.todayNoTip:setToggleChange(function(name,isOn)
XiWeiSaiController:saveChangeWinShowTime(isOn)
end)
self.bgModel:setChildUIModelShowTarget(5643,1,nil,eAnimationID.enter,false,false,0,function()end)
self:delayDo(0.4,function()
self.root:setChildCanvasGroupDOFade(1,0.5,function()end)
end)
end


function UIXWSChangeWin:__delete()
self:unbindComponents()
end




function UIXWSChangeWin:onShow(argtable,afterOnloaded)
local pos=argtable.pos
local logTime=argtable.logTime
XiWeiSaiController:saveChangeWinShowLogTime(logTime)
local fight=XiWeiSaiController.getDefendTeamFight()
local name=playerModel:getActorName()
local iconInfo=playerModel:getActorIconInfo()
local abName=XiWeiSaiModel:getConfig_abName()

if pos==0 then
self.noPos:setActive(true)
self.pos:setActive(false)
self.rank:setActive(false)
self.itemBg:setCSImageSprite(abName,"image_xizuosaiui_8")
else
self.noPos:setActive(false)
self.pos:setActive(true)
self.rank:setActive(true)
self.pos:setText(pos)
self.rank:setText(pos)
local bgName={
"image_xizuosaiui_3",
"image_xizuosaiui_2",
"image_xizuosaiui_1"
}
self.itemBg:setCSImageSprite(abName,bgName[pos]or"image_xizuosaiui_0")
end
self.playername:setText(name)
self.playerfight:setText(mathHelper.formatNumber3(fight))
playerController:setHeadIcon(self.winlua,self.headIocn:getID(),{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
end


function UIXWSChangeWin:onHide()

end



function UIXWSChangeWin:onCloseClick()
self:closeSelf()
end
