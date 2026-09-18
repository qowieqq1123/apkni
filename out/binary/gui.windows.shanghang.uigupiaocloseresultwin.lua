







def_class("UIGuPiaoCloseResultWin",UIWindowBase)









function UIGuPiaoCloseResultWin:bindComponents()

self.bg=UIObject.get(self,0)
self.mon=UIObject.get(self,1)
self.eve=UIObject.get(self,2)
self.rankItem_1=UIObject.get(self,3)
self.rankItem_2=UIObject.get(self,4)
self.rankItem_3=UIObject.get(self,5)
self.myRank=UIText.get(self,6)
self.myHead=UIObject.get(self,7)
self.myName=UIText.get(self,8)
self.myYuQuan=UILinkImageText.get(self,9)
self.closeButton=UIButton.get(self,10)
self.title=UIObject.get(self,11)
self.title2=UIObject.get(self,12)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIGuPiaoCloseResultWin")end)
self.rankItem={
self.rankItem_1,
self.rankItem_2,
self.rankItem_3,
}



end


function UIGuPiaoCloseResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.mon);self.mon=nil;
_UIObject_release(self.eve);self.eve=nil;
_UIObject_release(self.rankItem_1);self.rankItem_1=nil;
_UIObject_release(self.rankItem_2);self.rankItem_2=nil;
_UIObject_release(self.rankItem_3);self.rankItem_3=nil;
_UIObject_release(self.myRank);self.myRank=nil;
_UIObject_release(self.myHead);self.myHead=nil;
_UIObject_release(self.myName);self.myName=nil;
_UIObject_release(self.myYuQuan);self.myYuQuan=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.title2);self.title2=nil;
self.rankItem=nil;
end



















function UIGuPiaoCloseResultWin:onLoaded(...)
self:bindComponents()
end


function UIGuPiaoCloseResultWin:__delete()
self:unbindComponents()
end




function UIGuPiaoCloseResultWin:onShow(argtable,afterOnloaded)
local closeType=argtable.closeType


if closeType==1 then
self.bg:setChildUIModelShowTarget(5303,1,{},eAnimationID.stand,false,false,0,nil)

else
self.bg:setChildUIModelShowTarget(5303,1,{},2082,false,false,0,nil)

end

if not shangHangController:send_248_99()then
self:freshInfo()
end
end


function UIGuPiaoCloseResultWin:onHide()

end

local rankText={"<color=#8d2525>遥遥领先</color>","<color=#25628d>紧随其后</color>","<color=#6d5044>穷追不舍</color>"}
local rankBg={"image_zaowanxiushi_3","image_zaowanxiushi_4","image_zaowanxiushi_5"}
function UIGuPiaoCloseResultWin:freshInfo()
local ranklist=shangHangModel:getRankList()or{}
local myrank=shangHangModel:getMyRank()
local iconStr=shangHangModel.getYuQuanIconStr(32)
local rankData
local startMoney=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"init_yq")
for i=1,3 do
local widget=self.rankItem[i]:getChildWidgetBase()
rankData=ranklist[i]
if rankData then
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
playerController:setHeadIcon(widget,0,{iconInfo=rankData.iconInfo,scale=HEAD_SCALE_TYPE.e96x96})
widget:SetChildText(2,rankText[rankData.rank_idx])
widget:SetChildCSImageSprite(6,"ui/windows/shanghang/shanghang_xiushi_atlas_pak.ab",rankBg[rankData.rank_idx])
widget:SetChildText(3,rankData.name)
widget:SetChildText(4,loginModel:getServerName(rankData.server_id))
local zhang=math.floor(((rankData.point-startMoney)/startMoney)*10000)/100
widget:SetChildText(5,FMT.fmt("{1}{0}",mathHelper.formatNumber5(rankData.point,2),iconStr))
widget:SetChildText(7,FMT.fmt("<color={1}>{0}%</color>",zhang,zhang>=0 and"#c82c2c"or"#549327"))
widget:SetChildActive(8,zhang>0)
widget:SetChildActive(9,zhang<0)
else
widget:SetChildActive(0,false)
widget:SetChildActive(1,true)
widget:SetChildText(2,rankText[i])
widget:SetChildCSImageSprite(6,"ui/windows/shanghang/shanghang_xiushi_atlas_pak.ab",rankBg[i])
widget:SetChildText(3,"虚位以待")
widget:SetChildText(4,"")
widget:SetChildText(5,"")
end
end
self:refreshRank()
playerController:setHeadIcon(self.winid,self.myHead:getID(),{iconInfo=playerModel:getActorIconInfo(),scale=HEAD_SCALE_TYPE.e60x60})


self.myName:setText(playerModel:getActorName())

self.myYuQuan:setText(FMT.fmt("{1}{0}玉券",mathHelper.formatNumber5(shangHangModel:getZiChanZongZhi(),2),iconStr))

end

function UIGuPiaoCloseResultWin:refreshRank()
local myrank=shangHangModel:getMyRank()
self.myRank:setText(myrank==0 and"未上榜"or FMT.fmt("{0}名",myrank))
end


function UIGuPiaoCloseResultWin:onCloseBtn()
self:closeSelf()
end


