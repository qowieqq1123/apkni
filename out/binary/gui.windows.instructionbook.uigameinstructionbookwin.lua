







def_class("UIGameInstructionBookWin",UIWindowBase)









function UIGameInstructionBookWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.Content=UIObject.get(self,2)
self.CSGUIScrollView=UIComboScrollView.get(self,3)
self.model=UIObject.get(self,4)
self.paragraphList=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.titleImg=UIImage.get(self,7)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIGameInstructionBookWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.paragraphList);self.paragraphList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
end















local _this=nil
local _imagAB="ui/windows/instructionbook/instructionbook_image_atlas_pak.ab"
local _comboMainCmp={
name=0,
arrow_close=1,
arrow_open=2,
}
local _comboSubCmp={
name=0,
selected=1,
}
local _paragrapCmp={
list=-1,
name=0,
}
local _contentCmp={
text=0,
sign=1,
image=2,
}
local _contentItemHandle={
[instructionbookModel.eContentType.eTextWithBullets]=function(item,content)
item:SetChildActive(_contentCmp.text,true)
item:SetChildActive(_contentCmp.image,false)
item:SetChildText(_contentCmp.text,FMT.fmt("     {0}",content[1]))
item:SetChildActive(_contentCmp.sign,true)
end,
[instructionbookModel.eContentType.eTextWithoutBullets]=function(item,content)
item:SetChildActive(_contentCmp.text,true)
item:SetChildActive(_contentCmp.image,false)
item:SetChildText(_contentCmp.text,content[1])
item:SetChildActive(_contentCmp.sign,false)
end,
[instructionbookModel.eContentType.eImage]=function(item,content)
item:SetChildActive(_contentCmp.text,false)
item:SetChildActive(_contentCmp.image,true)
item:SetChildSizeDelta(_contentCmp.image,content[2],content[3])
item:SetChildCSImageSprite(_contentCmp.image,_imagAB,content[1])
end,
}



function UIGameInstructionBookWin:onLoaded(...)
self:bindComponents()
_this=self

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)
self.mainIndex=nil
self.subIndex=nil

self.data=instructionbookModel:getSortList()
self.CSGUIScrollView:createMainGrids(#self.data,1,true)
end


function UIGameInstructionBookWin:__delete()
self:unbindComponents()
_this=nil
end




function UIGameInstructionBookWin:onShow(argtable,afterOnloaded)
self:initView(argtable)
self.root:setChildCanvasGroupAlpha(0)
self.model:setChildUIModelShowTarget(5223,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(2/3,function()
self.root:setChildCanvasGroupDOFade(1,0.25)
if argtable.subId==28 then
local pos=self.winlua:GetChildAnchoredPosition(self.Content:getID())
self.winlua:SetChildAnchoredPos(self.Content:getID(),pos.x,285)
end
end)
end)
end


function UIGameInstructionBookWin:onHide()

end





function UIGameInstructionBookWin:onBackground()
self:onCloseBtn()
end



function UIGameInstructionBookWin:onCloseBtn()
self:closeSelf()
end

function UIGameInstructionBookWin:initView(argtable)
if argtable then
if argtable.subId then
for mainIndex,data in ipairs(self.data)do
for subIndex,subId in ipairs(data.list)do
if subId==argtable.subId then
self.jumpSub=subIndex
self.CSGUIScrollView:clickItem(mainIndex-1)
return
end
end
end
end
if argtable.mainId then
for mainIndex,data in ipairs(self.data)do
if data.id==argtable.mainId then
self.CSGUIScrollView:clickItem(mainIndex-1)
return
end
end
end
end
end

function UIGameInstructionBookWin:mainClickAction(mainItem)
local mainIndex=mainItem.Index+1
if self.mainIndex~=mainIndex then
if self.mainIndex then
local mItem=self.CSGUIScrollView:getMainItem(self.mainIndex-1)
local mainData=self.data[self.mainIndex]
if mainData.id~=0 then
mainItem:SetChildActive(_comboMainCmp.arrow_open,false)
mainItem:SetChildActive(_comboMainCmp.arrow_close,true)
else
mainItem:SetChildActive(_comboMainCmp.arrow_open,false)
mainItem:SetChildActive(_comboMainCmp.arrow_close,false)
end
end
self.mainIndex=mainIndex
mainItem:SetChildActive(_comboMainCmp.arrow_open,true)
mainItem:SetChildActive(_comboMainCmp.arrow_close,false)

local mainData=self.data[mainIndex]
if#mainData.list>0 then
self.subIndex=self.jumpSub or 1
self.jumpSub=nil
local sItem=self.CSGUIScrollView:getSubItem(self.mainIndex-1,self.subIndex-1)
if sItem then
sItem:SetChildActive(_comboSubCmp.selected,true)
end
self:onChoose()
else
local data=houtaiModel:getSheQuEnterData()
local jumpURL=data.jumpURL
local apiLevel=deviceHelper.getAPILevel()
if apiLevel<431 then
if deviceHelper.isRunIOS()and apiLevel>=400 then
platformSDK:reqOpenURL(jumpURL)
else
LuaApplication.GetApplication().OpenURL(jumpURL)
end
else

platformSDK:reqOpenCommunity(10004)
end
mainItem:SetChildActive(_comboMainCmp.arrow_open,false)
mainItem:SetChildActive(_comboMainCmp.arrow_close,false)
end
else
self.mainIndex=nil
local mainData=self.data[mainIndex]
if mainData.id~=0 then
mainItem:SetChildActive(_comboMainCmp.arrow_open,false)
mainItem:SetChildActive(_comboMainCmp.arrow_close,true)
else
mainItem:SetChildActive(_comboMainCmp.arrow_open,false)
mainItem:SetChildActive(_comboMainCmp.arrow_close,false)
end


end
end

function UIGameInstructionBookWin:subClickAction(subItem)
local subIndex=subItem.Index+1
if self.subIndex~=subIndex then
if self.subIndex~=nil then
local sItem=self.CSGUIScrollView:getSubItem(self.mainIndex-1,self.subIndex-1)
sItem:SetChildActive(_comboSubCmp.selected,false)
end
self.subIndex=subIndex
subItem:SetChildActive(_comboSubCmp.selected,true)
self:onChoose()
end
end

function UIGameInstructionBookWin:mainCreateAction(mainItem)
local mainIndex=mainItem.Index+1
local selected=mainIndex==self.mainIndex
local mainData=self.data[mainIndex]
local mainId=mainData.id
local nameStr
if mainId~=0 then
local mainCfg=cfgHelper.get1(cfg_instructionbookmaintabconfig_get,mainId)
nameStr=mainCfg.name
mainItem:SetChildActive(_comboMainCmp.arrow_open,selected)
mainItem:SetChildActive(_comboMainCmp.arrow_close,not selected)
else
nameStr=mainData.name
mainItem:SetChildActive(_comboMainCmp.arrow_open,false)
mainItem:SetChildActive(_comboMainCmp.arrow_close,false)
end

local count=#mainData.list

mainItem:SetChildText(_comboMainCmp.name,nameStr)
mainItem:SetAddExpandColumCount(count)
end

function UIGameInstructionBookWin:subCreateAction(subItem)
local subIndex=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local selected=subIndex==self.subIndex and mainIndex==self.mainIndex
local mainData=self.data[mainIndex]
local subId=mainData.list[subIndex]
local subCfg=cfgHelper.get1(cfg_instructionbooksubtabconfig_get,subId)
local nameStr=subCfg.name
subItem:SetChildText(_comboSubCmp.name,nameStr)
subItem:SetChildActive(_comboSubCmp.selected,selected)
end

function UIGameInstructionBookWin:onExpandAction(mainIndex)

end

function UIGameInstructionBookWin:onChoose()
local mainData=self.data[self.mainIndex]
local subCfg=cfgHelper.get1(cfg_instructionbooksubtabconfig_get,mainData.list[self.subIndex])
self.titleImg:setSprite(_imagAB,subCfg.image)
self.paragraphList:setChildAnchoredPos(0,0)
self.paragraphList:setChildLayoutGroupCreateItems(#subCfg.list,function(paragraphIndex)
local paragraphItem=self.paragraphList:getChildLayoutGroupGridItem(paragraphIndex-1)
local paragraphCfg=cfgHelper.get1(cfg_instructionbookparagraphconfig_get,subCfg.list[paragraphIndex])
paragraphItem:SetChildText(_paragrapCmp.name,paragraphCfg.name)
paragraphItem:SetChildLayoutGroupCreateItems(_paragrapCmp.list,#paragraphCfg.list,function(contentIndex)
local contentItem=paragraphItem:GetChildLayoutGroupGridItem(_paragrapCmp.list,contentIndex-1)
local contentId=paragraphCfg.list[contentIndex]
local contentCfg=cfgHelper.get1(cfg_instructionbookcontentconfig_get,contentId)
local contentType=contentCfg.type
local contentText=contentCfg.content
_contentItemHandle[contentType](contentItem,contentText)
end)
self.winlua:ForceLayoutRect(self.paragraphList:getID())
end)
end
