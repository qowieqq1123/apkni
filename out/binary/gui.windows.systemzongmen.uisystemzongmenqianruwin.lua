







def_class("UISystemZongMenQianRuWin",UIWindowBase)









function UISystemZongMenQianRuWin:bindComponents()

self.backBtn=UIButton.get(self,0)
self.modelImage=UIObject.get(self,1)
self.talkdesc=UIText.get(self,2)
self.nameTx=UIText.get(self,3)

self.backBtn:setButtonClick(function()self:onBackBtn()end)



end


function UISystemZongMenQianRuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.talkdesc);self.talkdesc=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
end
















local _this=nil




function UISystemZongMenQianRuWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
end


function UISystemZongMenQianRuWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
end




function UISystemZongMenQianRuWin:onShow(argtable,afterOnloaded)
self.discipleGuid=argtable.disciple
self:refreshView()
end


function UISystemZongMenQianRuWin:onHide()

end



function UISystemZongMenQianRuWin:onBackBtn()
self:closeSelf()
end

function UISystemZongMenQianRuWin:refreshView()

comHelper.setChildInSideModel(self.modelImage,self.discipleGuid,0.7,0)

local discipleName=UIDiscipleModel:getDiscipleName(self.discipleGuid)
self.nameTx:setText(discipleName)

local job=UIDiscipleModel:getDiscipleJob(self.discipleGuid)
local descLib=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,job,"systemzm_qr_speak")
local r=math.random(1,#descLib)
local descStr=descLib[r]
self.talkdesc:setText(descStr)
end

function UISystemZongMenQianRuWin.onSystemZMDiscipleChange(serial,discipleGuid,oldGuid)
if mathHelper.compareInt64(_this.discipleGuid,oldGuid)then
if mathHelper.validInt64(discipleGuid)then
_this.discipleGuid=discipleGuid
_this:refreshView()
else
_this:closeSelf()
end
end
end