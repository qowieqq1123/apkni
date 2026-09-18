





UIFullTianMoJieControl=gameState.addListener(fullScreenUI.create())

function UIFullTianMoJieControl:onAppStart()
local args=
{
skinType=fullScreenSkinType.eSkin22,
fullType=FULL_TYPE.eTianMoJie,
}
self:initUI(args)
end

function UIFullTianMoJieControl:showMainWin(args)
args=args or{}
local args=
{
showBg=true,
viewNames={'UITianMoJieMainWin','UIJiuChongTianJieSysBackWin','UITopMaskWin'},
viewArgs={
['UITianMoJieMainWin']=args,
['UIJiuChongTianJieSysBackWin']={
backFunc=function()
local jumpParam={
id=JUMP_TYPE.eJiuChongTianJie,
args={sysType=JIUCHONGTIANJIE_SYS_TYPE.eZhuXieMo},
}
jumpManager:jump(jumpParam)
end,
leaveFunc=function()
self:closeWinByCloud()
end
},
},
}
self:showUI(args)
return true
end

function UIFullTianMoJieControl:showMainWinByCloud(args)
local func=function()
args=args or{}
args.cloud=true
self:showMainWin(args)
end
loadingControl.openCloud(func)
end

function UIFullTianMoJieControl:closeWinByCloud()
local func=function()
self:closeUI(true,false)
end
loadingControl.openCloud(func,0.5)
end