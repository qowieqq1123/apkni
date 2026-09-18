







UIFullPoetryArenaController=gameState.addListener(fullScreenUI.create())

function UIFullPoetryArenaController:onAppStart()
local args={
fullType=FULL_TYPE.ePoetryArena,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullPoetryArenaController:showMainWindow(guid)
self.guid=guid
local args={
showBg=true,
viewNames={'UIPoetryArenaWin'},
viewArgs={['UIPoetryArenaWin']={guid=guid}},
blurParams={showBlack=worldController:checkBlackBlur()}
}
self:showUI(args)
end

function UIFullPoetryArenaController:showRewardWindow(id)
local cfg=cfgHelper.get1(cfg_wendouleitaiconfig_get,id)
local level=zongmenModel:getLevel()
local rewards=nil
for i,v in ipairs(cfg.winRewards)do
if v[1]<=level and v[2]>=level then
rewards=v[3]
break
end
end
local args={
title='胜利奖励',
rewardTitle="",
desc1=FMT.fmt('答对{0}题可获得以下奖励',cfg.spfNum[1]),
rewards=rewards,
showCancel=false,
commitName='确定',
}
self:showWindow('UIDialougeRewardWin',args)
end

function UIFullPoetryArenaController:showSelectWindow(args)
self:showWindow("UIPoetryArenaSelectWin",args)
end

function UIFullPoetryArenaController:checkCloseWindow(guid)
if fullScreenUI.checkFull(self)then
if mathHelper.compareInt64(self.guid,guid)then
self:closeUI(true)
end
end
end