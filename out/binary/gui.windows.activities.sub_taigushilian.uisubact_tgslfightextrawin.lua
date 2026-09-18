







def_class("UISubAct_tgslFightExtraWin",UIWindowBase)









function UISubAct_tgslFightExtraWin:bindComponents()

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

self.skillItem:setButtonClick(function()self:onSkillItem()end)



end


function UISubAct_tgslFightExtraWin:unbindComponents()
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
end

















local tefighttype=8
local _this


function UISubAct_tgslFightExtraWin:onLoaded(...)
_this=self
self:bindComponents()
self.fazebg={self.bg1,self.bg2,self.bg3}
self.fazetxt={self.txt1,self.txt2,self.txt3}
end


function UISubAct_tgslFightExtraWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_tgslFightExtraWin:onShow(argtable,afterOnloaded)

if argtable then
self.actId=argtable[1]
self.subType=argtable[2]
self.subId=argtable[3]
self.bossid=argtable[4]or 1
self.specialfaze_templist=argtable[5]
self.specialfaze_fazeidx=argtable[6]


self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
if not self.info then
UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end
self.bossData=self.config.boss[self.bossid]



local startdayidx=activitiesHandle_taiguBoss:getSubOpenDayIndex(_this.actId,_this.subType,_this.subId)
local faze=self.config.faze
local fazeData=faze[startdayidx]or{}











self:onClickSkill(fazeData)


self.lhidx=self.bossData[4]

self.cfg_dizifaze=cfg_tsdzfzconfig_get(tefighttype)[self.lhidx]
self.dizifazedesc=self.config.dizifazedesc[self.lhidx]
local diziList=self.cfg_dizifaze.diziList
self.diziList_id={}
for k,v in pairs(diziList)do
if k and v==1 then
self.diziList_id[#self.diziList_id+1]=k
end
end
self.diziid=self.diziList_id[1]
if self.specialfaze_templist[1]then
if self.specialfaze_templist[1][1]then
self.diziid=self.specialfaze_templist[1][1]
end
end

self:initdizifaze()
end
end


function UISubAct_tgslFightExtraWin:onHide()

end





function UISubAct_tgslFightExtraWin:initdizifaze()

local widget=_this.diziitem1:getChildWidgetBase()
widget:SetChildButtonClick(7,function()

UIManager:showWindow('UISubAct_tgslZenYiWin',{_this.actId,_this.subType,_this.subId,_this.bossid,1})
end)
_this:refreshdizifaze(false)
end

function UISubAct_tgslFightExtraWin:refreshdizifaze(flag,diziID)
local info=activitiesModel:getSubActInfo(_this.actId,_this.subType,_this.subId)
if not info then
UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end


if not flag then

local widget=_this.diziitem1:getChildWidgetBase()
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(_this.diziid)
local imageInfo=dizidata.imageInfo
comHelper.setChildModelHeadIconBGByColor(widget,0,imageInfo.color)
comHelper.setChildModelRawImageByDiziId(widget,_this.diziid,1,0,eHeadCenterType.eHead)
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
comHelper.setChildModelHeadIconBGByColor(widget,0,imageInfo.color)
comHelper.setChildModelRawImageByDiziId(widget,diziID,1,0,eHeadCenterType.eHead)

local str=_this.dizifazedesc[fazelevel][2]
widget:SetChildText(5,str)
else
local widget=_this.diziitem1:getChildWidgetBase()
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(_this.diziid)
local imageInfo=dizidata.imageInfo
comHelper.setChildModelHeadIconBGByColor(widget,0,imageInfo.color)
comHelper.setChildModelRawImageByDiziId(widget,_this.diziid,1,0,eHeadCenterType.eHead)
widget:SetChildText(5,"查看弟子增益")
end
end
end


function UISubAct_tgslFightExtraWin:onClickSkill(fazeData)
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
