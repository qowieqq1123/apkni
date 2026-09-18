







def_class("UIYCTBRightWin",UIWindowBase)









function UIYCTBRightWin:bindComponents()

self.jiachebtn=UIButton.get(self,0)
self.jianlibtn=UIButton.get(self,1)
self.paihanbtn=UIButton.get(self,2)

self.jiachebtn:setButtonClick(function()self:onJiachebtn()end)

self.jianlibtn:setButtonClick(function()self:onJianlibtn()end)

self.paihanbtn:setButtonClick(function()self:onPaihanbtn()end)



end


function UIYCTBRightWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.jiachebtn);self.jiachebtn=nil;
_UIObject_release(self.jianlibtn);self.jianlibtn=nil;
_UIObject_release(self.paihanbtn);self.paihanbtn=nil;
end
















local _this



function UIYCTBRightWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIYCTBRightWin:__delete()
self:unbindComponents()
_this=nil
end




function UIYCTBRightWin:onShow(argtable,afterOnloaded)
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid
self.parentwin=argtable.parentwin
end


function UIYCTBRightWin:onHide()

end






function UIYCTBRightWin:onJiachebtn()




local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local effect_list=mydata.effect_list
if effect_list and#effect_list>0 then
local win=UIManager:findActiveWindow('UIYCTBTipsWin')
if win then
win:closeSelf()
else
if _this.parentwin then
_this.parentwin:showWindow('UIYCTBTipsWin',{effect_list,_this.actID,_this.subType,_this.subid})
end
end
else
UIManager.error('当前没有加成效果')
end
end


function UIYCTBRightWin:onJianlibtn()




UIManager:showWindow('UISubAct_yunchengtanbao_reward_win',{act_id=_this.actID,sub_act_type=_this.subType,sub_act_id=_this.subid})
end


function UIYCTBRightWin:onPaihanbtn()




local json_str=jsonHelper.encode({4})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end

