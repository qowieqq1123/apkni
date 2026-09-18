







def_class("tipsChildDaoBingMaterialsProgress",UICloneObject)





tipsChildDaoBingMaterialsProgress.abName="ui/windows/tips/child/tipschilddaobingmaterialsprogress.ab"

tipsChildDaoBingMaterialsProgress.assetName="tipsChildDaoBingMaterialsProgress"


function tipsChildDaoBingMaterialsProgress:bindComponents()

self.desc=UIText.get(self,0)
self.progressBar=UIProgressBarAni.get(self,1)
self.progressCount=UIText.get(self,2)
self.line=UIObject.get(self,3)

end


function tipsChildDaoBingMaterialsProgress:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.line);self.line=nil;
end








function tipsChildDaoBingMaterialsProgress:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingMaterialsProgress:__delete()
self:unbindComponents()
end

function tipsChildDaoBingMaterialsProgress:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx

local itemid=data.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local piece=itemCfg.piece
local need=piece[2]

local has=itemsModel.getCount(itemid)

self.desc:setText(itemCfg.desc)

self.progressCount:setText(FMT.fmt('{0}/{1}',has,need))

if has>need then has=need end
self.progressBar:animateThreeParams(has,need,0)
end

function tipsChildDaoBingMaterialsProgress:onHide()

end


