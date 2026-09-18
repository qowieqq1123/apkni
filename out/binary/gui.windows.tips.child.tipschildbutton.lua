







def_class("tipsChildButton",UICloneObject)





tipsChildButton.abName="ui/windows/tips/child/tipschildbutton.ab"

tipsChildButton.assetName="tipsChildButton"


function tipsChildButton:bindComponents()

self.cbtn=UIButton.get(self,0)
self.btn_txt=UIText.get(self,1)
self.btnAni=UIObject.get(self,2)
self.reddot=UIObject.get(self,3)

self.cbtn:setButtonClick(function()self:onCbtn()end)
self.btn={
["txt"]=self.btn_txt,
}

end


function tipsChildButton:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cbtn);self.cbtn=nil;
_UIObject_release(self.btn_txt);self.btn_txt=nil;
_UIObject_release(self.btnAni);self.btnAni=nil;
_UIObject_release(self.reddot);self.reddot=nil;
self.btn=nil;
end





local _menuBody=2017
function tipsChildButton:onLoaded()
self:bindComponents()
end

function tipsChildButton:__delete()
self.widget:SetChildNewBieComponentId(self.cbtn:getID(),"")
self:unbindComponents()
end

function tipsChildButton:onShow(args)
local order=self.__order
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local btnType=args.btnType
local tipsType=data.tipsType
local formType=data.formType
local isLeftBtn=data.isLeftBtn
local hideBtnRed=data.hideBtnRed
local tipsbtnsconfig=cfg_tipsbtnsconfig_get(btnType)
local name=tipsbtnsconfig.name

self.btnType=btnType
self.itemid=itemid
self.itemguid=itemguid
self.attach=attach
self.tipsType=tipsType
self.formType=formType
self.isLeftBtn=isLeftBtn
self.hideBtnRed=hideBtnRed
local reddotType=attach.reddotType
self:stopAllReddotNotify()
if reddotType then
self:addReddotNotify(reddotType,function(...)
self:refreshReddotType(...)
end)
end

self.isGray=tipsConfig.callBtnsFuncGray(self.btnType,self.itemid,self.itemguid,self.attach,self.tipsType,self.formType)
local name_str=name
if self.isGray then
name_str=toColorString(FONT_COLOR.eGrayColor,name_str)
end
self.btn_txt:setText(name_str)
self.btnAni:setChildUIModelShowTarget(_menuBody,1,{},eAnimationID.common_window_enter)
if api_Available_SetChildUIModelGray()then
self.widget:SetChildUIModelGray(self.btnAni:getID(),self.isGray)
else
local colorV=self.isGray and 0.3 or 1
self.widget:SetChildUIModelShowColor(self.btnAni:getID(),Color.New(colorV,colorV,colorV,1))
end
self:refreshReddot()
self.widget:SetChildNewBieComponentId(self.cbtn:getID(),FMT.fmt('tipsChildButton.cbtn.{0}',order))


if self.isLeftBtn then
self.btnAni:setScale(Vector3(-1,1,1))
self.widget:SetChildLocalPosX(self.btn_txt:getID(),49)
self.widget:SetChildLocalPosX(self.reddot:getID(),-25)
else
self.btnAni:setScale(Vector3(1,1,1))
self.widget:SetChildLocalPosX(self.btn_txt:getID(),43)
self.widget:SetChildLocalPosX(self.reddot:getID(),25)
end
end

function tipsChildButton:onCbtn()
if self.isGray and self.attach.cannotClickGray then
return
end
self.btnAni:setChildUIModelShowTarget(_menuBody,1,{},eAnimationID.common_window_dianji)
tipsConfig.callBtnsFunc(self.btnType,self.itemid,self.itemguid,self.attach,self.tipsType,self.formType)
end


function tipsChildButton:refreshReddot()
local isreddot=tipsConfig.callBtnsFuncReddot(self.btnType,self.itemid,self.itemguid,self.attach,self.tipsType,self.formType)
self.reddot:setActive(not self.hideBtnRed and isreddot)
end

function tipsChildButton:refreshReddotType(index,class,sub_typo,last_flag,flag)
self.reddot:setActive(not self.hideBtnRed and flag)
end
