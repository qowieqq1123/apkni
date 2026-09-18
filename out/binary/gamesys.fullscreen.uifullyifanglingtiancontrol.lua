







UIFullYiFangLingTianControl=gameState.addListener(fullScreenUI.create())

function UIFullYiFangLingTianControl:onAppStart()


local function _showProductionWindow(...)self:showProductionWindow(...)end

local function _initSendPro1(...)self:initSendPro1(...)end

local menulist=
{


}

local args={
menulist=menulist,
fullType=FULL_TYPE.eFeiShengTai,

}
self:initUI(args)
end

function UIFullYiFangLingTianControl:showFullYiFangLingTianWindow(argstable)
argstable=argstable or{}

local args={

showBg=true,
skinType=fullScreenSkinType.eSkin5,
viewNames={'UIYFLTMapWin'},
viewArgs={['UIYFLTMapWin']=argstable},
}

self:showUI(args)
end





function UIFullFeiShengTaiControl:initSendPro1()

end