







def_class("UIXianGuanJingXuanJobListWin",UIWindowBase)









function UIXianGuanJingXuanJobListWin:bindComponents()

self.cancelButton=UIButton.get(self,0)
self.helpBtn=UIButton.get(self,1)
self.jobList=UIObject.get(self,2)
self.nameBg=UIImage.get(self,3)
self.nameTx=UIText.get(self,4)
self.officerBtn=UIButton.get(self,5)
self.playerName=UIText.get(self,6)
self.selectText=UIText.get(self,7)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.officerBtn:setButtonClick(function()self:onOfficerBtn()end)



end


function UIXianGuanJingXuanJobListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.jobList);self.jobList=nil;
_UIObject_release(self.nameBg);self.nameBg=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.officerBtn);self.officerBtn=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.selectText);self.selectText=nil;
end















local _this=nil
local _jobCmp={
widget=-1,
select=0,
name=1,
reddot=2,
icon=3,
}
local _panels={
[XianGuanCampaignType.eWuXuan]={
[XianGuanWuXuanSegment.eRegister]="UIXianGuanWuXuanPrepareWin",
[XianGuanWuXuanSegment.eReady]="UIXianGuanWuXuanMatch2Win",
[XianGuanWuXuanSegment.eMatch]="UIXianGuanWuXuanMatch2Win",
[XianGuanWuXuanSegment.eFinish]="UIXianGuanWuXuanMatch2Win",
},
}
local _selectTx={
[XianGuanCampaignType.eWuXuan]={
[XianGuanWuXuanSegment.eRegister]="武选登记",
}
}
local _helper={
[XianGuanCampaignType.eWuXuan]={
[XianGuanWuXuanSegment.eReady]="xianguan_jingxuan_2_%d",
[XianGuanWuXuanSegment.eMatch]="xianguan_jingxuan_2_%d",
[XianGuanWuXuanSegment.eFinish]="xianguan_jingxuan_2_%d",
}
}

local _bwHelper={
[XianGuanCampaignType.eWuXuan]={
[XianGuanWuXuanSegment.eReady]="xianguan_jingxuan_buwei_2_%d",
[XianGuanWuXuanSegment.eMatch]="xianguan_jingxuan_buwei_2_%d",
[XianGuanWuXuanSegment.eFinish]="xianguan_jingxuan_buwei_2_%d",
}
}
local _skip={

}



function UIXianGuanJingXuanJobListWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onXianGuanJingXuanSegmentChange,self.onXianGuanJingXuanSegmentChange)

self.selectIdx=nil
end


function UIXianGuanJingXuanJobListWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGuanJingXuanJobListWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback

self.campaignType=argtable.campaignType
self.jobId=argtable.jobId
self.segment=xianguanController:getActivitySegment_Campaign_Compatible(self.campaignType)

if self.campaignType==XianGuanCampaignType.eWenXuan then
self.openBWState=xianguanController:isInMatchStage_WenXuan_BW()
if self.openBWState then
self.bwShowJobLookup=xianguanModel:getBWMatchJobLookUp_WenXuan()
end
elseif self.campaignType==XianGuanCampaignType.eWuXuan then
self.openBWState=xianguanController:isInMatchStage_WuXuan_BW()
if self.openBWState then
self.bwShowJobLookup=xianguanModel:getBWMatchJobLookUp_WuXuan()
end
end

self.jobs={}
local cfgs=xianguanConfig.getCampaignJobListConfig(self.campaignType)
for i,v in ipairs(cfgs)do
if self.openBWState then
if self.bwShowJobLookup[v.id]then
table.insert(self.jobs,v.id)
end
else
table.insert(self.jobs,v.id)
end
end
table.sort(self.jobs,function(a,b)
local sortA=cfgHelper.get2(cfg_xianguanconfig_get,a,"jobLevel")
local sortB=cfgHelper.get2(cfg_xianguanconfig_get,b,"jobLevel")
return sortA<sortB
end)
if self.jobId then
self.selectIdx=table.findValue(self.jobs,self.jobId)
else
self.selectIdx=1
self.jobId=self.jobs[self.selectIdx]
end

self.jobList:setChildLayoutGroupCreateItems(#self.jobs,function(index)
local item=self.jobList:getChildLayoutGroupGridItem(index-1)
local job=self.jobs[index]
local jobCfg=cfgHelper.get1(cfg_xianguanconfig_get,job)
item:SetChildActive(_jobCmp.select,self.selectIdx==index)
item:SetChildText(_jobCmp.name,jobCfg.name)


item:SetChildCSImageSprite(_jobCmp.icon,globalABLookup.xianguan,FMT.fmt("icon_xiangongtequan_{0}",jobCfg.jobIcon))
item:SetChildButtonClick(_jobCmp.widget,function()
self:onClickJob(index)
end)
end)
local activityId=self.campaignType==XianGuanCampaignType.eWenXuan and LIMIT_ACT_TYPE.eXianGuanWenXuan or LIMIT_ACT_TYPE.eXianGuanWuXuan
local activityName=limitActivitiesModel:getActConfig(activityId,"name")
activityName=_selectTx[self.campaignType]and _selectTx[self.campaignType][self.segment]or activityName
self.selectText:setText(activityName)

local isBW=xianguanController:IsInBWMatchStage_Campaign_Compatible(self.campaignType)
local helpStr
if isBW then
helpStr=_bwHelper[self.campaignType]and _bwHelper[self.campaignType][self.segment]or nil
else
helpStr=_helper[self.campaignType]and _helper[self.campaignType][self.segment]or nil
end
self.helpBtn:setActive(helpStr~=nil)

self:refreshPanel()
self:refreshInfo()
end


function UIXianGuanJingXuanJobListWin:onHide()

end




function UIXianGuanJingXuanJobListWin:onCancelButton()
local callback=self.callback
if self.currentPanel then
UIFullXJForceControl:closeWindow(self.currentPanel)
end
UIFullXJForceControl:closeWindow(self.__name)
if callback then
callback()
end
end


function UIXianGuanJingXuanJobListWin:onOfficerBtn()
local args={groupId=1,jobId=self.jobId}
UIFullXJForceControl:showWindow("UIXianGuanJobDetailsWin",args)
end

function UIXianGuanJingXuanJobListWin:onHelpBtn()
local isBW=xianguanController:IsInBWMatchStage_Campaign_Compatible(self.campaignType)
local helpStr
if isBW then
helpStr=_bwHelper[self.campaignType]and _bwHelper[self.campaignType][self.segment]or nil
else
helpStr=_helper[self.campaignType]and _helper[self.campaignType][self.segment]or nil
end
if helpStr then
local d={}
d.mode=3
d.title="说明"
d.name=helpStr
d.showBlack=true
self:showWindow('UIRuleWin',d)
end
end

function UIXianGuanJingXuanJobListWin:onClickJob(index)
if self.selectIdx~=index then
self:refreshJobSelect(self.selectIdx,false)
self.selectIdx=index
self.jobId=self.jobs[index]
self:refreshJobSelect(self.selectIdx,true)
self:refreshPanel()
self:refreshInfo()
end
end

function UIXianGuanJingXuanJobListWin:refreshJobSelect(index,select)
if index then
local item=self.jobList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_jobCmp.select,select)
end
end

function UIXianGuanJingXuanJobListWin:refreshJobReddot(index)
local item=self.jobList:getChildLayoutGroupGridItem(index-1)
local reddot=false
item:SetChildActive(_jobCmp.select,reddot)
end

function UIXianGuanJingXuanJobListWin:refreshInfo()
local jobCfg=cfgHelper.get2(cfg_xianguanconfig_get,self.jobId)
local group=xianguanModel:getGroupIdByJob(self.jobId)
local info=xianguanModel:getGroupJobInfo(group,self.jobId)
local icon=chatModel:getSignIcon(jobCfg.chatFlagId)
self.playerName:setText(info and info.actorname or"虚位以待")
self.nameTx:setText(jobCfg.name)
self.nameBg:setImageIcon(icon,true)
end

function UIXianGuanJingXuanJobListWin:refreshPanel()
local panelName=_panels[self.campaignType][self.segment]
if self.currentPanel and self.currentPanel~=panelName then
UIFullXJForceControl:closeWindow(self.currentPanel)
end
self.currentPanel=panelName
if panelName then
UIFullXJForceControl:showWindow(panelName,{job=self.jobId})
end
end

function UIXianGuanJingXuanJobListWin.onXianGuanJingXuanSegmentChange(campaignType,oldSeg)
if _this.campaignType==campaignType then
_this.segment=xianguanController:getJingXuanSegment(_this.campaignType)
local skips=_skip[_this.campaignType]
if skips and table.containsValue(skips,_this.segment)then
return
end

local panels=_panels[_this.campaignType]
if panels and panels[_this.segment]then
_this:refreshPanel()
else
_this:onCancelButton()
end
end
end
