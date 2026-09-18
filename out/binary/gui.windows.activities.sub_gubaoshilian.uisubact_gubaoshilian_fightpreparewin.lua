







def_class("UISubAct_GuBaoShiLian_FightPrepareWin",UIWindowBase)









function UISubAct_GuBaoShiLian_FightPrepareWin:bindComponents()

self.disciplePanel=UIObject.get(self,0)
self.gubaoPanel=UIObject.get(self,1)



end


function UISubAct_GuBaoShiLian_FightPrepareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.disciplePanel);self.disciplePanel=nil;
_UIObject_release(self.gubaoPanel);self.gubaoPanel=nil;
end















local _this=nil
local _gubaoCmp={
gbModel=0,
attrList=1,
emptyAttr=2,
helpBtn=3,
}
local _discipleCmp={
bg=0,
head=1,
tipsTx=2,
helpBtn=3,
}
local _gubaoLoopTime=5



function UISubAct_GuBaoShiLian_FightPrepareWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onFightPrepareSelectChange,self.onFightPrepareSelectChange)

self.gubaoWidget=self.gubaoPanel:getChildWidgetBase()
self.gubaoWidget:SetChildButtonClick(_gubaoCmp.helpBtn,function()
self:onClickGuBaoHelp()
end)

self.discipleWidget=self.disciplePanel:getChildWidgetBase()
self.discipleWidget:SetChildButtonClick(_discipleCmp.helpBtn,function()
self:onClickDiscipleHelp()
end)

self.defaultGuBaoScale=self.gubaoWidget:GetChildScale(_gubaoCmp.gbModel)
self.showGubaoIdx=1
end


function UISubAct_GuBaoShiLian_FightPrepareWin:__delete()
self:unbindComponents()
_this=nil

self:stopGBTick()
self:killGBTweener()
end




function UISubAct_GuBaoShiLian_FightPrepareWin:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.emptyDiscipleStr=FMT.fmt("本期至少上阵<color=#f36666>1名{0}</color>",UIDiscipleModel:getJobName(self.config.voc_limit))
self.gubaoIDs=argtable.gubaoIDs
if self.gubaoIDs==nil then
self.gubaoIDs={}
for id,temp in pairs(self.config.gubao_up1)do
table.insert(self.gubaoIDs,id)
end
for id,temp in pairs(self.config.gubao_up2)do
if not self.config.gubao_up1[id]then
table.insert(self.gubaoIDs,id)
end
end
table.sort(self.gubaoIDs)
end
self.onFightPrepareSelectChange(argtable.base_selectList,true)
self:refreshGuBaoModel()
self:refreshGuBaoAttr()
self:startGBTick()
end


function UISubAct_GuBaoShiLian_FightPrepareWin:onHide()

end



function UISubAct_GuBaoShiLian_FightPrepareWin.onFightPrepareSelectChange(selectList,force)
local tempLv,tempGuid
for pos,data in pairs(selectList)do
if data[1]==fightPreSelectModel.teamEntityType.dizi then
local discipleGuid=data[2]
local job=UIDiscipleModel:getDiscipleJob(discipleGuid)
if job==_this.config.voc_limit then
local jjlv=UIDiscipleModel:getDiscipleJJLevel(discipleGuid)
local ltlv=UIDiscipleModel:getDiscipleLTLevel(discipleGuid)
local sumlv=jjlv+ltlv
if(tempLv or 0)<sumlv then
tempLv=sumlv
tempGuid=discipleGuid
end
end
end
end
_this:setDisciplePanel(tempGuid,force)
end

function UISubAct_GuBaoShiLian_FightPrepareWin:onClickGuBaoHelp()
local args={
parentWin=self,
actId=self.actId,
subType=self.subType,
subId=self.subId,
gubaoIDs=self.gubaoIDs,
}
self:showWindow("UISubAct_GuBaoShiLian_GuBaoWin",args)
end

function UISubAct_GuBaoShiLian_FightPrepareWin:onClickDiscipleHelp()
local d={}
d.title='规则'
d.mode=3
d.name='gubaoshilian_fightprepare_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_GuBaoShiLian_FightPrepareWin:startGBTick()
if not self.gbTick then
self.gbTick=self:setTimer(1,0,function()
if self.gbTickTime<timeHelper.getServerShortTime()then
self:onNextGuBao()
end
end)
end
end

function UISubAct_GuBaoShiLian_FightPrepareWin:stopGBTick()
if self.gbTick then
self:stopTimerByID(self.gbTick)
self.gbTick=nil
end
end

function UISubAct_GuBaoShiLian_FightPrepareWin:onNextGuBao()
self.showGubaoIdx=self.showGubaoIdx+1
if self.showGubaoIdx>#self.gubaoIDs then
self.showGubaoIdx=self.showGubaoIdx-#self.gubaoIDs
end
self:refreshGuBaoModel()
end

function UISubAct_GuBaoShiLian_FightPrepareWin:refreshGuBaoModel()
local gbId=self.gubaoIDs[self.showGubaoIdx]
local itemCfg=itemsConfig.getConfig(gbId,ITEM_CONFIG_TYPE.eGuBao)
local pram=itemCfg.relevantPram.pram
local effectId=pram.effectid
self:killGBTweener()
local scale=self.defaultGuBaoScale.x or 0.44
self.gubaoWidget:SetChildScale(_gubaoCmp.gbModel,Vector3.zero)
self.gubaoWidget:SetChildShowEffect(_gubaoCmp.gbModel,effectId,true)
self.gbTweener=self.gubaoWidget:SetChildDOScale(_gubaoCmp.gbModel,scale,0,nil)
self.gbTweener:SetDelay(0.2)

self.gbTickTime=timeHelper.getServerShortTime()+_gubaoLoopTime
end

function UISubAct_GuBaoShiLian_FightPrepareWin:killGBTweener()
if self.gbTweener and self.gbTweener:IsActive()then
self.gbTweener:Kill()
self.gbTweener=nil
end
end

function UISubAct_GuBaoShiLian_FightPrepareWin:setDisciplePanel(discipleGuid,force)
if force or self.discipleGuid~=discipleGuid then
self.discipleGuid=discipleGuid

if discipleGuid then
self.discipleWidget:SetChildActive(_discipleCmp.bg,true)
self.discipleWidget:SetChildActive(_discipleCmp.head,true)

comHelper.setChildModelRawImage(self.discipleWidget,discipleGuid,_discipleCmp.head,eAnimationID.stand,eHeadCenterType.eHead)

local jjlv=UIDiscipleModel:getDiscipleJJLevel(discipleGuid)
local ltlv=UIDiscipleModel:getDiscipleLTLevel(discipleGuid)
local sumlv=jjlv+ltlv
for i,v in ipairs(self.config.disciple_up)do
if v[1]<=sumlv and sumlv<=v[2]then
local str=nil
for j,w in ipairs(v[3])do
local fzId=w[1]
local fzLv=w[2]
local fzRuleCfg=cfgHelper.getSSlawRule(fzId)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzLv]and true or false
local desc=fzRuleCfg.attrdesc or fzRuleCfg.desc
local fzdesc=not hasParam and desc or string.format(desc,unpack(fzRuleCfg.descparm[fzLv]))
str=str and FMT.fmt("{0} {1}",str,fzdesc)or fzdesc
end
self.discipleWidget:SetChildText(_discipleCmp.tipsTx,str)
return
end
end
self.discipleWidget:SetChildText(_discipleCmp.tipsTx,"")
else
self.discipleWidget:SetChildActive(_discipleCmp.bg,false)
self.discipleWidget:SetChildActive(_discipleCmp.head,false)
self.discipleWidget:SetChildText(_discipleCmp.tipsTx,self.emptyDiscipleStr)
end
end
end

function UISubAct_GuBaoShiLian_FightPrepareWin:refreshGuBaoAttr()
local descList={}
for i,v in ipairs(self.gubaoIDs)do
local gbData=gubaoModel:getDataByID(v)
if gbData then
local lv=gbData.gubaostar+gbData.gubaojxlv
local desc=self.config.gubao_effect_desc[v][lv][1]
table.insert(descList,desc)
end
end
self.gubaoWidget:SetChildActive(_gubaoCmp.emptyAttr,#descList<=0)
self.gubaoWidget:SetChildLayoutGroupCreateItems(_gubaoCmp.attrList,#descList,function(index)
local item=self.gubaoWidget:GetChildLayoutGroupGridItem(_gubaoCmp.attrList,index-1)
item:SetChildText(-1,descList[index])
end)
end