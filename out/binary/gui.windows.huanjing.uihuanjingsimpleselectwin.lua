







def_class("UIHuanJingSimpleSelectWin",UIWindowBase)









function UIHuanJingSimpleSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.btnsRoot=UIObject.get(self,1)
self.shiLianBtn=UIButton.get(self,2)
self.tiaoZhanBtn=UIButton.get(self,3)
self.jinDiBtn=UIButton.get(self,4)
self.zhenlingBtn=UIButton.get(self,5)

self.shiLianBtn:setButtonClick(function()self:onShiLianBtn()end)

self.tiaoZhanBtn:setButtonClick(function()self:onTiaoZhanBtn()end)

self.jinDiBtn:setButtonClick(function()self:onJinDiBtn()end)

self.zhenlingBtn:setButtonClick(function()self:onZhenlingBtn()end)



end


function UIHuanJingSimpleSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.btnsRoot);self.btnsRoot=nil;
_UIObject_release(self.shiLianBtn);self.shiLianBtn=nil;
_UIObject_release(self.tiaoZhanBtn);self.tiaoZhanBtn=nil;
_UIObject_release(self.jinDiBtn);self.jinDiBtn=nil;
_UIObject_release(self.zhenlingBtn);self.zhenlingBtn=nil;
end



















function UIHuanJingSimpleSelectWin:onLoaded(...)
self:bindComponents()

self.enterPos={0,-320}
self.leftPos={-205,-320}
self.rightPos={205,-320}

self.btns={
self.shiLianBtn,
self.tiaoZhanBtn,
self.jinDiBtn,
self.zhenlingBtn
}

self.datas={
[1]={
showDz=true,
name='后山试炼',
click=function()
UIHuanJingControl:showLiLianWindow()
return true
end,
reddot=function()
return UIHuanJingControl:isShowRewardReddot()
end,
},
[2]={
showDz=true,
name='每日挑战',
click=function()
UIHuanJingControl:showDayChallengeWindow()
return true
end,
reddot=function()
return UIHuanJingControl:isShowDayChallengeRewardReddot()
end,
},
[3]={
showDz=false,
name='后山禁地',
click=function()

if not self.isJDOpen then
local open=cfgHelper.get2(cfg_backmountainareabasicconfig_get,1,"open")
UIManager.error(FMT.fmt("通关{0}后开启",UIHuanJingControl:getLevelName("",open)))
return false
end
UIHuanJingControl:showJinDiWindow()
return true


end,
},
[4]={
showDz=false,
name='后山阵灵',
click=function()

if not self.isZLOpen then
local openstr=systemModel.getOpenTips(SYSTEM_DEFINE.eHouShanZhenLing)
UIManager.error(openstr)
return false
end
UIHuanJingControl:showZhenLingWindow()
return true
end,
reddot=function()
return UIHuanJingControl:isZhengLingReddot()
end,
},
}
end


function UIHuanJingSimpleSelectWin:__delete()
self:unbindComponents()

uiAIManager:clearUIWinData('UIHuanJingSimpleSelectWin')
end




function UIHuanJingSimpleSelectWin:onShow(argtable,afterOnloaded)
self:refresh(argtable)



local check=UIHuanJingControl:isDayChallengeOpen()
self.isDCOpen=check

self.tiaoZhanBtn:setChildGraphicGray(not check,true)

check=UIHuanJingControl:isJinDiFuncOpen()
self.isJDOpen=check
self.jinDiBtn:setChildGraphicGray(not check,true)

check=UIHuanJingControl:isZhenlingFuncOpen()
self.isZLOpen=check
self.zhenlingBtn:setChildGraphicGray(not check,true)

self:initAI()
end

function UIHuanJingSimpleSelectWin:isPlayingAnim()
local isPlaying=UIManager:callWindowFunc('UIHuanJingWin','getPlayingState')
return isPlaying
end

function UIHuanJingSimpleSelectWin:onShowArgRecv(argtable)
self:refresh(argtable)
end

function UIHuanJingSimpleSelectWin:refresh(argtable)
if argtable and argtable.index then
self.selectIndex=argtable.index
end

for i,v in ipairs(self.datas)do
local widget=self.btns[i]:getChildWidgetBase()
widget:SetChildActive(0,i==self.selectIndex)
widget:SetChildText(1,v.name)
widget:SetChildActive(2,v.reddot and v.reddot())
end
end


function UIHuanJingSimpleSelectWin:onHide()

end

function UIHuanJingSimpleSelectWin:initAI()
if self.isInitAI then
return
end
self.isInitAI=true

local dzData=UIDiscipleModel:getDiscipleByFightIndex(1)
self:createDZ(dzData.discipleguid,self.enterPos,function(bt)
self.currDZ=bt


end)
end

function UIHuanJingSimpleSelectWin:createDZ(dzId,pos,callback)

local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
uispeakrate=0.5,
uimoverate=0.5,
}
local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local otherData={
scale=0.9,
noRescueClick=true,
}
self.dzInst=uiAIManager:createUIDisciple('UIHuanJingSimpleSelectWin','bt_ui_huanjing',dzId,tran,vpos,initData,otherData,function(bt)
local dzModel=_InstantiateManager.GetComponent(self.dzInst,'CSGUIWidgetBase')
dzModel:SetChildActive(-1,self.datas[self.selectIndex].showDz)
callback(bt)
end)
end

function UIHuanJingSimpleSelectWin:getDZSpeakText(bt,tkey)
local speak_text=cfgHelper.get2(cfg_guanqianewbasicconfig_get,1,'speak_text')
local txt=speak_text[math.random(1,#speak_text)]
bt:setSharedVar(tkey,txt)
end

function UIHuanJingSimpleSelectWin:getMovePos(bt,pkey)
local px=self.rightPos[1]-self.leftPos[1]
local py=self.rightPos[2]-self.leftPos[2]
local rv=math.random()
local tp={self.leftPos[1]+px*rv,self.leftPos[2]+py*rv}
bt:setSharedVar(pkey,tp)
end



function UIHuanJingSimpleSelectWin:onShiLianBtn()
if self.selectIndex==1 then
return
end
if self:isPlayingAnim()then
return
end
if self.datas[1].click()then
local dzModel=_InstantiateManager.GetComponent(self.dzInst,'CSGUIWidgetBase')
dzModel:SetChildActive(-1,self.datas[1].showDz)
end
end

function UIHuanJingSimpleSelectWin:onTiaoZhanBtn()
if self.selectIndex==2 then
return
end
if self:isPlayingAnim()then
return
end
if not self.isDCOpen then
UIManager.error('通关4-5后开启')
return
end
if self.datas[2].click()then
local dzModel=_InstantiateManager.GetComponent(self.dzInst,'CSGUIWidgetBase')
dzModel:SetChildActive(-1,self.datas[2].showDz)
end
end

function UIHuanJingSimpleSelectWin:onJinDiBtn()
if self.selectIndex==3 then
return
end
if self:isPlayingAnim()then
return
end
if self.datas[3].click()then
local dzModel=_InstantiateManager.GetComponent(self.dzInst,'CSGUIWidgetBase')
dzModel:SetChildActive(-1,self.datas[3].showDz)
end
end

function UIHuanJingSimpleSelectWin:onZhenlingBtn()
if self.selectIndex==4 then
return
end
if self:isPlayingAnim()then
return
end
if self.datas[4].click()then
local dzModel=_InstantiateManager.GetComponent(self.dzInst,'CSGUIWidgetBase')
dzModel:SetChildActive(-1,self.datas[3].showDz)
end
end

