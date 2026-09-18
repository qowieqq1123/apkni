







def_class("UITianShuDaZhenOtherUseWin",UIWindowBase)









function UITianShuDaZhenOtherUseWin:bindComponents()

self.item=UIObject.get(self,0)



end


function UITianShuDaZhenOtherUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.item);self.item=nil;
end



















function UITianShuDaZhenOtherUseWin:onLoaded(...)
self:bindComponents()
end


function UITianShuDaZhenOtherUseWin:__delete()
self:unbindComponents()
end




function UITianShuDaZhenOtherUseWin:onShow(argtable,afterOnloaded)
local actorid=argtable and argtable.actorid or nil
self.actorid=actorid
self:refreshInfo()
end


function UITianShuDaZhenOtherUseWin:onHide()

end



function UITianShuDaZhenOtherUseWin:refreshInfo()
local tqbuffid=tianshudazhenModel:getShenDunTeQuanBuffId()
local cfg=cfg_fairylandbuffconfig_get(tqbuffid)
local widget=self.item:getChildWidgetBase()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
local tqcfg=cfg_xianguanprivilegeconfig_get(tqid)
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
local iconName=xianguanConfig.getTeQuanIconName(tqcfg.icon)
widget:SetChildIcon(11,iconName,false)

widget:SetChildActive(10,false)
widget:SetChildActive(13,true)
widget:SetChildText(0,cfg.name)
widget:SetChildText(1,cfg.desc)

local maxtimes=tianshudazhenModel:getMaxXgHuDunUseCnt()
local usetimes=tianshudazhenModel:getXgHuDunUseCnt()
local hastimes=maxtimes-usetimes
local cntStr=hastimes>0 and FMT.fmt('<color=#aae252>{0}</color>',hastimes)or FMT.cfmt(FONT_COLOR.eRedColor,hastimes)
local desc=FMT.fmt('使用\n{0}/{1}',cntStr,maxtimes)
widget:SetChildText(4,desc)
widget:SetChildActive(5,hastimes<maxtimes)
widget:SetChildActive(7,false)
widget:SetChildActive(12,false)
local descStr=cfg.desc
if cfg.tipsDesc then
descStr=FMT.fmt('{0}\n{1}',descStr,cfg.tipsDesc)
end
local tqName=tqcfg.name
widget:SetChildButtonClick(12,function()
UIManager:showWindow('UITianShuDaZhenTeQuanTips',{name=tqName,
str=descStr,
pos=widget:GetChildScreenPointToLocalPointRectangle(12),
offsetPos=Vector2.zero})
end,true)
widget:SetChildButtonClick(3,function()
self:useShenDunTeQuan()
end,true)

if self.useBuffTimer then
self:stopTimerByID(self.useBuffTimer)
end
self.useBuffTimer=nil

if hastimes<maxtimes then
local func=function()
local leftTime=tianshudazhenModel:getUseXgTeQuanLeftTime()
leftTime=math.max(leftTime,0)
if leftTime>0 then
widget:SetChildText(6,timeHelper.format_time_stamp(leftTime))
else
widget:SetChildActive(5,false)
if self.useBuffTimer then
self:stopTimerByID(self.useBuffTimer)
end
self.useBuffTimer=nil
end
end
self.useBuffTimer=self:setTimer(0.7,0,func)
func()
end
end

function UITianShuDaZhenOtherUseWin:useShenDunTeQuan()
local zmData=xianjieModel:getZongMenData(self.actorid)
if zmData==nil then
UIManager.error('进入仙界后方可使用')
return
end
local func=function()
tianshudazhenModel:useShenDunTeQuan(self.actorid)
end
local isOpenTianShuShenDun=xianjieModel:isOpenTianShuShenDun(self.actorid)
local isOpenFangHuZhao=xianjieModel:isOpenFangHuZhao(self.actorid)

if isOpenTianShuShenDun or isOpenFangHuZhao then
local desc='尊敬的天枢龙卫，该宗门已开启护山大阵，是否继续为对方开启？\n<color=#c0703b>（可无视煞气入侵状态）</color>'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
return
end

local desc='尊敬的天枢龙卫，是否为对方开启天枢大阵？\n<color=#c0703b>（可无视煞气入侵状态）</color>'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
end