







def_class("UILunDaoXiBaiWin",UIWindowBase)









function UILunDaoXiBaiWin:bindComponents()

self.mask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.model=UIObject.get(self,2)
self.frontClick=UIButton.get(self,3)
self.mainPanel=UIObject.get(self,4)
self.nameImg=UIImage.get(self,5)
self.content=UIText.get(self,6)
self.effectTitle=UIObject.get(self,7)

self.mask:setButtonClick(function()self:onMask()end)

self.frontClick:setButtonClick(function()self:onFrontClick()end)



end


function UILunDaoXiBaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.frontClick);self.frontClick=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.nameImg);self.nameImg=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.effectTitle);self.effectTitle=nil;
end


















local titleImgab='ui/windows/lundaodahui/lundaodahuiyugao_atlas_pak.ab'
local titleImg={'image_saijiygbt_3','image_saijiygbt_4','image_saijiygbt_2','image_saijiygbt_1'}
local matchMap=
{
[3]={pre="半决赛",next="季军赛"},
}

function UILunDaoXiBaiWin:onLoaded(...)
self:bindComponents()
end


function UILunDaoXiBaiWin:__delete()
self:unbindComponents()
end




function UILunDaoXiBaiWin:onShow(argtable,afterOnloaded)
socketManager:send_17_39()
local JinJiType=argtable.JinJiType

if JinJiType==3 then
self.effectTitle:setChildShowEffect(10514,true)
self.mainPanel:setChildCanvasGroupAlpha(0)
local tweener=self.mainPanel:setChildCanvasGroupDOFade(1,0.5)
tweener:SetDelay(0.5)
self.model:setActive(true)
local str=matchMap[JinJiType]
self.nameImg:setSprite(titleImgab,titleImg[3])
local matchTimeJiJun=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)
local nowTime=timeHelper.getServerLongTime()
if nowTime<timeHelper.getServerZeroStamp(matchTimeJiJun)then
self.content:setText(FMT.fmt("祖师在论道大会-{0}中惜败\n将参与明天<color=#b97935>{1}</color>！",str.pre,str.next))
else
self.content:setText(FMT.fmt("祖师在论道大会-{0}中惜败\n将参与今天<color=#b97935>{1}</color>！",str.pre,str.next))
end

end

end


function UILunDaoXiBaiWin:onHide()

end





function UILunDaoXiBaiWin:onMask()
UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=3,subPage=1})
self:closeSelf()
end



function UILunDaoXiBaiWin:onFrontClick()
end

