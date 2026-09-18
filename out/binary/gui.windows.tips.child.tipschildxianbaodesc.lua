







def_class("tipsChildXianBaoDesc",UICloneObject)





tipsChildXianBaoDesc.abName="ui/windows/tips/child/tipschildxianbaodesc.ab"

tipsChildXianBaoDesc.assetName="tipsChildXianBaoDesc"


function tipsChildXianBaoDesc:bindComponents()

self.title=UIText.get(self,0)
self.desc=UIText.get(self,1)

end


function tipsChildXianBaoDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
end









function tipsChildXianBaoDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildXianBaoDesc:__delete()
self:unbindComponents()
end




function tipsChildXianBaoDesc:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local xbid=data.itemid
local attach=data.attach
local xbType=data.xbtype or XianBaoTypeEnum.eXianBao
local xbCfg=xianbaoConfig.getTypeFuncResult(xbType,'getConfig',xbid)
self.title:setText('仙宝传说')
local desc_str=xbCfg.story
self.desc:setText(desc_str)
end


function tipsChildXianBaoDesc:onHide()

end


