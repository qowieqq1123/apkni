







def_class("tipsChildXianBaoLevel",UICloneObject)





tipsChildXianBaoLevel.abName="ui/windows/tips/child/tipschildxianbaolevel.ab"

tipsChildXianBaoLevel.assetName="tipsChildXianBaoLevel"


function tipsChildXianBaoLevel:bindComponents()

self.levelItemRoot=UIObject.get(self,0)
self.tipsChildXianBaoLevel=UIObject.get(self,1)

end


function tipsChildXianBaoLevel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.levelItemRoot);self.levelItemRoot=nil;
_UIObject_release(self.tipsChildXianBaoLevel);self.tipsChildXianBaoLevel=nil;
end








local levelItemCmp={
profull=0,
proIconfull=1,
starGrid=2,
levelEffect=3,
proBg=4,
lckFlag=5,
}

function tipsChildXianBaoLevel:onLoaded(...)
self:bindComponents()
end


function tipsChildXianBaoLevel:__delete()
self:unbindComponents()
end




function tipsChildXianBaoLevel:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local xbid=data.itemid
local attach=data.attach
local formType=data.formType
local starlv=xianbaoModel:checkActive(xbid)and xianbaoModel:getXbStart(xbid)or(attach.starlv or 0)
if formType==TIPS_FORM_TYPE.eXianBaoBag or formType==TIPS_FORM_TYPE.eXianBaoMaterial then
starlv=attach.starlv or 0
end
local starCfg=xianbaoConfig.getXBStarCfg(xbid,starlv)
local xbCfg=xianbaoConfig.getXBCfg(xbid)

if not xianbaoModel:checkCanUpStar(xbid)then
self.tipsChildXianBaoLevel:setActive(false)
return
end
local maxStar=xianbaoConfig.getXBMaxStar(xbid)
self.levelItemRoot:setChildLayoutGroupCreateItems(maxStar,function(idx)
local levelItem=self.levelItemRoot:getChildLayoutGroupGridItem(idx-1)
local curUnlock=idx<=starlv
local nextUnlock=(idx+1)<=starlv
levelItem:SetChildActive(levelItemCmp.profull,nextUnlock)
levelItem:SetChildActive(levelItemCmp.proIconfull,curUnlock)
levelItem:SetChildLayoutGroupCreateItems(levelItemCmp.starGrid,idx,function(starIdx)
local strtItem=levelItem:GetChildLayoutGroupGridItem(levelItemCmp.starGrid,starIdx-1)
strtItem:SetChildActive(0,curUnlock)
end)
levelItem:SetChildActive(levelItemCmp.lckFlag,not curUnlock)
local starCfg=xianbaoConfig.getXBStarCfg(xbid,idx)
levelItem:SetChildText(levelItemCmp.levelEffect,curUnlock and starCfg.effectDec or FMT.fmt("<color=#8e8c87>{0}</color>",starCfg.effectDec))

if maxStar==idx then
levelItem:SetChildActive(levelItemCmp.proBg,false)
end
end)
end


function tipsChildXianBaoLevel:onHide()

end


