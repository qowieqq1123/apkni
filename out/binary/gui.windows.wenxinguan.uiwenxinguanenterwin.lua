







def_class("UIWenXinGuanEnterWin",UIWindowBase)









function UIWenXinGuanEnterWin:bindComponents()

self.bg=UIObject.get(self,0)
self.choosebtn=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.effect=UIObject.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.modelRoot=UIObject.get(self,5)
self.openBtn=UIButton.get(self,6)
self.PanelRoot=UIObject.get(self,7)
self.replaceBtn=UIButton.get(self,8)
self.specialityBtn=UIButton.get(self,9)

self.choosebtn:setButtonClick(function()self:onChoosebtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.openBtn:setButtonClick(function()self:onOpenBtn()end)

self.replaceBtn:setButtonClick(function()self:onReplaceBtn()end)

self.specialityBtn:setButtonClick(function()self:onSpecialityBtn()end)



end


function UIWenXinGuanEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.choosebtn);self.choosebtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.openBtn);self.openBtn=nil;
_UIObject_release(self.PanelRoot);self.PanelRoot=nil;
_UIObject_release(self.replaceBtn);self.replaceBtn=nil;
_UIObject_release(self.specialityBtn);self.specialityBtn=nil;
end
















local this



function UIWenXinGuanEnterWin:onLoaded(...)
this=self
self:bindComponents()
self.config=cfg_wenxinguanbaseconfig_get(1)
end


function UIWenXinGuanEnterWin:__delete()
self:clearTime()
self:unbindComponents()
end




function UIWenXinGuanEnterWin:onShow(argtable,afterOnloaded)
if argtable.guid then
self.discipleGuid=argtable.guid
end

if argtable.return_jump_param then
self.closeBtn:setActive(false)
self.return_jump_param=argtable.return_jump_param
UIManager:showWindow("UIWenXinGuanTopWin",self.return_jump_param)
end

self:showDzModel()
UIManager:showWindow("UIWenXinGuanEnterBgWin")
self:refreshSwitchBtn()
self:showBgModel()
end


function UIWenXinGuanEnterWin:onHide()

end

function UIWenXinGuanEnterWin:refreshSwitchBtn()
local isCurr=false
local curID=WenXinGuanModel:getDtDzGuid()

if curID and self.discipleGuid and curID==self.discipleGuid then
isCurr=true
end







if not self.discipleGuid and not curID then
self.choosebtn:setActive(true)
else
self.choosebtn:setActive(false)
end
end

function UIWenXinGuanEnterWin:onDoFadeImg(value,duration)
local tweener=self.PanelRoot:setChildCanvasGroupDOFade(value,duration)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanEnterWin:loopStandAnim()
local animCb
animCb=function()
self:playStandAnim(2602,1,animCb)
end

self:playStandAnim(2602,1,animCb)
end

function UIWenXinGuanEnterWin:playStandAnim(animId,speed,cb)
if not this.clickOpenBtn then
this.bg:setChildModelAnimationState(animId,speed,cb)
else
self:waitForEnter()
end
end

function UIWenXinGuanEnterWin:showBgModel()
local value=1
local animId=eAnimationID.enter
local cb=function()
local callBack=function()
self:loopStandAnim()
end
this.bg:setChildModelAnimationState(animId,1,callBack)

self:delayDo(2,function()
self:onDoFadeImg(value,1)
end)
end

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bg:getID(),false,true,false)
self.bg:setChildUIModelShowTarget(5534,1,{},animId,false,false,
0,cb)
end

function UIWenXinGuanEnterWin:showDzModel(guid)
local initData={}
local guid=guid or self.discipleGuid

local curID=WenXinGuanModel:getDtDzGuid()
if not guid and curID then
guid=curID
self.discipleGuid=curID
end

local vpos=Vector2.New(0,-50)
local tran=self.modelRoot:getCommonComponent('Transform')

if guid then
uiAIManager:createUIDisciple('UIWenXinGuanEnterWin','bt_ui_idle',guid,tran,vpos,initData,{},function(bt)
self.currDz=bt
end)
end
end

function UIWenXinGuanEnterWin:replaceDzModel(guid)
if self.currDz then
uiAIManager:removeUIInstance(self.currDz)
self.currDz=nil
end
if guid then
self.discipleGuid=guid
self:showDzModel(guid)
end
end





function UIWenXinGuanEnterWin:onCloseBtn()
if self.return_jump_param then
jumpManager:jump(self.return_jump_param)
else
local startCallback=function()
if self.discipleGuid then
local guid=self.discipleGuid
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
UIManager:closeWindow('UIWenXinGuanEnterBgWin')
UIFullDiscipleMainControl:showWindowInfo({dis_guid=guid})
UIManager:showWindow('UIDiscipleJingJieWin',{guid=guid})
else
UIFullWenXinGuanControl:closeUI(true)
end
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end
end


function UIWenXinGuanEnterWin:onHelpBtn()
local str=self.config.infoDesc
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=str})
end

function UIWenXinGuanEnterWin:play()
local anim=eAnimationID.stand2
this.bg:setChildModelAnimationState(anim)
end

function UIWenXinGuanEnterWin:waitForEnter()
self:clearTime()


local curID=WenXinGuanModel:getDtDzGuid()

local state=WenXinGuanModel:checkDzWXGState(self.discipleGuid)

if curID and curID~=self.discipleGuid and not state then
local netData=UIDiscipleModel:getDiscipleData(curID)
local str=string.format("弟子%s正在经历问心关，需先完成弟子%s的问心关",netData.disciplename,netData.disciplename)
UIManager.info(str)
self.clickOpenBtn=false
return
end

local animId=2601
local winName="UIWenXinGuanMainWin"
winName=WenXinGuanModel:checkDzIsFinishWXG(self.discipleGuid)
if winName=="UIWenXinGuanEnterWin"then winName="UIWenXinGuanMainWin"end
UIManager:invokeUIMethod("UIWenXinGuanEnterBgWin","playEffect")

self:delayDo(1.8,function()
UIManager:showWindow(winName,{guid=self.discipleGuid,return_jump_param=self.return_jump_param,isFirstOpen=true})
self.clickOpenBtn=false


end)

self:onDoFadeImg(0,1)
UIManager:invokeUIMethod("UIWenXinGuanTopWin","onDoFade",0,1)
self.bg:setChildModelAnimationState(animId)
end


function UIWenXinGuanEnterWin:onOpenBtn()
if self.clickOpenBtn then return end

if self.discipleGuid then
local callback=function()
this.clickOpenBtn=true
this:addTime()
end
local curID=WenXinGuanModel:getDtDzGuid()
local netData=UIDiscipleModel:getDiscipleData(self.discipleGuid)
if not curID and systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie3)and not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
local str=string.format('九重天劫期间，参与问心关的弟子无法更换，是否选择%s弟子参与问心关？',netData.disciplename)
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
else
callback()
end
else
UIManager.info('请先选择参与问心的弟子')
end
end


function UIWenXinGuanEnterWin:onChoosebtn()
self:onReplaceBtn()
end

function UIWenXinGuanEnterWin:addTime()
local timeSpeed=Time.timeScale
while timeSpeed<5 do
timeSpeed=timeSpeed+0.1
self.winlua:SetChildUIModelAnimationSpeed(self.bg:getID(),timeSpeed)
end
end

function UIWenXinGuanEnterWin:clearTime()
self.winlua:SetChildUIModelAnimationSpeed(self.bg:getID(),1)
end


function UIWenXinGuanEnterWin:onReplaceBtn()
local args={
discipleGuid=self.discipleGuid,
openType=dzSelectWinOpenType.eWenXinGuanSelect,
filterTipDesc='提示：弟子完成红尘劫后才能参与问心',
emptyTipDesc='当前暂无完成红尘劫的弟子',
isNotShowSearchBox=true,
callback=function(dzId)
self:replaceDzModel(dzId)
self:refreshSwitchBtn()
UIManager:closeWindow('UICommonDragonBoneWin')
end
}
discipleSelectController:openDiscipleSelect(args)
end


function UIWenXinGuanEnterWin:onSpecialityBtn()
UIManager:showWindow("UIWenXinGuan_SpecialityPreviewWin",{guid=self.discipleGuid})
end

