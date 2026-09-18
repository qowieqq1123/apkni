







def_class("UILingShouYSFbainyiWin",UIWindowBase)









function UILingShouYSFbainyiWin:bindComponents()

self.root=UIObject.get(self,0)
self.name=UIText.get(self,1)
self.icon=UIImage.get(self,2)
self.byimg=UIObject.get(self,3)
self.baseSkillGrid=UIObject.get(self,4)
self.talentSkillItem=UIObject.get(self,5)
self.spine=UIObject.get(self,6)



end


function UILingShouYSFbainyiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.byimg);self.byimg=nil;
_UIObject_release(self.baseSkillGrid);self.baseSkillGrid=nil;
_UIObject_release(self.talentSkillItem);self.talentSkillItem=nil;
_UIObject_release(self.spine);self.spine=nil;
end
















local _this
local abname='ui/windows/lingshou/lingshouxuemai_atlas_pak.ab'



function UILingShouYSFbainyiWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UILingShouYSFbainyiWin:__delete()
self:unbindComponents()
_this=nil
end




function UILingShouYSFbainyiWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.spine:setChildUIModelShowTarget(5906,1,{},eAnimationID.enter)
self:delayDo(0.4,function()
if _this==nil then return end
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end)
self.lsid=argtable.lsid
if not self.lsid then
logErr('传入的灵兽id为nil')
return
end
self.config=cfgHelper.get(cfg_lingshouconfig_get,self.lsid)


self:freshinfo()
end


function UILingShouYSFbainyiWin:onHide()

end


function UILingShouYSFbainyiWin:freshinfo()

local name=self.config.name or''
self.name:setText(name)


local icon=self.config.ysfbianyi or'image_yushoufang_tj6'
self.icon:setSprite(abname,icon,false)


local skillList=lingshouModel.getSkillListEx(self.lsid,1,1,1,1,1)
if not skillList then
skillList={}
end
self:refreshSkillGrid(self.baseSkillGrid,skillList,eSkillTipsType.eLSSkill)


local tianfu=self.config.tianfu
local tianfu_skill_id=tianfu[1][1]
local talentSkillList={}
if tianfu_skill_id~=nil then
local level=1
local talentSkillId=tianfu_skill_id
if talentSkillId>0 then

table.insert(talentSkillList,{talentSkillId,level})
end
end
local talentSkill=talentSkillList[1]
local hasTalentSkill=talentSkill~=nil
if hasTalentSkill then
local talentSkillId=talentSkill[1]
local talentSkillLv=talentSkill[2]
local talentSkillItem=self.talentSkillItem:getWidgetBase()
self:refreshSkillItem(talentSkillItem,talentSkillId,talentSkillLv,false,eSkillTipsType.eLSTalentSkill,1)
end
end


function UILingShouYSFbainyiWin:refreshSkillGrid(skillGrid,skilList,st)
skillGrid:setChildLayoutGroupCreateItems(#skilList)
local gridlist=skillGrid:getChildLayoutGroupGridList()
local c=gridlist.Count
if c>0 then
for i=1,c do
local item=gridlist[i-1]
local d=skilList[i]
local skillID=d[1]
local skillLv=d[2]
local unlock=d[3]
local nSkillLv=d[4]
self:refreshSkillItem(item,skillID,skillLv,unlock,st,nSkillLv)
end
end
end
function UILingShouYSFbainyiWin:refreshSkillItem(item,skillId,skillLv,unlock,st,nSkillLv)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if not skillCfg then
logErr(FMT.fmt("找不到技能{0}对应的技能配置 请检查灵兽技能配置与数据是否正确",skillId))
return
end
local islock=false

item:SetChildText(11,skillCfg.name)

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

local showLevel=false
if st==eSkillTipsType.eLSTalentSkill then

showLevel=false
end
item:SetChildActive(4,showLevel)
if showLevel then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end

item:SetChildActive(5,islock)

item:SetChildButtonClick(3,function()
self:onSkillItemClick(st,skillId,skillLv)
end)

item:SetChildActive(7,false)
end
function UILingShouYSFbainyiWin:onSkillItemClick(skillType,skillID,skillLv)
local args={skillID=skillID,skillLv=skillLv,attend=skillType}
self:showWindow('UIDiscipleJobSkillTipsWin',args)
end