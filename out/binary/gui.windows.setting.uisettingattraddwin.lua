







def_class("UISettingAttrAddWin",UIWindowBase)









function UISettingAttrAddWin:bindComponents()

self.tipsRoot=UIObject.get(self,0)
self.tipsBtn=UIButton.get(self,1)
self.tips=UIText.get(self,2)
self.mask=UIButton.get(self,3)
self.ScrollView=UIObject.get(self,4)
self.Content=UIObject.get(self,5)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UISettingAttrAddWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Content);self.Content=nil;
end



















function UISettingAttrAddWin:onLoaded(...)
self:bindComponents()
end


function UISettingAttrAddWin:__delete()
self:unbindComponents()
end




function UISettingAttrAddWin:onShow(argtable,afterOnloaded)
local settingType=argtable.settingType
local cfgs=UISettingConfig.getSelfAllCfg(settingType)
local attrList={}
local jzAttrList={}
local allAttrList={}
for _,v in pairs(cfgs)do
local unlock=UISettingModel:checkSettingIdUnlock_Type(settingType,v.id)
local starNum=UISettingModel:getStarNum(settingType,v.id)
local attr=v.attr
if attr and unlock then
for __,v2 in ipairs(attr)do
if attrList[v2[1]]then
attrList[v2[1]]=attrList[v2[1]]+v2[2]
else
attrList[v2[1]]=v2[2]
end
end
if starNum>0 then
local star_attr=v.star_attr[starNum]
for __,v2 in ipairs(star_attr)do
if attrList[v2[1]]then
attrList[v2[1]]=attrList[v2[1]]+v2[2]
else
attrList[v2[1]]=v2[2]
end
end
end
end
local jzattr=v.jzattr
if jzattr and unlock then
for __,v2 in ipairs(jzattr)do
if jzAttrList[v2[1]]then
jzAttrList[v2[1]]=jzAttrList[v2[1]]+v2[2]
else
jzAttrList[v2[1]]=v2[2]
end
end
if starNum>0 then
local star_jzattr=v.star_jzattr[starNum]
for __,v2 in ipairs(star_jzattr)do
if jzAttrList[v2[1]]then
jzAttrList[v2[1]]=jzAttrList[v2[1]]+v2[2]
else
jzAttrList[v2[1]]=v2[2]
end
end
end
end
end
for k,v in pairs(attrList)do
table.insert(allAttrList,{k,v})
end
for k,v in pairs(jzAttrList)do
table.insert(allAttrList,{k,v})
end
if#allAttrList<=0 then
return
end
self.Content:setChildLayoutGroupCreateItems(#allAttrList,function(index)
local item=self.Content:getChildLayoutGroupGridItem(index-1)
local data=allAttrList[index]
local name,value=equipsHelper.getAttr(data[1],data[2])

local valStr=string.format("+%s",value)
item:SetChildText(0,name)
item:SetChildText(1,valStr)
end)
end


function UISettingAttrAddWin:onHide()

end





function UISettingAttrAddWin:onTipsBtn()

end



function UISettingAttrAddWin:onMask()
self:closeSelf()
end

