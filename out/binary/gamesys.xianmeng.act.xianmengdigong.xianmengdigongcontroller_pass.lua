







function xianmengdigongController:onAppStart_pass()
socketManager:register_receiver(20,64,xianmengdigongController.recv_20_64)
socketManager:register_receiver(20,65,xianmengdigongController.recv_20_65)
socketManager:register_receiver(20,66,xianmengdigongController.recv_20_66)
socketManager:register_receiver(20,67,xianmengdigongController.recv_20_67)
socketManager:register_receiver(20,68,xianmengdigongController.recv_20_68)
end

function xianmengdigongController:onEnterState_pass(isReconnet)
xianmengdigongModel:initData_pass()
end

function xianmengdigongController:onLeaveState_pass(isReconnet)
xianmengdigongModel:clearData_pass()
end

function xianmengdigongController:onProtocolReq_pass()
end

function xianmengdigongController:onLostConnection_pass()
end


function xianmengdigongController:reqPassData()
socketManager:send_20_64()
end


function xianmengdigongController:reqPassBuyMoneyInvest(confIndex)
socketManager:send_20_65(confIndex)
end


function xianmengdigongController:reqPassRewards()
socketManager:send_20_66()
end


function xianmengdigongController:reqPassBuyProgress(xdl)
socketManager:send_20_67(xdl)
end



function xianmengdigongController.recv_20_64(args)
local firstTime=args[1]
local xdlTotal=args[2]
local rwMaxVal=args[3]
local rwMaxVal2=args[4]
local rwMaxVal3=args[5]
local lytzFlag=args[6]
local cztzFlag=args[7]
local stopTime=args[8]

xianmengdigongModel:setPassFirstTime(firstTime)
xianmengdigongModel:setPassStopTime(stopTime)
xianmengdigongModel:setPassXDL(xdlTotal)
xianmengdigongModel:setPassClaimedXDL(XMDG_Pass_Invest_Type.eFree,rwMaxVal)
xianmengdigongModel:setPassClaimedXDL(XMDG_Pass_Invest_Type.eMoney,rwMaxVal2)
xianmengdigongModel:setPassClaimedXDL(XMDG_Pass_Invest_Type.eRecharge,rwMaxVal3)
xianmengdigongModel:setPassInvestFlag(XMDG_Pass_Invest_Type.eMoney,lytzFlag)
xianmengdigongModel:setPassInvestFlag(XMDG_Pass_Invest_Type.eRecharge,cztzFlag)
UIManager:invokeUIMethod("UIXM_XMDG_MiLingWin","refresh")
xianmengdigongController.refreshXMDGPassReddot()
end


function xianmengdigongController.recv_20_65(confIndex,lytzFlag,cztzFlag)
xianmengdigongModel:setPassInvestFlag(XMDG_Pass_Invest_Type.eMoney,lytzFlag)
xianmengdigongModel:setPassInvestFlag(XMDG_Pass_Invest_Type.eRecharge,cztzFlag)
UIManager:invokeUIMethod("UIXM_XMDG_MiLingWin","refresh")
xianmengdigongController.refreshXMDGPassReddot()
end


function xianmengdigongController.recv_20_66(rwMaxVal,rwMaxVal2,rwMaxVal3)
xianmengdigongModel:setPassClaimedXDL(XMDG_Pass_Invest_Type.eFree,rwMaxVal)
xianmengdigongModel:setPassClaimedXDL(XMDG_Pass_Invest_Type.eMoney,rwMaxVal2)
xianmengdigongModel:setPassClaimedXDL(XMDG_Pass_Invest_Type.eRecharge,rwMaxVal3)
UIManager:invokeUIMethod("UIXM_XMDG_MiLingWin","refresh")
xianmengdigongController.refreshXMDGPassReddot()
end


function xianmengdigongController.recv_20_67(xdl,xdlTotal)
xianmengdigongModel:setPassXDL(xdlTotal)
UIManager:invokeUIMethod("UIXM_XMDG_MiLingWin","refresh")
UIManager:closeWindow("UIXM_XMDG_MiLingBuyProgressWin")
xianmengdigongController.refreshXMDGPassReddot()
end


function xianmengdigongController.recv_20_68(xdlTotal)
xianmengdigongModel:setPassXDL(xdlTotal)
UIManager:invokeUIMethod("UIXM_XMDG_MiLingWin","refresh")
xianmengdigongController.refreshXMDGPassReddot()
end


function xianmengdigongController.refreshXMDGPassReddot()
reddotControl.on_change_catch_type(CATCH_TYPE.eXMDGPass)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianMengDiGong)
end