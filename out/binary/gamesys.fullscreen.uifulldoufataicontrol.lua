







UIFullDouFaTaiControl=gameState.addListener(fullScreenUI.create())

DOUFATAI_SUBWIN_TYPE=
{
record='UIDouFaTaiRecordWin',
rank='UIDouFaTaiRankWin',
}

function UIFullDouFaTaiControl:onAppStart()
local function _showDouFaTaiWindow(...)self:showDouFaTaiWindow(...)end
local function _showChallengeWindow(...)self:showChallengeWin(...)end
local menulist=
{
{tabType=FULL_TAB_TYPE.eDouFaTai_Main,callback=_showDouFaTaiWindow,},
{tabType=FULL_TAB_TYPE.eDouFaTai_Challenge,callback=_showChallengeWindow,},
}
local args={
stage=true,
menulist=menulist,
fullType=FULL_TYPE.eDouFaTai,
}
self:initUI(args)
end


function UIFullDouFaTaiControl:showDouFaTaiJumpWin(args)
local isjump=false
if args and args.args then
isjump=args.args.isjump
end


if not isjump then

AudioManager.playBtnClick()
UIManager:showWindow("UIDouFaTaiJumpWin")
else

UIFullDouFaTaiControl:showDouFaTaiWindow(args,true)
end
end

function UIFullDouFaTaiControl:showDouFaTaiWindow(argstable,needLoadind)
if not systemModel.isOpen(SYSTEM_DEFINE.eBuildOpenDouFaTai)then
return
end

local isActive=UIManager:isActive('UIDouFaTaiWin')
if isActive then
UIManager.error('当前已在斗法台')
return
end

local func=function(argstable)
UIFullDouFaTaiControl:showDouFaTaiWindowEx(argstable)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end

if needLoadind then
douFaTaiController:req_doufatai_data()
douFaTaiController:req_rank_data()

local startCallback=function()
fightStage:create(821026,func,argstable)
end

UIFullDouFaTaiControl:showWindow("UIFightPrepareLoading",{
startCallback=startCallback
})
else
douFaTaiController:req_rank_data()
fightStage:create(821026,func,argstable)
end
end

function UIFullDouFaTaiControl:showDouFaTaiWindowEx(argstable)
local tabType=FULL_TAB_TYPE.eDouFaTai_Main
local args={
tabType=tabType,
showBg=false,
showFg=false,
viewNames={'UIDouFaTaiWin'},
viewArgs={['UIDouFaTaiWin']=argstable},
}
if argstable.subwin then
table.insert(args.viewNames,argstable.subwin)
args.viewArgs[argstable.subwin]=argstable
end
UIFullDouFaTaiControl.fightStage=argstable.fightStage

self:showUI(args)
end

function UIFullDouFaTaiControl:showChallengeWin(argstable)
local func=function(argstable)
UIFullDouFaTaiControl.fightStage=argstable.fightStage
UIFullDouFaTaiControl:showChallengeWinEx(argstable)
end
fightStage:create(821025,func,argstable)
end

function UIFullDouFaTaiControl:showChallengeWinEx(argstable)
local tabType=FULL_TAB_TYPE.eDouFaTai_Challenge
local args={
tabType=tabType,
showBg=false,
showFg=false,
viewNames={'UIDouFaTaiChallengeWin'},
viewArgs={['UIDouFaTaiChallengeWin']=argstable},
}
self:showUI(args)
end