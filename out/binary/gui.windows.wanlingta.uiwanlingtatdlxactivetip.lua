







def_class("UIWanLingTaTDLXActiveTip",UIWindowBase)









function UIWanLingTaTDLXActiveTip:bindComponents()

self.activeBtn=UIButton.get(self,0)
self.activePanel=UIObject.get(self,1)
self.activeReddot=UIObject.get(self,2)
self.activeRewardPanel=UIObject.get(self,3)
self.activeText=UIText.get(self,4)
self.activeTitle=UIText.get(self,5)
self.attrPanel=UIObject.get(self,6)
self.baseAttrPanel=UIObject.get(self,7)
self.colorFrame=UIImage.get(self,8)
self.costItem_1=UIObject.get(self,9)
self.costItem_2=UIObject.get(self,10)
self.costItem_3=UIObject.get(self,11)
self.costTitle=UIText.get(self,12)
self.desc=UIText.get(self,13)
self.descPanel=UIObject.get(self,14)
self.effect=UIObject.get(self,15)
self.effectIcon=UIImage.get(self,16)
self.gain=UIText.get(self,17)
self.icon=UIImage.get(self,18)
self.mask=UIButton.get(self,19)
self.name=UIText.get(self,20)
self.reward_1=UIObject.get(self,21)
self.reward_2=UIObject.get(self,22)
self.root=UIObject.get(self,23)
self.speAttrPanel=UIObject.get(self,24)

self.activeBtn:setButtonClick(function()self:onActiveBtn()end)

self.mask:setButtonClick(function()self:onMask()end)
self.costItem={
self.costItem_1,
self.costItem_2,
self.costItem_3,
}
self.reward={
self.reward_1,
self.reward_2,
}



end


function UIWanLingTaTDLXActiveTip:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activeBtn);self.activeBtn=nil;
_UIObject_release(self.activePanel);self.activePanel=nil;
_UIObject_release(self.activeReddot);self.activeReddot=nil;
_UIObject_release(self.activeRewardPanel);self.activeRewardPanel=nil;
_UIObject_release(self.activeText);self.activeText=nil;
_UIObject_release(self.activeTitle);self.activeTitle=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.baseAttrPanel);self.baseAttrPanel=nil;
_UIObject_release(self.colorFrame);self.colorFrame=nil;
_UIObject_release(self.costItem_1);self.costItem_1=nil;
_UIObject_release(self.costItem_2);self.costItem_2=nil;
_UIObject_release(self.costItem_3);self.costItem_3=nil;
_UIObject_release(self.costTitle);self.costTitle=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.descPanel);self.descPanel=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effectIcon);self.effectIcon=nil;
_UIObject_release(self.gain);self.gain=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.reward_1);self.reward_1=nil;
_UIObject_release(self.reward_2);self.reward_2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.speAttrPanel);self.speAttrPanel=nil;
self.costItem=nil;
self.reward=nil;
end


















local abName="ui/windows/wanlingta/wanlingtaspriteatlas_pak.ab"
local this

function UIWanLingTaTDLXActiveTip:onLoaded(...)
self:bindComponents()
this=self
self:addNotify(notifyConfig.onWanLingTaTuJianChange,self.onWanLingTaTuJianChange)
end


function UIWanLingTaTDLXActiveTip:__delete()
self:unbindComponents()
this=nil
end




function UIWanLingTaTDLXActiveTip:onShow(argtable,afterOnloaded)

self.tj_id=argtable.tj_id
self.tj_conf=wanLingTaModel:getTuJianConfig(self.tj_id)
self.tj_data=wanLingTaModel:getTuJianData(self.tj_id)
self.level=self.tj_data.level
local maxLevel=self.tj_conf.activeUp and#self.tj_conf.activeUp or 1





self:showAttrPanel()
self:showInfoPanel()
if self.level>=maxLevel then
self.activePanel:setActive(false)
else
self.activePanel:setActive(true)
self:showActivePanel()
end
if argtable and argtable.effect then
self.effect:setChildShowEffect(argtable.effect,true)
if argtable.effectSize then
local size=argtable.effectSize
self.effect:setScale(Vector3(size,size,size))
end
end
if argtable and argtable.icon then
self.effectIcon:setChildIcon(argtable.icon,true)
end
end

function UIWanLingTaTDLXActiveTip.onWanLingTaTuJianChange(tjId,tjLevel)
this:onShow({tj_id=tjId})
end

function UIWanLingTaTDLXActiveTip:showAttrPanel()

local prop=self.tj_conf.prop
local level=self.level<=0 and 0 or self.level
local attrLookup=prop[level]or{}
local nextAttrLookup=prop[level+1]or attrLookup
local attrList={}
for attrKey,attrVal in pairs(nextAttrLookup)do
table.insert(attrList,{attrKey,attrLookup[attrKey]or 0,attrVal})
end
self.baseAttrPanel:setChildLayoutGroupCreateItems(#attrList,function(index)
local baseAttrItem=self.baseAttrPanel:getChildLayoutGroupGridItem(index-1)
local attrs=attrList[index]
local attrType=attrs[1]
local attrValue=attrs[2]
local nextVal=attrs[3]
local attrStr=helper.getAttributeStr(attrType,attrValue,2,"{0}：{1}")
baseAttrItem:SetChildText(0,attrStr)
baseAttrItem:SetChildActive(1,nextVal>attrValue)
if nextVal>attrValue then
local diffVal=nextVal-attrValue
baseAttrItem:SetChildText(1,string.format("(+%d)",diffVal))
end
end)

local propRewardsDesc=self.tj_conf.propRewardsDesc and(self.tj_conf.propRewardsDesc[level]or defaultT)or defaultT
local next=propRewardsDesc.next or{}
self.speAttrPanel:setChildLayoutGroupCreateItems(#propRewardsDesc,function(index)
local speAttrItem=self.speAttrPanel:getChildLayoutGroupGridItem(index-1)
local desc=propRewardsDesc[index]
local nextVal=next[index]
speAttrItem:SetChildText(0,desc)
speAttrItem:SetChildActive(1,nextVal~=nil)
if nextVal~=nil then
speAttrItem:SetChildText(1,string.format("(%s)",nextVal))
end
end)
end

function UIWanLingTaTDLXActiveTip:showInfoPanel()
local color=self.tj_conf.color
local iconName=self.tj_conf.icon
local itemName=self.tj_conf.name
local isActive=self.level>0
local name=isActive and string.format("%s %d级",itemName,self.level)or itemName

self.colorFrame:setSprite(abName,string.format("image_wanlingtapz_%d",color))

self.icon:setChildIcon(iconName,true)

self.name:setText(FMT.cfmt(color,isActive and name or"未收集"))

self.desc:setText(self.tj_conf.desc)







end

function UIWanLingTaTDLXActiveTip:showActivePanel()
local level=self.level
local nextLevel=level+1
self.activeTitle:setText(level>0 and"升级奖励"or"激活奖励")
self.costTitle:setText(level>0 and"升级消耗"or"激活消耗")
self.activeText:setText(level>0 and"升级"or"激活")
local rewards=self.tj_conf.rewards[nextLevel]
if rewards then
self.activeRewardPanel:setActive(true)
for i,v in ipairs(self.reward)do
local reward=rewards[i]
if reward then
v:setActive(true)
local widget=v:getWidgetBase()
local itemid,itemnum=unpack(reward)
widget:SetChildIcon(0,iconHelper.getIconName(itemid),true)
widget:SetChildText(1,itemnum)
else
v:setActive(false)
end
end
else
self.activeRewardPanel:setActive(false)
end














local costItemList=self.tj_conf.activeUp[nextLevel]
self.costItemList=costItemList
for i,v in ipairs(self.costItem)do
local costItem=costItemList[i]
if costItem then
v:setActive(true)
local widget=v:getWidgetBase()
local itemid,neednum=unpack(costItem)
local itemnum=itemsModel.getCount(itemid)
local countStr=''
local conf={itemid=itemid,itemcount=countStr,showCountBG=false,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetBaseItemClickEvent(0,function(...)
tipsManager.showTips({tipsType=TIPS_TYPE.eTDLXMaterial,itemid=itemid})
end)
widget:SetChildPropData(0,prop)
widget:SetChildText(1,string.format("<color=#%s>%d</color>/%d",itemnum>=neednum and"549327"or"c82c2c",itemnum,neednum))
else
v:setActive(false)
end
end

local reddot=wanLingTaModel:checkTuJianReddot(self.tj_id)
self.activeReddot:setActive(reddot)
end


function UIWanLingTaTDLXActiveTip:showPosition(item,move_pos,layerName,order)
local id=_luaHelper.SortingLayerNameToID(layerName)
item:SetChildCanvas(-1,id,order)

local screenPoint=item:GetChildUIScreenPos(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.root:getTransform()
local selfSize=selfTrans.sizeDelta

local itemOffx=0
local itemOffy=0
local offsetX=0
local offsetY=0
move_pos=move_pos or'bottom'

if move_pos=='bottom'or move_pos=='top'then
if itemPivot.x~=0.5 then
itemOffx=itemPivot.x==0 and itemSize.x/2 or-itemSize.x/2
end
offsetX=itemOffx
elseif move_pos=='left'or move_pos=='right'then
if itemPivot.y~=0.5 then
itemOffy=itemPivot.y==0 and itemSize.y/2 or-itemSize.y/2
end
offsetY=itemOffy
end

if move_pos=='bottom'then
if itemPivot.y~=0 then
itemOffy=-itemSize.y
end
offsetY=-selfSize.y/2+itemOffy
elseif move_pos=='top'then
if itemPivot.y~=1 then
itemOffy=itemSize.y
end
offsetY=selfSize.y/2+itemOffy
elseif move_pos=='left'then
if itemPivot.x~=0 then
itemOffx=-itemSize.x
end
offsetX=-selfSize.x/2+1.5*itemOffx
elseif move_pos=='right'then
if itemPivot.x~=1 then
itemOffx=itemSize.x
end
offsetX=selfSize.x/2+1.5*itemOffx
end

local rootPosX=screenPoint.x+offsetX
local rootPosY=screenPoint.y+offsetY

self.winlua:SetChildUIScreenPos(self.root:getID(),Vector2.New(rootPosX,rootPosY))
end

function UIWanLingTaTDLXActiveTip:onActiveBtn()
local itemList={}
for i,v in ipairs(self.costItemList)do
local costItemId,costNum=unpack(v)





local check=function(item)
return item.itemcount>=costNum
end
local _,costItemGuid=bagControl.invokeFuncByItemId(costItemId,'getItemWithCheckFuncByItemID',costItemId,check)
if not costItemGuid then
gainControl:showGainWin(costItemId)
return
end
table.insert(itemList,{costItemGuid,costNum})
end
if self.level<=0 then
wanLingTaController.send_43_3(self.tj_id,#itemList,itemList)
else
wanLingTaController.send_43_4(self.tj_id,#itemList,itemList)
end
end

function UIWanLingTaTDLXActiveTip:onMask()
self:closeSelf()
end