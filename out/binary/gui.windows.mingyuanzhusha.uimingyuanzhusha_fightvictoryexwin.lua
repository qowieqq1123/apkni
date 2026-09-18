







def_class("UIMingYuanZhuSha_FightVictoryExWin",UIWindowBase)









function UIMingYuanZhuSha_FightVictoryExWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.discipleStateList=UIObject.get(self,1)
self.gotScoreBg=UIObject.get(self,2)
self.lingliDown=UIObject.get(self,3)
self.lldownTxt=UIText.get(self,4)
self.noReward=UIObject.get(self,5)
self.noRewardTxt=UIText.get(self,6)
self.rewardList=UIObject.get(self,7)
self.rewardPart=UIObject.get(self,8)
self.rewardTxt=UIObject.get(self,9)
self.Root=UIObject.get(self,10)
self.score=UIText.get(self,11)
self.uiRoot=UIObject.get(self,12)



end


function UIMingYuanZhuSha_FightVictoryExWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.discipleStateList);self.discipleStateList=nil;
_UIObject_release(self.gotScoreBg);self.gotScoreBg=nil;
_UIObject_release(self.lingliDown);self.lingliDown=nil;
_UIObject_release(self.lldownTxt);self.lldownTxt=nil;
_UIObject_release(self.noReward);self.noReward=nil;
_UIObject_release(self.noRewardTxt);self.noRewardTxt=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardPart);self.rewardPart=nil;
_UIObject_release(self.rewardTxt);self.rewardTxt=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.score);self.score=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this
local _discipleItemCmpIndex={
discipleInfo=0,
bg=1,
head=2,
voc=3,
lingli=4,
llval=5,
hp=6,
hpbar=7,
hptxt=8,
}




function UIMingYuanZhuSha_FightVictoryExWin:onLoaded(...)
self:bindComponents()
UIManager.enableMoneyTips(true)
end


function UIMingYuanZhuSha_FightVictoryExWin:__delete()
self:unbindComponents()
end




function UIMingYuanZhuSha_FightVictoryExWin:onShow(argtable,afterOnloaded)
local group=myzsModel:getGroup()
local level=argtable.data.level
local score=argtable.data.score
local discipleListLen=argtable.data.disciple_list_len
local discipleList=argtable.data.disciple_list

self.parentWin=argtable.parentWin


local vectoryDownLLVal=myzsModel:getBaseConfig('energy_dec')
self.lldownTxt:setText(string.format("%d%%",vectoryDownLLVal))

self.score:setText(FMT.fmt("本次挑战积分：{0}",score))

local isNoRecv=myzsModel:checkNoRecvFirstLevelReward(level)
self.rewardPart:setActive(isNoRecv)
self.noReward:setActive(not isNoRecv)
if isNoRecv then



local _,_,rewards=myzsModel:willGetDefeatReward()
local len=#rewards

self.rewardList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]

local itemid=data[1]
local itemcount=data[2]
local showCountBG=itemcount>1
itemcount=showCountBG and itemcount or""

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,propData)

item:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemid)
end)

local isDiff=data.isDiff and true or false
item:SetChildActive(1,isDiff)
end)
end

self.discipleStateList:setChildLayoutGroupCreateItems(discipleListLen,function(index)
local discipleItem=self.discipleStateList:getChildLayoutGroupGridItem(index-1)

local discipleData=discipleList[index]

local llval=discipleData.param_1
local hp=discipleData.param_2
local discipleguid=discipleData.param_3


comHelper.setChildModelHeadIconBG(discipleItem,_discipleItemCmpIndex.bg,discipleguid)

comHelper.setChildModelRawImage(discipleItem,discipleguid,_discipleItemCmpIndex.head,0,eHeadCenterType.eHead)

local jobIcon=UIDiscipleModel:getJobIconNameX(discipleguid)
discipleItem:SetChildCSImageSprite(_discipleItemCmpIndex.voc,globalABLookup.global,jobIcon)

local llvalPercent=string.format('灵力:<color=#171311>%d%%</color>',llval)
discipleItem:SetChildText(_discipleItemCmpIndex.llval,llvalPercent)

local isShowHp=hp>=0
discipleItem:SetChildActive(_discipleItemCmpIndex.hp,isShowHp)
if isShowHp then
discipleItem:SetChildIconFillAmount(_discipleItemCmpIndex.hpbar,hp/100)
discipleItem:SetChildText(_discipleItemCmpIndex.hptxt,string.format('%d%%',hp))
else
discipleItem:SetChildGray(_discipleItemCmpIndex.discipleInfo,true)
discipleItem:SetChildText(_discipleItemCmpIndex.llval,"<color=#c82c2c>弟子已死亡</color>")
end
end)

local moneyID=myzsModel:getBaseConfig('money_type')
local iconName=iconHelper.getIconName(moneyID)
local levelConf=myzsModel:getlevelConf(level)
UIManager.rewardInfo(iconName,levelConf.money_num)
end


function UIMingYuanZhuSha_FightVictoryExWin:onHide()

end


