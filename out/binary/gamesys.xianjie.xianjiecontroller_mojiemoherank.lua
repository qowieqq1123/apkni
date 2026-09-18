









function xianjieController:onAppStart_RankMoHe()
xianjieModel:initData_MoHe()

socketManager:register_receiver(39,41,xianjieController.recv_protocol_39_41)

socketManager:register_receiver(39,42,xianjieController.recv_protocol_39_42)

end

function xianjieController:onEnterState_RankMoHe(isReconnet)


end

function xianjieController:onLeaveState_RankMoHe(isReconnet)
xianjieModel:clearData_MoHe()

end


function xianjieController.recv_protocol_39_41(len,list,myScore)
xianjieModel:SetMoHe_PersonalData(len,list,myScore)
UIManager:invokeUIMethod("UIMoJieRankMoHePeopleWin","severmkrankfresh")
end


function xianjieController.recv_protocol_39_42(len,XMlist,XMscore)
xianjieModel:SetMoHe_XMData(len,XMlist,XMscore)
UIManager:invokeUIMethod("UIMoJieRankMoHeXMWin","severmkrankfresh")

end

function xianjieController:OpenMoHeRankWin()
UIManager:showWindow("UIMoJieMoHeBlackWin")
UIManager:showWindow("UIMoJieRankSelectInternalWin",{rankType=xianjieController.Ranktype.mhRank})
end