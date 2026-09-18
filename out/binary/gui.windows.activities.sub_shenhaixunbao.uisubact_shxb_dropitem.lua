







def_class("UISubAct_SHXB_dropItem",UICloneObject)





UISubAct_SHXB_dropItem.abName="ui/windows/activities/sub_shenhaixunbao/uisubact_shxb_dropitem.ab"

UISubAct_SHXB_dropItem.assetName="UISubAct_SHXB_dropItem"


function UISubAct_SHXB_dropItem:bindComponents()

self.root=UIObject.get(self,0)
self.model=UIObject.get(self,1)
self.icon_1=UIImage.get(self,2)
self.icon_2=UIImage.get(self,3)
self.icon_3=UIImage.get(self,4)
self.icon_4=UIImage.get(self,5)
self.icon_5=UIImage.get(self,6)
self.icon_6=UIImage.get(self,7)
self.iconRoot_1=UIObject.get(self,8)
self.iconRoot_2=UIObject.get(self,9)
self.iconRoot_3=UIObject.get(self,10)
self.iconRoot_4=UIObject.get(self,11)
self.iconRoot_5=UIObject.get(self,12)
self.iconRoot_6=UIObject.get(self,13)
self.iconRootList=UIObject.get(self,14)
self.icon={
self.icon_1,
self.icon_2,
self.icon_3,
self.icon_4,
self.icon_5,
self.icon_6,
}
self.iconRoot={
self.iconRoot_1,
self.iconRoot_2,
self.iconRoot_3,
self.iconRoot_4,
self.iconRoot_5,
self.iconRoot_6,
}

end


function UISubAct_SHXB_dropItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.icon_1);self.icon_1=nil;
_UIObject_release(self.icon_2);self.icon_2=nil;
_UIObject_release(self.icon_3);self.icon_3=nil;
_UIObject_release(self.icon_4);self.icon_4=nil;
_UIObject_release(self.icon_5);self.icon_5=nil;
_UIObject_release(self.icon_6);self.icon_6=nil;
_UIObject_release(self.iconRoot_1);self.iconRoot_1=nil;
_UIObject_release(self.iconRoot_2);self.iconRoot_2=nil;
_UIObject_release(self.iconRoot_3);self.iconRoot_3=nil;
_UIObject_release(self.iconRoot_4);self.iconRoot_4=nil;
_UIObject_release(self.iconRoot_5);self.iconRoot_5=nil;
_UIObject_release(self.iconRoot_6);self.iconRoot_6=nil;
_UIObject_release(self.iconRootList);self.iconRootList=nil;
self.icon=nil;
self.iconRoot=nil;
end





local animIdList={
[1]=3608,
[2]=3609,
[3]=3610,
[4]=3611,
[5]=3612,
}
local activeIconList={
[1]={[6]=true},
[2]={[2]=true,[3]=true},
[3]={[2]=true,[3]=true,[4]=true},
[4]={[2]=true,[3]=true,[4]=true,[5]=true},
[5]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true},
}




function UISubAct_SHXB_dropItem:onLoaded(...)
self:bindComponents()
end


function UISubAct_SHXB_dropItem:__delete()
if self.sequence then
self.sequence:Kill()
self.sequence=nil
end









for idx,iconRoot in ipairs(self.iconRoot)do
iconRoot:setActive(false)
end
self:unbindComponents()
end




function UISubAct_SHXB_dropItem:onShow(argtable,afterOnloaded)
self.formPos=argtable.formPos
self.toPos=argtable.toPos

self.itemList=argtable.itemList
self.item=argtable.item












self.root:setChildPosition(self.formPos)


local rootTF=self.root:getTransform()


local itemCount=self.itemList and#self.itemList or 0
local animId=animIdList[itemCount]or animIdList[1]
local activeList=activeIconList[itemCount]or activeIconList[1]
local delayTime=1.5
if itemCount<=1 then
delayTime=1
end
self:delayDo(delayTime,function()
local sequence=Lua.SequenceProxy.New()




local deltaX=self.toPos.x-self.formPos.x
local tweenerJump=_DOTweenProxy.DoPath(rootTF,{self.toPos,Vector3(self.formPos.x+deltaX*0.5,self.formPos.y+2,self.formPos.z),self.toPos},1,_pathType.CubicBezier)
tweenerJump:SetEase(_Ease.InSine)

sequence:Append(tweenerJump)
self.sequence=sequence
end)

if itemCount>0 then
local itemIdx=1
for idx,iconRoot in ipairs(self.iconRoot)do
local isActiveRoot=activeList[idx]or false
local item=self.itemList[itemIdx]
local isShowIcon=item and isActiveRoot or false
iconRoot:setActive(isShowIcon)
local icon=self.icon[idx]
if isShowIcon then

itemIdx=itemIdx+1
local itemId=item[1]
local iconName=iconHelper.getIconName(itemId)
icon:setImageIcon(iconName,false)
end
end
end
self.model:setChildSpineAnimation(animId,1,nil)
end


function UISubAct_SHXB_dropItem:onHide()

end


