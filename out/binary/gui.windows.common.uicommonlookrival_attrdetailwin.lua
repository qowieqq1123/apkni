







def_class("UICommonLookRival_attrDetailWin",UIWindowBase)









function UICommonLookRival_attrDetailWin:bindComponents()

self.contentRoot=UIObject.get(self,0)
self.descListPanel=UIObject.get(self,1)
self.iconCreater=UIObject.get(self,2)
self.attrCreater1=UIObject.get(self,3)
self.attrCreater2=UIObject.get(self,4)
self.questionBtn=UIButton.get(self,5)

self.questionBtn:setButtonClick(function()self:onQuestionBtn()end)



end


function UICommonLookRival_attrDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.contentRoot);self.contentRoot=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.iconCreater);self.iconCreater=nil;
_UIObject_release(self.attrCreater1);self.attrCreater1=nil;
_UIObject_release(self.attrCreater2);self.attrCreater2=nil;
_UIObject_release(self.questionBtn);self.questionBtn=nil;
end



















function UICommonLookRival_attrDetailWin:onLoaded(...)
self:bindComponents()
end


function UICommonLookRival_attrDetailWin:__delete()
self:unbindComponents()
end




function UICommonLookRival_attrDetailWin:onShow(argtable,afterOnloaded)
self.dzData=argtable.dzData
self.attrLookup=argtable.attrLookup

local attrsDetail=cfgHelper.getdef(cfg_attributesconfig,'attrsDetail')
if self.attrLookup~=nil then
self.attrlist2=UIDiscipleModel.getAttrListByType(self.attrLookup,attrsDetail,true,true)
else
self.attrlist2=UIDiscipleModel.getAttrListByType2(self.dzData.attrList,attrsDetail,true)
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


function UICommonLookRival_attrDetailWin:onHide()

end

function UICommonLookRival_attrDetailWin:RefreshAttrList1(isInit)

if self.attrlist1==nil then
local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
if self.attrLookup~=nil then
self.attrlist1=UIDiscipleModel.getAttrListByType(self.attrLookup,attrsBase,true)
else
self.attrlist1=UIDiscipleModel.getAttrListByType2(self.dzData.attrList,attrsBase,true)
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

function UICommonLookRival_attrDetailWin:RefreshAttrList2(isInit)

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

function UICommonLookRival_attrDetailWin:RefreshSkillList(isInit)
local baseData=self.dzData.base
local groupid=baseData.vocsgidx
local image=UIDiscipleModel.calculationDiscipleImageBase(baseData)
local jobSkillList=UIDiscipleModel:getDiscipleJobSkillListEx(groupid,image.job,baseData.jingjielv,baseData)
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

function UICommonLookRival_attrDetailWin:refreshQuestionBtn()
local iconname
if self.curPage then
iconname='button_tyjieshao_2'
else
iconname='button_tyjieshao_1'
end
self.questionBtn:setSprite(globalABLookup.global,iconname)
end

function UICommonLookRival_attrDetailWin:refreshTeZhi()
local netData=self.dzData.base
local list=UIDiscipleModel:getDiscipleAllSpecialityEx(netData)
if list then
local dataNum=#list
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local sType=list[i][1]
local v=list[i][2].param_1
local cfg=UIDiscipleModel:getSpecialityConfigEx(netData,sType,list[i][2])
cfg.specialitytype=sType
local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
UIManager:showWindow('UISpecialityWin',{item=item,node='left',guidNetData=netData,config=cfg,pivot=Vector2.New(0.5,0.5)})
end)
end
end

end
end




function UICommonLookRival_attrDetailWin:onQuestionBtn()
self.curPage=not self.curPage
self:refreshQuestionBtn()
self:RefreshAttrList2()
end


function UICommonLookRival_attrDetailWin:onSkillItemClick(skillID,skillLv)
local tdsExtraLv=0
local vocEquipExtraLv
if self.dzData.skillLvPlusLookupExtra then
if self.dzData.skillLvPlusLookupExtra['tiandaoshu']then
tdsExtraLv=self.dzData.skillLvPlusLookupExtra['tiandaoshu'][skillID]or 0
end

if self.dzData.skillLvPlusLookupExtra['vocequip']then
vocEquipExtraLv=self.dzData.skillLvPlusLookupExtra['vocequip'][skillID]
end
end
local args={skillID=skillID,skillLv=skillLv,attend=eSkillTipsType.eDZSkill,dis_guid=nil,changLv=false,tdsLv=tdsExtraLv,vocEquipAddLv=vocEquipExtraLv}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end
