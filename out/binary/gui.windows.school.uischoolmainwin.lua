







def_class("UISchoolMainWin",UIWindowBase)








function UISchoolMainWin:bindComponents()

self.maskImg=UIButton.get(self,0)
self.upGradeBtn=UIButton.get(self,1)
self.bottom=UIObject.get(self,2)
self.upGrade=UIObject.get(self,3)
self.startClass=UIObject.get(self,4)
self.readyClass=UIObject.get(self,5)
self.selectClass=UIObject.get(self,6)
self.jiangtai=UIObject.get(self,7)
self.speedUpBtn=UIButton.get(self,8)
self.upGradeTimeText=UIText.get(self,9)
self.completeUpBtn=UIButton.get(self,10)
self.timeClock=UIObject.get(self,11)
self.selectClassBtn=UIButton.get(self,12)
self.selectClassModel=UIObject.get(self,13)
self.zhiwuImg2=UIImage.get(self,14)
self.startClassEffect=UIObject.get(self,15)
self.timeText=UIText.get(self,16)
self.actionClassBtn=UIButton.get(self,17)
self.selectClassNameImg=UIImage.get(self,18)
self.changeClassBtn=UIButton.get(self,19)
self.zhiwuImg1=UIImage.get(self,20)
self.tab1ExpText2=UIText.get(self,21)
self.tab1ExpText4=UIText.get(self,22)
self.tab1ExpText1=UIText.get(self,23)
self.tab1ExpText3=UIText.get(self,24)
self.tab1ExpTextTwo4=UIText.get(self,25)
self.tab1ExpTextTwo1=UIText.get(self,26)
self.tab1ExpTextTwo2=UIText.get(self,27)
self.tab1ExpTextTwo3=UIText.get(self,28)
self.tab2ExpText4=UIText.get(self,29)
self.tab2ExpText3=UIText.get(self,30)
self.tab2ExpText2=UIText.get(self,31)
self.tab2ExpText1=UIText.get(self,32)
self.tab2ExpTextTwo4=UIText.get(self,33)
self.tab2ExpTextTwo3=UIText.get(self,34)
self.tab2ExpTextTwo2=UIText.get(self,35)
self.tab2ExpTextTwo1=UIText.get(self,36)
self.tab4ExpText1=UIText.get(self,37)
self.tab4ExpText2=UIText.get(self,38)
self.tab4ExpText3=UIText.get(self,39)
self.tab4ExpText4=UIText.get(self,40)
self.tab4ExpTextTwo1=UIText.get(self,41)
self.tab4ExpTextTwo4=UIText.get(self,42)
self.tab4ExpTextTwo2=UIText.get(self,43)
self.tab4ExpTextTwo3=UIText.get(self,44)
self.tab3ExpTextTwo1=UIText.get(self,45)
self.tab3ExpTextTwo2=UIText.get(self,46)
self.tab3ExpTextTwo3=UIText.get(self,47)
self.tab3ExpTextTwo4=UIText.get(self,48)
self.tab3ExpText4=UIText.get(self,49)
self.tab3ExpText3=UIText.get(self,50)
self.tab3ExpText2=UIText.get(self,51)
self.tab3ExpText1=UIText.get(self,52)
self.tab6ExpTextTwo3=UIText.get(self,53)
self.tab6ExpTextTwo2=UIText.get(self,54)
self.tab6ExpTextTwo1=UIText.get(self,55)
self.tab6ExpTextTwo4=UIText.get(self,56)
self.tab6ExpText2=UIText.get(self,57)
self.tab6ExpText1=UIText.get(self,58)
self.tab6ExpText3=UIText.get(self,59)
self.tab6ExpText4=UIText.get(self,60)
self.tab5ExpTextTwo3=UIText.get(self,61)
self.tab5ExpTextTwo2=UIText.get(self,62)
self.tab5ExpTextTwo1=UIText.get(self,63)
self.tab5ExpTextTwo4=UIText.get(self,64)
self.tab5ExpText2=UIText.get(self,65)
self.tab5ExpText4=UIText.get(self,66)
self.tab5ExpText1=UIText.get(self,67)
self.tab5ExpText3=UIText.get(self,68)
self.txtSpeakTwo6=UIText.get(self,69)
self.speakImgLeaveBgOne6=UIImage.get(self,70)
self.speakImgLeaveBgOne5=UIImage.get(self,71)
self.txtSpeakTwo5=UIText.get(self,72)
self.speakImgLeaveBgOne4=UIImage.get(self,73)
self.txtSpeakTwo4=UIText.get(self,74)
self.txtSpeakTwo3=UIText.get(self,75)
self.speakImgLeaveBgOne3=UIImage.get(self,76)
self.speakImgLeaveBgOne1=UIImage.get(self,77)
self.txtSpeakTwo1=UIText.get(self,78)
self.txtSpeakTwo2=UIText.get(self,79)
self.speakImgLeaveBgOne2=UIImage.get(self,80)
self.speakImgBgOne4=UIImage.get(self,81)
self.txtSpeak4=UIText.get(self,82)
self.txtSpeak6=UIText.get(self,83)
self.speakImgBgOne6=UIImage.get(self,84)
self.speakImgBgOne1=UIImage.get(self,85)
self.txtSpeak1=UIText.get(self,86)
self.txtSpeak2=UIText.get(self,87)
self.speakImgBgOne2=UIImage.get(self,88)
self.speakImgBgOne3=UIImage.get(self,89)
self.txtSpeak3=UIText.get(self,90)
self.speakImgBgOne5=UIImage.get(self,91)
self.txtSpeak5=UIText.get(self,92)
self.tab1ExpImg2=UIImage.get(self,93)
self.tab1ExpImg3=UIImage.get(self,94)
self.tab1ExpImg1=UIImage.get(self,95)
self.tab1ExpImg4=UIImage.get(self,96)
self.red1Flower3=UIObject.get(self,97)
self.red1Flower1=UIObject.get(self,98)
self.red1Flower2=UIObject.get(self,99)
self.tab1ExpImgTwo4=UIImage.get(self,100)
self.tab1ExpImgTwo1=UIImage.get(self,101)
self.tab1ExpImgTwo2=UIImage.get(self,102)
self.tab1ExpImgTwo3=UIImage.get(self,103)
self.classLevel1=UIText.get(self,104)
self.red2Flower1=UIObject.get(self,105)
self.red2Flower2=UIObject.get(self,106)
self.red2Flower3=UIObject.get(self,107)
self.tab2ExpImgTwo4=UIImage.get(self,108)
self.tab2ExpImgTwo1=UIImage.get(self,109)
self.tab2ExpImgTwo2=UIImage.get(self,110)
self.tab2ExpImgTwo3=UIImage.get(self,111)
self.classLevel2=UIText.get(self,112)
self.tab2ExpImg1=UIImage.get(self,113)
self.tab2ExpImg4=UIImage.get(self,114)
self.tab2ExpImg3=UIImage.get(self,115)
self.tab2ExpImg2=UIImage.get(self,116)
self.tab3ExpImg1=UIImage.get(self,117)
self.tab3ExpImg2=UIImage.get(self,118)
self.tab3ExpImg4=UIImage.get(self,119)
self.tab3ExpImg3=UIImage.get(self,120)
self.classLevel3=UIText.get(self,121)
self.red3Flower2=UIObject.get(self,122)
self.red3Flower3=UIObject.get(self,123)
self.red3Flower1=UIObject.get(self,124)
self.tab3ExpImgTwo1=UIImage.get(self,125)
self.tab3ExpImgTwo3=UIImage.get(self,126)
self.tab3ExpImgTwo4=UIImage.get(self,127)
self.tab3ExpImgTwo2=UIImage.get(self,128)
self.tab4ExpImg2=UIImage.get(self,129)
self.tab4ExpImg1=UIImage.get(self,130)
self.tab4ExpImg4=UIImage.get(self,131)
self.tab4ExpImg3=UIImage.get(self,132)
self.red4Flower1=UIObject.get(self,133)
self.red4Flower2=UIObject.get(self,134)
self.red4Flower3=UIObject.get(self,135)
self.tab4ExpImgTwo3=UIImage.get(self,136)
self.tab4ExpImgTwo2=UIImage.get(self,137)
self.tab4ExpImgTwo1=UIImage.get(self,138)
self.tab4ExpImgTwo4=UIImage.get(self,139)
self.classLevel4=UIText.get(self,140)
self.classLevel5=UIText.get(self,141)
self.tab5ExpImg3=UIImage.get(self,142)
self.tab5ExpImg2=UIImage.get(self,143)
self.tab5ExpImg4=UIImage.get(self,144)
self.tab5ExpImg1=UIImage.get(self,145)
self.red5Flower3=UIObject.get(self,146)
self.red5Flower2=UIObject.get(self,147)
self.red5Flower1=UIObject.get(self,148)
self.tab5ExpImgTwo1=UIImage.get(self,149)
self.tab5ExpImgTwo2=UIImage.get(self,150)
self.tab5ExpImgTwo3=UIImage.get(self,151)
self.tab5ExpImgTwo4=UIImage.get(self,152)
self.tab6ExpImgTwo2=UIImage.get(self,153)
self.tab6ExpImgTwo3=UIImage.get(self,154)
self.tab6ExpImgTwo4=UIImage.get(self,155)
self.tab6ExpImgTwo1=UIImage.get(self,156)
self.classLevel6=UIText.get(self,157)
self.tab6ExpImg4=UIImage.get(self,158)
self.tab6ExpImg1=UIImage.get(self,159)
self.tab6ExpImg2=UIImage.get(self,160)
self.tab6ExpImg3=UIImage.get(self,161)
self.red6Flower2=UIObject.get(self,162)
self.red6Flower3=UIObject.get(self,163)
self.red6Flower1=UIObject.get(self,164)
self.speakObjTwo4=UIObject.get(self,165)
self.effectTwo4=UIObject.get(self,166)
self.effectTwo3=UIObject.get(self,167)
self.speakObjTwo3=UIObject.get(self,168)
self.effectTwo5=UIObject.get(self,169)
self.speakObjTwo5=UIObject.get(self,170)
self.speakObjTwo2=UIObject.get(self,171)
self.effectTwo2=UIObject.get(self,172)
self.speakObjTwo6=UIObject.get(self,173)
self.effectTwo6=UIObject.get(self,174)
self.speakObjTwo1=UIObject.get(self,175)
self.effectTwo1=UIObject.get(self,176)
self.effect6=UIObject.get(self,177)
self.speakObj6=UIObject.get(self,178)
self.effect1=UIObject.get(self,179)
self.speakObj1=UIObject.get(self,180)
self.speakObj4=UIObject.get(self,181)
self.effect4=UIObject.get(self,182)
self.effect5=UIObject.get(self,183)
self.speakObj5=UIObject.get(self,184)
self.speakObj2=UIObject.get(self,185)
self.effect2=UIObject.get(self,186)
self.speakObj3=UIObject.get(self,187)
self.effect3=UIObject.get(self,188)
self.tab1ExpObjTwo=UIObject.get(self,189)
self.classLevelImg1=UIObject.get(self,190)
self.juanzhouImg1=UIObject.get(self,191)
self.redFlowerObj1=UIObject.get(self,192)
self.tab1ExpObj=UIObject.get(self,193)
self.qipaoImg1=UIObject.get(self,194)
self.tab2ExpObj=UIObject.get(self,195)
self.qipaoImg2=UIObject.get(self,196)
self.redFlowerObj2=UIObject.get(self,197)
self.tab2ExpObjTwo=UIObject.get(self,198)
self.juanzhouImg2=UIObject.get(self,199)
self.classLevelImg2=UIObject.get(self,200)
self.tab4ExpObjTwo=UIObject.get(self,201)
self.redFlowerObj4=UIObject.get(self,202)
self.tab4ExpObj=UIObject.get(self,203)
self.qipaoImg4=UIObject.get(self,204)
self.classLevelImg4=UIObject.get(self,205)
self.juanzhouImg4=UIObject.get(self,206)
self.tab3ExpObjTwo=UIObject.get(self,207)
self.tab3ExpObj=UIObject.get(self,208)
self.qipaoImg3=UIObject.get(self,209)
self.redFlowerObj3=UIObject.get(self,210)
self.juanzhouImg3=UIObject.get(self,211)
self.classLevelImg3=UIObject.get(self,212)
self.qipaoImg6=UIObject.get(self,213)
self.classLevelImg6=UIObject.get(self,214)
self.juanzhouImg6=UIObject.get(self,215)
self.redFlowerObj6=UIObject.get(self,216)
self.tab6ExpObj=UIObject.get(self,217)
self.tab6ExpObjTwo=UIObject.get(self,218)
self.tab5ExpObjTwo=UIObject.get(self,219)
self.redFlowerObj5=UIObject.get(self,220)
self.juanzhouImg5=UIObject.get(self,221)
self.qipaoImg5=UIObject.get(self,222)
self.tab5ExpObj=UIObject.get(self,223)
self.classLevelImg5=UIObject.get(self,224)
self.leaveDZModel3=UIObject.get(self,225)
self.leaveDZModel4=UIObject.get(self,226)
self.leaveDZModel1=UIObject.get(self,227)
self.leaveDZModel2=UIObject.get(self,228)
self.leaveDZModel5=UIObject.get(self,229)
self.leaveDZModel6=UIObject.get(self,230)
self.huacaoImg=UIImage.get(self,231)
self.dzModel6=UIObject.get(self,232)
self.dzModel5=UIObject.get(self,233)
self.dzModel4=UIObject.get(self,234)
self.dzModel1=UIObject.get(self,235)
self.dzModel2=UIObject.get(self,236)
self.dzModel3=UIObject.get(self,237)
self.alreadyClassNum=UIText.get(self,238)
self.rubbish1=UIObject.get(self,239)
self.rubbish2=UIObject.get(self,240)
self.rubbish3=UIObject.get(self,241)
self.schoolLevel=UIText.get(self,242)
self.table2=UIObject.get(self,243)
self.table1=UIObject.get(self,244)
self.progressImg=UIObject.get(self,245)
self.table3=UIObject.get(self,246)
self.table4=UIObject.get(self,247)
self.table6=UIObject.get(self,248)
self.table5=UIObject.get(self,249)
self.cloud=UIObject.get(self,250)
self.upGradeBtnText=UIText.get(self,251)
self.saobaModel=UIObject.get(self,252)
self.skipPanel=UIObject.get(self,253)
self.skipToggle=UIToggleButton.get(self,254)
self.skipToggleBg=UIObject.get(self,255)
self.classCostPanel=UIObject.get(self,256)
self.costValue=UIText.get(self,257)
self.costIcon=UIImage.get(self,258)

self.maskImg:setButtonClick(function()self:onMaskImg()end)

self.upGradeBtn:setButtonClick(function()self:onUpGradeBtn()end)

self.speedUpBtn:setButtonClick(function()self:onSpeedUpBtn()end)

self.completeUpBtn:setButtonClick(function()self:onCompleteUpBtn()end)

self.selectClassBtn:setButtonClick(function()self:onSelectClassBtn()end)

self.actionClassBtn:setButtonClick(function()self:onActionClassBtn()end)

self.changeClassBtn:setButtonClick(function()self:onChangeClassBtn()end)



end


function UISchoolMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.maskImg);self.maskImg=nil;
_UIObject_release(self.upGradeBtn);self.upGradeBtn=nil;
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.upGrade);self.upGrade=nil;
_UIObject_release(self.startClass);self.startClass=nil;
_UIObject_release(self.readyClass);self.readyClass=nil;
_UIObject_release(self.selectClass);self.selectClass=nil;
_UIObject_release(self.jiangtai);self.jiangtai=nil;
_UIObject_release(self.speedUpBtn);self.speedUpBtn=nil;
_UIObject_release(self.upGradeTimeText);self.upGradeTimeText=nil;
_UIObject_release(self.completeUpBtn);self.completeUpBtn=nil;
_UIObject_release(self.timeClock);self.timeClock=nil;
_UIObject_release(self.selectClassBtn);self.selectClassBtn=nil;
_UIObject_release(self.selectClassModel);self.selectClassModel=nil;
_UIObject_release(self.zhiwuImg2);self.zhiwuImg2=nil;
_UIObject_release(self.startClassEffect);self.startClassEffect=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.actionClassBtn);self.actionClassBtn=nil;
_UIObject_release(self.selectClassNameImg);self.selectClassNameImg=nil;
_UIObject_release(self.changeClassBtn);self.changeClassBtn=nil;
_UIObject_release(self.zhiwuImg1);self.zhiwuImg1=nil;
_UIObject_release(self.tab1ExpText2);self.tab1ExpText2=nil;
_UIObject_release(self.tab1ExpText4);self.tab1ExpText4=nil;
_UIObject_release(self.tab1ExpText1);self.tab1ExpText1=nil;
_UIObject_release(self.tab1ExpText3);self.tab1ExpText3=nil;
_UIObject_release(self.tab1ExpTextTwo4);self.tab1ExpTextTwo4=nil;
_UIObject_release(self.tab1ExpTextTwo1);self.tab1ExpTextTwo1=nil;
_UIObject_release(self.tab1ExpTextTwo2);self.tab1ExpTextTwo2=nil;
_UIObject_release(self.tab1ExpTextTwo3);self.tab1ExpTextTwo3=nil;
_UIObject_release(self.tab2ExpText4);self.tab2ExpText4=nil;
_UIObject_release(self.tab2ExpText3);self.tab2ExpText3=nil;
_UIObject_release(self.tab2ExpText2);self.tab2ExpText2=nil;
_UIObject_release(self.tab2ExpText1);self.tab2ExpText1=nil;
_UIObject_release(self.tab2ExpTextTwo4);self.tab2ExpTextTwo4=nil;
_UIObject_release(self.tab2ExpTextTwo3);self.tab2ExpTextTwo3=nil;
_UIObject_release(self.tab2ExpTextTwo2);self.tab2ExpTextTwo2=nil;
_UIObject_release(self.tab2ExpTextTwo1);self.tab2ExpTextTwo1=nil;
_UIObject_release(self.tab4ExpText1);self.tab4ExpText1=nil;
_UIObject_release(self.tab4ExpText2);self.tab4ExpText2=nil;
_UIObject_release(self.tab4ExpText3);self.tab4ExpText3=nil;
_UIObject_release(self.tab4ExpText4);self.tab4ExpText4=nil;
_UIObject_release(self.tab4ExpTextTwo1);self.tab4ExpTextTwo1=nil;
_UIObject_release(self.tab4ExpTextTwo4);self.tab4ExpTextTwo4=nil;
_UIObject_release(self.tab4ExpTextTwo2);self.tab4ExpTextTwo2=nil;
_UIObject_release(self.tab4ExpTextTwo3);self.tab4ExpTextTwo3=nil;
_UIObject_release(self.tab3ExpTextTwo1);self.tab3ExpTextTwo1=nil;
_UIObject_release(self.tab3ExpTextTwo2);self.tab3ExpTextTwo2=nil;
_UIObject_release(self.tab3ExpTextTwo3);self.tab3ExpTextTwo3=nil;
_UIObject_release(self.tab3ExpTextTwo4);self.tab3ExpTextTwo4=nil;
_UIObject_release(self.tab3ExpText4);self.tab3ExpText4=nil;
_UIObject_release(self.tab3ExpText3);self.tab3ExpText3=nil;
_UIObject_release(self.tab3ExpText2);self.tab3ExpText2=nil;
_UIObject_release(self.tab3ExpText1);self.tab3ExpText1=nil;
_UIObject_release(self.tab6ExpTextTwo3);self.tab6ExpTextTwo3=nil;
_UIObject_release(self.tab6ExpTextTwo2);self.tab6ExpTextTwo2=nil;
_UIObject_release(self.tab6ExpTextTwo1);self.tab6ExpTextTwo1=nil;
_UIObject_release(self.tab6ExpTextTwo4);self.tab6ExpTextTwo4=nil;
_UIObject_release(self.tab6ExpText2);self.tab6ExpText2=nil;
_UIObject_release(self.tab6ExpText1);self.tab6ExpText1=nil;
_UIObject_release(self.tab6ExpText3);self.tab6ExpText3=nil;
_UIObject_release(self.tab6ExpText4);self.tab6ExpText4=nil;
_UIObject_release(self.tab5ExpTextTwo3);self.tab5ExpTextTwo3=nil;
_UIObject_release(self.tab5ExpTextTwo2);self.tab5ExpTextTwo2=nil;
_UIObject_release(self.tab5ExpTextTwo1);self.tab5ExpTextTwo1=nil;
_UIObject_release(self.tab5ExpTextTwo4);self.tab5ExpTextTwo4=nil;
_UIObject_release(self.tab5ExpText2);self.tab5ExpText2=nil;
_UIObject_release(self.tab5ExpText4);self.tab5ExpText4=nil;
_UIObject_release(self.tab5ExpText1);self.tab5ExpText1=nil;
_UIObject_release(self.tab5ExpText3);self.tab5ExpText3=nil;
_UIObject_release(self.txtSpeakTwo6);self.txtSpeakTwo6=nil;
_UIObject_release(self.speakImgLeaveBgOne6);self.speakImgLeaveBgOne6=nil;
_UIObject_release(self.speakImgLeaveBgOne5);self.speakImgLeaveBgOne5=nil;
_UIObject_release(self.txtSpeakTwo5);self.txtSpeakTwo5=nil;
_UIObject_release(self.speakImgLeaveBgOne4);self.speakImgLeaveBgOne4=nil;
_UIObject_release(self.txtSpeakTwo4);self.txtSpeakTwo4=nil;
_UIObject_release(self.txtSpeakTwo3);self.txtSpeakTwo3=nil;
_UIObject_release(self.speakImgLeaveBgOne3);self.speakImgLeaveBgOne3=nil;
_UIObject_release(self.speakImgLeaveBgOne1);self.speakImgLeaveBgOne1=nil;
_UIObject_release(self.txtSpeakTwo1);self.txtSpeakTwo1=nil;
_UIObject_release(self.txtSpeakTwo2);self.txtSpeakTwo2=nil;
_UIObject_release(self.speakImgLeaveBgOne2);self.speakImgLeaveBgOne2=nil;
_UIObject_release(self.speakImgBgOne4);self.speakImgBgOne4=nil;
_UIObject_release(self.txtSpeak4);self.txtSpeak4=nil;
_UIObject_release(self.txtSpeak6);self.txtSpeak6=nil;
_UIObject_release(self.speakImgBgOne6);self.speakImgBgOne6=nil;
_UIObject_release(self.speakImgBgOne1);self.speakImgBgOne1=nil;
_UIObject_release(self.txtSpeak1);self.txtSpeak1=nil;
_UIObject_release(self.txtSpeak2);self.txtSpeak2=nil;
_UIObject_release(self.speakImgBgOne2);self.speakImgBgOne2=nil;
_UIObject_release(self.speakImgBgOne3);self.speakImgBgOne3=nil;
_UIObject_release(self.txtSpeak3);self.txtSpeak3=nil;
_UIObject_release(self.speakImgBgOne5);self.speakImgBgOne5=nil;
_UIObject_release(self.txtSpeak5);self.txtSpeak5=nil;
_UIObject_release(self.tab1ExpImg2);self.tab1ExpImg2=nil;
_UIObject_release(self.tab1ExpImg3);self.tab1ExpImg3=nil;
_UIObject_release(self.tab1ExpImg1);self.tab1ExpImg1=nil;
_UIObject_release(self.tab1ExpImg4);self.tab1ExpImg4=nil;
_UIObject_release(self.red1Flower3);self.red1Flower3=nil;
_UIObject_release(self.red1Flower1);self.red1Flower1=nil;
_UIObject_release(self.red1Flower2);self.red1Flower2=nil;
_UIObject_release(self.tab1ExpImgTwo4);self.tab1ExpImgTwo4=nil;
_UIObject_release(self.tab1ExpImgTwo1);self.tab1ExpImgTwo1=nil;
_UIObject_release(self.tab1ExpImgTwo2);self.tab1ExpImgTwo2=nil;
_UIObject_release(self.tab1ExpImgTwo3);self.tab1ExpImgTwo3=nil;
_UIObject_release(self.classLevel1);self.classLevel1=nil;
_UIObject_release(self.red2Flower1);self.red2Flower1=nil;
_UIObject_release(self.red2Flower2);self.red2Flower2=nil;
_UIObject_release(self.red2Flower3);self.red2Flower3=nil;
_UIObject_release(self.tab2ExpImgTwo4);self.tab2ExpImgTwo4=nil;
_UIObject_release(self.tab2ExpImgTwo1);self.tab2ExpImgTwo1=nil;
_UIObject_release(self.tab2ExpImgTwo2);self.tab2ExpImgTwo2=nil;
_UIObject_release(self.tab2ExpImgTwo3);self.tab2ExpImgTwo3=nil;
_UIObject_release(self.classLevel2);self.classLevel2=nil;
_UIObject_release(self.tab2ExpImg1);self.tab2ExpImg1=nil;
_UIObject_release(self.tab2ExpImg4);self.tab2ExpImg4=nil;
_UIObject_release(self.tab2ExpImg3);self.tab2ExpImg3=nil;
_UIObject_release(self.tab2ExpImg2);self.tab2ExpImg2=nil;
_UIObject_release(self.tab3ExpImg1);self.tab3ExpImg1=nil;
_UIObject_release(self.tab3ExpImg2);self.tab3ExpImg2=nil;
_UIObject_release(self.tab3ExpImg4);self.tab3ExpImg4=nil;
_UIObject_release(self.tab3ExpImg3);self.tab3ExpImg3=nil;
_UIObject_release(self.classLevel3);self.classLevel3=nil;
_UIObject_release(self.red3Flower2);self.red3Flower2=nil;
_UIObject_release(self.red3Flower3);self.red3Flower3=nil;
_UIObject_release(self.red3Flower1);self.red3Flower1=nil;
_UIObject_release(self.tab3ExpImgTwo1);self.tab3ExpImgTwo1=nil;
_UIObject_release(self.tab3ExpImgTwo3);self.tab3ExpImgTwo3=nil;
_UIObject_release(self.tab3ExpImgTwo4);self.tab3ExpImgTwo4=nil;
_UIObject_release(self.tab3ExpImgTwo2);self.tab3ExpImgTwo2=nil;
_UIObject_release(self.tab4ExpImg2);self.tab4ExpImg2=nil;
_UIObject_release(self.tab4ExpImg1);self.tab4ExpImg1=nil;
_UIObject_release(self.tab4ExpImg4);self.tab4ExpImg4=nil;
_UIObject_release(self.tab4ExpImg3);self.tab4ExpImg3=nil;
_UIObject_release(self.red4Flower1);self.red4Flower1=nil;
_UIObject_release(self.red4Flower2);self.red4Flower2=nil;
_UIObject_release(self.red4Flower3);self.red4Flower3=nil;
_UIObject_release(self.tab4ExpImgTwo3);self.tab4ExpImgTwo3=nil;
_UIObject_release(self.tab4ExpImgTwo2);self.tab4ExpImgTwo2=nil;
_UIObject_release(self.tab4ExpImgTwo1);self.tab4ExpImgTwo1=nil;
_UIObject_release(self.tab4ExpImgTwo4);self.tab4ExpImgTwo4=nil;
_UIObject_release(self.classLevel4);self.classLevel4=nil;
_UIObject_release(self.classLevel5);self.classLevel5=nil;
_UIObject_release(self.tab5ExpImg3);self.tab5ExpImg3=nil;
_UIObject_release(self.tab5ExpImg2);self.tab5ExpImg2=nil;
_UIObject_release(self.tab5ExpImg4);self.tab5ExpImg4=nil;
_UIObject_release(self.tab5ExpImg1);self.tab5ExpImg1=nil;
_UIObject_release(self.red5Flower3);self.red5Flower3=nil;
_UIObject_release(self.red5Flower2);self.red5Flower2=nil;
_UIObject_release(self.red5Flower1);self.red5Flower1=nil;
_UIObject_release(self.tab5ExpImgTwo1);self.tab5ExpImgTwo1=nil;
_UIObject_release(self.tab5ExpImgTwo2);self.tab5ExpImgTwo2=nil;
_UIObject_release(self.tab5ExpImgTwo3);self.tab5ExpImgTwo3=nil;
_UIObject_release(self.tab5ExpImgTwo4);self.tab5ExpImgTwo4=nil;
_UIObject_release(self.tab6ExpImgTwo2);self.tab6ExpImgTwo2=nil;
_UIObject_release(self.tab6ExpImgTwo3);self.tab6ExpImgTwo3=nil;
_UIObject_release(self.tab6ExpImgTwo4);self.tab6ExpImgTwo4=nil;
_UIObject_release(self.tab6ExpImgTwo1);self.tab6ExpImgTwo1=nil;
_UIObject_release(self.classLevel6);self.classLevel6=nil;
_UIObject_release(self.tab6ExpImg4);self.tab6ExpImg4=nil;
_UIObject_release(self.tab6ExpImg1);self.tab6ExpImg1=nil;
_UIObject_release(self.tab6ExpImg2);self.tab6ExpImg2=nil;
_UIObject_release(self.tab6ExpImg3);self.tab6ExpImg3=nil;
_UIObject_release(self.red6Flower2);self.red6Flower2=nil;
_UIObject_release(self.red6Flower3);self.red6Flower3=nil;
_UIObject_release(self.red6Flower1);self.red6Flower1=nil;
_UIObject_release(self.speakObjTwo4);self.speakObjTwo4=nil;
_UIObject_release(self.effectTwo4);self.effectTwo4=nil;
_UIObject_release(self.effectTwo3);self.effectTwo3=nil;
_UIObject_release(self.speakObjTwo3);self.speakObjTwo3=nil;
_UIObject_release(self.effectTwo5);self.effectTwo5=nil;
_UIObject_release(self.speakObjTwo5);self.speakObjTwo5=nil;
_UIObject_release(self.speakObjTwo2);self.speakObjTwo2=nil;
_UIObject_release(self.effectTwo2);self.effectTwo2=nil;
_UIObject_release(self.speakObjTwo6);self.speakObjTwo6=nil;
_UIObject_release(self.effectTwo6);self.effectTwo6=nil;
_UIObject_release(self.speakObjTwo1);self.speakObjTwo1=nil;
_UIObject_release(self.effectTwo1);self.effectTwo1=nil;
_UIObject_release(self.effect6);self.effect6=nil;
_UIObject_release(self.speakObj6);self.speakObj6=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.speakObj1);self.speakObj1=nil;
_UIObject_release(self.speakObj4);self.speakObj4=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.speakObj5);self.speakObj5=nil;
_UIObject_release(self.speakObj2);self.speakObj2=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.speakObj3);self.speakObj3=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.tab1ExpObjTwo);self.tab1ExpObjTwo=nil;
_UIObject_release(self.classLevelImg1);self.classLevelImg1=nil;
_UIObject_release(self.juanzhouImg1);self.juanzhouImg1=nil;
_UIObject_release(self.redFlowerObj1);self.redFlowerObj1=nil;
_UIObject_release(self.tab1ExpObj);self.tab1ExpObj=nil;
_UIObject_release(self.qipaoImg1);self.qipaoImg1=nil;
_UIObject_release(self.tab2ExpObj);self.tab2ExpObj=nil;
_UIObject_release(self.qipaoImg2);self.qipaoImg2=nil;
_UIObject_release(self.redFlowerObj2);self.redFlowerObj2=nil;
_UIObject_release(self.tab2ExpObjTwo);self.tab2ExpObjTwo=nil;
_UIObject_release(self.juanzhouImg2);self.juanzhouImg2=nil;
_UIObject_release(self.classLevelImg2);self.classLevelImg2=nil;
_UIObject_release(self.tab4ExpObjTwo);self.tab4ExpObjTwo=nil;
_UIObject_release(self.redFlowerObj4);self.redFlowerObj4=nil;
_UIObject_release(self.tab4ExpObj);self.tab4ExpObj=nil;
_UIObject_release(self.qipaoImg4);self.qipaoImg4=nil;
_UIObject_release(self.classLevelImg4);self.classLevelImg4=nil;
_UIObject_release(self.juanzhouImg4);self.juanzhouImg4=nil;
_UIObject_release(self.tab3ExpObjTwo);self.tab3ExpObjTwo=nil;
_UIObject_release(self.tab3ExpObj);self.tab3ExpObj=nil;
_UIObject_release(self.qipaoImg3);self.qipaoImg3=nil;
_UIObject_release(self.redFlowerObj3);self.redFlowerObj3=nil;
_UIObject_release(self.juanzhouImg3);self.juanzhouImg3=nil;
_UIObject_release(self.classLevelImg3);self.classLevelImg3=nil;
_UIObject_release(self.qipaoImg6);self.qipaoImg6=nil;
_UIObject_release(self.classLevelImg6);self.classLevelImg6=nil;
_UIObject_release(self.juanzhouImg6);self.juanzhouImg6=nil;
_UIObject_release(self.redFlowerObj6);self.redFlowerObj6=nil;
_UIObject_release(self.tab6ExpObj);self.tab6ExpObj=nil;
_UIObject_release(self.tab6ExpObjTwo);self.tab6ExpObjTwo=nil;
_UIObject_release(self.tab5ExpObjTwo);self.tab5ExpObjTwo=nil;
_UIObject_release(self.redFlowerObj5);self.redFlowerObj5=nil;
_UIObject_release(self.juanzhouImg5);self.juanzhouImg5=nil;
_UIObject_release(self.qipaoImg5);self.qipaoImg5=nil;
_UIObject_release(self.tab5ExpObj);self.tab5ExpObj=nil;
_UIObject_release(self.classLevelImg5);self.classLevelImg5=nil;
_UIObject_release(self.leaveDZModel3);self.leaveDZModel3=nil;
_UIObject_release(self.leaveDZModel4);self.leaveDZModel4=nil;
_UIObject_release(self.leaveDZModel1);self.leaveDZModel1=nil;
_UIObject_release(self.leaveDZModel2);self.leaveDZModel2=nil;
_UIObject_release(self.leaveDZModel5);self.leaveDZModel5=nil;
_UIObject_release(self.leaveDZModel6);self.leaveDZModel6=nil;
_UIObject_release(self.huacaoImg);self.huacaoImg=nil;
_UIObject_release(self.dzModel6);self.dzModel6=nil;
_UIObject_release(self.dzModel5);self.dzModel5=nil;
_UIObject_release(self.dzModel4);self.dzModel4=nil;
_UIObject_release(self.dzModel1);self.dzModel1=nil;
_UIObject_release(self.dzModel2);self.dzModel2=nil;
_UIObject_release(self.dzModel3);self.dzModel3=nil;
_UIObject_release(self.alreadyClassNum);self.alreadyClassNum=nil;
_UIObject_release(self.rubbish1);self.rubbish1=nil;
_UIObject_release(self.rubbish2);self.rubbish2=nil;
_UIObject_release(self.rubbish3);self.rubbish3=nil;
_UIObject_release(self.schoolLevel);self.schoolLevel=nil;
_UIObject_release(self.table2);self.table2=nil;
_UIObject_release(self.table1);self.table1=nil;
_UIObject_release(self.progressImg);self.progressImg=nil;
_UIObject_release(self.table3);self.table3=nil;
_UIObject_release(self.table4);self.table4=nil;
_UIObject_release(self.table6);self.table6=nil;
_UIObject_release(self.table5);self.table5=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.upGradeBtnText);self.upGradeBtnText=nil;
_UIObject_release(self.saobaModel);self.saobaModel=nil;
_UIObject_release(self.skipPanel);self.skipPanel=nil;
_UIObject_release(self.skipToggle);self.skipToggle=nil;
_UIObject_release(self.skipToggleBg);self.skipToggleBg=nil;
_UIObject_release(self.classCostPanel);self.classCostPanel=nil;
_UIObject_release(self.costValue);self.costValue=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
end


















local curClassState={
select=1,
ready=2,
start=3,
upGrade=4,
}

local _this=nil
local progressSizeDelta=nil
local studyTime=0




local diziList={}

local _helper=CS.UIHelper
local _DOTween=Lua.DOTweenProxyExtensions
local _Ease=DG.Tweening.Ease

local jobab='ui/windows/disciple/sharedtextures/uidisciplejobicons.ab'

local schoolAB='ui/windows/school/sharedtextures/schoolsprite.ab'
local classNameImg={
[DISCIPLE_PROSKILL_TYPE.ePeiZhi]=1,
[DISCIPLE_PROSKILL_TYPE.eDanDao]=3,
[DISCIPLE_PROSKILL_TYPE.eShangDao]=7,
[DISCIPLE_PROSKILL_TYPE.eFuLu]=5,
[DISCIPLE_PROSKILL_TYPE.eLianQi]=4,
[DISCIPLE_PROSKILL_TYPE.eZhenFa]=6,
[DISCIPLE_PROSKILL_TYPE.eSiYang]=8,
[DISCIPLE_PROSKILL_TYPE.eJuLing]=2,
}


function UISchoolMainWin:onLoaded(...)
self:bindComponents()
self.tableObj={
[1]={table=self.table1,classLevelImg=self.classLevelImg1,classLevel=self.classLevel1,model=self.dzModel1,speakObj=self.speakObj1,speakImgOne=self.speakImgBgOne1,speakTxt=self.txtSpeak1,leavemodel=self.leaveDZModel1,speakObjTwo=self.speakObjTwo1,speakImgLeaveOne=self.speakImgLeaveBgOne1,speakTxtTwo=self.txtSpeakTwo1,expObj=self.tab1ExpObj,expObj2=self.tab1ExpObjTwo,juanzhou=self.juanzhouImg1,qipaoImg=self.qipaoImg1,flowerObj=self.redFlowerObj1,effect=self.effect1,effect2=self.effectTwo1,},
[2]={table=self.table2,classLevelImg=self.classLevelImg2,classLevel=self.classLevel2,model=self.dzModel2,speakObj=self.speakObj2,speakImgOne=self.speakImgBgOne2,speakTxt=self.txtSpeak2,leavemodel=self.leaveDZModel2,speakObjTwo=self.speakObjTwo2,speakImgLeaveOne=self.speakImgLeaveBgOne2,speakTxtTwo=self.txtSpeakTwo2,expObj=self.tab2ExpObj,expObj2=self.tab2ExpObjTwo,juanzhou=self.juanzhouImg2,qipaoImg=self.qipaoImg2,flowerObj=self.redFlowerObj2,effect=self.effect2,effect2=self.effectTwo2,},
[3]={table=self.table3,classLevelImg=self.classLevelImg3,classLevel=self.classLevel3,model=self.dzModel3,speakObj=self.speakObj3,speakImgOne=self.speakImgBgOne3,speakTxt=self.txtSpeak3,leavemodel=self.leaveDZModel3,speakObjTwo=self.speakObjTwo3,speakImgLeaveOne=self.speakImgLeaveBgOne3,speakTxtTwo=self.txtSpeakTwo3,expObj=self.tab3ExpObj,expObj2=self.tab3ExpObjTwo,juanzhou=self.juanzhouImg3,qipaoImg=self.qipaoImg3,flowerObj=self.redFlowerObj3,effect=self.effect3,effect2=self.effectTwo3,},
[4]={table=self.table4,classLevelImg=self.classLevelImg4,classLevel=self.classLevel4,model=self.dzModel4,speakObj=self.speakObj4,speakImgOne=self.speakImgBgOne4,speakTxt=self.txtSpeak4,leavemodel=self.leaveDZModel4,speakObjTwo=self.speakObjTwo4,speakImgLeaveOne=self.speakImgLeaveBgOne4,speakTxtTwo=self.txtSpeakTwo4,expObj=self.tab4ExpObj,expObj2=self.tab4ExpObjTwo,juanzhou=self.juanzhouImg4,qipaoImg=self.qipaoImg4,flowerObj=self.redFlowerObj4,effect=self.effect4,effect2=self.effectTwo4,},
[5]={table=self.table5,classLevelImg=self.classLevelImg5,classLevel=self.classLevel5,model=self.dzModel5,speakObj=self.speakObj5,speakImgOne=self.speakImgBgOne5,speakTxt=self.txtSpeak5,leavemodel=self.leaveDZModel5,speakObjTwo=self.speakObjTwo5,speakImgLeaveOne=self.speakImgLeaveBgOne5,speakTxtTwo=self.txtSpeakTwo5,expObj=self.tab5ExpObj,expObj2=self.tab5ExpObjTwo,juanzhou=self.juanzhouImg5,qipaoImg=self.qipaoImg5,flowerObj=self.redFlowerObj5,effect=self.effect5,effect2=self.effectTwo5,},
[6]={table=self.table6,classLevelImg=self.classLevelImg6,classLevel=self.classLevel6,model=self.dzModel6,speakObj=self.speakObj6,speakImgOne=self.speakImgBgOne6,speakTxt=self.txtSpeak6,leavemodel=self.leaveDZModel6,speakObjTwo=self.speakObjTwo6,speakImgLeaveOne=self.speakImgLeaveBgOne6,speakTxtTwo=self.txtSpeakTwo6,expObj=self.tab6ExpObj,expObj2=self.tab6ExpObjTwo,juanzhou=self.juanzhouImg6,qipaoImg=self.qipaoImg6,flowerObj=self.redFlowerObj6,effect=self.effect6,effect2=self.effectTwo6,},
}
self.tableobj2={
[1]={expImg={self.tab1ExpImg1,self.tab1ExpImg2,self.tab1ExpImg3,self.tab1ExpImg4},expText={self.tab1ExpText1,self.tab1ExpText2,self.tab1ExpText3,self.tab1ExpText4},expImg2={self.tab1ExpImgTwo1,self.tab1ExpImgTwo2,self.tab1ExpImgTwo3,self.tab1ExpImgTwo4},expText2={self.tab1ExpTextTwo1,self.tab1ExpTextTwo2,self.tab1ExpTextTwo3,self.tab1ExpTextTwo4},redFlower={self.red1Flower1,self.red1Flower2,self.red1Flower3},},
[2]={expImg={self.tab2ExpImg1,self.tab2ExpImg2,self.tab2ExpImg3,self.tab2ExpImg4},expText={self.tab2ExpText1,self.tab2ExpText2,self.tab2ExpText3,self.tab2ExpText4},expImg2={self.tab2ExpImgTwo1,self.tab2ExpImgTwo2,self.tab2ExpImgTwo3,self.tab2ExpImgTwo4},expText2={self.tab2ExpTextTwo1,self.tab2ExpTextTwo2,self.tab2ExpTextTwo3,self.tab2ExpTextTwo4},redFlower={self.red2Flower1,self.red2Flower2,self.red2Flower3},},
[3]={expImg={self.tab3ExpImg1,self.tab3ExpImg2,self.tab3ExpImg3,self.tab3ExpImg4},expText={self.tab3ExpText1,self.tab3ExpText2,self.tab3ExpText3,self.tab3ExpText4},expImg2={self.tab3ExpImgTwo1,self.tab3ExpImgTwo2,self.tab3ExpImgTwo3,self.tab3ExpImgTwo4},expText2={self.tab3ExpTextTwo1,self.tab3ExpTextTwo2,self.tab3ExpTextTwo3,self.tab3ExpTextTwo4},redFlower={self.red3Flower1,self.red3Flower2,self.red3Flower3},},
[4]={expImg={self.tab4ExpImg1,self.tab4ExpImg2,self.tab4ExpImg3,self.tab4ExpImg4},expText={self.tab4ExpText1,self.tab4ExpText2,self.tab4ExpText3,self.tab4ExpText4},expImg2={self.tab4ExpImgTwo1,self.tab4ExpImgTwo2,self.tab4ExpImgTwo3,self.tab4ExpImgTwo4},expText2={self.tab4ExpTextTwo1,self.tab4ExpTextTwo2,self.tab4ExpTextTwo3,self.tab4ExpTextTwo4},redFlower={self.red4Flower1,self.red4Flower2,self.red4Flower3},},
[5]={expImg={self.tab5ExpImg1,self.tab5ExpImg2,self.tab5ExpImg3,self.tab5ExpImg4},expText={self.tab5ExpText1,self.tab5ExpText2,self.tab5ExpText3,self.tab5ExpText4},expImg2={self.tab5ExpImgTwo1,self.tab5ExpImgTwo2,self.tab5ExpImgTwo3,self.tab5ExpImgTwo4},expText2={self.tab5ExpTextTwo1,self.tab5ExpTextTwo2,self.tab5ExpTextTwo3,self.tab5ExpTextTwo4},redFlower={self.red5Flower1,self.red5Flower2,self.red5Flower3},},
[6]={expImg={self.tab6ExpImg1,self.tab6ExpImg2,self.tab6ExpImg3,self.tab6ExpImg4},expText={self.tab6ExpText1,self.tab6ExpText2,self.tab6ExpText3,self.tab6ExpText4},expImg2={self.tab6ExpImgTwo1,self.tab6ExpImgTwo2,self.tab6ExpImgTwo3,self.tab6ExpImgTwo4},expText2={self.tab6ExpTextTwo1,self.tab6ExpTextTwo2,self.tab6ExpTextTwo3,self.tab6ExpTextTwo4},redFlower={self.red6Flower1,self.red6Flower2,self.red6Flower3},},
}
self.rubbishObj={self.rubbish1,self.rubbish2,self.rubbish3}
self.rubbishList={}
_this=self

studyTime=cfgHelper.get2(cfg_collegebaseconfig_get,1,'time')

self.curClassState=curClassState.select

local progressObj=self.progressImg:getGameObject()
local rect=_helper.GetRectTransform(progressObj)
local sizeDelta=rect.sizeDelta
progressSizeDelta=sizeDelta
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)


local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.cloud:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)


self.skipToggle:setToggleChange(function(...)self:onToggleChanged(...)end)

self.isSkipToggle=UISchoolModel:getIsSkipClassAnim()
end


function UISchoolMainWin:__delete()
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end
self:killExpObjTween()

self:stopClassOverTimer()
self:killAllDoTween()
self:removeAllBT()

self:stopLevelUpTimer()
self:stopShowResultWinTimer()
self:stopStudyTimer()
self:clearSaodiWaitTimer()
self:clearSaobaShowTimer()
self:clearDzShowSaoBaTimer()

_this=nil
diziList={}
progressSizeDelta=nil
self.selectClassId=nil
self.curClassState=nil
self.tableObj=nil
self.tableobj2=nil
self.rubbishObj=nil
self.rubbishList=nil

UISchoolModel:clearSaveDzList()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end




function UISchoolMainWin:onShow(argtable,afterOnloaded)

if argtable then
local guid=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end
self.selectClassModel:setChildUIModelShowTarget(2018,1,nil,eAnimationID.stand)
self:refreshLevelUp()
self:refreshSkipPanel()
end


function UISchoolMainWin:onHide()

end

function UISchoolMainWin:checkStudying()
if self.waitStudying then
UIManager.info('操作太频繁，稍等片刻')
return true
end
return false
end



function UISchoolMainWin:onUpGradeBtn()
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end


function UISchoolMainWin:onSelectClassBtn()
if self:checkStudying()then
return
end
local remain=UISchoolModel:get_study_remainNum()
if remain<=0 then
UIManager.info('今日上课次数已用完')
return
end
self:showSelectClassWin()
end


function UISchoolMainWin:onChangeClassBtn()
if self:checkStudying()then
return
end
self:showSelectClassWin()
end


function UISchoolMainWin:onActionClassBtn()
if self:checkStudying()then
return
end
local remain=UISchoolModel:get_study_remainNum()
if remain>0 then
if self.classCost then

local moneyType=self.classCost[1]
local moneyCount=self.classCost[2]
local enough=moneySystem:useMoney(moneyType,moneyCount,function()return end,WARNING_TYPE.eWarning)
if not enough then
return
end
end

self:killAllDoTween()
self:stopClassOverTimer()
self:clearAllSaoDiTimerAndTweener()

self:clearAllRubblish(0.1)

self:removeSaoBaModel(nil,0.1)
local sendList={}
for i,guid in ipairs(diziList)do
if guid~=0 then
local netData=UIDiscipleModel:getDiscipleData(guid)
local skillData=UIDiscipleModel:getDiscipleJobDataEx(netData,self.selectClassId)
UISchoolModel:setOldDiZiProSkillData(guid,{skillData.level,skillData.exp})
sendList[#sendList+1]=guid
end
end
if#sendList<=0 then
UIManager.info('请选择上课的弟子')
return
end
self.waitStudying=true
UISchoolController:req_start_study(self.selectClassId,#sendList,sendList)
else
UIManager.info('今日上课次数已用完')
end
end


function UISchoolMainWin:onSpeedUpBtn()
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end


function UISchoolMainWin:onCompleteUpBtn()
self.sfId=zongmenModel:getMountainId()
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
end


function UISchoolMainWin:OnEvent(index)
if self.curClassState==curClassState.upGrade then
UIManager.info('升级中，稍安勿躁')
return
end
UISchoolModel:saveLastSelectDzList(diziList)
UIManager:showWindow('UISchoolDiscipleSelectWin',{curClass=self.selectClassId,tableCount=self.tableCount,tableIdx=index,diziList=diziList})
end

function UISchoolMainWin:onMaskImg()
if self.resultTimer then
UIManager.info('正在上课中，稍等片刻')
return
else
self.maskImg:setActive(false)
end
end



function UISchoolMainWin:actionClassPlay()
self.waitStudying=false
self.winlua:SetChildShowEffect(self.startClassEffect:getID(),10003,true)
self.curClassState=curClassState.start
self:refreshBottomPanel()
self:refreshTableInfo()
local func=function()
UIManager:showWindow('UISchoolResultWin',{self.selectClassId})
UISchoolController:req_data()
self.maskImg:setActive(false)
self.curClassState=curClassState.select
self:refreshBottomPanel()
self:refreshTableThingsAfterClass1()
self:stopShowResultWinTimer()
self:stopShowStateEffect()
self:stopAllStartClassSpeak()
self:killExpObjTween()
end
if self.isSkipToggle then

return func()
end

self.resultTimer=self:setTimer(studyTime,1,func)
self.maskImg:setActive(true)
self:refreshStudyTimeText()

for i,guid in ipairs(diziList)do
if guid~=0 then
local model=self.tableObj[i].model
self:initModel(model,i)
local bt=model.bt
if bt then
local uistate=bt:getSharedVar('UIstateId')
local classState=bt:getSharedVar('classState')
if uistate==1 and classState==1 then
bt:setSharedVar('UIstateId',4)
bt:broke()
bt:reset()
bt:tick(0.5)
elseif uistate==2 and classState==1 then
bt:setSharedVar('classing',2)
else
bt:setSharedVar('UIstateId',2)
bt:setSharedVar('classing',2)
bt:broke()
bt:reset()
bt:tick(0.5)
end
end
end
end
end

function UISchoolMainWin:refreshBottomPanel()
self.selectClass:setActive(self.curClassState==curClassState.select)
self.readyClass:setActive(self.curClassState==curClassState.ready)
self.startClass:setActive(self.curClassState==curClassState.start)
self.upGrade:setActive(self.curClassState==curClassState.upGrade)
self.jiangtai:setActive(self.curClassState~=curClassState.upGrade)
if self.curClassState==curClassState.select then
self:refreshRemainClassNum()
end
end

function UISchoolMainWin:refreshRemainClassNum()
local remain=UISchoolModel:get_study_remainNum()
local total=UISchoolModel:get_study_maxNum()
self.alreadyClassNum:setText(FMT.fmt('剩{0}课',remain))
end


function UISchoolMainWin.on_building_event(etype,sfId,bdId,args)
if etype==buildingEvent.levelUpStart then
_this:refreshLevelUp()
elseif etype==buildingEvent.levelUpComplete then
UISchoolController:req_data()
_this.curClassState=curClassState.select
_this:refreshLevelUp()
elseif etype==buildingEvent.speedUpComplete then
_this:refreshLevelUp()
end
end

function UISchoolMainWin:refreshLevelUp()
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.schoolLevel:setText(FMT.fmt('{0}级{1}',self.bdData.level,bdCfg.name))
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id,true)
if cddata and cddata.complete then
self.upGradeBtnText:setText('完成升级')
else
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self.upGradeBtnText:setText(nextLvCfg~=nil and'升级'or'建筑信息')
end

local tableCount=cfgHelper.get2(cfg_collegearchitectureconfig_get,self.bdData.level,'sea')
self.tableCount=tableCount
for i,v in ipairs(self.tableObj)do
v.table:setActive(i<=self.tableCount)
end

local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
if nextLvCfg then
if self.bdData.flag==0 then
self.curClassState=curClassState.select
elseif self.bdData.flag==2 then
self.completeUpBtn:setActive(false)
self.timeClock:setActive(true)
self.upGradeTimeText:setActive(true)
self.speedUpBtn:setActive(true)
local beginTime=self.bdData.begintime-self.bdData.reducetime
if beginTime>0 then
local func=function()
local curTime=timeHelper.getServerShortTime()
local needTime=nextLvCfg.uplevel_times
local dtime=curTime-beginTime
if dtime<needTime then
self.upGradeTimeText:setText(FMT.fmt('{0}',timeHelper.format_time_stamp4(needTime-dtime)))
else
self:stopLevelUpTimer()
self.completeUpBtn:setActive(true)
self.timeClock:setActive(false)
self.upGradeTimeText:setActive(false)
self.speedUpBtn:setActive(false)
end
end
func()
self:stopLevelUpTimer()
self.levelUpTimer=self:setTimer(1,0,func)


for i,v in ipairs(diziList)do
if v~=0 then
local model=self.tableObj[i].model
local bt=model.bt
if bt then
bt:setSharedVar('UIstateId',3)
bt:broke()
bt:reset()
end
end
end

self.curClassState=curClassState.upGrade
diziList={}
self.selectClassId=nil
end
end
end
self:refreshBottomPanel()
self:refreshTableInfo()
end

function UISchoolMainWin:refreshSkipPanel()
local isOpenSkip=UISchoolModel:checkIsCanSkipClassAnim()
self.skipPanel:setActive(isOpenSkip)
if isOpenSkip then
self:freshToggle(self.isSkipToggle)
end
end

function UISchoolMainWin:onToggleChanged(name,isToggle,data)
if self.isSkipToggle==isToggle then return end
self.isSkipToggle=isToggle
UISchoolModel:setIsSkipClassAnim(isToggle)
self:freshToggle(isToggle)
end

function UISchoolMainWin:freshToggle(isToggle)
self.skipToggle:setToggle(isToggle)
self.skipToggleBg:setActive(not isToggle)
end


function UISchoolMainWin:showSelectClassWin()
UIManager:showWindow('UISchoolSelectClassWin')
end


function UISchoolMainWin:setClassId(classid)
self.selectClassId=classid
self:autoSelectDZ()
UISchoolModel:set_class_isNewState()
self:playAnimation(UISchoolModel.curAniState.changeDZ)

self.selectClassNameImg:setSprite(schoolAB,FMT.fmt('title_shujiming_{0}',classNameImg[classid]))
self.huacaoImg:setSprite(schoolAB,FMT.fmt('image_shujichatu_{0}',classNameImg[classid]))
self.zhiwuImg1:setSprite(schoolAB,FMT.fmt('image_kechengzs_{0}',classNameImg[classid]))
self.zhiwuImg2:setSprite(schoolAB,FMT.fmt('image_kechengzs_{0}',classNameImg[classid]))
self.curClassState=curClassState.ready


self:refreshClassCostPanel()

self:refreshBottomPanel()
end

function UISchoolMainWin:refreshClassCostPanel()
local config=cfgHelper.get1(cfg_collegecourseconfig_get,self.selectClassId)
local cost=config.useItem
if cost then
local moneyType=cost[1]
local moneyCount=cost[2]
self.classCost={moneyType,moneyCount}
self.costIcon:setImageIcon(iconHelper.getIconName(moneyType),false)
local costCountStr=FMT.fmt("x{0}",moneyCount)
local enough=moneyModel.checkEnoughMoney(moneyType,moneyCount)
if not enough then
costCountStr=FMT.cfmt(FONT_COLOR.eRedColor,costCountStr)
end
self.costValue:setText(costCountStr)


self.classCostPanel:setActive(true)
else

self.classCost=nil

self.classCostPanel:setActive(false)
end
end

function UISchoolMainWin:onMoneyChanged(moneyType,oldVal,newVal)
if self.classCost and self.curClassState==curClassState.ready then
local costMoneyType=self.classCost[1]
if moneyType==costMoneyType then

self:refreshClassCostPanel()
end
end
end



function UISchoolMainWin:refreshStudyTimeText()
self.timeText:setText(FMT.fmt('{0}秒',studyTime))
local endTime=timeHelper.getServerShortTime()+studyTime
local func=function()
local curTime=timeHelper.getServerShortTime()
local dtTime=endTime-curTime
self.timeText:setText(FMT.fmt('{0}秒',dtTime))
if dtTime<=0 then
self:stopStudyTimer()
return
end
end
self.studyTimer=self:setTimer(1,0,func)
self.progressImg:setChildSizeDelta(10,progressSizeDelta.y)
local rectTrans=self.progressImg:getCommonComponent('RectTransform')
local size=rectTrans.sizeDelta
local tweener=_DOTweenProxy.DOSizeDelta(rectTrans,Vector2(size.x,0),studyTime,false)
tweener:SetEase(_Ease.Linear)
end

function UISchoolMainWin:stopLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end

function UISchoolMainWin:stopShowResultWinTimer()
if self.resultTimer then
self:stopTimerByID(self.resultTimer)
self.resultTimer=nil
end
end

function UISchoolMainWin:stopStudyTimer()
if self.studyTimer then
self:stopTimerByID(self.studyTimer)
self.studyTimer=nil
end
end


function UISchoolMainWin:setSelectDZlist(list)
local newList=UISchoolModel:getDiZiList(list)
diziList=newList
end


function UISchoolMainWin:autoSelectDZ()














































diziList=UISchoolController:autoSelectDZ(diziList,self.selectClassId,self.tableCount)
self:refreshTableInfo()
end


function UISchoolMainWin:refreshTableInfo()

if#diziList==0 then
for i=1,self.tableCount do
local obj=self.tableObj[i]
obj.classLevelImg:setActive(false)
obj.juanzhou:setActive(false)
obj.flowerObj:setActive(false)
obj.qipaoImg:setActive(self.curClassState~=curClassState.upGrade)
end
end

for i,guid in ipairs(diziList)do
local obj=self.tableObj[i]
obj.qipaoImg:setActive(guid==0)
obj.juanzhou:setActive(guid~=0)
obj.flowerObj:setActive(false)
local showClassLevel=guid~=0 and self.selectClassId~=nil
obj.classLevelImg:setActive(showClassLevel)
if showClassLevel then
local data=UIDiscipleModel:getDiscipleData(guid)

local proskilllist=data.proskillList
local classList=proskilllist[self.selectClassId]
obj.classLevel:setText(classList.level)
else
obj.classLevel:setText('')
end
end
end

function UISchoolMainWin:refreshTableThingsAfterClass1()
for i=1,self.tableCount do
local obj=self.tableObj[i]
obj.qipaoImg:setActive(false)
obj.juanzhou:setActive(false)
obj.flowerObj:setActive(false)
obj.classLevelImg:setActive(false)
end
end

function UISchoolMainWin:refreshTableThingsAfterClass2()
for i=1,self.tableCount do
local obj=self.tableObj[i]
obj.qipaoImg:setActive(true)
obj.juanzhou:setActive(false)
obj.flowerObj:setActive(false)
obj.classLevelImg:setActive(false)
end
end


function UISchoolMainWin:refreshRubbishPoint()
local rubbishList=cfgHelper.get2(cfg_collegebaseconfig_get,1,'rubbishdot')
local rublishPointList={}
for i,v in ipairs(rubbishList)do
rublishPointList[#rublishPointList+1]=v
end
self.rubbishList={}
for i=1,3 do
local rand=math.random(1,#rublishPointList)
local rubPoint=rublishPointList[rand]
local posX=rubPoint[1]
local posY=rubPoint[2]
local rubbishObj=self.rubbishObj[i]
rubbishObj.posX=posX
rubbishObj.posY=posY
self.winlua:SetChildActive(rubbishObj:getID(),true)
self.winlua:SetChildLocalPosition(rubbishObj:getID(),Vector3(posX,posY,0))
self:initModel(rubbishObj)
rubbishObj.fadeTween=_DOTween.DOFade(rubbishObj.canvasGroup,1,0.2)
table.remove(rublishPointList,rand)

local rubbishItem={obj=rubbishObj,pos={posX,posY}}
table.insert(self.rubbishList,rubbishItem)
end
end

function UISchoolMainWin:clearAllRubblish(time)
for i,v in ipairs(self.rubbishObj)do
self:clearRubblish(v,time)
end
end


function UISchoolMainWin:clearRubblish(rubObj,time)
local defaultTime=cfgHelper.get2(cfg_collegebaseconfig_get,1,'rubhidetime')
local time=time~=nil and time or defaultTime
self:initModel(rubObj)
if rubObj.fadeTween then
rubObj.fadeTween=_DOTween.DOFade(rubObj.canvasGroup,0,time)
end
end


function UISchoolMainWin:checkPosIsRubbish(pos)
for i,v in ipairs(self.rubbishObj)do
if pos[1]==v.posX and pos[2]==v.posY then
self:clearRubblish(v)
v.posX=-10000
v.posY=-10000
return true
end
end
return false
end



function UISchoolMainWin:initModel(model,index)
model.transform=model:getTransform()
model.canvasGroup=_helper.GetCanvasGroup(model.transform.gameObject)
if index then
local scale=1
if index>=5 then
scale=0.8
elseif index>=3 then
scale=0.9
end
model:setScale(Vector3(scale,scale,scale))
end
end

function UISchoolMainWin:playAnimation(state)
self:killAllDoTween()
self:clearAllSaoDiTimerAndTweener()
if self.dasaoTimer~=nil then
self:stopTimerByID(self.dasaoTimer)
self.dasaoTimer=nil
end
if state==UISchoolModel.curAniState.changeDZ then

self:clearAllRubblish(0.5)

self:removeSaoBaModel(nil,0.5)
self:changeSelectDiZi()
else

self:classOverGoOut()
end
end

function UISchoolMainWin:createDzBT(model,index)
local pathCfg=cfgHelper.get1(cfg_collegepathconfig_get,index)
local initData={
speakHUDID=1,
speakTime=3,
offset={-15,75},
idlePos=pathCfg.targetPos,
enterPos=pathCfg.initpos,
classing=1,
index=index,
saodi=0,
}
local bt=UIRoleStateManager:addUIXueYuanBT('bt_ui_xueyuan',self.winlua,model:getID(),initData)
bt:setSharedVar('UIstateId',2)
model.bt=bt
return bt
end

function UISchoolMainWin:getDzSpeakText(bt,tkey)
local str=''
if self.selectClassId then
local config=cfgHelper.get1(cfg_collegecourseconfig_get,self.selectClassId)
local classState=bt:getSharedVar('classState')
if classState==1 then

local selectTalk=config.selectclasstalk
str=self:randSpeakStr(selectTalk)
elseif classState==2 then

local leaveTalk=config.classovertalk
str=self:randSpeakStr(leaveTalk)
elseif classState==3 then

local classoverTalk=cfgHelper.get2(cfg_collegebaseconfig_get,1,'classovertalk')
str=self:randSpeakStr(classoverTalk)
elseif classState==4 then

local clearrubTalk=cfgHelper.get2(cfg_collegebaseconfig_get,1,'clearrubtalk')
str=self:randSpeakStr(clearrubTalk)
end
else
local freeTalk=cfgHelper.get2(cfg_collegebaseconfig_get,1,'freetalk')
str=self:randSpeakStr(freeTalk)
end
bt:setSharedVar(tkey,str)
end

function UISchoolMainWin:randSpeakStr(talkList)
local rand=math.random(1,#talkList)
return talkList[rand]
end

function UISchoolMainWin:createDzModel(model,guid)
comHelper.setChildHead2(model,guid,1,nil,2,false)
end


function UISchoolMainWin:changeSelectDiZi()
for index,guid in ipairs(diziList)do
local leavemodel=self.tableObj[index].leavemodel
local model=self.tableObj[index].model
local oldBT=model.bt
local uiState
if oldBT then
uiState=oldBT:getSharedVar('UIstateId')
end
local needLeave=UISchoolModel:checkDiZiNeedLeave(index,guid)

if guid~=0 then
local oldReEnter=UISchoolModel:checkOldIndexReEnter(index)
self:initModel(model,index)
if oldBT==nil then
self:createDzModel(model,guid)
local bt=self:createDzBT(model,index)
bt:setSharedVar('classState',1)
elseif oldReEnter or(uiState==0 or uiState==1 or uiState==5)then
self:createDzModel(model,guid)
oldBT:setSharedVar('UIstateId',2)
oldBT:setSharedVar('classing',1)
oldBT:broke()
oldBT:reset()
oldBT:tick(0.5)
oldBT:setSharedVar('classState',1)
end
if needLeave then
self:initModel(leavemodel,index)
self:createDzModel(leavemodel,guid)
local bt=leavemodel.bt
if bt then
bt:setSharedVar('UIstateId',2)
bt:setSharedVar('classing',1)
bt:broke()
bt:reset()
bt:tick(0.5)
else
bt=self:createDzBT(leavemodel,index)
end
bt:setSharedVar('classState',1)
self:switchDzModel(index)
end
end


if needLeave then
oldBT:setSharedVar('classState',1)
oldBT:setSharedVar('UIstateId',3)
oldBT:broke()
oldBT:reset()
oldBT:tick(0.5)
end
end
end

function UISchoolMainWin:switchDzModel(i)
local temp=self.tableObj[i].model
self.tableObj[i].model=self.tableObj[i].leavemodel
self.tableObj[i].leavemodel=temp

local effectTemp=self.tableObj[i].effect
self.tableObj[i].effect=self.tableObj[i].effect2
self.tableObj[i].effect2=effectTemp

local speakObjTemp=self.tableObj[i].speakObj
self.tableObj[i].speakObj=self.tableObj[i].speakObjTwo
self.tableObj[i].speakObjTwo=speakObjTemp

local speakImgTemp=self.tableObj[i].speakImgOne
self.tableObj[i].speakImgOne=self.tableObj[i].speakImgLeaveOne
self.tableObj[i].speakImgLeaveOne=speakImgTemp

local speakTextTemp=self.tableObj[i].speakTxt
self.tableObj[i].speakTxt=self.tableObj[i].speakTxtTwo
self.tableObj[i].speakTxtTwo=speakTextTemp
end




function UISchoolMainWin:classOverGoOut()
local temp={}
for _,guid in ipairs(diziList)do
if guid~=0 then
temp[#temp+1]=guid
end
end
local rand=math.random(1,#temp)
local loopDizi=temp[rand]

local delayDaSao=false
local dsIndex=nil

local waitLeave=0
for i,guid in ipairs(diziList)do
local model=self.tableObj[i].model
local bt=model.bt
if guid~=0 then
bt:broke()
if not mathHelper.compareInt64(guid,loopDizi)then
delayDaSao=true
local zeroPos=self.winlua:GetChildLocalPosition(model:getID())
local setData=
{
zeroPos={0,zeroPos.y},
jumpPos={0,-280},
bottomPos={0,-330},
endPos={450,-330},
}
for k,v in pairs(setData)do
bt:setSharedVar(k,v)
end
bt:setSharedVar('classState',2)
bt:setSharedVar('UIstateId',5)
bt:setSharedVar('waitLeaveTime',waitLeave)
waitLeave=waitLeave+0.4
else
dsIndex=i
end
bt:reset()
else
model:setActive(false)
end
end


local dsFunc=function()
self.dasaoTimer=nil
self:refreshTableThingsAfterClass2()

local model=self.tableObj[dsIndex].model
local bt=model.bt
bt:setSharedVar('classState',3)
bt:setSharedVar('UIstateId',1)
local config=cfgHelper.get1(cfg_collegepathconfig_get,dsIndex)
model.duration=config.duration
local loopList=config.looppath
local randPath=math.random(1,#loopList)
local pathList=loopList[randPath]
self.dsModelScale=model.transform.localScale.x



self:refreshRubbishPoint()


self:dzWaitToNextSaoDi(model)
end
if delayDaSao then
self.dasaoTimer=self:delayDo(waitLeave+3,dsFunc)
else
dsFunc()
end
end
























function UISchoolMainWin:classOverLoopWalk(model,pathList)
local path=self:getPathArray(pathList)
local initFlipX=false
local firstIdx=self.moveStep==nil and 1 or self.moveStep
local first=pathList[firstIdx]
local second=pathList[firstIdx+1]
if second and second[1]-first[1]~=0 then
initFlipX=second[1]-first[1]>0
end
self.winlua:SetChildUIModelShowFlipX(model:getID(),initFlipX or false)

model.moveTween=_DOTween.DoLocalPath(model.transform,path,model.duration)
model.moveTween:SetEase(_Ease.Linear)
if self.moveStep then
model.moveTween:GotoWaypoint(self.moveStep,true)
self.moveStep=nil
end
model:setChildModelAnimationState(eAnimationID.walk)
model.moveTween:OnWaypointChange(function(index)
if index>0 then
local point=pathList[index]
local nextPoint=pathList[index+1]
local dy=0
if nextPoint then
local isFlipX=false
if nextPoint[1]-point[1]~=0 then
isFlipX=nextPoint[1]-point[1]>0
end
self.winlua:SetChildUIModelShowFlipX(model:getID(),isFlipX or false)
dy=nextPoint[2]-point[2]
else
dy=first[2]-point[2]
end
local curScale=model.transform.localScale.x
if dy>0 then
curScale=curScale-0.1
elseif dy<0 then
curScale=curScale+0.1
end

curScale=mathHelper.decimal(curScale,1)
model.scaleTween=_DOTween.DOScale(model.transform,curScale,0.5)

local isClearRub=self:checkPosIsRubbish(point)
local bt=model.bt
if isClearRub then
self.moveStep=index
model:setChildModelAnimationState(eAnimationID.stand)
model.moveTween:Kill(false)
model.moveTween=nil
bt:setSharedVar('saodi',1)
bt:setSharedVar('classState',4)
bt:broke()
bt:reset()
self:stopClassOverTimer()
self.classOverTimer=self:delayDo(2,function(...)
self:classOverLoopWalk(model,pathList)
end)
else
bt:setSharedVar('saodi',0)
bt:setSharedVar('classState',3)
end
bt:tick(0.5)
end
end)
model.moveTween:AddComplete(function(...)
if model.moveTween then
model.moveTween:Kill(false)
model.moveTween=nil
end
self:classOverLoopWalk(model,pathList)
end)
end

function UISchoolMainWin:getPathArray(path)
local list={}
for i=1,#path do
local point=path[i]
table.insert(list,Vector3(point[1],point[2],0))
end
return list
end

function UISchoolMainWin:dzClearClassroom(model)
local targetRub=self:getNearRubbish(model)
if targetRub then

local nowPos=model:getChildAnchoredPosition()
local offset=targetRub.pos[1]>nowPos.x and-95 or 95
local pos=Vector2.New(targetRub.pos[1]+offset,targetRub.pos[2])
local dy=targetRub.pos[2]-nowPos.y
local curScale=self.dsModelScale-dy*0.0015
local speed=50

local duration=Vector2.Distance(pos,nowPos)/speed
local isFlipX=pos.x-nowPos.x>0
model:setChildUIModelShowFlipX(isFlipX or false)
model.isFlipX=isFlipX

local callback=function()

local dzNowPos=model:getChildAnchoredPosition()
local isFlipX=targetRub.pos[1]-dzNowPos.x>0
model:setChildUIModelShowFlipX(isFlipX or false)
model.isFlipX=isFlipX

if model.moveTween then
model.moveTween:Kill(false)
model.moveTween=nil
end
return self:dzSaoDi(model,targetRub)
end
model:setChildModelAnimationState(eAnimationID.walk)

if model.moveTween then
model.moveTween:Kill(false)
model.moveTween=nil
end
model.moveTween=model:setChildDOAnchorPos(pos,duration,callback)


curScale=mathHelper.decimal(curScale,1)
model.scaleTween=_DOTween.DOScale(model.transform,curScale,duration)
else

local waitLeave=0
local bt=model.bt
bt:broke()
local zeroPos=self.winlua:GetChildLocalPosition(model:getID())
local setData=
{
zeroPos={0,zeroPos.y},
jumpPos={0,-280},
bottomPos={0,-330},
endPos={450,-330},
}
for k,v in pairs(setData)do
bt:setSharedVar(k,v)
end
bt:setSharedVar('classState',2)
bt:setSharedVar('UIstateId',5)
bt:setSharedVar('waitLeaveTime',waitLeave)
bt:reset()
bt:tick(0.5)
end
end

function UISchoolMainWin:dzSaoDi(model,targetRub)

model:setChildModelAnimationState(eAnimationID.attack4)
self:clearDzShowSaoBaTimer()
self.dzShowSaoBaTimer=self:delayDo(1,function()
return self:showSaoBa(model,targetRub)
end)
end
function UISchoolMainWin:showSaoBa(model,targetRub)

local pos=model:getChildAnchoredPosition()

local isFlipX=model.isFlipX==nil and true or not model.isFlipX
local offset=90
local posX=isFlipX and pos.x-offset or pos.x+offset
self.saobaModel:setChildAnchoredPos(posX,pos.y)


local saodiTime=cfgHelper.get2(cfg_collegebaseconfig_get,1,'rubhidetime')or 4.7

local saobaModelId=2083
local scale=model.transform.localScale.x/self.dsModelScale
self.saobaModel:setChildCanvasGroupAlpha(1)
self.saobaModel:setChildUIModelShowTarget(saobaModelId,scale,{},eAnimationID.stand,false,false,0.5)
self.saobaModel:setChildUIModelShowFlipX(isFlipX)
self:clearSaobaShowTimer()
self.saobaShowTimer=self:delayDo(saodiTime,function()
return self:removeSaoBaModel(model,0.5)
end)


self:clearRubblish(targetRub.obj,saodiTime)

local bt=model.bt
bt:setSharedVar('saodi',1)
bt:setSharedVar('classState',4)
bt:broke()
bt:reset()
bt:tick(0.5)
end

function UISchoolMainWin:removeSaoBaModel(model,fadeTime)
self:killSaobaRemoveTweener()
local callback=function()

self.saobaModel:setChildUIModelRemoveTarget()
if model then
return self:dzWaitToNextSaoDi(model,2,3)
end
end
if fadeTime and fadeTime>0 then
self.saobaRemoveTweener=self.saobaModel:setChildCanvasGroupDOFade(0,fadeTime,callback)
else
callback()
end
end

function UISchoolMainWin:dzWaitToNextSaoDi(model,minTime,maxTime)


local callback=function()
return self:dzClearClassroom(model)
end

local waitTime=0
if minTime and maxTime and minTime~=maxTime then
waitTime=math.random(minTime,maxTime)
else
waitTime=minTime or maxTime or 0
end

local bt=model.bt
bt:setSharedVar('saodi',0)
bt:setSharedVar('classState',3)
bt:broke()
bt:reset()
bt:tick(0.5)

self:clearSaodiWaitTimer()
if waitTime>0 then
self.saodiWaitTimer=self:delayDo(waitTime,callback)
else
callback()
end
end
function UISchoolMainWin:getNearRubbish(model)
if not self.rubbishList or not next(self.rubbishList)then
return nil
end

local modelPos=model:getChildAnchoredPosition()
local minDistance=nil
local selectIndex=nil
for i,rub in ipairs(self.rubbishList)do
local posX=rub.pos[1]
local dis=math.abs(modelPos.x-posX)
if not minDistance or dis<minDistance then
minDistance=dis
selectIndex=i
end
end

if not selectIndex then
return nil
end

local rub=self.rubbishList[selectIndex]
table.remove(self.rubbishList,selectIndex)
return rub
end

function UISchoolMainWin:stopClassOverTimer()
if self.classOverTimer then
self:stopTimerByID(self.classOverTimer)
self.classOverTimer=nil
end
end


function UISchoolMainWin:killSaobaRemoveTweener()
if self.saobaRemoveTweener then
self.saobaRemoveTweener:Kill(false)
self.saobaRemoveTweener=nil
end
end


function UISchoolMainWin:clearSaodiWaitTimer()
if self.saodiWaitTimer then
self:stopTimerByID(self.saodiWaitTimer)
self.saodiWaitTimer=nil
end
end


function UISchoolMainWin:clearSaobaShowTimer()
if self.saobaShowTimer then
self:stopTimerByID(self.saobaShowTimer)
self.saobaShowTimer=nil
end
end


function UISchoolMainWin:clearDzShowSaoBaTimer()
if self.dzShowSaoBaTimer then
self:stopTimerByID(self.dzShowSaoBaTimer)
self.dzShowSaoBaTimer=nil
end
end

function UISchoolMainWin:clearAllSaoDiTimerAndTweener()
self:killSaobaRemoveTweener()
self:clearSaodiWaitTimer()
self:clearSaobaShowTimer()
self:clearDzShowSaoBaTimer()
end


function UISchoolMainWin:killAllDoTween()
for i,v in ipairs(self.tableObj)do
local model=v.model
if model.moveTween then
model.moveTween:Kill(false)
model.moveTween=nil
end
if model.scaleTween then
model.scaleTween:Kill(false)
model.scaleTween=nil
end
if model.fadeTween then
model.fadeTween:Kill(false)
model.fadeTween=nil
end

local leavemodel=v.leavemodel
if leavemodel.moveTween then
leavemodel.moveTween:Kill(false)
leavemodel.moveTween=nil
end
if leavemodel.scaleTween then
leavemodel.scaleTween:Kill(false)
leavemodel.scaleTween=nil
end
if leavemodel.fadeTween then
leavemodel.fadeTween:Kill(false)
leavemodel.fadeTween=nil
end
end
for i,v in ipairs(self.rubbishObj)do
if v.fadeTween then
v.fadeTween:Kill(false)
end
end

self:killSaobaRemoveTweener()
end

function UISchoolMainWin:removeAllBT()
for i,v in ipairs(self.tableObj)do
local model=v.model
local leavemodel=v.leavemodel
if model.bt then
UIRoleStateManager:removeUIXueYuanBT(model.bt)
model.bt=nil
end
if leavemodel.bt then
UIRoleStateManager:removeUIXueYuanBT(leavemodel.bt)
leavemodel.bt=nil
end
end
end







function UISchoolMainWin:flyExpProSkillIcon(index)
if _this.curClassState~=curClassState.start then
return
end
local expImgNum={4,3,2,2,1}

local resultData=UISchoolModel:get_study_result()or{}
for i,v in ipairs(resultData)do
local guid=v.dzGuild
if diziList[index]==guid then
local exp=tonumber(tostring(v.exp))
local state=v.studyStatus
local expObj=_this.tableObj[index].expObj
expObj:setActive(true)
if state<=3 then
local expObj2=_this.tableObj[index].expObj2
expObj2:setActive(true)
end
_this:flyExpAnimation(index,state,expImgNum[state])


_this:showRedFlower(index,v)

_this:startClassSpeak(index,v)

_this:playStateEffect(index,v)
end
end
end

function UISchoolMainWin:flyExpAnimation(tableIdx,state,imgNum)
for i=1,4 do
local tableExpImg=self.tableobj2[tableIdx]
local imgObj=tableExpImg.expImg[i]
local imgObj2=tableExpImg.expImg2[i]
self:initModel(imgObj)
self:initModel(imgObj2)
imgObj:setActive(i<=imgNum)
self.winlua:SetChildLocalPosition(imgObj:getID(),Vector3(0,0,0))
self.winlua:SetChildCanvasGroupAlpha(imgObj:getID(),0)
if state<=3 then
imgObj2:setActive(i<=imgNum)
self.winlua:SetChildLocalPosition(imgObj2:getID(),Vector3(0,0,0))
self.winlua:SetChildCanvasGroupAlpha(imgObj2:getID(),0)
end
if i<=imgNum then

local proType=self.selectClassId
local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,proType,'icon')
imgObj:setSprite(jobab,FMT.fmt('image_gongzhongtp_{0}',icon))

self:flyExpImgFunc(imgObj,i,imgNum,false,true)
if state<=3 then
imgObj2:setSprite(jobab,FMT.fmt('image_gongzhongtp_{0}',icon))
self:flyExpImgFunc(imgObj2,i,imgNum,true,true)
end
end


local textObj=tableExpImg.expText[i]
local baseExp=cfgHelper.get2(cfg_collegearchitectureconfig_get,self.bdData.level,'exp')
local expNum=baseExp/(studyTime-1)

local percent=cfgHelper.get2(cfg_collegestudystatusconfig_get,state,'addexp')
if state==5 then
expNum=expNum*(100+percent)/100
end
textObj:setText(FMT.fmt('+{0}',math.floor(expNum)))
if state<=3 then
local textObj2=tableExpImg.expText2[i]
local expNum2=(baseExp*percent/100)/(studyTime-1)
textObj2:setText(FMT.fmt('+{0}',math.floor(expNum2)))
end
end
end

function UISchoolMainWin:flyExpImgFunc(obj,index,total,extra,init)
obj.fade=_DOTween.DOFade(obj.canvasGroup,1,0.1)
if init then
init=false
if extra then
obj.fade:SetDelay(2/total*(index-0.5))
else
obj.fade:SetDelay(2/total*(index-1))
end
end
obj.fade:AddComplete(function()
obj.move=_DOTween.DOLocalMove(obj.transform,Vector3(0,84,0),2)
obj.fade=_DOTween.DOFade(obj.canvasGroup,0,2)
obj.move:SetEase(_Ease.Linear)

obj.fade:AddComplete(function()
self.winlua:SetChildLocalPosition(obj:getID(),Vector3(0,0,0))
self:flyExpImgFunc(obj,index,total,extra,init)
end)
end)
end

function UISchoolMainWin:hideExpObj()
for i=1,self.tableCount do
local expObj=self.tableObj[i].expObj
expObj:setActive(false)
local expObj2=self.tableObj[i].expObj2
expObj2:setActive(false)
end
end

function UISchoolMainWin:killExpObjTween()
for i=1,self.tableCount do
local tableExp=self.tableobj2[i]
for i=1,4 do
local imgObj=tableExp.expImg[i]
if imgObj.move then
imgObj.move:Kill(false)
end
if imgObj.fade then
imgObj.fade:Kill(false)
end
local imgObj2=tableExp.expImg2[i]
if imgObj2.move then
imgObj2.move:Kill(false)
end
if imgObj2.fade then
imgObj2.fade:Kill(false)
end
end
end
end


function UISchoolMainWin:showRedFlower(index,data)
local state=data.studyStatus
local redFlowerObjList=_this.tableobj2[index].redFlower
local redFlowerNum={3,2,1}
local showNum=redFlowerNum[state]or 0
local redFlowerEmpty=_this.tableObj[index].flowerObj
redFlowerEmpty:setActive(showNum>0)
for i,v in ipairs(redFlowerObjList)do
v:setActive(i<=showNum)
end
end


function UISchoolMainWin:startClassSpeak(index,data)
local state=data.studyStatus
local speakObj=self.tableObj[index].speakObj
local speakImgOne=self.tableObj[index].speakImgOne
local speakTextOne=self.tableObj[index].speakTxt
local baseCfg=cfgHelper.get1(cfg_collegebaseconfig_get,1)
local skin=1
local talk=''
local left,right=4,6
if state==5 then
skin=2
talk=baseCfg.debuffstalk
elseif state==4 then
skin=1
talk=baseCfg.normaltalk
else
skin=2
local stateTalk=baseCfg.gaintalk
talk=stateTalk[state]
left,right=2,3
end
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(skin)
speakImgOne:setSprite(abName,skinName)

speakObj:setActive(true)
speakObj:setChildCanvasGroupAlpha(0)
self:delayDo(1,function()
speakObj:setChildCanvasGroupAlpha(1)
self:setDzTalkSomething(speakObj,speakTextOne,index,talk,left,right)
end)
end


function UISchoolMainWin:setDzTalkSomething(speakObj,speakText,index,talk,left,right)
if speakObj.tween then
speakObj.tween:Kill(false)
speakObj.tween=nil
end
local time=math.random(left,right)
local rand=math.random(1,#talk)
local str=talk[rand]
speakText:setText(str)
local hideFunc=function()
local showFunc=function()
self:setDzTalkSomething(speakObj,speakText,index,talk,left,right)
end
speakObj.tween=speakObj:setChildCanvasGroupDOFade(1,0,showFunc)
speakObj.tween:SetDelay(2)
end
speakObj.tween=speakObj:setChildCanvasGroupDOFade(0,0,hideFunc)
speakObj.tween:SetDelay(time)
end

function UISchoolMainWin:stopAllStartClassSpeak()
for i,guid in ipairs(diziList)do
if guid~=0 then
local speakObj=self.tableObj[i].speakObj
if speakObj.tween then
speakObj.tween:Kill(false)
speakObj.tween=nil
end
speakObj:setActive(false)
end
end
end


function UISchoolMainWin:playStateEffect(index,data)
local effectIdList={10006,10005,10004}
local effect=self.tableObj[index].effect
local state=data.studyStatus
local effectId=effectIdList[state]
if effectId then
self.winlua:SetChildShowEffect(effect:getID(),effectId,true)
end
end

function UISchoolMainWin:stopShowStateEffect()
for i,v in ipairs(diziList)do
if v~=0 then
local effect=self.tableObj[i].effect
self.winlua:SetChildShowEffect(effect:getID(),0,false)
end
end
end