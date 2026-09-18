







function helper.check_spec_chars(s)
local k=1
while true do
if k>#s then
break
end
local c=string.byte(s,k)
if c<192 then

local b=specialfontHelper.check_spec_char_same(string.sub(s,k,k+1),1)
if b then
return true
end
k=k+1
elseif c<224 then

k=k+2
elseif c<240 then

local b=specialfontHelper.check_spec_char_same(string.sub(s,k,k+3),3)
if b then
return true
end
k=k+3
elseif c<248 then

k=k+4
elseif c<252 then

k=k+5
elseif c<254 then

k=k+6
end
end
return false
end


function helper.find_spec_chars(_str)
for k=1,#_str do
local c=string.byte(_str,k)
if not c then
break
end
if(c>=32 and c<=47)or(c>=58 and c<=64)or(c>=91 and c<=96)or(c>=123 and c<=126)then
return true
end
end
return false
end

function helper.find_spec_chars_ex(s)
local k=1
while true do
if k>#s then
break
end
local c=string.byte(s,k)
if c<192 then

if(c>=48 and c<=57)or(c>=65 and c<=90)or(c>=97 and c<=122)then

k=k+1
else

return true
end
elseif c<224 then

k=k+2
return true
elseif c<240 then

local _Chinese=helper.is_Chinese_ex(s,c,k)
local _Japanese=helper.is_Japanese(s,c,k)
k=k+3
if _Chinese==false and _Japanese==false then
return true
end
elseif c<248 then

k=k+4
return true
elseif c<252 then

k=k+5
return true
elseif c<254 then

k=k+6
return true
end
end
return false
end





function helper.is_Chinese(s,c,k)
local _result=false
if c>=228 and c<=233 then
local c1=string.byte(s,k+1)
local c2=string.byte(s,k+2)
if c1 and c2 then
local a1,a2,a3,a4=128,191,128,191
if c==228 then
a1=184
elseif c==233 then
a2,a4=190,c1~=190 and 191 or 165
end
if c1>=a1 and c1<=a2 and c2>=a3 and c2<=a4 then
_result=true
end
end
end
return _result
end

function helper.is_Chinese_ex(s,c,k)
local _result=false
local c1=string.byte(s,k+1)
local c2=string.byte(s,k+2)
if c1 and c2 then
local unic=bit.lshift(bit.band(c,0x1F),12)
unic=bit.bor(unic,bit.lshift(bit.band(c1,0x3F),6))
unic=bit.bor(unic,bit.band(c2,0x3F))

if unic>=0x4E00 and unic<=0x9FA5 then
_result=true
end
end
return _result
end


function helper.is_Japanese(s,c,k)
return helper.is_Hiragana(s,c,k)or helper.is_Katakana(s,c,k)or helper.is_Katakana_ex(s,c,k)
end



function helper.is_Hiragana(s,c,k)
local _result=false
local c1=string.byte(s,k+1)
local c2=string.byte(s,k+2)
if c1 and c2 then
local unic=bit.lshift(bit.band(c,0x1F),12)
unic=bit.bor(unic,bit.lshift(bit.band(c1,0x3F),6))
unic=bit.bor(unic,bit.band(c2,0x3F))

if unic>=0x3040 and unic<=0x309F then
_result=true
end
end
return _result
end



function helper.is_Katakana(s,c,k)
local _result=false
local c1=string.byte(s,k+1)
local c2=string.byte(s,k+2)
if c1 and c2 then
local unic=bit.lshift(bit.band(c,0x1F),12)
unic=bit.bor(unic,bit.lshift(bit.band(c1,0x3F),6))
unic=bit.bor(unic,bit.band(c2,0x3F))

if unic>=0x30A0 and unic<=0x30FF then
_result=true
end
end
return _result
end



function helper.is_Katakana_ex(s,c,k)
local _result=false
local c1=string.byte(s,k+1)
local c2=string.byte(s,k+2)
if c1 and c2 then
local unic=bit.lshift(bit.band(c,0x1F),12)
unic=bit.bor(unic,bit.lshift(bit.band(c1,0x3F),6))
unic=bit.bor(unic,bit.band(c2,0x3F))

if unic>=0x31F0 and unic<=0x31FF then
_result=true
end
end
return _result
end

function helper.get_chars_lenght(s)
local k=1
local num=0
while true do
if k>#s then
break
end
local c=string.byte(s,k)
if c<192 then

k=k+1
num=num+1
elseif c<224 then

k=k+2
num=num+1
elseif c<240 then

k=k+3
num=num+1
elseif c<248 then

k=k+4
num=num+1
elseif c<252 then

k=k+5
num=num+1
elseif c<254 then

k=k+6
num=num+1
end
end
return num
end

function helper.string_is_ChineseS(s)
local k=1
while true do
if k>#s then
break
end
local c=string.byte(s,k)
local _Chinese=helper.is_Chinese_ex(s,c,k)
if not _Chinese then
return false
end
k=k+3
end
return true
end


local wi={7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1}
local vi={'1','0','X','9','8','7','6','5','4','3','2',}
function helper.CheckSum(idCard)
local nums={}
local _idcard=idCard:sub(1,17)
for ch in _idcard:gmatch"."do
table.insert(nums,tonumber(ch))
end
local sum=0
for i,k in ipairs(nums)do
sum=sum+k*wi[i]
end
return vi[sum%11+1]==idCard:sub(18,18)
end
