







def_class("UIQSSSInfoWin",UIWindowBase)









function UIQSSSInfoWin:bindComponents()

self.skillpanel=UIObject.get(self,0)
self.dbPanel=UIObject.get(self,1)
self.arrowBtn=UIButton.get(self,2)
self.skillitem_1=UIObject.get(self,3)
self.skillitem_2=UIObject.get(self,4)
self.skillitem_3=UIObject.get(self,5)
self.skillitem_4=UIObject.get(self,6)
self.skillitem_5=UIObject.get(self,7)
self.daobing=UIObject.get(self,8)

self.arrowBtn:setButtonClick(function()self:onArrowBtn()end)
self.skillitem={
self.skillitem_1,
self.skillitem_2,
self.skillitem_3,
self.skillitem_4,
self.skillitem_5,
}



end


function UIQSSSInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skillpanel);self.skillpanel=nil;
_UIObject_release(self.dbPanel);self.dbPanel=nil;
_UIObject_release(self.arrowBtn);self.arrowBtn=nil;
_UIObject_release(self.skillitem_1);self.skillitem_1=nil;
_UIObject_release(self.skillitem_2);self.skillitem_2=nil;
_UIObject_release(self.skillitem_3);self.skillitem_3=nil;
_UIObject_release(self.skillitem_4);self.skillitem_4=nil;
_UIObject_release(self.skillitem_5);self.skillitem_5=nil;
_UIObject_release(self.daobing);self.daobing=nil;
self.skillitem=nil;
end



















function UIQSSSInfoWin:onLoaded(...)
self:bindComponents()

self.skillPanelHeight=self.skillpanel:getChildSizeDeltaY()
self.skillpanel:setChildSizeDelta(130,self.skillPanelHeight)
self.showAllSkill=false
end


function UIQSSSInfoWin:__delete()
self:unbindComponents()
end




function UIQSSSInfoWin:onShow(argtable,afterOnloaded)
local cfg=activitiesModel:getSubActivityConfig(argtable.subType,argtable.subId)
local data=cfg.dzlist[argtable.index]
local gflist=data.gongfa
self:setSkillItemList(gflist)
self:setDaoBing(data.daobing)
end

function UIQSSSInfoWin:setDaoBing(dbData)
local widget=self.daobing:getChildWidgetBase()
local itemId=dbData[1]
local star=dbData[2]
local level=dbData[3]
local levelStr
if level>0 then
levelStr=FMT.fmt('+{0}',level)
else
levelStr=''
end
local clickFunc=function()
local attach={starlv=star,jllv=level}
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight,attach=attach})
end
widgetHelper.setNormalRewardItem(widget,0,{itemId,0,countText=levelStr,clickFunc=clickFunc})

local sw=widget:GetChildWidgetBase(1)
for i=1,5 do
sw:SetChildActive(i-1,i<=star)
end
end

function UIQSSSInfoWin:setSkillItemList(gflist)
local skillList=self:getGFSkillList(gflist)
self.skillNum=#skillList
for i,v in ipairs(self.skillitem)do
local item=v:getChildWidgetBase()
local d=skillList[i]
if d then
v:setActive(true)
local skillID=d[1]
local skillLv=d[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

item:SetChildActive(4,not islock)
if not islock then
local c_skillLv=skillLv



item:SetChildText(2,skillModel:getSkillLvStr(c_skillLv))
end

item:SetChildActive(5,islock)

item:SetChildButtonClick(3,function()
self:onSkillItemClick(skillID,skillLv)
end)
else
v:setActive(false)
end
end
end

function UIQSSSInfoWin:onSkillItemClick(skillID,skillLv)
local args={skillID=skillID,skillLv=skillLv,attend=eSkillTipsType.eDZGFSkill,dis_guid=nil,changLv=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end

function UIQSSSInfoWin:getGFSkillList(gflist)
local result={}
for i,v in ipairs(gflist)do
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,v[1])
local levels=cfg.level
local level=levels[v[2]]
local skills=cfg.skill
for i1,skillID in ipairs(skills)do
local lv=level[i1]
result[#result+1]={skillID,lv}
end
end
return result
end


function UIQSSSInfoWin:onHide()

end




function UIQSSSInfoWin:onArrowBtn()
self.showAllSkill=not self.showAllSkill
local size
if self.showAllSkill then
self.arrowBtn:setScale(Vector3.New(-1,1,1))
size=Vector2.New(130+(self.skillNum-1)*90,self.skillPanelHeight)
else
self.arrowBtn:setScale(Vector3.New(1,1,1))
size=Vector2.New(130,self.skillPanelHeight)
end
self.arrowBtn:setActive(false)
self.skillpanel:setChildDOSizeDelta(size,0.5,function()
self.arrowBtn:setActive(true)
end)
end