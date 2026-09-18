







def_class("UISuperZuShiWin",UIWindowBase)









function UISuperZuShiWin:bindComponents()

self.mask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.qrCodeImage=UIImage.get(self,4)
self.mainText=UIText.get(self,5)
self.checkText=UIText.get(self,6)
self.connectText=UILinkImageText.get(self,7)
self.qrCodePanel=UIObject.get(self,8)
self.connectTitle=UIText.get(self,9)
self.qrCodeRawImage=UIRawImage.get(self,10)
self.rewardGroup=UIObject.get(self,11)

self.mask:setButtonClick(function()self:onMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISuperZuShiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.qrCodeImage);self.qrCodeImage=nil;
_UIObject_release(self.mainText);self.mainText=nil;
_UIObject_release(self.checkText);self.checkText=nil;
_UIObject_release(self.connectText);self.connectText=nil;
_UIObject_release(self.qrCodePanel);self.qrCodePanel=nil;
_UIObject_release(self.connectTitle);self.connectTitle=nil;
_UIObject_release(self.qrCodeRawImage);self.qrCodeRawImage=nil;
_UIObject_release(self.rewardGroup);self.rewardGroup=nil;
end















local _this




function UISuperZuShiWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISuperZuShiWin:__delete()
_this=nil
self:unbindComponents()
end




function UISuperZuShiWin:onShow(argtable,afterOnloaded)

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5216,1,{},eAnimationID.enter)
self:delayDo(0.5,function()
if _this==nil then return end
self.root:setChildCanvasGroupDOFade(1,0.5,nil)
end)
end

local showData=superZuShiModel:getSuperZuShiDetailData()


local contentText=showData.content or""
contentText=comHelper.getCheckStrStartFormat(contentText)
local textViewWidth=self.mainText:getChildSizeDeltaX()
local checkStr=comHelper.getCheckLayoutStr(self.checkText:getGameObject(),textViewWidth,contentText)
self.mainText:setText(checkStr)


local rewards=cfgHelper.getglobal1('superZuShiShowRewards')
local isShowRewards=rewards~=nil and(tonumber(showData.show_reward)==1)
self.rewardGroup:setActive(isShowRewards)
if isShowRewards then
self.rewardGroup:setChildLayoutGroupCreateItems(#rewards,function(index)
local widget=self.rewardGroup:getChildLayoutGroupGridItem(index-1)
local reward=rewards[index]
if reward then
widget:SetChildActive(-1,true)
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)





else
widget:SetChildActive(-1,false)
end
end)
end


local connectTitleStr=showData.connect and showData.connect.content or""
self.connectTitle:setText(connectTitleStr)


local connectTextStr=showData.connect and showData.connect.information or""
local exURL=showData.connect and showData.connect.add_url
if exURL and exURL~=nil then
local str=FMT.fmt("<a;[立即添加];1;1;3,{0};/>",exURL)
connectTextStr=FMT.fmt("{0}{1}",connectTextStr,str)
end
self.connectText:setText(connectTextStr)


local qr_codeUrl=showData.connect and showData.connect.qr_code
local isShowQrCode=qr_codeUrl~=nil
if isShowQrCode then
if api_Available_ChildRawImageLoader()then

self.qrCodeImage:setActive(false)
self.qrCodeRawImage:setActive(true)
local cdnUrl
if deviceHelper.isRunNoneOrEditor()then

cdnUrl="http://10.10.4.101:88/pic/"
platformSDK.printSDK('获取外部图片链接:',cdnUrl)
self.widget:ChildRawImageLoader(self.qrCodeRawImage:getID(),3,cdnUrl,qr_codeUrl,true)
else

local rootUrl=shequModel:getCdnRootURL()
local url=FMT.fmt("{0}pic/",rootUrl)
platformSDK.printSDK('获取外部图片链接:',url)
if webGLHelper:isRunMiniGame()then

self.widget:ChildRawImageLoader(self.qrCodeRawImage:getID(),2,url,qr_codeUrl,true)
else
self.widget:ChildRawImageLoader(self.qrCodeRawImage:getID(),3,url,qr_codeUrl,true)
end

end
else

self.qrCodeImage:setActive(true)
self.qrCodeRawImage:setActive(false)
if deviceHelper.isRunNoneOrEditor()then

local imageName=qr_codeUrl
local abName=FMT.fmt("ui/windows/superzushi/sharedtextures/{0}.ab",imageName)
self.qrCodeImage:setSprite(abName,imageName)
else

isShowQrCode=false
end
end
end
self.qrCodePanel:setActive(isShowQrCode)
end


function UISuperZuShiWin:onHide()

end




function UISuperZuShiWin:onMask()
self:onCloseBtn()
end



function UISuperZuShiWin:onCloseBtn()
self:closeSelf()
end

function UISuperZuShiWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end
