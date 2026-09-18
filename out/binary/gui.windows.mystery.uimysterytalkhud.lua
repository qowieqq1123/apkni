







def_class("UIMysteryTalkHUD",UICloneObject)





UIMysteryTalkHUD.abName="ui/windows/mystery/uimysterytalkhud.ab"

UIMysteryTalkHUD.assetName="UIMysteryTalkHUD"


function UIMysteryTalkHUD:bindComponents()

self.biaoqingTxt=UILinkImageText.get(self,0)
self.text=UIText.get(self,1)
self.Root=UIObject.get(self,2)
self.biaoqingObj=UIObject.get(self,3)
self.image=UIImage.get(self,4)
self.image2=UIImage.get(self,5)
self.image3=UIObject.get(self,6)

end


function UIMysteryTalkHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.biaoqingTxt);self.biaoqingTxt=nil;
_UIObject_release(self.text);self.text=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.biaoqingObj);self.biaoqingObj=nil;
_UIObject_release(self.image);self.image=nil;
_UIObject_release(self.image2);self.image2=nil;
_UIObject_release(self.image3);self.image3=nil;
end









function UIMysteryTalkHUD:onLoaded(...)
self:bindComponents()
self.updateTimer=self:setTimer(0.05,0,function()self.onUpdate(self)end)
end


function UIMysteryTalkHUD:__delete()
self.image:setActive(false)
self.image2:setActive(false)
self.image3:setActive(false)
self:unbindComponents()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end




function UIMysteryTalkHUD:onShow(argtable,afterOnloaded)
local talkId=argtable.talkId
local delay=argtable.delay or 3
self.eType=argtable.bindType
self.guid=argtable.bindguid
local str=argtable.str
local filpX=argtable.flipX
local ganhanhao=argtable.ganhanhao
local randomStrId=argtable.randomId
local ganhanhao2=argtable.ganhanhao2
local callback=argtable.callback

if str then
self.biaoqingObj:setActive(true)
self.biaoqingObj:setChildCanvasGroupAlpha(0)
self.text:setText(str)
self.biaoqingObj:setChildCanvasGroupDOFade(1,0.2,nil)
elseif talkId then
self.biaoqingObj:setActive(true)
self.biaoqingObj:setChildCanvasGroupAlpha(0)
local dialoguecfg=cfgHelper.get1(cfg_storydialogueconfig_get,talkId)
local emot=dialoguecfg.emot
local desc=dialoguecfg.dialogue or""
if emot then
self.biaoqingTxt:setActive(true)
self.biaoqingTxt:setText(chatEmotHelper.decodeEmot(emot))
else
self.biaoqingTxt:setActive(false)
end


self.text:setText(desc)
self.biaoqingObj:setChildCanvasGroupDOFade(1,0.2,nil)
elseif ganhanhao then
if filpX then
self.Root:setScale(Vector3.New(-1,1,1))
end
self.biaoqingObj:setChildCanvasGroupAlpha(0)
self.image:setActive(true)
elseif randomStrId then
self.biaoqingObj:setActive(true)
self.biaoqingObj:setChildCanvasGroupAlpha(0)

local dialoguecfg=cfgHelper.get(cfg_ssentitytalkerconfig_get,randomStrId,"text")
if dialoguecfg then
local desc=dialoguecfg[math.random(1,#dialoguecfg)]
self.text:setText(desc)
self.biaoqingObj:setChildCanvasGroupDOFade(1,0.2,nil)
end
elseif ganhanhao2 then
self.biaoqingObj:setChildCanvasGroupAlpha(0)
self.image3:setActive(true)
end

self:setTimer(delay,1,function()
if callback then
callback()
end
self:recycleSelf()
end)
end

function UIMysteryTalkHUD.onUpdate(win)
if win then
if win.guid then
local hudPos=mysteryEntityController.invokeFuncByMysteryEntityType(win.eType,"get_hud_position",win.guid)
win:refreshPosition(hudPos)
end
end
end

function UIMysteryTalkHUD:refreshPosition(hudPos)
if self.Root then
self:setChildPosition(self.Root:getID(),hudPos)
end
end


function UIMysteryTalkHUD:onHide()

end


