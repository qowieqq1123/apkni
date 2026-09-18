







def_class("UIServerTransferConditionWin",UIWindowBase)









function UIServerTransferConditionWin:bindComponents()

self.emptyLimit=UIObject.get(self,0)
self.guildFight=UIText.get(self,1)
self.guildName=UIText.get(self,2)
self.limitContent=UIObject.get(self,3)
self.playerFight=UIText.get(self,4)
self.realmName=UIText.get(self,5)
self.root=UIObject.get(self,6)
self.signBGIcon=UIImage.get(self,7)
self.signIcon=UIImage.get(self,8)
self.signKuangIcon=UIImage.get(self,9)
self.xyGradeFlag=UIImage.get(self,10)
self.xyGradeIcon=UIImage.get(self,11)
self.zmGrade=UIText.get(self,12)
self.zmGradeIcon=UIImage.get(self,13)



end


function UIServerTransferConditionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.emptyLimit);self.emptyLimit=nil;
_UIObject_release(self.guildFight);self.guildFight=nil;
_UIObject_release(self.guildName);self.guildName=nil;
_UIObject_release(self.limitContent);self.limitContent=nil;
_UIObject_release(self.playerFight);self.playerFight=nil;
_UIObject_release(self.realmName);self.realmName=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.signBGIcon);self.signBGIcon=nil;
_UIObject_release(self.signIcon);self.signIcon=nil;
_UIObject_release(self.signKuangIcon);self.signKuangIcon=nil;
_UIObject_release(self.xyGradeFlag);self.xyGradeFlag=nil;
_UIObject_release(self.xyGradeIcon);self.xyGradeIcon=nil;
_UIObject_release(self.zmGrade);self.zmGrade=nil;
_UIObject_release(self.zmGradeIcon);self.zmGradeIcon=nil;
end


















local _abName="ui/windows/servertransfer/servertransferspriteatlas_pak.ab"

function UIServerTransferConditionWin:onLoaded(...)
self:bindComponents()
end


function UIServerTransferConditionWin:__delete()
self:unbindComponents()
end




function UIServerTransferConditionWin:onShow(argtable,afterOnloaded)

















local fight=mathHelper.int64_to_number(ServerTransferModel:getHistoryFight())
local cross_id=loginModel:getCrossServerId()
local xianyu_pj_level=ServerTransferModel:getXianYuGrade()

self.playerFight:setText(string.format("%s（%d）",mathHelper.formatNumber3(fight),fight))
self.zmGrade:setText(string.format("<color=%s>%s宗门</color>",ServerTransferModel:getZongMenGradeColor(),ServerTransferModel:getZongMenGradeName()))
self.realmName:setText(loginModel:getCrossZoneName(cross_id))
self.xyGradeIcon:setSprite(_abName,string.format("image_pojieyueqian_xq%d",xianyu_pj_level))
self.xyGradeFlag:setSprite(_abName,string.format("image_pojieyueqian_wz%d",xianyu_pj_level))
self.zmGradeIcon:setSprite(globalABLookup.globa4,ServerTransferModel:getZongMenGradeIcon())

self:refreshLimitConditionPanel()
end


function UIServerTransferConditionWin:refreshLimitConditionPanel()
self.updateList={}
self:clearUpdateTimer()
local limitInfo=ServerTransferController:getServerTransferLimitInfo()
self.limitInfo=limitInfo
self.limitContent:setChildLayoutGroupCreateItems(#limitInfo,function(index)
local data=limitInfo[index]
local item=self.limitContent:getChildLayoutGroupGridItem(index-1)
if data.desc then
item:SetChildText(0,data.desc)
elseif data.descFun then
local limitData=data.limitData
if limitData.endTime then
table.insert(self.updateList,index)
local nowTime=timeHelper.getServerShortTime()
local lerp=limitData.endTime-nowTime
local str=data.descFun(lerp)
item:SetChildText(0,str)
end
end
if data.jump then
item:SetChildActive(1,true)
item:SetChildButtonClick(1,data.jump)
else
item:SetChildActive(1,false)
end
end)
self.emptyLimit:setActive(#limitInfo<=0)
if#self.updateList>0 then
self.updateTimer=self:setTimer(1,0,function()
self:updateInfoView()
end)
end
end

function UIServerTransferConditionWin:updateInfoView()
local needRefresh=false
for _,index in ipairs(self.updateList)do
local item=self.limitContent:getChildLayoutGroupGridItem(index-1)
local data=self.limitInfo[index]
local nowTime=timeHelper.getServerShortTime()
local limitData=data.limitData
if limitData.endTime then
local lerp=limitData.endTime-nowTime
if lerp<=0 then
needRefresh=true
break
end
local str=data.descFun(lerp)
item:SetChildText(0,str)
end
end
if needRefresh then
self:refreshLimitConditionPanel()
end
end

function UIServerTransferConditionWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end