







def_class("UISubAct_ChiSeJinDi_CopyDiscipleDetailWin",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:bindComponents()

self.attrDetail=UIButton.get(self,0)
self.attrTx_1=UIText.get(self,1)
self.attrTx_2=UIText.get(self,2)
self.attrTx_3=UIText.get(self,3)
self.attrTx_4=UIText.get(self,4)
self.attrTx_5=UIText.get(self,5)
self.attrTx_6=UIText.get(self,6)
self.background=UIButton.get(self,7)
self.closeBtn=UIButton.get(self,8)
self.colorIcon=UIImage.get(self,9)
self.gfSkillList=UIObject.get(self,10)
self.jingjieTx=UIText.get(self,11)
self.jobIcon=UIImage.get(self,12)
self.jobSkillList=UIObject.get(self,13)
self.list=UIObject.get(self,14)
self.listView=UIObject.get(self,15)
self.model=UIObject.get(self,16)
self.nameTx=UIText.get(self,17)
self.starList=UIObject.get(self,18)
self.tmBack=UIButton.get(self,19)
self.weapon=UIObject.get(self,20)
self.weaponBtn=UIButton.get(self,21)

self.attrDetail:setButtonClick(function()self:onAttrDetail()end)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tmBack:setButtonClick(function()self:onTmBack()end)

self.weaponBtn:setButtonClick(function()self:onWeaponBtn()end)
self.attrTx={
self.attrTx_1,
self.attrTx_2,
self.attrTx_3,
self.attrTx_4,
self.attrTx_5,
self.attrTx_6,
}



end


function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrDetail);self.attrDetail=nil;
_UIObject_release(self.attrTx_1);self.attrTx_1=nil;
_UIObject_release(self.attrTx_2);self.attrTx_2=nil;
_UIObject_release(self.attrTx_3);self.attrTx_3=nil;
_UIObject_release(self.attrTx_4);self.attrTx_4=nil;
_UIObject_release(self.attrTx_5);self.attrTx_5=nil;
_UIObject_release(self.attrTx_6);self.attrTx_6=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.colorIcon);self.colorIcon=nil;
_UIObject_release(self.gfSkillList);self.gfSkillList=nil;
_UIObject_release(self.jingjieTx);self.jingjieTx=nil;
_UIObject_release(self.jobIcon);self.jobIcon=nil;
_UIObject_release(self.jobSkillList);self.jobSkillList=nil;
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.listView);self.listView=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.starList);self.starList=nil;
_UIObject_release(self.tmBack);self.tmBack=nil;
_UIObject_release(self.weapon);self.weapon=nil;
_UIObject_release(self.weaponBtn);self.weaponBtn=nil;
self.attrTx=nil;
end















local _this=nil
local _attrs={
1,3,2,4,201,203
}
local _skillCmp={
widget=-1,
icon=0,
sign=1,
lvText=2,
}
local _weaponCmp={
quality=0,
icon=1,
starBg=2,
starTx=3,
}
local _roleCmp={
widget=-1,
bg=0,
head=1,
select=2,
}
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"



function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.roleList=argtable.roleList
self.parentWin=argtable.parentWin
self.showList=argtable.showList
local default=argtable.index or 1
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self:refreshList()
self:onClickRole(default)
end


function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:onHide()

end




function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:onBackground()
self:onCloseBtn()
end


function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:onAttrDetail()
local role=self.roleList[self.selectIdx]
local disciple=role.disciple
local attrList=self.config.discipleAttr[disciple]
local attrLookup=attrListHelper.tramsformToLookup(attrList)

local weapon=role.weapon
if weapon and weapon>0 then
local weaponServer=self.config.treasure[weapon]
local weaponAttr=weaponServer[1]
for i,v in ipairs(weaponAttr)do
local attrType=v[1]
local attrValue=v[2]
attrLookup[attrType]=(attrLookup[attrType]or 0)+attrValue
end
end

local args={}
args.titleName='详细属性'
args.pos=1
args.extraWin='UICommonAttrDetailWin'
local extraParams={}
extraParams.attrLookup=attrLookup
args.extraParams=extraParams
self:showWindow('UICommonPageWin',args)
end

function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:onTmBack()
local role=self.roleList[self.selectIdx]
local discipleId=role.disciple
local discipleServer=self.config.disciple[discipleId]
local tmList=self.config.discipleTM[discipleId]
local job=discipleServer[6]
local tempVec1=Vector2.New(1,1)
local tempVec2=Vector2.New(0,1)
local args={
tmList=tmList,
job=job,










}
self:showWindow("UIDiscipleTianMingTipsCommonWin",args)
end

function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:onWeaponBtn()
local role=self.roleList[self.selectIdx]
local args={
itemid=role.weapon,
funType=TIPS_FUNC_TYPE.eChiSeJinDiWeapon,
attach={
actId=self.actId,
subType=self.subType,
subId=self.subId,
}
}
tipsManager.showTips(args)
end

function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:refreshList()
self.list:setChildLayoutGroupCreateItems(#self.roleList,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local role=self.roleList[index]
local disciple=role.disciple
local discipleServer=self.config.disciple[disciple]
local color=discipleServer[5]
local inside=self.config.discipleInside[disciple]
local modelParams={
body=inside[1],
componets=inside[2]or{},
}
comHelper.setChildModelHeadIconBGByColor(item,_roleCmp.bg,color)
comHelper.setChildModelRawImageEx(_roleCmp.head,item,modelParams,eHeadCenterType.eHead)
item:SetChildActive(_roleCmp.select,false)
item:SetChildButtonClick(_roleCmp.widget,function()
self:onClickRole(index)
end)
end)
self.listView:setActive(#self.roleList>1 or self.showList)
end

function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:onClickRole(index)
if self.selectIdx==index then return end
if self.selectIdx then
local item=self.list:getChildLayoutGroupGridItem(self.selectIdx-1)
item:SetChildActive(_roleCmp.select,false)
end

self.selectIdx=index

if self.selectIdx then
local item=self.list:getChildLayoutGroupGridItem(self.selectIdx-1)
item:SetChildActive(_roleCmp.select,true)
end

self:refreshView()
end

function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:refreshView()
local role=self.roleList[self.selectIdx]
local weaponID=role.weapon
local discipleID=role.disciple
local discipleServer=self.config.disciple[discipleID]
local monsterId=discipleServer[1]
local monsterCfg=cfgHelper.get1(cfg_monsterconfig_get,monsterId)
local modelParams=monsterCfg.modelid
local job=discipleServer[6]
local jjlv=self.config.discipleJJ[discipleID]
local color=discipleServer[5]
local jobSkillList=self.config.discipleJobSkill[discipleID]
local gfSkillList=self.config.discipleGFSkill[discipleID]
local star=self.info:getCopyItemStar(discipleID)
local attrList=self.config.discipleAttr[discipleID]
local attrLookup=attrListHelper.tramsformToLookup(attrList)
self.model:setChildUIModelShowTarget(modelParams[1],1,modelParams[2]or{},eAnimationID.stand,false,false,0)
self.model:setChildUIModelShowFlipX(true)
self.nameTx:setText(monsterCfg.name)
self.jobIcon:setSprite(globalABLookup.global,UIDiscipleModel:getJobIconName(job))
self.colorIcon:setSprite(_abName,FMT.fmt("image_chiseshilian_pz{0}",color))
self.jingjieTx:setText(FMT.fmt("修为：{0}",UIDiscipleModel:getJJNameXX(jjlv)))
self.starList:setChildLayoutGroupCreateItems(star)

self.jobSkillList:setChildLayoutGroupCreateItems(#jobSkillList,function(index)
local item=self.jobSkillList:getChildLayoutGroupGridItem(index-1)
local skillData=jobSkillList[index]
self:setSkillItem(item,skillData)
end)
self.gfSkillList:setChildLayoutGroupCreateItems(#gfSkillList,function(index)
local item=self.gfSkillList:getChildLayoutGroupGridItem(index-1)
local skillData=gfSkillList[index]
self:setSkillItem(item,skillData)
end)

self.weapon:setActive(weaponID~=nil and weaponID>0)
if weaponID and weaponID>0 then
local weaponServer=self.config.treasure[weaponID]
local weaponClient=self.config.treasureClient[weaponID]
local weaponAttr=weaponServer[1]
local color=weaponServer[6]
local widget=self.weapon:getChildWidgetBase()

local iconName=weaponClient[2]
local star=self.info:getCopyItemStar(weaponID)
widget:SetChildQulaity(_weaponCmp.quality,color)
widget:SetChildCSImageIcon(_weaponCmp.icon,iconName,false)
widget:SetChildActive(_weaponCmp.starBg,star>0)
widget:SetChildText(_weaponCmp.starTx,star>0 and star or"")

for i,v in ipairs(weaponAttr)do
local attrType=v[1]
local attrValue=v[2]
attrLookup[attrType]=(attrLookup[attrType]or 0)+attrValue
end
end

for i,v in ipairs(self.attrTx)do
local attrType=_attrs[i]
local attrValue=attrLookup[attrType]or 0
local attrStr=helper.getAttributeStr(attrType,attrValue,2,"<color=#813B17>{0}</color>： {1}")
v:setText(attrStr)
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleDetailWin:setSkillItem(item,skillData)
local skillId=skillData[1]
local skillLv=skillData[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(_skillCmp.sign,is_bd)
item:SetChildCSImageIcon(_skillCmp.icon,iconHelper.getSkillIcon(skillCfg.icon),false)
item:SetChildText(_skillCmp.lvText,FMT.fmt("{0}级",skillLv))
item:SetChildButtonClick(_skillCmp.widget,function()





local args={
skillID=skillId,
skillLv=skillLv,
fromCfg=skillCfg,
}
self:showWindow("UIDiscipleJobSkillTipsWin",args)
end)
end

