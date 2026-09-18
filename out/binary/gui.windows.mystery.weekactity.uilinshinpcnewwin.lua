







def_class("UILinShiNPCNewWin",UIWindowBase)









function UILinShiNPCNewWin:bindComponents()

self.root=UIObject.get(self,0)
self.effect1=UIObject.get(self,1)
self.effect2=UIObject.get(self,2)
self.info=UIObject.get(self,3)
self.effect3=UIObject.get(self,4)
self.baitie=UIObject.get(self,5)
self.jieyouAnimaion=UIObject.get(self,6)
self.tipsImg=UIObject.get(self,7)
self.leftDrag=UIObject.get(self,8)
self.rightDrag=UIObject.get(self,9)
self.shengziYou=UIObject.get(self,10)
self.jiezuoAnimaion=UIObject.get(self,11)
self.shengziZuo=UIObject.get(self,12)
self.nextBtn=UIButton.get(self,13)
self.lastBtn=UIButton.get(self,14)
self.diziList=UIObject.get(self,15)
self.pinjiBg=UIImage.get(self,16)
self.model=UIObject.get(self,17)
self.speak=UIObject.get(self,18)
self.name=UIText.get(self,19)
self.pinjiImg=UIImage.get(self,20)
self.head=UIObject.get(self,21)
self.speakText=UILinkImageText.get(self,22)
self.zhaoruImg=UIObject.get(self,23)
self.jujueImg=UIObject.get(self,24)
self.btns=UIObject.get(self,25)
self.tixiu=UIText.get(self,26)
self.lichang=UIText.get(self,27)
self.xingbie=UIText.get(self,28)
self.jingjie=UIText.get(self,29)
self.zhongzu=UIText.get(self,30)
self.shouyuan=UIText.get(self,31)
self.descScrollView=UIObject.get(self,32)
self.skillScrollView=UIObject.get(self,33)
self.polygonAttrPanel=UIObject.get(self,34)
self.totalValue=UIText.get(self,35)
self.skills=UIObject.get(self,36)
self.zhiye=UIText.get(self,37)
self.giveUpBtn=UIButton.get(self,38)
self.selectBtn=UIButton.get(self,39)
self.costPanel=UIObject.get(self,40)
self.costImage=UIImage.get(self,41)
self.costTxt=UIText.get(self,42)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)

self.lastBtn:setButtonClick(function()self:onLastBtn()end)

self.giveUpBtn:setButtonClick(function()self:onGiveUpBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)



end


function UILinShiNPCNewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.baitie);self.baitie=nil;
_UIObject_release(self.jieyouAnimaion);self.jieyouAnimaion=nil;
_UIObject_release(self.tipsImg);self.tipsImg=nil;
_UIObject_release(self.leftDrag);self.leftDrag=nil;
_UIObject_release(self.rightDrag);self.rightDrag=nil;
_UIObject_release(self.shengziYou);self.shengziYou=nil;
_UIObject_release(self.jiezuoAnimaion);self.jiezuoAnimaion=nil;
_UIObject_release(self.shengziZuo);self.shengziZuo=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.lastBtn);self.lastBtn=nil;
_UIObject_release(self.diziList);self.diziList=nil;
_UIObject_release(self.pinjiBg);self.pinjiBg=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.speak);self.speak=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.pinjiImg);self.pinjiImg=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.zhaoruImg);self.zhaoruImg=nil;
_UIObject_release(self.jujueImg);self.jujueImg=nil;
_UIObject_release(self.btns);self.btns=nil;
_UIObject_release(self.tixiu);self.tixiu=nil;
_UIObject_release(self.lichang);self.lichang=nil;
_UIObject_release(self.xingbie);self.xingbie=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.zhongzu);self.zhongzu=nil;
_UIObject_release(self.shouyuan);self.shouyuan=nil;
_UIObject_release(self.descScrollView);self.descScrollView=nil;
_UIObject_release(self.skillScrollView);self.skillScrollView=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.totalValue);self.totalValue=nil;
_UIObject_release(self.skills);self.skills=nil;
_UIObject_release(self.zhiye);self.zhiye=nil;
_UIObject_release(self.giveUpBtn);self.giveUpBtn=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costImage);self.costImage=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
end


















local _this
local proSkillSort={1,3,5,7,2,4,6,8}


function UILinShiNPCNewWin:onLoaded(...)
self:bindComponents()

_this=self
self.abName='ui/sharedtextures/uiglobalspriteatlas_1.ab'
self.jobab='ui/windows/disciple/sharedtextures/uidisciplejobicons.ab'
self.yxtAB='ui/windows/recruit/sharedtextures/yinxiantai_new.ab'
self.smABName='ui/windows/shanmen/sharedtextures/shanmen.ab'
self.descScrollView:setChildScrollViewInit(0,true,self.onDescSlotClick,nil)
self.skillScrollView:setChildScrollViewInit(0,true,nil,nil)

self.minFrame=0
self.maxFrame=12
self.currLeftFrame=0
self.currRightFrame=0

self.winlua:SetChildUIDragEvent(self.leftDrag:getID(),0,self.beginLeftDragCallback,self.endLeftDragCallback,self.leftDragCallback)
self.winlua:SetChildUIDragEvent(self.rightDrag:getID(),0,self.beginRightDragCallback,self.endRightDragCallback,self.rightDragCallback)
end


function UILinShiNPCNewWin:__delete()
self:unbindComponents()
_this=nil


end




function UILinShiNPCNewWin:onShow(argtable,afterOnloaded)
local datas=argtable.npcList
self.callback=argtable.callback

self:openInfo(datas)
end


function UILinShiNPCNewWin:onHide()

end

function UILinShiNPCNewWin:openInfo(datas)
self.effect1:setChildShowEffect(10112,false)
self.effect2:setChildShowEffect(10113,false)
self:setTimer(0.25,1,function()
self.effect3:setChildShowEffect(10111,true)
end)

self.root:setAnimatorInteger('state',1,true)
self.leftDrag:setActive(false)
self.rightDrag:setActive(false)
self.descScrollView:setActive(true)
self.skillScrollView:setActive(true)


local showList={}
for i,v in ipairs(datas)do
local cfg=cfgHelper.get(cfg_fightnpcconfig_get,v)
table.insert(showList,{id=v,cfg=cfg})
end
self.disciples=showList
self.roleIndex=1
self:refreshWin()
local showDzList=#showList>1
self.diziList:setActive(showDzList)
self.lastBtn:setActive(showDzList)
self.nextBtn:setActive(showDzList)
if showDzList then
self:initDiZiList()
end
end


function UILinShiNPCNewWin:refreshWin()
local data=self.disciples[self.roleIndex]
self:refreshInfo(data)
end


function UILinShiNPCNewWin:initDiZiList()
self.diziList:setChildLayoutGroupCreateItems(#self.disciples,function(index)
self:setDZItem(index)
end)
end


function UILinShiNPCNewWin:setDZItem(index)
local item=self.diziList:getChildLayoutGroupGridItem(index-1)
if item then
local data=self.disciples[index]
local cfg=data.cfg
local image=cfg.image
item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame2[cfg.color])
item:SetChildUIModelShowTarget(1,image[1],0.5,image[2],eAnimationID.stand)
item:SetChildUIModelShowTargetOffset(1,0,-28)
item:SetChildActive(2,self.roleIndex==index)
local name=cfg.name
item:SetChildText(3,name)
item:SetChildButtonClickWithID(0,function(index)
self:onClickDZItem(index)
end,index)



item:SetChildActive(4,false)
item:SetChildActive(5,false)
end
end

function UILinShiNPCNewWin:onClickDZItem(index)
if self.roleIndex==index then return end
local lastItem=self.diziList:getChildLayoutGroupGridItem(self.roleIndex-1)
if lastItem then
lastItem:SetChildActive(2,false)
end
self.roleIndex=index
local item=self.diziList:getChildLayoutGroupGridItem(self.roleIndex-1)
item:SetChildActive(2,true)
local data=self.disciples[self.roleIndex]

self:refreshInfo(data)
end

function UILinShiNPCNewWin:refreshInfo(data)
local cfg=data.cfg
local info=cfg.image
self.dzId=cfg.id

self.pinjiImg:setSprite(self.yxtAB,FMT.fmt('image_pinjishibie_{0}',cfg.color))
self.pinjiBg:setSprite(self.smABName,FMT.fmt('image_baitiedizipz_{0}',cfg.color))
local modelParams={body=info[1],componets=info[2]}
comHelper.setChildInSideModelEx(self.head,modelParams,1.5,0,0,-100,false,true)
self.head:setChildUIModelShowFlipX(true)
local modelParams=fightPreSelectModel.getNPCOutSideModel(cfg.id)
self.model:setChildUIModelShowTarget(modelParams[1],1,modelParams[2]or{},eAnimationID.stand,false,false,0,function(...)
self.model:setChildUIModelShowFlipX(true)
self.model:setChildUIModelShowTargetOffset(0,-50)
end)
self.name:setText(cfg.name)


self.zhongzu:setText(cfgHelper.get2(cfg_discipleraceconfig_get,cfg.race or 0,'name'))
self.xingbie:setText(cfgHelper.get2(cfg_disciplesexconfig_get,cfg.sex or 1,'name'))
self.shouyuan:setText(cfg.shouyuan)
self.lichang:setText(cfgHelper.get2(cfg_disciplestandconfig_get,cfg.stand or 1,'name'))
self.zhiye:setText(cfgHelper.get2(cfg_disciplevocationconfig_get,cfg.job or 1,'name'))
local n,p,pN=UIDiscipleModel:getJJNameX(cfg.jingjie or 1)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}',n,pN)
else
jj_str=n
end
self.jingjie:setText(jj_str)
local n1,p1=UIDiscipleModel:getLTNameX(cfg.lianti or 1)
local lt_lv_str=''
if p1~=nil then
lt_lv_str=FMT.fmt('{0}层',p1)
end
local lt_str=FMT.fmt('{0}{1}',n1,lt_lv_str)
self.tixiu:setText(lt_str)

self:RefreshDesc(cfg)

self:refreshPorSkill(cfg)

local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
local attrList=cfg.attr6 or{}
for i,v in ipairs(attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
end
local tVal=0
local wiget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=attrList[attrType]==0 and 1 or attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#069067>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
tVal=tVal+v
end
wiget:SetChildUIPolygonImage(6,ratelist,0)

local color=cfg.color
local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)
self.totalValue:setText(FMT.fmt('总值：{0}',tVal))

local skillList=self:GetJobSkillList(cfg)

self.skills:setChildLayoutGroupCreateItems(#skillList)
local items=self.skills:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local sdata=skillList[i+1]
local skillID=sdata[1]
local skillLv=sdata[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0
item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),true)
item:SetChildImageExGray(0,islock)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)
item:SetChildButtonClick(3,function()
UIManager:showWindow('UIDiscipleJobSkillTipsWin',{skillID=skillID,skillLv=skillLv,attend=1})
end)
item:SetChildActive(4,not islock)
if not islock then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end
item:SetChildActive(5,islock)
end
self.ddata=data
end

function UILinShiNPCNewWin:GetJobSkillList(data)
local groupid=data.vocskilllib
local result=UIDiscipleModel:getDiscipleJobSkillListEx(groupid,data.job,data.jingjie)
return result
end

function UILinShiNPCNewWin:insertSpeList(specialityList,list,SPEType)
if list then
local lst={specialitytype=SPEType,specialityLst={}}
for i,v in ipairs(list)do
table.insert(lst.specialityLst,{param_1=v,param_2=0})
end
table.insert(specialityList,lst)
end
end

function UILinShiNPCNewWin:RefreshDesc(data)
local d=data.specialityList
if not d then
local specialityList={}
self:insertSpeList(specialityList,data.spiritrootlib,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
self:insertSpeList(specialityList,data.bodylib,DISCIPLE_SPECIALITY_TYPE.eBody)
self:insertSpeList(specialityList,data.talentlib,DISCIPLE_SPECIALITY_TYPE.eTalent)
self:insertSpeList(specialityList,data.strangelib,DISCIPLE_SPECIALITY_TYPE.eStrange)
data.specialityList=specialityList
end

local desclist=UIDiscipleModel:getDiscipleSpecialityConfigByData(data)
if not desclist then
return
end
local dataNum=#desclist
self.descScrollView:setChildScrollViewCreateGrids(dataNum,4)

local grids=self.descScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local cfg=desclist[i]
local item=grids[i-1]
UIDiscipleModel.refreshSpecialityItemEx(item,cfg)
end

self.desclist=desclist
end

function UILinShiNPCNewWin.onDescSlotClick(clickNum,index)
local cfg=_this.desclist[index+1]
local item=_this.descScrollView:getChildScrollViewItemWidget(index)
local data=_this.disciples[_this.roleIndex]
local baseData=data.discipleInfo

if UIDiscipleModel.onClickClientSpeciality(item,baseData,cfg,eDirectionType.eRight)then
return
end

UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',config=cfg})
end

function UILinShiNPCNewWin:getPorSkillDatas(proskilllist)
local list={}
if not proskilllist then
return list
end
local len=#proSkillSort
for i=1,len do
local ptype=proSkillSort[i]
local data=proskilllist[ptype]
if data>0 then
table.insert(list,{type=ptype,level=data})
end
end
return list
end

function UILinShiNPCNewWin:refreshPorSkill(data)
local dataList=self:getPorSkillDatas(data.proskill)
local len=#dataList
self.skillScrollView:setChildScrollViewCreateGrids(len,2)

local grids=self.skillScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local pd=dataList[i]
local item=grids[i-1]
local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,pd.type,'icon')
item:SetChildCSImageSprite(0,self.jobab,FMT.fmt('image_gongzhongtp_{0}',icon))
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,pd.type,'name')
item:SetChildText(1,FMT.fmt('{0}：{1}级',name,pd.level))
end
end




function UILinShiNPCNewWin:onNextBtn()
local index=self.roleIndex+1
if index>#self.disciples then
index=1
end
self:onClickDZItem(index)
end



function UILinShiNPCNewWin:onLastBtn()
local index=self.roleIndex-1
if index<1 then
index=#self.disciples
end
self:onClickDZItem(index)
end



function UILinShiNPCNewWin:onGiveUpBtn()
end



function UILinShiNPCNewWin:onSelectBtn()
local callback=self.callback
if callback then
callback(self.dzId)
end
self:closeSelf()
end

function UILinShiNPCNewWin:onClickClose()
self:closeSelf()
end