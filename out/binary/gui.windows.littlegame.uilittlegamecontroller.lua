







local _MODULENAME="UILittleGameController"


def_table(_MODULENAME)
UILittleGameController.name=_MODULENAME
UILittleGameController.data={}


function UILittleGameController:openLittleGame(gameType,args,callback,startCallback)
args=args or{}
args.startCallback=startCallback
args.callback=callback
if gameType==littleGameType.eLongGuLianHua then

elseif gameType==littleGameType.eLianLianKan then
UIManager:showWindow("UILianLianKanGameWin",args)
elseif gameType==littleGameType.eTuLingGuiWei then
UIManager:showWindow("UITuLingGuiWeiWin",args)
elseif gameType==littleGameType.eGuHeJieMi then
UIManager:showWindow("UIGuHeJieMiWin",args)
elseif gameType==littleGameType.eWanBaoJianShang then
UIManager:showWindow("UIWanBaoJianShangWin",args)
elseif gameType==littleGameType.eLingYunLanZhong then
UIManager:showWindow("UILingYunLanZhongLittleGameWin",args)
elseif gameType==littleGameType.e2048 then
UIManager:showWindow("UI2048Win",args)
elseif gameType==littleGameType.eastroke then
UIManager:showWindow("UIAStrokeGameWin",args)
elseif gameType==littleGameType.eDrawFuWin then
UIManager:showWindow("UIDrawFuWin",args)
elseif gameType==littleGameType.eCatchLingShou then

UICatchLingShouController:openNewGame(args)
end
end

function UILittleGameController:quitTips(okcallback,cancelback)
local showdata=
{
type='UIDialouge',
title='提示',
content='中途退出游戏，则此局游戏算作失败，是否确定退出？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=okcallback,
cancelback=cancelback,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UILittleGameController:quitTips_CatchLingShou(okcallback,cancelback)
local showdata=
{
type='UIDialouge',
title='提示',
content='中途退出游戏后，当前游戏进度将保存，是否退出？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=okcallback,
cancelback=cancelback,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end