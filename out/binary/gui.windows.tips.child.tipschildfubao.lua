







def_class("tipsChildFubao",UICloneObject)





tipsChildFubao.abName="ui/windows/tips/child/tipschildfubao.ab"

tipsChildFubao.assetName="tipsChildFubao"


function tipsChildFubao:bindComponents()

self.name=UIText.get(self,0)
self.typename=UIText.get(self,1)
self.Icon=UIImage.get(self,2)
self.stage=UIText.get(self,3)
self.equip=UIObject.get(self,4)
self.jingjie=UIText.get(self,5)
self.lock=UIButton.get(self,6)
self.unlock=UIButton.get(self,7)

self.lock:setButtonClick(function()self:onLock()end)

self.unlock:setButtonClick(function()self:onUnlock()end)

end


function tipsChildFubao:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.typename);self.typename=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.stage);self.stage=nil;
_UIObject_release(self.equip);self.equip=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.unlock);self.unlock=nil;
end








local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end


function tipsChildFubao:onLoaded(...)
self:bindComponents()
self._onFuBaoLockChanged=function(...)self:onFuBaoLockChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_lock_changed,self._onFuBaoLockChanged)
end


function tipsChildFubao:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_lock_changed,self._onFuBaoLockChanged)
end




function tipsChildFubao:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
self.formType=data.formType
self.itemguid=itemguid

local itemConfig=itemsConfig.getConfig(itemid)
self.name:setText(itemConfig.name)

local typetxt=_descFun('类型：','玉符')
local stagetxt=_descFun('阶数：',FMT.fmt('{0}阶',itemConfig.stage))
self.typename:setText(typetxt)
self.stage:setText(stagetxt)
local conditions=itemConfig.wear_conditions
local jjLevel=self:getNeedJJ(conditions)
if jjLevel then
local n,p,pN=UIDiscipleModel:getJJNameX(jjLevel)
self.jingjie:setText(_descFun('境界：',FMT.fmt('{0}期',n)))
else
self.jingjie:setText('')
end

local equip=UIFuLuFangModel:isEquipedOnAnyDizi(itemguid)
self.equip:setActive(equip)

local iconname=iconHelper.getIconName(itemid)
self.Icon:setImageIcon(iconname,false)

local showLockImg=self:checkShowLockImg(self.formType)
if showLockImg then
if self.formType==TIPS_FORM_TYPE.eAuctionSellItem then

local isLock=bagUseControl.isItemInAuctionSellCd(itemguid)
self.lock:setActive(isLock)
self.unlock:setActive(false)
else
local lockType=UIFuLuFangModel:getLockBtnType(itemguid)
local isLock=lockType==TIPS_BTNS_TYPE.eUnlockEquip
self.lock:setActive(isLock)
self.unlock:setActive(not isLock)
end
else
self.lock:setActive(false)
self.unlock:setActive(false)
end
end

function tipsChildFubao:getNeedJJ(conditions)
if not conditions then
return
end
for i,v in ipairs(conditions)do
if v[1]==1 then
return v[2]
end
end
end


function tipsChildFubao:onHide()

end

function tipsChildFubao:onFuBaoLockChanged(itemid,itemguid,isUnlock)
if itemguid and tostring(itemguid)==tostring(self.itemguid)then
self.unlock:setActive(isUnlock)
self.lock:setActive(not isUnlock)
end
end

function tipsChildFubao:getPosFlag(dzId,itemguid)
local pos=UIFuLuFangModel:getEquipPos(dzId,self.itemguid)
if pos>0 then
return-10-pos
end
logErr(FMT.fmt('玉符({0})不在弟子({1})身上',tostring(itemguid),tostring(dzId)))
return 0
end

function tipsChildFubao:changeLock(flag)
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(self.itemguid)
if dzId then

local pos=self:getPosFlag(dzId,self.itemguid)
bagProtocolControl.req_change_bag_dizi_equip_lockflag(dzId,pos,flag)
else

bagProtocolControl.req_change_bag_item_lockflag(self.itemguid,flag)
end
end

function tipsChildFubao:checkShowLockImg(formType)
if formType~=TIPS_FORM_TYPE.eWatchRoleItem and formType~=TIPS_FORM_TYPE.eNone then
return true
end
return false
end



function tipsChildFubao:onLock()
if self.formType==TIPS_FORM_TYPE.eAuctionSellItem then

return
end
self:changeLock(true)
end

function tipsChildFubao:onUnlock()
self:changeLock(false)
end