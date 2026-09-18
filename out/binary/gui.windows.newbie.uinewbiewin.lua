







def_class("UINewbieWin",UIWindowBase)









function UINewbieWin:bindComponents()

self.Camera=UIObject.get(self,0)
self.marker=UIObject.get(self,1)
self.npcRoot=UIObject.get(self,2)
self.select=UIObject.get(self,3)
self.finger=UIObject.get(self,4)
self.txtBg=UIObject.get(self,5)
self.effect=UIObject.get(self,6)
self.creater=UIGameobjectClone.new(self,7)
self.txt=UIText.get(self,8)



end


function UINewbieWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Camera);self.Camera=nil;
_UIObject_release(self.marker);self.marker=nil;
_UIObject_release(self.npcRoot);self.npcRoot=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.finger);self.finger=nil;
_UIObject_release(self.txtBg);self.txtBg=nil;
_UIObject_release(self.effect);self.effect=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.txt);self.txt=nil;
end



















function UINewbieWin:onLoaded(...)
self:bindComponents()
end

function UINewbieWin:__delete()
self:unbindComponents()
end

function UINewbieWin:onShow(argtable,afterOnloaded)
self.creater:recycleAll()
local actionConfig=argtable.conf
local entityInfo=argtable.info
local cmpid=argtable.cmpId
local showCameraTransform=self.Camera:getTransform()
local targetCameraTransform=newbieControl.getUITopCamera(actionConfig.threeUI)
if cmpid then
self.winlua:SetChildNewbieMarkerTarget(self.marker:getID(),cmpid,showCameraTransform,targetCameraTransform)
end
local txtPos=actionConfig.txtPos
local selectPos=actionConfig.selectPos

local npc=actionConfig.npc
local npcTxt=actionConfig.npcTxt
local npcOffset=actionConfig.npcOffset

local fingerAsset=actionConfig.finger
local fingerArgs=actionConfig.fingerArgs


if fingerAsset then
self.creater:createObject(fingerAsset,self.finger:getID(),0,fingerArgs)
end
if fingerArgs and fingerArgs.pos then
self.winlua:SetChildLocalPosition(self.finger:getID(),Vector3(fingerArgs.pos[1],fingerArgs.pos[2],0))
end


local selectAsset=actionConfig.select
local selectArgs=actionConfig.selectArgs
if selectAsset then
local args={}
args.args=selectArgs
if entityInfo then
args.entityInfo=entityInfo
elseif cmpid then
args.cmpid=cmpid
end
self.creater:createObject(selectAsset,self.select:getID(),0,args)
end
if selectPos then
self.winlua:SetChildLocalPosition(self.select:getID(),Vector3(selectPos[1],selectPos[2],0))
end



self.txt:setText(actionConfig.txt or'')
if txtPos then
self.winlua:SetChildLocalPosition(self.txtBg:getID(),Vector3(txtPos[1],txtPos[2],0))
end


if actionConfig.effect then
local effect=actionConfig.effect
for i,v in ipairs(effect)do
self.creater:createObject(v[1],self.effect:getID(),0,v[2])
end
end


local npcAsset=actionConfig.npcAsset
local npcArgs=actionConfig.npcArgs
if npcAsset then
self.creater:createObject(npcAsset,self.npcRoot:getID(),0,npcArgs)
end
if npcArgs and npcArgs.pos then
self.winlua:SetChildLocalPosition(self.npcRoot:getID(),Vector3(npcArgs.pos[1],npcArgs.pos[2],0))
end
end

function UINewbieWin:onHide()

end



