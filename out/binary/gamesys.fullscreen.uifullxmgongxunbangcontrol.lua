







UIFullXMGongXunBangControl=gameState.addListener(fullScreenUI.create())

function UIFullXMGongXunBangControl:onAppStart()
local function _showWindowRank(...)self:showWindowRank(...)end
local function _showWindowReward(...)self:showWindowReward(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eXMGXB_Reward,callback=_showWindowReward},

{tabType=FULL_TAB_TYPE.eXMGXB_Rank,callback=_showWindowRank},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eXMGongXunBang,
skinType=fullScreenSkinType.eSkin6,
}
self:initUI(args)
end


function UIFullXMGongXunBangControl:showWindowRank(argstable)
local tabType=FULL_TAB_TYPE.eXMGXB_Rank
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIXianMengGXBRankWin'},
viewArgs={['UIXianMengGXBRankWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullXMGongXunBangControl:showWindowReward(argstable)
local tabType=FULL_TAB_TYPE.eXMGXB_Reward
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIXianMengGXBTaskWin'},
viewArgs={['UIXianMengGXBTaskWin']=argstable or{}},
}
self:showUI(args)
return true
end


function UIFullXMGongXunBangControl:onCheckRewardReddot()
return xianmengModel:getGXBRewardReddot()
end
