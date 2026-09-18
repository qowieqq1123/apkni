







def_class("UIClientShowQuestionWin",UIWindowBase)









function UIClientShowQuestionWin:bindComponents()

self.root=UIObject.get(self,0)
self.tablist=UIScrollView.get(self,1)
self.panel=UIObject.get(self,2)
self.titleroot=UIObject.get(self,3)
self.questionList=UIScrollView.get(self,4)
self.bottonRoot=UIObject.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.input=UIInputField.get(self,7)
self.blroot=UIObject.get(self,8)
self.brroot=UIObject.get(self,9)
self.rewardroot=UIObject.get(self,10)
self.rewardlist=UIScrollView.get(self,11)
self.nextQuestionBtn=UIButton.get(self,12)
self.submit=UIButton.get(self,13)
self.questionNumTip=UIText.get(self,14)
self.startroot=UIObject.get(self,15)
self.startdesc=UIText.get(self,16)
self.startBtn=UIButton.get(self,17)
self.startdesctemp=UIText.get(self,18)
self.bgmodel=UIObject.get(self,19)
self.xiantiao=UIObject.get(self,20)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.nextQuestionBtn:setButtonClick(function()self:onNextQuestionBtn()end)

self.submit:setButtonClick(function()self:onSubmit()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)



end


function UIClientShowQuestionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tablist);self.tablist=nil;
_UIObject_release(self.panel);self.panel=nil;
_UIObject_release(self.titleroot);self.titleroot=nil;
_UIObject_release(self.questionList);self.questionList=nil;
_UIObject_release(self.bottonRoot);self.bottonRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.input);self.input=nil;
_UIObject_release(self.blroot);self.blroot=nil;
_UIObject_release(self.brroot);self.brroot=nil;
_UIObject_release(self.rewardroot);self.rewardroot=nil;
_UIObject_release(self.rewardlist);self.rewardlist=nil;
_UIObject_release(self.nextQuestionBtn);self.nextQuestionBtn=nil;
_UIObject_release(self.submit);self.submit=nil;
_UIObject_release(self.questionNumTip);self.questionNumTip=nil;
_UIObject_release(self.startroot);self.startroot=nil;
_UIObject_release(self.startdesc);self.startdesc=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.startdesctemp);self.startdesctemp=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.xiantiao);self.xiantiao=nil;
end
















local transformOptionIndex={'A',"B",'C','D','E','F','G','H','I','J','K','L','M','N','O','P',"Q",'R','S','T','U','V','W','X','Y','Z'}




function UIClientShowQuestionWin:onLoaded(...)
self:bindComponents()

self.tablist:bindScrollWidget(function(...)self:bindTab(...)end)
self.questionList:bindScrollWidget(function(...)self:bindQuestion(...)end)

self.tablist:setClickAction(function(...)self:onClickTab(...)end)
self.rewardlist:setClickAction(function(...)self:onClickRewardItem(...)end)

self.textCmpList={}
self.isAllowSubmit=true
end


function UIClientShowQuestionWin:__delete()

self:dealAnswer(true)
self:saveAnswer()

self:unbindComponents()
end




function UIClientShowQuestionWin:onShow(argtable,afterOnloaded)
self.tabIdList=newQuestionModel:getOpenQuestionList()
self.data={}
self.resultData={}
self.finalResultData={}
self.startList={}

self.tabIndex=1
self.questionIndex=1
self.questionXuHao=1


local allquestionbanks=cfg_questionbankconfig()
for k,v in pairs(self.tabIdList)do
self.data[k]=allquestionbanks[v.bank_id]
self.resultData[k]={}
self.finalResultData[v.bank_id]={}

self.startList[v.bank_id]=newQuestionController:getQuestionnirAnswer(v.question_id)==nil





end


self:refresh()


self.panel:setChildCanvasGroupAlpha(0)
self.tablist:setChildCanvasGroupAlpha(0)
self.bgmodel:setChildUIModelShowTarget(4860,1,nil,eAnimationID.enter,false,false,0,function()
self:delayDo(0.5,function()
self.panel:setChildCanvasGroupDOFade(1,1,nil)
self.tablist:setChildCanvasGroupDOFade(1,1,nil)
end)
end)
end


function UIClientShowQuestionWin:onHide()

end





function UIClientShowQuestionWin:onNextQuestionBtn()
local wjid=self.activeTabList[self.tabIndex]
if not newQuestionModel:isPrize(wjid)then

if self:dealAnswer()then
self:jumpQuestion()
self:refreshButton()
end
else
local content="祖师，非常抱歉，此问卷已结束"
local show_data={
type='UIDialouge',
title='提示',
oktext='确定',
content=content,
canceltext='取消',
showclosebtn=true,
okcallback=function()
self:closeSelf()
end,
cancelcallback=function()
self:closeSelf()
end,
closecallback=function()
self:closeSelf()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
end



function UIClientShowQuestionWin:onSubmit()
if self:dealAnswer()and self.isAllowSubmit then
self.isAllowSubmit=false
self:delayDo(3,function()
self.isAllowSubmit=true
end)
local question_id=self.activeQuestionList[self.tabIndex].question_id
local bank_id=self.activeQuestionList[self.tabIndex].bank_id
newQuestionController:submitQuestionnaireAnswer(question_id,bank_id,self.finalResultData[self.activeTabList[self.tabIndex]])
end
end



function UIClientShowQuestionWin:onCloseBtn()
self:closeSelf()
end

function UIClientShowQuestionWin:onStartBtn()
self.startList[self.activeTabList[self.tabIndex]]=false
self.startroot:setActive(false)
self.startBtn:setActive(false)
self.questionList:setActive(true)
self:refresh()
end

local tabposlist={{10,-10},{30,-140},{18.376,-264}}
function UIClientShowQuestionWin:bindTab(index,item)
local question_id=self.activeTabList[index]
local state
if question_id~=nil then
state=newQuestionModel:isPrize(question_id)
else
state=true
end
item:SetChildActive(-1,not state and tabposlist[index]~=nil)
if not state and tabposlist[index]~=nil then
local title=self.activeQuestionList[index].title
item:SetChildText(1,title)
item:SetChildActive(0,self.tabIndex==index)
item:SetChildActive(-1,not newQuestionModel:isPrize(question_id))
item:SetChildLocalPosition(-1,Vector3(tabposlist[index][1],tabposlist[index][2],0))
end
end

function UIClientShowQuestionWin:onClickTab(id,index,guid,attch)
if self.tabIndex~=index then
local preitem=self.tablist:getGridObjectByindex(self.tabIndex-1)
preitem:SetChildActive(0,false)
local item=self.tablist:getGridObjectByindex(index-1)
item:SetChildActive(0,true)

self:saveAnswer()

self.tabIndex=index
self.questionIndex=1
self.questionXuHao=1
self.questionList:jumpToLockY(self.questionIndex)



self:refreshWelcome()
self:refreshQuestionList()
self:refreshButton()
end
end

function UIClientShowQuestionWin:saveAnswer()
local question_data=self.activeQuestionList[self.tabIndex]
local answer=self.finalResultData[self.activeTabList[self.tabIndex]]
if next(answer)then
answer=table.deepCopy(answer)
for k,ans in pairs(answer)do
ans.lookup={}
if ans.fillContent_len and ans.fillContent_len>0 then
ans.fillContentDir={}
for k,v in pairs(ans.fillContents)do
table.insert(ans.fillContentDir,{index=k,content=v})
end
ans.fillContents={}

ans.optionContenttDir={}
for k,v in pairs(ans.optionContent)do
table.insert(ans.optionContenttDir,{index=k,content=v})
end
ans.optionContent={}
end
end
newQuestionController:saveQuestionnirAnswer(question_data.question_id,question_data.bank_id,answer)
end
end

function UIClientShowQuestionWin:fillResult()
local question_data=self.activeQuestionList[self.tabIndex]
local data=newQuestionController:getQuestionnirAnswer(question_data.question_id)
if data~=nil then
if data.bankid==question_data.bank_id then
self.resultData[self.tabIndex]=table.deepCopy(data.answer or{})
self.questionXuHao=0
self.finalResultData[self.activeTabList[self.tabIndex]]={}
local finaltemp=self.finalResultData[self.activeTabList[self.tabIndex]]
for k,v in pairs(data.answer)do
finaltemp[k]=v
self.questionIndex=k
self.questionXuHao=self.questionXuHao+1
end
else
newQuestionController:deleteQuestionnirAnswer(question_data.question_id)
end
end
end

local questionCompIndex={
xtopic=0,
input=1,
optionroot=2,
inputroot=3,
topicroot=4,
xxuhao=5,
optionscrollview=6,
xiantiao=7,
xuanzeti=8,
tiankongti=9,
ttopic=10,
txuhao=11,
}

local optionCompIndex={
single=0,
single_ok=1,
double=2,
double_ok=3,
desc=4,
input=5,
btn=6,
}
function UIClientShowQuestionWin:bindQuestion(index,item)
local cfgdata=self.data[self.tabIndex][index]
if cfgdata==nil then return end
if not self.resultData[self.tabIndex][index]then
self.resultData[self.tabIndex][index]={
selectOptionNum=0,
lookup={},
inputList={},
fillContents={},
content="",
}
end
local resultData=self.resultData[self.tabIndex][index]
resultData.lookup=resultData.lookup or{}
resultData.inputList=resultData.inputList or{}
resultData.fillContents=resultData.fillContents or{}

local question_type=cfgdata.question_type
local questionTypeName
if question_type==1 then
questionTypeName="单选题"
elseif question_type==2 then
questionTypeName="多选题"
elseif question_type==3 then
questionTypeName="填写题"
else
questionTypeName=""
end
item:SetChildText(questionCompIndex.xxuhao,FMT.fmt("{0}.",index))
item:SetChildText(questionCompIndex.txuhao,FMT.fmt("{0}.",index))
item:SetChildText(questionCompIndex.xtopic,FMT.fmt("【{0}】{1}",questionTypeName,cfgdata.question_desc))
item:SetChildText(questionCompIndex.ttopic,FMT.fmt("【{0}】{1}",questionTypeName,cfgdata.question_desc))
item:SetChildActive(questionCompIndex.xuanzeti,cfgdata.question_type~=3)
item:SetChildActive(questionCompIndex.tiankongti,cfgdata.question_type==3)
item:SetChildActive(questionCompIndex.optionscrollview,cfgdata.question_type~=3)
item:SetChildActive(questionCompIndex.inputroot,cfgdata.question_type==3)
item:SetChildActive(-1,true)
item:SetChildActive(questionCompIndex.xiantiao,question_type~=3)
if cfgdata.question_type==1 or cfgdata.question_type==2 then
local isLimitSelctOption=cfgdata.limitSelectOptionNum~=nil
local limitSelectOptionNum=isLimitSelctOption and cfgdata.limitSelectOptionNum or#cfgdata.question_options
local option_num=Mathf.Ceil(#cfgdata.question_options/2)
item:SetChildLayoutGroupCreateItems(questionCompIndex.optionroot,option_num,function(opindex)
local real_index=opindex-1
local data_left_index=real_index*2+1
local data_right_index=data_left_index+1
local op_item=item:GetChildLayoutGroupGridItem(questionCompIndex.optionroot,opindex-1)

local fresh_Option_Item=function(widget,data,rindex)

local desc=FMT.fmt("{0}.{1}",transformOptionIndex[rindex],data[1])
local isShowFillBox=data[2]and data[2]==1
local limitFilleWord=data[3]and data[3]

widget:SetChildActive(-1,true)
widget:SetChildActive(optionCompIndex.single,question_type==1)
widget:SetChildActive(optionCompIndex.double,question_type==2)
widget:SetChildText(optionCompIndex.desc,desc)
widget:SetChildActive(optionCompIndex.single_ok,resultData.lookup[rindex])
widget:SetChildActive(optionCompIndex.double_ok,resultData.lookup[rindex])
widget:SetChildActive(optionCompIndex.input,resultData.lookup[rindex]and isShowFillBox)
if isShowFillBox then
if limitFilleWord then
widget:SetChildInputCharacterLimit(optionCompIndex.input,limitFilleWord)
end
widget:SetChildInputFieldValue(optionCompIndex.input,resultData.fillContents[rindex]or"")
if resultData.lookup[rindex]then
resultData.inputList[rindex]=widget
end
end

local singleClickFunc=function()
if not resultData.lookup[rindex]and resultData.selectOptionNum==1 then

local key
for k,v in pairs(resultData.lookup)do
if v then
key=k
break
end
end
resultData.lookup[key]=false
local mainkey=Mathf.Ceil(key/2)
local isAloneOption=cfgdata.question_options[key][4]and cfgdata.question_options[key][4]==1
local subKey=isAloneOption and 2 or(key+1)%2
local original_item=item:GetChildLayoutGroupGridItem(questionCompIndex.optionroot,mainkey-1)
local real_item=original_item:GetChildWidgetBase(subKey)
real_item:SetChildActive(optionCompIndex.single_ok,resultData.lookup[key])
local pIsShowFillBox=cfgdata.question_options[key][2]and cfgdata.question_options[key][2]==1


if pIsShowFillBox then
real_item:SetChildActive(optionCompIndex.input,resultData.lookup[key])
resultData.inputList[key]=nil
real_item:SetChildInputFieldValue(optionCompIndex.input,"")
end

resultData.lookup[rindex]=not resultData.lookup[rindex]
widget:SetChildActive(optionCompIndex.single_ok,resultData.lookup[rindex])
if isShowFillBox then
widget:SetChildActive(optionCompIndex.input,resultData.lookup[rindex])
resultData.inputList[rindex]=widget
end

if resultData.fillContents[rindex]then
widget:SetChildInputFieldValue(optionCompIndex.input,resultData.fillContents[rindex]or"")
end
else

resultData.lookup[rindex]=not resultData.lookup[rindex]
widget:SetChildActive(optionCompIndex.single_ok,resultData.lookup[rindex])
if isShowFillBox then
widget:SetChildActive(optionCompIndex.input,resultData.lookup[rindex])
if resultData.lookup[rindex]then
resultData.inputList[rindex]=widget
else
resultData.inputList[rindex]=nil
end
end
if resultData.lookup[rindex]then
resultData.selectOptionNum=resultData.selectOptionNum+1
else
resultData.selectOptionNum=resultData.selectOptionNum-1
end

if resultData.fillContents[rindex]then
widget:SetChildInputFieldValue(optionCompIndex.input,resultData.fillContents[rindex]or"")
end
end
end
local doubleClickFunc=function()
if isLimitSelctOption then
local limittype=cfgdata.limitSelectOptionNum[1]
local limitnum=cfgdata.limitSelectOptionNum[2]
local limitnum2=cfgdata.limitSelectOptionNum[3]
if resultData.lookup[rindex]==nil then
if limittype==1 then
if resultData.selectOptionNum>=limitnum then
UIManager.info(FMT.fmt("最多选择{0}项",limitnum))
return
end
elseif limittype==4 then
if resultData.selectOptionNum>=limitnum2 then
UIManager.info(FMT.fmt("最多选择{0}项",limitnum2))
return
end
end
end
end
resultData.lookup[rindex]=not resultData.lookup[rindex]
widget:SetChildActive(optionCompIndex.double_ok,resultData.lookup[rindex])
if isShowFillBox then
widget:SetChildActive(optionCompIndex.input,resultData.lookup[rindex])
if resultData.lookup[rindex]then
resultData.inputList[rindex]=widget
else
resultData.inputList[rindex]=nil
end

end
if resultData.lookup[rindex]then
resultData.selectOptionNum=resultData.selectOptionNum+1
else
resultData.selectOptionNum=resultData.selectOptionNum-1
end

if resultData.fillContents[rindex]then
widget:SetChildInputFieldValue(optionCompIndex.input,resultData.fillContents[rindex]or"")
end
end
widget:SetChildButtonClick(optionCompIndex.single,function()
singleClickFunc()
end)
widget:SetChildButtonClick(optionCompIndex.double,function()
doubleClickFunc()
end)
widget:SetChildButtonClick(optionCompIndex.btn,function()
if cfgdata.question_type==1 then
singleClickFunc()
elseif cfgdata.question_type==2 then
doubleClickFunc()
end
end)
end

local op_left_data=cfgdata.question_options[data_left_index]
if op_left_data and op_left_data[4]==1 then

local op_single_item=op_item:GetChildWidgetBase(2)
op_item:SetChildActive(0,false)
op_single_item:SetChildActive(-1,op_left_data~=nil)
if op_left_data then
fresh_Option_Item(op_single_item,op_left_data,data_left_index)
end
else
local op_left_item=op_item:GetChildWidgetBase(0)
op_item:SetChildActive(2,false)
op_left_item:SetChildActive(-1,op_left_data~=nil)
if op_left_data then
fresh_Option_Item(op_left_item,op_left_data,data_left_index)
end
end

local op_right_data=cfgdata.question_options[data_right_index]
local op_right_item=op_item:GetChildWidgetBase(1)
op_right_item:SetChildActive(-1,op_right_data~=nil)
if op_right_data then
fresh_Option_Item(op_right_item,op_right_data,data_right_index)
end

end)
elseif cfgdata.question_type==3 then
if cfgdata.limitharacter then
item:SetChildInputCharacterLimit(questionCompIndex.input,cfgdata.limitharacter)
end
if resultData.fillContent then
item:SetChildInputFieldValue(questionCompIndex.input,resultData.fillContent or"")
end
end

end

function UIClientShowQuestionWin:onClickRewardItem(id,index,guid,attch)
itemsComponentHelper.onItemClick(id,index,guid,attch)
end

function UIClientShowQuestionWin:refresh()
self:refreshTab()
self:refreshWelcome()
self:refreshQuestionList()
self:refreshReward()
self:refreshButton()
end

function UIClientShowQuestionWin:refreshTab()
if self.activeTabList then
if newQuestionModel:isPrize(self.activeTabList[self.tabIndex])then
self.tabIndex=1
self.questionIndex=1
self.questionXuHao=1
self.questionList:jumpToLockY(self.questionIndex)
end
end

self.activeTabList={}
self.activeQuestionList={}
for k,v in pairs(self.tabIdList)do
if not newQuestionModel:isPrize(v.bank_id)then
self.activeTabList[#self.activeTabList+1]=v.bank_id
self.activeQuestionList[#self.activeQuestionList+1]=v
end
end

local allquestionbanks=cfg_questionbankconfig()
self.data={}
for k,v in pairs(self.activeTabList)do
local bank_id=self.activeQuestionList[k].bank_id
local question_id=self.activeQuestionList[k].question_id
self.data[k]=allquestionbanks[bank_id]
self.resultData[k]={}
self.finalResultData[bank_id]={}
end

local questionnirNum=#self.activeTabList
self.tablist:clearItems()
self.tablist:setActive(#self.activeTabList>1)
self.tablist:freshGridsNum(questionnirNum,questionnirNum,1,true)

end

function UIClientShowQuestionWin:refreshWelcome()
local bank_id=self.activeQuestionList[self.tabIndex].bank_id
local cfg=cfgHelper.get1(cfg_clientquestionnaireconfig_get,bank_id)
self.startroot:setActive(self.startList[self.activeTabList[self.tabIndex]])
self.questionList:setActive(not self.startList[self.activeTabList[self.tabIndex]])

local rstr=comHelper.getCheckLayoutStr(self.startdesctemp:getGameObject(),self.startdesctemp:getChildSizeDeltaX(),cfg.questionnaire_welcomestr)
self.startdesc:setText(rstr)

end

function UIClientShowQuestionWin:refreshQuestionList()
self:fillResult()
local pdata=self.data[self.tabIndex]
self.questionList:clearItems()
self.questionList:freshGridsNum(#pdata,1,#pdata,not self.pzero)
self.pzero=true
self.questionList:jumpToLockY(self.questionIndex)
end

function UIClientShowQuestionWin:refreshReward()
local bank_id=self.activeQuestionList[self.tabIndex].bank_id
local cfg=cfgHelper.get1(cfg_clientquestionnaireconfig_get,bank_id)
local reward=cfg.rewards
self.rewardlist:clearItems()
self.rewardlist:freshGridsNum(#reward,1,#reward,true)
local propArray={}
for k,v in pairs(reward)do
local conf={itemid=v[1],itemcount=v[2]>1 and v[2]or'',showCountBG=v[2]>1,showname=false}
table.insert(propArray,itemsComponentHelper.getCommonFillDataSmall(conf))
end
self.rewardlist:initPropData(propArray)
end

function UIClientShowQuestionWin:refreshButton()
local bank_id=self.activeQuestionList[self.tabIndex].bank_id
local cfg=cfgHelper.get1(cfg_clientquestionnaireconfig_get,bank_id)
self.questionNumTip:setActive(not cfg.isbranchbank)
self.startBtn:setActive(self.startList[self.activeTabList[self.tabIndex]])

if self.startList[self.activeTabList[self.tabIndex]]then
self.nextQuestionBtn:setActive(false)
self.submit:setActive(false)
self.questionNumTip:setText("完成问卷即可领取奖励")
else
if cfg.isbranchbank then
local qcfg=self.data[self.tabIndex][self.questionIndex]
self.nextQuestionBtn:setActive(qcfg.branch~=nil)
self.submit:setActive(qcfg.branch==nil)
else
local totalQuestionNum=#self.data[self.tabIndex]
self.nextQuestionBtn:setActive(self.questionIndex~=totalQuestionNum)
self.submit:setActive(self.questionIndex==totalQuestionNum)
self.questionNumTip:setText(FMT.fmt("完成（{0}/{1}）题可领取奖励",self.questionIndex,totalQuestionNum))
end
end

end

function UIClientShowQuestionWin:dealAnswer(noShowInfo)
local temp={}



local result=self.resultData[self.tabIndex][self.questionIndex]
local questionCfg=self.data[self.tabIndex][self.questionIndex]
local question_type=questionCfg.question_type
local errorStr=""

temp.number=questionCfg.idx
temp.topic=questionCfg.question_desc
temp.type=question_type
temp.option={}
temp.optionContent={}
temp.fillContent=""
temp.fillContents={}

if question_type==1 then
if result.selectOptionNum==1 then
local key
for k,v in pairs(result.lookup)do
if v then
key=k
break
end
end
temp.selectIndex=key
local inputCompent=result.inputList[key]
if inputCompent then
temp.fillContent_len=0
local fill_content=inputCompent:GetChildInputFieldValue(optionCompIndex.input)
if string.len(fill_content or"")>0 then
temp.fillContents[key]=fill_content
temp.fillContent_len=temp.fillContent_len+1
else
if questionCfg.noinputcontent then
errorStr="祖师有选项尚未注明"
end
end
end
else
errorStr="祖师尚未选择"
end
end

if question_type==2 then
local isLimit=questionCfg.limitSelectOptionNum~=nil
local dealInputFunc=function()
temp.fillContent_len=0
temp.fillContents={}
for k,optionComp in pairs(result.inputList)do
local fill_content=optionComp:GetChildInputFieldValue(optionCompIndex.input)
if string.len(fill_content or"")>0 then
temp.fillContents[k]=fill_content
result.fillContents[k]=fill_content
temp.fillContent_len=temp.fillContent_len+1
else
if questionCfg.noinputcontent then
errorStr="祖师有选项尚未注明"
break
end
end
end
end
if isLimit then
local type=questionCfg.limitSelectOptionNum[1]
local num=questionCfg.limitSelectOptionNum[2]
local num2=questionCfg.limitSelectOptionNum[3]
if type==1 then
if result.selectOptionNum>=num then
dealInputFunc()
else
errorStr=FMT.fmt("请祖师最少选择{0}项",num)
end
elseif type==2 then
if result.selectOptionNum==num then
dealInputFunc()
else
errorStr=FMT.fmt("请祖师选择{0}项",num)
end
elseif type==3 then
if result.selectOptionNum<=num and result.selectOptionNum>=2 then
dealInputFunc()
else
errorStr=FMT.fmt("请祖师最多选择{0}项",num)
end
elseif type==4 then
if result.selectOptionNum>=num and result.selectOptionNum<=num2 then
dealInputFunc()
elseif result.selectOptionNum<num then
errorStr=FMT.fmt("请祖师最少选择{0}项",num)
elseif result.selectOptionNum>num2 then
errorStr=FMT.fmt("请祖师最多选择{0}项",num2)
end
end

else
if result.selectOptionNum>=2 then
dealInputFunc()
else
errorStr="请祖师至少选择两项"
end
end
end

if question_type==3 then
local questionWidget=self.questionList:getGridObjectByindex(self.questionIndex-1)
local fill_content=questionWidget:GetChildInputFieldValue(1)
if string.len(fill_content or"")>0 then
temp.fillContent=fill_content
result.fillContent=fill_content

else
if questionCfg.noinputcontent then
errorStr="祖师尚未填写内容"
end
end
end

if string.len(errorStr)>0 and not noShowInfo then
UIManager.info(errorStr)
return
end




temp.lookup=result.lookup
temp.inputList={}
temp.selectOptionNum=result.selectOptionNum


for k,v in pairs(temp.lookup)do
if v then
temp.option[#temp.option+1]=k
temp.optionContent[k]=FMT.fmt("{0}.{1}",transformOptionIndex[k],questionCfg.question_options[k][1])
end
end

if temp.fillContent_len and temp.fillContent_len>0 then
for k,v in pairs(temp.fillContents)do
if temp.lookup[k]then
temp.optionContent[k]=FMT.fmt("{0}.{1}::{2}",transformOptionIndex[k],questionCfg.question_options[k][1],v)
end
end
end

self.finalResultData[self.activeTabList[self.tabIndex]][self.questionIndex]=temp
return true
end







function UIClientShowQuestionWin:jumpQuestion()
local bank_id=self.activeQuestionList[self.tabIndex].bank_id
local cfg=cfgHelper.get1(cfg_clientquestionnaireconfig_get,bank_id)
if cfg.isbranchbank then
local qcfg=self.data[self.tabIndex][self.questionIndex]
local condition=qcfg.branch and qcfg.branch
local result_ok=qcfg.branch and qcfg.branch[3]
local result_no=qcfg.branch and qcfg.branch[4]
local resultData=self.resultData[self.tabIndex][self.questionIndex]
if next(condition or{})then
local type=condition[1]
if type==1 then
self.questionIndex=condition[2]
elseif type==2 then
local slist=condition[2]
local result=true
for k,v in pairs(slist)do
if not resultData.lookup[v]then
result=false
break
end
end
if result and#slist==resultData.selectOptionNum then
self.questionIndex=result_ok
else
self.questionIndex=result_no
end
elseif type==3 then
local slist=condition[2]
local result=true
for k,v in pairs(slist)do
if not resultData.lookup[v]then
result=false
break
end
end
if result then
self.questionIndex=result_ok
else
self.questionIndex=result_no
end
elseif type==4 then
local slist=condition[2]
local result=true
for k,v in pairs(slist)do
if resultData.lookup[v]then
result=false
break
end
end
if result then
self.questionIndex=result_ok
else
self.questionIndex=result_no
end
elseif type==5 then
local clist=condition[2]
local dlist=condition[3]
self.questionIndex=condition[4]

local list={}
for index,_ in pairs(resultData.lookup)do
table.insert(list,index)
end

table.sort(list,function(a,b)
return a<b
end)

for k,cl in pairs(clist)do
if table.contrastTable(cl,list)then
self.questionIndex=dlist[k]
break
end
end
end
end
else
self.questionIndex=self.questionIndex+1
end
self.questionXuHao=self.questionXuHao+1
self.questionList:jumpToLockY(self.questionIndex)

local questionitem=self.questionList:getGridObjectByindex(self.questionIndex-1)
questionitem:SetChildText(questionCompIndex.xxuhao,FMT.fmt('{0}.',self.questionXuHao))
questionitem:SetChildText(questionCompIndex.txuhao,FMT.fmt('{0}.',self.questionXuHao))
end


