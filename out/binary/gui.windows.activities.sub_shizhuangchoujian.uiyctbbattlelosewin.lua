







def_class("UIYCTBBattleLoseWin",UIWindowBase)









function UIYCTBBattleLoseWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.strengthenCreator=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.headdatapanel=UIObject.get(self,3)
self.headIcon=UIButton.get(self,4)
self.headIcontwo=UIButton.get(self,5)
self.selfname=UIText.get(self,6)
self.selfserver=UIText.get(self,7)
self.othername=UIText.get(self,8)
self.otherserver=UIText.get(self,9)
self.shareBtn=UIButton.get(self,10)
self.selfpanel=UIObject.get(self,11)
self.selffrightvalue=UIText.get(self,12)
self.otherpanel=UIObject.get(self,13)
self.otherfrightvalue=UIText.get(self,14)
self.selfimg=UIObject.get(self,15)
self.otherimg=UIObject.get(self,16)
self.yctbtxt=UIText.get(self,17)
self.rewardGrid=UIObject.get(self,18)

self.headIcon:setButtonClick(function()self:onHeadIcon()end)

self.headIcontwo:setButtonClick(function()self:onHeadIcontwo()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UIYCTBBattleLoseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.strengthenCreator);self.strengthenCreator=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.headdatapanel);self.headdatapanel=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.headIcontwo);self.headIcontwo=nil;
_UIObject_release(self.selfname);self.selfname=nil;
_UIObject_release(self.selfserver);self.selfserver=nil;
_UIObject_release(self.othername);self.othername=nil;
_UIObject_release(self.otherserver);self.otherserver=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.selfpanel);self.selfpanel=nil;
_UIObject_release(self.selffrightvalue);self.selffrightvalue=nil;
_UIObject_release(self.otherpanel);self.otherpanel=nil;
_UIObject_release(self.otherfrightvalue);self.otherfrightvalue=nil;
_UIObject_release(self.selfimg);self.selfimg=nil;
_UIObject_release(self.otherimg);self.otherimg=nil;
_UIObject_release(self.yctbtxt);self.yctbtxt=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
end



















function UIYCTBBattleLoseWin:onLoaded(...)
self:bindComponents()
end


function UIYCTBBattleLoseWin:__delete()
self:unbindComponents()
end




function UIYCTBBattleLoseWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end
self:delayDo(0.4,func)
end

self.yctb_data=argtable.yctb_data
local yctb_data=argtable.yctb_data
if yctb_data then

local str=yctb_data[1]or""
self.yctbtxt:setText(str)


local rewardList=yctb_data[2]
local len1=#rewardList
self.winlua:SetChildLayoutGroupCreateItems(self.rewardGrid:getID(),len1)
local grids2=self.winlua:GetChildLayoutGroupGridList(self.rewardGrid:getID())
for i=1,len1 do
local rewardItem=grids2[i-1]
local itemid=rewardList[i].itemid
local itemnum=rewardList[i].num
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if self==nil then return end
self:onClickItem(...)
end)
end
end
end


function UIYCTBBattleLoseWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end


function UIYCTBBattleLoseWin:onHide()

end





function UIYCTBBattleLoseWin:onHeadIcon()
end



function UIYCTBBattleLoseWin:onHeadIcontwo()
end



function UIYCTBBattleLoseWin:onShareBtn()
end

