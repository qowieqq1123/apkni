







def_class("UISystemZongMenJoinWin",UIWindowBase)









function UISystemZongMenJoinWin:bindComponents()

self.root=UIObject.get(self,0)
self.costPanel=UIObject.get(self,1)
self.costTxt=UIText.get(self,2)
self.costImage=UIImage.get(self,3)
self.selectBtn=UIButton.get(self,4)
self.giveUpBtn=UIButton.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.nextBtn=UIButton.get(self,7)
self.lastBtn=UIButton.get(self,8)
self.skillScrollView=UIObject.get(self,9)
self.zhaoruImg=UIObject.get(self,10)
self.jujueImg=UIObject.get(self,11)
self.btns=UIObject.get(self,12)
self.speakText=UILinkImageText.get(self,13)
self.model=UIObject.get(self,14)
self.pinjiBg=UIImage.get(self,15)
self.speak=UIObject.get(self,16)
self.shouyuan=UIText.get(self,17)
self.xingbie=UIText.get(self,18)
self.tixiu=UIText.get(self,19)
self.lichang=UIText.get(self,20)
self.zhongzu=UIText.get(self,21)
self.jingjie=UIText.get(self,22)
self.pinjiImg=UIImage.get(self,23)
self.name=UIText.get(self,24)
self.head=UIObject.get(self,25)
self.descScrollView=UIObject.get(self,26)
self.zhiye=UIText.get(self,27)
self.totalValue=UIText.get(self,28)
self.polygonAttrPanel=UIObject.get(self,29)
self.skills=UIObject.get(self,30)
self.diziList=UIObject.get(self,31)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.giveUpBtn:setButtonClick(function()self:onGiveUpBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)

self.lastBtn:setButtonClick(function()self:onLastBtn()end)



end


function UISystemZongMenJoinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.costImage);self.costImage=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.giveUpBtn);self.giveUpBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.lastBtn);self.lastBtn=nil;
_UIObject_release(self.skillScrollView);self.skillScrollView=nil;
_UIObject_release(self.zhaoruImg);self.zhaoruImg=nil;
_UIObject_release(self.jujueImg);self.jujueImg=nil;
_UIObject_release(self.btns);self.btns=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.pinjiBg);self.pinjiBg=nil;
_UIObject_release(self.speak);self.speak=nil;
_UIObject_release(self.shouyuan);self.shouyuan=nil;
_UIObject_release(self.xingbie);self.xingbie=nil;
_UIObject_release(self.tixiu);self.tixiu=nil;
_UIObject_release(self.lichang);self.lichang=nil;
_UIObject_release(self.zhongzu);self.zhongzu=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.pinjiImg);self.pinjiImg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.descScrollView);self.descScrollView=nil;
_UIObject_release(self.zhiye);self.zhiye=nil;
_UIObject_release(self.totalValue);self.totalValue=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.skills);self.skills=nil;
_UIObject_release(self.diziList);self.diziList=nil;
end















local _this=nil
local _dzCmp={
bg=0,
select=1,
received=2,
giveup=3,
head=4
}
local _skillCmp={
icon=0,
sign=1,
lvText=2,
click=3,
lv=4,
lock=5,
}
local _proSkillCmp={
bg=0,
text=1,
}
local _polygonAttrPanelCmp={
attr1=0,
attr2=1,
attr3=2,
attr4=3,
attr5=4,
attr6=5,
polygonAttr=6,
icon=7,
}
local speakLib={
[0]=1,
[1]=2,
[2]=3,
}
local proSkillSort={1,3,5,7,2,4,6,8}
local polygonLookup={6,5,4,3,2,1}
local yxtAB='ui/windows/recruit/sharedtextures/yinxiantai_new.ab'
local smABName='ui/windows/shanmen/sharedtextures/shanmen.ab'



function UISystemZongMenJoinWin:onLoaded(...)
self:bindComponents()
_this=self
self.descScrollView:setChildScrollViewInit(0,true,function(...)
self:onDescSlotClick(...)
end,nil)
self.skillScrollView:setChildScrollViewInit(0,true,nil,nil)
self.stateList={}
self:addNotify(notifyConfig.onSystemZMExpelDiscipleHandle,self.onSystemZMExpelDiscipleHandle)
self:addNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
end


function UISystemZongMenJoinWin:__delete()
self:unbindComponents()
_this=nil
self:clearSpeakTimer()
self:killSpeakTweener()
end




function UISystemZongMenJoinWin:onShow(argtable,afterOnloaded)
if self.serial==argtable.serial then return end
self.serial=argtable.serial
self.parentWin=argtable.parentWin
self.callback=argtable.callback
self.disciples=argtable.disciples
self.root:setActive(self.disciples~=nil)
if self.disciples then
self:refreshDzList()
self:onSelectItem(1)
else
systemZongMenController:req_detailInfo(systemZongMenDetailDataPart.eDZList,self.serial)
end
end


function UISystemZongMenJoinWin:onHide()

end





function UISystemZongMenJoinWin:onCloseBtn()
local callback=self.callback

if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end

if callback then
callback()
end
end



function UISystemZongMenJoinWin:onNextBtn()
if self.selectIndex<#self.disciples then
self:onSelectItem(self.selectIndex+1)
end
end



function UISystemZongMenJoinWin:onLastBtn()
if self.selectIndex>1 then
self:onSelectItem(self.selectIndex-1)
end
end



function UISystemZongMenJoinWin:onGiveUpBtn()
local netData=self.disciples[self.selectIndex]
systemZongMenController:req_disciple_recruit(self.serial,netData.discipleguid,2)
end



function UISystemZongMenJoinWin:onSelectBtn()
local cur=UIDiscipleModel:checkDiscipleCount()
local max=UIRecruitModel:getZongMenPeopleMax()
if cur>=max then
UIManager.error("弟子人数已满")
return
end

local maxnum,havenum=UIPrisonModel:getSiXuSpeciality()
if maxnum>0 and havenum>=maxnum then
UIManager.error(FMT.fmt("拥有思绪的弟子已达上限（{0}/{1}）",havenum,maxnum))
return
end

local netData=self.disciples[self.selectIndex]
systemZongMenController:req_disciple_recruit(self.serial,netData.discipleguid,1)
end

function UISystemZongMenJoinWin:onDescSlotClick(clickNum,index)
local cfg=self.desclist[index+1]
local item=self.descScrollView:getChildScrollViewItemWidget(index)
local netData=self.disciples[_this.selectIndex]

if UIDiscipleModel.onClickClientSpeciality(item,netData,cfg,eDirectionType.eRight)then
return
end

UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guidNetData=netData,config=cfg})
end

function UISystemZongMenJoinWin:refreshArrows()
local count=#self.disciples
self.lastBtn:setActive(count>1 and self.selectIndex>1)
self.nextBtn:setActive(count>1 and self.selectIndex<count)
end

function UISystemZongMenJoinWin:refreshDzList()
self.diziList:setChildLayoutGroupCreateItems(#self.disciples,function(index)
local item=self.diziList:getChildLayoutGroupGridItem(index-1)
local data=self.disciples[index]
local info=UIDiscipleModel:getDiscipleImageInfoEx(data)
comHelper.setChildModelHeadIconBGByColor(item,_dzCmp.bg,info.color)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
comHelper.setChildModelRawImageEx(_dzCmp.head,item,modelParams,eHeadCenterType.eHead)
item:SetChildActive(_dzCmp.select,self.selectIndex==index)
item:SetChildButtonClick(0,function()
self:onSelectItem(index)
end)
local state=self.stateList[index]or 0
item:SetChildActive(_dzCmp.received,state==1)
item:SetChildActive(_dzCmp.giveup,state==2)
end)
self.winlua:ForceLayoutRect(self.diziList:getID())
end

function UISystemZongMenJoinWin:onSelectItem(index,scroll)
if self.selectIndex==index then return end

if self.selectIndex then
local item=self.diziList:getChildLayoutGroupGridItem(self.selectIndex-1)
item:SetChildActive(_dzCmp.select,false)
end

self.selectIndex=index

local item=self.diziList:getChildLayoutGroupGridItem(self.selectIndex-1)
item:SetChildActive(_dzCmp.select,true)

self:refreshInfo()

if scroll then
local x=10+(self.selectIndex-1)*98
local width=self.diziList:getChildSizeDeltaX()
x=Mathf.Clamp(x,0,width-557)
self.diziList:setChildAnchoredPos(-x,0)
end
end

function UISystemZongMenJoinWin:refreshInfo()
local netData=self.disciples[self.selectIndex]
local info=UIDiscipleModel:getDiscipleImageInfoEx(netData)

self.pinjiImg:setSprite(yxtAB,FMT.fmt('image_pinjishibie_{0}',info.color))
self.pinjiBg:setSprite(smABName,FMT.fmt('image_baitiedizipz_{0}',info.color))
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
comHelper.setChildInSideModelEx(self.head,modelParams,1.5,eAnimationID.stand,0,-100,false,true,0)
self.head:setChildUIModelShowFlipX(true)

modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
self.model:setChildUIModelShowTarget(modelParams.body,0.8,modelParams.componets,eAnimationID.stand,false,false,0,function(...)
self.model:setChildUIModelShowFlipX(true)
self.model:setChildUIModelShowTargetOffset(0,-50)
end)
self.name:setText(netData.disciplename)


self.zhongzu:setText(cfgHelper.get2(cfg_discipleraceconfig_get,info.race,'name'))
self.xingbie:setText(cfgHelper.get2(cfg_disciplesexconfig_get,info.sex,'name'))
local sy=UIDiscipleModel:getDiscipleShouYuanDescEx(netData)
self.shouyuan:setText(sy)
self.lichang:setText(cfgHelper.get2(cfg_disciplestandconfig_get,netData.stand,'name'))
self.zhiye:setText(cfgHelper.get2(cfg_disciplevocationconfig_get,info.job,'name'))
local n,p,pN=UIDiscipleModel:getJJNameX(netData.jingjielv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}',n,pN)
else
jj_str=n
end
self.jingjie:setText(jj_str)
local n1,p1=UIDiscipleModel:getLTNameX(netData.liantilv)
local lt_lv_str=''
if p1~=nil then
lt_lv_str=FMT.fmt('{0}层',p1)
end
local lt_str=FMT.fmt('{0}{1}',n1,lt_lv_str)
self.tixiu:setText(lt_str)

self.desclist=UIDiscipleModel:getDiscipleSpecialityConfigByData(netData,true)
self.descScrollView:setChildScrollViewCreateGrids(#self.desclist,3)
if#self.desclist>0 then
local grids=self.descScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local cfg=self.desclist[i]
local item=grids[i-1]
UIDiscipleModel.refreshSpecialityItemEx(item,cfg)
end
end

local proSkillList={}
if netData.proskillList then
for i,v in ipairs(proSkillSort)do
local d=netData.proskillList[v]
local level=d.level
if level>0 then
table.insert(proSkillList,{type=v,level=level})
end
end
end

self.skillScrollView:setChildScrollViewCreateGrids(#proSkillList,2)
local grids=self.skillScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local pd=proSkillList[i]
local item=grids[i-1]
local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,pd.type,'icon')
item:SetChildCSImageSprite(_proSkillCmp.bg,globalABLookup.proskill,FMT.fmt('image_gongzhongtp_{0}',icon))
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,pd.type,'name')
item:SetChildText(_proSkillCmp.text,FMT.fmt('{0}：{1}级',name,pd.level))
end

local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
local allnum=0
local ratelist={}
for i,v in ipairs(netData.attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[polygonLookup[i]]=aa/polygonMaxValue
end
local tVal=0
local wiget=self.polygonAttrPanel:getChildWidgetBase()
for attrType=1,6 do
local idx=_polygonAttrPanelCmp[FMT.fmt("attr{0}",attrType)]
local attrValue=netData.attrList[attrType]==0 and 1 or netData.attrList[attrType]
local attrName=UIDiscipleModel:discipleBaseAttrName(attrType)
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#069067>{1}</color>',attrName,attrValue))
tVal=tVal+attrValue
end
wiget:SetChildUIPolygonImage(_polygonAttrPanelCmp.polygonAttr,ratelist,0)

local color=info.color
local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(_polygonAttrPanelCmp.icon,globalABLookup.diciplemain,polygonIcon)
self.totalValue:setText(FMT.fmt('总值：{0}',tVal))

local skillList=UIDiscipleModel:getDiscipleJobSkillListEx(netData.vocsgidx,info.job,netData.jingjielv,netData)
self.skills:setChildLayoutGroupCreateItems(#skillList)
local items=self.skills:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local sdata=skillList[i+1]
local skillID=sdata[1]
local skillLv=sdata[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0
local icon=skillModel.getSkillIconChange(skillCfg,netData)
item:SetChildIcon(_skillCmp.icon,iconHelper.getSkillIcon(icon),true)
item:SetChildImageExGray(_skillCmp.icon,islock)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(_skillCmp.sign,is_bd)
item:SetChildButtonClick(_skillCmp.click,function()
UIManager:showWindow('UIDiscipleJobSkillTipsWin',{skillID=skillID,skillLv=skillLv,attend=1})
end)
item:SetChildActive(_skillCmp.lv,not islock)
if not islock then
item:SetChildText(_skillCmp.lvText,skillModel:getSkillLvStr(skillLv))
end
item:SetChildActive(_skillCmp.lock,islock)
end

local state=self.stateList[self.selectIndex]or 0
self.btns:setActive(state==0)
self.zhaoruImg:setActive(state==1)
self.jujueImg:setActive(state==2)

self:randomSpeak(info.job,state)
end

function UISystemZongMenJoinWin:randomSpeak(voc,state)
local time=math.random(5,8)
self:playSpeakText(voc,state)
self:clearSpeakTimer()
self.speakTimer=self:setTimer(time,1,function()
self:randomSpeak(voc,state)
end)
end

function UISystemZongMenJoinWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end
end

function UISystemZongMenJoinWin:playSpeakText(voc,state)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,FMT.fmt('baishanspeak{0}',speakLib[state]))
local speakStr=speakList[math.random(1,#speakList)]
self.speakText:setText(speakStr)
self.speak:setChildCanvasGroupAlpha(1)
self:killSpeakTweener()
self.speakTweener=self.speak:setChildCanvasGroupDOFade(0,1)
self.speakTweener:SetDelay(3)
end

function UISystemZongMenJoinWin:killSpeakTweener()
if self.speakTweener then
self.speakTweener:Kill(false)
self.speakTweener=nil
end
end

function UISystemZongMenJoinWin:refreshState(index)
local state=self.stateList[index]or 0
if index==self.selectIndex then
local netData=self.disciples[index]
local info=UIDiscipleModel:getDiscipleImageInfoEx(netData)
self.btns:setActive(state==0)
self.zhaoruImg:setActive(state==1)
self.jujueImg:setActive(state==2)

self:randomSpeak(info.job,state)
if state==1 then
self.model:setChildModelAnimationState(eAnimationID.ui_jump1)
end
end
local item=self.diziList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_dzCmp.received,state==1)
item:SetChildActive(_dzCmp.giveup,state==2)
end

function UISystemZongMenJoinWin.onSystemZMExpelDiscipleHandle(serial,discipleguid,deal_type)
if _this.serial==serial and _this.disciples then
local current=nil
for i,v in ipairs(_this.disciples)do
if mathHelper.compareInt64(v.discipleguid,discipleguid)then
current=i
break
end
end

_this.stateList[current]=deal_type
_this:refreshState(current)

local count=#_this.disciples
for i=1,count do
local next=current+i
next=next>count and(next-count)or next
local state=_this.stateList[next]or 0
if state==0 then
_this:onSelectItem(next,true)
break
end
end
end
end

function UISystemZongMenJoinWin.onSystemZMDetailInfo(partType,serial)
if serial==_this.serial and partType==systemZongMenDetailDataPart.eDZList and _this.disciples==nil then
local detailInfo=systemZongMenModel:getDetailPartInfo(serial,systemZongMenDetailDataPart.eDZList)
_this.disciples=detailInfo.discipleList or{}
if#_this.disciples>0 then
_this.root:setActive(true)
_this:refreshDzList()
_this:onSelectItem(1)
else
_this:onCloseBtn()
end
end
end