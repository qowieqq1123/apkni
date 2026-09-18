







def_class("UIXianMoZhuanZhi_daoHengShuWin",UIWindowBase)









function UIXianMoZhuanZhi_daoHengShuWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.curDaoHeng=UIText.get(self,1)
self.daoHengShuContent=UIObject.get(self,2)
self.jindu=UIObject.get(self,3)
self.skillDesc_1=UIText.get(self,4)
self.skillDesc_2=UIText.get(self,5)
self.skillDesc_3=UIText.get(self,6)
self.skillIcon_1=UIImage.get(self,7)
self.skillIcon_2=UIImage.get(self,8)
self.skillIcon_3=UIImage.get(self,9)
self.skillLevel_1=UIText.get(self,10)
self.skillLevel_2=UIText.get(self,11)
self.skillLevel_3=UIText.get(self,12)
self.skillName_1=UIText.get(self,13)
self.skillName_2=UIText.get(self,14)
self.skillName_3=UIText.get(self,15)
self.skillNextLevel_1=UIText.get(self,16)
self.skillNextLevel_2=UIText.get(self,17)
self.skillNextLevel_3=UIText.get(self,18)
self.vocSkillTitle=UIText.get(self,19)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.skillDesc={
self.skillDesc_1,
self.skillDesc_2,
self.skillDesc_3,
}
self.skillIcon={
self.skillIcon_1,
self.skillIcon_2,
self.skillIcon_3,
}
self.skillLevel={
self.skillLevel_1,
self.skillLevel_2,
self.skillLevel_3,
}
self.skillName={
self.skillName_1,
self.skillName_2,
self.skillName_3,
}
self.skillNextLevel={
self.skillNextLevel_1,
self.skillNextLevel_2,
self.skillNextLevel_3,
}



end


function UIXianMoZhuanZhi_daoHengShuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.curDaoHeng);self.curDaoHeng=nil;
_UIObject_release(self.daoHengShuContent);self.daoHengShuContent=nil;
_UIObject_release(self.jindu);self.jindu=nil;
_UIObject_release(self.skillDesc_1);self.skillDesc_1=nil;
_UIObject_release(self.skillDesc_2);self.skillDesc_2=nil;
_UIObject_release(self.skillDesc_3);self.skillDesc_3=nil;
_UIObject_release(self.skillIcon_1);self.skillIcon_1=nil;
_UIObject_release(self.skillIcon_2);self.skillIcon_2=nil;
_UIObject_release(self.skillIcon_3);self.skillIcon_3=nil;
_UIObject_release(self.skillLevel_1);self.skillLevel_1=nil;
_UIObject_release(self.skillLevel_2);self.skillLevel_2=nil;
_UIObject_release(self.skillLevel_3);self.skillLevel_3=nil;
_UIObject_release(self.skillName_1);self.skillName_1=nil;
_UIObject_release(self.skillName_2);self.skillName_2=nil;
_UIObject_release(self.skillName_3);self.skillName_3=nil;
_UIObject_release(self.skillNextLevel_1);self.skillNextLevel_1=nil;
_UIObject_release(self.skillNextLevel_2);self.skillNextLevel_2=nil;
_UIObject_release(self.skillNextLevel_3);self.skillNextLevel_3=nil;
_UIObject_release(self.vocSkillTitle);self.vocSkillTitle=nil;
self.skillDesc=nil;
self.skillIcon=nil;
self.skillLevel=nil;
self.skillName=nil;
self.skillNextLevel=nil;
end



















function UIXianMoZhuanZhi_daoHengShuWin:onLoaded(...)
self:bindComponents()
end


function UIXianMoZhuanZhi_daoHengShuWin:__delete()
self:unbindComponents()
end




function UIXianMoZhuanZhi_daoHengShuWin:onShow(argtable,afterOnloaded)
self.dis_guid=argtable
self.voc=UIDiscipleModel:getDiscipleJob(self.dis_guid)
self.type=UIDiscipleModel:getDiscipleXianMoVoc(self.dis_guid)
self.cfg=cfgHelper.get2(cfg_discipledaohengtreeconfig_get,self.type,self.voc)
self.daoHeng=UIDiscipleModel:getDiscipleDaoHeng(self.dis_guid)
self.xinFaLevel=UIDiscipleModel:getDiscipleXinFaLevel(self.dis_guid)
local vocCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,self.voc)
local xm_name=vocCfg.xm_name[self.type]
self.vocSkillTitle:setText(string.format("%s技能预览",xm_name))
self:refreshDaoHengShu()
self:refreshSkillPreview()

local contentHeight=445
local itemHeight=90
local singleStageDaoHeng=self.cfg.client_reward_list[1][1]
local targetIdx=mathHelper.floor(self.daoHeng/singleStageDaoHeng)+1
local jumpY=-(targetIdx*itemHeight)+(contentHeight/2)
self.daoHengShuContent:setChildAnchoredPosition(Vector2(0,jumpY))
end

function UIXianMoZhuanZhi_daoHengShuWin:refreshDaoHengShu()
self.curDaoHeng:setText(string.format("当前道行：%d年",self.daoHeng))

local daoHengShuCfg=self.cfg.client_reward_list
local maxTarget=0
self.daoHengShuContent:setChildLayoutGroupCreateItems(#daoHengShuCfg,function(index)
local item=self.daoHengShuContent:getChildLayoutGroupGridItem(index-1)
local cfg=daoHengShuCfg[index]

local target_daoHeng=cfg[1]
local target_xinFaLevel=cfg[4]or 0
maxTarget=math.max(maxTarget,target_daoHeng)
local isActive=false
if target_xinFaLevel>0 then
isActive=self.daoHeng>target_daoHeng and self.xinFaLevel>=target_xinFaLevel
else
isActive=self.daoHeng>=target_daoHeng and self.xinFaLevel>=target_xinFaLevel
end
item:SetChildActive(0,isActive)

item:SetChildText(1,string.format("道行%d年",target_daoHeng))

local rewardType=cfg[2]
local rewardStr=''
if rewardType==1 then
local attrType,attrValue=unpack(cfg[3])
rewardStr=helper.getAttributeStr(attrType,attrValue,1,self.daoHeng<target_daoHeng and"<color=#8e8c87>{0}+{1}</color>"or"{0}+{1}")
elseif rewardType==2 then
local skillid,skillLevel=unpack(cfg[3])
local skillconfig=cfgHelper.get1(cfg_skillconfig_get,skillid)
local skillName=skillconfig.name
rewardStr=string.format("%s技能：%s",skillLevel>1 and'升级'or'解锁',skillName)
if not isActive then
rewardStr=string.format("<color=#8e8c87>%s</color>",rewardStr)
end
if skillconfig then
local icon=iconHelper.getSkillIcon(skillconfig.icon)
item:SetChildIcon(5,icon,false)
item:SetChildImageExGray(5,not isActive)
end
end
item:SetChildText(2,rewardStr)
if target_xinFaLevel>0 then
item:SetChildActive(3,true)


else
item:SetChildActive(3,false)
end
end)
self.jindu:setChildIconFillAmount(self.daoHeng/maxTarget)
end

function UIXianMoZhuanZhi_daoHengShuWin:refreshSkillPreview()
local skillCfg=self.cfg.client_skill_preview
for i=1,3 do
if skillCfg[i]then
local cfg=skillCfg[i]
local skillid,daoHengCfg=cfg[1],cfg[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillid)
local icon=iconHelper.getSkillIcon(skillCfg.icon)

self.skillIcon[i]:setChildIcon(icon,false)

local level=0
local nextDaoHeng=0
for i,v in ipairs(daoHengCfg)do
if self.daoHeng>v then
level=i
else
nextDaoHeng=v
break
end
end

self.skillIcon[i]:setChildImageExGray(level<=0)

self.skillName[i]:setText(level<=0 and string.format('<color=#8e8c87>%s</color>',skillCfg.name)or skillCfg.name)
self.skillLevel[i]:setActive(level>0)
self.skillNextLevel[i]:setActive(level<=0)
self.skillLevel[i]:setText(string.format('%d级',level))

self.skillNextLevel[i]:setText(level<=0 and string.format('<color=#8e8c87>(道行%d年突破后解锁)</color>',nextDaoHeng)or"")

local desc=skillModel:getSkillDesc(skillid,level)
local descEx=nil
local str=desc
if descEx then
str=string.format("%s\n%s",desc,table.concat(descEx,"\n"))
end
self.skillDesc[i]:setText(level<=0 and string.format('<color=#8e8c87>%s</color>',str)or str)
end
end
end

function UIXianMoZhuanZhi_daoHengShuWin:onCloseBtn()
self:closeSelf()
end