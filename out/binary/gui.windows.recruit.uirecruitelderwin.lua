







def_class("UIRecruitElderWin",UIWindowBase)









function UIRecruitElderWin:bindComponents()

self.name=UIText.get(self,0)
self.meili=UIText.get(self,1)
self.role=UIObject.get(self,2)
self.info=UIObject.get(self,3)
self.infotips=UIText.get(self,4)
self.timetips=UIText.get(self,5)
self.selectBtn=UIButton.get(self,6)
self.selectTxt=UIText.get(self,7)
self.menulist=UIObject.get(self,8)
self.zongmenBtn=UIButton.get(self,9)
self.jiazuBtn=UIButton.get(self,10)
self.zongmenPanel=UIObject.get(self,11)
self.jiazuPanel=UIObject.get(self,12)
self.title=UIText.get(self,13)
self.prText_1=UIText.get(self,14)
self.prText_2=UIText.get(self,15)
self.prText_3=UIText.get(self,16)
self.prText_4=UIText.get(self,17)
self.prText_5=UIText.get(self,18)
self.zongmenBtn_select=UIImage.get(self,19)
self.jiazuBtn_select=UIImage.get(self,20)
self.jiazuInfo=UIText.get(self,21)
self.prTextList={
self.prText_1,
self.prText_2,
self.prText_3,
self.prText_4,
self.prText_5,
}

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)
self.zongmenBtn:setButtonClick(function()self:onZongMenBtnClick()end)
self.jiazuBtn:setButtonClick(function()self:onJiaZuBtnClick()end)



end


function UIRecruitElderWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.meili);self.meili=nil;
_UIObject_release(self.role);self.role=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.infotips);self.infotips=nil;
_UIObject_release(self.timetips);self.timetips=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.selectTxt);self.selectTxt=nil;
_UIObject_release(self.menulist);self.menulist=nil;
_UIObject_release(self.zongmenBtn);self.zongmenBtn=nil;
_UIObject_release(self.jiazuBtn);self.jiazuBtn=nil;
_UIObject_release(self.zongmenPanel);self.zongmenPanel=nil;
_UIObject_release(self.jiazuPanel);self.jiazuPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.prText_1);self.prText_1=nil;
_UIObject_release(self.prText_2);self.prText_2=nil;
_UIObject_release(self.prText_3);self.prText_3=nil;
_UIObject_release(self.prText_4);self.prText_4=nil;
_UIObject_release(self.prText_5);self.prText_5=nil;
_UIObject_release(self.zongmenBtn_select);self.zongmenBtn_select=nil;
_UIObject_release(self.jiazuBtn_select);self.jiazuBtn_select=nil;
_UIObject_release(self.jiazuInfo);self.jiazuInfo=nil;
end
















local _this
local menu_slot_name='button_dytab'
local body_id={
back=2016,
menu=2017,
}



function UIRecruitElderWin:onLoaded(...)
self:bindComponents()

_this=self

notifySystem:listenNotify(notifyConfig.onDisciplePosChange,self.on_pos_change)
notifySystem:listenNotify(notifyConfig.onDiscipleSixAttrChange,self.on_pos_change)
end


function UIRecruitElderWin:__delete()
self:unbindComponents()

_this=nil

notifySystem:removelistener(notifyConfig.onDisciplePosChange,self.on_pos_change)
notifySystem:removelistener(notifyConfig.onDiscipleSixAttrChange,self.on_pos_change)
end

function UIRecruitElderWin.on_pos_change(guid,pos)
_this:refresh()
end




function UIRecruitElderWin:onShow(argtable,afterOnloaded)
self.selectMenuIndex=1
self:refresh()
end


function UIRecruitElderWin:onHide()

end

function UIRecruitElderWin:getAddAttr(effects)
for i,v in ipairs(effects)do
if v.type==1 and v.param[5]then
return v.param[5]
end
end
return 0
end

function UIRecruitElderWin:refresh()
local attrName=''
local attrCfg=cfgHelper.getdef1(cfg_yinxiantaizmconfig,'attr6')
for i,v in ipairs(attrCfg)do
attrName=string.format('%s、%s',attrName,UIDiscipleModel:discipleBaseAttrName(v))
end
attrName=string.gsub(attrName,'、','',1)

local cfgs=cfg_yinxiantaizmadjustconfig()

if self.apTweener then
self.apTweener:Rewind()
self.apTweener:Kill()
self.apTweener=nil
end

local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)or{}
if#dis_list>0 then
self.selectTxt:setText('更\n换')

local ddata=dis_list[1]
local guid=ddata.discipleguid
comHelper.setChildInSideModel(self.role,guid,nil,nil,0,0,false,true)
self.name:setText(ddata.disciplename)

local mlVal=ddata.attrList[DISCIPLE_BASE_ATTR_TYPE.eMeiLi]
local pcfg=cfgHelper.get1(cfg_guildposconfig_get,eZongMenPostType.eJieYin)
local add=self:getAddAttr(pcfg.effects_myself)
self.meili:setText(FMT.fmt('{0}<color=green>+{1}</color>',mlVal-add,add))

self.zlGuid=guid

local count=0
for i,v in ipairs(attrCfg)do
count=count+ddata.attrList[v]
end

local index
for i,v in ipairs(cfgs)do
if count>=v.minval and count<=v.maxval then
index=i
end
end
if not index then
index=#cfgs
end

local cfg=cfgs[index]
local dtime=cfgs[1].duration-cfg.duration








self.role:setActive(true)
self.info:setActive(true)
self.infotips:setActive(false)
else
self.selectTxt:setText('委\n任')

self.apTweener=self.winlua:SetChildDOPunchRotation(self.selectBtn:getID(),Vector3(0,0,15),2,6,1)
self.apTweener:SetEase(_Ease.Linear)
self.apTweener:SetLoops(-1,_LoopType.Restart)







self.zlGuid=nil

self.role:setActive(false)
self.info:setActive(false)
self.infotips:setActive(true)
end


self:refreshPanel()
end

function UIRecruitElderWin:getTimeStr(time)

time=math.floor(time/60)*60
return timeHelper.format_time_stamp11(time)
end




function UIRecruitElderWin:onSelectBtn()
UIFullSectPalaceControl:showSectPalacePostInfo(eZongMenPostType.eJieYin,self.zlGuid,true)
end

function UIRecruitElderWin:onCloseClick()
self:closeSelf()
end

function UIRecruitElderWin:onZongMenBtnClick()

self.selectMenuIndex=1
self:refreshPanel()
end

function UIRecruitElderWin:onJiaZuBtnClick()

self.selectMenuIndex=2
self:refreshPanel()
end

function UIRecruitElderWin:refreshPanel()
if self.selectMenuIndex==1 then

self.zongmenPanel:setActive(true)
self.jiazuPanel:setActive(false)

self.zongmenBtn_select:setActive(true)
self.jiazuBtn_select:setActive(false)
self:refreshZongMenPanel()
elseif self.selectMenuIndex==2 then

self.zongmenPanel:setActive(false)
self.jiazuPanel:setActive(true)

self.zongmenBtn_select:setActive(false)
self.jiazuBtn_select:setActive(true)
self:refreshJiaZuPanel()
end
end

function UIRecruitElderWin:refreshZongMenPanel()

self.title:setText("宗门招募")


local mlVal=0
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)or{}
if#dis_list>0 then
local ddata=dis_list[1]
mlVal=ddata.attrList[DISCIPLE_BASE_ATTR_TYPE.eMeiLi]
end



local cfg=cfg_yinxiantaizminfoconfig()


local prList=nil
for i,v in ipairs(cfg)do
local range=v.mlzRange
if range[2]and range[2]~=-1 then

if mlVal>=range[1]and mlVal<=range[2]then
prList=v.probability
break
end
else

if mlVal>=range[1]then
prList=v.probability
break
end
end
end

if prList and next(prList)then
if#prList>=5 then

for i,v in ipairs(self.prTextList)do
v:setText(FMT.fmt("{0}%",prList[i]))
end
else
logErr("请检查当前魅力值区间对应的概率配置是否填写完整")
end
else
logErr("没有找到当前魅力值对应区间的概率，请检查是否正确获取到魅力值，或是否已正确配置魅力值区间对应的概率")
end

end

function UIRecruitElderWin:refreshJiaZuPanel()

self.title:setText("家族招募")


self.jiazuInfo:setText(cfgHelper.getlang('yinxiantai_jiazuzhaomu_info'))
end