







def_class("UIRecruitInfoWin",UIWindowBase)









function UIRecruitInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.diziScrollView=UIScrollView.get(self,1)
self.bg=UIObject.get(self,2)
self.giveUpBtn=UIButton.get(self,3)
self.selectBtn=UIButton.get(self,4)
self.skills=UIObject.get(self,5)
self.skillScrollView=UIObject.get(self,6)
self.lichang=UIText.get(self,7)
self.name=UIText.get(self,8)
self.zhongzu=UIText.get(self,9)
self.jingjie=UIText.get(self,10)
self.shouyuan=UIText.get(self,11)
self.xingbie=UIText.get(self,12)
self.tixiu=UIText.get(self,13)
self.descScrollView=UIObject.get(self,14)
self.totalValue=UIText.get(self,15)
self.polygonAttrPanel=UIObject.get(self,16)
self.title=UIText.get(self,17)
self.btns=UIObject.get(self,18)
self.zhiye=UIText.get(self,19)
self.costPanel=UIObject.get(self,20)
self.costImage=UIImage.get(self,21)
self.costTxt=UIText.get(self,22)
self.sixAttrHelp=UIButton.get(self,23)

self.giveUpBtn:setButtonClick(function()self:onGiveUpBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.sixAttrHelp:setButtonClick(function()self:onSixAttrHelp()end)



end


function UIRecruitInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.diziScrollView);self.diziScrollView=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.giveUpBtn);self.giveUpBtn=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.skills);self.skills=nil;
_UIObject_release(self.skillScrollView);self.skillScrollView=nil;
_UIObject_release(self.lichang);self.lichang=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.zhongzu);self.zhongzu=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.shouyuan);self.shouyuan=nil;
_UIObject_release(self.xingbie);self.xingbie=nil;
_UIObject_release(self.tixiu);self.tixiu=nil;
_UIObject_release(self.descScrollView);self.descScrollView=nil;
_UIObject_release(self.totalValue);self.totalValue=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.btns);self.btns=nil;
_UIObject_release(self.zhiye);self.zhiye=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costImage);self.costImage=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.sixAttrHelp);self.sixAttrHelp=nil;
end
















local _this
local proSkillSort={1,3,5,7,2,4,6,8}
local pinzi={"平庸","出众","傲人","绝伦","逆天","逆天"}



function UIRecruitInfoWin:onLoaded(...)
self:bindComponents()

_this=self

self.abName='ui/sharedtextures/uiglobalspriteatlas_1.ab'
self.jobab='ui/windows/disciple/sharedtextures/uidisciplejobicons.ab'
self.yxtAB='ui/windows/recruit/sharedtextures/yinxiantai_new.ab'
self.descScrollView:setChildScrollViewInit(0.5,true,self.onDescSlotClick,nil)
self.skillScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.diziScrollView:setClickAction(self.on_role_item_click)
end


function UIRecruitInfoWin:__delete()
self:unbindComponents()

_this=nil
UIManager:invokeUIMethod('UIRecruitJZWin','resetDzSpeak')
end




function UIRecruitInfoWin:onShow(argtable,afterOnloaded)
self.dispicles=argtable.datas
self.mode=argtable.mode or 1
self.roleIndex=argtable.index


self.root:setChildCanvasGroupAlpha(0)
self.bg:setChildUIModelShowTarget(2016,1,nil,eAnimationID.common_window_enter,false,false,0,function()
self.root:setActive(true)
local tweener=self.root:setChildCanvasGroupDOFade(1,0.35)
tweener:SetEase(DG.Tweening.Ease.InQuad)
end)
self:refreshWin()
self:refreshCost(argtable.cost)

if self.dispicles then
self:checkActiveSpe()
end
end

function UIRecruitInfoWin:checkActiveSpe()
for k,v in ipairs(self.dispicles)do

local index
local data=v
local type=addSpeType.home

if data.discipleInfo then
local datas=data.discipleInfo
local pos=UIRecruitModel:getDzSeverGuid(datas.discipleguid)
index=UIRecruitModel:getDzSeverPos(pos)

if pos and index and index>0 then
TeZhiTuJianModel:checkIsHaveSpeCanActive(data.discipleInfo,type,1,index)
end
end
end
end

function UIRecruitInfoWin:refreshWin(guid)
if guid then
self.roleIndex=self:findOperateDz(guid)
local data=self.dispicles[self.roleIndex]
local item=_this.diziScrollView:getGridObjectByindex(self.roleIndex-1)
local showReceived=self.mode~=3
local state=data.state
if self.mode==4 then
state=shanmenModel:getBaiShanStateByDzId(guid)
end
item:SetChildActive(4,state==1 and showReceived)
item:SetChildActive(5,state==-1 and showReceived)
else
self:refreshRoleList()
end
self.on_role_item_click(1,self.roleIndex)
end

function UIRecruitInfoWin:findOperateDz(guid)
for i,v in ipairs(self.dispicles)do
local ddata=v.discipleInfo
if ddata.discipleguid==guid then
return i
end
end
end

function UIRecruitInfoWin.on_role_item_click(id,index,guid,attach)
if _this.selectIndex then
local item=_this.diziScrollView:getGridObjectByindex(_this.selectIndex-1)

item:SetChildActive(3,false)
end

_this.selectIndex=index

local item=_this.diziScrollView:getGridObjectByindex(index-1)
item:SetChildActive(3,true)




local data=_this.dispicles[_this.selectIndex]
_this:refreshInfo(data)
end

function UIRecruitInfoWin:refreshInfo(data)
local ddata=data.discipleInfo
local info=ddata.imageInfo

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

local state=data.state
if self.mode==4 then
state=shanmenModel:getBaiShanStateByDzId(ddata.discipleguid)
end
self.btns:setActive(state==0)

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

local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
local netData=data.discipleInfo
local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
for i,v in ipairs(netData.attrList)do
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
local v=netData.attrList[attrType]==0 and 1 or netData.attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#069067>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
tVal=tVal+v
end
wiget:SetChildUIPolygonImage(6,ratelist,0)

local color=info.color
local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)

self.totalValue:setText(FMT.fmt('总值：{0}',tVal))

self.ddata=data
end

function UIRecruitInfoWin:GetJobSkillList(data)
local imageInfo=data.imageInfo
local groupid=data.vocsgidx
local result=UIDiscipleModel:getDiscipleJobSkillListEx(groupid,imageInfo.job,data.jingjielv,data)
return result
end

function UIRecruitInfoWin:RefreshDesc(data)
local desclist=UIDiscipleModel:getDiscipleSpecialityConfigByData(data,true)
if not desclist then
return
end
local dataNum=#desclist
self.descScrollView:setChildScrollViewCreateGrids(dataNum,3)

local grids=self.descScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local cfg=desclist[i]
local item=grids[i-1]
UIDiscipleModel.refreshSpecialityItemEx(item,cfg)
end

self.desclist=desclist
end

function UIRecruitInfoWin.onDescSlotClick(clickNum,index)
local cfg=_this.desclist[index+1]
local item=_this.descScrollView:getChildScrollViewItemWidget(index)
local data=_this.dispicles[_this.selectIndex]
local baseData=data.discipleInfo

if UIDiscipleModel.onClickClientSpeciality(item,baseData,cfg,eDirectionType.eRight)then
return
end

UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=baseData.discipleguid,config=cfg})
end

function UIRecruitInfoWin:getPorSkillDatas(proskilllist)
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

function UIRecruitInfoWin:refreshPorSkill(data)
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

function UIRecruitInfoWin:refreshRoleList()
local len=#self.dispicles
self.diziScrollView:freshGridsNum(len,len,1)

local showReceived=self.mode~=3
for i=1,len do
local data=self.dispicles[i]
local ddata=data.discipleInfo
local item=self.diziScrollView:getGridObjectByindex(i-1)
if item then
local info=ddata.imageInfo
item:SetChildCSImageSprite(0,self.yxtAB,FMT.fmt('frame_zhaoshoudz_{0}',info.color))
item:SetChildCSImageSprite(1,self.abName,FMT.fmt('image_pinjishibie_{0}',info.color))
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
item:SetChildUIModelShowTarget(2,modelParams.body,0.5,modelParams.componets,eAnimationID.stand)
item:SetChildActive(3,false)
local state=data.state
if self.mode==4 then
state=shanmenModel:getBaiShanStateByDzId(ddata.discipleguid)
end
item:SetChildActive(4,state==1 and showReceived)
item:SetChildActive(5,state==-1 and showReceived)
end
end
self.diziScrollView:jumpToLockX(self.roleIndex)
end

function UIRecruitInfoWin:checkState(data,state)
local tstate=data.state
if self.mode==4 then
tstate=shanmenModel:getBaiShanStateByDzId(data.discipleInfo.discipleguid)
end
return tstate==state
end



function UIRecruitInfoWin:toNext(state)
local nextIndex
local len=#self.dispicles
local selectIndex=self.selectIndex
if state then
local count=0
local lc=len-1
while(count<lc)do
local index=(selectIndex+count)%len+1
local td=self.dispicles[index]
if self:checkState(td,state)then
nextIndex=index
break
end
count=count+1
end
if not nextIndex then
return
end
else
nextIndex=selectIndex%len+1
end

self.diziScrollView:jumpToLockX(nextIndex-1)
self.on_role_item_click(0,nextIndex)
end


function UIRecruitInfoWin:onHide()

end

function UIRecruitInfoWin:checkOperateLast()
local operateNum=0
for i,v in ipairs(self.dispicles)do
local state=v.state
if self.mode==4 then
state=shanmenModel:getBaiShanStateByDzId(v.discipleInfo.discipleguid)
end
if state~=0 then
operateNum=operateNum+1
end
end
if operateNum+1>=#self.dispicles then
return true
end
return false
end

function UIRecruitInfoWin:refreshCost(cost)
self.costPanel:setActive(cost~=nil)
if cost then
local itemid=cost[1]
local need=cost[2]
local iconName=iconHelper.getIconName(itemid)
self.costImage:setImageIcon(iconName,false)
self.costTxt:setText(FMT.fmt('{0}',need))
end
end



function UIRecruitInfoWin:onSelectBtn()
if UIRecruitModel:checkZongMenPeopleMax()then
UIManager.info('宗门人数已达上限')
return
end
roleAudioController:playRoleSpeak(self.ddata.discipleInfo.discipleguid,roleAudioNodeType.ZhaoMuChengGong)
if self.mode==1 then
UIRecruitControl:reqSelectDisciple(self.ddata.discipleInfo.discipleguid)
elseif self.mode==2 then
UIRecruitControl:reqSelectDiscipleJZ(self.ddata.familyid,self.ddata.discipleInfo.discipleguid)
elseif self.mode==4 then
local canZhaoRu,msg=shanmenModel:checkZhaoru()
if not canZhaoRu then
UIManager.error(msg)
return
end
shanmenController:req_banshai_success(self.ddata.discipleInfo.discipleguid)
end

if self:checkOperateLast()then
self:onClickClose()
end
end

function UIRecruitInfoWin:onGiveUpBtn()
if self.mode==1 or self.mode==4 then
if UIDiscipleModel.checkDZHasLoveSpeciality(self.ddata.discipleInfo)then
local callback=function()
if _this==nil then return end
_this:showGiveUpDialog()
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveGiveUp)
if not flag then
local contentStr='当前弟子拥有<color=#c82c2c>心仪特质</color>，拒收后弟子消失，确定拒招吗？'
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
showclosebtn=true,
allowclickBG=false,
oktext='确定',
canceltext='取消',
choosetext='<color=#c82c2c>心仪特质</color>今日不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveGiveUp,flag)
end,
okcallback=function()
if _this==nil then return end
callback()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
callback()
end
return
end
end
self:showGiveUpDialog()
end

function UIRecruitInfoWin:handleGiveUp()
if self.mode==1 then
UIRecruitControl:reqGiveUpDisciple(self.ddata.discipleInfo.discipleguid)
elseif self.mode==2 then
UIRecruitControl:reqGiveUpDiscipleJZ(self.ddata.familyid,self.ddata.discipleInfo.discipleguid)
elseif self.mode==4 then
shanmenController:req_banshai_fail(self.ddata.discipleInfo.discipleguid)
end
if self:checkOperateLast()then
self:onClickClose()
end
end

function UIRecruitInfoWin:onSixAttrHelp()
local offset=Vector2.New(15,-15)
local desc_str=cfgHelper.getlang('six_attrs_tips')
UIManager:showWindow('UIConditionTipsOne',{showType=4,str=desc_str,posItem=self.sixAttrHelp,pos=offset})
end

function UIRecruitInfoWin:showGiveUpDialog()
local cfg=cfgHelper.get1(cfg_yinxiantaiconfig_get,1)
local content
local ftype=-1

local data=self.dispicles[self.selectIndex]
local info=UIRecruitModel:GetDiscipleImageInfo(data.discipleInfo)
local color=info.color

for i,v in ipairs(cfg.giveup_tips)do
if color>=v[1]then
ftype=i
content=v[2]
end
end


local ffTypeName=FMT.fmt('recruitSelect_GiveUpTips_{0}',ftype)
local ff=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,ffTypeName)

local iscolor=false
local setcolor=userActorSetting.get('UIRecruitSelectWincolor',0)
local setcolor2=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eUIRecruitSelectWincolor)
if setcolor>=color and setcolor2 then
iscolor=true
end

if ff or ftype<0 or iscolor then
self:handleGiveUp()
return
end

if not content then
logErr('无法找到招募提示配置')
return
end

local func=function()
local _ff=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,ffTypeName)
if _ff then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eUIRecruitSelectWincolor,true)
userActorSetting.set('UIRecruitSelectWincolor',color)
userActorSetting.flush()
end
self:handleGiveUp()
end
local _colornew=getQualityColorNew(QualityColorNewType.white,color)
local _choosetext=FMT.fmt('<color={0}>{1}</color>品质以下今天不再提示',_colornew,pinzi[color]or"")
local desc=content
local show_data=
{
title='提示',
Str=desc or'',
oktext="确认",
canceltext="取消",
eDay=REPEAT_TIME_TYPE.eDay,
REPEAT_TYPE=ffTypeName,
tipsTextstr=_choosetext,
profilerSetpos=186,
okcallback=function()
if _this==nil then return end
func()
end
}
UIManager:showWindow('UIDialougeYCTBtips',show_data)





















end

function UIRecruitInfoWin:onClickClose()
self:closeSelf()
end