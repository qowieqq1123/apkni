







def_class("UIChatLeftShareLingShouInfoItem",UICloneObject)





UIChatLeftShareLingShouInfoItem.abName=""

UIChatLeftShareLingShouInfoItem.assetName="UIChatLeftShareLingShouInfoItem"


function UIChatLeftShareLingShouInfoItem:bindComponents()

self.back=UIImage.get(self,0)
self.bg=UIObject.get(self,1)
self.default=UIButton.get(self,2)
self.head=UIObject.get(self,3)
self.headBg=UIButton.get(self,4)
self.lingshourole=UIButton.get(self,5)
self.name=UIText.get(self,6)
self.order=UIImage.get(self,7)
self.rawImage=UIImage.get(self,8)
self.time=UIText.get(self,9)
self.timeRoot=UIObject.get(self,10)

self.default:setButtonClick(function()self:onDefault()end)

self.headBg:setButtonClick(function()self:onHeadBg()end)

self.lingshourole:setButtonClick(function()self:onLingshourole()end)

end


function UIChatLeftShareLingShouInfoItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.default);self.default=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headBg);self.headBg=nil;
_UIObject_release(self.lingshourole);self.lingshourole=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.order);self.order=nil;
_UIObject_release(self.rawImage);self.rawImage=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
end






local _this=nil



function UIChatLeftShareLingShouInfoItem:onLoaded(...)
self:bindComponents()
_this=self
end


function UIChatLeftShareLingShouInfoItem:__delete()
_this=nil
self:unbindComponents()
end




function UIChatLeftShareLingShouInfoItem:onShow(argtable,afterOnloaded)
local chatInfo=argtable.chatInfo
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local actorInfo=chatInfo.actorInfo or{}
local actorID=actorInfo.actorId
local actorName=actorInfo.actorName
local serverId=actorInfo.serverId
local iconInfo=actorInfo.iconInfo

self.chatInfo=chatInfo
self:freshRect()


local timeFlag=chatInfo.timeFlag or false
self.timeFlag=timeFlag
self.timeRoot:setActive(timeFlag)
if timeFlag then
local txt=''
if timeHelper.isTodayStamp(timeStamp)then
txt=timeHelper.getTwoFormatByStamp(timeStamp)
else
txt=timeHelper.getFourFormatByStamp(timeStamp)
end
self.time:setText(txt)
end


if channelId~=CHAT_CHANNNEL.eKuafu then
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'{0}',actorName))
else
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}]{1}',loginModel:getServerName(serverId),actorName))
end


playerController:setRawImageHeadIcon(self.widget,self.head:getID(),{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
self.bg:setActive(true)
local widget=self.widget
widget:SetChildButtonClick(self.headBg:getID(),function()
local attach=nil
if channelId==CHAT_CHANNNEL.eKuafu then attach={serverid=serverId}end
if channelId==CHAT_CHANNNEL.eXianJie then attach={serverid=serverId,isXianJie=true}end
otherPlayerController:openOtherPlayerInfoWin(actorID,nil,nil,attach)
end,true)


local regexInfo=chatInfo.regexInfo
local lingshouData=chatEmotHelper.getLingShouInfoByRegex(regexInfo)
self:freshLingShouInfo(lingshouData)
end


function UIChatLeftShareLingShouInfoItem:onHide()

end

function UIChatLeftShareLingShouInfoItem:onDefault()
UIManager.error('灵兽信息过期，暂无法查看')
end

function UIChatLeftShareLingShouInfoItem:onHeadBg()

end

function UIChatLeftShareLingShouInfoItem:onLingshourole()
if self.fullLsData and self.fullLsData.id and self.fullLsData.id>0 then

UIManager:showWindow('UILingShouTipsWin',{lsData=self.fullLsData,fromType=TIPS_FORM_TYPE.eShareLingShou})





else
UIManager.error('灵兽信息过期，暂无法查看')
end
end




function UIChatLeftShareLingShouInfoItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=252
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end

function UIChatLeftShareLingShouInfoItem:freshLingShouInfo(lingshouData)
local ls_guid=lingshouData and lingshouData.ls_guid or nil
self.ls_guid=ls_guid
self.lingshouData=lingshouData


local hasValidData=lingshouData and lingshouData.id and lingshouData.id>0

self.default:setActive(not hasValidData)
self.lingshourole:setActive(hasValidData)

if hasValidData then

self.fullLsData=self:buildFullLsData(lingshouData)

local lingshouWidget=self.lingshourole:getWidgetBase()
local cardWidget=lingshouWidget:GetChildWidgetBase(0)
self:setLingShouCardByShareData(cardWidget,lingshouData)
end
end

function UIChatLeftShareLingShouInfoItem:buildFullLsData(shareData)
local lsID=shareData.id
local lscfg=shareData.cfg or cfgHelper.get1(cfg_lingshouconfig_get,lsID)
if not lscfg then
return shareData
end




local serverSkillList=shareData.serverSkillList or{}
local skillListFromServer={}
local serverSkillIndex=1


local configSkillOrder={}

if lscfg.normal_skill then
table.insert(configSkillOrder,{id=lscfg.normal_skill,type="normal"})
end

if lscfg.skill then
table.insert(configSkillOrder,{id=lscfg.skill,type="main"})
end

if lscfg.passive_skill then
for _,skillId in ipairs(lscfg.passive_skill)do
table.insert(configSkillOrder,{id=skillId,type="passive"})
end
end

if lscfg.tianfu then
for _,tianfuData in ipairs(lscfg.tianfu)do
local skillId=tianfuData[1]
table.insert(configSkillOrder,{id=skillId,type="tianfu"})
end
end


local tianfu_skill_id=0
local tianfu_skill_lv=1
for _,configSkill in ipairs(configSkillOrder)do
local serverSkill=serverSkillList[serverSkillIndex]
local serverSkillId=serverSkill and serverSkill[1]or nil
local serverSkillLv=serverSkill and serverSkill[2]or 0

if serverSkillId==configSkill.id then

if configSkill.type=="tianfu"then
tianfu_skill_id=serverSkillId
tianfu_skill_lv=serverSkillLv
else
table.insert(skillListFromServer,{serverSkillId,serverSkillLv,true,serverSkillLv})
end
serverSkillIndex=serverSkillIndex+1
else

if configSkill.type=="tianfu"then

else
table.insert(skillListFromServer,{configSkill.id,0,false,0})
end
end
end



local serverAttrList=shareData.serverAttrList or{}
local serverAttrLookup={}
for i,attrData in ipairs(serverAttrList)do
if i<=3 and type(attrData)=="table"and attrData[1]and attrData[2]then
serverAttrLookup[attrData[1]]=attrData[2]
end
end

local lsData={
ls_guid=shareData.ls_guid,
guid=shareData.guid,
id=lsID,
name=shareData.name,
jj_lvl=shareData.jj_lvl or 0,
zizhi=shareData.zizhi or 0,
qianli=shareData.qianli or 0,
xuemai_type=shareData.xuemai_type or 0,
xuemai_val=shareData.xuemai_val or 0,
xuemai_dianshu=shareData.xuemai_dianshu or 0,
sex=shareData.sex or 0,
generation=shareData.generation or 1,
wordList=shareData.wordList or{},
tianfu_skill_id=tianfu_skill_id,
tianfu_skill_lv=tianfu_skill_lv,
born_times=shareData.born_times or 0,
cfg=lscfg,
serverSkillList=skillListFromServer,
serverAttrLookup=serverAttrLookup,
}


lsData.allAttrLookup={}
lsData.allAttrRateLookup={}
local totalLookup={}
for attrId,attrVal in pairs(serverAttrLookup)do
totalLookup[attrId]=attrVal
end
lsData.allAttrLookup[lingshouAttributeType.eBase]=totalLookup


local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
local emptyLookup={}
local emptyRateLookup={}
for _,attrType in ipairs(attrsBase)do
emptyRateLookup[attrType]=0
end

lsData.allAttrLookup[lingshouAttributeType.eJingJie]=emptyLookup
lsData.allAttrRateLookup[lingshouAttributeType.eJingJie]=emptyRateLookup
lsData.allAttrLookup[lingshouAttributeType.eQianLi]=emptyLookup
lsData.allAttrRateLookup[lingshouAttributeType.eQianLi]=emptyRateLookup
lsData.allAttrLookup[lingshouAttributeType.eXueMai]=emptyLookup
lsData.allAttrRateLookup[lingshouAttributeType.eXueMai]=emptyRateLookup
lsData.allAttrLookup[lingshouAttributeType.eDJob]=emptyLookup
lsData.allAttrRateLookup[lingshouAttributeType.eDJob]=emptyRateLookup
lsData.allAttrLookup[lingshouAttributeType.eTrait]=emptyLookup
lsData.allAttrRateLookup[lingshouAttributeType.eTrait]=emptyRateLookup
lsData.allAttrLookup[lingshouAttributeType.eDzGongFa]=emptyLookup
lsData.allAttrRateLookup[lingshouAttributeType.eDzGongFa]=emptyRateLookup

return lsData
end


function UIChatLeftShareLingShouInfoItem:setLingShouCardByShareData(widget,lsData)
local lsID=lsData.id
local lscfg=lsData.cfg or cfgHelper.get1(cfg_lingshouconfig_get,lsID)
if not lscfg then
return
end


local color=lscfg.color
widget:SetChildCSImageSprite(0,globalABLookup.lingshoumain,lingshouColorToFrame[color])


widget:SetChildText(1,lsData.name or'')


comHelper.setChildModelRawImage_lingshou(widget,lsID,2,0,eHeadCenterType.eHead,1)


widget:SetChildActive(5,true)
local fight=lingshouModel.getFightValueEx(self.fullLsData)
widget:SetChildText(5,FMT.fmt("<color=#7D3B17>战力</color> {0}",mathHelper.formatNumber7(fight,1,2)))
widget:SetChildText(4,'')


local showSign=lscfg.bianyi==1
widget:SetChildActive(3,showSign)


local generation=lsData.generation or 1
widget:SetChildText(8,FMT.fmt("{0}代",generation))
local generationShowParams=cfgHelper.get2(cfg_lingshoubasicconfig_get,1,'generationShowBg')
local generationParam=generationShowParams[generation]or generationShowParams[#generationShowParams]
local abName=generationParam.abname
local iconName=generationParam.icon
widget:SetChildCSImageSprite(7,abName,iconName)


widget:SetChildButtonClick(-1,function()
self:onLingshourole()
end,true)
end
