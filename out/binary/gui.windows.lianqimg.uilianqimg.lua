







def_class("UILianQiMG",UIWindowBase)









function UILianQiMG:bindComponents()

self.achievement=UIButton.get(self,0)
self.beginBtn=UIButton.get(self,1)
self.beginBtnText=UIText.get(self,2)
self.bg=UIObject.get(self,3)
self.count=UIText.get(self,4)
self.drag=UIObject.get(self,5)
self.effect=UIObject.get(self,6)
self.effect2=UIObject.get(self,7)
self.grid=UIObject.get(self,8)
self.help=UIButton.get(self,9)
self.hhCount=UIText.get(self,10)
self.hitScore=UIObject.get(self,11)
self.huHuan=UIButton.get(self,12)
self.item=UIObject.get(self,13)
self.model=UIObject.get(self,14)
self.quXiao=UIButton.get(self,15)
self.qxName=UIText.get(self,16)
self.reddot1=UIObject.get(self,17)
self.reddot2=UIObject.get(self,18)
self.root=UIObject.get(self,19)
self.score=UIText.get(self,20)
self.scoreRoot=UIObject.get(self,21)
self.scoreText=UIObject.get(self,22)
self.shengJie=UIButton.get(self,23)
self.sjCount=UIText.get(self,24)
self.speak=UIObject.get(self,25)
self.time=UIText.get(self,26)
self.xcCount=UIText.get(self,27)
self.xiaoChu=UIButton.get(self,28)

self.achievement:setButtonClick(function()self:onAchievement()end)

self.beginBtn:setButtonClick(function()self:onBeginBtn()end)

self.help:setButtonClick(function()self:onHelp()end)

self.huHuan:setButtonClick(function()self:onHuHuan()end)

self.quXiao:setButtonClick(function()self:onQuXiao()end)

self.shengJie:setButtonClick(function()self:onShengJie()end)

self.xiaoChu:setButtonClick(function()self:onXiaoChu()end)



end


function UILianQiMG:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.achievement);self.achievement=nil;
_UIObject_release(self.beginBtn);self.beginBtn=nil;
_UIObject_release(self.beginBtnText);self.beginBtnText=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.count);self.count=nil;
_UIObject_release(self.drag);self.drag=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.grid);self.grid=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.hhCount);self.hhCount=nil;
_UIObject_release(self.hitScore);self.hitScore=nil;
_UIObject_release(self.huHuan);self.huHuan=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.quXiao);self.quXiao=nil;
_UIObject_release(self.qxName);self.qxName=nil;
_UIObject_release(self.reddot1);self.reddot1=nil;
_UIObject_release(self.reddot2);self.reddot2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.score);self.score=nil;
_UIObject_release(self.scoreRoot);self.scoreRoot=nil;
_UIObject_release(self.scoreText);self.scoreText=nil;
_UIObject_release(self.shengJie);self.shengJie=nil;
_UIObject_release(self.sjCount);self.sjCount=nil;
_UIObject_release(self.speak);self.speak=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.xcCount);self.xcCount=nil;
_UIObject_release(self.xiaoChu);self.xiaoChu=nil;
end
















local _this

local _direction={
up=1,
down=2,
left=3,
right=4
}

local _skillType={
xiaoChu=1,
huHuan=2,
shengJie=3
}

local _itemIndex={
quality=0,
icon=1,
stage=2,
select=3,
click=4,
effect=5
}




function UILianQiMG:onLoaded(...)
self:bindComponents()

_this=self

self.itemDataPool={}
self.scoreTextPool={}
self.hitScoreTextPool={}
self.moveTime=0.2

self.selectEffectTweens={}

self.checkMoneyType={
[eMoneyType.mtXuanXuSha]=true,
[eMoneyType.mtLiangYiPan]=true,
[eMoneyType.mtJiuZhuanSui]=true,
}

self.skillTexts={
self.xcCount,
self.hhCount,
self.sjCount
}

self.cancelBtnName={
'取消消除',
'取消互换',
'取消升阶'
}

self.tipsTypeToCfgName={
'speak_begin',
'speak_hit',
'speak_fz',
}

self.fzTypeToIndex={
[0]=1,
[1]=2,
[2]=3,
[3]=4,
}

self.abName='ui/windows/lianqimg/lianqi_mg_atlas_pak.ab'

self.winlua:SetChildUIDragEvent(self.drag:getID(),0,function(...)
if _this then
_this:onBeginDrag(...)
end
end,function(...)
if _this then
_this:onEndDrag(...)
end
end,function(...)
if _this then
_this:onDrag(...)
end
end)

self.item:setActive(false)
self.scoreText:setActive(false)
self.hitScore:setActive(false)

self.quXiao:setActive(false)

self.speak:setChildCanvasGroupAlpha(0)

self.gridDatas={[0]={},{},{},{}}
local gridWB=self.grid:getChildWidgetBase()
for i=0,15 do
local st=gridWB:GetChildGameObject(i).transform
local y=math.floor(i/4)
local x=i%4
self.gridDatas[x][y]={
index=i+1,
x=x,
y=y,
wpos=st.position
}
end







self.handleGridArray={{[0]={},{},{},{}},{[0]={},{},{},{}},{[0]={},{},{},{}},{[0]={},{},{},{}}}
for x=0,3 do
for y=0,3 do
self.handleGridArray[_direction.left][x][y]=self.gridDatas[x][y]
self.handleGridArray[_direction.right][x][y]=self.gridDatas[3-x][3-y]
self.handleGridArray[_direction.up][x][y]=self.gridDatas[y][x]
self.handleGridArray[_direction.down][x][y]=self.gridDatas[3-y][3-x]
end
end

self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
end

function UILianQiMG:onMoneyChanged(moneyType,lastVal,val)
if not self.checkMoneyType[moneyType]then
return
end
self:setSkillCount()
end


function UILianQiMG:__delete()
self:unbindComponents()

UIManager:closeWindow('UITopMoneyWin4')

_this=nil
end




function UILianQiMG:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.actId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

UIManager:showWindow('UITopMoneyWin4',{moneys={{eMoneyType.mtDiHuoJing}},offsetX=75.9,offsetY=-29.71})

self.config=cfgHelper.get1(cfg_artifactrefineconfig_get,self.subId)
self.maxMergeLevel=#self.config.score
self:setEndTimeTips()
self:refresh()
self:setModel()

self:setChengJiuReddot()
end


function UILianQiMG:onHide()
UIManager:hideWindow('UITopMoneyWin4')
self:onQuXiao()
end

function UILianQiMG:setEndTimeTips()
if not self.nTimer then
local info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
local etime=info.end_time
local tick=function()
local dt=etime-gameUtilityModel.getServerShortTime()
local earlyEndTime=self.config.earlyEndTime or 0
local check=dt<earlyEndTime
if check then
if not self.isInSettlementTime then
self.isInSettlementTime=true
self:enterSettlementTime()
self.reddot1:setActive(false)
end
self.time:setText(FMT.fmt('活动排行结算中：{0}',timeHelper.format_time_stamp11(dt,true)))
if dt<0 then
self.time:setText('活动已结束')
self:stopTimerByID(self.nTimer)
self.nTimer=nil
end
else
local st=dt-earlyEndTime
self.time:setText(FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp11(st,true)))
end
end
self.nTimer=self:setTimer(1,0,tick)
tick()
end
end

function UILianQiMG:enterSettlementTime()
self.beginBtn:setChildGraphicGray(true)
end

function UILianQiMG:setModel()
self.model:setChildUIModelShowTarget(1113038,1,{},eAnimationID.stand)
self:setBottleneckTips()
end

function UILianQiMG:setScoreAndCount()
local data=self:getSubActData()
self.score:setText(data.gameScore)
self.count:setText(data.roundNum)
self:playScoreText()
end

function UILianQiMG:clearScore()
local data=self:getSubActData()
data.gameScore=0
data.roundNum=0
self:setScoreAndCount()
end

function UILianQiMG:refresh()
self:initGame()
end

function UILianQiMG:setBeginBtnReddot()
local info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
local check=info:checkCanPlayReddot()
self.reddot1:setActive(check)
end

function UILianQiMG:setChengJiuReddot()
local info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
local check=info:checkChengJiuReddot()
self.reddot2:setActive(check)
end

function UILianQiMG:getSubActData()
if not self.actData then
self.actData=activitiesModel:getSubActInfoData(self.actId,self.subType,self.subId)
end
return self.actData
end

function UILianQiMG:initGame()
local data=self:getSubActData()
self.gameState=1
if data.gridList then
self.gameState=2
end

if self.gameState==1 then
self.beginBtnText:setText('开始挑战')
elseif self.gameState==2 then
self.beginBtnText:setText('结束挑战')
self.effect2:setChildShowEffect(22661,true)
self:resetAllGrid(data.gridList)
end

self:setSkillCount()
self:setScoreAndCount()

self:setBeginBtnReddot()
end

function UILianQiMG:handleEndGame(rankData)
if self.gameState==2 then
self.gameState=1
self.waitResult=false
self.beginBtnText:setText('开始挑战')
self.effect:setChildShowEffect(22657,true)
self.effect2:setChildShowEffect(22661,false)
self.playing=true
self:delayDo(1,function()
self.playing=false
UIManager:showWindow('UILianQiMGResult',{actId=self.actId,subType=self.subType,subId=self.subId,rankData=rankData})
self:clearAllGrid()
self:clearScore()
end)
self:setBeginBtnReddot()
end
end

function UILianQiMG:handlePlayResult(newItemList)
if self.gameState==1 then
self.gameState=2
self.beginBtnText:setText('结束挑战')
self.effect:setChildShowEffect(22656,true)
self.effect2:setChildShowEffect(22661,true)
self:showTips(1)
self:setBeginBtnReddot()
end
self.newItemList=newItemList
self.waitResult=false
self:handlePlayFinish()
self:setScoreAndCount()
end

function UILianQiMG:setSkillCount()
local auxItem=self.config.auxItem
for i=1,3 do
local itemData=auxItem[i][1]
local have=moneyModel.getMoney(itemData[1])
local count=math.floor(have/itemData[2])
local text=self.skillTexts[i]
text:setText(count)
end
end

function UILianQiMG:handlePlayFinish()
if self.playing or self.waitResult then
return
end

self:showHitScoreText()
self:showTips(2,self.hitCount)

local newItemList=self.newItemList
self.newItemList=nil

local data=self:getSubActData()
local gridList=data.gridList

if newItemList then
local list={}
for i,v in ipairs(gridList)do
list[i]=v
end
for i,v in ipairs(newItemList)do
list[v.param_1]=0
end
gridList=list
end



local check=self:checkGridList(gridList)
if not check then
self:printGridChange(gridList)
self:resetAllGrid(gridList)
end

if not newItemList then
self:setBottleneckTips()
return
end

for i,v in ipairs(newItemList)do
local pos=v.param_1
local level=v.param_2
self:addNewItem(pos,level,true)
end

self:setBottleneckTips()
end

function UILianQiMG:printGrid()
local data=self:getSubActData()
local str=''
for y=0,3 do
for x=0,3 do
local d=self.gridDatas[x][y]
if d.itemData then
str=str..'_'..d.itemData.level
else
str=str..'_0'
end
end
end
logWarn(FMT.fmt('炼器-当前：{0} {1}',str,data.roundNum))
end

function UILianQiMG:printGridChange(gridList)
local data=self:getSubActData()
local str=''
for y=0,3 do
for x=0,3 do
local d=self.gridDatas[x][y]
if d.itemData then
str=str..'_'..d.itemData.level
else
str=str..'_0'
end
end
end
logErr(FMT.fmt('炼器-当前：{0} {1}',str,data.roundNum))

str=''
for i,v in ipairs(gridList)do
str=str..'_'..v
end
logErr(FMT.fmt('炼器-下发：{0} {1}',str,data.roundNum))

logErr('服务器下发数据与客户端实际执行不一致')
end
























function UILianQiMG:getPosDataByIndex(index)
local id=index-1
local x=id%4
local y=math.floor(id/4)
local data=self.gridDatas[x][y]
return data
end

function UILianQiMG:setItemSelectState(item,active)
item:SetChildActive(_itemIndex.select,active)
item:SetChildActive(_itemIndex.click,active)
end

function UILianQiMG:createItemInstance(wpos)
local tran=self.item:getTransform()
local nt=GameObject.Instantiate(tran,self.grid:getTransform())
nt.gameObject:SetActive(true)
local w=nt:GetComponent('CSGUIWidgetBase')
w:SetChildPosition(-1,wpos)
w:SetChildActive(_itemIndex.select,false)
w:SetChildActive(_itemIndex.click,false)
return w
end

function UILianQiMG:checkGridList(gridList)
for i=0,3 do
for j=0,3 do
local d=self.gridDatas[i][j]
local val=gridList[d.index]
if d.itemData then
local level=d.itemData.level
if level~=val then
return false
end
else
if val~=0 then
return false
end
end
end
end
return true
end

function UILianQiMG:clearAllGrid()
for i=0,3 do
for j=0,3 do
local d=self.gridDatas[i][j]
if d.itemData then
self:removeItem(d.itemData)
d.itemData=nil
end
end
end
end

function UILianQiMG:resetAllGrid(gridList)
self:clearAllGrid()

for i,v in ipairs(gridList)do
if v>0 then
self:addNewItem(i,v)
end
end
end

function UILianQiMG:addNewItem(index,level,showScore)
local pdata=self:getPosDataByIndex(index)
if pdata then
if#self.itemDataPool>0 then
local itemData=table.remove(self.itemDataPool)
itemData.item:SetChildActive(-1,true)
itemData.item:SetChildPosition(-1,pdata.wpos)
itemData.level=level
pdata.itemData=itemData
self:refreshItem(itemData)
self:setItemSelectState(itemData.item,false)
else
local item=self:createItemInstance(pdata.wpos)
pdata.itemData={
item=item,
level=level
}
self:refreshItem(pdata.itemData)
self:setItemSelectState(item,false)
end
if showScore then
self:showScoreText(level,pdata.wpos)
end
end
end

function UILianQiMG:removeItem(data)
data.item:SetChildShowEffect(_itemIndex.effect,22660,false)
data.item:SetChildCanvasGroupAlpha(_itemIndex.icon,1)
data.item:SetChildActive(_itemIndex.click,false)
data.item:SetChildGraphicGray(-1,false,true)
data.item:SetChildActive(-1,false)
data.item:SetChildCanvasGroupAlpha(-1,1)
table.insert(self.itemDataPool,data)
end








function UILianQiMG:getHandleList(gridArray,y)
local count=1
local list={{},{},{},{}}
for x=0,3 do
local pd=gridArray[x][y]
local itemData=pd.itemData
if itemData then
local arr=list[count]
local d1=arr[1]
if d1 then
local d2=arr[2]
if d2 then
count=count+1
list[count][1]=itemData
else
if d1.level==itemData.level and(d1.level+1<=self.maxMergeLevel)then
arr[2]=itemData
else
count=count+1
list[count][1]=itemData
end
end
else
arr[1]=itemData
end
end
end
return list
end













function UILianQiMG:handleMerge(direction)
self.playing=true
local needPlay=false
local gridArray=self.handleGridArray[direction]
for y=0,3 do
local list=self:getHandleList(gridArray,y)
for i,v in ipairs(list)do
local pd=gridArray[i-1][y]
pd.itemData=nil
local c=#v
if c==1 then
needPlay=true
pd.itemData=v[1]
pd.itemData.item:SetChildDOMove(-1,pd.wpos,self.moveTime,nil)
elseif c==2 then
needPlay=true
local d1=v[1]
local d2=v[2]
pd.itemData=d1
d1.item:SetChildDOMove(-1,pd.wpos,self.moveTime,function()
if _this then
d1.level=d1.level+1
self.hitCount=self.hitCount+1
self:refreshItem(d1)
self:showScoreText(d1.level,pd.wpos)
d1.item:SetChildShowEffect(_itemIndex.effect,22660,true)
end
end)
d2.item:SetChildDOMove(-1,pd.wpos,self.moveTime,function()
if _this then
self:removeItem(d2)
end
end)
end
end
end

if needPlay then
self:delayDo(self.moveTime+0.01,function()
if _this then
if self:isCanMerge(direction)then
self:handleMerge(direction)
else
self.playing=false
self:handlePlayFinish()
end
end
end)
else
self.playing=false
self:handlePlayFinish()
end
end

function UILianQiMG:isCanMerge(direction)
local gridArray=self.handleGridArray[direction]
for y=0,3 do
local list=self:getHandleList(gridArray,y)
for i,v in ipairs(list)do
if#v==2 then
return true
end
end
end
return false
end

function UILianQiMG:hasEmptyPos()
for i=0,3 do
for j=0,3 do
local d=self.gridDatas[i][j]
if not d.itemData then
return true
end
end
end
return false
end

function UILianQiMG:refreshItem(data)
data.item:SetChildText(_itemIndex.stage,data.level)
data.item:SetChildCSImageSprite(_itemIndex.quality,self.abName,'image_lianqidahui_db'..data.level)
local iconName=self.config.icons[data.level]
data.item:SetChildIcon(_itemIndex.icon,iconName,true)
end

function UILianQiMG:getNoEmptyList()
local list={}
for i=0,3 do
for j=0,3 do
local d=self.gridDatas[i][j]
if d.itemData then
table.insert(list,d)
end
end
end
return list
end

function UILianQiMG:handleSkillFinish(onlyClear)
if not self.playing then
return
end
self:showTips(3,0,true)
for i=0,3 do
for j=0,3 do
local d=self.gridDatas[i][j]
if d.itemData then
self:setItemSelectState(d.itemData.item,false)
end
end
end
self.playing=false
self.isUseSkill=false
self.drag:setActive(true)
self:clearAllSelectEffect()
self:setSkillBtnShow()
if not onlyClear then
self:handlePlayFinish()
end
end

function UILianQiMG:setSelectEffect(index,item)
if self.selectEffectTweens[index]then
return
end
local tween=item:SetChildCanvasGroupDOFade(_itemIndex.icon,0.1,0.5,nil)

tween:SetLoops(-1,_LoopType.Yoyo)
self.selectEffectTweens[index]=tween

item:SetChildActive(_itemIndex.click,true)
end

function UILianQiMG:clearAllSelectEffect()
for k,v in pairs(self.selectEffectTweens)do
v:Kill()
end
self.selectEffectTweens={}

for i=0,3 do
for j=0,3 do
local d=self.gridDatas[i][j]
if d.itemData then
d.itemData.item:SetChildCanvasGroupAlpha(_itemIndex.icon,1)
d.itemData.item:SetChildActive(_itemIndex.click,false)
d.itemData.item:SetChildGraphicGray(-1,false,true)
end
end
end
end

function UILianQiMG:checkCanUseSkill(stype,list)
local auxItem=self.config.auxItem
if stype==_skillType.xiaoChu then
local canUseLevel=auxItem[stype][2]
for i,v in ipairs(list)do
local itemData=v.itemData
if itemData then
if itemData.level<=canUseLevel then
return true
end
end
end
elseif stype==_skillType.huHuan then
local count=0
for i,v in ipairs(list)do
local itemData=v.itemData
if itemData then
count=count+1
if count>=2 then
return true
end
end
end
elseif stype==_skillType.shengJie then
local canUseLevel=auxItem[stype][2]
for i,v in ipairs(list)do
local itemData=v.itemData
if itemData then
if itemData.level<=canUseLevel then
return true
end
end
end
end

return false
end

function UILianQiMG:useSkill(stype)
if not self:checkItemEnough(stype,true)then
gainControl:showGainWin(self.config.auxItem[stype][1][1])
return
end

if self.gameState~=2 then
UIManager.info('开始挑战后方可使用功能')
gainControl:showGainWin(self.config.auxItem[stype][1][1])
return
end

if self.playing or self.waitResult then
return
end

local list=self:getNoEmptyList()
if not self:checkCanUseSkill(stype,list)then
UIManager.error('无可操作装备')
return
end

local auxItem=self.config.auxItem
local handleList={}
if stype==_skillType.xiaoChu then
local canUseLevel=auxItem[stype][2]
for i,v in ipairs(list)do
local index=v.index
local itemData=v.itemData
if itemData then
local item=itemData.item
if itemData.level<=canUseLevel then
table.insert(handleList,itemData)
self:setSelectEffect(index,item)
item:SetChildButtonClick(_itemIndex.click,function()
UIDialogManager.getConfirmDialog3(nil,FMT.fmt('是否消除本{0}阶装备',itemData.level),function()
item:SetChildShowEffect(_itemIndex.effect,22662,true)
item:SetChildCanvasGroupDOFade(-1,0,1,function()
v.itemData=nil
self:callActivityFunc('reqDestroy',index)
self.waitResult=true
self:removeItem(itemData)
self:handleSkillFinish()
end)
end,REPEAT_TYPE.eLianQiMiniGame1)
end)
else
item:SetChildActive(_itemIndex.click,true)
item:SetChildGraphicGray(-1,true,true)
item:SetChildButtonClick(_itemIndex.click,function()
UIManager.info(FMT.fmt('只能消除{0}阶及其以下装备',canUseLevel))
end)
end
end
end
elseif stype==_skillType.huHuan then
local currSelect
for i,v in ipairs(list)do
local index=v.index
local itemData=v.itemData
if itemData then
table.insert(handleList,itemData)
local item=itemData.item
self:setSelectEffect(index,item)
item:SetChildButtonClick(_itemIndex.click,function()
if currSelect then
UIDialogManager.getConfirmDialog3(nil,'是否互换两个装备',function()
self:callActivityFunc('reqExchange',currSelect.index,index)
self.waitResult=true
self:setItemSelectState(currSelect.itemData.item,false)
local d1=currSelect.itemData
local d2=v.itemData
currSelect.itemData=v.itemData
v.itemData=d1
local wp1=currSelect.wpos
local wp2=v.wpos
d1.item:SetChildDOScaleX(-1,0,0.25,nil)
d2.item:SetChildDOScaleX(-1,0,0.25,function()
d1.item:SetChildPosition(-1,wp2)
d2.item:SetChildPosition(-1,wp1)
d1.item:SetChildDOScaleX(-1,1,0.25,nil)
d2.item:SetChildDOScaleX(-1,1,0.25,function()
self:handleSkillFinish()
end)
end)
end,REPEAT_TYPE.eLianQiMiniGame2)
else
self:setItemSelectState(itemData.item,true)
currSelect=v
end
end)
end
end
elseif stype==_skillType.shengJie then
local canUseLevel=auxItem[stype][2]
for i,v in ipairs(list)do
local index=v.index
local itemData=v.itemData
if itemData then
local item=itemData.item
if itemData.level<=canUseLevel then
table.insert(handleList,itemData)
self:setSelectEffect(index,item)
item:SetChildButtonClick(_itemIndex.click,function()
UIDialogManager.getConfirmDialog3(nil,FMT.fmt('是否将本{0}阶装备升级到{1}阶',itemData.level,itemData.level+1),function()
item:SetChildShowEffect(_itemIndex.effect,22663,true)
self:callActivityFunc('reqLevelUp',index)
self.waitResult=true
itemData.level=itemData.level+1
self:refreshItem(itemData)
self:handleSkillFinish()
end,REPEAT_TYPE.eLianQiMiniGame3)
end)
else
item:SetChildActive(_itemIndex.click,true)
item:SetChildGraphicGray(-1,true,true)
item:SetChildButtonClick(_itemIndex.click,function()
UIManager.info(FMT.fmt('只能升阶{0}阶及其以下装备',canUseLevel))
end)
end
end
end
end

self.playing=true
self.isUseSkill=true
self.drag:setActive(false)
self:setSkillBtnShow(self.cancelBtnName[stype])
self:showTips(3,stype)
end

function UILianQiMG:showScoreText(level,wpos)
local score=self.config.score[level]or 0
local tw
if#self.scoreTextPool>0 then
tw=table.remove(self.scoreTextPool)
else
local tran=self.scoreText:getTransform()
local nt=GameObject.Instantiate(tran,self.scoreRoot:getTransform())
nt.gameObject:SetActive(true)
tw=nt:GetComponent('CSGUIWidgetBase')
end
tw:SetChildText(0,score)
tw:SetChildPosition(-1,wpos)
local pos=tw:GetChildAnchoredPosition3D(-1)
pos.y=pos.y+100
tw:SetChildDOAnchorPos3D(-1,pos,1.51,function()
table.insert(self.scoreTextPool,tw)
end)

tw:SetChildCanvasGroupAlpha(-1,1)
local tween=tw:SetChildCanvasGroupDOFade(-1,0,0.5,nil)
tween:SetDelay(1)

tw:SetChildScale(-1,Vector3.New(0,0,1))
tween=tw:SetChildDOScale(-1,1,0.25,nil)
tween:SetEase(_Ease.OutQuad)

tween=tw:SetChildDOScale(-1,0.5,0.5,nil)
tween:SetEase(_Ease.InQuad)
tween:SetDelay(0.25)
end

function UILianQiMG:showHitScoreText()
local score=self.config.comboScore[self.hitCount]or 0
if score<=0 then
return
end
local tw
if#self.hitScoreTextPool>0 then
tw=table.remove(self.hitScoreTextPool)
else
local tran=self.hitScore:getTransform()
local nt=GameObject.Instantiate(tran,self.scoreRoot:getTransform())
nt.gameObject:SetActive(true)
tw=nt:GetComponent('CSGUIWidgetBase')
end
tw:SetChildText(0,score)
local wpos=self.hitScore:getChildPosition()
tw:SetChildPosition(-1,wpos)
local pos=tw:GetChildAnchoredPosition3D(-1)
local spos=Vector3.New(pos.x+200,pos.y,pos.z)
tw:SetChildAnchoredPosition3D(-1,spos)
tw:SetChildDOAnchorPos3D(-1,pos,0.5,nil)
tw:SetChildCanvasGroupAlpha(-1,0)
tw:SetChildCanvasGroupDOFade(-1,1,0.5,nil)
local tween=tw:SetChildCanvasGroupDOFade(-1,0,0.5,function()
table.insert(self.hitScoreTextPool,tw)
end)
tween:SetDelay(1.5)
end

function UILianQiMG:playScoreText()
if self.scoreTween then
self.scoreTween:Kill()
end
self.score:setScale(Vector3.New(1,1,1))
self.scoreTween=self.score:setChildDOScale(1.5,0.2,function()
self.scoreTween=nil
end)
self.scoreTween:SetLoops(2,_LoopType.Yoyo)
end

function UILianQiMG:callActivityFunc(fname,...)
return call_activitiesHandle_func('activitiesHandle_lianqidahui',fname,self.actId,self.subId,...)
end

function UILianQiMG:setBottleneckTips()







self:showTips(3,0,not self:checkBottleneck())
end

function UILianQiMG:checkBottleneck()
if self:hasEmptyPos()then
return false
end
for k,v in pairs(_direction)do
if self:isCanMerge(v)then
return false
end
end
return true
end

function UILianQiMG:showTips(stype,arg1,arg2)
if self.tipsNeedClose and stype~=3 then
return
end
if arg2 then
if self.tipsNeedClose then
self.tipsNeedClose=nil
if self.tipsTween then
self.tipsTween:Rewind()
self.tipsTween:Kill()
end
self.tipsTween=nil
self.speak:setChildCanvasGroupAlpha(0)
end
return
else
if self.tipsTween then
self.tipsTween:Kill()
end
end
local speakData=self.config[self.tipsTypeToCfgName[stype]]
local txt
if stype==1 then
txt=speakData[math.random(1,#speakData)]
elseif stype==2 then
if not arg1 then
return
end
local list
for i,v in ipairs(speakData)do
if arg1>=v[1]then
list=v[2]
else
break
end
end
if not list then
return
end
txt=list[math.random(1,#list)]
elseif stype==3 then
txt=speakData[self.fzTypeToIndex[arg1]]
self.tipsNeedClose=true
end
self.speak:setChildCanvasGroupAlpha(1)
local spkWidget=self.speak:getWidgetBase()
spkWidget:SetChildCanvasGroupAlpha(0,1)
spkWidget:SetChildText(0,chatEmotHelper.decodeEmot(txt))
if stype==3 then
spkWidget:SetChildActive(1,false)
spkWidget:SetChildActive(2,true)
self.tipsTween=spkWidget:SetChildCanvasGroupDOFade(0,0.1,0.5,nil)
self.tipsTween:SetEase(_Ease.Linear)
self.tipsTween:SetLoops(-1,_LoopType.Yoyo)
else
spkWidget:SetChildActive(1,true)
spkWidget:SetChildActive(2,false)
self.tipsTween=self.speak:setChildCanvasGroupDOFade(0,0.25,function()
self.tipsTween=nil
end)
self.tipsTween:SetDelay(3)
end
end

function UILianQiMG:setSkillBtnShow(qxName)
if qxName then
self.quXiao:setActive(true)
self.xiaoChu:setActive(false)
self.huHuan:setActive(false)
self.shengJie:setActive(false)
self.qxName:setText(qxName)
else
self.quXiao:setActive(false)
self.xiaoChu:setActive(true)
self.huHuan:setActive(true)
self.shengJie:setActive(true)
end
end

function UILianQiMG:showDialogue(content,okcb)
local dialog=UIDialogManager.getConfirmDialog(nil,'提示',content,'确认','取消',okcb)
dialog:show()
end




function UILianQiMG:checkItemEnough(skType,showTips)
local auxItem=self.config.auxItem
local itemData=auxItem[skType][1]
local have=itemsModel.getCount(itemData[1])
if have>=itemData[2]then
return true
else
if showTips then
local name=itemsConfig.getItemName(itemData[1])
UIManager.error(name..'不足')
end
return false
end
end

function UILianQiMG:checkCost(showTips)
local moveCost=self.config.moveCost
local have=itemsModel.getCount(moveCost[1])
if have>=moveCost[2]then
return true
else
if showTips then
local name=itemsConfig.getItemName(moveCost[1])
UIManager.error(name..'不足')
end
return false
end
end

function UILianQiMG:onQuXiao()
if self.isUseSkill then
self:handleSkillFinish(true)
self:setBottleneckTips()
end
end

function UILianQiMG:onXiaoChu()
self:useSkill(_skillType.xiaoChu)
end

function UILianQiMG:onHuHuan()
self:useSkill(_skillType.huHuan)
end

function UILianQiMG:onShengJie()
self:useSkill(_skillType.shengJie)
end

function UILianQiMG:onHelp()
local args={
ruleGroupID=ruleTipsImageGroup.eLianQiDaHui,
}
self:showWindow("UIRuleTipsImage2Win",args)
end

function UILianQiMG:onAchievement()
UIManager:showWindow('UILianQiMGCJ',{actId=self.actId,subType=self.subType,subId=self.subId})
end

function UILianQiMG:onBeginDrag(id,pos)
self.beginPos=pos
end

function UILianQiMG:onEndDrag(id,pos,deltaTime)
if self.gameState~=2 then
return
end

if not self:checkCost(true)then
gainControl:showGainWin(self.config.moveCost[1])
return
end

local x=pos.x-self.beginPos.x
local y=pos.y-self.beginPos.y
local cx=math.abs(x)
local cy=math.abs(y)
if cx<50 and cy<50 then
return
end
if self.playing or self.waitResult then
return
end
local direction
if cx>cy then
if x>0 then
direction=_direction.right
else
direction=_direction.left
end
else
if y>0 then
direction=_direction.up
else
direction=_direction.down
end
end
if direction and(self:hasEmptyPos()or self:isCanMerge(direction))then
self.hitCount=0
self:handleMerge(direction)
self:callActivityFunc('reqPlayGame',direction)
self.waitResult=true
end
end

function UILianQiMG:onDrag(id,pos)

end

function UILianQiMG:handleBeginGame()
if not self:checkCost(true)then
gainControl:showGainWin(self.config.moveCost[1])
return
end
self.waitResult=true
self:callActivityFunc('reqStartGame')
end

function UILianQiMG:onBeginBtn()
if self.waitResult or self.playing then
return
end
if self.gameState==1 then
if not self.isInSettlementTime then
self:handleBeginGame()
else
UIManager.info('活动排行结算中，请耐心等待')
end
elseif self.gameState==2 then
self:showDialogue('是否确认结束挑战？',function()
if _this then
self.waitResult=true
self:callActivityFunc('reqEndGame')
end
end)
end
end

function UILianQiMG:onCloseClick()
self:closeSelf()
end
