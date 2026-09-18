






local _MODULENAME="xianjiexianbangController"

gameState.addListener(def_table(_MODULENAME))

xianjiexianbangController.name=_MODULENAME
xianjiexianbangController.data={}

function xianjiexianbangController:onAppStart()
xianjiexianbangModel:onAppStart()

socketManager:register_receiver(37,80,self.recv_37_80)
socketManager:register_receiver(37,81,self.recv_37_81)
socketManager:register_receiver(37,82,self.recv_37_82)
socketManager:register_receiver(37,83,self.recv_37_83)
socketManager:register_receiver(37,84,self.recv_37_84)
socketManager:register_receiver(37,85,self.recv_37_85)

end


function xianjiexianbangController:onEnterState(isReconnect)
xianjiexianbangModel:onEnterState()
end


function xianjiexianbangController:onProtocolReq()
xianjiexianbangModel:onProtocolReq()
end


function xianjiexianbangController:onLeaveState(isReconnect)
xianjiexianbangModel:onLeaveState(isReconnect)

self.data={}
end


function xianjiexianbangController:onLostConnection()

end


function xianjiexianbangController:onReConnection(isInitPro)

end



function xianjiexianbangController:send_37_80()
socketManager:send_37_80()
end

function xianjiexianbangController:send_37_81()
socketManager:send_37_81()
end

function xianjiexianbangController:send_37_82(is_assistant)
socketManager:send_37_82(is_assistant or 0)
end

function xianjiexianbangController:send_37_84()
socketManager:send_37_84()
end

function xianjiexianbangController:send_37_85(taskId,runFlag)
socketManager:send_37_85(taskId,runFlag)
end

function xianjiexianbangController.recv_37_81(data1,data2,data3,data4)
end



function xianjiexianbangController.recv_37_80(agr1,agr2,agr3,agr4,agr5)
xianjiexianbangModel:initdata(agr1,agr2,agr3,agr4,agr5)
xianjiexianbangModel:refreshYJYHUD()
end

function xianjiexianbangController.recv_37_82(agr1,agr2,agr3,agr4,is_assistant)
local oldLevel=xianjiexianbangModel:getXBLevel()
xianjiexianbangModel:setXBrwFlag(agr1,agr2,agr3,agr4)
UIManager:invokeUIMethod("UIXianBangWin","severfresh")

local newLevel=xianjiexianbangModel:getXBLevel()

if newLevel>oldLevel then
UIManager:showWindow('UIXBLvlUpWin',{lastLevel=oldLevel,currLevel=newLevel})
end
xianjiexianbangModel:refreshYJYHUD()
end

function xianjiexianbangController.recv_37_83(agr1)
xianjiexianbangModel:freshOldTaskDataXB(agr1.taskId,agr1.failFlag,agr1.finishFlag)
local win=UIManager:findActiveWindow('UIXianBangWin')
if win then
UIManager.info("仙榜任务已更新")
end
local win2=UIManager:findActiveWindow('UIXianBanTaskWin')
if win2 then
UIManager:closeWindow("UIXianBanTaskWin")
end
UIManager:invokeUIMethod("UIXianBangWin","severfresh")
xianjiexianbangModel:freshwindata()
xianjiexianbangModel:refreshYJYHUD()
end

function xianjiexianbangController.recv_37_84(agr1,agr2,agr3)
xianjiexianbangModel:freshXBNewTaskData(agr1,agr2,agr3)
local win=UIManager:findActiveWindow('UIXianBangWin')
if win then
UIManager.info("仙榜任务已更新")
end
local win2=UIManager:findActiveWindow('UIXianBanTaskWin')
if win2 then
UIManager:closeWindow("UIXianBanTaskWin")
end
UIManager:invokeUIMethod("UIXianBangWin","severfresh")
xianjiexianbangModel:freshwindata()
xianjiexianbangModel:refreshYJYHUD()
end

function xianjiexianbangController.recv_37_85(taskId,runFlag)
xianjiexianbangModel:setXBtaskDoingflag(taskId,runFlag)
xianjiexianbangModel:freshwindata()
end


function xianjiexianbangController:jumpxjzm()
local zmPos=xianjieModel:getZongMenOutPos()
if zmPos then

local sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]
return sceneidx,gridX,gridZ
end
return nil,nil,nil
end


function xianjiexianbangController:XianBangJump()
jumpManager:jump({id=JUMP_TYPE.eXianJieBaoLei},function()
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eXianBang}})
end,JUMP_BACK.eNoBack)

end
