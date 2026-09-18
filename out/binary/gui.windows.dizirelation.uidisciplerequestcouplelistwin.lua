







def_class("UIDiscipleRequestCoupleListWin",UIWindowBase)









function UIDiscipleRequestCoupleListWin:bindComponents()

self.root=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.requestItem_1=UIObject.get(self,3)
self.requestItem_2=UIObject.get(self,4)
self.requestItem_3=UIObject.get(self,5)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)
self.requestItem={
self.requestItem_1,
self.requestItem_2,
self.requestItem_3,
}



end


function UIDiscipleRequestCoupleListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.requestItem_1);self.requestItem_1=nil;
_UIObject_release(self.requestItem_2);self.requestItem_2=nil;
_UIObject_release(self.requestItem_3);self.requestItem_3=nil;
self.requestItem=nil;
end



















local this
function UIDiscipleRequestCoupleListWin:onLoaded(...)
self:bindComponents()
this=self
end


function UIDiscipleRequestCoupleListWin:__delete()
self:unbindComponents()

DiscipleCoupleModel:CheckDelReqCoupleList()
end




function UIDiscipleRequestCoupleListWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5389,1,{},eAnimationID.stand)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.6)
end)
end
self.reqCoupleList=DiscipleCoupleModel:getReqCoupleList()
self:refreshReqListPanel()
if argtable then
if argtable.man and argtable.woman and argtable.dialogueId and argtable.timeStamp then
local manGuid=argtable.man
local womanGuid=argtable.woman
local dialogueId=argtable.dialogueId
local timeStamp=argtable.timeStamp
UIManager:showWindow("UIDiscipleRequestCoupleWin",{man=manGuid,woman=womanGuid,dialogueId=dialogueId,timeStamp=timeStamp})
end
end
end


function UIDiscipleRequestCoupleListWin:onHide()

DiscipleCoupleModel:CheckDelReqCoupleList()
end


function UIDiscipleRequestCoupleListWin:refreshReqListPanel()
local tNum=#self.requestItem
for i=1,tNum do
local item=self.requestItem[i]:getWidgetBase()
local netdata=self.reqCoupleList[i]
if netdata then
local manGuid=netdata.man
local womanGuid=netdata.woman
local timeStamp=netdata.timeStamp
if UIDiscipleModel:getDiscipleData(manGuid)or UIDiscipleModel:getDiscipleData(womanGuid)then
item:SetChildActive(-1,true)
local manName=UIDiscipleModel:getDiscipleName(manGuid)
local womanName=UIDiscipleModel:getDiscipleName(womanGuid)
local dialogueId=netdata.dialogueId or 1
if dialogueId>#cfg_reqcoupledialogueconfig()or dialogueId<=0 then
dialogueId=1
end
local cfg=cfgHelper.get1(cfg_reqcoupledialogueconfig_get,dialogueId)

comHelper.setChildModelRawImage(item,manGuid,0,0,eHeadCenterType.eHead)
comHelper.setChildModelHeadIconBG(item,6,manGuid)
comHelper.setChildModelRawImage(item,womanGuid,1,0,eHeadCenterType.eHead)
comHelper.setChildModelHeadIconBG(item,7,womanGuid)

item:SetChildText(2,manName)
item:SetChildText(3,womanName)

item:SetChildText(4,string.format(cfg.desc,manName,womanName))

local manCouple=DiscipleCoupleModel:getDiscipleCoupleGuid(manGuid)
local womanCouple=DiscipleCoupleModel:getDiscipleCoupleGuid(womanGuid)
local gray=manCouple~=nil or womanCouple~=nil
local mercurialName=manCouple~=nil and manName or womanName
item:SetChildImageExGray(5,gray)
item:SetChildButtonClick(5,function()
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local NowTimeStamp=timeHelper.getServerShortTime()
local pastTime=NowTimeStamp-timeStamp
if pastTime<cfg.duration then
if gray then
UIManager.error(FMT.fmt("{0}已有道侣",mercurialName))
else
UIManager:showWindow("UIDiscipleRequestCoupleWin",{man=manGuid,woman=womanGuid,dialogueId=dialogueId,timeStamp=timeStamp})
end
else
DiscipleCoupleModel:DelReqCoupleList(manGuid,womanGuid)
UIManager:invokeUIMethod('UIFuncStorageWin','refreshCoupleRequestBtn')
UIManager:invokeUIMethod('UIDiscipleRequestCoupleListWin','onShow')
UIManager.error("该弟子请求良缘时间已过期")
if#DiscipleCoupleModel:getReqCoupleList()<=0 then
UIManager:closeWindow('UIDiscipleRequestCoupleListWin')
end
end
end)
else
item:SetChildActive(-1,false)
end
else
item:SetChildActive(-1,false)
end
end
end

function UIDiscipleRequestCoupleListWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='UIReqCoupleRule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end