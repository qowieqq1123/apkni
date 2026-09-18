







def_class("UIXianJieLingShouShareWin",UIWindowBase)









function UIXianJieLingShouShareWin:bindComponents()

self.cancelBtn=UIButton.get(self,0)
self.countTip=UIText.get(self,1)
self.descTxt=UILinkImageText.get(self,2)
self.frameSp=UIObject.get(self,3)
self.mainroot=UIObject.get(self,4)
self.optionList=UIObject.get(self,5)
self.pos=UILinkImageText.get(self,6)
self.privateChannel=UIObject.get(self,7)
self.privateCount=UIText.get(self,8)
self.root=UIObject.get(self,9)
self.shareBtn=UIButton.get(self,10)
self.sharename=UILinkImageText.get(self,11)
self.titleTxt=UIText.get(self,12)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UIXianJieLingShouShareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.countTip);self.countTip=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.mainroot);self.mainroot=nil;
_UIObject_release(self.optionList);self.optionList=nil;
_UIObject_release(self.pos);self.pos=nil;
_UIObject_release(self.privateChannel);self.privateChannel=nil;
_UIObject_release(self.privateCount);self.privateCount=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.sharename);self.sharename=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end















local _this=nil

local _scrollSizeX=490
local _scrollSizeY={630,590,560}
local _scrollPosY={0,-20,-35}

local _subItemIndex=
{
bg=0,
head=1,
name=2,
sdi=3,
simg=4
}

local CmpOptionItemIndex={
self=0,
optionusimg=1,
optionssimg=2,
name=3,
lockimg=4,
exportimg=5,
exportroot=6,
friendnum=7,
}

local optionCfg={
[CHAT_CHANNNEL.eXianmeng]={

channel=CHAT_CHANNNEL.eXianmeng,
isShowExport=false,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)and xianmengModel:hasXM()
end,
getTipStr=function(channel)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[channel])
end
if not xianmengModel:hasXM()then
return"请先加入一个仙盟"
end
end,
},
}




function UIXianJieLingShouShareWin:onLoaded(...)
self:bindComponents()

_this=self
end


function UIXianJieLingShouShareWin:__delete()

_this=nil
self:unbindComponents()
end




function UIXianJieLingShouShareWin:onShow(argtable,afterOnloaded)
self.infoGuid=argtable.infoGuid

self.optionTypes={CHAT_CHANNNEL.eXianmeng}
self.optionState={}
self.optionNum=0

self.optionList:setChildLayoutGroupCreateItems(#self.optionTypes,function(index)
if _this==nil then return end
_this:refreshOptionItem(nil,index)
end)

local lsData=xianjieController:getLingShouData(self.infoGuid)
local name=lsData:getName()
self.sharename:setText(name)
local sharePosStr=FMT.fmt('（X:{0},Y:{1}）',lsData.gridX_c,lsData.gridZ_c)
self.pos:setText(sharePosStr)
local fmt='我在【仙界】发现了{0}({1},{2})，快来看看吧'
local descStr=FMT.fmt(fmt,name,lsData.gridX_c,lsData.gridZ_c)
self.descTxt:setText(descStr)

self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4851,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.25,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
local shareBtnState=_this.optionNum>0
_this.shareBtn:setButtonEnable(shareBtnState,not shareBtnState)
end


function UIXianJieLingShouShareWin:onHide()

end

function UIXianJieLingShouShareWin:refreshOptionItem(item,index)
if item==nil then
item=self.optionList:getChildLayoutGroupGridItem(index-1)
end
local channel=self.optionTypes[index]
local cfg=optionCfg[channel]
local selectState=self.optionState[channel]~=nil
local isUnlock=cfg.checkOpen(channel)
local isPrivate=channel==CHAT_CHANNNEL.ePrivate

item:SetChildActive(CmpOptionItemIndex.optionusimg,not selectState or isPrivate)
item:SetChildActive(CmpOptionItemIndex.optionssimg,selectState and not isPrivate)
item:SetChildText(CmpOptionItemIndex.name,CHAT_CHANNNEL_NAME[channel])
item:SetChildActive(CmpOptionItemIndex.lockimg,not isUnlock)
item:SetChildActive(CmpOptionItemIndex.exportimg,cfg.isShowExport and isUnlock)
item:SetChildActive(CmpOptionItemIndex.exportroot,cfg.isShowExport and isUnlock and self.isShowFirentPart)
if cfg.isShowExport then
item:SetChildText(CmpOptionItemIndex.friendnum,self.privateActorNum)
end

item:SetBaseItemClickEvent(CmpOptionItemIndex.self,function()
if isUnlock then

_this.optionState[channel]=not selectState and channel or nil
_this.optionNum=not selectState and _this.optionNum+1 or _this.optionNum-1
selectState=not selectState
item:SetChildActive(CmpOptionItemIndex.optionusimg,not selectState or isPrivate)
item:SetChildActive(CmpOptionItemIndex.optionssimg,selectState and not isPrivate)
if isPrivate then
local exportRootState=isPrivate and _this.optionState[channel]~=nil
_this.exportroot:setActive(exportRootState)
_this.isShowFirentPart=exportRootState
item:SetChildActive(CmpOptionItemIndex.exportroot,exportRootState)
if exportRootState and not _this.isCreateFirentPart then
_this.isCreateFirentPart=true
_this:freshExportRoot()
end
item:SetChildText(CmpOptionItemIndex.friendnum,_this.privateActorNum)
end
if not isPrivate then
local shareBtnState=_this.optionNum>0
_this.shareBtn:setButtonEnable(shareBtnState,not shareBtnState)
end
else

local tipstr=cfg.getTipStr(channel)
UIManager.info(tipstr)
end
end)
end





function UIXianJieLingShouShareWin:onCancelBtn()
self:closeSelf()
end



function UIXianJieLingShouShareWin:onShareBtn()
if self.optionNum>0 then
local guid=xianjieModel:getShareLSGuid()
local lsdata=xianjieController:getLingShouData_exExpire(guid)
if guid==0 or lsdata==nil or lsdata.isExpire then
xianjieController:reqLingShouShare(self.infoGuid)
else
UIManager.error("已有分享灵兽")
end
end
end

function UIXianJieLingShouShareWin:onCloseBtn()
self:closeSelf()
end
