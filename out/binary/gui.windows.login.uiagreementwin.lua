







def_class("UIAgreementWin",UIWindowBase)









function UIAgreementWin:bindComponents()

self.checkTxt=UIText.get(self,0)
self.txTitle=UIText.get(self,1)
self.txtList=UIObject.get(self,2)



end


function UIAgreementWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.checkTxt);self.checkTxt=nil;
_UIObject_release(self.txTitle);self.txTitle=nil;
_UIObject_release(self.txtList);self.txtList=nil;
end


















function UIAgreementWin:onLoaded(...)
self:bindComponents()
end

function UIAgreementWin:__delete()
self:unbindComponents()
end

function UIAgreementWin:onShow(argtable,afterOnloaded)
local id
local data
if argtable.userId then
id=argtable.userId

local cfg=cfg_userprivateconfig_get(id)

data=self:transOldData(cfg)
else
id=argtable.userType or USER_TYPE.ePrivateProtected
local content
local cfg
if id==USER_TYPE.ePrivateProtected then
content=loginControl.proviteProtocolContent
elseif id==USER_TYPE.eUserProtocol then
content=loginControl.userProtocolContent
end
if content~='nil'and content~=nil then
data=content

else
local pfid=loginModel:getPfid()
local pfcfg=cfg_userpfprivateconfig_get(1).pfcfg
id=argtable.userType or USER_TYPE.ePrivateProtected
if pfid and pfcfg[pfid]and argtable.userType then
id=pfcfg[pfid][argtable.userType]
end
cfg=cfg_userprivateconfig_get(id)
data=self:transOldData(cfg)
end
end

if data then
self.txTitle:setText(data.name)

local len=#data.list
local textViewWidth=self.checkTxt:getChildSizeDeltaX()
self.txtList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.txtList:getChildLayoutGroupGridItem(index-1)
local data=data.list[index]
local checkStr=comHelper.getCheckLayoutStr(self.checkTxt:getGameObject(),textViewWidth,data)
item:SetChildText(-1,checkStr)
end)
end
end

function UIAgreementWin:onHide()

end

function UIAgreementWin:transOldData(cfg)
local data={name=cfg.name,list={}}
local list=data.list
local addIndex=1
list[addIndex]=cfg.content

if cfg.content2 then
addIndex=addIndex+1
list[addIndex]=cfg.content2
end

if cfg.content3 then
addIndex=addIndex+1
list[addIndex]=cfg.content3
end

if cfg.content4 then
addIndex=addIndex+1
list[addIndex]=cfg.content4
end
if cfg.content5 then
addIndex=addIndex+1
list[addIndex]=cfg.content5
end

return data
end




function UIAgreementWin:OnClickClose()
self:closeSelf()
end
