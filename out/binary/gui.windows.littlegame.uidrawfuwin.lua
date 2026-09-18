







def_class("UIDrawFuWin",UIWindowBase)









function UIDrawFuWin:bindComponents()

self.applyBtn=UIButton.get(self,0)
self.drawLevel=UIText.get(self,1)
self.drawpanel=UIObject.get(self,2)
self.drawroot=UIObject.get(self,3)
self.dzModel=UIObject.get(self,4)
self.effect=UIObject.get(self,5)
self.notStart=UIButton.get(self,6)
self.progressbar=UIProgressBarAni.get(self,7)
self.rating=UIText.get(self,8)
self.resetBtn=UIButton.get(self,9)
self.root=UIObject.get(self,10)
self.template=UIObject.get(self,11)
self.timeText=UIText.get(self,12)
self.xianghuo=UIObject.get(self,13)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.notStart:setButtonClick(function()self:onNotStart()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIDrawFuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.drawLevel);self.drawLevel=nil;
_UIObject_release(self.drawpanel);self.drawpanel=nil;
_UIObject_release(self.drawroot);self.drawroot=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.notStart);self.notStart=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.rating);self.rating=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.template);self.template=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.xianghuo);self.xianghuo=nil;
end



















function UIDrawFuWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/fulu/sharedtextures/{0}.ab'
end


function UIDrawFuWin:__delete()

uiAIManager:removeUIInstance(self.currDZ)
uiAIManager:clearUIWinData('UIDrawFuWin')
self:unbindComponents()
end




function UIDrawFuWin:onShow(argtable,afterOnloaded)
self.args=argtable
self.mapId=self.args.mapId

self.isGaming=false
self.notStart:setActive(true)
self.root:setActive(false)

if self.dzId then
self:refreshDzModel()
end
local fbCfg=cfgHelper.get1(cfg_huafuconfig_get,self.mapId)
self.config=fbCfg
self.xianghuo:setActive(false)
UIFullFuLuFangControl:showMoneyTopWin(false)
self.timeText:setText(FMT.fmt('倒计时：{0}',timeHelper.format_time_stamp4(fbCfg.lz_time)))
local lv=fbCfg.success+1
if lv>5 then
lv=5
end
local name=cfgHelper.get2(cfg_fubaoratingconfig_get,lv,'name')
self.drawLevel:setText(FMT.fmt('绘制评级达到<color={0}>{1}</color>即可获胜',FONT_COLOR_VAL[lv],name))
end


function UIDrawFuWin:onHide()

end

function UIDrawFuWin:refreshDzModel()
local dzId=self.dzId

uiAIManager:removeUIInstance(self.currDZ)
self.currDZ=nil
if tostring(dzId)~='0'then
self:createDZ(dzId,{0,0},function(bt)
self.currDZ=bt
end)
end
end

function UIDrawFuWin:createDZ(dzId,pos,callback)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
UIstateId=2,
enterspeak=0,
}
local tran=self.dzModel:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])





local otherData={
weaponslot='maobislotname',
}
uiAIManager:createUIDisciple('UIDrawFuWin','bt_ui_fulu',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end


function UIDrawFuWin:getSpeakText(bt,tkey)
local dzId=self.dzId
local voc=UIDiscipleModel:getDiscipleJob(dzId)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'fuludraw')
local speakStr=speakList[math.random(1,#speakList)]or''
bt:setSharedVar(tkey,speakStr)
end

function UIDrawFuWin:refreshWin()
if self.args.startCallback then
self.args.startCallback()
end
self.winlua:SetChildDrawTexture(self.template:getID(),FMT.fmt(self.abName,self.config.fu),self.config.fu,Vector2(0,0),0,1)

self:playCountdown(self.config.lz_time)
end

function UIDrawFuWin:playCountdown(count)
self:clearTimer()
self:killTweener()

local rectTrans=self.progressbar:getCommonComponent('RectTransform')
local size=rectTrans.sizeDelta
if self.sizeDelta==nil then
self.sizeDelta=rectTrans.sizeDelta
end
self.progressbar:setChildSizeDelta(self.sizeDelta.x,self.sizeDelta.y)
self.tweener=_DOTweenProxy.DOSizeDelta(rectTrans,Vector2(size.x,10),count-0.5,false)
self.tweener:SetEase(_Ease.Linear)
self.tweener:SetDelay(0.5)

self.timeText:setText(FMT.fmt('倒计时：{0}',timeHelper.format_time_stamp4(count)))
local endtime=os.time()+count
self.timer=self:setTimer(1,count,function()
local dt=endtime-os.time()
self.timeText:setText(FMT.fmt('倒计时：{0}',timeHelper.format_time_stamp4(dt)))
if dt<=0 then
self.progressbar:setActive(false)
self.timeText:setActive(false)
self:clearTimer()
self:killTweener()
self:onApplyBtn()
return
end



end)
end

function UIDrawFuWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIDrawFuWin:killTweener()
if self.tweener then
self.tweener:Kill(false)
self.tweener=nil
end
end




function UIDrawFuWin:onNotStart()
self.isGaming=true
self.notStart:setActive(false)
self.root:setActive(true)
self.xianghuo:setActive(true)
self:refreshWin()
end

function UIDrawFuWin:onResetBtn()
self.drawpanel:setChildDrawBrushClear()
self:refreshWin()
end

function UIDrawFuWin:onApplyBtn()
local cv=self.drawroot:getChildTextureCompareValue()
local level=1
local rating=self.config.rating
local success=self.config.success
for i,v in ipairs(rating)do
if cv>=v then
level=i+1
else
break
end
end
local iswin=0
if level>success then
iswin=1
end
if self.isGaming then
if self.args.callback then
self.args.callback(iswin,level)
end
end
self:closeSelf()



end

function UIDrawFuWin:onCloseClick()

UILittleGameController:quitTips(function()
if self.args.callback then
self.args.callback(0,1)
end
self:closeSelf()
end)

end