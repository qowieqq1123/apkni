







bubbleShooterModel={}
local blockLookup
local colorIcon={
[bbBallColor.eYellow]='image_wuxingbutianwanfa_pp1',
[bbBallColor.eGreen]='image_wuxingbutianwanfa_pp2',
[bbBallColor.eBlue]='image_wuxingbutianwanfa_pp3',
[bbBallColor.eRed]='image_wuxingbutianwanfa_pp4',
[bbBallColor.eGary]='image_wuxingbutianwanfa_pp5',
[bbBallColor.eFunc1]='image_wuxingbutianwanfa_pp7',
[bbBallColor.eFunc2]='image_wuxingbutianwanfa_pp6',

}
local levelLookup

function bubbleShooterModel:initData()
levelLookup={}
end

function bubbleShooterModel:clearData()
blockLookup=nil
levelLookup=nil
end



function bubbleShooterModel:getBlock(blockid)
if blockLookup==nil then
blockLookup=require("lua.gameSys.bubbleShooter.bubbleshooterblockconfig")
end
return blockLookup[blockid]
end

function bubbleShooterModel:getLevelBalls(groupid,level)
local blockid=cfgHelper.get3(cfg_bubbleshooterlevelconfig_get,groupid,level,'blockid')
local block=bubbleShooterModel:getBlock(blockid)
local balls={}
if block~=nil then
for i,v in ipairs(block)do
local color=v
if color>0 then
if color==bbBallColor.eRandom then
color=bubbleShooterModel:randomBallColor()
end
table.insert(balls,i*100+color)
end
end
end
return balls
end





function bubbleShooterModel:setLevelData(data)
if levelLookup==nil then
levelLookup={}
end
levelLookup[data.id]=data
end

function bubbleShooterModel:getLevelData(id)
if levelLookup~=nil then
return levelLookup[id]
end
end

function bubbleShooterModel:removeLevelData(id)
if levelLookup~=nil then
levelLookup[id]=nil
end
end

function bubbleShooterModel:calculateScore(delBalls,dropBalls)
return bubbleShooterModel:calculateScore_del(delBalls)+bubbleShooterModel:calculateScore_drop(dropBalls)
end

function bubbleShooterModel:calculateScore_del(delBalls)
local s=0
if delBalls~=nil then
s=bubbleShooterModel.calculateScoreCommon('eliminateScore',#delBalls)
end
return s
end

function bubbleShooterModel:calculateScore_drop(dropBalls)
local s=0
if dropBalls~=nil then
s=bubbleShooterModel.calculateScoreCommon('dropScore',#dropBalls)
end
return s
end

function bubbleShooterModel.calculateScoreCommon(key,n)
local score=cfgHelper.get2(cfg_wuxingbutianactconfig_get,1,key)
local rate=1
for i=#score[2],1,-1 do
local v=score[2][i]
if n>=v[1]then
rate=v[2]
break
end
end
return math.floor(n*score[1]*rate)
end

function bubbleShooterModel.isMaxLevel(groupid,level)
local cfgs=cfgHelper.get1(cfg_bubbleshooterlevelconfig_get,groupid)
local max=#cfgs
return level>=max
end

function bubbleShooterModel.isNormalMode(groupid,level)
local cfg=cfgHelper.get(cfg_bubbleshooterlevelconfig_get,groupid,level)
local score=cfg and cfg.score or 0

return score>0
end


function bubbleShooterModel:randomBallColor()
return math.random(bbBallColor.eGreen,bbBallColor.eRed)
end

function bubbleShooterModel:getWaitShootList()
local list={}
list[1]=bubbleShooterModel:randomBallColor()
list[2]=bubbleShooterModel:randomBallColor()
return list
end

function bubbleShooterModel:newWaitShootList(waitBalls)
local list={}
list[1]=waitBalls[2]
list[2]=bubbleShooterModel:randomBallColor()
return list
end

function bubbleShooterModel:getBallIcon(color)

local abName="ui/windows/bubbleshooter/bubbleshooter_atlas_pak.ab"
return abName,colorIcon[color]
end

function bubbleShooterModel:getBaseConfig()
return cfgHelper.get1(cfg_bubbleshooterbaseconfig_get,1)
end

function bubbleShooterModel:getMaxCol()
return cfgHelper.get2(cfg_bubbleshooterbaseconfig_get,1,'maxCol')
end

function bubbleShooterModel:getKeyOffsetRow(key,row)
local maxCol=bubbleShooterModel:getMaxCol()
return key+row*maxCol*100
end

function bubbleShooterModel:getKeyRowCol(key)
local index=math.floor(key/100)
local maxCol=bubbleShooterModel:getMaxCol()
local row=math.ceil(index/maxCol)
local col=index%maxCol
return row,col
end

function bubbleShooterModel:getKeyIndex(key)
return math.floor(key/100)
end