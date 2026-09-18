







def_class("UIFuBaoDrawWin",UIWindowBase)









function UIFuBaoDrawWin:bindComponents()

self.notStart=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.timeText=UIText.get(self,2)
self.dzModel=UIObject.get(self,3)
self.rating=UIText.get(self,4)
self.drawroot=UIObject.get(self,5)
self.applyBtn=UIButton.get(self,6)
self.resetBtn=UIButton.get(self,7)
self.progressbar=UIProgressBarAni.get(self,8)
self.template=UIObject.get(self,9)
self.drawpanel=UIObject.get(self,10)
self.xianghuo=UIObject.get(self,11)

self.notStart:setButtonClick(function()self:onNotStart()end)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIFuBaoDrawWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.notStart);self.notStart=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.rating);self.rating=nil;
_UIObject_release(self.drawroot);self.drawroot=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.template);self.template=nil;
_UIObject_release(self.drawpanel);self.drawpanel=nil;
_UIObject_release(self.xianghuo);self.xianghuo=nil;
end



















function UIFuBaoDrawWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/fulu/sharedtextures/{0}.ab'
end


function UIFuBaoDrawWin:__delete()

uiAIManager:removeUIInstance(self.currDZ)
uiAIManager:clearUIWinData('UIFuBaoDrawWin')
self:unbindComponents()
end




function UIFuBaoDrawWin:onShow(argtable,afterOnloaded)
self.id=argtable[1]
self.sfId=argtable[2]
self.bdId=argtable[3]
self.dzId=argtable[4]

self.notStart:setActive(true)
self.root:setActive(false)

if self.dzId then
self:refreshDzModel()
end
local fbCfg=cfgHelper.get1(cfg_fulufangconfig_get,self.id)
self.config=fbCfg
self.xianghuo:setActive(false)
UIFullFuLuFangControl:showMoneyTopWin(false)
self.timeText:setText(FMT.fmt('倒计时：{0}',timeHelper.format_time_stamp4(fbCfg.lz_time)))
end


function UIFuBaoDrawWin:onHide()

end

function UIFuBaoDrawWin:refreshDzModel()
local dzId=self.dzId

uiAIManager:removeUIInstance(self.currDZ)
self.currDZ=nil
if tostring(dzId)~='0'then
self:createDZ(dzId,{0,0},function(bt)
self.currDZ=bt
end)
end
end

function UIFuBaoDrawWin:createDZ(dzId,pos,callback)
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
uiAIManager:createUIDisciple('UIFuBaoDrawWin','bt_ui_fulu',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end


function UIFuBaoDrawWin:getSpeakText(bt,tkey)
local dzId=self.dzId
local voc=UIDiscipleModel:getDiscipleJob(dzId)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'fuludraw')
local speakStr=speakList[math.random(1,#speakList)]or''
bt:setSharedVar(tkey,speakStr)
end

function UIFuBaoDrawWin:refreshWin()
self.winlua:SetChildDrawTexture(self.template:getID(),FMT.fmt(self.abName,self.config.fu),self.config.fu,Vector2(0,0),0,1)






self:playCountdown(self.config.lz_time)
end

function UIFuBaoDrawWin:playCountdown(count)
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

function UIFuBaoDrawWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIFuBaoDrawWin:killTweener()
if self.tweener then
self.tweener:Kill(false)
self.tweener=nil
end
end




function UIFuBaoDrawWin:onNotStart()
self.notStart:setActive(false)
self.root:setActive(true)
self.xianghuo:setActive(true)
self:refreshWin()
end

function UIFuBaoDrawWin:onResetBtn()
self.drawpanel:setChildDrawBrushClear()
self:refreshWin()
end

function UIFuBaoDrawWin:onApplyBtn()
local cv=self.drawroot:getChildTextureCompareValue()
local level=1
local rating=self.config.rating
for i,v in ipairs(rating)do
if cv>=v then
level=i+1
else
break
end
end

UIFullFuLuFangControl:reqMakeFuLu(self.sfId,self.bdId,self.id,level,1)
self:onCloseClick()



end

function UIFuBaoDrawWin:onCloseClick()
UIFullFuLuFangControl:showMoneyTopWin(true)
self:closeSelf()
end