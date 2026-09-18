







def_class("UIWuXingDianFightFaZeWin",UIWindowBase)









function UIWuXingDianFightFaZeWin:bindComponents()

self.fzBg=UIButton.get(self,0)
self.fzName=UIText.get(self,1)
self.layer=UIText.get(self,2)
self.helpBtn=UIButton.get(self,3)

self.fzBg:setButtonClick(function()self:onFzBg()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIWuXingDianFightFaZeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fzBg);self.fzBg=nil;
_UIObject_release(self.fzName);self.fzName=nil;
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
end


















function UIWuXingDianFightFaZeWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.onBattleRoundChange,function(...)
self:onBattleRoundChange(...)
end)
end

function UIWuXingDianFightFaZeWin:__delete()
self:unbindComponents()
end
function UIWuXingDianFightFaZeWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
self.wxdId=argtable.temple_id
local layer=argtable.layer

self.jie=argtable.jie
self.battleId=argtable.battleId
self.layer:setText(FMT.fmt('第{0}层',layer))
self:freshFZ()
end

function UIWuXingDianFightFaZeWin:onHide()

end



function UIWuXingDianFightFaZeWin:onFzBg()
self:onHelpBtn()
end



function UIWuXingDianFightFaZeWin:onHelpBtn()
local wxdId=self.wxdId
local jie=self.jie
local battle=fightModel:getBattle(self.battleId)
local round=battle:getRoundIndexInfo()
if round<=0 then round=1 end
local desc=''
if wuXingDianConfig.isSD(wxdId)then
local groupId=wuXingDianModel:getSDGroupIdByJie(jie)
local groupcfg=cfg_fiveelementsholytemplegroupconfig_get(groupId)
local fightfztips=groupcfg.fightfztips
local descFMT=fightfztips.desc
local params=fightfztips.params[round]
desc=FMT.fmt(descFMT,unpack(params))
else
local wxdCfg=cfg_fiveelementstempleconfig_get(wxdId)
local fightfztips=wxdCfg.fightfztips
local descFMT=fightfztips.desc
local params=fightfztips.params[round]
desc=FMT.fmt(descFMT,unpack(params))
end
local offset=Vector2.New(0,-35)
UIManager:showWindow('UIConditionTipsThree',{showType=4,
str=desc,
posItem=self.helpBtn,
pos=offset,
maxWidth=338})
end

function UIWuXingDianFightFaZeWin:freshFZ()
local wxdId=self.wxdId
local jie=self.jie
local battle=fightModel:getBattle(self.battleId)
local round=battle:getRoundIndexInfo()
if round<=0 then round=1 end
if wuXingDianConfig.isSD(wxdId)then
local groupId=wuXingDianModel:getSDGroupIdByJie(jie)
local groupcfg=cfg_fiveelementsholytemplegroupconfig_get(groupId)
local desc=groupcfg.fightfztips.name[round]
if desc==nil then
loggerUtil.logErrFMT('圣殿第{0}回合法则配置fightfztips->name为空',round)
end
desc=FMT.cfmt3(groupcfg.fazcolor,desc)
local fazbgid=groupcfg.fazbg
self.fzName:setText(desc)
iconHelper.setChildIcon(self.winlua,self.fzBg:getID(),fazbgid)
else
local wxdCfg=cfg_fiveelementstempleconfig_get(wxdId)
local desc=cfgHelper.get4(cfg_fiveelementstempleconfig_get,wxdId,'fightfztips','name',round)
if desc==nil then
loggerUtil.logErrFMT('五行{0}殿第{1}回合法则配置fightfztips->name为空',wuXingDianTypeName[wxdId],round)
end
desc=FMT.cfmt3(wxdCfg.fazcolor,desc)
local fazbgid=wxdCfg.fazbg
self.fzName:setText(desc)
iconHelper.setChildIcon(self.winlua,self.fzBg:getID(),fazbgid)
end
end

function UIWuXingDianFightFaZeWin:onBattleRoundChange(battleId,oldround,newround)

if self.battleId==battleId then
self:freshFZ()
end
end
