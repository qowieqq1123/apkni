







UIFullFeiShengTaiControl=gameState.addListener(fullScreenUI.create())

function UIFullFeiShengTaiControl:onAppStart()


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

function UIFullFeiShengTaiControl:showFullFeiShengTaiWindow(argstable)

if not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)and JiuChongTianJieEnterModel:isJCTJFinish()then
UIFullJiuChongTianJieControl:showFullWindow()
return
end
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eflyupWin
local args={
tabType=tabType,
showBg=true,
skinType=fullScreenSkinType.eSkin1,
viewNames={'UIFeiShengTaiWin'},
viewArgs={['UIFeiShengTaiWin']=argstable},
}
self:showUI(args)
end




function UIFullFeiShengTaiControl:showFeiShengTaiDuJieWindow(goFunc,argstable,dis_guid)


local func=function(argstable)
argstable=argstable or{}
argstable.isFull=true
UIFullCommonControl:showCommonWindow('UIFeiShengTaiDuJieWin',argstable)

end
fightStage:create(100,func,argstable)
end

function UIFullFeiShengTaiControl:initSendPro1()

end