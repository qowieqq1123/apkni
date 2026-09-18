







def_class("UILunDaoRankWin",UIWindowBase)









function UILunDaoRankWin:bindComponents()

self.content=UIText.get(self,0)
self.mainPanel=UIObject.get(self,1)
self.mask=UIButton.get(self,2)
self.model=UIObject.get(self,3)
self.nameImg=UIImage.get(self,4)
self.root=UIObject.get(self,5)
self.xbsRank=UIText.get(self,6)
self.xbsRankPanel=UIObject.get(self,7)
self.xzsRank=UIText.get(self,8)
self.xzsRankPanel=UIObject.get(self,9)

self.mask:setButtonClick(function()self:onMask()end)



end


function UILunDaoRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.nameImg);self.nameImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.xbsRank);self.xbsRank=nil;
_UIObject_release(self.xbsRankPanel);self.xbsRankPanel=nil;
_UIObject_release(self.xzsRank);self.xzsRank=nil;
_UIObject_release(self.xzsRankPanel);self.xzsRankPanel=nil;
end


















local titleImgab='ui/windows/lundaodahui/lundaojinji_atlas_pak.ab'
local titleImg={'image_zuizhongmingci_wz1','image_zuizhongmingci_wz2','image_zuizhongmingci_wz3'}
local matchMap=
{
[1]={pre="选拔赛",next="第3名"},
[2]={pre="小组赛",next="32强"},
[4]={pre="季军赛",win_next="季军",lose_next="4强",win_Img=1,lose_Rank=4},
[5]={pre="冠军赛",win_next="冠军",lose_next="亚军",win_Img=3,lose_Img=2},
[6]={pre="32强赛",next="32强",titleImg=4,win_Rank=32,lose_Rank=32},
[7]={pre="16强赛",next="16强",titleImg=4,win_Rank=16,lose_Rank=16},
}

function UILunDaoRankWin:onLoaded(...)
self:bindComponents()
end


function UILunDaoRankWin:__delete()
self:unbindComponents()
end




function UILunDaoRankWin:onShow(argtable,afterOnloaded)
socketManager:send_17_39()
local JinJiType=argtable.JinJiType
local str=matchMap[JinJiType]
if not str then
self:closeSelf()
return
end
local xbsRank=argtable.xbsRank
local lddhRank=argtable.lddhRank
local isWin=argtable.isWin
self.mainPanel:setChildCanvasGroupAlpha(0)
local tweener=self.mainPanel:setChildCanvasGroupDOFade(1,0.5)
tweener:SetDelay(1)
self.model:setActive(true)
if isWin then
self.nameImg:setActive(true)
self.nameImg:setSprite(titleImgab,titleImg[str.win_Img])
self.content:setText(FMT.fmt("祖师在论道大会-{0}中获胜\n获得最终名次<color=#c82c2c><size=36>{1}</size></color>！",str.pre,str.win_next or str.next))
else
if JinJiType==1 then
self.xbsRankPanel:setActive(true)
self.xbsRank:setText(xbsRank)
self.content:setText(FMT.fmt("祖师在论道大会-{0}中憾负敌手\n获得小组<color=#c82c2c><size=36>第{1}名</size></color>！",str.pre,xbsRank))
elseif JinJiType==2 or JinJiType==6 or JinJiType==7 then
self.xzsRankPanel:setActive(true)
self.xzsRank:setText(lddhRank)
self.content:setText(FMT.fmt("祖师在论道大会-{0}强赛中惜败\n获得最终名次<color=#c82c2c><size=36>{0}强</size></color>！",lddhRank))
else
if str.lose_Img then
self.nameImg:setActive(true)
self.nameImg:setSprite(titleImgab,titleImg[str.lose_Img])
elseif str.lose_Rank then
self.xzsRankPanel:setActive(true)
self.xzsRank:setText(str.lose_Rank)
end
self.content:setText(FMT.fmt("祖师在论道大会-{0}中惜败\n获得最终名次<color=#c82c2c><size=36>{1}</size></color>！",str.pre,str.lose_next or str.next))
end
end
end


function UILunDaoRankWin:onHide()

end


function UILunDaoRankWin:onMask()

self:closeSelf()
end