







def_class("UIXianJieExtra_ZTMJunWin",UIWindowBase)









function UIXianJieExtra_ZTMJunWin:bindComponents()

self.boxItem=UIObject.get(self,0)
self.clickMask=UIObject.get(self,1)
self.effBtn=UIButton.get(self,2)
self.effect=UIObject.get(self,3)
self.effReddot=UIObject.get(self,4)
self.helpBtn=UIButton.get(self,5)
self.normalPanel=UIObject.get(self,6)
self.timeText=UIText.get(self,7)
self.topBg=UIButton.get(self,8)
self.uiroot=UIObject.get(self,9)
self.mjimg1=UIObject.get(self,10)
self.mjimg2=UIObject.get(self,11)
self.mjBtn2=UIButton.get(self,12)
self.xijiimg=UIButton.get(self,13)
self.xijiimgtime=UIText.get(self,14)

self.effBtn:setButtonClick(function()self:onEffBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.topBg:setButtonClick(function()self:onTopBg()end)

self.mjBtn2:setButtonClick(function()self:onMjBtn2()end)

self.xijiimg:setButtonClick(function()self:onXijiimg()end)



end


function UIXianJieExtra_ZTMJunWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.boxItem);self.boxItem=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.effBtn);self.effBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effReddot);self.effReddot=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.normalPanel);self.normalPanel=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.topBg);self.topBg=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.mjimg1);self.mjimg1=nil;
_UIObject_release(self.mjimg2);self.mjimg2=nil;
_UIObject_release(self.mjBtn2);self.mjBtn2=nil;
_UIObject_release(self.xijiimg);self.xijiimg=nil;
_UIObject_release(self.xijiimgtime);self.xijiimgtime=nil;
end
















local _this
local zfindex=
{
selfitem=0,
icon=1,
name=2,
time=3,
bgzfimg=4,
bgzftxt=5,
csimg=6,
cstxt=7
}
local _abname="ui/windows/mojiemojun/mojiemojun_atlas_pak.ab"



function UIXianJieExtra_ZTMJunWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onXianJieMoJunKill,function()self:onEndAct()end)
end


function UIXianJieExtra_ZTMJunWin:__delete()
self:unbindComponents()
self:clearTimer()
self:clearTimer2()
_this=nil
end




function UIXianJieExtra_ZTMJunWin:onShow(argtable,afterOnloaded)
local guildid=xianmengModel:getMyXMGuildID()
if guildid then
xianmengController:reqXMMemberListCheckCD(guildid)
end
self.zmData=xianjieModel:getMyZongMenData()
self:refresh()
end


function UIXianJieExtra_ZTMJunWin:onHide()

end

function UIXianJieExtra_ZTMJunWin:refresh()
local mojunData=xianjieModel:getMoJunData()
self.topBg:setActive(mojunData.timeType==2)
self.boxItem:setActive(mojunData.timeType==4)

self:refreshBox()
self:refreshEffBtn()


self.MJZJID=xianjieModel:getMoJunZhangJieID()
if self.MJZJID==MoJunZhangJieID.two then
self.effBtn:setActive(false)
self.mjimg1:setActive(false)
self.mjimg2:setActive(true)

local widget=self.boxItem:getChildWidgetBase()
widget:SetChildActive(3,false)
widget:SetChildActive(4,true)


self:refreshZFBtn()
end

if mojunData.timeType==2 or mojunData.timeType==4 then
self.timeType=mojunData.timeType
self.endTime=mojunData.endTime

self:setRemainingTimeTimer()
else
self:clearTimer()
end
end

function UIXianJieExtra_ZTMJunWin:refreshEffBtn()
if self.MJZJID==MoJunZhangJieID.one then
local mojunData=xianjieModel:getMoJunData()
if mojunData.timeType==2 then
local effList=xianjieModel:getMoJunEffectList(mojunData.seasonType,mojunData.stageIndex)
local fenshenList=xianjieModel:getMoJunFenShenEffectDatas()
local isHasEff=effList~=nil and next(effList)~=nil
local isHasFS=fenshenList~=nil and next(fenshenList)~=nil
local isShow=isHasEff or isHasFS
local isHasNew=xianjieModel:getIsHasNewMoJunEffect()
self.effBtn:setActive(isShow)
self.effReddot:setActive(isShow and isHasNew)
else
self.effBtn:setActive(false)
end
end
end

function UIXianJieExtra_ZTMJunWin:refreshBox()
local mojunData=xianjieModel:getMoJunData()
if mojunData.timeType==4 then
local firstTemp,num=xianjieModel:getMoJunFirstBox(mojunData.seasonType,mojunData.stageIndex)
local widget=self.boxItem:getChildWidgetBase()
widget:SetChildText(0,FMT.fmt("待采集{0}个",num))
widget:SetChildButtonClick(2,function()
local curFirstTemp=xianjieModel:getMoJunFirstBox(mojunData.seasonType,mojunData.stageIndex)
if curFirstTemp~=nil then
xianjieController:openMoJunBoxWin(curFirstTemp.boxId)
end
end)
end
end


function UIXianJieExtra_ZTMJunWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=timeHelper.getServerShortTime()
local lerp=self.endTime-nowTime
if lerp>0 then

if self.timeType==2 then
self.timeText:setText(timeHelper.format_time_stamp3(lerp))
self:refreshEffBtn()
self:refreshZFBtn()
end
if self.timeType==4 then
local widget=self.boxItem:getChildWidgetBase()
widget:SetChildText(1,timeHelper.format_time_stamp3(self.endTime-nowTime))
end
else
self.timeText:setText("已结束")
UIManager.error("魔君已结束")
self:clearTimer()
self:onEndAct()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UIXianJieExtra_ZTMJunWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end



function UIXianJieExtra_ZTMJunWin:onEndAct()

self.normalPanel:setActive(false)
self.clickMask:setActive(true)

self:delayDo(2,function()

UIManager:invokeUIMethod("UIXianJieMainWin","refreshLeftMenuExPanel")

self:closeSelf()
end)
end






function UIXianJieExtra_ZTMJunWin:onTopBg()
self:onHelpBtn()
end



function UIXianJieExtra_ZTMJunWin:onHelpBtn()






local args={
ruleGroupID=ruleTipsImageGroup.eZhengTaoMoJun,
}
if self.MJZJID==MoJunZhangJieID.two then
args={ruleGroupID=ruleTipsImageGroup.eZhengTaoMoJun2,}
end
UIManager:showWindow("UIRuleTipsImage2Win",args)
end

function UIXianJieExtra_ZTMJunWin:onEffBtn()
xianjieModel:setIsHasNewMoJunEffect(false)
self.effReddot:setActive(false)
local winParams={
parentWin=self,
}
self:showWindow("UIXianJieExtra_ZTMJunTipsWin",winParams)
end


function UIXianJieExtra_ZTMJunWin:refreshZFBtn()
self.mjBtn2:setActive(false)
if self.MJZJID==MoJunZhangJieID.two then
local mojunData=xianjieModel:getMoJunData()
if mojunData.timeType==2 then
local effList=xianjieModel:getMoJunEffectList(mojunData.seasonType,mojunData.stageIndex)

local nowTime=timeHelper.getServerShortTime()
if effList and effList[1]then
local effIdx=effList[1]
self._effIdx=effIdx
local data=xianjieModel:getMoJunEffectRange(mojunData.seasonType,mojunData.stageIndex,effIdx)
_this.exdata=data
local confid=data.confid or 0
if confid>0 then
local zmData=self.zmData
self._confid=confid
self.mjBtn2:setActive(true)

local cfg=cfg_seasonmojuneffectconfig_get(confid)
local widget=self.mjBtn2:getChildWidgetBase()
widget:SetChildCSImageSprite(zfindex.icon,_abname,cfg.icon)


if cfg.effectType==ZhenFaeffectType.guaXiang then
widget:SetChildActive(zfindex.bgzfimg,true)
else
widget:SetChildActive(zfindex.bgzfimg,false)
end
if cfg.effectType==ZhenFaeffectType.douZhuan then
widget:SetChildActive(zfindex.csimg,true)
else
widget:SetChildActive(zfindex.csimg,false)
end


local endTime=data.endTime-1
local name=cfg.name
local effectType=cfg.effectType
local effectParam=cfg.effectParam
local guildid=xianmengModel:getMyXMGuildID()



widget:SetChildText(zfindex.name,name)
local lerp=endTime-nowTime
if lerp>0 then
widget:SetChildText(zfindex.time,timeHelper.format_time_stamp3(lerp))


local effectIndex=0
local str
if _this.exdata and _this.exdata.twodata then
str=_this.exdata.twodata.ex_jsonStr
end
if str and str~=""then
local decode=jsonHelper.decode(str)
effectIndex=decode[1]
end
self:setGuaXiangImg(widget,effectType,guildid,effectIndex)


self:checkDZTimeChange(widget,effectType,effectParam,endTime,nowTime)




else
self.mjBtn2:setActive(false)
end
end
end

self:showXiJiTime(nowTime)
end
end
end

function UIXianJieExtra_ZTMJunWin:setRemainingTimeTimer2(endTime,confid)
self:clearTimer2()
local cfg=cfg_seasonmojuneffectconfig_get(confid)
local widget=self.mjBtn2:getChildWidgetBase()
widget:SetChildText(2,cfg.name)
local func=function()
local nowTime=timeHelper.getServerShortTime()
local lerp=endTime-nowTime
if lerp>0 then
widget:SetChildText(3,timeHelper.format_time_stamp3(lerp))
else
self:clearTimer2()
self.mjBtn2:setActive(false)
end
end
func()
self.timer2=self:setTimer(1,0,func)
end

function UIXianJieExtra_ZTMJunWin:clearTimer2()
if self.timer2 then
self:stopTimerByID(self.timer2)
self.timer2=nil
end
end

function UIXianJieExtra_ZTMJunWin:onMjBtn2()
local mojunData=xianjieModel:getMoJunData()
if mojunData then
local build_id=mojunData.build_id
local _index=1
if _this.exdata and _this.exdata.twodata then
local str=_this.exdata.twodata.ex_jsonStr
if str and str~=""then

local decode=jsonHelper.decode(str)
_index=decode[1]
end
end
local winParams={
parentWin=self,
seasonType=mojunData.seasonType,
stageIndex=mojunData.stageIndex,
build_id=build_id,
confid=self._confid,
areaId=1,
zfindex=_index,
idx=_this._effIdx,
}
self:showWindow("UIMoJieMoJunAreaEffectTipsWin",winParams)
end
end

function UIXianJieExtra_ZTMJunWin:onXijiimg()
local mojunData=xianjieModel:getMoJunData()
if mojunData then
local build_id=mojunData.build_id
local winParams={
parentWin=self,
seasonType=mojunData.seasonType,
stageIndex=mojunData.stageIndex,
build_id=build_id,
confid=7,
areaId=1,
idx=_this._effIdx,
}
self:showWindow("UIMoJieMoJunAreaEffectTipsWin",winParams)
end
end


function UIXianJieExtra_ZTMJunWin:setGuaXiangImg(widget,effectType,guildid,effectIndex)
if effectType==ZhenFaeffectType.guaXiang then
local flag=self:checkXMposChange(effectIndex,guildid)

if flag then
widget:SetChildText(zfindex.bgzftxt,"<color=#EFB150>已有盟友处于弱点位置</color>")
else
widget:SetChildText(zfindex.bgzftxt,"<color=#f36666>暂无盟友处于弱点位置</color>")
end
end
end

function UIXianJieExtra_ZTMJunWin:checkXMposChange(effectIndex,guildid)
local xmlist=xianmengModel:getSearchXMMemberList(guildid)
if xmlist and next(xmlist)then
for k,actorData in pairs(xmlist)do
local zmData=xianjieModel:getZongMenData(actorData.actorid)
if zmData then

local gridX=zmData.gridX
local gridZ=zmData.gridZ




if self:checkXMposChangeTwo(effectIndex,gridX,gridZ)then
return true
end
end
end
end
return false
end

function UIXianJieExtra_ZTMJunWin:checkXMposChangeTwo(effectIndex,gridX,gridZ)
for temp_x=gridX,gridX+2-1 do
for temp_y=gridZ,gridZ+2-1 do
if xianjieModel:checkZFGridLimit(effectIndex,temp_x,temp_y)then
return true
end
end
end
return false
end



function UIXianJieExtra_ZTMJunWin:checkDZTimeChange(widget,effectType,effectParam,endTime,nowTime)
if effectType==ZhenFaeffectType.douZhuan then
local jiange=effectParam[1]

local dalytime=endTime-nowTime
local shengyutiem=dalytime%jiange

widget:SetChildText(zfindex.cstxt,FMT.fmt("<color=#EFB150>传送：</color>{0}",timeHelper.format_time_stamp3(shengyutiem)))
if shengyutiem==0 then
widget:SetChildActive(zfindex.csimg,false)
end
end
end

function UIXianJieExtra_ZTMJunWin:showXiJiTime(nowTime)
self.xijiimg:setActive(false)
local fsdata
local fenshenList=xianjieModel:getMoJunFenShenEffectDatas()
if fenshenList and next(fenshenList)then
for i=1,#fenshenList do
fsdata=fenshenList[i]
end
if fsdata then
local endTime=fsdata.endTime or 0
local dalytime=endTime-nowTime
if dalytime>0 then
self.xijiimg:setActive(true)
self.xijiimgtime:setText(timeHelper.format_time_stamp3(dalytime))
end
end
end
end



function UIXianJieExtra_ZTMJunWin:checkRLTimeChange(effectType,effectParam,zmData)
if effectType==ZhenFaeffectType.ranLing then
if xianjieModel:checkRanLingZFPos(zmData.gridX,zmData.gridZ,effectParam[3],effectParam[4],effectParam[5],effectParam[6])then
if not UIManager:findActiveWindow("UIMoJieMoJunAttackTipsWin")then
UIManager:showWindow('UIMoJieMoJunAttackTipsWin')
end
end
end
end

function UIXianJieExtra_ZTMJunWin:checkRLTimeClose()
if not xianjieModel:isCloseMoJunAttackWin()then
if UIManager:findActiveWindow("UIMoJieMoJunAttackTipsWin")then
UIManager:closeWindow('UIMoJieMoJunAttackTipsWin')
end
end
end


function UIXianJieExtra_ZTMJunWin:printtttt()

end
function UIXianJieExtra_ZTMJunWin:printtttt2(type,gridX,gridZ)
local flag=xianjieModel:checkZFGridLimit(type,gridX,gridZ)

end
function UIXianJieExtra_ZTMJunWin:printtttt3(type)
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local flag
if zmPos then
local gridX=zmPos[2]
local gridZ=zmPos[3]
local zmData=xianjieModel:getZongMenData(playerModel:getActorID())

if xianjieModel:checkZFGridLimit(type,gridX,gridZ)then
flag=true
end
end

end
