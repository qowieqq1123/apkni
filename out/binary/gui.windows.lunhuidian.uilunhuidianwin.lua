







def_class("UILunHuiDianWin",UIWindowBase)









function UILunHuiDianWin:bindComponents()

self.actorRoot=UIObject.get(self,0)
self.animRoot=UIObject.get(self,1)
self.bdLevel=UIText.get(self,2)
self.emojiRoot=UIObject.get(self,3)
self.ghostRoot=UIObject.get(self,4)
self.hunPoBg=UIObject.get(self,5)
self.hunPoFill=UIObject.get(self,6)
self.hunPoPreText=UIText.get(self,7)
self.hunPoText=UIText.get(self,8)
self.levelUpBtn=UIButton.get(self,9)
self.levelUpBtnText=UIText.get(self,10)
self.lunHuiBg=UIObject.get(self,11)
self.lunHuiFill=UIObject.get(self,12)
self.lunHuiPreText=UIText.get(self,13)
self.lunHuiText=UIText.get(self,14)
self.mbg=UIObject.get(self,15)
self.modelRoot=UIObject.get(self,16)
self.moneyRoot=UIObject.get(self,17)
self.mZhuZi=UIObject.get(self,18)
self.root=UIObject.get(self,19)
self.ruleBtn=UIButton.get(self,20)
self.ruleList=UIObject.get(self,21)
self.ruleMask=UIButton.get(self,22)
self.rulePart=UIObject.get(self,23)
self.speakObj_1=UIObject.get(self,24)
self.speakObj_2=UIObject.get(self,25)
self.speakText_1=UIText.get(self,26)
self.speakText_2=UIText.get(self,27)
self.zhaoMuBtn=UIButton.get(self,28)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.ruleMask:setButtonClick(function()self:onRuleMask()end)

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


function UILunHuiDianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actorRoot);self.actorRoot=nil;
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.emojiRoot);self.emojiRoot=nil;
_UIObject_release(self.ghostRoot);self.ghostRoot=nil;
_UIObject_release(self.hunPoBg);self.hunPoBg=nil;
_UIObject_release(self.hunPoFill);self.hunPoFill=nil;
_UIObject_release(self.hunPoPreText);self.hunPoPreText=nil;
_UIObject_release(self.hunPoText);self.hunPoText=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.lunHuiBg);self.lunHuiBg=nil;
_UIObject_release(self.lunHuiFill);self.lunHuiFill=nil;
_UIObject_release(self.lunHuiPreText);self.lunHuiPreText=nil;
_UIObject_release(self.lunHuiText);self.lunHuiText=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.mZhuZi);self.mZhuZi=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.ruleList);self.ruleList=nil;
_UIObject_release(self.ruleMask);self.ruleMask=nil;
_UIObject_release(self.rulePart);self.rulePart=nil;
_UIObject_release(self.speakObj_1);self.speakObj_1=nil;
_UIObject_release(self.speakObj_2);self.speakObj_2=nil;
_UIObject_release(self.speakText_1);self.speakText_1=nil;
_UIObject_release(self.speakText_2);self.speakText_2=nil;
_UIObject_release(self.zhaoMuBtn);self.zhaoMuBtn=nil;
self.speakObj=nil;
self.speakText=nil;
end
















local this
local ghostPos={-195,-135,-68,0,65}




function UILunHuiDianWin:onLoaded(...)
self:bindComponents()
self.btTable={}
this=self
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UILunHuiDianWin:__delete()
UIManager:hideWindow('UITopMoneyWin')
self:clearAllTree()

this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end




function UILunHuiDianWin:onShow(argtable,afterOnloaded)
local guid=argtable.entityId
self.bdData=zongmenModel:findBuildingByEntityId(guid)
UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtHunPo},{eMoneyType.mtLunHuiDian}})

local cfg=moneyModel.getMoneyConfig(eMoneyType.mtLunHuiDian)
self.lunhuiMax=cfg.autoincr and cfg.autoincr[5]or 0

cfg=cfg_lunhuidianconfig_get(1)
self.hunpoMax=cfg.soul_limit

self:initTalkCfg(cfg)
self:refreshMoney()
self:refreshGhost()
self:createMengPo()
end


function UILunHuiDianWin:onHide()


end


function UILunHuiDianWin:refreshMoneyPos(hunpoFill,lunhuiFill)
local pos=-193
local len=97.5

local hunpoPos=len*hunpoFill+pos
local lunhuiPos=len*lunhuiFill+pos

self.winlua:SetChildLocalPosY(self.hunPoBg:getID(),hunpoPos)
self.winlua:SetChildLocalPosY(self.lunHuiBg:getID(),lunhuiPos)
end

function UILunHuiDianWin:refreshMoney()
local hunpoNum=moneyModel.getMoney(eMoneyType.mtHunPo)
local hunpoName=moneyModel.getMoneyName(eMoneyType.mtHunPo)
local lunhuiNum=moneyModel.getMoney(eMoneyType.mtLunHuiDian)
local lunhuiName=moneyModel.getMoneyName(eMoneyType.mtLunHuiDian)

local hunpoFill=hunpoNum/self.hunpoMax
local lunhuiFill=lunhuiNum/self.lunhuiMax

if hunpoFill>1 then hunpoFill=1 end
if lunhuiFill>1 then lunhuiFill=1 end

self.hunPoFill:setChildIconFillAmount(hunpoFill)
self.lunHuiFill:setChildIconFillAmount(lunhuiFill)

self.winlua:SetChildText(self.hunPoText:getID(),string.format("%s:%s",hunpoName,hunpoNum))
self.winlua:SetChildText(self.lunHuiText:getID(),string.format("%s:%s",lunhuiName,lunhuiNum))
self.winlua:SetChildText(self.hunPoPreText:getID(),string.format("%s%%",mathHelper.decimal(hunpoFill*100,1)))
self.winlua:SetChildText(self.lunHuiPreText:getID(),string.format("%s%%",mathHelper.decimal(lunhuiFill*100,1)))

self:refreshMoneyPos(hunpoFill,lunhuiFill)
end

function UILunHuiDianWin.on_money_changed(moneyType,lastVal,val)
if moneyType==eMoneyType.mtLunHuiDian or moneyType==eMoneyType.mtHunPo then
this:refreshMoney()
end
end


function UILunHuiDianWin:setFade(value,index)
local widget=self.modelRoot:getWidgetBase()
widget:SetChildCanvasGroupDOFade(index,value,1)
end

function UILunHuiDianWin:refreshGhost()
local count=0
local num=itemsModel.getCount(eMoneyType.mtHunPo)
local present=math.floor((num/self.hunpoMax)*100)

local cfg=cfg_lunhuidianconfig_get(1)
local gost=cfg.ghostId
cfg=cfg.ghostCount

if cfg then
for k,v in pairs(cfg)do
if v then
if present>=v[1]then
count=v[2]
end
end
end
end

if count>0 then
for i=1,count do
local index=math.random(1,2)
local Id=gost[index]
self:createGhost(Id,i-1)
end
end
end

function UILunHuiDianWin:createGhost(Id,index)
local scale=1
local pos={0,0}
local widget=self.modelRoot:getWidgetBase()
local tran=widget:GetChildGameObject(index).transform

local initData=
{
index=index,
targetPos={},
winName='UILunHuiDianWin',
}
local otherData={scale=scale,}

uiAIManager:createUIObject('UILunHuiDianWin','bt_ui_lunhuidian_ghost',INSTANCE_TYPE.eUIDModel,Id,tran,pos,initData,otherData,
function(bt)
table.insert(self.btTable,bt)
end)
end


function UILunHuiDianWin:clearAllTree()
if this.btTable then
for k,v in ipairs(this.btTable)do
if v then
uiAIManager:removeUIInstance(v)
end
end
end
end

function UILunHuiDianWin:clearAllModel()
LunHuiDianController:showPrize()
self.isZhaoMu=false
this.actorRoot:setChildUIModelRemoveTarget()
this.ghostRoot:setChildUIModelRemoveTarget()

end


function UILunHuiDianWin:createMengPo()
local scale=1.5
local pos={0,0}
local tran=self.actorRoot:getGameObject().transform

local initData=
{
winName='UILunHuiDianWin',
offset={-20,185},
speakTime=5,
speakHUDParent=0,
probability=self.probability or 0.4,
}
local otherData={scale=scale,}

uiAIManager:createUIObject('UILunHuiDianWin','bt_ui_lunhuidian_mp',INSTANCE_TYPE.eUIDModel,1124103,tran,pos,initData,otherData,
function(bt)
table.insert(self.btTable,bt)
end)
end


function UILunHuiDianWin:initTalkCfg(cfg)
if cfg then
self.ghostTalk=cfg.ghostTalk
cfg=cfg.mpTalk
self.probability=cfg[1]
self.hunPoTalk=cfg[2]
self.hunPoHaveTalk=cfg[3]
self.zhaoHunTalk=cfg[4]
end
end

function UILunHuiDianWin:getSpeakText(bt,tkey)
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


function UILunHuiDianWin:playZhaoMuAnim()
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


function UILunHuiDianWin:doSpeaking(index)
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

function UILunHuiDianWin:doTalkAnim(index)
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

function UILunHuiDianWin:talkEnd(index)
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


function UILunHuiDianWin:ghostEmoji(value,cb)
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

function UILunHuiDianWin:refreshRulePart(ruleName)
local hunpoNum=moneyModel.getMoney(eMoneyType.mtHunPo)
local lunhuiNum=moneyModel.getMoney(eMoneyType.mtLunHuiDian)
local ccdNum=moneyAutoIncreaseModel:ccdNum(eMoneyType.mtLunHuiDian)
local autoCfg=cfgHelper.get2(cfg_moneyconfig_get,eMoneyType.mtLunHuiDian,'autoincr')

if hunpoNum==0 then ccdNum=0 end

local str1=string.format('魂魄上限：%s/%s',hunpoNum,self.hunpoMax)
local str2=string.format('轮回点上限：%s/%s',lunhuiNum,self.lunhuiMax)
local str3=string.format('轮回点效率：%s/每时',ccdNum)

local desclist={str1,str2,str3}

for i=1,10 do
local str=cfgHelper.get1(cfg_lang_get,string.format(ruleName,i))
if str~=nil then
table.insert(desclist,str)
end
end

local descLen=#desclist
self.ruleList:setChildLayoutGroupCreateItems(descLen,function(index)
local item=self.ruleList:getChildLayoutGroupGridItem(index-1)
local desc=desclist[index]
item:SetChildText(0,desc)
end)
end




function UILunHuiDianWin:onLevelUpBtn()
self:showWindow("UIXJBuildingInfoWin",self.bdData)
end


function UILunHuiDianWin:onZhaoMuBtn()
UIManager:showWindow("UILHDZhaoMuWin",self.bdData)
end

function UILunHuiDianWin:onRuleBtn()
local ruleName="ui_lunhuidian_help_%d"
self:refreshRulePart(ruleName)
self.rulePart:setActive(true)
self.ruleMask:setActive(true)
end

function UILunHuiDianWin:onRuleMask()
self.rulePart:setActive(false)
self.ruleMask:setActive(false)
end