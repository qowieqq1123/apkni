







def_class("tipsChildGuBaoGongMingInfo",UICloneObject)





tipsChildGuBaoGongMingInfo.abName="ui/windows/tips/child/tipschildgubaogongminginfo.ab"

tipsChildGuBaoGongMingInfo.assetName="tipsChildGuBaoGongMingInfo"


function tipsChildGuBaoGongMingInfo:bindComponents()

self.name=UIText.get(self,0)
self.spine=UIObject.get(self,1)

end


function tipsChildGuBaoGongMingInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.spine);self.spine=nil;
end









function tipsChildGuBaoGongMingInfo:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoGongMingInfo:__delete()
self:unbindComponents()
end




function tipsChildGuBaoGongMingInfo:onShow(args,afterOnloaded)
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


local vocId=vocEquipHelper.getEquipVocId(itemid)
local vocName=UIDiscipleModel:getJobName(vocId)
self.name:setText(FMT.fmt('限定职业：{0}',vocName))

self.spine:setChildUIModelShowTarget(6124,1,nil,eAnimationID.stand)
self.spine:setChildUIModelShowTargetOffset(0,-251)
end


function tipsChildGuBaoGongMingInfo:onHide()

end


