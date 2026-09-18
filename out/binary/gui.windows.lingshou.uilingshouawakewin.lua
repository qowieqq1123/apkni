







def_class("UILingShouAwakeWin",UIWindowBase)









function UILingShouAwakeWin:bindComponents()

self.root=UIObject.get(self,0)
self.leftPanel=UIObject.get(self,1)
self.rightPanel=UIObject.get(self,2)
self.planBtn=UIButton.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.changeBtn=UIButton.get(self,5)
self.noneRoot=UIObject.get(self,6)
self.infoRoot=UIObject.get(self,7)
self.xuemaiProgress=UIProgress.get(self,8)
self.conditionObj=UIObject.get(self,9)
self.descTxt=UIText.get(self,10)
self.cantRoot=UIText.get(self,11)
self.condTitleTxt=UIText.get(self,12)
self.canRoot=UIObject.get(self,13)
self.costGrid=UIObject.get(self,14)
self.talentSkillGrid=UIObject.get(self,15)
self.baseSkillGrid=UIObject.get(self,16)

self.planBtn:setButtonClick(function()self:onPlanBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)



end


function UILingShouAwakeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.planBtn);self.planBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.noneRoot);self.noneRoot=nil;
_UIObject_release(self.infoRoot);self.infoRoot=nil;
_UIObject_release(self.xuemaiProgress);self.xuemaiProgress=nil;
_UIObject_release(self.conditionObj);self.conditionObj=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.cantRoot);self.cantRoot=nil;
_UIObject_release(self.condTitleTxt);self.condTitleTxt=nil;
_UIObject_release(self.canRoot);self.canRoot=nil;
_UIObject_release(self.costGrid);self.costGrid=nil;
_UIObject_release(self.talentSkillGrid);self.talentSkillGrid=nil;
_UIObject_release(self.baseSkillGrid);self.baseSkillGrid=nil;
end
















local _this
local leftChild={
lingshouModelShow=0,
lingshoufight=1,
lingshoufightTx=2,
bianyi=3,
changeBtn=4,
helpBtn=5,
planBtn=6,
lingshouName=7,
previewBtn=8,
lingshouModelPreview=9,
}


function UILingShouAwakeWin:onLoaded(...)
_this=self
self:bindComponents()
notifySystem:listenNotify(notifyConfig.onLingShouAwake,self.onLingShouAwake)

self.gainTable={}
self.leftWidget=self.leftPanel:getWidgetBase()

self.leftWidget:SetChildActive(leftChild.lingshouModelPreview,false)
end


function UILingShouAwakeWin:__delete()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onLingShouAwake,self.onLingShouAwake)
end


function UILingShouAwakeWin:onHide()

end

function UILingShouAwakeWin.onLingShouAwake(guid)
if _this==nil then return end
if not mathHelper.compareInt64(guid,_this.ls_guid)then return end

_this:refreshLeft()
_this:refreshCondView()
end




function UILingShouAwakeWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
self.entityId=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(self.entityId)
local select_ls=self.select_ls or lingshouModel:getJiuLiDianSelect2(self.bdData.un_build_id)
if select_ls then
local select_lsData=lingshouModel:getLingShouData(select_ls)
if select_lsData then
if lingshouModel.checkZhenLingEx(select_lsData.cfg.race)then
select_ls=nil
end
else
select_ls=nil
end
end
self:onSelectLingShou(select_ls)
end

function UILingShouAwakeWin:onPressPreview()
if not self.previewing then
self.previewing=true
self.leftWidget:SetChildActive(leftChild.lingshouModelShow,false)
self.leftWidget:SetChildActive(leftChild.lingshouModelPreview,true)
end
end

function UILingShouAwakeWin:onBackPreview()
self.previewing=false
self.leftWidget:SetChildActive(leftChild.lingshouModelShow,true)
self.leftWidget:SetChildActive(leftChild.lingshouModelPreview,false)
end

function UILingShouAwakeWin:onPlanBtn()
local list=lingshouModel:getLingShouDatas()
local temp={}
for i,v in pairs(list)do
local iszhenling=lingshouModel.checkZhenLingEx(v.cfg.race)
local canAwaken=lingshouModel:checkCanAwake(v.guid)
if canAwaken and not iszhenling then
table.insert(temp,v.guid)
end
end

local args={
lingshous=temp,
current=self.select_ls,
noneTips="（注：只有血脉达到100%才可进行觉醒）",
callback=function(guid)
self:onSelectLingShou(guid)
end
}
lingshouSelectController:openLingShouSelect(args)
end

function UILingShouAwakeWin:onHelpBtn()
local d={}
d.title='灵兽觉醒'
d.mode=3
d.name='lingshou_awake_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UILingShouAwakeWin:onChangeBtn()
local list=lingshouModel:getLingShouDatas()
local temp={}
for i,v in pairs(list)do
local iszhenling=lingshouModel.checkZhenLingEx(v.cfg.race)
local canAwaken=lingshouModel:checkCanAwake(v.guid)
if canAwaken and not iszhenling then
table.insert(temp,v.guid)
end
end

local args={
lingshous=temp,
current=self.select_ls,
noneTips="（注：只有血脉达到100%才可进行觉醒）",
callback=function(guid)
self:onSelectLingShou(guid)
end
}
lingshouSelectController:openLingShouSelect(args)
end

function UILingShouAwakeWin:onSelectLingShou(guid)
self.ls_guid=guid
lingshouModel:setJiuLiDianSelect2(self.bdData.un_build_id,self.ls_guid)
self:refreshLeft()
self:refreshRight()
end

function UILingShouAwakeWin:refreshLeft()
local show=self.ls_guid~=nil
self.leftWidget:SetChildActive(leftChild.planBtn,not show)
self.leftWidget:SetChildActive(leftChild.changeBtn,show)
self.leftWidget:SetChildActive(leftChild.lingshoufight,show)
if show then
local lsData=lingshouModel:getLingShouData(self.ls_guid)
local fight=lingshouModel.getFightValueEx(lsData)
local lscfg=lsData.cfg
local modelParams=lingshouModel.getModelParamsEx(lscfg.model)
local scale=0.8
self.leftWidget:SetChildText(leftChild.lingshoufightTx,tostring(fight))
self.leftWidget:SetChildActive(leftChild.bianyi,lscfg.bianyi==1)
self.leftWidget:SetChildText(leftChild.lingshouName,lsData.name)

self.leftWidget:SetChildUIModelRemoveTarget(leftChild.lingshouModelShow)
self.leftWidget:SetChildUIModelShowTarget(leftChild.lingshouModelShow,modelParams.body,scale,modelParams.componets,0,false,true)
self.leftWidget:SetChildUIModelShowTargetOffset(leftChild.lingshouModelShow,0,-350)

self.leftWidget:SetChildActive(leftChild.previewBtn,lscfg.new_id~=nil)
if lscfg.new_id then
lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lscfg.new_id)
modelParams=lingshouModel.getModelParamsEx(lscfg.model)
self.leftWidget:SetChildUIModelRemoveTarget(leftChild.lingshouModelPreview)
self.leftWidget:SetChildUIModelShowTarget(leftChild.lingshouModelPreview,modelParams.body,scale,modelParams.componets,0,false,true)
self.leftWidget:SetChildUIModelShowTargetOffset(leftChild.lingshouModelPreview,0,-350)
end
else
self.leftWidget:SetChildUIModelRemoveTarget(leftChild.lingshouModelShow)
self.leftWidget:SetChildUIModelRemoveTarget(leftChild.lingshouModelPreview)
self.leftWidget:SetChildActive(leftChild.bianyi,false)
self.leftWidget:SetChildText(leftChild.lingshouName,"")
self.leftWidget:SetChildActive(leftChild.previewBtn,false)
end
end

function UILingShouAwakeWin:refreshFightView()
local fight=lingshouModel:getFightValue(self.select_ls)
self.leftWidget:SetChildText(leftChild.lingshoufightTx,tostring(fight))
self.leftWidget:ForceLayoutRect(leftChild.lingshoufight)
end


function UILingShouAwakeWin:refreshRight()
local show=self.ls_guid~=nil
self.infoRoot:setActive(show)
self.noneRoot:setActive(not show)
if show then
self:refreshView()
end
end

function UILingShouAwakeWin:refreshView()
local lsData=lingshouModel:getLingShouData(self.ls_guid)

local desc_str="境界属性提示\n神通技能大幅增强"
if lsData.cfg.juexing_jj_per then
desc_str=FMT.fmt('境界属性提升{0}%\n神通技能大幅增强',lsData.cfg.juexing_jj_per)
end

self.descTxt:setText(desc_str)
local zlID=lsData.cfg.new_id

local talentSkillList=lingshouModel.getTalentSkillMaxListEx(lsData)
self:refreshSkillGrid(self.talentSkillGrid,talentSkillList,eSkillTipsType.eLSTalentSkill)

local skillList=lingshouModel.getSkillMaxList(zlID)
self:refreshSkillGrid(self.baseSkillGrid,skillList,eSkillTipsType.eLSSkill)

self:refreshCondView()
end

function UILingShouAwakeWin:refreshCondView()
local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
local iszhenling=lingshouModel:checkZhenLing(guid)
local canAwaken=lingshouModel:checkCanAwake(guid)

local title_str=iszhenling and'已觉醒'or'觉醒条件'
self.condTitleTxt:setText(title_str)

self.xuemaiProgress:setProgressValue(lsData.xuemai_val,100)
self.xuemaiProgress:setChildProgressText(FMT.fmt('{0}%',math.min(lsData.xuemai_val,100)))

local show=canAwaken and not iszhenling
self.conditionObj:setActive(show)
self.gainTable={}
self.canRoot:setActive(not iszhenling)
self.cantRoot:setActive(iszhenling)
if show then
local costlist=lsData.cfg.juexing_cost
local costNum=#costlist
self.costGrid:setChildLayoutGroupCreateItems(costNum)
local gridlist=self.costGrid:getChildLayoutGroupGridList()
for i=1,costNum do
local item=gridlist[i-1]
local cost=costlist[i]
local itemid=cost[1]
local itemnum=cost[2]
self.gainTable[itemid]=itemnum
local hasnum
local num_str
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
num_str=tostring(hasnum)
else
hasnum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
num_str=string.format('%d/%d',hasnum,itemnum)
end
local grayNum=0
if hasnum<=0 then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
elseif hasnum<itemnum then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
if grayNum~=0 then
num_str=FMT.fmt('<color=red>{0}</color>',num_str)
end
local conf={itemid=itemid,itemcount=num_str,showname=false,itemIndex=i,gray=grayNum,showStage=true,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
end
end
end

function UILingShouAwakeWin:refreshSkillGrid(skillGrid,skilList,st)
skillGrid:setChildLayoutGroupCreateItems(#skilList)
local gridlist=skillGrid:getChildLayoutGroupGridList()
local c=gridlist.Count
if c>0 then
for i=1,c do
local item=gridlist[i-1]
local d=skilList[i]
local skillID=d[1]
local skillLv=d[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)

if st==eSkillTipsType.eLSSkill then
skillLv=skillCfg.maxGrowLv
end
local islock=skillLv<=0

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

local showLevel=false
item:SetChildActive(4,showLevel)
if showLevel then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end

item:SetChildActive(5,islock)

item:SetChildButtonClick(3,function()
self:onSkillItemClick(st,skillID,skillLv)
end)

item:SetChildActive(6,true)
end
end
end

function UILingShouAwakeWin:onSkillItemClick(skillType,skillID,skillLv)
local args={skillID=skillID,skillLv=skillLv,attend=skillType}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end

function UILingShouAwakeWin:onItemClick(itemid,index,guid,attach)
if itemid==-1 then return end
local need=self.gainTable[itemid]or 0
if gainControl:showGainWin(itemid,need)then return end
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UILingShouAwakeWin:onCommitBtn()
local guid=self.ls_guid
if lingshouModel:checkZhenLing(guid)then return end
local lsData=lingshouModel:getLingShouData(guid)
local xuemai_val=lsData.xuemai_val
if not lingshouModel.checkEnoughAwake(xuemai_val,lsData.id,true)then
return
end

local rewards=lingshouModel:getQianLiReturn(guid)
if rewards~=nil then
local args={
title='真灵觉醒',
desc1='是否进行真灵觉醒？',
desc2='(已培养潜力的灵兽在觉醒时会返回已消耗的材料)',
rewards=rewards,
rewardTitle='将获得以下材料',
showCancel=true,
cancelName=nil,
commitName='觉醒',
cancelCB=nil,
commitCB=function()
lingshouController:reqAwake(guid)
end,
}
UIManager:showWindow('UIDialougeRewardWin',args)
else
lingshouController:reqAwake(guid)
end
end