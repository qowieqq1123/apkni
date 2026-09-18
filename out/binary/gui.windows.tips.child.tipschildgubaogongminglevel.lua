







def_class("tipsChildGuBaoGongMingLevel",UICloneObject)





tipsChildGuBaoGongMingLevel.abName="ui/windows/tips/child/tipschildgubaogongminglevel.ab"

tipsChildGuBaoGongMingLevel.assetName="tipsChildGuBaoGongMingLevel"


function tipsChildGuBaoGongMingLevel:bindComponents()

self.titleText=UIText.get(self,0)
self.creater=UIObject.get(self,1)

end


function tipsChildGuBaoGongMingLevel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.creater);self.creater=nil;
end









function tipsChildGuBaoGongMingLevel:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoGongMingLevel:__delete()
self:unbindComponents()
end




function tipsChildGuBaoGongMingLevel:onShow(args,afterOnloaded)
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
self.showEnhancelv=attach and attach.showEnhancelv
local itemConfig=itemsConfig.getConfig(itemid)
local equip=equipsHelper.getEquip(itemguid)

local gongMingLv=equip and vocEquipModel:getVocEquipGongMingLv(itemid)or 0
if self.showEnhancelv and self.showEnhancelv>0 then
gongMingLv=vocEquipModel:getVocEquipGongMingLv(itemid)
end
local levelCndDescList=vocEquipHelper.getVocEquipGongMingLvCndDescList(itemid)

self.creater:setChildLayoutGroupCreateItems(#levelCndDescList,function(index)
local widget=self.creater:getChildLayoutGroupGridItem(index-1)
local cndDesc=levelCndDescList[index]
if cndDesc then
widget:SetChildActive(-1,true)
local level=index
local isActive=gongMingLv>=level
local descStr=""
local stateStr=""
if isActive then
descStr=FMT.fmt("<color=#aae252>{0}级：{1}</color>",level,cndDesc)
stateStr="<color=#aae252>已解锁</color>"
else
descStr=FMT.fmt("{0}级：{1}",level,cndDesc)
stateStr="未解锁"
end
widget:SetChildText(0,descStr)
widget:SetChildText(1,stateStr)
else
widget:SetChildActive(-1,false)
end
end)
end


function tipsChildGuBaoGongMingLevel:onHide()

end


