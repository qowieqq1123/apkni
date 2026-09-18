






UIDialogManager={}
local _CSUIManager=CS.UIManager
local _CreateWindow=_CSUIManager.CreateWindow
local dialogguid=0
local _ctor={}
local active_dialogs={}
local _singleton_dialog=nil
local _common_dialog=nil
local function _PreloadCtor(info)

local src=info.src
local ctor=_ctor[info.creator]
if ctor==nil then
require(src)
ctor=_G[info.creator]
_ctor[info.creator]=ctor
info.ctor=ctor
end
end

function UIDialogManager:onAppStart()
_CSUIManager.sOnDialogLoaded=UIDialogManager.OnDialogLoaded
end

function UIDialogManager.OnDialogLoaded(guid,winlua)

local index=tonumber(guid)
local showdata=active_dialogs[index]
if not showdata then

loggerUtil.log(FMT.fmt('对话框加载完成【已关闭】 {0}',guid))
if winlua~=nil then
winlua:Close()
end
return
end

local typename=showdata.type
local info=UIDialogConfig[typename]
loggerUtil.log(FMT.fmt('对话框加载完成 {0}_{1}',typename,guid))
local dialog=info.ctor(winlua.gameObject,winlua)
winlua:Show()
showdata.dialog=dialog


dialog:onLoaded()

dialog:onShow(showdata)
end













local function _newDialogGUID()
dialogguid=dialogguid+1
return dialogguid
end




local function _markActive(showdata)

assert(showdata.id)
local guid=showdata.id
if active_dialogs[guid]then
return
end
active_dialogs[guid]=showdata
local info=UIDialogConfig[showdata.type]
_PreloadCtor(info)























local canvasIndex=showdata.canvasIndex or-1
loggerUtil.log(FMT.fmt('开始加载对话框 {0}_{1}',showdata.type,guid))
_CSUIManager.LoadDialogWindow(tostring(guid),info.ab,canvasIndex,true)
return guid
end




local function _markInActive(guid)

local showdata=active_dialogs[guid]
if showdata then
showdata.dialog=nil
active_dialogs[guid]=nil
end










end

local function _newDialog(show_data)
show_data.id=_newDialogGUID()
show_data.show=function()








_markActive(show_data)

end
show_data.closeOK=function()
if show_data.dialog and not show_data.dialog.isClose then
if show_data.dialog.doOk then
show_data.dialog:doOk()
end
else
show_data:deleteSelf()
end
end
show_data.closeCancel=function()
if show_data.dialog and not show_data.dialog.isClose then
if show_data.dialog.doCancel then
show_data.dialog:doCancel()
end
else
show_data:deleteSelf()
end
end


show_data.hide=function()
if show_data.dialog then
show_data.dialog:doClose()
else
show_data:deleteSelf()
end
end
show_data.deleteSelf=function()

_markInActive(show_data.id)
end
return show_data
end

function UIDialogManager.showSingletonDialog(show_data)
if _singleton_dialog then
_singleton_dialog:hide()
end
_singleton_dialog=_newDialog(show_data)
local oldDeleteSelf=_singleton_dialog.deleteSelf
_singleton_dialog.deleteSelf=function(...)

_singleton_dialog=nil
oldDeleteSelf()
end
_singleton_dialog:show()
end

function UIDialogManager.newDialog(show_data)
return _newDialog(show_data)
end

function UIDialogManager.newConfirmDialog(input_title,input_content)
input_title=input_title or'提示'
local showdata=
{
type='UIDialouge',
title=input_title,
content=input_content,
oktext='确 认',
canceltext='取 消'
}
return _newDialog(showdata)
end

function UIDialogManager.getConfirmDialog(dialog,
input_title,
input_content,
input_oktext,
input_canceltext,
input_okcb,
input_cancelcb,
input_choosetext,
input_choosecallback,
input_showCloseBtn)
if dialog==nil then
dialog=_newDialog({})
end
dialog.type='UIDialouge'
dialog.title=input_title or'提示'
dialog.content=input_content
dialog.oktext=input_oktext or'确 认'
dialog.canceltext=input_canceltext or'取 消'
dialog.okcallback=input_okcb
dialog.cancelcallback=input_cancelcb
dialog.choosetext=input_choosetext
dialog.choosecallback=input_choosecallback
dialog.showclosebtn=input_showCloseBtn~=false
return dialog
end

function UIDialogManager.getConfirmDialogEx(dialog,args)
if dialog==nil then
dialog=_newDialog({})
end
dialog.type='UIDialouge'
dialog.canvasIndex=args.canvasIndex
dialog.title=args.title or'提示'
dialog.content=args.content
dialog.oktext=args.oktext or'确 认'
dialog.canceltext=args.canceltext or'取 消'
dialog.okcallback=args.okcb
dialog.cancelcallback=args.cancelcb
dialog.choosetext=args.choosetext
dialog.choosecallback=args.choosecallback
dialog.showclosebtn=args.showCloseBtn~=false
dialog.itemList=args.itemList
dialog.okTipsText=args.okTipsText
return dialog
end

function UIDialogManager.getCommonDialog(title,content,func)
UIDialogManager.getCommonDialog2(title,content,func,nil)
end

function UIDialogManager.getCommonDialog2(title,content,func,setFunc)
title=title or'提示'
if not _common_dialog then
local show_data={
type='UIDialouge',
title=title,
content=content,
oktext='确定',
canceltext='取消',
okcallback=func,
}
_common_dialog=UIDialogManager.newDialog(show_data)
else
_common_dialog.title=title
_common_dialog.content=content
_common_dialog.okcallback=func
end
if setFunc then
setFunc(_common_dialog)
end
if _common_dialog.choosecallback~=nil then
if _common_dialog.choosetext==nil then
_common_dialog.choosetext='本次登录不再提示'
end
end
_common_dialog:show()
end

function UIDialogManager.getCommonDialog3(title,content,func,setFunc)
title=title or'提示'
if not _common_dialog then
local show_data={
type='UIDialouge',
title=title,
content=content,
oktext='确定',
okcallback=func,
}
_common_dialog=UIDialogManager.newDialog(show_data)
else
_common_dialog.title=title
_common_dialog.content=content
_common_dialog.okcallback=func
end
if setFunc then
setFunc(_common_dialog)
end
if _common_dialog.choosecallback~=nil then
if _common_dialog.choosetext==nil then
_common_dialog.choosetext='本次登录不再提示'
end
end
_common_dialog:show()
end

function UIDialogManager.closeAll()
for _,show_data in pairs(active_dialogs)do
if show_data and not show_data.isClose then
show_data:closeCancel()
end
end
active_dialogs={}
end

function UIDialogManager.hasActive()
return next(active_dialogs)~=nil
end


function UIDialogManager.getConfirmDialog3(dialog,desc,func,repeatType,cancelfunc,closefunc)
if repeatType then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,repeatType)
if flag then
func()
return
end
dialog=UIDialogManager.getConfirmDialog(dialog,'提示',desc)
dialog.choosetext="今日不再提示"
dialog.choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,repeatType,flag)
end
dialog.okcallback=func
dialog.cancelcallback=cancelfunc
dialog.closecallback=closefunc
dialog:show()
else
dialog=UIDialogManager.getConfirmDialog(dialog,'提示',desc)
dialog.okcallback=func
dialog.cancelcallback=cancelfunc
dialog.closecallback=closefunc
dialog:show()
end
end



























