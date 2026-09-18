







def_class("UISubAct_fyslFightExtraWin",UIWindowBase)









function UISubAct_fyslFightExtraWin:bindComponents()

self.skillItem=UIButton.get(self,0)
self.bg1=UIObject.get(self,1)
self.bg2=UIObject.get(self,2)
self.bg3=UIObject.get(self,3)
self.txt1=UIText.get(self,4)
self.txt2=UIText.get(self,5)
self.txt3=UIText.get(self,6)
self.diziitem1=UIObject.get(self,7)
self.skillIcon=UIImage.get(self,8)
self.skillname=UIText.get(self,9)
self.skillDescTxt=UIText.get(self,10)
self.dizipanel=UIObject.get(self,11)
self.lgpanel=UIObject.get(self,12)
self.ctpanel=UIObject.get(self,13)
self.lgitem=UIObject.get(self,14)
self.ctitem=UIObject.get(self,15)

self.skillItem:setButtonClick(function()self:onSkillItem()end)



end


function UISubAct_fyslFightExtraWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.bg1);self.bg1=nil;
_UIObject_release(self.bg2);self.bg2=nil;
_UIObject_release(self.bg3);self.bg3=nil;
_UIObject_release(self.txt1);self.txt1=nil;
_UIObject_release(self.txt2);self.txt2=nil;
_UIObject_release(self.txt3);self.txt3=nil;
_UIObject_release(self.diziitem1);self.diziitem1=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.skillname);self.skillname=nil;
_UIObject_release(self.skillDescTxt);self.skillDescTxt=nil;
_UIObject_release(self.dizipanel);self.dizipanel=nil;
_UIObject_release(self.lgpanel);self.lgpanel=nil;
_UIObject_release(self.ctpanel);self.ctpanel=nil;
_UIObject_release(self.lgitem);self.lgitem=nil;
_UIObject_release(self.ctitem);self.ctitem=nil;
end


















local _this
local hdtype=
{
fuyaoshilain=1,
taigushilain=2
}


function UISubAct_fyslFightExtraWin:onLoaded(...)
_this=self
self:bindComponents()
self.fazebg={self.bg1,self.bg2,self.bg3}
self.fazetxt={self.txt1,self.txt2,self.txt3}
end


function UISubAct_fyslFightExtraWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_fyslFightExtraWin:onShow(argtable,afterOnloaded)
self.actId=argtable[1]
self.subType=argtable[2]
self.subId=argtable[3]
self.bossid=argtable[4]or 1
self.specialfaze_templist=argtable[5]
self.specialfaze_fazeidx=argtable[6]
self.hdtype=argtable[7]or hdtype.fuyaoshilain
self.tefighttype=9
if self.hdtype==hdtype.taigushilain then
self.tefighttype=8
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
if not self.info then
UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end
self.bossData=self.config.boss[self.bossid]
self.lhidx=self.bossData[4]
self.cfg_dizifaze=cfg_tsdzfzconfig_get(_this.tefighttype)[self.lhidx]


local startdayidx=activitiesHandle_fuyaoBoss:getSubOpenDayIndex(_this.actId,_this.subType,_this.subId)
local faze=self.config.faze

local fazeData=faze[startdayidx]or{}
self:onClickSkill(fazeData)


if self.lhidx~=0 then
if self.cfg_dizifaze.tm then
self.dizipanel:setActive(true)
self.lgpanel:setActive(false)
self.ctpanel:setActive(false)
self:initdizifaze()
elseif self.cfg_dizifaze.lg then
self.dizipanel:setActive(false)
self.lgpanel:setActive(true)
self.ctpanel:setActive(false)
self:initlgfaze()
self.lgpanel:setChildCanvasGroupAlpha(0)
elseif self.cfg_dizifaze.ct then
self.dizipanel:setActive(false)
self.lgpanel:setActive(false)
self.ctpanel:setActive(true)
self:initctfaze()
self.ctpanel:setChildCanvasGroupAlpha(0)
end
else
self.dizipanel:setActive(false)
self.lgpanel:setActive(false)
self.ctpanel:setActive(false)
end
end


function UISubAct_fyslFightExtraWin:onHide()

end




function UISubAct_fyslFightExtraWin:initdizifaze()
self.dizifazedesc=self.config.dizifazedesc[self.lhidx]
local diziList=self.cfg_dizifaze.diziList
self.diziList_id={}
for k,v in pairs(diziList)do
if k and v==1 then
self.diziList_id[#self.diziList_id+1]=k
end
end
self.diziid=self.diziList_id[1]
if self.specialfaze_templist and self.specialfaze_templist[1]then
if self.specialfaze_templist[1][1]then
self.diziid=self.specialfaze_templist[1][1]
end
end
local widget=_this.diziitem1:getChildWidgetBase()
widget:SetChildButtonClick(7,function()
if _this.hdtype==hdtype.fuyaoshilain then
UIManager:showWindow('UISubAct_fyslZenYiWin',{_this.actId,_this.subType,_this.subId,_this.bossid,1})
elseif _this.hdtype==hdtype.taigushilain then
UIManager:showWindow('UISubAct_tgslZenYiWin',{_this.actId,_this.subType,_this.subId,_this.bossid})
end
end)
_this:refreshdizifaze(false)
end

function UISubAct_fyslFightExtraWin:refreshdizifaze(flag,diziID)
local info=activitiesModel:getSubActInfo(_this.actId,_this.subType,_this.subId)
if not info then
UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end
if not flag then

local widget=_this.diziitem1:getChildWidgetBase()
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(_this.diziid)
local imageInfo=dizidata.imageInfo
widget:SetChildActive(0,false)
widget:SetChildActive(1,false)


widget:SetChildText(5,"查看弟子增益")
else

local specialfaze_templist=_this.specialfaze_templist
local fazelevel=0
for k,v in ipairs(specialfaze_templist)do
if diziID and diziID==v[1]then
fazelevel=v[2]
end
end
if fazelevel~=0 and diziID then
local widget=_this.diziitem1:getChildWidgetBase()
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(diziID)
local imageInfo=dizidata.imageInfo
widget:SetChildActive(0,true)
widget:SetChildActive(1,true)
comHelper.setChildModelHeadIconBGByColor(widget,0,imageInfo.color)
comHelper.setChildModelRawImageByDiziId(widget,diziID,1,0,eHeadCenterType.eHead)
local str=_this.dizifazedesc[fazelevel][2]
widget:SetChildText(5,str)
else
local widget=_this.diziitem1:getChildWidgetBase()
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(_this.diziid)
local imageInfo=dizidata.imageInfo
widget:SetChildActive(0,false)
widget:SetChildActive(1,false)


widget:SetChildText(5,"查看弟子增益")
end
end
end


function UISubAct_fyslFightExtraWin:initlgfaze()
local widget=_this.lgitem:getChildWidgetBase()
widget:SetChildButtonClick(7,function()
if _this.hdtype==hdtype.fuyaoshilain then
UIManager:showWindow('UISubAct_fyslZenYiLCWin',{_this.actId,_this.subType,_this.subId,_this.bossid})
elseif _this.hdtype==hdtype.taigushilain then
UIManager:showWindow('UISubAct_tgslZenYiLCWin',{_this.actId,_this.subType,_this.subId,_this.bossid})
end
end)
_this:refreshlinggen(false)
end

function UISubAct_fyslFightExtraWin:refreshlinggen(flag,lglevel)
local info=activitiesModel:getSubActInfo(_this.actId,_this.subType,_this.subId)
if not info then
UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end
if not flag then
local widget=_this.lgitem:getChildWidgetBase()
widget:SetChildText(5,"查看弟子增益")
widget:SetChildText(8,"总等级:0")
else
_this.lgpanel:setChildCanvasGroupDOFade(1,0.3)
if lglevel and lglevel~=0 then
local alldata=_this.cfg_dizifaze.lg
local lg=alldata[2]
local fazelevel=1
for k,v in ipairs(lg)do
if lglevel<=v then
fazelevel=k
break
end
end
local dizifazedesc=_this.config.dizifazedesc[_this.lhidx]
local widget=_this.lgitem:getChildWidgetBase()
local str=dizifazedesc[fazelevel][2]
widget:SetChildText(5,str)
local lgstr=FMT.fmt("总等级:{0}级",lglevel)
widget:SetChildText(8,lgstr)
else
local widget=_this.lgitem:getChildWidgetBase()
widget:SetChildText(5,"查看弟子增益")
widget:SetChildText(8,"灵根总等级:0")
end
end
end


function UISubAct_fyslFightExtraWin:initctfaze()
local widget=_this.ctitem:getChildWidgetBase()
widget:SetChildButtonClick(7,function()
if _this.hdtype==hdtype.fuyaoshilain then
UIManager:showWindow('UISubAct_fyslZenYiLCWin',{_this.actId,_this.subType,_this.subId,_this.bossid})
elseif _this.hdtype==hdtype.taigushilain then
UIManager:showWindow('UISubAct_tgslZenYiLCWin',{_this.actId,_this.subType,_this.subId,_this.bossid})
end
end)
_this:refreshcuiti(false)
end

function UISubAct_fyslFightExtraWin:refreshcuiti(flag,ctlevel)
local info=activitiesModel:getSubActInfo(_this.actId,_this.subType,_this.subId)
if not info then
UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end
if not flag then
local widget=_this.ctitem:getChildWidgetBase()
widget:SetChildText(5,"查看弟子增益")
widget:SetChildText(8,"总等级:0")
else
_this.ctpanel:setChildCanvasGroupDOFade(1,0.3)
if ctlevel and ctlevel~=0 then
local alldata=_this.cfg_dizifaze.ct
local ct=alldata[2]
local fazelevel=1
for k,v in ipairs(ct)do
if ctlevel<=v then
fazelevel=k
break
end
end
local dizifazedesc=_this.config.dizifazedesc[_this.lhidx]
local widget=_this.ctitem:getChildWidgetBase()
local str=dizifazedesc[fazelevel][2]
widget:SetChildText(5,str)
local lgstr=FMT.fmt("总等级:{0}级",ctlevel)
widget:SetChildText(8,lgstr)
else
local widget=_this.ctitem:getChildWidgetBase()
widget:SetChildText(5,"查看弟子增益")
widget:SetChildText(8,"淬体总等级:0")
end
end
end


function UISubAct_fyslFightExtraWin:onClickSkill(fazeData)
local x=-146+78
local txParam=fazeData
local fazeID=txParam[1]
local fazeLv=txParam[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local descparm=fazeCfg.descparm
local name=fazeCfg.name
local icon=fazeCfg.image
local desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLv]))or fazeCfg.desc
local halfVector=Vector2.right*0.5
local args={
name=name,
icon=icon,
desc=desc,
bottomLeft=nil,
rootPoint={
anchorsMin=halfVector,
anchorsMax=halfVector,
pivot=halfVector,
anchoredPosition=Vector2.New(x,245),
}
}
self.skillname:setText(name)
self.skillIcon:setImageIcon(icon,true)
self.skillDescTxt:setText(desc)

end
