local _moulueList={}


function xianmengController:onAppStart_moulue()
socketManager:register_receiver(20,173,xianmengController.do_protocol_20_173)
socketManager:register_receiver(20,174,xianmengController.do_protocol_20_174)

end

function xianmengController:onEnterState_moulue()
xianmengModel:initData_moulue()
end

function xianmengController:onLeaveState_moulue(isReconnet)
_moulueList={}
xianmengModel:clearData_moulue()
end


function xianmengController:judeMouLueOpen()

if not systemModel.isOpen(SYSTEM_DEFINE.eXianMengMouLueSetInfo)then
return false
end

return true
end

function xianmengController:send_learnBtn(type,id)
socketManager:send_20_174(type,id)
end



function xianmengController.do_protocol_20_173(mou_len,mou_table,wu_len,wu_table)
xianmengModel:setmoulueData(mou_len,mou_table,wu_len,wu_table)


end


function xianmengController.do_protocol_20_174(stduy_type,id,lv)
xianmengModel:UpdataSkillData(stduy_type,id,lv)
local win=UIManager:findActiveWindow("UIXianMengMouLueSetWin")
if win then
win:Onfresh(id)
win:play_effect()
end

end


