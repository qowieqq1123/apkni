







def_class("UIWanBaoXunBaoDui_BtnModelWin",UIWindowBase)









function UIWanBaoXunBaoDui_BtnModelWin:bindComponents()

self.Root=UIObject.get(self,0)
self.modelroot=UIObject.get(self,1)
self.model=UIObject.get(self,2)
self.guitai=UIObject.get(self,3)
self.dealBtn_Click=UIButton.get(self,4)
self.operationName=UIText.get(self,5)
self.recruitList=UIObject.get(self,6)

self.dealBtn_Click:setButtonClick(function()self:onDealBtn_Click()end)
self.dealBtn={
["Click"]=self.dealBtn_Click,
}



end


function UIWanBaoXunBaoDui_BtnModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.modelroot);self.modelroot=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.guitai);self.guitai=nil;
_UIObject_release(self.dealBtn_Click);self.dealBtn_Click=nil;
_UIObject_release(self.operationName);self.operationName=nil;
_UIObject_release(self.recruitList);self.recruitList=nil;
self.dealBtn=nil;
end



















function UIWanBaoXunBaoDui_BtnModelWin:onLoaded(...)
self:bindComponents()
end


function UIWanBaoXunBaoDui_BtnModelWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_BtnModelWin:onShow(argtable,afterOnloaded)
self.model:setChildUIModelShowTarget(1113002,1,nil,1,false,false)
local state=UIManager:isActive("UIWanBaoXunBaoDui_MainWin")
end


function UIWanBaoXunBaoDui_BtnModelWin:onHide()

end





function UIWanBaoXunBaoDui_BtnModelWin:onDealBtn_Click()
wanBaoXunBaoDuiModel:doOperation(self.option)
end

function UIWanBaoXunBaoDui_BtnModelWin:freshOperationBtn(option)
self.option=option
self.dealBtn_Click:setActive(self.option.isShow)
self.operationName:setText(self.option.name)
local isRecuit=option.state==WanBaoXunBaoDuiOperationType.Recruit
self.recruitList:setActive(isRecuit)
if isRecuit then
self:freshRecruit()
end
end

function UIWanBaoXunBaoDui_BtnModelWin:freshRecruit()
local recruiters=wanBaoXunBaoDuiModel:getRecruitDatas()
self.recruitList:setChildLayoutGroupCreateItems(#recruiters,function(index)
local recruit=recruiters[index]
local item=self.recruitList:getChildLayoutGroupGridItem(index-1)
local cfg=cfgHelper.get1(cfg_catshowconfig_get,recruit.wx_id)
local modelid=cfg.model
item:SetChildUIModelShowTarget(1,modelid,1,nil,1,false,false)
end)
end

