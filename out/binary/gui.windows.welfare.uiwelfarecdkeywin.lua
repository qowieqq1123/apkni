







def_class("UIWelfareCdKeyWin",UIWindowBase)









function UIWelfareCdKeyWin:bindComponents()

self.InputField=UIInputField.get(self,0)
self.Placeholder=UIText.get(self,1)
self.sureBtn=UIButton.get(self,2)
self.cancelBtn=UIButton.get(self,3)
self.showCdKeyPanel=UIObject.get(self,4)
self.cdKeyScrollView=UIObject.get(self,5)
self.addKeyBtn=UIButton.get(self,6)
self.weakGideClickPanel=UIButton.get(self,7)
self.tipspanel=UIObject.get(self,8)
self.tipstxt=UIText.get(self,9)
self.testpanel=UIObject.get(self,10)
self.clickInputTips=UIText.get(self,11)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.addKeyBtn:setButtonClick(function()self:onAddKeyBtn()end)

self.weakGideClickPanel:setButtonClick(function()self:onWeakGideClickPanel()end)



end


function UIWelfareCdKeyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.showCdKeyPanel);self.showCdKeyPanel=nil;
_UIObject_release(self.cdKeyScrollView);self.cdKeyScrollView=nil;
_UIObject_release(self.addKeyBtn);self.addKeyBtn=nil;
_UIObject_release(self.weakGideClickPanel);self.weakGideClickPanel=nil;
_UIObject_release(self.tipspanel);self.tipspanel=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.testpanel);self.testpanel=nil;
_UIObject_release(self.clickInputTips);self.clickInputTips=nil;
end
















local maxSendCount=10
local cdKeyItemIndex={
cmp_cdKeyText=0,
cmp_removeBtn=1,
}
local _this




function UIWelfareCdKeyWin:onLoaded(...)
_this=self
self:bindComponents()

self.isRunDouYin=webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()

self.cdKeyScrollView:setChildScrollViewInit(0.5,true,nil,nil)
if api_Available_SetChildInputLineType()then
self.widget:SetChildInputLineType(self.InputField:getID(),2)
end
end


function UIWelfareCdKeyWin:__delete()
_this=nil
self:unbindComponents()
end




function UIWelfareCdKeyWin:onShow(argtable,afterOnloaded)

self.cdKeyList={}
self.realCdKeyList={}
self:onShowArgRecv()
self:showTipPanel()
end


function UIWelfareCdKeyWin:onShowArgRecv()

local cdkeyGuideFinish=welfareModel:getCdKeyGuideFinishMark()
if not cdkeyGuideFinish then

self.Placeholder:setActive(false)
local defaultCdKey,realCdKey=welfareModel:getDefaultCdKey_sortById()
self.realCdKey=realCdKey
platformSDK.printSDK('CdKey SetInput',defaultCdKey)
self.InputField:setInputFieldValue(defaultCdKey)

self.weakGideClickPanel:setActive(false)
self.clickInputTips:setActive(false)
else

self.Placeholder:setActive(true)
self.InputField:setInputFieldValue('')
self.isFinishGuide=true

self.weakGideClickPanel:setActive(false)
self.clickInputTips:setActive(false)
end

self:setCdKeyList()
self:refreshShowCdKeyList()

if self.isRunDouYin and cdkeyGuideFinish then
self:checkAndInputDouYinCDKey()
end
end


function UIWelfareCdKeyWin:onHide()

end


function UIWelfareCdKeyWin:refreshShowCdKeyList()
if not next(self.cdKeyList)then

self.InputField:setActive(true)
self.InputField:setInputFieldValue('')
self.Placeholder:setActive(true)
self.clickInputTips:setActive(false)
self.showCdKeyPanel:setActive(false)
self.addKeyBtn:setActive(false)
self.sureBtn:setActive(false)
self.cancelBtn:setActive(false)
return
end

self.InputField:setActive(false)
self.showCdKeyPanel:setActive(true)

self.cdKeyScrollView:setChildScrollViewCreateGrids(#self.cdKeyList,1)
local grids=self.cdKeyScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local cdKey=self.cdKeyList[i]
item:SetChildText(cdKeyItemIndex.cmp_cdKeyText,cdKey)
item:SetChildButtonClick(cdKeyItemIndex.cmp_removeBtn,function()
self:onClickCdKeyRemoveBtn(i)
end)
end
end

self:checkCdKeyListShow()

self.sureBtn:setActive(true)
self.cancelBtn:setActive(true)
self.clickInputTips:setActive(false)


self.addKeyBtn:setActive(count<maxSendCount)
end


function UIWelfareCdKeyWin:setCdKeyList()
self.cdKeyList={}
self.realCdKeyList={}
local str=self.InputField:getInputFieldValue()
if str~=''then
local pattern="[^\n%s]+"

if pfwindowslController:checkIsGameVersion_yuenan()then
pattern="[^\n]+"
end
platformSDK.printSDK('CdKey Input',str)
for split in string.gmatch(str,pattern)do
table.insert(self.cdKeyList,split)
end
end
if not self.isFinishGuide then
str=self.realCdKey
if str~=''then
local pattern="[^\n%s]+"

if pfwindowslController:checkIsGameVersion_yuenan()then
pattern="[^\n]+"
end
for split in string.gmatch(str,pattern)do
table.insert(self.realCdKeyList,split)
end
end
end
end

function UIWelfareCdKeyWin:checkAndInputDouYinCDKey()
if self.isRunDouYin then
local query=webGLHelper:getQueryArgs()
local cdkey=query.game_cdkey
if cdkey then
platformSDK:reqCheckCDKey(cdkey,function(success,result)
if success then
if _this then
_this.InputField:setInputFieldValue(cdkey)
_this:setCdKeyList()
_this:refreshShowCdKeyList()
end
end
end)
end
end
end





function UIWelfareCdKeyWin:onSureBtn()
self:setCdKeyList()
if not next(self.cdKeyList)then
return
end

if self.isRunDouYin and self.isFinishGuide then
local query=webGLHelper:getQueryArgs()
local cdkey=query.game_cdkey
if cdkey then
local needCheck=false
for i,v in ipairs(self.cdKeyList)do
if v==cdkey then
needCheck=true
break
end
end
if needCheck then
platformSDK:reqCheckCDKey(cdkey,function(success,result)
if success then
if _this then
_this:sendCDKey()
end
query.game_cdkey=nil
else
local tips=_this and _this:getDouYinCDKeyTipsText(result)or'无法使用'
UIManager.error(FMT.fmt('兑换码{0}{1}',cdkey,tips))
end
end)
return
end
end
end

self:sendCDKey()
end

function UIWelfareCdKeyWin:getDouYinCDKeyTipsText(result)
local data=jsonHelper.decode_josn(result)
if data then
if data.errCode==28006040 then
return'已使用，无需再提交'
end
end
return'无法使用'
end

function UIWelfareCdKeyWin:sendCDKey()
if not self.isFinishGuide then
UISettingController:req_cdkey_reward(self.realCdKeyList)
else
UISettingController:req_cdkey_reward(self.cdKeyList)
end
self.InputField:setInputFieldValue('')
self:setCdKeyList()
self:refreshShowCdKeyList()
if not self.isFinishGuide then
if not welfareModel:getCdKeyGuideFinishMark()then

welfareModel:setCdKeyGuideFinishMark()
end

self.isFinishGuide=true


reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end

self:checkAndInputDouYinCDKey()
end



function UIWelfareCdKeyWin:onCancelBtn()
if not self.isFinishGuide then

return
end
self.InputField:setInputFieldValue('')
self:setCdKeyList()
self:refreshShowCdKeyList()
end

function UIWelfareCdKeyWin:onClickInput()
self.Placeholder:setActive(false)
self.clickInputTips:setActive(true)
end


function UIWelfareCdKeyWin:onExitInput()



self:setCdKeyList()


if next(self.cdKeyList)and#self.cdKeyList>maxSendCount then

UIManager.error(FMT.fmt('最多同时输入{0}条兑换码',maxSendCount))
return
end


self:refreshShowCdKeyList()
end

function UIWelfareCdKeyWin:onAddKeyBtn()
if not self.isFinishGuide then

return
end

local str=''
if next(self.cdKeyList)then
str=table.concat(self.cdKeyList,"\n ")
self.Placeholder:setActive(false)
self.clickInputTips:setActive(true)
str=FMT.fmt('{0}\n',str)
else
self.Placeholder:setActive(true)
self.clickInputTips:setActive(false)
end

self.InputField:setActive(true)
self.InputField:setInputFieldValue(str)
self.showCdKeyPanel:setActive(false)
self.addKeyBtn:setActive(false)
self.sureBtn:setActive(false)
self.cancelBtn:setActive(false)

self:onClickInput()
end

function UIWelfareCdKeyWin:onClickCdKeyRemoveBtn(index)
if not self.isFinishGuide then

return
end

if index and self.cdKeyList[index]then
table.remove(self.cdKeyList,index)
end


self:refreshShowCdKeyList()
end

function UIWelfareCdKeyWin:onWeakGideClickPanel()















end


function UIWelfareCdKeyWin:checkCdKeyListShow()


local width_scrollView=self.cdKeyScrollView:getChildSizeDeltaX()

local scrollPanelTransform=self.showCdKeyPanel:getTransform()
local scrollPanelRect=scrollPanelTransform.rect
local height_scrollPanel=scrollPanelRect.height

local height_scrollView_max=height_scrollPanel*0.69+0.5



local height_item=52
local startOffset_Y=-3
local endOffset_Y=5
local space_Y=8
local count=#self.cdKeyList
local height_content=height_item*count-startOffset_Y+endOffset_Y+(count-1>=0 and space_Y*count or 0)


local isExceedMaxShow=height_content>height_scrollView_max


self.winlua:SetChildScrollRectEnable(self.cdKeyScrollView:getID(),isExceedMaxShow)


local height_scrollView=isExceedMaxShow and height_scrollView_max or height_content
self.cdKeyScrollView:setChildSizeDelta(width_scrollView,height_scrollView)


if isExceedMaxShow then
local jumpIndex=count
self.cdKeyScrollView:setChildScrollViewSelectItem(jumpIndex,false,false,false)
end
end


function UIWelfareCdKeyWin:showTipPanel()
local pfid=loginModel:getPfid()
local cfg_tips_platform=cfg_tipsservercdkeyconfig_get(1).tips_platform
local isshow=cfg_tips_platform[pfid]
if isshow then
self.tipspanel:setActive(true)
self.tipstxt:setText(isshow or"")
self.winlua:SetChildLocalPosY(self.testpanel:getID(),17)
else
self.tipspanel:setActive(false)
end
end
