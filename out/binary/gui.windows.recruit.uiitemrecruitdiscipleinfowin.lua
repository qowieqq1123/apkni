







def_class("UIItemRecruitDiscipleInfoWin",UIWindowBase)









function UIItemRecruitDiscipleInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.info=UIObject.get(self,1)
self.baitie=UIObject.get(self,2)
self.pinjiBg=UIImage.get(self,3)
self.model=UIObject.get(self,4)
self.speak=UIObject.get(self,5)
self.tixiu=UIText.get(self,6)
self.jingjie=UIText.get(self,7)
self.zhongzu=UIText.get(self,8)
self.lichang=UIText.get(self,9)
self.xingbie=UIText.get(self,10)
self.shouyuan=UIText.get(self,11)
self.speakText=UILinkImageText.get(self,12)
self.skillScrollView=UIObject.get(self,13)
self.head=UIObject.get(self,14)
self.pinjiImg=UIImage.get(self,15)
self.name=UIText.get(self,16)
self.descScrollView=UIObject.get(self,17)
self.skills=UIObject.get(self,18)
self.polygonAttrPanel=UIObject.get(self,19)
self.zhiye=UIText.get(self,20)
self.totalValue=UIText.get(self,21)



end


function UIItemRecruitDiscipleInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.baitie);self.baitie=nil;
_UIObject_release(self.pinjiBg);self.pinjiBg=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.speak);self.speak=nil;
_UIObject_release(self.tixiu);self.tixiu=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.zhongzu);self.zhongzu=nil;
_UIObject_release(self.lichang);self.lichang=nil;
_UIObject_release(self.xingbie);self.xingbie=nil;
_UIObject_release(self.shouyuan);self.shouyuan=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.skillScrollView);self.skillScrollView=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.pinjiImg);self.pinjiImg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.descScrollView);self.descScrollView=nil;
_UIObject_release(self.skills);self.skills=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.zhiye);self.zhiye=nil;
_UIObject_release(self.totalValue);self.totalValue=nil;
end

















local _this
local proSkillSort={1,3,5,7,2,4,6,8}


function UIItemRecruitDiscipleInfoWin:onLoaded(...)
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

end


function UIItemRecruitDiscipleInfoWin:__delete()
self:unbindComponents()
_this=nil
self:clearSpeakTimer()
self:killSpeakTweener()
end




function UIItemRecruitDiscipleInfoWin:onShow(argtable,afterOnloaded)

self.dzItemId=argtable.itemId

self.dzData=UIDiscipleModel:getItemDiscipleDataByItemId(self.dzItemId)


self:refreshWin()

end


function UIItemRecruitDiscipleInfoWin:onHide()

end

function UIItemRecruitDiscipleInfoWin:refreshWin()
local ddata=self.dzData
local info=ddata.imageInfo

self.pinjiImg:setSprite(self.yxtAB,FMT.fmt('image_pinjishibie_{0}',info.color))
self.pinjiBg:setSprite(self.smABName,FMT.fmt('image_baitiedizipz_{0}',info.color))
if ddata.hasFixedImage then

local insideInfo=UIDiscipleModel:getDiscipleInsideModelInfoEx(ddata)
comHelper.setChildInSideModelEx(self.head,insideInfo,1.5,0,0,-100,false,true)


local modelParams=UIDiscipleModel:getImageInfoHeadModelInfo(info)
self.model:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,eAnimationID.stand,false,false,0,function(...)
self.model:setChildUIModelShowFlipX(true)
self.model:setChildUIModelShowTargetOffset(0,-50)
end)


else
logErr(FMT.fmt("展示弟子道具 {0} 对应的弟子id: {1} 没有配置固定组件库 无法加载形象",self.dzItemId,ddata.id))
end
self.name:setText(ddata.disciplename)

self.zhongzu:setText(cfgHelper.get2(cfg_discipleraceconfig_get,info.race,'name'))
self.xingbie:setText(cfgHelper.get2(cfg_disciplesexconfig_get,info.sex,'name'))
local sy=UIDiscipleModel:getDiscipleShouYuanDescEx(ddata)
self.shouyuan:setText(sy)
self.lichang:setText(cfgHelper.get2(cfg_disciplestandconfig_get,ddata.stand,'name'))
self.zhiye:setText(cfgHelper.get2(cfg_disciplevocationconfig_get,info.job,'name'))
local n,p,pN=UIDiscipleModel:getJJNameX(ddata.jingjielv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}',n,pN)
else
jj_str=n
end
self.jingjie:setText(jj_str)
local n1,p1=UIDiscipleModel:getLTNameX(ddata.liantilv)
local lt_lv_str=''
if p1~=nil then
lt_lv_str=FMT.fmt('{0}层',p1)
end
local lt_str=FMT.fmt('{0}{1}',n1,lt_lv_str)
self.tixiu:setText(lt_str)

self:RefreshDesc(ddata)

self:refreshPorSkill(ddata)

local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
for i,v in ipairs(ddata.attrList)do
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
local v=ddata.attrList[attrType]==0 and 1 or ddata.attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#069067>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
tVal=tVal+v
end
wiget:SetChildUIPolygonImage(6,ratelist,0)

local color=info.color
local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)
self.totalValue:setText(FMT.fmt('总值：{0}',tVal))

local skillList=self:GetJobSkillList(ddata)
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
end

function UIItemRecruitDiscipleInfoWin:GetJobSkillList(data)
local imageInfo=data.imageInfo
local groupid=data.vocsgidx
local result=UIDiscipleModel:getDiscipleJobSkillListEx(groupid,imageInfo.job,data.jingjielv)
return result
end

function UIItemRecruitDiscipleInfoWin:RefreshDesc(data)
local desclist=UIDiscipleModel:getDiscipleSpecialityConfigByData(data,true)
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

local showEffect=cfg.effectID~=nil
item:SetChildActive(2,showEffect)
if showEffect then
item:SetChildAnimationStringID(2,cfg.effectID,true)
end
end

self.desclist=desclist
end

function UIItemRecruitDiscipleInfoWin.onDescSlotClick(clickNum,index)
local cfg=_this.desclist[index+1]
local item=_this.descScrollView:getChildScrollViewItemWidget(index)
local baseData=_this.dzData

if UIDiscipleModel.onClickClientSpeciality(item,baseData,cfg,eDirectionType.eRight)then
return
end

UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guidNetData=baseData,config=cfg})
end

function UIItemRecruitDiscipleInfoWin:getPorSkillDatas(proskilllist)
local list={}
if not proskilllist then
return list
end
local len=#proSkillSort
for i=1,len do
local ptype=proSkillSort[i]
local data=proskilllist[ptype]
if data.level>0 then
table.insert(list,{type=ptype,level=data.level})
end
end
return list
end

function UIItemRecruitDiscipleInfoWin:refreshPorSkill(data)
local dataList=self:getPorSkillDatas(data.proskillList)
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

function UIItemRecruitDiscipleInfoWin:RandomSpeak(time)
self:playSpeakText()
self:clearSpeakTimer()
self.speakTimer=self:setTimer(time,1,function()
self:RandomSpeak(math.random(5,8))
end)
end

function UIItemRecruitDiscipleInfoWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end
end

function UIItemRecruitDiscipleInfoWin:playSpeakText()
local state=0
local ddata=self.dzData
local voc=ddata.imageInfo.job
local speakList
if state==0 then
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'baishanspeak1')
else
if state==1 then
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'baishanspeak2')
else
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'baishanspeak3')
end
end
local speakStr=speakList[math.random(1,#speakList)]
self.speakText:setText(speakStr)
self.speak:setChildCanvasGroupAlpha(1)
self:killSpeakTweener()
self.speakTweener=self.speak:setChildCanvasGroupDOFade(0,1)
self.speakTweener:SetDelay(3)
end

function UIItemRecruitDiscipleInfoWin:killSpeakTweener()
if self.speakTweener then
self.speakTweener:Kill(false)
self.speakTweener=nil
end
end



function UIItemRecruitDiscipleInfoWin:onClickClose()
self:closeSelf()
end