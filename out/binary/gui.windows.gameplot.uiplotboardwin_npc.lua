







def_class("UIPlotBoardWin_npc",UIWindowBase)









function UIPlotBoardWin_npc:bindComponents()

self.bg1=UIObject.get(self,0)
self.bg2=UIObject.get(self,1)
self.blackbg=UIObject.get(self,2)
self.modelImage=UIObject.get(self,3)
self.modelObj=UIObject.get(self,4)
self.moveroot=UIObject.get(self,5)
self.name=UIImage.get(self,6)
self.parentsRoot=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.title=UIImage.get(self,9)



end


function UIPlotBoardWin_npc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg1);self.bg1=nil;
_UIObject_release(self.bg2);self.bg2=nil;
_UIObject_release(self.blackbg);self.blackbg=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.moveroot);self.moveroot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.parentsRoot);self.parentsRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
end


















local abname="ui/windows/gameplot/plotboard_npc_atlas_pak.ab"

function UIPlotBoardWin_npc:onLoaded(...)
self:bindComponents()
end

local bgcmp=
{
[1]={'image_xjnpcchuchangui_1','image_xjnpcchuchangui_2'},
[2]={'image_xjnpcchuchangui_3','image_xjnpcchuchangui_4'},
}


function UIPlotBoardWin_npc:__delete()
self:unbindComponents()
uiAIManager:removeUIInstance(self.btlistp)
end




function UIPlotBoardWin_npc:onShow(argtable,afterOnloaded)

self.cfg=argtable[1]
self.npcID=argtable[2]
self.showNpcCfg=self.cfg.showNpc


























local endinpos=self.showNpcCfg[7][1]
local endinpos2=self.showNpcCfg[8][1]
local initData=
{
endinpos=endinpos,
begintime=self.showNpcCfg[7][2],
durtime=self.showNpcCfg[7][3]-self.showNpcCfg[7][2],
ease=DG.Tweening.Ease.OutExpo,
endinpos2=endinpos2,
begintime2=self.showNpcCfg[8][2],
durtime2=self.showNpcCfg[8][3]-self.showNpcCfg[8][2],
ease2=DG.Tweening.Ease.InOutExpo,
endfade=self.showNpcCfg[9][1],
fadebegintime=self.showNpcCfg[9][2],
fadedurtimetime=self.showNpcCfg[9][3]-self.showNpcCfg[9][2],
}

local otherData=
{

}
local func=function(bt)
self.btlistp=bt
end
local beginpos=self.showNpcCfg[6]
local tran=self.parentsRoot:getCommonComponent('Transform')
local vpos=Vector2.New(beginpos[1],beginpos[2])
uiAIManager:createEmptyObject('UIPlotBoardWin_npc','bt_ui_NPCShow',INSTANCE_TYPE.eUIimage_NPC,tran,vpos,initData,otherData,func)
self:setRemainingTimeTimer()
if self.showNpcCfg[11]then
self.bg1:setCSImageSprite(abname,bgcmp[self.showNpcCfg[11]][1])
self.bg2:setCSImageSprite(abname,bgcmp[self.showNpcCfg[11]][2])
end

end

function UIPlotBoardWin_npc:setRemainingTimeTimer()

self.nowtime=0
local func=function()
self.nowtime=self.nowtime+1
if self.showNpcCfg[10]then
if self.nowtime>=self.showNpcCfg[10]then
self:onBackClick()
end
end

end

self.timer=self:setTimer(1,0,func)
end

function UIPlotBoardWin_npc:onHide()

end


function UIPlotBoardWin_npc:Setmove(widget,endinpos,durtime,ease)
local dotween=widget:SetChildDOAnchorPos(0,Vector2.New(endinpos[1],endinpos[2]),durtime,function()

end)


dotween:SetEase(ease)
end


function UIPlotBoardWin_npc:onBackClick()
UIManager:invokeUIMethod('UIPlotBoardWin','showRootCanvasGroup',1,0)
self:closeSelf()
end




local imageindex=
{
modelobj=1,
modelimage=2,
name=3,
title=4,
}

function UIPlotBoardWin_npc:SetImage(widget)
widget:SetChildCSImageSprite(imageindex.title,abname,self.showNpcCfg[1])
widget:SetChildCSImageSprite(imageindex.name,abname,self.showNpcCfg[2])

widget:SetChildLocalPos(imageindex.title,self.showNpcCfg[3][1],self.showNpcCfg[3][2],0)
widget:SetChildLocalPos(imageindex.name,self.showNpcCfg[4][1],self.showNpcCfg[4][2],0)
widget:SetChildLocalPos(imageindex.modelobj,self.showNpcCfg[5][1],self.showNpcCfg[5][2],0)
local image=npcModel:getImageInfo(self.npcID)

if image then
local bodyid=image.body
local components=image.componets
local scale=1
local actionid=0
local fadeTime=0
widget:SetChildUIModelShowTarget(imageindex.modelimage,bodyid,scale,components,actionid,false,false,fadeTime)
end
end
