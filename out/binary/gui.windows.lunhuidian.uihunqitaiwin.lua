







def_class("UIHunQiTaiWin",UIWindowBase)









function UIHunQiTaiWin:bindComponents()

self.actorRoot=UIObject.get(self,0)
self.animRoot=UIObject.get(self,1)
self.bdLevel=UIText.get(self,2)
self.emojiRoot=UIObject.get(self,3)
self.ghostRoot=UIObject.get(self,4)
self.levelUpBtn=UIButton.get(self,5)
self.levelUpBtnText=UIText.get(self,6)
self.mbg=UIObject.get(self,7)
self.modelRoot=UIObject.get(self,8)
self.root=UIObject.get(self,9)
self.ruleBtn=UIButton.get(self,10)
self.speakObj_1=UIObject.get(self,11)
self.speakObj_2=UIObject.get(self,12)
self.speakText_1=UIText.get(self,13)
self.speakText_2=UIText.get(self,14)
self.zhaoMuBtn=UIButton.get(self,15)
self.nowlhtxt=UIText.get(self,16)
self.nextlhtxt=UIText.get(self,17)
self.progressbar=UIObject.get(self,18)
self.progressValue=UIObject.get(self,19)
self.progressValueTxt=UIText.get(self,20)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.zhaoMuBtn:setButtonClick(function()self:onZhaoMuBtn()end)
self.speakObj={
self.speakObj_1,
self.speakObj_2,
}
self.speakText={
self.speakText_1,
self.speakText_2,
}



end


function UIHunQiTaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actorRoot);self.actorRoot=nil;
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.emojiRoot);self.emojiRoot=nil;
_UIObject_release(self.ghostRoot);self.ghostRoot=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.speakObj_1);self.speakObj_1=nil;
_UIObject_release(self.speakObj_2);self.speakObj_2=nil;
_UIObject_release(self.speakText_1);self.speakText_1=nil;
_UIObject_release(self.speakText_2);self.speakText_2=nil;
_UIObject_release(self.zhaoMuBtn);self.zhaoMuBtn=nil;
_UIObject_release(self.nowlhtxt);self.nowlhtxt=nil;
_UIObject_release(self.nextlhtxt);self.nextlhtxt=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.progressValueTxt);self.progressValueTxt=nil;
self.speakObj=nil;
self.speakText=nil;
end
















local this
local ghostPos={-195,-135,-68,0,65}




function UIHunQiTaiWin:onLoaded(...)
self:bindComponents()
self.btTable={}
this=self
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)

self.nextLHnum=0
self.nowLHnum=0
self.allLHnum=0
end


function UIHunQiTaiWin:__delete()
UIManager:hideWindow('UITopMoneyWin')
self:clearAllTree()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
this=nil
end

function UIHunQiTaiWin.on_money_changed(moneyType,lastVal,val)
if moneyType==eMoneyType.mtHunQiDan then

end
end

function UIHunQiTaiWin:onRuleBtn()
local tipslist=self.config.tipslist
local d={}
d.title='规则'
d.mode=3
d.name='UIHunQiTaiWin_rule_%d'
if tipslist then
local saijiid=xianjieController:getMoJieSaiJiID()
if saijiid and tipslist[saijiid]then
d.name=tipslist[saijiid]
end
end
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIHunQiTaiWin:onLevelUpBtn()
self:showWindow("UIXJBuildingInfoWin",self.bdData)
end

function UIHunQiTaiWin:onZhaoMuBtn()






if self.nowLHnum and self.nowLHnum>0 then
self:showWindow("UIHunQiTaiHYWin")
else
UIManager.info("暂无可还阳的修士")
end
end





function UIHunQiTaiWin:onShow(argtable,afterOnloaded)
local guid=argtable.entityId
self.bdData=zongmenModel:findBuildingByEntityId(guid)
UIManager:callWindowFunc('UIXianJieBottomMaskWin','showModel',5671,{0,-33})

local cfg=moneyModel.getMoneyConfig(eMoneyType.mtLunHuiDian)
self.lunhuiMax=cfg.autoincr and cfg.autoincr[5]or 0
self.hunpoMax=cfg.soul_limit

self.config=cfg_lunhuidianhunqitaiconfig_get(1)
self.save_limit=self.config.save_limit








self:freshGhostNum()
self:showGhostAi()

local isfirst=LunHuiDianModel:firstHQTReddot()
if isfirst then
userActorSetting.set('HQTOpen',false)
userActorSetting.flush()
reddotControl.on_change_catch_type(CATCH_TYPE.eHunQiTai)
end
end


function UIHunQiTaiWin:onHide()

end

function UIHunQiTaiWin:onShowArgRecv(argtable,afterOnloaded)
UIManager:callWindowFunc('UIXianJieBottomMaskWin','showModel',5671,{0,-33})
end


function UIHunQiTaiWin:freshGhostNum()
self.nextLHdata=LunHuiDianModel:getHQTNextLHnum()
self.nowLHdata=LunHuiDianModel:getHQTNowLHnum()

local nextnum=0
if self.nextLHdata then
for k,v in pairs(self.nextLHdata)do
local num=v.param_2 and tonumber(tostring(v.param_2))or 0
nextnum=nextnum+num
end
end
self.nextLHnum=nextnum


local nownum=0
if self.nowLHdata then
for k,v in pairs(self.nowLHdata)do
local num=v.param_2 and tonumber(tostring(v.param_2))or 0
nownum=nownum+num
end
end
self.nowLHnum=nownum
self.allLHnum=nextnum+nownum


self.nextlhtxt:setText(nextnum)

self.nowlhtxt:setText(nownum)
if self.save_limit>self.allLHnum then
self.progressValueTxt:setText(FMT.fmt('{0}/{1}',self.allLHnum,self.save_limit))
self.winlua:SetChildUIProgressbar(self.progressbar:getID(),self.allLHnum,self.save_limit,false)
else
self.progressValueTxt:setText(FMT.fmt('{0}/{1}',self.save_limit,self.save_limit))
self.winlua:SetChildUIProgressbar(self.progressbar:getID(),1,1,false)
end
end


function UIHunQiTaiWin:showGhostAi()
self:refreshGhost()
end
function UIHunQiTaiWin:refreshGhost()
local ghostCount=self.config.ghostCount
local allnum=self.allLHnum
local save_limit=self.save_limit
local present=math.floor((allnum/save_limit)*100)
local count=0
for k,v in pairs(ghostCount)do
if v then
if present>=v[1]then
count=v[2]
end
end
end

if count>5 then count=5 end

local gost=self.config.ghostId
if count>0 then
for i=1,count do
local index=math.random(1,2)
local Id=gost[index]
self:createGhost(Id,i-1)
end
end
end

function UIHunQiTaiWin:createGhost(Id,index)
local speak_rate=self.config.speak_rate or 0
local speak_time=self.config.speak_time or 3
local scale=1
local pos={0,0}
local widget=self.modelRoot:getWidgetBase()
local tran=widget:GetChildGameObject(index).transform
local initData=
{
index=index,
targetPos={},
winName='UIHunQiTaiWin',

sepaktime=speak_time,
speakrate=speak_rate,
speakHUDParent=0,
offset={0,100}
}
local otherData={scale=scale,}
uiAIManager:createUIObject('UIHunQiTaiWin','bt_ui_hunqitai_ghost',INSTANCE_TYPE.eUIDModel,Id,tran,pos,initData,otherData,
function(bt)
table.insert(self.btTable,bt)
end)
end

function UIHunQiTaiWin:setFade(value,index)
local widget=self.modelRoot:getWidgetBase()
widget:SetChildCanvasGroupDOFade(index,value,1)
end

function UIHunQiTaiWin:ghostEmoji(value,cb)
local emojiText="quad-ani=10-quad"
if value==1 then
local pro=4
local val=math.random(1,10)
if val<=pro then
this.emojiRoot:setChildCanvasGroupDOFade(value,1,cb)
end
else
this.emojiRoot:setChildCanvasGroupDOFade(value,1,cb)
end
end

function UIHunQiTaiWin:getCatSpeakText(bt,tkey,ttype)
local config=cfg_lunhuidianhunqitaiconfig_get(1)
local speak_rate=config.speak_rate or 0
local stand=math.random(0,1)
if speak_rate<stand then
local speakArr=config.speakArr or{"祖师请看看我","我还能再战斗"}
if speakArr then
bt:setSharedVar(tkey,speakArr[math.random(1,#speakArr)])
end
end
end



function UIHunQiTaiWin:clearAllTree()
if this.btTable then
for k,v in ipairs(this.btTable)do
if v then
uiAIManager:removeUIInstance(v)
end
end
end
end

function UIHunQiTaiWin:clearAllModel()
LunHuiDianController:showPrize()
self.isZhaoMu=false
this.actorRoot:setChildUIModelRemoveTarget()
this.ghostRoot:setChildUIModelRemoveTarget()

end


function UIHunQiTaiWin:createMengPo()
local scale=1.5
local pos={0,0}
local tran=self.actorRoot:getGameObject().transform

local initData=
{
winName='UIHunQiTaiWin',
offset={-20,185},
speakTime=5,
speakHUDParent=0,
probability=self.probability or 0.4,
}
local otherData={scale=scale,}

uiAIManager:createUIObject('UIHunQiTaiWin','bt_ui_lunhuidian_mp',INSTANCE_TYPE.eUIDModel,1124103,tran,pos,initData,otherData,
function(bt)
table.insert(self.btTable,bt)
end)
end

function UIHunQiTaiWin:initTalkCfg(cfg)
if cfg then
self.ghostTalk=cfg.ghostTalk
cfg=cfg.mpTalk
self.probability=cfg[1]
self.hunPoTalk=cfg[2]
self.hunPoHaveTalk=cfg[3]
self.zhaoHunTalk=cfg[4]
end
end
function UIHunQiTaiWin:getSpeakText(bt,tkey)
local speakList
local count=itemsModel.getCount(eMoneyType.mtHunPo)

if count>0 then
speakList=self.hunPoHaveTalk
else
speakList=self.hunPoTalk
end

local speakStr=speakList[math.random(1,#speakList)]
bt:setSharedVar(tkey,speakStr)
end

function UIHunQiTaiWin:playZhaoMuAnim()
self.isZhaoMu=true
this:clearAllTree()

this.actorRoot:setChildUIModelShowTarget(1124103,1.17,{},eAnimationID.stand)
this.actorRoot:setChildUIModelShowFlipX(true)
local cb=function()
local call=function()

this:doSpeaking(1)
this:doSpeaking(2)
this.actorRoot:setChildModelAnimationState(2916)
this:delayDo(3,function()
this.ghostRoot:setChildModelAnimationState(2915)
this:delayDo(3,function()
this:clearAllModel()
this:refreshGhost()
this:createMengPo()
this.zhaoMuBtn:setActive(true)
this.zhaoMuBtn:setChildCanvasGroupDOFade(1,1)
this.moneyRoot:setChildCanvasGroupDOFade(1,1)
end)
end)




end
this.ghostRoot:setChildModelAnimationState(eAnimationID.enter,1,call)
end
this.ghostRoot:setChildUIModelShowTarget(5806,1,{},eAnimationID.stand,false,false,-1,cb)
this.moneyRoot:setChildCanvasGroupDOFade(0,1)
this.zhaoMuBtn:setChildCanvasGroupDOFade(0,1,function()this.zhaoMuBtn:setActive(false)end)
end

function UIHunQiTaiWin:doSpeaking(index)
local speakStr
local speed=30
local len=#this.zhaoHunTalk
local key=math.random(1,len)
speakStr=this.zhaoHunTalk[key]

if index==2 then
local pro=4
local val=math.random(1,10)
if val>pro then
return
end

local i=math.random(1,5)
local pos=ghostPos[i]
self.winlua:SetChildLocalPosX(self.speakObj_2:getID(),pos)

len=#this.ghostTalk
key=math.random(1,len)
speakStr=this.ghostTalk[key]
end

if speakStr then
this.speakObj[index]:setChildCanvasGroupAlpha(1)
this.speakText[index]:setChildTrendsTextPlay(speakStr,speed,nil)
this:doTalkAnim(index)
end
end
function UIHunQiTaiWin:doTalkAnim(index)
if this.talkTween and this.talkTween[index]then
this.talkTween[index]:Kill()
this.talkTween[index]=nil

elseif not this.talkTween then
this.talkTween={}
end

this.winlua:SetChildScale(this.speakObj[index]:getID(),Vector3.zero)

if not this.doTalk then this.doTalk={}end
this.doTalk[index]=this:delayDo(0.2,function()
this.speakObj[index]:setChildCanvasGroupAlpha(1)
this.talkTween[index]=this.speakObj[index]:setChildDOScaleY(1.2,0.2,function()
if this==nil then return end
this.talkTween[index]=nil
this.talkTween[index]=this.speakObj[index]:setChildDOScale(0.8,0.1,function()
if this==nil then return end
this.talkTween[index]=nil
return this:talkEnd(index)
end)
end)
end)
end
function UIHunQiTaiWin:talkEnd(index)
if this.speakShowTimer and this.speakShowTimer[index]then
this:stopTimerByID(this.speakShowTimer[index])
this.speakShowTimer[index]=nil
elseif not this.speakShowTimer then
this.speakShowTimer={}
end

this.speakShowTimer[index]=this:delayDo(2.5,function()

if this==nil then return end
this.winlua:SetChildScale(this.speakObj[index]:getID(),Vector3.zero)
this.speakObj[index]:setChildCanvasGroupAlpha(0)

if this.speakShowTimer[index]then
this:stopTimerByID(this.speakShowTimer[index])
this.speakShowTimer[index]=nil
end
end)
end




