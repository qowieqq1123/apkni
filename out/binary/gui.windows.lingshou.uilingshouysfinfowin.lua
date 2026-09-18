







def_class("UILingShouYSFInfoWin",UIWindowBase)









function UILingShouYSFInfoWin:bindComponents()

self.baseSkillGrid=UIObject.get(self,0)
self.descListPanel=UIObject.get(self,1)
self.jingjieText=UIText.get(self,2)
self.qianliBtn=UIButton.get(self,3)
self.qianLiRedDot=UIObject.get(self,4)
self.qianliText=UIText.get(self,5)
self.raceText=UIText.get(self,6)
self.reduceZiZhi=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.sexText=UIText.get(self,9)
self.talentSkillItem=UIObject.get(self,10)
self.talentSkillPanel=UIObject.get(self,11)
self.xuemaiBtn=UIButton.get(self,12)
self.xuemaiText=UIText.get(self,13)
self.zizhiText=UIText.get(self,14)
self.fanyanText=UIText.get(self,15)
self.closebtn=UIButton.get(self,16)
self.lingshouModel=UIObject.get(self,17)
self.lingshouName=UIText.get(self,18)
self.elementText=UIText.get(self,19)
self.colorText=UIText.get(self,20)
self.sexicon=UIImage.get(self,21)
self.daishuicon=UIImage.get(self,22)
self.daishutxt=UIText.get(self,23)
self.byicon=UIObject.get(self,24)
self.successEffect=UIObject.get(self,25)
self.lingshouListPanel=UIScrollView.get(self,26)
self.title1=UIObject.get(self,27)
self.infoPanel=UIObject.get(self,28)
self.title2=UIObject.get(self,29)
self.texingPanel=UIObject.get(self,30)
self.title3=UIObject.get(self,31)
self.skillPanel=UIObject.get(self,32)
self.mpanel=UIObject.get(self,33)
self.titleBack=UIObject.get(self,34)
self.titleTxt=UIText.get(self,35)
self.spinebg=UIObject.get(self,36)

self.qianliBtn:setButtonClick(function()self:onQianliBtn()end)

self.xuemaiBtn:setButtonClick(function()self:onXuemaiBtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)



end


function UILingShouYSFInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
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
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.lingshouModel);self.lingshouModel=nil;
_UIObject_release(self.lingshouName);self.lingshouName=nil;
_UIObject_release(self.elementText);self.elementText=nil;
_UIObject_release(self.colorText);self.colorText=nil;
_UIObject_release(self.sexicon);self.sexicon=nil;
_UIObject_release(self.daishuicon);self.daishuicon=nil;
_UIObject_release(self.daishutxt);self.daishutxt=nil;
_UIObject_release(self.byicon);self.byicon=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.lingshouListPanel);self.lingshouListPanel=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.texingPanel);self.texingPanel=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.mpanel);self.mpanel=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
end
















local _this
local colorWoldList={
'绿品','蓝品','紫品','橙品','红品','粉品'
}
local abname='ui/windows/lingshou/lingshouxuemai_atlas_pak.ab'
local sexarry=
{
[1]='image_yushoufang_13',
[2]='image_yushoufang_12',
}
local daishuarry=
{
[1]='image_yushoufang_03',
[2]='image_yushoufang_04',
}
local AnimationIDs=
{
[1]=eAnimationID.stand3,
[2]=eAnimationID.stand3,
[3]=eAnimationID.stand3,
[4]=eAnimationID.stand2,
[5]=eAnimationID.stand,
}

function UILingShouYSFInfoWin:onLoaded(...)
self:bindComponents()
_this=self
self.lslist={}
self.curSelectIndex=1
self.onRoleItemClick_=function(...)
if _this==nil then return end
_this:onRoleItemClick(...)
end
self.lingshouListPanel:setClickAction(self.onRoleItemClick_)
end


function UILingShouYSFInfoWin:__delete()

self.successEffect:setChildShowEffect(10010,false)
self:unbindComponents()
_this=nil
end

function UILingShouYSFInfoWin:onXuemaiBtn()

end
function UILingShouYSFInfoWin:onQianliBtn()

end
function UILingShouYSFInfoWin:onDetailClick()

end
function UILingShouYSFInfoWin:rec_awake(guid)

end

function UILingShouYSFInfoWin.refreshReddot()
if _this==nil then return end
_this:refreshView()
end


function UILingShouYSFInfoWin:onHide()

end

function UILingShouYSFInfoWin:onClosebtn()
self:closeSelf()
end


function UILingShouYSFInfoWin:onRoleItemClick(id,idx,guid,attach)
if self.curSelectIndex==idx then return end

local old=self.curSelectIndex
self.curSelectIndex=idx
if old then
local olditem=self.lingshouListPanel:getGridObjectByindex(old-1)
olditem:SetChildActive(3,false)
end
local item=self.lingshouListPanel:getGridObjectByindex(self.curSelectIndex-1)
if item then
item:SetChildActive(3,true)
end


self:refreshModel()

self:refreshView()
end




function UILingShouYSFInfoWin:onShow(argtable,afterOnloaded)
local canvas=argtable.canvas
if canvas then
self.winlua:SetCanvasIndex(-1,canvas)
end
self.successEffect:setChildShowEffect(10010,true)
self.closeCallBack=argtable.closeCallBack

self.lslist=argtable.lslist
self.lsindex=argtable.lsindex
if argtable.titleTxt then
self.titleTxt:setText(argtable.titleTxt)
else
self.titleTxt:setText('获得灵兽')
end

if not self.lslist then
logErr("灵兽列表为nil")
return
end
if self.lsindex then
self.curSelectIndex=self.lsindex
end


self:sortlsit()


self:refreshRoleGrid()

self:refreshModel()

self:refreshView()

self:doMyAnim()
end

function UILingShouYSFInfoWin:sortlsit()
local list={}
local list2=table.weakCopy(self.lslist)
for k,lsData in ipairs(list2)do
local lsID=lsData.id
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
local banyi=lscfg.bianyi==1 and 1 or 0
local color=lscfg.color or 0
local weight=color*1000+banyi*100+k
table.insert(list,{weight=weight,lsData=lsData})
end
if#list>1 then
table.sort(list,function(a,b)
return a.weight>b.weight
end)
end
self.lslist=list
end


function UILingShouYSFInfoWin:refreshModel()
local lsData=self.lslist[self.curSelectIndex].lsData
local lsID=lsData.id
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
local name_str=lsData.name

self.lingshouName:setText(name_str)

local sex=lsData.sex or 1
self.winlua:SetChildCSImageSprite(self.sexicon:getID(),abname,sexarry[sex])

local generation=lsData.generation or 1
self.daishutxt:setText(FMT.fmt("{0}代",generation))
self.winlua:SetChildCSImageSprite(self.daishuicon:getID(),abname,daishuarry[generation])

local lsIsMutation=lscfg.bianyi==1
self.byicon:setActive(lsIsMutation)

self.lingshouModel:setChildUIModelRemoveTarget()
local modelParams=lingshouModel.getModelParamsEx(lscfg.model)
local scale=lscfg.modelScale
if not scale then

scale=isometricMapSystem:getModelScale(lscfg.model,true)
end
self.lingshouModel:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,0,false,true)
local offset=lscfg.modelOffset or{0,-210}
self.lingshouModel:setChildUIModelShowTargetOffset(offset[1],offset[2])


self.spinebg:setChildUIModelShowTarget(6524,1.1,nil,AnimationIDs[lscfg.color])
end

function UILingShouYSFInfoWin:refreshView()
local lsData=self.lslist[self.curSelectIndex].lsData
local lsID=lsData.id
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)

self.colorText:setText(FMT.fmt('品质：<color=#aae252>{0}</color>',colorWoldList[lscfg.color]))

self.xuemaiText:setText(FMT.fmt('血脉：<color=#aae252>{0}</color>',lingshouModel:switchLevelToStageName_XueMai(lsData.xuemai_val)))

self.zizhiText:setText(FMT.fmt('资质：<color=#aae252>{0}</color>',lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)))
self.reduceZiZhi:setActive(false)

local ql_str=lingshouModel.getQianLiDescEx(lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI))
self.qianliText:setText(FMT.fmt('潜力：<color=#aae252>{0}</color>',ql_str))

local race_str=cfgHelper.get2(cfg_lingshouraceconfig_get,lscfg.race,'name')
self.raceText:setText(FMT.fmt('{0}族',race_str))

local fanyanCount=lsData.born_times or 0
self.fanyanText:setText(FMT.fmt('繁衍次数：<color=#aae252>{0}</color>',fanyanCount))

local element=lscfg.element
local elementName=ELEMENT_TYPE.getName(element)
self.elementText:setText(FMT.fmt('元素：<color=#aae252>{0}</color>',elementName))


self.desclist=lsData and table.deepCopy(lsData.wordList)
local list={}
for k,v in ipairs(self.desclist)do
local wordId=v
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordId)
local spe_type=cfg.spe_type
local weight=spe_type*1000+k
table.insert(list,{weight=weight,v=v})
end
if#list>1 then
table.sort(list,function(a,b)
return a.weight>b.weight
end)
end
self.desclist=list

local dataNum=self.desclist and#self.desclist or 0
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local descGrids=self.descListPanel:getChildLayoutGroupGridList()
local count=descGrids.Count
if count>0 then
for i=1,count do
local wordId=self.desclist[i].v
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


local jnplv=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.MAIN_SKILL_LEVEL)
local pjnplv=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.PASSIVE_SKILL_LEVEL)
local skillList=lingshouModel.getSkillListEx(lsData.id,lsData.jj_lvl,lsData.xuemai_val,lsData.skill_level,jnplv,pjnplv)
if not skillList then
skillList={}
end
self:refreshSkillGrid(self.baseSkillGrid,skillList,eSkillTipsType.eLSSkill)


local talentSkillList={}
if lsData.tianfu_skill_id~=nil then
local level=1
local talentSkillId=lsData.tianfu_skill_id
if talentSkillId>0 then

table.insert(talentSkillList,{talentSkillId,level})
end
end
local talentSkill=talentSkillList[1]
local hasTalentSkill=talentSkill~=nil
self.talentSkillPanel:setActive(hasTalentSkill)
if hasTalentSkill then
local talentSkillId=talentSkill[1]
local talentSkillLv=talentSkill[2]
local talentSkillItem=self.talentSkillItem:getWidgetBase()
self:refreshSkillItem(talentSkillItem,talentSkillId,talentSkillLv,eSkillTipsType.eLSTalentSkill)
end











end

function UILingShouYSFInfoWin:refreshRoleGrid()
local tNum=#self.lslist
if tNum>1 then
self.lingshouListPanel:setActive(true)
self.lingshouListPanel:freshGridsNum(tNum,tNum,1,true)
for i=1,tNum do
local item=self.lingshouListPanel:getGridObjectByindex(i-1)
self:refreshRoleItem(item,i)
end
self.lingshouListPanel:jumpToLockX(self.curSelectIndex)
else
self.lingshouListPanel:setActive(false)
self.curSelectIndex=1
end
end
function UILingShouYSFInfoWin:refreshRoleItem(item,idx)
local lsData=self.lslist[idx].lsData
local lsID=lsData.id
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
comHelper.setChildModelHeadIconBGByColor(item,0,lscfg.color)

comHelper.setChildModelRawImage_lingshou(item,lsID,1,0,eHeadCenterType.eHead,1)

item:SetChildActive(3,self.curSelectIndex==idx)

local sex=lsData.sex or 1
item:SetChildCSImageSprite(5,abname,sexarry[sex])

local lsIsMutation=lscfg.bianyi==1
item:SetChildActive(6,lsIsMutation)
end


function UILingShouYSFInfoWin:refreshSkillGrid(skillGrid,skilList,st)
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
function UILingShouYSFInfoWin:refreshSkillItem(item,skillId,skillLv,unlock,st,nSkillLv)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if not skillCfg then
logErr(FMT.fmt("找不到技能{0}对应的技能配置 请检查灵兽技能配置与数据是否正确",skillId))
return
end
local islock=not unlock

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
self:onSkillItemClick(st,skillId,skillLv)
end)

item:SetChildActive(7,false)
end
function UILingShouYSFInfoWin:onSkillItemClick(skillType,skillID,skillLv)
local args={skillID=skillID,skillLv=skillLv,attend=skillType}
self:showWindow('UIDiscipleJobSkillTipsWin',args)
end



function UILingShouYSFInfoWin:onDescSlotClick(idx)
local wordId=self.desclist[idx].v
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordId)
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)

self:showWindow('UILingShouSpecialityWin',{item=item,node='top',guid=self.ls_guid,config=cfg,pivot=Vector2(0.5,0)})







end

function UILingShouYSFInfoWin:onCloseBtn()
local closeCallBack=self.closeCallBack
self:closeSelf()
if closeCallBack then
closeCallBack()
end
end


function UILingShouYSFInfoWin:doMyAnim()

local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)
delay=delay+0.15


local lsItemPos=self.lingshouListPanel:getChildLocalPosition()
self.lingshouListPanel:setLocalPosX(-1000)
self.lingshouListPanel:setChildDOLocalMoveX(lsItemPos.x,0.4,function()
if _this==nil then return end
end)


self.mpanel:setChildCanvasGroupAlpha(0)
self:delayDo(delay,function()
self.mpanel:setChildCanvasGroupDOFade(1,0.6)
end)
delay=delay+0.1


local titlePos1=self.title1:getChildLocalPosition()
self.title1:setLocalPosY(titlePos1.y-600)
self:delayDo(delay,function()
self.title1:setChildDOLocalMoveY(titlePos1.y,0.3)
end)
delay=delay+0.1
local infoPanelPos=self.infoPanel:getChildLocalPosition()
self.infoPanel:setLocalPosY(infoPanelPos.y-600)
self:delayDo(delay,function()
self.infoPanel:setChildDOLocalMoveY(infoPanelPos.y,0.3)
end)
delay=delay+0.1


local titlePos2=self.title2:getChildLocalPosition()
self.title2:setLocalPosY(titlePos2.y-600)
self:delayDo(delay,function()
self.title2:setChildDOLocalMoveY(titlePos2.y,0.3)
end)
delay=delay+0.1
local texingPanelPos=self.texingPanel:getChildLocalPosition()
self.texingPanel:setLocalPosY(texingPanelPos.y-600)
self:delayDo(delay,function()
self.texingPanel:setChildDOLocalMoveY(texingPanelPos.y,0.3)
end)
delay=delay+0.1


local titlePos3=self.title3:getChildLocalPosition()
local skillPanelPos=self.skillPanel:getChildLocalPosition()
local talentSkillPanelPos=self.talentSkillPanel:getChildLocalPosition()
self.title3:setLocalPosY(titlePos3.y-600)
self.skillPanel:setLocalPosY(skillPanelPos.y-600)
self.talentSkillPanel:setLocalPosY(talentSkillPanelPos.y-600)
self:delayDo(delay,function()
self.title3:setChildDOLocalMoveY(titlePos3.y,0.3)
self.skillPanel:setChildDOLocalMoveY(skillPanelPos.y,0.3)
self.talentSkillPanel:setChildDOLocalMoveY(talentSkillPanelPos.y,0.3)
end)
end


