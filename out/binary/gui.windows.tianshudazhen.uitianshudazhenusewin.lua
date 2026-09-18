







def_class("UITianShuDaZhenUseWin",UIWindowBase)









function UITianShuDaZhenUseWin:bindComponents()

self.fzCreator=UIObject.get(self,0)



end


function UITianShuDaZhenUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fzCreator);self.fzCreator=nil;
end


















function UITianShuDaZhenUseWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,function(...)
self:onMoneyChanged(...)
end)
self.useBuffTimer={}
end

function UITianShuDaZhenUseWin:__delete()
self:unbindComponents()
end

function UITianShuDaZhenUseWin:onShow(argtable,afterOnloaded)
local actorid=argtable and argtable.actorid or nil
if actorid then
self.isSelf=playerModel:checkActorId(actorid)
else
self.isSelf=true
end
self.actorid=actorid or playerModel:getActorID()
self:refreshInfo()
end

function UITianShuDaZhenUseWin:onHide()

end




function UITianShuDaZhenUseWin:refreshInfo()
local bufflist__=tianshudazhenConfig.getTianShuDaZhenBufflist()
local tqbuffid=tianshudazhenModel:getShenDunTeQuanBuffId()
local hasXgJob=false
local bufflist=bufflist__
if hasXgJob then
bufflist={}
bufflist[#bufflist+1]=tqbuffid
if self.isSelf then
bufflist=table.concatTable(bufflist,bufflist__)
end
end

local len=#bufflist
for _,v in pairs(self.useBuffTimer)do
self:stopTimerByID(v)
end
self.useBuffTimer={}

self.winlua:SetChildLayoutGroupCreateItems(self.fzCreator:getID(),len,function(index)
local widget=self.winlua:GetChildLayoutGroupGridItem(self.fzCreator:getID(),index-1)
local buffid=bufflist[index]
local cfg=cfg_fairylandbuffconfig_get(buffid)
local consume=cfg.consume
local cost=consume and consume[1]or nil
local itemid=cost and cost[1]or nil
local need=cost and cost[2]or 0
local isxgJob=hasXgJob and buffid==tqbuffid

widget:SetChildText(0,cfg.name)
widget:SetChildText(1,cfg.desc)
widget:SetChildActive(13,isxgJob)
widget:SetChildActive(10,not isxgJob)

if not isxgJob then
widget:SetChildQulaity(10,eQualityColor.eBlue)
widget:SetChildIcon(11,cfg.iconNmae,true)
else
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
local tqcfg=cfg_xianguanprivilegeconfig_get(tqid)
local iconName=xianguanConfig.getTeQuanIconName(tqcfg.icon)
widget:SetChildIcon(11,iconName,true)
end

if isxgJob then
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
local tqcfg=cfg_xianguanprivilegeconfig_get(tqid)
local maxtimes=tianshudazhenModel:getMaxXgHuDunUseCnt()
local times=tianshudazhenModel:getXgHuDunUseCnt()
local hastimes=maxtimes-times
local cntStr=hastimes>0 and FMT.fmt('<color=#aae252>{0}</color>',hastimes)or FMT.cfmt(FONT_COLOR.eRedColor,hastimes)
local desc=FMT.fmt('使用\n{0}/{1}',cntStr,maxtimes)
widget:SetChildText(4,desc)
widget:SetChildActive(5,hastimes<maxtimes)
widget:SetChildActive(7,false)
widget:SetChildActive(12,true)
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

if hastimes<maxtimes then
local func=function()
local leftTime=tianshudazhenModel:getUseXgTeQuanLeftTime()
leftTime=math.max(leftTime,0)
if leftTime>0 then
widget:SetChildText(6,timeHelper.format_time_stamp(leftTime))
else
widget:SetChildActive(5,false)
if self.useBuffTimer[buffid]then
self:stopTimerByID(self.useBuffTimer[buffid])
self.useBuffTimer[buffid]=nil
end
end
end
self.useBuffTimer[buffid]=self:setTimer(0.7,0,func)
func()
end
elseif itemid==eMoneyType.mtTSDZConsume then
local maxtimes=tianshudazhenConfig:getMaxFHZFreeTimes()
local hastimes=tianshudazhenModel:getHasFHZFreeTimes()
local cntStr=hastimes>0 and FMT.fmt('<color=#aae252>{0}</color>',hastimes)or FMT.cfmt(FONT_COLOR.eRedColor,hastimes)
local desc=FMT.fmt('使用\n{0}/{1}',cntStr,maxtimes)
local btnTxt=desc
widget:SetChildText(4,btnTxt)
widget:SetChildActive(5,hastimes<maxtimes)
widget:SetChildActive(7,false)
widget:SetChildButtonClick(3,function()
self:useBuff(buffid,cfg)
end,true)
widget:SetChildActive(12,false)
if hastimes<maxtimes then
local func=function()
local leftTime=moneyAutoIncreaseModel:getLeastTime(itemid)
leftTime=math.max(leftTime,0)
widget:SetChildText(6,timeHelper.format_time_stamp(leftTime))
end
self.useBuffTimer[buffid]=self:setTimer(0.7,0,func)
func()
end
else
local enough=itemsModel.checkItemEnough(itemid,need)
widget:SetChildText(4,'使用')
widget:SetChildActive(5,false)
widget:SetChildActive(7,true)
widget:SetChildIcon(8,iconHelper.getIconName(itemid),false)

local str=enough and need or FMT.cfmt(FONT_COLOR.eRedColor,need)
local hasCnt=itemsModel.getCount(itemid)

if hasCnt==0 then
widget:SetChildText(9,str)
else
local desc=FMT.fmt('{0}/{1}',str,hasCnt)
widget:SetChildText(9,desc)
end
widget:SetChildButtonClick(3,function()
self:useBuff(buffid,cfg)
end,true)
widget:SetChildActive(12,false)
end
end)
end

function UITianShuDaZhenUseWin:useBuff(buffid,cfg)
if not xianjieModel:checkJoin()then
UIManager.error('尚未进入仙域，无法开启护山大阵')
return
end
if tianshudazhenModel:isDisableOpenFHZ()then
UIManager.error('已被煞气入侵，无法开启护山大阵')
return
end

if tianshudazhenConfig.getFreeFHZBuffId()==buffid then
if tianshudazhenModel:getHasFHZFreeTimes()<=0 then
UIManager.error('免费次数已用完')
return
end
end

local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
if isInMoJie and xianjieModel:getMyCanTzMoJun()then
UIManager.error('魔君挑战区域无法开启护山大阵')
return
end

local consume=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffid,'consume')
if consume then
for i,v in ipairs(consume)do
local itemId=v[1]
if not itemsModel.checkItemEnough(itemId,v[2])then
gainControl:showGainWin(itemId)
local name=itemsConfig.getItemName(itemId)
UIManager.error(FMT.fmt('{0}不足',name))
return
end
end
end


local leftTime=tianshudazhenModel:getOpeningDaZhenLeftTime()
local max=tianshudazhenConfig.getMaxFHZValue()
if leftTime>=max then
UIManager.error('已超防护罩持续上限')
return
end
leftTime=leftTime+cfg.duration

local func=function()
local func1=function()
tianshudazhenController.reqUseBuff(buffid)
end
if leftTime>max then
local overTime=leftTime-max
local overTimeStr=timeHelper.format_time_stamp16(overTime)
local desc=FMT.fmt('继续使用防护罩时间将溢出{0},请问是否继续？',overTimeStr)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func1)
return
end
func1()
xianjieController:reqMassYBDChangeOpenFlagWithType(xjJjJieBaseType.eWar,false)
end

if xianjieModel:checkHasJiJieYBDIsOpen(xjJjJieBaseType.eWar)then
local args={}
args.content='已开启战争预备队，是否关闭预备队并开启护山大阵？'
args.title='提示'
args.okcallback=func
args.oktext='确定'
args.canceltext='取消'
args.choosetext="护山大阵结束后自动开启战争预备队"
args.choosecallback=function(flag)
tianshudazhenModel:setLocalJiJieYBDData(flag)
end
self:showWindow('UITianShuDaZhenDialouge',args)
else
func()
end
end

function UITianShuDaZhenUseWin:onMoneyChanged(moneyType)
if moneyType==eMoneyType.mtTSDZConsume then
self:refreshInfo()
end
end

function UITianShuDaZhenUseWin:useShenDunTeQuan()
local func=function()
tianshudazhenModel:useShenDunTeQuan(self.actorid)
end
if tianshudazhenModel:isOpeningTianShuShenDun()then
local desc='尊敬的天枢龙卫，本宗门已开启护山大阵，是否继续开启？\n<color=#c0703b>（可无视煞气入侵状态）</color>'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
else
func()
end
end