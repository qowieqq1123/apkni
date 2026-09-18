







def_class("tipsChildBenMingFabaoShentong",UICloneObject)





tipsChildBenMingFabaoShentong.abName="ui/windows/tips/child/tipschildbenmingfabaoshentong.ab"

tipsChildBenMingFabaoShentong.assetName="tipsChildBenMingFabaoShentong"


function tipsChildBenMingFabaoShentong:bindComponents()

self.title=UIText.get(self,0)
self.skill_1=UIBaseItem.get(self,1)
self.skill_2=UIBaseItem.get(self,2)
self.skill_3=UIBaseItem.get(self,3)
self.skillname=UIText.get(self,4)
self.desc=UIText.get(self,5)
self.skill={
self.skill_1,
self.skill_2,
self.skill_3,
}

end


function tipsChildBenMingFabaoShentong:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.skill_1);self.skill_1=nil;
_UIObject_release(self.skill_2);self.skill_2=nil;
_UIObject_release(self.skill_3);self.skill_3=nil;
_UIObject_release(self.skillname);self.skillname=nil;
_UIObject_release(self.desc);self.desc=nil;
self.skill=nil;
end








function tipsChildBenMingFabaoShentong:onLoaded(...)
self:bindComponents()
end

function tipsChildBenMingFabaoShentong:__delete()
self:unbindComponents()
end

function tipsChildBenMingFabaoShentong:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local diziguid=attach.diziguid
self.diziguid=diziguid
self.itemid=itemid
self.formType=data.formType
local itemConfig=itemsConfig.getConfig(itemid)
self.itemguid=itemguid
local equip=fabaoHelper.getFabao(itemguid)

local shentongInfos=benMingFaBaoHelper.getShentongInfoList(equip)
local mainidx=benMingFaBaoHelper.getNowMainIdx(equip)
local shentongInfo=shentongInfos[mainidx]
local addlv=fabaoHelper.getJlAddShenTonglv(equip)
local shentongid=shentongInfo[1]
local shentongLv=shentongInfo[2]+
benMingFaBaoHelper.getAddShentonglv(itemguid,mainidx)+
addlv
for i,info in ipairs(shentongInfos)do
local id=info[1]
local isSelect=mainidx==i
local shentongConfig=fabaoConfig.getShentongConfig(id)
local shentongIcon=iconHelper.getSkillIcon(shentongConfig.icon)

local widget=self.skill[i]:getWidgetBase()
widget:SetChildButtonClick(0,function()
self:selectShentong(i)
end,true)
widget:SetChildActive(1,isSelect)
widget:SetChildCSImageIcon(2,shentongIcon,false)
widget:SetChildActive(3,isSelect)
end

local shentongConfig=fabaoConfig.getShentongConfig(shentongid)
local shentongName=shentongConfig.name
shentongName=FMT.fmt('{0}（{1}级）',shentongName,shentongLv)
local shentongdesc=skillModel:getSkillDesc(shentongid,shentongLv)

self.skillname:setText(shentongName)
self.desc:setText(shentongdesc)
end

function tipsChildBenMingFabaoShentong:onHide()

end



function tipsChildBenMingFabaoShentong:selectShentong(idx)
local itemguid=self.itemguid
local equip=fabaoHelper.getFabao(itemguid)
local shentongInfos=benMingFaBaoHelper.getShentongInfoList(equip)
local mainidx=benMingFaBaoHelper.getNowMainIdx(equip)
local selectidx=idx
local addlv=fabaoHelper.getJlAddShenTonglv(equip)
local shentongInfo=shentongInfos[selectidx]
local shentongid=shentongInfo[1]
local shentongLv=shentongInfo[2]+
benMingFaBaoHelper.getAddShentonglv(itemguid,mainidx)+
addlv

for i,info in ipairs(shentongInfos)do
local id=info[1]
local isEnable=mainidx==i
local isSelect=selectidx==i
local widget=self.skill[i]:getWidgetBase()
widget:SetChildActive(1,isSelect)
widget:SetChildActive(3,isEnable)
end

local shentongConfig=fabaoConfig.getShentongConfig(shentongid)
local shentongName=shentongConfig.name
shentongName=FMT.fmt('{0}（{1}级）',shentongName,shentongLv)
local shentongdesc=skillModel:getSkillDesc(shentongid,shentongLv)

self.skillname:setText(shentongName)
self.desc:setText(shentongdesc)
end

