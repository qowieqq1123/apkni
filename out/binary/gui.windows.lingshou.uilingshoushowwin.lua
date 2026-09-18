







def_class("UILingShouShowWin",UIWindowBase)









function UILingShouShowWin:bindComponents()

self.fightTx=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.modelShow=UIObject.get(self,2)
self.byTag=UIObject.get(self,3)
self.nameTx=UIText.get(self,4)
self.getted=UIObject.get(self,5)
self.talentGrid=UIObject.get(self,6)
self.baseSkillGrid=UIObject.get(self,7)
self.zizhiTx=UIText.get(self,8)
self.qianliTx=UIText.get(self,9)
self.raceTx=UIText.get(self,10)
self.xuemaiTx=UIText.get(self,11)
self.sexTx=UIText.get(self,12)
self.daishuTx=UIText.get(self,13)
self.jjTx=UIText.get(self,14)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UILingShouShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fightTx);self.fightTx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.modelShow);self.modelShow=nil;
_UIObject_release(self.byTag);self.byTag=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.getted);self.getted=nil;
_UIObject_release(self.talentGrid);self.talentGrid=nil;
_UIObject_release(self.baseSkillGrid);self.baseSkillGrid=nil;
_UIObject_release(self.zizhiTx);self.zizhiTx=nil;
_UIObject_release(self.qianliTx);self.qianliTx=nil;
_UIObject_release(self.raceTx);self.raceTx=nil;
_UIObject_release(self.xuemaiTx);self.xuemaiTx=nil;
_UIObject_release(self.sexTx);self.sexTx=nil;
_UIObject_release(self.daishuTx);self.daishuTx=nil;
_UIObject_release(self.jjTx);self.jjTx=nil;
end
















local _this=nil




function UILingShouShowWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UILingShouShowWin:__delete()
self:unbindComponents()
_this=nil
end




function UILingShouShowWin:onShow(argtable,afterOnloaded)
if not argtable then
return self:closeSelf()
end
self.data=lingshouModel:getLingShouData(argtable)

local modelParams=lingshouModel.getModelParamsEx(self.data.cfg.model)
local fight=lingshouModel.getFightValueEx(self.data)
self.modelShow:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,0,false,true)
self.modelShow:setChildUIModelShowTargetOffset(0,-350)
self.byTag:setActive(self.data.cfg.bianyi==1)
self.nameTx:setText(self.data.cfg.name)
self.fightTx:setText(fight)

local jj_str=lingshouModel.getJJNameEx(self.data.jj_lvl,4)
self.jjTx:setText(jj_str)
local zz_str=FMT.fmt('资质：{0}',lingshouModel.getLingShouPropertyVal(self.data,lingshouPropertyType.ZIZHI))
self.zizhiTx:setText(zz_str)
local ql_str=FMT.fmt('潜力：{0}',lingshouModel.getQianLiDescEx(lingshouModel.getLingShouPropertyVal(self.data,lingshouPropertyType.QIANLI)))
self.qianliTx:setText(ql_str)
local race_str=FMT.fmt('种族：{0}',cfgHelper.get2(cfg_lingshouraceconfig_get,self.data.cfg.race,'name'))
self.raceTx:setText(race_str)
local xm_str=FMT.fmt('血脉：{0}',lingshouModel.getXueMaiDescEx(self.data.cfg.race,self.data.xuemai_type,self.data.xuemai_val))
self.xuemaiTx:setText(xm_str)
local sex_str=FMT.fmt('性别：{0}',SEX_TYPE.getName2(self.data.sex))
self.sexTx:setText(sex_str)
local ds_str=FMT.fmt('代数：{0}',eNumberType:getName2(self.data.generation))
self.daishuTx:setText(ds_str)
local talentSkillList=lingshouModel.getTalentSkillListEx(self.data)
self:refreshSkillList(self.talentGrid,talentSkillList,eSkillTipsType.eLSTalentSkill)
local skillList=lingshouModel:getSkillList(self.data.guid)
self:refreshSkillList(self.baseSkillGrid,skillList,eSkillTipsType.eLSSkill)

self.animation=true
self.getted:setScale(Vector3.one*10)
self.getted:setChildDOScale(1,1,function()
self.animation=false
end)
end


function UILingShouShowWin:onHide()

end





function UILingShouShowWin:onCloseBtn()
if not self.animation then
self:closeSelf()
end
end

function UILingShouShowWin:refreshSkillList(skillGrid,skilList,st)
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
local islock=skillLv<=0

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

local showLevel=not islock
if st==eSkillTipsType.eLSTalentSkill then

showLevel=false
end
item:SetChildActive(4,showLevel)
if showLevel then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end

item:SetChildActive(5,islock)

item:SetChildButtonClick(3,function()
self:onSkillItemClick(st,skillID,skillLv)
end)
end
end
end

function UILingShouShowWin:onSkillItemClick(skillType,skillID,skillLv)
local args={skillID=skillID,skillLv=skillLv,attend=skillType}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end