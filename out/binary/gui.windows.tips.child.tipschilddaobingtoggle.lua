







def_class("tipsChildDaoBingToggle",UICloneObject)





tipsChildDaoBingToggle.abName="ui/windows/tips/child/tipschilddaobingtoggle.ab"

tipsChildDaoBingToggle.assetName="tipsChildDaoBingToggle"


function tipsChildDaoBingToggle:bindComponents()

self.root=UIObject.get(self,0)
self.closeTag=UIObject.get(self,1)
self.openTag=UIObject.get(self,2)
self.toggleBtn=UIButton.get(self,3)

self.toggleBtn:setButtonClick(function()self:onToggleBtn()end)

end


function tipsChildDaoBingToggle:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeTag);self.closeTag=nil;
_UIObject_release(self.openTag);self.openTag=nil;
_UIObject_release(self.toggleBtn);self.toggleBtn=nil;
end








function tipsChildDaoBingToggle:onLoaded(...)
self:bindComponents()
end

function tipsChildDaoBingToggle:__delete()
self:unbindComponents()
end

function tipsChildDaoBingToggle:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
self.itemid=itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach=attach
local starlv=attach.starlv or 0
local maxlv=daobingConfig.getStarMaxLv(itemid)
local isMax=starlv>=maxlv
self.closeTag:setActive(not isMax)
self.openTag:setActive(isMax)
end

function tipsChildDaoBingToggle:onHide()

end



function tipsChildDaoBingToggle:onToggleBtn()
local attach=self.attach
local itemid=self.itemid
local starlv=attach.starlv or 0
local maxStarlv=daobingConfig.getStarMaxLv(itemid)
local maxjllv=daobingConfig.getJinglianMaxLv(itemid)
local isMax=starlv>=maxStarlv
tipsManager.setAttachArgs(attach,'starlv',isMax and 0 or maxStarlv)
tipsManager.setAttachArgs(attach,'jllv',isMax and 0 or maxjllv)
tipsManager.freshTips()
end