







def_class("UIXM_ZZSH_EnterMainWin",UIWindowBase)









function UIXM_ZZSH_EnterMainWin:bindComponents()

self.baomingBtn=UIButton.get(self,0)
self.openlogBtn=UIButton.get(self,1)
self.root=UIObject.get(self,2)
self.setBtn=UIButton.get(self,3)

self.baomingBtn:setButtonClick(function()self:onBaomingBtn()end)

self.openlogBtn:setButtonClick(function()self:onOpenlogBtn()end)

self.setBtn:setButtonClick(function()self:onSetBtn()end)



end


function UIXM_ZZSH_EnterMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.baomingBtn);self.baomingBtn=nil;
_UIObject_release(self.openlogBtn);self.openlogBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.setBtn);self.setBtn=nil;
end
















local _this


function UIXM_ZZSH_EnterMainWin:onLoaded(...)
_this=self
self:bindComponents()
local weakGuideThinking=zhengzhanshanhaiController:getZZSHCfg('weakGuideThinking')
weakGuideThinkingController:doThinkingLine(weakGuideThinking)

local guildid=xianmengModel:getMyXMGuildID()
if guildid then
local myActorid=playerModel:getActorID()
if xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign)then
xianmengController:reqXMMemberList(guildid)
end
end
end


function UIXM_ZZSH_EnterMainWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_EnterMainWin:onHide()

end




function UIXM_ZZSH_EnterMainWin:onShow(argtable,afterOnloaded)
self:refreshSettingModel()
end

function UIXM_ZZSH_EnterMainWin:onBaomingBtn()
if not xianmengModel:hasXM()then
return
end
local myActorid=playerModel:getActorID()
if not xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign)then
UIManager.error('只有盟主或副盟主可以报名参加')
return
end
if not zhengzhanshanhaiModel:checkJoin()then
local guildid=xianmengModel:getMyXMGuildID()
local num=xianmengModel:getSearchXMHuoYueNum(guildid)
if num==nil then
UIManager.error('仙盟成员7日活跃人数查询中，请稍后尝试')
return
end
local attend=zhengzhanshanhaiController:getZZSHCfg('attend')
if num<attend then
UIManager.error(FMT.fmt('仙盟7日活跃人数不足{0}人，报名失败',attend))
return
end
zhengzhanshanhaiController:reqJoin()
end
end



function UIXM_ZZSH_EnterMainWin:onSetBtn()
UIManager:showWindow("UIXM_ZZSH_settingWin")
end

function UIXM_ZZSH_EnterMainWin:refreshSettingModel()
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1

end


function UIXM_ZZSH_EnterMainWin:onOpenlogBtn()
zhengzhanshanhaiController:OpenZhengZhanShanHaiMonsterLog()
end