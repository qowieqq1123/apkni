







def_class("UILunDaoInvitationWin",UIWindowBase)









function UILunDaoInvitationWin:bindComponents()

self.root=UIObject.get(self,0)
self.model=UIObject.get(self,1)
self.frontClick=UIButton.get(self,2)
self.mainPanel=UIObject.get(self,3)
self.mask=UIButton.get(self,4)
self.zmNameText=UIText.get(self,5)
self.rankText=UIText.get(self,6)
self.mainClick=UIButton.get(self,7)

self.frontClick:setButtonClick(function()self:onFrontClick()end)

self.mask:setButtonClick(function()self:onMask()end)

self.mainClick:setButtonClick(function()self:onMainClick()end)



end


function UILunDaoInvitationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.frontClick);self.frontClick=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.zmNameText);self.zmNameText=nil;
_UIObject_release(self.rankText);self.rankText=nil;
_UIObject_release(self.mainClick);self.mainClick=nil;
end



















function UILunDaoInvitationWin:onLoaded(...)
self:bindComponents()
end


function UILunDaoInvitationWin:__delete()
self:unbindComponents()
end




function UILunDaoInvitationWin:onShow(argtable,afterOnloaded)

local modelId=4734
local scale=1
self.model:setChildUIModelShowTarget(modelId,scale,nil,eAnimationID.stand)


douFaTaiController:req_doufatai_data()

self:showPage(1)
end

function UILunDaoInvitationWin:refreshInvitationInfo()
local isTruce=douFaTaiModel:checkIsTruce()
local selfRank=0
local doufataiData=douFaTaiModel:get_doufatai_data()
if isTruce then

selfRank=doufataiData and doufataiData.rank or 0
else

selfRank=doufataiData and doufataiData.lastSelfRank or 0
end


local zmName=UISettingModel:getZMName()
self.zmNameText:setText(FMT.fmt("﹃{0}﹄",zmName))
if pfwindowslController:checkIsGameVersion_yuenan()then
self.zmNameText:setText(FMT.fmt("﹃\n{0}\n﹄",zmName))
end
self.rankText:setText(selfRank)
end


function UILunDaoInvitationWin:onHide()

end

function UILunDaoInvitationWin:showPage(pageIndex)
if self.selectPageIndex==pageIndex then
return
end

if pageIndex==1 then
self.root:setAnimatorInteger('state',0,true)
self.frontClick:setActive(true)
self.mainPanel:setActive(false)
elseif pageIndex==2 then
self:refreshInvitationInfo()

local animId=2093
self.model:setChildModelAnimationState(animId)
self.mainPanel:setActive(true)
self:delayDo(0.8,function()
self.frontClick:setActive(false)
self.mainPanel:setActive(true)
self.root:setAnimatorInteger('state',1,true)
end)
end
self.selectPageIndex=pageIndex
end





function UILunDaoInvitationWin:onFrontClick()
if self.selectPageIndex~=2 then
self:showPage(2)
end
end



function UILunDaoInvitationWin:onCloseBtn()
self:closeSelf()

UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=1})
end



function UILunDaoInvitationWin:onMask()
self:onCloseBtn()
end

function UILunDaoInvitationWin:onMainClick()

self.root:setChildAnimatorParameter("fastTrigger","trigger","")
end

