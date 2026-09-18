







def_class("UIXianZhanManagerWin",UIWindowBase)









function UIXianZhanManagerWin:bindComponents()

self.changeText=UIText.get(self,0)
self.desc=UIText.get(self,1)
self.tipsBtn=UIButton.get(self,2)
self.dzName=UIText.get(self,3)
self.shangdaodesc=UIText.get(self,4)
self.conghuidesc=UIText.get(self,5)
self.meilidesc=UIText.get(self,6)
self.dizi=UIObject.get(self,7)
self.changeBtn=UIButton.get(self,8)
self.dzInfo=UIObject.get(self,9)
self.notDiZi=UIText.get(self,10)
self.descImg=UIObject.get(self,11)
self.infoPanel=UIButton.get(self,12)
self.closeBtn=UIButton.get(self,13)
self.sdLevel=UIText.get(self,14)
self.conghui=UIText.get(self,15)
self.meili=UIText.get(self,16)
self.bottomPanel=UIObject.get(self,17)
self.middlePanel=UIObject.get(self,18)
self.topPanel=UIObject.get(self,19)
self.topUIPanel=UIObject.get(self,20)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.infoPanel:setButtonClick(function()self:onInfoPanel()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianZhanManagerWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.changeText);self.changeText=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.shangdaodesc);self.shangdaodesc=nil;
_UIObject_release(self.conghuidesc);self.conghuidesc=nil;
_UIObject_release(self.meilidesc);self.meilidesc=nil;
_UIObject_release(self.dizi);self.dizi=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.dzInfo);self.dzInfo=nil;
_UIObject_release(self.notDiZi);self.notDiZi=nil;
_UIObject_release(self.descImg);self.descImg=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.sdLevel);self.sdLevel=nil;
_UIObject_release(self.conghui);self.conghui=nil;
_UIObject_release(self.meili);self.meili=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.middlePanel);self.middlePanel=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.topUIPanel);self.topUIPanel=nil;
end

















local _this


function UIXianZhanManagerWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UIXianZhanManagerWin:__delete()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end




function UIXianZhanManagerWin:onShow(argtable,afterOnloaded)
self.sfId=argtable[1]
self.bdData=argtable[2]
local dzId=argtable[3]
self.dzId=dzId
self:refreshDzInfo(dzId)


if not newbieControl.isInNewbie()then
self:doOpenAnim()
end
end

function UIXianZhanManagerWin:doOpenAnim()
self.middlePanel:setChildCanvasGroupAlpha(0)
self.topUIPanel:setChildCanvasGroupAlpha(0)
self.bottomPanel:setLocalPosY(-750)
self.topPanel:setLocalPosY(-750)
self.bottomPanel:setChildDOLocalMoveY(0,0.35,nil)
self.topPanel:setChildDOLocalMoveY(0,0.35,nil)
self:delayDo(0.15,function()
self.bottomPanel:setChildDOScale(1.1,0.2,function()
if _this==nil then return end
_this.bottomPanel:setChildDOScale(1,0.1,nil)
end)
self.topPanel:setChildDOScale(1.1,0.2,function()
if _this==nil then return end
_this.topPanel:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this:onOpenAnimFinish()
end)
end)
end)
end

function UIXianZhanManagerWin:onOpenAnimFinish()
self.middlePanel:setChildCanvasGroupDOFade(1,0.2)
self.topUIPanel:setChildCanvasGroupDOFade(1,0.2,function()
if _this==nil then return end
_this:saySomething()
end)
end


function UIXianZhanManagerWin:onHide()

end

function UIXianZhanManagerWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if _this==nil then return end
if etype==buildingEvent.replaceDisciple then
local old_dz=_this.dzId
_this.dzId=arg1
_this:refreshDzInfo(arg1)
if tostring(old_dz)=='0'then
_this:saySomething()
end
end
end

function UIXianZhanManagerWin:getSpeakText()
local dzId=self.dzId
local txt=nil
if tostring(dzId)~='0'then
local speakList=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'managerspeak')
txt=speakList[math.random(1,#speakList)]or''
end
return txt
end

function UIXianZhanManagerWin:refreshDzInfo(dzId)
local haveDz=tostring(dzId)~='0'

self.descImg:setActive(haveDz)
self.descImg:setChildCanvasGroupAlpha(0)
self.dizi:setActive(haveDz)
self.notDiZi:setActive(not haveDz)
local changeStr=''
if haveDz then

local dzName=UIDiscipleModel:getDiscipleName(dzId)
self.dzName:setText(dzName)
local sdLevel=UIDiscipleModel:getDiscipleJobLevel(dzId,DISCIPLE_PROSKILL_TYPE.eShangDao)
self.sdLevel:setText(FMT.fmt('<color=#7d3b17>商道：</color>{0}级',sdLevel))
local conghui=UIDiscipleModel:getDiscipleBaseAttr(dzId,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
self.conghui:setText(FMT.fmt('<color=#7d3b17>聪慧：</color>{0}',conghui))
local meili=UIDiscipleModel:getDiscipleBaseAttr(dzId,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
self.meili:setText(FMT.fmt('<color=#7d3b17>魅力：</color>{0}',meili))

local info=UIDiscipleModel:getDiscipleInsideModelInfo(dzId)

self.dizi:setChildUIModelShowTarget(info.body,0.8,info.componets,eAnimationID.stand)
self.dizi:setChildUIModelShowTargetOffset(0,26)
changeStr='更换弟子'
else
self.dzName:setText('')
self.sdLevel:setText('<color=#7d3b17>商道：</color>收取更多的租金')
self.conghui:setText('<color=#7d3b17>聪慧：</color>获得更多满意度')
self.meili:setText('<color=#7d3b17>魅力：</color>增加与房客亲密度')
changeStr='安排弟子'
end
self.changeText:setText(changeStr)
end

function UIXianZhanManagerWin:saySomething()
local speakStr=self:getSpeakText()
if speakStr==nil then return end

self.desc:setText(speakStr)
self.descImg:setChildCanvasGroupAlpha(1)
self.descImg:setScale(Vector3.zero)

self.descImg:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.descImg:setChildDOScale(1,0.1)
end)
self:delayDo(5,function()
local haveDz_=tostring(self.dzId)~='0'
if haveDz_ then
self.descImg:setChildCanvasGroupDOFade(0,0.3)
end
end)
end



function UIXianZhanManagerWin:onChangeBtn()
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eXianZhan)
end

function UIXianZhanManagerWin:onCloseBtn()
self:closeSelf()
end

function UIXianZhanManagerWin:onTipsBtn()
self:showInfoPanel()
end

function UIXianZhanManagerWin:onInfoPanel()
self:showInfoPanel()
end

function UIXianZhanManagerWin:showInfoPanel()
self.closeTips=not self.closeTips
self.infoPanel:setActive(self.closeTips)
if not self.initInfo then
self.initInfo=true
local sdStr=cfgHelper.get1(cfg_lang_get,'xianzhan_zhanggui_tips_1')
local chStr=cfgHelper.get1(cfg_lang_get,'xianzhan_zhanggui_tips_2')
local mlStr=cfgHelper.get1(cfg_lang_get,'xianzhan_zhanggui_tips_3')
self.shangdaodesc:setText(sdStr)
self.conghuidesc:setText(chStr)
self.meilidesc:setText(mlStr)
end
end


function UIXianZhanManagerWin:onNoteBtn()
local datalist=xianzhanModel:getNotes()
if#datalist<=0 then
UIManager.error('暂无入住记录')
return
end

local args={}
args.titleName="入住记录"
args.pos=1
args.extraWin='UIXianZhanNoteWin'
local extraParams={datalist=datalist}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end