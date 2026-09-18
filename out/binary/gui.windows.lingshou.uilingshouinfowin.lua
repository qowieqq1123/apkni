







def_class("UILingShouInfoWin",UIWindowBase)









function UILingShouInfoWin:bindComponents()

self.attrGrid=UIObject.get(self,0)
self.baseSkillGrid=UIObject.get(self,1)
self.descListPanel=UIObject.get(self,2)
self.jingjieText=UIText.get(self,3)
self.qianliBtn=UIButton.get(self,4)
self.qianLiRedDot=UIObject.get(self,5)
self.qianliText=UIText.get(self,6)
self.raceText=UIText.get(self,7)
self.reduceZiZhi=UIObject.get(self,8)
self.root=UIObject.get(self,9)
self.sexText=UIText.get(self,10)
self.talentSkillItem=UIObject.get(self,11)
self.talentSkillPanel=UIObject.get(self,12)
self.xuemaiBtn=UIButton.get(self,13)
self.xuemaiText=UIText.get(self,14)
self.zizhiText=UIText.get(self,15)
self.fanyanText=UIText.get(self,16)
self.elementText=UIText.get(self,17)
self.attrHelpBtn=UIButton.get(self,18)
self.xinqingText=UIText.get(self,19)

self.qianliBtn:setButtonClick(function()self:onQianliBtn()end)

self.xuemaiBtn:setButtonClick(function()self:onXuemaiBtn()end)

self.attrHelpBtn:setButtonClick(function()self:onAttrHelpBtn()end)



end


function UILingShouInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.baseSkillGrid);self.baseSkillGrid=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.jingjieText);self.jingjieText=nil;
_UIObject_release(self.qianliBtn);self.qianliBtn=nil;
_UIObject_release(self.qianLiRedDot);self.qianLiRedDot=nil;
_UIObject_release(self.qianliText);self.qianliText=nil;
_UIObject_release(self.raceText);self.raceText=nil;
_UIObject_release(self.reduceZiZhi);self.reduceZiZhi=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sexText);self.sexText=nil;
_UIObject_release(self.talentSkillItem);self.talentSkillItem=nil;
_UIObject_release(self.talentSkillPanel);self.talentSkillPanel=nil;
_UIObject_release(self.xuemaiBtn);self.xuemaiBtn=nil;
_UIObject_release(self.xuemaiText);self.xuemaiText=nil;
_UIObject_release(self.zizhiText);self.zizhiText=nil;
_UIObject_release(self.fanyanText);self.fanyanText=nil;
_UIObject_release(self.elementText);self.elementText=nil;
_UIObject_release(self.attrHelpBtn);self.attrHelpBtn=nil;
_UIObject_release(self.xinqingText);self.xinqingText=nil;
end
















local _this


function UILingShouInfoWin:onLoaded(...)
self:bindComponents()
_this=self

local _recv_19_14=function(guid)
if _this==nil then return end
if _this.ls_guid and mathHelper.compareInt64(_this.ls_guid,guid)then
_this:refreshView()
end
end
self:addProNotify(19,14,_recv_19_14)

local _onLingShouZiZhiRestore=function(lsGuid)
if _this==nil then return end
if _this.ls_guid and mathHelper.compareInt64(_this.ls_guid,lsGuid)then
_this.reduceZiZhi:setActive(false)
end
end
self:addNotify(notifyConfig.onLingShouZiZhiRestore,_onLingShouZiZhiRestore)
self:addNotify(notifyConfig.onLingShouXinQingChanged,self.onLingShouXinQingChange)

reddotClassManager.register_event(REDDIT_SUB_TYPE.sLingShouInfo,self.refreshReddot)
end


function UILingShouInfoWin:__delete()
reddotClassManager.unregister_event(REDDIT_SUB_TYPE.sLingShouInfo,self.refreshReddot)
self:unbindComponents()
end

function UILingShouInfoWin.refreshReddot()
if _this==nil then return end
_this:refreshView()
end


function UILingShouInfoWin:onHide()

end




function UILingShouInfoWin:onShow(argtable,afterOnloaded)
self.ls_guid=argtable.ls_guid
self.preview=argtable.preview
local canvas=argtable.canvas
if canvas then
self.winlua:SetCanvasIndex(-1,canvas)
end

self:refreshView()
end

function UILingShouInfoWin:onChangeLingShou(guid)
self:onShow({ls_guid=guid,preview=self.preview})
end

function UILingShouInfoWin:refreshView()
local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
local lsID=lsData.id
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)

local jj_str=lingshouModel:getJJName(guid,2)
self.jingjieText:setText(FMT.fmt('境界：<color=#000000>{0}</color>',jj_str))

self.xuemaiText:setText(FMT.fmt('血脉：<color=#000000>{0}</color>',lingshouModel:switchLevelToStageName_XueMai(lsData.xuemai_val)))

self.zizhiText:setText(FMT.fmt('资质：<color=#000000>{0}</color>',lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)))
self.reduceZiZhi:setActive(lingshouModel:checkLingshouZiZhiIsReduce(guid))

local ql_str=lingshouModel:getQianLiDesc(guid)
self.qianliText:setText(FMT.fmt('潜力：<color=#000000>{0}</color>',ql_str))


local element=lscfg.element
local elementName=ELEMENT_TYPE.getName(element)


local race_str=cfgHelper.get2(cfg_lingshouraceconfig_get,lscfg.race,'name')
self.raceText:setText(FMT.fmt('种族：<color=#000000>{0}·{1}</color>',race_str,elementName))


self.sexText:setText(FMT.fmt('性别：<color=#000000>{0}</color>',SEX_TYPE.getName2(lsData.sex)))


local xqValue=lingshouModel:getLSXinQingValueEx(lsData)
self.xinqingText:setText(FMT.fmt('心情：<color=#000000>{0}</color>',math.floor(xqValue)))


local fanyanCount=lsData.born_times or 0
self.fanyanText:setText(FMT.fmt('繁衍次数：<color=#000000>{0}</color>',fanyanCount))





local attrsShow={eAttributeType.eATK,eAttributeType.eDEF,eAttributeType.eHP}
local attrlist=lingshouModel:getAttrListByType(guid,attrsShow,true,1)
local num=#attrlist
self.attrGrid:setChildLayoutGroupCreateItems(num)
local gridlist=self.attrGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
local attr=attrlist[i]
local attrType=attr[1]
local value=attr[2]
if value<0 then
value=0
end
local color_str='{0}：<color=#000000>{1}</color>'
item:SetChildText(0,helper.getAttributeStr(attrType,value,nil,color_str))
end


local talentSkillList=lingshouModel:getTalentSkillList(guid)or defaultT

local talentSkill=talentSkillList[1]
local hasTalentSkill=talentSkill~=nil











local skillList=lingshouModel:getSkillList(guid)
if hasTalentSkill then
talentSkill.isTalentSkill=true
table.insert(skillList,1,talentSkill)
end
self:refreshSkillGrid(self.baseSkillGrid,skillList,eSkillTipsType.eLSSkill)



self.desclist=lingshouModel:getLsSortWordListEx(lsData)
local dataNum=self.desclist and#self.desclist or 0
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local descGrids=self.descListPanel:getChildLayoutGroupGridList()
local count=descGrids.Count
if count>0 then
for i=1,count do
local wordData=self.desclist[i]
local wordId=wordData.wordId
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordId)
local item=descGrids[i-1]
if cfg then
item:SetChildActive(-1,true)
lingshouModel.refreshSpecialityItem(item,cfg,function()
self:onDescSlotClick(i)
end)
else
item:SetChildActive(-1,false)
end
end
end


self:refreshTipsRedDot(guid)

self.qianliBtn:setActive(not self.preview)
end

function UILingShouInfoWin:refreshTipsRedDot(guid)

local canBeImproved=lingshouModel:checkLSqianliReddot(self.ls_guid)
self:doReddotPunchRotation(canBeImproved)
self.qianLiRedDot:setActive(canBeImproved)
end

function UILingShouInfoWin:refreshSkillGrid(skillGrid,skilList)
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
local isTalentSkill=d.isTalentSkill or false
local st=isTalentSkill and eSkillTipsType.eLSTalentSkill or eSkillTipsType.eLSSkill
self:refreshSkillItem(item,skillID,skillLv,unlock,st,nSkillLv)
end
end
end

function UILingShouInfoWin:refreshSkillItem(item,skillId,skillLv,unlock,st,nSkillLv)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if not skillCfg then
logErr(FMT.fmt("找不到技能{0}对应的技能配置 请检查灵兽技能配置与数据是否正确",skillId))
return
end

local isTalentSkill=st==eSkillTipsType.eLSTalentSkill

item:SetChildActive(8,isTalentSkill)

item:SetChildActive(9,isTalentSkill)

item:SetChildActive(10,not isTalentSkill)

local islock=not unlock and not isTalentSkill

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

local showLevel=not islock and not isTalentSkill
item:SetChildActive(4,showLevel)
if showLevel then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end

item:SetChildActive(5,islock)

item:SetChildButtonClick(3,function()
self:onSkillItemClick(st,skillId,skillLv)
end)
local reddot=lingshouModel:checkIsMainSkill(self.ls_guid,skillId)and lingshouModel:getMainSkillReddot(self.ls_guid)
item:SetChildActive(7,reddot)
end

function UILingShouInfoWin:onSkillItemClick(skillType,skillID,skillLv)
if lingshouModel:checkIsMainSkill(self.ls_guid,skillID)then
if self.preview then
local args={skillID=skillID,skillLv=skillLv,attend=skillType,lsGuid=self.ls_guid}
self:showWindow('UIDiscipleJobSkillTipsWin',args)
else
local args={lsGuid=self.ls_guid,skillID=skillID}
self:showWindow('UILingShouSkillUpWin',args)
end
else
local args={skillID=skillID,skillLv=skillLv,attend=skillType,lsGuid=self.ls_guid}
self:showWindow('UIDiscipleJobSkillTipsWin',args)
end
end

function UILingShouInfoWin:onDetailClick()
self:showWindow('UILingShouAttrDetailWin',{guid=self.ls_guid})
end

function UILingShouInfoWin:rec_awake(guid)
self:onShow({ls_guid=guid})
end

function UILingShouInfoWin:onDescSlotClick(idx)
local wordData=self.desclist[idx]
local wordId=wordData.wordId
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordId)
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)

self:showWindow('UILingShouSpecialityWin',{item=item,node='top',guid=self.ls_guid,config=cfg,pivot=Vector2(0.5,0)})







end

function UILingShouInfoWin:onXuemaiBtn()


end

function UILingShouInfoWin:onQianliBtn()


local args={
titleName="灵兽潜力",
extraWin="UILingShouQianLiUpgradeWin",
extraParams={
selectedLingShouGuid=self.ls_guid,
closeCallback=function()
_this:refreshView()
end
},
}
UIManager:showWindow("UICommonPageThreeWin",args)

end

function UILingShouInfoWin:doReddotPunchRotation(isreddot)
if isreddot then
if self.reddotTweener==nil then
self.qianLiRedDot:setRotation(0,0,0)
local tweener=self.qianLiRedDot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.qianLiRedDot:setRotation(0,0,0)
end
end
end

function UILingShouInfoWin:onAttrHelpBtn()
local offset=Vector2.New(16,-25)

local desc_str=cfgHelper.getlang('ls_two_attrs_tips')
UIManager:showWindow('UIConditionTipsOne',{showType=4,str=desc_str,posItem=self.attrHelpBtn,pos=offset})
end

function UILingShouInfoWin.onLingShouXinQingChange(guid,old_value,new_value)
if not _this or not _this.isVisible then return end
if _this.ls_guid and mathHelper.compareInt64(_this.ls_guid,guid)then
_this:refreshView()
end
end