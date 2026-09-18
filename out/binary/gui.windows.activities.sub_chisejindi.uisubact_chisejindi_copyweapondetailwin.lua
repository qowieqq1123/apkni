







def_class("UISubAct_ChiSeJinDi_CopyWeaponDetailWin",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyWeaponDetailWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.empty=UIObject.get(self,2)
self.itemList=UIObject.get(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_ChiSeJinDi_CopyWeaponDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.itemList);self.itemList=nil;
end















local _this=nil
local _itemCmp={
widget=-1,
colorBg=0,
image=1,
name=2,
starList=3,
headBg=4,
head=5,
attrList=6,
skillDesc=7,
skillDesc2=8,
}
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"
local _colorBg={
[eQualityColor.eGreen]="image_chiseshilian_pzdb6",
[eQualityColor.eBlue]="image_chiseshilian_pzdb7",
[eQualityColor.ePurple]="image_chiseshilian_pzdb8",
[eQualityColor.eOrange]="image_chiseshilian_pzdb9",
[eQualityColor.eRed]="image_chiseshilian_pzdb10",
}



function UISubAct_ChiSeJinDi_CopyWeaponDetailWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_ChiSeJinDi_CopyWeaponDetailWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_ChiSeJinDi_CopyWeaponDetailWin:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.dataList=argtable.dataList
self.parentWin=argtable.parentWin

self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self:refreshList()
end


function UISubAct_ChiSeJinDi_CopyWeaponDetailWin:onHide()

end




function UISubAct_ChiSeJinDi_CopyWeaponDetailWin:onBackground()
self:onCloseBtn()
end


function UISubAct_ChiSeJinDi_CopyWeaponDetailWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_CopyWeaponDetailWin:refreshList()
local len=#self.dataList
self.empty:setActive(len<=0)
self.itemList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local itemData=self.dataList[index]
local weapon=itemData.weapon
local disciple=itemData.disciple
local weaponServer=self.config.treasure[weapon]
local weaponClient=self.config.treasureClient[weapon]
local attrList=weaponServer[1]
local skillId=weaponServer[2]
local skillLv=weaponServer[3]
local color=weaponServer[6]
local iconName=weaponClient[2]
local star=self.info:getCopyItemStar(weapon)
local desc=skillModel:getSkillDesc(skillId,skillLv)
local descEx=skillModel:getSkillDescEx(skillId,skillLv)or{}
for i,v in ipairs(descEx)do
local str=FMT.fmt('<color=#ffff99>{0}</color>',v)
desc=FMT.fmt('{0}\n{1}',desc,str)
end
desc=comHelper.getCheckLayoutStr(item:GetChildGameObject(_itemCmp.skillDesc2),477,desc,true)
item:SetChildText(_itemCmp.skillDesc,desc)
item:SetChildCSImageIcon(_itemCmp.image,iconName,false)
item:SetChildCSImageSprite(_itemCmp.colorBg,_abName,_colorBg[color]or"")
item:SetChildLayoutGroupCreateItems(_itemCmp.starList,star)
item:SetChildLayoutGroupCreateItems(_itemCmp.attrList,#attrList,function(attrIdx)
local attrItem=item:GetChildLayoutGroupGridItem(_itemCmp.attrList,attrIdx-1)
local attrData=attrList[attrIdx]
local attrType=attrData[1]
local attrValue=attrData[2]
local attrName=helper.getAttributeName(attrType)
local attrStr=helper.getAttributeStr(attrType,attrValue,2,"<color=#7D3B17>{0}</color>：{1}")
attrItem:SetChildText(-1,attrStr)
end)
item:SetChildButtonClick(_itemCmp.widget,function()
self:onClickItem(index)
end)
item:SetChildActive(_itemCmp.headBg,disciple~=nil)
if disciple then
local discipleServer=self.config.disciple[disciple]
local dColor=discipleServer[5]
local inside=self.config.discipleInside[disciple]
local modelParams={
body=inside[1],
componets=inside[2]or{},
}
comHelper.setChildModelHeadIconBGByColor(item,_itemCmp.headBg,dColor)
comHelper.setChildModelRawImageEx(_itemCmp.head,item,modelParams,eHeadCenterType.eHead)
end
end)
end

function UISubAct_ChiSeJinDi_CopyWeaponDetailWin:onClickItem(index)
local itemData=self.dataList[index]
local weapon=itemData.weapon
local args={
itemid=weapon,
funType=TIPS_FUNC_TYPE.eChiSeJinDiWeapon,
attach={
actId=self.actId,
subType=self.subType,
subId=self.subId,
}
}
tipsManager.showTips(args)
end