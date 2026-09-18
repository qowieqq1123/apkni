







def_class("tipsChildXianBaoEffect",UICloneObject)





tipsChildXianBaoEffect.abName="ui/windows/tips/child/tipschildxianbaoeffect.ab"

tipsChildXianBaoEffect.assetName="tipsChildXianBaoEffect"


function tipsChildXianBaoEffect:bindComponents()

self.gubaoEffectRoot=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.ztpeffectRoot=UIObject.get(self,2)

end


function tipsChildXianBaoEffect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gubaoEffectRoot);self.gubaoEffectRoot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.ztpeffectRoot);self.ztpeffectRoot=nil;
end








local ztpCmpIdndex={
desc=0,
proImg=1,
proTxt=2,
}

function tipsChildXianBaoEffect:onLoaded(...)
self:bindComponents()
end


function tipsChildXianBaoEffect:__delete()
self:unbindComponents()
end




function tipsChildXianBaoEffect:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local xbid=data.itemid
local attach=data.attach
local formType=data.formType

local xbtype=data.xbtype or XianBaoTypeEnum.eXianBao

if xbtype==XianBaoTypeEnum.eXianBao then

local starlv=xianbaoModel:checkActive(xbid)and xianbaoModel:getXbStart(xbid)or(attach.starlv or 0)
if formType==TIPS_FORM_TYPE.eXianBaoBag or formType==TIPS_FORM_TYPE.eXianBaoMaterial then
starlv=attach.starlv or 0
end
local starCfg=xianbaoConfig.getXBStarCfg(xbid,starlv)
local xbCfg=xianbaoConfig.getXBCfg(xbid)
local effectType=xbCfg.effectType
local isShowZTPRoot=effectType==XianBaoEffectType.ZTP
self.ztpeffectRoot:setActive(isShowZTPRoot)
if isShowZTPRoot then
local widget=self.ztpeffectRoot:getWidgetBase()
widget:SetChildText(ztpCmpIdndex.desc,starCfg.xb_Effect_tip)

local cur,maxPro=YiFangLingTianModel:GetLingYeNum()
if formType==TIPS_FORM_TYPE.eXianBaoBag or formType==TIPS_FORM_TYPE.eXianBaoMaterial then
cur=0
end
local proValue=cur/maxPro
widget:SetChildText(ztpCmpIdndex.proTxt,FMT.fmt("{0}/{1}",cur,maxPro))
widget:SetChildIconFillAmount(ztpCmpIdndex.proImg,proValue)
else
logErr(FMT.fmt("仙宝效果类型没实现:{0}",effectType))
end
else
self.ztpeffectRoot:setActive(false)
end

local isShowGbRoot=xbtype==XianBaoTypeEnum.eGuBao
self.gubaoEffectRoot:setActive(isShowGbRoot)
if isShowGbRoot then
local widget=self.gubaoEffectRoot:getWidgetBase()
local skilllv=1
local flag=false
local skill_str,skill_str_2,skill_str_3
if xianzhiConfig.checkIsXianZhiGb(xbid)then
skill_str=xianzhiConfig.getXianZhiGuBaoEffectDesc()
else
if gubaoModel:checkActive(xbid)then
skilllv=gubaoModel:getSkillLv(xbid)
flag=true
end
skill_str,skill_str_2,skill_str_3=gubaoModel:getSkillDesc(xbid,skilllv)
if flag then
if skill_str_2 then
skill_str=FMT.fmt('{0}\n{1}',skill_str,skill_str_2)
end
if skill_str_3 then
skill_str=FMT.fmt('{0}\n{1}',skill_str,skill_str_3)
end
end
end

widget:SetChildText(0,skill_str)
end
end


function tipsChildXianBaoEffect:onHide()

end


