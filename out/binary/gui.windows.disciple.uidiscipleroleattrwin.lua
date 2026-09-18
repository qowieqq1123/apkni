







def_class("UIDiscipleRoleAttrWin",UIWindowBase)









function UIDiscipleRoleAttrWin:bindComponents()

self.alllAttrPointNumText=UIText.get(self,0)
self.polygonAttrPanel=UIObject.get(self,1)
self.lifeText=UIText.get(self,2)
self.loyaltyText=UIText.get(self,3)
self.standPointText=UIText.get(self,4)
self.injuryText=UIText.get(self,5)
self.raceText=UIText.get(self,6)
self.descListPanel=UIObject.get(self,7)
self.proSkillGrid=UIObject.get(self,8)
self.sexText=UIText.get(self,9)
self.root=UIObject.get(self,10)
self.injuryHelp=UIButton.get(self,11)
self.loyaltyHelp=UIButton.get(self,12)
self.sixAttrHelp=UIButton.get(self,13)
self.injuryBtn=UIButton.get(self,14)
self.lifeBtn=UIButton.get(self,15)
self.proSkillUpBtn=UIButton.get(self,16)
self.discipleNameText=UIText.get(self,17)
self.discipleJobIcon=UIImage.get(self,18)
self.changeNameBtn=UIButton.get(self,19)
self.shareBtn=UIButton.get(self,20)
self.colorSign=UIImage.get(self,21)
self.colorSignbtn=UIButton.get(self,22)
self.imgreddot=UIObject.get(self,23)
self.discipleJobIcon2=UIImage.get(self,24)
self.spBg=UIObject.get(self,25)

self.injuryHelp:setButtonClick(function()self:onInjuryHelp()end)

self.loyaltyHelp:setButtonClick(function()self:onLoyaltyHelp()end)

self.sixAttrHelp:setButtonClick(function()self:onSixAttrHelp()end)

self.injuryBtn:setButtonClick(function()self:onInjuryBtn()end)

self.lifeBtn:setButtonClick(function()self:onLifeBtn()end)

self.proSkillUpBtn:setButtonClick(function()self:onProSkillUpBtn()end)

self.changeNameBtn:setButtonClick(function()self:onChangeNameBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.colorSignbtn:setButtonClick(function()self:onColorSignbtn()end)



end


function UIDiscipleRoleAttrWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.alllAttrPointNumText);self.alllAttrPointNumText=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.lifeText);self.lifeText=nil;
_UIObject_release(self.loyaltyText);self.loyaltyText=nil;
_UIObject_release(self.standPointText);self.standPointText=nil;
_UIObject_release(self.injuryText);self.injuryText=nil;
_UIObject_release(self.raceText);self.raceText=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.proSkillGrid);self.proSkillGrid=nil;
_UIObject_release(self.sexText);self.sexText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.injuryHelp);self.injuryHelp=nil;
_UIObject_release(self.loyaltyHelp);self.loyaltyHelp=nil;
_UIObject_release(self.sixAttrHelp);self.sixAttrHelp=nil;
_UIObject_release(self.injuryBtn);self.injuryBtn=nil;
_UIObject_release(self.lifeBtn);self.lifeBtn=nil;
_UIObject_release(self.proSkillUpBtn);self.proSkillUpBtn=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.changeNameBtn);self.changeNameBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.colorSign);self.colorSign=nil;
_UIObject_release(self.colorSignbtn);self.colorSignbtn=nil;
_UIObject_release(self.imgreddot);self.imgreddot=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.spBg);self.spBg=nil;
end
















local _this=nil
local proSkillSort={1,3,5,7,2,4,6,8}


function UIDiscipleRoleAttrWin:onLoaded(...)
self:bindComponents()
_this=self
self.proSkillPage=false
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:listenNotify(notifyConfig.onDiscipleLoyaltyChange,self.onDiscipleLoyaltyChange)
notifySystem:listenNotify(notifyConfig.onDiscipleInjuryChange,self.onDiscipleInjuryChange)
notifySystem:listenNotify(notifyConfig.onDiscipleShouYuanChange,self.onDiscipleShouYuanChange)
notifySystem:listenNotify(notifyConfig.onDiscipleNameChange,self.onDiscipleNameChange)
notifySystem:listenNotify(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)
end


function UIDiscipleRoleAttrWin:__delete()
self:unbindComponents()
if self.linkRoadTimer then
self:stopTimerByID(self.linkRoadTimer)
self.linkRoadTimer=nil
end
_this=nil
notifySystem:removelistener(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:removelistener(notifyConfig.onDiscipleLoyaltyChange,self.onDiscipleLoyaltyChange)
notifySystem:removelistener(notifyConfig.onDiscipleInjuryChange,self.onDiscipleInjuryChange)
notifySystem:removelistener(notifyConfig.onDiscipleShouYuanChange,self.onDiscipleShouYuanChange)
notifySystem:removelistener(notifyConfig.onDiscipleNameChange,self.onDiscipleNameChange)
notifySystem:removelistener(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)
end




function UIDiscipleRoleAttrWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
self:refreshPolygonAtrrPanel()
self:refreshPorSkill()
self:refreshLeftPanel()
end

function UIDiscipleRoleAttrWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end


function UIDiscipleRoleAttrWin:OnEnable()

end


function UIDiscipleRoleAttrWin:OnDisable()

end

function UIDiscipleRoleAttrWin:refreshPolygonAtrrPanel()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
for i,v in ipairs(netData.attrList)do
local a=v==0 and 1 or v

allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
end
self.alllAttrPointNumText:setText(FMT.fmt('总值：{0}',allnum))

local wiget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=netData.attrList[attrType]==0 and 1 or netData.attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#549327>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
end
wiget:SetChildUIPolygonImage(6,ratelist,0)

local color=UIDiscipleModel:getDiscipleColor(self.disciple_guid)
local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)
end

function UIDiscipleRoleAttrWin:refreshLife()
local guid=self.disciple_guid
local shouyuan=UIDiscipleModel:getDiscipleShouYuanDesc(guid)
local life_str=FMT.fmt('寿元：<color=#181412>{0}</color>',shouyuan)
self.lifeText:setText(life_str)
local showBtn=true
if self.showType==dicipleType.eTemp then
showBtn=false
else
local sy=UIDiscipleModel:getDiscipleShouYuan(guid)
if sy==-1 then
showBtn=false
end
end
self.lifeBtn:setActive(showBtn)
end

function UIDiscipleRoleAttrWin:refreshInjury()
local guid=self.disciple_guid
local netData=UIDiscipleModel:getDiscipleData(guid)
local injury_name=UIDiscipleModel:getDiscipleInjuryNameEx(guid,'<color=red>(%s)</color>')
local injury_str=FMT.fmt('负伤：<color=#181412>{0}{1}</color>',netData.injury,injury_name)
self.injuryText:setText(injury_str)
local showBtn=true
if self.showType==dicipleType.eTemp then
showBtn=false
else
if netData.injury<=0 then
showBtn=false
end
end
self.injuryBtn:setActive(showBtn)
end

function UIDiscipleRoleAttrWin:refreshLoyalty()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local loyalty_str=FMT.fmt('忠诚：<color=#181412>{0}</color>',netData.loyalty or 0)
self.loyaltyText:setText(loyalty_str)
end

function UIDiscipleRoleAttrWin:refreshName()

self.discipleNameText:setText(UIDiscipleModel:getDiscipleName(self.disciple_guid))
end

function UIDiscipleRoleAttrWin:refreshLeftPanel()

self:refreshName()

local jobicon=UIDiscipleModel:getJobIconNameX(self.disciple_guid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(self.disciple_guid)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(self.disciple_guid,switchidx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end

local showChangeName=false
if self.showType==dicipleType.eSystem then
if not UIDiscipleModel:isPlotDisciple(self.disciple_guid)then
showChangeName=true
end
end


local guid=self.disciple_guid
local disciple_id=UIDiscipleModel:getDiscipleData(guid).id
local flag=cfgHelper.get2(cfg_discipleconfig_get,disciple_id,'flag')
if flag and flag>=16 then
showChangeName=false
end

self.changeNameBtn:setActive(showChangeName)

self:refreshLife()

local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.disciple_guid)
local race_str=FMT.fmt('种族：<color=#181412>{0}</color>',cfgHelper.get2(cfg_discipleraceconfig_get,imageInfo.race,'name'))
self.raceText:setText(race_str)

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local stand_str=FMT.fmt('立场：<color=#181412>{0}</color>',cfgHelper.get2(cfg_disciplestandconfig_get,netData.stand,'name'))
self.standPointText:setText(stand_str)

self:refreshInjury()

self:refreshLoyalty()

local sex_str=FMT.fmt('性别：<color=#181412>{0}</color>',cfgHelper.get2(cfg_disciplesexconfig_get,imageInfo.sex,'name'))
self.sexText:setText(sex_str)


self.desclist=UIDiscipleModel:getDiscipleSpecialityConfig(self.disciple_guid,true)
local dataNum=#self.desclist
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local cfg=self.desclist[i]

local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onDescSlotClick(i)
end)
end
end

local color=UIDiscipleModel:getDiscipleColor(self.disciple_guid)
local color_icon=FMT.fmt('image_pinjishibie_{0}',color)
self.colorSign:setSprite(globalABLookup.global,color_icon)
local attrreddot=userActorSetting.get('RoleAttrWin_attrreddot',false)
self.imgreddot:setActive(not attrreddot)
end

function UIDiscipleRoleAttrWin:onDescSlotClick(idx)
local cfg=self.desclist[idx]
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

if UIDiscipleModel.onClickClientSpeciality(item,netData,cfg,eDirectionType.eLeft)then
return
end
if idx>8 then
UIManager:showWindow('UISpecialityWin',{item=item,node='top',guid=self.disciple_guid,config=cfg,pivot=Vector2(0.5,0)})
else
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.disciple_guid,config=cfg})
end
end

function UIDiscipleRoleAttrWin:refreshPorSkill(playAnim)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local proskilllist=netData.proskillList
self.proSkillGrid:setChildLayoutGroupCreateItems(#proSkillSort)
local gridlist=self.proSkillGrid:getChildLayoutGroupGridList()
local c=gridlist.Count
if c>0 then
for i=1,c do
local ty=proSkillSort[i]
local item=gridlist[i-1]
local d=proskilllist[ty]

local name=cfgHelper.get2(cfg_discipleproskillconfig_get,ty,'name')
item:SetChildText(0,name)

item:SetChildText(3,FMT.fmt('{0}级',d.level))

local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local curexp=d.exp
local maxexp=explist[d.level]
local nextexp=explist[d.level+1]
local isFull=nextexp==nil
local a,b=curexp,maxexp
if not isFull then
if a>b then
a=b
end
else
a=1
b=1
end
item:SetChildProgress(2,a,b)
if not isFull then
local rate=math.floor((a/b)*100)
local str1=FMT.fmt('{0}%',rate)
local str2=FMT.fmt('{0}/{1}',a,b)
item:SetChildText(4,str1)
item:SetChildText(5,str2)
if self.proSkillPage==true then
if playAnim then
self:proSkillAnima(item,4,5,playAnim)
else
self:proSkillAnima(item,5,4,playAnim)
end
else
if playAnim then
self:proSkillAnima(item,5,4,playAnim)
else
self:proSkillAnima(item,4,5,playAnim)
end
end
else
local str='已满级'
item:SetChildText(4,str)
self:proSkillAnima(item,4,5,false)
end

local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,ty,'icon')
item:SetChildCSImageSprite(1,globalABLookup.proskill,'image_gongzhongtp_'..icon)
end
end
end

function UIDiscipleRoleAttrWin:proSkillAnima(item,curIndex,nextIndex,playAnim)
if playAnim then
local func=function()
self.lockClickPorskill=false
end
self.lockClickPorskill=true

item:SetChildLocalPosY(curIndex,0)
item:SetChildCanvasGroupAlpha(curIndex,1)
item:SetChildDOLocalMoveY(curIndex,20,0.4,func)
item:SetChildCanvasGroupDOFade(curIndex,0,0.4,nil)

item:SetChildLocalPosY(nextIndex,-20)
item:SetChildCanvasGroupAlpha(nextIndex,0)
item:SetChildDOLocalMoveY(nextIndex,0,0.4,nil)
item:SetChildCanvasGroupDOFade(nextIndex,1,0.4,nil)
else
item:SetChildLocalPosY(curIndex,0)
item:SetChildCanvasGroupAlpha(curIndex,1)
item:SetChildCanvasGroupAlpha(nextIndex,0)
end
end

function UIDiscipleRoleAttrWin:onInjuryHelp()
local offset=Vector2.New(15,10)
commonTipsHelper.showDiscipleInjuryHelp(self.injuryHelp,offset,2)
end

function UIDiscipleRoleAttrWin:onLoyaltyHelp()
local offset=Vector2.New(15,10)
commonTipsHelper.showDiscipleLoyaltyHelp(self.loyaltyHelp,offset)
end

function UIDiscipleRoleAttrWin:onSixAttrHelp()
local offset=Vector2.New(15,15)
local desc_str=cfgHelper.getlang('six_attrs_tips')
UIManager:showWindow('UIConditionTipsOne',{showType=2,str=desc_str,posItem=self.sixAttrHelp,pos=offset})
end

function UIDiscipleRoleAttrWin:onInjuryBtn()
UIFullDiscipleBatchTreatControl.showBatchZhiliaoWin(false,1,7,self.disciple_guid)
end

function UIDiscipleRoleAttrWin:onLifeBtn()
UIManager:showWindow('UIDiscipleChuiweiWin',{guid=self.disciple_guid,funcType=item_funtion_type.shouyuan})
end

function UIDiscipleRoleAttrWin:onChangeNameBtn()
UIManager:showWindow('UIDiscipleChangeNameWin',{guid=self.disciple_guid})
end

function UIDiscipleRoleAttrWin:onBottomPanelClick()
if self.lockClickPorskill then return end
self.proSkillPage=not self.proSkillPage
self:refreshPorSkill(true)
end

function UIDiscipleRoleAttrWin:onProSkillUpBtn()
local skillid=UIFuncItemUseModel:getHaveExpDanProskillId()
local args={type=item_funtion_type.pro_skill_exp,skillid=skillid,disguid=self.disciple_guid}
UIFuncItemUseModel:openFuncItemUseWin(args)

end

function UIDiscipleRoleAttrWin.onDiscipleJJChange(guid)
if _this==nil then return end

if mathHelper.compareInt64(guid,_this.disciple_guid)then
_this:refreshLife()
end
end

function UIDiscipleRoleAttrWin.onDiscipleLoyaltyChange(guid)
if _this==nil then return end

if mathHelper.compareInt64(guid,_this.disciple_guid)then
_this:refreshLoyalty()
end
end

function UIDiscipleRoleAttrWin.onDiscipleInjuryChange(guid,oldInjury,injury)
if _this==nil then return end

if mathHelper.compareInt64(guid,_this.disciple_guid)then
_this:refreshInjury()
end
end

function UIDiscipleRoleAttrWin.onDiscipleShouYuanChange(guid,old,shouyuan)
if _this==nil then return end

if mathHelper.compareInt64(guid,_this.disciple_guid)then
_this:refreshLife()
end
end

function UIDiscipleRoleAttrWin.onDiscipleNameChange(dis_guid,oldName,name)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:refreshName()
end

function UIDiscipleRoleAttrWin.onDiscipleJobChange(dis_guid,jobtype,oldlv,lv,oldexp,exp)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:refreshPorSkill()
end

function UIDiscipleRoleAttrWin:onShareBtn()
UIFullDiscipleMainControl:showWindow('UIShareDiscipleRoleInfoWin',{guid=self.disciple_guid})
end

function UIDiscipleRoleAttrWin:onColorSignbtn()
userActorSetting.set("RoleAttrWin_attrreddot",true)
userActorSetting.flush()
_this.imgreddot:setActive(false)
UIManager:showWindow('UIDiscipleAttrColorWin',{guid=self.disciple_guid})
end