







def_class("UISubAct_tgslrankupWin",UIWindowBase)









function UISubAct_tgslrankupWin:bindComponents()

self.effect=UIObject.get(self,0)
self.FullScreenClose=UIButton.get(self,1)
self.liandanVal=UILinkImageText.get(self,2)
self.ScrollView1=UIObject.get(self,3)
self.Text=UILinkImageText.get(self,4)
self.ScrollView2=UIObject.get(self,5)
self.Content2=UIObject.get(self,6)
self.Content=UIObject.get(self,7)
self.bosstxt=UIText.get(self,8)
self.rangkIcon=UIImage.get(self,9)
self.rank22=UIText.get(self,10)
self.weitxt=UIText.get(self,11)
self.rankScrollView=UIObject.get(self,12)
self.rankGridPanel=UIObject.get(self,13)
self.panela=UIObject.get(self,14)
self.rangkIconone=UIImage.get(self,15)
self.panelb=UIObject.get(self,16)
self.rangkIconteol=UIImage.get(self,17)
self.rangkIconteor=UIImage.get(self,18)
self.rank2=UIText.get(self,19)
self.rankl2=UIText.get(self,20)
self.rankr2=UIText.get(self,21)

self.FullScreenClose:setButtonClick(function()self:onFullScreenClose()end)



end


function UISubAct_tgslrankupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.FullScreenClose);self.FullScreenClose=nil;
_UIObject_release(self.liandanVal);self.liandanVal=nil;
_UIObject_release(self.ScrollView1);self.ScrollView1=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.ScrollView2);self.ScrollView2=nil;
_UIObject_release(self.Content2);self.Content2=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.bosstxt);self.bosstxt=nil;
_UIObject_release(self.rangkIcon);self.rangkIcon=nil;
_UIObject_release(self.rank22);self.rank22=nil;
_UIObject_release(self.weitxt);self.weitxt=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
_UIObject_release(self.panela);self.panela=nil;
_UIObject_release(self.rangkIconone);self.rangkIconone=nil;
_UIObject_release(self.panelb);self.panelb=nil;
_UIObject_release(self.rangkIconteol);self.rangkIconteol=nil;
_UIObject_release(self.rangkIconteor);self.rangkIconteor=nil;
_UIObject_release(self.rank2);self.rank2=nil;
_UIObject_release(self.rankl2);self.rankl2=nil;
_UIObject_release(self.rankr2);self.rankr2=nil;
end

















local _this


function UISubAct_tgslrankupWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_tgslrankupWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_tgslrankupWin:onShow(argtable,afterOnloaded)
if argtable then
self.actId=argtable[1]
self.subType=argtable[2]
self.subId=argtable[3]
self.bossidrank=argtable[4]
self.myrank=argtable[5]

if self.bossidrank==0 and self.myrank then
self.panela:setActive(true)
local rank=self.myrank
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
else
rankIcon=FMT.fmt('icon_phbmingci_4')
end
local showRankIcon=rankIcon~=nil
if showRankIcon then
_this.winlua:SetChildCSImageSprite(_this.rangkIconone:getID(),globalABLookup.rankList,rankIcon)
_this.rank2:setText(rank_str)
else
_this.rank2:setText(rank_str)
end

elseif self.bossidrank>0 and self.myrank then
self.panelb:setActive(true)

local rankold=self.bossidrank
local rankIcon
local rank_str=tostring(rankold)
if rankold<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rankold)
else
rankIcon=FMT.fmt('icon_phbmingci_4')
end
local showRankIcon=rankIcon~=nil
if showRankIcon then
_this.winlua:SetChildCSImageSprite(_this.rangkIconteol:getID(),globalABLookup.rankList,rankIcon)
_this.rankl2:setText(rank_str)
else
_this.rankl2:setText(rank_str)
end


local ranknew=self.myrank
local rankIconnew
local rank_strnew=tostring(ranknew)
if ranknew<=3 then
rankIconnew=FMT.fmt('icon_phbmingci_{0}',ranknew)
else
rankIconnew=FMT.fmt('icon_phbmingci_4')
end
local showRankIconnew=rankIconnew~=nil
if showRankIconnew then
_this.winlua:SetChildCSImageSprite(_this.rangkIconteor:getID(),globalABLookup.rankList,rankIconnew)
_this.rankr2:setText(rank_strnew)
else
_this.rankr2:setText(rank_strnew)
end
end

end
end


function UISubAct_tgslrankupWin:onHide()

end





function UISubAct_tgslrankupWin:onFullScreenClose()
end

function UISubAct_tgslrankupWin:onCloseWin()
self:closeSelf()
end
