







def_class("UIXianJie_ZMttackerWin",UIWindowBase)









function UIXianJie_ZMttackerWin:bindComponents()

self.btnConfirm=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.damage=UIObject.get(self,2)
self.contenroot=UIObject.get(self,3)
self.bgModel=UIObject.get(self,4)
self.toggleTip=UIToggleButton.get(self,5)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)



end


function UIXianJie_ZMttackerWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.damage);self.damage=nil;
_UIObject_release(self.contenroot);self.contenroot=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.toggleTip);self.toggleTip=nil;
end


















local bgModelIDList={
[ATTACKTYPE.eXJActor]=5748,
[ATTACKTYPE.eMJActor]=5748,
[ATTACKTYPE.eMoZong]=5748,
[ATTACKTYPE.eMoJun]=5748,
[ATTACKTYPE.eMJActor_dazhen]=5748,
[ATTACKTYPE.eZhenYan]=5748,
}

function UIXianJie_ZMttackerWin:onLoaded(...)
self:bindComponents()
end

function UIXianJie_ZMttackerWin:__delete()
self:unbindComponents()
end

function UIXianJie_ZMttackerWin:onShow(argtable,afterOnloaded)
local isNotify=false
if argtable then
isNotify=argtable.notifyAttack or false
self.attackType=argtable.attackType
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZMAttacktip)
if flag then
isNotify=false
end
local isMojun=self.attackType==ATTACKTYPE.eMoJun
self.root:setActive(isNotify and not isMojun)
if isNotify then
self.bgModel:setChildUIModelShowTarget(bgModelIDList[self.attackType],1,nil,eAnimationID.enter,false,false,0,function()end)
self.contenroot:setChildDOScale(1,0.4)



end

self.toggleTip:setToggle(flag==true)
self.toggleTip:setToggleChange(function(name,isOn)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZMAttacktip,isOn)
end)
end

function UIXianJie_ZMttackerWin:onHide()

end




function UIXianJie_ZMttackerWin:onBtnConfirm()
self.root:setActive(false)
if self.attackType~=ATTACKTYPE.eXJActor then
local tabType=xianjieModel:getFirstTabType()
jumpManager:jump({id=JUMP_TYPE.eXianJieAttackerWin,args={mapid=xjJumpSceneType.eMoJie,tabType=tabType}})
else
jumpManager:jump({id=JUMP_TYPE.eXianJieAttackerWin,args={mapid=xjJumpSceneType.eSelfZMPos}})
end

end

function UIXianJie_ZMttackerWin:closeSelf()
self.root:setActive(false)
self.contenroot:setScale(Vector3.zero)
end
