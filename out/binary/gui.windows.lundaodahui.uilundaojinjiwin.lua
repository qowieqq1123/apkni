







def_class("UILunDaoJinJiWin",UIWindowBase)









function UILunDaoJinJiWin:bindComponents()

self.mask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.model=UIObject.get(self,2)
self.frontClick=UIButton.get(self,3)
self.mainPanel=UIObject.get(self,4)
self.nameImg=UIImage.get(self,5)
self.effectTitle=UIObject.get(self,6)
self.content=UIText.get(self,7)

self.mask:setButtonClick(function()self:onMask()end)

self.frontClick:setButtonClick(function()self:onFrontClick()end)



end


function UILunDaoJinJiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.frontClick);self.frontClick=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.nameImg);self.nameImg=nil;
_UIObject_release(self.effectTitle);self.effectTitle=nil;
_UIObject_release(self.content);self.content=nil;
end



















local titleImgab='ui/windows/lundaodahui/lundaodahuiyugao_atlas_pak.ab'
local titleImg={'image_saijiygbt_3','image_saijiygbt_4','image_saijiygbt_2','image_saijiygbt_1','image_saijiygbt_5','image_saijiygbt_6'}
local matchMap=
{
[1]={pre="选拔赛",next="小组赛",titleImg=1,jump=function()UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=2,subPage=1})end},
[2]={pre="小组赛",next="半决赛",titleImg=2,jump=function()UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=2,subPage=2})end},
[3]={pre="半决赛",next="冠军赛",titleImg=4,jump=function()UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=3,subPage=2})end},
[6]={pre="32强赛",next="16强赛",titleImg=5,jump=function()UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=2,subPage=1})end},
[7]={pre="16强赛",next="8强赛",titleImg=6,jump=function()UIFullLunDaoDaHuiControl:showLunDaoDaHui({page=2,subPage=1})end},
}

function UILunDaoJinJiWin:onLoaded(...)
self:bindComponents()
end


function UILunDaoJinJiWin:__delete()
self:unbindComponents()
end




function UILunDaoJinJiWin:onShow(argtable,afterOnloaded)
socketManager:send_17_39()
local JinJiType=argtable.JinJiType
local str=matchMap[JinJiType]
if not str then
self:closeSelf()
return
end
local xbsRank=argtable.xbsRank
self.jjType=JinJiType
self.mainPanel:setChildCanvasGroupAlpha(0)
local tweener=self.mainPanel:setChildCanvasGroupDOFade(1,0.5)
tweener:SetDelay(0.5)
self.effectTitle:setChildShowEffect(10513,true)

self.nameImg:setSprite(titleImgab,titleImg[str.titleImg])
if JinJiType==1 then
if not xbsRank then
xbsRank=lundaodahuiModel:getMyRank2()
end
if xbsRank then
self.content:setText(FMT.fmt("恭喜祖师在论道大会-{0}中获得<color=#b97935>第{2}名</color>\n成功晋级<color=#b97935>{1}</color>！！",str.pre,str.next,xbsRank))
else
lundaodahuiController.req_17_20()
end
else
self.content:setText(FMT.fmt("恭喜祖师在论道大会-{0}中获得胜利\n成功晋级<color=#b97935>{1}</color>！！",str.pre,str.next))
end

end

function UILunDaoJinJiWin:refreshRank(xbsRank)
if self.jjType==1 then
local str=matchMap[self.jjType]
self.content:setText(FMT.fmt("恭喜祖师在论道大会-{0}中获得<color=#b97935>第{2}名</color>\n成功晋级<color=#b97935>{1}</color>！！",str.pre,str.next,xbsRank))
end
end


function UILunDaoJinJiWin:onHide()

end





function UILunDaoJinJiWin:onMask()
matchMap[self.jjType].jump()
self:closeSelf()
end



function UILunDaoJinJiWin:onFrontClick()
end

