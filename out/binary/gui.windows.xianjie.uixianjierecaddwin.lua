







def_class("UIXianJieRecAddWin",UIWindowBase)









function UIXianJieRecAddWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.maskBlock=UIButton.get(self,1)
self.pointtxt=UIText.get(self,2)
self.item1=UIObject.get(self,3)
self.item2=UIObject.get(self,4)
self.item3=UIObject.get(self,5)
self.btnone=UIObject.get(self,6)
self.btntwo=UIObject.get(self,7)
self.addbtn=UIButton.get(self,8)
self.deletebtn=UIButton.get(self,9)
self.changebtn=UIButton.get(self,10)
self.priceInputField=UIInputField.get(self,11)
self.Placeholder=UIText.get(self,12)
self.cnbtn=UIButton.get(self,13)
self.nametxt=UIText.get(self,14)
self.root=UIObject.get(self,15)
self.titleText=UIText.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.addbtn:setButtonClick(function()self:onAddbtn()end)

self.deletebtn:setButtonClick(function()self:onDeletebtn()end)

self.changebtn:setButtonClick(function()self:onChangebtn()end)

self.cnbtn:setButtonClick(function()self:onCnbtn()end)



end


function UIXianJieRecAddWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.pointtxt);self.pointtxt=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.btnone);self.btnone=nil;
_UIObject_release(self.btntwo);self.btntwo=nil;
_UIObject_release(self.addbtn);self.addbtn=nil;
_UIObject_release(self.deletebtn);self.deletebtn=nil;
_UIObject_release(self.changebtn);self.changebtn=nil;
_UIObject_release(self.priceInputField);self.priceInputField=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.cnbtn);self.cnbtn=nil;
_UIObject_release(self.nametxt);self.nametxt=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end
















local _this
local itemname=
{
[1]={"特殊","icon_xianjie_tese"},
[2]={"仙友","icon_xianjie_youhao"},
[3]={"敌人","icon_xianjie_didui"},
}
local itemidx=
{
selimg=1,
btn=2,
name=3,
}
local abname="ui/windows/xianjie/xianjiemain_explora_atlas_pak.ab"



function UIXianJieRecAddWin:onLoaded(...)
self:bindComponents()
_this=self
self.itemslist={self.item1,self.item2,self.item3}
self.selectidx=1
end


function UIXianJieRecAddWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJieRecAddWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
if argtable then
self.scenceType=xianjieModel:getScenceType()
self.gridX=argtable.gridX
self.gridZ=argtable.gridZ
self.exidex=argtable.exidex
self.nameStr=argtable.nameStr
self.Point_Share=argtable.Point_Share
self.sharename=argtable.sharename
self.ishujian=argtable.ishujian or false
self.selectidx=1
self.canChange=false

self.maxrecord=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'recordMaxNum')
self.pointnum=xianjieController:getXJPointRecordData()

self.pointdata=xianjieController:checkPointRecordKey(self.scenceType,self.gridX,self.gridZ)
if not self.pointdata then
self.titleText:setText("新增记录")
self.btnone:setActive(true)
self.btntwo:setActive(false)
self.pname=self.nameStr or""
self.pselectidx=1
self.isonepass=true



self.priceInputField:setActive(false)
self.nametxt:setActive(true)
self.nametxt:setText(self.pname)
else
self.titleText:setText("修改记录")
self.btnone:setActive(false)
self.btntwo:setActive(true)
self.pname=self.pointdata[4]or""
self.pselectidx=self.pointdata[5]or 1
self.selectidx=self.pselectidx

self.priceInputField:setActive(false)
self.nametxt:setActive(true)
self.nametxt:setText(self.pname)
end
self:freshInfo()
self:checkisChange()
end
end


function UIXianJieRecAddWin:onHide()

end

function UIXianJieRecAddWin:onCloseBtn()
self:closeSelf()
end
function UIXianJieRecAddWin:onMaskBlock()
self:onCloseBtn()
end


function UIXianJieRecAddWin:onAddbtn()
local inputstr=self.priceInputField:getInputFieldValue()
if not self.isonepass then
if inputstr==''or inputstr==nil then
UIManager.info('请输入名称')
return
end
else
if inputstr==''or inputstr==nil then
inputstr=self.pname
end
end
if helper.check_spec_chars(inputstr)then
UIManager.info('名称含敏感字符')
return
end
if self.maxrecord and self.pointnum then
if self.maxrecord<=#self.pointnum then
UIManager.info('可记录坐标数量已满，请清理后再新增')
return
end
end

self.priceInputField:setInputFieldValue('')

xianjieController:addPointRecordData(self.scenceType,self.gridX,self.gridZ,inputstr,self.selectidx,self.Point_Share,self.sharename,self.ishujian)
self:onCloseBtn()
end

function UIXianJieRecAddWin:onChangebtn()
if not self.canChange then
UIManager.info('记录信息无修改')
if self.pointdata then
local str=self.priceInputField:getInputFieldValue()
if not str or str==''then
self.Placeholder:setActive(true)
self.priceInputField:setActive(false)
self.nametxt:setActive(true)
end
end
return
end
local inputstr=self.priceInputField:getInputFieldValue()
if not self.pname then
if inputstr==''or inputstr==nil then
UIManager.info('请输入名称')
return
end
else
if inputstr==''or inputstr==nil then
inputstr=self.pname
end
end
if helper.check_spec_chars(inputstr)then
UIManager.info('名称含敏感字符')
return
end
self.priceInputField:setInputFieldValue('')

xianjieController:changePointRecordData(self.scenceType,self.gridX,self.gridZ,inputstr,self.selectidx,self.Point_Share,self.sharename,self.ishujian,self.exidex)

end

function UIXianJieRecAddWin:onDeletebtn()
local scenceType=self.scenceType
local gridX=self.gridX
local gridZ=self.gridZ

local showdata=
{
type='UIDialouge',
title='提示',
content="你确定删除记录的地点吗？",
oktext='确认',
canceltext='取消',
okcallback=function(...)
if _this==nil then return end
xianjieController:deletePointRecordData(scenceType,gridX,gridZ)
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIXianJieRecAddWin:onSelectBtn(index)
if self.selectidx==index then
return
end
local oldidx=self.selectidx
self.selectidx=index

if self.itemslist[oldidx]then
local oldwidget=self.itemslist[oldidx]:getWidgetBase()
oldwidget:SetChildActive(itemidx.selimg,false)
end
if self.itemslist[self.selectidx]then
local widget=self.itemslist[self.selectidx]:getWidgetBase()
widget:SetChildActive(itemidx.selimg,true)
end

if self.pointdata then
local str=self.priceInputField:getInputFieldValue()
if not str or str==''then
self.Placeholder:setActive(true)
self.priceInputField:setActive(false)
self.nametxt:setActive(true)
end
end
self:checkisChange()
end

function UIXianJieRecAddWin:freshInfo()

for k,v in ipairs(self.itemslist)do
local widget=v:getWidgetBase()
if self.selectidx==k then
widget:SetChildActive(itemidx.selimg,true)
else
widget:SetChildActive(itemidx.selimg,false)
end
widget:SetChildText(itemidx.name,xianjie_RecordName[k]or"")
widget:SetChildButtonClick(itemidx.btn,function()
self:onSelectBtn(k)
end)
end


local sname=""
if self.scenceType==1 then
sname="仙界"
elseif self.scenceType==2 then
sname="魔界"
else
sname="仙域"
end
local str=FMT.fmt("{0}  ({1}，{2})",sname,self.gridX,self.gridZ)
self.pointtxt:setText(str)


self.frontClickMask=false
self.Placeholder:setActive(true)
self.priceInputField:setInputFieldValue('')
self.priceInputField:setChildInputFieldChange(true,function()
self:onInputFieldValueChange()
end)
end


function UIXianJieRecAddWin:checkisChange()
if self.pointdata then
self.canChange=false

local str=self.priceInputField:getInputFieldValue()
if self.pname then
if str and str~=''and str~=self.pname then
self.canChange=true
end
end
if self.pselectidx~=self.selectidx then
self.canChange=true
end

if self.canChange then
_this.winlua:SetChildGray(_this.changebtn:getID(),false)
else
_this.winlua:SetChildGray(_this.changebtn:getID(),true)
end
end
end


function UIXianJieRecAddWin:onCnbtn()
self.priceInputField:setActive(true)
self.nametxt:setActive(false)
self.isonepass=false
end
function UIXianJieRecAddWin:onClickInput()
self.Placeholder:setActive(false)
end
function UIXianJieRecAddWin:onExitInput()
self.frontClickMask=false
local str=self.priceInputField:getInputFieldValue()
if not str or str==''then
self.Placeholder:setActive(true)
end

end
function UIXianJieRecAddWin:onInputFieldValueChange()
self.frontClickMask=true
self:checkisChange()
end

