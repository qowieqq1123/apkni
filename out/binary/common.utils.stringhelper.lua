





local string_gsub=string.gsub

function string.endsWith(str,suffix)
local len=#suffix
return#str>=len and string.sub(str,-len)==suffix
end


function string.split(str,split_char)
local sub_str_tab={}
while(true)do
local pos=string.find(str,split_char)
if(not pos)then
sub_str_tab[#sub_str_tab+1]=str
break
end
local sub_str=string.sub(str,1,pos-1)
sub_str_tab[#sub_str_tab+1]=sub_str
str=string.sub(str,pos+1,#str)
end
return sub_str_tab
end

function string.splitEx(str,split_string)
local sub_str_tab={}
local pattern=FMT.fmt('(.-){0}',split_string)
local pos=1
for part in string.gmatch(str,pattern)do
table.insert(sub_str_tab,part)
pos=pos+#part+string.len(split_string)
end
table.insert(sub_str_tab,string.sub(str,pos))
return sub_str_tab
end




function string.lenEx(str)
local lenInByte=#str;
local len=0;
local i=1;
while(i<=lenInByte)do
local curByte=string.byte(str,i);
local byteCount=1;
if curByte>0 and curByte<=127 then
byteCount=1;
elseif curByte<=223 then
byteCount=2;
elseif curByte<=239 then
byteCount=3;
elseif curByte<=247 then
byteCount=4;
elseif curByte<=251 then
byteCount=5;
elseif curByte<=253 then
byteCount=6;
end
i=i+byteCount;
len=len+1;
end
return len
end



function string.customStrLen(str)
local lenInByte=#str;
local len=0;
local allStrCount=0
local invalidCharacter=false
local i=1;
while(i<=lenInByte)do
local curByte=string.byte(str,i);
local byteCount=1;
local StrCount=1;
if curByte>0 and curByte<=127 then
byteCount=1;
StrCount=1;
elseif curByte<=223 then
byteCount=2;
StrCount=1.6;
elseif curByte<=239 then
byteCount=3;
StrCount=1.6;
elseif curByte<=247 then
byteCount=4;
StrCount=1.6;
invalidCharacter=true;
return allStrCount,len,invalidCharacter;
elseif curByte<=251 then
byteCount=5;
StrCount=1.6;
invalidCharacter=true;
return allStrCount,len,invalidCharacter;
elseif curByte<=253 then
byteCount=6;
StrCount=1.6;
invalidCharacter=true;
return allStrCount,len,invalidCharacter;
end
i=i+byteCount;
len=len+1;
allStrCount=allStrCount+StrCount
end
return allStrCount,len,invalidCharacter;
end




function string.lenwtf(str)
local _,count=string.gsub(str,'[^\128-\193]',"")
return count
end


function string.toTable(str)
local temp={}
for uchar in string.gmatch(str,"[%z\1-\127\194-\244][\128-\191]*")do
temp[#temp+1]=uchar
end
return temp
end


function string.addSpace(str,flag)
str=str or''
if flag then
return FMT.fmt("\194\160{0}\194\160",str)
else
return FMT.fmt("{0}\194\160]",str)
end
end


function string.replaceSpace(str)

if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
if str==nil then return end
return string.gsub(str,"%s","\194\160")
else
return str
end
end


function string.replace(str,astr,bstr)
if str==nil or str==''then return''end
if astr==nil or astr==''then return str end
local t=string.toTable(str)
local blen=string.lenwtf(astr)
local startIdx,endIdx=string.find(str,astr,1,true)
if startIdx then
local tt=string.sub(str,1,startIdx-1)
local len=string.lenwtf(tt)
for j=blen+len,len+1,-1 do
table.remove(t,j)
end
table.insert(t,len+1,bstr)
end

return table.concat(t,'')
end


function string.findStr(str,astr)
if str==nil or str==''or astr==''then return false end
local startIdx,endIdx=string.find(str,astr,1,true)
if startIdx then
return true
end
return false
end


function string.findStrTable(str,strTable)
for _,v in ipairs(strTable)do
if string.findStr(str,v)then return true end
end
return false
end


function string.encodeURI(s)
s=string.gsub(s,"([^%w%.%-:/%?=_ &;])",function(c)return string.format("%%%02X",string.byte(c))end)
return string.gsub(s," ","+")
end


function string.encodeURI_R(s)
s=string.gsub(s,"([^%w%.%- ])",function(c)return string.format("%%%02X",string.byte(c))end)
return string.gsub(s," ","+")
end


function string.decodeURI_R(s)
s=string.gsub(s,'%%(%x%x)',function(h)return string.char(tonumber(h,16))end)
return s
end


function string.unicodeURL(jsonTable,skipFrist)
local st={}
local i=1
for k,v in pairs(jsonTable)do
if not skipFrist or skipFrist and i~=1 then
st[#st+1]='&'
end
st[#st+1]=tostring(k)
st[#st+1]='='
st[#st+1]=tostring(v)
i=i+1
end
local str=table.concat(st,"")
return str
end


function string.qqDecodeURI(s)
s=string.gsub(s,'%%(%x%x)',function(h)return string.char(tonumber(h,16))end)
return s
end

function string.qqEncodeURI(s)
s=string.gsub(s,"([^%w%.%- ])",function(c)return string.format("%%%02X",string.byte(c))end)
return string.gsub(s," ","+")
end


function string.insertBreakLine(str,checkNum)
local temp=string.toTable(str)
if checkNum then
local isNumber=false
local t={}
local t1={}
for i,v in ipairs(temp)do
if tonumber(v)~=nil then
isNumber=true
t1[#t1+1]=v
else
if isNumber then
t[#t+1]=table.concat(t1,'')
isNumber=false
end
t[#t+1]=v
end
end

if isNumber then
t[#t+1]=table.concat(t1,'')
end
return table.concat(t,'\n')
end
return table.concat(temp,'\n')
end







function string.interceptStr(str,startIndex,endIndex)
local lenInByte=#str;
local len=0;
local i=1;
local tostr=''
while(i<=lenInByte)do
local curByte=string.byte(str,i);
local byteCount=1;
if curByte>0 and curByte<=127 then
byteCount=1;
elseif curByte<=223 then
byteCount=2;
elseif curByte<=239 then
byteCount=3
elseif curByte<=247 then
byteCount=4;
elseif curByte<=251 then
byteCount=5;
elseif curByte<=253 then
byteCount=6;
end
i=i+byteCount;
len=len+1;
if len>=startIndex and len<=endIndex then
tostr=tostr..string.char(curByte)
end
if len>endIndex then
break
end
end
return tostr;
end

function string.removeDaKuoHao(str)
local result=string.gsub(str,"{(.-)}",'%1')
if result~=str then
return string.removeDaKuoHao(result)
end
return result
end

function string.startWidth(str,prefix)
if str==nil then return false end
return string.sub(str,1,string.len(prefix))==prefix
end

function string.addCharBetweenChars(s,char,limit)
if s==nil or char==nil then return s end
local len=utf8.len(s)
if len<=1 then return s end
if limit and len>limit then
return s
end
local t={}
for i in utf8.byte_indices(s)do
local nexti=utf8.next(s,i)or#s+1
table.insert(t,s:sub(i,nexti-1))
end
return table.concat(t,char)
end


local htmlTagPattens={"<color=.->(.-)</color>","<size=.->(.-)</size>"}
function string.removeHtmlSpecialTag(str,p,ol)
local ret=string_gsub(str,p,"%1")
ol=ol+1
if ret==str or ol>10 then
return ret
else
return string.removeHtmlSpecialTag(ret,p,ol)
end
end


function string.removeHtmlTag(str)
local ret=str
for _,p in ipairs(htmlTagPattens)do
ret=string.removeHtmlSpecialTag(ret,p,0)
end
return ret
end








function string.delTagsWithoutSpecialPattern(str,tags,specialPattern)
local pool={}
local index=0
local ret=string_gsub(str,specialPattern,function(m)
local key=FMT.fmt("_x_u_z_{0}",index)
index=index+1
pool[key]=m
return key
end)

ret=string_gsub(ret,tags,"")
for key,subStr in pairs(pool)do
ret=string_gsub(ret,key,subStr)
end

return ret
end


function helper.string_is_Invalid(s)
local k=1
while true do
if k>#s then
break
end
local Invalid=false
local c=string.byte(s,k)
local _Chinese=helper.is_Chinese_ex(s,c,k)
if _Chinese then
k=k+3
Invalid=true

else
if helper.string_isAlphaNumeric(c)then

k=k+1
Invalid=true
end
end
if not Invalid then

return false
end
end
return true
end

function helper.string_isAlphaNumeric(c)
if c<192 then

if(c>=48 and c<=57)or(c>=65 and c<=90)or(c>=97 and c<=122)then

return true
else

return false
end

end
return false
end


function string.addNewlineAfterSecondWord(str)
local words={}
for word in str:gmatch("%S+")do
table.insert(words,word)
end
local wordCount=#words
if wordCount==4 then
return string.format("%s %s\n%s %s",words[1],words[2],words[3],words[4])
else
return table.concat(words," ")
end
end
