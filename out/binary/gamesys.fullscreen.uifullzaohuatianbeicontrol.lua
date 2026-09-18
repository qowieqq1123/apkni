







UIFullZaoHuaTianBeiControl=gameState.addListener(fullScreenUI.create())

function UIFullZaoHuaTianBeiControl:onAppStart()
local args={
fullType=FULL_TYPE.eZaoHuaTianBei,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullZaoHuaTianBeiControl:showMainWindow(argstable)
local func=function(argstable)
self:showMainWindowEx(argstable)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
local opened=fullScreenUI.isActiveFullEx(FULL_TYPE.eZaoHuaTianBei)
if not opened then



UIFullDouFaTaiControl:showWindow("UIFightPrepareLoading",{
startCallback=func
})
else
self:showMainWindowEx(argstable)
end
end

function UIFullZaoHuaTianBeiControl:showMainWindowEx(argstable)
local args={
showBg=true,
showFg=false,
viewNames={'UIRankListEnterWin1'},
viewArgs={
['UIRankListEnterWin1']=argstable,
},





}
self:showUI(args)
end

function UIFullZaoHuaTianBeiControl:openWuJiBei()
rankListController:send_24_21()

UIManager:invokeUIMethod("UIRankListEnterWin1","showRoot",false)
self:showWindow("UIRankListWuJiBeiWin")
end

function UIFullZaoHuaTianBeiControl:closeWuJiBei()

UIManager:invokeUIMethod("UIRankListEnterWin1","showRoot",true)
self:hideWindow("UIRankListWuJiBeiWin")
end

function UIFullZaoHuaTianBeiControl:openWanLingBei()
rankListController:req_rankList_data(eRankListType.eFaBaoFight)
self:hideWindow("UIRankListEnterWin")
self:showWindow("UIRankListWanLingBeiWin")
end

function UIFullZaoHuaTianBeiControl:closeWanLingBei()
self:showWindow("UIRankListEnterWin")
self:hideWindow("UIRankListWanLingBeiWin")
end

function UIFullZaoHuaTianBeiControl:openHunDunBei()
rankListController:req_rankList_data(eRankListType.eZongMenFight)
rankListController:req_rankList_data(eRankListType.eDouFaTai)
rankListController:req_rankList_data(eRankListType.eShiLianTa)
rankListController:req_rankList_data(eRankListType.eYinJieKaiTian)
rankListController:req_rankList_data(eRankListType.eDuJieFeiSheng)
self:hideWindow("UIRankListEnterWin")
self:showWindow("UIRankListHunDunBeiWin")
end

function UIFullZaoHuaTianBeiControl:closeHunDunBei()
self:showWindow("UIRankListEnterWin")
self:hideWindow("UIRankListHunDunBeiWin")
end

function UIFullZaoHuaTianBeiControl:openNormalRankListWin(args)
local config=cfgHelper.get1(cfg_steletypeconfig_get,args.id)
for i,v in ipairs(config.panelArgs)do
for j,w in ipairs(v.list)do
local cfg=cfgHelper.get1(cfg_stelerankconfig_get,w)
for k,u in ipairs(cfg.rank)do
rankListController:req_rankList_data(u)
end
end
end
self:showWindow("UIRankListTabListWin",args)
UIManager:invokeUIMethod("UIRankListEnterWin1","showRoot",false)
end

function UIFullZaoHuaTianBeiControl:closeNormalRankListWin()
UIManager:invokeUIMethod("UIRankListEnterWin1","showRoot",true)
self:closeWindow('UIRankListTabListWin')
end