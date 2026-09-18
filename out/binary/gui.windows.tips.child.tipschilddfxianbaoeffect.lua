







def_class("tipsChildDFXianBaoEffect",UICloneObject)





tipsChildDFXianBaoEffect.abName="ui/windows/tips/child/tipschilddfxianbaoeffect.ab"

tipsChildDFXianBaoEffect.assetName="tipsChildDFXianBaoEffect"


function tipsChildDFXianBaoEffect:bindComponents()

self.gubaoEffectRoot=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.ztpeffectRoot=UIObject.get(self,2)
self.ztpdesc=UIText.get(self,3)
self.desc1=UIText.get(self,4)
self.desc2=UIText.get(self,5)

end


function tipsChildDFXianBaoEffect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gubaoEffectRoot);self.gubaoEffectRoot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.ztpeffectRoot);self.ztpeffectRoot=nil;
_UIObject_release(self.ztpdesc);self.ztpdesc=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.desc2);self.desc2=nil;
end








local ztpCmpIdndex={
desc=0,
proImg=1,
proTxt=2,
}

function tipsChildDFXianBaoEffect:onLoaded(...)
self:bindComponents()
end


function tipsChildDFXianBaoEffect:__delete()
self:unbindComponents()
end




function tipsChildDFXianBaoEffect:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local xbid=data.itemid
local attach=data.attach
local formType=data.formType

local xbtype=data.xbtype or XianBaoTypeEnum.eXianBao

local dfxb=xianbaoModel:CheckDianfengXianbao(xbid)
if dfxb then
self.ztpdesc:setText('巅峰等级升级时可获得天数感悟点数')
local dflevel=DianFengLevelModel:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local maxpoint=cfglvl.point
local usepoint=DianFengLevelModel:getaddPointNum()
local num=maxpoint-usepoint
if num<0 then
num=0
end
local desc1=FMT.fmt('天道感悟点数：{0}',maxpoint)
self.desc1:setText(desc1)
local desc2=FMT.fmt('（剩余{0}点未分配）',num)
self.desc2:setText(desc2)
else
logErr(FMT.fmt("传入的仙宝id:{0}不是巅峰仙宝",xbid))
end
end


function tipsChildDFXianBaoEffect:onHide()

end
