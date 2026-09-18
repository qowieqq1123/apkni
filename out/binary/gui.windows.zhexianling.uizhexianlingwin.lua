







def_class("UIZheXianLingWin",UIWindowBase)









function UIZheXianLingWin:bindComponents()

self.root=UIObject.get(self,0)
self.btnJiYuan=UIButton.get(self,1)
self.btnDaoTu=UIButton.get(self,2)
self.btnZJ=UIButton.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.noselectJiYuan=UIObject.get(self,5)
self.selectJiYuan=UIObject.get(self,6)
self.txtJiYuan=UIText.get(self,7)
self.reddotJiYuan=UIObject.get(self,8)
self.jiyuanLock=UIObject.get(self,9)
self.noselectDaoTu=UIObject.get(self,10)
self.selectDaoTu=UIObject.get(self,11)
self.txtDaoTu=UIText.get(self,12)
self.reddotDaoTu=UIObject.get(self,13)
self.reddotZj=UIObject.get(self,14)
self.txtZJ=UIText.get(self,15)
self.selectZJ=UIObject.get(self,16)
self.noselectZJ=UIObject.get(self,17)
self.buffBtn=UIButton.get(self,18)
self.effect1=UIObject.get(self,19)
self.effect2=UIObject.get(self,20)
self.tipsBuffRoot=UIButton.get(self,21)
self.lingpaModel=UIObject.get(self,22)
self.buffRoot=UIObject.get(self,23)
self.sceneAni=UIObject.get(self,24)
self.node=UIObject.get(self,25)
self.effect=UIObject.get(self,26)
self.effect3=UIObject.get(self,27)
self.leftPoint=UIObject.get(self,28)
self.rightPoint=UIObject.get(self,29)
self.midPoint=UIObject.get(self,30)
self.tipsBuffTxt=UIText.get(self,31)

self.btnJiYuan:setButtonClick(function()self:onBtnJiYuan()end)

self.btnDaoTu:setButtonClick(function()self:onBtnDaoTu()end)

self.btnZJ:setButtonClick(function()self:onBtnZJ()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.buffBtn:setButtonClick(function()self:onBuffBtn()end)

self.tipsBuffRoot:setButtonClick(function()self:onTipsBuffRoot()end)



end


function UIZheXianLingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.btnJiYuan);self.btnJiYuan=nil;
_UIObject_release(self.btnDaoTu);self.btnDaoTu=nil;
_UIObject_release(self.btnZJ);self.btnZJ=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.noselectJiYuan);self.noselectJiYuan=nil;
_UIObject_release(self.selectJiYuan);self.selectJiYuan=nil;
_UIObject_release(self.txtJiYuan);self.txtJiYuan=nil;
_UIObject_release(self.reddotJiYuan);self.reddotJiYuan=nil;
_UIObject_release(self.jiyuanLock);self.jiyuanLock=nil;
_UIObject_release(self.noselectDaoTu);self.noselectDaoTu=nil;
_UIObject_release(self.selectDaoTu);self.selectDaoTu=nil;
_UIObject_release(self.txtDaoTu);self.txtDaoTu=nil;
_UIObject_release(self.reddotDaoTu);self.reddotDaoTu=nil;
_UIObject_release(self.reddotZj);self.reddotZj=nil;
_UIObject_release(self.txtZJ);self.txtZJ=nil;
_UIObject_release(self.selectZJ);self.selectZJ=nil;
_UIObject_release(self.noselectZJ);self.noselectZJ=nil;
_UIObject_release(self.buffBtn);self.buffBtn=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.tipsBuffRoot);self.tipsBuffRoot=nil;
_UIObject_release(self.lingpaModel);self.lingpaModel=nil;
_UIObject_release(self.buffRoot);self.buffRoot=nil;
_UIObject_release(self.sceneAni);self.sceneAni=nil;
_UIObject_release(self.node);self.node=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.leftPoint);self.leftPoint=nil;
_UIObject_release(self.rightPoint);self.rightPoint=nil;
_UIObject_release(self.midPoint);self.midPoint=nil;
_UIObject_release(self.tipsBuffTxt);self.tipsBuffTxt=nil;
end

















local _winType=UIFullZheXianControl.winType
local _winNames=
{
[_winType.eZhangJie]='UIZheXianLingZJWin',
[_winType.eDaoTu]='UIZheXianLingDaoTuWin',
[_winType.eJiYuan]='UIZheXianLingJiYuanWin',
}

function UIZheXianLingWin:onLoaded(...)
self:bindComponents()
self.defaultWinType=_winType.eZhangJie
self.windows={}
self:freshAllReddot()
self._onSystemOpen=function(...)
self:onSystemOpen(...)
end
notifySystem:listenNotify(notifyConfig.on_system_open,self._onSystemOpen)
self.winlua:SetChildActive(self.lingpaModel:getID(),false)
end

function UIZheXianLingWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_system_open,self._onSystemOpen)
end

function UIZheXianLingWin:onShow(argtable,afterOnloaded)

local flag=true
if flag then
local winType=self.defaultWinType
if argtable.winType then
winType=argtable.winType
end
self:onSelectTab(winType)
self.node:setActive(true)
else
self.isFly=true
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZheXianLingAni,true)
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
self.winlua:SetChildAnimatorInteger(self.sceneAni:getID(),'id',1,true)
local func1=function()
if self and not self.isClose then
self.winlua:SetChildActive(self.lingpaModel:getID(),true)
self.winlua:SetChildSpineAnimation(self.lingpaModel:getID(),2040,1,nil)
end
end

self:delayDo(0.6,func1)
local func2=function()
if self and not self.isClose then
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.3)
self.node:setActive(true)
end
end
self:delayDo(2,func2)

local func3=function()
if self and not self.isClose then
self.winlua:SetChildShowEffect(self.effect3:getID(),10151,true)
self.winlua:SetChildShowEffect(self.effect:getID(),10150,true)

end
end
self:delayDo(1.5,func3)
end
end

function UIZheXianLingWin:onShowArgRecv(argtable)
local winType=self.defaultWinType
if argtable.winType then
winType=argtable.winType
end
self:onSelectTab(winType)
end

function UIZheXianLingWin:onHide()

end


function UIZheXianLingWin:onSelectTab(idx)
if idx==_winType.eJiYuan and not systemModel.isOpen(SYSTEM_DEFINE.eZxlJiYuan)then
idx=_winType.eZhangJie
elseif idx==_winType.eZhangJie and zheXianLingModel:isShowChapterLock()then
idx=_winType.eJiYuan
end
if idx==self.winType then return end
if self.tweener then
self.tweener:Kill()
end
self.tweener=nil
local lastIdx=self.winType
self.winType=idx
self:openWindow({lastIdx=lastIdx})
local isZJ=idx==_winType.eZhangJie
local isDaoTu=idx==_winType.eDaoTu
local isJiYuan=idx==_winType.eJiYuan

self.selectZJ:setActive(isZJ)
self.selectDaoTu:setActive(isDaoTu)
self.selectJiYuan:setActive(isJiYuan)

self.noselectZJ:setActive(not isZJ)
self.noselectDaoTu:setActive(not isDaoTu)
self.noselectJiYuan:setActive(not isJiYuan)
self:freshAllReddot()


self.lingpaModel:setActive(true)
if self.visTimer then
self:stopTimerByID(self.visTimer)
end
if self.daotuExitTimer then
self:stopTimerByID(self.daotuExitTimer)
end
self.visTimer=nil
self.daotuExitTimer=nil

local node=isZJ and self.leftPoint or isDaoTu and self.rightPoint or self.midPoint
local delayDis=isDaoTu and 1.2 or 0
local ani=not isJiYuan and 2 or 2018

self.winlua:SetChildSpineAnimation(self.lingpaModel:getID(),ani,1,nil)

self.winlua:SetChildShowEffect(self.effect:getID(),10151,true)
self.isFly=false


local nodeIdx=node:getID()
local pos=self.winlua:GetChildPosition(nodeIdx)
local scale=self.winlua:GetChildScale(nodeIdx)
local lastScale=self.scale or 1
local changeScale=scale.x~=self.scale
self.scale=scale.x
local func=function()
local tweener=self.winlua:SetChildDOMove(self.lingpaModel:getID(),pos,1)
self.tweener=tweener
tweener:SetEase(_Ease.OutExpo)
tweener:OnComplete(function()



self.tweener=nil
end)
if changeScale then
self.winlua:SetChildDOScale(self.lingpaModel:getID(),scale.x,1)
end
if delayDis and delayDis>0 then







end
end
if lastIdx==_winType.eDaoTu then
self.daotuExitTimer=self:delayDo(0.5,func)
else
func()
end

self:freshBuff()
end

function UIZheXianLingWin:openWindow(args)
local name=_winNames[self.winType]
local has=false
for _name,vis in pairs(self.windows)do
if _name~=name then
if vis==true then
self:hideWindow(_name)
self.windows[_name]=false
end
elseif _name==name then
has=true
if vis==false then
self:showWindow(_name,args)
self.windows[_name]=true
end
end
end
if not has then
self:showWindow(name,args)
self.windows[name]=true
end
end

function UIZheXianLingWin:freshAllReddot()
self:freshZXLReddot()
self:freshJiYuanReddot()
end

function UIZheXianLingWin:freshZXLReddot()
local isWait=zheXianLingController:isWaitNextOpen()
local hasAnyTaskPrize=zheXianLingModel:isAnyTaskCanPrizeByCurrentChapter()
local isChapterFinishStatus=zheXianLingModel:isFinishCurrentChapter()
local isBookFinishStatus=zheXianLingModel:isFinishCurrentBook()
self.reddotZj:setActive(not isWait and(hasAnyTaskPrize or isChapterFinishStatus))
self.reddotDaoTu:setActive(isBookFinishStatus)
end

function UIZheXianLingWin:freshJiYuanReddot()
self.noselectJiYuan:setGray(not systemModel.isOpen(SYSTEM_DEFINE.eZxlJiYuan))
self.selectJiYuan:setGray(not systemModel.isOpen(SYSTEM_DEFINE.eZxlJiYuan))
self.jiyuanLock:setActive(not systemModel.isOpen(SYSTEM_DEFINE.eZxlJiYuan))
self.reddotJiYuan:setActive(systemModel.isOpen(SYSTEM_DEFINE.eZxlJiYuan)and
zheXianLingModel:hasJiYuanTimes()and
zheXianLingModel:hasJiYuanItems())
end

function UIZheXianLingWin:freshBuff()
local state=JiuChongTianJieEnterModel:getOpenTianJieSec()
local zmLevel=zongmenModel:getLevel()
local buffCfg=cfgHelper.get(cfg_jctjbaseconfig_get,1,"buff")
local buffid=buffCfg[zmLevel]
local showState=state>0 and buffid~=nil

self.buffRoot:setActive(showState)
self.buffId=buffid
if buffid then



local desc=""
local effects=cfgHelper.get2(cfg_guildstateconfig_get,buffid,'effects')
for kk,vv in pairs(effects)do
local str=cfgHelper.get2(cfg_guildstateeffectconfig_get,vv,'desc')
desc=FMT.fmt("{0}{1}",desc,str)
if kk<#effects then
desc=FMT.fmt("{0}{1}",desc,'\n')
end
end
self.tipsBuffTxt:setText(desc)
end
end




function UIZheXianLingWin:onBtnJiYuan()
if not systemModel.isOpen(SYSTEM_DEFINE.eZxlJiYuan)then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eZxlJiYuan)
UIManager.error(tips)
return
end
self:onSelectTab(_winType.eJiYuan)
end



function UIZheXianLingWin:onBtnDaoTu()
local isWait,desc=zheXianLingController:isWaitNextOpen(true)
if isWait then
UIManager.error(desc)
return
end
self:onSelectTab(_winType.eDaoTu)
end



function UIZheXianLingWin:onBtnZJ()
local isWait,desc=zheXianLingController:isWaitNextOpen()
if isWait then
UIManager.error(desc)
return
end
self:onSelectTab(_winType.eZhangJie)
end



function UIZheXianLingWin:onCloseBtn()
UIFullZheXianControl:closeUI()
end

function UIZheXianLingWin:onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eZxlJiYuan then
self:freshJiYuanReddot()
end
end

function UIZheXianLingWin:onBuffBtn()







self.tipsBuffRoot:setActive(true)
end

function UIZheXianLingWin:onTipsBuffRoot()
self.tipsBuffRoot:setActive(false)
end