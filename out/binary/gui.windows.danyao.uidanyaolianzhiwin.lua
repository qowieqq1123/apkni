







def_class("UIDanYaoLianZhiWin",UIWindowBase)









function UIDanYaoLianZhiWin:bindComponents()

self.okBtn=UIButton.get(self,0)
self.jiantou=UIObject.get(self,1)
self.bestArea=UIObject.get(self,2)

self.okBtn:setButtonClick(function()self:onOkBtn()end)



end


function UIDanYaoLianZhiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.jiantou);self.jiantou=nil;
_UIObject_release(self.bestArea);self.bestArea=nil;
end

















local _this=nil

local totalWidth=0
local bestAreaWidth=0
local bestShowPosX=0


function UIDanYaoLianZhiWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDanYaoLianZhiWin:__delete()
self:unbindComponents()
_this=nil
self:stopLianZhiTimer()
self:stopResultTimer()
end




function UIDanYaoLianZhiWin:onShow(argtable,afterOnloaded)
self.danFangId=argtable
self.danFangCfg=cfgHelper.get1(cfg_danfangconfig_get,self.danFangId)
local progressSet=self.danFangCfg.progress
totalWidth=progressSet[1]
bestAreaWidth=progressSet[2]
local bestPosIdx=progressSet[3]
bestShowPosX=bestPosIdx*bestAreaWidth

local bestTrans=self.bestArea:getTransform()
local bestRect=bestTrans:GetComponent('RectTransform')
local sizeDelta=bestRect.sizeDelta
local bestLocalPos=bestTrans.localPosition

self.winlua:SetChildSizeDelta(self.bestArea:getID(),bestAreaWidth,sizeDelta.y)
self.winlua:SetChildLocalPosition(self.bestArea:getID(),Vector3(bestShowPosX,bestLocalPos.y,bestLocalPos.z))
self:refreshJianTou()
end


function UIDanYaoLianZhiWin:onHide()

end





function UIDanYaoLianZhiWin:onOkBtn()
self:stopLianZhiTimer()
if self.resultTimer then
self:showReward()
else
self:closeSelfWin()
end
end

function UIDanYaoLianZhiWin:refreshJianTou()
local jiantouTrans=self.jiantou:getTransform()
local jiantouLocalPos=jiantouTrans.localPosition
local a=self.danFangCfg.speed
local completeTime=self.danFangCfg.lz_time
local x=0
local time=0
local func=function(...)
x=x+0.01
local time=a*x
_this.jiantouPosX=time*(totalWidth/completeTime)
_this.winlua:SetChildLocalPosition(_this.jiantou:getID(),Vector3(_this.jiantouPosX,jiantouLocalPos.y,jiantouLocalPos.z))
if time>=completeTime then
_this:stopLianZhiTimer()
_this:closeSelfWin()
return
end
end
self.lianzhiTimer=self:setTimer(0.01,0,func)
end

function UIDanYaoLianZhiWin:stopLianZhiTimer()
if self.lianzhiTimer then
self:stopTimerByID(self.lianzhiTimer)
self.lianzhiTimer=nil
end
end


function UIDanYaoLianZhiWin:closeSelfWin()
local func=function(...)
_this:showReward()
end
self.resultTimer=self:setTimer(0.2,1,func)
end

function UIDanYaoLianZhiWin:showReward()
local flag=0
if self.jiantouPosX>=bestShowPosX and self.jiantouPosX<=bestShowPosX+bestAreaWidth+5 then
flag=1
end
UIDanYaoController:req_lianzhi(self.danFangId,flag)
self:closeSelf()
end

function UIDanYaoLianZhiWin:stopResultTimer()
if self.resultTimer then
self:stopTimerByID(self.resultTimer)
self.resultTimer=nil
end
end