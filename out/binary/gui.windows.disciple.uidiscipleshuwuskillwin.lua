







def_class("UIDiscipleShuWuSkillWin",UIWindowBase)









function UIDiscipleShuWuSkillWin:bindComponents()

self.mask=UIObject.get(self,0)
self.effect2=UIObject.get(self,1)
self.skillIconA=UIObject.get(self,2)
self.skillIconB=UIObject.get(self,3)
self.skillIconC=UIObject.get(self,4)
self.fullTips=UIText.get(self,5)
self.levelUpPanel=UIObject.get(self,6)
self.skillTips=UIText.get(self,7)
self.attrScrollView=UIObject.get(self,8)
self.effect=UIObject.get(self,9)
self.order=UIText.get(self,10)
self.levelName=UIText.get(self,11)
self.pdAddValue=UIText.get(self,12)
self.pdImage=UIImage.get(self,13)
self.skillTree=UIObject.get(self,14)
self.tzScrollView=UIObject.get(self,15)
self.fightValue=UIText.get(self,16)
self.helpBtn=UIButton.get(self,17)
self.costScrollView=UIObject.get(self,18)
self.needFValue=UIText.get(self,19)
self.levelUpBtn=UIButton.get(self,20)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)



end


function UIDiscipleShuWuSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.skillIconA);self.skillIconA=nil;
_UIObject_release(self.skillIconB);self.skillIconB=nil;
_UIObject_release(self.skillIconC);self.skillIconC=nil;
_UIObject_release(self.fullTips);self.fullTips=nil;
_UIObject_release(self.levelUpPanel);self.levelUpPanel=nil;
_UIObject_release(self.skillTips);self.skillTips=nil;
_UIObject_release(self.attrScrollView);self.attrScrollView=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.order);self.order=nil;
_UIObject_release(self.levelName);self.levelName=nil;
_UIObject_release(self.pdAddValue);self.pdAddValue=nil;
_UIObject_release(self.pdImage);self.pdImage=nil;
_UIObject_release(self.skillTree);self.skillTree=nil;
_UIObject_release(self.tzScrollView);self.tzScrollView=nil;
_UIObject_release(self.fightValue);self.fightValue=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.costScrollView);self.costScrollView=nil;
_UIObject_release(self.needFValue);self.needFValue=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
end



















function UIDiscipleShuWuSkillWin:onLoaded(...)
self:bindComponents()

self.skillItems={
self.skillIconA,
self.skillIconB,
self.skillIconC
}

self.tzScrollView:setChildScrollViewInit(0.5,true,function(...)self:on_tz_select(...)end,nil)
self.attrScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.costScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIDiscipleShuWuSkillWin:__delete()
self:unbindComponents()
end

function UIDiscipleShuWuSkillWin:on_tz_select(num,index)
local item=self.tzScrollView:getChildScrollViewItemWidget(index)
local pos=item:GetChildPosition(-1)
local offset={0,-30}
local tt=self.tzAttrList[index+1]
local tn=UIDiscipleModel:discipleBaseAttrName(tt)
local cnt=FMT.fmt('{0}的{1}值可提供额外的庶务实力加成',self.dzData.disciplename,tn)
UIManager:showWindow('UICommonHelpWin',{worldPos=pos,anchoredOffset=offset,htype=4,content=cnt})
end




function UIDiscipleShuWuSkillWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable
self.dzData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

self:refresh()
end

function UIDiscipleShuWuSkillWin:refresh()
local qjLevel=self.dzData.qiaojianglv
local nextcfg=cfgHelper.get1(cfg_discipleqiaojiangconfig_get,qjLevel+1)
self.isFull=nextcfg==nil
self.attrs=self:countAttr()
self:setInfo()
self:setSkill()
self:setTZList()
self:setAttrs()
self:setCost()

self.levelUpPanel:setActive(not self.isFull)
self.fullTips:setActive(self.isFull)
end


function UIDiscipleShuWuSkillWin:onHide()

end

function UIDiscipleShuWuSkillWin:setTZList()
local id=self.dzData.id
local swcfg=UIDiscipleModel:getShuWuDZConfig(id)
local attrs={}
for i,v in ipairs(swcfg.attr6)do
if v>1 then
table.insert(attrs,i)
end
end
self.tzAttrList=attrs
local len=#attrs
self.tzScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.tzScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local tt=attrs[i]
local name=UIDiscipleModel:discipleBaseAttrName(tt)
item:SetChildText(1,name)
end
end

function UIDiscipleShuWuSkillWin:setInfo()
local id=self.dzData.id
local qjLevel=self.dzData.qiaojianglv
local swcfg=UIDiscipleModel:getShuWuDZConfig(id)
local name,order=UIDiscipleModel:getShuWuQJLevelInfo(swcfg.bdId,qjLevel)
self.levelName:setText(name)
self.order:setText(FMT.fmt('{0}阶',order))

local pdval,ptype=UIDiscipleModel:countShuWUDZSelfPDAddValue(self.dzData)
self.pdImage:setSprite(globalABLookup.shuwusprite,shuWuPDImage[ptype])
self.pdAddValue:setText(FMT.fmt('+{0}%',pdval))














self.fvalue=UIDiscipleModel:getShuWuFightValue(self.disciple_guid)
self.fightValue:setText(self.fvalue)

self.effect:setChildShowEffect(10518,true)
end

function UIDiscipleShuWuSkillWin:findTipsSkillCfg(qjLevel)
local cfgs=cfg_discipleshuwuskillconfig()
for i,v in ipairs(cfgs)do
if v.qiaojiang==qjLevel then
return v
end
end
end

function UIDiscipleShuWuSkillWin:setAttrs()
local len=#self.attrs
self.attrScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.attrScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.attrs[i]
if data.htype==-1 then
item:SetChildText(0,data.stageName1)
item:SetChildText(1,'')
item:SetChildText(2,data.stageName2)
elseif data.htype==9 then
local bdname=cfgHelper.get2(cfg_monijybuildconfig_get,data.btype,'name')
item:SetChildText(0,FMT.fmt('所在{0}中炼制丹药效率',bdname))
item:SetChildText(1,FMT.fmt('+{0}%',math.abs(data.percent)))
local showAdd=data.add~=nil
item:SetChildActive(2,showAdd)
if showAdd then
item:SetChildText(2,FMT.fmt('{0}%',math.abs(data.add)))
end
else
local ptname=moneyModel.getMoneyName(data.ptype)
local bdname=cfgHelper.get2(cfg_monijybuildconfig_get,data.btype,'name')
item:SetChildText(0,FMT.fmt('所在{0}中{1}产量',bdname,ptname))
item:SetChildText(1,FMT.fmt('+{0}%',data.percent))
local showAdd=data.add~=nil
item:SetChildActive(2,showAdd)
if showAdd then
item:SetChildText(2,FMT.fmt('{0}%',data.add))
end
end
end

local tcfg=self:findTipsSkillCfg(self.dzData.qiaojianglv+1)
if tcfg then
local info=cfgHelper.get1(cfg_discipleshuwuskillinfoconfig_get,tcfg.sid)
if tcfg.slv==0 then
self.skillTips:setText(FMT.fmt('可激活庶务技能【{0}】',info.name))
else
self.skillTips:setText(FMT.fmt('庶务技能【{0}】可升至{1}级',info.name,tcfg.slv))
end
else
self.skillTips:setText('')
end
end

function UIDiscipleShuWuSkillWin:countAttr()
local qjLevel=self.dzData.qiaojianglv
local id=self.dzData.id
local bonus=cfgHelper.get2(cfg_discipleqiaojiangconfig_get,qjLevel,'bonus')
local attrs=bonus[id]
local nextcfg=cfgHelper.get1(cfg_discipleqiaojiangconfig_get,qjLevel+1)
local nextAttr=nextcfg and nextcfg.bonus[id]
local list={}
local cfg=UIDiscipleModel:getShuWuDZConfig(id)
for i,v in ipairs(attrs)do
local ptype=cfg.produceType
local data={
btype=v[2],
htype=v[1],
ptype=ptype,
percent=v[3],
}
if nextAttr then
data.add=nextAttr[i][3]-v[3]
end
list[#list+1]=data
end
local swcfg=UIDiscipleModel:getShuWuDZConfig(id)
local stage,order=UIDiscipleModel:countShuWuQJStageValue(qjLevel)
local stage2,order2=UIDiscipleModel:countShuWuQJStageValue(qjLevel+1)
if stage2 and stage2>stage then
local stageName1=UIDiscipleModel:getShuWuQJStageName(swcfg.bdId,stage)
local stageName2=UIDiscipleModel:getShuWuQJStageName(swcfg.bdId,stage2)
local data={
htype=-1,
stageName1=stageName1,
stageName2=stageName2,
}
list[#list+1]=data
end
return list
end

function UIDiscipleShuWuSkillWin:setCost()
local qjLevel=self.dzData.qiaojianglv
local cfg=cfgHelper.get1(cfg_discipleqiaojiangconfig_get,qjLevel)
local id=self.dzData.id
local len=#cfg.consume[id]
self.costScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.costScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=cfg.consume[id][i]
widgetHelper.setNormalRewardItem(item,0,{data[1],data[2],checkAmount=true})
end

if self.fvalue>=cfg.strength then
self.needFValue:setText(cfg.strength)
else
self.needFValue:setText(FMT.fmt('<color=red>{0}</color>',cfg.strength))
end
end

function UIDiscipleShuWuSkillWin:setSkill()
local skillLevelData=self.dzData.swList or{}
local id=self.dzData.id
local qjLevel=self.dzData.qiaojianglv
local cfg=UIDiscipleModel:getShuWuDZConfig(id)
local skillList=cfg.skill
for i,v in ipairs(self.skillItems)do
local skillId=skillList[i]
local level=skillLevelData[i]or 0
local isActive=level>0

local skillInfo=cfgHelper.get1(cfg_discipleshuwuskillinfoconfig_get,skillId)
local icon=iconHelper.getSkillIcon(skillInfo.icon)
local widget=v:getChildWidgetBase()
widget:SetChildIcon(0,icon,true)
widget:SetChildGraphicGray(0,not isActive)
local check=UIDiscipleController:checkShuWuDZSkillReddot(self.dzData,i)
widget:SetChildActive(1,check)
widget:SetChildActive(2,not isActive)
widget:SetChildButtonClick(0,function()
UIManager:showWindow('UIDiscipleShuWuSkillTipsWin',{id=skillId,level=level,dzId=self.disciple_guid})
end)
end

local lastVal=0
if qjLevel>1 then
lastVal=cfgHelper.get2(cfg_discipleqiaojiangconfig_get,qjLevel-1,'strength')
end
local strength=cfgHelper.get2(cfg_discipleqiaojiangconfig_get,qjLevel,'strength')
local dv=strength-lastVal
local cv=self.fvalue-lastVal
self.skillTree:setChildUIProgressbar(cv,dv,false)
end

function UIDiscipleShuWuSkillWin:playLevelUp()
self.mask:setActive(true)
self.effect2:setChildShowEffect(10013,true)
self:delayDo(2.5,function()
UIManager:showWindow('UIDiscipleShuWuUpWin',{dzId=self.disciple_guid})
if UIDiscipleController:checkShuWuQJLevelUp(self.dzData.qiaojianglv,self.fvalue,self.disciple_guid)then
self.mask:setActive(false)
else
self:onCloseClick()
end
end)
end



function UIDiscipleShuWuSkillWin:onLevelUpBtn()
if UIDiscipleController:checkShuWuQJLevelUp(self.dzData.qiaojianglv,self.fvalue,self.disciple_guid,true)then
UIDiscipleController:reqQiaoJiangLevelUp(self.disciple_guid)
end
end

function UIDiscipleShuWuSkillWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_shuwu_dizi_help_%s'})
end

function UIDiscipleShuWuSkillWin:onCloseClick()
self:closeSelf()
end
