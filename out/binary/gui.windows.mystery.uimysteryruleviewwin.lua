







def_class("UIMysteryRuleViewWin",UIWindowBase)









function UIMysteryRuleViewWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.select=UIObject.get(self,1)
self.frame=UIImage.get(self,2)
self.name=UIText.get(self,3)
self.icon=UIImage.get(self,4)
self.desc=UIText.get(self,5)
self.quality=UIText.get(self,6)
self.descBg=UIObject.get(self,7)
self.detaildesc=UIText.get(self,8)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIMysteryRuleViewWin")end)



end


function UIMysteryRuleViewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.quality);self.quality=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.detaildesc);self.detaildesc=nil;
end



















function UIMysteryRuleViewWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryRuleViewWin:__delete()
self:unbindComponents()
end






function UIMysteryRuleViewWin:onShow(argtable,afterOnloaded)
if argtable then
self.ruleId=argtable.id
self.level=argtable.level or 1
local ruleCfg=cfgHelper.getSSlawRule(self.ruleId)
if ruleCfg then
local image=ruleCfg.image
local name=ruleCfg.name
local quality=self.level
local qualityDesc=cfg_secretscenebaseconfig_get(1).rule_quality
local desc=ruleCfg.desc
local attrdesc=ruleCfg.attrdesc
local descparm=ruleCfg.descparm
if descparm and descparm[self.level]and next(descparm[self.level])then
desc=string.format(desc,unpack(descparm[self.level]))
if attrdesc then
attrdesc=string.format(attrdesc,unpack(descparm[self.level]))
end
end
local color_cfg=qualityDesc[quality]
self.name:setText(FMT.fmt("<color=#{0}>{1}</color>",color_cfg[2],name))
self.icon:setImageIcon(image,false)
self.desc:setText(desc)

if attrdesc then
self.descBg:setActive(true)
self.detaildesc:setText(attrdesc)
else
self.descBg:setActive(false)
end

local frameImg=iconHelper.getRuleQualityIcon(quality)
self.frame:setImageIcon(frameImg,false)

local fzdata=SiFangPingYaoModel:getqyfazedata()
if fzdata then
if fzdata.abname and fzdata.isdebuff then
self.winlua:SetChildCSImageSprite(self.frame:getID(),fzdata.abname,"frame_fazefumian1")
self.name:setText(FMT.fmt("<color=#22201f>{0}</color>",name))

end
end

self.select:setChildShowEffect(10027,true)
end
end
end


function UIMysteryRuleViewWin:OnEnable()

end


function UIMysteryRuleViewWin:OnDisable()

end


