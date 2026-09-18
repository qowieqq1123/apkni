







def_class("UIWanBaoXunBaoDui_DismissDialogWin",UIWindowBase)









function UIWanBaoXunBaoDui_DismissDialogWin:bindComponents()

self.titleText=UIText.get(self,0)
self.dialougeText=UIText.get(self,1)
self.cancelButton=UIButton.get(self,2)
self.cancelText=UIText.get(self,3)
self.okButton=UIButton.get(self,4)
self.okText=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.modelroot=UIBaseItem.get(self,7)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIWanBaoXunBaoDui_DismissDialogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.dialougeText);self.dialougeText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.modelroot);self.modelroot=nil;
end



















function UIWanBaoXunBaoDui_DismissDialogWin:onLoaded(...)
self:bindComponents()
end


function UIWanBaoXunBaoDui_DismissDialogWin:__delete()
self:unbindComponents()

if self.btTree then
behaviorManager:removeBehaviorTree(self.btTree)
self.btTree=nil
end
end




function UIWanBaoXunBaoDui_DismissDialogWin:onShow(argtable,afterOnloaded)
self.employeeData=argtable.employeeData
self:initUI()
end


function UIWanBaoXunBaoDui_DismissDialogWin:onHide()

end





function UIWanBaoXunBaoDui_DismissDialogWin:onCancelButton()
self:closeSelf()
end



function UIWanBaoXunBaoDui_DismissDialogWin:onOkButton()
wanBaoXunBaoDuiController:reqDismissCat(self.employeeData.guid)
self:closeSelf()
end



function UIWanBaoXunBaoDui_DismissDialogWin:onCloseBtn()
self:closeSelf()
end


function UIWanBaoXunBaoDui_DismissDialogWin:initUI()
if self.btTree then
behaviorManager:removeBehaviorTree(self.btTree)
self.btTree=nil
end

local lvcfg=cfgHelper.get1(cfg_catlvconfig_get,self.employeeData.lv)
local str="是否辞退该猫猫？"

if self.employeeData.lv>1 then
str=FMT.fmt('{0}辞退后会留下',str)
for k,v in pairs(lvcfg.delBackItem)do
local item_config=itemsConfig.getConfig(v[1])
local cname=FMT.cfmt(item_config.color,FMT.fmt("[{0}]"),item_config.name)
str=FMT.fmt(" {0} {1} *{2}",str,cname,v[2])
end
end

if self.employeeData.equip_num>0 then
if self.employeeData.lv==1 then
str=FMT.fmt('{0}辞退后会留下',str)
end
local equipdata=self.employeeData.equipList[1]
local item_config=itemsConfig.getConfig(equipdata.itemid)
local cname=FMT.cfmt(item_config.color,FMT.fmt("[{0}]"),item_config.name)
str=FMT.fmt("{0} {1} *{2}。",str,cname,1)
end

local content=str

self.titleText:setText("提示")
self.dialougeText:setText(content)
self.cancelText:setText('取消')
self.okText:setText('确定')

local modelid,components=wanbaoXunBaoDuiHelper:getCatModelParam(self.employeeData)

local modelwb=self.modelroot:getChildWidgetBase()
modelwb:SetChildUIModelShowTarget(0,modelid,2,components,eAnimationID.stand2,false,false,0,nil)
modelwb:SetChildUIModelShowFlipX(0,true)

self.modelroot:setChildSizeDelta(400,400)

local initData={
widget=modelwb,
stateId=WBXBD_BT_Type.None,

speakid=1,
speakType=WBXBD_Speak_Type.dismiss,
startWaitTime=0.5,
endWaitTime=Mathf.Random(6,10),
speakOffset={-30,180},
speakDuration=5,
}
self.btTree=behaviorManager:addBehaviorTree('bt_ui_wbxbd_employee',{},true,initData)
end
