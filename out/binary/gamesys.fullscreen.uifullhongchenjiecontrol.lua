





UIFullHongChenJieControl=gameState.addListener(fullScreenUI.create())

function UIFullHongChenJieControl:onAppStart()
local args=
{
skinType=fullScreenSkinType.eSkin22,
fullType=FULL_TYPE.eHongChenJie,
}
self:initUI(args)
end


function UIFullHongChenJieControl:showMainWin(args)
args=args or{}
if not args.id then logErr('红尘劫 必须传入id')return end
if not hongChenJieModel:checkHasGameIdData(args.id)then logErr('红尘劫 未接受到初始化数据')return end
local args=
{
showBg=true,
viewNames={'UIHongChenJieMainWin','UIHongChenJieTopWin','UITopMaskWin'},
viewArgs={['UIHongChenJieMainWin']=args,['UIHongChenJieTopWin']=args},
}
self:showUI(args)
return true
end

function UIFullHongChenJieControl:showPrepareWin(args)
args=args or{}
if not args.id then logErr('红尘劫 必须传入id')return end
if not hongChenJieModel:checkHasGameIdData(args.id)then logErr('红尘劫 未接受到初始化数据')return end
local args=
{
showBg=true,
viewNames={'UIHongChenJiePrepareWin','UIHongChenJieTopWin','UITopMaskWin'},
viewArgs={['UIHongChenJiePrepareWin']=args,['UIHongChenJieTopWin']=args},
}
self:showUI(args)
return true
end

function UIFullHongChenJieControl:showGameWin(args)
args=args or{}
if not args.id then logErr('红尘劫 必须传入id')return end
if not hongChenJieModel:checkHasGameIdData(args.id)then logErr(FMT.fmt('红尘劫 未接受到初始化数据 {0}',args.id))return end
local args=
{
showBg=true,
viewNames={'UIHongChenJieGameWin','UIHongChenJieTopWin','UITopMaskWin'},
viewArgs={['UIHongChenJieGameWin']=args,['UIHongChenJieTopWin']=args},
}
self:showUI(args)
return true
end

function UIFullHongChenJieControl:showMainWinByCloud(args)
local startCallback=function()
self:showMainWin(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end

function UIFullHongChenJieControl:transToWin(callback)
UIManager:invokeUIMethod('UIHongChenJieTopWin','transWin',callback)
end