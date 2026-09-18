







def_class("UIXinFaBranchWin",UIWindowBase)









function UIXinFaBranchWin:bindComponents()

self.btnText=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.costItem_1=UIObject.get(self,2)
self.costItem_2=UIObject.get(self,3)
self.costItem_3=UIObject.get(self,4)
self.costItemList=UIObject.get(self,5)
self.fullTips=UIObject.get(self,6)
self.mask=UIButton.get(self,7)
self.skillContent=UIObject.get(self,8)
self.skillScrollView=UIObject.get(self,9)
self.upLevelBtn=UIButton.get(self,10)
self.upLevelPanel=UIObject.get(self,11)
self.xinFaDesc=UIText.get(self,12)
self.xinFaName=UIText.get(self,13)
self.xinFaSkillIcon=UIImage.get(self,14)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.upLevelBtn:setButtonClick(function()self:onUpLevelBtn()end)
self.costItem={
self.costItem_1,
self.costItem_2,
self.costItem_3,
}



end


function UIXinFaBranchWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnText);self.btnText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costItem_1);self.costItem_1=nil;
_UIObject_release(self.costItem_2);self.costItem_2=nil;
_UIObject_release(self.costItem_3);self.costItem_3=nil;
_UIObject_release(self.costItemList);self.costItemList=nil;
_UIObject_release(self.fullTips);self.fullTips=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.skillContent);self.skillContent=nil;
_UIObject_release(self.skillScrollView);self.skillScrollView=nil;
_UIObject_release(self.upLevelBtn);self.upLevelBtn=nil;
_UIObject_release(self.upLevelPanel);self.upLevelPanel=nil;
_UIObject_release(self.xinFaDesc);self.xinFaDesc=nil;
_UIObject_release(self.xinFaName);self.xinFaName=nil;
_UIObject_release(self.xinFaSkillIcon);self.xinFaSkillIcon=nil;
self.costItem=nil;
end



















function UIXinFaBranchWin:onLoaded(...)
self:bindComponents()
end


function UIXinFaBranchWin:__delete()
self:unbindComponents()
end




function UIXinFaBranchWin:onShow(argtable,afterOnloaded)
self.type,self.stage,self.id,self.isHideActive=unpack(argtable)
self.cfg=cfgHelper.get1(cfg_disciplexinfabranchconfig_get,self.id)
self:refreshAllPanel()
end

function UIXinFaBranchWin:refreshAllPanel()
self.xinFaName:setText(self.cfg.name)
self.xinFaDesc:setText(self.cfg.desc)
self.xinFaSkillIcon:setChildIcon(self.cfg.icon,false)
self:refreshSkillScrollViewPanel()
if not self.isHideActive then
self:refreshUpLevelPanel()
else
self.upLevelPanel:setActive(false)
self.skillScrollView:setChildSizeDelta(350,430)
end
end

function UIXinFaBranchWin:upLevelCallBack()
self:refreshSkillScrollViewPanel()
if not self.isHideActive then
self:refreshUpLevelPanel()
end
end

function UIXinFaBranchWin:refreshUpLevelPanel()
local lv=UIDiscipleModel:getXinFaBranchLevel(self.id)
local maxLevel=math.min((#self.cfg.level_consume+1),#self.cfg.effect_client)
if lv<maxLevel then
self.fullTips:setActive(false)
self.upLevelBtn:setActive(true)
self.costItemList:setActive(true)

local itemList=self.cfg.level_consume[lv]
for i,v in ipairs(self.costItem)do
local items=itemList[i]
if items then
local widget=self.winlua:GetChildWidgetBase(v:getID())
local itemId,needNum=unpack(items)
local itemNum=itemsModel.getCount(itemId)
local countStr=string.format(itemNum>=needNum and"<color=#549327>%s</color>/%d"or"<color=#c82c2c>%s</color>/%d",mathHelper.formatNumber(itemNum),needNum)
local conf={itemid=itemId,itemcount='',showCountBG=false,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
widget:SetChildPropData(0,prop)
widget:SetChildText(1,countStr)
else
v:setActive(false)
end
end
self.btnText:setText(lv<=0 and'激活'or'升级')
else
self.fullTips:setActive(true)
self.upLevelBtn:setActive(false)
self.costItemList:setActive(false)
end
end

function UIXinFaBranchWin:refreshSkillScrollViewPanel()
local lv=UIDiscipleModel:getXinFaBranchLevel(self.id)
local stageStr=string.format("%s阶",mathHelper.numberToChinese(self.stage))
local typeStr=self.type==1 and'仙术'or'魔功'

self.skillContent:setChildLayoutGroupCreateItems(#self.cfg.effect_client,function(index)
local item=self.skillContent:getChildLayoutGroupGridItem(index-1)

item:SetChildText(0,string.format("%s-%d级",self.cfg.name,index))

local effectList=self.cfg.effect_client[index]
local isActived=lv>=index
item:SetChildLayoutGroupCreateItems(1,#effectList,function(idx)
local skllItem=item:GetChildLayoutGroupGridItem(1,idx-1)
local effect=effectList[idx]
local str=nil
if effect[1]==1 then
local attrs=effect[2]
for i,v in ipairs(attrs)do
local attrInfo=helper.getAttributeStr(v[1],v[2],1,isActived and"<color=#549327>{0}+{1}</color>"or"{0}+{1}")
str=str==nil and attrInfo or string.format("%s、%s",str,attrInfo)
end
elseif effect[1]==2 then
local attrKey,percent=effect[2],effect[3]
local attrName=helper.getAttributeName(attrKey)
str=FMT.fmt("<color={0}>{3}{4}道行{1}属性提升{2}%</color>",isActived and"#549327"or"#8E8C87",attrName,mathHelper.decimal(percent/100),stageStr,typeStr)
elseif effect[1]==3 then
local type,percent=effect[2],effect[3]
str=FMT.fmt("<color={0}>{1}属性提升{2}%</color>",isActived and"#549327"or"#8E8C87",type==1 and"境界"or"炼体",mathHelper.decimal(percent/100))
end
skllItem:SetChildText(0,str)
end)
end)
end

function UIXinFaBranchWin:onCloseBtn()
self:closeSelf()
end

function UIXinFaBranchWin:onMask()
self:closeSelf()
end

function UIXinFaBranchWin:onUpLevelBtn()
local lv=UIDiscipleModel:getXinFaBranchLevel(self.id)
local itemList=self.cfg.level_consume[lv]
for i,v in ipairs(itemList)do
local itemId,needNum=v[1],v[2]
local itemNum=itemsModel.getCount(itemId)
if itemNum<needNum then
UIManager.error(string.format("%s不足",itemsModel.getName(itemId)))
gainControl:showGainWin(itemId)
return
end
end
UIDiscipleController:reqXinFaBranchLevelUp(self.type,self.stage,self.id)
end