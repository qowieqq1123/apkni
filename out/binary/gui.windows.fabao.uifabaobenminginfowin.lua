







def_class("UIFabaoBenMingInfoWin",UIWindowBase)









function UIFabaoBenMingInfoWin:bindComponents()

self.closeTag=UIObject.get(self,0)
self.openTag=UIObject.get(self,1)
self.fanzhuLock=UIObject.get(self,2)
self.fbname=UIText.get(self,3)
self.czdesc=UIText.get(self,4)
self.czname=UIText.get(self,5)
self.yunyangBtn=UIButton.get(self,6)
self.help=UIButton.get(self,7)
self.InputField=UIInputField.get(self,8)
self.fbicon=UIObject.get(self,9)
self.rename=UIButton.get(self,10)
self.colorBg=UIImage.get(self,11)
self.skillicon=UIObject.get(self,12)
self.reowner=UIButton.get(self,13)
self.temp=UIObject.get(self,14)
self.dzname=UIText.get(self,15)
self.ownername=UIText.get(self,16)
self.itemSlot_1=UIObject.get(self,17)
self.itemSlot_2=UIObject.get(self,18)
self.itemSlot_3=UIObject.get(self,19)
self.model=UIObject.get(self,20)
self.fanzhuBtn=UIButton.get(self,21)
self.guiyuanBtn=UIButton.get(self,22)

self.yunyangBtn:setButtonClick(function()self:onYunyangBtn()end)

self.help:setButtonClick(function()self:onHelp()end)

self.rename:setButtonClick(function()self:onRename()end)

self.reowner:setButtonClick(function()self:onReowner()end)

self.fanzhuBtn:setButtonClick(function()self:onFanzhuBtn()end)

self.guiyuanBtn:setButtonClick(function()self:onGuiyuanBtn()end)
self.itemSlot={
self.itemSlot_1,
self.itemSlot_2,
self.itemSlot_3,
}



end


function UIFabaoBenMingInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeTag);self.closeTag=nil;
_UIObject_release(self.openTag);self.openTag=nil;
_UIObject_release(self.fanzhuLock);self.fanzhuLock=nil;
_UIObject_release(self.fbname);self.fbname=nil;
_UIObject_release(self.czdesc);self.czdesc=nil;
_UIObject_release(self.czname);self.czname=nil;
_UIObject_release(self.yunyangBtn);self.yunyangBtn=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.fbicon);self.fbicon=nil;
_UIObject_release(self.rename);self.rename=nil;
_UIObject_release(self.colorBg);self.colorBg=nil;
_UIObject_release(self.skillicon);self.skillicon=nil;
_UIObject_release(self.reowner);self.reowner=nil;
_UIObject_release(self.temp);self.temp=nil;
_UIObject_release(self.dzname);self.dzname=nil;
_UIObject_release(self.ownername);self.ownername=nil;
_UIObject_release(self.itemSlot_1);self.itemSlot_1=nil;
_UIObject_release(self.itemSlot_2);self.itemSlot_2=nil;
_UIObject_release(self.itemSlot_3);self.itemSlot_3=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.fanzhuBtn);self.fanzhuBtn=nil;
_UIObject_release(self.guiyuanBtn);self.guiyuanBtn=nil;
self.itemSlot=nil;
end

















local _colorBg=
{
[eQualityColor.ePurple]='image_benmingfabaoxxpz_1',
[eQualityColor.eOrange]='image_benmingfabaoxxpz_2',
[eQualityColor.eRed]='image_benmingfabaoxxpz_3',
}

function UIFabaoBenMingInfoWin:onLoaded(...)
self:bindComponents()
end

function UIFabaoBenMingInfoWin:__delete()
self:unbindComponents()
end

function UIFabaoBenMingInfoWin:onShow(argtable,afterOnloaded)
self:freshFaBao(argtable)
end

function UIFabaoBenMingInfoWin:freshFaBao(argtable)
if argtable then
local itemguid=argtable.itemguid
self.equip=fabaoHelper.getFabao(itemguid)
self.isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)
end
self:freshInfo()
end

function UIFabaoBenMingInfoWin:onHide()

end





function UIFabaoBenMingInfoWin:onYunyangBtn()
local equip=self.equip
local itemguid=equip.itemguid
local has=benMingFaBaoHelper.hasOwner(itemguid)
if not has then
UIManager.error('暂无主人，无法蕴养')
return
end
local flag=fabaoModel.isYunYang(equip)
fabaoProtocolControl.reqYunYang(itemguid,not flag)
end



function UIFabaoBenMingInfoWin:onHelp()
local d={}
d.title='蕴养规则'
d.mode=3
d.name='fabao_yunyang_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UIFabaoBenMingInfoWin:onRename()
UIManager:showWindow('UIChangeFaBaoNameWin',self.equip.itemguid)
end

function UIFabaoBenMingInfoWin:onReowner()
local itemguid=self.equip.itemguid
local func=function(...)
local args={
openType=dzSelectWinOpenType.eFabaoOwner,
effectType=dzSelectEffectType.ePlan,
bdData=self.bdData,
sfId=mapIdType.zhufeng,
funcIndex=1,
canvasIdx=8,
callback=function(dzId)
fabaoProtocolControl.reqReOwner(dzId,itemguid)
end
}
discipleSelectController:openDiscipleSelect(args)
end
func()


end



function UIFabaoBenMingInfoWin:onGuiyuanBtn()
local equip=self.equip
local itemguid=equip.itemguid
local guiyuanCfg=fabaoConfig.getGuiYuanConfig()
local moneyType=guiyuanCfg[1][1]
local costnum=guiyuanCfg[1][2]
local have=moneyModel.getMoney(moneyType)
local okTipsStr=have>=costnum and FMT.fmt('{0}/{1}',have,costnum)or FMT.fmt('<color=red>{0}/{1}</color>',have,costnum)
local iconname=iconHelper.getIconName(moneyType)
local str='本命法宝归元后将变成无主状态\n法宝属性不变，确认是否归元？'
local showdata=
{
type='UIDialougeBMFaBaoGuiYuan',
title='提示',
content=str,
okTipsText=okTipsStr,
okTipsIcon=iconname,
oktext='确认',
canceltext='取消',
allowclickBG=false,
okcallback=function(...)
moneySystem:useMoney(moneyType,costnum,function()
if have>=costnum then
local diziguid=fabaoModel.getDiziguidByItemguid(itemguid)
fabaoProtocolControl.reqReOwner(int64.new(0),itemguid)
if diziguid then
fabaoProtocolControl.reqTakeoffFabao(diziguid)
end

local win=UIManager:findActiveWindow("UIBackgroundComponent")
if win then
win:onCloseButton()
end
end
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end



function UIFabaoBenMingInfoWin:onFanzhuBtn()
if not systemModel.isOpen(SYSTEM_DEFINE.eBMFabaoRL)then
UIManager.error(systemModel.getOpenTips(SYSTEM_DEFINE.eBMFabaoRL))
return
end
local equip=self.equip
local itemguid=equip.itemguid
local d={}
d.itemguid=itemguid
UIManager:showWindow('UIFabaoBenMingFanZhuTips',d)
end

function UIFabaoBenMingInfoWin:freshInfo()
local equip=self.equip
local itemid=equip.itemid
local itemguid=equip.itemguid
local hasOwner,dzguid=benMingFaBaoHelper.hasOwner(itemguid)
local dzname=hasOwner and UIDiscipleModel:getDiscipleName(dzguid)or'尚未认主'
local fbiconName=itemsModel.getIconName(equip)
local isYunYang=fabaoModel.isYunYang(equip)
local mainid=fabaoHelper.getReallyMainId(equip)
local czid=benMingFaBaoHelper.getCiZhui(mainid)
local czCfg=cfg_disciplefabaoczconfig_get(czid)
local stInfo=benMingFaBaoHelper.getShentongInfoList(equip)
local mainidx=fabaoModel.getMianidxByEquip(equip)
local visReName=true
local itemCfg=itemsConfig.getConfig(itemid)

self.colorBg:setSprite(globalABLookup.fabaoSprite,_colorBg[itemCfg.color])

self.rename:setActive(visReName)

self:freshOwner()

self:freshShowFanZhuBtn()

self.closeTag:setActive(not isYunYang)

self.openTag:setActive(isYunYang)

self.fbicon:setChildIcon(fbiconName,false)

self.InputField:setInputFieldValue(fabaoHelper.getFabaoName(equip))

self.skillicon:setChildIcon(iconHelper.getSkillIcon(czCfg.icon),false)

self.czname:setText(FMT.fmt('本命词缀：{0}',czCfg.name))

self.czdesc:setText(czCfg.descEx or czCfg.desc)
local addlv=fabaoHelper.getJlAddShenTonglv(equip)
for i,v in ipairs(self.itemSlot)do
local widget=v:getWidgetBase()

local info=stInfo[i]
local shentongid=info[1]
local level=info[2]+
benMingFaBaoHelper.getAddShentonglv(itemguid,i)+
addlv
local stConfig=fabaoConfig.getShentongConfig(shentongid)
local stIcon=iconHelper.getSkillIcon(stConfig.icon)
local isSelect=mainidx==i
widget:SetChildIcon(0,stIcon,false)
widget:SetChildButtonClick(0,function()
local _dzguid=hasOwner and dzguid or nil
local args={skillID=shentongid,skillLv=level,attend=eSkillTipsType.eDZSTSkill,dis_guid=_dzguid,changLv=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end,true)
widget:SetChildActive(1,not isSelect)
widget:SetChildButtonClick(1,function()
fabaoProtocolControl.reqChangeShentong(itemguid,i)
end,true)
widget:SetChildActive(2,isSelect)
widget:SetChildActive(3,isSelect)
widget:SetChildActive(4,true)
widget:SetChildText(5,level)
widget:SetChildText(6,stConfig.name)
end
end

function UIFabaoBenMingInfoWin:freshOwner()
local equip=self.equip
local itemid=equip.itemid
local itemguid=equip.itemguid
local hasOwner,dzguid=benMingFaBaoHelper.hasOwner(itemguid)
local dzname=hasOwner and UIDiscipleModel:getDiscipleName(dzguid)or'尚未认主'

self.dzname:setText(dzname)
if hasOwner then
comHelper.setChildInSideModel(self.model,dzguid,0.85,nil,0,0,false,false,nil)
end
self.reowner:setActive(not hasOwner)
self.temp:setActive(not hasOwner)
self.guiyuanBtn:setActive(hasOwner)
end

function UIFabaoBenMingInfoWin:onYunYangRet(itemguid)
if tostring(itemguid)~=tostring(self.equip.itemguid)then return end
local equip=self.equip
local isYunYang=fabaoModel.isYunYang(equip)
self.closeTag:setActive(not isYunYang)
self.openTag:setActive(isYunYang)
end

function UIFabaoBenMingInfoWin:onShengTongChangeRet(itemguid,mainidx)
if tostring(itemguid)~=tostring(self.equip.itemguid)then return end
for i,v in ipairs(self.itemSlot)do
local widget=v:getWidgetBase()
local isSelect=mainidx==i
widget:SetChildActive(1,not isSelect)
widget:SetChildActive(2,isSelect)
widget:SetChildActive(3,isSelect)
end
end

function UIFabaoBenMingInfoWin:onChangeNameRet(itemguid)
if tostring(itemguid)~=tostring(self.equip.itemguid)then return end
self.InputField:setInputFieldValue(fabaoHelper.getFabaoName(self.equip))
end

function UIFabaoBenMingInfoWin:onReOwnerRet(itemguid)
if tostring(itemguid)~=tostring(self.equip.itemguid)then return end
self:freshOwner()
end

function UIFabaoBenMingInfoWin:freshShowFanZhuBtn()
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eBMFabaoRL)
self.winlua:SetChildImageExGray(self.fanzhuBtn:getID(),not isOpen)
self.fanzhuLock:setActive(not isOpen)
end