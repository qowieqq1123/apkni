







def_class("UIYCTBTEffectWin",UIWindowBase)









function UIYCTBTEffectWin:bindComponents()

self.root=UIObject.get(self,0)
self.effectpanel=UIObject.get(self,1)
self.daojuitems=UIObject.get(self,2)
self.itemspoint=UIObject.get(self,3)
self.spine_join=UIObject.get(self,4)
self.spine_flyjoin=UIObject.get(self,5)
self.jiachepos=UIObject.get(self,6)
self.jiachepo2=UIObject.get(self,7)
self.spine={
["join"]=self.spine_join,
["flyjoin"]=self.spine_flyjoin,
}



end


function UIYCTBTEffectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.effectpanel);self.effectpanel=nil;
_UIObject_release(self.daojuitems);self.daojuitems=nil;
_UIObject_release(self.itemspoint);self.itemspoint=nil;
_UIObject_release(self.spine_join);self.spine_join=nil;
_UIObject_release(self.spine_flyjoin);self.spine_flyjoin=nil;
_UIObject_release(self.jiachepos);self.jiachepos=nil;
_UIObject_release(self.jiachepo2);self.jiachepo2=nil;
self.spine=nil;
end



















function UIYCTBTEffectWin:onLoaded(...)
self:bindComponents()
end


function UIYCTBTEffectWin:__delete()
self:unbindComponents()
end




function UIYCTBTEffectWin:onShow(argtable,afterOnloaded)






if argtable then
local centerPostion=self.itemspoint:getChildPosition()
self.actID=argtable[1]
self.subType=argtable[2]
self.subid=argtable[3]
self.pos=argtable[4]
self.desc=argtable[5]
self.itemid=argtable[6]
self.isstatechange=argtable[7]
self.data=argtable[8]
self.parentwin=argtable[9]

if self.pos then
self.daojuitems:setChildCanvasGroupAlpha(0)
self.daojuitems:setChildPosition(self.pos)
self.spine_join:setChildShowEffect(10352,true)

local item=self.daojuitems:getChildWidgetBase()
local itemcfg=itemsConfig.getConfig(self.itemid)
item:SetChildIcon(1,iconHelper.getItemIconName(itemcfg.icon),false)
item:SetChildText(2,FMT.fmt('<color=#161A14>{0}</color>',self.desc))

self.daojuitems:setChildCanvasGroupDOFade(1,0.2)

self.daojuitems:setActive(true)

self:delayDo(0.3,function()
local tweener=self.winlua:SetChildDOMove(self.daojuitems:getID(),centerPostion,0.5)
self.winlua:SetChildDOScale(self.daojuitems:getID(),1.3,0.5,nil)
self.tweener=tweener
tweener:SetEase(_Ease.Linear)
tweener:OnComplete(function()

if self.isstatechange then
self.daojuitems:setChildCanvasGroupDOFade(0,0.7)

self.spine_join:setChildShowEffect(10350,true)
self:delayDo(0.8,function()
self.spine_flyjoin:setChildShowEffect(10571,true)
self.spine_flyjoin:setChildDOMove(self.jiachepo2:getChildPosition(),0.8,function()
if self then
self.jiachepos:setChildShowEffect(10572,true)
end
end)
end)
self:delayDo(1.5,function()
local json_str=jsonHelper.encode(self.data)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end)
self:delayDo(2.1,function()
local mydata=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local effect_list=mydata.effect_list
if effect_list and#effect_list>0 then
if self.parentwin then
self.parentwin:showWindow('UIYCTBTipsWin',{effect_list,self.actID,self.subType,self.subid})
end
end
self:closeSelf()
end)
else
self.daojuitems:setChildCanvasGroupDOFade(0,0.7)
self.spine_join:setChildShowEffect(10350,true)
self:delayDo(1,function()
local _actID=self.actID
local _subType=self.subType
local _subid=self.subid
local _data=self.data
local startCallback=function()
local json_str=jsonHelper.encode(_data)
activitiesController:sendProtocol(actSendType.eComonReqHandle,_actID,_subType,_subid,json_str)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
if self.itemid==10592 then
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback,})
else
local json_str=jsonHelper.encode(self.data)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end
end)
self:delayDo(1.6,function()
self:closeSelf()
end)
end
self.tweener=nil
end)
end)
end

else
UIManager.error('使用道具失败')
self:closeSelf()
end
end


function UIYCTBTEffectWin:onHide()

end




function UIYCTBTEffectWin:cannotbtn()

end
