







def_class("UIMysterySkillSelectWin",UIWindowBase)









function UIMysterySkillSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.close2Button=UIButton.get(self,1)
self.ListPanel=UIObject.get(self,2)
self.fg1=UIObject.get(self,3)
self.fg2=UIObject.get(self,4)
self.fg3=UIObject.get(self,5)
self.selectSkill=UIObject.get(self,6)

self.close2Button:setButtonClick(function()self:onClose2Button()end)



end


function UIMysterySkillSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.close2Button);self.close2Button=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.fg1);self.fg1=nil;
_UIObject_release(self.fg2);self.fg2=nil;
_UIObject_release(self.fg3);self.fg3=nil;
_UIObject_release(self.selectSkill);self.selectSkill=nil;
end


















local widgetList=
{
name=0,
desc=1,
select=2,
count=3,
cost=4,
icon=5,
moneyicon=6,
lockTxt=7,
lockBg=8,
lockImg=9,
countbg=10,
costbg=11,
}

local selectNum=0
local maxSelect=3
local _this=nil

function UIMysterySkillSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.ListPanel:setChildScrollViewInit(0.5,true,function(...)self:onScrollItemClick(...)end)
self.selectSkill:setChildLayoutGroupCreateItems(3)
local grids=self.selectSkill:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildButtonClick(2,function()
self.onLayoutItemClick(i)
end)
end

end


function UIMysterySkillSelectWin:__delete()
self:unbindComponents()
_this=nil

end




function UIMysterySkillSelectWin:onShow(argtable,afterOnloaded)
self.lockList={}
MysteryModel.data.tempSkillSelectSlot={}

if argtable then
self.fbid=argtable[1]
self.cfg=cfgHelper.get(cfg_secretscenefubenconfig_get,self.fbid)
local mustUseSkill=self.cfg.mustUseSkill or{}
self.mustUseSkill=mustUseSkill
self.mustList={}
selectNum=0

for i,v in pairs(mustUseSkill)do
MysteryModel.data.tempSkillSelectSlot[i]=v[1]
self.mustList[v[1]]=v[2]
selectNum=selectNum+1
end


local skillList=MysteryModel:getTempSkillData(self.fbid)
if skillList and next(skillList)then


for i,v in ipairs(skillList)do
if not self.mustList[v.param_1]then
table.insert(MysteryModel.data.tempSkillSelectSlot,v.param_1)
selectNum=selectNum+1
end
end
self.lockList=skillList

end
end

local weakGuide=3510
local isGuide=userActorSetting.get(FMT.fmt("weakGuide_{0}",weakGuide),0)
if isGuide~=1 then
weakGuideController:beginGuide(weakGuide)
userActorSetting.flushVal(FMT.fmt("weakGuide_{0}",weakGuide),1)
end

local environmentEffect=MysteryModel:get_mysteryFB_environmentEffect(self.fbid)or{}
self.silent=mysteryEnvironmentEffectModel.haveType(eEnvironmentEffect.eSilent,environmentEffect)

self:initSkillList()
self:refreshSelectSkillList()
end

function UIMysterySkillSelectWin:initSkillList()
if not self.fbid then
return
end

local skillList=self.cfg.skill

local unlockList={}
local lockList={}
for i,skillId in ipairs(skillList)do
local skillCfg=mysterySkillModel.get_skill_config(skillId)
local needUnlock=skillCfg.unlock and skillCfg.unlock==1
if needUnlock and not QianJiGeModel:is_skill_unlock(skillId)and not self.mustList[skillId]then
table.insert(lockList,skillId)
else
table.insert(unlockList,skillId)
end
end

for i,v in ipairs(lockList)do
table.insert(unlockList,v)
end

self.skillList=unlockList

local dataNum=#self.skillList

self.ListPanel:setChildScrollViewCreateGrids(dataNum,1)

local grids=self.ListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local skillId=self.skillList[i]
local skillCfg=mysterySkillModel.get_skill_config(skillId)
local item=grids[i-1]
item:SetChildText(widgetList.name,skillCfg.name)
local needUnlock=skillCfg.unlock and skillCfg.unlock==1 and not self.mustList[skillId]
local isLock=needUnlock and not QianJiGeModel:is_skill_unlock(skillId)
if skillCfg.times then
local times=skillCfg.times+mysterySkillModel:get_add_count()
local skillLockIndex=self:getSkillLock(skillId)
if self.mustList[skillId]and not isLock then
if self.mustList[skillId]>=999 then
item:SetChildText(widgetList.count,"")
else
item:SetChildText(widgetList.count,FMT.fmt("使用次数:<color=#549327>{0}（每次进入恢复）</color>",self.mustList[skillId]))
end
else
if skillLockIndex then
times=self.lockList[skillLockIndex].param_2
item:SetChildText(widgetList.count,FMT.fmt("剩余次数:<color=#549327>{0}</color>",times))
else
item:SetChildText(widgetList.count,FMT.fmt("使用次数:<color=#549327>{0}</color>",times))
end
end

item:SetChildActive(widgetList.countbg,true)
else
item:SetChildActive(widgetList.countbg,false)
item:SetChildText(widgetList.count,FMT.fmt(""))
end
item:SetChildText(widgetList.desc,skillCfg.desc)

if skillCfg.useres then
item:SetChildActive(widgetList.costbg,true)
local name=""
if moneyConfig.isMoney(skillCfg.useres[1][1])then
name=moneyModel.getMoneyName(skillCfg.useres[1][1])
else
name=itemsConfig.getItemName(skillCfg.useres[1][1])
end

item:SetChildText(widgetList.cost,skillCfg.useres[1][2])

local itemicon=iconHelper.getIconName(skillCfg.useres[1][1])
item:SetChildCSImageIcon(widgetList.moneyicon,itemicon,false)
else
item:SetChildActive(widgetList.costbg,false)
end
item:SetChildActive(widgetList.select,self:getSelectSkillIndex(skillId)~=nil and(not isLock))
item:SetChildCSImageIcon(widgetList.icon,skillCfg.icon,false)


item:SetChildActive(widgetList.lockImg,isLock)
item:SetChildImageExGray(widgetList.icon,isLock)
item:SetChildActive(widgetList.lockBg,isLock)
item:SetChildText(widgetList.lockTxt,isLock and"[千机阁解锁]"or"")
end
end

function UIMysterySkillSelectWin:getSelectSkillIndex(skillId)
if MysteryModel.data.tempSkillSelectSlot then
for i,v in ipairs(MysteryModel.data.tempSkillSelectSlot)do
if skillId==v then
return i
end
end
end
end

function UIMysterySkillSelectWin:getSkillLock(skillId)
for i,v in pairs(self.lockList)do
if skillId==v.param_1 then
return i
end
end
end

function UIMysterySkillSelectWin:getSkillLockByIndex(index)
local skillList=self.skillList
local skillId=skillList[index+1]
if skillId then
return self:getSkillLock(skillId)
end
end

function UIMysterySkillSelectWin:onScrollItemClick(id,index)
if self.silent then
UIManager.info("该秘境无法使用探索技能")
return
end

local skillList=self.skillList
local skillId=skillList[index+1]
local skillCfg=mysterySkillModel.get_skill_config(skillId)

local needUnlock=skillCfg.unlock and skillCfg.unlock==1 and not self.mustList[skillId]
if needUnlock and not QianJiGeModel:is_skill_unlock(skillId)then
return
end
local grid=self.ListPanel:getChildScrollViewItemWidget(index)
local selectIndex=self:getSelectSkillIndex(skillId)
if selectIndex then
if self.mustList[skillId]then
UIManager.error('默认技能无法更改')
return
end

if self:getSkillLock(skillId)then
UIManager.error('技能已锁定')
return
end
selectNum=selectNum-1
table.remove(MysteryModel.data.tempSkillSelectSlot,selectIndex)
if grid then
grid:SetChildActive(2,false)
end
self:refreshSelectSkillList()
else
if selectNum<maxSelect then
selectNum=selectNum+1
table.insert(MysteryModel.data.tempSkillSelectSlot,skillId)
if grid then
grid:SetChildActive(2,true)
end
self:refreshSelectSkillList()
end
end
end

function UIMysterySkillSelectWin:refreshSelectSkillList()
local grids=self.selectSkill:getChildLayoutGroupGridList()
local selectList=MysteryModel:getTempSkillSelectSlot()

local count=grids.Count
for i=1,count do
local skillId





skillId=selectList[i]
local item=grids[i-1]
if self.silent then
item:SetChildActive(0,false)
item:SetChildText(1,"<color=#65615f>已禁用</color>")
item:SetChildActive(3,true)
item:SetChildActive(4,false)
else
item:SetChildActive(3,false)
item:SetChildActive(4,true)
if skillId then
local skillCfg=mysterySkillModel.get_skill_config(skillId)
item:SetChildActive(0,true)
item:SetChildCSImageIcon(0,skillCfg.icon,false)
item:SetChildText(1,skillCfg.name)
item:SetChildActive(5,self:getSkillLock(skillId)~=nil and not self.mustList[skillId])
local needUnlock=skillCfg.unlock and skillCfg.unlock==1
local isLock=needUnlock and not QianJiGeModel:is_skill_unlock(skillId)and not self.mustList[skillId]
item:SetChildImageExGray(0,isLock or false)
else
item:SetChildActive(0,false)
item:SetChildText(1,"<color=#65615f>可添加</color>")
end
end
end
end

function UIMysterySkillSelectWin.onLayoutItemClick(id)

if not MysteryModel:is_have_team()then
_this.root:setActive(true)

if _this.rootState then
local tips=nil
local skillId=MysteryModel.data.tempSkillSelectSlot[id]
if skillId then
if _this.mustList[skillId]then
tips='默认技能无法更改'
end
end
if _this:getSkillLockByIndex(id-1)then
if not tips then
tips='技能已锁定'
end
end
if tips then
UIManager.error(tips)
end
end

_this.rootState=true

timeEventController.delayDo(0.2,function()
local weakGuide=3511
local isGuide=userActorSetting.get(FMT.fmt("weakGuide_{0}",weakGuide),0)
if isGuide~=1 then
weakGuideController:beginGuide(weakGuide)
userActorSetting.flushVal(FMT.fmt("weakGuide_{0}",weakGuide),1)
end
end)
else
UIManager.error("秘境探索时无法更改技能")
end
end

function UIMysterySkillSelectWin:onClose2Button()
self.root:setActive(false)
self.rootState=false
end


function UIMysterySkillSelectWin:OnEnable()

end


function UIMysterySkillSelectWin:OnDisable()

end


