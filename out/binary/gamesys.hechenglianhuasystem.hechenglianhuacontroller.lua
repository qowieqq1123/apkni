






local _MODULENAME="heChengLianHuaController"




gameState.addListener(def_table(_MODULENAME))
heChengLianHuaController.name=_MODULENAME


heChengLianHuaController.data={}

function heChengLianHuaController:onAppStart()
heChengLianHuaModel:onAppStart()


socketManager:register_receiver(3,181,heChengLianHuaController.recv_3_181)
socketManager:register_receiver(3,182,heChengLianHuaController.recv_3_182)





end


function heChengLianHuaController:onEnterState()
heChengLianHuaModel:onEnterState()
end


function heChengLianHuaController:onServerDataInitFinish()
heChengLianHuaModel:onServerDataInitFinish()
end


function heChengLianHuaController:onLeaveState()
heChengLianHuaModel:onLeaveState()

self.data={}
end


function heChengLianHuaController:onLostConnection()

end



function heChengLianHuaController:reqHeChengItem(sfId,ubdId,pfId,count,op_type,itemList)
itemList=itemList or{}
socketManager:send_3_181(sfId,ubdId,pfId,count,op_type or 0,#itemList,itemList)
end



function heChengLianHuaController.recv_3_181(array)
local sfId=array[1]
local ubdId=array[2]
local pfId=array[3]
local count=array[4]
local len=array[5]
local reward=array[6]
local op_type=array[7]
local itemListLen=array[8]
local itemList=array[9]
if op_type~=1 then
local quickWin=UIManager:findActiveWindow('UIQuickHeChengWin')
if not quickWin then
local win=UIManager:findActiveWindow('UIHeChengLianHuaWin')
if win then

return win:startHeChengLianHua(pfId,reward)
end
end
end


local showRewardList={}
for i,v in ipairs(reward)do
local itemid=v.param_1
local itemcount=v.param_2
local item={itemid=itemid,num=itemcount}
table.insert(showRewardList,item)
end
showPrizeControl.showWindowNow(showRewardList)

UIManager:invokeUIMethod("UICommonMoneyGainWin","onCloseClick")
end


function heChengLianHuaController:reqPiLiangHeChengItem(sfId,ubdId,len,list)
socketManager:send_3_182(sfId,ubdId,len,list)
end

function heChengLianHuaController.recv_3_182(datas)
local result=datas[3]
local reward=datas[7]
if result==0 then
if datas[6]>0 then
local showRewardList={}
for i,v in ipairs(reward)do
local itemid=v.param_1
local itemcount=v.param_2
local item={itemid=itemid,num=itemcount}
table.insert(showRewardList,item)
end
showPrizeControl.showWindowNow(showRewardList)
end
UIManager:closeWindow('UIPiLiangHeChengJCWin')
else
logErr(FMT.fmt('合成失败，原因：{0}',result))
end
end
