







def_class("UISFPYRuleViewWin",UIWindowBase)









function UISFPYRuleViewWin:bindComponents()

self.closebutton=UIButton.get(self,0)
self.select=UIObject.get(self,1)
self.frame=UIImage.get(self,2)
self.name=UIText.get(self,3)
self.icon=UIImage.get(self,4)
self.desc=UIText.get(self,5)
self.quality=UIText.get(self,6)
self.descBg=UIObject.get(self,7)
self.detaildesc=UIText.get(self,8)
self.changebtn=UIButton.get(self,9)
self.closebutton2=UIButton.get(self,10)
self.nepanel=UIObject.get(self,11)
self.arrow=UIObject.get(self,12)
self.card=UIObject.get(self,13)
self.card2=UIObject.get(self,14)
self.select2=UIObject.get(self,15)
self.frame2=UIImage.get(self,16)
self.name2=UIText.get(self,17)
self.icon2=UIImage.get(self,18)
self.desc2=UIText.get(self,19)
self.quality2=UIText.get(self,20)
self.tipstxt=UIText.get(self,21)
self.titleBg=UIButton.get(self,22)
self.numbg=UIObject.get(self,23)
self.fznum=UIText.get(self,24)
self.zhuanshu=UIImage.get(self,25)
self.zhuanshu2=UIImage.get(self,26)

self.closebutton:setButtonClick(function()self:onClosebutton()end)

self.changebtn:setButtonClick(function()self:onChangebtn()end)

self.closebutton2:setButtonClick(function()self:onClosebutton2()end)

self.titleBg:setButtonClick(function()self:onTitleBg()end)



end


function UISFPYRuleViewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closebutton);self.closebutton=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.quality);self.quality=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.detaildesc);self.detaildesc=nil;
_UIObject_release(self.changebtn);self.changebtn=nil;
_UIObject_release(self.closebutton2);self.closebutton2=nil;
_UIObject_release(self.nepanel);self.nepanel=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.card);self.card=nil;
_UIObject_release(self.card2);self.card2=nil;
_UIObject_release(self.select2);self.select2=nil;
_UIObject_release(self.frame2);self.frame2=nil;
_UIObject_release(self.name2);self.name2=nil;
_UIObject_release(self.icon2);self.icon2=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.quality2);self.quality2=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.numbg);self.numbg=nil;
_UIObject_release(self.fznum);self.fznum=nil;
_UIObject_release(self.zhuanshu);self.zhuanshu=nil;
_UIObject_release(self.zhuanshu2);self.zhuanshu2=nil;
end
















local _this
local ab_name="ui/windows/sifangpingyao/sifangpingyao_atlas_pak.ab"

function UISFPYRuleViewWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISFPYRuleViewWin:__delete()
self:unbindComponents()
_this=nil
end




function UISFPYRuleViewWin:onShow(argtable,afterOnloaded)
self.isplaying=false
if argtable then
self.ruleId=argtable.id
self.level=argtable.level or 1
self.changefa=argtable.changefa
self._fznum=argtable.fznum

if self.changefa then
self.changebtn:setActive(true)
else
self.changebtn:setActive(false)
end

local demons_id=SiFangPingYaoModel:getMapIdex()
self.debufflist=cfg_foursideskilldemonsconfig_get(demons_id).debufflist

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

if self.debufflist[self.ruleId]then
self.winlua:SetChildCSImageSprite(self.frame:getID(),ab_name,"frame_fazefumian1")
self.winlua:SetChildText(self.name:getID(),FMT.fmt("<color=#22201f>{0}</color>",name))
end

local isnum=self._fznum
if isnum==0 then
self.numbg:setActive(false)
else
self.numbg:setActive(true)
self.fznum:setText(isnum)
end

if ruleCfg.zhuanshuImg then
self.zhuanshu:setActive(true)
self.winlua:SetChildIcon(self.zhuanshu:getID(),FMT.fmt('image_zhuan_shu_faze_{0}',ruleCfg.zhuanshuImg),true)
else
self.zhuanshu:setActive(false)
end


self.select:setChildShowEffect(10027,true)
end
end
end


function UISFPYRuleViewWin:OnEnable()

end


function UISFPYRuleViewWin:OnDisable()

end


function UISFPYRuleViewWin:onChangebtn()
if self.changefa and self.ruleId and self.level then





self.isplaying=true
self.closebutton:setActive(false)
self.closebutton2:setActive(true)
self.select:setActive(false)
self.select:setChildShowEffect(0,false)

local allfz_list=SiFangPingYaoModel:getBagFZ_list()
local index=0
for k,v in ipairs(allfz_list)do
if v.param_1==self.ruleId and v.param_2==self.level then
index=k
break
end
end
SiFangPingYaoController.send_34_54(1,index)

end
end


function UISFPYRuleViewWin:onClosebutton()

if not _this.isplaying then
UIManager:closeWindow("UISFPYRuleViewWin")
end
end


function UISFPYRuleViewWin:onClosebutton2()

if not _this.isplaying then
local startCallback=function()
UIManager:closeWindow("UISFPYRuleViewWin")
UIManager:closeWindow("UISFPYRuleBagWin")
UIManager:closeWindow("UISiFangPingYaotiaozhanWin")
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
local endCallback=function()
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","showfuhuotxt")
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","openNewZhangjiewin")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback,endCallback=endCallback})
end
end


function UISFPYRuleViewWin:doAnima(new_fazeid,new_fazelvl,new_fazeNun)

self.descBg:setActive(false)
self.changebtn:setActive(false)


local ruleCfg=cfgHelper.getSSlawRule(new_fazeid)
if ruleCfg then
local image=ruleCfg.image
local name=ruleCfg.name
local quality=new_fazelvl
local qualityDesc=cfg_secretscenebaseconfig_get(1).rule_quality
local desc=ruleCfg.desc
local attrdesc=ruleCfg.attrdesc
local descparm=ruleCfg.descparm
if descparm and descparm[new_fazelvl]and next(descparm[new_fazelvl])then
desc=string.format(desc,unpack(descparm[new_fazelvl]))
if attrdesc then
attrdesc=string.format(attrdesc,unpack(descparm[new_fazelvl]))
end
end
local color_cfg=qualityDesc[quality]
self.name2:setText(FMT.fmt("<color=#{0}>{1}</color>",color_cfg[2],name))
self.icon2:setImageIcon(image,false)
self.desc2:setText(desc)

local frameImg=iconHelper.getRuleQualityIcon(quality)
self.frame2:setImageIcon(frameImg,false)

if ruleCfg.zhuanshuImg then
self.zhuanshu2:setActive(true)
self.winlua:SetChildIcon(self.zhuanshu2:getID(),FMT.fmt('image_zhuan_shu_faze_{0}',ruleCfg.zhuanshuImg),true)
else
self.zhuanshu2:setActive(false)
end


self.winlua:SetChildDOLocalMoveX(self.card:getID(),-220,1)
self:delayDo(1,function()
if not _this then return end
self.winlua:SetChildCanvasGroupDOFade(self.nepanel:getID(),1,0.5,function()
self.select2:setChildShowEffect(10027,true)
end)

self.winlua:SetChildLocalPosX(self.arrow:getID(),-220)
self.winlua:SetChildDOLocalMoveX(self.arrow:getID(),0,0.5)

self.winlua:SetChildLocalPosX(self.card2:getID(),-220)
self.winlua:SetChildDOLocalMoveX(self.card2:getID(),220,1)
end)
self:delayDo(2,function()
if not _this then return end
_this.tipstxt:setActive(true)
_this.isplaying=false
end)
end
end
