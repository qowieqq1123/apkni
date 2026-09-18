







def_class("UILingZhenPZGameWin",UIWindowBase)









function UILingZhenPZGameWin:bindComponents()

self.startPanel=UIObject.get(self,0)
self.targetBtn=UIButton.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.actTime=UIText.get(self,3)
self.gamePanel=UIObject.get(self,4)
self.startBtn=UIButton.get(self,5)
self.time=UIText.get(self,6)
self.skillBtnC=UIButton.get(self,7)
self.skillBtnB=UIButton.get(self,8)
self.skillBtnA=UIButton.get(self,9)
self.rpos=UIObject.get(self,10)
self.bpos_2=UIObject.get(self,11)
self.bpos_7=UIObject.get(self,12)
self.bpos_6=UIObject.get(self,13)
self.bpos_5=UIObject.get(self,14)
self.bpos_4=UIObject.get(self,15)
self.bpos_3=UIObject.get(self,16)
self.bpos_1=UIObject.get(self,17)
self.cpos_1=UIObject.get(self,18)
self.cpos_2=UIObject.get(self,19)
self.cpos_13=UIObject.get(self,20)
self.cpos_12=UIObject.get(self,21)
self.cpos_11=UIObject.get(self,22)
self.cpos_10=UIObject.get(self,23)
self.cpos_9=UIObject.get(self,24)
self.cpos_8=UIObject.get(self,25)
self.cpos_7=UIObject.get(self,26)
self.cpos_6=UIObject.get(self,27)
self.cpos_5=UIObject.get(self,28)
self.cpos_4=UIObject.get(self,29)
self.cpos_3=UIObject.get(self,30)
self.cpos_14=UIObject.get(self,31)
self.cpos_15=UIObject.get(self,32)
self.topScore=UIText.get(self,33)
self.currScore=UIText.get(self,34)

self.targetBtn:setButtonClick(function()self:onTargetBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)

self.skillBtnC:setButtonClick(function()self:onSkillBtnC()end)

self.skillBtnB:setButtonClick(function()self:onSkillBtnB()end)

self.skillBtnA:setButtonClick(function()self:onSkillBtnA()end)
self.bpos={
self.bpos_1,
self.bpos_2,
self.bpos_3,
self.bpos_4,
self.bpos_5,
self.bpos_6,
self.bpos_7,
}
self.cpos={
self.cpos_1,
self.cpos_2,
self.cpos_3,
self.cpos_4,
self.cpos_5,
self.cpos_6,
self.cpos_7,
self.cpos_8,
self.cpos_9,
self.cpos_10,
self.cpos_11,
self.cpos_12,
self.cpos_13,
self.cpos_14,
self.cpos_15,
}



end


function UILingZhenPZGameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.startPanel);self.startPanel=nil;
_UIObject_release(self.targetBtn);self.targetBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.actTime);self.actTime=nil;
_UIObject_release(self.gamePanel);self.gamePanel=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.skillBtnC);self.skillBtnC=nil;
_UIObject_release(self.skillBtnB);self.skillBtnB=nil;
_UIObject_release(self.skillBtnA);self.skillBtnA=nil;
_UIObject_release(self.rpos);self.rpos=nil;
_UIObject_release(self.bpos_2);self.bpos_2=nil;
_UIObject_release(self.bpos_7);self.bpos_7=nil;
_UIObject_release(self.bpos_6);self.bpos_6=nil;
_UIObject_release(self.bpos_5);self.bpos_5=nil;
_UIObject_release(self.bpos_4);self.bpos_4=nil;
_UIObject_release(self.bpos_3);self.bpos_3=nil;
_UIObject_release(self.bpos_1);self.bpos_1=nil;
_UIObject_release(self.cpos_1);self.cpos_1=nil;
_UIObject_release(self.cpos_2);self.cpos_2=nil;
_UIObject_release(self.cpos_13);self.cpos_13=nil;
_UIObject_release(self.cpos_12);self.cpos_12=nil;
_UIObject_release(self.cpos_11);self.cpos_11=nil;
_UIObject_release(self.cpos_10);self.cpos_10=nil;
_UIObject_release(self.cpos_9);self.cpos_9=nil;
_UIObject_release(self.cpos_8);self.cpos_8=nil;
_UIObject_release(self.cpos_7);self.cpos_7=nil;
_UIObject_release(self.cpos_6);self.cpos_6=nil;
_UIObject_release(self.cpos_5);self.cpos_5=nil;
_UIObject_release(self.cpos_4);self.cpos_4=nil;
_UIObject_release(self.cpos_3);self.cpos_3=nil;
_UIObject_release(self.cpos_14);self.cpos_14=nil;
_UIObject_release(self.cpos_15);self.cpos_15=nil;
_UIObject_release(self.topScore);self.topScore=nil;
_UIObject_release(self.currScore);self.currScore=nil;
self.bpos=nil;
self.cpos=nil;
end



















function UILingZhenPZGameWin:onLoaded(...)
self:bindComponents()

self.selectFunc=function(id)
self:handleItemClick(id)
end

self.startPanel:setActive(true)
self.gamePanel:setActive(false)

local data=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eLingZhenPengZhuang)
if data and data.state==2 then
local etime=data.end_time
local tick=function()
local dt=etime-gameUtilityModel.getServerShortTime()
self.actTime:setText(FMT.fmt('活动时间：{0}',timeHelper.format_time_stamp11(dt,true)))
if dt<=0 then
self:stopTimerByID(self.gtimer)
self.gtimer=nil
end
end
self.gtimer=self:setTimer(1,0,tick)
tick()
else
self.actTime:setText('活动未开启')
end

self.loadRecord={}
end


function UILingZhenPZGameWin:__delete()
self:unbindComponents()

for k,v in pairs(self.loadRecord)do
_InstantiateManager.RemoveInstance(k)
end
self.loadRecord=nil
end




function UILingZhenPZGameWin:onShow(argtable,afterOnloaded)
lingZhenPengZhuangController:reqDatas()
end


function UILingZhenPZGameWin:onHide()

end

function UILingZhenPZGameWin:startCDTimer(gtime)
self:clearCDTimer()
local ctime=gameUtilityModel.getServerShortTime()
self.gameEndTime=ctime+gtime
local tick=function()
local cd=self.gameEndTime-gameUtilityModel.getServerShortTime()
self.time:setText(FMT.fmt('倒计时：{0}',timeHelper.format_time_stamp11(cd)))
if cd<=0 then
self:handleSuccsee()
end
end
self.cdTimer=self:setTimer(1,0,tick)
tick()
end

function UILingZhenPZGameWin:resetCDTimer()
self:startCDTimer(self.rcCD)
end

function UILingZhenPZGameWin:clearCDTimer()
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end

function UILingZhenPZGameWin:pauseCD()
self.rcCD=self.gameEndTime-gameUtilityModel.getServerShortTime()
self:clearCDTimer()
end

function UILingZhenPZGameWin:initData()
local cfg=cfgHelper.get1(cfg_lingzhenpengzhuangconfig_get,1)
self.gameTime=cfg.time
self.kpNum=10
self.cbNum=cfg.num
self.cbScore=cfg.score
self.maxNum=self.kpNum*self.cbNum*cfg.mulriple
self.kpMax=self.maxNum/self.kpNum
self.kvCount={}
self.randDict={}
for i=1,self.kpNum do
self.kvCount[i]=0
self.randDict[i]=i
end

self.posNum=15
self.rpCount={}
self.kpCount={}
self.checkNum=self.maxNum/self.posNum
for i=1,self.posNum do
self.rpCount[i]=0
self.kpCount[i]=0
end

self.createList={}
for i=1,self.maxNum do
local rvp=math.random(1,#self.randDict)
local rv=self.randDict[rvp]
local rvc=self.kvCount[rv]
rvc=rvc+1
self.kvCount[rv]=rvc
if rvc>=self.kpMax then
table.remove(self.randDict,rvp)
end

local rp=math.random(1,self.posNum)
local rpc=self.rpCount[rp]
rpc=rpc+1

if rpc>self.checkNum then
rp=math.random(1,self.posNum)
rpc=self.rpCount[rp]
rpc=rpc+1
end
self.rpCount[rp]=rpc

local rc=self.kpCount[rp]
rc=rc+1
self.kpCount[rp]=rc
table.insert(self.createList,{rp,rv,rc})
end

self.itemPool={}
self.combineList={}
self.recordList={}
self.selectQueue={}

self.score=0
self.skillCount={0,0,0,0}
end

function UILingZhenPZGameWin:setItemList()
self.isPlaying=true
self.playRefresh=true
self.itemList={}
local len=#self.createList
local fcount=0
local setItemFunc=function(id,widget,cdata,index)
local offset=index*4
widget:SetChildLocalPos(-1,0,offset,0)
widget:SetChildText(0,cdata[2])
widget:SetChildButtonClickWithID(1,self.selectFunc,id)


self.itemList[id]={
id=id,
pos=cdata[1],
val=cdata[2],
index=index,
widget=widget
}
fcount=fcount+1
if fcount>=len then
self.playRefresh=false
end
end

local root=self.gamePanel:getTransform()

local count=0
self.timerId=self:setTimer(0.02,0,function()
for i=1,10 do
count=count+1
local cdata=self.createList[count]
if cdata then
local parent=self.cpos[cdata[1]]
local pwt=parent:getTransform()
local index=self.kpCount[cdata[1]]-cdata[3]
local id,widget=self:getItemFromPool()
if id then
local tran=widget:GetCommonComponent(-1,'Transform')

tran.parent=root
tran.parent=pwt
setItemFunc(id,widget,cdata,index)
else
local rid=_InstantiateManager.AddInstance(INSTANCE_TYPE.eLZPZItem,pwt,function(_id)
local _widget=_InstantiateManager.GetComponent(_id,'CSGUIWidgetBase')
setItemFunc(_id,_widget,cdata,index)
end)
self.loadRecord[rid]=true
end
else
self:clearTimer()
self.isPlaying=false
break
end
end
end)
end

function UILingZhenPZGameWin:clearTimer()
if self.timerId then
self:stopTimerByID(self.timerId)
self.timerId=nil
end
end

function UILingZhenPZGameWin:pushToPool(id,widget)
widget:SetChildActive(-1,false)
self.itemPool[id]=widget
end

function UILingZhenPZGameWin:getItemFromPool()
local id,widget=next(self.itemPool)
if widget then
self.itemPool[id]=nil
widget:SetChildActive(-1,true)
end
return id,widget
end

function UILingZhenPZGameWin:handleItemClick(id)
if self.isPlaying then
return
end

local data=self.itemList[id]

if data.index~=0 then
return
end

if#self.combineList>=7 then
return
end

self.itemList[id]=nil
self:setIndexValue(data.pos,-1)
self:addToCombineList(data)
end

function UILingZhenPZGameWin:playMoveAnim(index,callback)
local len=#self.combineList
local check
for i,v in ipairs(self.combineList)do
if i>=index then
local pw=self.bpos[i]
local tp=pw:getChildPosition()
local cb=i==len and callback or nil
v.widget:SetChildDOMove(-1,tp,0.25,cb)
check=true
end
end
if not check then
if callback then
callback()
end
end
end

function UILingZhenPZGameWin:addToCombineList(data)
self.isPlaying=true
local parent=self.gamePanel:getTransform()
local tran=data.widget:GetCommonComponent(-1,'Transform')
tran.parent=parent


data.widget:SetChildButtonClickWithID(1,nil,0,true,0)

local check1=0
local check2=false
local playIndex=1
for i,v in ipairs(self.combineList)do
if check1==1 and v.val~=data.val then
table.insert(self.combineList,i,data)
check2=true
playIndex=i
break
end
if v.val==data.val then
check1=1
end
end

if not check2 then
table.insert(self.combineList,data)
playIndex=#self.combineList
end

self:addToQueue(data)

self:playMoveAnim(playIndex,function()
self:checkAndCombine()
end)
end

function UILingZhenPZGameWin:checkAndCombine()
local rval=-1
local index=-1
local count=0
for i,v in ipairs(self.combineList)do
if rval~=v.val then
rval=v.val
index=i
count=1
else
count=count+1
if count>=3 then
break
end
end
end

if count>=self.cbNum then
local list={}
for i=1,count do
local data=self.combineList[index]
table.insert(list,data)
table.remove(self.combineList,index)
self:removeFormQueue(data.id)
end
for i,v in ipairs(list)do
_InstantiateManager.RemoveInstance(v.id)
self.loadRecord[v.id]=nil
end
self:addScore(self.cbScore)
self:playMoveAnim(index,function()
self.isPlaying=false
local k,v=next(self.itemList)
if not k then
self:handleSuccsee()
end
end)
else
self.isPlaying=false
if#self.combineList>=7 then
self:handleFailure()
end
end
end

function UILingZhenPZGameWin:addScore(score)
self:setScore(self.score+score)
end

function UILingZhenPZGameWin:setScore(score)
self.score=score
self.currScore:setText(self.score)
end

function UILingZhenPZGameWin:addToQueue(data)
table.insert(self.selectQueue,1,data)
end

function UILingZhenPZGameWin:removeFormQueue(id)
for i,v in ipairs(self.selectQueue)do
if v.id==id then
table.remove(self.selectQueue,i)
return
end
end
end

function UILingZhenPZGameWin:setIndexValue(pos,offset)
for k,v in pairs(self.itemList)do
if v.pos==pos then
v.index=v.index+offset
local op=v.index*4
v.widget:SetChildLocalPos(-1,0,op,0)
end
end
end

function UILingZhenPZGameWin:refreshItemList()
self.rpCount={}
self.kpCount={}
for i=1,self.posNum do
self.rpCount[i]=0
self.kpCount[i]=0
end

self.createList={}
local itemList=self.itemList
for k,v in pairs(itemList)do
local rp=math.random(1,self.posNum)
local rpc=self.rpCount[rp]
rpc=rpc+1

if rpc>self.checkNum then
rp=math.random(1,self.posNum)
rpc=self.rpCount[rp]
rpc=rpc+1
end
local rv=v.val
self.rpCount[rp]=rpc
local rc=self.kpCount[rp]
rc=rc+1
self.kpCount[rp]=rc
table.insert(self.createList,{rp,rv,rc})
end

for k,v in pairs(itemList)do
self:pushToPool(k,v.widget)
end

self:setItemList()
end

function UILingZhenPZGameWin:removeItem()
local list={}
local len=#self.combineList
local count=math.min(len,3)
for i=1,count do
local data=self.combineList[1]
table.insert(list,data)
table.remove(self.combineList,1)
self:removeFormQueue(data.id)
end

local clickFunc=function(id)
local data=self.recordList[id]
self:recaptionItem(data)
end

local parent=self.rpos:getTransform()
for i,v in ipairs(list)do
local tran=v.widget:GetCommonComponent(-1,'Transform')
tran.parent=parent
v.widget:SetChildButtonClickWithID(1,clickFunc,v.id)
self.recordList[v.id]=v
end

self:playMoveAnim(1)
end

function UILingZhenPZGameWin:recaptionItem(data)
self.recordList[data.id]=nil
self:addToCombineList(data)
end

function UILingZhenPZGameWin:revocationItem()
local data=self.selectQueue[1]
if not data then
return
end
table.remove(self.selectQueue,1)

local index=0
for i,v in ipairs(self.combineList)do
if v.id==data.id then
index=i
table.remove(self.combineList,i)
break
end
end

self:playMoveAnim(index)

local rp=data.pos
local parent=self.cpos[rp]
local pwt=parent:getTransform()
local tran=data.widget:GetCommonComponent(-1,'Transform')
tran.parent=pwt
local tp=parent:getChildPosition()
data.widget:SetChildDOMove(-1,tp,0.25,function()
self:setIndexValue(rp,1)
self.itemList[data.id]=data
data.index=0
data.widget:SetChildButtonClickWithID(1,self.selectFunc,data.id)
end)
end

function UILingZhenPZGameWin:clearCombineList()
for i,v in ipairs(self.combineList)do
_InstantiateManager.RemoveInstance(v.id)
self.loadRecord[v.id]=nil
end
self.combineList={}
self.selectQueue={}
end

function UILingZhenPZGameWin:handleSuccsee()
self:clearCDTimer()
lingZhenPengZhuangController:reqSetScore(self.score)
UIManager:showWindow('UILZPZResultWin',{success=true,score=self.score})
end

function UILingZhenPZGameWin:handleFailure()
local fdata=cfgHelper.get2(cfg_lingzhenpengzhuangconfig_get,1,'func')
local count=self.skillCount[4]
if count<#fdata[4]then
self:showSkillWin(4)
else
self:showFailureWin()
end
end

function UILingZhenPZGameWin:showFailureWin()
self:clearCDTimer()
lingZhenPengZhuangController:reqSetScore(self.score)
UIManager:showWindow('UILZPZResultWin',{success=false,score=self.score})
end

function UILingZhenPZGameWin:clearGame()
self.startPanel:setActive(true)
self.gamePanel:setActive(false)

for k,v in pairs(self.itemList)do
_InstantiateManager.RemoveInstance(v.id)
self.loadRecord[v.id]=nil
end

for i,v in ipairs(self.combineList)do
_InstantiateManager.RemoveInstance(v.id)
self.loadRecord[v.id]=nil
end

for i,v in ipairs(self.recordList)do
_InstantiateManager.RemoveInstance(v.id)
self.loadRecord[v.id]=nil
end

self:setScore(0)
end

function UILingZhenPZGameWin:setInfo()
self.topScore:setText(lingZhenPengZhuangModel:getTopScore())
end




function UILingZhenPZGameWin:onStartBtn()
if lingZhenPengZhuangController:isActOpen()then
self.startPanel:setActive(false)
self.gamePanel:setActive(true)

self:initData()
self:setInfo()
self:setItemList()
self:startCDTimer(self.gameTime)
else
UIManager.info('活动未开启')
end
end

function UILingZhenPZGameWin:onSkillBtnA()
if#self.combineList>0 then
self:showSkillWin(1)
else
UIManager.info('暂无灵阵可移出')
end
end

function UILingZhenPZGameWin:onSkillBtnB()
if#self.combineList>0 then
self:showSkillWin(2)
else
UIManager.info('暂无灵阵可撤回')
end
end

function UILingZhenPZGameWin:onSkillBtnC()
self:showSkillWin(3)
end

function UILingZhenPZGameWin:showSkillWin(id)
self:pauseCD()
UIManager:showWindow('UILZPZSkillWin',{id=id,count=self.skillCount[id]})
end

function UILingZhenPZGameWin:handleSkill(id)
if id==1 then
self:removeItem()
elseif id==2 then
self:revocationItem()
elseif id==3 then
self:refreshItemList()
elseif id==4 then
self:clearCombineList()
end
self.skillCount[id]=self.skillCount[id]+1
end

function UILingZhenPZGameWin:onTargetBtn()
if lingZhenPengZhuangController:isActOpen()then
UIManager:showWindow('UILZPZTargetWin')
else
UIManager.info('活动未开启')
end
end

function UILingZhenPZGameWin:onHelpBtn()

end

function UILingZhenPZGameWin:onCloseClick()

fullScreenUI.closeActiveUI()
end