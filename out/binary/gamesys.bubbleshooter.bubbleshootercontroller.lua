







bubbleShooterController=gameState.addListener({})
local openMark

function bubbleShooterController:onAppStart()





end

function bubbleShooterController:onEnterState(isReconnet)
bubbleShooterModel:initData()


end

function bubbleShooterController:onLeaveState(isReconnet)
bubbleShooterModel:clearData()
openMark=nil
end

function bubbleShooterController:onProtocolReq(isReconnet)
end

function bubbleShooterController:checkOpenGameWin(subActInfo)
local id=subActInfo.gameid
local check=true
local data=bubbleShooterModel:getLevelData(id)
if data==nil or subActInfo:getNextLevel()~=data.level or data.isExpired==true then
check=false
end
if check==false then
openMark=true
local json_str=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,subActInfo.act_id,subActInfo.sub_act_type,subActInfo.sub_act_id,json_str)
else
bubbleShooterController:openGameWin(id)
end
end

function bubbleShooterController:openGameWin(id)

UIFullCommonControl:showCommonWindow('UIBubbleShooterWin',{id=id})
end

function bubbleShooterController:sendCloseGameWin(id,reStart)
local data=bubbleShooterModel:getLevelData(id)
local subActInfo=activitiesModel:getSubActInfo(data.act_id,data.sub_act_type,data.sub_act_id)
if subActInfo then
local flag=reStart==true and 1 or 0
local json_str=jsonHelper.encode({3,flag})
activitiesController:sendProtocol(actSendType.eComonReqHandle,subActInfo.act_id,subActInfo.sub_act_type,subActInfo.sub_act_id,json_str)
end
end

function bubbleShooterController:useOpenMark()
if openMark==true then
openMark=nil
return true
else
return false
end
end

function bubbleShooterController:checkOpenMark()
return openMark==true
end

function bubbleShooterController:openBuyBallWin(gameid)
local d=bubbleShooterModel:getLevelData(gameid)
bubbleShooterController:openBuyBallWinEx(d.act_id,d.sub_act_type,d.sub_act_id)
end

function bubbleShooterController:openBuyBallWinEx(actID,subType,subid)

UIFullCommonControl:showCommonWindow('UISubAct_wxbtBuyWin',{actID=actID,subType=subType,subid=subid,zgTitleStr="补天礼包"})
end




function bubbleShooterController:reqShoot(angle,color,gameid)
local d=bubbleShooterModel:getLevelData(gameid)
local handle=get_activitiesHandle2(d.sub_act_type)
handle.sendShoot(d.act_id,d.sub_act_type,d.sub_act_id,angle,color)
end


function bubbleShooterController:reqTest(angle,dropRow,dropCol,bt,shootColor)

local color=shootColor or bt:getShootColor()
local shootInfo=bt:mergeKey(dropRow,dropCol,color)
local args={}
args[4]=shootInfo
args[3]=0
args[8]=bubbleShooterModel:newWaitShootList(bt.waitBalls)
args[7]=#args[8]
local delBalls=bt:calculateDelBalls(dropRow,dropCol,color)
if delBalls~=nil then
args[9]=#delBalls
args[10]=delBalls
else
args[9]=0
end
local dropBalls=bt:calculateDropBalls(delBalls,dropRow,dropCol,color)
if dropBalls~=nil then
args[11]=#dropBalls
args[12]=dropBalls
else
args[11]=0
end
local moveRow,newBalls=bt:calculateMoveRow1(delBalls,dropBalls,dropRow,dropCol,color)
args[6]=moveRow
if newBalls~=nil then
args[13]=#newBalls
args[14]=newBalls
else
args[13]=0
end
bubbleShooterController.recv_shoot('test',args)
end


function bubbleShooterController:reqExchange(buyItemID,buynum,gameid)
local d=bubbleShooterModel:getLevelData(gameid)
local handle=get_activitiesHandle2(d.sub_act_type)
handle.sendExchange(d.act_id,d.sub_act_type,d.sub_act_id,buyItemID,buynum)
end






function bubbleShooterController:recv_test()

local data={id='test',groupid=1,level=1,moveRow=nil,score=0}
data.balls=bubbleShooterModel:getLevelBalls(data.groupid,data.level)
data.waitBalls=bubbleShooterModel:getWaitShootList()
bubbleShooterModel:setLevelData(data)
end

function bubbleShooterController:recv_init(subActInfo,args)
local groupid,level=subActInfo:getLevelAndGroup()
local gameScore=args[3]
local offsetRow=args[4]
local len=args[5]
local gameList=args[6]
local ballLen=args[7]
local ballInfo=args[8]
local data={id=subActInfo.gameid,groupid=groupid,level=level,moveRow=offsetRow,score=gameScore,act_id=subActInfo.act_id,sub_act_type=subActInfo.sub_act_type,sub_act_id=subActInfo.sub_act_id}
data.balls=gameList or{}
data.waitBalls=ballInfo or{}
bubbleShooterModel:setLevelData(data)
end


function bubbleShooterController.recv_shoot(id,args)
local data=bubbleShooterModel:getLevelData(id)
if data==nil then return end

local groupid=data.groupid
local level=data.level
local shootInfo=args[4]
local result=args[3]
local score=args[5]
local moveRow=args[6]
local waitBallsLen=args[7]
local waitBalls=args[8]
local delBallsLen=args[9]
local delBalls=args[10]
local dropBallsLen=args[11]
local dropBalls=args[12]
local newBallsLen=args[13]
local newBalls=args[14]
local secondDropBallsLen=args[15]
local secondDropBalls=args[16]
if newBallsLen>0 then
table.sort(newBalls,function(a,b)
return a<b
end)
else





end


if score==nil then
score=data.score+bubbleShooterModel:calculateScore(delBalls,dropBalls)
end
data.score=score
data.moveRow=moveRow
data.waitBalls=waitBalls

local balls={}
local lp={}
local idx_
for _,v in ipairs(data.balls)do
idx_=bubbleShooterModel:getKeyIndex(v)
lp[idx_]=v
end
idx_=bubbleShooterModel:getKeyIndex(shootInfo)
lp[idx_]=shootInfo
if delBallsLen>0 then
for _,idx__ in ipairs(delBalls)do
lp[idx__]=nil
end
end
if dropBallsLen>0 then
for _,idx__ in ipairs(dropBalls)do
lp[idx__]=nil
end
end
local c=0
for _,v in pairs(lp)do
c=c+1
balls[c]=v
end
data.balls=balls

if newBallsLen>0 then
local insertRow,_=bubbleShooterModel:getKeyRowCol(newBalls[#newBalls])
for i,v in ipairs(balls)do
balls[i]=bubbleShooterModel:getKeyOffsetRow(v,insertRow)
end
for _,v in ipairs(newBalls)do
table.insert(balls,v)
end
end

if secondDropBallsLen>0 then
local lp2={}
local balls2={}
for _,v in ipairs(balls)do
idx_=bubbleShooterModel:getKeyIndex(v)
lp2[idx_]=v
end

for _,idx__ in ipairs(secondDropBalls)do
lp2[idx__]=nil
end
local c2=0
for _,v in pairs(lp2)do
c2=c2+1
balls2[c2]=v
end
data.balls=balls2
end

if result==2 then
data.isExpired=true
end
local args_={id=id,shootInfo=shootInfo,result=result,moveRow=moveRow,
waitBalls=waitBalls,delBalls=delBalls,dropBalls=dropBalls,newBalls=newBalls,secondDropBalls=secondDropBalls}
UIManager:invokeUIMethod('UIBubbleShooterWin','recv_shoot',args_)
end

