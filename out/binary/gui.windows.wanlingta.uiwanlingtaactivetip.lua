







def_class("UIWanLingTaActiveTip",UIWindowBase)









function UIWanLingTaActiveTip:bindComponents()

self.activeBtn=UIButton.get(self,0)
self.activePanel=UIObject.get(self,1)
self.activeReddot=UIObject.get(self,2)
self.activeRewardPanel=UIObject.get(self,3)
self.activeText=UIText.get(self,4)
self.activeTitle=UIText.get(self,5)
self.colorFrame=UIImage.get(self,6)
self.costItem_1=UIObject.get(self,7)
self.costItem_2=UIObject.get(self,8)
self.costItem_3=UIObject.get(self,9)
self.costTitle=UIText.get(self,10)
self.desc=UIText.get(self,11)
self.descPanel=UIObject.get(self,12)
self.effect=UIObject.get(self,13)
self.effectIcon=UIImage.get(self,14)
self.gain=UIText.get(self,15)
self.icon=UIImage.get(self,16)
self.mask=UIButton.get(self,17)
self.name=UIText.get(self,18)
self.reward_1=UIObject.get(self,19)
self.reward_2=UIObject.get(self,20)
self.reward_3=UIObject.get(self,21)
self.reward_4=UIObject.get(self,22)
self.root=UIObject.get(self,23)

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
self.reward_3,
self.reward_4,
}



end


function UIWanLingTaActiveTip:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activeBtn);self.activeBtn=nil;
_UIObject_release(self.activePanel);self.activePanel=nil;
_UIObject_release(self.activeReddot);self.activeReddot=nil;
_UIObject_release(self.activeRewardPanel);self.activeRewardPanel=nil;
_UIObject_release(self.activeText);self.activeText=nil;
_UIObject_release(self.activeTitle);self.activeTitle=nil;
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
_UIObject_release(self.reward_3);self.reward_3=nil;
_UIObject_release(self.reward_4);self.reward_4=nil;
_UIObject_release(self.root);self.root=nil;
self.costItem=nil;
self.reward=nil;
end


















local abName="ui/windows/wanlingta/wanlingtaspriteatlas_pak.ab"
local this

function UIWanLingTaActiveTip:onLoaded(...)
self:bindComponents()
this=self
self:addNotify(notifyConfig.onWanLingTaTuJianChange,self.onWanLingTaTuJianChange)
end


function UIWanLingTaActiveTip:__delete()
self:unbindComponents()
this=nil
end




function UIWanLingTaActiveTip:onShow(argtable,afterOnloaded)

self.tj_id=argtable.tj_id
self.tj_conf=wanLingTaModel:getTuJianConfig(self.tj_id)
self.tj_data=wanLingTaModel:getTuJianData(self.tj_id)
self.level=self.tj_data.level
local maxLevel=self.tj_conf.activeUp and#self.tj_conf.activeUp or 1






self:showInfoPanel()
if self.level>=maxLevel then
self.activePanel:setActive(false)
else
self.activePanel:setActive(true)
self:showActivePanel()
end
if argtable and argtable.effect then
self.effect:setChildShowEffect(argtable.effect,true)
end
if argtable and argtable.icon then
self.effectIcon:setChildIcon(argtable.icon,true)
end
end

function UIWanLingTaActiveTip.onWanLingTaTuJianChange(tjId,tjLevel)
this:onShow({tj_id=tjId})
end

function UIWanLingTaActiveTip:showInfoPanel()
local color=self.tj_conf.color
local iconName=self.tj_conf.icon
local itemName=self.tj_conf.name
local isActive=self.level>0
local name=isActive and string.format("%s %d级",itemName,self.level)or itemName

self.colorFrame:setSprite(abName,string.format("image_wanlingtapz_%d",color))

self.icon:setChildIcon(iconName,true)

self.name:setText(FMT.cfmt(color,isActive and name or"未收集"))

self.desc:setText(isActive and self.tj_conf.desc or"激活后解锁描述")

if self.tj_conf.gain and isActive then
self.gain:setActive(true)
self.gain:setText(string.format("获取途径：%s",self.tj_conf.gain))
else
self.gain:setActive(false)
end
end

function UIWanLingTaActiveTip:showActivePanel()
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
widget:SetChildButtonClick(-1,function()
itemsComponentHelper.onItemClick(itemid)
end)
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
itemsComponentHelper.onItemClick(...)
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


function UIWanLingTaActiveTip:showPosition(item,move_pos,layerName,order)
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

function UIWanLingTaActiveTip:onActiveBtn()
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

function UIWanLingTaActiveTip:onMask()
self:closeSelf()
end