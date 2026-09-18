







def_class("UIDouFaTaiRivalAttrDetailWin",UIWindowBase)









function UIDouFaTaiRivalAttrDetailWin:bindComponents()

self.attrCreater2=UIObject.get(self,0)
self.iconCreater=UIObject.get(self,1)
self.attrCreater1=UIObject.get(self,2)
self.contentRoot=UIObject.get(self,3)
self.questionBtn=UIButton.get(self,4)
self.descListPanel=UIObject.get(self,5)

self.questionBtn:setButtonClick(function()self:onQuestionBtn()end)



end


function UIDouFaTaiRivalAttrDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrCreater2);self.attrCreater2=nil;
_UIObject_release(self.iconCreater);self.iconCreater=nil;
_UIObject_release(self.attrCreater1);self.attrCreater1=nil;
_UIObject_release(self.contentRoot);self.contentRoot=nil;
_UIObject_release(self.questionBtn);self.questionBtn=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
end



















function UIDouFaTaiRivalAttrDetailWin:onLoaded(...)
self:bindComponents()
end


function UIDouFaTaiRivalAttrDetailWin:__delete()
self:unbindComponents()
end




function UIDouFaTaiRivalAttrDetailWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.attrLookup=argtable.attrLookup

local attrsDetail=cfgHelper.getdef(cfg_attributesconfig,'attrsDetail')
if self.attrLookup~=nil then
self.attrlist2=UIDiscipleModel.getAttrListByType(self.attrLookup,attrsDetail,true,true)
else
if UIDiscipleModel:isMyActorDZ(self.disciple_guid)then
self.attrlist2=UIDiscipleModel:getDiscipleMultipleAttrListByType(self.disciple_guid,attrsDetail,true,true)
else
local dzData=otherPlayerModel:getDZData(self.disciple_guid)
self.attrlist2=UIDiscipleModel.getAttrListByType2(dzData.attrList,attrsDetail,true)
end
end
self.curPage=false
self:refreshQuestionBtn()
self:RefreshAttrList1(true)
self:RefreshAttrList2(true)
self:RefreshSkillList(true)
self:refreshTeZhi()

self.contentRoot:setChildCanvasGroupAlpha(0)
local func=function()
self.contentRoot:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.1,func)
end


function UIDouFaTaiRivalAttrDetailWin:OnEnable()

end


function UIDouFaTaiRivalAttrDetailWin:OnDisable()

end

function UIDouFaTaiRivalAttrDetailWin:RefreshAttrList1(isInit)

if self.attrlist1==nil then
local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
if self.attrLookup~=nil then
self.attrlist1=UIDiscipleModel.getAttrListByType(self.attrLookup,attrsBase,true)
else
if UIDiscipleModel:isMyActorDZ(self.disciple_guid)then
self.attrlist1=UIDiscipleModel:getDiscipleMultipleAttrListByType(self.disciple_guid,attrsBase,true)
else
local dzData=otherPlayerModel:getDZData(self.disciple_guid)
self.attrlist1=UIDiscipleModel.getAttrListByType2(dzData.attrList,attrsBase,true)
end

end
end
local c1=#self.attrlist1
if isInit then
self.attrCreater1:setChildLayoutGroupCreateItems(c1)
end
local gridlist1=self.attrCreater1:getChildLayoutGroupGridList()
for i=1,c1 do
local item=gridlist1[i-1]
local attr=self.attrlist1[i]
local attr_v=attr[2]
if attr_v<0 then
attr_v=0
end
item:SetChildText(0,cfgHelper.get2(cfg_attributesconfig_get,attr[1],'attrname'))
item:SetChildText(1,helper.getAttributeStrEx(attr[1],attr_v))
end
end

function UIDouFaTaiRivalAttrDetailWin:RefreshAttrList2(isInit)

local c2=#self.attrlist2
if isInit then
self.attrCreater2:setChildLayoutGroupCreateItems(c2)
end
local gridlist2=self.attrCreater2:getChildLayoutGroupGridList()
for i=1,c2 do
local item=gridlist2[i-1]
local attr=self.attrlist2[i]
local attrID=attr[1]
local attr_v=attr[2]
if attr_v<0 then
attr_v=0
end
local cfg=cfg_attributesconfig_get(attrID)
item:SetChildText(0,cfg.attrname)
if not self.curPage then
item:SetChildText(1,helper.getAttributeStrEx(attrID,attr_v))
item:SetChildText(2,'')
else
item:SetChildText(1,'')
item:SetChildText(2,cfg.desc or'')
end
end
end

function UIDouFaTaiRivalAttrDetailWin:RefreshSkillList(isInit)
local jobSkillList
if UIDiscipleModel:isMyActorDZ(self.disciple_guid)then
jobSkillList=UIDiscipleModel:getDiscipleJobSkillList(self.disciple_guid)
else
local dzData=otherPlayerModel:getDZData(self.disciple_guid)
local baseData=dzData.base
local groupid=baseData.vocsgidx
local image=UIDiscipleModel.calculationDiscipleImageBase(baseData)
jobSkillList=UIDiscipleModel:getDiscipleJobSkillListEx(groupid,image.job,baseData.jingjielv,baseData)
end
local c3=#jobSkillList
if isInit then
self.iconCreater:setChildLayoutGroupCreateItems(c3)
end
local gridlist3=self.iconCreater:getChildLayoutGroupGridList()
for i=1,c3 do
local item=gridlist3[i-1]
local d=jobSkillList[i]
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
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end

item:SetChildActive(5,islock)

item:SetChildButtonClick(3,function()
self:onSkillItemClick(skillID,skillLv)
end)

end
end

function UIDouFaTaiRivalAttrDetailWin:onSkillItemClick(skillID,skillLv)
if UIDiscipleModel:isMyActorDZ(self.disciple_guid)then
local args={skillID=skillID,skillLv=skillLv,attend=eSkillTipsType.eDZSkill,dis_guid=self.disciple_guid,changLv=true}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
else
local args={skillID=skillID,skillLv=skillLv,attend=eSkillTipsType.eDZSkill,dis_guid=nil,changLv=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end
end

function UIDouFaTaiRivalAttrDetailWin:refreshQuestionBtn()
local iconname
if self.curPage then
iconname='button_tyjieshao_2'
else
iconname='button_tyjieshao_1'
end
self.questionBtn:setSprite(globalABLookup.global,iconname)
end

function UIDouFaTaiRivalAttrDetailWin:onQuestionClick()
self.curPage=not self.curPage
self:refreshQuestionBtn()
self:RefreshAttrList2()
end

function UIDouFaTaiRivalAttrDetailWin:refreshTeZhi()
local list
local netData
if UIDiscipleModel:isMyActorDZ(self.disciple_guid)then
netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
list=UIDiscipleModel:getDiscipleAllSpecialityEx(netData)
else
local dzData=otherPlayerModel:getDZData(self.disciple_guid)
netData=dzData.base
list=UIDiscipleModel:getDiscipleAllSpecialityEx(netData)
end
if list then
local dataNum=#list
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local sType=list[i][1]
local v=list[i][2].param_1
local cfg=UIDiscipleModel:getSpecialityConfig(sType,v)
cfg.specialitytype=sType
local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
UIManager:showWindow('UISpecialityWin',{item=item,node='left',guidNetData=netData,config=cfg,pivot=Vector2.New(0.5,0.5)})
end)
end
end

end
end
