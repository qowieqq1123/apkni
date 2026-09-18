






local _MODULENAME="funcShopController"




gameState.addListener(def_table(_MODULENAME))
funcShopController.name=_MODULENAME

funcShopController.data={}




function funcShopController:onAppStart()

funcShopModel:onAppStart()


socketManager:register_receiver(23,1,funcShopController.recv_23_1)
socketManager:register_receiver(23,2,funcShopController.recv_23_2)



















end


function funcShopController:onEnterState()
funcShopModel:onEnterState()
end


function funcShopController:onServerDataInitFinish()
funcShopModel:onServerDataInitFinish()
end


function funcShopController:onLeaveState()
funcShopModel:onLeaveState()

self.data={}
end


function funcShopController:onLostConnection()

end



function funcShopController.send_23_1(shopId)
socketManager:send_23_1(shopId)
end

function funcShopController.send_23_2(shopId,buyId,num)
socketManager:send_23_2(shopId,buyId,num)
end






function funcShopController.recv_23_1(shopId,buyListLen,buyList)
funcShopModel:init_data(shopId,buyList)

if funcShopController:NeedFreshFuncShopWin(shopId)then
UIManager:invokeUIMethod("UIFuncShopWin","updateView",true)
end
if shopId==eFuncShopType.eXuYuan then
UIManager:invokeUIMethod("UIBaoLingShuPickUp_ShopWin","updateView",true)
end
if shopId==eFuncShopType.eYiYuHuiYou then
UIManager:invokeUIMethod("YYHYMainShopWin","updateView")
end

if shopId==eFuncShopType.eshanhaishop then

funcShopModel:SetShanHaiShop(buyListLen,buyList)
end
if shopId==eFuncShopType.eQiYuan then

funcShopModel:SetqiyuanshuShop(buyListLen,buyList)
end
if shopId==eFuncShopType.eMojieSaiJi then

funcShopModel:SetMoJieShop(buyListLen,buyList)
end
notifySystem:postNotify(notifyConfig.onCommonShopData,shopId)
end






function funcShopController.recv_23_2(shopId,buyId,buyNum,result)
if result==1 then
UIManager.error("购买失败")
return
end
local data=funcShopModel:get_data(shopId,buyId)
local curNum=data and data.buyNum or 0
funcShopModel:set_data(shopId,buyId,{buyNum=curNum+buyNum})


AudioManager.playAudio(514)



UIManager:callWindowFunc("UIFuncShopWin",'updateView')
if shopId==eFuncShopType.eXuYuan then

UIManager:invokeUIMethod("UIBaoLingShuPickUp_ShopWin","updateView")

reddotControl.on_change_catch_type(CATCH_TYPE.eBLSPickUp)

UIManager:invokeUIMethod("UIBaoLingShuWin","refreshPickUpShopBtnReddot")


local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end
if shopId==eFuncShopType.eYiYuHuiYou then
UIManager:invokeUIMethod('YYHYMainShopWin','updateView')
end
notifySystem:postNotify(notifyConfig.onCommonShopChange,shopId,buyId,buyNum)











if shopId==eFuncShopType.eXianMeng then
UIManager:invokeUIMethod('UIPrisonWin','refreshMoney')
elseif shopId==eFuncShopType.eshanhaishop then

funcShopModel:ChangeShanHaiShop(buyId,buyNum)
UIManager:invokeUIMethod('UIZZSH_ShopWin','SetLayoutGroup')
elseif shopId==eFuncShopType.eQiYuan then

funcShopModel:ChangeqiyuanshuShop(buyId,buyNum)
UIManager:invokeUIMethod('UIQiYuanShu_ShopWin','onseverfresh')
elseif shopId==eFuncShopType.eMojieSaiJi then

funcShopModel:ChangeMoJieShop(buyId,buyNum)
UIManager:invokeUIMethod('UIMJ_ShopWin','SetLayoutGroup')
end
end






function funcShopController:openShopWin(args)
if not funcShopModel:checkInit(args.shopId)then
funcShopController.send_23_1(args.shopId)
end
UIManager:showWindow("UIFuncShopMenuWin",args)
end


function funcShopController:getEndTime(shopId)
local shopCfg=cfgHelper.get(cfg_shoplistconfig_get,shopId)
local funcList=funcShopModel.FuncShopTypeFunc[shopCfg.shopType]
if funcList then
return funcList.getEndTime()
end
end

function funcShopController:NeedFreshFuncShopWin(shopId)
local shopCfg=cfgHelper.get(cfg_shoplistconfig_get,shopId)
local funcList=funcShopModel.FuncShopTypeFunc[shopCfg.shopType]
if funcList then
return funcList.needFreshFuncShopWin
end
end


