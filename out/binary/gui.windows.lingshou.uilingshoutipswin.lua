







def_class("UILingShouTipsWin",UIWindowBase)









function UILingShouTipsWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.colorframe=UIObject.get(self,2)
self.lsItem=UIObject.get(self,3)
self.lsInfoObj=UIObject.get(self,4)
self.lsBaseAttrObj=UIObject.get(self,5)
self.lsSpecialAttrObj=UIObject.get(self,6)
self.lsCharacterObj=UIObject.get(self,7)
self.baseSkillObj=UIObject.get(self,8)
self.lsDescObj=UIObject.get(self,9)
self.menuAnimGrid=UIObject.get(self,10)
self.buttonRoot=UIObject.get(self,11)
self.fadeOutRoot=UIObject.get(self,12)
self.colorBg=UIImage.get(self,13)
self.liandonBtn=UIButton.get(self,14)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)



end


function UILingShouTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.colorframe);self.colorframe=nil;
_UIObject_release(self.lsItem);self.lsItem=nil;
_UIObject_release(self.lsInfoObj);self.lsInfoObj=nil;
_UIObject_release(self.lsBaseAttrObj);self.lsBaseAttrObj=nil;
_UIObject_release(self.lsSpecialAttrObj);self.lsSpecialAttrObj=nil;
_UIObject_release(self.lsCharacterObj);self.lsCharacterObj=nil;
_UIObject_release(self.baseSkillObj);self.baseSkillObj=nil;
_UIObject_release(self.lsDescObj);self.lsDescObj=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
_UIObject_release(self.buttonRoot);self.buttonRoot=nil;
_UIObject_release(self.fadeOutRoot);self.fadeOutRoot=nil;
_UIObject_release(self.colorBg);self.colorBg=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
end


















local _tipsBtnType={
eReplace=1,
eSetup=2,
eRemove=3,
eRefresh=4,
eGotoInfo=5,

getName=function(self,v)
if self.namelist==nil then
self.namelist={'替换','携带','卸下','更换','培养'}
end
return self.namelist[v]
end,
}



function UILingShouTipsWin:onLoaded(...)
self:bindComponents()
end


function UILingShouTipsWin:__delete()
self:unbindComponents()

end


function UILingShouTipsWin:onHide()

end




function UILingShouTipsWin:onShow(argtable,afterOnloaded)
self.ls_guid=argtable.ls_guid
self.dzOwner=argtable.dzOwner
self.old_dzOwner=argtable.old_dzOwner
self.lsData=argtable.lsData
if self.lsData==nil then
self.lsData=lingshouModel:getLingShouData(self.ls_guid)
end
self.fromType=argtable.fromType or TIPS_FORM_TYPE.eNone
self.blackImgAlpha=argtable.blackImgAlpha or 1
self.offsetx=argtable.offsetx


self:checkShowBtnTypeList()
self:refreshBtnView()
self:showAnim()

self:refreshView()
self.fadeOutRoot:setChildCanvasGroupAlpha(0)
self.fadeOutRoot:setChildCanvasGroupDOFade(1,0.1,nil)
self.blackImg:setChildCanvasGroupAlpha(self.blackImgAlpha)

self:refreshRoot(false)

UIManager:invokeUIMethod("UILingShouSetupWin","setBlackImg",false)
end

function UILingShouTipsWin:refreshRoot(isplay)
local posx
if self.fromType==TIPS_FORM_TYPE.eEquipListWin then
posx=186.5
elseif self.fromType==TIPS_FORM_TYPE.eShareLingShou then
posx=304
else
posx=self.offsetx or 0
end
if isplay then
self.root:setChildDOLocalMoveX(posx,0.25,nil)
else
self.root:setLocalPosX(posx)
end
end

function UILingShouTipsWin:onSelectLS(ls_guid,fromType,old)
self.ls_guid=ls_guid
self.old_dzOwner=old
self.lsData=lingshouModel:getLingShouData(self.ls_guid)
local originalFromType=self.fromType
self.fromType=fromType
local isNeedMove=self.fromType==TIPS_FORM_TYPE.eEquipListWin and originalFromType~=TIPS_FORM_TYPE.eEquipListWin


self:checkShowBtnTypeList()
self:refreshBtnView()
self:showAnim()
self:refreshView()

if isNeedMove then
self:refreshRoot(true)
end
end

function UILingShouTipsWin:refreshBtnView()
local showBtn=self.showBtnTypeList and#self.showBtnTypeList>0 or false

self.buttonRoot:setActive(showBtn)
if showBtn then
local grids=self.buttonRoot:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local tipsType=self.showBtnTypeList[i]
local widget=grids[i-1]
if tipsType then
widget:SetChildActive(-1,true)
local btnName=_tipsBtnType:getName(tipsType)
widget:SetChildText(0,btnName)
widget:SetChildButtonClick(-1,function()
self:onClickTipsBtn(i)
end,true)
local reddot=false
if tipsType==_tipsBtnType.eGotoInfo then
reddot=lingshouModel:checkLingShouReddot(self.ls_guid)
end
widget:SetChildActive(1,reddot)



else
widget:SetChildActive(-1,false)
end
end
end
end

function UILingShouTipsWin:showAnim(isInit)
self.buttonRoot:setActive(false)
local showBtn=self.showBtnTypeList and#self.showBtnTypeList>0 or false
self.menuAnimGrid:setActive(showBtn)
if showBtn then
local grids=self.menuAnimGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local tipsType=self.showBtnTypeList[i]
local widget=grids[i-1]
if tipsType then
widget:SetChildActive(-1,true)
widget:SetChildUIModelShowTarget(-1,2017,1,{},eAnimationID.common_window_enter,false,false,0,nil)
else
widget:SetChildActive(-1,false)
end
end



local func1=function()
self.buttonRoot:setActive(true)
self.buttonRoot:setChildCanvasGroupAlpha(0)
self.buttonRoot:setChildCanvasGroupDOFade(1,1,nil)
end
if isInit then
self:delayDo(0.3,func1)
else
return func1()
end
end
end

function UILingShouTipsWin:refreshView()
local lsData=self.lsData
local lsID=lsData.id
local lscfg=lsData.cfg

local color=lingshouModel.getColorEx(lsData)
if color<3 then
color=3
end
local bgName=FMT.fmt('image_lingshouui_tips_{0}',color+1)
local abName="ui/windows/lingshou/lingshoutips_atlas_pak.ab"

self.colorBg:setSprite(abName,bgName)


local lsItemWidget=self.lsItem:getChildWidgetBase()

local name_str=lsData.name
lsItemWidget:SetChildText(0,name_str)

local isbianyi=lscfg.bianyi==1
lsItemWidget:SetChildActive(7,isbianyi)



local generation=lsData.generation
lsItemWidget:SetChildText(4,FMT.fmt("{0}代",generation))
local generationShowParams=cfgHelper.get2(cfg_lingshoubasicconfig_get,1,'tipsGenerationShowBg')
local generationParam=generationShowParams[generation]or generationShowParams[#generationShowParams]
local abName=generationParam.abname
local iconName=generationParam.icon
lsItemWidget:SetChildCSImageSprite(6,abName,iconName)


local fanyanCount=lsData.born_times or 0
lsItemWidget:SetChildText(8,FMT.fmt('繁衍次数：{0}',fanyanCount))





local fight_str=lingshouModel.getFightValueEx(lsData)
lsItemWidget:SetChildText(2,fight_str)


local modelParams=lingshouModel.getModelParamsEx(lscfg.model)
local scale=lscfg.modelScale
if not scale then

scale=isometricMapSystem:getModelScale(lscfg.model,true)
end
scale=scale*0.7
lsItemWidget:SetChildUIModelShowTarget(5,modelParams.body,scale,modelParams.componets,0,false,true)
local offset=lscfg.modelOffset or{0,-150}
lsItemWidget:SetChildUIModelShowTargetOffset(5,offset[1],offset[2])

self:refreshLingShouBaseAttr()
self:refreshLingShouInfo()

self:refreshLingShouTX()
self:refreshLingShouSkill()


local lsDescWidget=self.lsDescObj:getChildWidgetBase()
lsDescWidget:SetChildText(0,lscfg.desc)


local isLDLS=liandonModel:getLianDonLinkageIdByLsId(lsID)>0
self.liandonBtn:setActive(isLDLS)
end

function UILingShouTipsWin:refreshLingShouInfo()
local lsData=self.lsData
local lscfg=lsData.cfg
local lsInfoWidget=self.lsInfoObj:getChildWidgetBase()
lsInfoWidget:SetChildLayoutGroupCreateItems(0,6)
local infoGrid=lsInfoWidget:GetChildLayoutGroupGridList(0)

local jj_str=FMT.fmt('<color=#7d3b17>境界：</color>{0}',lingshouModel.getJJNameEx(lsData.jj_lvl,2))
infoGrid[0]:SetChildText(0,jj_str)

local element=lscfg.element
local elementName=ELEMENT_TYPE.getName(element)


local race_str=cfgHelper.get2(cfg_lingshouraceconfig_get,lscfg.race,'name')
infoGrid[1]:SetChildText(0,FMT.fmt('<color=#7d3b17>种族：</color>{0}·{1}',race_str,elementName))


local xm_str=lingshouModel.getXueMaiDescEx2(lsData.xuemai_val)
infoGrid[2]:SetChildText(0,FMT.fmt('<color=#7d3b17>血脉：</color>{0}',xm_str))


infoGrid[3]:SetChildText(0,FMT.fmt('<color=#7d3b17>性别：</color>{0}',SEX_TYPE.getName2(lsData.sex)))


infoGrid[4]:SetChildText(0,FMT.fmt('<color=#7d3b17>资质：</color>{0}',lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)))

local ql_str=lingshouModel.getQianLiDescEx(lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI))
infoGrid[5]:SetChildText(0,FMT.fmt('<color=#7d3b17>潜力：</color>{0}',ql_str))




end

function UILingShouTipsWin:refreshLingShouBaseAttr()
local lsData=self.lsData
local lscfg=lsData.cfg

local widget=self.lsBaseAttrObj:getChildWidgetBase()

local showAttrList
local attrsShow=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
if self.ls_guid then
showAttrList=lingshouModel:getAttrListByType(self.ls_guid,attrsShow,true,2)
else
showAttrList=lingshouModel:getAttrListByTypeEx(lsData,attrsShow,true,2)
end
local num=#showAttrList


local gridlist=widget:GetChildCommonLayoutGroupWidgetList(0)
for i=1,num do
local item=gridlist[i-1]
local attr=showAttrList[i]
local attrType=attr[1]
local value=attr[2]
if value<0 then
value=0
end
local color_str='<color=#ca631d>{0}：</color>{1}'
item:SetChildText(0,helper.getAttributeStr(attrType,value,nil,color_str))
end










end

function UILingShouTipsWin:refreshLingShouSpecialAttr()
local lsData=self.lsData
local lscfg=lsData.cfg
local widget=self.lsSpecialAttrObj:getChildWidgetBase()




















local showAttrList
local attrsShow=cfgHelper.getdef(cfg_attributesconfig,'attrsDetail')
if self.ls_guid then
showAttrList=lingshouModel:getAttrListByType(self.ls_guid,attrsShow,true,2)
else
showAttrList=lingshouModel:getAttrListByTypeEx(lsData,attrsShow,true,2)
end
local num=showAttrList and#showAttrList or 0
self.lsSpecialAttrObj:setActive(num>0)
widget:SetChildLayoutGroupCreateItems(0,num)
local gridlist=widget:GetChildLayoutGroupGridList(0)
for i=1,num do
local item=gridlist[i-1]
local attr=showAttrList[i]
local attrType=attr[1]
local value=attr[2]
if value<0 then
value=0
end
local color_str='{0}：{1}'
item:SetChildText(0,helper.getAttributeStr(attrType,value,nil,color_str))
end
end

function UILingShouTipsWin:refreshLingShouTX()
local lsData=self.lsData
local lscfg=lsData.cfg




















self.desclist=lingshouModel:getLsSortWordListEx(lsData)
local dataNum=self.desclist and#self.desclist or 0
local widget=self.lsCharacterObj:getChildWidgetBase()
widget:SetChildLayoutGroupCreateItems(0,dataNum)
local descGrids=widget:GetChildLayoutGroupGridList(0)
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
end

function UILingShouTipsWin:refreshLingShouSkill()
local lsData=self.lsData


local skillList
if self.ls_guid then
skillList=lingshouModel:getSkillList(lsData.guid)
elseif lsData.serverSkillList and#lsData.serverSkillList>0 then

skillList={}
for i,v in ipairs(lsData.serverSkillList)do
skillList[i]=v
end
else

local passiveSkillLv=lingshouModel:getPassiveSkillLevel(lsData)
skillList=lingshouModel.getSkillListEx(lsData.id,lsData.jj_lvl,lsData.xuemai_val,lsData.skill_level,lsData.skill_level,passiveSkillLv)
end


local talentSkillList=lingshouModel.getTalentSkillListEx(lsData)
local talentSkill=talentSkillList[1]
local hasTalentSkill=talentSkill~=nil
if hasTalentSkill then
talentSkill.isTalentSkill=true
table.insert(skillList,1,talentSkill)
end

self:refreshSkillGrid(skillList)
end

function UILingShouTipsWin:refreshTalentSkillItem(item,skill,changlv)
local hasSkill=skill~=nil
item:setActive(hasSkill)
if hasSkill then
local skillID=skill[1]
local skillLv=skill[2]




local itemWidget=item:getChildWidgetBase()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
itemWidget:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
itemWidget:SetChildActive(1,is_bd)
itemWidget:SetChildText(2,skillCfg.name)

local lv_str=''
local lock_str=nil
if skillLv>0 then
lv_str=FMT.fmt('{0}级',skillLv)
else
lock_str='未解锁'
end
itemWidget:SetChildText(3,lv_str)

local isLock=lock_str~=nil
itemWidget:SetChildActive(8,isLock)
if isLock then
itemWidget:SetChildText(8,lock_str)
end

itemWidget:SetChildActive(7,isLock)

local desc_str=skillModel:getSkillDesc(skillID,skillLv)
itemWidget:SetChildText(4,desc_str)

local descExList=skillModel:getSkillDescEx(skillID,skillLv)
local descExNum=0
if descExList~=nil then
descExNum=#descExList
end
local showDescEx=descExNum>0
itemWidget:SetChildActive(9,showDescEx)
if showDescEx then
itemWidget:SetChildLayoutGroupCreateItems(9,descExNum)
local descExGrid=itemWidget:GetChildLayoutGroupGridList(9)
for i=1,descExNum do
local descItem=descExGrid[i-1]
local txt=descExList[i]
descItem:SetChildText(0,txt)
end
end

local coolDown=skillModel:getSkillCooldownTime(skillID,skillLv)
local isCoolDown=coolDown>0
itemWidget:SetChildActive(5,isCoolDown)
if isCoolDown then
local cooldown_str=FMT.fmt('冷却：{0}回合',coolDown)
itemWidget:SetChildText(6,cooldown_str)
end
end
end

function UILingShouTipsWin:refreshSkillGrid(skilList)
local widget=self.baseSkillObj:getChildWidgetBase()


local count=#skilList
widget:SetChildScrollViewCreateGrids(0,count,count)
local gridlist=widget:GetChildScrollViewItemWidgets(0)
local c=gridlist.Count
if c>0 then
for i=1,c do
local item=gridlist[i-1]
local d=skilList[i]
local skillId=d[1]
local skillLv=d[2]
local oSkillLv=d[4]

local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local isTalentSkill=d.isTalentSkill or false

item:SetChildActive(8,isTalentSkill)

item:SetChildActive(9,isTalentSkill)

local islock=not d[3]and not isTalentSkill

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

item:SetChildActive(5,islock)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)


local skillName=skillCfg.name
item:SetChildText(10,skillName)


local showLevel=not islock and not isTalentSkill
item:SetChildActive(4,showLevel)
if showLevel then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end

item:SetChildButtonClick(3,function()
self:onSkillItemClick(skillId,skillLv,isTalentSkill)
end)
end
end
end

function UILingShouTipsWin:checkShowBtnTypeList()
self.showBtnTypeList={}
if self.fromType==TIPS_FORM_TYPE.eNone then
return
end

local isCheckEquipBtn=self.fromType==TIPS_FORM_TYPE.eEquipWin or self.fromType==TIPS_FORM_TYPE.eEquipListWin
if isCheckEquipBtn then
local isOnWin=self.fromType==TIPS_FORM_TYPE.eEquipWin
local isOnList=self.fromType==TIPS_FORM_TYPE.eEquipListWin
local lsDzGuid=lingshouModel:getDiziguidByLsGuid(self.ls_guid)

local isNowSetup=lsDzGuid~=nil and not mathHelper.compareInt64(lsDzGuid,Int64_0)or false

local nowDzHasLs=false

local isNowDzLs=false
if self.dzOwner then
local diziguid=self.dzOwner
local nowDzLsGuid=lingshouModel:getLingShouByDizi(diziguid)
nowDzHasLs=nowDzLsGuid~=nil and not mathHelper.compareInt64(nowDzLsGuid,Int64_0)or false
if nowDzHasLs then
isNowDzLs=mathHelper.compareInt64(nowDzLsGuid,self.ls_guid)
end
end

if isNowSetup then

if isOnWin then
self.showBtnTypeList[#self.showBtnTypeList+1]=_tipsBtnType.eRefresh
if isNowDzLs then

self.showBtnTypeList[#self.showBtnTypeList+1]=_tipsBtnType.eRemove
self.showBtnTypeList[#self.showBtnTypeList+1]=_tipsBtnType.eGotoInfo
end
elseif isOnList then
if not isNowDzLs then

self.showBtnTypeList[#self.showBtnTypeList+1]=_tipsBtnType.eReplace
end
end
elseif isOnList then

if nowDzHasLs then

self.showBtnTypeList[#self.showBtnTypeList+1]=_tipsBtnType.eReplace
else

self.showBtnTypeList[#self.showBtnTypeList+1]=_tipsBtnType.eSetup
end
end
end
end

function UILingShouTipsWin:onClickTipsBtn(idx)
local tipsType=self.showBtnTypeList and self.showBtnTypeList[idx]or nil
if not tipsType then
return
end

if tipsType==_tipsBtnType.eRefresh then

UIManager:showWindow('UILingShouSetupWin',{dis_guid=self.dzOwner})
elseif tipsType==_tipsBtnType.eSetup then

UIDiscipleController:req_setup_ls(self.dzOwner,self.ls_guid)
elseif tipsType==_tipsBtnType.eRemove then


UIDiscipleController:req_takeoff_ls(self.dzOwner)


return self:onCloseBtn()
elseif tipsType==_tipsBtnType.eReplace then
if lingshouModel:checkNoOptState(self.ls_guid)then return end

if self.old_dzOwner~=nil then

UIDiscipleController:req_takeoff_ls(self.old_dzOwner)
end
UIDiscipleController:req_setup_ls(self.dzOwner,self.ls_guid)
elseif tipsType==_tipsBtnType.eGotoInfo then

jumpManager:jump({id=JUMP_TYPE.eLingShouMain,args={tabType=FULL_TAB_TYPE.eLingShouInfo,lsGuid=self.ls_guid}})
end
end

function UILingShouTipsWin:onDescSlotClick(idx)
local wordData=self.desclist[idx]
local wordId=wordData.wordId
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordId)
local widget=self.lsCharacterObj:getChildWidgetBase()
local item=widget:GetChildLayoutGroupGridItem(0,idx-1)

self:showWindow('UILingShouSpecialityWin',{item=item,node='top',guid=self.ls_guid,config=cfg,pivot=Vector2(0.5,0)})
end

function UILingShouTipsWin:onSkillItemClick(skillID,skillLv,isTalentSkill)
local skillType=isTalentSkill and eSkillTipsType.eLSTalentSkill or eSkillTipsType.eLSSkill
local args={lsGuid=self.ls_guid,skillID=skillID,skillLv=skillLv,attend=skillType,canvasIdx=10,showBlackBg=true}
self:showWindow('UIDiscipleJobSkillTipsWin',args)
end


function UILingShouTipsWin:onCloseBtn()
return self:closeSelf()
end

function UILingShouTipsWin:onLiandonBtn()
local lsData=self.lsData
local lsID=lsData.id
local linkageId=liandonModel:getLianDonLinkageIdByLsId(lsID)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end
