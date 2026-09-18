




UIFullDuJieZhiBaoControl=gameState.addListener(fullScreenUI.create())

function UIFullDuJieZhiBaoControl:onAppStart()
local function _showFairWindow(...)self:showFairWindow(...)end

local function _initSendFairPro(...)self:initSendFairPro(...)end

local menulist=
{


}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eDuJieZhiBao,
skinType=fullScreenSkinType.eSkin1,

}
self:initUI(args)
end


function UIFullDuJieZhiBaoControl:showDJZBWindow(argstable)
local tabType=FULL_TAB_TYPE.eDuJieZhiBao
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDJZBuplevelWin'},
viewArgs={['UIDJZBuplevelWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullDuJieZhiBaoControl:initSendFairPro()

end

function UIFullDuJieZhiBaoControl:initSendGuiShiPro()

end
