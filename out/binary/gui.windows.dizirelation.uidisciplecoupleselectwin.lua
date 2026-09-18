







def_class("UIDiscipleCoupleSelectWin",UIWindowBase)









function UIDiscipleCoupleSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.womanSnowEffect=UIObject.get(self,1)
self.manSnowEffect=UIObject.get(self,2)
self.womanThunderEffect=UIObject.get(self,3)
self.manThunderEffect=UIObject.get(self,4)
self.resultEffect=UIObject.get(self,5)
self.flowerEffect=UIObject.get(self,6)
self.heartEffect=UIObject.get(self,7)
self.helpBtn=UIButton.get(self,8)
self.coupleBtn=UIButton.get(self,9)
self.leftTimeBg=UIObject.get(self,10)
self.womanDialogueBg=UIImage.get(self,11)
self.manDialogueBg=UIImage.get(self,12)
self.moonModel=UIObject.get(self,13)
self.womanInfo=UIObject.get(self,14)
self.blackmoonModel=UIObject.get(self,15)
self.bgModel=UIObject.get(self,16)
self.tipsBg=UIObject.get(self,17)
self.manMask=UIObject.get(self,18)
self.womanMask=UIObject.get(self,19)
self.cloudModel=UIObject.get(self,20)
self.dzMan=UIObject.get(self,21)
self.manInfo=UIObject.get(self,22)
self.selectWomanBtn=UIButton.get(self,23)
self.dzWoman=UIObject.get(self,24)
self.bridgeModel=UIObject.get(self,25)
self.selectManBtn=UIButton.get(self,26)
self.leftTimes=UIText.get(self,27)
self.womanChangeBtn=UIButton.get(self,28)
self.womanWishBg=UIObject.get(self,29)
self.womanName=UIText.get(self,30)
self.womanCharm=UIText.get(self,31)
self.womanToManRelationTxt=UIImage.get(self,32)
self.womanToManRelationIcon=UIImage.get(self,33)
self.womanToManRelationArrow=UIImage.get(self,34)
self.womanStand=UIText.get(self,35)
self.manToWomanRelationIcon=UIImage.get(self,36)
self.manToWomanRelationTxt=UIImage.get(self,37)
self.manCharm=UIText.get(self,38)
self.manStand=UIText.get(self,39)
self.manWishBg=UIObject.get(self,40)
self.manToWomanRelationArrow=UIImage.get(self,41)
self.manName=UIText.get(self,42)
self.manChangeBtn=UIButton.get(self,43)
self.manDialogue=UIText.get(self,44)
self.manWish=UIText.get(self,45)
self.womanWish=UIText.get(self,46)
self.womanDialogue=UIText.get(self,47)
self.tipsTxt=UIText.get(self,48)
self.manModel=UIObject.get(self,49)
self.womanModel=UIObject.get(self,50)
self.manLianDon=UIObject.get(self,51)
self.womanLianDon=UIObject.get(self,52)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.coupleBtn:setButtonClick(function()self:onCoupleBtn()end)

self.selectWomanBtn:setButtonClick(function()self:onSelectWomanBtn()end)

self.selectManBtn:setButtonClick(function()self:onSelectManBtn()end)

self.womanChangeBtn:setButtonClick(function()self:onWomanChangeBtn()end)

self.manChangeBtn:setButtonClick(function()self:onManChangeBtn()end)



end


function UIDiscipleCoupleSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.womanSnowEffect);self.womanSnowEffect=nil;
_UIObject_release(self.manSnowEffect);self.manSnowEffect=nil;
_UIObject_release(self.womanThunderEffect);self.womanThunderEffect=nil;
_UIObject_release(self.manThunderEffect);self.manThunderEffect=nil;
_UIObject_release(self.resultEffect);self.resultEffect=nil;
_UIObject_release(self.flowerEffect);self.flowerEffect=nil;
_UIObject_release(self.heartEffect);self.heartEffect=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.coupleBtn);self.coupleBtn=nil;
_UIObject_release(self.leftTimeBg);self.leftTimeBg=nil;
_UIObject_release(self.womanDialogueBg);self.womanDialogueBg=nil;
_UIObject_release(self.manDialogueBg);self.manDialogueBg=nil;
_UIObject_release(self.moonModel);self.moonModel=nil;
_UIObject_release(self.womanInfo);self.womanInfo=nil;
_UIObject_release(self.blackmoonModel);self.blackmoonModel=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.manMask);self.manMask=nil;
_UIObject_release(self.womanMask);self.womanMask=nil;
_UIObject_release(self.cloudModel);self.cloudModel=nil;
_UIObject_release(self.dzMan);self.dzMan=nil;
_UIObject_release(self.manInfo);self.manInfo=nil;
_UIObject_release(self.selectWomanBtn);self.selectWomanBtn=nil;
_UIObject_release(self.dzWoman);self.dzWoman=nil;
_UIObject_release(self.bridgeModel);self.bridgeModel=nil;
_UIObject_release(self.selectManBtn);self.selectManBtn=nil;
_UIObject_release(self.leftTimes);self.leftTimes=nil;
_UIObject_release(self.womanChangeBtn);self.womanChangeBtn=nil;
_UIObject_release(self.womanWishBg);self.womanWishBg=nil;
_UIObject_release(self.womanName);self.womanName=nil;
_UIObject_release(self.womanCharm);self.womanCharm=nil;
_UIObject_release(self.womanToManRelationTxt);self.womanToManRelationTxt=nil;
_UIObject_release(self.womanToManRelationIcon);self.womanToManRelationIcon=nil;
_UIObject_release(self.womanToManRelationArrow);self.womanToManRelationArrow=nil;
_UIObject_release(self.womanStand);self.womanStand=nil;
_UIObject_release(self.manToWomanRelationIcon);self.manToWomanRelationIcon=nil;
_UIObject_release(self.manToWomanRelationTxt);self.manToWomanRelationTxt=nil;
_UIObject_release(self.manCharm);self.manCharm=nil;
_UIObject_release(self.manStand);self.manStand=nil;
_UIObject_release(self.manWishBg);self.manWishBg=nil;
_UIObject_release(self.manToWomanRelationArrow);self.manToWomanRelationArrow=nil;
_UIObject_release(self.manName);self.manName=nil;
_UIObject_release(self.manChangeBtn);self.manChangeBtn=nil;
_UIObject_release(self.manDialogue);self.manDialogue=nil;
_UIObject_release(self.manWish);self.manWish=nil;
_UIObject_release(self.womanWish);self.womanWish=nil;
_UIObject_release(self.womanDialogue);self.womanDialogue=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.manModel);self.manModel=nil;
_UIObject_release(self.womanModel);self.womanModel=nil;
_UIObject_release(self.manLianDon);self.manLianDon=nil;
_UIObject_release(self.womanLianDon);self.womanLianDon=nil;
end


















local relationSpriteMap={
[2]={arrow="image_daolvxitong_14",icon="image_daolvxitong_gx4",txt="image_daolvxitong_wz7",},
[1]={arrow="image_daolvxitong_14",icon="image_daolvxitong_gx3",txt="image_daolvxitong_wz6",},
[-1]={arrow="image_daolvxitong_15",icon="image_daolvxitong_gx2",txt="image_daolvxitong_wz5",},
[-2]={arrow="image_daolvxitong_15",icon="image_daolvxitong_gx1",txt="image_daolvxitong_wz4",},
}
local this

function UIDiscipleCoupleSelectWin:onLoaded(...)
self:bindComponents()
this=self
notifySystem:listenNotify(notifyConfig.onGameCounterChange,self.onLimitCountChange)
end


function UIDiscipleCoupleSelectWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onGameCounterChange,self.onLimitCountChange)
uiAIManager:clearUIWinData('UIDiscipleCoupleSelectWin')
self.currManDZ=nil
self.currWomanDZ=nil
self.manGuid=nil
self.womanGuid=nil
end




function UIDiscipleCoupleSelectWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5385,1,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.cloudModel:getID(),5386,1,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.bridgeModel:getID(),5387,1,{},eAnimationID.stand)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.6)
end)
end
self.isAnim=false

self:refreshInfoView(true,true)
end



function UIDiscipleCoupleSelectWin:refreshInfoView(refreshMan,refreshWoman)
local abName="ui/windows/dizirelation/disciplecouple_atlas_pak.ab"
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
if refreshMan then
if self.manGuid then
self.selectManBtn:setActive(false)
self.manInfo:setActive(true)
local manName=UIDiscipleModel:getDiscipleName(self.manGuid)
local manCharm=UIDiscipleModel:getDiscipleBaseAttr(self.manGuid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
local netData=UIDiscipleModel:getDiscipleData(self.manGuid)
self.manName:setText(manName)
self.manCharm:setText(string.format("魅力:%d",manCharm))
self.manStand:setText(string.format("立场:%s",cfgHelper.get2(cfg_disciplestandconfig_get,netData.stand,'name')))

comHelper.setChildInSideModel(self.manModel,self.manGuid,0.7,nil,0,40,false,false,nil)
else
self.selectManBtn:setActive(true)
self.manInfo:setActive(false)
self.manModel:setChildUIModelRemoveTarget()
end
end

if refreshWoman then
if self.womanGuid then
self.selectWomanBtn:setActive(false)
self.womanInfo:setActive(true)
local womanName=UIDiscipleModel:getDiscipleName(self.womanGuid)
local womanCharm=UIDiscipleModel:getDiscipleBaseAttr(self.womanGuid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
local netData=UIDiscipleModel:getDiscipleData(self.womanGuid)
self.womanName:setText(womanName)
self.womanCharm:setText(string.format("魅力:%d",womanCharm))
self.womanStand:setText(string.format("立场:%s",cfgHelper.get2(cfg_disciplestandconfig_get,netData.stand,'name')))

comHelper.setChildInSideModel(self.womanModel,self.womanGuid,0.7,nil,0,40,false,false,nil)
else
self.selectWomanBtn:setActive(true)
self.womanInfo:setActive(false)
self.womanModel:setChildUIModelRemoveTarget()
end
end
if self.manGuid and self.womanGuid then
local releationValue1=UIDiscipleModel:getReleationValue(self.manGuid,self.womanGuid,DISCIPLE_RELATION_TYPE.eFriend)
local releationType1=UIDiscipleModel:getRelationChildType(DISCIPLE_RELATION_TYPE.eFriend,releationValue1)
local releationValue2=UIDiscipleModel:getReleationValue(self.womanGuid,self.manGuid,DISCIPLE_RELATION_TYPE.eFriend)
local releationType2=UIDiscipleModel:getRelationChildType(DISCIPLE_RELATION_TYPE.eFriend,releationValue2)
local relationSprite1=relationSpriteMap[releationType1]
local relationSprite2=relationSpriteMap[releationType2]
local manName=UIDiscipleModel:getDiscipleName(self.manGuid)
local womanName=UIDiscipleModel:getDiscipleName(self.womanGuid)
local wish1=Mathf.Clamp(DiscipleCoupleModel:getCoupleWishRate(self.manGuid,self.womanGuid),0,100)
local wish2=Mathf.Clamp(DiscipleCoupleModel:getCoupleWishRate(self.womanGuid,self.manGuid),0,100)

local dialogueCfg=cfg_coupledialogueconfig()
local dialogueCfg1
local dialogueCfg2
for i,v in ipairs(dialogueCfg)do
if wish1>=v.wish then
dialogueCfg1=v.manDialogue
break
end
end
for i,v in ipairs(dialogueCfg)do
if wish2>=v.wish then
dialogueCfg2=v.womanDialogue
break
end
end
local dialogue1=dialogueCfg1[math.random(#dialogueCfg1)]
local dialogue2=dialogueCfg2[math.random(#dialogueCfg2)]

self.manDialogueBg:setActive(true)
self.womanDialogueBg:setActive(true)
self.manWishBg:setActive(true)
self.womanWishBg:setActive(true)
if relationSprite1 then
self.manToWomanRelationArrow:setActive(true)
self.manToWomanRelationIcon:setActive(true)
self.manToWomanRelationTxt:setActive(true)
self.manToWomanRelationArrow:setCSImageSprite(abName,relationSprite1.arrow)
self.manToWomanRelationIcon:setCSImageSprite(abName,relationSprite1.icon)
self.manToWomanRelationTxt:setCSImageSprite(abName,relationSprite1.txt)
if releationType1>0 then
self.manToWomanRelationArrow:setScale(Vector3.New(1,1,1))
else
self.manToWomanRelationArrow:setScale(Vector3.New(-1,-1,1))
end
else
self.manToWomanRelationArrow:setActive(false)
self.manToWomanRelationIcon:setActive(false)
self.manToWomanRelationTxt:setActive(false)
end
if relationSprite2 then
self.womanToManRelationArrow:setActive(true)
self.womanToManRelationIcon:setActive(true)
self.womanToManRelationTxt:setActive(true)
self.womanToManRelationArrow:setCSImageSprite(abName,relationSprite2.arrow)
self.womanToManRelationIcon:setCSImageSprite(abName,relationSprite2.icon)
self.womanToManRelationTxt:setCSImageSprite(abName,relationSprite2.txt)
if releationType2>0 then
self.womanToManRelationArrow:setScale(Vector3.New(-1,-1,1))
else
self.womanToManRelationArrow:setScale(Vector3.New(1,1,1))
end
else
self.womanToManRelationArrow:setActive(false)
self.womanToManRelationIcon:setActive(false)
self.womanToManRelationTxt:setActive(false)
end
self.manDialogue:setText(string.format(dialogue1,womanName))
self.womanDialogue:setText(string.format(dialogue2,manName))
self.manWish:setText(string.format("配对值 : %d%%",wish1))
self.womanWish:setText(string.format("配对值 : %d%%",wish2))
self.manDialogueBg:setCSImageSprite(globalABLookup.global,wish1>=60 and"frame_duihuaqipaokuang_1"or"frame_duihuaqipaokuang_2")
self.womanDialogueBg:setCSImageSprite(globalABLookup.global,wish2>=60 and"frame_duihuaqipaokuang_1"or"frame_duihuaqipaokuang_2")

local manId=UIDiscipleModel:getDiscipleID(self.manGuid)
local womanId=UIDiscipleModel:getDiscipleID(self.womanGuid)
local manLinkageId=liandonModel:getLianDonLinkageIdByDZId(manId)
local womanLinkageId=liandonModel:getLianDonLinkageIdByDZId(womanId)
local isSpecial=false
for i,v in ipairs(cfg.special)do
if manId==v[1]and womanId==v[2]then
isSpecial=true
break
end
end
local showLD=isSpecial and manLinkageId>0 and womanLinkageId>0
self.manLianDon:setActive(showLD)
self.womanLianDon:setActive(showLD)
else
self.manToWomanRelationArrow:setActive(false)
self.manToWomanRelationIcon:setActive(false)
self.manToWomanRelationTxt:setActive(false)
self.womanToManRelationArrow:setActive(false)
self.womanToManRelationIcon:setActive(false)
self.womanToManRelationTxt:setActive(false)
self.manDialogueBg:setActive(false)
self.womanDialogueBg:setActive(false)
self.manWishBg:setActive(false)
self.womanWishBg:setActive(false)
self.manLianDon:setActive(false)
self.womanLianDon:setActive(false)
end
local cnt=gameUtilityModel:getData_counter(gameCounterType.eZuShiCoupleNum)
local leftTimes=cfg.times[1]-cnt
self.leftTimes:setText(string.format("本日剩余：%d次",leftTimes>0 and leftTimes or 0))
self.coupleBtn:setImageExGray(leftTimes<=0)
end

function UIDiscipleCoupleSelectWin:selectDiscipleCallback(sex,guid)
if sex==1 then
if mathHelper.compareInt64(self.manGuid,guid)then
return
end
self.manGuid=guid
elseif sex==2 then
if mathHelper.compareInt64(self.womanGuid,guid)then
return
end
self.womanGuid=guid
end
self:refreshInfoView(sex==1,sex==2)
end

function UIDiscipleCoupleSelectWin:test(ret)
local random_dis1=UIDiscipleModel:getRandomDiscipleData().discipleguid
local random_dis2=UIDiscipleModel:getRandomDiscipleData().discipleguid
self:onCoupleCallback(random_dis1,random_dis2,ret)
end

function UIDiscipleCoupleSelectWin:onCoupleCallback(discipleguid1,discipleguid2,ret)
self.isAnim=true
self.leftTimeBg:setActive(false)
self.coupleBtn:setActive(false)
self.manInfo:setActive(false)
self.womanInfo:setActive(false)
local cfg=cfg_reqcoupledialogueconfig()
local dialogueid=math.random(#cfg)
if ret==0 then
self.root:setChildCanvasGroupAlpha(0)

self.resultEffect:setChildShowEffect(20204,true)
self:delayDo(0.6,function()
self.winlua:SetChildUIModelShowFadeToColor(self.manModel:getID(),Color.New(1,1,1,0),1,0,nil)
self.winlua:SetChildUIModelShowFadeToColor(self.womanModel:getID(),Color.New(1,1,1,0),1,0,nil)
local manSpeakTxt=cfg[dialogueid].manSpeakTxt
local womanSpeakTxt=cfg[dialogueid].womanSpeakTxt

self:createDZ(discipleguid1,1,manSpeakTxt,function(bt)
if self then
self.currManDZ=bt
end
end)
self:createDZ(discipleguid2,2,womanSpeakTxt,function(bt)
if self then
self.currWomanDZ=bt
end
end)
end)
self:delayDo(1.5,function()





self.heartEffect:setChildShowEffect(20202,true)

self.flowerEffect:setChildShowEffect(20203,true)

self.moonModel:setChildUIModelShowTarget(5391,1,{},eAnimationID.enter)






end)
self:delayDo(4.5,function()
self.currManDZ:setSharedVar('dPos',{-120,-40})
self.currWomanDZ:setSharedVar('dPos',{-648,-40})
self.currManDZ:setSharedVar('run',1)
self.currWomanDZ:setSharedVar('run',1)
self.currManDZ:broke()
self.currManDZ:reset()
self.currManDZ:tick(0)
self.currWomanDZ:broke()
self.currWomanDZ:reset()
self.currWomanDZ:tick(0)
end)
self:delayDo(7.5,function()
self.dzMan:setChildCanvasGroupDOFade(0,1)
self.dzWoman:setChildCanvasGroupDOFade(0,1,function()
UIManager:closeWindow("UIDiscipleCoupleSelectWin")
end)
end)
else
self.resultEffect:setChildShowEffect(20205,true)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(discipleguid1)
local sex=imageInfo.sex
local manGuid=sex==1 and discipleguid1 or discipleguid2
local womanGuid=sex==1 and discipleguid2 or discipleguid1
local idx1=sex==1 and 0 or 1
local idx2=sex==1 and 1 or 0
local NOPass1=bit.band(1,bit.rshift(ret,idx1))~=0
local NOPass2=bit.band(1,bit.rshift(ret,idx2))~=0
self.manDialogueBg:setActive(false)
self.womanDialogueBg:setActive(false)
self.manDialogueBg:setCSImageSprite(globalABLookup.global,NOPass1 and"frame_duihuaqipaokuang_2"or"frame_duihuaqipaokuang_1")
self.womanDialogueBg:setCSImageSprite(globalABLookup.global,NOPass2 and"frame_duihuaqipaokuang_2"or"frame_duihuaqipaokuang_1")
local tips=nil
local manName=UIDiscipleModel:getDiscipleName(manGuid)
local womanName=UIDiscipleModel:getDiscipleName(womanGuid)
if NOPass1 then
local manNoPassTxt=cfg[dialogueid].manNoPassTxt
self.manDialogue:setText(manNoPassTxt)
tips=manName
else
self:delayDo(1,function()

self.manThunderEffect:setChildShowEffect(20209,true)
end)
self:delayDo(1.5,function()

self.winlua:SetChildUIModelGray(self.manModel:getID(),true)

self.manSnowEffect:setChildShowEffect(20210,true)
end)
local manPassTxt=cfg[dialogueid].manPassTxt
self.manDialogue:setText(manPassTxt)
end
if NOPass2 then
local womanNoPassTxt=cfg[dialogueid].womanNoPassTxt
self.womanDialogue:setText(womanNoPassTxt)
tips=tips and string.format("%s、%s",manName,womanName)or womanName
else
self:delayDo(1,function()

self.womanThunderEffect:setChildShowEffect(20209,true)
end)
self:delayDo(1.5,function()

self.winlua:SetChildUIModelGray(self.womanModel:getID(),true)

self.womanSnowEffect:setChildShowEffect(20210,true)
end)
local womanPassTxt=cfg[dialogueid].womanPassTxt
self.womanDialogue:setText(womanPassTxt)
end
self:delayDo(2,function()
self.manDialogueBg:setActive(true)
end)
self:delayDo(3,function()
self.womanDialogueBg:setActive(true)
end)
self:delayDo(5,function()

self.winlua:SetChildCanvasGroupDOFade(self.manMask:getID(),0,1)
self.winlua:SetChildDOAnchorPos(self.manMask:getID(),Vector2.New(-450,-56),1)
self.winlua:SetChildCanvasGroupDOFade(self.womanMask:getID(),0,1)
self.winlua:SetChildDOAnchorPos(self.womanMask:getID(),Vector2.New(450,-56),1,function()
UIManager:closeWindow("UIDiscipleCoupleSelectWin")
end)
end)
self.tipsTxt:setText(string.format("%s拒绝结为道侣",tips))

self.blackmoonModel:setChildUIModelShowTarget(5392,1,{},eAnimationID.zhidui_enter)
end
end

function UIDiscipleCoupleSelectWin:createDZ(dzId,sex,speakTxt,callback)
local initData={
dPos=sex==1 and{250,30}or{-250,30},
speakHUDParent=1,
offset={0,0},
speakTxt="#23",
speakTime=999,
run=1,
}
local tran
if sex==1 then
tran=self.dzMan:getCommonComponent('Transform')
else
tran=self.dzWoman:getCommonComponent('Transform')
end
local vpos=Vector2.zero
local otherData={
scale=0.8,
checkChuiWei=false,
}
uiAIManager:createUIDisciple('UIDiscipleCoupleSelectWin','bt_ui_coupleSuccess',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end

function UIDiscipleCoupleSelectWin:onCoupleBtn()
if self.isAnim then
return
end
local cnt=gameUtilityModel:getData_counter(gameCounterType.eZuShiCoupleNum)
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local leftTimes=cfg.times[1]-cnt
if leftTimes<=0 then
UIManager.error("本日配对道侣次数不足")
return
end
if self.manGuid and self.womanGuid then
DiscipleCoupleController.send_2_142(self.manGuid,self.womanGuid)
else
UIManager.error("祖师尚未选择男/女弟子")
end
end

function UIDiscipleCoupleSelectWin:onSelectManBtn()
if self.isAnim then
return
end
DiscipleCoupleController:showSelectDiscipleWin(1,self.womanGuid)
end

function UIDiscipleCoupleSelectWin:onSelectWomanBtn()
if self.isAnim then
return
end
DiscipleCoupleController:showSelectDiscipleWin(2,self.manGuid)
end

function UIDiscipleCoupleSelectWin:onManChangeBtn()
if self.isAnim then
return
end
DiscipleCoupleController:showSelectDiscipleWin(1,self.womanGuid)
end

function UIDiscipleCoupleSelectWin:onWomanChangeBtn()
if self.isAnim then
return
end
DiscipleCoupleController:showSelectDiscipleWin(2,self.manGuid)
end

function UIDiscipleCoupleSelectWin:onHelpBtn()
if self.isAnim then
return
end
local d={}
d.mode=3
d.title="规则介绍"
d.name='UICoupleRule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIDiscipleCoupleSelectWin.onLimitCountChange(type)
if type==gameCounterType.eZuShiCoupleNum then
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local cnt=gameUtilityModel:getData_counter(gameCounterType.eZuShiCoupleNum)
local leftTimes=cfg.times[1]-cnt
this.leftTimes:setText(string.format("本日剩余：%d次",leftTimes>0 and leftTimes or 0))
this.coupleBtn:setImageExGray(leftTimes<=0)
end
end