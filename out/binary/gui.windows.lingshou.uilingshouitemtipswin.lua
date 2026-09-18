







def_class("UILingShouItemTipsWin",UIWindowBase)









function UILingShouItemTipsWin:bindComponents()

self.baseSkillObj=UIObject.get(self,0)
self.blackImg=UIObject.get(self,1)
self.buttonRoot=UIObject.get(self,2)
self.colorBg=UIImage.get(self,3)
self.colorframe=UIObject.get(self,4)
self.fadeOutRoot=UIObject.get(self,5)
self.liandonBtn=UIButton.get(self,6)
self.lsBaseAttrObj=UIObject.get(self,7)
self.lsCharacterObj=UIObject.get(self,8)
self.lsDescObj=UIObject.get(self,9)
self.lsInfoObj=UIObject.get(self,10)
self.lsItem=UIObject.get(self,11)
self.lsSpecialAttrObj=UIObject.get(self,12)
self.menuAnimGrid=UIObject.get(self,13)
self.root=UIObject.get(self,14)
self.tishiText=UIText.get(self,15)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)



end


function UILingShouItemTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.baseSkillObj);self.baseSkillObj=nil;
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.buttonRoot);self.buttonRoot=nil;
_UIObject_release(self.colorBg);self.colorBg=nil;
_UIObject_release(self.colorframe);self.colorframe=nil;
_UIObject_release(self.fadeOutRoot);self.fadeOutRoot=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.lsBaseAttrObj);self.lsBaseAttrObj=nil;
_UIObject_release(self.lsCharacterObj);self.lsCharacterObj=nil;
_UIObject_release(self.lsDescObj);self.lsDescObj=nil;
_UIObject_release(self.lsInfoObj);self.lsInfoObj=nil;
_UIObject_release(self.lsItem);self.lsItem=nil;
_UIObject_release(self.lsSpecialAttrObj);self.lsSpecialAttrObj=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tishiText);self.tishiText=nil;
end



















function UILingShouItemTipsWin:onLoaded(...)
self:bindComponents()
end


function UILingShouItemTipsWin:__delete()
self:unbindComponents()
end





function UILingShouItemTipsWin:onShow(argtable,afterOnloaded)
self.itemId=argtable.itemId
self.fromType=argtable.fromType or TIPS_FORM_TYPE.eNone
self.blackImgAlpha=argtable.blackImgAlpha or 1
self.offsetx=argtable.offsetx

self:cancelTishiTextTimer()


self.lsData=self:buildLsDataFromItem(self.itemId)
if not self.lsData then
logErr(FMT.fmt("UILingShouItemTipsWin: 无法从道具ID {0} 获取灵兽数据",self.itemId))
self:closeSelf()
return
end


self.buttonRoot:setActive(false)
self.menuAnimGrid:setActive(false)


self:refreshView()


self.fadeOutRoot:setChildCanvasGroupAlpha(0)
self.fadeOutRoot:setChildCanvasGroupDOFade(1,0.1,nil)
self.blackImg:setChildCanvasGroupAlpha(self.blackImgAlpha)


self:refreshRoot()
end


function UILingShouItemTipsWin:onHide()
self:cancelTishiTextTimer()
end

function UILingShouItemTipsWin:cancelTishiTextTimer()
if self._tishiTextTimerId then
self:stopTimerByID(self._tishiTextTimerId)
self._tishiTextTimerId=nil
end
if self._tishiTextTimerId2 then
self:stopTimerByID(self._tishiTextTimerId2)
self._tishiTextTimerId2=nil
end
end


function UILingShouItemTipsWin:refreshRoot()
local posx
if self.fromType==TIPS_FORM_TYPE.eEquipListWin then
posx=186.5
elseif self.fromType==TIPS_FORM_TYPE.eShareLingShou then
posx=304
else
posx=self.offsetx or-315
end
self.root:setLocalPosX(posx)
end




function UILingShouItemTipsWin:buildLsDataFromItem(itemId)

local itemCfg=itemsConfig.getConfig(itemId)
if not itemCfg then
logErr(FMT.fmt("UILingShouItemTipsWin: 找不到道具配置 itemId={0}",itemId))
return nil
end



local funcparam=itemCfg.funcparam
if not funcparam or not funcparam[1]then
logErr(FMT.fmt("UILingShouItemTipsWin: 道具 {0} 没有配置 funcparam[1] 灵兽ID",itemId))
return nil
end
local lsId=funcparam[1]


local lsCfg=cfgHelper.get(cfg_lingshouconfig_get,lsId)
if not lsCfg then
logErr(FMT.fmt("UILingShouItemTipsWin: 找不到灵兽配置 lsId={0}",lsId))
return nil
end


local lsData={

id=lsId,
name=lsCfg.name,
cfg=lsCfg,


generation=lsCfg.generation,

jj_lvl=lsCfg.init_lv,

sex=nil,
zizhi=nil,
qianli=nil,
born_times=nil,
skill_level=nil,
wordList=nil,



xuemai_type=lsCfg.xuemai and lsCfg.xuemai[1]or nil,
xuemai_val=lsCfg.xuemai and lsCfg.xuemai[2]or nil,

isItemTips=true,
}

return lsData
end

function UILingShouItemTipsWin:onCloseBtn()
return self:closeSelf()
end


function UILingShouItemTipsWin:refreshView()
local lsData=self.lsData
local lsCfg=lsData.cfg

local color=lsCfg.color or 3
if color<3 then
color=3
end
local bgName=FMT.fmt('image_lingshouui_tips_{0}',color+1)
local abName="ui/windows/lingshou/lingshoutips_atlas_pak.ab"
self.colorBg:setSprite(abName,bgName)

self:refreshLsItem()
self:refreshLingShouInfo()
self.lsBaseAttrObj:setActive(false)
self.lsSpecialAttrObj:setActive(false)
self:refreshLingShouTX()
self:refreshLingShouSkill()
self:refreshLsDesc()
self:refreshLiandonBtn()
end


function UILingShouItemTipsWin:refreshLsItem()
local lsData=self.lsData
local lsCfg=lsData.cfg
local lsItemWidget=self.lsItem:getChildWidgetBase()


lsItemWidget:SetChildText(0,lsData.name)


local isbianyi=lsCfg.bianyi==1
lsItemWidget:SetChildActive(7,isbianyi)


local generation=lsData.generation
if generation then
lsItemWidget:SetChildText(4,FMT.fmt("{0}代",generation))
local generationShowParams=cfgHelper.get2(cfg_lingshoubasicconfig_get,1,'tipsGenerationShowBg')
local generationParam=generationShowParams[generation]or generationShowParams[#generationShowParams]
local abName=generationParam.abname
local iconName=generationParam.icon
lsItemWidget:SetChildCSImageSprite(6,abName,iconName)
else
lsItemWidget:SetChildText(4,"?代")
end


lsItemWidget:SetChildText(8,'繁衍次数：?')


lsItemWidget:SetChildText(9,'性别：?')


lsItemWidget:SetChildText(2,'')


local modelParams=lingshouModel.getModelParamsEx(lsCfg.model)
local scale=lsCfg.modelScale
if not scale then
scale=isometricMapSystem:getModelScale(lsCfg.model,true)
end
scale=scale*0.7
lsItemWidget:SetChildUIModelShowTarget(5,modelParams.body,scale,modelParams.componets,0,false,true)
local offset=lsCfg.modelOffset or{0,-150}
lsItemWidget:SetChildUIModelShowTargetOffset(5,offset[1],offset[2])
end


function UILingShouItemTipsWin:refreshLingShouInfo()
local lsData=self.lsData
local lsCfg=lsData.cfg
local lsInfoWidget=self.lsInfoObj:getChildWidgetBase()
lsInfoWidget:SetChildLayoutGroupCreateItems(0,6)
local infoGrid=lsInfoWidget:GetChildLayoutGroupGridList(0)


local jj_str
if lsData.jj_lvl then
jj_str=FMT.fmt('<color=#7d3b17>境界：</color>{0}',lingshouModel.getJJNameEx(lsData.jj_lvl,2))
else
jj_str='<color=#7d3b17>境界：</color>?'
end
infoGrid[0]:SetChildText(0,jj_str)


local element=lsCfg.element
local elementName=ELEMENT_TYPE.getName(element)
local race_str=cfgHelper.get2(cfg_lingshouraceconfig_get,lsCfg.race,'name')
infoGrid[1]:SetChildText(0,FMT.fmt('<color=#7d3b17>种族：</color>{0}·{1}',race_str,elementName))


local xm_str
if lsData.xuemai_val and lsData.xuemai_val>0 then
xm_str=lingshouModel.getXueMaiDescEx2(lsData.xuemai_val)
else
xm_str='无'
end
infoGrid[2]:SetChildText(0,FMT.fmt('<color=#7d3b17>血脉：</color>{0}',xm_str))


infoGrid[3]:SetChildText(0,'<color=#7d3b17>性别：</color>?')


infoGrid[4]:SetChildText(0,'<color=#7d3b17>资质：</color>?')


infoGrid[5]:SetChildText(0,'<color=#7d3b17>潜力：</color>?')
end


function UILingShouItemTipsWin:refreshLsDesc()
local lsData=self.lsData
local lsCfg=lsData.cfg
local lsDescWidget=self.lsDescObj:getChildWidgetBase()
lsDescWidget:SetChildText(0,lsCfg.desc or'')
end


function UILingShouItemTipsWin:refreshLiandonBtn()
local lsData=self.lsData
local lsID=lsData.id
local isLDLS=liandonModel:getLianDonLinkageIdByLsId(lsID)>0
self.liandonBtn:setActive(isLDLS)
end


function UILingShouItemTipsWin:refreshLingShouTX()
local lsData=self.lsData
local lsCfg=lsData.cfg

local wordList=self:getGoodWordList(lsCfg)
local dataNum=wordList and#wordList or 0

local widget=self.lsCharacterObj:getChildWidgetBase()
widget:SetChildLayoutGroupCreateItems(0,dataNum)
local descGrids=widget:GetChildLayoutGroupGridList(0)

if descGrids.Count>0 then
for i=1,descGrids.Count do
local wordData=wordList[i]
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

self.desclist=wordList
self:refreshTishiTextPos(dataNum)
end


function UILingShouItemTipsWin:refreshTishiTextPos(wordCount)
wordCount=nil
if not self.tishiText then return end
self:cancelTishiTextTimer()

local function _applyPos()
if not self.tishiText or not self.lsCharacterObj then return end
local widget=self.lsCharacterObj:getChildWidgetBase()
if not widget then return end
widget:ForceLayoutVertical(0)
local layoutHeight=widget:GetChildRectHeight(0)or 0
if layoutHeight<0 then
layoutHeight=0
end
local offsetY=-layoutHeight-23
self.tishiText:setLocalPosY(offsetY)
end

self._tishiTextTimerId=self:setTimer(0,1,function()
_applyPos()
self._tishiTextTimerId2=self:setTimer(0,1,function()
_applyPos()
end)
end)
end



function UILingShouItemTipsWin:getGoodWordList(lsCfg)
local result={}
local allWords={}

local wordCfgList=lsCfg.word
if wordCfgList then
for _,wordItem in ipairs(wordCfgList)do
local wordId=wordItem[1]
if wordId then
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordId)
if cfg then
local wordData={
wordId=wordId,
color=cfg.framecolor or 1,
}
table.insert(allWords,wordData)
end
end
end
end


table.sort(allWords,function(a,b)
if a.color~=b.color then
return a.color>b.color
end
return a.wordId<b.wordId
end)

local maxCount=8
for _,wordData in ipairs(allWords)do
if#result>=maxCount then
break
end
table.insert(result,wordData)
end

return result
end


function UILingShouItemTipsWin:onDescSlotClick(idx)
local wordData=self.desclist[idx]
if not wordData then
return
end
local wordId=wordData.wordId
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordId)
local widget=self.lsCharacterObj:getChildWidgetBase()
local item=widget:GetChildLayoutGroupGridItem(0,idx-1)

self:showWindow('UILingShouSpecialityWin',{item=item,node='top',config=cfg,pivot=Vector2(0.5,0)})
end


function UILingShouItemTipsWin:refreshLingShouSkill()
local lsData=self.lsData
local lsCfg=lsData.cfg


local skillList=self:getSkillListFromConfig(lsCfg)


local talentSkill=self:getTalentSkillFromConfig(lsCfg)
if talentSkill then
talentSkill.isTalentSkill=true
table.insert(skillList,1,talentSkill)
end

self:refreshSkillGrid(skillList)
end




function UILingShouItemTipsWin:getSkillListFromConfig(lsCfg)
local skillList={}


local normalSkillId=lsCfg.normal_skill
if normalSkillId and normalSkillId>0 then
table.insert(skillList,{normalSkillId,1,true,1})
end


local mainSkillId=lsCfg.skill
if mainSkillId and mainSkillId>0 then
table.insert(skillList,{mainSkillId,1,true,1})
end


local passiveSkills=lsCfg.passive_skill
if passiveSkills then
for _,passiveSkillId in ipairs(passiveSkills)do
if passiveSkillId and passiveSkillId>0 then
table.insert(skillList,{passiveSkillId,0,false,0})
end
end
end

return skillList
end


function UILingShouItemTipsWin:getTalentSkillFromConfig(lsCfg)
local tianfuCfg=lsCfg.tianfu
if not tianfuCfg then
return nil
end

local firstSkillId=nil
if type(tianfuCfg)=="number"then
firstSkillId=tianfuCfg
elseif type(tianfuCfg)=="table"then

for _,v in pairs(tianfuCfg)do
if type(v)=="number"then
firstSkillId=v
break
elseif type(v)=="table"and v[1]then
firstSkillId=v[1]
break
end
end
end

if firstSkillId and firstSkillId>0 then

return{firstSkillId,1,true,1}
end

return nil
end


function UILingShouItemTipsWin:refreshSkillGrid(skillList)
local widget=self.baseSkillObj:getChildWidgetBase()
local count=#skillList
widget:SetChildScrollViewCreateGrids(0,count,count)
local gridlist=widget:GetChildScrollViewItemWidgets(0)
local c=gridlist.Count

if c>0 then
for i=1,c do
local item=gridlist[i-1]
local d=skillList[i]
local skillId=d[1]
local skillLv=d[2]
local isUnlock=d[3]
local isTalentSkill=d.isTalentSkill or false

local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if not skillCfg then
item:SetChildActive(-1,false)
else
item:SetChildActive(-1,true)


item:SetChildActive(8,isTalentSkill)
item:SetChildActive(9,isTalentSkill)

local islock=not isUnlock and not isTalentSkill


item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
item:SetChildImageExGray(0,islock)

item:SetChildActive(5,islock)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)


item:SetChildText(10,skillCfg.name)


local showLevel=isUnlock and not isTalentSkill
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
end


function UILingShouItemTipsWin:onSkillItemClick(skillID,skillLv,isTalentSkill)
local skillType=isTalentSkill and eSkillTipsType.eLSTalentSkill or eSkillTipsType.eLSSkill
local args={skillID=skillID,skillLv=skillLv,attend=skillType,canvasIdx=10,showBlackBg=true}
self:showWindow('UIDiscipleJobSkillTipsWin',args)
end




function UILingShouItemTipsWin:onLiandonBtn()
local lsData=self.lsData
local lsID=lsData.id
local linkageId=liandonModel:getLianDonLinkageIdByLsId(lsID)
if linkageId and linkageId>0 then
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end
end
